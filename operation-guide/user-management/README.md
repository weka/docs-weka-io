---
description: >-
  This page describes the management of users licensed to work with the WEKA
  system.
---

# User management

## User types

Access to a WEKA system cluster is controlled by creating, modifying, and deleting users. You can add up to 1152 local users to work with a WEKA system cluster. A username identifies each user and must provide a password for authentication to work with the WEKA system GUI, CLI, and API.

Every WEKA system user has one of the following defined roles:

* **Cluster Admin**: A user role with additional privileges. See [Cluster Admin role privileges](./#cluster-admin-role-privileges).
* **Organization Admin**: A user role with additional privileges within an organization. This role is relevant when working with different organizations. See [Organization Admin role privileges](../organizations/#organization-admin-role-privileges).
*   **Read-only:** A user role with limited privileges across the GUI, CLI, and API interfaces. Users with this role are restricted from making any changes to the system configuration, including tasks like creating file systems, protocols, and user accounts. Their permissions are strictly limited to 'read' operations, allowing them to view system settings and data but not to modify them.

    The term 'read-only' does not apply to authenticated mounts. In such cases, even users with a read-only role can still authenticate and write data to a mounted location.
* **S3:** A user role to run S3 commands and APIs. This user can operate within the limits of the S3 IAM policy attached to it. An S3 user can create S3 service accounts with a specific policy.
* **Regular**: A user role only used for mounting filesystems. This user can sign in to obtain an access token and change the password but cannot access the GUI or run other CLI/API commands.

## Cluster Admin **(**the first user)

By default, when a WEKA cluster is created, the first user with an `admin` username and password is created. A prompt to change the password on the first login is displayed. This user has a Cluster Admin role, which allows running all commands.&#x20;

Cluster Admin users are responsible for managing the cluster as a whole. When using multiple organizations, there is a difference between managing a single organization and managing the cluster because managing the cluster also covers the management of the cluster hardware and resources. These are the additional permissions given to a Cluster Admin compared to an Organization Admin.

The WEKA Customer Success Team must have at least one defined **internal** Cluster Admin user. However**,** it is possible to create a Cluster Admin user with a different name and delete the default admin user if required.

### Cluster Admin role privileges

Cluster Admin users have additional privileges over regular users. These include the ability to:

* Create new users
* Delete existing users
* Change user passwords
* Set user roles
* Manage LDAP configurations
* Manage organizations

Additionally, the following restrictions apply to Cluster Admin users to avoid situations where a Cluster Admin loses access to the WEKA cluster:

* Cluster Admins cannot delete themselves.
* Cluster Admins cannot change their role to a regular user role.

### Password requirements

* at least 8 characters
* an uppercase letter
* a lowercase letter
* a number or a special character



**Related topics**

[user-management.md](user-management.md "mention")

[user-management-1.md](user-management-1.md "mention")
