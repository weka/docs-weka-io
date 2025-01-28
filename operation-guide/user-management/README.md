---
description: >-
  The WEKA system enables managing user access and roles locally and through
  organizational directories like LDAP or AD. This topic covers user types,
  authentication methods, and management.
---

# User management

## User types and roles

Access to the WEKA system is managed through user accounts, each uniquely identified by a username and authenticated using a password. The system supports up to 1,152 local users. User permissions and access levels are determined by predefined roles.

### Role descriptions&#x20;

<table><thead><tr><th width="154">Role</th><th width="164">Purpose</th><th width="225">Key permissions</th><th>Restrictions</th></tr></thead><tbody><tr><td><strong>Cluster Admin</strong></td><td>Advanced administrative tasks for managing the cluster.</td><td>Full access to system configuration, user management, and performance tuning.</td><td>None. <br>For details, see <a data-mention href="./#cluster-admin-first-user">#cluster-admin-first-user</a> </td></tr><tr><td><strong>CSI</strong></td><td>Interfacing with the WEKA cluster through the <a data-mention href="../../appendices/weka-csi-plugin/">weka-csi-plugin</a> for Kubernetes.</td><td><ul><li>Provisioning, mounting, and unmounting file systems.</li><li>Storage management tasks through CLI and API.</li></ul></td><td><ul><li>Limited to storage management.</li><li>No access to broader administrative functions.</li></ul></td></tr><tr><td><strong>Organization Admin</strong></td><td>Administrative tasks within a single organization.</td><td>Privileges limited to managing the assigned organization.</td><td>Cannot perform cluster-wide administrative tasks.<br>For details, see <a data-mention href="../organizations/#organization-admin-role-privileges">#organization-admin-role-privileges</a></td></tr><tr><td><strong>Read-only</strong></td><td>Viewing system configurations and data without making changes.</td><td><ul><li>View system settings and data through GUI, CLI, and API.</li><li>Authenticate and write data to mounted locations (exception for authenticated mounts).</li></ul></td><td><ul><li>Cannot modify system settings.</li><li>Cannot create file systems, protocols, or user accounts.</li></ul></td></tr><tr><td><strong>Regular</strong></td><td>Basic role for mounting filesystems.</td><td><ul><li>Sign in to obtain an access token.</li><li>Change own password.</li></ul></td><td><ul><li>No GUI access.</li><li>No CLI or API commands beyond mounting tasks.</li></ul></td></tr><tr><td><strong>S3</strong></td><td>Running S3 commands and APIs.</td><td><ul><li>Perform S3 operations within the limits of the assigned IAM policy.</li><li>Create S3 service accounts with specific policies.</li></ul></td><td>Limited to actions allowed by the attached S3 IAM policy.</td></tr></tbody></table>

### **Special case: Cluster Admin (first user)**

When a WEKA cluster is created, a default **Cluster Admin** user (`admin`) is generated with a default password. This user must change their password on the first login. The first user has full administrative privileges across the cluster.\
Key responsibilities and restrictions include:

* **Responsibilities**: Managing cluster-wide operations, global configurations, hardware, and resources.
* **Restrictions**: Cannot delete their account or downgrade their role.

Cluster Admin accounts must adhere to a strict password policy:

* Minimum of 8 characters.
* At least one uppercase letter, one lowercase letter, and one number or special character.

You can create additional Cluster Admin accounts with unique usernames. You can rename or delete the default `admin` user if at least one other Cluster Admin account exists. To ensure system continuity, maintain at least one internal Cluster Admin account for support purposes.

{% hint style="info" %}
When multiple organizations exist, Organization Admins manage specific organizations, while Cluster Admins handle cluster-wide and infrastructure-level tasks.
{% endhint %}

## Authentication and login process

The WEKA user login process involves authenticating users and managing access. The following steps outline the key components:

* **Local user login**: The system first searches for the user among local accounts created using the `weka user add` command.
* **LDAP integration**: If the user is not found locally but exists in an integrated LDAP directory, the system verifies their credentials using LDAP. Integration must be configured beforehand.
* **Login events**:
  * **Successful login**: Triggers a `UserLoggedIn` event, logging the username, role, and user type (local or LDAP).
  * **Failed login**: Prompts an "Invalid username or password" message and triggers a `UserLoginFailed` event with details of the failure.
* **GUI login**: Users log in by entering their username and password in the GUI. The `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables can pass this information to the CLI.
* **CLI login**: Users authenticate through the CLI using the `weka user login <username> <password>` command. This generates an authentication token file, defaulting to `~/.weka/auth-token.json`.
  * Use `weka user whoami` to verify the currently logged-in CLI user.
  * Adjust the token file path with the `--path` option or the `WEKA_TOKEN` environment variable.
* **Persistence and defaults**:
  * The `weka user login` command's persistence is server-specific.
  * If `WEKA_USERNAME` and `WEKA_PASSWORD` are not set, the CLI uses the token file.
  * If no CLI user is logged in and no token file exists, the CLI defaults to `admin/admin` credentials.
* **Custom token path**: Use the `WEKA_TOKEN` environment variable to specify a custom path for the authentication token file.

**Related topics**

[user-management.md](user-management.md "mention")

[user-management-1.md](user-management-1.md "mention")
