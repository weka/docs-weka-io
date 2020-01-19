---
description: This page describes the stages in the installation process when using the CLI.
---

# WekaIO System Installation Process Using the CLI

## Stage 1: Installation of the WekaIO Software on Each Host

Run the untar command and `install.sh` command, according to the instructions, on each host.

On completion of this stage in the installation process, the WekaIO software is installed on all the allocated hosts and running in the stem mode i.e., no cluster is attached and the WekaIO system is awaiting instructions.

{% hint style="info" %}
**Note:** If a failure occurs during this installation stage, an error message detailing the source of the failure will be received. If possible, try to recover this error or alternatively, contact the WekaIO Support Team.
{% endhint %}

## Stage 2: Formation of a Cluster from the Hosts

**Command:** `cluster create`

This stage involves the formation of a cluster from the allocated hosts. It is performed using the following command line:

 `weka cluster create <hostnames> [--host-ips <ips | ip+ip>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `hostnames` | Space- separated strings | Host names or IP addresses | Need at least 6 strings, as this is the minimal cluster size | Yes |  |
| `host-ips` | Comma- separated IP addresses | IP addresses of the management interfaces. Use a list of ip+ip addresses pairs of two cards for HA configuration | Same number of values as in `hostnames`.  | Only in IB | Hostnames will be resolved |

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

This command is used to give the cluster a name. Although this is optional, it is highly recommended, because the name enables cloud event notification and increases the ability of the WekaIO Support Team to resolve any issues that may occur. To perform this operation, use the following command line:

`weka cluster update --cluster-name=<name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `cluster-name` | String | Identifier of the cluster name | Must be a valid identifier | No |  |

## Stage 4: Enabling Cloud Event Notifications \(optional\)

### **Enabling Support via Weka Home**

**Command:** `weka cloud enable`

This command enables cloud event notification \(via Weka Home\), which increases the ability of the WekaIO Support Team to resolve any issues that may occur. 

To learn more about this and how to enable cloud event notification, refer to [WekaIO Support Cloud](../../support/the-wekaio-support-cloud.md).

### For Private Instance of Weka Home

In closed environments, such as dark sites and private VPCs, it is possible to install a private instance of Weka Home.

**Command:** `weka cloud enable --cloud-url=http://<weka-home-ip>:<weka-home-port>`

This command enables the use of a private instance of Weka Home. 

