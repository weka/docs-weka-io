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
**Note:** To create an SMB-W cluster, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

**Parameters**

| Name                             | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Default                                  |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| `netbios-name`\*                 | NetBIOS name for the SMB cluster                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |                                          |
| `domain`\*                       | The domain to join the SMB cluster to                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ​                                        |
| `domain-netbios-name`            | Domain NetBIOS name.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | The first part of the `domain` parameter |
| `idmap-backend`                  | <p>The ID mapping method to use.<br><br>SMB-W possible values: <code>rfc2307</code><br><br>Legacy SMB possible values: <code>rfc2307</code> or <code>rid</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `rfc2307`                                |
| `default-domain-mapping-from-id` | <p>The last ID of the range for the default AD ID mapping (for trusted domains that have no range defined).<br>Not supported in SMB-W yet.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 4290000000                               |
| `joined-domain-mapping-from-id`  | The first ID of the range for the main AD ID mapping.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 4290000000                               |
| `joined-domain-mapping-to-id`    | The last ID of the range for the main AD ID mapping.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 4290000001                               |
| `encryption`                     | <p>The global encryption policy to use:</p><p><br><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</p><p><br><code>disabled</code> - doesn't support encrypted connections.</p><p><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections.</p><p><br><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption will be denied access to the server.<br><br>SMB-W possible values: <code>enabled,</code> <code>desired</code> or <code>required</code><br><br>Legacy SMB possible values: <code>enabled,</code> <code>disabled</code>, <code>desired</code> or <code>required</code></p> | `enabled`                                |
| `smb-conf-extra`                 | Additional SMB configuration options.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |                                          |
| `container-ids`                  | <p>The container IDS of the containers with the frontend process to serve the SMB service.<br>Minimum of 3 containers.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |                                          |
| `smb-ips-pool`                   | <p>The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. Do not assign these IPs to any server on the network.<br>Format: comma-separated IP addresses</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |                                          |
| `smb-ips-range`                  | <p>The public IPs range used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. Do not assign these IPs to any server on the network.<br>Format: <code>A.B.C.D-E</code><br>Example: <code>10.10.0.1-100</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |                                          |

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

| Name            | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `encryption`    | <p>The global encryption policy to use:</p><p><br><code>enabled</code>: enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.<br><br><code>disabled</code>: doesn't support encrypted connections.<br><br><code>desired</code>: enables encryption negotiation and turns on data encryption on supported sessions and share connections.<br><br><code>required</code>: enforces data encryption on sessions and share connections. Clients that do not support encryption are denied access to the server.<br><br>Possible values in SMB-W: <code>enabled,</code> <code>desired</code> or <code>required</code><br><br>Possible values in legacy SMB: <code>enabled,</code> <code>disabled</code>, <code>desired</code> or <code>required</code></p> |
| `smb-ips-pool`  | <p>The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA. The IPs must not be assigned to any host on the network.<br>Format: comma-separated IP addresses.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `smb-ips-range` | <p>The public IPs used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA.<br>Do not assign IPs to any host on the network.<br>Format: A.B.C.D-E<br>Example: 10.10.0.1-100</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |

***

## Check the status of SMB cluster readiness <a href="#check-status-smb-host-readiness" id="check-status-smb-host-readiness"></a>

**Command:** `weka smb cluster status`

The SMB cluster is comprised of a few SMB containers. Use this command to check the status of the SMB containers that are part of the SMB cluster. Once all the SMB containers are prepared and ready, it is possible to join an SMB cluster to an Active Directory.

## Join an SMB cluster in Active Directory <a href="#join-smb-cluster-in-ad" id="join-smb-cluster-in-ad"></a>

**Command:** `weka smb domain join`

Use the following command line to join an SMB domain in an Active Directory:

`weka smb domain join <username> <password> [--server server] [--create-computer create-computer]`

**Parameters**

| Name              | Value                                                                                                                                                                                                               | Default                                                          |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| `username`\*      | Name of a user with permission to add a server to the domain.                                                                                                                                                       |                                                                  |
| `password`\*      | The password of the user.                                                                                                                                                                                           |                                                                  |
| `server`          | <p>Weka identifies the AD server automatically based on the AD name. You do not need to set the server name. In some cases, if required, specify the AD server.<br>Not applicable for SMB-W yet.</p>                | The AD server is automatically identified based on the AD name.  |
| `create-computer` | <p>The default organization unit is the Computers directory. You can define any other directory to connect to in Active Directory, such as SMB servers or Corporate computers.<br>Not applicable for SMB-W yet.</p> | The computer's directory                                         |

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

| Name              | Value                                                                                                                                                   |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `containers-id`\* | <p>Container IDs of containers with a frontend process to serve the SMB service.<br>Specify a comma-separated list with a minimum of 3 containers. </p> |

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

| Name            | Value                                                                                                       |
| --------------- | ----------------------------------------------------------------------------------------------------------- |
| `domain-name`\* | The name of the domain to add.                                                                              |
| `from-id`\*     | <p>The first ID of the range for the domain ID mapping.<br>The range cannot overlap with other domains.</p> |
| `to-id`\*       | <p>The last ID of the range for the domain ID mapping.<br>The range cannot overlap with other domains</p>   |

