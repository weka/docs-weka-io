---
description: >-
  Perform day-2 configuration updates, token rotation, trace management, and
  planned maintenance operations on a running WEKA Operator deployment.
---

# Cluster maintenance

{% hint style="info" %}
Version upgrades for the WEKA Operator, WekaCluster, and WekaClient are covered in [WEKA Operator upgrade and migration](../weka-operator-deployments/weka-operator-upgrade-and-migration.md).
{% endhint %}

**Tasks**

<table><thead><tr><th width="308">Task</th><th>Description</th></tr></thead><tbody><tr><td><a href="cluster-maintenance.md#update-wekacluster-configuration">Update WekaCluster configuration</a></td><td>Modify memory, tolerations, driver service, and image pull secret settings.</td></tr><tr><td><a href="cluster-maintenance.md#update-wekaclient-configuration">Update WekaClient configuration</a></td><td>Modify client-side memory, ports, cores, tolerations, and authentication settings.</td></tr><tr><td><a href="cluster-maintenance.md#rotate-pods-after-applying-changes">Rotate pods after applying changes</a></td><td>Restart all WekaContainer pods to apply updated configuration cluster-wide.</td></tr><tr><td><a href="cluster-maintenance.md#rotate-the-wekaclient-join-token">Rotate the WekaClient join token</a></td><td>Generate a new join token and update the Kubernetes secret before the current token expires.</td></tr><tr><td><a href="cluster-maintenance.md#configure-trace-retention">Configure trace retention</a></td><td>Set trace retention limits on a Kubernetes-managed WEKA cluster.</td></tr><tr><td><a href="cluster-maintenance.md#pause-and-resume-a-cluster-for-maintenance">Pause and resume a cluster for maintenance</a></td><td>Halt all cluster I/O gracefully for a planned maintenance window.</td></tr><tr><td><a href="cluster-maintenance.md#cancel-a-cluster-deletion">Cancel a cluster deletion</a></td><td>Recover a cluster before the graceful destroy period expires.</td></tr></tbody></table>

***

## Update WekaCluster configuration

Update WekaCluster configuration parameters to adjust memory allocation, tolerations, driver distribution, or registry authentication.

After you apply the change, the Operator rolls out the affected pods within a few minutes.

**Updatable parameters**

| Parameter                   | Field                     |
| --------------------------- | ------------------------- |
| Additional memory           | `spec.additionalMemory`   |
| Tolerations                 | `spec.tolerations`        |
| Raw tolerations             | `spec.rawTolerations`     |
| Driver distribution service | `spec.driversDistService` |
| Image pull secret           | `spec.imagePullSecret`    |

**Before you begin**

* Verify the WekaCluster is in `Ready` state.
* Back up the current `weka-cluster.yaml` before making changes.

**Procedure**

1.  Open `weka-cluster.yaml` and update the relevant field. Use the examples below as reference for each parameter.

    **AdditionalMemory:**

```yaml
additionalMemory:
  compute: 100
  s3: 200
  drive: 300
```

**Tolerations and RawTolerations:**

```yaml
tolerations:
  - simple-toleration
  - another-one
rawTolerations:
  - key: "weka.io/dedicated"
    operator: "Equal"
    value: "weka-backend"
    effect: "NoSchedule"
```

**DriversDistService:**

```yaml
driversDistService: "https://weka-driverdist.namespace.svc.cluster.local:60002"
```

**ImagePullSecret:**

```yaml
imagePullSecret: "your-new-secret-name"
```

2. Apply the updated configuration:

```bash
kubectl apply -f weka-cluster.yaml
```

