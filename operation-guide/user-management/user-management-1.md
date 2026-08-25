---
description: >-
  Manage local users, authentication tokens, and LDAP or Active Directory
  directories using the CLI.
---

# Manage users using the CLI

## Create a local user

Creates a local cluster user with a role that determines what the user can do.

**Command:** `weka user add`

```sh
weka user add <username> <role> [<password>] [--posix-gid <uint32>] [--posix-uid <uint32>]
```

**Parameters**

| Parameter               | Description                                                                                                                                                                                                                                  |
| --- | --- |
| `username`\* | Username for new user. The user must present this to login. |
| `role`\* | Role for new user. Possible values: `clusteradmin`, `csi`, `tenantadmin`, `readonly`, `regular`, `s3` |
| `password` | Password for new user. Must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping. |
| `--posix-gid` \<uint32> | POSIX group ID for user. Used for S3 only. |
| `--posix-uid` \<uint32> | POSIX user ID for user. Used for S3 only. |

{% hint style="success" %}
**Example:**

`$ weka user add my_new_user regular S3cret`

This command line creates a user with a username of `my_new_user`, a password of `S3cret` and a role of a Regular user.
{% endhint %}

### Display list of users

Run the `weka user` command to display the list of users defined in WEKA.

```
$ weka user
Username    | Source   | Role
------------+----------+--------
my_new_user | Internal | Regular
admin       | Internal | Admin
```

### Display current user information

Run the `weka user whoami` command to receive information about the current user running the command.

To use the new user credentials, use the`WEKA_USERNAME` and `WEKA_PASSWORD`environment variables:

```
$ WEKA_USERNAME=my_new_user WEKA_PASSWORD=S3cret weka user whoami
Username    | Source   | Role
------------+----------+--------
my_new_user | Internal | Regular
```

## Log-in to the WEKA cluster

Authenticates to the cluster and saves a login token, so later commands run without prompting.

**Command:** `weka user login`

```sh
weka user login [<username>] [<password>] [--path <string>] [--tenant <string>]
```

**Parameters**

| Parameter                  | Description                                                                                                                                                                                                                                                                                                                                                     |
| --- | --- |
| `username` | Username of user for authentication. Can be supplied in the envrionment as 'WEKA\_USERNAME'. Prompted for if not set. |
| `password` | Password of the user to authenticate as. Can be supplied in the environment as 'WEKA\_PASSWORD'. Prompted for if not set. |
| `-p`, `--path` \<string> | The path where the login token will be saved. This path can also be specified using the WEKA\_TOKEN environment variable. After logging in, use the WEKA\_TOKEN environment variable to specify where the login token is located. Deprecated: Use of profiles is a better solution, or use the weka user generate-token command to create a suitable API token. default: ~/.weka/auth-token.json). This path can also be specified using the WEKA_TOKEN environment variable. After logging-in, use the WEKA_TOKEN environment variable to specify where the login token is located |
| `-g`, `--tenant` \<string> | Tenant where the user is located. |

{% hint style="success" %}
**Manage authentication tokens in WEKA**

The `--path` parameter is used to control the directory and file where the authentication token is written. The specified path, which includes the filename, can then be assigned to the `WEKA_TOKEN` environment variable.

**Example 1: Using the `--path` parameter**

The following example demonstrates how to log in and specify the path for the authentication token. After logging in, the path is set to the `WEKA_TOKEN` environment variable.

```sh
weka user login user1 password1 --path /home/user1/.weka/user1-token.json
export WEKA_TOKEN=/home/user1/.weka/user1-token.json
```

**Example 2: Using the `WEKA_TOKEN` environment variable**

Alternatively, you can set the `WEKA_TOKEN` environment variable first, which removes the need to use the `--path` parameter during the login process.

```sh
export WEKA_TOKEN=/home/user1/.weka/user1-token.json
weka user login user1 password1
```
{% endhint %}

**Related topic**

[obtain-authentication-tokens.md](../../security/obtain-authentication-tokens.md "mention")

## Change a local user password

Changes a local user's password.

**Command:** `weka user passwd`

```sh
weka user passwd [<password>] [--current-password <string>] [--username <username>]
```

**Parameters**

| Parameter                      | Description                                                                                                                                                                                                                         |
| --- | --- |
| `password` | New password. Must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping. |
| `--current-password` \<string> | Current password. Only required when changing the current user's own password. |
| `--username` \<username> | User to change the password for. Defaults to the currently logged-in user. |

{% hint style="info" %}
* If necessary, provide or set`WEKA_USERNAME` or `WEKA_PASSWORD.`
* To regain access to the system after changing the password, the user must re-authenticate using the new password.
{% endhint %}

### Reset your own S3 credentials

Reset the S3 API credentials for your user account by generating a new access key and secret key.

**Before you begin**

Confirm that you have existing S3 credentials. If you also need to reset your WEKA account password, note that the two operations are independent. Resetting your WEKA account password does not affect S3 credentials.

**Procedure**

1. Run the following command:

```bash
weka s3 user keys-generate
```

2. At the prompt, review the message and type `yes` to confirm, or `no` to cancel.

The system generates and displays a new access key and secret key for your S3 API access.

**Result**

Your new S3 credentials are displayed. Store the secret key securely, as it is not retrievable after the session ends.

## Revoke user access

Revokes all of a user's login tokens, forcing the user to authenticate again.

**Command:** `weka user revoke-tokens`

