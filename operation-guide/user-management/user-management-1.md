---
description: >-
  Manage local users, authentication tokens, and LDAP or Active Directory
  directories using the CLI.
---

# Manage users using the CLI

## Create a local user

**Command:** `weka user add`

Use the following command line to create a local user:

`weka user add <username> <role> [password] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

| Name         | Value                                                                                                                      | Default |
| ------------ | -------------------------------------------------------------------------------------------------------------------------- | ------- |
| `username`\* | Name for the new user                                                                                                      |         |
| `role`       | Role of the new created user.Possible values: `clusteradmin`, `csi`, `tenantadmin`, `readonly`, `regular`, `s3`            |         |
| `password`   | New user password.If not supplied, the command prompts to supply the password.                                             |         |
| `posix-uid`  | POSIX UID of underlying files representing objects created by this S3 user access/keys credentials.For S3 user roles only. | 0       |
| `posix-gid`  | POSIX GID of underlying files representing objects created by this S3 user access/keys credentials.For S3 user roles only. | 0       |

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

**Command:** `weka user login`

Use the following command to log a user into the WEKA cluster. If login is successful, the user credentials are saved to the user's home directory.

`weka user login [username] [password] [--tenant tenant] [--path path]`

**Parameters**

<table><thead><tr><th width="175">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>User's username</td></tr><tr><td><code>password</code>*</td><td>User's password</td></tr><tr><td><code>tenant</code></td><td>Tenant name or ID</td></tr><tr><td><code>path</code></td><td><p>The path where the login token will be saved (default: ~/.weka/auth-token.json). This path can also be specified using the WEKA_TOKEN environment variable.</p><p>After logging-in, use the WEKA_TOKEN environment variable to specify where the login token is located.</p></td></tr></tbody></table>

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

**Command:** `weka user passwd`

Use the following command to change a local user password:

`weka user passwd <password> [--username username]`

**Parameters**

| Name         | Value                                                                      | Default                    |
| ------------ | -------------------------------------------------------------------------- | -------------------------- |
| `password`\* | New password                                                               |                            |
| `username`   | Name of the user to change the password for.It must be a valid local user. | The current logged-in user |

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

**Command:** `weka user revoke-tokens`

Use the following command to revoke internal user access to the system and mounting filesystems:

`weka user revoke-tokens <username>`

You can revoke the access for LDAP users by changing the `user-revocation-attribute` defined in the LDAP server configuration.

**Parameters**

| Name         | Value                                                                                 |
| ------------ | ------------------------------------------------------------------------------------- |
| `username`\* | A user with valid credentials within the Tenant Admin's domain executing the command. |

{% hint style="warning" %}
NFS and SMB are different protocols from WekaFS, which require additional security considerations when used. For example, The system grants NFS permissions per server. Therefore, manage the permissions for accessing these servers for NFS export carefully.
{% endhint %}

## Update a local user

**Command:** `weka user update`

Use the following command line to update a local user:

`weka user update <username> [--role role] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

| Name         | Value                                                                                                                      |
| ------------ | -------------------------------------------------------------------------------------------------------------------------- |
| `username`\* | Name of an existing user.It must be a valid local user.                                                                    |
| `role`       | Updated user role.Possible values: `regular`, `s3`,`readonly`, `tenantadmin` or `clusteradmin`                             |
| `posix-uid`  | POSIX UID of underlying files representing objects created by this S3 user access/keys credentials.For S3 user roles only. |
| `posix-gid`  | POSIX GID of underlying files representing objects created by this S3 user access/keys credentials.For S3 user roles only. |

## Delete a local user

**Command:** `weka user remove`

To delete a user, use the following command line:

`weka user remove <username>`

**Parameters**

| Name         | Value                                                     |
| ------------ | --------------------------------------------------------- |
| `username`\* | Name of the user to delete.It must be a valid local user. |

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

**Command:**\
`weka user ldap setup`\
`weka user ldap setup-ad`

One of two CLI commands is used to configure an LDAP user directory for user authentication. The first is for configuring a general LDAP server and the second is for configuring an Active Directory server.

To configure an LDAP server, use the following command line:

`weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> <reader-password> <cluster-admin-group> <tenant-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--protocol-version protocol-version] [--user-revocation-attribute user-revocation-attribute]`

To configure an Active Directory server, use the following command line:

`weka user ldap setup-ad <server-uri> <domain> <reader-username> <reader-password> <cluster-admin-group> <tenant-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--user-revocation-attribute user-revocation-attribute]`

**Parameters**

| Name                                      | Value                                                                                                                                                                                                         | Default   |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `server-uri`\*                            | Either the LDAP server hostname/IP or a URI.Format: `ldap://hostname:port` or `ldaps://hostname:port`                                                                                                         |           |
| `base-dn`\*                               | Base DN under which users are stored.Ensure the name is valid.                                                                                                                                                |           |
| `user-id-attribute`\*                     | Attribute storing user IDs.Ensure the name is valid.                                                                                                                                                          |           |
| `user-object-class`\*                     | Object class of users.Ensure the name is valid.                                                                                                                                                               |           |
| `group-object-class`\*                    | Object class of groups.Ensure the name is valid.                                                                                                                                                              |           |
| `group-membership-attribute`\*            | Attribute of group containing the DN of a user membership in the group.Ensure the name is valid.                                                                                                              |           |
| `group-id-attribute`\*                    | Attribute storing the group name.The name must match the names used in the `&#x3C;admin-group>`, `&#x3C;regular group>` and `&#x3C;readonly group>`                                                           |           |
| `reader-username` and `reader-password`\* | Credentials of a user with read access to the directory.The password is kept in the Weka cluster configuration in plain text, as it is used to authenticate against the directory during user authentication. |           |
| `cluster-admin-group`\*                   | Group name for Users with Cluster Admin role.Ensure the name is valid.                                                                                                                                        |           |
| `tenant-admin-group`\*                    | Tenant Admin Group Name.Ensure the name is valid.                                                                                                                                                             |           |
| `regular-group`\*                         | Name of group containing users defined with regular privileges.Ensure the name is valid.                                                                                                                      |           |
| `readonly-group`\*                        | Name of group containing users defined with read only privileges.Ensure the name is valid.                                                                                                                    |           |
| `server-timeout-secs`                     | Server connection timeout in seconds.                                                                                                                                                                         |           |
| `protocol-version`                        | Selection of LDAP version.Possible values: `LDAP v2` or `LDAP v3`                                                                                                                                             | `LDAP v3` |
| `user-revocation-attribute`               | The LDAP attribute; when its value changes in the LDAP directory, user access and mount tokens are revoked.The user must re-login after a change is detected.                                                 |           |
| `start-tls`                               | Issue StartTLS after connecting.Possible values: `yes` or `no`Do not use with `ldaps://`                                                                                                                      | `no`      |
| `ignore-start-tls-failure`                | Ignore start TLS failure.Possible values: `yes` or `no`                                                                                                                                                       | `no`      |

{% hint style="info" %}
The `sAMAccountName` (user logon name) for roles such as Cluster Admin, Tenant Admin, Regular User, and Read-only User is limited to 20 characters.
{% endhint %}

### View a configured LDAP User Directory

**Command:**\
`weka user ldap`

This command is used for viewing the current LDAP configuration used for authenticating users.

### Disable or enable a configured LDAP user directory

**Command:**\
`weka user ldap disable`\
`weka user ldap enable`

These commands are used for disabling or enabling user authentication through a configured LDAP user directory.

{% hint style="info" %}
You can only disable an LDAP configuration, but not delete it.
{% endhint %}
