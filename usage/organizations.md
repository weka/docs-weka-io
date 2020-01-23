---
description: >-
  This page describes the concept of organizations and how different WekaIO
  system features operate within an organizational context.
---

# Organizations

## Overview

For the obscuration of data between different groups of users on the same WekaIO system, it is possible to create multiple organizations. 

The WekaIO system supports up to 64 organizations. Within an organization, logical entities participating in obtaining control of data are managed by the Organization Admin, and not the Cluster Admin.

The Cluster Admin can perform the following activities:

* Create new organizations \(with a defined Organization Admin\).
* Delete existing organizations.
* Monitor per organization the total capacity used by all the organization filesystems.

‌While Cluster Admins are people trusted by the different organizations \(e.g., have root access to the backend hosts\), they are obscured from the organization data in the WekaIO system. The Cluster Admin separation is partial, e.g., they can still see the events of all organizations. The WekaIO system ensures the separation of any sensitive information between the different organizations.

{% hint style="info" %}
**Note:** It is not possible to separate data at the hardware level. While the WekaIO system is highly scalable and serves IOs fairly among filesystems, there is no QoS guarantee between organizations and system limits are per organization. Consequently, a single organization's workload or configuration can exhaust the entire cluster limits.
{% endhint %}

## Use Cases for Working with Organizations

### Private Cloud Multi-Tenancy

Working with organizations makes it possible to manage different departments. While this requires more configuration, e.g., different LDAP configurations are usually unnecessary between different departments in the same organization, the Cluster Admin is fully trusted. It is possible to separate and obscure specific departments - such as IT, Finance, Life Sciences, and Genomics - and even specific projects in departments.

### Logical Separation of External Groups of Users

When multiple, independent groups use the same provided infrastructure, the use of multiple organizations provides much better security, obscuration and separation of data. 

## Cluster Level Entities

The following entities are managed at the cluster level by the Cluster Admin:

* Hardware
* NFS service \(NFS groups and IP/interfaces\)
* SMB service
* Filesystem groups - definition of tiering policies for the different groups, while the Organization Admin selects the filesystem group from the predefined list of groups for each filesystem created
* KMS

## Organization Level Entities

All system entities at the organization level are managed only by the relevant Organization Admin and are only viewable by users within the organization. Cluster Admins do not have permissions to view or manage these entities, which include the following: 

* Filesystems, along with the ability to mount the filesystems \(cannot be mounted even by the Cluster Admin\)
* Object store buckets
* LDAP server
* NFS exports \(NFS client permissions\)

{% hint style="warning" %}
**Note**: SMB shares cannot be defined for organizations other than the 'Root' organization.
{% endhint %}

## Managing Organizations

Only users defined as Cluster Admins can manage organizations. When no organization is created, the root organization is the default organization and all operations are regular, i.e., it is not necessary to authenticate the mounts or supply an organization name when logging in using the GUI/CLI.

Once a new organization is created, the organization name must be provided in every login command, using the `--org` attribute in the `weka user login` command.

## Usage and Quota Management

Cluster Admins can view an organization's usage \(both SSD and total\) and can limit usage with quotas per organization. This can be leveraged for charge-backs on either used or allocated capacity of SSD or object store data.

## Managing Organizations Using the GUI

To create, delete or view organizations in the cluster using the GUI, go to the Organizations screen.

![Organizations Screen](../.gitbook/assets/organization-screen-3.5.png)

## Managing Organizations Using the CLI

### Creating an Organization

**Command:** `weka org create`

Use the following command line to create an organization:

`weka org create <name> <username> <password> [--ssd-quota ssd-quota] [--total-quota total-quota]`

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Organization name | Must be a valid name | Yes |  |
| `username` | String | Username of the created Organization Admin | Must be a valid name | Yes |  |
| `password` | String | Password of the created Organization Admin |  | Yes |  |
| `ssd-quota` | Number | Allowed quota out of the system SSDs to be used by the organization | Must be a valid number | No | 0 \(not limited\) |
| `total-quota` | Number | Total allowed quota for the organization \(SSD and object store\) | Must be a valid number | No | 0 \(not limited\) |

### Viewing Organizations 

**Command:** `weka org`

```text
# weka org

ID | Name       | Allocated SSD | SSD Quota | Allocated Total | Total Quota
---+------------+---------------+-----------+-----------------+-------------
0  | Root       | 0 B           | 0 B       | 0 B             | 0 B
1  | Local IT   | 500.00 GB     | 500.00 GB | 500.00 GB       | 0 B
2  | CUSTOMER_1 | 100.00 GB     | 300.00 GB | 200.00 GB       | 900.00 GB
```

