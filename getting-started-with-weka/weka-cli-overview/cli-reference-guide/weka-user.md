# weka user

List users defined in the Weka cluster.

```sh
weka user [--include-tenants]
```

| Parameter           | Description                     |
| ------------------- | ------------------------------- |
| `--include-tenants` | Include users from all tenants. |

**Columns:** `uid`, `tenantId`, `tenant`, `username`, `role`, `source`, `posix_uid`, `posix_gid`, `s3policy`

## weka user add

Create a new user.

```sh
weka user add <username> <role> [<password>] [--posix-gid <uint32>] [--posix-uid <uint32>]
```

| Parameter               | Description                                                                                                                                                                                                                                  |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `username`\*            | Username for new user. The user must present this to login.                                                                                                                                                                                  |
| `role`\*                | Role for new user.                                                                                                                                                                                                                           |
| `password`              | Password for new user. Must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping. |
| `--posix-gid` \<uint32> | POSIX group ID for user. Used for S3 only.                                                                                                                                                                                                   |
| `--posix-uid` \<uint32> | POSIX user ID for user. Used for S3 only.                                                                                                                                                                                                    |

## weka user generate-token

Generate an access token for the current logged in user for use with REST API.

```sh
weka user generate-token [--access-token-timeout <duration>] [--plain]
```

| Parameter                            | Description                                                            |
| ------------------------------------ | ---------------------------------------------------------------------- |
| `--access-token-timeout` \<duration> | Duration until the access token expires.                               |
| `--plain`                            | Print the token to the console instead of copying it to the clipboard. |

## weka user ldap

Show current LDAP configuration used for authenticating users.

```sh
weka user ldap
```

**Columns:** `enabled`, `server_type`, `server_uri`, `start_tls`, `ignore_start_tls_failure`, `server_timeout_secs`, `protocol_version`, `base_dn`, `domain`, `user_object_class`, `user_id_attribute`, `user_revocation_attribute`, `group_object_class`, `group_membership_attribute`, `group_id_attribute`, `reader_username`, `s3_policy_attribute`, `user_uuid_attribute`, `network_space_id`, `role_groups`

### weka user ldap disable

Disable authentication through the configured LDAP server (has no effect if LDAP server is already disabled).

