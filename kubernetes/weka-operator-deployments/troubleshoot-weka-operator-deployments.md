---
description: >-
  Diagnose and resolve common issues encountered during WEKA Operator deployment
  and operation.
---

# Troubleshoot WEKA Operator deployments

### Pod stuck in pending state

**Symptom:** A WekaContainer pod remains in `Pending` state and does not progress.

**Procedure**

1. Describe the pod to identify the scheduling issue:

```bash
kubectl describe pod <pod-name> -n <namespace>
```

2. Review the `Events` section of the output and match the condition to a resolution:

<details>

<summary>Common pending conditions and resolutions</summary>

<table><thead><tr><th width="203">Condition</th><th>Cause</th><th>Resolution</th></tr></thead><tbody><tr><td>Pod blocked on <code>weka.io/drives</code></td><td>The operator cannot allocate the required drives for the WekaContainer. Either more drives were requested than are available on the node, or too many <code>driveContainers</code> are already running.</td><td>Verify that drives are signed and that the number of drives requested in the WekaCluster spec does not exceed those available on the target nodes.</td></tr><tr><td>Image pull failure</td><td>The <code>imagePullSecret</code> is missing, incorrect, or not present in the target namespace.</td><td>Verify that a valid robot secret for <code>quay.io</code> exists in every namespace where WEKA resources are deployed. Each deployment requires a unique secret.</td></tr><tr><td>Insufficient resources</td><td>The node does not have enough CPU, memory, or HugePages to schedule the pod.</td><td>Verify node resource availability and confirm HugePages are configured correctly. See [Configure HugePages for Kubernetes worker nodes].</td></tr><tr><td>No matching node</td><td>The pod's <code>nodeSelector</code> does not match any available node labels.</td><td>See <a href="https://claude.ai/chat/32ea7d82-ebfc-4f46-808a-3a71f2d67250#wekacluster-or-wekaclient-not-creating-wekacontainers">WekaCluster or WekaClient not creating WekaContainers</a> below.</td></tr></tbody></table>

</details>

### WekaContainers staying in WaitForDrivers

**Symptom:** WekaContainers remain in `WaitForDrivers` state and do not progress to `Starting`.

**Cause:** The Drivers-Loader cannot obtain the kernel driver. This occurs when the driver distribution service is unreachable, the driver package is unavailable for the node's kernel version, or kernel headers are missing on the build server.

**Procedure**

1. Confirm the driver distribution service is reachable from the node:

```bash
kubectl exec -n <namespace> <weka-pod> -- curl -v <driversDistService-url>
```

2. Check the Drivers-Loader logs for connectivity or signature errors:

```bash
kubectl logs -n <namespace> -l app=weka-drivers-loader
```

3. Verify that `driversDistService` in the WekaCluster or WekaClient spec points to the correct endpoint:

```bash
kubectl get wekacluster <cluster-name> -o jsonpath='{.spec.driversDistService}'
```

4. For locally-built drivers, confirm that kernel headers matching the running kernel are installed on the build server:

```bash
uname -r
apt list --installed | grep linux-headers
```

