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
* **Configure the NFS export level (permissions)**
  * [Define client access groups](nfs-support-1.md#uploading-a-snapshot-using-the-ui)
  * [Manage client access groups](nfs-support-1.md#manage-client-access-groups)
  * [Manage NFS client permissions](nfs-support-1.md#manage-nfs-client-permissions)

## Create interface groups

**Command:** `weka nfs interface-group add`

Use the following command line to add an interface group:

`weka nfs interface-group add <name> <type> [--subnet subnet] [--gateway gateway] [--allow-manage-gids allow-manage-gids]`

**Parameters**

| **Name**            | **Type** | **Value**                                                                                                                                                                                                                                                                                | **Limitations**                                                                                                                                                                    | **Mandatory** | **Default**     |
| ------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | --------------- |
| `name`              | String   | Unique interface group name                                                                                                                                                                                                                                                              | Up to 11 characters in length                                                                                                                                                      | Yes           |                 |
| `type`              | String   | Group type                                                                                                                                                                                                                                                                               | Can only be  `NFS`                                                                                                                                                                 | Yes           |                 |
| `subnet`            | String   | The subnet mask in the 255.255.0.0 format                                                                                                                                                                                                                                                | Valid netmask                                                                                                                                                                      | No            | 255.255.255.255 |
| `gateway`           | String   | Gateway IP                                                                                                                                                                                                                                                                               | Valid IP                                                                                                                                                                           | No            | 255.255.255.255 |
| `allow-manage-gids` | String   | <p>Allows the hosts within this interface group to use <code>manage-gids</code> when set in exports. </p><p>With <code>manage-gids</code>, the list of group IDs received from the client will be replaced by a list of group IDs determined by an appropriate lookup on the server.</p> | <p><code>on</code> or <code>off</code>.</p><p>Cannot be set if one of the hosts belongs to an interface group which does not have the <code>allow-manage-gids</code> flag set.</p> | No            | `on`            |

{% hint style="warning" %}
**Notes:**

* Do not mount the same filesystem by containers residing in interface groups with different values of the `allow-manage-gids.`
* As a best practice, it is recommended to have only one of the following protocol containers, NFS, SMB, or S3, installed on the same server. Starting from version 4.2, setting more than one additional protocol to the existing POSIX is not allowed.
{% endhint %}

## Set interface group ports

**Commands:** `weka nfs interface-group port add`and `weka nfs interface-group port delete`

Use the following command lines to add/delete an interface group port:`weka nfs interface-group port add <name> <host-id> <port>`  \
`weka nfs interface-group port delete <name> <host-id> <port>`

**Parameters**

| **Name**  | **Type** | **Value**                                                                                      | **Limitations** | **Mandatory** | **Default** |
| --------- | -------- | ---------------------------------------------------------------------------------------------- | --------------- | ------------- | ----------- |
| `name`    | String   | Interface group name                                                                           | None            | Yes           |             |
| `host-id` | String   | Host ID on which the port resides (can be obtained by running the `weka cluster host` command) | Valid host ID   | Yes           |             |
| `port`    | String   | Port's device, e.g., eth1                                                                      | Valid device    | Yes           |             |

## Set interface group IPs

**Commands:** `weka nfs interface-group ip-range add`and `weka nfs interface-group ip-range delete`

Use the following command lines to add/delete an interface group IP:\
`weka nfs interface-group ip-range add <name> <ips>`\
`weka nfs interface-group ip-range delete <name> <ips>`

**Parameters**

| **Name** | **Type** | **Value**            | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | -------------------- | --------------- | ------------- | ----------- |
| `name`   | String   | Interface group name | None            | Yes           |             |
| `ips`    | String   | IP range             | Valid IP range  | Yes           |             |

{% hint style="info" %}
The AWS environment does not support interface group IPs.
{% endhint %}

## Configure the service mountd port

The mountd service receives requests from clients to mount to the NFS server. When working with interface groups (with `allow-manage-gids=on`), it is possible to set it explicitly, rather than have it randomly selected on each server startup. This allows an easier setup of the firewalls to allow that port.

Use the following command to set and view the mountd configuration: `weka nfs global-config set --mountd-port <mountd-port>` and `weka nfs global-config show`

## Define client access groups <a href="#uploading-a-snapshot-using-the-ui" id="uploading-a-snapshot-using-the-ui"></a>

**Command:** `weka nfs client-group`

Use the following command lines to add/delete a client access group:\
`weka nfs client-group add <name>`\
`weka nfs client-group delete <name>`

**Parameters**

| **Name** | **Type** | **Value**  | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ---------- | --------------- | ------------- | ----------- |
| `name`   | String   | Group name | Valid name      | Yes           |             |

## Manage client access groups

### **Add or delete DNS**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group DNS:\
`weka nfs rules add dns <name> <dns>`\
`weka nfs rules delete dns <name> <dns>`

**Parameters**

| **Name** | **Type** | **Value**                           | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ----------------------------------- | --------------- | ------------- | ----------- |
| `name`   | String   | Group name                          | Valid name      | Yes           |             |
| `dns`    | String   | DNS rule with \*?\[] wildcard rules |                 | Yes           |             |

### **Add or delete an IP**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group IP:\
`weka nfs rules add ip <name> <ip>`\
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

| **Name**             | **Type** | **Value**                                                                                                                                                                                  | **Limitations**                                                                                                                                                | **Mandatory**                      | **Default** |
| -------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- | ----------- |
| `filesystem`         | String   | Filesystem name                                                                                                                                                                            | <p>Existing filesystem.<br>A filesystem set with required authentication cannot be used for NFS export.</p>                                                    | Yes                                |             |
|  `group`             | String   | Client group name                                                                                                                                                                          | Existing client group                                                                                                                                          | Yes                                |             |
|  `path`              | String   | The root of the share                                                                                                                                                                      | Valid path                                                                                                                                                     | No                                 | /           |
| `permission-type`    | String   | Permission type                                                                                                                                                                            | <p><code>ro</code> for read-only or</p><p><code>rw</code> for read-write</p>                                                                                   | No                                 | `rw`        |
| `squash`             | String   | Squashing type                                                                                                                                                                             | `none` , `root` or `all` (`all` is supported only when working on hosts with intrface-groups set with  `allow-manage-gids,` otherwise it is treated as `root`) | No                                 | `on`        |
| `anon-uid`           | Number   | Anonymous user ID (relevant only for root squashing)                                                                                                                                       | Valid UID (between 1 and 65535)                                                                                                                                | Yes (if root squashing is enabled) | 65534       |
| `anon-gid`           | Number   | Anonymous user group ID (relevant only for root squashing)                                                                                                                                 | Valid GID (between 1 and 65535)                                                                                                                                | Yes (if root squashing is enabled) | 65534       |
| `obs-direct`         | Boolean  | See [Object-store Direct Mount](../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option) section                                       | `on` or `off`                                                                                                                                                  | No                                 | No          |
| `manage-gids`        | String   | <p>Sets external group IDs resolution.</p><p>The list of group IDs received from the client will be replaced by a list of group IDs determined by an appropriate lookup on the server.</p> | <p> <code>on</code> or <code>off</code>.</p><p>Relevant only when using<code>allow-manage-gids</code> interface groups.</p>                                    | No                                 | `off`       |
| `privileged-port`    | String   | Sets the share to only be mounted via privileged ports (1-1024), usually only allowed by the root user.                                                                                    | <p><code>on</code> or <code>off</code>.</p><p>Relevant only when using<code>allow-manage-gids</code> interface groups.</p>                                     | No                                 | `off`       |
| `supported-versions` | String   | A comma-separated list of supported NFS versions.                                                                                                                                          | `v3,v4`                                                                                                                                                        | No                                 | `v3`        |
