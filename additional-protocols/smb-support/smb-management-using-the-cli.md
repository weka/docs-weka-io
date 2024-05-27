---
description: >-
  This page details SMB management - setting up an SMB cluster over Weka
  filesystems and managing the cluster itself - using CLIs.
---

# SMB Management Using CLIs

## Overview

The Weka system has a number of CLI commands for setting up an SMB cluster over Weka filesystems. Used for managing the cluster itself, they are all located under the`weka smb cluster` command. They define what Weka hosts will participate in the SMB cluster, and what (if any) public IPs will be exposed by the SMB cluster.

## Showing an SMB Cluster

**Command:** `weka smb cluster`

Use this command to view information about the SMB cluster managed by the Weka system.

## Showing an SMB Domain Configuration

**Command:** `weka smb domain`

Use this command to view information about the SMB domain configuration.

## Creating an SMB Cluster

**Command:** `weka smb cluster create`

Use the following command line to create a new SMB cluster to be managed by the Weka system:

`weka smb cluster create <name> <domain> [--samba-hosts samba-hosts]... [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range] [--domain-netbios-name domain-netbios-name] [--idmap-backend idmap-backend] [--joined-domain-mapping-from-id joined-domain-mapping-from-id] [--joined-domain-mapping-to-id joined-domain-mapping-to-id] [--default-domain-mapping-from-id default-domain-mapping-from-id] [--default-domain-mapping-to-id default-domain-mapping-to-id] [--encryption encryption]`

**Parameters in Command Line**

| **Name**                         | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Limitations**                                     | **Mandatory** | **Default**                     |
| -------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | ------------- | ------------------------------- |
| `name`                           | String                       | NetBIOS name for the SMB cluster                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Must be a valid name (ASCII)                        | Yes           |                                 |
| `domain`                         | String                       | The domain which the SMB cluster is to join                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Must be a valid name (ASCII)                        | Yes           | ​                               |
| `samba-hosts`                    | Comma-separated strings      | List of 3-8 Weka system hosts to participate in the SMB cluster, based on the host IDs in Weka                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Must be valid host IDs                              | Yes           | ​                               |
| `smb-ips-pool`                   | Comma-separated IP addresses | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA; should not be assigned to any host on the network                                                                                                                                                                                                                                                                                                                                                                                                                         | Must be valid IP addresses                          | No            | ​                               |
| `smb-ips-range`                  | IP address range             | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA; should not be assigned to any host on the network                                                                                                                                                                                                                                                                                                                                                                                                                         | <p>Format: A.B.C.D-E </p><p>E.g., 10.10.0.1-100</p> | No​           |                                 |
| `domain-netbios-name`            | String                       | Domain NetBIOS name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Must be a valid name (ASCII)                        | No            | First part of`domain` parameter |
| `idmap-backend`                  | String                       | The Id mapping method to use                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `rfc2307` or `rid`                                  | No            | `rfc2307`                       |
| `joined-domain-mapping-from-id`  | Number                       | The first ID of the range for the main AD ID mapping                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |                                                     | No            | 0                               |
| `joined-domain-mapping-to-id`    | Number                       | The last ID of the range for the main AD ID mapping                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                     | No            | 4290000000                      |
| `default-domain-mapping-from-id` | Number                       | The first ID of the range for the default AD ID mapping (for trusted domains that have no range defined)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |                                                     | No            | 4290000001                      |
| `default-domain-mapping-to-id`   | Number                       | The last ID of the range for the default AD ID mapping (for trusted domains that have no range defined)                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |                                                     | No            | 4291000000                      |
| `encryption`                     | String                       | <p>The global encryption policy to use. </p><p><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</p><p><code>disabled</code> -  doesn't support encrypted connections. </p><p><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections. </p><p><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption will be denied access to the server.</p> | `enabled,` `disabled`, `desired` or `required`      | No            | `enabled`                       |

{% hint style="info" %}
**Note:** All IPs must reside on the same subnet, in order to enable HA through IP takeover.
{% endhint %}

{% hint style="info" %}
**Note:** The IPs must be configured but **MUST NOT** be in use by any other application/host in the subnet, including Weka system management nodes, Weka system IO nodes, or Weka system NFS floating IPs. In AWS environments, this is not supported and these IPs should not be provided**.**
{% endhint %}

{% hint style="info" %}
**Note:** The `--smb-ips` parameter is supposed to accept the public IPs that the SMB cluster will expose. To mount the SMB cluster in an HA manner, clients should be mounted via one of the exposed public IPs, thereby ensuring that they will automatically reconnect if one of the SMB hosts fails.
{% endhint %}

