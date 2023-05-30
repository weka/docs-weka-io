---
description: This page describes how to configure the NFS networking using the CLI.
---

# Manage NFS networking using the CLI

Using the CLI, you can:

* **Configure the NFS cluster level**
  * [Create interface groups](nfs-support-1.md#define-interface-groups)
  * [Set interface group ports](nfs-support-1.md#set-interface-group-ports)
  * [Set interface group IPs](nfs-support-1.md#set-interface-group-ips)
  * [Configure the service mountd port](nfs-support-1.md#configure-the-service-mountd-port)
  * [Configure the NFS configuration filesystem](nfs-support-1.md#configure-the-nfs-configuration-filesystem)
* **Configure the NFS export level (permissions)**
  * [Define client access groups](nfs-support-1.md#uploading-a-snapshot-using-the-ui)
  * [Manage client access groups](nfs-support-1.md#manage-client-access-groups)
  * [Manage NFS client permissions](nfs-support-1.md#manage-nfs-client-permissions)

## Create interface groups

**Command:** `weka nfs interface-group add`

Use the following command line to add an interface group:

`weka nfs interface-group add <name> <type> [--subnet subnet] [--gateway gateway] [--allow-manage-gids allow-manage-gids]`

The parameter `allow-manage-gids` determines the type of NFS stack. The default value of this parameter is `on`, which sets the NFS-W stack.

{% hint style="warning" %}
**Notes:**

* Do not mount the same filesystem by containers residing in interface groups with different values of the `allow-manage-gids.`
* As a best practice, it is recommended to have only one of the following protocol containers, NFS, SMB, or S3, installed on the same server. Starting from version 4.2, setting more than one additional protocol to the existing POSIX is not allowed.
{% endhint %}

**Parameters**

| **Name**            | **Type** | **Value**                                                                                                                                                                                                                                                                                | **Limitations**                                                                                                                                                                               | **Mandatory** | **Default**     |
| ------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | --------------- |
| `name`              | String   | Unique interface group name                                                                                                                                                                                                                                                              | Up to 11 characters in length                                                                                                                                                                 | Yes           |                 |
| `type`              | String   | Group type                                                                                                                                                                                                                                                                               | Can only be  `NFS`                                                                                                                                                                            | Yes           |                 |
| `subnet`            | String   | The subnet mask in the 255.255.0.0 format                                                                                                                                                                                                                                                | Valid netmask                                                                                                                                                                                 | No            | 255.255.255.255 |
| `gateway`           | String   | Gateway IP                                                                                                                                                                                                                                                                               | Valid IP                                                                                                                                                                                      | No            | 255.255.255.255 |
| `allow-manage-gids` | String   | <p>Allows the containers within this interface group to use <code>manage-gids</code> when set in exports. </p><p>With <code>manage-gids</code>, the list of group IDs received from the client is replaced by a list of group IDs determined by an appropriate lookup on the server.</p> | <p>NFS-W: <code>on</code></p><p>Legacy NFS: <code>off</code></p><p></p><p>Each container can be set to be part of interface groups with the same value of <code>allow-manage-gids</code>.</p> | No            | `on`            |

## Set interface group ports

**Commands:**

`weka nfs interface-group port add`

`weka nfs interface-group port delete`

Use the following command lines to add or delete an interface group port:

`weka nfs interface-group port add <name> <container-id> <port>`

`weka nfs interface-group port delete <name> <container-id> <port>`

**Parameters**

<table data-header-hidden><thead><tr><th width="189">Name</th><th>Type</th><th width="265">Value</th><th width="181">Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>name</code></td><td>String</td><td>Interface group name</td><td>None</td><td>Yes</td><td></td></tr><tr><td><code>container-id</code></td><td>String</td><td>Container ID on which the port resides (can be obtained by running the <code>weka cluster container</code> command)</td><td>Valid container ID</td><td>Yes</td><td></td></tr><tr><td><code>port</code></td><td>String</td><td>Port's device, e.g., eth1</td><td>Valid device</td><td>Yes</td><td></td></tr></tbody></table>

## Set interface group IPs

**Commands:**&#x20;

`weka nfs interface-group ip-range add`

`weka nfs interface-group ip-range delete`

Use the following command lines to add/delete an interface group IP:

`weka nfs interface-group ip-range add <name> <ips>`

`weka nfs interface-group ip-range delete <name> <ips>`

**Parameters**

| **Name** | **Type** | **Value**            | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | -------------------- | --------------- | ------------- | ----------- |
| `name`   | String   | Interface group name | None            | Yes           |             |
| `ips`    | String   | IP range             | Valid IP range  | Yes           |             |

{% hint style="info" %}
**Note:** Cloud environments do not support interface group IPs.
{% endhint %}

## Configure the service mountd port

The mountd service receives requests from clients to mount to the NFS server. In NFS-W, it is possible to set it explicitly rather than have it randomly selected on each server startup. This allows an easier setup of the firewalls to allow that port.

Use the following command lines to set and view the mountd configuration:

`weka nfs global-config set --mountd-port <mountd-port>`&#x20;

`weka nfs global-config show`

## Configure the NFS configuration filesystem <a href="#configure-the-nfs-configuration-filesystem" id="configure-the-nfs-configuration-filesystem"></a>

The NFS configuration filesystem is used as a shared location for persisting cluster-wide NFS configuration. This setting only applies to NFSv4. It is recommended to allocate 100 GB to support future system expansions.&#x20;

Use the following command line to set the NFS configuration filesystem:

`weka nfs global-config set --config-fs <config-fs>`&#x20;

## Define client access groups <a href="#uploading-a-snapshot-using-the-ui" id="uploading-a-snapshot-using-the-ui"></a>

**Command:** `weka nfs client-group`

Use the following command lines to add/delete a client access group:

`weka nfs client-group add <name>`

`weka nfs client-group delete <name>`

**Parameters**

| **Name** | **Type** | **Value**  | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ---------- | --------------- | ------------- | ----------- |
| `name`   | String   | Group name | Valid name      | Yes           |             |

## Manage client access groups

### **Add or delete DNS**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group DNS:

`weka nfs rules add dns <name> <dns>`

`weka nfs rules delete dns <name> <dns>`

**Parameters**

| **Name** | **Type** | **Value**                           | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ----------------------------------- | --------------- | ------------- | ----------- |
| `name`   | String   | Group name                          | Valid name      | Yes           |             |
| `dns`    | String   | DNS rule with \*?\[] wildcard rules |                 | Yes           |             |

### **Add or delete an IP**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group IP:

`weka nfs rules add ip <name> <ip>`

`weka nfs rules delete ip <name> <ip>`

**Parameters**

| **Name** | **Type** | **Value**                                               | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------------------------------------- | --------------- | ------------- | ----------- |
| `name`   | String   | Group name                                              | Valid name      | Yes           |             |
| `ip`     | String   | IP with netmask rule, in the 1.1.1.1/255.255.0.0 format | Valid IP        | Yes           |             |

## **Manage NFS client permissions**

**Command:** `weka nfs permission`

Use the following command lines to add/update/delete NFS permissions:\
`weka nfs permission add <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port]`

`weka nfs permission update <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions]`

`weka nfs permission delete <filesystem> <group> [--path path]`

**Parameters**

<table data-header-hidden><thead><tr><th width="183">Name</th><th width="131">Type</th><th width="270">Value</th><th width="236">Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>filesystem</code></td><td>String</td><td>Filesystem name</td><td>Existing filesystem.<br>A filesystem set with required authentication cannot be used for NFS client permissions.</td><td>Yes</td><td></td></tr><tr><td> <code>group</code></td><td>String</td><td>Client group name</td><td>Existing client group</td><td>Yes</td><td></td></tr><tr><td> <code>path</code></td><td>String</td><td>The root of the share</td><td>Valid path</td><td>No</td><td>/</td></tr><tr><td><code>permission-type</code></td><td>String</td><td>Permission type </td><td><p><code>ro</code> for read-only or</p><p><code>rw</code> for read-write</p></td><td>No</td><td><code>rw</code></td></tr><tr><td><code>squash</code></td><td>String</td><td>Squashing type</td><td><code>none</code> , <code>root</code> or <code>all</code> <br><br><code>all</code> is only applicable in NFS-W. Otherwise, it is treated as <code>root</code>.</td><td>No</td><td><code>on</code></td></tr><tr><td><code>anon-uid</code></td><td>Number</td><td>Anonymous user ID (relevant only for root squashing)</td><td>Valid UID (between 1 and 65535)</td><td>Yes (if root squashing is enabled)</td><td>65534</td></tr><tr><td><code>anon-gid</code></td><td>Number</td><td>Anonymous user group ID (relevant only for root squashing)</td><td>Valid GID (between 1 and 65535)</td><td>Yes (if root squashing is enabled)</td><td>65534</td></tr><tr><td><code>obs-direct</code></td><td>Boolean</td><td>See <a href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a> section</td><td><code>on</code> or <code>off</code></td><td>No</td><td>No</td></tr><tr><td><code>manage-gids</code></td><td>String</td><td><p>Sets external group IDs resolution.</p><p>The list of group IDs received from the client is replaced by a list of group IDs determined by an appropriate lookup on the server.</p></td><td><p><code>on</code> or <code>off</code>.</p><p><br>This option is only applicable in NFS-W.</p></td><td>No</td><td><code>off</code></td></tr><tr><td><code>privileged-port</code></td><td>String</td><td>Sets the share to only be mounted via privileged ports (1-1024), usually only allowed by the root user.</td><td><p><code>on</code> or <code>off</code>.</p><p><br>This option is only applicable in NFS-W.</p></td><td>No</td><td><code>off</code></td></tr><tr><td><code>supported-versions</code></td><td>String</td><td>A comma-separated list of supported NFS versions.</td><td><code>v3,v4</code><br><br><code>v4</code> is only applicable in NFS-W.</td><td>No</td><td><code>v3</code></td></tr></tbody></table>
