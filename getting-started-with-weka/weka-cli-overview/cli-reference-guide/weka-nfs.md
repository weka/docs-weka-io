---
description: Manage the WEKA NFS service.
---

# weka nfs

Manage Weka's NFS service.

```sh
weka nfs
```

## weka nfs client-group

Manage NFS client groups.

```sh
weka nfs client-group [--name <nfs-client-group>]
```

| Parameter                    | Description                         |
| ---------------------------- | ----------------------------------- |
| `--name` \<nfs-client-group> | NFS client group name to filter by. |

**Columns:** `id`, `uid`, `name`, `rules`

### weka nfs client-group add

Create an NFS client group.

```sh
weka nfs client-group add <name>
```

| Parameter | Description                      |
| --------- | -------------------------------- |
| `name`\*  | Name of the NFS group to create. |

**Columns:** `id`, `uid`, `name`, `rules`

### weka nfs client-group remove

Remove an NFS client group.

```sh
weka nfs client-group remove <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the NFS group to delete.                                |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## weka nfs clients

NFS clients usage information.

```sh
weka nfs clients
```

### weka nfs clients show

NFS clients usage information. If no options are given, all NFS Ganesha containers will be selected.

```sh
weka nfs clients show [--container-id <container-id>] [--fip <ip>] [--fsnames <strings>…] [--interface-group <string>]
```

| Parameter                        | Description                                                                                                            |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `--container-id` \<container-id> | Specify container ID.                                                                                                  |
| `--fip` \<ip>                    | Specify floating IP.                                                                                                   |
| `--fsnames` \<strings>…          | Specify exported filesystem names. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--interface-group` \<string>    | Specify NFS interface group.                                                                                           |

**Columns:** `container`, `fsname`, `client_ip`, `idle_time`, `num_v3_ops`, `num_v4_ops`, `num_v4_open_ops`, `num_v4_close_ops`

## weka nfs custom-options

Manage NFS custom global, permission, and client config options.

```sh
weka nfs custom-options
```

**Columns:** `global_options`, `export_options`, `client_options`

### weka nfs custom-options update

Update custom options.

```sh
weka nfs custom-options update [--client-options <string>] [--export-options <string>] [--global-options <string>]
```

| Parameter                    | Description             |
| ---------------------------- | ----------------------- |
| `--client-options` \<string> | Set client NFS options. |
| `--export-options` \<string> | Set export NFS options. |
| `--global-options` \<string> | Set global NFS options. |

## weka nfs debug-level

Manage NFS debug level.

```sh
weka nfs debug-level
```

### weka nfs debug-level list

List NFS server supported components or levels for setting debug levels.

```sh
weka nfs debug-level list <what> [--full-list]
```

| Parameter     | Description                                       |
| ------------- | ------------------------------------------------- |
| `what`\*      | Specify the available debug components or levels. |
| `--full-list` | Show the full list of names or levels.            |

**Columns:** `name`

### weka nfs debug-level set

Set NFS debug level.

```sh
weka nfs debug-level set <level> [--full-list] [--nfs-components <strings>…] [--nfs-hosts <container-ids>…]
```

| Parameter                       | Description                                                                                                         |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `level`\*                       | One of the supported debug levels.                                                                                  |
| `--full-list`                   | Set log level for all components.                                                                                   |
| `--nfs-components` \<strings>…  | List of component names. Multiple values may be supplied separated by commas, or the option may be repeated.        |
| `--nfs-hosts` \<container-ids>… | Only apply to these containers. Multiple values may be supplied separated by commas, or the option may be repeated. |

### weka nfs debug-level show

Show NFS debug level settings information.

```sh
weka nfs debug-level show [--full-list] [--nfs-components <strings>…] [--nfs-hosts <container-ids>…]
```

| Parameter                       | Description                                                                                                            |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `--full-list`                   | Show the full list of components.                                                                                      |
| `--nfs-components` \<strings>…  | List of component names. Multiple values may be supplied separated by commas, or the option may be repeated.           |
| `--nfs-hosts` \<container-ids>… | Only return from these containers. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `container`, `debug_level`, `component`