3. If the rollout does not start automatically, see [Rotate pods after applying changes](cluster-maintenance.md#rotate-pods-after-applying-changes).
4. Verify that the updated values are applied:

```bash
kubectl get pods -A -o=jsonpath="{range .items[*]}{.metadata.namespace}{' '}{.metadata.name}{':\n'}{' Requests: '}{.spec.containers[*].resources.requests.memory}{'\n'}{' Limits: '}{.spec.containers[*].resources.limits.memory}{'\n\n'}{end}"
```

**Troubleshooting**

If pods do not restart or the new configuration is not applied, verify:

* The syntax in `weka-cluster.yaml` is correct.
* You have the necessary permissions to modify the cluster configuration.
* The WekaCluster is in a healthy state.

***

## Update WekaClient configuration

Update WekaClient configuration parameters to adjust client memory, ports, cores, tolerations, authentication references, or the driver distribution service.

After applying any of the following changes, all affected pods restart within a few minutes to apply the new configuration.

**Updatable parameters**

| Parameter                   | Field                     |
| --------------------------- | ------------------------- |
| Driver distribution service | `spec.driversDistService` |
| Image pull secret           | `spec.imagePullSecret`    |
| Cluster secret reference    | `spec.wekaSecretRef`      |
| Additional memory           | `spec.additionalMemory`   |
| Upgrade policy              | `spec.upgradePolicy`      |
| Drivers loader image        | `spec.driversLoaderImage` |
| Port                        | `spec.port`               |
| Agent port                  | `spec.agentPort`          |
| Port range                  | `spec.portRange`          |
| Cores number                | `spec.coresNumber`        |
| Tolerations                 | `spec.tolerations`        |
| Raw tolerations             | `spec.rawTolerations`     |

**Before you begin**

* Ensure you have access to the `weka-client.yaml` configuration file or the WekaClient CR.
* Verify you have the necessary permissions to modify client configurations.
* Back up the current `weka-client.yaml` before making changes.
* Verify the cluster is in a healthy state and accessible to clients.

**Procedure**

1.  Open `weka-client.yaml` and update the relevant field. Use the examples below as reference for each parameter.

    **DriversDistService:**

```yaml
driversDistService: "https://weka-driverdist.namespace.svc.cluster.local:60002"
```

**ImagePullSecret:**

```yaml
imagePullSecret: "your-new-secret-name"
```

**WekaSecretRef:**

```yaml
wekaSecretRef: "your-new-secret-ref"
```

**AdditionalMemory:**

```yaml
additionalMemory: 1000
```

**Tolerations and RawTolerations:**

```yaml
tolerations:
  - simple-toleration
  - another-one
rawTolerations:
  - key: "weka.io/dedicated"
    operator: "Equal"
    value: "weka-client"
    effect: "NoSchedule"
```

**CoresNumber:**

```yaml
coresNumber: <new-core-number>
```

2. Apply the updated configuration:

```bash
kubectl apply -f weka-client.yaml
```

3. Delete the affected client pods to trigger the restart:

```bash
kubectl delete pod <client-pod-name>
```

4. Verify the pods have restarted and rejoined the cluster:

```bash
kubectl get pods --all-namespaces
```

**Troubleshooting**

If pods do not restart or the new configuration is not applied, verify:

* The syntax in `weka-client.yaml` is correct.
* You have the necessary permissions to modify the client configuration.
* The cluster is in a healthy state and accessible to clients.
* The specified ports are available and not blocked by network policies.

***

#### Update port configuration

Migrate from explicit `port` and `agentPort` settings to a `portRange` configuration. This procedure involves deleting client pods to apply the change. Follow the force-delete guidance below before proceeding.

{% hint style="info" %}
Do not use `--force --grace-period=0` when deleting WekaClient pods. Force-deleting a pod does not remove the underlying WekaContainer resource. The Operator immediately recreates the pod on the same node. Delete the WekaContainer resource instead if the pod does not terminate cleanly. See [Do not force-delete WEKA pods](../weka-operator-deployments/troubleshoot-weka-operator-deployments.md#do-not-force-delete-weka-pods) in Troubleshoot WEKA Operator deployments.
{% endhint %}

**Procedure**

1. Verify the clients are running with the current port configuration:

```bash
kubectl get pods --all-namespaces
```

2. Open `weka-client.yaml`, remove the `port` and `agentPort` fields, and add `portRange`:

```yaml
spec:
  portRange:
    basePort: 45000
```

3. Apply the updated configuration:

```bash
kubectl apply -f weka-client.yaml
```

4. Delete the WekaContainer resource for each affected client to trigger reconfiguration. Replace `<client-container-name>` with the actual WekaContainer name:

```bash
kubectl delete wekacontainer <client-container-name> -n weka-operator-system
```

5. Verify the pods have restarted and rejoined the cluster:

```bash
kubectl get pods --all-namespaces
```

***

## Rotate pods after applying changes

Restart all WekaContainer pods in sequence to apply updated cluster configuration across all containers.

{% hint style="info" %}
Wait for each set of pods to return to `Running` before proceeding to the next set. Deleting all pod types simultaneously can cause a service disruption.
{% endhint %}

**Before you begin**

Apply the updated configuration before rotating pods:

```bash
kubectl apply -f weka-cluster.yaml
```

**Procedure**

1. Delete compute pods:

```bash
kubectl delete pod -n weka-operator-system cluster-dev-compute-*
```

{% hint style="warning" %}
Never force-delete WEKA pods. Force deletion removes the pod from the orchestration layer only, while the underlying container continues running untracked. See [#deletion-behavior](../weka-operator-deployments/wekacluster-and-wekacontainer-lifecycle.md#deletion-behavior "mention").
{% endhint %}

2. Wait for compute pods to reach `Running`, then delete drive pods:

```bash
kubectl delete pod -n weka-operator-system cluster-dev-drive-*
```

3. Wait for drive pods to reach `Running`, then delete S3 pods:

```bash
kubectl delete pod -n weka-operator-system cluster-dev-s3-*
```

4. Wait for S3 pods to reach `Running`, then delete envoy pods:

```bash
kubectl delete pod -n weka-operator-system cluster-dev-envoy-*
```

5. Monitor pod status until all pods return to `Running`:

```bash
kubectl get pods --all-namespaces -o wide
```

**Expected results**

* All pods return to `Running` state within a few minutes.
* Resource configurations match the updated values in the cluster configuration.
* No service disruption occurs during the rotation process.
* Pods automatically restart after deletion.

***

## Rotate the WekaClient join token

Generate a new join token and update the Kubernetes secret before the current token expires to maintain uninterrupted WekaClient connectivity.

**Before you begin**

* Ensure you have access to a running WEKA backend container in the `weka-operator-system` namespace.
* Ensure you have `kubectl` access with appropriate permissions.

***

#### Step 1: Generate and encode a new join token

1. List the available pods in the `weka-operator-system` namespace:

```bash
kubectl get pods -n weka-operator-system
```

2. Connect to a backend pod and generate a long-lived token. Replace `<POD_NAME>` with a Compute or Drive pod name:

```bash
kubectl exec -it -n weka-operator-system <POD_NAME> -- \
  weka cluster join-token generate --access-token-timeout 52w
```

This command generates a JWT token valid for 52 weeks. Example output:

```
eyJhbGciOiJSUzI1NiIsIml0dCI6IkNMSUVOVCIsInR5cCI6IkpXVCJ9...
```

3. Encode the token to base64:

```bash
echo <TOKEN> | base64 -w 0 && echo
```

Save the base64-encoded output for use in the next step.

***

#### Step 2: Create the updated Kubernetes secret

Choose one of the following options:

**Option A: Create from a YAML template**

Create a file named `secret.yaml` and populate it with the encoded values:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: weka-client-cluster1
  namespace: <namespace>
type: Opaque
data:
  join-secret: <BASE64_ENCODED_TOKEN>
  org: <BASE64_VALUE>
  password: <BASE64_VALUE>
  username: <BASE64_VALUE>
```

* `join-secret`: use the base64-encoded token from step 1.
* `org`, `username`, `password`: copy from the existing secret or provide new base64-encoded values.

**Option B: Export and modify the existing secret**

Export the current secret and update only the token:

```bash
kubectl get secret -n weka-operator-system weka-client-cluster1 -o yaml \
  > weka-client-cluster1_new.yaml
```

Edit the file and replace the `join-secret` value with the new base64-encoded token.

***

#### Step 3: Apply the secret

Apply the updated secret:

```bash
kubectl apply -f <secret-yaml-file>.yaml
```

Verify the secret was created:

```bash
kubectl get secret -n <namespace>
```

***

#### Step 4: Update the WekaClient configuration

1. Remove active workloads from the target node to ensure no pods are actively using WEKA storage:

```bash
kubectl get pods --field-selector spec.nodeName=<node-name>
kubectl delete pod <pod-name>
```

2. Remove the existing WekaClient:

```bash
kubectl get wekaclient -n weka-operator-system
kubectl delete wekaclient -n weka-operator-system <client-name>
```

3. Create a new WekaClient that references the updated secret:

```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaClient
metadata:
  name: new-cluster1-clients
  namespace: default
spec:
  image: quay.io/weka.io/weka-in-container:<version-tag>
  imagePullSecret: quay-io-robot-secret
  driversDistService: "https://drivers.weka.io"
  nodeSelector:
    weka.io/supports-clients: "true"
  wekaSecretRef: weka-client-cluster1
  targetCluster:
    name: cluster1
    namespace: weka-operator-system
  portRange:
    basePort: 45000
```

4. Apply the manifest:

```bash
kubectl apply -f new-weka-client.yaml
```

***

#### Step 5: Verify client status

Monitor the new WekaClient deployment:

```bash
kubectl get wekaclients
kubectl get pods
```

The new client should show `Running` status. CSI pods may temporarily enter `CrashLoopBackOff` while the client initializes but recover automatically once the client is ready. If CSI pods remain in a failed state after the WekaClient is running, restart them manually:

```bash
kubectl delete pod -n csi-wekafs <csi-pod-name>
```

**Token management best practices**

* Generate tokens with expiration times aligned to your maintenance schedule.
* Store secrets in the appropriate namespaces with RBAC controls applied.
* Maintain records of token generation dates and expiration times.
* Set up alerts for token expiration to prevent service disruptions.
* Validate new tokens in non-production environments before deploying to production.
* Limit access to token generation commands to authorized personnel.
* Rotate tokens regularly as part of your security policy.
* Monitor and audit secret access and modifications.

***

## Configure trace retention

Set trace retention limits on a Kubernetes-managed WEKA cluster. The Operator applies the settings cluster-wide and propagates them to attached stateless clients automatically.

{% hint style="info" %}
Do not run `weka cluster` commands to configure trace retention on a Kubernetes-managed deployment. These commands take effect only when `dumperConfigMode` is set to `cluster`. The Operator manages `dumperConfigMode` automatically and sets it to `auto`.
{% endhint %}

**Procedure**

1. Add the `tracesConfiguration` block under `spec` in the WekaCluster CR:

```yaml
spec:
  tracesConfiguration:
    ensureFreeSpace: <value in GiB>
    maxCapacityPerIoNode: <value in GiB>
```

| Field                  | Description                                                            | Required            |
| ---------------------- | ---------------------------------------------------------------------- | ------------------- |
| `ensureFreeSpace`      | Minimum free space, in GiB, the cluster preserves on each I/O process. | Yes                 |
| `maxCapacityPerIoNode` | Maximum total trace capacity, in GiB, per I/O process.                 | No. Default: 10 GiB |

2. Apply the updated configuration:

```bash
kubectl apply -f weka-cluster.yaml
```

Cluster-level retention propagates to stateless clients automatically. To override retention on a specific stateless client:

```bash
weka debug traces retention set \
  --client-ensure-free <value>GiB \
  --client-max <value>GiB
```

**Related topic:** \[Traces management]

***

## Pause and resume a cluster for maintenance

Pause all containers in a WEKA cluster gracefully during a planned maintenance window where all I/O must halt without removing the cluster.

**Before you begin**

Run `weka cluster stop-io` manually before applying the pause. The Operator does not perform this step automatically.

**Key behaviors**

* No data is deleted during a pause.
* The pause state propagates automatically to any WekaClient resources that reference the cluster through `spec.targetCluster` during the client's next reconciliation cycle.
* The `spec.overrides.paused` field on the WekaCluster CR controls the pause state.

**`spec.overrides.paused` values**

<table><thead><tr><th width="185">Value</th><th>Behavior</th></tr></thead><tbody><tr><td>Field omitted</td><td>No propagation. The cluster does not enforce a pause state on containers.</td></tr><tr><td><code>true</code></td><td>Containers are stopped in sequence. Cluster status changes to <code>Paused</code>.</td></tr><tr><td><code>false</code></td><td>Containers that were paused by this field transition back to active. Containers in other states are not affected.</td></tr></tbody></table>

**Procedure: pause the cluster**

1. Run `weka cluster stop-io` on the cluster.
2. Apply the following change to the WekaCluster manifest:

```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  name: my-cluster
spec:
  overrides:
    paused: true
```

3. Apply the updated configuration:

```bash
kubectl apply -f weka-cluster.yaml
```

The cluster status changes to `Paused` as containers are stopped in sequence.

**Procedure: resume the cluster**

Set `paused` to `false` to return paused containers to active state:

```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  name: my-cluster
spec:
  overrides:
    paused: false
```

Apply the updated configuration:

```bash
kubectl apply -f weka-cluster.yaml
```

To remove cluster-level pause control entirely, delete the `overrides.paused` field from the manifest.

***

## Cancel a cluster deletion

Recover a WEKA cluster after a deletion has been initiated but before the graceful destroy period expires.

**How the grace period works**

When a deletion is requested, the Operator pauses cluster containers instead of removing them immediately, providing a recovery window. The default grace period is 24 hours, set by `spec.gracefulDestroyDuration`. To bypass this window in non-production environments, see [Delete a WekaCluster](../weka-operator-deployments/weka-operator-upgrade-and-migration.md#delete-a-wekacluster) in WEKA Operator upgrade and migration.

**Before you begin**

* Verify the cluster is still within the `gracefulDestroyDuration` window.
* Ensure you have permissions to edit the WekaCluster CR.

**Procedure**

1. Open the WekaCluster resource for editing:

```bash
kubectl edit wekacluster <cluster-name> -n <namespace>
```

2. Navigate to the `spec.overrides` section and set `cancelDeletion` to `true`:

```yaml
spec:
  overrides:
    cancelDeletion: true
```

3. Save and apply the change. The Operator detects the update and resumes the cluster containers.
4. Verify the cluster returns to a healthy state:

```bash
kubectl get wekacluster <cluster-name> -n <namespace>
```

The cluster status should return to `Ready`.

***

**Related topics**

[WEKA Operator upgrade and migration](../weka-operator-deployments/weka-operator-upgrade-and-migration.md)

[WekaCluster and WekaContainer lifecycle](../weka-operator-deployments/wekacluster-and-wekacontainer-lifecycle.md)

[Troubleshoot WEKA Operator deployments](../weka-operator-deployments/troubleshoot-weka-operator-deployments.md)

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)
