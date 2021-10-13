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

**Command:** `weka cluster create`

This stage involves the formation of a cluster from the allocated hosts. It is performed using the following command line:

`weka cluster create <hostnames> [--host-ips <ips | ip+ip+ip+ip>]`

**Parameters in Command Line**

| **Name**    | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                               | **Limitations**                                              | **Mandatory** | Default                                    |
| ----------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ------------------------------------------ |
| `hostnames` | Space-separated strings      | Hostnames or IP addresses                                                                                                                                                                                                                                                                                               | Need at least 6 strings, as this is the minimal cluster size | Yes           |                                            |
| `host-ips`  | Comma-separated IP addresses | IP addresses of the management interfaces. Use a list of `ip+ip` addresses pairs of two cards for HA configuration. In case the cluster is connected to both IB and Ethernet, it is possible to set up to 4 management IPs for redundancy of both the IB and Ethernet networks using a list of `ip+ip+ip+ip `addresses. | The same number of values as in `hostnames`.                 | No            | IP of the first network device of the host |

{% hint style="info" %}
**Note:** It is possible to use either a host-name or an IP address; this string serves as the identifier of the host in subsequent commands.
{% endhint %}

{% hint style="info" %}
**Note:** If a host-name is used, make sure that the host-name to IP resolution mechanism is reliable since a failure of this mechanism will cause a loss of service in the cluster. It is recommended to add the host-names to `/etc/hosts`.
{% endhint %}

{% hint style="info" %}
**Note:** After successful completion of this command, the cluster is in the initialization phase, and some commands can only run in this phase.
{% endhint %}

{% hint style="info" %}
**Note:** For configuring HA, at least two cards must be defined for each host.
{% endhint %}

On successful completion of the formation of the cluster, every host receives a host ID. Use of the command line `weka cluster host` will display a list of the hosts and IDs.

{% hint style="info" %}
**Note:** In IB installations the `--hosts-ips` parameter must specify the IP addresses of the IPoIB interfaces.
{% endhint %}

## Stage 3: Naming the Cluster (optional)

**Command:** `weka cluster update`

This command is used to give the cluster a name. Although this is optional, it is highly recommended, because the name enables cloud event notification and increases the ability of the Weka Support Team to resolve any issues that may occur. To perform this operation, use the following command line:

`weka cluster update --cluster-name=<cluster-name>`

**Parameters in Command Line**

| **Name**       | **Type** | **Value**                      | **Limitations**            | **Mandatory** | **Default** |
| -------------- | -------- | ------------------------------ | -------------------------- | ------------- | ----------- |
| `cluster-name` | String   | Identifier of the cluster name | Must be a valid identifier | No            |             |

## Stage 4: Enabling Cloud Event Notifications (optional)

### **Enabling Support via Weka Home**

**Command:** `weka cloud enable`

This command enables cloud event notification (via Weka Home), which increases the ability of the Weka Support Team to resolve any issues that may occur.

To learn more about this and how to enable cloud event notification, refer to [Weka Support Cloud](../../support/the-wekaio-support-cloud.md).

### For Private Instance of Weka Home

In closed environments, such as dark sites and private VPCs, it is possible to install a private instance of Weka Home.

**Command:** `weka cloud enable --cloud-url=http://<weka-home-ip>:<weka-home-port>`

This command enables the use of a private instance of Weka Home.