{% hint style="info" %}
**Note:** If it is necessary to set global options to the SMB library, contact the Weka Support Team.
{% endhint %}

{% hint style="success" %}
**For Example:**

`weka smb cluster create wekaSMB mydomain --samba-hosts 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over the Weka system hosts 0-4. The SMB cluster is called `wekaSMB,`the domain name is called `mydomain`and is directed to use public IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Checking Status of SMB Host Readiness

**Command:** `weka smb cluster status`

Use this command to check the status of the hosts which are part of the SMB cluster. Once all hosts are prepared and ready, it is possible to join an SMB cluster to an Active Directory.

## Joining an SMB Cluster to an Active Directory

**Command:** `weka smb domain join`

Use the following command line to join an SMB domain to an Active Directory:

`weka smb domain join <username> <password>`

**Parameters in Command Line**

| **Name**   | **Type** | **Value**                                                      | **Limitations**                  | **Mandatory** | **Default** |
| ---------- | -------- | -------------------------------------------------------------- | -------------------------------- | ------------- | ----------- |
| `username` | String   | Name of a user with permissions to add a machine to the domain | Must be a valid name (ASCII)     | Yes           |             |
| `password` | String   | The password of the user                                       | Must be a valid password (ASCII) | Yes           |             |

In order to join another Active Directory to the current SMB cluster configuration, it is necessary to leave the current Active Directory. This is performed using the following command line:

`weka smb domain leave <username> <password>`

On completion of this operation, it is possible to join another Active Directory to the SMB cluster.

## Deleting an SMB Cluster

**Command:** `weka smb cluster destroy`

Use this command to destroy an SMB cluster managed by the Weka system.

Deleting an existing SMB cluster managed by the Weka system does not delete the backend Weka filesystems, but removes the SMB share exposures of these filesystems.

## Add/Remove Hosts from an SMB Cluster

**Command:** `weka smb cluster hosts add/remove`

Use these commands to add or remove hosts from the SMB cluster.

{% hint style="info" %}
**Note:** This operation might take some time to complete. During that time, SMB IOs will be stalled.
{% endhint %}

## Configuring Trusted Domains

### Listing Trusted Domains

**Command:** `weka smb cluster trusted-domains`

Use this command to list all the configured trusted domains and their ID ranges.

### Adding Trusted Domains

**Command:** `weka smb cluster trusted-domains add`

Use the following command line to add an SMB trusted domain:

`weka smb cluster trusted-domains add <domain-name> <from-id> <to-id>`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                                           | **Limitations**                             | **Mandatory** | **Default** |
| ------------- | -------- | --------------------------------------------------- | ------------------------------------------- | ------------- | ----------- |
| `domain-name` | String   | The name of the domain being added                  | Must be a valid name (ASCII)                | Yes           |             |
| `from-id`     | Number   | The first ID of the range for the domain ID mapping | The range cannot overlap with other domains | Yes           |             |
| `to-id`       | Number   | The last ID of the range for the domain ID mapping  | The range cannot overlap with other domains | Yes           |             |

### Removing Trusted Domains

**Command:** `weka smb cluster trusted-domains remove`

Use the following command line to remove an SMB trusted domain:

`weka smb cluster trusted-domains remove <domain-id>`

**Parameters in Command Line**

| **Name**    | **Type** | **Value**                               | **Limitations** | **Mandatory** | **Default** |
| ----------- | -------- | --------------------------------------- | --------------- | ------------- | ----------- |
| `domain-id` | Number   | The internal ID of the domain to remove |                 | Yes           |             |

## Listing SMB Shares

**Command:** `weka smb share`

Use this command to list all existing SMB shares.

## Adding SMB Shares

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed to SMB:

`weka smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [--file-create-mask file-create-mask] [--directory-create-mask directory-create-mask] [--obs-direct obs-direct] [--encryption encryption] [--read-only read-only] [--user-list-type user-list-type] [--users users]... [--allow-guest-access allow-guest-access] [--hidden hidden]`

{% hint style="info" %}
The mount mode for the SMB share is `readcache` and cannot be modified.
{% endhint %}

**Parameters in Command Line**

| **Name**                | **Type**                          | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default**       |
| ----------------------- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------------- |
| `share-name`            | String                            | Name of the share being added                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Must be a valid name (ASCII)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Yes           | ​                 |
| `fs-name`               | String                            | Name of the filesystem to share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | <p>Must be a valid name.<br>A filesystem set with required authentication cannot be used for SMB share.</p>                                                                                                                                                                                                                                                                                                                                                                                                                     | Yes           | ​                 |
| `description`           | String                            | Description of what the share will receive when viewed remotely                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Must be a valid string                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | No            | ​                 |
| `internal-path`         | String                            | The internal path within the filesystem (relative to its root) which will be exposed                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Must be a valid path                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | No            | .                 |
| `file-create-mask`      | String                            | POSIX permissions for the file created through the SMB share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Numeric (octal) notation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | No            | 0744              |
| `directory-create-mask` | String                            | POSIX permissions for directories created through the SMB share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Numeric (octal) notation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | No            | 0755              |
| `acl`                   | String                            | Enable Windows ACLs on the share (which will be translated to POSIX)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | <p><code>on</code> or <code>off;</code></p><p>Up to 16 ACEs per file</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                        | No            | `off`             |
| `obs-direct`            | String                            | See [Object-store Direct Mount](../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option) section                                                                                                                                                                                                                                                                                                                                                                                                                | `on` or `off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | No            | `off`             |
| `encryption`            | String                            | <p></p><p>The share encryption policy.</p><p><code>cluster_default</code> - the share encryption policy will follow the global SMB cluster setting </p><p><code>desired</code> - turns on data encryption for this share for clients that support encryption if negotiation has been enabled globally.</p><p><code>required</code> - enforces encryption for the shares. Clients that do not support encryption will be denied access to the share. If the global option is set to <code>disabled</code> access will be denied to these shares for all clients.</p> | `cluster_default` `desired` or `required`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | No            | `cluster_default` |
| `read-only`             | String                            | Sets the share as read-only. Users cannot create or modify files in this share.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `on` or `off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | No            | `off`             |
| `user-list-type`        | String                            | The type of initial permissions list for `users`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | No            |                   |
| `users`                 | A comma-separated list of Strings | A list of users to use with the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins`                                                                                                                                                                                                                                                                                                                                                                                                                         | Up to 8 users/groups  for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | No            | Empty list        |
| `allow-guest-access`    | String                            |  Allows connecting to the SMB service without a password. Permissions are as the `nobody` user account permissions.                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `on` or`off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | No            | `off`             |
| `hidden`                | String                            | Sets the share as non-browsable. It will be accessible for mounting and IOs but not discoverable by SMB clients.                                                                                                                                                                                                                                                                                                                                                                                                                                                    | `on` or `off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | No            | `off`             |

