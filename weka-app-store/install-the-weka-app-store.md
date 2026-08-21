---
description: >-
  Set up the App Store on Kubernetes, configure access to NeuralMesh storage,
  and deploy AI applications through the browser.
---

# Install the WEKA App Store

Deploy the WEKA App Store on a Kubernetes cluster to install the WEKA Operator, the CSI storage driver, and the App Store GUI for browsing and deploying AI applications. This guide covers adding the Helm repository, installing the chart, and completing the setup wizard that connects the cluster to NeuralMesh storage.

## Before you begin

Gather the following information and access before starting. The setup wizard prompts for most of these values, so having them ready avoids interruptions partway through.

* A running Kubernetes cluster, version 1.24 or later, with `kubectl` configured on the workstation and cluster-admin access. Run `kubectl cluster-info` to confirm the connection.
* Helm version 3.10 or later. Run `helm version` to check the installed version. Install Helm from the official Helm documentation if needed.
* The NeuralMesh cluster endpoint addresses: the IP addresses (or hostnames) and port numbers of the NeuralMesh servers, for example `192.168.1.10:14000`. Collect at least one endpoint, though three or more improve resilience. The default WEKA port is `14000`.
* The WEKA software version running on the cluster, for example `5.1.0.605`. This value must match exactly. Find it by running `weka version` on a WEKA server, or in the WEKA management UI under **Configuration > Cluster Settings > General Information**.
* A WEKA user account with the CSI role. This is a dedicated service account for the storage driver, not a personal WEKA admin account. Ask a WEKA administrator to create one if it does not exist.
* A Quay.io login with access to WEKA container images. WEKA provides this at registration on get.weka.io. Contact WEKA Sales if access is missing.
* Root or sudo access to every Kubernetes worker node, to apply a one-time kubelet configuration change.
* Network connectivity from the Kubernetes worker nodes to the NeuralMesh cluster. Confirm the required ports are open between the Kubernetes nodes and the NeuralMesh servers. Refer to the WEKA documentation for the port list.

{% hint style="info" %}
Upgrading an existing installation? Run `helm repo update` before any upgrade to retrieve the latest available chart version.
{% endhint %}

## Step 1: Add the Helm repository

The WEKA App Store is distributed as a Helm chart hosted on GitHub Pages. Add the repository to the local Helm configuration once, before installing or upgrading the chart.

1.  Register the repository and refresh the chart index:

    ```bash
    helm repo add weka-app-store https://weka.github.io/appstore-helm
    helm repo update
    ```
2.  Confirm the repository is available:

    ```bash
    helm search repo weka-app-store
    ```

    The output lists `weka-app-store/weka-app-store-operator-chart` along with its current version.

## Step 2: Install the Helm chart

Installing the chart deploys the WEKA App Store operator and its web-based GUI on the cluster, and registers the `WekaAppStore` custom resource type that the operator uses to track every deployment it manages.

1.  Create the namespace for the operator:

    ```bash
    kubectl create namespace weka-app-store
    ```
2. Create a Quay robot secret for image pull secret:

```bash
kubectl create secret docker-registry quay-appstore-pull \
  --docker-server=quay.io \
  --docker-username='weka.io+<robotname>' \
  --docker-password='<robot-token>' \
  --docker-email='not-used@weka.io' \
  -n weka-app-store
```

1.  Install the chart, choosing an option based on how the GUI should be exposed.

    Option A: LoadBalancer (recommended for bare-metal clusters with MetalLB)

    ```bash
    helm install weka-app-store weka-app-store/weka-app-store-operator-chart \
      --namespace weka-app-store \
      --set service.type=LoadBalancer \
      --set 'imagePullSecrets[0].name=quay-appstore-pull'
    ```

    Option B: NodePort (when a load balancer is not available)

    ```bash
    helm install weka-app-store weka-app-store/weka-app-store-operator-chart \
      --namespace weka-app-store \
      --set service.type=NodePort \
      --set 'imagePullSecrets[0].name=quay-appstore-pull'
    ```

    Option C: ClusterIP only (access by port-forward)

    ```bash
    helm install weka-app-store weka-app-store/weka-app-store-operator-chart \
      --namespace weka-app-store \
      --set 'imagePullSecrets[0].name=quay-appstore-pull'
    ```

    <div data-gb-custom-block data-tag="hint" data-style="warning" class="hint hint-warning"><p>The chart installs a <code>ClusterRole</code> and <code>ClusterRoleBinding</code> that grant the operator broad permissions across the cluster, because the operator manages resources in multiple namespaces. Run <code>helm install</code> with cluster-admin privileges.</p></div>