### Remove trusted domains

**Command:** `weka smb cluster trusted-domains remove`

Use the following command line to remove an SMB trusted domain:

`weka smb cluster trusted-domains remove <domain-id>`

**Parameters**

| Name          | Value                                   |
| ------------- | --------------------------------------- |
| `domain-id`\* | The internal ID of the domain to remove |

## List SMB shares <a href="#list-smb-shares" id="list-smb-shares"></a>

**Command:** `weka smb share`

Use this command to list all existing SMB shares.

## Add an SMB share <a href="#add-an-smb-share" id="add-an-smb-share"></a>

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed to SMB:

`weka smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [--mount-option mount-option] [--file-create-mask file-create-mask] [--directory-create-mask directory-create-mask] [--obs-direct obs-direct] [--encryption encryption] [--read-only read-only] [--user-list-type user-list-type] [--users users]... [--allow-guest-access allow-guest-access] [--hidden hidden]`

**Parameters**

| Name                    | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Default           |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `share-name`\*          | <p>Valid name of the share to add.<br><br>SMB-W: cannot create the same share name with different case insensitivity.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ​                 |
| `fs-name`\*             | <p>Valid name of the filesystem to share.<br>A filesystem with Required Authentication set to ON cannot be used for SMB share.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ​                 |
| `description`           | The description of the share received in remote views.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ​                 |
| `internal-path`         | The internal valid path within the filesystem (relative to its root) which will be exposed                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | .                 |
| `mount-option`          | <p>The mount mode for the share.<br>Possible values: <code>readcache</code>, <code>writecache</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | `readcache`       |
| `file-create-mask`      | <p>POSIX permissions for the file created through the SMB share.<br>Numeric (octal) notation</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 0744              |
| `directory-create-mask` | <p>POSIX permissions for directories created through the SMB share.<br>Numeric (octal) notation.<br><br>SMB-W: the specified string must be greater or equal to 0600.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 0755              |
| `acl`                   | <p>Enable Windows ACLs on the share (which will be translated to POSIX).<br>Supports up to 16 ACEs per file.<br>Possible values: <code>on</code>, <code>off</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `off`             |
| `obs-direct`            | <p>See <a href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a> section.<br><br>Possible values for legacy SMB: <code>on</code>, <code>off</code><br><br>SMB-W: not supported</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `off`             |
| `encryption`            | <p>The share encryption policy.</p><p><code>cluster_default:</code> The he share encryption policy follows the global SMB cluster setting.</p><p><code>desired</code>: If negotiation is enabled globally, it turns on data encryption for this share for clients that support encryption.</p><p><code>required</code>: Enforces encryption for the shares. Clients that do not support encryption are denied when accessing the share. If the global option is <code>disabled</code>, the access is restricted to these shares for all clients.<br>Possible value for SMB-W: <code>cluster_default</code><br><br>Possible values legacy SMB: <code>cluster_default</code> , <code>desired</code>, <code>required</code></p> | `cluster_default` |
| `read-only`             | <p>Sets the share as read-only. Users cannot create or modify files in this share.<br>Possible values: <code>on</code>, <code>off</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `off`             |
| `user-list-type`        | <p>The type of initial permissions list for <code>users</code>.<br><br>SMB-W: not supported<br><br>Possible values for legacy SMB:<br><code>read_only</code> : List of users that will not be given write access to the share, regardless of the <code>read-only</code> setting.<br><code>read_write</code>: List of users that are given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> : List of users that are allowed to log-in to this share SMB service (empty list all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p>                                                                     |                   |
| `users`                 | <p>A list of users to use with the <code>user-list-type</code> list. Can use the <code>@</code> notation to allow groups of users, e.g. <code>root, Jack, @domain\admins</code>.<br><br>SMB-W: not supported<br><br>Possible values for legacy SMB: Up to 8 users/groups for all lists combined per share.</p>                                                                                                                                                                                                                                                                                                                                                                                                               | Empty list        |
| `allow-guest-access`    | <p>Allows connecting to the SMB service without a password. Permissions are as the <code>nobody</code> user account permissions.<br><br>SMB-W: not supported.<br><br>Possible values for legacy SMB: <code>on</code>, <code>off</code><br></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | `off`             |
| `hidden`                | <p>Sets the share as non-browsable. It will be accessible for mounting and IOs but not discoverable by SMB clients.<br>Possible values: <code>on</code>, <code>off</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `off`             |

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

| Name                 | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `share-id`\*         | A valid share ID to update.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `encryption`         | <p>The share encryption policy:</p><p><br><code>desired</code>: turns on data encryption for this share for clients that support encryption if negotiation has been enabled globally.</p><p><br><code>required</code>: enforces encryption for the shares. Clients that do not support encryption are denied access to the share. If the global option is set to <code>disabled</code>, the access is denied to these shares for all clients.<br><br>Possible values: <code>cluster_default</code>, <code>desired</code>, <code>required</code></p> |
| `read-only`          | <p>Mount the SMB share as read-only.<br>Possible values: <code>on</code>, <code>off</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `allow-guest-access` | <p>Allow guest access.<br>Possible values: <code>on</code>, <code>off</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `hidden`             | <p>Hide the the SMB share.<br>Possible values: <code>on</code>, <code>off</code></p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

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

| Name               | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `share-id`\*       | The ID of the share to update.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `user-list-type`\* | <p>The type of permissions list for <code>users</code>:<br><br><code>read_only</code>: list of users that do not get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>read_write</code>: list of users get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>valid</code>: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).<br><br><code>invalid</code>: list of users that are not allowed to log in to this share SMB service.</p> |
| `users`\*          | <p>A comma-separated list of users to add to the <code>user-list-type</code> list.<br>Can use the <code>@</code> notation to allow groups of users. For example, <code>root, Jack, @domain\admins.</code><br>You can set up to 8 users/groups for all lists combined per share.</p>                                                                                                                                                                                                                                                                                                 |

