---
description: >-
  Deploy WEKA on Kubernetes end-to-end: from environment preparation and
  operator installation through resource provisioning and post-deployment
  storage configuration.
---

# WEKA Operator full deployment workflow

**Workflow**

| Step | Task | Description |
| --- | --- | --- |
| 1 | [Obtain setup information](weka-operator-full-deployment-workflow.md#id-1.-obtain-setup-information) | Collect registry credentials and version tags. |
| 2 | [Prepare Kubernetes environment](weka-operator-full-deployment-workflow.md#id-2.-prepare-kubernetes-environment) | Configure control plane readiness, HugePages, Kubelet settings, image pull secrets, and failure domains. |
| 3 | [Install the WEKA Operator](weka-operator-full-deployment-workflow.md#id-3.-install-the-weka-operator) | Deploy the operator and set the required drive type configuration. |
| 4 | [Manage driver distribution](weka-operator-full-deployment-workflow.md#id-4.-manage-driver-distribution) | Select external or local driver distribution and apply the required policy. |
| 5 | [Discover and sign drives](weka-operator-full-deployment-workflow.md#id-5.-discover-and-sign-drives) | Detect available drives and apply the required signing policy. |
| 6 | [Provision WEKA resources](weka-operator-full-deployment-workflow.md#id-6.-provision-weka-resources) | Deploy the WekaCluster, create the optional client secret, and install the WekaClient when needed. |
| 7 | [Manage the WEKA cluster management proxy](weka-operator-full-deployment-workflow.md#id-7.-manage-the-weka-cluster-management-proxy) | Optionally expose WEKA management endpoints through an operator-managed Service and Ingress. |
| 8 | [Assign network space proxy subnets](weka-operator-full-deployment-workflow.md#id-8.-assign-network-space-proxy-subnets-for-multiple-weka-clusters) | Assign unique proxy subnets when multiple WEKA clusters share the same Kubernetes environment. |
| 9 | [Perform post-deployment storage configuration on WEKA client](weka-operator-full-deployment-workflow.md#id-9.-perform-post-deployment-storage-configuration-on-weka-client) | Configure CSI behavior and storage provisioning for WEKA clients. |

***

## 1. Obtain setup information

Identify and record the credentials required to pull WEKA container images and the specific version tags for your deployment.

#### Before you begin

Contact the WEKA Customer Success Team to receive your authorized registry credentials.

#### Procedure

1. Access [WEKA Operator page](https://get.weka.io/ui/operator) to identify the latest `WEKA_OPERATOR_VERSION` and `WEKA_IMAGE_VERSION_TAG`.
2. Record the following credentials for your image pull secret:
   * Registry: `quay.io`
   * QUAY\_USERNAME
   * QUAY\_PASSWORD
   * QUAY\_SECRET\_KEY: Typically `quay-io-robot-secret`.

{% hint style="info" %}
Replace all placeholders in your setup files with these values before proceeding.
{% endhint %}

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/get-weka-io_weka_operator_example.png" alt=""><figcaption><p>Example: WEKA Operator page on get.weka.io</p></figcaption></figure></div>

***

## 2. Prepare Kubernetes environment

Ensure the infrastructure meets the performance and resiliency requirements of the WEKA data plane. This step covers control plane configuration, node hardware and software requirements, HugePages, port requirements, and Kubelet CPU policy.

#### Control plane high availability

Configure the Kubernetes control plane for high availability to match WEKA resiliency. High availability depends on etcd quorum.

* **Quorum rule:** etcd requires an odd number of members (N) and tolerates failures up to (N-1)/2 failures.
* **Recommendation:** Use five or nine etcd members for production storage backends.

{% hint style="info" %}
Consider using an external etcd cluster or distributing control plane components across multiple failure domains. For more information, see the [Kubernetes HA topology guidance](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/ha-topology/).
{% endhint %}

#### Node hardware and software requirements

Verify that every node in the cluster meets these specifications:

* **Kubernetes version:** 1.25 or later (OpenShift 4.17 or later).
* **Storage allocation:** Reserve approximately 20 GiB per WEKA container plus 10 GiB per allocated CPU core in `/opt/k8s-weka`. Do not use NFS or network-attached storage.
* **Kernel headers:** Ensure kernel headers exactly match the running kernel version to allow driver compilation.

#### Configure HugePages for Kubernetes worker nodes

WEKA processes require dedicated HugePages memory. Configure HugePages on every worker node before deploying the WekaCluster. Nodes without HugePages configured will fail to schedule WEKA pods.

#### Memory allocation requirements

Use the following formula to calculate the required number of 2 MiB HugePages for your server:

```
Total GiB = (Server capacity GiB / Ratio + Cores for WEKA × 1.7) × 1.1
HugePages  = (Total GiB × 1024) / 2
```

Variables:

| Variable | Description |
| --- | --- |
| Server capacity | Total usable capacity of all drives assigned to WEKA on the server, measured in GiB. |
| Ratio | Controls the metadata memory component in the HugePages calculation. Server capacity is divided by this value, so a higher ratio allocates less memory to metadata, which reduces total HugePages consumption. The default is 1000. Set to 2000 to lower HugePages usage on servers where reduced metadata allocation is acceptable. |
| Cores for WEKA | Number of CPU cores allocated to the WEKA container on the server. |
| WEKA Container factor | Fixed HugePages allocation of 1.7 GiB for each WEKA container. |
| Headroom | Additional 10% buffer, expressed as 1.1, to account for memory fragmentation and operational variance. If you plan to run additional workloads that require HugePages, add their planned requirements on top of the calculated value. |

**Example calculation**

Server specifications:

* CPU cores: 64 total; 63 dedicated to WEKA.
* Storage: 16 drives × 15.3 TiB = 244.8 TiB usable (250,675 GiB).

Step 1: Calculate total GiB:

```
(250,675 / 1000 + 63 × 1.7) × 1.1 = 393.55 GiB
```

Step 2: Convert to MiB:

```
393.55 × 1024 = 402,998 MiB
```

Step 3: Calculate HugePages:

```
402,998 / 2 = 201,499 → round up to 201,500 HugePages
```

**Apply HugePages settings**

Before you begin:

* Identify the number of drives and CPU cores allocated to WEKA on the server.
* Ensure you have root or `sudo` permissions on the worker nodes.

Procedure:

1.  Check the current HugePages status on the server:

    ```bash
    grep Huge /proc/meminfo
    ```
2.  Apply the calculated HugePages value. Replace `<calculated-value>` with the value computed for your server:

    ```bash
    sudo sysctl -w vm.nr_hugepages=<calculated-value>
    ```
3.  Persist the setting to ensure it remains active after a reboot:

    ```bash
    sudo sh -c 'echo "vm.nr_hugepages = <calculated-value>" >> /etc/sysctl.conf'
    ```

#### Kubernetes port requirements

The WEKA Operator automatically allocates ports to prevent collisions in multi-cluster environments. Manual configuration is typically unnecessary unless specific infrastructure or policy requirements apply.

| Component | Default start port | Port range size |
| --- | --- | --- |
| WEKA Operator (v1.10+) / WEKA (v5.1.0+) | 35000 | 260 ports per cluster |
| WEKA Operator / WEKA (previous versions) | 35000 | 500 ports per cluster |
| WEKA client connectivity | 45000 | Maximum: 65535 |

**Reserve ports on each node**

To prevent the Linux kernel from assigning WEKA ports to other processes, add the following to `/etc/sysctl.d/99-weka.conf` on every node. For example:

```
net.ipv4.ip_local_reserved_ports = 35000-37600
```

The range 35000–37600 covers 2,600 ports, which supports up to 10 WekaCluster instances at 260 ports each. If you plan to deploy more than 10 clusters, extend the upper bound by 260 ports per additional cluster.

For full kernel parameter configuration, see [Set custom kernel parameters](../../planning-and-installation/bare-metal/setting-up-the-hosts/#configure-the-networking).

#### Configure Kubelet requirements

Enable the static CPU Manager policy on all worker nodes to give WEKA processes dedicated CPU cores. Without this, the Kubernetes scheduler can place other workloads on the same cores, causing contention and reducing I/O throughput.

On Kubernetes v1.32 and later, also enable `strict-cpu-reservation` to prevent Burstable and Best Effort pods from scheduling onto reserved cores.

For the full rationale, sibling-pair guidance, and version-specific reservation details, see [WEKA Operator best practices](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/kubernetes/weka-operator-deployments/weka-operator-best-practices).

**Before you begin: identify HyperThreading sibling cores**

On hyperthreaded systems, each physical core exposes two logical CPUs. Include both logical CPUs from the same physical core in `reservedSystemCPUs` to ensure full isolation. Reserving only one sibling of a physical core leaves that core shared.

Run the following commands to identify sibling pairs on the node:

```bash
lscpu -e=cpu,core,socket,node

cat /sys/devices/system/cpu/cpu*/topology/thread_siblings_list
```

Example output for a 12-logical-CPU, single-socket server with HyperThreading enabled:

```
CPU  CORE  SOCKET  NODE
0    0     0       0
1    1     0       0
2    2     0       0
3    3     0       0
4    4     0       0
5    5     0       0
6    0     0       0
7    1     0       0
8    2     0       0
9    3     0       0
10   4     0       0
11   5     0       0
```

In this example, there are 6 physical cores and 12 logical CPUs. CPUs that share the same\
`CORE` and `SOCKET` values are HyperThreading siblings:

| Physical core | Logical CPU (thread 0) | Logical CPU (thread 1, HT sibling) |
| --- | --- | --- |
| 0 | 0 | 6 |
| 1 | 1 | 7 |
| 2 | 2 | 8 |
| 3 | 3 | 9 |
| 4 | 4 | 10 |
| 5 | 5 | 11 |

The `thread_siblings_list` confirms these pairs directly:

```
/sys/devices/system/cpu/cpu0/topology/thread_siblings_list  → 0,6
/sys/devices/system/cpu/cpu1/topology/thread_siblings_list  → 1,7
... 
```

{% hint style="info" %}
Do not treat CPUs on different sockets with the same core index as siblings. Always verify pairs using `thread_siblings_list` rather than relying on the `CORE` column alone.
{% endhint %}

**Procedure**

1. Edit the Kubelet configuration file on each worker node and add the following settings. In this example, physical core 0 is reserved for the OS. `reservedSystemCPUs` includes both logical CPUs of that core (CPU 0 and its HT sibling, CPU 6):

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

Adjust `reservedSystemCPUs` to match the sibling pairs reported by `thread_siblings_list` on your node. Reserve at least one physical CPU (two sibling cores) for the Kubelet. Reserve additional physical cores, including both logical CPUs for each core, when OS or platform workloads require more capacity.

{% hint style="info" %}
Kubelet configuration methods vary by Kubernetes distribution. Some environments manage `KubeletConfiguration` centrally, while others require per-node file or bootstrap changes. Treat this example as the target Kubelet state and apply the equivalent settings by using the method your platform supports on every worker node that hosts WEKA processes.
{% endhint %}

{% hint style="info" %}
`CPUManagerPolicyAlphaOptions` and `strict-cpu-reservation` require Kubernetes v1.32 or later. Omit the `featureGates` and `cpuManagerPolicyOptions` blocks on earlier versions. Without strict reservation, Burstable and Best Effort pods can schedule onto reserved cores under load, reducing WEKA I/O throughput.
{% endhint %}

2. Save the file and restart the Kubelet:

```bash
systemctl restart kubelet
```

**Related information**

[Control CPU Management Policies on the Node](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/)

#### Configure image pull secrets

Set up Kubernetes secrets to enable secure image pulling from the WEKA container registry. These secrets must exist in every namespace where WEKA resources are deployed.

**Before you begin**

Identify your `QUAY_USERNAME`, `QUAY_PASSWORD`, and `QUAY_SECRET_KEY` from [step 1](weka-operator-full-deployment-workflow.md#id-1.-obtain-setup-information).

**Procedure**

1. Define the target namespaces and ensure they do not overlap to prevent configuration conflicts.
2. Create the secret in the `weka-operator-system` namespace. Repeat the same step in every namespace where you plan to create a WEKA CR. For example, if you deploy WEKA resources in the `default` namespace, create the secret there as well:

```bash
export QUAY_USERNAME='your_username'
export QUAY_PASSWORD='your_password'

kubectl create ns weka-operator-system

kubectl create secret docker-registry quay-io-robot-secret \
  --docker-server=quay.io \
  --docker-username=$QUAY_USERNAME \
  --docker-password=$QUAY_PASSWORD \
  --docker-email=$QUAY_USERNAME \
  --namespace=weka-operator-system

# Example workload namespace: default
kubectl create secret docker-registry quay-io-robot-secret \
  --docker-server=quay.io \
  --docker-username=$QUAY_USERNAME \
  --docker-password=$QUAY_PASSWORD \
  --docker-email=$QUAY_USERNAME \
  --namespace=default
```

#### Configure failure domains

Group backend nodes into failure domains to ensure high availability and data protection. A failure domain represents a set of processes that share a common physical risk, such as a rack, power circuit, or network switch.

The system distributes data and parity blocks from the same stripe across different failure domains. If an entire failure domain fails, the cluster reconstructs the missing data from the remaining domains.

**Select a failure domain mode**

| Mode | Function | Usage |
| --- | --- | --- |
| Implicit (default) | Assigns every process as its own independent failure domain. | Deployments where infrastructure shared risks cannot be identified by Kubernetes node labels. |
| Explicit | Groups processes into named domains based on physical node labels. | Deployments where containers share a rack, switch, or power source. |

{% hint style="info" %}
Prefer explicit mode when Kubernetes node labels can represent shared infrastructure boundaries. Explicit mode provides better failure protection by separating processes across known physical domains such as racks, power feeds, or switches. To use it, ensure the required topology labels are present on the nodes.
{% endhint %}

**Determine stripe width and domain count**

Coordinate the number of failure domains with the stripe width and protection level during cluster formation. Stripe width and protection levels are permanent once set.

Constraint to prevent data loss: blocks lost during a failure domain failure = stripe width / number of failure domains. This value must not exceed the parity block count (P).

Minimum healthy server requirements:

| Stripe configuration | Minimum healthy server |
| -------------------- | ---------------------- |
| 5+2                  | 4                      |
| 16+ 2                | 9                      |
| 5+4                  | 3                      |
| 16+4                 | 5                      |

**Map a single node label**

1.  Label every backend node with a physical grouping value:

    ```bash
    kubectl label nodes <node-name> weka.io/failure-domain=<rack-id>
    ```
2.  Configure the `failureDomain` field in the `WekaCluster` CR:

    ```yaml
    spec:
      failureDomain:
        label: "weka.io/failure-domain"
        skew: 1
    ```

    * `label`: The node label key identifying the failure domain.
    * `skew`: The permitted difference in container count between domains.

**Use composite topology labels**

Combine existing Kubernetes topology labels, such as zone and rack, into a compound failure domain identity.

**Procedure**

1.  Identify the existing labels on your nodes:

    ```bash
    kubectl get nodes --show-labels
    ```
2.  Add the `compositeLabels` list to the `WekaCluster` CR:

    ```yaml
    spec:
      failureDomain:
        compositeLabels:
          - "topology.kubernetes.io/zone"
          - "rack"
    ```

    The operator combines these values. For example, a node in zone `us-east-1a` on `rack-1` becomes failure domain `us-east-1a/rack-1`.

**Verify the configuration**

Confirm the distribution of containers across the defined domains.

**Procedure**

1.  Apply the CR changes:

    ```bash
    kubectl apply -f wekacluster.yaml
    ```
2.  Check the container status:

    ```bash
    weka cluster container
    ```
3. Verify that the `FAILURE DOMAIN` column displays your custom label values instead of `AUTO`.

***

## 3. Install the WEKA Operator

Manage the lifecycle of WEKA resources by installing the WEKA Operator. This process involves applying Custom Resource Definitions (CRDs) and deploying the operator controller with specific configurations for the Container Storage Interface (CSI) and drive types.

#### Before you begin

* Ensure the `QUAY_SECRET_KEY` is created in the `weka-operator-system` namespace (completed in [step 2](weka-operator-full-deployment-workflow.md#id-2.-prepare-kubernetes-environment)).
*   Install Helm on a local server, unless using a higher-level deployment tool such as Argo CD:

    ```bash
    curl -fsSL -o get_helm.sh \
      https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
      chmod 700 get_helm.sh && ./get_helm.sh
    ```
* Confirm `kubectl` is installed and configured against the target cluster.
*   Identify your deployment configuration before running the Helm command:

    | Condition | Required flag |
| --- | --- |
| Operator v1.7.0 and later | `--set csi.installationEnabled=true` |
| Operator v1.10 and later with AlloyFlash | `--set driveSharing.driveTypesRatio='{tlc: 9, qlc: 1}'` |
| Operator v1.10 and later with single drive type | `--set driveSharing.driveTypesRatio='{qlc: 0}'` |

#### Procedure

1. Download and apply the CRDs so the Kubernetes API can recognize WEKA resources. Replace `<WEKA_OPERATOR_VERSION>` with your version:

```bash
helm pull oci://quay.io/weka.io/helm/weka-operator \
  --untar --version <WEKA_OPERATOR_VERSION>
kubectl apply -f weka-operator/crds
```

2. Deploy the WEKA Operator using the Helm flags that match your configuration. The following examples show the two most common layouts:

**Mixed flash configuration** (AlloyFlash<sup>TM</sup>)**:**

```bash
helm upgrade --create-namespace \
  --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version <WEKA_OPERATOR_VERSION> \
  --set csi.installationEnabled=true \
  --set driveSharing.driveTypesRatio='{tlc: 9, qlc: 1}'
```

This setting allocates 9/10 capacity to TLC and 1/10 to QLC.

**Single drive type**:

```bash
helm upgrade --create-namespace \
    --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
    --namespace weka-operator-system \
    --version <WEKA_OPERATOR_VERSION> \
    --set csi.installationEnabled=true \
    --set driveSharing.driveTypesRatio='{qlc: 0}'
```

This setting configures a single drive type and disables Hybrid Flash.

3. Verify the installation. The `weka-operator-controller-manager` pod must show `Running` status:

```bash
kubectl -n weka-operator-system get pod
```

Expected output:

```bash
NAME                                                  READY   STATUS    RESTARTS   AGE
weka-operator-controller-manager-564bfd6b49-p6k7d    2/2     Running   0          13s
```

If the pod does not reach `Running` state, see [Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md).

***

## 4. Manage driver distribution

If outbound access to `drivers.weka.io` is available, use the pre-built driver service. Configure driver distribution only when you need a local build and distribution path for client and backend processes.

**Choose a distribution method**

| Condition | Method |
| --- | --- |
| Standard Linux distribution with supported kernel, outbound access to `drivers.weka.io` | Pre-built drivers (recommended): No build infrastructure required. By default, the drivers are pulled from `https://drivers.weka.io`. |
| Air-gapped environment, custom or patched kernel, or no external network access | Local driver builder: Configure driver distribution policy. |

For architectural details on how driver distribution works, see [WEKA Operator driver management](weka-operator-driver-management.md).

#### Before you begin

* Ensure a WEKA-compatible image (`weka-in-container`) and a valid `imagePullSecret` are accessible.
* Confirm that builder container versions match the target WEKA version.
* For local distribution: ensure kernel headers matching the running kernel are installed on the build server. On Ubuntu, install `linux-headers-$(uname -r)`. On Rocky Linux, install `kernel-devel-$(uname -r)` and `kernel-headers-$(uname -r)`. Also confirm port 60002 is open for communication between the operator, Drivers-Builder, Drivers-Dist, and Drivers-Loader.

**Local driver distribution components**

When using a local builder, the operator deploys three components:

* **Drivers-Builder:** Compiles the kernel module for specific WEKA and kernel version combinations.
* **Drivers-Dist:** An internal HTTP server that stores and serves compiled driver packages.
* **Service:** A Kubernetes Service that exposes Drivers-Dist at a stable internal endpoint.

{% hint style="info" %}
When configuring driver distribution manually, the following elements must be preserved exactly as shown in the configuration examples: ports, network modes, core configurations, and `spec.name`.
{% endhint %}

**Procedure**

1. Define node selection using a `nodeSelector` to identify target Kubernetes nodes that require the driver.
2. Apply a WekaPolicy to deploy the driver distribution service. Use the example that matches your environment:

<details>

<summary>Example 1: Minimal policy (recommended for most deployments)</summary>

{% code title="weka-drivers.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaPolicy
metadata:
  name: weka-drivers
  namespace: weka-operator-system
spec:
  type: enable-local-drivers-distribution
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
```
{% endcode %}

</details>

<details>

<summary>Example 2: Manual deployment of distribution and builder containers</summary>

Use this example only when direct resource control is required instead of a WekaPolicy:

{% code title="weka-drivers.yaml" overflow="wrap" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaContainer
metadata:
  name: weka-drivers-dist
  namespace: weka-operator-system
  labels:
    app: weka-drivers-dist
spec:
  agentPort: 60001
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
  mode: "drivers-dist"
  name: dist
  numCores: 1
  port: 60002
---
apiVersion: v1
kind: Service
metadata:
  name: weka-drivers-dist
  namespace: weka-operator-system
spec:
  type: ClusterIP
  ports:
    - name: weka-drivers-dist
      port: 60002
      targetPort: 60002
  selector:
    app: weka-drivers-dist
---
apiVersion: weka.weka.io/v1alpha1
kind: WekaContainer
metadata:
  name: weka-drivers-builder-157
  namespace: weka-operator-system
spec:
  agentPort: 60001
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
  mode: "drivers-builder"
  name: dist
  numCores: 1
  uploadResultsTo: "weka-drivers-dist"
  port: 60002
  nodeSelector:
    weka.io/supports-backends: "true"
---
apiVersion: weka.weka.io/v1alpha1
kind: WekaContainer
metadata:
  name: weka-drivers-builder-157-ubuntu-1
  namespace: weka-operator-system
spec:
  agentPort: 60001
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
  mode: "drivers-builder"
  name: dist
  numCores: 1
  uploadResultsTo: "weka-drivers-dist"
  port: 60002
  nodeSelector:
    weka.io/supports-backends: "true"
    weka.io/kernel: "6.5.0-45-generic"
  overrides:
    preRunScript: "apt-get update && apt-get install -y gcc-12"
```
{% endcode %}

On Rocky Linux, replace the `preRunScript` value with `dnf install -y gcc`.

</details>

<details>

<summary>Example 3: WekaPolicy with proactive driver pre-building</summary>

Use this example when you need to pre-build drivers for specific images beyond those detected from existing WekaCluster and WekaClient resources:

**Ubuntu**

{% code title="weka-drivers.yaml" overflow="wrap" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaPolicy
metadata:
  name: weka-drivers
  namespace: weka-operator-system
spec:
  type: "enable-local-drivers-distribution"
  image: "quay.io/weka.io/weka-in-container:5.1.0"
  imagePullSecret: "quay-io-robot-secret"
  tolerations:
    - key: "example-key"
      operator: "Exists"
      effect: "NoSchedule"
  payload:
    interval: "1m"
    driverDistPayload:
      ensureImages:
        - "quay.io/weka.io/weka-in-container:5.1.0"
      nodeSelectors:
        - role: "worker-nodes"
          environment: "production"
        - custom-label: "drivers-build-pool"
      builderPreRunScript: |
        #!/bin/sh
        apt-get update && apt-get install -y gcc-12
```
{% endcode %}

**Rocky Linux**

{% code title="weka-drivers.yaml" overflow="wrap" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaPolicy
metadata:
  name: weka-drivers
  namespace: weka-operator-system
spec:
  type: "enable-local-drivers-distribution"
  image: "quay.io/weka.io/weka-in-container:5.1.0"
  imagePullSecret: "quay-io-robot-secret"
  tolerations:
    - key: "example-key"
      operator: "Exists"
      effect: "NoSchedule"
  payload:
    interval: "1m"
    driverDistPayload:
      ensureImages:
        - "quay.io/weka.io/weka-in-container:5.1.0"
      nodeSelectors:
        - role: "worker-nodes"
          environment: "production"
        - custom-label: "drivers-build-pool"
      builderPreRunScript: |
        #!/bin/sh
        dnf install -y gcc
```
{% endcode %}

</details>

3. Install a compiler in the builder container.
   1. The driver builder compiles kernel modules in the builder container. Install a compiler that matches the node kernel requirements.
   2. Add `builderPreRunScript` to the `WekaPolicy` specification:

```yaml
payload:
  driverDistPayload:
    builderPreRunScript: "apt-get update && apt-get install -y gcc-12"
```

For RPM-based builder images (for example, Rocky Linux):

```yaml
payload:
  driverDistPayload:
    builderPreRunScript: "dnf install -y gcc"
```

{% hint style="info" %}
* Ubuntu 22.04 with kernel 6.5 or later requires `gcc-12`.
* Ubuntu 24.04 typically requires `gcc-13`.
* Alternatively, install `gcc` and kernel headers with `apt-get install -y gcc linux-headers-$(uname -r)`.
{% endhint %}

**WekaPolicy additional attributes**

{% hint style="info" %}
Review the [WekaPolicy API reference](https://weka.github.io/weka-k8s-api/wekapolicy/) for all available resource options.
{% endhint %}

| Attribute | Description |
| --- | --- |
| `image` | The WEKA container image used for the distributor and default builder. |
| `interval` | How often the operator reconciles the policy. Default: `1m`. |
| `builderPreRunScript` | Optional script to run before the build, for example to install a compiler. |
| `ensureNICsPayload` | Defines the configuration for ensuring a specific number of data NICs on selected nodes. |
| `signDrivesPayload` | Configures parameters to scan and sign drives for WEKA backend containers. |

4. Apply the configuration:

```bash
kubectl apply -f weka-drivers.yaml
```

***

## 5. Discover and sign drives

Identify and prepare physical storage devices before provisioning the WEKA cluster.

**How drive discovery works**

When a drive discovery operation runs, the operator performs three actions on each node:

* Annotates the node with a list of known serial IDs for all accessible drives.
* Creates the extended resource `weka.io/drives` on the node to indicate the count of ready drives.
* Marks only healthy, unblocked drives as available. Drives with errors or manual blocks are excluded.

**Choose a discovery method**

| Method | Use case |
| --- | --- |
| `WekaManualOperation` | One-time action for initial manual provisioning. |
| `WekaPolicy` | Automated periodic discovery. Initiates immediately when it detects node updates or hardware additions. Recommended for production. |

**Understand the shared field**

The `shared` field in the `signDrivesPayload` controls whether SSD Proxy is enabled on the signed drives.

{% tabs %}
{% tab title="shared: false (default)" %}
Whole drives are assigned directly to WEKA processes. This is the simpler configuration and suits deployments where clusters are large enough to use full drives.

Consider `false` when:

* You intend to assign complete drives to one or more WekaCluster CRs.
* Your clusters are consistently active and you want to avoid sharing drive workload across tenants.

{% hint style="info" %}
Running multiple WekaCluster CRs on the same hardware does not require drive sharing. With 6 drives available, you can assign each drive to a separate WekaCluster without enabling `shared`.
{% endhint %}
{% endtab %}

{% tab title="shared: true" %}
Enables SSD Proxy, which introduces a layer between WEKA processes and the physical drives. This enables two capabilities:

* **Drive slicing:** A single physical drive can be divided into logical slices, each used by a different WekaCluster. This is useful when clusters are smaller and do not need full drives.
* **Higher aggregate throughput:** When clusters are not all fully loaded at the same time, drive sharing increases the number of drives used in parallel, which can improve overall performance. If clusters are consistently active simultaneously, drive workload is shared across tenants.

{% hint style="info" %}
SSD Proxy enables allocating multiple CPU cores per physical drive.
{% endhint %}

For details on SSD Proxy operation and resource requirements,, see [Drive sharing](../../operation-guide/drives-sharing.md).
{% endtab %}
{% endtabs %}

#### Procedure

{% hint style="info" %}
Review the [WekaPolicy API reference](https://weka.github.io/weka-k8s-api/wekapolicy/) for all available resource options.
{% endhint %}

1. **Define drive sharing and signing:** Apply a WekaPolicy to sign compatible drives.

{% code title="sign-drives.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaPolicy
metadata:
  name: sign-drives
  namespace: weka-operator-system
spec:
  type: sign-drives
  payload:
    signDrivesPayload:
      type: "all-not-root"
      ##shared: true # To support drive slicing or higher per-drive throughput through SSD Proxy. See the Understand the shared field section above.
```
{% endcode %}

| Name | Description |
| --- | --- |
| `all-not-root` | Signs all detected block devices except the root device. |
| `aws-all` | Detects NVMe devices using AWS PCI identifiers. |
| `device-paths` | Targets specific device paths listed in the manifest. |

## 6. Provision WEKA resources

Deploy the WekaCluster and WekaClient Custom Resources to provision the backend storage and connect your Kubernetes nodes.

{% hint style="info" %}
Run cluster-level WEKA CLI commands from Compute or Drive pods only. Do not run WEKA CLI commands inside WekaClient pods or application client pods.
{% endhint %}

Perform these steps in sequence:

1. Install the WekaCluster CR.
2. Create the WEKA cluster client secret (only required if WekaCluster and WekaClient are not deployed on the same Kubernetes cluster)
3. Install the WekaClient CR.

### 6.1. Install the WekaCluster CR

Provision the WEKA cluster backend using the WekaCluster CR. This resource defines the storage containers, drive configurations, and networking for the cluster.

{% hint style="info" %}
Review the [WekaCluster API reference](https://weka.github.io/weka-k8s-api/wekacluster/) for all available resource options.
{% endhint %}

#### Before you begin

* Verify that drives are signed and discovered ([step 5](weka-operator-full-deployment-workflow.md#id-5.-discover-and-sign-drives)).
* Verify the driver distribution service is accessible. WEKA recommends the external service at `https://drivers.weka.io`.
* If you set `shared: true` when signing drives, select a sizing method for the dynamic template:
  * `clusterCapacity`: Sets the target usable capacity for the whole cluster. The operator derives the container and drive layout automatically.
  * `containerCapacity`: Sets the capacity per drive container. Required when `shared: true` is set and `clusterCapacity` is not set.
  * `numDrives`: Assigns whole drives per drive container. Applies when `shared: false` is set. Optional, defaults to `1`.

#### Procedure

1. Create `weka-cluster.yaml`:

<details>

<summary>Example: weka-cluster.yaml</summary>

{% code title="weka-cluster.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  name: weka-cluster-dev
  namespace: default
spec:
  template: dynamic
  dynamicTemplate:
    computeContainers: 6
    driveContainers: 6
    ##containerCapacity: 1000   # Use instead of numDrives when shared: true is set in sign-drive
    ##     clusterCapacity: "300TiB" # Target usable capacity for the whole cluster - operator 1.14.2 
  image: quay.io/weka.io/weka-in-container:5.1.0
  nodeSelector:
    weka.io/supports-backends: "true"
  driversDistService: "https://drivers.weka.io"
  imagePullSecret: "quay-io-robot-secret"
  
```
{% endcode %}

</details>

2. If your cluster requires settings that cannot be applied through standard configuration, for example overriding the default bucket count on a small or non-standard cluster, set `spec.overrides.postFormClusterScript` in the manifest before applying it. The operator runs this script once, after the cluster forms and before `start-io`. Use it only when no standard configuration option achieves the required result:

<details>

<summary>Example: postFormClusterScript override</summary>

{% code title="weka-cluster.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  name: weka-cluster-dev
spec:
  overrides:
    postFormClusterScript: |
      weka debug jrpc cluster_configure_internal buckets_number=280
```
{% endcode %}

</details>

To inspect the field definition, run:

```bash
kubectl explain wekacluster.spec.overrides.postFormClusterScript
```

{% hint style="info" %}
`postFormClusterScript` runs privileged debug commands on a cluster that is not yet serving I/O. Validate the script on a non-production cluster before applying it to production.
{% endhint %}

4. Apply the manifest:

```bash
kubectl apply -f weka-cluster.yaml
```

**Related information**

[WekaClusterSpec](https://weka.github.io/weka-k8s-api/wekacluster/)

### 6.2. Create the WEKA cluster client secret

Create a Kubernetes Secret that stores the credentials WekaClient uses to join the WEKA cluster. This is required only when WekaClient and WekaCluster are not deployed in the same Kubernetes cluster.

#### Before you begin

Obtain the `org`, `join-secret`, `password`, and `username` from your WEKA backend.

#### Procedure

1. Encode each credential value to **base64**.

{% code overflow="wrap" %}
```bash
echo -n 'my_password' | base64
```
{% endcode %}

2. Create `secret.yaml`:

<details>

<summary>Example: secret.yaml</summary>

{% code title="secret.yaml" %}
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: weka-cluster-dev
  namespace: weka-operator-system
type: Opaque
data:
  org: <base64-encoded-org>
  join-secret: <base64-encoded-join-secret>
  password: <base64-encoded-password>
  username: <base64-encoded-username>
```
{% endcode %}

</details>

3. Apply the secret:

```bash
kubectl apply -f secret.yaml
```

### 6.3. Install the WekaClient CR

If you need WEKA clients on Kubernetes, deploy the WekaClient CR on the designated Kubernetes nodes. WekaClient works like a DaemonSet and provisions one pod per selected node to provide a persistent WEKA data plane for your workloads.

{% hint style="info" %}
Review the [WekaClient API reference](https://weka.github.io/weka-k8s-api/wekaclient/) for all available resource options.
{% endhint %}

#### Before you begin

* Label every worker node intended to host WEKA client pods:

```bash
kubectl label nodes <node-name> <label>
```

Example:

```bash
kubectl label nodes <node-name> weka.io/supports-clients=true
```

{% hint style="info" %}
Ensure the label matches the `nodeSelector` property in the WekaClient CR.
{% endhint %}

* Verify that the Kubernetes Secret (for example, `weka-cluster-dev`) exists in the `weka-operator-system` namespace and contains base64-encoded cluster credentials (`org`, `join-secret`, `password`, and `username`).
* Identify whether you are using the external driver distribution service (`https://drivers.weka.io`) or a local service endpoint.

#### Procedure

1. Create `weka-client.yaml` using the connection type that matches your environment:

<details>

<summary>Example: Internal cluster connection (WekaCluster and WekaClient in the same Kubernetes cluster)</summary>

{% code title="weka-client.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaClient
metadata:
  name: cluster-dev-clients
spec:
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
  driversDistService: "https://weka-drivers-dist.weka-operator-system.svc.cluster.local:60002"
  portRange:
    basePort: 46000
  nodeSelector:
    weka.io/supports-clients: "true"
  wekaSecretRef: weka-cluster-dev
  targetCluster:
    name: weka-cluster-dev
    namespace: default
```
{% endcode %}

</details>

<details>

<summary>Example: External cluster connection (WEKA cluster running outside Kubernetes)</summary>

{% code title="weka-client.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaClient
metadata:
  name: cluster-dev-clients
spec:
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
  driversDistService: "https://drivers.weka.io"
  portRange:
    basePort: 46000
  nodeSelector:
    weka.io/supports-clients: "true"
  wekaSecretRef: weka-cluster-dev
  joinIpPorts: ["10.0.2.137:16101"]
  network:
    ethDevice: mlnx0
```
{% endcode %}

</details>

3. Apply the manifest.

```bash
kubectl apply -f weka-client.yaml
```

<details>

<summary><strong>WekaClient parameters reference</strong></summary>

For the full list of configurable fields, see [WekaClient parameters](https://weka.github.io/weka-k8s-api/wekaclient/).

| Name | Description | Default |
| --- | --- | --- |
| `image` | The WEKA container image version to deploy. | — |
| `imagePullSecret` | Secret name used to authenticate with the image registry. | — |
| `port` | Defines a range of 100 ports for the container. | Dynamic |
| `agentPort` | Specifies a single port used by the agent process. | Dynamic |
| `portRange` | Defines a `basePort` for automatic port allocation. | — |
| `nodeSelector` | Selects the nodes where WEKA containers are scheduled. | — |
| `network` | Network configuration map. Sub-keys: `ethDevice` (single device), `ethDevices` (multiple devices), and `udpMode` (true/false). Defaults to UDP mode when not set. | UDP |
| `driversDistService` | URL for the driver distribution service. | — |
| `targetCluster` | Name and namespace of the WekaCluster CR to connect to. Applies when the WekaCluster runs in the same Kubernetes cluster. | — |
| `joinIpPorts` | IP addresses used to join a cluster outside the local environment. | — |
| `wekaSecretRef` | Reference to the Kubernetes Secret containing cluster credentials. | — |
| `coresNum` | Number of physical CPU cores to allocate to each container. | 1 |
| `cpuPolicy` | Defines core allocation behavior: `auto`, `manual`, `shared`, `dedicated` or `dedicated_ht` | `auto` |
| `upgradePolicy` | Sets the upgrade strategy: `rolling`, `manual`, or `all-at-once`. | `rolling` |
| `gracefulDestroyDuration` | Pause duration for local data and drive allocations during pod deletion. | 24h |

</details>

***

## 7. Manage the WEKA cluster management proxy

Optionally - access WEKA management endpoints through an operator-managed Service, and optionally expose them outside the Kubernetes cluster using a Kubernetes Ingress.

**Required infrastructure**

WEKA does not install or configure the following components. These remain the responsibility of the platform administrator:

| Component | Purpose |
| --- | --- |
| Ingress controller | Manages incoming traffic, for example NGINX or Traefik. |
| External connectivity | A load balancer or equivalent mechanism to route traffic from outside the cluster. |
| DNS resolution | Configured hostnames that resolve to the Ingress controller's external IP. |
| TLS termination | Optional platform-managed certificate management for secure HTTPS communication. |

**Ingress configuration**

WEKA simplifies basic setups by managing Ingress configuration through a single `ingressClass` setting. For advanced or customized networking scenarios, wrap or modify the service using standard Kubernetes Ingress resources.

***

## 8. Assign network space proxy subnets for multiple WEKA clusters

Optionally, allocate a unique proxy subnet to each WEKA cluster when you deploy more than one WekaCluster on the same Kubernetes environment. Each WEKA cluster uses an internal proxy subnet for its network space. When two clusters share the same subnet, their address ranges overlap and cause routing conflicts.

Assign a non-overlapping subnet to every WEKA cluster so that each cluster keeps a dedicated address range and isolates its traffic from other tenants on the same Kubernetes nodes.

### Before you begin

* Deploy the WEKA Operator on the target Kubernetes environment.
* Identify every WEKA cluster already deployed on the same Kubernetes environment.

{% hint style="info" %}
**Important:** Assign a unique proxy subnet to each WEKA cluster on the same Kubernetes environment. This prevents overlapping address ranges and routing conflicts when you deploy additional clusters.
{% endhint %}

### Procedure

1.  Record the proxy subnets already assigned to the existing WEKA clusters:

    ```
    weka cluster network-space proxy subnet
    ```
2. For each new WEKA cluster, choose a subnet in CIDR notation that no other WEKA cluster on the same Kubernetes environment uses.
3.  Assign the subnet to the WEKA cluster:

    ```
    weka cluster network-space proxy subnet set 10.1.0.0   ## WekaCluster_A
    weka cluster network-space proxy subnet set 10.2.0.0   ## WekaCluster_B
    weka cluster network-space proxy subnet set 10.3.0.0   ## WekaCluster_C
    ```
4.  Confirm the assignment by listing the proxy subnets again and verifying that each WEKA cluster holds a distinct range:

    ```
    weka cluster network-space proxy subnet
    ```

***

## 9. Perform post-deployment storage configuration on WEKA client

If your deployment includes a WEKA client on Kubernetes and embedded CSI is enabled, configure the CSI plugin and storage classes based on your operator version to enable persistent volume provisioning.

| Operator version | Behavior | Required action |
| --- | --- | --- |
| v1.7.0 and later | Embedded CSI is supported. When embedded CSI is enabled during operator installation, the operator configures the CSI plugin and StorageClass automatically. | Proceed to create a Persistent Volume Claim (PVC).See dynamic-and-static-provisioning.md. |
| v1.6.2 and earlier | Embedded CSI is not available. CSI requires manual installation. | See weka-csi-plugin. |

{% hint style="info" %}
For v1.7.0 and later, when embedded CSI installation is enabled, the operator creates storage classes following the pattern `weka-<groupName>-<fsName>`. To disable automatic storage class creation, set `csi.storageClassCreationDisabled: true` in your Helm values.
{% endhint %}
