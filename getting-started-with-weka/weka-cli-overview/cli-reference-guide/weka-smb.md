# weka smb

Manage SMB file sharing protocol service.

```sh
weka smb
```

## weka smb cluster

View info about the managed SMB cluster.

```sh
weka smb cluster
```

**Columns:** `status`, `name`, `smb_ips`, `smb_containers`, `idmap_backend`, `joined_idmap_range`, `default_idmap_range`, `encryption`, `config_fs_name`, `type`, `domain_joined`, `domain_name`, `domain_admin_username`, `sssd_health`, `sssd_last_error`, `scale_out`, `userdb_trusted_domains`

### weka smb cluster containers

Add or remove containers from the SMB cluster.

```sh
weka smb cluster containers
```

#### weka smb cluster containers add

Add containers to the SMB cluster.

```sh
weka smb cluster containers add --container-ids <container-ids>… [--force]
```

| Parameter                             | Description                                                                                                |
| ------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--container-ids` \<container-ids>\*… | SMB containers to add. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-f`, `--force`                       | Force action. Perform this action without further confirmation.                                            |

#### weka smb cluster containers remove

Remove containers from the SMB cluster.

```sh
weka smb cluster containers remove --container-ids <container-ids>… [--force]
```

| Parameter                             | Description                                                                                                   |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `--container-ids` \<container-ids>\*… | SMB containers to remove. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-f`, `--force`                       | Force action. Perform this action without further confirmation.                                               |

### weka smb cluster create

Create an SMB cluster.

```sh
weka smb cluster create <netbios-name> <domain> <config-fs-name> --container-ids <container-ids>… [--default-domain-mapping-from-id <uint32>] [--default-domain-mapping-to-id <uint32>] [--domain-netbios-name <string>] [--encryption <smb-cluster-encryption>] [--idmap-backend <smb-idmap-backend>] [--joined-domain-mapping-from-id <uint32>] [--joined-domain-mapping-to-id <uint32>] [--ldap-bind-dn <string>] [--ldap-bind-password <string>] [--ldap-domain <string>] [--ldap-schema <smb-ldap-schema>] [--ldap-search-base <string>] [--ldap-uri <string>] [--posix-resolution-mode <smb-posix-resolution-mode>] [--prompt-ldap-bind-password] [--scale-out-mode <smb-scale-out-mode>] [--smb-conf-extra <string>] [--smb-ips-pool <ips>…] [--smb-ips-range <ip-ranges>…] [--symlink] [--userdb-trusted-domains]
```

| Parameter                                              | Description                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `netbios-name`\*                                       | NetBIOS name for the SMB cluster.                                                                                                                                                                                                                                                                                                                                                                                                |
| `domain`\*                                             | Domain name for the SMB cluster.                                                                                                                                                                                                                                                                                                                                                                                                 |
| `config-fs-name`\*                                     | Filesystem name for SMB configuration storage.                                                                                                                                                                                                                                                                                                                                                                                   |
| `--container-ids` \<container-ids>\*…                  | Containers that will serve SMB protocol. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                                                                                                                     |
| `--default-domain-mapping-from-id` \<uint32>           | Default domain ID mapping range start.                                                                                                                                                                                                                                                                                                                                                                                           |
| `--default-domain-mapping-to-id` \<uint32>             | Default domain ID mapping range end.                                                                                                                                                                                                                                                                                                                                                                                             |
| `--domain-netbios-name` \<string>                      | Domain NetBIOS name.                                                                                                                                                                                                                                                                                                                                                                                                             |
| `--encryption` \<smb-cluster-encryption>               | Cluster encryption mode. Valid values: enabled, disabled, desired, required.                                                                                                                                                                                                                                                                                                                                                     |
| `--idmap-backend` \<smb-idmap-backend>                 | ID mapping backend type. Valid values: rid, rfc2307.                                                                                                                                                                                                                                                                                                                                                                             |
| `--joined-domain-mapping-from-id` \<uint32>            | Joined domain ID mapping range start.                                                                                                                                                                                                                                                                                                                                                                                            |
| `--joined-domain-mapping-to-id` \<uint32>              | Joined domain ID mapping range end.                                                                                                                                                                                                                                                                                                                                                                                              |
| `--ldap-bind-dn` \<string>                             | LDAP bind DN used by SSSD.                                                                                                                                                                                                                                                                                                                                                                                                       |
| `--ldap-bind-password` \<string>                       | LDAP bind password used by SSSD.                                                                                                                                                                                                                                                                                                                                                                                                 |
| `--ldap-domain` \<string>                              | LDAP domain used by SSSD.                                                                                                                                                                                                                                                                                                                                                                                                        |
| `--ldap-schema` \<smb-ldap-schema>                     | LDAP schema type used by SSSD for POSIX attribute resolution. Valid values: rfc2307, rfc2307bis, ad, ipa.                                                                                                                                                                                                                                                                                                                        |
| `--ldap-search-base` \<string>                         | LDAP search base used by SSSD.                                                                                                                                                                                                                                                                                                                                                                                                   |
| `--ldap-uri` \<string>                                 | LDAP server URI used by SSSD.                                                                                                                                                                                                                                                                                                                                                                                                    |
| `--posix-resolution-mode` \<smb-posix-resolution-mode> | POSIX UID/GID resolution mode for SMB-W: 'ad' or 'nss'. 'nss' needs at least one LDAP domain: supply --ldap-domain, or omit it to reuse the LDAP domains that survived a previous cluster destroy. Valid values: ad, nss.                                                                                                                                                                                                        |
| `--prompt-ldap-bind-password`                          | Prompt interactively for the LDAP bind password instead of passing it on the command line.                                                                                                                                                                                                                                                                                                                                       |
| `--scale-out-mode` \<smb-scale-out-mode>               | Scale-out mode. Valid values: none, full, partial.                                                                                                                                                                                                                                                                                                                                                                               |
| `--smb-conf-extra` \<string>                           | Additional smb.conf configuration.                                                                                                                                                                                                                                                                                                                                                                                               |
| `--smb-ips-pool` \<ips>…                               | SMB floating IP addresses. The pool and --smb-ips-range together hold one to three addresses per container. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                                                  |
| `--smb-ips-range` \<ip-ranges>…                        | SMB floating IP address ranges, each written as a CIDR subnet, a first-last pair, or a first address with the last octets of the final one (10.0.0.0/29, 10.0.0.1-10.0.0.9, 10.0.0.1-9). A /30 or wider CIDR excludes its network and broadcast addresses. The ranges and --smb-ips-pool together hold one to three addresses per container. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--symlink`                                            | Enable symlink support.                                                                                                                                                                                                                                                                                                                                                                                                          |
| `--userdb-trusted-domains`                             | Enumerate the trusted domains and their domain controllers when the SMB server starts (enabled by default). Set to false in large Active Directory environments where the enumeration times out and the SMB server keeps restarting. While it is off, users from trusted domains cannot be resolved and lose access.                                                                                                             |

