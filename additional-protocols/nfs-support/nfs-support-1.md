---
description: >-
  Configure NFS networking, authentication, and client permissions using the
  CLI.
---

# Manage NFS networking using the CLI

## Configure the NFS global settings

Sets the cluster-wide NFS configuration, including the configuration filesystem, the service ports, and the default ACL and authentication behavior.

**Command:** `weka nfs global-config set`

```sh
weka nfs global-config set [--acl <on-off>] [--config-fs <string>] [--default-acl-type <acl-type>] [--default-supported-versions <nfs-versions>…] [--direct-io <on-off>] [--enable-auth-types <nfs-auth-types>…] [--enable-multi-tenant <on-off>] [--extended-stats <on-off>] [--force] [--force-config-fs <on-off>] [--lockmgr-port <uint16>] [--max-client-connections <uint>] [--max-open-fds <uint>] [--mountd-port <uint16>] [--no-restart] [--notify-port <uint16>] [--statmon-port <uint16>]
```

**Parameters**

| Parameter                                       | Description                                                                                                           |
| --- | --- |
| `--acl` \<on-off> | Enable or disable ACL. Default: on |
| `--config-fs` \<string> | Config filesystem name. Use empty string to invalidate. For details, see #dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations |
| `--default-acl-type` \<acl-type> | Default ACL type. For details, see #access-control-list-acl-in-nfs. Default: posix |
| `--default-supported-versions` \<nfs-versions>… | NFS versions for new permissions. Multiple values may be supplied separated by commas, or the option may be repeated. Possible values: v3 , v4, v3,v4 Default: v3 |
| `--direct-io` \<on-off> | Disable readcache and writecache. |
| `--enable-auth-types` \<nfs-auth-types>… | List of NFS authentication types. Multiple values may be supplied separated by commas, or the option may be repeated. Possible values: none,sys,krb5,krb5i,krb5p Example: krb5,krb5i,krb5p Default: If Kerberos is not configured: sys If Kerberos is configured: krb5 |
| `--enable-multi-tenant` \<on-off> | Enable or disable NFS multi-tenant support (default: Off). |
| `--extended-stats` \<on-off> | Enable or disable extended stats. Possible values: on or off Default: on |
| `--force` | Force action; this may cause disruption. |
| `--force-config-fs` \<on-off> | Force config-fs update when locks are on. |
| `--lockmgr-port` \<uint16> | Port for NFS lock manager. Default 0 selects any available port. |
| `--max-client-connections` \<uint> | Maximum number of concurrent NFS client connections. 0 means auto-tune based on cluster size. Default: 0 |
| `--max-open-fds` \<uint> | Maximum number of open file descriptors per NFS server process. Default: 0 |
| `--mountd-port` \<uint16> | Port number for mountd service. Default: 0 |
| `--no-restart` | Prevent NFS-W containers from restarting when changes are applied. |
| `--notify-port` \<uint16> | Port for NFSv3 notification. Default 0 means any available port. |
| `--statmon-port` \<uint16> | Port for NFS status monitor. Default 0 means any available port. |

{% hint style="info" %}
`max-client-connections` and `max-open-fds` are the supported way to raise these limits. If an alert directs you to a `weka debug config override` command for either value, use the `global-config set` option instead.

Both are available through the CLI and the API only. They are not in the GUI global settings dialog, which exposes the Multi-Tenancy toggle and the NFS port fields.
{% endhint %}

{% hint style="info" %}
Commands that change NFS configuration wait for the change to propagate to every NFS server before returning — normally a few seconds, bounded by a 55-second timeout. If the timeout expires, the command fails with an error naming the servers that did not confirm.
{% endhint %}

#### Show NFS global configuration

Shows the current cluster-wide NFS configuration.

**Command:** `weka nfs global-config show`

```sh
weka nfs global-config show
```

{% hint style="info" %}
The parameters `Default Auth Types` and `Supported Auth Types` are determined internally.

The `Effective` line reports the value actually in force. When the configured value is `0`, the effective value is the one the system sized automatically.
{% endhint %}

