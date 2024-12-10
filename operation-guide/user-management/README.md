---
description: >-
  This page describes the management of users licensed to work with the WEKA
  system.
---

# User management

## User types

Access to a WEKA system cluster is managed by creating, modifying, and deleting user accounts. Each user is identified by a unique username and must provide a password for authentication to access the WEKA system through the GUI, CLI, or API. The system supports up to 1,152 local users.

Each user is assigned one of the following predefined roles, which determine their permissions and level of access within the WEKA system:

### Role descriptions&#x20;

<table><thead><tr><th width="154">Role</th><th width="164">Purpose</th><th width="225">Key permissions</th><th>Restrictions</th></tr></thead><tbody><tr><td><strong>Cluster Admin</strong></td><td>Advanced administrative tasks for managing the cluster.</td><td>Full access to system configuration, user management, and performance tuning.</td><td>None. <br>For details, see <a data-mention href="./#cluster-admin-first-user">#cluster-admin-first-user</a> </td></tr><tr><td><strong>CSI</strong></td><td>Interfacing with the WEKA cluster through the <a data-mention href="../../appendices/weka-csi-plugin/">weka-csi-plugin</a> for Kubernetes.</td><td><ul><li>Provisioning, mounting, and unmounting file systems.</li><li>Storage management tasks through CLI and API.</li></ul></td><td><ul><li>Limited to storage management.</li><li>No access to broader administrative functions.</li></ul></td></tr><tr><td><strong>Organization Admin</strong></td><td>Administrative tasks within a single organization.</td><td>Privileges limited to managing the assigned organization.</td><td>Cannot perform cluster-wide administrative tasks.<br>For details, see <a data-mention href="../organizations/#organization-admin-role-privileges">#organization-admin-role-privileges</a></td></tr><tr><td><strong>Read-only</strong></td><td>Viewing system configurations and data without making changes.</td><td><ul><li>View system settings and data through GUI, CLI, and API.</li><li>Authenticate and write data to mounted locations (exception for authenticated mounts).</li></ul></td><td><ul><li>Cannot modify system settings.</li><li>Cannot create file systems, protocols, or user accounts.</li></ul></td></tr><tr><td><strong>Regular</strong></td><td>Basic role for mounting filesystems.</td><td><ul><li>Sign in to obtain an access token.</li><li>Change own password.</li></ul></td><td><ul><li>No GUI access.</li><li>No CLI or API commands beyond mounting tasks.</li></ul></td></tr><tr><td><strong>S3</strong></td><td>Running S3 commands and APIs.</td><td><ul><li>Perform S3 operations within the limits of the assigned IAM policy.</li><li>Create S3 service accounts with specific policies.</li></ul></td><td>Limited to actions allowed by the attached S3 IAM policy.</td></tr></tbody></table>

## Cluster Admin **(**&#x66;irst user)

When a WEKA cluster is created, the system automatically generates the first user account with the `admin` username and a default password. Upon first login, the system prompts this user to change their password. This initial user is assigned the **Cluster Admin** role, granting them full access to all commands and administrative capabilities.

**Responsibilities**

Cluster Admin users are responsible for managing the entire cluster, including:

* Cluster-wide operations that span all organizations within the system.
* Management of cluster hardware, resources, and global configurations.

When multiple organizations are used, there is a distinction between managing a specific organization (handled by an Organization Admin) and managing the overall cluster. A Cluster Admin oversees tasks beyond organizational boundaries, including infrastructure-level management.

**Cluster admin role privileges**

Cluster Admin users have additional privileges compared to other user roles. These privileges include the ability to:

* Create new users.
* Delete existing users.
* Change user passwords.
* Assign or modify user roles.
* Manage LDAP configurations.
* Manage organizations.

**Restrictions**

To ensure a Cluster Admin user retains access to the WEKA cluster, the following restrictions are in place:

* Cluster Admins cannot delete their own user accounts.
* Cluster Admins cannot change their own role to a regular user role.

**Password requirements**

All Cluster Admin accounts must adhere to the following password policy:

* At least 8 characters.
* At least one uppercase letter.
* At least one lowercase letter.
* At least one number or special character.

**Key points**

* The WEKA Customer Success Team requires at least one internal Cluster Admin account to be defined for support purposes.
* Additional Cluster Admin accounts can be created with unique usernames.
* The default `admin` user can be renamed or deleted if a replacement Cluster Admin account is created.



**Related topics**

[user-management.md](user-management.md "mention")

[user-management-1.md](user-management-1.md "mention")
