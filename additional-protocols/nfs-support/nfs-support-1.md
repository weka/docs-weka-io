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
weka nfs global-config set [--acl <on-off>] [--config-fs <string>] [--default-acl-type <acl-type>] [--default-supported-versions <nfs-versions>…] [--direct-io <on-off>] [--enable-auth-types <nfs-auth-types>…] [--enable-multi-tenant <on-off>] [--extended-stats <on-off>] [--force] [--force-config-fs <on-off>] [--lockmgr-port <uint16>] [--max-client-connections <uint>] [--max-memory <capacity>] [--max-open-fds <uint>] [--mountd-port <uint16>] [--no-restart] [--notify-port <uint16>] [--statmon-port <uint16>]
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
| `--max-client-connections` \<uint> | Maximum number of concurrent client connections for each NFS server: `0` (automatic) or a value from 1024 to 65536. Default: `0` |
| `--max-memory` \<capacity> | Memory ceiling of each NFS container, in whole GiB from 2GiB to 512GiB, for example, `64GiB`. Set it before the first NFS container is configured. Default: 32GiB |
| `--max-open-fds` \<uint> | Maximum number of files each NFS server can hold open: `0` (default, 500000) or a value from 10000 to 10000000. |
| `--mountd-port` \<uint16> | Port number for mountd service. Default: 0 |
| `--no-restart` | Prevent NFS-W containers from restarting when changes are applied. |
| `--notify-port` \<uint16> | Port for NFSv3 notification. Default 0 means any available port. |
| `--statmon-port` \<uint16> | Port for NFS status monitor. Default 0 means any available port. |