### Editing an Organization

#### **Renaming an Organization**

**Command:** `weka org rename`

Use the following command line to rename an organization: ****

`weka org rename <org> <new-name>`

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `org` | String/Integer | Current organization name or ID |  | Yes |  |
| `new-name` | String | New organization name |  | Yes |  |

#### Updating an Organization's Quotas

**Command:** `weka org set-quota`

Use the following command line to update an organization's quota:

`weka org set-quota <org> [--ssd-quota ssd-quota] [--total-quota total-quota]`

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `org` | String/Integer | Organization name or ID | The root organization \(org ID = 0 cannot be limited\) | Yes |  |
| `ssd-quota` | Number | Allowed quota out of the system SSDs to be used by the organization | Must be a valid number | No |  |
| `total-quota` | Number | Total allowed quota for the organization \(SSD and object store\) | Must be a valid number | No |  |

### Deleting an Organization

**Command:** `weka org delete`

Use the following command line to delete an organization: ****

`weka org delete <org>`

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `org` | String/Integer | Organization name or ID |  | Yes |  |

{% hint style="danger" %}
**Warning:** Deleting an organization is irreversible and will also remove all entities related to the organization, such as filesystems, object stores and users.
{% endhint %}

## Organization Admin Role Privileges

When a new organization is created, the Cluster Admin creates an Organization Admin user for the organization, who is the administrator within the organization responsible for managing each [organization level entity.](organizations.md#organization-level-entities)

Organization Admins have similar privileges to Cluster Admins, except that these privileges are limited to the organization level. They can perform the following within the organization:

* Create new users
* Delete existing users
* Change user passwords
* Set user roles
* Manage the organization LDAP configuration

Additionally,  to avoid situations where an Organization Admin loses access to a WekaIO system cluster, the following restrictions are implemented on Organization Admins:

* Cannot delete themselves
* Cannot change their role to a regular user role.

## Mount Authentication for Organization Filesystems

Once the Cluster Admin has created an organization and the Organization Admin has created filesystems, users or configured the LDAP for the organization, regular users of the organization can mount filesystems.

The purpose of organizations is to provide separation and security for organization data, which requires authentication of the WekaIO system filesystem mounts. This authentication of mounts prevents users of other organizations and even the Cluster Admin from accessing organization filesystems.

Mounting filesystems in an organization \(other than the Root organization\) is only supported using a stateless client. If the user is not logged into the WekaIO system, a login prompt will appear as part of the mount command. 

To securely mount a filesystem in the client, first log into the WekaIO system:

```text
weka user login my_user my_password --org my_org -H backend-host-0
```

Then mount the filesystem:

```text
mount -t wekafs backend-host-0/my_fs /mnt/weka/my_fs
```

Refer to [Mount Command Options](../fs/mounting-filesystems.md#mount-command-options) for all mount options.

‌Authentication is achieved by obtaining a mount token and including it in the mount command. Logging into the WekaIO system using the CLI \(the `weka user login` command\) creates an authentication token and saves it in the client \(default to `~/.weka/auth-token.json,` which can be changed using the`--path`attribute\). The WekaIO system assigns the token that relates to a specific organization. Only mounts that pass the path to a correct token can successfully access the filesystems of the organization. 

Once a user is authenticated, the mount command uses the default location of the authentication token. It is possible to change the token location/name and pass it as a parameter in the mount command using the`token` mount option, or the`WEKA_TOKEN` environment variable.

```text
mount -t wekafs backend-host-0/my_fs /mnt/weka/my_fs -o auth_token=<path>
```

This is useful when mounting several filesystems for several users/organizations on the same host or when using Autofs.

When a token is compromised or no longer required, such as when a user leaves the organization, the Organization Admin can prevent using that token for new mounts by revoking the user access.

#### Revoking User Access Using the CLI

**Command:** `weka user revoke-tokens`

Use the following command to revoke internal user access to the system and mounting filesystems:

`weka user revoke-tokens <username>`

For LDAP users, access can be revoked by changing the `user-revocation-attribute` defined in the LDAP server configuration.

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `username` | String/Integer | Valid user in the organization of the Organization Admin running the command |  | Yes |  |

{% hint style="warning" %}
**Note:** NFS and SMB are different protocols from WekaFS which require additional security considerations when used, e.g., NFS permissions are granted per host, so permissions for accessing these hosts for NFS export should be handled carefully.
{% endhint %}

