---
description: >-
  Apply the following guidance to production WEKA Operator deployments to
  maximize reliability, performance, and operational clarity.
---

# WEKA Operator best practices

### Preload images before deployment

Preloading WEKA container images on all target nodes before applying CRs eliminates download delays during cluster formation. Without preloading, nodes that complete their image pull early sit idle while others are still downloading, staggering the start of each deployment step.

Apply a DaemonSet to pull the image on every target node during environment preparation:

<details>

<summary>Example DaemonSet for image preloading</summary>

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: weka-preload
  namespace: default
spec:
  selector:
    matchLabels:
      app: weka-preload
  template:
    metadata:
      labels:
        app: weka-preload
    spec:
      imagePullSecrets:
        - name: quay-io-robot-secret
      nodeSelector:
        weka.io/supports-backends: "true"
      tolerations:
        - key: "key1"
          operator: "Equal"
          value: "value1"
          effect: "NoSchedule"
        - key: "key2"
          operator: "Exists"
          effect: "NoExecute"
      containers:
        - name: weka-preload
          image: quay.io/weka.io/weka-in-container:<WEKA_IMAGE_VERSION_TAG>
          command: ["sleep", "infinity"]
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
```

</details>

Replace `<WEKA_IMAGE_VERSION_TAG>` with the target image version. Remove the DaemonSet after the deployment completes.

**Configure control plane high availability**

Use an odd number of etcd members to maintain quorum and tolerate failures. A cluster of N members tolerates up to (N−1)/2 failures.

For production backend deployments, use five or nine etcd members. Consider distributing control plane components across multiple failure domains or using an external etcd cluster. For more information, see the [Kubernetes HA topology guidance](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/).

### Configure the Kubelet CPU Manager with static policy

Enable the static CPU Manager policy on all worker nodes to give WEKA processes dedicated CPU cores. Without this, the Kubernetes scheduler can place other workloads on the same cores, causing contention and reducing I/O throughput.

On Kubernetes v1.32 and later, also enable `strict-cpu-reservation` to prevent Burstable and Best Effort pods from scheduling onto reserved cores.

On hyperthreaded systems, reserve both logical CPUs of the physical core assigned to the OS. Reserving only one sibling leaves the physical core shared.

Identify HyperThreading sibling pairs on the node before configuring:

```bash
lscpu -e=cpu,core,socket,node
cat /sys/devices/system/cpu/cpu*/topology/thread_siblings_list
```

Apply the configuration to each worker node:

<details>

<summary>Example Kubelet configuration</summary>

```yaml
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
cpuManagerPolicy: "static"
reservedSystemCPUs: "0,6"
featureGates:
  CPUManagerPolicyOptions: "true"
  CPUManagerPolicyAlphaOptions: "true"
cpuManagerPolicyOptions:
  strict-cpu-reservation: "true"
```

</details>

Adjust `reservedSystemCPUs` to match the sibling pairs reported by `thread_siblings_list` on each node.

### Use consistent nodeSelector labels across all resources

Apply the same `nodeSelector` labels consistently across the WekaCluster, WekaClient, and CSI installation. A mismatch between these resources is one of the most common causes of WekaContainers not being created and CSI pods not co-locating with client pods.

WEKA recommends using the standard labels to simplify support and keep labeling consistent across the documentation, but you can use your own labels:

* Backend nodes: `weka.io/supports-backends: "true"`
* Client nodes: `weka.io/supports-clients: "true"`

Verify labels are applied before deploying any CR:

```bash
kubectl get nodes --show-labels | grep weka.io
```

### Use pre-built drivers for standard deployments

Use the WEKA driver registry at `https://drivers.weka.io` for standard Linux distributions with supported kernel versions. This approach requires no build infrastructure and produces the fastest driver provisioning path.

Use a local Drivers-Builder only when the environment is air-gapped, uses a custom or patched kernel, or cannot reach the external registry. For locally-built drivers, ensure kernel headers matching the running kernel are installed on the build server before deployment:

```bash
apt-get install -y linux-headers-$(uname -r)
```

### Protect clusters against accidental deletion

The `gracefulDestroyDuration` field on the WekaCluster CR sets a protection window before the operator begins destroying the cluster after a deletion request. The default is 24 hours.

Keep the default in production environments. To cancel a deletion during the grace period, set `overrides.cancelDeletion: true` on the WekaCluster before the window expires:

```bash
kubectl patch wekacluster <cluster-name> --type='merge' \
  -p '{"spec": {"overrides": {"cancelDeletion": true}}}'
```

Only reduce `gracefulDestroyDuration` to zero in non-production environments or when an immediate removal is intentional and confirmed.

### Use rolling upgrade policy for WekaClient

Set `upgradePolicy` to `rolling` on all WekaClient CRs. This replaces client pods one at a time, preserving availability during upgrades. The `all-at-once` policy updates all pods simultaneously and causes a full client outage. The `manual` policy requires explicit pod deletion for each update and is prone to operator error.

```yaml
spec:
  upgradePolicy: rolling
```

### Never force-delete WEKA pods

{% hint style="danger" %}
Never force-delete WEKA pods. Force deletion removes the pod from the orchestration layer only, while the underlying container continues running untracked.
{% endhint %}

Force-deleting a WEKA pod leaves the underlying container running on the node, holding all assigned resources and keeping WEKA processes active without the operator being aware of them. As a result, scheduling a replacement pod on the same node may fail, or resources may be over-allocated. The WekaContainer resource also remains, and the operator recreates the pod immediately, leaving the root cause unresolved.

To move or remove a container, delete the WekaContainer resource:

```bash
kubectl delete wekacontainer <container-name> -n <namespace>
```

For client containers with active mounts, coordinate unmounting with application owners before deleting the WekaContainer resource.

**Related topic**

[#deletion-behavior](wekacluster-and-wekacontainer-lifecycle.md#deletion-behavior "mention")

### Monitor resources using custom display fields

WEKA custom resources expose additional status fields that are not visible in the default `kubectl get` output. Use the `-o wide` flag or `k9s` to access the full field set.

Assess WekaContainer status across all namespaces:

```bash
kubectl get wekacontainer -o wide --all-namespaces
```

<details>

<summary>Example output</summary>

```bash
NAMESPACE              NAME                                                    STATUS        MODE      AGE     DRIVES COUNT   WEKA CID
weka-operator-system   cluster-dev-clients-34.242.2.16                         Running       client    64s
weka-operator-system   cluster-dev-clients-52.51.10.75                         Running       client    64s                    12
weka-operator-system   cluster-dev-compute-16fd029f-8aad-487c-be32-c74d70350f69 Running      compute   6m49s                  9
weka-operator-system   cluster-dev-compute-33f54d4b-302d-4d85-9765-f6d9a7a31d02 Running     compute   6m50s                  8
weka-operator-system   weka-dsc-34.242.2.16                                    PodNotRunning discovery 64s
```

</details>

The `STATUS` and `MODE` columns provide a quick health overview. The `DRIVES COUNT` and `WEKA CID` columns confirm drive allocation and cluster membership per container.

**Related topics**

[WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md)

[Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md)

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)
