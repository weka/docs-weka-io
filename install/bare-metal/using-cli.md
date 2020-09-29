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

`weka cluster create <hostnames> [--host-ips <ips | ip+ip>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `hostnames` | Space-separated strings | Hostnames or IP addresses | Need at least 6 strings, as this is the minimal cluster size | Yes |  |
| `host-ips` | Comma-separated IP addresses | IP addresses of the management interfaces. Use a list of ip+ip addresses pairs of two cards for HA configuration | The same number of values as in `hostnames`. | No | IP of the first network device of the host |

{% hint style="info" %}
**Note:** It is possible to use either a host name or an IP address; this string serves as the identifier of the host in subsequent commands.
{% endhint %}

{% hint style="info" %}
**Note:** If a host name is used, make sure that the host name to IP resolution mechanism is reliable, since failure of this mechanism will cause a loss of service in the cluster. It is recommended to add the host names to `/etc/hosts`.
{% endhint %}

{% hint style="info" %}
**Note:** After successful completion of this command, the cluster is in the initialization phase, and some commands can only run in this phase.
{% endhint %}

{% hint style="info" %}
**Note:** For configuring HA, at least two cards must be defined for each host.
{% endhint %}

On successful completion of the formation of the cluster, every host receives a host ID specified in the host name parameter. Use of the command line `weka cluster host` will display a list of the hosts and IDs.

{% hint style="info" %}
**Note:** In IB installations the `--hosts-ips` parameter must specify the IP addresses of the IPoIB interfaces.
{% endhint %}

## Stage 3: Naming the Cluster \(optional\)

**Command:** `weka cluster update`

This command is used to give the cluster a name. Although this is optional, it is highly recommended, because the name enables cloud event notification and increases the ability of the Weka Support Team to resolve any issues that may occur. To perform this operation, use the following command line:

`weka cluster update --cluster-name=<name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `cluster-name` | String | Identifier of the cluster name | Must be a valid identifier | No |  |

## Stage 4: Enabling Cloud Event Notifications \(optional\)

### **Enabling Support via Weka Home**

**Command:** `weka cloud enable`

This command enables cloud event notification \(via Weka Home\), which increases the ability of the Weka Support Team to resolve any issues that may occur.

To learn more about this and how to enable cloud event notification, refer to [Weka Support Cloud](../../support/the-wekaio-support-cloud.md).

### For Private Instance of Weka Home

In closed environments, such as dark sites and private VPCs, it is possible to install a private instance of Weka Home.

**Command:** `weka cloud enable --cloud-url=http://<weka-home-ip>:<weka-home-port>`

This command enables the use of a private instance of Weka Home.