2.  Confirm the operator pod started:

    ```bash
    kubectl get pods -n weka-app-store
    ```

    A pod with a name starting with `weka-app-store` shows `Running` status.
3.  Confirm the custom resource type registered:

    ```bash
    kubectl get crd wekaappstores.warp.io
    ```

    If both commands return results, the operator is ready.

## Step 3: Access the App Store

With the operator running, open the App Store GUI to start the setup wizard.

For LoadBalancer or NodePort installations, find the assigned address:

```bash
kubectl get svc -n weka-app-store
```

For LoadBalancer, use the address under `EXTERNAL-IP`. For NodePort, use any worker node's IP address with the high port number shown under `PORT(S)`.

For ClusterIP installations, open a temporary tunnel:

```bash
kubectl port-forward svc/wekaappstoregui-svc 8080:80 -n weka-app-store
```

Then open `http://localhost:8080` in a browser.

{% hint style="info" %}
Until the setup wizard is completed, every page in the App Store redirects back to the wizard. Complete the wizard before deploying blueprints or accessing the main interface.
{% endhint %}

## Step 4: Complete the setup wizard

The setup wizard runs once and configures the connection between the Kubernetes cluster and the NeuralMesh storage system, across six screens.

### Node prerequisites

Before WEKA can run as a containerised storage client on the Kubernetes nodes, the kubelet, the Kubernetes agent that runs on every node, needs specific settings applied. This screen displays the configuration to apply on every worker node before continuing.

{% hint style="warning" %}
Applying these settings requires SSH access to each worker node and causes the kubelet to restart on each node, briefly interrupting the Kubernetes agent on that node. Schedule this during a maintenance window on production clusters.
{% endhint %}

The wizard displays a ready-to-paste configuration snippet with the following settings.

<table><thead><tr><th width="204.17578125">Setting</th><th width="163.4765625">Value</th><th>Purpose</th></tr></thead><tbody><tr><td>CPU Manager Policy</td><td><code>static</code></td><td>Allows containers to request dedicated CPU cores instead of sharing them. WEKA's storage processes require exclusive access to specific cores for consistent performance.</td></tr><tr><td>Reserved CPUs</td><td><code>1000m</code> plus CPUs 0 and 1</td><td>Reserves one CPU core and two dedicated system CPUs for Kubernetes system processes, so WEKA does not compete with the operating system for CPU time.</td></tr><tr><td>Reserved Memory</td><td><code>1 GiB</code></td><td>Reserves RAM for Kubernetes system processes, separate from the memory WEKA itself uses.</td></tr><tr><td>Hugepages</td><td>25,000 x 2 MB (50 GB per node)</td><td>Reserves large memory regions that bypass normal operating system memory management, letting WEKA move data at high speed with minimal CPU overhead. Confirm each node has at least 50 GB of free RAM above what other workloads need.</td></tr></tbody></table>

Apply the configuration and restart the kubelet on every worker node, then select the confirmation checkbox and select **Next**.

### Quay credentials

WEKA's operator and client container images are stored in a private registry on Quay.io. This step creates a Kubernetes pull secret so the nodes can authenticate with Quay.io and download the images during installation.

