---
description: This page describes how to add clients to a bare-metal cluster.
---

# Add clients

## About clients

Clients are used to run applications that need to access the WEKA filesystems. They do not contribute CPUs or drives to the cluster and only connect to the cluster to use its filesystems.

## Add stateless clients

To use the WEKA filesystems from a client, just call the mount command. The mount command automatically installs the software version, and there is no need to join the client to the cluster.

To mount a filesystem in this method, first, install the WEKA agent from one of the backend instances and then mount the filesystem.

Example:

<pre><code># Agent Installation (one time)
curl http://Backend-1:14000/dist/v1/install | sh

# Creating a mount point (one time)
mkdir -p /mnt/weka

# Mounting a filesystem
<strong>mount -t wekafs -o net=eth0 backend-1/my_fs /mnt/weka
</strong></code></pre>

For the first mount, this installs the WEKA software and automatically configures the client. For more information on mount and configuration options, refer to [Mount a filesystem using the stateless clients feature](../../fs/mounting-filesystems.md#mounting-filesystems-using-stateless-clients).

It is possible to configure the client OS to automatically mount the filesystem at boot time. For more information, refer to [Mount a filesystem using the traditional method](../../fs/mounting-filesystems.md#mount-a-filesystem-using-the-traditional-method) or [Mount filesystems using autofs](../../fs/mounting-filesystems.md#mount-filesystems-using-autofs).

{% hint style="info" %}
**Note:** Clients can be deployed on [diskless servers](https://en.wikipedia.org/wiki/Diskless\_node). They can use RAM for WEKA client software and NFS mount for the traces. For more information, contact the Customer Success Team.
{% endhint %}

{% hint style="info" %}
**Note:** Each client must have a unique IP and FQDN.
{% endhint %}

## Add stateful clients, which are always part of the cluster

{% hint style="info" %}
**Note:** It is possible to add instances that do not contribute resources to the cluster but are used for mounting filesystems. It is recommended to use the previously described method for adding client instances for mounting purposes. However, in some cases, it could be useful to permanently add them to the cluster, e.g., to use these instances as NFS/SMB servers which are always expected to be up.
{% endhint %}

### Stage 1: Install the WEKA software

Verify that the WEKA software is installed on the client according to the installation instructions. For further information, see [Download the WEKA software installation file](obtaining-the-weka-install-file.md) and [1. Install the WEKA software](weka-system-installation-with-multiple-containers-using-the-cli.md#1.-install-the-weka-software).

{% hint style="info" %}
**Note:** All clients in a WEKA system cluster must use the same software version as the backends or a maximum of one version back. The backend containers must run the same WEKA software version except during upgrades (as managed by the upgrade process).
{% endhint %}

### Stage 2: Join the cluster

**Command:** `weka cluster container add`

Once the client is in the stem mode (this is the mode defined immediately after running the `install.sh`command), use the following command line on the client to add it to the cluster:

`weka -H <backend-hostname> cluster container add <client-hostname>`

**Parameters in command line**

| **Name**           | **Type** | **Value**                                                           | **Limitations**          | **Mandatory** | **Default** |
| ------------------ | -------- | ------------------------------------------------------------------- | ------------------------ | ------------- | ----------- |
| `backend-hostname` | String   | IP/hostname of one of the existing backend instances in the cluster | Existing backend IP/FQDN | Yes           |             |
| `client-hostname`  | String   | IP/hostname of the client currently being added                     | Unique IP/FQDN           | Yes           |             |

{% hint style="info" %}
**Note:** On completion of this stage, the container-id of the newly added container will be received. Make a note of it for the next steps.
{% endhint %}

### Stage 3: Configure the container as a client

**Command:** `weka cluster container cores`

To configure the new container as a client, run the following command:

`weka cluster container cores <container-id> <cores> --frontend-dedicated-cores=<frontend-dedicated-cores>`

**Parameters in command line**

| **Name**                   | **Type** | **Value**                                                      | **Limitations**                                                                                 | **Mandatory**                             | **Default** |
| -------------------------- | -------- | -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------------------------- | ----------- |
| `container-id`             | String   | Identifier of the container to be added to the cluster         | Must be a valid container identifier                                                            | Yes                                       |             |
| `cores`                    | Number   | Number of physical cores to be allocated to the WEKA client    | Maximum 19 cores                                                                                | Yes                                       |             |
| `frontend-dedicated-cores` | Number   | Number of physical cores to be dedicated to FrontEnd processes | <p></p><p>For clients, the number of total cores and frontend-dedicated-cores must be equal</p> | Yes, to configure a container as a client |             |

### Stage 4: Configure client networking

**Command:** `weka cluster container net add`

{% hint style="info" %}
**Note:** If the new client is to communicate with the WEKA cluster over the kernel UDP stack, it is not necessary to run this command.
{% endhint %}

If a high-performance client is required and the appropriate network NIC is available, use the following command to configure the networking interface used by the client to communicate with the WEKA cluster:

`weka cluster container net add <container-id> <device> --ips=<ips> --netmask=<netmask> --gateway=<gateway>`

**Parameters in command line**

| **Name**       | **Type**   | **Value**                                                                               | **Limitations**                                                                                                                                                              | **Mandatory** | **Default** |
| -------------- | ---------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `container-id` | String     | Identifier of the container to be added to the cluster                                  | Must be a valid container identifier                                                                                                                                         | Yes           |             |
| `device`       | String     | Network interface device name e.g., `eth1`                                              | Must be a valid network device name                                                                                                                                          | Yes           |             |
| `ips`          | IP address | The IP address of the new interface                                                     | Must be a valid IP address                                                                                                                                                   | Yes           |             |
| `gateway`      | IP address | The IP address of the default routing gateway                                           | <p>The gateway must reside within the same IP network of <code>ips</code> (as described by <code>netmask</code>). </p><p>Not relevant for IB / L2 non-routable networks.</p> | No            |             |
| `netmask`      | Number     | Number of bits in the netmask, e.g., the netmask of `255.255.0.0` has `16` netmask bits | Describes the number of bits that identify a network ID (also known as CIDR).                                                                                                | No            |             |

{% hint style="info" %}
**Note:** When configuring an InfiniBand client, do not pass the `--ips`, `--netmask` and `--gateway` parameters.
{% endhint %}

{% hint style="info" %}
**Note:** InfiniBand/Ethernet clients can only join a cluster with the same network technology connectivity. It is possible to mix InfiniBand and Ethernet clients in the same cluster as long as the cluster backends are connected to both network technologies.
{% endhint %}

### Stage 5: Apply the container configuration

**Command:** `weka cluster container apply`

After successfully configuring the container and its network device, run the following command to finalize the configuration by activating the container:

`weka cluster container apply <container-id> [--force]`

**Parameters in command line**

| **Name**       | **Type**               | **Value**                                              | **Limitations**                      | **Mandatory** | **Default** |
| -------------- | ---------------------- | ------------------------------------------------------ | ------------------------------------ | ------------- | ----------- |
| `container-id` | Comma-separated string | Identifier of the container to be added to the cluster | Must be a valid container identifier | Yes           |             |
| `force`        | Boolean                | Do not prompt for confirmation                         |                                      | No            | Off         |