{% hint style="info" %}
For more information, refer to [Private Instance of Weka Home](../../support/the-wekaio-support-cloud.md#private-instance-of-weka-home) and contact the Weka Support Team.
{% endhint %}

## Stage 5: Setting hosts as dedicated to the cluster \(Optional\)

**Command:** `cluster host dedicate`

It is possible to set the host as dedicated to the Weka cluster. By setting the host to dedicated, no other application is expected to run on it, and the Weka system optimizes it for performance and stability. For example, the host can be rebooted by the system at need, and all the host's memory is allocatable by the Weka processes.

## Stage 6: Configuration of Networking

**Command:** `cluster host net add`

When PKEYs are used, the device name for InfiniBand should follow the name.PKEY convention.

{% hint style="info" %}
**Note:** Although in general, devices can be renamed arbitrarily, Weka will only function correctly if the .PKEY naming convention is followed.
{% endhint %}

The networking type can be either Ethernet \(direct over DPDK\) or InfiniBand \(IB\). A physical network device must be specified for both types. This can be a device dedicated to the Weka system, or a device that is also being used for other purposes in parallel. For IP over DPDK, the standard routing parameters can be specified for routed networks.

To perform this operation, the cluster host net add command must be run for each host. The commands can run from one host configuring another host, so they can all run on a single host. The IP addresses specified using this command are the data plane IPs allocated in the planning stage. To perform this operation, use the following command line:

`weka cluster host net add <host-id> <device> [--ips-type=<POOL|USER>] [--ips=<ips>]... [--gateway=<gw>] [--netmask=<netmask>]`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>host-id</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Identifier of host to which a network interface will be added</td>
      <td
      style="text-align:left">Must be a valid host identifier</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>device</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">A device, e.g., <code>eth1</code>
      </td>
      <td style="text-align:left">Must be a valid Unix network device name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>ips-type</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">POOL or USER</td>
      <td style="text-align:left">Must be one of the two options</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">POOL</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>ips</code>
      </td>
      <td style="text-align:left">Comma-separated IP address</td>
      <td style="text-align:left">The data plane IP addresses for internal Weka system traffic. In IB, use
        the IPoIB address</td>
      <td style="text-align:left">Must be part of the data plane IP pool defined in the planning phase.
        See <a href="../../overview/networking-in-wekaio.md#backend-hosts">Weka Networking</a> and
        <a
        href="prerequisites-for-installation-of-weka-dedicated-hosts.md#networking">Networking Prerequisites</a>.</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">From Pool</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>netmask</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Number of bits in the net mask</td>
      <td style="text-align:left">Describes the number of bits that identify a network ID (also known as
        CIDR).</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>gateway</code>
      </td>
      <td style="text-align:left">IP address</td>
      <td style="text-align:left">IP address of the default routing gateway</td>
      <td style="text-align:left">
        <p>Gateway must reside within the same IP network of <code>ips</code> (as described
          by <code>netmask</code>).</p>
        <p>Not relevant for IB / L2 non-routable networks.</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

The number of IP addresses should be according to [Weka Networking](../../overview/networking-in-wekaio.md#backend-hosts) and [Networking Prerequisites](prerequisites-for-installation-of-weka-dedicated-hosts.md#networking).

{% hint style="info" %}
**Note:** Additional IP addresses may be assigned for each host, if IP per core is needed. In this case, unused IP addresses are reserved for future expansion process, and can be automatically assigned if number of cores assigned to Weka system on that host is increased.
{% endhint %}

{% hint style="info" %}
**Note:** For HA configurations, this command has to be run separately for each interface.
{% endhint %}

### Optional: Configure default data networking

**Command:** `cluster default-net set`

Instead of explicit IP address configuration per each network device, dynamic IP address allocation is supported. Weka supports adding a range of IP addresses to a dynamic pool, from which the IP addresses can be automatically allocated on demand.

{% hint style="info" %}
**For Ethernet networking only**, a mixed approach is supported: for certain network devices the IP addresses are assigned explicitly by the administrator, while the other devices in cluster get an automatic allocation from IP range. Such an approach could be useful in an environment where clients are spawned automatically.
{% endhint %}

`weka cluster default-net set --range <range> [--gateway=<gw>] [--netmask-bits=<netmask>]`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>range</code>
      </td>
      <td style="text-align:left">IP address range</td>
      <td style="text-align:left">A range of IP addresses that can be used for dynamic allocation across
        the whole cluster</td>
      <td style="text-align:left">
        <p>Format: A.B.C.D-E</p>
        <p>E.g., 10.10.0.1-100</p>
      </td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>netmask-bits</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Number of bits in the net mask</td>
      <td style="text-align:left">Describes the number of bits that identify a network ID (also known as
        CIDR).</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>gateway</code>
      </td>
      <td style="text-align:left">IP address</td>
      <td style="text-align:left">IP address of the default routing gateway</td>
      <td style="text-align:left">
        <p>Gateway must reside within the same IP network of IPs in <code>range</code> (as
          described by <code>netmask-bits</code>).</p>
        <p>Not relevant for IB / L2 non-routable networks.</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

To view the current default data networking settings use the command `weka cluster default-net`.

If a default data networking was previously configured on a cluster and is no longer needed, it is possible to remove it using the command `weka cluster default-net reset`.

## Stage 7: Configuration of SSDs

**Command:** `cluster drive add`

This stage in the installation process is used to add a local SSD to be used by a Weka filesystem. The same command can be used for adding multiple drive paths. To perform this operation, use the following command line:

`weka cluster drive add <host-id> <device-paths>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host to which a local SSD will be added | Must be a valid host identifier | Yes |  |
| `device-paths` | Space-separated  list of strings | List of block devices that identify local SSDs, e.g., `/dev/nvme0n1 /dev/nvme1n1` | Must be a valid Unix network device name | Yes |  |

{% hint style="info" %}
**Note:** If, due to some technical limitation, the use of an NVMe device through the kernel is required, contact the Weka Support Team.
{% endhint %}

## Stage 8: Configuration of CPU Resources

**Command:** `cluster host cores`

This stage in the installation process is used to configure the amount of CPU resources, which are physical rather than logical cores. To perform this operation, use the following command line:

`weka cluster host cores <host-id> <cores> [--frontend-dedicated-cores <fe_cores>] [--drives-dedicated-cores <be_cores>] [--cores-ids <cores_ids>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host in which a core count should be configured | Must be a valid host identifier | Yes |  |
| `cores` | Number | Number of physical cores to be allocated to the Weka system | Should be less than the number of physical cores in the host \(leaving 1 core for the OS\) . Maximum 19 cores | Yes |  |
| `frontend-dedicated-cores` | Number | Number of physical cores to be dedicated to FrontEnd processes | The total of fe\_cores and be\_cores must be less than cores above | No | zero |
| `drives-dedicated-cores` | Number | Number of physical cores to be dedicated to Drive/SSD processes | The total of fe\_cores and be\_cores must be less than cores above | No | Typically 1 core per drive or 1/2 core per drive/SSD |
| `cores-ids` | Comma-separated list  of numbers | Physical Core numbers | Specification of which cores to use. | No | Select cores automatically |

{% hint style="success" %}
**Note:** `core_ids` are distributed in the following order: first, all the FrontEnd processes, second all the Compute processes, and last all the Drive processes. By ordering the `core_ids` list, it is possible to determine the exact assignment of cores to processes \(e.g., for taking into account NUMA distribution\).

**For example:** If we have 1 FrontEnd, 2 Compute, and 3 Drive, setting `core_ids` to `1, 2, 4, 3, 5, 6` will put the FrontEnd on core 1, Compute on cores 2 and 4, and Drive on cores 3, 5 and 6. Assuming cores 1, 2, 3 are at NUMA 0 and cores 4, 5, 6 are at NUMA 1, we will have the following distribution of processes:

* NUMA 0: FrontEnd, Compute, Drive
* NUMA 1: Compute, Drive, Drive
{% endhint %}

{% hint style="info" %}
**Note:** Performance can be optimized by assigning different functions to the various Weka cores. If necessary, contact the Weka Support Team for more information.
{% endhint %}

## Stage 9: Configuration of Memory \(optional\)

**Command:** `cluster host memory`

As defined in the memory requirements, the fixed memory per host and the per compute/SSD cores memory are automatically calculated by the Weka system. By default, 1.4 GB is allocated per compute-core, out of which 0.4 GB is left for the capacity-oriented memory. If the host is set as [dedicated](using-cli.md#stage-5-setting-hosts-as-dedicated-to-the-cluster-optional), all the memory left after reductions, as described in [Memory Resource Planning](planning-a-weka-system-installation.md#memory-resource-planning), is automatically allocated for the Weka system.

If capacity requirements mandate more memory, the following command should be used:

`weka cluster host memory <host-id> <capacity-memory>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host in which the memory configuration has to be defined | Must be a valid host identifier | Yes |  |
| `capacity-memory` | Number | Memory dedicated to Weka in bytes. It is possible to set the format in other units, e.g.: 1MB, 1GB, 1MiB, 1GiB. | Setting to 0 determines this value automatically | Yes |  |

{% hint style="info" %}
**Note:** This command is given the memory per-host and will later be distributed by the system per compute core. Out of this value, 1GB per compute core is reserved for other purposes \(as cache\) and not used for capacity.
{% endhint %}

## Stage 10: Configuration of Failure Domains \(optional\)

**Command:** `cluster host failure-domain`

This optional stage in the installation process is used to assign a host to a failure domain. If the specified failure domain does not exist, it will be created by this command. If the host is assigned to another failure domain, it will be reassigned by this command.

{% hint style="info" %}
**Note:** All hosts not assigned to any failure domain will be considered by the Weka system as an additional failure domain. However, it is good practice to either not define failure domains at all or to assign each host to a single failure domain.
{% endhint %}

This operation is performed using the following command line:

`weka cluster host failure-domain <host-id> [--name <fd-name>] | [--auto]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host in which the failure domain should be configured | Must be a valid host identifier | Yes |  |
| `name` | String | The failure domain that will contain the host from now |  | Yes \(either `--name` OR `--auto` must be specified\) |  |
| `auto` | Boolean | Will automatically assign fd-name |  | Yes \(either `--name` OR `--auto` must be specified\) |  |

## Stage 11: Configuration of Weka System Protection Scheme

**Command:** `cluster update`

To configure the Weka system protection scheme, use the following command line:

`weka cluster update [--data-drives=<num>] [--parity-drives=<num>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `data-drives` | Number | Protection stripe width | Between 3-16. The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | \#failure domains - protection level - \#hot spares |
| `parity-drives` | Number | Protection level | Either 2 or 4. The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 2 |

{% hint style="info" %}
**Note:** This command can only be used in the initialization phase.
{% endhint %}

{% hint style="info" %}
**Note:** If not configured, the data protection drives in the cluster stripes are automatically set, taking into account the number of backends with drives. There is also a default value for the cluster hot spare.
{% endhint %}

## Stage 12: Configuration of Hot Spare

**Command:** `cluster hot-spare`

To configure the Weka system hot spare, use the following command line:

`weka cluster hot-spare <count>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `hot-spare` | Number | Hot spare | The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 1 for clusters with 6 failure domains and 2 for clusters larger than this |

## Stage 13: Applying Hosts Configuration

**Command:** `weka cluster host apply`

This command is used to apply the Weka system cluster hosts' configuration. In the install phase, all hosts need to be added, so the `--all` parameter can be used.

To activate the cluster hosts, use the following command line:

`weka cluster host apply [--all] [<host-ids>...] [--force]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-ids` | Comma-separated strings | Comma-separated host identifiers |  | Either `host-ids` or `all` must be specified |  |
| `all` | Boolean | Apply all hosts |  | Either `host-ids` or `all` must be specified |  |
| `force` | Boolean | Do not prompt for confirmation |  | No | Off |

## Stage 14: Running the Start IO Command

**Command:** `weka cluster start-io`

To start the system IO and exit from the initialization phase, use the following command line:

`weka cluster start-io`

After successful completion of this command, the system exits the initialization state and runs accept IOs from the user applications.