{% hint style="info" %}
A tenant administrator running this command sees a reduced view. The Kerberos authentication types are omitted, so the output differs from what a cluster administrator sees. See [multi-tenancy-tenant-level-administration.md](../../operation-guide/weka-native-multi-tenancy-management/multi-tenancy-tenant-level-administration.md "mention").
{% endhint %}

**Example**

<pre><code>$ weka nfs global-config show
NFS Global Configuration
   mountd port: 0
     Config FS: .config_fs
   acl: on
   default acl type: posix
   Default Supported Versions: V3
<strong>   Enabled Auth Types: KRB5, KRB5i, KRB5p
</strong>   Default Auth Types: KRB5
   Supported Auth Types: NONE, SYS, KRB5, KRB5i, KRB5p
   Multi-Tenant: false
   Max Client Connections: 0
   Max Client Connections Effective: 2048
   Max Open FDs: 0
</code></pre>

{% hint style="info" %}
The parameters `Default Auth Types` and `Supported Auth Types` are determined internally.

The `Effective` line reports the value actually in force. When the configured value is `0`, the effective value is the one the system sized automatically.
{% endhint %}

{% hint style="info" %}
A tenant administrator running this command sees a reduced view. The Kerberos authentication types are omitted, so the output differs from what a cluster administrator sees. See [multi-tenancy-tenant-level-administration.md](../../operation-guide/weka-native-multi-tenancy-management/multi-tenancy-tenant-level-administration.md "mention").
{% endhint %}

## **Configure the NFS cluster level**


### Create interface groups

Creates an NFS interface group, which defines the network interfaces and floating IPs that serve NFS.

**Command:** `weka nfs interface-group add`

```sh
weka nfs interface-group add <name> [--gateway <ip>] [--netmask <uint8>]
```

**Parameters**

| Parameter            | Description             |
| --- | --- |
| `name`\* | Interface group name. |
| `--gateway` \<ip> | Gateway IP address. Default: `255.255.255.255` |
| `--netmask` \<uint8> | Netmask length in bits. |