<table><thead><tr><th width="187.51953125">Field</th><th width="165.08984375">Requirement</th><th>Description</th></tr></thead><tbody><tr><td>Quay Username</td><td>Required</td><td>The Quay.io account granted access to WEKA's private container images.</td></tr><tr><td>Quay Password</td><td>Required</td><td>The Quay.io password or robot token. A robot token is recommended for production environments: it can be rotated without affecting the main login, and it distinguishes a service credential from a personal one in audit logs.</td></tr><tr><td>Operator Version</td><td>Default: <code>v1.13.0</code></td><td>The version of the WEKA Kubernetes operator to install. Leave the default if unsure. The version must exist on Quay.io, entered as <code>v1.13.0</code> or <code>1.13.0</code>.</td></tr></tbody></table>

Use the Quay.io credentials from the WEKA portal account at get.weka.io.

### WEKA connection

This step tells the WEKA client, which runs as a DaemonSet on every node, how to find and connect to the NeuralMesh cluster.

<table><thead><tr><th width="206.94140625">Field</th><th width="133.578125">Requirement</th><th>Description</th></tr></thead><tbody><tr><td>WEKA Endpoints</td><td>Required</td><td>A comma-separated list of <code>host:port</code> entries for the NeuralMesh cluster servers. At least one entry is required; three or more allow the client to stay connected if one server is temporarily unavailable. Example: <code>10.0.1.10:14000,10.0.1.11:14000,10.0.1.12:14000</code></td></tr><tr><td>WEKA Image Version</td><td>Required</td><td>The exact WEKA software version running on the cluster. The containerized client version must match the version on the NeuralMesh servers: even a minor version mismatch prevents the client from connecting. Example: <code>5.1.0.605</code></td></tr><tr><td>Endpoint Scheme</td><td>Default: <code>http</code></td><td>The protocol used to reach the NeuralMesh cluster management API. Leave as <code>http</code> unless the NeuralMesh cluster has TLS enabled on its management API endpoint, in which case select <code>https</code>.</td></tr></tbody></table>

Find the endpoint addresses in the WEKA management UI under **Configure > Cluster Servers**, then select **Backends** from the server menu. The default port is `14000`. Find the image version by running `weka version` on a WEKA server, or under **Configuration > Cluster Settings > General Information** in the management UI.

### Networking

This step sets how the WEKA client transfers data between the Kubernetes nodes and the NeuralMesh cluster. The choice affects throughput and latency. Select **Auto** if unsure: the mode can be changed later.

<table><thead><tr><th width="239.40234375">Mode</th><th>Description</th></tr></thead><tbody><tr><td>Auto (recommended)</td><td>WEKA automatically selects the best available networking mode for the environment. The safest choice when the available NICs or supported modes are unclear.</td></tr><tr><td>DPDK (high performance)</td><td>Uses kernel-bypass networking for the highest throughput and lowest latency. Requires DPDK-capable network cards, typically Mellanox/NVIDIA ConnectX series or Intel adapters. Selecting DPDK reveals a field for the NIC device names: enter the storage network interface names, comma-separated, for example <code>ens3f0,ens3f1</code>. Find NIC names by running <code>ip link show</code> on a worker node and identifying the interfaces connected to the storage network.</td></tr><tr><td>UDP (compatibility mode)</td><td>Uses standard UDP-based software networking. Lower throughput than DPDK, but compatible with any network card and environment. Use this when DPDK is unavailable or maximum throughput is not required.</td></tr></tbody></table>

### WEKA credentials

These credentials let the WEKA CSI storage driver authenticate with the NeuralMesh cluster to create, delete, and manage storage volumes on behalf of Kubernetes workloads.

{% hint style="warning" %}
Use a dedicated service account for this step. Create a separate WEKA user with the CSI role assigned, rather than a personal admin account. If a personal account's password changes, storage stops working cluster-wide, and audit logs cannot distinguish operator actions from user actions.
{% endhint %}

<table><thead><tr><th width="183.484375">Field</th><th width="139.9453125">Requirement</th><th>Description</th></tr></thead><tbody><tr><td>WEKA Organization</td><td>Default: <code>Root</code></td><td>The WEKA organization the CSI user account belongs to. Leave as <code>Root</code> if the cluster does not use multi-tenancy, otherwise enter the organization name where the CSI service account was created.</td></tr><tr><td>WEKA Username</td><td>Required</td><td>The username of the WEKA CSI service account. The account must already exist in WEKA with the CSI role assigned.</td></tr><tr><td>WEKA Password</td><td>Required</td><td>The password for the WEKA CSI service account.</td></tr></tbody></table>

