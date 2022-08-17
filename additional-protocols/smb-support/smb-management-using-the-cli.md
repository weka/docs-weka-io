---
description: >-
  This page provides procedures for setting up an SMB cluster over Weka
  filesystems and managing the cluster itself, using the CLI.
---

# Manage SMB using the CLI

Using the CLI, you can:

* [Show the SMB cluster](smb-management-using-the-cli.md#show-the-smb-cluster)
* [Show the SMB domain configuration](smb-management-using-the-cli.md#show-smb-domain-cfg)
* [Create the SMB cluster](smb-management-using-the-cli.md#create-smb-cluster)
* [Update the SMB cluster](smb-management-using-the-cli.md#update-smb-cluster)
* [Check the status of SMB host readiness](smb-management-using-the-cli.md#check-status-smb-host-readiness)
* [Join an SMB cluster in Active Directory](smb-management-using-the-cli.md#join-smb-cluster-in-ad)
* [Delete an SMB cluster](smb-management-using-the-cli.md#delete-an-smb-cluster)
* [Add or remove hosts from an SMB cluster](smb-management-using-the-cli.md#add-remove-hosts-from-smb)
* [Configure trusted domains](smb-management-using-the-cli.md#configure-trusted-domains)
* [List SMB shares](smb-management-using-the-cli.md#list-smb-shares)
* [Add an SMB share](smb-management-using-the-cli.md#add-an-smb-share)
* [Update SMB shares](smb-management-using-the-cli.md#update-smb-shares)
* [Control SMB share user-lists](smb-management-using-the-cli.md#control-smb-share-user-lists)

## Show the SMB cluster <a href="#show-the-smb-cluster" id="show-the-smb-cluster"></a>

**Command:** `weka smb cluster`

Use this command to view information about the SMB cluster managed by the Weka system.

## Show the SMB domain configuration <a href="#show-smb-domain-cfg" id="show-smb-domain-cfg"></a>

**Command:** `weka smb domain`

Use this command to view information about the SMB domain configuration.

## Create the SMB cluster <a href="#create-smb-cluster" id="create-smb-cluster"></a>

**Command:** `weka smb cluster create`

Use the following command line to create a new SMB cluster to be managed by the Weka system:

`weka smb cluster create <name> <domain> [--samba-hosts samba-hosts]... [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range] [--domain-netbios-name domain-netbios-name] [--idmap-backend idmap-backend] [--joined-domain-mapping-from-id joined-domain-mapping-from-id] [--joined-domain-mapping-to-id joined-domain-mapping-to-id] [--default-domain-mapping-from-id default-domain-mapping-from-id] [--default-domain-mapping-to-id default-domain-mapping-to-id] [--encryption encryption]`

**Parameters**

| **Name**                         | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Limitations**                                     | **Mandatory** | **Default**                     |
| -------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | ------------- | ------------------------------- |
| `name`                           | String                       | NetBIOS name for the SMB cluster                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Must be a valid name (ASCII)                        | Yes           |                                 |
| `domain`                         | String                       | The domain which the SMB cluster is to join                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Must be a valid name (ASCII)                        | Yes           | ​                               |
| `samba-hosts`                    | Comma-separated strings      | List of 3-8 Weka system hosts to participate in the SMB cluster, based on the host IDs in Weka                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Must be valid host IDs                              | Yes           | ​                               |
| `smb-ips-pool`                   | Comma-separated IP addresses | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA; should not be assigned to any host on the network                                                                                                                                                                                                                                                                                                                                                                                                                         | Must be valid IP addresses                          | No            | ​                               |
| `smb-ips-range`                  | IP address range             | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. The IPs should not be assigned to any host on the network.                                                                                                                                                                                                                                                                                                                                                                                                                | <p>Format: A.B.C.D-E </p><p>E.g., 10.10.0.1-100</p> | No​           |                                 |
| `domain-netbios-name`            | String                       | Domain NetBIOS name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Must be a valid name (ASCII)                        | No            | First part of`domain` parameter |
| `idmap-backend`                  | String                       | The Id mapping method to use.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `rfc2307` or `rid`                                  | No            | `rfc2307`                       |
| `joined-domain-mapping-from-id`  | Number                       | The first ID of the range for the main AD ID mapping.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |                                                     | No            | 0                               |
| `joined-domain-mapping-to-id`    | Number                       | The last ID of the range for the main AD ID mapping.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |                                                     | No            | 4290000000                      |
| `default-domain-mapping-from-id` | Number                       | The first ID of the range for the default AD ID mapping (for trusted domains that have no range defined).                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                                     | No            | 4290000001                      |
| `default-domain-mapping-to-id`   | Number                       | The last ID of the range for the default AD ID mapping (for trusted domains that have no range defined).                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |                                                     | No            | 4291000000                      |
| `encryption`                     | String                       | <p>The global encryption policy to use. </p><p><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</p><p><code>disabled</code> -  doesn't support encrypted connections. </p><p><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections. </p><p><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption will be denied access to the server.</p> | `enabled,` `disabled`, `desired` or `required`      | No            | `enabled`                       |

{% hint style="info" %}
**Note:** To enable HA through IP takeover, all IPs must reside on the same subnet.
{% endhint %}

{% hint style="info" %}
**Note:** The IPs must be configured but **MUST NOT** be in use by any other application/host in the subnet, including Weka system management nodes, Weka system IO nodes, or Weka system NFS floating IPs. In AWS environments, this is not supported and these IPs should not be provided**.**
{% endhint %}

{% hint style="info" %}
**Note:** The `--smb-ips` parameter is supposed to accept the public IPs that the SMB cluster will expose. To mount the SMB cluster in an HA manner, clients should be mounted via one of the exposed public IPs, thereby ensuring that they will automatically reconnect if one of the SMB hosts fails.
{% endhint %}

{% hint style="info" %}
**Note:** If it is necessary to set global options to the SMB library, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).
{% endhint %}

{% hint style="success" %}
**For Example:**

`weka smb cluster create wekaSMB mydomain --samba-hosts 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over the Weka system hosts 0-4. The SMB cluster is called `wekaSMB,`the domain name is called `mydomain`and is directed to use public IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Update the SMB cluster <a href="#update-smb-cluster" id="update-smb-cluster"></a>

**Command:** `weka smb cluster update`

Use the following command line to update an existing SMB cluster:

`weka smb cluster update [--encryption encryption] [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]`

**Parameters**

| **Name**        | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | **Limitations**                                     | **Mandatory** |
| --------------- | ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | ------------- |
| `encryption`    | String                       | <p>The global encryption policy to use. </p><p><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</p><p><code>disabled</code> -  doesn't support encrypted connections. </p><p><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections. </p><p><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption are denied access to the server.</p> | `enabled,` `disabled`, `desired` or `required`      | No            |
| `smb-ips-pool`  | Comma-separated IP addresses | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. The IPs should not be assigned to any host on the network.                                                                                                                                                                                                                                                                                                                                                                                                            | Must be valid IP addresses                          | No            |
| `smb-ips-range` | IP address range             | <p>The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA.<br>The IPs should not be assigned to any host on the network.</p>                                                                                                                                                                                                                                                                                                                                                                                                  | <p>Format: A.B.C.D-E </p><p>E.g., 10.10.0.1-100</p> | No​           |

****

## Check the status of SMB host readiness <a href="#check-status-smb-host-readiness" id="check-status-smb-host-readiness"></a>

**Command:** `weka smb cluster status`

Use this command to check the status of the hosts that are part of the SMB cluster. Once all hosts are prepared and ready, it is possible to join an SMB cluster to an Active Directory.

## Join an SMB cluster in Active Directory <a href="#join-smb-cluster-in-ad" id="join-smb-cluster-in-ad"></a>

**Command:** `weka smb domain join`

Use the following command line to join an SMB domain in an Active Directory:

`weka smb domain join <username> <password>`

**Parameters**

| **Name**   | **Type** | **Value**                                                      | **Limitations**                  | **Mandatory** | **Default** |
| ---------- | -------- | -------------------------------------------------------------- | -------------------------------- | ------------- | ----------- |
| `username` | String   | Name of a user with permissions to add a machine to the domain | Must be a valid name (ASCII)     | Yes           |             |
| `password` | String   | The password of the user                                       | Must be a valid password (ASCII) | Yes           |             |

To join another Active Directory to the current SMB cluster configuration, leaving the current Active Directory is necessary. This is performed using the following command line:

`weka smb domain leave <username> <password>`

On completion of this operation, it is possible to join another Active Directory to the SMB cluster.

## Delete an SMB cluster <a href="#delete-an-smb-cluster" id="delete-an-smb-cluster"></a>

**Command:** `weka smb cluster destroy`

Use this command to destroy an SMB cluster managed by the Weka system.

Deleting an existing SMB cluster managed by the Weka system does not delete the backend Weka filesystems but removes the SMB share exposures of these filesystems.

## Add or remove hosts from an SMB cluster <a href="#add-remove-hosts-from-smb" id="add-remove-hosts-from-smb"></a>

**Command:** `weka smb cluster hosts add`

**Command:** `weka smb cluster hosts remove`

Use these commands to add or remove hosts from the SMB cluster.

{% hint style="info" %}
**Note:** This operation might take some time to complete. During that time, SMB IOs are stalled.
{% endhint %}

## Configure trusted domains <a href="#configure-trusted-domains" id="configure-trusted-domains"></a>

### List trusted domains

**Command:** `weka smb cluster trusted-domains`

Use this command to list all the configured trusted domains and their ID ranges.

### Add trusted domains

**Command:** `weka smb cluster trusted-domains add`

Use the following command line to add an SMB trusted domain:

`weka smb cluster trusted-domains add <domain-name> <from-id> <to-id>`

**Parameters**

| **Name**      | **Type** | **Value**                                           | **Limitations**                             | **Mandatory** | **Default** |
| ------------- | -------- | --------------------------------------------------- | ------------------------------------------- | ------------- | ----------- |
| `domain-name` | String   | The name of the domain being added                  | Must be a valid name (ASCII)                | Yes           |             |
| `from-id`     | Number   | The first ID of the range for the domain ID mapping | The range cannot overlap with other domains | Yes           |             |
| `to-id`       | Number   | The last ID of the range for the domain ID mapping  | The range cannot overlap with other domains | Yes           |             |

### Remove trusted domains

**Command:** `weka smb cluster trusted-domains remove`

Use the following command line to remove an SMB trusted domain:

`weka smb cluster trusted-domains remove <domain-id>`

**Parameters**

| **Name**    | **Type** | **Value**                               | **Limitations** | **Mandatory** | **Default** |
| ----------- | -------- | --------------------------------------- | --------------- | ------------- | ----------- |
| `domain-id` | Number   | The internal ID of the domain to remove |                 | Yes           |             |

## List SMB shares <a href="#list-smb-shares" id="list-smb-shares"></a>

**Command:** `weka smb share`

Use this command to list all existing SMB shares.

## Add an SMB share <a href="#add-an-smb-share" id="add-an-smb-share"></a>

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed to SMB:

`weka smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [--mount-option mount-option] [--file-create-mask file-create-mask] [--directory-create-mask directory-create-mask] [--obs-direct obs-direct] [--encryption encryption] [--read-only read-only] [--user-list-type user-list-type] [--users users]... [--allow-guest-access allow-guest-access] [--hidden hidden]`

**Parameters**

| **Name**                | **Type**                          | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | **Mandatory** | **Default**       |
| ----------------------- | --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------------- |
| `share-name`            | String                            | Name of the share being added                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Must be a valid name (ASCII)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Yes           | ​                 |
| `fs-name`               | String                            | Name of the filesystem to share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Must be a valid name                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Yes           | ​                 |
| `description`           | String                            | Description of what the share will receive when viewed remotely                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Must be a valid string                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | No            | ​                 |
| `internal-path`         | String                            | The internal path within the filesystem (relative to its root) which will be exposed                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Must be a valid path                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | No            | .                 |
| `mount-option`          | String                            | The mount mode for the share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `readcache` or `writecache`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | No            | `writecache`      |
| `file-create-mask`      | String                            | POSIX permissions for the file created through the SMB share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Numeric (octal) notation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | No            | 0744              |
| `directory-create-mask` | String                            | POSIX permissions for directories created through the SMB share                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Numeric (octal) notation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | No            | 0755              |
| `acl`                   | String                            | Enable Windows ACLs on the share (which will be translated to POSIX)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | <p><code>on</code> or <code>off;</code></p><p>Up to 16 ACEs per file</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                  | No            | `off`             |
| `obs-direct`            | String                            | See [Object-store Direct Mount](../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option) section                                                                                                                                                                                                                                                                                                                                                                                                           | `on` or `off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | No            | `off`             |
| `encryption`            | String                            | <p></p><p>The share encryption policy.</p><p><code>cluster_default:</code> The he share encryption policy follows the global SMB cluster setting.  </p><p><code>desired</code>: If negotiation is enabled globally, it turns on data encryption for this share for clients that support encryption.</p><p><code>required</code>:  Enforces encryption for the shares. Clients that do not support encryption are denied when accessing the share. If the global option is <code>disabled</code>, the access is restricted to these shares for all clients.</p> | `cluster_default` `desired` or `required`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | No            | `cluster_default` |
| `read-only`             | String                            | Sets the share as read-only. Users cannot create or modify files in this share.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `on` or `off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | No            | `off`             |
| `user-list-type`        | String                            | The type of initial permissions list for `users`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | <p><code>read_only</code> : List of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>: List of users that are given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> : List of users that are  allowed to log-in to this share SMB service (empty list all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | No            |                   |
| `users`                 | A comma-separated list of Strings | A list of users to use with the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins`                                                                                                                                                                                                                                                                                                                                                                                                                    | Up to 8 users/groups  for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | No            | Empty list        |
| `allow-guest-access`    | String                            |  Allows connecting to the SMB service without a password. Permissions are as the `nobody` user account permissions.                                                                                                                                                                                                                                                                                                                                                                                                                                            | `on` or`off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | No            | `off`             |
| `hidden`                | String                            | Sets the share as non-browsable. It will be accessible for mounting and IOs but not discoverable by SMB clients.                                                                                                                                                                                                                                                                                                                                                                                                                                               | `on` or `off`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | No            | `off`             |

{% hint style="info" %}
**Note:** If it is necessary to set a share with specific options to the SMB library, contact Weka support.
{% endhint %}

{% hint style="success" %}
**Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default`  \
`weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first SMB share added has the Weka system share for default. The second SMB share has internal for default.
{% endhint %}

## Update SMB shares <a href="#update-smb-shares" id="update-smb-shares"></a>

**Command:** `weka smb share update`

Use the following command line to update an existing share:

`weka smb share update <share-id> [--encryption encryption]`

**Parameters**

| **Name**             | **Type** | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Limitations**                           | **Mandatory** | **Default** |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- | ------------- | ----------- |
| `share-id`           | Number   | The ID of the share to be updated                                                                                                                                                                                                                                                                                                                                                                                                               | Must be a valid share ID                  | Yes           | ​           |
| `encryption`         | String   | <p>The share encryption policy.</p><p><code>desired</code> - turns on data encryption for this share for clients that support encryption if negotiation has been enabled globally.</p><p><code>required</code> - enforces encryption for the shares. Clients that do not support encryption will be denied access to the share. If the global option is set to <code>disabled</code> access will be denied to these shares for all clients.</p> | `cluster_default` `desired` or `required` | No            |             |
| `read-only`          | String   | Mount the SMB share  as read-only.                                                                                                                                                                                                                                                                                                                                                                                                              | `on` or `off`                             | No            |             |
| `allow-guest-access` | String   | Allow guest access                                                                                                                                                                                                                                                                                                                                                                                                                              | `on` or `off`                             | No            |             |
| `hidden`             | String   | Hide the the SMB share.                                                                                                                                                                                                                                                                                                                                                                                                                         | `on` or `off`                             | StringNo      |             |

## **Control SMB share user-lists** <a href="#control-smb-share-user-lists" id="control-smb-share-user-lists"></a>

**Command:** `weka smb share lists show`

Use this command to view the various user-list settings.

****

**Command:** `weka smb share lists add`

Use the following command line to add users to a share user-list:

`weka smb share lists add <share-id> <user-list-type> <--users users>...`

**Parameters**

| **Name**         | **Type**                          | **Value**                                                                                                                                 | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default** |
| ---------------- | --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `share-id`       | Number                            | The ID of the share to be updated                                                                                                         | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Yes           |             |
| `user-list-type` | String                            | The type of permissions list for `users`                                                                                                  | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |
| `users`          | A comma-separated list of Strings | A list of users to add to the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins` | Up to 8 users/groups  for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Yes           |             |

****

**Command:** `weka smb share lists remove`

Use the following command line to remove users from a share user-list:

`weka smb share lists remove <share-id> <user-list-type> <--users users>...`

**Parameters**

| **Name**         | **Type**                          | **Value**                                                                                                                                      | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default** |
| ---------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `share-id`       | Number                            | The ID of the share to be updated                                                                                                              | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Yes           |             |
| `user-list-type` | String                            | The type of permissions list for `users`                                                                                                       | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |
| `users`          | A comma-separated list of Strings | A list of users to remove from the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins` | Up to 8 users/groups  for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Yes           |             |

****

**Command:** `weka smb share lists reset`

Use the following command line to remove all users from a share user-list:

`weka smb share lists reset <share-id> <user-list-type>`

**Parameters**

| **Name**         | **Type** | **Value**                              | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | **Mandatory** | **Default** |
| ---------------- | -------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `share-id`       | Number   | The ID of the share to be updated      | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Yes           |             |
| `user-list-type` | String   | The type of permissions list to reset  | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are  allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |

## Remove SMB shares <a href="#remove-smb-shares" id="remove-smb-shares"></a>

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`weka smb share remove <share-id>`

**Parameters**

| **Name**   | **Type** | **Value**                         | **Limitations**          | **Mandatory** | **Default** |
| ---------- | -------- | --------------------------------- | ------------------------ | ------------- | ----------- |
| `share-id` | String   | The ID of the share to be removed | Must be a valid share ID | Yes           | ​           |

{% hint style="success" %}
**Example:** The following is an example for removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## Control SMB access based on hosts IP/name <a href="#control-smb-access-based-on-ip" id="control-smb-access-based-on-ip"></a>

It is possible to control which hosts are permitted to access the SMB service or share.

**Command:** `weka smb cluster host-access show` / `weka smb share host-access show`

Use this command to view the various host-access settings.



**Command:** `weka smb cluster host-access add` / `weka smb share host-access add`

Use the following command line to add hosts to the allow/deny list (in either cluster-level or share-level):

`weka smb cluster host-access add <mode> <--ips ips> <--hosts hosts>` ****&#x20;

`weka smb share host-access add <share-id> <mode> <--ips ips> <--hosts hosts>`

**Parameters**

| **Name**   | **Type**                          | **Value**                         | **Limitations**                                                                                                                                                             | **Mandatory**                                  | **Default** |
| ---------- | --------------------------------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- | ----------- |
| `share-id` | Number                            | The ID of the share to be updated | Must be a valid share ID                                                                                                                                                    | Yes (for the share-level command)              |             |
| `mode`     | String                            | The access mode of the host       | `allow` or `deny`                                                                                                                                                           | Yes                                            |             |
| `ips`      | A Comma-separated list of IPs     | Host IPs to allow/deny            | <p>Supports the following format to provide multiple IPs: </p><p><code>192.</code></p><p><code>192.168.</code><br><code>192.168.1</code><br><code>192.168.1.1/24</code></p> | Must provide at least one of: `ips` or `hosts` |             |
| `hosts`    | A Comma-separated list of strings | Host names to allow/deny          |                                                                                                                                                                             | Must provide at least one of: `ips` or `hosts` |             |



**Command:** `weka smb cluster host-access remove` / `weka smb share host-access remove`

Use the following command line to remove hosts from the allow/deny list (in either cluster-level or share-level):

`weka smb cluster host-access remove <hosts>` ****&#x20;

`weka smb share host-access remove <share-id> <hosts>`

**Parameters**

| **Name**   | **Type**                      | **Value**                                     | **Limitations**                                                                              | **Mandatory**                     | **Default** |
| ---------- | ----------------------------- | --------------------------------------------- | -------------------------------------------------------------------------------------------- | --------------------------------- | ----------- |
| `share-id` | Number                        | The ID of the share to be updated             | Must be a valid share ID                                                                     | Yes (for the share-level command) |             |
| `hosts`    | Space-separated list of hosts | The hosts to remove from the host-access list | Must be the exact name as shown under the `HOSTNAME` column in the equivalent `list` command | Yes                               |             |



**Command:** `weka smb cluster host-access reset` / `weka smb share host-access reset`

Use the following command line to remove all hosts from the allow/deny list (in either cluster-level or share-level):

`weka smb cluster host-access reset <mode>` **** `weka smb share host-access reset <share-id> <mode>`

**Parameters**

| **Name**   | **Type** | **Value**                                                     | **Limitations**          | **Mandatory**                     | **Default** |
| ---------- | -------- | ------------------------------------------------------------- | ------------------------ | --------------------------------- | ----------- |
| `share-id` | Number   | The ID of the share to be updated                             | Must be a valid share ID | Yes (for the share-level command) |             |
| `mode`     | String   | All hosts with this access-mode will be removed from the list | `allow` or `deny`        | Yes                               |             |
