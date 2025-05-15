---
description: >-
  Understand how WEKA supports multi-tenancy by logically separating users and
  resources using organizations.
---

# Organizations management

## Overview

Organizations enable separation of duties between user groups within the same WEKA system. Each organization is isolated from others. Users in one organization cannot access or manage data from another.

* Up to 256 organizations can be created.
* Each organization is managed by an Organization Admin.
* A Cluster Admin oversees the overall system but cannot access organization-specific data.

## Cluster Admin responsibilities

Cluster Admins manage the system-wide configuration and can:

* Create and delete organizations.
* Assign an Organization Admin to each organization.
* Monitor total capacity used by each organization.

Although Cluster Admins have backend access (for example, root on servers), they cannot access user data within organizations. They may still view events across all organizations.

{% hint style="info" %}
* **QoS between organizations**: Data is not physically separated at the hardware level. While the system balances IO fairly, there is no QoS guarantee between organizations. One organization’s activity can affect cluster-wide performance.
* **Mount configuration:** Mounts can be configured with maximum and preferred throughput settings. For more information, see [Set mount option default values](../../weka-filesystems-and-object-stores/mounting-filesystems/#set-mount-option-default-values).
{% endhint %}

## Organization use cases&#x20;

### Private cloud multi-tenancy

Organizations can be used to logically separate departments (for example, IT, Finance, Genomics). While setup may require extra configuration, such as per-organization LDAP, the underlying cluster infrastructure remains shared and trusted.

### Logical separation of external groups

For environments with multiple independent user groups, organizations provide stronger data isolation and management boundaries.

## System entity management

### Cluster-level entities

Managed by the Cluster Admin:

* Hardware
* NFS service (including NFS groups and IP interfaces)
* SMB service
* S3 service
* Filesystem groups (used by Organization Admins when creating filesystems)
* Encryption settings (KMS)
* User management for the root organization

{% hint style="info" %}
Protocol services (NFS, SMB, S3) are only available in the root organization. Filesystems cannot be moved between organizations, including into or out of the root organization.
{% endhint %}

### Organization-level entities

Managed exclusively by the Organization Admin:

* Filesystems (including encryption)&#x20;
* Object store buckets
* LDAP server configuration
* NFS exports and client permissions
* User management for their specific organization

{% hint style="info" %}
In an organization, only authenticated users with the Regular or Organization Admin role can mount the filesystems.
{% endhint %}

## Manage organizations

Only Cluster Admins can create or delete organizations. If no organizations are configured, the root organization is used by default, and mounts do not require authentication.

After creating an organization, users must specify the organization name when logging in, using the `--org` flag in the `weka user login` command.

## Usage and quota management

Cluster Admins can:

* Monitor per-organization SSD and total usage.
* Set quotas to limit usage by capacity type.

This supports chargeback models based on actual or allocated storage usage.

## Organization admin privileges

When an organization is created, the Cluster Admin assigns an Organization Admin who manages the organization-level resources.

Organization Admins can:

* Create, delete, and manage users
* Set user roles and change passwords
* Manage the organization’s LDAP configuration

#### Restrictions

To ensure Organization Admins do not lose access:

* They cannot delete their own user account.
* They cannot change their own role.
