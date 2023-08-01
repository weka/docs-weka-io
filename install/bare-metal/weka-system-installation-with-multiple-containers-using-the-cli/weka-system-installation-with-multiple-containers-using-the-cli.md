---
description: >-
  Detailed workflow for manually configuring the WEKA cluster using the resource
  generator in a multi-container backend architecture.
---

# Manually configure the WEKA cluster using the resource generator

Perform this workflow using the resource generator only if you are not using the automated WMS, WSA, or WEKA Configurator.

The resource generator generates three resource files on each server in the `/tmp` directory: `drives0.json`, `compute0.json`, and `frontend0.json`. Then, you create the containers using these generated files of the cluster servers.&#x20;

## Before you begin

1. Download the resource generator from the GitHub repository to your local server: [https://github.com/weka/tools/blob/master/install/resources\_generator.py](https://github.com/weka/tools/blob/master/install/resources\_generator.py).

Example:&#x20;

```
wget 
https://raw.githubusercontent.com/weka/tools/master/install/resources_generator.py

```

2. Copy the resource generator from your local server to all servers in the cluster.

Example for a cluster with 8 servers:&#x20;

```
for i in {0..7}; do scp resources_generator.py weka0-$i:/tmp/resources_generator.py; done

```

2. To enable execution, change the mode of the resource generator on all servers in the cluster.

Example for a cluster with 8 servers:&#x20;

```
pdsh -R ssh -w "weka0-[0-7]" 'chmod +x /tmp/resources_generator.py'

```

## Workflow

1. [Remove the default container](weka-system-installation-with-multiple-containers-using-the-cli.md#2.-remove-the-default-container)
2. [Generate the resource files](weka-system-installation-with-multiple-containers-using-the-cli.md#3.-generate-the-resource-files)
3. [Create drive containers](weka-system-installation-with-multiple-containers-using-the-cli.md#4.-create-drive-containers)
4. [Create a cluster](weka-system-installation-with-multiple-containers-using-the-cli.md#5.-create-a-cluster)
5. [Configure the SSD drives](weka-system-installation-with-multiple-containers-using-the-cli.md#6.-configure-the-ssd-drives)
6. [Create compute containers](weka-system-installation-with-multiple-containers-using-the-cli.md#7.-create-compute-containers)
7. [Create frontend containers](weka-system-installation-with-multiple-containers-using-the-cli.md#7.-create-compute-containers)
8. [Name the cluster](weka-system-installation-with-multiple-containers-using-the-cli.md#8.-name-the-cluster)

### 1. Remove the default container

**Command:** `weka local stop default && weka local rm -f default`

Stop and remove the auto-created default container created on each server.

### 2. Generate the resource files

**Command:** `resources_generator.py`

To generate the resource files for the drive, compute, and frontend processes, run the following command on each backend server:

`./resources_generator.py --net <net-devices> [options]`

The resource generator allocates the number of cores, memory, and other resources according to the values specified in the parameters.&#x20;

The best practice for resources allocation is as follows:

* 1 drive core per NVMe device (SSD).
* 2-3 compute cores per drive core.&#x20;
* 1-2 frontend cores if deploying a protocol container. If there is a spare core, it is used for a frontend container.
* Minimum of 1 core for the OS.

#### Example 1: according to the best practice

For a server with **24** cores and 6 SSDs, allocate 6 drive cores and 12 compute cores, and optionally you can use 2 cores of the remaining cores for the frontend container. The OS uses the remaining 4 cores.

Run the following command line:\
`./resources_generator.py --net eth1 eth2 --drive-dedicated-cores 6 --compute-dedicated-cores 12 --frontend-dedicated-cores 2`

#### Example 2: a server with a limited number of cores

For a server with **14** cores and 6 SSDs, allocate 6 drive cores and 6 compute cores, and optionally you can use 1 core of the remaining cores for the frontend container. The OS uses the remaining 1 core.

Run the following command line:\
`./resources_generator.py --net eth1 eth2 --drive-dedicated-cores 6 --compute-dedicated-cores 6 --frontend-dedicated-cores 1`

{% hint style="info" %}
Contact Professional Services for the recommended resource allocation settings for your system.
{% endhint %}

**Parameters**

<table><thead><tr><th width="307">Name</th><th width="292">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>compute-core-ids</code></td><td>Specify the CPUs to allocate for the compute processes.<br>Format: space-separated numbers</td><td></td></tr><tr><td><code>compute-dedicated-cores</code></td><td>Specify the number of cores to dedicate for the compute processes.</td><td>The maximum available cores</td></tr><tr><td><code>compute-memory</code></td><td><p>Specify the total memory to allocate for the compute processes.</p><p>Format: value and unit without a space.</p><p>Examples: 1024B, 10GiB, 5TiB.</p></td><td>The maximum available memory</td></tr><tr><td><code>core-ids</code></td><td>Specify the CPUs to allocate for the WEKA processes.<br>Format: space-separated numbers.</td><td></td></tr><tr><td><code>drive-core-ids</code></td><td>Specify the CPUs to allocate for the drive processes.<br>Format: space-separated numbers.</td><td></td></tr><tr><td><code>drive-dedicated-cores</code></td><td>Specify the number of cores to dedicate for the drive processes.</td><td>1 core per each detected drive</td></tr><tr><td><code>drives</code></td><td><p>Specify the drives to use. </p><p>This option overrides automatic detection.<br>Format: space-separated strings.</p></td><td>All unmounted NVME devices</td></tr><tr><td><code>frontend-core-ids</code></td><td>Specify the CPUs to allocate for the frontend processes.<br>Format: space-separated numbers.</td><td>-</td></tr><tr><td><code>frontend-dedicated-cores</code></td><td>Specify the number of cores to dedicate for the frontend processes.</td><td>1</td></tr><tr><td><code>max-cores-per-container</code></td><td>Override the default maximum number of cores per container for IO processes (19). If provided, the new value must be lower.</td><td>19</td></tr><tr><td><code>minimal-memory</code></td><td>Set each container's hugepages memory to 1.4 GiB * number of IO processes on the container.</td><td></td></tr><tr><td><code>net</code>*</td><td>Specify the network devices to use.<br>Format: space-separated strings.</td><td></td></tr><tr><td><code>no-rdma</code></td><td>Don't take RDMA support into account when computing memory requirements.</td><td>False</td></tr><tr><td><code>num-cores</code></td><td>Override the auto-deduction of the number of cores.</td><td>All available cores</td></tr><tr><td><code>path</code></td><td>Specify the path to write the resource files.</td><td>'.'</td></tr><tr><td><code>spare-cores</code></td><td>Specify the number of cores to leave for OS and non-WEKA processes.</td><td>1</td></tr><tr><td><code>spare-memory</code></td><td><p>Specify the memory to reserve for non-WEKA requirements.</p><p>Argument format: a value and unit without a space.</p><p>Examples: 10GiB, 1024B, 5TiB.</p></td><td>The maximum between 8 GiB and 2% of the total RAM</td></tr><tr><td><code>weka-hugepages-memory</code></td><td><p>Specify the memory to allocate for compute, frontend, and drive processes.</p><p>Argument format: a value and unit without a space.</p><p>Examples: 10GiB, 1024B, 5TiB.</p></td><td>The maximum available memory</td></tr></tbody></table>

### 3. Create drive containers

**Command:** `weka local setup container`

For each server in the cluster, create the drive containers using the resource generator output file `drives0.json`.

The drives JSON file includes all the required values for creating the drive containers. Therefore, it is not required to set all the options of the `weka local setup container` command. Only the path to the JSON resource file is required.

```
weka local setup container --resources-path <resources-path>/drives0.json
```

**Parameters**

| Name               | Value                          |
| ------------------ | ------------------------------ |
| `resources-path`\* | The path to the resource file. |

### 4. Create a cluster

**Command:** `weka cluster create`

To create a cluster of the allocated containers, use the following command:

```
weka cluster create <hostnames> [--host-ips <ips | ip+ip+ip+ip>]
```

**Parameters**

<table><thead><tr><th width="181">Name</th><th width="390.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>hostnames</code>*</td><td>Hostnames or IP addresses.<br>If port 14000 is not the default for the drives, you can specify hostnames:port or ips:port.<br>Minimum cluster size: 6<br>Format: space-separated strings</td><td></td></tr><tr><td><code>host-ips</code></td><td>IP addresses of the management interfaces. Use a list of <code>ip+ip</code> addresses pairs of two cards for HA configuration. In case the cluster is connected to both IB and Ethernet, it is possible to set up to 4 management IPs for redundancy of both the IB and Ethernet networks using a list of <code>ip+ip+ip+ip</code> addresses.<br>The same number of values as in <code>hostnames</code>.<br>Format: comma-separated IP addresses.<br></td><td>IP of the first network device of the container</td></tr></tbody></table>

{% hint style="info" %}
**Notes:**

* It is possible to use a hostname or an IP address. This string serves as the container's identifier in subsequent commands.
* If a hostname is used, ensure the hostname to IP resolution mechanism is reliable. A failure of this mechanism causes a loss of service in the cluster. It is recommended to add the hostnames to `/etc/hosts`.
* Once the cluster creation is successfully completed, the cluster is in the initialization phase, and some commands can only run in this phase.
* To configure high availability (HA), at least two cards must be defined for each container.
* On successful completion of the formation of the cluster, every container receives a container-ID. To display the list of the containers and IDs, run `weka cluster container`.
* In IB installations the `--containers-ips` parameter must specify the IP addresses of the IPoIB interfaces.
{% endhint %}

### 5. Configure the SSD drives

**Command:** `weka cluster drive add`

To configure the SSD drives on each server in the cluster, or add multiple drive paths, use the following command:

```
weka cluster drive add <container-id> <device-paths>
```

**Parameters**

<table><thead><tr><th width="266">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>container-id</code>*</td><td>The Identifier of the drive container to add the local SSD drives.</td></tr><tr><td><code>device-paths</code>*</td><td>List of block devices that identify local SSDs. <br>It must be a valid Unix network device name<strong>.</strong><br>Format: Space-separated strings.<br>Example,  <code>/dev/nvme0n1 /dev/nvme1n1</code></td></tr></tbody></table>

### 6. Create compute containers

**Command:** `weka local setup container`

For each server in the cluster, create the compute containers using the resource generator output file `compute0.json`.

The compute JSON file includes all the required values for creating the compute containers. Therefore, it is not required to set all the options of the `weka local setup container` command. Only the path to the JSON resource file is required.

```
weka local setup container --join-ips <IP addresses> --resources-path <resources-path>/compute0.json
```

**Parameters**

<table><thead><tr><th width="291">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>resources-path</code>*</td><td>The path to the resource file.</td></tr><tr><td><code>join-ip</code></td><td>IP addresses of the cluster servers to join the container.<br>If the cluster does not use the default port 14000, specify the actual port. <br>Format: space-separated IP addresses.<br>Example: <code>--join-ips 10.10.10.23:15000</code></td></tr></tbody></table>

### 7.  Create frontend containers

**Command:** `weka local setup container`

For each server in the cluster, create the frontend containers using the resource generator output file `frontend0.json`.

The compute JSON file includes all the required values for creating the frontend containers. Therefore, it is not required to set all the options of the `weka local setup container` command. Only the path to the JSON resource file is required.

```
weka local setup container --join-ips <IP addresses> --resources-path <resources-path>/frontend0.json
```

**Parameters**

<table><thead><tr><th width="277">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>resources-path</code>*</td><td>The valid path to the resource file.</td></tr><tr><td><code>join-ip</code>*</td><td>IP addresses of the cluster servers to join the container.<br>If the cluster does not use the default port 14000, specify the actual port.<br>Format: space-separated IP addresses.<br>Example: <code>--join-ips 10.10.10.23:15000</code></td></tr></tbody></table>

### 8. Name the cluster

**Command:** `weka cluster update --cluster-name=<cluster name>`

## What to do next?

[perform-post-configuration-procedures.md](../perform-post-configuration-procedures.md "mention")
