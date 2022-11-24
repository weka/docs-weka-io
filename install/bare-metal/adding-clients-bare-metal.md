---
description: This page describes how to add clients to a bare-metal cluster.
---

# Add clients

## About clients

Clients are used to running applications that need to access the Weka filesystems. They do not contribute CPUs or drives to the cluster and only connect to the cluster to use its filesystems.

## Add stateless clients

To use the Weka filesystems from a client, all that is needed is to call the mount command. The mount command automatically installs the software version, and there is no need to join the client to the cluster.

To mount a filesystem in this manner, first, install the Weka agent from one of the backend instances and then mount the filesystem. For example:

```
# Agent Installation (one time)
curl http://Backend-1:14000/dist/v1/install | sh

# Creating a mount point (one time)
mkdir -p /mnt/weka

# Mounting a filesystem
mount -t wekafs Backend-1/my_fs /mnt/weka
```

For the first mount, this will install the Weka software and automatically configure the client. For more information on mount and configuration options, refer to [Mounting filesystems using the stateless clients feature](../../fs/mounting-filesystems.md#mounting-filesystems-using-stateless-clients).

It is possible to configure the client OS to automatically mount the filesystem at boot time. For more information refer to [Mounting Filesystems Using fstab](../../fs/mounting-filesystems.md#mounting-filesystems-using-fstab) or [Mounting Filesystems Using autofs](../../fs/mounting-filesystems.md#mounting-filesystems-using-autofs).

{% hint style="info" %}
**Note:** Clients can be deployed on [diskless servers](https://en.wikipedia.org/wiki/Diskless\_node). They can use RAM for Weka client software and NFS mount for the traces. For more information, contact the Weka Support Team.
{% endhint %}

{% hint style="info" %}
**Note:** The different clients must have a unique IP and FQDN.
{% endhint %}

## Add stateful clients, which are always part of the cluster

{% hint style="info" %}
**Note:** It is possible to add instances that do not contribute resources to the cluster but are used for mounting filesystems. It is recommended to use the previously described method for adding client instances for mounting purposes. However, in some cases it could be useful to permanently add them to the cluster, e.g., to use these instances as NFS/SMB servers which are always expected to be up.
{% endhint %}

### Stage 1: Install the Weka software

Verify that the Weka software is installed on the client according to the installation instructions. For further information, see [Obtaining the Weka Install File](obtaining-the-weka-install-file.md) and [Stage 1 in Weka System Installation Process.](using-cli.md#stage-1-installation-of-the-wekaio-software-on-each-host)

{% hint style="info" %}
**Note:** All clients in a Weka system cluster must use the same software version as the backends or a maximum of one version back. The backend containers must run the same Weka software version except during upgrades (as managed by the upgrade process).
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
| `cores`                    | Number   | Number of physical cores to be allocated to the Weka client    | Maximum 19 cores                                                                                | Yes                                       |             |
| `frontend-dedicated-cores` | Number   | Number of physical cores to be dedicated to FrontEnd processes | <p></p><p>For clients, the number of total cores and frontend-dedicated-cores must be equal</p> | Yes, to configure a container as a client |             |

### Stage 4: Configure client networking

**Command:** `weka cluster container net add`

{% hint style="info" %}
**Note:** If the new client is to communicate with the Weka system cluster over the kernel UDP stack, it is not necessary to run this command.
{% endhint %}

If a high-performance client is required and the appropriate network NIC is available, use the following command to configure the networking interface used by the client to communicate with the Weka system cluster:

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