{% hint style="info" %}
For more information, refer to [Private Instance of Weka Home](../../support/the-wekaio-support-cloud.md#private-instance-of-weka-home) and contact the WekaIO Support Team.
{% endhint %}

## Stage 5: Configuration of Networking

**Command:** `cluster host net add`

When PKEYs are used, the device name for InfiniBand should follow the name.PKEY convention.

{% hint style="info" %}
**Note:** Although in general, devices can be renamed arbitrarily, WekaIO will only function correctly if the .PKEY naming convention is followed.
{% endhint %}

The networking type can be either Ethernet \(direct over DPDK\) or InfiniBand \(IB\). A physical network device must be specified for both types. This can be a device dedicated to the WekaIO system, or a device that is also being used for other purposes in parallel. For IP over DPDK, the standard routing parameters can be specified for routed networks.

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
      <td style="text-align:left">The data plane IP addresses for internal WekaIO system traffic. In IB,
        use the IPoIB address</td>
      <td style="text-align:left">Must be part of the data plane IP pool defined in the planning phase.
        See <a href="../../overview/networking-in-wekaio.md#backend-hosts">WekaIO Networking</a> and
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
</table>The number of IP addresses should be according to [WekaIO Networking](../../overview/networking-in-wekaio.md#backend-hosts) and [Networking Prerequisites](prerequisites-for-installation-of-weka-dedicated-hosts.md#networking).

{% hint style="info" %}
Additional IP addresses may be assigned for each host, if IP per core is needed. In this case, unused IP addresses are reserved for future expansion process, and can be automatically assigned if number of cores assigned to WekaIO system on that host is increased.
{% endhint %}

{% hint style="info" %}
**Note:** For HA configurations, this command has to be run separately for each interface.
{% endhint %}

### Optional: Configure default data networking

**Command:** `cluster default-net set`

Instead of explicit IP address configuration per each network device, dynamic IP address allocation is supported. WekaIO supports adding a range of IP addresses to a dynamic pool, from which the IP addresses can be automatically allocated on demand. 

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
</table>To view the current default data networking settings use the command `weka cluster default-net`.

If a default data networking was previously configured on a cluster and is no longer needed, it is possible to remove it using the command `weka cluster default-net reset`.

## Stage 6: Configuration of SSDs

**Command:** `cluster drive add`

This stage in the installation process is used to add a local SSD to be used by a WekaIO filesystem. The same command can be used for adding multiple drive paths. To perform this operation, use the following command line:

`weka cluster drive add <host-id> <device-path>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host to which a local SSD will be added | Must be a valid host identifier | Yes |  |
| `device` | String | A block device that identifies a local SSD, e.g., `/dev/sdb` | Must be a valid Unix network device name | Yes |  |

{% hint style="info" %}
**Note:** If, due to some technical limitation, the use of an NVMe device through the kernel is required, contact the WekaIO Support Team.
{% endhint %}

## Stage 7: **Scanning Drives**

**Command:**`weka cluster drive scan`

After provisioning the SSDs to be used by a WekaIO filesystem using the previous command, it is also necessary to scan them so that they are recognizable by the system internally. To perform this operation, use the following command line:

`weka cluster drive scan`

## Stage 8: Configuration of CPU Resources

**Command:** `cluster host cores`

This stage in the installation process is used to configure the amount of CPU resources, which are physical rather than logical cores. To perform this operation, use the following command line:

`weka cluster host cores <host-id> <cores> [--frontend-dedicated-cores <fe_cores>] [--drives-dedicated-cores <be_cores>] [--cores-ids <cores_ids>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host in which a core count should be configured | Must be a valid host identifier | Yes |  |
| `cores` | Number | Number of physical cores to be allocated to the WekaIO system | Should be less than the number of physical cores in the host \(leaving 1 core for the OS\) . Maximum 19 cores | Yes |  |
| `frontend-dedicated-cores` | Number | Number of physical cores to be dedicated to FrontEnd processes | The total of fe\_cores and be\_cores must be less than cores above | No | zero |
| `drives-dedicated-cores` | Number | Number of physical cores to be dedicated to Drive/SSD processes | The total of fe\_cores and be\_cores must be less than cores above | No | Typically 1 core per drive or 1/2 core per drive/SSD |
| `cores_ids` | Comma-separated list Numbers | Physical Core numbers | Specification of which cores to use. | No | Select cores automatically |

{% hint style="info" %}
**Note:** Performance can be optimized by assigning different functions to the various WekaIO cores. If necessary, contact the WekaIO Support Team for more information.
{% endhint %}

## Stage 9: Configuration of Memory \(optional\)

**Command:** `cluster host memory`

As defined in the memory requirements, the fixed memory per host and the per core memory are automatically computed by the WekaIO system. For the capacity-oriented memory, a default of 1.4 GB per host is allocated. If capacity requirements mandate more memory per host, the following command should be used: 

`weka cluster host memory <host-id> <capacity-memory>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host in which the memory configuration has to be defined | Must be a valid host identifier | Yes |  |
| `capacity-memory` | Number | Required memory in bytes |  | Yes |  |

{% hint style="info" %}
**Note:** This command is for initialization phase only.  To adjust the memory of a running cluster, contact the WekaIO Support Team.
{% endhint %}

{% hint style="info" %}
This commands sets only the capacity portion of the memory requirements. The per-host and per-core requirements are set automatically by Weka
{% endhint %}

## Stage 10: Configuration of Failure Domains \(optional\)

**Command:** `cluster host failure-domain`

This optional stage in the installation process is used to assign a host to a failure domain. If the specified failure domain does not exist, it will be created by this command. If the host is assigned to another failure domain, it will be reassigned by this command.

{% hint style="info" %}
**Note:** All hosts not assigned to any failure domain will be considered by the WekaIO system as an additional failure domain. However, it is good practice to either not define failure domains at all or to assign each host to a single failure domain.
{% endhint %}

This operation is performed using the following command line: 

`weka cluster host failure-domain <host-id> [--name <fd-name>] | [--auto]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host in which the failure domain should be configured | Must be a valid host identifier | Yes |  |
| `name` | String | The failure domain that will contain the host from now |  | Yes \(either `--name` OR `--auto` must be specified\) | None |
| `auto` | n/a | n/a | Will automatically assign fd-name | Yes \(either `--name` OR `--auto` must be specified\) | None |

## Stage 11: Configuration of WekaIO System Protection Scheme

**Command:** `cluster update`

To configure the WekaIO system protection scheme, use the following command line:

`weka cluster update [--data-drives=<num>] [--parity-drives=<num>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `data-drives` | Number | Protection stripe width | Between 3-16. The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 3 |
| `parity-drives` | Number | Protection level | Either 2 or 4. The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 2 |

{% hint style="info" %}
**Note:** This command can only be used in the initialization phase.
{% endhint %}

{% hint style="info" %}
**Note:** If not configured, the data protection drives in the cluster stripes are automatically set, taking into account the number of backends with drives. There is also a default value for the cluster hot spare.
{% endhint %}

## Stage 12: Configuration of Hot Spare

**Command:** `cluster hot-spare`

To configure the WekaIO system hot spare, use the following command line:

`weka cluster hot-spare <count>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `hot-spare` | Number | Hot spare | The number of failure domains cannot be smaller than the stripe width + the protection level + hot spare | No | 1 for clusters with 6 failure domains and 2 for clusters larger than this |

## Stage 13: Activation of Cluster Hosts

**Command:** `weka cluster host activate`

This command is used to activate the WekaIO system cluster host. When it is run, a comma-separated list of all host names is received. In the install phase, all hosts need to be added, so the default of no parameter can be used.

To activate the cluster hosts, use the following command line:

 `weka cluster host activate [<host-ids>...]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-ids` | Comma-separated strings | Comma-separated host identifiers |  | No | All hosts |

## Stage 14: Activation of Cluster SSDs

**Command:** `weka cluster drive activate`

This command is used to mark the WekaIO system SSDs as active, so they are in-use by the cluster. To activate the cluster SSDs, use the following command line:

`weka cluster drive activate [<uuids>...]`

A comma-separated list of all SSD UUIDs is received. In the install phase all SSDs need to be active, so the default of no parameter can be used.

{% hint style="info" %}
**Note:** To obtain the drive UUIDs, it is possible to use either the output received from a previously run `weka cluster drive add` command, or alternatively use the drive listing command `weka cluster drive`, which will list all drives and their UUIDs.
{% endhint %}

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `uuids` | Comma-separated strings | Comma-separated host identifiers |  | No | All SSDs |

## Stage 15: Running the Start IO Command

**Command:** `weka cluster start-io`

To start the system IO and exit from the initialization phase, use the following command line: 

`weka cluster start-io`

After successful completion of this command, the system exits the initialization state and runs accept IOs from the user applications.

