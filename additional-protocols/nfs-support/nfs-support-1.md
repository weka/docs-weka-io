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
  * [Set the global configuration filesystem](nfs-support-1.md#configure-the-nfs-configuration-filesystem)
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
Do not mount the same filesystem by containers residing in interface groups with different values of the `allow-manage-gids.`
{% endhint %}

**Parameters**

<table><thead><tr><th width="225">Name</th><th width="325">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Unique interface group name.<br>Supports a maximum of 11 characters.</td><td></td></tr><tr><td><code>type</code>*</td><td>Group type.<br>Can only be  <code>NFS</code>.</td><td></td></tr><tr><td><code>subnet</code></td><td>The valid subnet mask in the 255.255.0.0 format.</td><td><code>255.255.255.255</code></td></tr><tr><td><code>gateway</code></td><td>Gateway valid IP.</td><td><code>255.255.255.255</code></td></tr><tr><td><code>allow-manage-gids</code></td><td><p>Allows the containers within this interface group to use <code>manage-gids</code> when set in exports. </p><p>With <code>manage-gids</code>, the list of group IDs received from the client is replaced by a list of group IDs determined by an appropriate lookup on the server.<br><br>NFS-W: <code>on</code></p><p>Legacy NFS: <code>off</code></p><p></p><p>Each container can be set to be part of interface groups with the same value of <code>allow-manage-gids</code>.</p></td><td><code>on</code></td></tr></tbody></table>

## Set interface group ports

**Commands:**

`weka nfs interface-group port add`

`weka nfs interface-group port delete`

Use the following command lines to add or delete an interface group port:

`weka nfs interface-group port add <name> <container-id> <port>`

`weka nfs interface-group port delete <name> <container-id> <port>`

**Parameters**

<table><thead><tr><th width="220">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Interface group name.</td></tr><tr><td><code>container-id</code>*</td><td>Valid frontend container ID on which the port resides. You can obtain the container ID by running the <code>weka cluster container</code> command.</td></tr><tr><td><code>port</code>*</td><td>Valid port's device.<br>Example: <code>eth1</code>.</td></tr></tbody></table>

## Set interface group IPs

**Commands:**&#x20;

`weka nfs interface-group ip-range add`

`weka nfs interface-group ip-range delete`

Use the following command lines to add/delete an interface group IP:

`weka nfs interface-group ip-range add <name> <ips>`

`weka nfs interface-group ip-range delete <name> <ips>`

**Parameters**

<table><thead><tr><th width="222">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Interface group name</td></tr><tr><td><code>ips</code>*</td><td>Valid IP range</td></tr></tbody></table>

{% hint style="info" %}
Cloud environments do not support interface group IPs.
{% endhint %}

## Configure the service mountd port

The mountd service receives requests from clients to mount to the NFS server. In NFS-W, it is possible to set it explicitly rather than have it randomly selected on each server startup. This allows an easier setup of the firewalls to allow that port.

Use the following command lines to set and view the mountd configuration:

`weka nfs global-config set --mountd-port <mountd-port>`&#x20;

`weka nfs global-config show`

## Set the global configuration filesystem <a href="#configure-the-nfs-configuration-filesystem" id="configure-the-nfs-configuration-filesystem"></a>

The global configuration filesystem is used as a shared location for persisting cluster-wide NFS v4,  S3, and SMB-W protocol cluster configurations. It is recommended to allocate 100 GB to support future system expansions.&#x20;

Use the following command line to set the configuration filesystem:

`weka nfs global-config set --config-fs <config-fs>`&#x20;

## Define client access groups <a href="#uploading-a-snapshot-using-the-ui" id="uploading-a-snapshot-using-the-ui"></a>

**Command:** `weka nfs client-group`

Use the following command lines to add/delete a client access group:

`weka nfs client-group add <name>`

`weka nfs client-group delete <name>`

**Parameters**

<table><thead><tr><th width="258">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Valid group name.</td></tr></tbody></table>

## Manage client access groups' rules

Clients are part of groups when their IP address or DNS hostname match the rules of that group. Similar to IP routing rules, clients are matched to client groups according to the most specific matching rule.

### **Add or delete DNS-based client group rules**

**Command:** `weka nfs rules`

Use the following command lines to add or delete a rule that causes a client to be part of a client group based on its DNS hostname:

`weka nfs rules add dns <name> <dns>`

Example:\
&#x20;`weka nfs rules add dns client-group1 hostname.example.com`



`weka nfs rules delete dns <name> <dns>`

Example:\
`weka nfs rules delete dns client-group1 hostname.example.com`

**Parameters**

<table><thead><tr><th width="250">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Valid client group name.</td></tr><tr><td><code>dns</code>*</td><td>DNS rule with *?[] wildcard rules.</td></tr></tbody></table>

### **Add or delete IP-based client group rules**

**Command:** `weka nfs rules`

Use the following command lines to add or delete a rule which causes a client to be part of a client group based on its IP and netmask:

`weka nfs rules add ip <name> <ip>`

Examples:\
&#x20;`weka nfs rules add ip client-group1 192.168.114.0/255.255.255.0`\
&#x20;`weka nfs rules add ip client-group2 172.16.0.0/255.255.0.0`



`weka nfs rules delete ip <name> <ip>`

Examples:\
&#x20;`weka nfs rules delete ip client-group1 192.168.114.0/255.255.255.0`\
&#x20;`weka nfs rules delete ip client-group2 172.16.0.0/255.255.0.0`\
&#x20;

**Parameters**

<table><thead><tr><th width="251">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Valid client group name.</td></tr><tr><td><code>ip</code>*</td><td>Valid IP with netmask rule.<br>Format: <code>1.1.1.1/255.255.0.0</code></td></tr></tbody></table>

## **Manage NFS client permissions**

**Command:** `weka nfs permission`

Use the following command lines to add/update/delete NFS permissions:\
`weka nfs permission add <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port]`

`weka nfs permission update <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions]`

`weka nfs permission delete <filesystem> <group> [--path path]`

**Parameters**

<table><thead><tr><th width="229">Name</th><th width="391">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>filesystem</code>*</td><td>Existing filesystem name.<br>A filesystem with Required Authentication set to ON cannot be used for NFS client permissions.</td><td></td></tr><tr><td> <code>group</code>*</td><td>Existing client group name.</td><td></td></tr><tr><td> <code>path</code></td><td>The root of the valid share path.</td><td>/</td></tr><tr><td><code>permission-type</code></td><td>Permission type.<br>Possible values: <code>ro</code> (read-only), <code>rw</code> (read-write)</td><td><code>rw</code></td></tr><tr><td><code>squash</code></td><td>Squashing type.<br>Possible values: <code>none</code> , <code>root</code>, <code>all</code> <br><br><code>all</code> is only applicable for NFS-W. Otherwise, it is treated as <code>root</code>.</td><td><code>none</code></td></tr><tr><td><code>anon-uid</code>*</td><td>Anonymous user ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</td><td><code>65534</code></td></tr><tr><td><code>anon-gid</code>*</td><td>Anonymous user group ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</td><td><code>65534</code></td></tr><tr><td><code>obs-direct</code></td><td>See <a href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a>.<br>Possible values: <code>on</code>, <code>off</code>.</td><td><code>on</code></td></tr><tr><td><code>manage-gids</code></td><td><p>Sets external group IDs resolution.</p><p>The list of group IDs received from the client is replaced by a list determined by an appropriate lookup on the server.<br>This option is only applicable in NFS-W.<br>Possible values: <code>on</code>, <code>off</code>.</p></td><td><code>off</code></td></tr><tr><td><code>privileged-port</code></td><td>Sets the share only to be mounted via privileged ports (1-1024), usually allowed by the root user.<br>This option is only applicable in NFS-W.<br>Possible values: <code>on</code>, <code>off</code>.</td><td><code>off</code></td></tr><tr><td><code>supported-versions</code></td><td>A comma-separated list of supported NFS versions.<br>Possible values: <code>v3</code>, <code>v4</code>.<br><code>v4</code> is only applicable in NFS-W.</td><td><code>v3</code></td></tr></tbody></table>