## weka nfs global-config

Manage NFS global config parameters.

```sh
weka nfs global-config
```

### weka nfs global-config set

Set NFS global config parameters.

```sh
weka nfs global-config set [--acl <on-off>] [--config-fs <string>] [--default-acl-type <acl-type>] [--default-supported-versions <nfs-versions>…] [--direct-io <on-off>] [--enable-auth-types <nfs-auth-types>…] [--enable-multi-tenant <on-off>] [--extended-stats <on-off>] [--force] [--force-config-fs <on-off>] [--lockmgr-port <uint16>] [--max-client-connections <uint>] [--max-open-fds <uint>] [--mountd-port <uint16>] [--no-restart] [--notify-port <uint16>] [--statmon-port <uint16>]
```

| Parameter                                       | Description                                                                                                           |
| ----------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `--acl` \<on-off>                               | Enable or disable ACL.                                                                                                |
| `--config-fs` \<string>                         | Config filesystem name. Use empty string to invalidate.                                                               |
| `--default-acl-type` \<acl-type>                | Default ACL type.                                                                                                     |
| `--default-supported-versions` \<nfs-versions>… | NFS versions for new permissions. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--direct-io` \<on-off>                         | Disable readcache and writecache.                                                                                     |
| `--enable-auth-types` \<nfs-auth-types>…        | List of NFS authentication types. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--enable-multi-tenant` \<on-off>               | Enable or disable NFS multi-tenant support (default: Off).                                                            |
| `--extended-stats` \<on-off>                    | Enable or disable extended stats.                                                                                     |
| `--force`                                       | Force action; this may cause disruption.                                                                              |
| `--force-config-fs` \<on-off>                   | Force config-fs update when locks are on.                                                                             |
| `--lockmgr-port` \<uint16>                      | Port for NFS lock manager. Default 0 selects any available port.                                                      |
| `--max-client-connections` \<uint>              | Maximum number of concurrent NFS client connections. 0 means auto-tune based on cluster size.                         |
| `--max-open-fds` \<uint>                        | Maximum number of open file descriptors per NFS server process.                                                       |
| `--mountd-port` \<uint16>                       | Port number for mountd service.                                                                                       |
| `--no-restart`                                  | Prevent NFS-W containers from restarting when changes are applied.                                                    |
| `--notify-port` \<uint16>                       | Port for NFSv3 notification. Default 0 means any available port.                                                      |
| `--statmon-port` \<uint16>                      | Port for NFS status monitor. Default 0 means any available port.                                                      |

### weka nfs global-config show

Show NFS global configuration information.

```sh
weka nfs global-config show
```

**Columns:** `acl`, `config_fs`, `default_acl_type`, `default_auth_types`, `default_supported_versions`, `direct_io`, `enabled_auth_types`, `enable_multi_tenant`, `extended_stats`, `grace_period`, `lease_lifetime`, `lock_recovery_period`, `lockmgr_port`, `locks`, `max_client_connections`, `max_client_connections_effective`, `max_open_fds`, `mountd_port`, `notify_port`, `statmon_port`, `supported_auth_types`

## weka nfs interface-group

Manage NFS interface groups.

```sh
weka nfs interface-group [--name <string>]
```

| Parameter          | Description               |
| ------------------ | ------------------------- |
| `--name` \<string> | NFS interface group name. |

**Columns:** `uid`, `name`, `type`, `netmask`, `gateway`, `status`, `ips`, `ports`, `tenant_ids`, `allow_manage_gids`

### weka nfs interface-group add

Add an NFS interface group.

```sh
weka nfs interface-group add <name> [--gateway <ip>] [--netmask <uint8>]
```

| Parameter            | Description             |
| -------------------- | ----------------------- |
| `name`\*             | Interface group name.   |
| `--gateway` \<ip>    | Gateway IP address.     |
| `--netmask` \<uint8> | Netmask length in bits. |

**Columns:** `uid`, `name`, `netmask`, `gateway`, `status`, `ips`, `ports`, `allow_manage_gids`

