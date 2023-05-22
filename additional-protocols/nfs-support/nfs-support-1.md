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
**Note:** Do not mount the same filesystem by containers residing in interface groups with different values of the `allow-manage-gids.`
{% endhint %}

**Parameters**

| Name                | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Default           |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `name`\*            | <p>Unique interface group name.<br>Supports a maximum of 11 characters.</p>                                                                                                                                                                                                                                                                                                                                                                                                            |                   |
| `type`\*            | <p>Group type.<br>Can only be  <code>NFS</code>.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                   |                   |
| `subnet`            | The valid subnet mask in the 255.255.0.0 format.                                                                                                                                                                                                                                                                                                                                                                                                                                       | `255.255.255.255` |
| `gateway`           | Gateway valid IP.                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `255.255.255.255` |
| `allow-manage-gids` | <p>Allows the containers within this interface group to use <code>manage-gids</code> when set in exports. </p><p>With <code>manage-gids</code>, the list of group IDs received from the client is replaced by a list of group IDs determined by an appropriate lookup on the server.<br><br>NFS-W: <code>on</code></p><p>Legacy NFS: <code>off</code></p><p></p><p>Each container can be set to be part of interface groups with the same value of <code>allow-manage-gids</code>.</p> | `on`              |

## Set interface group ports

**Commands:**

`weka nfs interface-group port add`

`weka nfs interface-group port delete`

Use the following command lines to add or delete an interface group port:

`weka nfs interface-group port add <name> <container-id> <port>`

`weka nfs interface-group port delete <name> <container-id> <port>`

**Parameters**

| Name             | Value                                                                                                                                   |
| ---------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*         | Interface group name.                                                                                                                   |
| `container-id`\* | Valid frontend container ID on which the port resides. You can obtain the container ID by running the `weka cluster container` command. |
| `port`\*         | <p>Valid port's device.<br>Example: <code>eth1</code>.</p>                                                                              |

## Set interface group IPs

**Commands:**&#x20;

`weka nfs interface-group ip-range add`

`weka nfs interface-group ip-range delete`

Use the following command lines to add/delete an interface group IP:

`weka nfs interface-group ip-range add <name> <ips>`

`weka nfs interface-group ip-range delete <name> <ips>`

**Parameters**

| Name     | Value                |
| -------- | -------------------- |
| `name`\* | Interface group name |
| `ips`\*  | Valid IP range       |

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

| Name     | Value             |
| -------- | ----------------- |
| `name`\* | Valid group name. |

## Manage client access groups

### **Add or delete DNS**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group DNS:

`weka nfs rules add dns <name> <dns>`

`weka nfs rules delete dns <name> <dns>`

**Parameters**

| Name     | Value                                |
| -------- | ------------------------------------ |
| `name`\* | Valid group name.                    |
| `dns`\*  | DNS rule with \*?\[] wildcard rules. |

### **Add or delete an IP**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group IP:

`weka nfs rules add ip <name> <ip>`

`weka nfs rules delete ip <name> <ip>`

**Parameters**

| Name     | Value                                                                          |
| -------- | ------------------------------------------------------------------------------ |
| `name`\* | Valid group name.                                                              |
| `ip`\*   | <p>Valid IP with netmask rule.<br>Format: <code>1.1.1.1/255.255.0.0</code></p> |

## **Manage NFS client permissions**

**Command:** `weka nfs permission`

Use the following command lines to add/update/delete NFS permissions:\
`weka nfs permission add <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port]`

`weka nfs permission update <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions]`

`weka nfs permission delete <filesystem> <group> [--path path]`

**Parameters**

| Name                 | Value                                                                                                                                                                                                                                                                       | Default |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `filesystem`\*       | <p>Existing filesystem name.<br>A filesystem with Required Authentication set to ON cannot be used for NFS client permissions.</p>                                                                                                                                          |         |
|  `group`\*           | Existing client group name.                                                                                                                                                                                                                                                 |         |
|  `path`              | The root of the valid share path.                                                                                                                                                                                                                                           | /       |
| `permission-type`    | <p>Permission type.<br>Possible values: <code>ro</code> (read-only), <code>rw</code> (read-write)</p>                                                                                                                                                                       | `rw`    |
| `squash`             | <p>Squashing type.<br>Possible values: <code>none</code> , <code>root</code>, <code>all</code> <br><br><code>all</code> is only applicable for NFS-W. Otherwise, it is treated as <code>root</code>.</p>                                                                    | `none`  |
| `anon-uid`\*         | <p>Anonymous user ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</p>                                                                                                                                                    | `65534` |
| `anon-gid`\*         | <p>Anonymous user group ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</p>                                                                                                                                              | `65534` |
| `obs-direct`         | <p>See <a href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a>.<br>Possible values: <code>on</code>, <code>off</code>.</p>                                                      | `on`    |
| `manage-gids`        | <p>Sets external group IDs resolution.</p><p>The list of group IDs received from the client is replaced by a list determined by an appropriate lookup on the server.<br>This option is only applicable in NFS-W.<br>Possible values: <code>on</code>, <code>off</code>.</p> | `off`   |
| `privileged-port`    | <p>Sets the share only to be mounted via privileged ports (1-1024), usually allowed by the root user.<br>This option is only applicable in NFS-W.<br>Possible values: <code>on</code>, <code>off</code>.</p>                                                                | `off`   |
| `supported-versions` | <p>A comma-separated list of supported NFS versions.<br>Possible values: <code>v3</code>, <code>v4</code>.<br><code>v4</code> is only applicable in NFS-W.</p>                                                                                                              | `v3`    |