5. If the driver package is missing for the specific kernel version, see [Driver download failures](troubleshoot-weka-operator-deployments.md#driver-download-failures).

### WekaClient containers stuck in Terminating

**Symptom:** WekaClient pod remains in `Terminating` state for an extended period.

**Cause:** The container is in `Draining` state, waiting for active mounts to be released before shutdown. This is expected behavior during deletion. The pod does not complete termination until all mounts are unmounted by the applications using them.

**Procedure**

1. Check the container state:

```bash
kubectl get wekacontainer <container-name> -n <namespace> -o jsonpath='{.status.status}'
```

2. Identify active mounts on the node:

```bash
kubectl get wekacontainer <container-name> -n <namespace> -o jsonpath='{.status.stats.activeMounts}'
```

3. Coordinate with application owners to unmount active WEKA filesystems on the affected node before the container can terminate cleanly.

{% hint style="info" %}
Do not force-delete a pod in `Draining` state. See [Do not force-delete WEKA pods](troubleshoot-weka-operator-deployments.md#do-not-force-delete-weka-pods).
{% endhint %}

### Do not force-delete WEKA pods

Force-deleting a WEKA pod does not remove the underlying WekaContainer resource. The operator immediately recreates the pod on the same node, and the root cause remains unresolved.

To move or remove a container, delete the WekaContainer resource:

```bash
kubectl delete wekacontainer <container-name> -n <namespace>
```

The operator then recreates the container, schedules a fresh pod, and applies the current `nodeSelector` rules. For client containers with active mounts, resolve the mounts before deleting the WekaContainer resource.

### WekaCluster never reaching StartingIO

**Symptom:** The WekaCluster remains in `WaitForDrives` and does not progress to `StartingIO`.

**Cause:** The cluster has not received enough signed drives to meet the threshold defined in `startIoConditions.minNumDrives`.

**Procedure**

1. Check the current cluster status:

```bash
kubectl get wekacluster <cluster-name>
```

2. Verify that the `sign-drives` WekaPolicy has been applied:

```bash
kubectl get wekapolicy -n weka-operator-system
```

3. Confirm that the `weka.io/drives` extended resource is present on the target nodes:

```bash
kubectl describe node <node-name> | grep weka.io/drives
```

4. If `weka.io/drives` is missing, the drive discovery process has not completed. Verify that the `sign-drives` WekaPolicy `nodeSelector` matches the labels on the backend nodes:

```bash
kubectl get nodes --show-labels | grep weka.io/supports-backends
```

5. Re-apply the sign-drives policy if needed:

```bash
kubectl apply -f sign-drives.yaml
```

6. Confirm that the number of available drives meets or exceeds `startIoConditions.minNumDrives` in the WekaCluster spec.

### WekaCluster or WekaClient not creating WekaContainers

**Symptom:** A WekaCluster or WekaClient is applied successfully but no WekaContainers are created.

**Cause:** The `nodeSelector` in the CR does not match any node labels in the cluster. The operator cannot schedule containers on nodes that do not satisfy the selector.

**Procedure**

1. Retrieve the `nodeSelector` from the WekaCluster or WekaClient:

```bash
kubectl get wekacluster <cluster-name> -o jsonpath='{.spec.nodeSelector}'
kubectl get wekaclient <client-name> -o jsonpath='{.spec.nodeSelector}'
```

2. Verify that at least one node carries the required labels:

```bash
kubectl get nodes --show-labels | grep weka.io/supports-backends
kubectl get nodes --show-labels | grep weka.io/supports-clients
```

3. If no nodes match, apply the correct label to the target nodes:

```bash
kubectl label nodes <node-name> weka.io/supports-backends=true
kubectl label nodes <node-name> weka.io/supports-clients=true
```

4. For CSI issues where the CSI plugin is not functioning, confirm that the `nodeSelector` on the CSI installation and the WekaClient match. A mismatch prevents the CSI node plugin from running on the same nodes as the WEKA client pods.

### CSI not functioning

**Symptom:** Persistent Volume Claims are not being provisioned or mounted.

**Cause:** The `nodeSelector` on the CSI installation and the WekaClient do not match, preventing the CSI node plugin from co-locating with the WEKA client pods.

**Procedure**

1. Retrieve the `nodeSelector` from the WekaClient:

```bash
kubectl get wekaclient <client-name> -o jsonpath='{.spec.nodeSelector}'
```

2. Retrieve the `nodeSelector` from the CSI node plugin DaemonSet:

```bash
kubectl get daemonset -n <csi-namespace> -o jsonpath='{.spec.template.spec.nodeSelector}'
```

3. Ensure both selectors match. Update the CSI configuration or WekaClient spec to align them.
4. Verify that the CSI node pods are running on the same nodes as the WekaClient pods:

```bash
kubectl get pods -n <csi-namespace> -o wide
kubectl get pods -n <namespace> -l app=weka-client -o wide
```

**Related topics**

[WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md)

[weka-operator-driver-management.md](weka-operator-driver-management.md "mention")

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)
