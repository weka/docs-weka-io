---
description: >-
  Detailed workflow for manually configuring the WEKA cluster using the resource
  generator in a multi-container backend architecture.
---

# Manually configure the WEKA cluster using the resources generator

Perform this workflow using the resources generator only if you are not using the automated WMS, WSA, or WEKA Configurator.

The resources generator generates three resource files on each server in the `/tmp` directory: `drives0.json`, `compute0.json`, and `frontend0.json`. Then, you create the containers using these generated files of the cluster servers.

## Before you begin

1. Download the resources generator from the GitHub repository to your local server: [https://github.com/weka/tools/blob/master/install/resources\_generator.py](https://github.com/weka/tools/blob/master/install/resources_generator.py).

Example:

```
wget https://raw.githubusercontent.com/weka/tools/master/install/resources_generator.py

```

2. Copy the resources generator from your local server to all servers in the cluster.

Example for a cluster with 8 servers:

```
for i in {0..7}; do scp resources_generator.py weka0-$i:/tmp/resources_generator.py; done

```

2. To enable execution, change the mode of the resources generator on all servers in the cluster.

Example for a cluster with 8 servers:

```
pdsh -R ssh -w "weka0-[0-7]" 'chmod +x /tmp/resources_generator.py'

```

## Workflow

1. Remove the default container
2. Generate the resource files
3. Create a cluster
4. Configure the SSD drives
5. Create compute containers
6. Create frontend containers
7. Configure number of data and parity drives
8. Configure number of hot spares
9. Name the cluster

### 1. Remove the default container

**Command:** `weka local stop default && weka local rm -f default`

Stop and remove the auto-created default container created on each server.

### 2. Generate the resource files

**Command:** `resources_generator.py`

To generate the resource files for the drive, compute, and frontend processes, run the following command on each backend server:

`./resources_generator.py --net <net-devices> [options]`

The resources generator allocates the number of cores, memory, and other resources according to the values specified in the parameters.

The best practice for resources allocation is as follows:

* 1 drive core per NVMe device (SSD).
* 2-3 compute cores per drive core.
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

<table><thead><tr><th width="307">Name</th><th width="292">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>compute-core-ids</code></td><td>Specify the CPUs to allocate for the compute processes.<br>Format: space-separated numbers</td><td></td></tr><tr><td><code>compute-dedicated-cores</code></td><td>Specify the number of cores to dedicate for the compute processes.</td><td>The maximum available cores</td></tr><tr><td><code>compute-memory</code></td><td><p>Specify the total memory to allocate for the compute processes.</p><p>Format: value and unit without a space.</p><p>Examples: 1024B, 10GiB, 5TiB.</p></td><td>The maximum available memory</td></tr><tr><td><code>core-ids</code></td><td>Specify the CPUs to allocate for the WEKA processes.<br>Format: space-separated numbers.</td><td></td></tr><tr><td><code>drive-core-ids</code></td><td>Specify the CPUs to allocate for the drive processes.<br>Format: space-separated numbers.</td><td></td></tr><tr><td><code>drive-dedicated-cores</code></td><td>Specify the number of cores to dedicate for the drive processes.</td><td>1 core per each detected drive</td></tr><tr><td><code>drives</code></td><td><p>Specify the drives to use.</p><p>This option overrides automatic detection.<br>Format: space-separated strings.</p></td><td>All unmounted NVME devices</td></tr><tr><td><code>frontend-core-ids</code></td><td>Specify the CPUs to allocate for the frontend processes.<br>Format: space-separated numbers.</td><td>-</td></tr><tr><td><code>frontend-dedicated-cores</code></td><td>Specify the number of cores to dedicate for the frontend processes.</td><td>1</td></tr><tr><td><code>max-cores-per-container</code></td><td>Override the default maximum number of cores per container for IO processes (19). If provided, the new value must be lower.</td><td>19</td></tr><tr><td><code>minimal-memory</code></td><td>Set each container's hugepages memory to 1.4 GiB * number of IO processes on the container.</td><td></td></tr><tr><td><code>net</code>*</td><td>Specify the network devices to use.<br>Format: space-separated strings.</td><td></td></tr><tr><td><code>no-rdma</code></td><td>Don't take RDMA support into account when computing memory requirements.</td><td>False</td></tr><tr><td><code>num-cores</code></td><td>Override the auto-deduction of the number of cores.</td><td>All available cores</td></tr><tr><td><code>path</code></td><td>Specify the path to write the resource files.</td><td>'.'</td></tr><tr><td><code>spare-cores</code></td><td>Specify the number of cores to leave for OS and non-WEKA processes.</td><td>1</td></tr><tr><td><code>spare-memory</code></td><td><p>Specify the memory to reserve for non-WEKA requirements.</p><p>Argument format: a value and unit without a space.</p><p>Examples: 10GiB, 1024B, 5TiB.</p></td><td>The maximum between 8 GiB and 2% of the total RAM</td></tr><tr><td><code>weka-hugepages-memory</code></td><td><p>Specify the memory to allocate for compute, frontend, and drive processes.</p><p>Argument format: a value and unit without a space.</p><p>Examples: 10GiB, 1024B, 5TiB.</p></td><td>The maximum available memory</td></tr></tbody></table>

### 3. Create a cluster

Explore the two methods to create a new WEKA cluster.

#### Create the cluster (two-step method)

This method involves two main stages. First, you create the initial `drives0` container on each server. Second, you run a single command from one server to form the cluster using those initial containers.

**Procedure**

1.  On each server that will be part of the cluster, run the `weka local setup container` command to create the initial `drives0` container.

    * Specify the path to the `drives0.json` resource file.
    * Do not include the `--join-ips` or `--clusterize` options at this stage.
    * `-n` sets the container name, in this example `drives0`. Otherwise, it uses the resource filename.

    ```
    weka local setup container -n drives0 --resources-path <resources-path>/drives0
    ```
2.  From one of the servers, run the `weka cluster add` command.

    * Provide the hostnames of the servers and their corresponding management IP addresses.
    * You must provide at least five servers.

    ```
    weka cluster add <hostnames> [--host-ips <ips | ip+ip+ip+ip>]
    ```

    \
    **Example**

    ```
    weka cluster add weka{0..4} \
    --host-ips 10.108.121.124,10.108.168.90,10.108.163.203,10.108.67.242,10.108.67.205
    ```

**Parameters**

<table><thead><tr><th width="158.6484375">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>hostnames*</code></td><td>(Required) Hostnames or IP addresses, separated by spaces. If port 14000 is not the default for the drives, you can specify <code>hostnames:port</code> or <code>ips:port</code>.</td></tr><tr><td><code>host-ips</code></td><td><p>IP addresses of the management interfaces, separated by commas.</p><ul><li>Use a list of <code>ip+ip</code> address pairs for a high availability (HA) configuration.</li><li>If the cluster connects to both IB and Ethernet, you can specify up to four management IPs (<code>ip+ip+ip+ip</code>) for redundancy.</li><li>Default: IP of the first network device of the container.</li></ul></td></tr></tbody></table>

{% hint style="info" %}
**Notes:**

* The `weka local setup container` command uses pre-configured IP addresses from the generated resource file. It only modifies entries that are empty or contain the default `127.0.0.1` address. To force an overwrite of the `ips` field, use the `--overwrite_resource_ips` flag.
* If you use hostnames, ensure a reliable hostname-to-IP resolution mechanism is in place.
* For a high availability (HA) configuration, you must define at least two network cards for each container.
* After the command succeeds, the cluster enters an initialization phase. Some commands only run during this phase.
* After formation, each container receives a `container-ID`. Run `weka cluster container` to display the list of containers and their IDs.
{% endhint %}

#### Create the cluster (single-step auto-clusterization)

This method uses a single command, run on all servers (for example, with a parallel shell utility), to auto-cluster. Containers start, discover peers using the join IPs, and automatically form the cluster.

**Before you begin**

* You must have a list of at least five management IP addresses from servers that will be part of the new cluster.

**Procedure**

1.  On each server, run the `weka local setup container` command.

    * Include the `--join-ips` option and provide at least five management IPs that will be part of the new cluster.
    * Include the `--clusterize` option to trigger the auto-clusterization process.
    * For InfiniBand (IB) installations, the `--join-ips` parameter must specify the IP addresses of the IPoIB interfaces.
    * `-n` sets the container name, in this example `drives0`. Otherwise, it uses the resource filename.

    ```
    weka local setup container -n drives0 --resources-path drives0.json \
    --join-ips 10.108.121.124,10.108.168.90,10.108.163.203,10.108.67.242,10.108.67.205 \
    --clusterize
    ```

**High availability (HA) with auto-clusterization**

The `--join-ips` argument does not support the `+` notation for defining HA.

To configure HA with auto-clusterization, use the `--management-ips` argument when creating the container. You can provide multiple specific IPs or multiple network interface names.

Example using network interface names for HA:

```
weka local setup container -n drives --resources-path drives0.json \
--management-ips enp0s5,ens1 \
--join-ips 10.108.121.124,10.108.168.90,10.108.163.203,10.108.67.242,10.108.67.205 \
--clusterize
```

### 4. Configure the SSD drives

**Command:** `weka cluster drive add`

To configure the SSD drives on each server in the cluster, or add multiple drive paths, use the following command:

```
weka cluster drive add <container-id> <device-paths>
```

**Parameters**

<table><thead><tr><th width="195.71484375">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>container-id</code>*</td><td>The Identifier of the drive container to add the local SSD drives.</td></tr><tr><td><code>device-paths</code>*</td><td>List of block devices that identify local SSDs.<br>It must be a valid Unix network device name<strong>.</strong><br>Format: Space-separated strings.<br>Example, <code>/dev/nvme0n1 /dev/nvme1n1</code></td></tr></tbody></table>

### 5. Create compute containers

**Command:** `weka local setup container`

For each server in the cluster, create the compute containers using the resources generator output file `compute0.json`.

```
weka local setup container --join-ips <IP addresses> \
--resources-path <resources-path>/compute0.json
```

**Parameters**

<table><thead><tr><th width="217">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>resources-path</code>*</td><td>A valid path to the resource file.</td></tr><tr><td><code>join-ips</code></td><td><p><code>IP:port</code> pairs for the management processes to join the cluster. In the absence of a specified port, the command defaults to using the standard WEKA port 14000. Set the values, only if you want to customize the port.</p><p>To restrict the client’s operations to only the essential APIs for mounting and unmounting operations, connect to WEKA clusters through TCP base port + 3 (for example, 14003).</p><p>The <code>IP:port</code> value must match the value used to create the container.<br>Format: comma-separated IP addresses.<br>Example: <code>--join-ips 10.10.10.1,10.10.10.2,10.10.10.3:15000</code></p></td></tr></tbody></table>

### 6. Create frontend containers

**Command:** `weka local setup container`

For each server in the cluster, create the frontend containers using the resources generator output file `frontend0.json`.

```bash
weka local setup container --join-ips <IP addresses> \
--resources-path <resources-path>/frontend0.json
```

**Command example for installing a stateful client with restricted privileges**

{% code overflow="wrap" %}
```bash
weka local setup container --client --auto-remove-timeout <auto-remove-timeout> \
--restricted --join-ips <IP addresses> --resources-path <resources-path>/frontend0.json
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="242.9765625">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>resources-path</code>*</td><td>A valid path to the resource file.</td></tr><tr><td><code>join-ips</code></td><td>IP:port pairs for the management processes to join the cluster. In the absence of a specified port, the command defaults to using the standard WEKA port 14000. Set the values, only if you want to customize the port.<br>Format: comma-separated IP addresses.<br>Example: <code>--join-ips 10.10.10.1,10.10.10.2,10.10.10.3:15000</code></td></tr><tr><td><code>client</code></td><td>Set the container as a client.</td></tr><tr><td><code>auto-remove-timeout</code></td><td>Specify timeout (in seconds) for automatically removing inactive client containers. Only applicable when used with the <code>--client</code> flag.</td></tr><tr><td><code>restricted</code></td><td>Set a client container with restricted privileges as a regular user regardless of the logged-in role.</td></tr></tbody></table>

### 7. Configure the number of data and parity drives

**Command:** `weka cluster update --data-drives=<count> --parity-drives=<count>`

**Example:** `weka cluster update --data-drives=4 --parity-drives=2`

### 8. Configure the number of hot spares

**Command:** `weka cluster hot-spare <count>`

**Example:** `weka cluster hot-spare 1`

### 9. Name the cluster

**Command:** `weka cluster update --cluster-name=<cluster name>`

## What to do next?

[perform-post-configuration-procedures.md](../perform-post-configuration-procedures.md "mention")
