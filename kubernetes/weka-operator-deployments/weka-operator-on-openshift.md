---
description: >-
  Deploy WEKA on OpenShift end-to-end: from environment preparation and operator
  installation through resource provisioning and post-deployment storage
  configuration.
---

# Deploy WEKA Operator on OpenShift

**Workflow**

<table><thead><tr><th width="80">Step</th><th width="272">Task</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><a href="weka-operator-on-openshift.md#id-1.-obtain-setup-information">Obtain setup information</a></td><td>Collect registry credentials and version tags.</td></tr><tr><td>2</td><td><a href="weka-operator-on-openshift.md#id-2.-prepare-openshift-environment">Prepare OpenShift environment</a></td><td>Configure node requirements, HugePages, ports, Kubelet settings, image pull secrets, and failure domains.</td></tr><tr><td>3</td><td><a href="weka-operator-on-openshift.md#id-3.-install-weka-operator">Install WEKA Operator</a></td><td>Deploy the operator and set the required drive type configuration.</td></tr><tr><td>4</td><td><a href="weka-operator-on-openshift.md#id-4.-sign-and-discover-storage-drives">Sign and discover storage drives</a></td><td>Detect available drives and apply the required signing policy.</td></tr><tr><td>5</td><td><a href="weka-operator-on-openshift.md#id-5.-provision-weka-resources">Provision WEKA resources</a></td><td>Deploy the WekaCluster, create the optional client secret, and install the WekaClient when needed.</td></tr><tr><td>6</td><td><a href="weka-operator-on-openshift.md#id-6.-manage-the-weka-cluster-management-proxy">Manage the WEKA cluster management proxy</a></td><td>Optionally expose WEKA management endpoints through an operator-managed Service and Ingress.</td></tr><tr><td>7</td><td><a href="weka-operator-on-openshift.md#id-7.-assign-network-space-proxy-subnets-for-multiple-weka-clusters">Assign network space proxy subnets</a></td><td>Assign unique proxy subnets when multiple WEKA clusters share the same Kubernetes environment.</td></tr><tr><td>8</td><td><a href="weka-operator-on-openshift.md#id-8.-perform-post-deployment-storage-configuration-on-weka-client">Perform post-deployment storage configuration on WEKA client</a></td><td>Configure CSI behavior and storage provisioning for WEKA clients.</td></tr></tbody></table>

***

## OpenShift-specific requirements

OpenShift deployments require the following platform-specific configuration:

