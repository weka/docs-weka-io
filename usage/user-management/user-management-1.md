---
description: >-
  Explore the management of users licensed to work with the WEKA system using
  the CLI.
---

# Manage users using the CLI

## User login **process** overview

In the WEKA user login process (sign-in), the following steps outline the authentication and user management:

* **Local user login:** When users log in, the system initially searches for them within the list of local users (internal users), specifically those created using the `weka user add` command.
* **LDAP integration: i**n cases where a user isn't internally registered but exists in an LDAP directory, there's an option to integrate the LDAP user directory with the WEKA system. This integration allows the system to search for the user in the directory and perform password verification.
* **Login events:** Successful logins trigger a `UserLoggedIn` event, providing essential details such as the username, role, and user type (internal or LDAP). On the other hand, unsuccessful logins prompt an "Invalid username or password" message and trigger a `UserLoginFailed`event containing the username and the reason for the failure.
* **GUI login:** The GUI login process requires users to input their username and password. Users can leverage the WEKA\_USERNAME and WEKA\_PASSWORD environment variables to pass this information to the CLI.
* **CLI login:** Users can log in with a specific identity using the `weka user login <username> <password>` command for CLI access. This establishes the user context for each subsequent CLI command. Upon logging in, a token file is generated for authentication, with the default path set to `~/.weka/auth-token.json` (adjustable using the `--path` attribute). You can use the `weka user whoami` command to check the currently logged-in CLI user.
* **Persistence and defaults:** The persistence of the `weka user login` command applies only to the server where it is set. If `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables are unspecified, the CLI defaults to the token file. In cases where no CLI user is explicitly logged in, and no token file is present, the CLI resorts to the default 'admin/admin' credentials.
* **Custom token file path:** Users who prefer a non-default path for the token file can use the `WEKA_TOKEN` environment variable.

To perform various operations through the CLI, you can:

* [Create a local user](user-management-1.md#create-a-local-user)
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

<table><thead><tr><th width="193.33333333333331">Name</th><th width="426">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>Name for the new user</td><td></td></tr><tr><td><code>role</code></td><td>Role of the new created user.<br>Possible values: <code>regular</code>,  <code>s3</code>,<code>readonly</code>, <code>orgadmin</code> or <code>clusteradmin</code></td><td></td></tr><tr><td><code>password</code></td><td>New user password.<br>If not supplied, the command prompts to supply the password.</td><td></td></tr><tr><td><code>posix-uid</code></td><td>POSIX UID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td><td>0</td></tr><tr><td><code>posix-gid</code></td><td>POSIX GID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td><td>0</td></tr></tbody></table>

{% hint style="success" %}
**Example:**

`$ weka user add my_new_user regular S3cret`

This command line creates a user with a username of `my_new_user`, a password of `S3cret` and a role of a Regular user. It is then possible to display a list of users and verify that the user was created:

```
$ weka user
Username    | Source   | Role
------------+----------+--------
my_new_user | Internal | Regular
admin       | Internal | Admin
```
{% endhint %}

Using the `weka user whoami` command, it is possible to receive information about the current user running the command.

To use the new user credentials, use the`WEKA_USERNAME` and `WEKA_PASSWORD`environment variables:

```
$ WEKA_USERNAME=my_new_user WEKA_PASSWORD=S3cret weka user whoami
Username    | Source   | Role
------------+----------+--------
my_new_user | Internal | Regular
```

## Change a local user password

**Command:** `weka user passwd`

Use the following command line to change a local user password:

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

<table><thead><tr><th width="176">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>A valid user in the organization of the Organization Admin running the command.</td></tr></tbody></table>

{% hint style="warning" %}
NFS and SMB are different protocols from WekaFS, which require additional security considerations when used. For example, The system grants NFS permissions per server. Therefore, manage the permissions for accessing these servers for NFS export carefully.
{% endhint %}

## Update a local user

**Command:** `weka user update`

Use the following command line to update a local user:

`weka user update <username> [--role role] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

<table><thead><tr><th width="181">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>Name of an existing user.<br>It must be a valid local user.</td></tr><tr><td><code>role</code></td><td>Updated user role.<br>Possible values: <code>regular</code>,  <code>s3</code>,<code>readonly</code>, <code>orgadmin</code> or <code>clusteradmin</code></td></tr><tr><td><code>posix-uid</code></td><td>POSIX UID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td></tr><tr><td><code>posix-gid</code></td><td>POSIX GID of underlying files representing objects created by this S3 user access/keys credentials.<br>For S3 user roles only.</td></tr></tbody></table>

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
`weka user ldap setup`  \
`weka user ldap setup-ad`

