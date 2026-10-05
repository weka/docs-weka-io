# weka user

List users defined in the cluster.

```sh
weka user [--include-tenants]
```

| Parameter | Description |
| --------- | ----------- |
| `--include-tenants` | Include users from all tenants. |

**Columns:** `uid`, `tenantId`, `tenant`, `username`, `role`, `source`, `posix_uid`, `posix_gid`, `s3policy`, `customRoles`

## weka user add

Create a new user.

```sh
weka user add <username> <role> [<password>] [--posix-gid <uint32>] [--posix-uid <uint32>] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `username`* | Username for new user. The user must present this to login. |
| `role`* | Role for the new user: a predefined role, one or more custom role names, or a comma-separated mix of the two. |
| `password` | Password for new user. Must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping. |
| `--posix-gid` &lt;uint32&gt; | POSIX group ID for user. Used for S3 only. |
| `--posix-uid` &lt;uint32&gt; | POSIX user ID for user. Used for S3 only. |
| `--tenant` &lt;tenant&gt; | Tenant name or ID in which to create the user. |

## weka user assume-tenant

Re-scope the current cluster-admin session to a tenant. Cluster administrators only.

```sh
weka user assume-tenant [<tenant>] [--revert]
```

| Parameter | Description |
| --------- | ----------- |
| `tenant` | Tenant name or ID to assume. |
| `--revert` | Drop this session's assumed tenant and return it to cluster scope. |

## weka user generate-token

Generate an access token for the current logged in user for use with REST API.

```sh
weka user generate-token [--access-token-timeout <duration>] [--plain]
```

| Parameter                            | Description                                                            |
| ------------------------------------ | ---------------------------------------------------------------------- |
| `--access-token-timeout` \<duration> | Duration until the access token expires. Default: 30 days.             |
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
weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> [<reader-password>] [--cluster-admin-group <string>] [--csi-group <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--protocol-version <uint>] [--quota-manager-group <string>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--start-tls] [--tenant-admin-group <string>] [--user-revocation-attribute <string>] [--user-uuid-attribute <string>]
```