{% hint style="info" %}
For more information, refer to [Private Instance of Weka Home](../../support/the-wekaio-support-cloud.md#private-instance-of-weka-home) and contact the Weka Support Team.
{% endhint %}

## Stage 5: Setting hosts as dedicated to the cluster (Optional)

**Command:** `weka cluster host dedicate`

It is possible to set the host as dedicated to the Weka cluster. By setting the host to dedicated, no other application is expected to run on it, and the Weka system optimizes it for performance and stability. For example, the host can be rebooted by the system at need, and all the host's memory is allocatable by the Weka processes.

## Stage 6: Configuration of Networking

**Command:** `weka cluster host net add`

When PKEYs are used, the device name for InfiniBand should follow the name.PKEY convention.

{% hint style="info" %}
**Note:** Although in general, devices can be renamed arbitrarily, Weka will only function correctly if the .PKEY naming convention is followed.
{% endhint %}

The networking type can be either Ethernet (direct over DPDK) or InfiniBand (IB), and can be mixed in the same host (by running multiple `cluster host net add` commands for the same host). A physical network device must be specified for both types. This can be a device dedicated to the Weka system or a device that is also being used for other purposes in parallel. For IP over DPDK, the standard routing parameters can be specified for routed networks.

To perform this operation, the `cluster host net add `command must be run for each host. The commands can run from one host configuring another host, so they can all run on a single host. The IP addresses specified using this command are the data plane IPs allocated in the planning stage. To perform this operation, use the following command line:

`weka cluster host net add <host-id> <device> [--ips-type=<POOL|USER>] [--ips=<ips>]... [--gateway=<gateway>] [--netmask=<netmask>] [--label=<label>]`

**Parameters in Command Line**

| **Name**   | **Type**                   | **Value**                                                                                  | **Limitations**                                                                                                                                                                                                                                            | **Mandatory** | **Default** |
| ---------- | -------------------------- | ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `host-id`  | String                     | Identifier of the host to which a network interface will be added                          | Must be a valid host identifier                                                                                                                                                                                                                            | Yes           |             |
| `device`   | String                     | A device, or bond-device e.g., `eth1` or `bond0`                                           | Must be a valid Unix network device name                                                                                                                                                                                                                   | Yes           |             |
| `ips-type` | String                     | POOL or USER                                                                               | Must be one of the two options                                                                                                                                                                                                                             | No            | POOL        |
| `ips`      | Comma-separated IP address | The data plane IP addresses for internal Weka system traffic. In IB, use the IPoIB address | Must be part of the data plane IP pool defined in the planning phase. See [Weka Networking](../../overview/networking-in-wekaio.md#backend-hosts) and [Networking Prerequisites](../prerequisites-for-installation-of-weka-dedicated-hosts.md#networking). | No            | From Pool   |
| `netmask`  | Number                     | Number of bits in the netmask                                                              | Describes the number of bits that identify a network ID (also known as CIDR). Not relevant for IB / L2 non-routable networks, and must be supplied for the ethernet NICs if the cluster is set to use both ethernet and IB interfaces.                     | No            |             |
| `gateway`  | IP address                 | The IP address of the default routing gateway                                              | <p>The gateway must reside within the same IP network of <code>ips</code> (as described by <code>netmask</code>).  </p><p>Not relevant for IB / L2 non-routable networks.</p>                                                                              | No            |             |
| `label`    | String                     | A label to describe the network device connectivity.                                       | The Weka system will prefer to use paths with the same labels to send data. This is useful when the system is configured with HA networking, to hint the system to send between hosts through the same switch rather than using the ISL.                   | No            |             |

The number of IP addresses should be according to [Weka Networking](../../overview/networking-in-wekaio.md#backend-hosts) and [Networking Prerequisites](../prerequisites-for-installation-of-weka-dedicated-hosts.md#networking).

{% hint style="info" %}
**Note: **Additional IP addresses may be assigned for each host if IP per core is needed. In this case, unused IP addresses are reserved for future expansions and can be automatically assigned if the number of cores assigned to the Weka system on that host is increased.
{% endhint %}

{% hint style="info" %}
**Note:** For HA configurations, this command has to be run separately for each interface.
{% endhint %}

### Optional: Configure default data networking

**Command:** `weka cluster default-net set`

Instead of explicit IP address configuration per each network device, dynamic IP address allocation is supported. Weka supports adding a range of IP addresses to a dynamic pool, from which the IP addresses can be automatically allocated on demand.

{% hint style="info" %}
**For Ethernet networking only**, a mixed approach is supported: for certain network devices the IP addresses are assigned explicitly by the administrator, while the other devices in the cluster get an automatic allocation from the IP range. Such an approach could be useful in an environment where clients are being spawned automatically.
{% endhint %}

`weka cluster default-net set --range <range> [--gateway=<gateway>] [--netmask-bits=<netmask-bits>]`

**Parameters in Command Line**

| **Name**       | **Type**         | **Value**                                                                                | **Limitations**                                                                                                                                                                             | **Mandatory** | **Default** |
| -------------- | ---------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `range`        | IP address range | A range of IP addresses that can be used for dynamic allocation across the whole cluster | <p>Format: A.B.C.D-E </p><p>E.g., 10.10.0.1-100</p>                                                                                                                                         | Yes           |             |
| `netmask-bits` | Number           | Number of bits in the netmask                                                            | Describes the number of bits that identify a network ID (also known as CIDR).                                                                                                               | Yes           |             |
| `gateway`      | IP address       | The IP address of the default routing gateway                                            | <p>The gateway must reside within the same IP network of IPs in <code>range</code> (as described by <code>netmask-bits</code>).  </p><p>Not relevant for IB / L2 non-routable networks.</p> | No            |             |

To view the current default data networking settings use the command `weka cluster default-net`.

If a default data networking was previously configured on a cluster and is no longer needed, it is possible to remove it using the command `weka cluster default-net reset`.

## Stage 7: Configuration of SSDs

**Command:** `weka cluster drive add`

This stage in the installation process is used to add a local SSD to be used by a Weka filesystem. The same command can be used for adding multiple drive paths. To perform this operation, use the following command line:

`weka cluster drive add <host-id> <device-paths>`

**Parameters in Command Line**

| **Name**       | **Type**                         | **Value**                                                                         | **Limitations**                          | **Mandatory** | **Default** |
| -------------- | -------------------------------- | --------------------------------------------------------------------------------- | ---------------------------------------- | ------------- | ----------- |
| `host-id`      | String                           | Identifier of the host to which a local SSD will be added                         | Must be a valid host identifier          | Yes           |             |
| `device-paths` | Space-separated  list of strings | List of block devices that identify local SSDs, e.g., `/dev/nvme0n1 /dev/nvme1n1` | Must be a valid Unix network device name | Yes           |             |

{% hint style="info" %}
**Note:** If, due to some technical limitation, the use of an NVMe device through the kernel is required, contact the Weka Support Team.
{% endhint %}

## Stage 8: Configuration of CPU Resources

**Command:** `weka cluster host cores`

This stage in the installation process is used to configure the number of CPU resources, which are physical rather than logical cores. To perform this operation, use the following command line:

`weka cluster host cores <host-id> <cores> [--frontend-dedicated-cores <frontend-dedicated-cores>] [--drives-dedicated-cores <drives-dedicated-cores>] [--cores-ids <cores-ids>]`

**Parameters in Command Line**

| **Name**                   | **Type**                           | **Value**                                                         | **Limitations**                                                                                            | **Mandatory** | **Default**                                          |
| -------------------------- | ---------------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------- | ---------------------------------------------------- |
| `host-id`                  | String                             | Identifier of the host in which a core count should be configured | Must be a valid host identifier                                                                            | Yes           |                                                      |
| `cores`                    | Number                             | Number of physical cores to be allocated to the Weka system       | Should be less than the number of physical cores in the host (leaving 1 core for the OS). Maximum 19 cores | Yes           |                                                      |
| `frontend-dedicated-cores` | Number                             | Number of physical cores to be dedicated to FrontEnd processes    | The total of fe_cores and be_cores must be less than cores above                                           | No            | zero                                                 |
| `drives-dedicated-cores`   | Number                             | Number of physical cores to be dedicated to Drive/SSD processes   | The total of fe_cores and be_cores must be less than cores above                                           | No            | Typically 1 core per drive or 1/2 core per drive/SSD |
| `cores-ids`                | A comma-separated list  of numbers | Physical Core numbers                                             | Specification of which cores to use.                                                                       | No            | Select cores automatically                           |

{% hint style="success" %}
**Note:** `cores-ids` are distributed in the following order: first, all the FrontEnd processes, second, all the Compute processes, and last, all the Drive processes. By ordering the `cores-ids` list, it is possible to determine the exact assignment of cores to processes (e.g., for taking into account NUMA distribution).

**For example:** If we have 1 FrontEnd, 2 Compute, and 3 Drive, setting `cores-ids` to `1, 2, 4, 3, 5, 6` will put the FrontEnd on core 1, Compute on cores 2 and 4, and Drive on cores 3, 5 and 6. Assuming cores 1, 2, 3 are at NUMA 0 and cores 4, 5, 6 are at NUMA 1, we will have the following distribution of processes:

* NUMA 0: FrontEnd, Compute, Drive
* NUMA 1: Compute, Drive, Drive
{% endhint %}

{% hint style="info" %}
**Note:** Performance can be optimized by assigning different functions to the various Weka cores. If necessary, contact the Weka Support Team for more information.
{% endhint %}

## Stage 9: Configuration of Memory (optional)

**Command:** `weka cluster host memory`

As defined in the memory requirements, the fixed memory per host and the per compute/SSD cores memory are automatically calculated by the Weka system. By default, 1.4 GB is allocated per compute-core, out of which 0.4 GB is left for the capacity-oriented memory. If the host is set as [dedicated](using-cli.md#stage-5-setting-hosts-as-dedicated-to-the-cluster-optional), all the memory left after reductions, as described in [Memory Resource Planning](planning-a-weka-system-installation.md#memory-resource-planning), is automatically allocated for the Weka system.

If capacity requirements mandate more memory, the following command should be used:

`weka cluster host memory <host-id> <capacity-memory>`

**Parameters in Command Line**

| **Name**          | **Type** | **Value**                                                                                                           | **Limitations**                                  | **Mandatory** | **Default** |
| ----------------- | -------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | ------------- | ----------- |
| `host-id`         | String   | Identifier of the host in which the memory configuration has to be defined.                                         | Must be a valid host identifier                  | Yes           |             |
| `capacity-memory` | Number   | The memory dedicated to Weka in bytes. It is possible to set the format in other units, e.g.: 1MB, 1GB, 1MiB, 1GiB. | Setting to 0 determines this value automatically | Yes           |             |

{% hint style="info" %}
**Note:** This command is given the memory per-host and will later be distributed by the system per compute core. Out of this value, 1GB per compute core is reserved for other purposes (as cache) and not used for capacity.
{% endhint %}

## Stage 10: Configuration of Failure Domains (optional)

**Command:** `weka cluster host failure-domain`

This optional stage in the installation process is used to assign a host to a failure domain. If the specified failure domain does not exist, it will be created by this command. If the host is assigned to another failure domain, it will be reassigned by this command.

{% hint style="info" %}
**Note:** All hosts not assigned to any failure domain will be considered by the Weka system as an additional failure domain. However, it is good practice to either not define failure domains at all or to assign each host to a single failure domain.
{% endhint %}

This operation is performed using the following command line:

`weka cluster host failure-domain <host-id> [--name <name>] | [--auto]`

**Parameters in Command Line**

| **Name**  | **Type** | **Value**                                                                | **Limitations**                 | **Mandatory**                                       | **Default** |
| --------- | -------- | ------------------------------------------------------------------------ | ------------------------------- | --------------------------------------------------- | ----------- |
| `host-id` | String   | Identifier of the host in which the failure domain should be configured. | Must be a valid host identifier | Yes                                                 |             |
| `name`    | String   | The failure domain that will contain the host from now.                  |                                 | Yes (either `--name` OR `--auto` must be specified) |             |
| `auto`    | Boolean  | Will automatically assign a failure domain name.                         |                                 | Yes (either `--name` OR `--auto` must be specified) |             |

## Stage 11: Configuration of Weka System Protection Scheme (optional)

**Command:** `weka cluster update`

To configure the Weka system protection scheme, use the following command line:

`weka cluster update [--data-drives=<data-drives>] [--parity-drives=<parity-drives>]`

**Parameters in Command Line**

| **Name**        | **Type** | **Value**               | **Limitations**                                                                                     | **Mandatory** | **Default**                                          |
| --------------- | -------- | ----------------------- | --------------------------------------------------------------------------------------------------- | ------------- | ---------------------------------------------------- |
| `data-drives`   | Number   | Protection stripe width | Between 3-16. The stripe width + the protection level cannot exceed the number of failure domains.  | No            | #failure domains - protection level; no more than 16 |
| `parity-drives` | Number   | Protection level        | Either 2 or 4. The stripe width + the protection level cannot exceed the number of failure domains. | No            | 2                                                    |

{% hint style="info" %}
**Note:** This command can only be used in the initialization phase.
{% endhint %}

## Stage 12: Configuration of Hot Spare (optional)

**Command:** `weka cluster hot-spare`

To configure the Weka system hot spare, use the following command line:

`weka cluster hot-spare <count>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations**                                                                                          | **Mandatory** | **Default** |
| -------- | -------- | --------- | -------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `count`  | Number   | Hot spare | The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No            | 1           |

## Stage 13: Applying Hosts Configuration

**Command:** `weka cluster host apply`

This command is used to apply the Weka system cluster hosts' configuration. In the install phase, all hosts need to be added, so the `--all` parameter can be used.

To activate the cluster hosts, use the following command line:

`weka cluster host apply [--all] [<host-ids>...] [--force]`

**Parameters in Command Line**

| **Name**   | **Type**                | **Value**                        | **Limitations** | **Mandatory**                                | **Default** |
| ---------- | ----------------------- | -------------------------------- | --------------- | -------------------------------------------- | ----------- |
| `host-ids` | Comma-separated strings | Comma-separated host identifiers |                 | Either `host-ids` or `all` must be specified |             |
| `all`      | Boolean                 | Apply all hosts                  |                 | Either `host-ids` or `all` must be specified |             |
| `force`    | Boolean                 | Do not prompt for confirmation   |                 | No                                           | Off         |

## Stage 14: Running the Start IO Command

**Command:** `weka cluster start-io`

To start the system IO and exit from the initialization phase, use the following command line:

`weka cluster start-io`

After successful completion of this command, the system exits the initialization state and runs accept IOs from the user applications.