{% hint style="info" %}
**Note:** If it is necessary to set share specific options to the SMB library, contact the Weka Support Team.
{% endhint %}

{% hint style="success" %}
**For Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default`  \
`weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first SMB share added has the Weka system share for default. The second SMB share has internal for default.
{% endhint %}

## Updating SMB Shares

**Command:** `weka smb share update`

Use the following command line to update an existing share:

`weka smb share update <share-id> [--encryption encryption]`

**Parameters in Command Line**

| **Name**     | **Type** | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Limitations**                           | **Mandatory** | **Default** |
| ------------ | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- | ------------- | ----------- |
| `share-id`   | Number   | The ID of the share to be updated                                                                                                                                                                                                                                                                                                                                                                                                               | Must be a valid share ID                  | Yes           | ​           |
| `encryption` | String   | <p>The share encryption policy.</p><p><code>desired</code> - turns on data encryption for this share for clients that support encryption if negotiation has been enabled globally.</p><p><code>required</code> - enforces encryption for the shares. Clients that do not support encryption will be denied access to the share. If the global option is set to <code>disabled</code> access will be denied to these shares for all clients.</p> | `cluster_default` `desired` or `required` | No            |             |

## **Controlling SMB Shares Users Lists**

**Command:** `weka smb share lists show`

Use this command to view the various user-list settings.



**Command:** `weka smb share lists add`

Use the following command line to add users to a share user-list:

`weka smb share lists add <share-id> <user-list-type> <--users users>...`

**Parameters in Command Line**

| **Name**         | **Type**                          | **Value**                                                                                                                                 | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default** |
| ---------------- | --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `share-id`       | Number                            | The ID of the share to be updated                                                                                                         | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Yes           |             |
| `user-list-type` | String                            | The type of permissions list for `users`                                                                                                  | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |
| `users`          | A comma-separated list of Strings | A list of users to add to the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins` | Up to 8 users/groups  for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Yes           |             |



**Command:** `weka smb share lists remove`

Use the following command line to remove users from a share user-list:

`weka smb share lists remove <share-id> <user-list-type> <--users users>...`

**Parameters in Command Line**

| **Name**         | **Type**                          | **Value**                                                                                                                                      | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default** |
| ---------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `share-id`       | Number                            | The ID of the share to be updated                                                                                                              | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Yes           |             |
| `user-list-type` | String                            | The type of permissions list for `users`                                                                                                       | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |
| `users`          | A comma-separated list of Strings | A list of users to remove from the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins` | Up to 8 users/groups  for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Yes           |             |