| Parameter | Description |
| --------- | ----------- |
| `server-uri`* | LDAP server URI. Format is either [ldap://]hostname[:port] or ldaps://hostname[:port]. |
| `base-dn`* | Base DN. |
| `user-object-class`* | User object class. |
| `user-id-attribute`* | User ID attribute. |
| `group-object-class`* | Group object class. |
| `group-membership-attribute`* | Group membership attribute. |
| `group-id-attribute`* | Group ID attribute. |
| `reader-username`* | Reader username. |
| `reader-password` | Reader password. If omitted, you will be prompted. |
| `--cluster-admin-group` &lt;string&gt; | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant. |
| `--csi-group` &lt;string&gt; | CSI LDAP group. Users in this group are assigned the CSI role. |
| `--ignore-start-tls-failure` | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption. |
| `--network-space-id` &lt;uint16&gt; | Network space ID in which to run LDAP queries. Defaults to the host network namespace. |
| `--protocol-version` &lt;uint&gt; | LDAP protocol version. |
| `--quota-manager-group` &lt;string&gt; | QuotaManager LDAP group. Users in this group are assigned the QuotaManager role. |
| `--readonly-group` &lt;string&gt; | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role. |
| `--regular-group` &lt;string&gt; | Regular LDAP group. Users in this group are assigned the Regular role. |
| `--server-timeout-secs` &lt;duration&gt; | LDAP server connection timeout, specified in seconds. |
| `--start-tls` | Issue StartTLS after connecting. URL should not be used with ldaps://. |
| `--tenant-admin-group` &lt;string&gt; | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role. |
| `--user-revocation-attribute` &lt;string&gt; | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `--user-uuid-attribute` &lt;string&gt; | User UUID attribute. |

### weka user ldap setup-ad

Set up authentication through an Active Directory server.

```sh
weka user ldap setup-ad <server-uri> <domain> <reader-username> [<reader-password>] [--cluster-admin-group <string>] [--csi-group <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--quota-manager-group <string>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--start-tls] [--tenant-admin-group <string>] [--user-revocation-attribute <string>]
```

| Parameter | Description |
| --------- | ----------- |
| `server-uri`* | LDAP server URI. |
| `domain`* | Active Directory domain for principals. |
| `reader-username`* | Reader username. |
| `reader-password` | Reader password. If omitted, you will be prompted. |
| `--cluster-admin-group` &lt;string&gt; | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant. |
| `--csi-group` &lt;string&gt; | CSI LDAP group. Users in this group are assigned the CSI role. |
| `--ignore-start-tls-failure` | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption. |
| `--network-space-id` &lt;uint16&gt; | Network space ID in which to run LDAP queries. Defaults to the host network namespace. |
| `--quota-manager-group` &lt;string&gt; | QuotaManager LDAP group. Users in this group are assigned the QuotaManager role. |
| `--readonly-group` &lt;string&gt; | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role. |
| `--regular-group` &lt;string&gt; | Regular LDAP group. Users in this group are assigned the Regular role. |
| `--server-timeout-secs` &lt;duration&gt; | LDAP server connection timeout, specified in seconds. |
| `--start-tls` | Issue StartTLS after connecting. URL should not be used with ldaps://. |
| `--tenant-admin-group` &lt;string&gt; | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role. |
| `--user-revocation-attribute` &lt;string&gt; | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |

### weka user ldap update

Edit LDAP server configuration.

```sh
weka user ldap update [--base-dn <string>] [--change-reader-password] [--cluster-admin-group <string>] [--csi-group <string>] [--group-id-attribute <string>] [--group-membership-attribute <string>] [--group-object-class <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--protocol-version <uint>] [--quota-manager-group <string>] [--reader-password <string>] [--reader-username <string>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--server-uri <string>] [--start-tls] [--tenant-admin-group <string>] [--user-id-attribute <string>] [--user-object-class <string>] [--user-revocation-attribute <string>] [--user-uuid-attribute <string>]
```

| Parameter | Description |
| --------- | ----------- |
| `--base-dn` &lt;string&gt; | Base DN. |
| `--change-reader-password` | Prompt for a new reader password. |
| `--cluster-admin-group` &lt;string&gt; | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant. |
| `--csi-group` &lt;string&gt; | CSI LDAP group. Users in this group are assigned the CSI role. |
| `--group-id-attribute` &lt;string&gt; | Group ID attribute. |
| `--group-membership-attribute` &lt;string&gt; | Group membership attribute. |
| `--group-object-class` &lt;string&gt; | Group object class. |
| `--ignore-start-tls-failure` | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption. |
| `--network-space-id` &lt;uint16&gt; | Network space ID in which to run LDAP queries. Defaults to the host network namespace. |
| `--protocol-version` &lt;uint&gt; | LDAP protocol version. |
| `--quota-manager-group` &lt;string&gt; | QuotaManager LDAP group. Users in this group are assigned the QuotaManager role. |
| `--reader-password` &lt;string&gt; | Reader password. |
| `--reader-username` &lt;string&gt; | Reader username. |
| `--readonly-group` &lt;string&gt; | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role. |
| `--regular-group` &lt;string&gt; | Regular LDAP group. Users in this group are assigned the Regular role. |
| `--server-timeout-secs` &lt;duration&gt; | LDAP server connection timeout, specified in seconds. |
| `--server-uri` &lt;string&gt; | LDAP server URI. Format is either [ldap://]hostname[:port] or ldaps://hostname[:port]. |
| `--start-tls` | Issue StartTLS after connecting. URL should not be used with ldaps://. |
| `--tenant-admin-group` &lt;string&gt; | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role. |
| `--user-id-attribute` &lt;string&gt; | User ID attribute. |
| `--user-object-class` &lt;string&gt; | User object class. |
| `--user-revocation-attribute` &lt;string&gt; | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `--user-uuid-attribute` &lt;string&gt; | User UUID attribute. |

## weka user login

Logs a user into the cluster. If login is successful, the user credentials are saved to the user's profile.

```sh
weka user login [<username>] [<password>] [--access-token-timeout <duration>] [--no-open] [--path <string>] [--refresh-token-timeout <duration>] [--tenant <string>] [--use-device-code]
```

| Parameter | Description |
| --------- | ----------- |
| `username` | Username of user for authentication. Can be supplied in the environment as 'WEKA_USERNAME'. Prompted for if not set. |
| `password` | Password of the user to authenticate as. Can be supplied in the environment as 'WEKA_PASSWORD'. Prompted for if not set. |
| `--access-token-timeout` &lt;duration&gt; | Duration until the access token expires. Defaults to the cluster setting. |
| `--no-open` | During single sign-on, do not automatically open a browser; print the verification URL instead (plus a code, with --use-device-code). |
| `-p`, `--path` &lt;string&gt; | The path where the login token will be saved. This path can also be specified using the WEKA_TOKEN environment variable. After logging in, use the WEKA_TOKEN environment variable to specify where the login token is located. Deprecated: Use of profiles is a better solution, or use the weka user generate-token command to create a suitable API token. |
| `--refresh-token-timeout` &lt;duration&gt; | Duration until the refresh token expires. Defaults to the cluster setting. |
| `-g`, `--tenant` &lt;string&gt; | Tenant where the user is located. |
| `--use-device-code` | Sign in via the device-code flow (a URL and code to enter elsewhere) instead of the default browser-based sign-in, even if a username is given. |

## weka user logout

Log out of the cluster by removing the saved credentials.

```sh
weka user logout [--all]
```

| Parameter | Description                                                                        |
| --------- | ---------------------------------------------------------------------------------- |
| `--all`   | Log out of all profiles. If not specified, only the current profile is logged out. |

## weka user oidc

Manage OIDC (OpenID Connect) single sign-on for the calling tenant.

```sh
weka user oidc
```

### weka user oidc reset

Remove the calling tenant's OIDC connector.

```sh
weka user oidc reset [--force]
```

| Parameter | Description |
| --------- | ----------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka user oidc rotate-seal-key

Rotate the calling tenant's OIDC seal key, so its outstanding single sign-on sessions must re-authenticate at their next refresh.

```sh
weka user oidc rotate-seal-key [--force]
```

| Parameter | Description |
| --------- | ----------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka user oidc set

Create or update the calling tenant's OIDC connector. An enabled connector takes over management login for the tenant; an LDAP configuration may stay enabled alongside it to serve the S3 user lifecycle.

```sh
weka user oidc set [--clear-client-secret] [--client-id <string>] [--client-secret <string>] [--enabled] [--issuer <string>] [--require-mfa] [--role-claim <string>] [--vendor <oidc-vendor>]
```

| Parameter | Description |
| --------- | ----------- |
| `--clear-client-secret` | Clear a stored client secret, re-registering WEKA as a public client. Does the same as entering an empty value at the --client-secret prompt, without needing a terminal. |
| `--client-id` &lt;string&gt; | OIDC client ID. Required to enable the connector. |
| `--client-secret` &lt;string&gt; | Client secret issued by the identity provider, for an application registered as a confidential client. Omit it to register WEKA as a public client; pass an empty value to be prompted, where an empty entry clears a secret set earlier. It is never displayed again once stored. |
| `--enabled` | Enable OIDC authentication for this tenant. Defaults to false when the connector is created. |
| `--issuer` &lt;string&gt; | OIDC issuer URL. Required to enable the connector. |
| `--require-mfa` | Require the identity provider to attest multi-factor authentication. Defaults to true when the connector is created. |
| `--role-claim` &lt;string&gt; | JWT claim name to map to a role. May be required to enable the connector. Pass an explicit empty value to clear it when moving the connector to group mapping. |
| `--vendor` &lt;oidc-vendor&gt; | Identity provider vendor. Only `entra` is accepted when enabling the connector. Valid value: entra. |

### weka user oidc show

Display the calling tenant's OIDC connector configuration.

```sh
weka user oidc show
```

**Columns:** `enabled`, `vendor`, `issuer`, `client_id`, `role_claim`, `require_mfa`, `client_secret_set`

## weka user passwd

Set a user's password. Admins can change the password for any user in their tenant.

```sh
weka user passwd [<password>] [--current-password <string>] [--username <username>]
```

| Parameter                      | Description                                                                                                                                                                                                                         |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `password`                     | New password. Must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping. |
| `--current-password` \<string> | Current password. Only required when changing the current user's own password.                                                                                                                                                      |
| `--username` \<username>       | User to change the password for. Defaults to the currently logged-in user.                                                                                                                                                          |

## weka user remove

Remove user from the cluster.

```sh
weka user remove <username> [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `username`* | Username of user to delete. |
| `--tenant` &lt;tenant&gt; | Tenant name or ID holding the user. Not supported for S3 users. |

## weka user revoke-tokens

Revoke all existing login tokens of an internal user.

```sh
weka user revoke-tokens <username>
```

| Parameter    | Description                                        |
| ------------ | -------------------------------------------------- |
| `username`\* | Username of the user whose tokens will be revoked. |

## weka user show

Show details for one cluster user.

```sh
weka user show <username> [--include-tenants] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `username`* | Username of the user to show. |
| `--include-tenants` | Search all tenants for the user, not only the caller's own tenant. |
| `--tenant` &lt;tenant&gt; | Tenant holding the user. Required when the username exists in more than one tenant. |

**Columns:** `tenantId`, `tenant`, `username`, `source`, `role`, `uid`, `posix_uid`, `posix_gid`, `s3policy`, `customRoles`

## weka user update

Change parameters of an existing new user.

```sh
weka user update <username> [--posix-gid <uint32>] [--posix-uid <uint32>] [--role <roles>] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `username`* | Username of user to update. |
| `--posix-gid` &lt;uint32&gt; | POSIX group ID for user. Used for S3 only. |
| `--posix-uid` &lt;uint32&gt; | POSIX user ID for user. Used for S3 only. |
| `--role` &lt;roles&gt; | New role(s) for the user: a predefined role, custom role names, or a comma-separated mix. Replaces the user's custom roles. Naming a predefined role alone also drops every custom role; naming only custom roles leaves the user's predefined role unchanged. |
| `--tenant` &lt;tenant&gt; | Tenant name or ID holding the user. Changing the POSIX IDs of an S3 user in another tenant is not supported. |

## weka user whoami

Get information about currently logged-in user.

```sh
weka user whoami
```

**Columns:** `tenantId`, `tenant`, `username`, `source`, `role`, `uid`, `posixUID`, `posixGID`, `s3Policy`, `customRoles`, `profile`, `credentials`, `assumed`, `assumedFromTenant`