### Review and install

The final screen summarises every setting entered across the previous steps, with passwords masked. Review the endpoint addresses, version numbers, and networking mode, since these are the most common sources of installation errors.

Select **Install** to start a two-phase deployment with a live progress stream on the next screen.

<table><thead><tr><th width="269.08984375">Phase</th><th>Description</th></tr></thead><tbody><tr><td>Phase 1: WEKA integration</td><td>Installs the WEKA Kubernetes operator, deploys the CSI storage driver, sets up image pull secrets, launches the WEKA client DaemonSet on every worker node, and creates the storage classes Kubernetes uses to provision NeuralMesh-backed volumes.</td></tr><tr><td>Phase 2: Cluster initialization</td><td>Deploys the monitoring stack (Prometheus and Grafana), the NVIDIA NIM Operator for AI workloads, and the Envoy Gateway networking layer that routes external traffic to the App Store and other deployed applications. Phase 2 starts automatically once Phase 1 completes.</td></tr></tbody></table>

{% hint style="warning" %}
The live progress stream runs in the browser. Navigating away or refreshing the page loses the live view, though the installation continues in the background. Check pod status manually to track progress if this happens.
{% endhint %}

## Step 5: Monitor the installation

After selecting **Install**, the App Store shows a live progress screen with a row for every component being deployed. Each row updates in real time as the operator works through the installation sequence.

Most of the installation time is spent downloading container images to the nodes on the first install. On a standard internet connection, Phase 1 typically takes 10 to 20 minutes (up to 45 minutes on slow connections), and Phase 2 typically adds 5 to 10 minutes. Later installs on the same cluster complete faster, since most images are already cached on the nodes.

If a row shows a `Failed` status, check the operator log for the cause:

```bash
kubectl logs -n weka-app-store \
  -l app.kubernetes.io/name=weka-app-store-operator-chart \
  --tail=100
```

The log identifies which component failed and why. Common causes include incorrect endpoint addresses, version mismatches, image pull failures from incorrect Quay credentials, or network connectivity issues between the Kubernetes cluster and NeuralMesh.

## Step 6: Verify the installation

Once both phases complete, the App Store redirects to the main interface. Run the following checks to confirm everything is healthy.

Check that all pods are running:

```bash
kubectl get pods -n weka-operator-system   # WEKA Kubernetes operator
kubectl get pods -n csi-wekafs             # CSI storage driver
kubectl get pods -n monitoring             # Monitoring stack (Prometheus and Grafana)
```

All pods show `Running` or `Completed` status. Check a pod's events with `kubectl describe pod <name> -n <namespace>` if any are stuck in `Pending` or `CrashLoopBackOff`.

Check that the storage classes were created:

```bash
kubectl get storageclasses
```

Three WEKA storage classes are listed.

<table><thead><tr><th width="227.12890625">Storage class</th><th>Description</th></tr></thead><tbody><tr><td><code>wekafs-dir-api</code></td><td>The default storage class. Volumes are created as directories within a NeuralMesh filesystem. Deleting a Kubernetes PVC also deletes the data.</td></tr><tr><td><code>wekafs-dir-api-retain</code></td><td>The same as above, with a Retain reclaim policy. Data in NeuralMesh persists after the Kubernetes PVC is deleted. Use this for data that should outlive the workload's lifecycle.</td></tr><tr><td><code>wekafs-fs-api</code></td><td>Filesystem-backed volumes. Each volume gets a dedicated NeuralMesh filesystem instead of a directory within a shared filesystem, suited to workloads with filesystem-level isolation requirements.</td></tr></tbody></table>

The Kubernetes cluster is now connected to NeuralMesh storage. Open the App Store interface to deploy blueprints, including the WEKA AI Data Platform.
