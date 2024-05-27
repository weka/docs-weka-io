---
description: >-
  This page provides procedures for setting up an SMB cluster over WEKA
  filesystems and managing the cluster itself, using the CLI.
---

# Manage SMB using the CLI

Using the CLI, you can manage both the SMB-W and legacy SMB:

* [Show the SMB cluster](smb-management-using-the-cli.md#show-the-smb-cluster)
* [Show the SMB domain configuration](smb-management-using-the-cli.md#show-smb-domain-cfg)
* [Create the SMB cluster](smb-management-using-the-cli.md#create-smb-cluster)
* [Update the SMB cluster](smb-management-using-the-cli.md#update-smb-cluster)
* [Check the status of SMB cluster readiness](smb-management-using-the-cli.md#check-status-smb-host-readiness)
* [Join an SMB cluster in Active Directory](smb-management-using-the-cli.md#join-smb-cluster-in-ad)
* [Delete an SMB cluster](smb-management-using-the-cli.md#delete-an-smb-cluster)
* [Add or remove SMB cluster containers](smb-management-using-the-cli.md#add-or-remove-smb-cluster-hosts)
* [Configure trusted domains](smb-management-using-the-cli.md#configure-trusted-domains)
* [List SMB shares](smb-management-using-the-cli.md#list-smb-shares)
* [Add an SMB share](smb-management-using-the-cli.md#add-an-smb-share)
* [Update SMB shares](smb-management-using-the-cli.md#update-smb-shares)
* [Control SMB share user-lists](smb-management-using-the-cli.md#control-smb-share-user-lists)
* [Remove SMB shares](smb-management-using-the-cli.md#remove-smb-shares)
* [Control SMB access based on hosts IP/name](smb-management-using-the-cli.md#control-smb-access-based-on-ip)

## Show the SMB cluster <a href="#show-the-smb-cluster" id="show-the-smb-cluster"></a>

**Command:** `weka smb cluster`

Use this command to view information about the SMB cluster managed by the WEKA system.

## Show the SMB domain configuration <a href="#show-smb-domain-cfg" id="show-smb-domain-cfg"></a>

**Command:** `weka smb domain`

Use this command to view information about the SMB domain configuration.

## Create the SMB cluster <a href="#create-smb-cluster" id="create-smb-cluster"></a>

**Command:** `weka smb cluster create`

Use the following command line to create a new SMB cluster to be managed by the WEKA system:

`weka smb cluster create <netbios-name> <domain> [--domain-netbios-name domain-netbios-name] [--idmap-backend idmap-backend] [--default-domain-mapping-from-id default-domain-mapping-from-id] [--default-domain-mapping-to-id default-domain-mapping-to-id] [--joined-domain-mapping-from-id joined-domain-mapping-from-id] [--joined-domain-mapping-to-id joined-domain-mapping-to-id] [--encryption encryption] [--smb-conf-extra smb-conf-extra] [--container-ids container-ids]... [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]...`

{% hint style="info" %}
To create an SMB-W cluster, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

{% hint style="warning" %}
**Note:** As a best practice, it is recommended to have only one of the following protocol containers, NFS, SMB, or S3, installed on the same server. Starting from version 4.2, setting more than one additional protocol to the existing POSIX is not allowed.
{% endhint %}

**Parameters**

| **Name**                         | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | **Limitations**                                                                                                                                                                                 | **Mandatory** | **Default**                              |
| -------------------------------- | ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ---------------------------------------- |
| `netbios-name`                   | String                       | NetBIOS name for the SMB cluster                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Must be a valid name (ASCII)                                                                                                                                                                    | Yes           |                                          |
| `domain`                         | String                       | The domain to join the SMB cluster to                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Must be a valid name (ASCII)                                                                                                                                                                    | Yes           | ​                                        |
| `domain-netbios-name`            | String                       | Domain NetBIOS name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Must be a valid name (ASCII)                                                                                                                                                                    | No            | The first part of the `domain` parameter |
| `idmap-backend`                  | String                       | The ID mapping method to use.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | <p>SMB-W: <code>rfc2307</code><br><br>Legacy SMB: <code>rfc2307</code> or <code>rid</code></p>                                                                                                  | No            | `rfc2307`                                |
| `default-domain-mapping-from-id` | Number                       | The last ID of the range for the default AD ID mapping (for trusted domains that have no range defined).                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Not supported in SMB-W yet                                                                                                                                                                      | No            | 4290000000                               |
| `joined-domain-mapping-from-id`  | Number                       | The first ID of the range for the main AD ID mapping.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | None                                                                                                                                                                                            | No            | 4290000000                               |
| `joined-domain-mapping-to-id`    | Number                       | The last ID of the range for the main AD ID mapping.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | None                                                                                                                                                                                            | No            | 4290000001                               |
| `encryption`                     | String                       | <p>The global encryption policy to use.</p><p><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</p><p><code>disabled</code> - doesn't support encrypted connections.</p><p><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections.</p><p><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption will be denied access to the server.</p> | <p>SMB-W: <code>enabled,</code> <code>desired</code> or <code>required</code><br><br>Legacy SMB: <code>enabled,</code> <code>disabled</code>, <code>desired</code> or <code>required</code></p> | No            | `enabled`                                |
| `smb-conf-extra`                 | String                       | Additional SMB configuration options.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | None                                                                                                                                                                                            | No            |                                          |
| `container-ids`                  | Number                       | The container IDS of the containers with the frontend process to serve the SMB service.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Minimum of 3 containers                                                                                                                                                                         |               |                                          |
| `smb-ips-pool`                   | Comma-separated IP addresses | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. Do not assign these IPs to any server on the network.                                                                                                                                                                                                                                                                                                                                                                                                                 | Must be valid IP addresses                                                                                                                                                                      | No            |                                          |
| `smb-ips-range`                  | IP address range             | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. Do not assign these IPs to any server on the network.                                                                                                                                                                                                                                                                                                                                                                                                                 | <p>Format: A.B.C.D-E</p><p>Example: 10.10.0.1-100</p>                                                                                                                                           | No            |                                          |

{% hint style="info" %}
**Note:** To enable HA through IP takeover, all IPs must reside on the same subnet.
{% endhint %}

{% hint style="info" %}
**Note:** The IPs must be configured but **MUST NOT** be in use by any other application/server in the subnet, including WEKA system management nodes, WEKA system IO nodes, or WEKA system NFS floating IPs. In AWS environments, this is not supported and these IPs should not be provided\*\*.\*\*
{% endhint %}

{% hint style="info" %}
**Note:** The `--smb-ips` parameter is supposed to accept the public IPs that the SMB cluster will expose. To mount the SMB cluster in an HA manner, clients should be mounted via one of the exposed public IPs, thereby ensuring that they will automatically reconnect if one of the SMB containers fails.
{% endhint %}

{% hint style="info" %}
**Note:** If it is necessary to set global options to the SMB library, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).
{% endhint %}

{% hint style="success" %}
**For Example:**

`weka smb cluster create wekaSMB mydomain --container-ids 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over the WEKA system containers 0-4. The SMB cluster is called `wekaSMB,`the domain name is called `mydomain`and is directed to use public IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Update the SMB cluster <a href="#update-smb-cluster" id="update-smb-cluster"></a>

**Command:** `weka smb cluster update`

Use the following command line to update an existing SMB cluster:

`weka smb cluster update [--encryption encryption] [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]`

**Parameters**

| **Name**        | **Type**                     | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | **Limitations**                                                                                                                                                                                 | **Mandatory** |
| --------------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| `encryption`    | String                       | <p>The global encryption policy to use.</p><p><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</p><p><code>disabled</code> - doesn't support encrypted connections.</p><p><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections.</p><p><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption are denied access to the server.</p> | <p>SMB-W: <code>enabled,</code> <code>desired</code> or <code>required</code><br><br>Legacy SMB: <code>enabled,</code> <code>disabled</code>, <code>desired</code> or <code>required</code></p> | No            |
| `smb-ips-pool`  | Comma-separated IP addresses | The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. The IPs should not be assigned to any host on the network.                                                                                                                                                                                                                                                                                                                                                                                                        | Must be valid IP addresses                                                                                                                                                                      | No            |
| `smb-ips-range` | IP address range             | <p>The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA.<br>Do not assign IPs to any host on the network.</p>                                                                                                                                                                                                                                                                                                                                                                                                           | <p>Format: A.B.C.D-E</p><p>E.g., 10.10.0.1-100</p>                                                                                                                                              | No​           |

***

## Check the status of SMB cluster readiness <a href="#check-status-smb-host-readiness" id="check-status-smb-host-readiness"></a>

**Command:** `weka smb cluster status`

The SMB cluster is comprised of a few SMB containers. Use this command to check the status of the SMB containers that are part of the SMB cluster. Once all the SMB containers are prepared and ready, it is possible to join an SMB cluster to an Active Directory.

## Join an SMB cluster in Active Directory <a href="#join-smb-cluster-in-ad" id="join-smb-cluster-in-ad"></a>

**Command:** `weka smb domain join`

Use the following command line to join an SMB domain in an Active Directory:

`weka smb domain join <username> <password> [--server server] [--create-computer create-computer]`

**Parameters**

| **Name**          | **Type** | **Value**                                                                                                                                                                   | **Limitations**                                      | **Mandatory** | **Default**                                                      |
| ----------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | ------------- | ---------------------------------------------------------------- |
| `username`        | String   | Name of a user with permission to add a server to the domain.                                                                                                               | Must be a valid name (ASCII)                         | Yes           |                                                                  |
| `password`        | String   | The password of the user.                                                                                                                                                   | Must be a valid password (ASCII)                     | Yes           |                                                                  |
| `server`          | String   | Weka identifies the AD server automatically based on the AD name. You do not need to set the server name. In some cases, if required, specify the AD server.                | <p>Must be valid<br>Not applicable for SMB-W yet</p> | No            | The AD server is automatically identified based on the AD name.  |
| `create-computer` | String   | The default organization unit is the Computers directory. You can define any other directory to connect to in Active Directory, such as SMB servers or Corporate computers. | <p>Must be valid<br>Not applicable for SMB-W yet</p> | No            | The computer's directory                                         |

To join the SMB cluster to another Active Directory, leave the current Active Directory using the following command line:

`weka smb domain leave <username> <password>`

On completion of this operation, it is possible to join the SMB cluster to another Active Directory.

## Delete an SMB cluster <a href="#delete-an-smb-cluster" id="delete-an-smb-cluster"></a>

**Command:** `weka smb cluster destroy`

Use this command to destroy an SMB cluster managed by the Weka system.

Deleting an existing SMB cluster managed by the Weka system does not delete the backend Weka filesystems but removes the SMB share exposures of these filesystems.

## Add or remove SMB cluster containers <a href="#add-or-remove-smb-cluster-hosts" id="add-or-remove-smb-cluster-hosts"></a>

**Command:** `weka smb cluster containers add`

**Command:** `weka smb cluster containers remove`

Use these commands to add or remove containers from the SMB cluster.

`weka smb cluster containers add [--containers-id containers-id]...`

`weka smb cluster containers remove [--containers-id containers-id]...`

{% hint style="info" %}
**Note:** This operation might take some time to complete. During that time, SMB IOs are stalled.
{% endhint %}

**Parameters**

| **Name**        | **Type**                | **Value**                                                                     | **Limitations**                           | **Mandatory** | **Default** |
| --------------- | ----------------------- | ----------------------------------------------------------------------------- | ----------------------------------------- | ------------- | ----------- |
| `containers-id` | Comma-separated strings | Container IDs of containers with a frontend process to serve the SMB service. | Minimum of 3 containers must be supplied. | Yes           |             |

## Configure trusted domains <a href="#configure-trusted-domains" id="configure-trusted-domains"></a>

{% hint style="info" %}
**Note:** SMB-W does not yet support trusted domains.
{% endhint %}

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

Use the following command line to remove an SMB-trusted domain:

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

`weka smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [--file-create-mask file-create-mask] [--directory-create-mask directory-create-mask] [--obs-direct obs-direct] [--encryption encryption] [--read-only read-only] [--user-list-type user-list-type] [--users users]... [--allow-guest-access allow-guest-access] [--hidden hidden]`

{% hint style="info" %}
The mount mode for the SMB share is `readcache` and cannot be modified.
{% endhint %}

**Parameters**

<table data-header-hidden><thead><tr><th width="188"></th><th></th><th width="191"></th><th width="224"></th><th width="129"></th><th></th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>share-name</code></td><td>String</td><td>Name of the share being added</td><td>Must be a valid name (ASCII)<br><br>SMB-W: cannot create the same share name with different case insensitivity.</td><td>Yes</td><td>​</td></tr><tr><td><code>fs-name</code></td><td>String</td><td>Name of the filesystem to share</td><td>Must be a valid name.<br>A filesystem set with required authentication cannot be used for SMB share.</td><td>Yes</td><td>​</td></tr><tr><td><code>description</code></td><td>String</td><td>Description of what the share will receive when viewed remotely</td><td>Must be a valid string</td><td>No</td><td>​</td></tr><tr><td><code>internal-path</code></td><td>String</td><td>The internal path within the filesystem (relative to its root) which will be exposed</td><td>Must be a valid path</td><td>No</td><td>.</td></tr><tr><td><code>file-create-mask</code></td><td>String</td><td>POSIX permissions for the file created through the SMB share</td><td>Numeric (octal) notation</td><td>No</td><td>0744</td></tr><tr><td><code>directory-create-mask</code></td><td>String</td><td>POSIX permissions for directories created through the SMB share</td><td>Numeric (octal) notation.<br><br>SMB-W: the specified string must be greater or equal to 0600.</td><td>No</td><td>0755</td></tr><tr><td><code>acl</code></td><td>String</td><td>Enable Windows ACLs on the share (which will be translated to POSIX)</td><td><p><code>on</code> or <code>off;</code></p><p>Up to 16 ACEs per file</p></td><td>No</td><td><code>off</code></td></tr><tr><td><code>obs-direct</code></td><td>String</td><td>See <a href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a> section</td><td>Legacy SMB: <code>on</code> or <code>off</code><br><br>SMB-W: not supported</td><td>No</td><td><code>off</code></td></tr><tr><td><code>encryption</code></td><td>String</td><td><p>The share encryption policy.</p><p><code>cluster_default:</code> The he share encryption policy follows the global SMB cluster setting.</p><p><code>desired</code>: If negotiation is enabled globally, it turns on data encryption for this share for clients that support encryption.</p><p><code>required</code>: Enforces encryption for the shares. Clients that do not support encryption are denied when accessing the share. If the global option is <code>disabled</code>, the access is restricted to these shares for all clients.</p></td><td>SMB-W: <code>cluster_default</code><br><br>Legacy SMB: <code>cluster_default</code> , <code>desired</code> or <code>required</code></td><td>No</td><td><code>cluster_default</code></td></tr><tr><td><code>read-only</code></td><td>String</td><td>Sets the share as read-only. Users cannot create or modify files in this share.</td><td><code>on</code> or <code>off</code></td><td>No</td><td><code>off</code></td></tr><tr><td><code>user-list-type</code></td><td>String</td><td>The type of initial permissions list for <code>users</code></td><td><p>SMB-W: not supported<br><br>Legacy SMB:<br><code>read_only</code> : List of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.<br><code>read_write</code>: List of users that are given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> : List of users that are allowed to log-in to this share SMB service (empty list all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p></td><td>No</td><td></td></tr><tr><td><code>users</code></td><td>A comma-separated list of Strings</td><td>A list of users to use with the <code>user-list-type</code> list. Can use the <code>@</code> notation to allow groups of users, e.g. <code>root, Jack, @domain\admins</code></td><td>SMB-W: not supported<br><br>Legacy SMB: Up to 8 users/groups for all lists combined per share</td><td>No</td><td>Empty list</td></tr><tr><td><code>allow-guest-access</code></td><td>String</td><td>Allows connecting to the SMB service without a password. Permissions are as the <code>nobody</code> user account permissions.</td><td>Legacy SMB: <code>on</code> or <code>off</code><br>SMB-W: not supported</td><td>No</td><td><code>off</code></td></tr><tr><td><code>hidden</code></td><td>String</td><td>Sets the share as non-browsable. It will be accessible for mounting and IOs but not discoverable by SMB clients.</td><td><code>on</code> or <code>off</code></td><td>No</td><td><code>off</code></td></tr></tbody></table>

{% hint style="info" %}
**Note:** If it is necessary to set a share with specific options to the SMB library, contact Weka support.
{% endhint %}

{% hint style="success" %}
**Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default`\
`weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first SMB share added has the Weka system share for default. The second SMB share has internal for default.
{% endhint %}

## Update SMB shares <a href="#update-smb-shares" id="update-smb-shares"></a>

**Command:** `weka smb share update`

Use the following command line to update an existing share:

`weka smb share update <share-id> [--encryption encryption] [--read-only read-only] [--allow-guest-access allow-guest-access] [--hidden hidden]`

{% hint style="info" %}
**Note:** SMB-W does not yet support share update.
{% endhint %}

**Parameters**

| **Name**             | **Type** | **Value**                                                                                                                                                                                                                                                                                                                                                                                                                                       | **Limitations**                           | **Mandatory** | **Default** |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- | ------------- | ----------- |
| `share-id`           | Number   | The ID of the share to update                                                                                                                                                                                                                                                                                                                                                                                                                   | Must be a valid share ID                  | Yes           | ​           |
| `encryption`         | String   | <p>The share encryption policy.</p><p><code>desired</code> - turns on data encryption for this share for clients that support encryption if negotiation has been enabled globally.</p><p><code>required</code> - enforces encryption for the shares. Clients that do not support encryption will be denied access to the share. If the global option is set to <code>disabled</code> access will be denied to these shares for all clients.</p> | `cluster_default` `desired` or `required` | No            |             |
| `read-only`          | String   | Mount the SMB share as read-only.                                                                                                                                                                                                                                                                                                                                                                                                               | `on` or `off`                             | No            |             |
| `allow-guest-access` | String   | Allow guest access                                                                                                                                                                                                                                                                                                                                                                                                                              | `on` or `off`                             | No            |             |
| `hidden`             | String   | Hide the the SMB share.                                                                                                                                                                                                                                                                                                                                                                                                                         | `on` or `off`                             | StringNo      |             |

## **Control SMB share user-lists** <a href="#control-smb-share-user-lists" id="control-smb-share-user-lists"></a>

{% hint style="info" %}
**Note:** SMB-W does not yet support share user-lists.
{% endhint %}

**Command:** `weka smb share lists show`

Use this command to view the various user-list settings.

***

**Command:** `weka smb share lists add`

Use the following command line to add users to a share user-list:

`weka smb share lists add <share-id> <user-list-type> <--users users>...`

**Parameters**

| **Name**         | **Type**                          | **Value**                                                                                                                                 | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | **Mandatory** | **Default** |
| ---------------- | --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ----------- |
| `share-id`       | Number                            | The ID of the share to be updated                                                                                                         | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Yes           |             |
| `user-list-type` | String                            | The type of permissions list for `users`                                                                                                  | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |
| `users`          | A comma-separated list of Strings | A list of users to add to the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins` | Up to 8 users/groups for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Yes           |             |

***

**Command:** `weka smb share lists remove`

Use the following command line to remove users from a share user-list:

`weka smb share lists remove <share-id> <user-list-type> <--users users>...`

**Parameters**

| **Name**         | **Type**                          | **Value**                                                                                                                                      | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | **Mandatory** | **Default** |
| ---------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ----------- |
| `share-id`       | Number                            | The ID of the share to be updated                                                                                                              | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Yes           |             |
| `user-list-type` | String                            | The type of permissions list for `users`                                                                                                       | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |
| `users`          | A comma-separated list of Strings | A list of users to remove from the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins` | Up to 8 users/groups for all lists combined per share                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Yes           |             |

***

**Command:** `weka smb share lists reset`

Use the following command line to remove all users from a share user-list:

`weka smb share lists reset <share-id> <user-list-type>`

**Parameters**

| **Name**         | **Type** | **Value**                             | **Limitations**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | **Mandatory** | **Default** |
| ---------------- | -------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ----------- |
| `share-id`       | Number   | The ID of the share to be updated     | Must be a valid share ID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Yes           |             |
| `user-list-type` | String   | The type of permissions list to reset | <p><code>read_only</code> - list of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>read_write</code>- list of users that will be given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> - list of users that are allowed to log-in to this share SMB service (empty list - all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p> | Yes           |             |

## Remove SMB shares <a href="#remove-smb-shares" id="remove-smb-shares"></a>

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`weka smb share remove <share-id>`

**Parameters**

| **Name**   | **Type** | **Value**                         | **Limitations**          | **Mandatory** | **Default** |
| ---------- | -------- | --------------------------------- | ------------------------ | ------------- | ----------- |
| `share-id` | String   | The ID of the share to be removed | Must be a valid share ID | Yes           | ​           |

{% hint style="success" %}
**Example:** The following is an example of removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## Control SMB access based on hosts' IP/name <a href="#control-smb-access-based-on-hosts" id="control-smb-access-based-on-hosts"></a>

It is possible to control which hosts are permitted to access the SMB service or share.

{% hint style="info" %}
**Note:** SMB-W does not yet support access based on hosts' IP/name.
{% endhint %}

**Command:** `weka smb cluster host-access list`

`weka smb share host-access list`

Use this command to view the various host access settings.

**Command:** `weka smb cluster host-access add`

`weka smb share host-access add`

Use the following command line to add a host to the allow/deny list (at either cluster level or share level):

`weka smb cluster host-access add <mode> <--ips ips> <--hosts hosts>`

`weka smb share host-access add <share-id> <mode> <--ips ips> <--hosts hosts>`

**Parameters**

| **Name**   | **Type**                          | **Value**                          | **Limitations**                                                                                                                                                            | **Mandatory**                                       | **Default** |
| ---------- | --------------------------------- | ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | ----------- |
| `share-id` | Number                            | The ID of the share to be updated  | Must be a valid share ID                                                                                                                                                   | Yes (for the share-level command)                   |             |
| `mode`     | String                            | The access mode of the host        | `allow` or `deny`                                                                                                                                                          | Yes                                                 |             |
| `ips`      | A Comma-separated list of IPs     | Host IP addresses to allow or deny | <p>Supports the following format to provide multiple IPs:</p><p><code>192.</code></p><p><code>192.168.</code><br><code>192.168.1</code><br><code>192.168.1.1/24</code></p> | Must provide at least one of: `ips` or `containers` |             |
| `hosts`    | A Comma-separated list of strings | Host names to allow/deny           |                                                                                                                                                                            | Must provide at least one of: `ips` or `containers` |             |

**Command:** `weka smb cluster host-access remove` / `weka smb share host-access remove`

Use the following command line to remove hosts from the allow or deny list (at either cluster level or share level):

`weka smb cluster host-access remove <hosts>`

`weka smb share host-access remove <share-id> <hosts>`

**Parameters**

| **Name**   | **Type**                      | **Value**                                     | **Limitations**                                                                              | **Mandatory**                     | **Default** |
| ---------- | ----------------------------- | --------------------------------------------- | -------------------------------------------------------------------------------------------- | --------------------------------- | ----------- |
| `share-id` | Number                        | The ID of the share to be updated             | Must be a valid share ID                                                                     | Yes (for the share-level command) |             |
| `hosts`    | Space-separated list of hosts | The hosts to remove from the host-access list | Must be the exact name as shown under the `HOSTNAME` column in the equivalent `list` command | Yes                               |             |

**Command:** `weka smb cluster host-access reset`

`weka smb share host-access reset`

Use the following command line to remove all containers from the allow or deny list (at either cluster level or share level):

`weka smb cluster host-access reset <mode>`

`weka smb share host-access reset <share-id> <mode>`

**Parameters**

| **Name**   | **Type** | **Value**                                                     | **Limitations**          | **Mandatory**                     | **Default** |
| ---------- | -------- | ------------------------------------------------------------- | ------------------------ | --------------------------------- | ----------- |
| `share-id` | Number   | The ID of the share to be updated                             | Must be a valid share ID | Yes (for the share-level command) |             |
| `mode`     | String   | All hosts with this access mode will be removed from the list | `allow` or `deny`        | Yes                               |             |