***

**Command:** `weka smb share lists remove`

Use the following command line to remove users from a share user-list:

`weka smb share lists remove <share-id> <user-list-type> <--users users>...`

**Parameters**

| Name               | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `share-id`\*       | The ID of the share to be updated.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `user-list-type`\* | <p>The type of permissions list for <code>users</code>:<br><br><code>read_only</code>: list of users that do not get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>read_write</code>: list of users get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>valid</code>: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).<br><br><code>invalid</code>: list of users not allowed to log in to this SMB share service.</p> |
| `users`\*          | <p>A comma-separated list of users to remove from the <code>user-list-type</code> list. Can use the <code>@</code> notation to allow groups of users, e.g. <code>root, Jack, @domain\admins.</code><br>You can set up to 8 users/groups for all lists combined per share.</p>                                                                                                                                                                                                                                                                                              |

***

**Command:** `weka smb share lists reset`

Use the following command line to remove all users from a share user-list:

`weka smb share lists reset <share-id> <user-list-type>`

**Parameters**

| Name               | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `share-id`\*       | The ID of the share to be updated                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `user-list-type`\* | <p>The type of permissions list to reset:<br><br><code>read_only</code>: list of users that do not get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>read_write</code>: list of users get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>valid</code>: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).<br><br><code>invalid</code>: list of users not allowed to log in to this SMB share service.</p> |

## Remove SMB shares <a href="#remove-smb-shares" id="remove-smb-shares"></a>

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`weka smb share remove <share-id>`

**Parameters**

| Name         | Value                          |
| ------------ | ------------------------------ |
|              |                                |
| `share-id`\* | The ID of the share to remove. |

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

| Name         | Value                                                                                                                                                                                                                                                                                                     |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|              |                                                                                                                                                                                                                                                                                                           |
| `share-id`\* | <p>The ID of the share to update.<br>Mandatory for the share-level command.</p>                                                                                                                                                                                                                           |
| `mode`\*     | <p>The access mode of the host.<br>Possible values: <code>allow</code>, <code>deny</code></p>                                                                                                                                                                                                             |
| `ips`        | <p>Host IP addresses to allow or deny.<br>Must provide at least one of the <code>ips</code> or <code>containers</code>.<br>A comma-separated list of IPs.<br>Format example for multiple IPs: <br><code>192.</code><br><code>192.168.</code><br><code>192.168.1</code><br><code>192.168.1.1/24</code></p> |
| `hosts`      | <p>Host names to allow/deny.<br>Must provide at least one of the <code>ips</code> or <code>containers</code>.<br>A comma-separated list of IPs.</p>                                                                                                                                                       |

**Command:** `weka smb cluster host-access remove` / `weka smb share host-access remove`

Use the following command line to remove hosts from the allow or deny list (at either cluster level or share level):

`weka smb cluster host-access remove <hosts>`

`weka smb share host-access remove <share-id> <hosts>`

**Parameters**

| Name         | Value                                                                                                                                                                                                             |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `share-id`\* | <p>The ID of the share to be updated.<br>Mandatory for the share-level command</p>                                                                                                                                |
| `hosts`\*    | <p>The hosts to remove from the host-access list.<br>Space-separated list of hosts.<br>It must be the exact name as shown under the <code>HOSTNAME</code> column in the equivalent <code>list</code> command.</p> |

**Command:** `weka smb cluster host-access reset`

`weka smb share host-access reset`

Use the following command line to remove all containers from the allow or deny list (at either cluster level or share level):

`weka smb cluster host-access reset <mode>`

`weka smb share host-access reset <share-id> <mode>`

**Parameters**

| Name         | Value                                                                                                                           |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| `share-id`\* | <p>The ID of the share to update.<br>Mandatory for the share-level command.</p>                                                 |
| `mode`\*     | <p>All hosts with this access mode will be removed from the list.<br>Possible values: <code>allow</code>, <code>deny</code></p> |