**Command:** `weka smb share lists reset`

Use the following command line to remove all users from a share user-list:

`weka smb share lists reset <share-id> <user-list-type>`

**Parameters in Command Line**

| **Name**         | **Type** | **Value**                              | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default** |
| ---------------- | -------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `share-id`       | Number   | The ID of the share to be updated      | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Yes           |             |
| `user-list-type` | String   | The type of permissions list to reset  | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |

## Removing SMB Shares

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`weka smb share remove <share-id>`

**Parameters in Command Line**

| **Name**   | **Type** | **Value**                         | **Limitations**          | **Mandatory** | **Default** |
| ---------- | -------- | --------------------------------- | ------------------------ | ------------- | ----------- |
| `share-id` | String   | The ID of the share to be removed | Must be a valid share ID | Yes           | ​           |

{% hint style="success" %}
**For Example:** The following is an example for removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## Controlling SMB Access Based on Hosts IP/Name

It is possible to control which hosts are permitted to access the SMB service or share.

**Command:** `weka smb cluster host-access show` / `weka smb share host-access show`

Use this command to view the various host-access settings.



**Command:** `weka smb cluster host-access add` / `weka smb share host-access add`

Use the following command line to add hosts to the allow/deny list (in either cluster-level or share-level):

`weka smb cluster host-access add <mode> <--ips ips> <--hosts hosts>`&#x20;

`weka smb share host-access add <share-id> <mode> <--ips ips> <--hosts hosts>`

**Parameters in Command Line**

| **Name**   | **Type**                          | **Value**                         | **Limitations**                                                                                                                                                             | **Mandatory**                                  | **Default** |
| ---------- | --------------------------------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- | ----------- |
| `share-id` | Number                            | The ID of the share to be updated | Must be a valid share ID                                                                                                                                                    | Yes (for the share-level command)              |             |
| `mode`     | String                            | The access mode of the host       | `allow` or `deny`                                                                                                                                                           | Yes                                            |             |
| `ips`      | A Comma-separated list of IPs     | Host IPs to allow/deny            | <p>Supports the following format to provide multiple IPs: </p><p><code>192.</code></p><p><code>192.168.</code><br><code>192.168.1</code><br><code>192.168.1.1/24</code></p> | Must provide at least one of: `ips` or `hosts` |             |
| `hosts`    | A Comma-separated list of strings | Host names to allow/deny          |                                                                                                                                                                             | Must provide at least one of: `ips` or `hosts` |             |



**Command:** `weka smb cluster host-access remove` / `weka smb share host-access remove`

Use the following command line to remove hosts from the allow/deny list (in either cluster-level or share-level):

`weka smb cluster host-access remove <hosts>`&#x20;

`weka smb share host-access remove <share-id> <hosts>`

**Parameters in Command Line**

| **Name**   | **Type**                      | **Value**                                     | **Limitations**                                                                              | **Mandatory**                     | **Default** |
| ---------- | ----------------------------- | --------------------------------------------- | -------------------------------------------------------------------------------------------- | --------------------------------- | ----------- |
| `share-id` | Number                        | The ID of the share to be updated             | Must be a valid share ID                                                                     | Yes (for the share-level command) |             |
| `hosts`    | Space-separated list of hosts | The hosts to remove from the host-access list | Must be the exact name as shown under the `HOSTNAME` column in the equivalent `list` command | Yes                               |             |



**Command:** `weka smb cluster host-access reset` / `weka smb share host-access reset`

Use the following command line to remove all hosts from the allow/deny list (in either cluster-level or share-level):

`weka smb cluster host-access reset <mode>` `weka smb share host-access reset <share-id> <mode>`

**Parameters in Command Line**

| **Name**   | **Type** | **Value**                                                     | **Limitations**          | **Mandatory**                     | **Default** |
| ---------- | -------- | ------------------------------------------------------------- | ------------------------ | --------------------------------- | ----------- |
| `share-id` | Number   | The ID of the share to be updated                             | Must be a valid share ID | Yes (for the share-level command) |             |
| `mode`     | String   | All hosts with this access-mode will be removed from the list | `allow` or `deny`        | Yes                               |             |
