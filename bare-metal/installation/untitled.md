---
description: This page describes the stages in the installation process when using the CLI.
---

# Weka System Installation Process Using the CLI

## Stage 1: Installation of the Weka Software on Each Host

Run the untar command and `install.sh` command, according to the instructions, on each host.

On completion of this stage in the installation process, the Weka software is installed on all the allocated hosts and running in the stem mode i.e., no cluster is attached and the Weka system is awaiting instructions.

{% hint style="info" %}
**Note:** If a failure occurs during this installation stage, an error message detailing the source of the failure will be received. If possible, try to recover this error or alternatively, contact the Weka Support Team.
{% endhint %}

## Stage 2: Formation of a Cluster from the Hosts

**Command:** `cluster create`

This stage involves the formation of a cluster from the allocated hosts. It is performed using the following command line:

 `weka cluster create <hosts-hostnames>...`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** |
| --- | --- |
| `host-names` | Comma separated strings | Host names or IP addresses | Need at least 6 strings, as this is the minimal cluster size |

{% hint style="info" %}
**Note:** It is possible to use either a host name or an IP address; this string serves as the identifier of the host in subsequent commands.
{% endhint %}

{% hint style="info" %}
**Note:** If a host name is used, make sure that the host name to IP resolution mechanism is reliable, since failure of this mechanism will cause a loss of service in the cluster. It is recommended to add the host names to `/etc/hosts`.
{% endhint %}

On successful completion of the formation of the cluster, every host receives a host ID specified in the host name parameter. Use of the command line `weka cluster host` will display a list of the hosts and IDs.

{% hint style="info" %}
**Note:** After successful completion of this command, the cluster is in the initialization phase, and some commands can only run in this phase.
{% endhint %}

## Stage 3: Naming the Cluster \(optional\)

**Command:** `weka cluster update`

This command is used to give the cluster a name. Although this is optional, it is highly recommended, because the name enables cloud event notification and increases the ability of the Weka Support Team to resolve any issues that may occur. To perform this operation, use the following command line:

`weka cluster update --cluster-name=<name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `cluster-name` | String | Identifier of the cluster name | Must be a valid identifier | No |  |

## Stage 4: Enabling Cloud Event Notifications \(optional\)

**Command** `weka cloud enable`

This command enables cloud event notification, which increases the ability of the Weka Support Team to resolve any issues that may occur. To perform this operation, use the following command line:

`weka cloud enable`

## Stage 5: Configuration of Networking

**Command:** `cluster host net add`

The networking type can be either Ethernet \(direct over DPDK\) or InfiniBand \(IB\). A physical network device must be specified for both types. This can be a device dedicated to the Weka system, or a device that is also being used for other purposes in parallel. For IP over DPDK, the standard routing parameters can be specified for routed networks.

To perform this operation, the cluster host net add command must be run for each host. The commands can run from one host configuring another host, so they can all run on a single host. The IP addresses specified using this command are the data plane IPs allocated in the planning stage. To perform this operation, use the following command line:

`weka cluster host net add <host-id> --device=<device> [--ips=<ips>]... [--gateway=<gw>] [--netmask=<netmask>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- | --- | --- | --- |
| `host-id` | String | Identifier of host to which a network interface will be added | Must be a valid host identifier | Yes |  |
| `device` | String | A device, e.g., `eth1` | Must be a valid Unix network device name | Yes |  |
| `ips` | Comma-separated IP address | The data plane IP addresses for internal Weka system traffic | Must be part of the data plane IP pool defined in the planning phase. Each IP can only be used once. The number of IP addresses specified must be at least the number of cores allocated \(see below\) | Yes |  |
| `gateway` | IP address | IP address of the default routing gateway | IP address and gateway may only be different on the last N bits, where N is the net mask. Not allowed for IB. | No | Does not exist for L2 non-routable networks |
| `netmask` | Number | Number of bits in the net mask | IP address and gateway may only be different on the last N bits, where N is the net mask. Not allowed for IB. | No | Does not exist for L2 non-routable networks |

The number of IP addresses should be at least the number of cores specified in Stage 8. A larger number can be specified, in which case the unused IP addresses will be assigned if and when more cores will be allocated using the expand process.

## Stage 6: Configuration of SSDs

**Command:** `cluster drive add`

This stage in the installation process is used to add a local SSD to be used by a Weka filesystem. To perform this operation, use the following command line:

`weka cluster drive add <host-id> <device-path>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `host-id` | String | Identifier of host to which a local SSD will be added | Must be a valid host identifier | Yes |  |
| `device` | String | A block device that identifies a local SSD, e.g., `/dev/sdb` | Must be a valid Unix network device name | Yes |  |

{% hint style="info" %}
**Note:** If, due to some technical limitation, the use of an NVMe device through the kernel is required, contact the Weka Support Team.
{% endhint %}

## Stage 7: **Scanning Drives**

**Command:**`weka cluster drive scan`

After provisioning the SSDs to be used by a Weka filesystem using the previous command, it is also necessary to scan them so that they are recognizable by the system internally. To perform this operation, use the following command line:

`weka cluster drive scan`

## Stage 8: Configuration of CPU Resources

**Command:** `cluster host cores`

This stage in the installation process is used to configure the amount of CPU resources, which are physical rather than logical cores \(since hyper-threading must be disabled\). To perform this operation, use the following command line:

`weka cluster host cores <host-id> <cores>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `host-id` | String | Identifier of host in which a core count should be configured | Must be a valid host identifier | Yes |  |
| `cores` | Number | Number of physical cores to be allocated to the Weka system | Should be less than the number of physical cores in the host \(leaving 1 core for the OS\) | Yes |  |

{% hint style="info" %}
**Note:** Performance can be optimized by assigning different functions to the various Weka cores. If necessary, contact the Weka Support Team for more information.
{% endhint %}

## Stage 9: Configuration of Memory \(optional\)

**Command:** `cluster host memory`

As defined in the memory requirements, the fixed memory per host and the per core memory are automatically computed by the Weka system. For the capacity-oriented memory, a default of 1.4 GB per host is allocated. If capacity requirements mandate more memory per host, the following command should be used: 

`weka cluster host memory <host-id> <capacity-memory>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `host-id` | String | Identifier of host in which the memory configuration has to be defined | Must be a valid host identifier | Yes |  |
| `capacity-emory` | Number | Required memory in bytes |  | Yes |  |

{% hint style="info" %}
**Note:** This command is for initialization phase only.  To adjust the memory of a running cluster, contact the Weka Support Team.
{% endhint %}

{% hint style="info" %}
This commands sets only the capacity portion of the memory requirements. The per-host and per-core requirements are set automatically by Weka
{% endhint %}

## Stage 10: Configuration of Failure Domains \(optional\)

**Command:** `cluster host fd-name`

This optional stage in the installation process is used to assign a host to a failure domain. If the specified failure domain does not exist, it will be created by this command. If the host is assigned to another failure domain, it will be reassigned by this command.

{% hint style="info" %}
**Note:** All hosts not assigned to any failure domain will be considered by the Weka system as an additional failure domain. However, it is s good practice to either not define failure domains at all or to assign each host to a single failure domain.
{% endhint %}

This operation is performed using the following command line: 

`weka cluster host fd-name <host-id> <failure-domain>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `host-id` | String | Identifier of host in which a core count should be configured | Must be a valid host identifier | Yes |  |
| `fd-name` | String | The failure domain that will contain the host from now |  | Yes |  |

## Stage 11: Configuration of Weka System Protection Scheme

**Command:** `cluster update`

To configure the Weka system protection scheme, use the following command line:

`weka cluster update [--data-drives=<num>] [--parity-drives=<num>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `data-drives` | Number | Protection stripe width | Between 3-16. The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 3 |
| `parity-drives` | Number | Protection level | Either 2 or 4. The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 2 |

{% hint style="info" %}
**Note:** This command can only be used in the initialization phase.
{% endhint %}

## Stage 12: Configuration of Hot Spare

**Command:** `cluster hot-spare`

To configure the Weka system hot spare, use the following command line:

`weka cluster hot-spare <count>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `hot-spare` | Number | Hot spare | The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 0 |

{% hint style="info" %}
**Note**: If this command is not executed, the hot spare will be defined as 0.
{% endhint %}

## Stage 13: Activation of Cluster Hosts

**Command:** `weka cluster host activate`

This command is used to activate the Weka system cluster host. When it is run, a comma-separated list of all host names is received. In the install phase, all hosts need to be added, so the default of no parameter can be used.

To activate the cluster hosts, use the following command line:

 `weka cluster host activate [<host-ids>...]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `host-ids` | Comma separated strings | Comma separated host identifiers | . | No | All hosts |

## Stage 14: Activation of Cluster SSDs

**Command:** `cluster drive activate`

This command is used to mark the Weka system SSDs as active, so they are in-use by the cluster. To activate the cluster SSDs, use the following command line:

`cluster drive activate [<uuids>...]`

A comma-separated list of all SSD UUIDs is received. In the install phase all SSDs need to be active, so the default of no parameter can be used.

{% hint style="info" %}
**Note:** To obtain the drive UUIDs, it is possible to use either the output received from a previously run `weka cluster drive add` command, or alternatively use the drive listing command `weka cluster drive`, which will list all drives and their UUIDs.
{% endhint %}

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `uuids` | Comma-separated strings | Comma-separated host identifiers | . | No | All SSDs |

## Stage 15: Running the Start IO Command

**Command:** `cluster start-io`

To start the system IO and exit from the initialization phase, use the following command line: 

`weka cluster start-io`

After successful completion of this command, the system exits the initialization state and runs accept IOs from the user applications.