### weka smb cluster debug

Set the SMB debug log level.

```sh
weka smb cluster debug <level> [--container-ids <container-ids>…]
```

| Parameter                           | Description                                                                                                           |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `level`\*                           | Debug log level.                                                                                                      |
| `--container-ids` \<container-ids>… | Containers to set debug level on. Multiple values may be supplied separated by commas, or the option may be repeated. |

### weka smb cluster destroy

Destroy the SMB cluster.

```sh
weka smb cluster destroy [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka smb cluster status

Display readiness status of SMB containers.

```sh
weka smb cluster status
```

**Columns:** `container`, `ready`

### weka smb cluster trusted-domains

List all trusted domains for the SMB cluster.

```sh
weka smb cluster trusted-domains
```

**Columns:** `id`, `domain_name`, `idmap_backend`, `mapping_from_id`, `mapping_to_id`

#### weka smb cluster trusted-domains add

Add a trusted domain to the SMB cluster.

```sh
weka smb cluster trusted-domains add <domain-name> <from-id> <to-id> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `domain-name`\* | Trusted domain name.                                            |
| `from-id`\*     | ID mapping range start.                                         |
| `to-id`\*       | ID mapping range end.                                           |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

#### weka smb cluster trusted-domains remove

Remove a trusted domain from the SMB cluster.

