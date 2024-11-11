---
description: This page describes how to configure the NFS networking using the CLI.
---

# Manage NFS networking using the CLI

Using the CLI, you can:

* [Configure the NFS global settings](nfs-support-1.md#configure-the-nfs-global-settings)
* [Configure the NFS cluster level](nfs-support-1.md#configure-the-nfs-cluster-level)
* [Integrate the NFS and Kerberos service](nfs-support-1.md#integrate-the-nfs-and-kerberos-service)
* [Configure the NFS export level (permissions)](nfs-support-1.md#configure-the-nfs-export-level-permissions)

## Configure the NFS global settings

NFSv4 and Kerberos require a persistent cluster-wide configuration filesystem for the protocol's internal operations.

Use the following command line to set the NFS configuration on the configuration filesystem:

`weka nfs global-config set` \[`--mountd-port mountd-port]` \[`--lockmgr-port lockmgr-port]` \[`--statmon-port statmon-port]` \[`--notify-port notify-port] [--config-fs config-fs] [--default-supported-versions default-supported-versions] [--enable-auth-types enable-auth-types]`

{% hint style="info" %}
* To support NFS file-locking, ensure the system meets the prerequisites outlined in [#nfs-file-locking-support](./#nfs-file-locking-support "mention").
* For the default published ports, see the [#required-ports](../../planning-and-installation/prerequisites-and-compatibility/#required-ports "mention").
{% endhint %}

**Parameters**

<table><thead><tr><th width="197">Name</th><th width="348">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>mountd-port</code></td><td>Set the alternate port if the existing mountd service is not operating on the default published port.<br>0 means use the default published port.</td><td><code>0</code></td></tr><tr><td><code>lockmgr-port</code></td><td><p>Set the alternate port for the NFS lock manager used in NFSv3.</p><p>0 means use the default published port.</p></td><td><code>0</code></td></tr><tr><td><code>statmon-port</code></td><td>Set the alternate port for the NFS status monitor used in NFSv3.<br>0 means use the default published port.</td><td><code>0</code></td></tr><tr><td><code>notify-port</code></td><td>Set the alternate port for notification used in NFSv3.<br>0 means use the default published port.</td><td><code>0</code></td></tr><tr><td><code>config-fs</code>*</td><td>The predefined filesystem name for maintaining the persisting cluster-wide protocols' configurations.<br>Verify that the filesystem is already created. If not, create it. For details, see  <a data-mention href="../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations">#dedicated-filesystem-requirement-for-persistent-protocol-configurations</a></td><td></td></tr><tr><td><code>default-supported-versions</code></td><td><p>Determines the default NFS version.<br>Possible values: <br><code>v3</code></p><p><code>v4</code></p><p><code>v3,v4</code></p></td><td><code>v3</code></td></tr><tr><td><code>enable-auth-types</code></td><td><p>A comma-separated list of authentication types that can be used when setting the NFS client permissions.</p><p>Possible values: <code>none,sys,krb5,krb5i,krb5p</code><br>Example:<br><code>krb5,krb5i,krb5p</code></p></td><td><p>Depends on Kerberos configuration:</p><ul><li>If not configured: <code>none,sys</code></li><li>If configured: <code>krb5</code></li></ul></td></tr></tbody></table>

#### Show NFS global configuration

**Command:** `weka nfs global-config show`

**Example**

```
$ weka nfs global-config show
NFS Global Configuration
   mountd port: 0
     Config FS: .config_fs
Default Supported Versions: V3
Enabled Auth Types: KRB5, KRB5i, KRB5p
Default Auth Types: KRB5
Supported Auth Types: NONE, SYS, KRB5, KRB5i, KRB5p
```

{% hint style="info" %}
The parameters `Default Auth Types` and `Supported Auth Types` are determined internally.
{% endhint %}

## **Configure the NFS cluster level**

### Create interface groups

**Command:** `weka nfs interface-group add`

Use the following command line to add an interface group:

`weka nfs interface-group add <name> <type> [--subnet subnet] [--gateway gateway]`

**Example**

`weka nfs interface-group add nfsw NFS  --subnet 255.255.255.0 --gateway 10.0.1.254`

**Parameters**

<table><thead><tr><th width="225">Name</th><th width="325">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Unique interface group name.</td><td></td></tr><tr><td><code>type</code>*</td><td>Group type.<br>Can only be  <code>NFS</code>.</td><td></td></tr><tr><td><code>subnet</code></td><td>The valid subnet mask in the 255.255.0.0 format.</td><td><code>255.255.255.255</code></td></tr><tr><td><code>gateway</code></td><td>Gateway valid IP.</td><td><code>255.255.255.255</code></td></tr></tbody></table>

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

<table><thead><tr><th width="220">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Interface group name.</td></tr><tr><td><code>container-id</code>*</td><td>Valid frontend container ID on which the port resides. You can obtain the container ID by running the <code>weka cluster container</code> command.</td></tr><tr><td><code>port</code>*</td><td>Valid port's device. Maximum 14 characters.<br>Example: <code>eth1</code>.</td></tr></tbody></table>

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

### Configure the service mountd port

The mountd service receives requests from clients to mount to the NFS server. It is possible to set it explicitly rather than have it randomly selected on each server startup. This allows an easier setup of the firewalls to allow that port.

Use the following command lines to set and view the mountd configuration:

`weka nfs global-config set --mountd-port <mountd-port>`&#x20;

`weka nfs global-config show`

### Configure user group resolution

NFS-W can authenticate more than 16 user groups, but it requires the external resolution of the user's groups, which means associating users with their respective group-IDs outside of the NFS protocol.

**Procedure**

1. **Configure interface groups:**
   * See [Create interface groups](nfs-support-1.md#create-interface-groups).&#x20;
2. **Configure NFS client permissions:**
   * See [Set the NFS client permissions](nfs-support-1.md#manage-nfs-client-permissions).
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

## Integrate the NFS and Kerberos service

Integrating the NFS and Kerberos service is critical to setting up a secure network communication process. This procedure involves defining the Key Distribution Center (KDC) details, administrative credentials, and other parameters to ensure a robust and secure authentication process.

**Before you begin**

* Ensure a configuration filesystem is set. See [#configure-the-nfs-global-settings](nfs-support-1.md#configure-the-nfs-global-settings "mention").
* Ensure the NFS cluster is configured and running. see [#configure-the-nfs-cluster-level](nfs-support-1.md#configure-the-nfs-cluster-level "mention").
* For Active Directory (AD) integration, obtain the required information from the AD administrator. (WEKA handles the generation of the keytab file.)
* For MIT integration, ensure the following:
  * Obtain the required information from the MIT Key Distribution Center (KDC) and OpenLDAP administrators.
  * A pre-generated keytab file in base64[^1] format stored in an accessible location is required.

{% hint style="info" %}
In all KDC and LDAP parameters, use the FQDN format. The hostname part of the FQDN is restricted to a maximum of 20 characters.
{% endhint %}

### Set the Kerberos service

**Command:** `weka nfs kerberos service setup`

Use the following command to set up NFS Kerberos Service information:

`weka nfs kerberos service setup <kdc-realm-name> <kdc-primary-server> <kdc-admin-server> [--kdc-secondary-server kdc-secondary-server][--force] [--restart]`

**Example**

{% code overflow="wrap" %}
```
weka nfs kerberos service setup WEKA-REALM kdc.primary.weka.io kdc.admin.weka.io --kdc-secondary-server kdc.secondary.weka.io
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="262">Name</th><th width="386">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>kdc-realm-name</code>*</td><td>Specifies the realm (domain) used by Kerberos.</td><td></td></tr><tr><td><code>kdc-primary-server</code>*</td><td>Identifies the server hosting the primary Key Distribution Center service.</td><td></td></tr><tr><td><code>kdc-admin-server</code>*</td><td>Identifies the server hosting the administrative Key Distribution Center service.</td><td></td></tr><tr><td><code>kdc-secondary-server</code></td><td>Identifies the server hosting the secondary Key Distribution Center service.</td><td></td></tr><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured or registered.</td><td>Not used</td></tr><tr><td><code>restart</code></td><td>When used, the command restarts the NFS-W containers after the changes are applied.</td><td>Not used</td></tr></tbody></table>

#### Show NFS Kerberos service setup information

**Command:** `weka nfs kerberos service show`

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

1. [Register Kerberos with AD](nfs-support-1.md#integrate-kerberos-with-a-d)
2. [Set up Kerberos to use AD LDAP](nfs-support-1.md#set-up-kerberos-to-use-a-d-ldap)

#### Register Kerberos with AD

**Command:** `weka nfs kerberos registration setup-ad`

Use the following command to register the Kerberos with Microsoft Active Directory:

`weka nfs kerberos registration setup-ad <nfs-service-name> <realm-admin-name> [realm-admin-passwd] [--force] [--restart]`

**Example**

{% code overflow="wrap" %}
```
weka nfs kerberos registration setup-ad myservicename.test.example.com myrealmadmin
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="231">Name</th><th width="407">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>nfs-service-name</code>*</td><td>This refers to the complete domain name for a specific NFS server.</td><td></td></tr><tr><td><code>realm-admin-name</code>*</td><td>The username of an administrator who has access to the LDAP directory. This user manages the KDC within a realm.</td><td></td></tr><tr><td><code>realm-admin-passwd</code></td><td>This parameter is for the password of the administrative user who manages the KDC within a realm.<br>It’s not stored in the configuration for security reasons. If it’s not provided during setup, the system asks for it. The entered password isn’t shown on the screen to protect privacy and security.</td><td></td></tr><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured or registered.</td><td>Not used</td></tr><tr><td><code>restart</code></td><td>When used, the command restarts the NFS-W containers after the changes are applied.</td><td>Not used</td></tr></tbody></table>

#### Set up Kerberos to use AD LDAP

**Command:** `weka nfs ldap setup-ad`

Use the following command to set up NFS configuration to use AD LDAP:

`weka nfs ldap setup-ad [--force] [--no-restart]`

**Example**

{% code overflow="wrap" %}
```
weka nfs ldap setup-ad
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="189">Name</th><th width="407">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured or registered.</td><td>Not used</td></tr><tr><td><code>no-restart</code></td><td>When used, it prevents NFS-W containers from restarting to apply changes.</td><td>Not used</td></tr></tbody></table>

{% hint style="warning" %}
In a successful operation, the system automatically restarts the NFS containers, leading to a temporary disruption in the IO service for connected NFS clients. However, if you want to avoid restarting the NFS-W containers, add the `--no-restart` option to the command line.
{% endhint %}

### Integrate Kerberos with MIT

Integrating Kerberos with MIT involves the following:

1. [Register Kerberos with MIT](nfs-support-1.md#register-kerberos-with-mit)
2. [Set up Kerberos to use OpenLDAP](nfs-support-1.md#set-up-kerberos-to-use-openldap)

#### Register Kerberos with MIT

**Command:** `weka nfs kerberos registration setup-mit`

Use the following command to register the Kerberos with MIT KDC:

`weka nfs kerberos registration setup-mit <nfs-service-name> <keytab-file> [--force] [--restart]`

{% hint style="info" %}
To register the Kerberos service with MIT, a pre-generated  [keytab file](#user-content-fn-2)[^2] , stored in an accessible location, is required.
{% endhint %}

**Example**

{% code overflow="wrap" %}
```
weka nfs kerberos registration setup-mit myservicename.test.example.com myservicename.keytab
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="227">Name</th><th width="407">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>nfs-service-name</code>*</td><td>Fully Qualified Domain Name (FQDN) for the NFS Service. This refers to the complete domain name for a specific NFS server. The hostname part of the FQDN is restricted to a maximum of 20 characters.</td><td></td></tr><tr><td><code>keytab-file</code>*</td><td>The path to the pre-generated keytab file containing the keys for the NFS service’s unique identity in <a data-footnote-ref href="#user-content-fn-3">base64</a> format.</td><td></td></tr><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured.</td><td>Not used</td></tr><tr><td><code>restart</code></td><td>When used, the command restarts the NFS-W containers after the changes are applied.</td><td>Not used</td></tr></tbody></table>

#### Set up Kerberos to use OpenLDAP

**Command:** `weka nfs ldap setup-openldap`

Use the following command to set up Kerberos to use OpenLDAP:

`weka nfs ldap setup-openldap  <server-name> <ldap-domain> <reader-user-name>[reader-user-password] [--base-dn base-dn] [--ldap-port-number ldap-port-number][--force] [--no-restart]`

**Example**

{% code overflow="wrap" %}
```
weka nfs ldap setup-openldap myldapserver.test.example.com, myldapdomain.example.com, cn=readonly-user,dc=test,dc=example,dc=com
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="241">Name</th><th width="407">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>server-name</code>*</td><td><p></p><p>Specifies the server hosting the Lightweight Directory Access Protocol service.</p></td><td></td></tr><tr><td><code>ldap-domain</code>*</td><td>Defines the domain the Lightweight Directory Access Protocol service will access.</td><td></td></tr><tr><td><code>reader-user-name</code>*</td><td>The username of an administrative user used to generate the keytab file.</td><td></td></tr><tr><td><code>reader-user-password</code></td><td>The administrative user's password.<br>(It is maintained in a configuration file.)</td><td></td></tr><tr><td><code>base-dn</code></td><td>The base Distinguished Name (DN) for the Lightweight Directory Access Protocol directory tree.</td><td></td></tr><tr><td><code>ldap-port-number</code></td><td>The port number on which the Lightweight Directory Access Protocol server listens.</td><td>389</td></tr><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured or registered.</td><td>Not used</td></tr><tr><td><code>no-restart</code></td><td>When used, it prevents NFS-W containers from restarting to apply changes.</td><td>Not used</td></tr></tbody></table>

{% hint style="warning" %}
In a successful operation, the system automatically restarts the NFS containers, leading to a temporary disruption in the IO service for connected NFS clients. However, if you want to avoid restarting the NFS-W containers, add the `--no-restart` option to the command line.
{% endhint %}

### Show Kerberos LDAP setup information

**Command:** `weka nfs ldap show`

**Example**

{% code fullWidth="true" %}
```bash
$ weka nfs ldap show
SERVER TYPE      LDAP DOMAIN      SERVER NAME  SERVER PORT  BASE DN  READER NAME  READER PASSWORD  GENERATION ID  SETUP STATUS
ActiveDirectory  test.wekalab.io               0                                                   1              CONFIGURED
```
{% endcode %}

### Clear the Kerberos LDAP configuration

**Command:** `weka nfs ldap reset`

Use the following command to clear the NFS LDAP configuration:

`weka nfs ldap reset [--force] [--no-restart]`

**Parameters**

<table><thead><tr><th width="189">Name</th><th width="438">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured.</td><td>Not used</td></tr><tr><td><code>no-restart</code></td><td>When used, it prevents NFS-W containers from restarting to apply changes.</td><td>Not used</td></tr></tbody></table>

### Show Kerberos registration information

**Command:** `weka nfs kerberos registration show`

**Example**

```bash
$ weka nfs kerberos registration show
NFS SERVICE NAME          NFS KDC TYPE        GENERATION ID      REGISTRATION STATUS
nfs.test.wekalab.io       ActiveDirectory     1                  REGISTERED
```

### Clear Kerberos configuration

**Command:** `weka nfs kerberos reset`

Use the following command to clear the NFS Kerberos service configuration:

`weka nfs kerberos reset [--force] [--no-restart]`

**Parameters**

<table><thead><tr><th width="189">Name</th><th width="407">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>force</code></td><td>When used, it forces the action to proceed without further confirmation. Typically used when the service is configured or registered.<br>Use this flag only to clear the configuration created by a previous call to <code>weka nfs kerberos service setup</code> succeeded.</td><td>Not used</td></tr><tr><td><code>no-restart</code></td><td>When used, it prevents NFS-W containers from restarting to apply changes.</td><td>Not used</td></tr></tbody></table>

{% hint style="warning" %}
In a successful operation, the system automatically restarts the NFS containers, leading to a temporary disruption in the IO service for connected NFS clients. However, if you want to avoid restarting the NFS-W containers, add the `--no-restart` option to the command line.
{% endhint %}

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

Run the command: \
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

## **Manage the NFS export level (permissions)**

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

`weka nfs permission add <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions] [--enable-auth-types enable-auth-types]`

Use the following command lines to update NFS permissions:

`weka nfs permission update <filesystem> <group> [--path path] [--permission-type permission-type] [--squash squash] [--anon-uid anon-uid] [--anon-gid anon-gid] [--obs-direct obs-direct] [--manage-gids manage-gids] [--privileged-port privileged-port] [--supported-versions supported-versions][--enable-auth-types enable-auth-types]`

Use the following command lines to delete NFS permissions:

`weka nfs permission delete <filesystem> <group> [--path path]`

**Parameters**

<table><thead><tr><th width="229">Name</th><th width="320">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>filesystem</code>*</td><td>Existing filesystem name.<br>A filesystem with Required Authentication set to ON cannot be used for NFS client permissions.</td><td></td></tr><tr><td> <code>group</code>*</td><td>Existing client group name.</td><td></td></tr><tr><td> <code>path</code></td><td>The root of the valid share path.</td><td><code>/</code></td></tr><tr><td><code>permission-type</code></td><td>Permission type.<br>Possible values: <code>ro</code> (read-only), <code>rw</code> (read-write)</td><td><code>rw</code></td></tr><tr><td><code>squash</code></td><td>Squashing type.<br>Possible values: <code>none</code>, <code>root</code>, <code>all</code> </td><td><code>none</code></td></tr><tr><td><code>anon-uid</code>*</td><td>Anonymous user ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</td><td><code>65534</code></td></tr><tr><td><code>anon-gid</code>*</td><td>Anonymous user group ID.<br>Relevant only for root squashing.<br>Possible values: <code>1</code> to <code>65535</code>.</td><td><code>65534</code></td></tr><tr><td><code>obs-direct</code></td><td>See <a href="../../weka-filesystems-and-object-stores/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a>.<br>Possible values: <code>on</code>, <code>off</code>.</td><td><code>on</code></td></tr><tr><td><code>manage-gids</code></td><td><p>Sets external group IDs resolution.</p><p>The list of group IDs received from the client is replaced by a list determined by an appropriate lookup on the server.<br>Possible values: <code>on</code>, <code>off</code>.</p></td><td><code>off</code></td></tr><tr><td><code>privileged-port</code></td><td>Sets the share only to be mounted via privileged ports (1-1024), usually allowed by the root user.<br>Possible values: <code>on</code>, <code>off</code>.</td><td><code>off</code></td></tr><tr><td><code>supported-versions</code></td><td>A comma-separated list of supported NFS versions.<br>Possible values: <code>v3</code>, <code>v4</code>.</td><td>The <code>default-supported-versions</code> setting in <a href="nfs-support-1.md#configure-the-nfs-global-settings">NFS global settings</a> determines the default NFS version.</td></tr><tr><td><code>enable-auth-types</code></td><td>A comma-separated list of NFS authentication types.<br>Possible values are determined by the  <code>enable-auth-types</code> in <a href="nfs-support-1.md#configure-the-nfs-global-settings">NFS global settings</a>.</td><td>The <code>default-auth-types</code> in NFS global settings determine the default.</td></tr></tbody></table>

### View connected NFS clients

**Command:** `weka nfs clients show`

Use the following command line to view insights of NFS clients connected to the NFS-W cluster in JSON output format.

`weka nfs clients show [--interface-group interface-group] [--container-id container-id] [--fip floating-ip]`

**Parameters**

<table data-full-width="false"><thead><tr><th width="200">Name</th><th width="283">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>interface-group</code></td><td>Interface group name.<br>A filter to show only the clients connected to the containers in the specified group.</td><td>The output shows all clients connected to any container in the NFS-W cluster regardless of the assigned interface group.</td></tr><tr><td><code>container-id</code></td><td><p>NFS-W container ID.</p><p>A filter to show only the clients connected to the specified container ID.</p></td><td>The output shows all clients connected to any container in the NFS-W cluster.</td></tr><tr><td><code>fip</code></td><td>Destination floating IP address.</td><td>The output shows all clients connected to all floating IP addresses.</td></tr></tbody></table>

[^1]: A binary data in an American Standard Code for Information Interchange (ASCII) string format.

[^2]: All Kerberos server machines need a keytab file, called `/etc/krb5.keytab`, to authenticate to the KDC. For details, see [https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-install/The-Keytab-File.html](https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-install/The-Keytab-File.html).

[^3]: A binary data in an American Standard Code for Information Interchange (ASCII) string format.
