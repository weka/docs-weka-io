---
description: >-
  The WEKA system enables managing user access and roles locally and through
  organizational directories like LDAP or AD. This topic covers user types,
  authentication methods, and management.
---

# User management

## User types and roles

Access to the WEKA system is managed through user accounts, each uniquely identified by a username and authenticated using a password. The system supports up to 1,152 local users. User permissions and access levels are determined by predefined roles.

### Role descriptions

<table><thead><tr><th width="154">Role</th><th width="164">Purpose</th><th width="225">Key permissions</th><th>Restrictions</th></tr></thead><tbody><tr><td><strong>Cluster Admin</strong></td><td>Advanced administrative tasks for managing the cluster.</td><td>Full access to system configuration, user management, and performance tuning.</td><td>Cannot delete their own account or change their role to a regular user role.</td></tr><tr><td><strong>CSI</strong></td><td>Interfacing with the WEKA cluster through the <a data-mention href="../../appendices/weka-csi-plugin/">weka-csi-plugin</a> for Kubernetes.</td><td><ul><li>Provisioning, mounting, and unmounting file systems.</li><li>Storage management tasks through CLI and API.</li></ul></td><td><ul><li>Limited to storage management.</li><li>No access to broader administrative functions.</li></ul></td></tr><tr><td><strong>Tenant Admin</strong></td><td>Administrative tasks within a single tenant.</td><td>Privileges limited to managing the assigned tenant.</td><td>Cannot perform cluster-wide administrative tasks.<br>For details, see <a data-mention href="../weka-native-multi-tenancy-management/">weka-native-multi-tenancy-management</a></td></tr><tr><td><strong>Read-only</strong></td><td>Viewing system configurations and data without making changes.</td><td><ul><li>View system settings and data through GUI, CLI, and API.</li><li>Authenticate and write data to mounted locations (exception for authenticated mounts).</li></ul></td><td>Cannot modify system settings or create file systems, protocols, or user accounts.</td></tr><tr><td><strong>Regular</strong></td><td>Basic role for mounting filesystems.</td><td><ul><li>Sign in to obtain an access token.</li><li>Change own password.</li></ul></td><td><ul><li>No GUI access.</li><li>No CLI or API commands beyond mounting tasks.</li></ul></td></tr><tr><td><strong>S3</strong></td><td>Running S3 commands and APIs.</td><td><ul><li>Perform S3 operations within the limits of the assigned IAM policy.</li><li>Create S3 service accounts with specific policies.</li></ul></td><td>Limited to actions allowed by the attached S3 IAM policy.</td></tr></tbody></table>

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
When multiple tenants exist, a Tenant Admin manages a specific tenant, while the Cluster Admin manages cluster-wide and infrastructure-level tasks.
{% endhint %}

### Roles and multi-tenancy

Two changes affect what a Tenant Admin can do when multi-tenancy is in use.

**Root-organization Tenant Admins keep the Tenant Admin role.** They are no longer escalated to Cluster Admin automatically. This is a loosening rather than a restriction, and it means a root-organization Tenant Admin now has the same scope as any other Tenant Admin.

**Some NFS operations now require the Cluster Admin role.** Five NFS operations were tightened, so calls that previously succeeded with a lower role return HTTP 403. The change takes effect immediately after the upgrade with no deprecation period. The most consequential is a *read* operation that moved from Read Only to Cluster Admin, which can break monitoring scripts that never wrote anything. See [breaking-changes.md](../upgrading-weka-versions/breaking-changes.md "mention").

**Cluster Admin can perform every Tenant Admin operation.** The roles are a strict hierarchy, so anything documented as a Tenant Admin task is also available to a Cluster Admin.

For what a Tenant Admin can and cannot do with NFS specifically, see [multi-tenancy-tenant-level-administration.md](../weka-native-multi-tenancy-management/multi-tenancy-tenant-level-administration.md "mention").

{% hint style="info" %}
**Role names in the CLI and API.** The role tokens accepted and returned by the CLI and API are `ClusterAdmin` and `TenantAdmin`. This documentation uses **Cluster Admin** and **Tenant Admin** in prose, and the exact tokens wherever a CLI or API value appears.

`OrgAdmin` is the pre-5.1.2 name for `TenantAdmin`. It is still accepted as an input alias but is not a current role name. It does appear verbatim in one place a reader will encounter — the 403 message raised by the tightened endpoints:

```
Current user role is "OrgAdmin" but a role of "ClusterAdmin" or above is required to perform this operation
```
{% endhint %}

## Authentication and login process

The WEKA user login process involves authenticating users and managing access. The following steps outline the key components:

* **Local user login**: The system first searches for the user among local accounts created using the GUI or the `weka user add` command.
* **LDAP or AD integration**: If the user is not found locally but exists in an integrated LDAP or AD directory, the system verifies their credentials using LDAP. Integration must be configured beforehand.
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