```sh
weka smb cluster trusted-domains remove <trusteddomain-id> [--force]
```

| Parameter            | Description                                                     |
| -------------------- | --------------------------------------------------------------- |
| `trusteddomain-id`\* | Trusted domain ID to remove.                                    |
| `-f`, `--force`      | Force action. Perform this action without further confirmation. |

### weka smb cluster update

Update the SMB cluster configuration.

```sh
weka smb cluster update [--encryption <smb-cluster-encryption>] [--force] [--idmap-backend <smb-idmap-backend>] [--posix-resolution-mode <smb-posix-resolution-mode>] [--smb-ips-pool <ips>…] [--smb-ips-range <ip-ranges>…] [--userdb-trusted-domains]
```

| Parameter                                              | Description                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--encryption` \<smb-cluster-encryption>               | Cluster encryption mode. Valid values: enabled, disabled, desired, required.                                                                                                                                                                                                                                                                                                                                                     |
| `-f`, `--force`                                        | Force action. Perform this action without further confirmation.                                                                                                                                                                                                                                                                                                                                                                  |
| `--idmap-backend` \<smb-idmap-backend>                 | ID mapping backend type. Required when switching --posix-resolution-mode to 'ad'; mutually exclusive with --posix-resolution-mode nss. Valid values: rid, rfc2307.                                                                                                                                                                                                                                                               |
| `--posix-resolution-mode` \<smb-posix-resolution-mode> | Change POSIX UID/GID resolution mode: 'ad' (resolve via the joined Active Directory) or 'nss' (resolve via NSS/SSSD against external LDAP; requires at least one LDAP domain already configured). Flipping the mode bounces the SMB cluster. Valid values: ad, nss.                                                                                                                                                              |
| `--smb-ips-pool` \<ips>…                               | SMB floating IP addresses. The pool and --smb-ips-range together hold one to three addresses per container. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                                                  |
| `--smb-ips-range` \<ip-ranges>…                        | SMB floating IP address ranges, each written as a CIDR subnet, a first-last pair, or a first address with the last octets of the final one (10.0.0.0/29, 10.0.0.1-10.0.0.9, 10.0.0.1-9). A /30 or wider CIDR excludes its network and broadcast addresses. The ranges and --smb-ips-pool together hold one to three addresses per container. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--userdb-trusted-domains`                             | Enumerate the trusted domains and their domain controllers when the SMB server starts (enabled by default). Set to false in large Active Directory environments where the enumeration times out and the SMB server keeps restarting. While it is off, users from trusted domains cannot be resolved and lose access.                                                                                                             |

### weka smb cluster wait

Wait for the SMB cluster to become ready.

```sh
weka smb cluster wait [--timeout <duration>]
```

| Parameter                     | Description                                     |
| ----------------------------- | ----------------------------------------------- |
| `-t`, `--timeout` \<duration> | Maximum time to wait for SMB cluster readiness. |

## weka smb domain

View info about the Active Directory domain.

```sh
weka smb domain
```

**Columns:** `domain_name`, `domain_joined`, `domain_admin_username`, `domain_netbios_name`, `server`, `computer_ou`

### weka smb domain join

Join the cluster to an Active Directory domain.

```sh
weka smb domain join <username> [<password>] [--create-computer <string>] [--debug] [--extra-options <string>] [--server <string>] [--timeout <duration>]
```

| Parameter                     | Description                                              |
| ----------------------------- | -------------------------------------------------------- |
| `username`\*                  | Domain admin username.                                   |
| `password`                    | Domain admin password. If omitted, you will be prompted. |
| `--create-computer` \<string> | Organizational unit for the computer account.            |
| `--debug`                     | Enable debug output.                                     |
| `--extra-options` \<string>   | Extra options for the domain join.                       |
| `--server` \<string>          | Domain controller server address.                        |
| `-t`, `--timeout` \<duration> | Timeout for the domain join operation.                   |