* **Node configuration:** Configure node settings with `Tuned`, `MachineConfig`, and `KubeletConfig` resources.
* **Privileged SCC:** Grant the `privileged` security context constraint to the operator service accounts before signing drives.
* **Pre-built drivers:** Allow access to [https://drivers.weka.io](https://drivers.weka.io/) to download pre-built storage drivers.
* **UDP networking:** Set `spec.network.udpMode: true` in WekaCluster and WekaClient resources.

## 1. Obtain setup information

Obtain necessary pre-requisite access credentials for downloading required container images.

**Related topic**

[weka-operator-full-deployment-workflow.md](weka-operator-full-deployment-workflow.md "mention")

## 2. Prepare OpenShift environment

### Node hardware and software requirements

Verify that every node in the cluster meets these specifications:

* **OpenShift version:** OpenShift 4.17 or later.
* **Storage allocation:** Reserve approximately 20 GiB per WEKA container plus 10 GiB per allocated CPU core in `/opt/k8s-weka`. Do not use NFS or network-attached storage.

### Configure HugePages for OpenShift nodes

WEKA processes require dedicated HugePages memory. Configure HugePages on every worker node before deploying the WekaCluster. Nodes without HugePages configured will fail to schedule WEKA pods.

**Related topic**

[Configure HugePages for Kubernetes worker nodes](weka-operator-full-deployment-workflow.md#configure-hugepages-for-kubernetes-worker-nodes) (calculate the required number of HugePages)

#### Apply HugePages settings using MachineConfigs

**Before you begin**

* Identify the number of drives and CPU cores allocated to WEKA on the server.
* Ensure you have command-line access to the OpenShift cluster.

**Procedure**

1. Label all desired nodes.

```shellscript
##Label all worker nodes that must have hugepages updated
oc label node -l node-role.kubernetes.io/worker hugepages-enabled=true

##Confirm label was applied to nodes
oc get nodes -L hugepages-enabled
NAME                           STATUS   ROLES                  AGE   VERSION   HUGEPAGES-ENABLED
ip-10-0-11-199.ec2.internal    Ready    worker                 46m   v1.35.8   true
ip-10-0-113-116.ec2.internal   Ready    control-plane,worker   53m   v1.35.8   true
ip-10-0-121-188.ec2.internal   Ready    control-plane,worker   53m   v1.35.8   true
ip-10-0-2-235.ec2.internal     Ready    worker                 47m   v1.35.8   true
ip-10-0-32-182.ec2.internal    Ready    worker                 39m   v1.35.8   true
ip-10-0-76-216.ec2.internal    Ready    control-plane,worker   53m   v1.35.8   true
```

2. Create a `Tuned` configuration, as shown below. Set `<numHugePages>` to required number of hugePages. In this example, 15000 is used.

```bash
## Tuned configuration that updates hugePages on desired targets
cat hugepages-tuned.yaml
apiVersion: tuned.openshift.io/v1
kind: Tuned
metadata:
  name: hugepages-signaling
  namespace: openshift-cluster-node-tuning-operator
spec:
  profile:
  - data: |
      [main]
      summary=Boot-time hugepages configuration
      include=openshift-node
      [bootloader]
      cmdline_openshift_node_hugepages=hugepagesz=2M hugepages=<numHugePages> ##Set desired number of hugePages and hugePage size
    name: node-hugepages
  recommend:
  - machineConfigLabels:
      machineconfiguration.openshift.io/role: "worker-hp"
    priority: 10
    profile: openshift-node-hugepages
    
# Create hugePages tuned object
oc create -f hugepages-tuned.yaml
tuned.tuned.openshift.io/hugepages-signaling created
```

3. Create `MachineConfigPools` that tells Machine Config Operator the targets to run against.

<pre class="language-bash"><code class="lang-bash"><strong>cat hugepages-worker-mcp.yaml
</strong>apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfigPool
metadata:
  name: worker-hp
  labels:
    hugepages-enabled: "true"
spec:
  machineConfigSelector:
    matchExpressions: ##Target all worker nodes.
      - {key: machineconfiguration.openshift.io/role, operator: In, values: [worker]}
  nodeSelector:
    matchLabels: ##Only run on nodes that have label below defined.
      hugepages-enabled: "true"

oc create -f hugepages-worker-mcp.yaml
machineconfigpool.machineconfiguration.openshift.io/worker-hp created
</code></pre>

4. Check the status of newly created `MachineConfigPool` to monitor progress of hugepages rollout.

<pre class="language-bash"><code class="lang-bash"><strong>oc get machineconfigpools
</strong>NAME        CONFIG                                                UPDATED   UPDATING   DEGRADED   MACHINECOUNT   READYMACHINECOUNT   UPDATEDMACHINECOUNT   DEGRADEDMACHINECOUNT   AGE
master      rendered-master-bc3823de2ae2928d31d93fd071529027      True      False      False      3              3                   3                     0                      52m
worker      rendered-worker-225167a69748153a2c95c88ef123b8ae      True      False      False      0              0                   0                     0                      52m
worker-hp   rendered-worker-hp-a4634358e312ffe1e9d490252a08b765   True      False      False      3              3                   3                     0                      10m
</code></pre>

The last entry indicates the configuration was rolled out successfully against 3 worker nodes.

5. Confirm hugepages allocation by describing desired nodes.

```bash
oc get node ip-10-0-2-235.ec2.internal -o jsonpath="{.status.allocatable.hugepages-2Mi}"
30000Mi
```

In the example, 15000 pages, each of 2Mi capacity, are defined on each worker node.

### OpenShift port requirements

The WEKA Operator automatically allocates ports to prevent collisions in multi-cluster environments. Manual configuration is typically unnecessary unless specific infrastructure or policy requirements apply.

<table><thead><tr><th width="273.39996337890625">Component</th><th width="144.39990234375">Default start port</th><th>Port range size</th></tr></thead><tbody><tr><td>WEKA Operator (v1.10+) / WEKA (v5.1.0+)</td><td>35000</td><td>260 ports per cluster</td></tr><tr><td>WEKA Operator / WEKA (previous versions)</td><td>35000</td><td>500 ports per cluster</td></tr><tr><td>WEKA client connectivity</td><td>45000</td><td>Maximum: 65535</td></tr></tbody></table>

#### Reserve ports on OpenShift nodes using MachineConfig

To prevent the Linux kernel from assigning WEKA ports to other processes, use the following `MachineConfig` .

```bash
# Display MachineConfig
cat 99-workers-reserve-ports.yaml
apiVersion: machineconfiguration.openshift.io/v1
kind: MachineConfig
metadata:
  labels:
    machineconfiguration.openshift.io/role: worker # Apply to worker or master roles
  name: 99-worker-reserve-ports
spec:
  config:
    ignition:
      version: 3.2.0
    storage:
      files:
      - contents:
          source: data:,net.ipv4.ip_local_reserved_ports%3D35000-37600 # Reserve ports 35000 - 37600
        mode: 420
        path: /etc/sysctl.d/99-reserve-ports.conf

# Create the MachineConfig.
oc create -f 99-workers-reserve-ports.yaml
```

The range 35000–37600 covers 2,600 ports, which supports up to 10 WekaCluster instances at 260 ports each. If you plan to deploy more than 10 clusters, extend the upper bound by 260 ports per additional cluster.

**Related topic**

[Set custom kernel parameters](../../planning-and-installation/bare-metal/setting-up-the-hosts/#configure-the-networking) (full kernel parameter configuration)

### Configure Kubelet requirements

Using `KubeletConfig`, enable the static CPU Manager policy on all worker nodes to give WEKA processes dedicated CPU cores. Without this, the Kubernetes scheduler can place other workloads on the same cores, causing contention and reducing I/O throughput.

Also, enable `strict-cpu-reservation` to keep Burstable and Best Effort pods off the reserved cores.

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

<table><thead><tr><th width="179">Physical core</th><th width="225">Logical CPU (thread 0)</th><th>Logical CPU (thread 1, HT sibling)</th></tr></thead><tbody><tr><td>0</td><td>0</td><td>6</td></tr><tr><td>1</td><td>1</td><td>7</td></tr><tr><td>2</td><td>2</td><td>8</td></tr><tr><td>3</td><td>3</td><td>9</td></tr><tr><td>4</td><td>4</td><td>10</td></tr><tr><td>5</td><td>5</td><td>11</td></tr></tbody></table>

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

1. Create a `KubeletConfig` file targeting each worker node and add the following settings. In this example, physical core 0 is reserved for the OS. `reservedSystemCPUs` includes both logical CPUs of that core (CPU 0 and its HT sibling, CPU 6):

<pre class="language-bash"><code class="lang-bash"><strong>cat kubelet-mconfig-workers.yaml
</strong><strong>apiVersion: machineconfiguration.openshift.io/v1
</strong>kind: KubeletConfig
metadata:
  name: custom-kubelet-workers
spec:
  machineConfigPoolSelector:
    matchLabels:
      pools.operator.machineconfiguration.openshift.io/worker: "" 
  kubeletConfig:
    cpuManagerPolicy: "static"
    reservedSystemCPUs: "0,6"
    cpuManagerPolicyOptions:
      strict-cpu-reservation: "true"
</code></pre>

Adjust `reservedSystemCPUs` to match the sibling pairs reported by `thread_siblings_list` on your node. Reserve at least one physical CPU (two sibling logical CPUs) for the Kubelet. Reserve additional physical cores, including both logical CPUs for each core, when OS or platform workloads require more capacity.

{% hint style="info" %}
`strict-cpu-reservation` keeps Burstable and Best Effort pods off the reserved cores, which protects WEKA I/O throughput under load.
{% endhint %}

2. Create the `KubeletConfig` manifest. MachineConfig Operator will detect its creation and perform a rolling reboot of the desired nodes, applying the changed configuration.

```bash
oc create -f kubelet-mconfig-workers.yaml
```

**Related topics**

[Control CPU Management Policies on the Node](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/) (static CPU Manager policy details)

[WEKA Operator best practices](weka-operator-best-practices.md) (rationale, sibling-pair guidance, and version-specific reservation details)

### Configure image pull secrets

Set up OpenShift secrets to enable secure image pulling from the WEKA container registry. These secrets must exist in every namespace where WEKA resources are deployed.

**Before you begin**

Identify your `QUAY_USERNAME`, `QUAY_PASSWORD`, and `QUAY_SECRET_KEY` from [step 1](weka-operator-on-openshift.md#id-1.-obtain-setup-information).

**Procedure**

1. Define the target namespaces and ensure they do not overlap to prevent configuration conflicts.
2. Create the secret in the `weka-operator-system` namespace. Repeat the same step in every namespace where you plan to create a WEKA CR. For example, if you deploy WEKA resources in the `default` namespace, create the secret there as well:

```bash
export QUAY_USERNAME='your_username'
export QUAY_PASSWORD='your_password'

oc create ns weka-operator-system

oc create secret docker-registry quay-io-robot-secret \
  --docker-server=quay.io \
  --docker-username=$QUAY_USERNAME \
  --docker-password=$QUAY_PASSWORD \
  --docker-email=$QUAY_USERNAME \
  --namespace=weka-operator-system

# Example workload namespace: default
oc create secret docker-registry quay-io-robot-secret \
  --docker-server=quay.io \
  --docker-username=$QUAY_USERNAME \
  --docker-password=$QUAY_PASSWORD \
  --docker-email=$QUAY_USERNAME \
  --namespace=default
```

### Configure failure domains

Group backend nodes into failure domains to ensure high availability and data protection. A failure domain represents a set of processes that share a common physical risk, such as a rack, power circuit, or network switch.

The system distributes data and parity blocks from the same stripe across different failure domains. If an entire failure domain fails, the cluster reconstructs the missing data from the remaining domains.

#### Select a failure domain mode

<table><thead><tr><th width="113">Mode</th><th width="320">Function</th><th>Usage</th></tr></thead><tbody><tr><td>Implicit (default)</td><td>Assigns every process as its own independent failure domain.</td><td>Deployments where infrastructure shared risks cannot be identified by Kubernetes node labels.</td></tr><tr><td>Explicit</td><td>Groups processes into named domains based on physical node labels.</td><td>Deployments where containers share a rack, switch, or power source.</td></tr></tbody></table>

{% hint style="info" %}
Prefer explicit mode when Kubernetes node labels can represent shared infrastructure boundaries. Explicit mode provides better failure protection by separating processes across known physical domains such as racks, power feeds, or switches. To use it, ensure the required topology labels are present on the nodes.
{% endhint %}

#### Determine stripe width and domain count

Coordinate the number of failure domains with the stripe width and protection level during cluster formation. Stripe width and protection levels are permanent once set.

Constraint to prevent data loss: blocks lost during a failure domain failure = stripe width / number of failure domains. This value must not exceed the parity block count (P).

Minimum healthy server requirements:

| Stripe configuration | Minimum healthy server |
| -------------------- | ---------------------- |
| 5+2                  | 4                      |
| 16+2                 | 9                      |
| 5+4                  | 3                      |
| 16+4                 | 5                      |

#### Map a single node label

1.  Label every backend node with a physical grouping value:

    ```bash
    oc label nodes <node-name> weka.io/failure-domain=<rack-id>
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

#### Use composite topology labels

Combine existing Kubernetes topology labels, such as zone and rack, into a compound failure domain identity.

**Procedure**

1.  Identify the existing labels on your nodes:

    ```bash
    oc get nodes --show-labels
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

#### Verify the configuration

Confirm the distribution of containers across the defined domains.

**Procedure**

1.  Apply the CR changes:

    ```bash
    oc apply -f wekacluster.yaml
    ```
2.  Check the container status:

    ```bash
    weka cluster container
    ```
3. Verify that the `FAILURE DOMAIN` column displays your custom label values instead of `AUTO`.

***

## 3. Install WEKA Operator

Manage the lifecycle of WEKA resources by installing the WEKA Operator. This process involves applying Custom Resource Definitions (CRDs) and deploying the operator controller with specific configurations for the Container Storage Interface (CSI) and drive types.

{% hint style="info" %}
The installation flow matches the Kubernetes workflow. Use `oc` commands on OpenShift and verify the OpenShift node-agent pods after installation.
{% endhint %}

**Before you begin**

* Ensure the `QUAY_SECRET_KEY` is created in the `weka-operator-system` namespace (completed in [step 2](weka-operator-on-openshift.md#id-2.-prepare-openshift-environment)).
*   Install Helm on a local server, unless using a higher-level deployment tool such as Argo CD:

    ```bash
    curl -fsSL -o get_helm.sh \
      https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
      chmod 700 get_helm.sh && ./get_helm.sh
    ```
* Confirm `oc` is installed and configured against the target cluster.
*   Identify your deployment configuration before running the Helm command:

    <table><thead><tr><th width="218">Condition</th><th>Required flag</th></tr></thead><tbody><tr><td>Operator v1.7.0 and later</td><td><code>--set csi.installationEnabled=true</code></td></tr><tr><td>Operator v1.10 and later with AlloyFlash</td><td><code>--set driveSharing.driveTypesRatio='{tlc: 9, qlc: 1}'</code></td></tr><tr><td>Operator v1.10 and later with single drive type</td><td><code>--set driveSharing.driveTypesRatio='{qlc: 0}'</code></td></tr></tbody></table>

**Procedure**

1. Download and apply the CRDs so the Kubernetes API can recognize WEKA resources. Replace `<WEKA_OPERATOR_VERSION>` with your version:

```bash
helm pull oci://quay.io/weka.io/helm/weka-operator \
  --untar --version <WEKA_OPERATOR_VERSION>
oc apply -f weka-operator/crds
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
oc -n weka-operator-system get pods
```

Expected output:

```bash
NAME                                                  READY   STATUS    RESTARTS   AGE
weka-operator-controller-manager-564bfd6b49-p6k7d    2/2     Running   0          22s
weka-operator-node-agent-4lc5s                       1/1     Running   0          22s
weka-operator-node-agent-6phw7                       1/1     Running   0          22s
weka-operator-node-agent-9mk64                       1/1     Running   0          22s
```

If the pod does not reach `Running` state, see [Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md).

***

## 4. Sign and discover storage drives

Identify and prepare physical storage devices before provisioning the WEKA cluster.

WEKA provides pre-built storage drivers for OpenShift.

Pre-built storage drivers are published at [https://drivers.weka.io](https://drivers.weka.io/).

{% hint style="info" %}
This OpenShift workflow uses pre-built drivers and requires SCC elevation before signing drives. The Kubernetes workflow documents local driver distribution separately.
{% endhint %}

#### How drive discovery works

When a drive discovery operation runs, the operator performs three actions on each node:

* Annotates the node with a list of known serial IDs for all accessible drives.
* Creates the extended resource `weka.io/drives` on the node to indicate the count of ready drives.
* Marks only healthy, unblocked drives as available. Drives with errors or manual blocks are excluded.

#### Choose a discovery method

<table><thead><tr><th width="208">Method</th><th>Use case</th></tr></thead><tbody><tr><td><code>WekaManualOperation</code></td><td>One-time action for initial manual provisioning.</td></tr><tr><td><code>WekaPolicy</code></td><td>Automated periodic discovery. Initiates immediately when it detects node updates or hardware additions. Recommended for production.</td></tr></tbody></table>

#### Understand the shared field

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

For details on SSD Proxy operation and resource requirements, see [Drive sharing](../../operation-guide/drives-sharing.md).
{% endtab %}
{% endtabs %}

**Procedure**

{% hint style="info" %}
Review the [WekaPolicy API reference](https://weka.github.io/weka-k8s-api/wekapolicy/) for all available resource options.
{% endhint %}

1. **Elevate permissions of WEKA ServiceAccount(s).**

To sign and discover storage drives attached to OpenShift node(s), the following command must be executed. This elevates the permissions of the ServiceAccounts used by the `weka-operator` .

```
oc adm policy add-scc-to-group privileged system:serviceaccounts:weka-operator-system
clusterrole.rbac.authorization.k8s.io/system:openshift:scc:privileged added: "system:serviceaccounts:weka-operator-system"
```

2. **Define drive sharing and signing:** Apply a WekaPolicy to sign compatible drives.

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
 
## Create wekaPolicy
oc create -f sign-drives.yaml     
```
{% endcode %}

<table><thead><tr><th width="185">Name</th><th>Description</th></tr></thead><tbody><tr><td><code>all-not-root</code></td><td>Signs all detected block devices except the root device.</td></tr><tr><td><code>aws-all</code></td><td>Detects NVMe devices using AWS PCI identifiers.</td></tr><tr><td><code>device-paths</code></td><td>Targets specific device paths listed in the manifest.</td></tr></tbody></table>

Confirm storage drives were signed and discovered by `weka-operator` .

```bash
# Print all nodes and their weka.io/weka-full-drives annotation.
oc get nodes -o custom-columns='NAME:.metadata.name,WEKADRIVES:.metadata.annotations.weka\.io/weka-full-drives'
NAME                           WEKADRIVES
ip-10-0-10-177.ec2.internal    [{"serial":"AWS43610718B23591D1E","capacity_gib":3492}]
ip-10-0-117-244.ec2.internal   [{"serial":"AWS642CAEDB142D12493","capacity_gib":3492}]
ip-10-0-3-84.ec2.internal      [{"serial":"AWS64CD02ED675BFA714","capacity_gib":3492}]
ip-10-0-32-103.ec2.internal    [{"serial":"AWS22B71C6A81D06C239","capacity_gib":3492}]
ip-10-0-70-248.ec2.internal    [{"serial":"AWS6437E35CB07E445D0","capacity_gib":3492}]
ip-10-0-76-5.ec2.internal      [{"serial":"AWS11EE7BFD98545B98C","capacity_gib":3492}]
```

***

## 5. Provision WEKA resources

Deploy the WekaCluster and WekaClient Custom Resources to provision the backend storage and connect your Kubernetes nodes.

{% hint style="info" %}
This OpenShift workflow uses `oc` and **requires** `spec.network.udpMode: true` for WekaCluster and WekaClient. The examples use the `weka-operator-system` namespace. The Kubernetes workflow uses `kubectl` and does not require UDP mode.
{% endhint %}

{% hint style="info" %}
Run cluster-level WEKA CLI commands from Compute or Drive pods only. Do not run WEKA CLI commands inside WekaClient pods or application client pods.
{% endhint %}

**Procedure**

1. Install the WekaCluster CR.
2. Create the WEKA cluster client secret (only required if WekaCluster and WekaClient are not deployed on the same Kubernetes cluster).
3. Install the WekaClient CR.

### 5.1. Install the WekaCluster CR

Provision the WEKA cluster backend using the WekaCluster CR. This resource defines the storage containers, drive configurations, and networking for the cluster.

{% hint style="info" %}
Review the [WekaCluster API reference](https://weka.github.io/weka-k8s-api/wekacluster/) for all available resource options.
{% endhint %}

{% hint style="warning" %}
OpenShift requires `spec.network.udpMode=true` to be set in WekaCluster definition. Only UDP Mode is supported.
{% endhint %}

**Before you begin**

* Verify that drives are signed and discovered ([step 4](weka-operator-on-openshift.md#id-4.-sign-and-discover-storage-drives)).
* Verify the driver distribution service is accessible. WEKA recommends the external service at `https://drivers.weka.io`.
* If you set `shared: true` when signing drives, select a sizing method for the dynamic template:
  * `clusterCapacity`: Sets the target usable capacity for the whole cluster. The operator derives the container and drive layout automatically.
  * `containerCapacity`: Sets the capacity per drive container. Required when `shared: true` is set and `clusterCapacity` is not set.
  * `numDrives`: Assigns whole drives per drive container. Applies when `shared: false` is set. Optional, defaults to `1`.

**Procedure**

1. Create `weka-cluster.yaml`:

<details>

<summary>Example: weka-cluster.yaml</summary>

{% code title="weka-cluster.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  name: weka-cluster-dev
  namespace: weka-operator-system
spec:
  template: dynamic
  dynamicTemplate:
    computeContainers: 6
    driveContainers: 6
    ##containerCapacity: 1000   # Use instead of numDrives when shared: true is set in sign-drive
    ##     clusterCapacity: "300TiB" # Target usable capacity for the whole cluster 
  image: quay.io/weka.io/weka-in-container:5.1.0
  nodeSelector:
    weka.io/supports-backends: "true"
  network:
    udpMode: true
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
oc explain wekacluster.spec.overrides.postFormClusterScript
```

{% hint style="info" %}
`postFormClusterScript` runs privileged debug commands on a cluster that is not yet serving I/O. Validate the script on a non-production cluster before applying it to production.
{% endhint %}

4. Apply the manifest:

```bash
oc apply -f weka-cluster.yaml -n weka-operator-system
```

**Related topic**

[WekaClusterSpec](https://weka.github.io/weka-k8s-api/wekacluster/) (all WekaCluster resource fields)

### 5.2. Create the WEKA cluster client secret

Create a secret that stores the credentials WekaClient uses to join the WEKA cluster. This is required only when WekaClient and WekaCluster are not deployed in the same OpenShift cluster.

**Before you begin**

Obtain the `org`, `join-secret`, `password`, and `username` from your WEKA backend.

**Procedure**

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
oc apply -f secret.yaml
```

### 5.3. Install the WekaClient CR

If you need WEKA clients on OpenShift, deploy the WekaClient CR on the designated OpenShift nodes. WekaClient works like a DaemonSet and provisions one pod per selected node to provide a persistent WEKA data plane for your workloads.

{% hint style="info" %}
Review the [WekaClient API reference](https://weka.github.io/weka-k8s-api/wekaclient/) for all available resource options.
{% endhint %}

**Before you begin**

1. Label every worker node intended to host WEKA client pods:

```bash
oc label nodes <node-name> <label>
```

Example:

```bash
oc label nodes <node-name> weka.io/supports-clients=true
```

{% hint style="info" %}
Ensure the label matches the `nodeSelector` property in the WekaClient CR.
{% endhint %}

2. Verify that the secret (for example, `weka-cluster-dev`) exists in the `weka-operator-system` namespace and contains base64-encoded cluster credentials (`org`, `join-secret`, `password`, and `username`).

**Procedure**

1. Create `weka-client.yaml` using the connection type that matches your environment:\
   Both connection modes support the embedded CSI plugin.

<details>

<summary>Example: Internal cluster connection (WekaCluster and WekaClient in the same OpenShift cluster)</summary>

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
  network:
    udpMode: true
  nodeSelector:
    weka.io/supports-clients: "true"
  wekaSecretRef: weka-cluster-dev
  targetCluster:
    name: weka-cluster-dev
    namespace: weka-operator-system
```
{% endcode %}

</details>

<details>

<summary>Example: External cluster connection (WEKA cluster running outside OpenShift)</summary>

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
    udpMode: true
```
{% endcode %}

</details>

3. Apply the manifest.

```bash
oc apply -f weka-client.yaml
```

<details>

<summary><strong>WekaClient parameters reference</strong></summary>

For the full list of configurable fields, see [WekaClient parameters](https://weka.github.io/weka-k8s-api/wekaclient/).

<table><thead><tr><th width="229">Name</th><th width="367">Description</th><th>Default</th></tr></thead><tbody><tr><td><code>image</code></td><td>The WEKA container image version to deploy.</td><td>—</td></tr><tr><td><code>imagePullSecret</code></td><td>Secret name used to authenticate with the image registry.</td><td>—</td></tr><tr><td><code>port</code></td><td>Defines a range of 100 ports for the container.</td><td>Dynamic</td></tr><tr><td><code>agentPort</code></td><td>Specifies a single port used by the agent process.</td><td>Dynamic</td></tr><tr><td><code>portRange</code></td><td>Defines a <code>basePort</code> for automatic port allocation.</td><td>—</td></tr><tr><td><code>nodeSelector</code></td><td>Selects the nodes where WEKA containers are scheduled.</td><td>—</td></tr><tr><td><code>network</code></td><td>Network configuration map. Sub-keys: <code>ethDevice</code> (single device), <code>ethDevices</code> (multiple devices), and <code>udpMode</code> (true/false). Defaults to UDP mode when not set.</td><td>UDP</td></tr><tr><td><code>driversDistService</code></td><td>URL for the driver distribution service.</td><td>—</td></tr><tr><td><code>targetCluster</code></td><td>Name and namespace of the WekaCluster CR to connect to. Applies when the WekaCluster runs in the same Kubernetes cluster.</td><td>—</td></tr><tr><td><code>joinIpPorts</code></td><td>IP addresses used to join a cluster outside the local environment.</td><td>—</td></tr><tr><td><code>wekaSecretRef</code></td><td>Reference to the Kubernetes Secret containing cluster credentials.</td><td>—</td></tr><tr><td><code>coresNum</code></td><td>Number of physical CPU cores to allocate to each container.</td><td>1</td></tr><tr><td><code>cpuPolicy</code></td><td>Defines core allocation behavior: <code>auto</code>, <code>manual</code>, <code>shared</code>, <code>dedicated</code> or <code>dedicated_ht</code></td><td><code>auto</code></td></tr><tr><td><code>upgradePolicy</code></td><td>Sets the upgrade strategy (<code>type</code>): <code>all-at-once</code>, <code>rolling</code>, <code>manual</code>, or <code>all-at-once-force</code>.</td><td><code>all-at-once</code></td></tr><tr><td><code>gracefulDestroyDuration</code></td><td>Pause duration for local data and drive allocations during pod deletion.</td><td>24h</td></tr></tbody></table>

</details>

***

## 6. Manage the WEKA cluster management proxy

For the procedure, see [weka-operator-full-deployment-workflow.md](weka-operator-full-deployment-workflow.md "mention").

***

## 7. Assign network space proxy subnets for multiple WEKA clusters

For the procedure, see [weka-operator-full-deployment-workflow.md](weka-operator-full-deployment-workflow.md "mention").

***

## 8. Perform post-deployment storage configuration on WEKA client

For the procedure, see [weka-operator-full-deployment-workflow.md](weka-operator-full-deployment-workflow.md "mention").
