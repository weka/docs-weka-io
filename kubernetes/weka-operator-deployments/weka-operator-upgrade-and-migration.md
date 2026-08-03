---
description: >-
  Upgrade the WEKA Operator, WEKA cluster, and WEKA client versions in the
  correct sequence. This topic also covers related procedures for ssdproxy, and
  more.
---

# WEKA Operator upgrade and migration

## Upgrade sequence

Always perform the following three steps in order. The WEKA Operator must be upgraded before the cluster or client versions are changed. Upgrade-related bugs in the Operator are resolved first, and some WEKA versions require a minimum Operator version to interact correctly with the new software.

<table><thead><tr><th width="78.2734375">Step</th><th width="287.71484375">Task</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><a href="weka-operator-upgrade-and-migration.md#id-1.-upgrade-the-weka-operator">Upgrade the WEKA Operator</a></td><td>Install the latest Operator version before making any version changes to the cluster or clients.</td></tr><tr><td>2</td><td><a href="weka-operator-upgrade-and-migration.md#id-2.-upgrade-the-weka-cluster-version">Upgrade the WEKA cluster version</a></td><td>Update the WEKA image on the WekaCluster CR.</td></tr><tr><td>3</td><td><a href="weka-operator-upgrade-and-migration.md#id-3.-upgrade-the-weka-client-version">Upgrade the WEKA client version</a></td><td>Update the WEKA image on the WekaClient CR.</td></tr></tbody></table>

***

## Additional procedures

The following procedures are independent of the upgrade sequence. Perform them as needed based on your environment.

<table><thead><tr><th width="366">Procedure</th><th>Description</th></tr></thead><tbody><tr><td><a href="weka-operator-upgrade-and-migration.md#upgrade-the-ssdproxy-version">Upgrade the ssdproxy version</a></td><td>Apply independently of or aligned with the cluster version.</td></tr><tr><td><a href="weka-operator-upgrade-and-migration.md#migrate-a-weka-client-to-operator-controlled-management">Migrate a client to Operator-controlled management</a></td><td>Move a standalone WEKA client to Operator lifecycle management.</td></tr><tr><td><a href="weka-operator-upgrade-and-migration.md#delete-a-wekacluster">Delete a WekaCluster</a></td><td>Remove a cluster immediately or after the grace period expires.</td></tr></tbody></table>

***

## 1. Upgrade the WEKA Operator

Install the latest WEKA Operator version to ensure upgrade-related fixes are in place before the cluster or client versions are changed.

**Procedure**

Follow the steps in Install the WEKA Operator, using the target `WEKA_OPERATOR_VERSION`. Re-running the installation process with an updated version upgrades the Operator without requiring additional setup.

***

## 2. Upgrade the WEKA cluster version

Update the WEKA image running on the WekaCluster after the Operator upgrade is complete.

**Before you begin**

* Confirm the Operator has been upgraded and the `weka-operator-controller-manager` pod is in `Running` state.
* Confirm the WekaCluster is in `Ready` state before proceeding.

**Procedure**

1. Open `weka-cluster.yaml` and update the image tag:

```yaml
spec:
  image: "quay.io/weka.io/weka-in-container:<new-version-tag>"
```

2. Apply the updated configuration:

```bash
kubectl apply -f weka-cluster.yaml
```

3. Monitor pod status until all pods return to `Running`:

```bash
kubectl get pods --all-namespaces -o wide
```

**Expected results**

* All pods return to `Running` state within a few minutes.
* No service disruption occurs during pod rotation.

***

## 3. Upgrade the WEKA client version

Update the WEKA image on the WekaClient CR after the cluster upgrade is complete. Client pods with active PVC mounts are not restarted immediately; the Operator updates each client WekaContainer automatically once no PVC mounts are using it.

**Before you begin**

* Confirm the WekaCluster upgrade is complete and all cluster pods are in `Running` state.

**Procedure**

1. Open `weka-client.yaml` and update the image tag:

```yaml
spec:
  image: "quay.io/weka.io/weka-in-container:<new-version-tag>"
```

2. Apply the updated configuration:

```bash
kubectl apply -f weka-client.yaml
```

3. Monitor client pod status:

```bash
kubectl get wekaclients
kubectl get pods --all-namespaces
```

***

## Upgrade the ssdproxy version

Upgrade the ssdproxy image to apply a fix independently of the WekaCluster, or to align ssdproxy with the cluster version after a cluster upgrade.

**How the Operator selects the ssdproxy image**

When the Operator creates an ssdproxy WekaContainer, it selects the image in the following order:

1. The `driveSharing.ssdProxy.imageOverride` Helm value, if set (requires Operator v1.12.0 or later).
2. The WekaCluster `spec.image`.

The override applies only to new ssdproxy WekaContainer resources. To apply a new image to existing resources, recreate them.

**Key behaviors**

* ssdproxy operates independently of the WekaCluster version. Each Kubernetes node can run its own ssdproxy version, and pods at different versions can coexist.
* Because ssdproxy has no persistent local data, restarting on a new image is safe as long as the previous proxy stopped cleanly.
* ssdproxy WekaContainer resources are named `weka-drives-proxy-<node-name>` in the `weka-operator-system` namespace.

**Procedure**

1. To override the ssdproxy image for new resources, set the Helm value during an Operator upgrade or update:

```bash
helm upgrade weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version <WEKA_OPERATOR_VERSION> \
  --set driveSharing.ssdProxy.imageOverride=quay.io/weka.io/weka-in-container:<new-version-tag>
```

2. To apply the new image to existing ssdproxy resources, identify and recreate them:

```bash
kubectl get wekacontainer -n weka-operator-system | grep weka-drives-proxy
kubectl delete wekacontainer weka-drives-proxy-<node-name> -n weka-operator-system
```

The Operator recreates the ssdproxy WekaContainer using the updated image.

***

## Migrate a WEKA client to Operator-controlled management

Move a standalone WEKA client running directly on a Kubernetes worker node to Operator lifecycle management. Choose the approach that matches your environment.

<table><thead><tr><th width="215">Approach</th><th>When to use</th></tr></thead><tbody><tr><td><a href="weka-operator-upgrade-and-migration.md#migrate-with-container-name-override">Container name override</a></td><td>Preferred for minimal operational impact. Migrates the client without interrupting workloads. Requires quick manual action within a two-minute window.</td></tr><tr><td><a href="weka-operator-upgrade-and-migration.md#migrate-with-a-clean-installation">Clean installation</a></td><td>Use when a fresh environment without legacy components is preferred. Requires node eviction and causes a temporary disruption.</td></tr></tbody></table>

***

### Migrate with container name override

**Before you begin**

* Ensure the environment does not use local mounts.
* Ensure that quick manual removal of the standalone container is possible within two minutes of applying the new configuration, to prevent client duplication conflicts.
* Anticipate a maximum of two minutes of I/O stalls during the switchover.
* When WEKA modifies cgroups, allocated CPU cores are not automatically freed. Reclaiming them in Kubernetes typically requires a node reboot, although a Kubernetes service restart may capture the resources depending on specific settings. Until a reboot is performed, CPUs remain double-allocated.

**Procedure**

1. Identify the standalone container name on the worker node:

```bash
weka local ps
```

Example output:

```bash
CONTAINER   STATE     DISABLED   UPTIME       MONITORING   PERSISTENT   PORT    PID      STATUS   VERSION       LAST FAILURE
client      Running   False      14:02:13h    True         False        14000   166663   Ready    4.4.9.130
```

Note the name in the `CONTAINER` column, for example `client`.

2. Update `weka-client.yaml` with the container name identified in the previous step, inserting it into the `overrides` section:

```yaml
overrides:
  wekaContainerName: <client_container_name>
```

3. Apply the updated WekaClient manifest to the Kubernetes cluster:

```bash
kubectl apply -f weka-client.yaml
```

4.  Immediately after applying the configuration, remove the standalone container on the worker node. Complete these steps within two minutes to avoid crashes caused by duplicate clients:

    Stop the container:

```bash
weka local stop <container_name>
```

Remove the container:

```bash
weka local rm <container_name>
```

5. After a successful deployment, remove the legacy WEKA service from the worker node if it is no longer required:

```bash
weka agent uninstall --force
```

***

### Migrate with a clean installation

**Before you begin**

* Ensure the cluster has sufficient resources to handle workloads during node eviction.
* Ensure the environment uses only CSI mounts. Local mounts are not supported with this approach.
* Anticipate up to two minutes of I/O delays during the switchover as the Operator-based client establishes connectivity.

**Procedure**

1. Evict the node to move all running pods to other healthy worker nodes, preventing data access errors for active applications during the client removal:

```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

2. Log in to the worker node and uninstall the standalone WEKA client:

```bash
weka agent uninstall --force
```

3. Verify that no legacy WEKA processes remain active on the node:

```bash
weka local ps
```

Confirm that no WEKA containers are listed.

4. Apply the WekaClient manifest to the cluster. The Operator manages the new container lifecycle without requiring the `wekaContainerName` override:

```bash
kubectl apply -f weka-client.yaml
```

5. Monitor the switchover as the Operator pulls the required images and starts the client processes:

```bash
kubectl get wekaclients
kubectl get pods --all-namespaces
```

***

## Delete a WekaCluster

Remove a WekaCluster immediately or after the default 24-hour grace period expires.

**How the grace period works**

When a deletion is requested, the Operator pauses cluster containers instead of removing them immediately, providing a recovery window. To cancel a deletion during this window, see [Cancel a cluster deletion](../weka-operator-day-2-operations/cluster-maintenance.md#cancel-a-cluster-deletion) in Cluster maintenance.

For environments where immediate removal is preferred, such as testing or development, bypass the grace period by setting `gracefulDestroyDuration` to `0s` before initiating the deletion.

**Procedure**

1. To bypass the grace period, set `gracefulDestroyDuration` to zero:

```bash
kubectl patch WekaCluster <cluster-name> --type='merge' \
  -p='{"spec": {"gracefulDestroyDuration": "0"}}'
```

2. Delete the WekaCluster:

```bash
kubectl delete WekaCluster <cluster-name> --namespace <cluster-namespace>
```

{% hint style="info" %}
Do not set `gracefulDestroyDuration` to `0s` in production environments unless immediate removal is intentional and confirmed. The default 24-hour window reduces the risk of accidental deletion, but it is not a valid way to preserve a cluster. Recovery from accidental deletion requires WEKA support.
{% endhint %}

***

**Related topics**

Install the WEKA Operator

[Cluster maintenance](../weka-operator-day-2-operations/cluster-maintenance.md)

[WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md)

[Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md)

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)
