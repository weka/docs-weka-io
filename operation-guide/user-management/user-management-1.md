---
description: >-
  Explore the CLI to perform a broader range of user management tasks, including
  creating, updating, and deleting local users, managing access, and
  authenticating users through the LDAP or AD directory.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/operation-guide/user-management/user-management-1
---

# Manage users using the CLI

Using the CLI, you can:

* [Create a local user](user-management-1.md#create-a-local-user)
* [Log-in to the WEKA cluster](user-management-1.md#log-in-to-the-weka-cluster)
* [Change a local user password](user-management-1.md#change-a-local-user-password)
* [Revoke user access](user-management-1.md#revoke-user-access)
* [Update a local user](user-management-1.md#update-a-local-user)
* [Delete a local user](user-management-1.md#delete-a-local-user)
* [Authenticate users from an LDAP user directory](user-management-1.md#authenticate-users-from-an-ldap-user-directory)

## Create a local user

**Command:** `weka user add`

Use the following command line to create a local user:

`weka user add <username> <role> [password] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

<table><thead><tr><th width="193.33333333333331">Name</th><th width="426">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>Name for the new user</td><td></td></tr><tr><td><code>role</code></td><td>Role of the new created user.<br>Possible values: <code>clusteradmin</code>, <code>csi</code>, <code>tenantadmin</code>, <code>readonly</code>, <code>regular</code>, <code>s3</code></td><td></td></tr><tr><td><code>password</code></td><td>New user password.<br>If not supplied, the command prompts to supply the password.</td><td></td></tr><tr><td><code>posix-uid</code></td><td>POSIX UID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td><td>0</td></tr><tr><td><code>posix-gid</code></td><td>POSIX GID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td><td>0</td></tr></tbody></table>

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

<table><thead><tr><th>Name</th><th width="389.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>password</code>*</td><td>New password</td><td></td></tr><tr><td><code>username</code></td><td>Name of the user to change the password for.<br>It must be a valid local user.</td><td>The current logged-in user</td></tr></tbody></table>

{% hint style="info" %}
* If necessary, provide or set`WEKA_USERNAME` or `WEKA_PASSWORD.`
* To regain access to the system after changing the password, the user must re-authenticate using the new password.
{% endhint %}

## Revoke user access

**Command:** `weka user revoke-tokens`

Use the following command to revoke internal user access to the system and mounting filesystems:

`weka user revoke-tokens <username>`

You can revoke the access for LDAP users by changing the `user-revocation-attribute` defined in the LDAP server configuration.

**Parameters**

<table><thead><tr><th width="176">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>A user with valid credentials within the Tenant Admin's domain executing the command.</td></tr></tbody></table>

{% hint style="warning" %}
NFS and SMB are different protocols from WekaFS, which require additional security considerations when used. For example, The system grants NFS permissions per server. Therefore, manage the permissions for accessing these servers for NFS export carefully.
{% endhint %}

## Update a local user

**Command:** `weka user update`

Use the following command line to update a local user:

`weka user update <username> [--role role] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

<table><thead><tr><th width="181">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>Name of an existing user.<br>It must be a valid local user.</td></tr><tr><td><code>role</code></td><td>Updated user role.<br>Possible values: <code>regular</code>, <code>s3</code>,<code>readonly</code>, <code>tenantadmin</code> or <code>clusteradmin</code></td></tr><tr><td><code>posix-uid</code></td><td>POSIX UID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td></tr><tr><td><code>posix-gid</code></td><td>POSIX GID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td></tr></tbody></table>

## Delete a local user

**Command:** `weka user delete`

To delete a user, use the following command line:

`weka user delete <username>`

**Parameters**

<table><thead><tr><th width="188">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>Name of the user to delete.<br>It must be a valid local user.</td></tr></tbody></table>

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

<table><thead><tr><th width="281">Name</th><th width="333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>server-uri</code>*</td><td>Either the LDAP server hostname/IP or a URI.<br>Format: <code>ldap://hostname:port</code> or <code>ldaps://hostname:port</code></td><td></td></tr><tr><td><code>base-dn</code>*</td><td>Base DN under which users are stored.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>user-id-attribute</code>*</td><td>Attribute storing user IDs.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>user-object-class</code>*</td><td>Object class of users.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>group-object-class</code>*</td><td>Object class of groups.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>group-membership-attribute</code>*</td><td>Attribute of group containing the DN of a user membership in the group.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>group-id-attribute</code>*</td><td>Attribute storing the group name.<br>The name must match the names used in the <code>&#x3C;admin-group></code>, <code>&#x3C;regular group></code> and <code>&#x3C;readonly group></code></td><td></td></tr><tr><td><code>reader-username</code> and <code>reader-password</code>*</td><td>Credentials of a user with read access to the directory.<br>The password is kept in the Weka cluster configuration in plain text, as it is used to authenticate against the directory during user authentication.</td><td></td></tr><tr><td><code>cluster-admin-group</code>*</td><td>Group name for Users with Cluster Admin role.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>tenant-admin-group</code>*</td><td>Tenant Admin Group Name.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>regular-group</code>*</td><td>Name of group containing users defined with regular privileges.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>readonly-group</code>*</td><td>Name of group containing users defined with read only privileges.<br>Ensure the name is valid.</td><td></td></tr><tr><td><code>server-timeout-secs</code></td><td>Server connection timeout in seconds.</td><td></td></tr><tr><td><code>protocol-version</code></td><td>Selection of LDAP version.<br>Possible values: <code>LDAP v2</code> or <code>LDAP v3</code></td><td><code>LDAP v3</code></td></tr><tr><td><code>user-revocation-attribute</code></td><td>The LDAP attribute; when its value changes in the LDAP directory, user access and mount tokens are revoked.<br>The user must re-login after a change is detected.</td><td></td></tr><tr><td><code>start-tls</code></td><td>Issue StartTLS after connecting.<br>Possible values: <code>yes</code> or <code>no</code><br>Do not use with <code>ldaps://</code></td><td><code>no</code></td></tr><tr><td><code>ignore-start-tls-failure</code></td><td>Ignore start TLS failure.<br>Possible values: <code>yes</code> or <code>no</code></td><td><code>no</code></td></tr></tbody></table>

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
