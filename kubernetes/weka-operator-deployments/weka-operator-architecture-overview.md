---
description: >-
  Explore how the WEKA Operator deploys and manages components in a Kubernetes
  cluster.
---

# WEKA Operator architecture overview

## Components and terms

Use these terms to understand a Kubernetes deployment managed by the WEKA Operator.

<table><thead><tr><th width="192">Term</th><th>Role</th></tr></thead><tbody><tr><td><strong>WEKA Operator</strong></td><td>Orchestrates the full WEKA deployment on Kubernetes. Manages WekaCluster and WekaClient CRs across namespaces, deploys the CSI driver, and maintains the NeuralMesh client on designated nodes.</td></tr><tr><td><strong>WekaCluster CR</strong></td><td><p>Represents a complete, discrete WEKA cluster deployment spanning one or more Kubernetes nodes. Each instance defines the backend cluster configuration (storage, compute, memory, and resource limits) and manages the lifecycle of all components that comprise that cluster.</p><p>Supports on-demand operations through <code>WekaManualOperation</code> and scheduled tasks through <code>WekaPolicy</code>.</p></td></tr><tr><td><strong>WekaClient CR</strong></td><td><p>Represents multiple WEKA client instances spanning one or more Kubernetes nodes matched by <code>nodeSelector</code>. Defines the data plane connectivity layer between those nodes and the WEKA cluster, and deploys one WEKA client pod per designated node (DaemonSet behavior).</p><p>A mandatory prerequisite for provisioning and mounting WEKA as persistent storage.</p></td></tr><tr><td><strong>WekaContainer CR</strong></td><td><p>The foundational building block of any WEKA deployment on Kubernetes. Each instance represents a single WEKA software component (the smallest deployable unit), which can be a drive, compute, frontend, or protocol container, as well as ephemeral workloads spawned during the deployment lifecycle.</p><p>Some WekaContainers carry a persistent identity that must be stored on the Kubernetes node. These are pinned to a specific node for their entire lifecycle.</p></td></tr><tr><td><strong>Pod</strong></td><td>The Kubernetes runtime object created by the operator from a WekaContainer CR. The pod runs the WEKA process on the node.</td></tr><tr><td><strong>Driver Distribution Model</strong></td><td><p>Ensures the correct WEKA kernel driver is available on every node. Operates through three components:</p><ul><li><strong>Drivers-Builder:</strong> Compiles drivers for specific WEKA and kernel version combinations; multiple instances can run concurrently against the same repository.</li><li><strong>Drivers-Dist:</strong> Stores and serves driver packages over HTTP.</li><li><strong>Drivers-Loader:</strong> Detects missing drivers, retrieves them from Drivers-Dist, and loads them using <code>modprobe</code>.</li></ul></td></tr><tr><td><strong>WekaPolicy CR</strong></td><td>Defines automated and operator-wide behavior. Typed policies run scheduled tasks, such as drive signing, NIC configuration, and local driver distribution. Starting with Operator v1.16.2, a WekaPolicy with a <code>configurationPayload</code> also holds operator-wide settings for the embedded CSI plugin and for driver builds. New operator-wide settings are added to this policy instead of to the Helm values.</td></tr></tbody></table>

Configure node-level requirements during environment preparation. These include kernel headers, `/opt/k8s-weka` storage allocations, and HugePages settings.

## Backend deployment

In a full backend deployment, the operator provisions and maintains one or more WekaCluster CRs. Each WekaCluster CR is an umbrella definition for multiple WEKA backend components and the business logic the operator uses to form, provision, and configure a complete WEKA NeuralMesh deployment:

* **Compute containers:** Handle WEKA compute processing and cluster logic.
* **Drive containers:** Manage the physical drives assigned to WEKA on each node.
* **Protocol containers:** Deployed only when protocol services are configured. Each protocol container type handles a specific service: S3 for object storage, NFS-W for NFS access, and SMB-W for SMB access.

For each container type, the operator automatically calculates the required hardware resources and the number of container instances to create. This calculation ensures consistent resource allocation across all instances of the same kind.

The operator places these backend containers on the nodes defined by the WekaCluster resource.

The following diagrams show three deployment models for WEKA backend services and client connectivity. Use them to identify where backend services run, how Kubernetes-managed clients connect to the backend cluster, and when access comes from external stateless clients instead.

{% tabs %}
{% tab title="Shared Kubernetes cluster" %}
Run WekaCluster and WekaClient in a shared Kubernetes cluster. Use this model when backend services, clients, and application workloads share one Kubernetes environment.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/weka_operator_shared.png" alt="WekaCluster backend and WekaClient deployment in a shared Kubernetes cluster"><figcaption><p>WekaCluster (backend) and WekaClient deployment on a shared Kubernetes cluster</p></figcaption></figure></div>

{% hint style="info" %}
WEKA containers run in `hostNetwork` mode, giving them direct access to the host network interfaces and bypassing the Kubernetes CNI. This ensures the WEKA data plane operates at the highest performance and lowest latency without contending with Kubernetes control plane or pod network traffic. CNI bypass applies in all networking modes, including UDP.
{% endhint %}
{% endtab %}