{% hint style="info" %}
When NFS multi-tenancy is enabled, the interface group listing includes a **Tenants** column showing which tenants each group serves. Tenants are assigned to interface groups with `weka nfs interface-group tenant`, which requires the ClusterAdmin role and is documented in [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention"). The root organization is never assigned; it uses the interface group's floating IPs directly.
{% endhint %}

**Example**

`weka nfs interface-group add nfsw --netmask 24 --gateway 10.0.1.254`

### Set interface group ports

Adds or removes a container's network port from an interface group. A port must be added before the container can serve NFS through that group.

**Command:** `weka nfs interface-group port add`

```sh
weka nfs interface-group port add <name> <container> <port>
```

**Command:** `weka nfs interface-group port remove`

```sh
weka nfs interface-group port remove <name> <container> <port> [--force]
```

**Parameters**

| Parameter     | Description                             |
| --- | --- |
| `name`\* | Name of the NFS interface group. |
| `container`\* | Container ID on which the port resides. |
| `port`\* | Port device name (e.g. eth1). |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

**Example**

The following command line adds the interface `enp2s0` on the Frontend container-id `3` to the interface group named `nfsw`.

`weka nfs interface-group port add nfsw 3 enp2s0`

### Set interface group IPs

Adds or removes the floating IP addresses that an interface group serves NFS on.

**Command:** `weka nfs interface-group ip-range add`

```sh
weka nfs interface-group ip-range add <name> <ips>
```

**Command:** `weka nfs interface-group ip-range remove`

```sh
weka nfs interface-group ip-range remove <name> <ips> [--force]
```

**Parameters**

| Parameter | Description                      |
| --- | --- |
| `name`\* | Name of the NFS interface group. |
| `ips`\* | IP range to add. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

**Example**

The following command line adds IPs in the range `10.0.1.101` to `10.0.1.118` to the interface group named `nfsw`.

`weka nfs interface-group ip-range add nfsw 10.0.1.101-118`

### Configure the service mountd port

The mountd service receives requests from clients to mount to the NFS server. It is possible to set it explicitly rather than have it randomly selected on each server startup. This allows an easier setup of the firewalls to allow that port.

Use the following command lines to set and view the mountd configuration:

`weka nfs global-config set --mountd-port <mountd-port>`

`weka nfs global-config show`

### Configure user group resolution

NFS can authenticate more than 16 user groups, but it requires the external resolution of the user's groups, which means associating users with their respective group-IDs outside of the NFS protocol.

**Procedure**

1. **Configure interface groups:**
   * See [Create interface groups](nfs-support-1.md#create-interface-groups).
2. **Configure NFS client permissions:**
   * See [Set the NFS client permissions](nfs-support-1.md#manage-nfs-client-permissions).
3. **Set up servers for group-IDs retrieval:**
   * Configure relevant servers to retrieve user group-IDs information.\
     This task is performed on the server's operating system and is not managed by the cluster. See the following procedure.

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

If you use another method than the `sssd` but with a different provider, configure an `sssd proxy` on each relevant server. The proxy allows the NFS container to resolve groups by any method defined on the server.

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

## Integrate the NFS and Kerberos service

Integrating the NFS and Kerberos service is critical to setting up a secure network communication process. This procedure involves defining the Key Distribution Center (KDC) details, administrative credentials, and other parameters to ensure a robust and secure authentication process.

**Before you begin**

* Ensure a configuration filesystem is set. See [#configure-the-nfs-global-settings](nfs-support-1.md#configure-the-nfs-global-settings "mention").
* Ensure the NFS cluster is configured and running. see [#configure-the-nfs-cluster-level](nfs-support-1.md#configure-the-nfs-cluster-level "mention").
* For Active Directory (AD) integration, obtain the required information from the AD administrator. (The keytab file is generated automatically.)
* For MIT integration, ensure the following:
  * Obtain the required information from the MIT Key Distribution Center (KDC) and OpenLDAP administrators.
  * A pre-generated keytab file in base64[^1] format stored in an accessible location is required.

{% hint style="info" %}
In all KDC and LDAP parameters, use the FQDN format. The hostname part of the FQDN is restricted to a maximum of 20 characters.
{% endhint %}

### Set the Kerberos service

Registers the Kerberos realm and KDC servers that the NFS service authenticates against.

**Command:** `weka nfs kerberos service setup`

```sh
weka nfs kerberos service setup <kdc-realm-name> <kdc-primary-server> <kdc-admin-server> [--force] [--kdc-secondary-server <string>] [--restart]
```

**Parameters**

| Parameter                          | Description                                       |
| --- | --- |
| `kdc-realm-name`\* | KDC realm name. |
| `kdc-primary-server`\* | KDC primary server. |
| `kdc-admin-server`\* | KDC admin server. |
| `--force` | Perform this action without further confirmation. |
| `--kdc-secondary-server` \<string> | KDC secondary server. |
| `--restart` | Restart the NFS-W containers to apply changes. |

**Example**

{% code overflow="wrap" %}
```
weka nfs kerberos service setup WEKA-REALM kdc.primary.weka.io kdc.admin.weka.io --kdc-secondary-server kdc.secondary.weka.io
```
{% endcode %}

#### Show NFS Kerberos service setup information

Shows the configured Kerberos realm and KDC servers.

**Command:** `weka nfs kerberos service show`

```sh
weka nfs kerberos service show
```

{% endcode %}

**Example**

{% code fullWidth="true" %}
```bash
$ weka nfs kerberos service show
REALM NAME          PRIMARY SERVER           SECONDARY SERVER   ADMIN SERVER           GENERATION ID     SERVICE STATUS
TEST.WEKALAB.IO     Zeus.test.wekalab.io                        Zeus.test.wekalab.io   1                 CONFIGURED
```
{% endcode %}

### Integrate Kerberos with AD

Integrating Kerberos with AD involves the following:

1. [Register Kerberos with AD](nfs-support-1.md#integrate-kerberos-with-ad)
2. [Set up Kerberos to use AD LDAP](nfs-support-1.md#set-up-kerberos-to-use-ad-ldap)

#### Register Kerberos with AD

Joins the NFS service to an Active Directory realm, creating its service principal.

**Command:** `weka nfs kerberos registration setup-ad`

```sh
weka nfs kerberos registration setup-ad <nfs-fqdn-service-name> <realm-admin-name> [<realm-admin-passwd>] [--base-ou <string>] [--force] [--restart]
```

**Parameters**

| Parameter                 | Description                                         |
| --- | --- |
| `nfs-fqdn-service-name`\* | NFS FQDN service name. |
| `realm-admin-name`\* | Realm admin user name. |
| `realm-admin-passwd` | Realm admin password. If omitted, will be prompted. |
| `--base-ou` \<string> | LDAP base OU to use (e.g. OU=Servers). |
| `--force` | Perform this action without further confirmation. |
| `--restart` | Restart the NFS-W containers to apply changes. |

**Example**

{% code overflow="wrap" %}
```
weka nfs kerberos registration setup-ad myservicename.test.example.com myrealmadmin
```
{% endcode %}

#### Set up Kerberos to use AD LDAP

Points NFS user and group resolution at the Active Directory the service is already joined to.

**Command:** `weka nfs ldap setup-ad`

```sh
weka nfs ldap setup-ad [--force] [--no-restart]
```

**Parameters**

| Parameter      | Description                                           |
| --- | --- |
| `--force` | Perform this action even when LDAP is already set up. |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. |

{% hint style="warning" %}
In a successful operation, the system automatically restarts the NFS containers, leading to a temporary disruption in the IO service for connected NFS clients. However, if you want to avoid restarting the NFS containers, add the `--no-restart` option to the command line.
{% endhint %}

**Example**

{% code overflow="wrap" %}
```
weka nfs ldap setup-ad
```
{% endcode %}

### Integrate Kerberos with MIT

Integrating Kerberos with MIT involves the following:

1. [Register Kerberos with MIT](nfs-support-1.md#register-kerberos-with-mit)
2. [Set up Kerberos to use OpenLDAP](nfs-support-1.md#set-up-kerberos-to-use-openldap)

#### Register Kerberos with MIT

Registers the NFS service with an MIT Kerberos KDC using a keytab file.

**Command:** `weka nfs kerberos registration setup-mit`

```sh
weka nfs kerberos registration setup-mit <nfs-fqdn-service-name> <keytab-path> [--force] [--restart]
```

**Parameters**

| Parameter                 | Description                                       |
| --- | --- |
| `nfs-fqdn-service-name`\* | NFS FQDN service name. |
| `keytab-path`\* | Path to keytab file. |
| `--force` | Perform this action without further confirmation. |
| `--restart` | Restart the NFS-W containers to apply changes. |

**Example**

{% code overflow="wrap" %}
```
weka nfs kerberos registration setup-mit myservicename.test.example.com myservicename.keytab
```
{% endcode %}

{% hint style="info" %}
To register the Kerberos service with MIT, a pre-generated [keytab file](#user-content-fn-2)[^2] , stored in an accessible location, is required.
{% endhint %}

#### Set up Kerberos to use OpenLDAP

Points NFS user and group resolution at an OpenLDAP server.

**Command:** `weka nfs ldap setup-openldap`

```sh
weka nfs ldap setup-openldap <server-name> <ldap-domain> <reader-user-name> [<reader-user-password>] [--base-dn <string>] [--force] [--ldap-port-number <uint16>] [--no-restart]
```

**Parameters**

| Parameter                      | Description                                           |
| --- | --- |
| `server-name`\* | OpenLDAP server name. |
| `ldap-domain`\* | OpenLDAP domain. |
| `reader-user-name`\* | OpenLDAP reader user name. |
| `reader-user-password` | OpenLDAP reader user password. |
| `--base-dn` \<string> | LDAP Base DN (e.g. dc=myldapdom,dc=ex,dc=com). |
| `--force` | Perform this action even when LDAP is already set up. |
| `--ldap-port-number` \<uint16> | OpenLDAP port number (default: 389). |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. |

{% hint style="warning" %}
In a successful operation, the system automatically restarts the NFS containers, leading to a temporary disruption in the IO service for connected NFS clients. However, if you want to avoid restarting the NFS containers, add the `--no-restart` option to the command line.
{% endhint %}

**Example**

{% code overflow="wrap" %}
```
weka nfs ldap setup-openldap myldapserver.test.example.com, myldapdomain.example.com, cn=readonly-user,dc=test,dc=example,dc=com
```
{% endcode %}

### Show Kerberos LDAP setup information

Shows the LDAP configuration used for NFS user and group resolution.

**Command:** `weka nfs ldap show`

```sh
weka nfs ldap show
```

{% endcode %}

**Example**

{% code fullWidth="true" %}
```bash
$ weka nfs ldap show
SERVER TYPE      LDAP DOMAIN      SERVER NAME  SERVER PORT  BASE DN  READER NAME  READER PASSWORD  GENERATION ID  SETUP STATUS
ActiveDirectory  test.wekalab.io               0                                                   1              CONFIGURED
```
{% endcode %}

### Clear the Kerberos LDAP configuration

Removes the LDAP configuration used for NFS user and group resolution.

**Command:** `weka nfs ldap reset`

```sh
weka nfs ldap reset [--force] [--no-restart]
```

**Parameters**

| Parameter      | Description                                          |
| --- | --- |
| `--force` | Perform this action without further confirmation. |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. |

### Show Kerberos registration information

Shows the NFS service's Kerberos registration details.

**Command:** `weka nfs kerberos registration show`

```sh
weka nfs kerberos registration show
```

**Example**

```bash
$ weka nfs kerberos registration show
NFS SERVICE NAME          NFS KDC TYPE        GENERATION ID      REGISTRATION STATUS
nfs.test.wekalab.io       ActiveDirectory     1                  REGISTERED
```

### Clear Kerberos configuration

Removes the Kerberos configuration from the NFS service.

**Command:** `weka nfs kerberos reset`

```sh
weka nfs kerberos reset [--force] [--no-restart]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. Default: False |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. Default: False. Containers restart automatically to apply changes. Important: Omitting this flag will cause a service disruption for active NFS clients during the container restart |

### Update Kerberos configuration during maintenance mode

Once the Kerberos integration with NFS is configured, there might be instances where the Kerberos setup is modified.

{% hint style="warning" %}
Changes to the Kerberos configuration in a production environment are rare. We recommend making any necessary updates during periods of low load from NFS clients, such as when the system are in maintenance mode. This approach helps to minimize potential disruptions to your operations.
{% endhint %}

Select the relevant tab to learn what to do for each scenario:

{% tabs %}
{% tab title="KDC" %}
Use this procedure if you want to add or remove a secondary KDC server:

```
kdc-secondary-server
```

**Procedure**

1. Run the command: `weka nfs kerberos reset --no-restart --force`
2. Run the command: `weka nfs kerberos service setup <options>`
3. Run one of the following commands:
   * **For AD implementation:** `weka nfs kerberos registration setup-ad <options> --restart`
   * **For MIT implementation:** `weka nfs kerberos registration setup-mit <options> --restart`
{% endtab %}

{% tab title="AD" %}
Use this procedure if one of the following is changed:

```
realm-admin-name
realm-admin-passwd
```

**Procedure**

Run the command:\
`weka nfs kerberos registration setup-ad --restart --force`
{% endtab %}

{% tab title="MIT" %}
Use this procedure if one of the following is changed:

```
keytab-file
```

**Procedure**

Run the command:\
`weka nfs kerberos registration setup-mit <options> --restart --force`
{% endtab %}

{% tab title="OpenLDAP" %}
Use this procedure if one of the following is changed:

```
reader-user-name
reader-user-password
```

**Procedure**

* For AD implementation, run the following:
  1. `weka nfs ldap reset --no-restart --force`
  2. `weka nfs ldap <setup-ldap> <options/params>`
* For MIT implementation, run the following:
  1. `weka nfs ldap reset --no-restart --force`
  2. `weka nfs ldap <setup-openldap> <options/params>`
{% endtab %}
{% endtabs %}

### Configure NFS for LDAP with ACLs (without Kerberos)

Configures NFS to resolve users and groups against Active Directory LDAP without joining a Kerberos realm.

**Command:** `weka nfs ldap setup-ad-nokrb`

```sh
weka nfs ldap setup-ad-nokrb <server-name> <ldap-domain> <nfs-service-name> <admin-user-name> [<admin-user-password>] [--base-ou <string>] [--force] [--no-restart]
```

**Parameters**

| Parameter             | Description                                           |
| --- | --- |
| `server-name`\* | AD server name. |
| `ldap-domain`\* | AD domain. |
| `nfs-service-name`\* | NFS FQDN service name. |
| `admin-user-name`\* | AD admin name. |
| `admin-user-password` | AD admin password. |
| `--base-ou` \<string> | LDAP OU (default: CN=Computers). |
| `--force` | Perform this action even when LDAP is already set up. Default: False |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. Default: False. Containers restart automatically to apply changes. Important: Omitting this flag will cause a service disruption for active NFS clients during the container restart |

### Set host-based LDAP resolution for NFS

Configures NFS to resolve users and groups through the host's own LDAP client (NSS/SSSD) rather than a directory the cluster connects to.

**Command:** `weka nfs ldap setup-onhostldap`

```sh
weka nfs ldap setup-onhostldap <ldap-domain> [--force] [--no-restart]
```

**Parameters**

| Parameter       | Description                                           |
| --- | --- |
| `ldap-domain`\* | LDAP domain. |
| `--force` | Perform this action even when LDAP is already set up. |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. Default: Containers restart automatically to apply changes. Important: Omitting this flag will cause a service disruption for active NFS clients during the container restart |

## **Manage the NFS export level (permissions)**


### Define client access groups

Creates or removes a client access group. Groups collect the client rules that an export permission is granted to.

**Command:** `weka nfs client-group add`

```sh
weka nfs client-group add <name>
```

**Command:** `weka nfs client-group remove`

```sh
weka nfs client-group remove <name> [--force]
```

**Parameters**

| Parameter | Description                      |
| --- | --- |
| `name`\* | Name of the NFS group to create. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### Manage client access groups' rules

Lists the rules defined on the client access groups. A rule matches clients by DNS name or by IP range.

**Command:** `weka nfs rules`

```sh
weka nfs rules
```

#### Add DNS-based client group rules

Adds a rule that matches clients by DNS name.

**Command:** `weka nfs rules add dns`

```sh
weka nfs rules add dns <name> <dns>
```

**Parameters**

| Parameter | Description                                        |
| --- | --- |
| `name`\* | Name of the NFS group in which to create the rule. |
| `dns`\* | DNS rule with \*?\[] wildcards. |

**Example**

`weka nfs rules add dns client-group1 hostname.example.com`

#### Remove DNS-based client group rules

Removes a DNS-based rule from a client access group.

**Command:** `weka nfs rules remove dns`

```sh
weka nfs rules remove dns <name> <dns>
```

**Parameters**

| Parameter | Description                                          |
| --- | --- |
| `name`\* | Name of the NFS group from which to delete the rule. |
| `dns`\* | DNS rule with \*?\[] wildcards. |

**Example**

`weka nfs rules remove dns client-group1 hostname.example.com`

#### Add IP-based client group rules

Adds a rule that matches clients by IP address or CIDR range.

**Command:** `weka nfs rules add ip`

```sh
weka nfs rules add ip <name> <ip>
```

**Parameters**

| Parameter | Description                                                                    |
| --- | --- |
| `name`\* | Name of the NFS group in which to create the rule. |
| `ip`\* | IP with netmask or CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format. |

**Examples**

`weka nfs rules add ip client-group1 192.168.114.0/8`\
`weka nfs rules add ip client-group2 172.16.0.0/255.255.0.0`

#### Remove IP-based client group rules

Removes an IP-based rule from a client access group.

**Command:** `weka nfs rules remove ip`

```sh
weka nfs rules remove ip <name> <ip>
```

**Parameters**

| Parameter | Description                                                                    |
| --- | --- |
| `name`\* | Name of the NFS group from which to delete the rule. |
| `ip`\* | IP with netmask or CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format. |

**Examples**

`weka nfs rules remove ip client-group1 192.168.114.0/255.255.255.0`\
`weka nfs rules remove ip client-group2 172.16.0.0/16`

### Manage NFS client permissions

Grants, changes, or revokes a client access group's permission on a filesystem, including its access level, squashing, and supported NFS versions.

**Command:** `weka nfs permission add`

```sh
weka nfs permission add <filesystem> <group> [--acl-type <acl-type>] [--anon-gid <uint32>] [--anon-uid <uint32>] [--enable-auth-types <nfs-auth-types>…] [--force] [--force-acl-type <on-off>] [--manage-gids <on-off>] [--no-restart] [--obs-direct <on-off>] [--path <string>] [--permission-type <permission-type>] [--privileged-port <on-off>] [--squash <squash-mode>] [--supported-versions <nfs-versions>…]
```

**Command:** `weka nfs permission update`

```sh
weka nfs permission update <filesystem> <group> [--acl-type <acl-type>] [--anon-gid <uint32>] [--anon-uid <uint32>] [--enable-auth-types <nfs-auth-types>…] [--force] [--force-acl-type <on-off>] [--manage-gids <on-off>] [--no-restart] [--obs-direct <on-off>] [--path <string>] [--permission-type <permission-type>] [--privileged-port <on-off>] [--squash <squash-mode>] [--supported-versions <nfs-versions>…]
```

**Command:** `weka nfs permission remove`

```sh
weka nfs permission remove <filesystem> <group> [--force] [--path <string>]
```

**Parameters**

| Parameter                                | Description                                                                                                                                                                                        |
| --- | --- |
| `filesystem`\* | Filesystem name. |
| `group`\* | Client group name. |
| `--acl-type` \<acl-type> | Type of ACL. Default is determined by the NFS global configuration. Values: none, posix, nfsv4, hybrid For details, see #access-control-list-acl-in-nfs |
| `--anon-gid` \<uint32> | GID to be used instead of root when root squashing is enabled. Values: 1 to 65535 |
| `--anon-uid` \<uint32> | UID to be used instead of root when root squashing is enabled. Values: 1 to 65535 |
| `--enable-auth-types` \<nfs-auth-types>… | NFS authentication types. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--force` | Perform this action when the service is already configured. |
| `--force-acl-type` \<on-off> | Force a change to the ACL type for existing permissions on the same filesystem. Values: on, off |
| `--manage-gids` \<on-off> | List of group IDs received from the client will be replaced by a list of group IDs determined by an appropriate lookup on the server. Only works with an interface group which allows manage-gids. Values: on, off |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. |
| `--obs-direct` \<on-off> | OBS direct. For details, see Object-store direct mount (obs_direct). Values: on, off |
| `--path` \<string> | Filesystem path. Default is '/'. |
| `--permission-type` \<permission-type> | Permission type. Values: ro (read-only), rw (read-write) |
| `--privileged-port` \<on-off> | Privileged port. Values: on, off |
| `--squash` \<squash-mode> | Permission squashing. The option 'all' can be used only on interface groups with --allow-manage-gids=on. Values: none, root, all Use all only on interface groups with --allow-manage-gids=on |
| `--supported-versions` \<nfs-versions>… | NFS versions for new permissions. Multiple values may be supplied separated by commas, or the option may be repeated. Values: v3, v4 |

### View connected NFS clients

Lists the clients currently connected to the NFS service.

**Command:** `weka nfs clients show`

```sh
weka nfs clients show [--container-id <container-id>] [--fip <ip>] [--fsnames <strings>…] [--interface-group <string>]
```

**Parameters**

| Parameter                        | Description                                                                                                            |
| --- | --- |
| `--container-id` \<container-id> | Specify container ID. |
| `--fip` \<ip> | Specify floating IP. |
| `--fsnames` \<strings>… | Specify exported filesystem names. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--interface-group` \<string> | Specify NFS interface group. |

[^1]: A binary data in an American Standard Code for Information Interchange (ASCII) string format.

[^2]: All Kerberos server machines need a keytab file, called `/etc/krb5.keytab`, to authenticate to the KDC. For details, see [https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-install/The-Keytab-File.html](https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-install/The-Keytab-File.html).