```sh
weka user revoke-tokens <username>
```

**Parameters**

| Parameter    | Description                                        |
| --- | --- |
| `username`\* | Username of the user whose tokens will be revoked. |

{% hint style="warning" %}
NFS and SMB are different protocols from WekaFS, which require additional security considerations when used. For example, The system grants NFS permissions per server. Therefore, manage the permissions for accessing these servers for NFS export carefully.
{% endhint %}

## Update a local user

Changes a local user's role or password policy.

**Command:** `weka user update`

```sh
weka user update <username> [--posix-gid <uint32>] [--posix-uid <uint32>] [--role <user-role>]
```

**Parameters**

| Parameter               | Description                                |
| --- | --- |
| `username`\* | Username of user to update. |
| `--posix-gid` \<uint32> | POSIX group ID for user. Used for S3 only. |
| `--posix-uid` \<uint32> | POSIX user ID for user. Used for S3 only. |
| `--role` \<user-role> | New role to set for the user. Possible values: `regular`, `s3`,`readonly`, `tenantadmin` or `clusteradmin` |

## Delete a local user

Deletes a local user from the cluster.

**Command:** `weka user remove`

```sh
weka user remove <username>
```

**Parameters**

| Parameter    | Description                 |
| --- | --- |
| `username`\* | Username of user to delete. |

{% hint style="success" %}
**Example:**

`$ weka user add my_new_user`

Then run the`weka user` command to verify that the user was deleted:

```
$ weka user
Username | Source   | Role
---------+----------+------
admin    | Internal | Admin
```
{% endhint %}

## Authenticate users from an LDAP user directory

To authenticate users from an LDAP user directory, the LDAP directory must first be configured to the Weka system. This is performed as follows.

### Configure an LDAP user directory

Configures the LDAP directory the cluster authenticates users against. Use `setup` for a generic LDAP server and `setup-ad` for Active Directory.

**Command:** `weka user ldap setup`

```sh
weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> [<reader-password>] [--cluster-admin-group <string>] [--csi-group <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--protocol-version <uint>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--start-tls] [--tenant-admin-group <string>] [--user-revocation-attribute <string>] [--user-uuid-attribute <string>]
```

**Command:** `weka user ldap setup-ad`

```sh
weka user ldap setup-ad <server-uri> <domain> <reader-username> [<reader-password>] [--cluster-admin-group <string>] [--csi-group <string>] [--ignore-start-tls-failure] [--network-space-id <uint16>] [--readonly-group <string>] [--regular-group <string>] [--server-timeout-secs <duration>] [--start-tls] [--tenant-admin-group <string>] [--user-revocation-attribute <string>]
```

**Parameters**

| Parameter                               | Description                                                                                                               |
| --- | --- |
| `server-uri`\* | LDAP server URI. Format is either \[ldap://]hostname\[:port] or ldaps://hostname\[:port]. |
| `base-dn`\* | Base DN. |
| `user-object-class`\* | User object class. |
| `user-id-attribute`\* | User ID attribute. |
| `group-object-class`\* | Group object class. |
| `group-membership-attribute`\* | Group membership attribute. |
| `group-id-attribute`\* | Group ID attribute. |
| `reader-username`\* | Reader username. |
| `reader-password` | Reader password. If omitted, you will be prompted. |
| `--cluster-admin-group` \<string> | ClusterAdmin LDAP group. Users in this group are assigned the ClusterAdmin role. Only available for the root tenant. |
| `--csi-group` \<string> | CSI LDAP group. Users in this group are assigned the CSI role. |
| `--ignore-start-tls-failure` | Ignore StartTLS failure. If StartTLS fails, the connection will not use encryption. Possible values: `yes` or `no` |
| `--network-space-id` \<uint16> | Network space ID in which to run LDAP queries. Defaults to the host network namespace. |
| `--protocol-version` \<uint> | LDAP protocol version. Possible values: `LDAP v2` or `LDAP v3` |
| `--readonly-group` \<string> | ReadOnly LDAP group. Users in this group are assigned the ReadOnly role. |
| `--regular-group` \<string> | Regular LDAP group. Users in this group are assigned the Regular role. |
| `--server-timeout-secs` \<duration> | LDAP server connection timeout, specified in seconds. |
| `--start-tls` | Issue StartTLS after connecting. URL should not be used with ldaps://. Possible values: `yes` or `no`Do not use with `ldaps://` |
| `--tenant-admin-group` \<string> | TenantAdmin LDAP group. Users in this group are assigned the TenantAdmin role. |
| `--user-revocation-attribute` \<string> | User revocation attribute. If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `--user-uuid-attribute` \<string> | User UUID attribute. |
| `domain`\* | Active Directory domain for principals. |

{% hint style="info" %}
The `sAMAccountName` (user logon name) for roles such as Cluster Admin, Tenant Admin, Regular User, and Read-only User is limited to 20 characters.
{% endhint %}

### View a configured LDAP User Directory

Shows the configured LDAP user directory and its current settings.

**Command:** `weka user ldap`

```sh
weka user ldap
```

### Disable or enable a configured LDAP user directory

Turns LDAP authentication off or back on without discarding the directory configuration.

**Command:** `weka user ldap disable`

```sh
weka user ldap disable [--force]
```

**Command:** `weka user ldap enable`

```sh
weka user ldap enable
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

{% hint style="info" %}
You can only disable an LDAP configuration, but not delete it.
{% endhint %}
