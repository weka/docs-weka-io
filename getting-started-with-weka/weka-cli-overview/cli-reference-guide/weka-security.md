# weka security

Security-related commands.

```sh
weka security
```

## weka security ca-cert

Manage trusted CA certificate for cluster.

```sh
weka security ca-cert
```

### weka security ca-cert download

Download the WEKA cluster custom certificate.

```sh
weka security ca-cert download <path>
```

| Parameter | Description                              |
| --------- | ---------------------------------------- |
| `path`\*  | Path to save the downloaded certificate. |

### weka security ca-cert reset

Unset custom CA signed certificate from cluster.

```sh
weka security ca-cert reset
```

### weka security ca-cert set

Add a custom certificate to the certificates list. If a custom certificate is already set, this command updates it.

```sh
weka security ca-cert set --cert-file <string>
```

| Parameter                 | Description               |
| ------------------------- | ------------------------- |
| `--cert-file` \<string>\* | Path to certificate file. |

### weka security ca-cert status

Show the WEKA cluster CA certificate status and certificate.

```sh
weka security ca-cert status
```

## weka security cors-trusted-sites

Manage the sites trusted for cross origin resource sharing.

```sh
weka security cors-trusted-sites
```

### weka security cors-trusted-sites add

Add a site to the set of sites trusted for cross origin resource sharing.

```sh
weka security cors-trusted-sites add <site>
```

| Parameter | Description                                      |
| --------- | ------------------------------------------------ |
| `site`\*  | Site to trust for cross origin resource sharing. |

### weka security cors-trusted-sites list

List the set of sites trusted for cross origin resource sharing.

```sh
weka security cors-trusted-sites list
```

**Columns:** `_`

### weka security cors-trusted-sites remove

Remove a site from the set of sites trusted for cross origin resource sharing.

```sh
weka security cors-trusted-sites remove <site>
```

| Parameter | Description                           |
| --------- | ------------------------------------- |
| `site`\*  | Site to remove from the trusted list. |

### weka security cors-trusted-sites reset

Reset the set of sites trusted for cross origin resource sharing.

```sh
weka security cors-trusted-sites reset
```

## weka security gui-idle-timeout

Manage GUI session idle timeout settings.

```sh
weka security gui-idle-timeout
```

### weka security gui-idle-timeout reset

Reset the GUI session idle timeout to default values.

```sh
weka security gui-idle-timeout reset
```

### weka security gui-idle-timeout set

Set the GUI session idle timeout.

```sh
weka security gui-idle-timeout set <duration>
```

| Parameter    | Description                        |
| ------------ | ---------------------------------- |
| `duration`\* | Idle time before automatic logout. |

### weka security gui-idle-timeout show

Show the GUI session idle timeout.

```sh
weka security gui-idle-timeout show
```

## weka security kms

Show the currently configured key management service settings.

```sh
weka security kms
```

### weka security kms reset

Reset external KMS configurations. Fails if any encrypted filesystems rely on the KMS unless --force or --allow-downgrade is specified.

```sh
weka security kms reset [--allow-downgrade] [--force]
```

| Parameter           | Description                                                                                         |
| ------------------- | --------------------------------------------------------------------------------------------------- |
| `--allow-downgrade` | Allow downgrading encrypted filesystems to local encryption instead of a KMS.                       |
| `-f`, `--force`     | For tenant KMS deletion, switch filesystems to the cluster-wide KMS. Requires cluster KMS to exist. |

### weka security kms rewrap

Rewrap all master filesystem keys using the configured KMS. Use this to rewrap with a rotated KMS key, or to change wrapping to the newly-configured KMS.

```sh
weka security kms rewrap [--all] [--convert-to-cluster-key-on-fs] [--force] [--new-key-uid <string>]
```

| Parameter                        | Description                                                                |
| -------------------------------- | -------------------------------------------------------------------------- |
| `--all`                          | Rewrap all filesystem keys.                                                |
| `--convert-to-cluster-key-on-fs` | Convert all encrypted filesystems to use the cluster key.                  |
| `-f`, `--force`                  | Force action. Perform this action without further confirmation.            |
| `--new-key-uid` \<string>        | Unique identifier for the new key to wrap filesystem keys with. KMIP only. |

