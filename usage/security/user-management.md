---
description: >-
  This page describes the management of users licensed to work with the Weka
  system.
---

# User Management

## Types of Users

Access to a Weka system cluster is controlled by creating, modifying and deleting users. Up to 128 local users can be defined to work with a Weka system cluster. Each user is identified by a username and must provide a password for authentication to work with the Weka system GUI or CLI.

Every Weka system user has one of the following defined roles:

* **Cluster Admin**: A user with additional privileges, as described in [Cluster Admin Role Privileges](user-management.md#admin-role-privileges) below.
* **Organization Admin**: A user with additional privileges within an organization \(when working with different organizations, as described in [Organization Admin Role Privileges](organizations.md#organization-admin-role-privileges)\).
* **Read-only:** A user with read-only privileges.
* **Regular**: A user that should only be able to mount filesystems
  * can log-in to obtain an access token
  * can change their password
  * cannot access the UI or run other CLI.API commands

## First User \(Cluster Admin\)

By default, when a Weka cluster is created, a first user with an `admin` username and password is created. This user has a Cluster Admin role, which allows the running of all commands.

Cluster Admin users are responsible for managing the cluster as a whole. When using multiple organizations, there is a difference between managing a single organization and managing the cluster because managing the cluster also covers the management of the cluster hardware and resources. These are the additional permissions given to a Cluster Admin in comparison to an Organization Admin.

A Cluster Admin user is created because a Weka system cluster must have at least one defined Admin user. However, it is possible to create a user with a different name and delete the default admin user, if required.

## Cluster Admin Role Privileges

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

## Managing Users

### Creating Users

**Command:** `weka user add`

Use the following command line to create a user:

`weka user add <username> <role> [password]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `username` | String | Name of the user to change the password for | Must be a valid local user | Yes |  |
| `role` | String | Role of the new created user | `regular`, `readonly`, `orgadmin` or `clusteradmin` | Yes |  |
| `password` | String | New password |  | No | If not supplied, command will prompt to supply the password |

{% hint style="success" %}
**For Example:**

`$ weka user add my_new_user S3cret regular`

This command line creates a user with a username of `my_new_user`, a password of `S3cret` and a role of Regular user. It is then possible to display a list of users and verify that the user was created:

```text
$ weka user
Username    | Source   | Role
------------+----------+--------
my_new_user | Internal | Regular
admin       | Internal | Admin
```
{% endhint %}

Using the `weka user whoami` command, it is possible to receive information about the current user running the command.

To use the new user credentials, use the`WEKA_USERNAME` and `WEKA_PASSWORD`environment variables:

```text
$ WEKA_USERNAME=my_new_user WEKA_PASSWORD=S3cret weka user whoami
Username    | Source   | Role
------------+----------+--------
my_new_user | Internal | Regular
```

### Changing Users Passwords

**Command:** `weka user passwd`

Use the following command line to change a local user password:

`weka user passwd <password> [--username username]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `password` | String | New password |  | Yes |  |
| `username` | String | Name of the user to change the password for | Must be a valid local user | No | Current logged-in user |

{% hint style="info" %}
**Note:** If necessary, provide or set`WEKA_USERNAME` or `WEKA_PASSWORD.`
{% endhint %}

### Deleting Users

**Command:** `weka user delete`

To delete a user, use the following command line:

`weka user delete <username>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `username` | String | Name of the user to delete | Must be a valid local user | Yes |  |

{% hint style="success" %}
**For Example:**

`$ weka user add my_new_user`

Then run the`weka user` command to verify that the user was deleted:

```text
$ weka user
Username | Source   | Role
---------+----------+------
admin    | Internal | Admin
```
{% endhint %}

## User Log In

When a login is attempted, the user is first searched in the list of internal users, i.e., users created using the`weka user add` command.

However, if a user does not exist in the Weka system but does exist in an LDAP directory, it is possible to [configure the LDAP user directory](user-management.md#configuring-an-ldap-user-directory) to the Weka system. This will enable a search for the user in the directory, followed by password verification.

On each successful login, a `UserLoggedIn` event is issued, containing the username, role and whether the user is an internal or LDAP user.

When a login fails, an "Invalid username or password" message is displayed and a `UserLoginFailed` event is issued, containing the username and the reason for the login failure.

When users open the GUI, they are prompted to provide their username and password. To pass username and password to the CLI, use the `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables.

Alternatively, it is possible to log into the CLI as a specific user using the`weka user login <username> <password>`command. This will run each CLI command from that user. When a user logs in, a token file is created to be used for authentication \(default to `~/.weka/auth-token.json`, which can be changed using the `--path` attribute\). To see the logged-in CLI user, run the`weka user whoami` command.

{% hint style="info" %}
**Note:** The`weka user login` command is persistent, but only applies to the host on which it was set.
{% endhint %}

{% hint style="info" %}
**Note:** If the`WEKA_USERNAME`/`WEKA_PASSWORD` environment variables are not specified, the CLI uses the default token file. If no CLI user is explicitly logged-in, and no token file is present the CLI uses the default `admin`/`admin`.

To use a non-default path for the token file, use the `WEKA_TOKEN` environment variable.
{% endhint %}

## Authenticating Users from an LDAP User Directory

To authenticate users from an LDAP user directory, the LDAP directory must first be configured to the Weka system. This is performed as follows.

### Configuring an LDAP User Directory

**Command:**  
`weka user ldap setup    
weka user ldap setup-ad`

One of two CLI commands is used to configure an LDAP user directory for user authentication. The first is for configuring a general LDAP server and the second is for configuring an Active Directory server.

To configure an LDAP server, use the following command line:

`weka user ldap setup <server-uri> <base-dn> <user-object-class> <user-id-attribute> <group-object-class> <group-membership-attribute> <group-id-attribute> <reader-username> <reader-password> <cluster-admin-group> <org-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--protocol-version protocol-version] [--user-revocation-attribute user-revocation-attribute]`

To configure an Active Directory server, use the following command line:

`weka user ldap setup-ad <server-uri> <domain> <reader-username> <reader-password> <cluster-admin-group> <org-admin-group> <regular-group> <readonly-group> [--start-tls start-tls] [--ignore-start-tls-failure ignore-start-tls-failure] [--server-timeout-secs server-timeout-secs] [--user-revocation-attribute user-revocation-attribute]`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>server-uri</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Either the LDAP server host name/IP or a URI</td>
      <td style="text-align:left">URI must be in format <code>ldap://hostname:port</code> or <code>ldaps://hostname:port</code>
      </td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>base-dn</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Base DN under which users are stored</td>
      <td style="text-align:left">Must be valid name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>user-id-attribute</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Attribute storing user IDs</td>
      <td style="text-align:left">Must be valid name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>user-object-class</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Object class of users</td>
      <td style="text-align:left">Must be valid name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>group-object-class</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Object class of groups</td>
      <td style="text-align:left">Must be valid name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>group-membership-attribute</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Attribute of group containing the DN of a user membership in the group</td>
      <td
      style="text-align:left">Must be valid name</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>group-id-attribute</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Attribute storing the group name</td>
      <td style="text-align:left">Name has to match names used in the <code>&lt;admin-group&gt;</code>, <code>&lt;regular group&gt;</code> and <code>&lt;readonly group&gt;</code>
      </td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>reader-username</code> and <code>reader-password</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Credentials of a user with read access to the directory</td>
      <td style="text-align:left">Password is kept in the Weka cluster configuration in plain text, as it
        is used to authenticate against the directory during user authentication</td>
      <td
      style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>cluster-admin-group</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Name of group containing users defined with cluster admin role</td>
      <td
      style="text-align:left">Must be valid name</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>org-admin-group</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Name of group containing users defined with organization admin role</td>
      <td
      style="text-align:left">Must be valid name</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>regular-group</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Name of group containing users defined with regular privileges</td>
      <td
      style="text-align:left">Must be valid name</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>readonly-group</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Name of group containing users defined with read only privileges</td>
      <td
      style="text-align:left">Must be valid name</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>server-timeout-secs</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Server connection timeout</td>
      <td style="text-align:left">Seconds</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>protocol-version</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Selection of LDAP version</td>
      <td style="text-align:left">LDAP v2 or v3</td>
      <td style="text-align:left">No`</td>
      <td style="text-align:left">LDAP v3</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>user-revocation-attribute</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The LDAP attribute; when its value changes in the LDAP directory, user
        access and mount tokens are revoked</td>
      <td style="text-align:left">User must re-login after a change is detected</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>start-tls</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Issue StartTLS after connecting</td>
      <td style="text-align:left">
        <p><code>yes</code> or <code>no</code>
        </p>
        <p>should not be used with <code>ldaps:// </code>
        </p>
        <p></p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"><code>no</code>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>ignore-start-tls-failure</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Ignore start TLS failure</td>
      <td style="text-align:left"><code>yes</code> or <code>no</code>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"><code>no</code>
      </td>
    </tr>
  </tbody>
</table>

### Viewing a Configured LDAP User Directory

**Command:**  
`weka user ldap`

This command is used for viewing the current LDAP configuration used for authenticating users. 

### Disabling/Enabling a Configured LDAP User Directory

**Command:**  
`weka user ldap disable    
weka user ldap enable`

These commands are used for disabling or enabling user authentication through a configured LDAP user directory.

{% hint style="info" %}
**Note:** It is not possible to delete an LDAP configuration; only disable it.
{% endhint %}

