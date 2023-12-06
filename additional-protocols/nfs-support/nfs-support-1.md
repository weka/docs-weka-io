---
description: This page describes how to configure the NFS networking using the CLI.
---

# Manage NFS networking using the CLI

Using the CLI, you can:

* **Configure the NFS cluster level**
  * [Set the global configuration filesystem](nfs-support-1.md#configure-the-nfs-configuration-filesystem)
  * [Create interface groups](nfs-support-1.md#create-interface-groups)
  * [Set interface group ports](nfs-support-1.md#set-interface-group-ports)
  * [Set interface group IPs](nfs-support-1.md#set-interface-group-ips)
  * [Configure the service mountd port](nfs-support-1.md#configure-the-service-mountd-port)
  * [Configure user groups resolution when using the legacy NFS](nfs-support-1.md#configure-user-groups-resolution-when-using-the-legacy-nfs)
* **Configure the NFS export level (permissions)**
  * [Define client access groups](nfs-support-1.md#uploading-a-snapshot-using-the-ui)
  * [Manage client access groups](nfs-support-1.md#manage-client-access-groups)
  * [Manage NFS client permissions](nfs-support-1.md#manage-nfs-client-permissions)

## **Configure the NFS cluster level**

### Set the NFS configuration filesystem <a href="#configure-the-nfs-configuration-filesystem" id="configure-the-nfs-configuration-filesystem"></a>

NFSv4 requires a persistent cluster-wide configuration filesystem for the protocol's internal operations.

Use the following command line to set the NFS configuration on the configuration filesystem:

`weka nfs global-config set --config-fs <config-fs>`&#x20;

**Parameters**

<table><thead><tr><th width="220">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>config-fs</code>*</td><td>The predefined filesystem name for maintaining the persisting cluster-wide protocols' configurations.<br>Ensure the filesystem is already created. If not, create a filesystem with 100 GB capacity.</td></tr></tbody></table>

### Create interface groups

**Command:** `weka nfs interface-group add`

Use the following command line to add an interface group:

`weka nfs interface-group add <name> <type> [--subnet subnet] [--gateway gateway] [--allow-manage-gids allow-manage-gids]`

The parameter `allow-manage-gids` determines the type of NFS stack. The default value of this parameter is `on`, which sets the NFS-W stack.

{% hint style="warning" %}
Do not mount the same filesystem by containers residing in interface groups with different values of the `allow-manage-gids.`
{% endhint %}

**Example**

`weka nfs interface-group add nfsw NFS  --subnet 255.255.255.0 --gateway 10.0.1.254`

**Parameters**

<table><thead><tr><th width="225">Name</th><th width="325">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Unique interface group name.<br>Supports a maximum of 11 characters.</td><td></td></tr><tr><td><code>type</code>*</td><td>Group type.<br>Can only be  <code>NFS</code>.</td><td></td></tr><tr><td><code>subnet</code></td><td>The valid subnet mask in the 255.255.0.0 format.</td><td><code>255.255.255.255</code></td></tr><tr><td><code>gateway</code></td><td>Gateway valid IP.</td><td><code>255.255.255.255</code></td></tr><tr><td><code>allow-manage-gids</code></td><td><p>Allows the containers within this interface group to use <code>manage-gids</code> when set in exports. </p><p>With <code>manage-gids</code>, the list of group IDs received from the client is replaced by a list of group IDs determined by an appropriate lookup on the server.<br><br>NFS-W: <code>on</code></p><p>Legacy NFS: <code>off</code></p><p></p><p>Each container can be set to be part of interface groups with the same value of <code>allow-manage-gids</code>.</p></td><td><code>on</code></td></tr></tbody></table>

### Set interface group ports

**Commands:**

`weka nfs interface-group port add`

`weka nfs interface-group port delete`

Use the following command lines to add or delete an interface group port:

`weka nfs interface-group port add <name> <container-id> <port>`

`weka nfs interface-group port delete <name> <container-id> <port>`

**Example**

The following command line adds the interface `enp2s0` on the Frontend container-id `3` to the interface group named `nfsw`.

`weka nfs interface-group port add nfsw 3 enp2s0`

**Parameters**

<table><thead><tr><th width="220">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Interface group name.</td></tr><tr><td><code>container-id</code>*</td><td>Valid frontend container ID on which the port resides. You can obtain the container ID by running the <code>weka cluster container</code> command.</td></tr><tr><td><code>port</code>*</td><td>Valid port's device.<br>Example: <code>eth1</code>.</td></tr></tbody></table>

### Set interface group IPs

**Commands:**&#x20;

`weka nfs interface-group ip-range add`

`weka nfs interface-group ip-range delete`

Use the following command lines to add/delete an interface group IP:

`weka nfs interface-group ip-range add <name> <ips>`

`weka nfs interface-group ip-range delete <name> <ips>`

**Example**

The following command line adds IPs in the range `10.0.1.101` to `10.0.1.118` to the interface group named `nfsw`.

`weka nfs interface-group ip-range add nfsw 10.0.1.101-118`

**Parameters**

<table><thead><tr><th width="222">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Interface group name</td></tr><tr><td><code>ips</code>*</td><td>Valid IP range</td></tr></tbody></table>

{% hint style="info" %}
Cloud environments do not support interface group IPs.
{% endhint %}

### Configure the service mountd port

The mountd service receives requests from clients to mount to the NFS server. In NFS-W, it is possible to set it explicitly rather than have it randomly selected on each server startup. This allows an easier setup of the firewalls to allow that port.

Use the following command lines to set and view the mountd configuration:

`weka nfs global-config set --mountd-port <mountd-port>`&#x20;

`weka nfs global-config show`

### Configure user groups resolution

NFS-W can authenticate more than 16 user groups, but it requires the external resolution of the user's groups, which means associating users with their respective group-IDs outside of the NFS protocol.

{% hint style="info" %}
Configuring more than 16 user groups is not supported with the legacy NFS.
{% endhint %}

**Procedure**

1. **Configure interface groups:**
   * Ensure that the `allow-manage-gids` option is set to `on` (default value). See [Create interface groups](nfs-support-1.md#create-interface-groups).&#x20;
2. **Configure NFS client permissions:**
   * Set the `manage-gids` option to `on` for the NFS client to enable external group-IDs resolution. See [Set the NFS client permissions](nfs-support-1.md#manage-nfs-client-permissions).
3. **Set up servers for group-IDs retrieval:**
   * Configure relevant servers to retrieve user group-IDs information.\
     This task is specific to NFS-W and does not involve WEKA management. See the following procedure.

<details>

<summary>Set up the servers to retrieve user's group-IDs information</summary>

For the servers that are part of the interface group, set the servers to retrieve the user's group-IDs information in any method that is part of the environment.

You can also set the group resolution by joining the AD and Kerberos domains or using LDAP with a read-only user.

Configure the `sssd` on the server to serve as a group IDs provider. For example, you can configure the `sssd` directly using LDAP or as a proxy to a different `nss` group IDs provider.

**Example: set `sssd` directly for `nss` services using LDAP with a read-only user**

```
[sssd]
services = nss
config_file_version = 2
domains = LDAP

[domain/LDAP]
id_provider = ldap
ldap_uri = ldap://ldap.example.com
ldap_search_base = dc=example,dc=com

# The DN used to search the ldap directory with. 
ldap_default_bind_dn = cn=ro_admin,ou=groups,dc=example,dc=com

# The password of the bind DN.
ldap_default_authtok = password

```

If you use another method than the `sssd` but with a different provider, configure an `sssd proxy` on each relevant server. The proxy is used for the WEKA container to resolve the groups by any method defined on the server.

To configure `sssd proxy` on a server, use the following:

```
# install sssd
yum install sssd

# set up a proxy for WEKA in /etc/sssd/sssd.conf
[sssd]
services = nss
config_file_version = 2
domains = proxy_for_weka

[nss]
[domain/proxy_for_weka]
id_provider = proxy
auth_provider = none
 
# the name of the nss lib to be proxied, e.g., ldap, nis, winbind, vas4, etc.
proxy_lib_name = ldap
```

All users must be present and resolved in the method used in the `sssd` for the group's resolution. In the above example, using an LDAP-only provider, local users (such as a local root) absent in LDAP do not receive their groups resolved and are denied. For such users or applications, add the LDAP user.

</details>

## **Configure the NFS export level (permissions)**

### Define client access groups <a href="#uploading-a-snapshot-using-the-ui" id="uploading-a-snapshot-using-the-ui"></a>

**Command:** `weka nfs client-group`

Use the following command lines to add/delete a client access group:

`weka nfs client-group add <name>`

`weka nfs client-group delete <name>`

**Parameters**

<table><thead><tr><th width="258">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Valid group name.</td></tr></tbody></table>

### Manage client access groups' rules

Clients are part of groups when their IP address or DNS hostname match the rules of that group. Similar to IP routing rules, clients are matched to client groups according to the most specific matching rule.

**Command:** `weka nfs rules`

#### **Add DNS-based client group rules**

Use the following command lines to add a rule that causes a client to be part of a client group based on its DNS hostname:

`weka nfs rules add dns <name> <dns>`

**Example**

&#x20;`weka nfs rules add dns client-group1 hostname.example.com`

#### **Delete DNS-based client group rules**

Use the following command lines to delete a rule that causes a client to be part of a client group based on its DNS hostname:

`weka nfs rules delete dns <name> <dns>`

**Example**

`weka nfs rules delete dns client-group1 hostname.example.com`

**Parameters**

<table><thead><tr><th width="250">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Valid client group name.</td></tr><tr><td><code>dns</code>*</td><td>DNS rule with *?[] wildcard rules.</td></tr></tbody></table>

#### **Add IP-based client group rules**

**Command:** `weka nfs rules`

Use the following command lines to add or delete a rule which causes a client to be part of a client group based on its IP and subnet mask (both CIDR and standard subnet mask formats are supported for enhanced flexibility):

`weka nfs rules add ip <name> <ip>`

**Examples**

&#x20;`weka nfs rules add ip client-group1 192.168.114.0/8`\
&#x20;`weka nfs rules add ip client-group2 172.16.0.0/255.255.0.0`

#### **Delete IP-based client group rules**

`weka nfs rules delete ip <name> <ip>`

**Examples**

&#x20;`weka nfs rules delete ip client-group1 192.168.114.0/255.255.255.0`\
&#x20;`weka nfs rules delete ip client-group2 172.16.0.0/16`

**Parameters**

<table><thead><tr><th width="167">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Valid client group name.</td></tr><tr><td><code>ip</code>*</td><td><p>Valid IP address with subnet mask.</p><p>Both CIDR and standard subnet mask formats are supported for enhanced flexibility.</p><p>CIDR format: <code>1.1.1.1/16</code> </p><p>Standard format: <code>1.1.1.1/255.255.0.0</code></p></td></tr></tbody></table>

### **Manage NFS client permissions**

**Command:** `weka nfs permission`

Use the following command lines to add NFS permissions:

`weka nfs permission add <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions]`

Use the following command lines to update NFS permissions:

`weka nfs permission update <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions]`

Use the following command lines to delete NFS permissions:

`weka nfs permission delete <filesystem> <group> [--path path]`

**Parameters**

<table><thead><tr><th width="229">Name</th><th width="391">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>filesystem</code>*</td><td>Existing filesystem name.<br>A filesystem with Required Authentication set to ON cannot be used for NFS client permissions.</td><td></td></tr><tr><td> <code>group</code>*</td><td>Existing client group name.</td><td></td></tr><tr><td> <code>path</code></td><td>The root of the valid share path.</td><td>/</td></tr><tr><td><code>permission-type</code></td><td>Permission type.<br>Possible values: <code>ro</code> (read-only), <code>rw</code> (read-write)</td><td><code>rw</code></td></tr><tr><td><code>squash</code></td><td>Squashing type.<br>Possible values: <code>none</code> , <code>root</code>, <code>all</code> <br><br><code>all</code> is only applicable for NFS-W. Otherwise, it is treated as <code>root</code>.</td><td><code>none</code></td></tr><tr><td><code>anon-uid</code>*</td><td>Anonymous user ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</td><td><code>65534</code></td></tr><tr><td><code>anon-gid</code>*</td><td>Anonymous user group ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</td><td><code>65534</code></td></tr><tr><td><code>obs-direct</code></td><td>See <a href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a>.<br>Possible values: <code>on</code>, <code>off</code>.</td><td><code>on</code></td></tr><tr><td><code>manage-gids</code></td><td><p>Sets external group IDs resolution.</p><p>The list of group IDs received from the client is replaced by a list determined by an appropriate lookup on the server.<br>This option is only applicable in NFS-W.<br>Possible values: <code>on</code>, <code>off</code>.</p></td><td><code>off</code></td></tr><tr><td><code>privileged-port</code></td><td>Sets the share only to be mounted via privileged ports (1-1024), usually allowed by the root user.<br>This option is only applicable in NFS-W.<br>Possible values: <code>on</code>, <code>off</code>.</td><td><code>off</code></td></tr><tr><td><code>supported-versions</code></td><td>A comma-separated list of supported NFS versions.<br>Possible values: <code>v3</code>, <code>v4</code>.<br><code>v4</code> is only applicable in NFS-W.</td><td><code>v3</code></td></tr></tbody></table>
