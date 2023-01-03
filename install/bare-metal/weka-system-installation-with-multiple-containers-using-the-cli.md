---
description: >-
  This page provides a detailed workflow for Weka system installation with
  multiple containers using the CLI. These are complementary details for the
  quick installation guide.
---

# Weka system installation with multiple containers

## Workflow

1. [Install the Weka software](weka-system-installation-with-multiple-containers-using-the-cli.md#1.-install-the-weka-software)
2. [Remove the default container](weka-system-installation-with-multiple-containers-using-the-cli.md#2.-remove-the-default-container)
3. [Generate the resource files](weka-system-installation-with-multiple-containers-using-the-cli.md#3.-generate-the-resource-files)
4. [Create drive containers](weka-system-installation-with-multiple-containers-using-the-cli.md#4.-create-drive-containers)
5. [Create a cluster](weka-system-installation-with-multiple-containers-using-the-cli.md#5.-create-a-cluster)
6. [Configure the SSD drives](weka-system-installation-with-multiple-containers-using-the-cli.md#6.-configure-the-ssd-drives)
7. [Create compute containers](weka-system-installation-with-multiple-containers-using-the-cli.md#7.-create-compute-containers)
8. [Name the cluster](weka-system-installation-with-multiple-containers-using-the-cli.md#8.-name-the-cluster)
9. [Name the cluster and enable event notifications to the cloud (optional)](weka-system-installation-with-multiple-containers-using-the-cli.md#9.-name-the-cluster-and-enable-event-notifications-to-the-cloud-optional)
10. [Set the license](weka-system-installation-with-multiple-containers-using-the-cli.md#10.-set-the-license)
11. [Start the cluster IO service](weka-system-installation-with-multiple-containers-using-the-cli.md#11.-start-the-cluster-io-service)
12. [Create frontend containers](weka-system-installation-with-multiple-containers-using-the-cli.md#12.-create-frontend-containers)
13. [Check the cluster configuration](weka-system-installation-with-multiple-containers-using-the-cli.md#13.-check-the-cluster-configuration)

### 1. Install the Weka software <a href="#1.-install-the-weka-software" id="1.-install-the-weka-software"></a>

Once the Weka software is downloaded from [get.weka.io](https://get.weka.io), run the untar command and `install.sh` command on each server, according to the instructions in the **Install** tab.

Once completed, the Weka software is installed on all the allocated servers and runs in stem mode (no cluster is attached).

{% hint style="info" %}
**Note:** If a failure occurs during the Weka software installation process, an error message prompts detailing the source of the failure. Review the details and try to resolve the failure. If required, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### 2. Remove the default container

**Command:** `weka local stop default && weka local rm -f default`

Stop and remove the auto-created default container created on each server.

### 3. Generate the resource files

**Command:** `resources_generator.py`

To generate the resource files for the drive, compute, and frontend processes, download the [resource\_generator.py](https://github.com/weka/tools/blob/master/install/resources\_generator.py) and run the following command on one server of each process type.

The resource generator automatically calculates the number of cores, memory, and other resource values. However, you can override these values by providing specific options.

`./resources_generator.py --net <net-devices> [options]`

**Parameters**

| **Name**                   | **Type**                | **Value**                                                                                                                                                                      | **Mandatory** | **Default**                                       |
| -------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ------------------------------------------------- |
| `compute-core-ids`         | Space-separated numbers | Specify the CPUs to allocate for the compute processes.                                                                                                                        | No            | -                                                 |
| `compute-dedicated-cores`  | Number                  | Specify the number of cores to dedicate for the compute processes.                                                                                                             | No            | The maximum available cores                       |
| `compute-memory`           | String                  | <p>Specify the total memory to allocate for the compute processes.</p><p>Argument format: value and unit without a space.</p><p>Examples: 1024B, 10GiB, 5TiB.</p>              | No            | The maximum available memory                      |
| `core-ids`                 | Space-separated numbers | Specify the CPUs to allocate for the Weka processes.                                                                                                                           | No            | -                                                 |
| `drive-core-ids`           | Space-separated numbers | Specify the CPUs to allocate for the drive processes.                                                                                                                          | No            | -                                                 |
| `drive-dedicated-cores`    | Number                  | Specify the number of cores to dedicate for the drive processes.                                                                                                               | No            | 1 core per each detected drive                    |
| `drives`                   | Space-separated strings | <p>Specify the drives to use. </p><p>This option overrides automatic detection.</p>                                                                                            | No            | All unmounted NVME devices                        |
| `frontend-core-ids`        | Space-separated numbers | Specify the CPUs to allocate for the frontend processes.                                                                                                                       | No            | -                                                 |
| `frontend-dedicated-cores` | Number                  | Specify the number of cores to dedicate for the frontend processes.                                                                                                            | No            | 1                                                 |
| `max-cores-per-container`  | Number                  | Override the default maximum number of cores per container for IO processes (19). If provided, the new value must be lower.                                                    | No            | 19                                                |
| `minimal-memory`           | Flag                    | Set each container's hugepages memory to 1.4 GiB \* number of IO processes on the container.                                                                                   | No            | -                                                 |
| `net-devices`              | Space-separated strings | Specify the network devices to use.                                                                                                                                            | Yes           | -                                                 |
| `no-rdma`                  | Boolean                 | Don't take RDMA support into account when computing memory requirements.                                                                                                       | No            | False                                             |
| `num-cores`                | Number                  | Override the auto-deduction of the number of cores.                                                                                                                            | No            | All available cores                               |
| `path`                     | String                  | Specify the path to write the resource files.                                                                                                                                  | No            | The default is '.'                                |
| `spare-cores`              | Number                  | Specify the number of cores to leave for OS and non-Weka processes.                                                                                                            | No            | 1                                                 |
| `spare-memory`             | String                  | <p>Specify the memory to reserve for non-Weka requirements.</p><p>Argument format: a value and unit without a space.</p><p>Examples: 10GiB, 1024B, 5TiB.</p>                   | No            | The maximum between 8 GiB and 2% of the total RAM |
| `weka-hugepages-memory`    | String                  | <p>Specify the memory to allocate for compute, frontend, and drive processes.</p><p>Argument format: a value and unit without a space.</p><p>Examples: 10GiB, 1024B, 5TiB.</p> | No            | The maximum available memory                      |

### 4. Create drive containers

**Command:** `weka local setup container`

For each server in the cluster, create the drive containers using the resource generator output file `drives0.json`.

The drives JSON file includes all the required values for creating the drive containers. Therefore, it is not required to set all the options of the `weka local setup container` command. Only the path to the JSON resource file is required.

```
weka local setup container --resources-path <resources-path>/drives0.json
```

**Parameters**

| **Name**         | **Type** | **Value**                      | **Limitations**      | **Mandatory** | **Default** |
| ---------------- | -------- | ------------------------------ | -------------------- | ------------- | ----------- |
| `resources-path` | String   | The path to the resource file. | Must be a valid path | Yes           |             |

### 5. Create a cluster

**Command:** `weka cluster create`

To create a cluster of the allocated containers, use the following command:

```
weka cluster create <hostnames> [--host-ips <ips | ip+ip+ip+ip>]
```

**Parameters**

| **Name**    | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                               | **Limitations**                                              | **Mandatory** | **Default**                                     |
| ----------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ----------------------------------------------- |
| `hostnames` | Space-separated strings      | <p>Hostnames or IP addresses.<br>If port 14000 is not the default for the drives, you can specify hostnames:port or ips:port. </p>                                                                                                                                                                                      | Need at least 6 strings, as this is the minimal cluster size | Yes           |                                                 |
| `host-ips`  | Comma-separated IP addresses | IP addresses of the management interfaces. Use a list of `ip+ip` addresses pairs of two cards for HA configuration. In case the cluster is connected to both IB and Ethernet, it is possible to set up to 4 management IPs for redundancy of both the IB and Ethernet networks using a list of `ip+ip+ip+ip` addresses. | The same number of values as in `hostnames`.                 | No            | IP of the first network device of the container |



{% hint style="info" %}
**Note:** It is possible to use either a hostname or an IP address; this string serves as the identifier of the container in subsequent commands.
{% endhint %}

{% hint style="info" %}
**Note:** If a hostname is used, make sure that the hostname to IP resolution mechanism is reliable. A failure of this mechanism causes a loss of service in the cluster. It is recommended to add the hostnames to `/etc/hosts`.
{% endhint %}

{% hint style="info" %}
**Note:** After the successful completion of this command, the cluster is in the initialization phase, and some commands can only run in this phase.
{% endhint %}

{% hint style="info" %}
**Note:** For configuring HA, at least two cards must be defined for each container.
{% endhint %}

On successful completion of the formation of the cluster, every container receives a container-ID. To display the list of the containers and IDs, run `weka cluster container`.

{% hint style="info" %}
**Note:** In IB installations the `--containers-ips` parameter must specify the IP addresses of the IPoIB interfaces.
{% endhint %}

### 6. Configure the SSD drives

**Command:** `weka cluster drive add`

To configure the SSD drives on each server in the cluster, or add multiple drive paths, use the following command:

```
weka cluster drive add <container-id> <device-paths>
```

**Parameters**

| **Name**       | **Type**                        | **Value**                                                                                 | **Limitations**                          | **Mandatory** | **Default** |
| -------------- | ------------------------------- | ----------------------------------------------------------------------------------------- | ---------------------------------------- | ------------- | ----------- |
| `container-id` | String                          | Identifier of the container to which a local SSD is **** added                            | Must be a valid container identifier     | Yes           |             |
| `device-paths` | Space-separated list of strings | List of block devices that identify local SSDs. For example,  `/dev/nvme0n1 /dev/nvme1n1` | Must be a valid Unix network device name | Yes           |             |

### 7. Create compute containers

**Command:** `weka local setup container`

For each server in the cluster, create the compute containers using the resource generator output file `compute0.json`.

The compute JSON file includes all the required values for creating the compute containers. Therefore, it is not required to set all the options of the `weka local setup container` command. Only the path to the JSON resource file is required.

```
weka local setup container --join-ips <IP addresses> --resources-path <resources-path>/compute0.json
```

**Parameters**

| **Name**                          | **Type**                | **Value**                                                                                                                                                                                                | **Limitations**            | **Mandatory** | **Default** |
| --------------------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ------------- | ----------- |
| `resources-path`                  | String                  | The path to the resource file.                                                                                                                                                                           | Must be a valid path       | yes           |             |
| <pre><code>join-ips
</code></pre> | Space-separated strings | <p>IP addresses of the cluster servers to join the container.<br>If the cluster does not use the default port 14000, specify the actual port. For example: <code>--join-ips 10.10.10.23:15000</code></p> | Must be valid IP addresses |               |             |

### 8. Name the cluster

**Command:** `weka cluster update --cluster-name=<cluster name>`

### 9. Name the cluster and enable event notifications to the cloud (optional)

Enable event notifications to the cloud for support purposes using one of the following options:

* Enable support through Weka Home
* Enable support through a private instance of Weka Home

#### **Enable support through Weka Home**

**Command:** `weka cloud enable`

This command enables cloud event notification (via Weka Home), which increases the ability of the Weka Support Team to resolve any issues that may occur.

To learn more about this and how to enable cloud event notification, refer to [Weka Support Cloud](../../support/the-wekaio-support-cloud/).

#### **Enable support through a** private instance of Weka Home

In closed environments, such as dark sites and private VPCs, it is possible to install a private instance of Weka Home.

**Command:** `weka cloud enable --cloud-url=http://<weka-home-ip>:<weka-home-port>`

This command enables the use of a private instance of Weka Home.

{% hint style="info" %}
For more information, refer to the [Private Instance of Weka Home](../../support/the-wekaio-support-cloud/#private-instance-of-weka-home) and contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).
{% endhint %}

### 10. Set the license

**Command:** `weka cluster license set / payg`

To run IOs against the cluster, a valid license must be set. Obtain a valid license, classic or PAYG, and set it to the Weka cluster. For details, see [License overview](../../licensing/overview.md).&#x20;

### 11. Start the cluster IO service

**Command:** `weka cluster start-io`

To start the system IO and exit from the initialization state, use the following command line:

`weka cluster start-io`

### 12. Create frontend containers

**Command:** `weka local setup container`

For each server in the cluster, create the frontend containers using the resource generator output file `frontend0.json`.

The compute JSON file includes all the required values for creating the frontend containers. Therefore, it is not required to set all the options of the `weka local setup container` command. Only the path to the JSON resource file is required.

```
weka local setup container --join-ips <IP addresses> --resources-path <resources-path>/frontend0.json
```

**Parameters**

| **Name**                          | **Type**                | **Value**                                                                                                                                                                                                | **Limitations**      | **Mandatory** | **Default** |
| --------------------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- | ------------- | ----------- |
| `resources-path`                  | String                  | The path to the resource file.                                                                                                                                                                           | Must be a valid path | yes           |             |
| <pre><code>join-ips
</code></pre> | Space-separated strings | <p>IP addresses of the cluster servers to join the container.<br>If the cluster does not use the default port 14000, specify the actual port. For example: <code>--join-ips 10.10.10.23:15000</code></p> | Must be valid IPs    | Yes           |             |

### 13. Check the cluster configuration

#### Check the cluster container

**Command:** `weka cluster container`

Use this command to display the list of containers and their details.

```
$ weka cluster container
HOST ID  HOSTNAME  CONTAINER  IPS             STATUS  RELEASE                                      FAILURE DOMAIN  CORES  MEMORY    LAST FAILURE  UPTIME
0        av299-0   drives0    10.108.79.121   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-000         7      10.45 GB                1:08:30h
1        av299-1   drives0    10.108.115.194  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-001         7      10.45 GB                1:08:30h
2        av299-2   drives0    10.108.2.136    UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-002         7      10.45 GB                1:08:29h
3        av299-3   drives0    10.108.165.185  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-003         7      10.45 GB                1:08:30h
4        av299-4   drives0    10.108.116.49   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-004         7      10.45 GB                1:08:29h
5        av299-5   drives0    10.108.7.63     UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-005         7      10.45 GB                1:08:30h
6        av299-6   drives0    10.108.80.75    UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-006         7      10.45 GB                1:08:29h
7        av299-7   drives0    10.108.173.56   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-007         7      10.45 GB                1:08:30h
8        av299-8   drives0    10.108.253.194  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-008         7      10.45 GB                1:08:29h
9        av299-9   drives0    10.108.220.115  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-009         7      10.45 GB                1:08:29h
10       av299-0   compute0   10.108.79.121   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-000         6      20.22 GB                1:08:08h
11       av299-1   compute0   10.108.115.194  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-001         6      20.22 GB                1:08:08h
12       av299-2   compute0   10.108.2.136    UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-002         6      20.22 GB                1:08:09h
13       av299-3   compute0   10.108.165.185  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-003         6      20.22 GB                1:08:09h
14       av299-4   compute0   10.108.116.49   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-004         6      20.22 GB                1:08:09h
15       av299-5   compute0   10.108.7.63     UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-005         6      20.22 GB                1:08:08h
16       av299-6   compute0   10.108.80.75    UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-006         6      20.22 GB                1:08:09h
17       av299-7   compute0   10.108.173.56   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-007         6      20.22 GB                1:08:08h
18       av299-8   compute0   10.108.253.194  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-008         6      20.22 GB                1:08:09h
19       av299-9   compute0   10.108.220.115  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-009         6      20.22 GB                1:08:08h
20       av299-0   frontend0  10.108.79.121   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-000         1      1.47 GB                 1:06:57h
21       av299-1   frontend0  10.108.115.194  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-001         1      1.47 GB                 1:06:57h
22       av299-2   frontend0  10.108.2.136    UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-002         1      1.47 GB                 1:06:57h
23       av299-3   frontend0  10.108.165.185  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-003         1      1.47 GB                 1:06:56h
24       av299-4   frontend0  10.108.116.49   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-004         1      1.47 GB                 1:06:57h
25       av299-5   frontend0  10.108.7.63     UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-005         1      1.47 GB                 1:06:56h
26       av299-6   frontend0  10.108.80.75    UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-006         1      1.47 GB                 1:06:57h
27       av299-7   frontend0  10.108.173.56   UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-007         1      1.47 GB                 1:06:56h
28       av299-8   frontend0  10.108.253.194  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-008         1      1.47 GB                 1:06:57h
29       av299-9   frontend0  10.108.220.115  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1  DOM-009         1      1.47 GB                 1:06:56h
30       av2991-0  client     10.108.227.233  UP      4.1.1.8076-9e87a37af8169f32fb3c81c73d6844a1                  0      1.46 GB                 0:05:49h
```

#### Check cluster container resources

**Command:** `weka cluster container resources`

Use this command to check the resources of each container in the cluster.

`weka cluster container resources <container-id>`

Example for a drive container resources output:

```
$ weka cluster container resources 0
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
DRIVES      1        12
DRIVES      2        14
DRIVES      3        2
DRIVES      4        20
DRIVES      5        6
DRIVES      6        8
DRIVES      7        22

NET DEVICE    IDENTIFIER    DEFAULT GATEWAY  IPS             NETMASK  NETWORK LABEL
0000:00:0a.0  0000:00:0a.0  10.108.0.1       10.108.34.80    16
0000:00:0b.0  0000:00:0b.0  10.108.0.1       10.108.190.166  16
0000:00:0c.0  0000:00:0c.0  10.108.0.1       10.108.125.213  16
0000:00:0f.0  0000:00:0f.0  10.108.0.1       10.108.61.111   16
0000:00:10.0  0000:00:10.0  10.108.0.1       10.108.26.149   16
0000:00:11.0  0000:00:11.0  10.108.0.1       10.108.30.216   16
0000:00:12.0  0000:00:12.0  10.108.0.1       10.108.217.129  16

Allow Protocols         false
Bandwidth               <auto>
Base Port               14000
Dedicate Memory         true
Disable NUMA Balancing  true
Failure Domain          DOM-000
Hardware Watchdog       false
Management IPs          10.108.79.121
Mask Interrupts         true
Memory                  <dedicated>
Mode                    BACKEND
Set CPU Governors       PERFORMANCE
```

Example of a compute container resources output:

```
$ weka cluster container resources 10
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
COMPUTE     1        16
COMPUTE     2        4
COMPUTE     3        18
COMPUTE     4        26
COMPUTE     5        28
COMPUTE     6        10

NET DEVICE    IDENTIFIER    DEFAULT GATEWAY  IPS             NETMASK  NETWORK LABEL
0000:00:04.0  0000:00:04.0  10.108.0.1       10.108.145.137  16
0000:00:05.0  0000:00:05.0  10.108.0.1       10.108.212.87   16
0000:00:06.0  0000:00:06.0  10.108.0.1       10.108.199.231  16
0000:00:07.0  0000:00:07.0  10.108.0.1       10.108.86.172   16
0000:00:08.0  0000:00:08.0  10.108.0.1       10.108.190.88   16
0000:00:09.0  0000:00:09.0  10.108.0.1       10.108.77.31    16

Allow Protocols         false
Bandwidth               <auto>
Base Port               14300
Dedicate Memory         true
Disable NUMA Balancing  true
Failure Domain          DOM-000
Hardware Watchdog       false
Management IPs          10.108.79.121
Mask Interrupts         true
Memory                  20224982280
Mode                    BACKEND
Set CPU Governors       PERFORMANCE
```

Example of a frontend container resources output:

```
$ weka cluster container resources 20
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
FRONTEND    1        24

NET DEVICE    IDENTIFIER    DEFAULT GATEWAY  IPS             NETMASK  NETWORK LABEL
0000:00:13.0  0000:00:13.0  10.108.0.1       10.108.217.249  16

Allow Protocols         true
Bandwidth               <auto>
Base Port               14200
Dedicate Memory         true
Disable NUMA Balancing  true
Failure Domain          DOM-000
Hardware Watchdog       false
Management IPs          10.108.79.121
Mask Interrupts         true
Memory                  <dedicated>
Mode                    BACKEND
Set CPU Governors       PERFORMANCE
```

#### Check cluster drives

**Command:** `weka cluster drive`

Use this command to check all drives in the cluster.

Example:

```
$ weka cluster drive
DISK ID  UUID                                  HOSTNAME  NODE ID  SIZE        STATUS  LIFETIME % USED  ATTACHMENT  DRIVE STATUS
0        d3d000d4-a76b-405d-a226-c40dcd8d622c  av299-4   87       399.99 GiB  ACTIVE  0                OK          OK
1        c68cf47a-f91d-499f-83c8-69aa06ed37d4  av299-7   143      399.99 GiB  ACTIVE  0                OK          OK
2        c97f83b5-b9e3-4ccd-bfb8-d78537fa8a6f  av299-1   23       399.99 GiB  ACTIVE  0                OK          OK
3        908dadc5-740c-4e08-9cc2-290b4b311f81  av299-0   7        399.99 GiB  ACTIVE  0                OK          OK
.
.
.
68       1c4c4d54-6553-44b2-bc61-0f0e946919fb  av299-4   84       399.99 GiB  ACTIVE  0                OK          OK
69       969d3521-9057-4db9-8304-157f50719683  av299-3   62       399.99 GiB  ACTIVE  0                OK          OK
```

#### Check Weka cluster status

**Command:** `weka status`

The `weka status` command displays the overall status of the Weka cluster.

For details, see [Cluster status](../../getting-started-with-weka/manage-the-system-using-weka-cli.md#cluster-status).
