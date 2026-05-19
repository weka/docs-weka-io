---
description: >-
  Upgrade NFS, S3, and SMB-W protocol containers on a Kubernetes cluster managed
  by the WEKA Operator using version-based node labels and the roleNodeSelector
  field on the WekaCluster custom resource.
---

# Upgrade protocol containers on the WEKA Operator

## Protocol container upgrade behavior

Protocol containers run as Kubernetes pods scheduled by the WEKA Operator onto labelled Kubernetes nodes. The Operator enforces two scheduling invariants that shape every upgrade:

* **Single version per node.** The Operator does not place containers from two different WEKA versions on the same node, even when those containers belong to different WekaCluster resources.
* **Single protocol container per node by default.** Multiple protocol containers per node require the Helm-time flag `allowMultipleProtocolsPerNode=true` on the Operator chart. This flag does not relax the single-version rule.

These invariants matter most in shared-infrastructure deployments where one Kubernetes cluster hosts several WekaCluster resources for different tenants or services. In that topology, upgrading one cluster's protocol containers in place could schedule a new-version pod onto a node that still runs an old-version protocol container from a neighbouring cluster, which the Operator prevents.

#### Container deletion versus pod deletion

Deleting a protocol pod does not migrate it to a new node. The Operator immediately respawns the pod on the same node because the underlying WekaContainer resource still references that node.

To move a protocol container to a different node, delete the WekaContainer resource. The Operator then recreates the container, schedules a fresh pod, and applies the current `roleNodeSelector` rules.

## Upgrade a protocol container to a new WEKA version

#### Before you begin

* Confirm you have `kubectl` access to the Kubernetes cluster and edit permissions on WekaCluster resources in the target namespace.
* Identify the WEKA versions involved: the current version on the protocol containers and the target version of the WEKA cluster image.
* Identify the Kubernetes nodes that will host the new-version protocol containers. These nodes must be free of protocol containers from other WekaCluster resources running a different version, or already labelled for the target version.
* Confirm whether the Operator was installed with `allowMultipleProtocolsPerNode=true`. If yes, plan an explicit upgrade strategy because the Operator does not auto-manage co-located protocols across versions.

{% hint style="warning" %}
Do not place new-version protocol pods on nodes that already host old-version protocol pods from any cluster. The Operator rejects the placement and the upgrade stalls.
{% endhint %}

#### Procedure

1. Label the target Kubernetes nodes with the new version.

{% code overflow="wrap" %}
```bash
kubectl label node <node-1> <node-2> weka.io/protocol-version=<target-version>
```
{% endcode %}

Replace `<target-version>` with the WEKA version string used by the cluster image, for example `5.0.3.25`.

2. Update the WekaCluster resource to reference both the new image and the new `roleNodeSelector` for each protocol you are upgrading. Apply both changes in a single patch so the Operator receives a consistent target state.

```bash
    kubectl patch wekacluster <cluster-name> -n <namespace> --type='merge' -p '
    {
      "spec": {
        "image": "<new-image-reference>",
        "roleNodeSelector": {
          "s3":  { "weka.io/protocol-version": "<target-version>" },
          "nfs": { "weka.io/protocol-version": "<target-version>" },
          "smbw":{ "weka.io/protocol-version": "<target-version>" }
        }
      }
    }'
```

Include only the protocol entries you actually run. The `roleNodeSelector` map supports `compute`, `dataServices`, `drive`, `nfs`, `s3`, and `smbw`. Each entry overrides the cluster-wide `nodeSelector` for that role.

3. Identify the WekaContainer resources that belong to nodes which no longer match the new `roleNodeSelector`. These are the containers that must move.

{% code overflow="wrap" %}
```bash
kubectl get wekacontainers -n <namespace> -l weka.io/cluster-id=<cluster-id>
```
{% endcode %}

4. Delete each WekaContainer that runs on a node the new selector excludes.

```bash
kubectl delete wekacontainer <container-name> -n <namespace>
```

The Operator recreates each deleted container. The new WekaContainer schedules onto a node that matches the new selector and starts on the target version.

5\. Watch the protocol pods reach **Running** state on the new-version nodes.

{% code overflow="wrap" %}
```bash
kubectl get pods -n <namespace> -l app.kubernetes.io/managed-by=weka-operator -o wide
```
{% endcode %}

6. Verify each protocol against the WEKA cluster:
   * **NFS:** Confirm clients reconnect and exported filesystems remain accessible.
   * **S3:** Confirm bucket access and that `weka cluster container` reports the S3 backends on the target version.
   * **SMB-W:** Confirm share enumeration and authentication.

#### Expected results

* The new-version protocol pods run on the labelled nodes.
* The old-version protocol pods are gone, along with the WekaContainer resources that backed them.
* The protocol service remains available throughout, provided you maintain enough capacity for the protocol's high-availability requirements during the move.

## Troubleshooting

<details>

<summary><strong>Pods stay Pending after you delete the WekaContainer</strong></summary>

Confirm the target nodes carry the new label and that no other WekaCluster resource has scheduled an incompatible-version protocol pod onto them.

</details>

<details>

<summary><strong>The Operator refuses to update the WekaCluster</strong></summary>

Check the Operator logs for selector validation errors. Confirm the label key and value match what you applied to the nodes exactly.

</details>

<details>

<summary><strong>The upgrade stalls on a single node</strong></summary>

Confirm the WekaContainer for that node was deleted, not just the pod. Deleting only the pod respawns the same container on the same node.

</details>