### weka nfs interface-group assignment

List NFS interface group assignments.

```sh
weka nfs interface-group assignment [--name <string>]
```

| Parameter          | Description               |
| ------------------ | ------------------------- |
| `--name` \<string> | NFS interface group name. |

**Columns:** `ip`, `container`, `port`, `group`

### weka nfs interface-group ip-range

Manage NFS interface group IP ranges.

```sh
weka nfs interface-group ip-range
```

#### weka nfs interface-group ip-range add

Add an IP range to an interface group.

```sh
weka nfs interface-group ip-range add <name> <ips>
```

| Parameter | Description                      |
| --------- | -------------------------------- |
| `name`\*  | Name of the NFS interface group. |
| `ips`\*   | IP range to add.                 |

#### weka nfs interface-group ip-range remove

Remove an IP range from an interface group.

```sh
weka nfs interface-group ip-range remove <name> <ips> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the NFS interface group.                                |
| `ips`\*         | IP range to remove.                                             |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka nfs interface-group ns-assignment

List the currently assigned container for each namespace. Optionally filter by interface group name or tenant.

```sh
weka nfs interface-group ns-assignment [--name <string>] [--tenant <tenant>]
```

| Parameter            | Description                     |
| -------------------- | ------------------------------- |
| `--name` \<string>   | Filter by interface group name. |
| `--tenant` \<tenant> | Filter by tenant name.          |

**Columns:** `uid`, `netspace_id`, `tenant_id`, `container`, `hostname`, `vlan`, `fip_range`, `interface_group`

### weka nfs interface-group port

Manage NFS interface group ports.

```sh
weka nfs interface-group port
```

#### weka nfs interface-group port add

Add a port to an NFS interface group.

```sh
weka nfs interface-group port add <name> <container> <port>
```

| Parameter     | Description                             |
| ------------- | --------------------------------------- |
| `name`\*      | Name of the NFS interface group.        |
| `container`\* | Container ID on which the port resides. |
| `port`\*      | Port device name (e.g. eth1).           |

#### weka nfs interface-group port remove

Remove a port from an NFS interface group.

```sh
weka nfs interface-group port remove <name> <container> <port> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the NFS interface group.                                |
| `container`\*   | Container on which the port resides.                            |
| `port`\*        | Port device name (e.g. eth1).                                   |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka nfs interface-group remove

Delete an NFS interface group.

