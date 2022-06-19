---
description: >-
  This page describes the management of users licensed to work with the Weka
  system.
---

# User management

## User types

Access to a Weka system cluster is controlled by creating, modifying, and deleting users. Up to 512 local users can be defined to work with a Weka system cluster. Each user is identified by a username and must provide a password for authentication to work with the Weka system GUI or CLI.

Every Weka system user has one of the following defined roles:

* **Cluster Admin**: A user with additional privileges, as described in [Cluster Admin Role Privileges](user-management.md#admin-role-privileges) below.
* **Organization Admin**: A user with additional privileges within an organization (when working with different organizations, as described in [Organization Admin Role Privileges](organizations/#organization-admin-role-privileges)).
* **Read-only:** A user with read-only privileges.
* **S3:** A user to run S3 commands and APIs. This user can operate within the limits of the S3 IAM policy attached to it.
* **Regular**: A user that should only be able to mount filesystems
  * can log-in to obtain an access token
  * can change their password
  * cannot access the UI or run other CLI/API commands

## Cluster admin-the first user

By default, when a Weka cluster is created, a first user with an `admin` username and password is created. This user has a Cluster Admin role, which allows the running of all commands.

Cluster Admin users are responsible for managing the cluster as a whole. When using multiple organizations, there is a difference between managing a single organization and managing the cluster because managing the cluster also covers the management of the cluster hardware and resources. These are the additional permissions given to a Cluster Admin in comparison to an Organization Admin.

A Cluster Admin user is created because a Weka system cluster must have at least one defined Admin user. However, it is possible to create a user with a different name and delete the default admin user, if required.

## Cluster admin role privileges

Cluster Admin users have additional privileges over regular users. These include the ability to:

* Create new users
* Delete existing users
* Change user passwords
* Set user roles
* Manage LDAP configurations
* Manage organizations

Additionally, the following restrictions are implemented for Cluster Admin users, to avoid situations where a Cluster Admin loses access to a Weka system cluster:

* Cluster Admins cannot delete themselves.
* Cluster Admins cannot change their role to a regular user role.

## Manage users

### Create users

**Command:** `weka user add`

Use the following command line to create a local user:

`weka user add <username> <role> [password] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

| **Name**    | **Type** | **Value**                                                                                          | **Limitations**                                           | **Mandatory** | **Default**                                                 |
| ----------- | -------- | -------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | ------------- | ----------------------------------------------------------- |
| `username`  | String   | Name for the new user                                                                              |                                                           | Yes           |                                                             |
| `role`      | String   | Role of the new created user                                                                       | `regular`,  `s3`,`readonly`, `orgadmin` or `clusteradmin` | Yes           |                                                             |
| `password`  | String   | New user password                                                                                  |                                                           | No            | If not supplied, command will prompt to supply the password |
| `posix-uid` | Number   | POSIX UID of underlying files representing objects created by this S3 user access/keys credentials | For S3 user roles only                                    | No            | 0                                                           |
| `posix-gid` | Number   | POSIX GID of underlying files representing objects created by this S3 user access/keys credentials | For S3 user roles only                                    | No            | 0                                                           |

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

### Change users passwords

**Command:** `weka user passwd`

Use the following command line to change a local user password:

`weka user passwd <password> [--username username]`

**Parameters**

| **Name**   | **Type** | **Value**                                   | **Limitations**            | **Mandatory** | **Default**            |
| ---------- | -------- | ------------------------------------------- | -------------------------- | ------------- | ---------------------- |
| `password` | String   | New password                                |                            | Yes           |                        |
| `username` | String   | Name of the user to change the password for | Must be a valid local user | No            | Current logged-in user |

{% hint style="info" %}
**Note:** If necessary, provide or set`WEKA_USERNAME` or `WEKA_PASSWORD.`
{% endhint %}

### Update users

**Command:** `weka user update`

Use the following command line to update a local user:

`weka user update <username> [--role role] [--posix-uid uid] [--posix-gid gid]`

**Parameters**

| **Name**    | **Type** | **Value**                                                                                          | **Limitations**                                           | **Mandatory** | **Default** |
| ----------- | -------- | -------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | ------------- | ----------- |
| `username`  | String   | Name of an existing user                                                                           | Must be a valid local user                                | Yes           |             |
| `role`      | String   | Updated user role                                                                                  | `regular`,  `s3`,`readonly`, `orgadmin` or `clusteradmin` | No            |             |
| `posix-uid` | Number   | POSIX UID of underlying files representing objects created by this S3 user access/keys credentials | For S3 user roles only                                    | No            |             |
| `posix-gid` | Number   | POSIX GID of underlying files representing objects created by this S3 user access/keys credentials | For S3 user roles only                                    | No            |             |

### Delete users

**Command:** `weka user delete`

To delete a user, use the following command line:

`weka user delete <username>`

**Parameters**

| **Name**   | **Type** | **Value**                  | **Limitations**            | **Mandatory** | **Default** |
| ---------- | -------- | -------------------------- | -------------------------- | ------------- | ----------- |
| `username` | String   | Name of the user to delete | Must be a valid local user | Yes           |             |

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

## User sign in

When a login is attempted, the user is first searched in the list of internal users, i.e., users created using the`weka user add` command.

However, if a user does not exist in the Weka system but does exist in an LDAP directory, it is possible to [configure the LDAP user directory](user-management.md#configuring-an-ldap-user-directory) to the Weka system. This will enable a search for the user in the directory, followed by password verification.

On each successful login, a `UserLoggedIn` event is issued, containing the username, role and whether the user is an internal or LDAP user.

When a login fails, an "Invalid username or password" message is displayed and a `UserLoginFailed` event is issued, containing the username and the reason for the login failure.

When users open the GUI, they are prompted to provide their username and password. To pass username and password to the CLI, use the `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables.

Alternatively, it is possible to log into the CLI as a specific user using the`weka user login <username> <password>`command. This will run each CLI command from that user. When a user logs in, a token file is created to be used for authentication (default to `~/.weka/auth-token.json`, which can be changed using the `--path` attribute). To see the logged-in CLI user, run the`weka user whoami` command.

{% hint style="info" %}
**Note:** The`weka user login` command is persistent, but only applies to the host on which it was set.
{% endhint %}

{% hint style="info" %}
**Note:** If the`WEKA_USERNAME`/`WEKA_PASSWORD` environment variables are not specified, the CLI uses the default token file. If no CLI user is explicitly logged-in, and no token file is present the CLI uses the default `admin`/`admin`.

To use a non-default path for the token file, use the `WEKA_TOKEN` environment variable.
{% endhint %}

## Authenticate users from an LDAP user directory

To authenticate users from an LDAP user directory, the LDAP directory must first be configured to the Weka system. This is performed as follows.

### Configuring an LDAP user directory

**Command:**\
`weka user ldap setup`  \
`weka user ldap setup-ad`

One of two CLI commands is used to configure an LDAP user directory for user authentication. The first is for configuring a general LDAP server and the second is for configuring an Active Directory server.

To configure an LDAP server, use the following command line:

`weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> <reader-password> <cluster-admin-group> <org-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--protocol-version protocol-version] [--user-revocation-attribute user-revocation-attribute]`

To configure an Active Directory server, use the following command line:

`weka user ldap setup-ad <server-uri> <domain> <reader-username> <reader-password> <cluster-admin-group> <org-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--user-revocation-attribute user-revocation-attribute]`

**Parameters in command line**

| **Name**                                | **Type** | **Value**                                                                                                   | **Limitations**                                                                                                                                  | **Mandatory** | **Default** |
| --------------------------------------- | -------- | ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ----------- |
| `server-uri`                            | String   | Either the LDAP server host name/IP or a URI                                                                | URI must be in format `ldap://hostname:port` or `ldaps://hostname:port`                                                                          | Yes           |             |
| `base-dn`                               | String   | Base DN under which users are stored                                                                        | Must be valid name                                                                                                                               | Yes           |             |
| `user-id-attribute`                     | String   | Attribute storing user IDs                                                                                  | Must be valid name                                                                                                                               | Yes           |             |
| `user-object-class`                     | String   | Object class of users                                                                                       | Must be valid name                                                                                                                               | Yes           |             |
| `group-object-class`                    | String   | Object class of groups                                                                                      | Must be valid name                                                                                                                               | Yes           |             |
| `group-membership-attribute`            | String   | Attribute of group containing the DN of a user membership in the group                                      | Must be valid name                                                                                                                               | Yes           |             |
| `group-id-attribute`                    | String   | Attribute storing the group name                                                                            | Name has to match names used in the `<admin-group>`, `<regular group>` and `<readonly group>`                                                    | Yes           |             |
| `reader-username` and `reader-password` | String   | Credentials of a user with read access to the directory                                                     | Password is kept in the Weka cluster configuration in plain text, as it is used to authenticate against the directory during user authentication | Yes           |             |
| `cluster-admin-group`                   | String   | Name of group containing users defined with cluster admin role                                              | Must be valid name                                                                                                                               | Yes           |             |
| `org-admin-group`                       | String   | Name of group containing users defined with organization admin role                                         | Must be valid name                                                                                                                               | Yes           |             |
| `regular-group`                         | String   | Name of group containing users defined with regular privileges                                              | Must be valid name                                                                                                                               | Yes           |             |
| `readonly-group`                        | String   | Name of group containing users defined with read only privileges                                            | Must be valid name                                                                                                                               | Yes           |             |
| `server-timeout-secs`                   | Number   | Server connection timeout                                                                                   | Seconds                                                                                                                                          | No            |             |
| `protocol-version`                      | String   | Selection of LDAP version                                                                                   | LDAP v2 or v3                                                                                                                                    | No\`          | LDAP v3     |
| `user-revocation-attribute`             | String   | The LDAP attribute; when its value  changes in the LDAP directory, user access and mount tokens are revoked | User must re-login after a change is detected                                                                                                    | No            |             |
| `start-tls`                             | String   | Issue StartTLS after connecting                                                                             | <p><code>yes</code> or <code>no</code></p><p>should not be used with <code>ldaps://</code> </p><p></p>                                           | No            | `no`        |
| `ignore-start-tls-failure`              | String   | Ignore start TLS failure                                                                                    | `yes` or `no`                                                                                                                                    | No            | `no`        |

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
**Note:** It is not possible to delete an LDAP configuration; only disable it.
{% endhint %}