### weka smb domain leave

Leave the Active Directory domain.

```sh
weka smb domain leave <username> [<password>] [--debug] [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `username`\*    | Domain admin username.                                          |
| `password`      | Domain admin password. If omitted, you will be prompted.        |
| `--debug`       | Enable debug output.                                            |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## weka smb ldap-domain

Manage SSSD/external-LDAP domains used for POSIX UID/GID resolution.

```sh
weka smb ldap-domain
```

### weka smb ldap-domain add

Add an SSSD/external-LDAP domain for POSIX UID/GID resolution.

```sh
weka smb ldap-domain add <domain> [<ldap-bind-password>] [--ca-cert <string>] [--case-sensitive] [--ldap-bind-dn <string>] [--ldap-schema <smb-ldap-schema>] [--ldap-search-base <string>] [--ldap-uri <string>] [--start-tls] [--validate-before-commit]
```

| Parameter                          | Description                                                                                               |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `domain`\*                         | SSSD domain label (must be unique).                                                                       |
| `ldap-bind-password`               | LDAP bind password. If omitted, you will be prompted.                                                     |
| `--ca-cert` \<string>              | Path to a CA certificate PEM file used to verify the LDAP server's TLS certificate.                       |
| `--case-sensitive`                 | Enable case-sensitive POSIX name lookups in SSSD.                                                         |
| `--ldap-bind-dn` \<string>         | Bind DN used to authenticate to the LDAP server.                                                          |
| `--ldap-schema` \<smb-ldap-schema> | LDAP schema type used by SSSD for POSIX attribute resolution. Valid values: rfc2307, rfc2307bis, ad, ipa. |
| `--ldap-search-base` \<string>     | LDAP search base.                                                                                         |
| `--ldap-uri` \<string>             | LDAP server URI.                                                                                          |
| `--start-tls`                      | Use StartTLS to secure the LDAP connection.                                                               |
| `--validate-before-commit`         | Probe the LDAP server (bind + POSIX attributes) before committing; abort if the probe fails.              |

### weka smb ldap-domain remove

Remove an SSSD/external-LDAP domain.

```sh
weka smb ldap-domain remove [<domain>] [--all] [--force]
```

| Parameter       | Description                                                                                                                            |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `domain`        | SSSD domain label to remove.                                                                                                           |
| `--all`         | Remove every configured LDAP domain. Rejected while the SMB cluster's POSIX resolution mode is 'nss', which needs at least one domain. |
| `-f`, `--force` | Force action. Perform this action without further confirmation.                                                                        |

### weka smb ldap-domain rotate-password

Rotate the SSSD/external-LDAP bind password for a domain. Prompts when the new password is omitted.

```sh
weka smb ldap-domain rotate-password <domain> [<new-password>]
```

| Parameter      | Description                                               |
| -------------- | --------------------------------------------------------- |
| `domain`\*     | SSSD domain label whose bind password to rotate.          |
| `new-password` | New LDAP bind password. If omitted, you will be prompted. |

### weka smb ldap-domain show

List the SSSD/external-LDAP domains used for POSIX UID/GID resolution, or show one when a domain label is given.

```sh
weka smb ldap-domain show [<domain>]
```

| Parameter | Description                                   |
| --------- | --------------------------------------------- |
| `domain`  | SSSD domain label to show (omit to list all). |

**Columns:** `domain`, `ldap_uri`, `search_base`, `bind_dn`, `has_bind_password`, `schema`, `case_sensitive`, `status`

### weka smb ldap-domain test

Test an SSSD/external-LDAP domain's connectivity (bind) and POSIX attributes without changing any configuration.

```sh
weka smb ldap-domain test <domain>
```

| Parameter  | Description                |
| ---------- | -------------------------- |
| `domain`\* | SSSD domain label to test. |

### weka smb ldap-domain update

Update fields of an existing SSSD/external-LDAP domain; only the provided fields change.

```sh
weka smb ldap-domain update <domain> [--ca-cert <string>] [--case-sensitive] [--ldap-bind-dn <string>] [--ldap-bind-password <string>] [--ldap-schema <smb-ldap-schema>] [--ldap-search-base <string>] [--ldap-uri <string>] [--start-tls] [--validate-before-commit]
```

| Parameter                          | Description                                                                                               |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `domain`\*                         | SSSD domain label to update.                                                                              |
| `--ca-cert` \<string>              | Path to a CA certificate PEM file used to verify the LDAP server's TLS certificate.                       |
| `--case-sensitive`                 | Enable case-sensitive POSIX name lookups in SSSD.                                                         |
| `--ldap-bind-dn` \<string>         | Bind DN used to authenticate to the LDAP server.                                                          |
| `--ldap-bind-password` \<string>   | New LDAP bind password.                                                                                   |
| `--ldap-schema` \<smb-ldap-schema> | LDAP schema type used by SSSD for POSIX attribute resolution. Valid values: rfc2307, rfc2307bis, ad, ipa. |
| `--ldap-search-base` \<string>     | LDAP search base.                                                                                         |
| `--ldap-uri` \<string>             | LDAP server URI.                                                                                          |
| `--start-tls`                      | Use StartTLS to secure the LDAP connection.                                                               |
| `--validate-before-commit`         | Probe the LDAP server (bind + POSIX attributes) before committing; abort if the probe fails.              |

## weka smb share

List and manage SMB shares.

```sh
weka smb share
```

**Columns:** `id`, `share_name`, `fs_name`, `description`, `inner_path`, `file_create_mask`, `directory_create_mask`, `acl`, `mount_options`, `additional_share_options`, `obs_direct`, `case_sensitivity`, `encryption`, `valid_users`, `invalid_users`, `read_only_users`, `read_write_users`, `read_only`, `allow_guest_access`, `hidden`, `vfs_zerocopy_read`, `named_streams`

### weka smb share add

Add an SMB share.

```sh
weka smb share add <share-name> <fs-name> [--acl] [--allow-guest-access] [--case-sensitivity] [--description <string>] [--directory-create-mask <string>] [--enable-ADS] [--encryption <smb-share-encryption>] [--file-create-mask <string>] [--force] [--hidden] [--internal-path <string>] [--map-acls <smb-map-acls>] [--obs-direct] [--read-only] [--user-list-type <smb-user-list-type>] [--users <strings>…] [--vfs-zerocopy-read]
```

| Parameter                                | Description                                                                                     |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `share-name`\*                           | Share name.                                                                                     |
| `fs-name`\*                              | Filesystem name.                                                                                |
| `--acl`                                  | Enable ACLs.                                                                                    |
| `--allow-guest-access`                   | Allow guest access.                                                                             |
| `--case-sensitivity`                     | Case sensitivity.                                                                               |
| `--description` \<string>                | Share description.                                                                              |
| `--directory-create-mask` \<string>      | Directory create mask.                                                                          |
| `--enable-ADS`                           | Enable named streams (ADS).                                                                     |
| `--encryption` \<smb-share-encryption>   | Encryption mode. Valid values: cluster\_default, desired, required.                             |
| `--file-create-mask` \<string>           | File create mask.                                                                               |
| `-f`, `--force`                          | Force action. Perform this action without further confirmation.                                 |
| `--hidden`                               | Hidden share.                                                                                   |
| `--internal-path` \<string>              | Internal path within the filesystem.                                                            |
| `--map-acls` \<smb-map-acls>             | Map ACLs mode. Valid values: posix, windows, hybrid, none.                                      |
| `--obs-direct`                           | OBS direct.                                                                                     |
| `--read-only`                            | Read only share.                                                                                |
| `--user-list-type` \<smb-user-list-type> | User list type. Valid values: read\_only, read\_write, valid, invalid.                          |
| `--users` \<strings>…                    | Users list. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--vfs-zerocopy-read`                    | VFS zerocopy read.                                                                              |

