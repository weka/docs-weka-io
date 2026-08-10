---
description: >-
  Deploy NeuralMesh Axon and integrate with orchestration services like
  Kubernetes and SLURM. For partners and skilled customers performing
  independent installations.
---

# NeuralMesh Axon deployment

## NeuralMesh Axon deployment overview

NeuralMesh Axon offers a flexible deployment model, supporting both Slurm and Kubernetes runtime environments. regardless of the deployment method, specific infrastructure configurations are required to ensure high performance and stability.

### Infrastructure prerequisites

Before deploying software, the physical and network environment must be prepared:

* **Network:** The topology must be non-blocking with zero over-subscription. Jumbo frames (9k MTU for Ethernet, 4k for InfiniBand) and Source Based Routing policies are required.
* **Hardware:** Servers require AMD or Intel CPUs with contention-free allocation per NUMA domain and NVMe storage with Power Loss Protection (PLP).
* **Linux configuration:** All deployments require specific Linux kernel settings, including disabling swap partitions, disabling kernel NUMA balancing, and setting `noexec` on `/tmp`. BIOS settings must disable hyperthreading and enable maximum performance.
* **Firewall:** Ensure traffic is allowed on essential ports, such as 14000-16100 (Core traffic), 443 (Traces), and 8200-8201 (Vault).

### Deployment options

Administrators can choose between a Kubernetes-native deployment or a direct installation on servers running Slurm.

**Option A: Kubernetes deployment**

This method uses the WEKA Operator to manage lifecycle and automation via Custom Resource Definitions (CRDs).

* **WEKA Operator and CSI:** The WEKA Operator and CSI plugin are installed through Helm charts to manage the cluster state.
* **Node preparation:** Kubernetes nodes are labeled (`weka.io/supports-backends=true` and `weka.io/supports-clients=true`) to control pod placement.
* **SELinux:** For Kubernetes clusters, a specific SELinux policy (`container_use_wekafs`) must be installed on nodes if SELinux support is enabled.
* **Custom Resources:** The cluster is defined and deployed by applying `WekaCluster` and `WekaClient` CRDs, which specify container counts and resources.

**Option B: Slurm deployment (without Kubernetes)**

This method involves manual distribution and scripting on the servers running on Slurm.

* **Distribution:** The software release tarball is downloaded and distributed to all cluster servers using tools like `pdcp`.
* **Installation:** An installation script configures the container topology (Drives, Compute, and Frontend containers), binding specific CPU cores and NICs to NeuralMesh processes.
* **Service management:** Systemd overrides are created to ensure graceful shutdown, and the cluster IO is started manually via CLI (`weka cluster start-io`).

### Workload integration

NeuralMesh Axon integrates with schedulers to optimize resource usage. To prevent resource conflicts with Slurm, configure `slurm.conf` to exclude the specific CPU cores and memory reserved for NeuralMesh Axon using `CpuSpecList` and `MemSpecLimit`.

### Multi-tenancy

Subdivide the cluster into Organizations to support multi-tenancy. Security policies enforce boundaries based on user roles and network CIDRs.

## NeuralMesh Axon deployment requirements

### System requirements overview

NeuralMesh Axon requires specific infrastructure configurations for both Linux servers and Kubernetes runtime environments.

* **Network infrastructure:** Configure the following network settings:
  * Non-blocking network topology with zero over-subscribed segments.
  * Jumbo frames enabled: 9k MTU for Ethernet, 4k MTU for Infiniband.
  * Source Based Routing policies applied to each dataplane network device.