One of two CLI commands is used to configure an LDAP user directory for user authentication. The first is for configuring a general LDAP server and the second is for configuring an Active Directory server.

To configure an LDAP server, use the following command line:

`weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> <reader-password> <cluster-admin-group> <org-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--protocol-version protocol-version] [--user-revocation-attribute user-revocation-attribute]`

To configure an Active Directory server, use the following command line:

`weka user ldap setup-ad <server-uri> <domain> <reader-username> <reader-password> <cluster-admin-group> <org-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--user-revocation-attribute user-revocation-attribute]`

**Parameters**

<table><thead><tr><th width="281">Name</th><th width="333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>server-uri</code>*</td><td>Either the LDAP server hostname/IP or a URI.<br>Format: <code>ldap://hostname:port</code> or <code>ldaps://hostname:port</code></td><td></td></tr><tr><td><code>base-dn</code>*</td><td>Base DN under which users are stored.<br>It must be a valid name.</td><td></td></tr><tr><td><code>user-id-attribute</code>*</td><td>Attribute storing user IDs.<br>It must be a valid name.</td><td></td></tr><tr><td><code>user-object-class</code>*</td><td>Object class of users.<br>It must be a valid name.</td><td></td></tr><tr><td><code>group-object-class</code>*</td><td>Object class of groups.<br>It must be a valid name.</td><td></td></tr><tr><td><code>group-membership-attribute</code>*</td><td>Attribute of group containing the DN of a user membership in the group.<br>It must be a valid name.</td><td></td></tr><tr><td><code>group-id-attribute</code>*</td><td>Attribute storing the group name.<br>The name must match the names used in the <code>&#x3C;admin-group></code>, <code>&#x3C;regular group></code> and <code>&#x3C;readonly group></code></td><td></td></tr><tr><td><code>reader-username</code> and <code>reader-password</code>*</td><td>Credentials of a user with read access to the directory.<br>The password is kept in the Weka cluster configuration in plain text, as it is used to authenticate against the directory during user authentication.</td><td></td></tr><tr><td><code>cluster-admin-group</code>*</td><td>Name of group containing users defined with cluster admin role.<br>It must be a valid name.</td><td></td></tr><tr><td><code>org-admin-group</code>*</td><td>Name of group containing users defined with organization admin role.<br>It must be a valid name.</td><td></td></tr><tr><td><code>regular-group</code>*</td><td>Name of group containing users defined with regular privileges.<br>It must be a valid name.</td><td></td></tr><tr><td><code>readonly-group</code>*</td><td>Name of group containing users defined with read only privileges.<br>It must be a valid name.</td><td></td></tr><tr><td><code>server-timeout-secs</code></td><td>Server connection timeout in seconds.</td><td></td></tr><tr><td><code>protocol-version</code></td><td>Selection of LDAP version.<br>Possible values: <code>LDAP v2</code> or <code>LDAP v3</code></td><td><code>LDAP v3</code></td></tr><tr><td><code>user-revocation-attribute</code></td><td>The LDAP attribute; when its value  changes in the LDAP directory, user access and mount tokens are revoked.<br>UThe user must re-login after a change is detected.</td><td></td></tr><tr><td><code>start-tls</code></td><td>Issue StartTLS after connecting.<br>Possible values: <code>yes</code> or <code>no</code><br>Do not use with <code>ldaps://</code> </td><td><code>no</code></td></tr><tr><td><code>ignore-start-tls-failure</code></td><td>Ignore start TLS failure.<br>Possible values: <code>yes</code> or <code>no</code></td><td><code>no</code></td></tr></tbody></table>

### View a configured LDAP User Directory

**Command:**\
`weka user ldap`

This command is used for viewing the current LDAP configuration used for authenticating users.&#x20;

### Disable or enable a configured LDAP user directory

**Command:**\
`weka user ldap disable`  \
`weka user ldap enable`

These commands are used for disabling or enabling user authentication through a configured LDAP user directory.

{% hint style="info" %}
You can only disable an LDAP configuration, but not delete it.
{% endhint %}