```sh
weka nfs interface-group remove <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the NFS interface group to delete.                      |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka nfs interface-group tenant

List tenants assigned to NFS interface groups.

```sh
weka nfs interface-group tenant [--name <string>]
```

| Parameter          | Description                     |
| ------------------ | ------------------------------- |
| `--name` \<string> | Filter by interface group name. |

**Columns:** `id`, `name`, `interface_group`

#### weka nfs interface-group tenant add

Assign a tenant to an NFS interface group. Fails if the tenant is already assigned to a different group; use "tenant move" to reassign.

```sh
weka nfs interface-group tenant add <name> <tenant>
```

| Parameter  | Description           |
| ---------- | --------------------- |
| `name`\*   | Interface group name. |
| `tenant`\* | Tenant name or ID.    |

#### weka nfs interface-group tenant delete

Remove a tenant from its assigned NFS interface group.

```sh
weka nfs interface-group tenant delete <name> <tenant>
```

| Parameter  | Description           |
| ---------- | --------------------- |
| `name`\*   | Interface group name. |
| `tenant`\* | Tenant name or ID.    |

#### weka nfs interface-group tenant move

Move a tenant from its current NFS interface group to a different one.

```sh
weka nfs interface-group tenant move <name> <tenant>
```

| Parameter  | Description               |
| ---------- | ------------------------- |
| `name`\*   | New interface group name. |
| `tenant`\* | Tenant name or ID.        |

### weka nfs interface-group update

Update an NFS interface group.

```sh
weka nfs interface-group update <name> [--gateway <ip>] [--netmask <uint8>]
```

| Parameter            | Description                          |
| -------------------- | ------------------------------------ |
| `name`\*             | Interface group name.                |
| `--gateway` \<ip>    | Gateway IP address (e.g. 192.0.2.0). |
| `--netmask` \<uint8> | Netmask length in bits.              |

## weka nfs kerberos

Manage NFS Kerberos configuration.

```sh
weka nfs kerberos
```

### weka nfs kerberos registration

Manage Kerberos registration.

```sh
weka nfs kerberos registration
```

#### weka nfs kerberos registration setup-ad

Configure Active Directory Kerberos.

```sh
weka nfs kerberos registration setup-ad <nfs-fqdn-service-name> <realm-admin-name> [<realm-admin-passwd>] [--base-ou <string>] [--force] [--restart]
```

| Parameter                 | Description                                         |
| ------------------------- | --------------------------------------------------- |
| `nfs-fqdn-service-name`\* | NFS FQDN service name.                              |
| `realm-admin-name`\*      | Realm admin user name.                              |
| `realm-admin-passwd`      | Realm admin password. If omitted, will be prompted. |
| `--base-ou` \<string>     | LDAP base OU to use (e.g. OU=Servers).              |
| `--force`                 | Perform this action without further confirmation.   |
| `--restart`               | Restart the NFS-W containers to apply changes.      |

#### weka nfs kerberos registration setup-mit

Configure MIT Kerberos.

```sh
weka nfs kerberos registration setup-mit <nfs-fqdn-service-name> <keytab-path> [--force] [--restart]
```

| Parameter                 | Description                                       |
| ------------------------- | ------------------------------------------------- |
| `nfs-fqdn-service-name`\* | NFS FQDN service name.                            |
| `keytab-path`\*           | Path to keytab file.                              |
| `--force`                 | Perform this action without further confirmation. |
| `--restart`               | Restart the NFS-W containers to apply changes.    |

#### weka nfs kerberos registration show

Show NFS Kerberos registration information.

```sh
weka nfs kerberos registration show
```

**Columns:** `kdc_type`, `nfs_service_name`, `registration_generation_id`, `registration_status`

### weka nfs kerberos reset

Wipe out NFS Kerberos configuration information.

```sh
weka nfs kerberos reset [--force] [--no-restart]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--no-restart`  | Don't restart the NFS-W containers to apply changes.            |

### weka nfs kerberos service

Manage Kerberos service configuration.

```sh
weka nfs kerberos service
```

#### weka nfs kerberos service setup

Configure Kerberos service.

```sh
weka nfs kerberos service setup <kdc-realm-name> <kdc-primary-server> <kdc-admin-server> [--force] [--kdc-secondary-server <string>] [--restart]
```

| Parameter                          | Description                                       |
| ---------------------------------- | ------------------------------------------------- |
| `kdc-realm-name`\*                 | KDC realm name.                                   |
| `kdc-primary-server`\*             | KDC primary server.                               |
| `kdc-admin-server`\*               | KDC admin server.                                 |
| `--force`                          | Perform this action without further confirmation. |
| `--kdc-secondary-server` \<string> | KDC secondary server.                             |
| `--restart`                        | Restart the NFS-W containers to apply changes.    |

#### weka nfs kerberos service show

Show NFS Kerberos configuration information.

```sh
weka nfs kerberos service show
```

**Columns:** `kdc_admin_server`, `kdc_primary_server`, `kdc_secondary_server`, `realm_name`, `service_generation_id`, `service_status`

## weka nfs ldap

Manage NFS LDAP and AD configuration.

```sh
weka nfs ldap
```

### weka nfs ldap export-openldap

Export OpenLDAP configuration.

```sh
weka nfs ldap export-openldap <server-name> <ldap-domain> <sssd-conf-file> <idmapd-conf-file>
```

| Parameter            | Description                        |
| -------------------- | ---------------------------------- |
| `server-name`\*      | OpenLDAP server name.              |
| `ldap-domain`\*      | OpenLDAP domain.                   |
| `sssd-conf-file`\*   | Path to sssd configuration file.   |
| `idmapd-conf-file`\* | Path to idmapd configuration file. |

### weka nfs ldap import-openldap

Import OpenLDAP configuration.

```sh
weka nfs ldap import-openldap <server-name> <ldap-domain> <sssd-conf-file> <idmapd-conf-file> [--force] [--no-restart] [--verify]
```

| Parameter            | Description                                          |
| -------------------- | ---------------------------------------------------- |
| `server-name`\*      | OpenLDAP server name.                                |
| `ldap-domain`\*      | OpenLDAP domain.                                     |
| `sssd-conf-file`\*   | Path to sssd configuration file.                     |
| `idmapd-conf-file`\* | Path to idmapd configuration file.                   |
| `--force`            | Perform this action without further confirmation.    |
| `--no-restart`       | Don't restart the NFS-W containers to apply changes. |
| `--verify`           | Verify connectivity with the OpenLDAP server.        |

### weka nfs ldap reset

Wipe out NFS LDAP configuration information.

```sh
weka nfs ldap reset [--force] [--no-restart]
```

| Parameter      | Description                                          |
| -------------- | ---------------------------------------------------- |
| `--force`      | Perform this action without further confirmation.    |
| `--no-restart` | Don't restart the NFS-W containers to apply changes. |

### weka nfs ldap setup-ad

Set up configuration for NFS to use Active Directory LDAP. Running this command without the no-restart option can disrupt IO service for connected NFS clients.

```sh
weka nfs ldap setup-ad [--force] [--no-restart]
```

| Parameter      | Description                                           |
| -------------- | ----------------------------------------------------- |
| `--force`      | Perform this action even when LDAP is already set up. |
| `--no-restart` | Don't restart the NFS-W containers to apply changes.  |

### weka nfs ldap setup-ad-nokrb

Set up configuration for NFS to use Active Directory LDAP for ACL only when Kerberos is not used. Running this command without the no-restart option can disrupt IO service for connected NFS clients.

```sh
weka nfs ldap setup-ad-nokrb <server-name> <ldap-domain> <nfs-service-name> <admin-user-name> [<admin-user-password>] [--base-ou <string>] [--force] [--no-restart]
```

| Parameter             | Description                                           |
| --------------------- | ----------------------------------------------------- |
| `server-name`\*       | AD server name.                                       |
| `ldap-domain`\*       | AD domain.                                            |
| `nfs-service-name`\*  | NFS FQDN service name.                                |
| `admin-user-name`\*   | AD admin name.                                        |
| `admin-user-password` | AD admin password.                                    |
| `--base-ou` \<string> | LDAP OU (default: CN=Computers).                      |
| `--force`             | Perform this action even when LDAP is already set up. |
| `--no-restart`        | Don't restart the NFS-W containers to apply changes.  |

### weka nfs ldap setup-onhostldap

Configure NFS to use on-host LDAP service.

```sh
weka nfs ldap setup-onhostldap <ldap-domain> [--force] [--no-restart]
```

| Parameter       | Description                                           |
| --------------- | ----------------------------------------------------- |
| `ldap-domain`\* | LDAP domain.                                          |
| `--force`       | Perform this action even when LDAP is already set up. |
| `--no-restart`  | Don't restart the NFS-W containers to apply changes.  |

### weka nfs ldap setup-openldap

Configure OpenLDAP.

```sh
weka nfs ldap setup-openldap <server-name> <ldap-domain> <reader-user-name> [<reader-user-password>] [--base-dn <string>] [--force] [--ldap-port-number <uint16>] [--no-restart]
```

| Parameter                      | Description                                           |
| ------------------------------ | ----------------------------------------------------- |
| `server-name`\*                | OpenLDAP server name.                                 |
| `ldap-domain`\*                | OpenLDAP domain.                                      |
| `reader-user-name`\*           | OpenLDAP reader user name.                            |
| `reader-user-password`         | OpenLDAP reader user password.                        |
| `--base-dn` \<string>          | LDAP Base DN (e.g. dc=myldapdom,dc=ex,dc=com).        |
| `--force`                      | Perform this action even when LDAP is already set up. |
| `--ldap-port-number` \<uint16> | OpenLDAP port number (default: 389).                  |
| `--no-restart`                 | Don't restart the NFS-W containers to apply changes.  |

### weka nfs ldap show

NFS LDAP configuration information.

```sh
weka nfs ldap show
```

**Columns:** `ldap_server_type`, `ldap_domain`, `ldap_server`, `ldap_port`, `ldap_base_dn`, `ldap_reader_user_name`, `ldap_reader_user_password`, `ldap_generation_id`, `ldap_status`

## weka nfs permission

Manage NFS permissions.

```sh
weka nfs permission [--filesystem <string>]
```

| Parameter                | Description      |
| ------------------------ | ---------------- |
| `--filesystem` \<string> | Filesystem name. |

**Columns:** `acl_type`, `anon_gid`, `anon_uid`, `enabled_auth_types`, `filesystem`, `group`, `manage_gids`, `obs_direct`, `path`, `permission_type`, `privileged_port`, `squash_mode`, `supported_versions`

### weka nfs permission add

Allow a client group to access a file system.

```sh
weka nfs permission add <filesystem> <group> [--acl-type <acl-type>] [--anon-gid <uint32>] [--anon-uid <uint32>] [--enable-auth-types <nfs-auth-types>…] [--force] [--force-acl-type <on-off>] [--manage-gids <on-off>] [--no-restart] [--obs-direct <on-off>] [--path <string>] [--permission-type <permission-type>] [--privileged-port <on-off>] [--squash <squash-mode>] [--supported-versions <nfs-versions>…]
```

| Parameter                                | Description                                                                                                                                                                                        |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `filesystem`\*                           | Filesystem name.                                                                                                                                                                                   |
| `group`\*                                | Client group name.                                                                                                                                                                                 |
| `--acl-type` \<acl-type>                 | Type of ACL. Default is determined by the NFS global configuration.                                                                                                                                |
| `--anon-gid` \<uint32>                   | GID to be used instead of root when root squashing is enabled.                                                                                                                                     |
| `--anon-uid` \<uint32>                   | UID to be used instead of root when root squashing is enabled.                                                                                                                                     |
| `--enable-auth-types` \<nfs-auth-types>… | NFS authentication types. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                      |
| `--force`                                | Perform this action when the service is already configured.                                                                                                                                        |
| `--force-acl-type` \<on-off>             | Force a change to the ACL type for existing permissions on the same filesystem.                                                                                                                    |
| `--manage-gids` \<on-off>                | List of group IDs received from the client will be replaced by a list of group IDs determined by an appropriate lookup on the server. Only works with an interface group which allows manage-gids. |
| `--no-restart`                           | Don't restart the NFS-W containers to apply changes.                                                                                                                                               |
| `--obs-direct` \<on-off>                 | OBS direct.                                                                                                                                                                                        |
| `--path` \<string>                       | Filesystem path. Default is '/'.                                                                                                                                                                   |
| `--permission-type` \<permission-type>   | Permission type.                                                                                                                                                                                   |
| `--privileged-port` \<on-off>            | Privileged port.                                                                                                                                                                                   |
| `--squash` \<squash-mode>                | Permission squashing. The option 'all' can be used only on interface groups with --allow-manage-gids=on.                                                                                           |
| `--supported-versions` \<nfs-versions>…  | NFS versions for new permissions. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                              |

**Columns:** `export_id`, `container_restart_needed`

### weka nfs permission remove

Delete filesystem permission.

```sh
weka nfs permission remove <filesystem> <group> [--force] [--path <string>]
```

| Parameter          | Description                                                     |
| ------------------ | --------------------------------------------------------------- |
| `filesystem`\*     | Filesystem name.                                                |
| `group`\*          | Client group name.                                              |
| `-f`, `--force`    | Force action. Perform this action without further confirmation. |
| `--path` \<string> | Filesystem path. Default is '/'.                                |

### weka nfs permission update

Edit a file system permission.

```sh
weka nfs permission update <filesystem> <group> [--acl-type <acl-type>] [--anon-gid <uint32>] [--anon-uid <uint32>] [--enable-auth-types <nfs-auth-types>…] [--force] [--force-acl-type <on-off>] [--manage-gids <on-off>] [--no-restart] [--obs-direct <on-off>] [--path <string>] [--permission-type <permission-type>] [--privileged-port <on-off>] [--squash <squash-mode>] [--supported-versions <nfs-versions>…]
```

| Parameter                                | Description                                                                                                                                                                                        |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `filesystem`\*                           | Filesystem name.                                                                                                                                                                                   |
| `group`\*                                | Client group name.                                                                                                                                                                                 |
| `--acl-type` \<acl-type>                 | ACL type. Default is determined by the NFS global configuration.                                                                                                                                   |
| `--anon-gid` \<uint32>                   | GID to be used instead of root when root squashing is enabled.                                                                                                                                     |
| `--anon-uid` \<uint32>                   | UID to be used instead of root when root squashing is enabled.                                                                                                                                     |
| `--enable-auth-types` \<nfs-auth-types>… | NFS authentication types. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                      |
| `--force`                                | Perform this action when the service is already configured.                                                                                                                                        |
| `--force-acl-type` \<on-off>             | Force a change to the ACL type for existing permissions on the same filesystem.                                                                                                                    |
| `--manage-gids` \<on-off>                | List of group IDs received from the client will be replaced by a list of group IDs determined by an appropriate lookup on the server. Only works with an interface group which allows manage-gids. |
| `--no-restart`                           | Don't restart the NFS-W containers to apply changes.                                                                                                                                               |
| `--obs-direct` \<on-off>                 | OBS direct.                                                                                                                                                                                        |
| `--path` \<string>                       | Filesystem path. Default is '/'.                                                                                                                                                                   |
| `--permission-type` \<permission-type>   | Permission type.                                                                                                                                                                                   |
| `--privileged-port` \<on-off>            | Privileged port.                                                                                                                                                                                   |
| `--squash` \<squash-mode>                | Permission squashing. The option 'all' can be used only on interface groups with --allow-manage-gids=on.                                                                                           |
| `--supported-versions` \<nfs-versions>…  | NFS versions for new permissions. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                              |

## weka nfs rules

Manage NFS rules, or list with no arguments.

```sh
weka nfs rules
```

### weka nfs rules add

Add an NFS rule.

```sh
weka nfs rules add
```

#### weka nfs rules add dns

Add an NFS rule with a DNS wildcard.

```sh
weka nfs rules add dns <name> <dns>
```

| Parameter | Description                                        |
| --------- | -------------------------------------------------- |
| `name`\*  | Name of the NFS group in which to create the rule. |
| `dns`\*   | DNS rule with \*?\[] wildcards.                    |

**Columns:** `id`, `uid`, `type`, `rule`

#### weka nfs rules add ip

Add an IP rule to an NFS client group.

```sh
weka nfs rules add ip <name> <ip>
```

| Parameter | Description                                                                    |
| --------- | ------------------------------------------------------------------------------ |
| `name`\*  | Name of the NFS group in which to create the rule.                             |
| `ip`\*    | IP with netmask or CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format. |

**Columns:** `id`, `uid`, `type`, `rule`

### weka nfs rules remove

Remove NFS rules.

```sh
weka nfs rules remove
```

#### weka nfs rules remove dns

Remove a DNS rule from an NFS client group.

```sh
weka nfs rules remove dns <name> <dns>
```

| Parameter | Description                                          |
| --------- | ---------------------------------------------------- |
| `name`\*  | Name of the NFS group from which to delete the rule. |
| `dns`\*   | DNS rule with \*?\[] wildcards.                      |

#### weka nfs rules remove ip

Remove an IP rule from an NFS client group.

```sh
weka nfs rules remove ip <name> <ip>
```

| Parameter | Description                                                                    |
| --------- | ------------------------------------------------------------------------------ |
| `name`\*  | Name of the NFS group from which to delete the rule.                           |
| `ip`\*    | IP with netmask or CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format. |