{% hint style="info" %}
`--max-client-connections`, `--max-open-fds`, and `--max-memory` set the resources of each NFS server. For their defaults and the effect of each setting, see [#nfs-server-resources](./#nfs-server-resources "mention"). To view the current usage, see [#view-nfs-server-resource-usage](nfs-support-1.md#view-nfs-server-resource-usage "mention").

These options are available through the CLI and the API. The GUI global settings dialog exposes the Multi-Tenancy toggle and the NFS port fields.
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
{% endhint %}

{% hint style="info" %}
A tenant administrator running this command sees a reduced view. The Kerberos authentication types are omitted, so the output differs from what a cluster administrator sees. See [multi-tenancy-tenant-level-administration.md](../../operation-guide/weka-native-multi-tenancy-management/multi-tenancy-tenant-level-administration.md "mention").
{% endhint %}

The resource rows of the output show the configured value and the value in force:

| Row | Shows |
| --- | --- |
| `Max Client Connections` | `auto (effective <n>)` when set to `0`, or `<setting> (effective <n>)`. |
| `Max Open Files` | `default (effective <n>)` when set to `0`, or `<setting> (effective <n>)`. |
| `FD Rlimit` | The file descriptor limit of each NFS server process, derived from the two settings above: `<derived> (effective <n>)`. |
| `Container Memory Ceiling` | The configured memory ceiling. Empty when the default applies. |
| `Container Memory Ceiling Effective` | The memory ceiling in force. |

**Example**

The following output is from a cluster with the default resource settings.

{% code fullWidth="true" %}
```bash
$ weka nfs global-config show
               ACL Feature Enabled  true
                         Config FS  .config_fs
          Container Memory Ceiling
Container Memory Ceiling Effective  32.00 GiB
                  Default ACL Type  POSIX
                Default Auth Types  SYS
        Default Supported Versions  V3
                        Direct I/O  true
                Enabled Auth Types  SYS
                      Multi-Tenant  false
                    Extended Stats  false
                      Grace Period  45
                      Lease Period  30
              Lock Recovery Period  75
                 Lock Manager Port  0
           Locking Feature Enabled  true
            Max Client Connections  auto (effective 1024)
                    Max Open Files  default (effective 500000)
                         FD Rlimit  505120 (effective 505120)
                       Mountd Port  0
                       Notify Port  0
               Status Monitor Port  0
              Supported Auth Types  NONE,SYS
```
{% endcode %}

### View NFS server resource usage

Shows the client connections, open files, and memory of each NFS container against its maximums, with a state for each resource. Running this command requires the Cluster Admin role.

**Command:** `weka nfs resource-usage`

```sh
weka nfs resource-usage [--container-id <container-id>]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `--container-id` | ID of one NFS container. Without this option, the command shows every NFS container from its latest sample. With it, the command reads the container directly. |

The **Source** column shows `sampled` or `live`, and **Sample Age** shows how old a sampled reading is. The cluster samples each NFS container every 30 seconds.

| Column | Description |
| --- | --- |
| `Connections`, `Conn Limit`, `Conn %`, `Conn State` | Client connections to the NFS server, the maximum, the percentage used, and the state. |
| `Open Files`, `File Limit`, `File %`, `File State` | Files the NFS server holds open, the maximum, the percentage used, and the state. |
| `Memory`, `Mem Limit`, `Mem %`, `Mem State` | Memory used by the NFS container, its memory ceiling, the percentage used, and the state. |

Each state is `OK`, `HIGH`, or `LIMIT`. For the thresholds, see [#nfs-server-resources](./#nfs-server-resources "mention"). Add `-v` for the file descriptor and socket counts behind these values, or `-J` for JSON output.

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
* Ensure you have the Tenant Admin role or higher. With NFS multi-tenancy enabled, run the commands in the root tenant.
* Ensure the directory accounts have the required privileges. See [#nfs-user-and-group-resolution](./#nfs-user-and-group-resolution "mention").

{% hint style="info" %}
In all KDC and LDAP parameters, use the FQDN format.

The NFS service name is a DNS name dedicated to the NFS service, in the form `<hostname>.<domain>`, where the domain is the domain of the realm. The hostname contains only letters, digits, and inner hyphens, and has up to 19 characters for Active Directory or up to 63 characters for MIT Kerberos. Use a name that differs from the names of the KDC and directory servers.
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

**Example**

The following output is from a cluster without an LDAP configuration. After you configure a mode, the row shows the server type, the domain, and the `CONFIGURED` status.

{% code fullWidth="true" %}
```bash
$ weka nfs ldap show
Server Type  LDAP Domain  Server Name  Server Port  Base DN  Reader Name  Reader Password  Generation ID  Status
None                                             0                                                     0  UNCONFIGURED
```
{% endcode %}

### Clear the Kerberos LDAP configuration

Removes the LDAP configuration used for NFS user and group resolution: the identity service configuration, the ID mapping configuration, the stored reader password, and the CA certificate. The Kerberos service and registration remain. To remove them, see [#clear-kerberos-configuration](nfs-support-1.md#clear-kerberos-configuration "mention"). The Active Directory computer account remains in Active Directory.

While Kerberos is configured or ACLs are enabled, add `--force` to reset the configuration.

**Command:** `weka nfs ldap reset`

```sh
weka nfs ldap reset [--force] [--no-restart]
```

**Parameters**

| Parameter      | Description                                          |
| --- | --- |
| `--force` | Perform this action without further confirmation. |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. |

### Export and import the LDAP configuration

Exports the identity service configuration that the cluster generated, and imports a configuration that you edited. Use export and import to add Active Directory domains, to verify the certificate of the directory server, or to copy the configuration to another cluster. The commands write and read these files:

* `sssd-conf-file`: The identity service (SSSD) configuration.
* `idmapd-conf-file`: The NFSv4 ID mapping configuration.
* `ca-cert-file`: Optional. The CA certificate of the directory server, in PEM format, up to 16 KiB.

**Command:** `weka nfs ldap export-ad`

```sh
weka nfs ldap export-ad <server-name> <ldap-domain> <sssd-conf-file> <idmapd-conf-file> [<ca-cert-file>]
```

**Command:** `weka nfs ldap export-openldap`

```sh
weka nfs ldap export-openldap <server-name> <ldap-domain> <sssd-conf-file> <idmapd-conf-file> [<ca-cert-file>]
```

**Command:** `weka nfs ldap import-ad`

```sh
weka nfs ldap import-ad <server-name> <ldap-domain> <sssd-conf-file> <idmapd-conf-file> [<ca-cert-file>] [--force] [--no-restart]
```

**Command:** `weka nfs ldap import-openldap`

```sh
weka nfs ldap import-openldap <server-name> <ldap-domain> <sssd-conf-file> <idmapd-conf-file> [<ca-cert-file>] [--force] [--no-restart] [--verify]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `server-name`\* | Directory server name. |
| `ldap-domain`\* | Directory domain. |
| `sssd-conf-file`\* | Path to the identity service configuration file. Export writes it, and import reads it. |
| `idmapd-conf-file`\* | Path to the ID mapping configuration file. Export writes it, and import reads it. |
| `ca-cert-file` | Path to the CA certificate file. Export writes the stored certificate, and import stores the certificate in the file. |
| `--force` | Import over an existing configuration of the same directory type. To import a configuration of the other type, reset the LDAP configuration first. |
| `--no-restart` | Do not restart the NFS containers to apply the change. |
| `--verify` | Verify the connection to the OpenLDAP server. |

#### Add Active Directory domains

Lists the domains of an Active Directory forest explicitly, instead of relying on discovery.

**Procedure**

1. Export the configuration:

   ```sh
   weka nfs ldap export-ad dc1.corp.example.com corp.example.com sssd.conf idmapd.conf
   ```
2. In `sssd.conf`, add the domains to the `domains` line, for example, `domains = corp.example.com,eu.corp.example.com`, and add a `[domain/<domain name>]` section for each added domain. Keep the domain from the command line in the list, with `id_provider = ad`.
3. Import the configuration:

   ```sh
   weka nfs ldap import-ad dc1.corp.example.com corp.example.com sssd.conf idmapd.conf --force
   ```

The NFS service stays registered in one domain. Each domain in the `domains` line needs its own section in the file.

#### Verify the directory server certificate

Imports the CA certificate of the directory server, so the identity service uses StartTLS and verifies the server certificate.

**Procedure**

1. Export the configuration with `weka nfs ldap export-ad` or `weka nfs ldap export-openldap`.
2. For OpenLDAP, add the reader password to the exported `sssd.conf`, which does not include it:

   ```
   ldap_default_authok_type = password
   ldap_default_authok = <password>
   ```

   The cluster stores the password encrypted and removes these lines from the stored file.
3. Import the configuration with the CA certificate as the fifth argument, for example:

   ```sh
   weka nfs ldap import-openldap ldap1.example.com example.com sssd.conf idmapd.conf ldap-ca.pem --verify
   ```

A later import without a certificate keeps the stored certificate. To remove the certificate, reset the LDAP configuration. See [#clear-the-kerberos-ldap-configuration](nfs-support-1.md#clear-the-kerberos-ldap-configuration "mention").

#### Copy the LDAP configuration to another cluster

Export the configuration on the source cluster, and import it on the target cluster with the same server and domain. For Active Directory, register the target cluster in the domain before you import. See [#register-kerberos-with-ad](nfs-support-1.md#register-kerberos-with-ad "mention").

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

Lists the rules defined on the client access groups. A rule matches clients by IP address or range, by DNS name, or by netgroup membership. For the order in which the NFS server checks the rules, see [#nfs-client-access-rules](./#nfs-client-access-rules "mention").

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
| `name`\* | Name of the NFS client group in which to create the rule. |
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
| `name`\* | Name of the NFS client group from which to delete the rule. |
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
| `name`\* | Name of the NFS client group in which to create the rule. |
| `ip`\* | IPv4 address with a prefix length, for example, 1.1.1.0/16. |

**Examples**

`weka nfs rules add ip client-group1 192.168.0.0/16`\
`weka nfs rules add ip client-group2 172.16.0.0/16`

The system stores an IP rule as its network address. For example, `10.1.2.3/24` is stored and listed as `10.1.2.0/24`, and either form removes it.

#### Remove IP-based client group rules

Removes an IP-based rule from a client access group.

**Command:** `weka nfs rules remove ip`

```sh
weka nfs rules remove ip <name> <ip>
```

**Parameters**

| Parameter | Description                                                                    |
| --- | --- |
| `name`\* | Name of the NFS client group from which to delete the rule. |
| `ip`\* | IPv4 address with a prefix length, for example, 1.1.1.0/16. |

**Examples**

`weka nfs rules remove ip client-group1 192.168.114.0/24`\
`weka nfs rules remove ip client-group2 172.16.0.0/16`

#### Add netgroup client group rules

Adds a rule that admits every member of a netgroup to a client group. Create the netgroup first. See [#manage-nfs-netgroups](nfs-support-1.md#manage-nfs-netgroups "mention").

**Command:** `weka nfs rules add netgroup`

```sh
weka nfs rules add netgroup <name> <netgroup>
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Name of the NFS client group in which to create the rule. |
| `netgroup`\* | Name of the netgroup whose members get access. A leading `@`, as shown in listings, is accepted. |

**Example**

`weka nfs rules add netgroup compute eng`

The client group listing shows the rule as `@eng`.

#### Remove netgroup client group rules

Removes a netgroup rule from a client access group. The netgroup and its members remain.

**Command:** `weka nfs rules remove netgroup`

```sh
weka nfs rules remove netgroup <name> <netgroup>
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Name of the NFS client group from which to delete the rule. |
| `netgroup`\* | Name of the netgroup to detach from the client group. A leading `@` is accepted. |

**Example**

`weka nfs rules remove netgroup compute eng`

### Manage NFS netgroups

A netgroup is a named list of client hostnames that a client group rule can reference. For how the NFS server matches netgroup members, the requirements, and the maximums, see [#netgroups](./#netgroups "mention").

To grant a list of hosts access to an export:

1. Create a netgroup.
2. Add the hostnames as members.
3. Add a netgroup rule to a client group. See [#add-netgroup-client-group-rules](nfs-support-1.md#add-netgroup-client-group-rules "mention").
4. Grant the client group a permission on the export. See [#manage-nfs-client-permissions](nfs-support-1.md#manage-nfs-client-permissions "mention").

**Example**

```sh
weka nfs netgroup add eng
weka nfs netgroup member add eng --from-file eng-hosts.txt
weka nfs client-group add compute
weka nfs rules add netgroup compute eng
weka nfs permission add default compute --path /projects --permission-type RW
```

#### Create a netgroup

Creates an empty netgroup.

**Command:** `weka nfs netgroup add`

```sh
weka nfs netgroup add <name>
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Name of the netgroup to create. Starts with a letter or an underscore, and contains only letters, digits, `.`, `_`, and `-`, up to 64 characters. |

#### Add members to a netgroup

Adds hostnames to a netgroup in one operation. Give the hostnames with `--hosts` or `--from-file`, not both.

The command stores the valid hostnames and lists each rejected entry with its reason, for example, an IP address or a wildcard pattern. A hostname that is already a member is counted under **Already Present**. Running the command again with the same list changes nothing.

**Command:** `weka nfs netgroup member add`

```sh
weka nfs netgroup member add <name> [--from-file <string>] [--hosts <hostnames>…]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Name of the netgroup. |
| `--hosts` | Member hostnames, comma-separated or by repeating the option. |
| `--from-file` | Path to a host list file. |

The host list file holds one or more comma-separated hostnames on each line. A `#` starts a comment that runs to the end of the line, and blank lines are ignored. The file can be up to 1 MiB.

```
# lab machines
node01.lab.example.com
node02.lab.example.com   # rack 4
node03.lab.example.com,node04.lab.example.com
```

**Example**

```
$ weka nfs netgroup member add eng --hosts node01.lab.example.com,node02.lab.example.com,10.1.2.3
Members Added
Netgroup  Added  Already Present  Members
eng       2      0                2

Rejected
Hostname  Reason
10.1.2.3  is an IP address; use an IP rule on the client group
```

#### Remove members from a netgroup

Removes hostnames from a netgroup in one operation. A hostname that is not a member is listed under **Not Found**.

**Command:** `weka nfs netgroup member remove`

```sh
weka nfs netgroup member remove <name> [--from-file <string>] [--hosts <hostnames>…]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Name of the netgroup. |
| `--hosts` | Member hostnames, comma-separated or by repeating the option. |
| `--from-file` | Path to a host list file, in the format described in [#add-members-to-a-netgroup](nfs-support-1.md#add-members-to-a-netgroup "mention"). |

**Example**

`weka nfs netgroup member remove eng --hosts node02.lab.example.com`

#### View netgroups

Lists the netgroups with the number of members, the number of unresolved members, and the number of client groups that reference each netgroup.

**Command:** `weka nfs netgroup list`

```sh
weka nfs netgroup list [--name <nfs-netgroup>]
```

To show one netgroup with the status of each member and the client groups and exports that reference it, run:

**Command:** `weka nfs netgroup show`

```sh
weka nfs netgroup show <name>
```

The **Resolution** column shows the result of the latest membership check for each member:

| Resolution | Description |
| --- | --- |
| `resolved` | The hostname resolves, and the PTR record of its address returns the member name. |
| `unresolved` | The hostname does not resolve. The **Reason** column shows the resolver result, for example, `nxdomain` or `timeout`. |
| `ptr_mismatch` | The hostname resolves, but the PTR record of its address returns another name, shown in **Resolves To**. A client with this address does not match the netgroup. To fix it, correct the PTR record or add the name it returns as the member. |
| `unchecked` | No membership check has covered the member yet. |

**Example**

```
$ weka nfs netgroup show eng
Netgroup
Name  Members  Unresolved
eng   3        1

Members
Hostname                Resolution    Resolves To                  Reason
node01.lab.example.com  resolved
node02.lab.example.com  unresolved                                 nxdomain
node03.lab.example.com  ptr_mismatch  node03-mgmt.lab.example.com  ptr_differs
Resolution reported by nfs-01 at 2026-10-20 09:12:03. Resolution is advisory: access is decided by the reverse name a client presents when it connects.

Referencing Client Groups
Client Group  Exports
compute       default:/projects
```

#### Rename a netgroup

Renames a netgroup. Client group rules that reference the netgroup use the new name.

**Command:** `weka nfs netgroup rename`

```sh
weka nfs netgroup rename <name> <new-name>
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Current name of the netgroup. |
| `new-name`\* | New name for the netgroup. |

#### Remove a netgroup

Removes a netgroup and its members. Before you remove a netgroup, remove its rule from every client group that references it. To list those client groups, run `weka nfs netgroup show <name>`.

**Command:** `weka nfs netgroup remove`

```sh
weka nfs netgroup remove <name>
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `name`\* | Name of the netgroup to remove. |

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

### Look up the NFS access of a client

Shows every export a client can mount, the access level the client gets, and the client group rule that grants it. The lookup resolves the target through the DNS configuration of an NFS server, the same way the NFS server resolves a connecting client, and checks the rules in the order the NFS server checks them.

**Command:** `weka nfs access lookup`

```sh
weka nfs access lookup <target> [--exact] [--host]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `target`\* | Hostname, IPv4 address, or IPv4 subnet to look up, for example, `node01.lab.example.com`, `10.1.2.7`, or `10.1.2.0/24`. For a subnet, the lookup checks IP rules only. |
| `--host` | List as related only the configured names for the same host, in short or fully qualified form. |
| `--exact` | List as related only the configured names spelled exactly as the target. |

Without `--host` or `--exact`, the **Member Entries** table also lists configured names that start with the target, so that a name that almost matches is visible. Use at most one of the two options.

The output has four tables:

| Table | Description |
| --- | --- |
| **Access Lookup** | The target, the address the lookup checked, the name that address resolves to, and the NFS server that resolved it (**Resolved By**). |
| **Member Entries** | The configured rules and netgroup members the lookup checked, with **Matches** set to `yes` or `no` and the reason. |
| **Client Groups** | The client groups that admit the client. **Granted By** shows the rule the NFS server applies. **Also Matches** shows other matching rules in the same client group, which the NFS server does not reach. |
| **Exports** | The exports the client can mount, in the order the NFS server checks the permissions. **Effective** marks the access the client gets. |

**Example**

```
$ weka nfs access lookup 10.1.2.7
Access Lookup
Target    Kind  Address   Resolves To             Resolved By
10.1.2.7  ip    10.1.2.7  node01.lab.example.com  nfs-01

Member Entries
Entry                   Kind      Held By  Matches  Reason
10.1.2.0/24             ip        compute  yes      10.1.2.7 is inside 10.1.2.0/24
node01.lab.example.com  netgroup  eng      yes      node01.lab.example.com is the name 10.1.2.7 resolves to

Client Groups
A client group serves a client by the first entry that matches, in the order ip, dns, netgroup; the rest are listed as also matching.
Client Group  Granted By      Also Matches
compute       ip 10.1.2.0/24  @eng
ro-all        netgroup @eng

Exports
Permissions on one path are consulted in priority order; the effective one is the access the client gets.
Path       Filesystem  Access  Effective  Via
/projects  default     RO      yes        ro-all
/projects  default     RW      no         compute
```

In this example, the `compute` client group admits the client through its IP rule, so the netgroup rule of `compute` is listed under **Also Matches**. Two client groups grant access to `/projects`. Permissions are processed in ascending priority order, and the read-only permission has the lower priority number, so the client gets read-only access.

If no client group admits the client, the command shows `No client group grants <target> access to any export.` and the **Member Entries** table.

If the command shows that too many lookups are running, run it again.

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