* **Hardware requirements:** Deploy servers that meet these specifications:
  * **CPU architecture**: AMD (single socket required), Intel (dual-socket supported), or NVIDIA Grace (ARM).
  * **CPU allocation**: Contention-free CPU allocation for each NUMA domain.
  * **Memory**: Sufficient RAM to allocate [HugeTLB pages](#user-content-fn-1)[^1] at runtime. For details, see [#memory-resource-planning](../planning-and-installation/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning "mention").
  * **Storage**: Adequate NVME capacity for the selected protection scheme.
* **Software prerequisites:** Install and configure these software components:
  * Unified CGROUPs or CGROUP v2 enabled.
  * Linux kernel headers matching the booted kernel version.
* **Additional Linux server configuration requirements:** see [#linux-system-configuration](neuralmesh-axon-deployment.md#linux-system-configuration "mention").

### Kubernetes-specific requirements

Ensure your Kubernetes environment meets specific driver and security configurations before deployment to guarantee optimal performance and compatibility.

#### NIC driver requirements

Review the supported drivers and specific version requirements for Ethernet and InfiniBand configurations.

**Mellanox OFED Ethernet and InfiniBand drivers**

Kubernetes deployments use NeuralMesh Axon Core releases that are one major version behind Slurm deployments. Consequently, these releases require the installation of Mellanox OFED drivers rather than using the drivers bundled in the Core codebase.

* **Core versions 5.0 and later:** No OFED driver installation is required as the code is bundled with Core.
* **Core versions before 5.0:** You must install a qualified OFED driver.
  * Latest date-versioned release: OFED 24.04-0.7.0.0.
  * Latest semantic-versioned release: OFED 5.9-0.5.6.0.

For more details, see [#ethernet-drivers-and-configurations](../planning-and-installation/prerequisites-and-compatibility.md#ethernet-drivers-and-configurations "mention")\
and [#networking-infiniband](../planning-and-installation/prerequisites-and-compatibility.md#networking-infiniband "mention").

**ENA drivers**

* **Supported versions:** 1.0.2 through 2.0.2.
* **Recommendation:** Use the current driver from the official OS repository.

**ixgbevf drivers**

* **Supported versions:** 3.2.2 through 4.1.2.
* **Recommendation:** Use the current driver from the official OS repository.

#### Enable SELinux support for NeuralMesh Axon on Kubernetes

Configure SELinux support for NeuralMesh Axon clusters hosted in a Kubernetes runtime environment. This process requires installing a specific SELinux policy on each participating Kubernetes node and updating the deployment configuration.

**Procedure:**

1. **Install the SELinux policy on the Kubernetes nodes:** Apply the policy package to each node participating in the NeuralMesh Axon system using the files from the public GitHub repository.
   1. Clone the repository:\
      `git clone https://github.com/weka/csi-wekafs.git`
   2. Copy the SELinux files to the relevant nodes (example using `pdcp`):\
      `pdcp -w neuralmesh-axon-[001-200] -r csi-wekafs/selinux ~/`
   3. Install the SELinux module (example using `pdsh`):\
      `pdsh -w neuralmesh-axon-[001-200] "sudo semodule -i ~/selinux/csi-wekafs.pp"`\
      This command defines a new SELinux boolean labeled `container_use_wekafs`.\
      If the `container_use_wekafs` boolean does not appear in the list, compile the policy package that matches the target Linux server. See [#install-a-custom-selink-p](../appendices/weka-csi-plugin/add-selinux-support.md#install-a-custom-selink-p "mention").
   4. Enable the SELinux boolean:\
      `pdsh -w neuralmesh-axon-[001-200] "sudo setsebool container_use_wekafs=on"`
2.  **Update the WEKA Operator definition:** Update the definition file with the SELinux support flag set to either `mixed` or `enforced`.

    Run the following Helm command to upgrade the plugin, for example, with the enforced setting:

    ```bash
    helm install --upgrade csi-wekafsplugin csi-wekafs/csi-wekafsplugin /
    --namespace csi-wekafsplugin --create-namespace --set selinuxSupport=enforced
    ```

### SSD requirements

* **SSD configuration:** Determine these specifications for each server:
  * Number of SSDs required.
  * Capacity per SSD (total capacity = number × capacity per SSD).
* **SSD feature requirements:** Verify that SSDs provide:
  * Power Loss Protection (PLP).
  * Capacity up to 30 TB.
  * Capacity ratio between smallest and largest SSDs not exceeding 8:1 across the cluster.

### Network configuration

Configure firewall rules to allow these ports and protocols on all cluster servers:

<table><thead><tr><th width="236">Port/NodePort</th><th width="116">Protocol</th><th>Purpose</th></tr></thead><tbody><tr><td>14000-14100, 15000-15100, 16000-16100</td><td>TCP + UDP</td><td>NeuralMesh Axon Core container traffic</td></tr><tr><td>443</td><td>TCP</td><td>NeuralMesh Axon Core traces remote viewer</td></tr><tr><td>22</td><td>TCP</td><td>SSH management access</td></tr><tr><td>123</td><td>TCP</td><td>NTP management access</td></tr><tr><td>8200, 8201</td><td>TCP</td><td>Hashicorp Vault traffic</td></tr><tr><td>5696</td><td>TCP</td><td>KMIP traffic</td></tr></tbody></table>

### CPU core management

NeuralMesh Axon co-locates with AI workloads on shared computational hardware.

For non-Kubernetes/bare-metal deployments, allocate dedicated CPU cores to both NeuralMesh Axon and the job-scheduling service to prevent CPU starvation.

For Kubernetes deployments, CPU core allocation is not required.

### Linux system configuration

Apply these configurations to all NeuralMesh Axon deployments, regardless of deployment type.

* **CPU and memory settings:**
  * Balance CPU cores across NUMA domains containing dataplane network devices.
  * Install Linux kernel header package matching the booted kernel version.
  * Disable NUMA balancing by setting `kernel.numa_balancing = 0` and add the entry to the `/etc/sysctl.conf` file to ensure persistence.
* **Network configuration:**
  * Configure Source Based Routing policies for every dataplane NIC on every dataplane subnet in the OS network scripts to enable access without specifying bind/outbound interfaces.
  *   Configure ARP settings for each dataplane network device by setting the following parameters in the `/etc/sysctl.conf` file, replacing `<device>` with the actual network interface name.

      ```
      net.ipv4.conf.<device>.arp_announce = 2
      net.ipv4.conf.<device>.arp_filter = 1
      net.ipv4.conf.<device>.arp_ignore = 0
      ```
* **System services and settings:** Configure these system requirements:
  * Disable swap partitions.
  * Run NTP with synchronized date and time across all cluster servers.
  * Install and enable `rpcbind`, `XFS`, and `SquashFS`.
  * Maintain consistent IOMMU settings (BIOS and bootloader) across all cluster servers.
  * Apply `noexec` mount option to `/tmp`.
* **BIOS configuration:** Flash BIOS using WEKA's [bios\_tool](https://github.com/weka/bios_tool/tree/master) to:
  * Select maximum power and performance settings.
  * Disable hyperthreading (HT).
  * Disable Active Management Technology (AMT).

## Install NeuralMesh Axon on a Kubernetes environment

The installation of NeuralMesh Axon on a Kubernetes environment consists of a WEKA Operator that simplifies the installation, management, and scaling of NeuralMesh Axon deployments within a Kubernetes cluster.

The WEKA Operator uses Kubernetes Custom Resource Definitions (CRDs) to provide resilience, scalability, and automation for each cluster. It provides a cluster-wide service that monitors each Kubernetes namespace containing NeuralMesh Axon custom resources.

When the WEKA Operator detects that the state of the deployed resources does not match the declared state in the resource definition file, it performs one of the following actions:

* Logs clear and useful messages in the WEKA Operator controller pod.
* Bootstraps the resource to return it to the desired state, provided the change is additive and non-destructive.

The WEKA Operator automation never makes subtractive or destructive changes to deployed resources.

#### Compatibility

Verify the environment meets the following minimum version requirements:

* **Kubernetes:** Version 1.25 or higher.
* **OpenShift:** Version 4.17 or higher.

#### Network requirements

The following Kubernetes nodePorts are required. These ports use default ranges unless defined differently in the definition files. These ports are not hard-coded into the source code and can be adjusted to match the target Kubernetes cluster service topology.

| **Purpose**        | **Source Container(s)** | **Destination Container(s)** | **Default Port Ranges** | **Protocol** |
| ------------------ | ----------------------- | ---------------------------- | ----------------------- | ------------ |
| Client connections | Client                  | Compute, Drives              | 45000-65000             | TCP/UDP      |
| Cluster allocation | Operator                | Compute, Drives, Client      | 35000-35499             | TCP/UDP      |
| Core traffic       | Compute, Drives         | Compute, Drives              | 35000-35499             | TCP/UDP      |

### Workflow

1. Configure Kubelet settings.
2. Install NeuralMesh Axon.
3. Label the nodes.
4. Create registry secrets.
5. Install the WEKA Operator and CSI Plugin.
6. Deploy driver and discovery services.
7. Deploy NeuralMesh Axon Custom Resources.

#### 1. Configure Kubelet settings

Configure the Kubelet with static CPU management to enable exclusive CPU allocation for NeuralMesh Axon performance.

1.  **Define the CPU management policy:** Configure the Kubelet with the following settings:

    ```yaml
    reservedSystemCPUs: "0"
    cpuManagerPolicy: static
    ```
2.  **Identify the active Kubelet configuration:** Check which configmap holds the current Kubelet configuration.

    ```bash
    kubectl get cm -A|grep kubelet
    ```

    If multiple Kubelet configurations exist, modify the configuration specifically for the worker nodes.
3.  **Apply the CPU settings:** Edit the Kubelet config map to add the required CPU settings.

    ```bash
    kubectl edit cm -n kube-system kubelet-config
    ```

#### 2. Install NeuralMesh Axon

The installation of a NeuralMesh Axon cluster in a Kubernetes environment is an automated process. The solution uses three collections of Kubernetes namespaces:

* Global namespace for the NeuralMesh Axon WEKA Operator.
* Global namespace for the CSI-WekaFS CSI plugin.
* Individual namespaces for each NeuralMesh Axon cluster.

Reliable pod scheduling for these services requires specific Kubernetes labels and selectors on both nodes and resources.

#### 3. Label the nodes

Apply Kubernetes node labels to assign the CSI and NeuralMesh Axon Core cluster pods to specific nodes. Ensure the labels applied to the nodes match the `nodeSelector` definitions in the Custom Resource Definitions (CRDs).

The following commands demonstrate how to label nodes using the example values `supports-clients` and `supports-backends`:

1.  **Label nodes for the CSI:**

    ```bash
    kubectl label nodes <node name> weka.io/supports-clients=true
    ```
2.  **Label nodes for the NeuralMesh Axon Core cluster:**

    ```bash
    kubectl label nodes <node name> weka.io/supports-backends=true
    ```

#### 4. Create registry secrets

Create a `docker-registry` secret in the global namespace for the WEKA Operator and in each namespace hosting a Core cluster.

The following commands are examples.

1.  **Export the required variables:**

    ```bash
    export QUAY_USERNAME='QUAY_USERNAME' # Replace with the actual value
    export QUAY_PASSWORD='QUAY_PASSWORD' # Replace with the actual value
    export QUAY_SECRET_NAME='QUAY_SECRET_NAME' # Replace with a meaningful name
    ```
2.  **Create the namespace and secret for the WEKA Operator:**

    ```bash
    # Create the namespace for the WEKA Operator
    kubectl create ns weka-operator-system

    # Create the docker-registry secret for NeuralMesh Axon Deploy
    kubectl create secret docker-registry $QUAY_SECRET_NAME \
      --docker-server=quay.io \
      --docker-username=$QUAY_USERNAME \
      --docker-password=$QUAY_PASSWORD \
      --docker-email=$QUAY_USERNAME \
      --namespace=weka-operator-system
    ```
3.  **Create the secret for NeuralMesh Axon Core:**

    ```bash
    # Create the docker-registry secret for NeuralMesh Axon Core
    kubectl create secret docker-registry $QUAY_SECRET_NAME \
      --docker-server=quay.io \
      --docker-username=$QUAY_USERNAME \
      --docker-password=$QUAY_PASSWORD \
      --docker-email=$QUAY_USERNAME \
      --namespace=default
    ```

#### 5. Install the WEKA Operator and CSI Plugin

Install the WEKA Operator and CSI plugin using Helm to enable storage lifecycle management. This installation sets up the required Custom Resource Definitions (CRDs) and deploys the operator within the specified namespace.

{% hint style="info" %}
The version numbers in the following commands are examples. Verify the latest version at [https://get.weka.io/ui/operator](https://get.weka.io/ui/operator) and update the `WEKA_OPERATOR_VERSION` variable before execution.
{% endhint %}

1.  **Set the WEKA Operator version:**

    ```bash
    export WEKA_OPERATOR_VERSION='v1.8.7'
    ```
2.  **Pull the Helm chart and apply the CRDs:**

    ```bash
    helm pull oci://quay.io/weka.io/helm/weka-operator \
    --untar --version $WEKA_OPERATOR_VERSION
    kubectl apply -f weka-operator/crds
    ```
3.  **Install the WEKA Operator and CSI Plugin:**

    ```bash
    helm upgrade --create-namespace \
        --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
        --namespace weka-operator-system \
        --version $WEKA_OPERATOR_VERSION \
        --set csi.installationEnabled=true
    ```

#### 6. Deploy driver and discovery services

1.  **Deploy the Driver Distribution Service:** Prepare the variables and apply the configuration.

    ```yaml
    export WEKA_IMAGE_VERSION='VERSION' # Replace with the latest version from https://get.weka.io/ui/releases
    export QUAY_SECRET_NAME='QUAY_SECRET_NAME' # Replace with a meaningful name

    cat <<EOF | kubectl apply -f -
    apiVersion: weka.weka.io/v1alpha1
    kind: WekaPolicy
    metadata:
      name: weka-drivers
      namespace: weka-operator-system
    spec:
      image: quay.io/weka.io/weka-in-container:${WEKA_IMAGE_VERSION}
      imagePullSecret: "${QUAY_SECRET_NAME}"
      payload:
        driverDistPayload: {}
        interval: 1m
      type: enable-local-drivers-distribution
    EOF
    ```
2.  **Deploy the Drive Signer Service:**

    ```yaml
    export WEKA_IMAGE_VERSION='VERSION' # Replace with the latest version from https://get.weka.io/ui/releases
    export QUAY_SECRET_NAME='QUAY_SECRET_NAME' # Replace with a meaningful name

    cat <<EOF | kubectl apply -f -
    apiVersion: weka.weka.io/v1alpha1
    kind: WekaManualOperation
    metadata:
      name: discover-drives
      namespace: weka-operator-system
    spec:
      action: "discover-drives"
      image: quay.io/weka.io/weka-in-container:${WEKA_IMAGE_VERSION}
      imagePullSecret: "${QUAY_SECRET_NAME}"
      payload:
        discoverDrivesPayload:
          nodeSelector:
            weka.io/supports-backends: "true"
    EOF
    ```

#### 7. Deploy NeuralMesh Axon Custom Resources

Install the Custom Resources for the WekaCluster and WekaClient.

1.  **Deploy WekaCluster:** Update the dynamicTemplate values to match the target cluster size.

    ```yaml
    export WEKA_IMAGE_VERSION='VERSION' # Replace with the latest version from https://get.weka.io/ui/releases
    export QUAY_SECRET_NAME='QUAY_SECRET_NAME' # Replace with a meaningful name

    cat <<EOF | kubectl apply -f -
    apiVersion: weka.weka.io/v1alpha1
    kind: WekaCluster
    metadata:
      name: axon-cluster
      namespace: default
    spec:
      template: dynamic
      dynamicTemplate: # Replace values with the actual size of your cluster
        computeContainers: 256
        computeCores: 16
        driveContainers: 256
        driveCores: 32
        numDrives: 8
      image: quay.io/weka.io/weka-in-container:${WEKA_IMAGE_VERSION}
      nodeSelector:
        weka.io/supports-backends: "true"
      driversDistService: "https://weka-drivers-dist.weka-operator-system.svc.cluster.local:60002"
      imagePullSecret: "${QUAY_SECRET_NAME}"
      network:
        ethDevice: enp0
    EOF
    ```
2.  **Deploy WekaClient:**

    ```yaml
    export WEKA_IMAGE_VERSION='VERSION' # Replace with the latest version from https://get.weka.io/ui/releases 
    export QUAY_SECRET_NAME='QUAY_SECRET_NAME' # Replace with a meaningful name

    cat <<EOF | kubectl apply -f -
    apiVersion: weka.weka.io/v1alpha1
    kind: WekaClient
    metadata:
      name: axon-cluster-clients
    spec:
      image: quay.io/weka.io/weka-in-container:${WEKA_IMAGE_VERSION}
      imagePullSecret: "${QUAY_SECRET_NAME}"
      driversDistService: "https://weka-drivers-dist.weka-operator-system.svc.cluster.local:60002"
      portRange:
        basePort: 46000
      nodeSelector:
        weka.io/supports-clients: "true"
      wekaSecretRef: axon-cluster
      targetCluster:
        name: axon-cluster
        namespace: default
      network:
        ethDevice: enp0
    EOF
    ```

## Install NeuralMesh Axon without Kubernetes

Installing the NeuralMesh Axon software involves downloading the installer, configuring system reliability settings, and running an automated script to deploy the cluster topology.

### Server configuration prerequisites

Verify the hardware and resource requirements to ensure optimal cluster performance.

The following table outlines the required networking, storage, resources, and protection scheme configurations.

<table><thead><tr><th width="208">Component</th><th>Requirement</th></tr></thead><tbody><tr><td>Networking</td><td>Two dataplane network devices (without HA configuration).</td></tr><tr><td>Storage</td><td>2, 4, or 8 NVMe drives per server.</td></tr><tr><td>Resources</td><td><p>One Drive core per NVMe drive (up to 8 cores).</p><p>Two Compute cores per Drive core (up to 16 cores).</p><p>Twelve Frontend cores (regardless of number of drives).</p></td></tr><tr><td>Protection scheme</td><td>16+4 protection (16 stripe width, 4 parity) with 2 hot spares.</td></tr></tbody></table>

**NUMA alignment guidelines**

Apply the following logic to ensure correct NUMA alignment:

* Distribute CPU core IDs evenly across NUMA domains that contain a dataplane network device.
* If hyperthreading is enabled, do not assign sibling cores to the Axon cluster. Exclude them from customer workloads.

### Workflow

1. Download and distribute the WEKA release.
2. Configure graceful shutdown.
3. Deploy the cluster.
4. Finalize the installation.

#### 1. Download and distribute the WEKA release

Begin by downloading the NeuralMesh Axon Core software and distributing it to all servers in the cluster.

1.  **Download the release:** Replace `YOUR_WEKA_TOKEN` with your assigned download token and `WEKA_RELEASE` with the specific release version.

    ```bash
    curl -LO https://YOUR_WEKA_TOKEN@get.weka.io/dist/v1/pkg/WEKA_RELEASE.tar
    ```
2.  **Distribute and install the software:** Use `pdcp` and `pdsh` to copy the tarball to the servers, extract it, and run the installation script.

    ```bash
    pdcp -w neuralmesh-axon-[001-200] WEKA_RELEASE.tar /root/WEKA_RELEASE.tar
    pdsh -w neuralmesh-axon-[001-200] 'tar -xvf /root/WEKA_RELEASE.tar'
    pdsh -w neuralmesh-axon-[001-200] \
    'cd /root/WEKA_RELEASE; \
    WEKA_SYSTEMD_GRACEFUL_SHUTDOWN=true WEKA_CGROUPS_MODE=force_v2 ./install.sh'
    ```

#### 2. Configure graceful shutdown

Configure a systemd override to ensure the system handles shutdowns gracefully by enforcing a specific timeout and reboot action.

1.  **Create the configuration file:** Create the `override.conf` file locally.

    ```
    cat <<EOF | tee -a /tmp/override.conf
    [Unit]
    JobTimeoutSec=30s
    JobTimeoutAction=reboot
    EOF
    ```
2.  **Apply the configuration to all servers:** Distribute the file to the `poweroff.target.d` directory on all cluster servers and reload the systemd daemon.

    ```bash
    pdsh -w neuralmesh-axon-[001-200] 'sudo mkdir -p /etc/systemd/system/poweroff.target.d'
    pdcp -w neuralmesh-axon-[001-200] /tmp/override.conf /tmp
    pdsh -w neuralmesh-axon-[001-200] \
    'sudo cp /tmp/override.conf /etc/systemd/system/poweroff.target.d'
    pdsh -w neuralmesh-axon-[001-200] 'systemctl daemon-reexec'
    ```

#### 3. Deploy the Axon Core cluster

Customize and execute the following installation script to deploy the NeuralMesh Axon Core cluster. This script automates the creation of containers (Drives, Compute, Frontend), forms the cluster, configures data protection, and assigns NVMe drives.

<details>

<summary>Example installation script</summary>

```bash
#!/bin/bash

##
# This script is an example. To convert this example to a valid
# installation script, edit the variables in the section below.
##

##
# Cluster configuration parameters:
# - 2x dataplane network devices (not configured for WEKA-HA)
# - 8x NVMe drives
# - 1x DRIVE container using 8 cores
# - 1x COMPUTE container using 16 cores
# - 16+4+2 protection scheme
#   --> 16: stripe width
#   -->  4: data parity count
#   -->  2: virtual hotspare count
##

##
# NUMA alignment notes:
# - Distribute CPU core-IDs evenly across NUMA domains containing a
#   dataplane network device.
# - If hyperthreading is enabled, exclude daughter/sibling cores from
#   the Axon cluster and ensure they are not used for customer workloads.
##

# --- Cluster Parameters (Edit these values) ---

## NeuralMesh Axon Core cluster name
CLUSTER_NAME="your cluster name here"

## Unique identifier for data drives (from output of: nvme list)
## Examples: "kioxia", "3.2TB"
DRIVE_MATCH="your NVMe unique drive identifier here"

## Protection: integers from 3 to 16, inclusive
PROTECTION=16
## Parity: integers from 2 to 4, inclusive
PARITY=4
## Hotspares: any positive integer starting from zero
HOT_SPARES=2

## Compute Container Configuration
## Actual core-IDs depend on the platform's NUMA domains
COMPUTE_CORES='48,54,60,66,72,78,84,90,47,53,59,65,71,77,83,89'
COMPUTE_NICS='enp1,enp2'
COMPUTE_MEM=56     ## 3.5 GB RAM/CORE * 16 cores

## Drive Container Configuration
## Actual core-IDs depend on the platform's NUMA domains
DRIVE_CORES='24,30,36,42,23,29,35,41'
DRIVE_NICS='enp1,enp2'
DRIVE_MEM=20       ## 2.5 GB RAM/CORE * 8 cores

## Frontend Container Configuration
## Actual core-IDs depend on the platform's NUMA domains
FE_CORES='42,43'
FE_NICS='enp1,enp2'
FE_MEM=5           ## 2.5 GB RAM/CORE * 2 cores

# --- End of Parameters ---

## Axon hostnames must be defined in /etc/hosts on all servers
LINUX_HOST_NAMES="`cat /etc/hosts | grep -i axon | awk '{print $2}' | tr '\n' ' ' | sed 's/.$//'`"
LINUX_HOST_ADDRS="`cat /etc/hosts | grep -i axon | awk '{print $1}' | tr '\n' ',' | sed 's/.$//'`"
AXON_IP="`echo ${LINUX_HOST_ADDRS} | tr ',' '\n' | head -n 1`"
JOIN_ME="`echo ${LINUX_HOST_ADDRS} | tr ',' '\n' | head -n 5 | tr '\n' ',' | sed 's/.$//'`"

## Remove any prior WEKA containers (e.g., 'default' container)
pdsh -f 120 -w ${LINUX_HOST_ADDRS} "sudo weka local stop -f; echo"
pdsh -f 120 -w ${LINUX_HOST_ADDRS} "sudo weka local rm --all -f; echo"

## Setup the DRIVES container on all Linux storage servers
cmd="sudo weka local setup container --name drives0 --only-drives-cores --base-port 14000 --net ${DRIVE_NICS} --cores 8 --core-ids ${DRIVE_CORES} --memory ${DRIVE_MEM}GB --failure-domain"
cmd+=' $(hostname -s)'
pdsh -f 120 -w ${LINUX_HOST_ADDRS} "${cmd}"
sleep 10

## Create the cluster
[cite_start]ssh ${AXON_IP} "sudo weka cluster create ${LINUX_HOST_NAMES} --host-ips=${LINUX_HOST_ADDRS}" # [cite: 464]
sleep 10

## Configure the protection scheme
[cite_start]ssh ${AXON_IP} "sudo weka cluster update --data-drives ${PROTECTION} --parity-drives ${PARITY} --cluster-name ${CLUSTER_NAME}" # [cite: 468]
ssh ${AXON_IP} "sudo weka cluster hot-spare ${HOT_SPARES}"
sleep 10

## Add the NVMe drives from each server to the correct DRIVES container
while read server_name;
do
  drives_data="`ssh -n ${server_name} "sudo nvme list | grep ${DRIVE_MATCH}"`"
  drives_list="`echo "${drives_data}" | tr '\n' ' '`"
  container_data="`ssh -n ${AXON_IP} "sudo weka cluster container --no-header | grep -i ${server_name} | grep -i drives0"`"
  container_id="`echo ${container_data} | awk '{print $1}'`"
  echo "${server_name}: weka cluster drive add ${container_id} ${drives_list}"
  [cite_start]ssh -n ${AXON_IP} "sudo weka cluster drive add ${container_id} ${drives_list}" # [cite: 495]
done < <( echo -e "${LINUX_HOST_NAMES}" | tr ' ' '\n' )
sleep 10

## Setup the COMPUTE containers on all Linux storage servers
cmd="sudo weka local setup container --name compute0 --only-compute-cores --base-port 15000 --net ${COMPUTE_NICS} --cores 16 --core-ids ${COMPUTE_CORES} --memory ${COMPUTE_MEM}GB --failure-domain"
cmd+=' $(hostname -s)'
cmd+=" --join-ips ${JOIN_ME}"
pdsh -f 120 -w ${LINUX_HOST_ADDRS} "${cmd}"

## Setup the FRONTEND containers on all Linux storage servers
cmd="sudo weka local setup container --name frontend0 --client --only-frontend-cores --base-port 16000 --net ${FE_NICS} --cores 2 --core-ids ${FE_CORES} --memory ${FE_MEM}GB --failure-domain"
cmd+=' $(hostname -s)'
cmd+=" --join-ips ${JOIN_ME}"
pdsh -f 120 -w ${LINUX_HOST_ADDRS} "${cmd}"
```

</details>

**Prerequisites**

* Ensure `pdsh` is installed and configured for passwordless access to all target servers.
* Verify all target servers are listed in `/etc/hosts` with a common identifier (e.g., `axon`) to facilitate hostname parsing.

**Procedure**

1. Copy the example installation script to a file (for example, `install_axon.sh`).
2. Edit the **Cluster Parameters** section to match your hardware configuration:
   * **Core IDs:** Align `COMPUTE_CORES`, `DRIVE_CORES`, and `FE_CORES` with your specific NUMA topology.
   * **NICs:** Update `COMPUTE_NICS`, `DRIVE_NICS`, and `FE_NICS` with the correct interface names.
   * **Drive identifier:** Update `DRIVE_MATCH` with a unique string (model or size) that identifies your NVMe drives.
3.  Make the script executable and run it:

    ```bash
    chmod +x install_axon.sh
    ./install_axon.sh
    ```

#### 4. Finalize the installation

After the cluster deployment script completes, enable the observation service and start the IO services.

1.  **Enable the Axon Observe service:**

    ```shell
    weka cloud enable
    ```
2.  **Start the cluster IO services:**

    ```bash
    weka cluster start-io
    ```

## NeuralMesh Axon workload integration with Slurm

Slurm is an open-source cluster management and job scheduling system tailored for Linux clusters. It manages resource access, workload execution, and monitoring.

In a NeuralMesh Axon architecture, Slurm compute servers often function as NeuralMesh Axon Core clients, requiring a Frontend container to mount the local storage service. Additionally, Compute and Drive containers may run on these servers in converged configurations.

To ensure optimal performance and stability, you must isolate CPU and memory resources for NeuralMesh Axon processes. This prevents conflicts with Slurm-managed user workloads or daemons.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/slurm_weka_dedicated_backend_4 (1).png" alt="" width="456"><figcaption><p>NeuralMesh Axon integration with Slurm</p></figcaption></figure></div>

#### Configure Slurm for resource isolation

Configure Slurm to isolate CPU and memory resources for WEKA processes. This prevents conflicts between Slurm services (primarily `slurmd`) and user workloads attempting to use the same cores. This configuration uses the `task/affinity` and `task/cgroup` plugins to control compute resource exposure and binds nodes to designated resources.

**Procedure**

1.  **Edit the `slurm.conf` file to enable resource tracking and containment:** Add or modify the following settings:

    * **ProctrackType:** Set to `proctrack/cgroup` to use cgroups for process tracking.
    * **TaskPlugin:** Set to `task/affinity,task/cgroup` to enable resource binding and containment.
    * TaskPluginParam: Set to `SlurmdOffSpec` to prevent Slurm daemons from running on cores designated for WEKA.
    * **SelectType:** Set to `select/cons_tres` to track cores, memory, and GPUs as consumable resources.
    * **SelectTypeParameters**: Set to `CR_Core_Memory` to schedule workloads based on core and memory availability.
    * **PrologFlags:** Set to `Contain` to enforce cgroup containment for all user nodes.
    * **JobAcctGatherType:** (Optional) Set to `jobacct_gather/cgroup` for metrics gathering.

    Example configuration snippet:

    ```bash
    ProctrackType=proctrack/cgroup
    TaskPlugin=task/affinity,task/cgroup
    TaskPluginParam=SlurmdOffSpec
    SelectType=select/cons_tres
    SelectTypeParameters=CR_Core_Memory
    JobAcctGatherType=jobacct_gather/cgroup
    PrologFlags=Contain
    ```
2.  **Edit the `cgroup.conf` file to enforce resource constraints:** Ensure the following parameters are set:

    * **ConstrainCores:** Set to `yes`.
    * **ConstrainRamSpace:** Set to `yes`.

    ```bash
    ConstrainCores=yes
    ConstrainRamSpace=yes
    ```
3.  **Define the compute nodes in `slurm.conf` to allocate exclusive resources:** Set the following parameters for each node definition:

    * [**`RealMemory`**](https://slurm.schedmd.com/slurm.conf.html#OPT_RealMemory)**:** The total available memory on the compute node.
    * [**`CpuSpecList`**](https://slurm.schedmd.com/slurm.conf.html#OPT_CpuSpecList)**:** The list of virtual CPU IDs reserved for system use (including WEKA processes). Slurm uses only the cores defined here; it excludes others from user jobs.
    * [**`MemSpecLimit`**](https://slurm.schedmd.com/slurm.conf.html#OPT_MemSpecLimit): The amount of memory (in MB) reserved for system use. This is required when `SelectTypeParameters` is set to `CR_Core_Memory`.

    Example node definition: This example reserves cores 47 through 95 for Slurm usage, leaving cores 0 through 46 available for WEKA.

    ```shellscript
    NodeName=compute-node-0 CPUs=96 Boards=1 SocketsPerBoard=2 CoresPerSocket=24 ThreadsPerCore=2 RealMemory=1360000 MemSpecLimit=5000 State=CLOUD CpuSpecList=47,95
    ```
4.  **Mount the filesystem using the resources excluded from Slurm:** The following example mounts the filesystem using core 46, which is outside the `CpuSpecList` range (47-95) defined for Slurm.

    ```bash
    mount -t wekafs -o core=46 -o net=ib0 backend-host-0/fs1 /mnt/weka
    ```

## Integrate with Kubernetes

NeuralMesh Axon is a Kubernetes-native solution, delivering super-computing storage packaged as a Kubernetes application. You can manage the placement and prioritization of NeuralMesh Axon Core clusters directly from the point of installation using standard Kubernetes mechanisms.

#### **Manage placement and prioritization**

Utilize the following Kubernetes-native features to control where and how NeuralMesh Axon resources are deployed:

* **Selectors:** Target specific nodes for deployment.
* **Affinity rules:** Define complex rules for pod placement relative to other pods or nodes.
* **Priority classes:** Ensure critical NeuralMesh Axon components receive scheduling priority.
* **Resource requests:** Reserve the necessary compute and memory resources for optimal performance.

## NeuralMesh Axon Multi-tenancy

NeuralMesh Axon implements logical multi-tenancy by subdividing cluster controls and resources into secure authorization boundaries called Organizations.

#### Security enforcement

WEKA security policies enforce the boundaries created by Organizations. These policies use network CIDR information and Organization member roles to evaluate authorization for API calls and data operations.

#### Policy scope and evaluation

You can apply security policies to the entire cluster, a specific Organization, or individual filesystems within an Organization. To ensure fine-grained enforcement, the system evaluates the following:

* The authenticated user's Organization membership.
* The user's Organization permissions.
* The network CIDR from which the authenticated API call originated.

[^1]: **HugeTLB (Huge Table):** This refers to the Linux kernel's framework/API for managing large memory pages. It's the _mechanism_ for reserving and allocating pages bigger than the standard 4KB. For more details, see [https://www.kernel.org/doc/html/v5.0/admin-guide/mm/hugetlbpage.html](https://www.kernel.org/doc/html/v5.0/admin-guide/mm/hugetlbpage.html)