```sh
weka user ldap disable [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka user ldap enable

Enable authentication through the configured LDAP server (has no effect if LDAP server is already enabled).

```sh
weka user ldap enable
```

### weka user ldap refresh-imported

Update the UID, GID, and S3 policy of users imported from LDAP directory.

```sh
weka user ldap refresh-imported
```

**Columns:** `success`, `message`, `success_count`, `failure_count`, `errors`

### weka user ldap reset

Delete all LDAP settings from the cluster.

```sh
weka user ldap reset [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka user ldap setup

Set up authentication through an LDAP server.

```sh
weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> [<reader-password>] [--cluster-admin-group <string>] [--csi-group <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--protocol-version <uint>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--start-tls] [--tenant-admin-group <string>] [--user-revocation-attribute <string>] [--user-uuid-attribute <string>]
```

| Parameter                               | Description                                                                                                               |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `server-uri`\*                          | LDAP server URI. Format is either \[ldap://]hostname\[:port] or ldaps://hostname\[:port].                                 |
| `base-dn`\*                             | Base DN.                                                                                                                  |
| `user-object-class`\*                   | User object class.                                                                                                        |
| `user-id-attribute`\*                   | User ID attribute.                                                                                                        |
| `group-object-class`\*                  | Group object class.                                                                                                       |
| `group-membership-attribute`\*          | Group membership attribute.                                                                                               |
| `group-id-attribute`\*                  | Group ID attribute.                                                                                                       |
| `reader-username`\*                     | Reader username.                                                                                                          |
| `reader-password`                       | Reader password. If omitted, you will be prompted.                                                                        |
| `--cluster-admin-group` \<string>       | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant.      |
| `--csi-group` \<string>                 | CSI LDAP group. Users in this group are assigned the CSI role.                                                            |
| `--ignore-start-tls-failure`            | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption.                                       |
| `--network-space-id` \<uint16>          | Network space ID in which to run LDAP queries. Defaults to the host network namespace.                                    |
| `--protocol-version` \<uint>            | LDAP protocol version.                                                                                                    |
| `--readonly-group` \<string>            | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role.                                                  |
| `--regular-group` \<string>             | Regular LDAP group. Users in this group are assigned the Regular role.                                                    |
| `--server-timeout-secs` \<duration>     | LDAP server connection timeout, specified in seconds.                                                                     |
| `--start-tls`                           | Issue StartTLS after connecting. URL should not be used with ldaps://.                                                    |
| `--tenant-admin-group` \<string>        | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role.                                            |
| `--user-revocation-attribute` \<string> | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `--user-uuid-attribute` \<string>       | User UUID attribute.                                                                                                      |

### weka user ldap setup-ad

Set up authentication through an Active Directory server.

```sh
weka user ldap setup-ad <server-uri> <domain> <reader-username> [<reader-password>] [--cluster-admin-group <string>] [--csi-group <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--start-tls] [--tenant-admin-group <string>] [--user-revocation-attribute <string>]
```

| Parameter                               | Description                                                                                                               |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `server-uri`\*                          | LDAP server URI.                                                                                                          |
| `domain`\*                              | Active Directory domain for principals.                                                                                   |
| `reader-username`\*                     | Reader username.                                                                                                          |
| `reader-password`                       | Reader password. If omitted, you will be prompted.                                                                        |
| `--cluster-admin-group` \<string>       | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant.      |
| `--csi-group` \<string>                 | CSI LDAP group. Users in this group are assigned the CSI role.                                                            |
| `--ignore-start-tls-failure`            | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption.                                       |
| `--network-space-id` \<uint16>          | Network space ID in which to run LDAP queries. Defaults to the host network namespace.                                    |
| `--readonly-group` \<string>            | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role.                                                  |
| `--regular-group` \<string>             | Regular LDAP group. Users in this group are assigned the Regular role.                                                    |
| `--server-timeout-secs` \<duration>     | LDAP server connection timeout, specified in seconds.                                                                     |
| `--start-tls`                           | Issue StartTLS after connecting. URL should not be used with ldaps://.                                                    |
| `--tenant-admin-group` \<string>        | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role.                                            |
| `--user-revocation-attribute` \<string> | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |

### weka user ldap update

Edit LDAP server configuration.

```sh
weka user ldap update [--base-dn <string>] [--change-reader-password] [--cluster-admin-group <string>] [--csi-group <string>] [--group-id-attribute <string>] [--group-membership-attribute <string>] [--group-object-class <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--protocol-version <uint>] [--reader-password <string>] [--reader-username <string>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--server-uri <string>] [--start-tls] [--tenant-admin-group <string>] [--user-id-attribute <string>] [--user-object-class <string>] [--user-revocation-attribute <string>] [--user-uuid-attribute <string>]
```

| Parameter                                | Description                                                                                                               |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `--base-dn` \<string>                    | Base DN.                                                                                                                  |
| `--change-reader-password`               | Prompt for a new reader password.                                                                                         |
| `--cluster-admin-group` \<string>        | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant.      |
| `--csi-group` \<string>                  | CSI LDAP group. Users in this group are assigned the CSI role.                                                            |
| `--group-id-attribute` \<string>         | Group ID attribute.                                                                                                       |
| `--group-membership-attribute` \<string> | Group membership attribute.                                                                                               |
| `--group-object-class` \<string>         | Group object class.                                                                                                       |
| `--ignore-start-tls-failure`             | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption.                                       |
| `--network-space-id` \<uint16>           | Network space ID in which to run LDAP queries. Defaults to the host network namespace.                                    |
| `--protocol-version` \<uint>             | LDAP protocol version.                                                                                                    |
| `--reader-password` \<string>            | Reader password.                                                                                                          |
| `--reader-username` \<string>            | Reader username.                                                                                                          |
| `--readonly-group` \<string>             | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role.                                                  |
| `--regular-group` \<string>              | Regular LDAP group. Users in this group are assigned the Regular role.                                                    |
| `--server-timeout-secs` \<duration>      | LDAP server connection timeout, specified in seconds.                                                                     |
| `--server-uri` \<string>                 | LDAP server URI. Format is either \[ldap://]hostname\[:port] or ldaps://hostname\[:port].                                 |
| `--start-tls`                            | Issue StartTLS after connecting. URL should not be used with ldaps://.                                                    |
| `--tenant-admin-group` \<string>         | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role.                                            |
| `--user-id-attribute` \<string>          | User ID attribute.                                                                                                        |
| `--user-object-class` \<string>          | User object class.                                                                                                        |
| `--user-revocation-attribute` \<string>  | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `--user-uuid-attribute` \<string>        | User UUID attribute.                                                                                                      |

## weka user login

Logs a user into the Weka cluster. If login is successful, the user credentials are saved to the user's profile.

```sh
weka user login [<username>] [<password>] [--path <string>] [--tenant <string>]
```

| Parameter                  | Description                                                                                                                                                                                                                                                                                                                                                     |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `username`                 | Username of user for authentication. Can be supplied in the envrionment as 'WEKA\_USERNAME'. Prompted for if not set.                                                                                                                                                                                                                                           |
| `password`                 | Password of the user to authenticate as. Can be supplied in the environment as 'WEKA\_PASSWORD'. Prompted for if not set.                                                                                                                                                                                                                                       |
| `-p`, `--path` \<string>   | The path where the login token will be saved. This path can also be specified using the WEKA\_TOKEN environment variable. After logging in, use the WEKA\_TOKEN environment variable to specify where the login token is located. Deprecated: Use of profiles is a better solution, or use the weka user generate-token command to create a suitable API token. |
| `-g`, `--tenant` \<string> | Tenant where the user is located.                                                                                                                                                                                                                                                                                                                               |

## weka user logout

Log out of the Weka cluster by removing the saved credentials.

```sh
weka user logout [--all]
```

| Parameter | Description                                                                        |
| --------- | ---------------------------------------------------------------------------------- |
| `--all`   | Log out of all profiles. If not specified, only the current profile is logged out. |

## weka user passwd

Set a user's password. Admins can change the password for any user in their organization.

```sh
weka user passwd [<password>] [--current-password <string>] [--username <username>]
```

| Parameter                      | Description                                                                                                                                                                                                                         |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `password`                     | New password. Must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping. |
| `--current-password` \<string> | Current password. Only required when changing the current user's own password.                                                                                                                                                      |
| `--username` \<username>       | User to change the password for. Defaults to the currently logged-in user.                                                                                                                                                          |

## weka user remove

Remove user from the Weka cluster.

```sh
weka user remove <username>
```

| Parameter    | Description                 |
| ------------ | --------------------------- |
| `username`\* | Username of user to delete. |

## weka user revoke-tokens

Revoke all existing login tokens of an internal user.

```sh
weka user revoke-tokens <username>
```

| Parameter    | Description                                        |
| ------------ | -------------------------------------------------- |
| `username`\* | Username of the user whose tokens will be revoked. |

## weka user update

Change parameters of an existing new user.

```sh
weka user update <username> [--posix-gid <uint32>] [--posix-uid <uint32>] [--role <user-role>]
```

| Parameter               | Description                                |
| ----------------------- | ------------------------------------------ |
| `username`\*            | Username of user to update.                |
| `--posix-gid` \<uint32> | POSIX group ID for user. Used for S3 only. |
| `--posix-uid` \<uint32> | POSIX user ID for user. Used for S3 only.  |
| `--role` \<user-role>   | New role to set for the user.              |

## weka user whoami

Get information about currently logged-in user.

```sh
weka user whoami
```

**Columns:** `tenantId`, `tenant`, `username`, `source`, `role`, `uid`, `posixUID`, `posixGID`, `s3Policy`