{% tab title="Separate Kubernetes clusters" %}
Run WekaCluster and WekaClient on separate Kubernetes clusters. Use this model when storage services and application workloads remain isolated.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/weka_operator_separate.png" alt="WekaCluster backend and WekaClient deployment in separate Kubernetes clusters"><figcaption><p>WekaCluster (backend) and WekaClient on separate Kubernetes clusters</p></figcaption></figure></div>
{% endtab %}

{% tab title="External stateless client" %}
Connect a stateless client running outside Kubernetes to a WekaCluster deployed on Kubernetes. Use this model when external servers need WEKA access without deploying WekaClient.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/weka_operator_external.png" alt="External stateless clients on bare-metal servers connect to a WekaCluster on Kubernetes"><figcaption><p>External stateless clients on bare-metal servers</p></figcaption></figure></div>
{% endtab %}
{% endtabs %}

## Resource status and label propagation

The operator reports resource status throughout deployment. It also propagates labels from parent resources to child resources.

**Label propagation**

The operator propagates labels along these paths:

* `WekaCluster` > `WekaContainer`
* `WekaClient` > `WekaContainer` > Pod
* `WekaPolicy` > `WekaContainer`

Labels on a parent resource appear on every child resource it creates. This supports consistent monitoring, scheduling, and selection policies.

**Resource status**

Each `WekaCluster`, `WekaClient`, and `WekaContainer` reports its deployment status. Cluster and client resources report deployment-level status. Container resources report pod-level status.

For a full explanation of resource states and transitions, see [WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md).

## Client deployment

The WekaClient CR defines which nodes run WEKA client processes. The deployment involves the following component types:

* **WEKA Operator (Deployment):** A single instance that installs and manages WEKA. It manages `WekaCluster` and `WekaClient` CRs, deploys the CSI plugin, and manages related resources.
*   **WEKA Client:** Runs on each Kubernetes node matched by the `WekaClient` `nodeSelector`. The operator creates and independently manages one `WekaContainer` per eligible node. This provides DaemonSet-like behavior without using a DaemonSet.

    The WEKA Client is required to provision PVs and mount WEKA persistent storage.
* **CSI Controller (Deployment):** Handles CSI requests from the Kubernetes API and provisions PersistentVolumes. Runs on any two nodes (by default) that have a WEKA Client connected to the cluster. Kubernetes binds each provisioned PV to the requesting PersistentVolumeClaim.
* **CSI Plugin (DaemonSet):** Runs on every worker node that has a WEKA Client and mounts volumes into pods on that node. In embedded mode, the Operator manages this automatically. In standalone mode, you must ensure the CSI Plugin `nodeSelector` matches the WekaClient `nodeSelector`.
* **PersistentVolumeClaim (PVC):** A request for storage submitted by an application. Specifies the required capacity and access mode.
* **PersistentVolume (PV):** The WEKA storage provisioned in response to a PVC. Kubernetes binds the PV to the requesting PVC, making it available to the application.

**App Pod** (your workload) runs alongside the WEKA Client and CSI Plugin on the same node. The CSI Plugin mounts volumes locally for co-located pods.

This diagram shows the separate-cluster deployment model. The WEKA Operator processes a WekaClient CR and deploys the WEKA Client and CSI Plugin DaemonSets across designated nodes that are co-located with user application pods. Application workloads and WEKA clients run in one Kubernetes cluster, while backend WEKA containers and NVMe storage run in a separate Kubernetes cluster.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/WEKA_operator_client_deploy (1).png" alt="WEKA Operator client deployment in a separate Kubernetes cluster"><figcaption><p>WEKA Operator client deployment</p></figcaption></figure></div>

### Embedded CSI plugin

Starting with Operator v1.7.0, the CSI plugin runs in embedded mode, managed directly by the operator as part of the WekaClient CR. This removes the need to install the WEKA CSI Plugin as a separate Helm chart and eliminates manual lifecycle management.

Embedded mode supports a subset of CSI features and configuration options, which covers most deployment scenarios. In specific cases, the WEKA Customer Success team may recommend using the standalone CSI plugin instead.

The CSI plugin requires WEKA client processes on the same nodes. Client pods must be running before the CSI plugin provisions or mounts volumes.

For instructions on switching from standalone to embedded mode, see [migrate-standalone-csi-to-weka-operator-embedded.md](migrate-standalone-csi-to-weka-operator-embedded.md "mention").

{% hint style="info" %}
When the WEKA backend runs as a WekaCluster on the same Kubernetes cluster, embedded CSI can automatically provision storage classes. When connecting to an external WEKA backend, storage classes must be configured manually.

To connect a WekaClient to an in-cluster WekaCluster, set `targetCluster` in the WekaClient spec to reference the WekaCluster resource.
{% endhint %}

**Related topics**

[WEKA Operator full deployment workflow](weka-operator-full-deployment-workflow.md)

[WEKA Operator driver management](weka-operator-driver-management.md)

[WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md)

[Set up protocols on K8s with WEKA Operator](set-up-protocols-on-k8s-with-weka-operator.md)