### weka smb share host-access

Manage host access rules for SMB shares.

```sh
weka smb share host-access
```

#### weka smb share host-access add

Add a host access rule to an SMB share.

```sh
weka smb share host-access add <share-id> <mode> [--ips <strings>…]
```

| Parameter           | Description                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------------- |
| `share-id`\*        | Share ID.                                                                                         |
| `mode`\*            | Access mode (allow/deny). Valid values: allow, deny.                                              |
| `--ips` \<strings>… | IP addresses. Multiple values may be supplied separated by commas, or the option may be repeated. |

#### weka smb share host-access list

List host access rules for SMB shares.

```sh
weka smb share host-access list
```

**Columns:** `uid`, `share_id`, `share_name`, `mode`, `hostname`

#### weka smb share host-access remove

Remove host access rules from an SMB share.

```sh
weka smb share host-access remove <share-id> <hosts>…
```

| Parameter    | Description      |
| ------------ | ---------------- |
| `share-id`\* | Share ID.        |
| `hosts`\*…   | Hosts to remove. |

#### weka smb share host-access reset

Reset host access rules for an SMB share.

```sh
weka smb share host-access reset <share-id> <mode> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `share-id`\*    | Share ID.                                                       |
| `mode`\*        | Access mode (allow/deny). Valid values: allow, deny.            |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka smb share lists

Manage user lists for SMB shares.

```sh
weka smb share lists
```

#### weka smb share lists add

Add users to a share's user list.

```sh
weka smb share lists add <share-id> <user-list-type> [--users <strings>…]
```

| Parameter             | Description                                                                                                      |
| --------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `share-id`\*          | Share ID.                                                                                                        |
| `user-list-type`\*    | User list type (read\_only, read\_write, valid, invalid). Valid values: read\_only, read\_write, valid, invalid. |
| `--users` \<strings>… | Users to add. Multiple values may be supplied separated by commas, or the option may be repeated.                |

#### weka smb share lists remove

Remove users from a share's user list.

```sh
weka smb share lists remove <share-id> <user-list-type> [--users <strings>…]
```

| Parameter             | Description                                                                                                      |
| --------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `share-id`\*          | Share ID.                                                                                                        |
| `user-list-type`\*    | User list type (read\_only, read\_write, valid, invalid). Valid values: read\_only, read\_write, valid, invalid. |
| `--users` \<strings>… | Users to remove. Multiple values may be supplied separated by commas, or the option may be repeated.             |

#### weka smb share lists reset

Reset a share's user list.

```sh
weka smb share lists reset <share-id> <user-list-type>
```

| Parameter          | Description                                                                                                      |
| ------------------ | ---------------------------------------------------------------------------------------------------------------- |
| `share-id`\*       | Share ID.                                                                                                        |
| `user-list-type`\* | User list type (read\_only, read\_write, valid, invalid). Valid values: read\_only, read\_write, valid, invalid. |

#### weka smb share lists show

Show user lists for SMB shares.

```sh
weka smb share lists show
```

**Columns:** `uid`, `id`, `share_name`, `read_only`, `valid_users`, `invalid_users`, `read_only_users`, `read_write_users`

### weka smb share remove

Remove an SMB share.

```sh
weka smb share remove <share-id> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `share-id`\*    | Share ID.                                                       |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka smb share update

Update an SMB share.

```sh
weka smb share update <share-id> [--allow-guest-access] [--encryption <smb-share-encryption>] [--hidden] [--read-only]
```

| Parameter                              | Description                                                         |
| -------------------------------------- | ------------------------------------------------------------------- |
| `share-id`\*                           | Share ID.                                                           |
| `--allow-guest-access`                 | Allow guest access.                                                 |
| `--encryption` \<smb-share-encryption> | Encryption mode. Valid values: cluster\_default, desired, required. |
| `--hidden`                             | Hidden share.                                                       |
| `--read-only`                          | Read only share.                                                    |