### weka security kms scope

Print the effective KMS type and scope (Cluster or Tenant) for the specified tenant (defaults to the current user's tenant).

```sh
weka security kms scope
```

### weka security kms set

Configure the active key management service.

```sh
weka security kms set
```

#### weka security kms set kmip

Configure the active key management service to use an external KMIP service.

```sh
weka security kms set kmip <address> <key-identifier> --client-cert <string> --client-key <string> [--ca-cert <string>] [--convert-to-cluster-key-on-fs] [--network-space-id <uint16>]
```

| Parameter                        | Description                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------- |
| `address`\*                      | Server address, usually a hostname:port or URL.                                             |
| `key-identifier`\*               | Key UID to secure the filesystems with.                                                     |
| `--client-cert` \<string>\*      | Path to the client certificate PEM file.                                                    |
| `--client-key` \<string>\*       | Path to the client key PEM file.                                                            |
| `--ca-cert` \<string>            | Path to a CA certificate PEM file for the KMIP server.                                      |
| `--convert-to-cluster-key-on-fs` | Convert all encrypted filesystems to use the cluster key.                                   |
| `--network-space-id` \<uint16>   | Network space ID in which to run the KMS connector. Defaults to the host network namespace. |

#### weka security kms set vault

Configure the active key management service to use an external HashiCorp Vault.

```sh
weka security kms set vault <address> <key-name> [--auth-path <string>] [--convert-to-cluster-key-on-fs] [--kubernetes-role <string>] [--namespace <string>] [--network-space-id <uint16>] [--role-id <string>] [--secret-id <string>] [--token <string>] [--transit-path <string>]
```

| Parameter                        | Description                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------- |
| `address`\*                      | Server address, usually a hostname:port or URL.                                             |
| `key-name`\*                     | Key name to secure the filesystems.                                                         |
| `--auth-path` \<string>          | Custom auth path URL prefix.                                                                |
| `--convert-to-cluster-key-on-fs` | Convert all encrypted filesystems to use the cluster key.                                   |
| `--kubernetes-role` \<string>    | Kubernetes role for Vault authentication.                                                   |
| `--namespace` \<string>          | Namespace in the Vault.                                                                     |
| `--network-space-id` \<uint16>   | Network space ID in which to run the KMS connector. Defaults to the host network namespace. |
| `--role-id` \<string>            | Role ID to access the KMS.                                                                  |
| `--secret-id` \<string>          | Secret ID to access the KMS (required with --role-id).                                      |
| `--token` \<string>              | API token to access the KMS.                                                                |
| `--transit-path` \<string>       | Custom transit path URL prefix.                                                             |

## weka security lockout-config

Manage the account lockout parameters, used when a user fails logging in too many times.

```sh
weka security lockout-config
```

### weka security lockout-config reset

Reset the number of failed attempts before lockout and the duration of lock to defaults.

```sh
weka security lockout-config reset
```

### weka security lockout-config set

Configure the number of failed attempts before lockout and the duration of lock.

```sh
weka security lockout-config set [--failed-attempts <uint8>] [--lockout-duration <duration>]
```

| Parameter                        | Description                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------- |
| `--failed-attempts` \<uint8>     | Maximum failed attempts. Number of consecutive failed logins before user account locks out. |
| `--lockout-duration` \<duration> | Lockout duration. How long the account should be locked out for after failed logins.        |

### weka security lockout-config show

Show the number of failed attempts before lockout and the duration of lock.

```sh
weka security lockout-config show
```

**Columns:** `lockout_duration`, `num_failed_logins`

## weka security login-banner

Manage the login banner displayed before authenticating.

```sh
weka security login-banner
```

### weka security login-banner disable

Disable the login banner.

```sh
weka security login-banner disable
```

### weka security login-banner enable

Enable the login banner.

```sh
weka security login-banner enable
```

### weka security login-banner reset

Reset the login banner back to default state (empty).

```sh
weka security login-banner reset
```

### weka security login-banner set

Set the login banner text.

```sh
weka security login-banner set <text>
```

| Parameter | Description                                                |
| --------- | ---------------------------------------------------------- |
| `text`\*  | Text banner to be displayed before the user authenticates. |

### weka security login-banner show

Show the current login banner.

```sh
weka security login-banner show
```

## weka security policy

Manage security policies, used for controlling access to cluster resources.

```sh
weka security policy
```

### weka security policy add

Add a new security policy.

```sh
weka security policy add <name> [--action <security-action>] [--anon-gid <uint32>] [--anon-uid <uint32>] [--description <string>] [--ips <strings>…] [--read-only <on-off>] [--roles <user-roles>…] [--squash-mode <squash-mode>]
```

| Parameter                      | Description                                                                                                                                                                                                |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                       | Name of the new security policy.                                                                                                                                                                           |
| `--action` \<security-action>  | Whether access is granted or denied when the security policy matches.                                                                                                                                      |
| `--anon-gid` \<uint32>         | Anonymous group ID to which accesses are squashed.                                                                                                                                                         |
| `--anon-uid` \<uint32>         | Anonymous user ID to which accesses are squashed.                                                                                                                                                          |
| `--description` \<string>      | Security policy description.                                                                                                                                                                               |
| `--ips` \<strings>…            | IPs (or ranges of IPs) to which the security policy applies. Multiple values may be supplied separated by commas, or the option may be repeated.                                                           |
| `--read-only` \<on-off>        | The security policy allows read-only mounts only.                                                                                                                                                          |
| `--roles` \<user-roles>…       | User roles to which the security policy applies. Used only for administrative interfaces. Multiple values may be supplied separated by commas, or the option may be repeated.                              |
| `--squash-mode` \<squash-mode> | Dictates whether user and group IDs accessing mounted filesystems are squashed. If 'root' then converts accesses by root (UID 0/GID 0) to the anonymous UID and GID. If 'all', then converts all accesses. |

### weka security policy duplicate

Duplicates an existing security policy, creating a new one.

```sh
weka security policy duplicate <policy> <new-name>
```

| Parameter    | Description                               |
| ------------ | ----------------------------------------- |
| `policy`\*   | Policy ID or name of the policy to clone. |
| `new-name`\* | Name for the new policy.                  |

### weka security policy join

Manage security policies enforced when containers join the cluster.

```sh
weka security policy join
```

#### weka security policy join attach

Add security policies to those applied when containers join the cluster.

```sh
weka security policy join attach <policies>… [--backend] [--client] [--force]
```

| Parameter         | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| `policies`\*…     | Security policies to apply, by name or ID.                    |
| `-b`, `--backend` | Apply to backend containers.                                  |
| `-c`, `--client`  | Apply to client containers.                                   |
| `-f`, `--force`   | Bypass safeguards when updating. May disrupt cluster members. |

#### weka security policy join detach

Remove security policies from those applied when containers join the cluster.

```sh
weka security policy join detach <policies>… [--backend] [--client] [--force]
```

| Parameter         | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| `policies`\*…     | Security policies to apply, by name or ID.                    |
| `-b`, `--backend` | Apply to backend containers.                                  |
| `-c`, `--client`  | Apply to client containers.                                   |
| `-f`, `--force`   | Bypass safeguards when updating. May disrupt cluster members. |

#### weka security policy join list

List security policies applied when containers join the cluster.

```sh
weka security policy join list [--backend] [--client]
```

| Parameter         | Description                  |
| ----------------- | ---------------------------- |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client`  | Apply to client containers.  |

**Columns:** `mode`, `position`, `uid`, `id`, `name`

#### weka security policy join reset

Remove all join security policies for the specified container mode.

```sh
weka security policy join reset [--backend] [--client]
```

| Parameter         | Description                  |
| ----------------- | ---------------------------- |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client`  | Apply to client containers.  |

#### weka security policy join set

Replace all join security policies for the specified container mode.

```sh
weka security policy join set <policies>… [--backend] [--client] [--force]
```

| Parameter         | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| `policies`\*…     | Security policies to apply, by name or ID.                    |
| `-b`, `--backend` | Apply to backend containers.                                  |
| `-c`, `--client`  | Apply to client containers.                                   |
| `-f`, `--force`   | Bypass safeguards when updating. May disrupt cluster members. |

### weka security policy list

Show the list of security policies.

```sh
weka security policy list [--action <security-action>] [--ips <ip-ranges>…] [--roles <user-roles>…]
```

| Parameter                     | Description                                                                                                                                |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `--action` \<security-action> | Only show policies that match a specific action.                                                                                           |
| `--ips` \<ip-ranges>…         | Only show policies include specific IP address ranges. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--roles` \<user-roles>…      | Only show policies naming these user roles. Multiple values may be supplied separated by commas, or the option may be repeated.            |

**Columns:** `uid`, `id`, `name`, `ref_count`, `description`, `action`, `roles`, `ips`, `read_only`, `squash_mode`, `anon_uid`, `anon_gid`, `created_by`, `created_at`, `modified_by`, `modified_at`

### weka security policy remove

Removes an existing security policy.

```sh
weka security policy remove <policy> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `policy`\*      | Policy ID or name of the policy to remove.                      |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka security policy show

Displays information about a specific security policy.

```sh
weka security policy show <policy>
```

| Parameter  | Description                            |
| ---------- | -------------------------------------- |
| `policy`\* | Name or ID of security policy to show. |

**Columns:** `uid`, `id`, `name`, `ref_count`, `description`, `action`, `roles`, `ips`, `read_only`, `squash_mode`, `anon_uid`, `anon_gid`, `created_by`, `created_at`, `modified_by`, `modified_at`

### weka security policy test

Simulates the effect of one or more security policies against a proposed access.

```sh
weka security policy test <policies>… [--ip <ip>] [--join] [--role <user-role>]
```

| Parameter             | Description                                                         |
| --------------------- | ------------------------------------------------------------------- |
| `policies`\*…         | Policies to evaluate, with access verified in the order listed.     |
| `--ip` \<ip>          | Use this IP address to evaluate as the source address.              |
| `--join`              | Simulate effect of policies when joining the cluster.               |
| `--role` \<user-role> | Simulate effect of policies on API access from the given user role. |

### weka security policy update

Updates the settings of an existing security policy.

```sh
weka security policy update <policy> [--action <security-action>] [--add-ips <ip-ranges>…] [--add-roles <user-roles>…] [--anon-gid <uint32>] [--anon-uid <uint32>] [--description <string>] [--force] [--ips <ip-ranges>…] [--new-name <string>] [--read-only <on-off>] [--remove-ips <ip-ranges>…] [--remove-roles <user-roles>…] [--roles <user-roles>…] [--squash-mode <squash-mode>]
```

| Parameter                       | Description                                                                                                                                                                                                |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `policy`\*                      | Policy ID or name of policy to update.                                                                                                                                                                     |
| `--action` \<security-action>   | Whether access is granted or denied when the security policy matches.                                                                                                                                      |
| `--add-ips` \<ip-ranges>…       | IP addresses or ranges to add to the end of the security policy. Multiple values may be supplied separated by commas, or the option may be repeated.                                                       |
| `--add-roles` \<user-roles>…    | These user roles are added to the security policy. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                     |
| `--anon-gid` \<uint32>          | Anonymous group ID to which accesses are squashed.                                                                                                                                                         |
| `--anon-uid` \<uint32>          | Anonymous user ID to which accesses are squashed.                                                                                                                                                          |
| `--description` \<string>       | Security policy description.                                                                                                                                                                               |
| `-f`, `--force`                 | Force action. Perform this action without further confirmation.                                                                                                                                            |
| `--ips` \<ip-ranges>…           | IPs (or ranges of IPs) to which the security policy applies. Multiple values may be supplied separated by commas, or the option may be repeated.                                                           |
| `--new-name` \<string>          | New name of security policy.                                                                                                                                                                               |
| `--read-only` \<on-off>         | The security policy allows read-only mounts only.                                                                                                                                                          |
| `--remove-ips` \<ip-ranges>…    | IP addresses or IP address ranges to remove from the security policy. Multiple values may be supplied separated by commas, or the option may be repeated.                                                  |
| `--remove-roles` \<user-roles>… | These user roles are removed from the security policy. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                 |
| `--roles` \<user-roles>…        | User roles to which the security policy applies. Used only for administrative interfaces. Multiple values may be supplied separated by commas, or the option may be repeated.                              |
| `--squash-mode` \<squash-mode>  | Dictates whether user and group IDs accessing mounted filesystems are squashed. If 'root' then converts accesses by root (UID 0/GID 0) to the anonymous UID and GID. If 'all', then converts all accesses. |

## weka security tls

TLS-related commands.

```sh
weka security tls
```

### weka security tls download

Download the WEKA cluster TLS certificate.

```sh
weka security tls download [<destination-path>]
```

| Parameter          | Description                              |
| ------------------ | ---------------------------------------- |
| `destination-path` | Path to save the downloaded certificate. |

### weka security tls local

Manage TLS local configuration.

```sh
weka security tls local
```

#### weka security tls local reset

Remove local TLS configuration.

```sh
weka security tls local reset [--all] [--ca-cert] [--container-ids <container-ids>…] [--private-key]
```

| Parameter                           | Description                                                                                                                 |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `--all`                             | Change applies to all backend containers.                                                                                   |
| `--ca-cert`                         | Remove local TLS CA certificate.                                                                                            |
| `--container-ids` \<container-ids>… | Change applies to specified containers. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--private-key`                     | Remove private key and certificate.                                                                                         |

#### weka security tls local set

Enable and set local TLS configuration.

```sh
weka security tls local set [--all] [--ca-cert <string>] [--certificate <string>] [--container-ids <container-ids>…] [--private-key <string>]
```

| Parameter                           | Description                                                                                                                 |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `--all`                             | Change applies to all backend containers.                                                                                   |
| `--ca-cert` \<string>               | Path to TLS CA certificate PEM file.                                                                                        |
| `--certificate` \<string>           | Path to TLS certificate PEM file.                                                                                           |
| `--container-ids` \<container-ids>… | Change applies to specified containers. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--private-key` \<string>           | Path to TLS private key PEM file.                                                                                           |

### weka security tls purge

Remove all pinned TLS certificates from the profile, or with --global from the machine-wide store used by unattended operations.

```sh
weka security tls purge [--global]
```

| Parameter  | Description                                                                                                                                                                                                                                        |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--global` | Use the machine-wide certificate store (/etc/wekaio/certs) instead of the profile's. The machine-wide store is shared by all users and consulted by unattended operations such as mounting a stateless client; writing it typically requires root. |

### weka security tls reset

Disable TLS certificate and key.

```sh
weka security tls reset
```

### weka security tls set

Enable and set TLS certificate and key.

```sh
weka security tls set --certificate <string> --private-key <string>
```

| Parameter                   | Description                       |
| --------------------------- | --------------------------------- |
| `--certificate` \<string>\* | Path to TLS certificate PEM file. |
| `--private-key` \<string>\* | Path to TLS private key PEM file. |

### weka security tls status

Show the WEKA cluster TLS status and certificate.

```sh
weka security tls status
```

### weka security tls trust

Pin (trust on first use) the TLS certificate a WEKA host presents, so later connections verify against it. Typically run at install time to trust a backend's distribution server before the first mount; use --global there, so the pin is found regardless of the invoking user and environment.

```sh
weka security tls trust --from <string> [--force] [--global]
```

| Parameter            | Description                                                                                                                                                                                                                                        |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--from` \<string>\* | Host to fetch and trust the certificate from (host or host:port; port defaults to 14000).                                                                                                                                                          |
| `--force`            | Replace an already-trusted certificate without prompting.                                                                                                                                                                                          |
| `--global`           | Use the machine-wide certificate store (/etc/wekaio/certs) instead of the profile's. The machine-wide store is shared by all users and consulted by unattended operations such as mounting a stateless client; writing it typically requires root. |

### weka security tls untrust

Remove a certificate previously pinned with 'security tls trust', so the next connection to that host runs trust-on-first-use again.

```sh
weka security tls untrust --from <string> [--global]
```

| Parameter            | Description                                                                                                                                                                                                                                        |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--from` \<string>\* | Host whose trusted certificate to remove (host or host:port; port defaults to 14000).                                                                                                                                                              |
| `--global`           | Use the machine-wide certificate store (/etc/wekaio/certs) instead of the profile's. The machine-wide store is shared by all users and consulted by unattended operations such as mounting a stateless client; writing it typically requires root. |
