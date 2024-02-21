---
description: >-
  This page provides procedures for setting up an SMB cluster over WEKA
  filesystems and managing the cluster itself, using the CLI.
---

# Manage SMB using the CLI

Using the CLI, you can manage both SMB-W and legacy SMB:

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

`weka smb cluster create <netbios-name> <domain> <config-fs-name> [--domain-netbios-name domain-netbios-name] [--idmap-backend idmap-backend] [--default-domain-mapping-from-id default-domain-mapping-from-id] [--default-domain-mapping-to-id default-domain-mapping-to-id] [--joined-domain-mapping-from-id joined-domain-mapping-from-id] [--joined-domain-mapping-to-id joined-domain-mapping-to-id] [--encryption encryption] [--smb-conf-extra smb-conf-extra] [--container-ids container-ids]... [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]...`

{% hint style="info" %}
The `weka smb cluster create` command creates an SMB-W cluster. To create a legacy SMB cluster, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

**Parameters**

<table><thead><tr><th width="210">Name</th><th width="361">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>netbios-name</code>*</td><td>NetBIOS name for the SMB cluster</td><td></td></tr><tr><td><code>domain</code>*</td><td>The Active Directory domain to join the SMB cluster to</td><td>​</td></tr><tr><td><code>config-fs-name</code>*</td><td>The predefined filesystem name for maintaining the persisting cluster-wide protocols' configurations.<br>Verify that the filesystem is already created. If not, create it. For details, see <a data-mention href="../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations">#dedicated-filesystem-requirement-for-persistent-protocol-configurations</a></td><td></td></tr><tr><td><code>domain-netbios-name</code></td><td>Domain NetBIOS name.</td><td>The first part of the <code>domain</code> parameter</td></tr><tr><td><code>idmap-backend</code></td><td>The ID mapping method to use.<br>Possible values: <code>rfc2307</code> or <code>rid</code></td><td><code>rfc2307</code></td></tr><tr><td><code>default-domain-mapping-from-id</code></td><td>The first ID of the range for the default AD ID mapping (for trusted domains that have no range defined).<br>Not supported in SMB-W yet.</td><td>4290000001</td></tr><tr><td><code>default-domain-mapping-to-id</code></td><td>The last ID of the range for the default AD ID mapping (for trusted domains that have no range defined).<br>Not supported in SMB-W yet.</td><td>4291000000</td></tr><tr><td><code>joined-domain-mapping-from-id</code></td><td>The first ID of the range for the main AD ID mapping.</td><td>0</td></tr><tr><td><code>joined-domain-mapping-to-id</code></td><td>The last ID of the range for the main AD ID mapping.</td><td>4290000000</td></tr><tr><td><code>encryption</code></td><td><p>The global encryption policy to use:</p><ul><li><code>enabled</code> - enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</li><li><code>disabled</code> - doesn't support encrypted connections.</li><li><code>desired</code> - enables encryption negotiation and turns on data encryption on supported sessions and share connections.</li><li><code>required</code> - enforces data encryption on sessions and share connections. Clients that do not support encryption will be denied access to the server.</li></ul><p>SMB-W possible values: <code>enabled</code>, <code>desired</code>, <code>required</code><br><br>Legacy SMB possible values: <code>enabled</code>, <code>disabled</code>, <code>desired</code>, <code>required</code></p></td><td><code>enabled</code></td></tr><tr><td><code>smb-conf-extra</code></td><td>Additional SMB configuration options.</td><td></td></tr><tr><td><code>container-ids</code></td><td>The container IDs of the containers with a frontend process to serve the SMB service.<br>Minimum of 3 containers.</td><td></td></tr><tr><td><code>smb-ips-pool</code></td><td><p>A pool of virtual IPs, used as floating IPs for the SMB cluster to provide HA to clients.</p><p>These IPs must be unique; do not assign these IPs to any host on the network.<br>Format: comma-separated IP addresses.</p></td><td></td></tr><tr><td><code>smb-ips-range</code></td><td><p>A range of virtual IPs, used as floating IPs for the SMB cluster to provide HA to clients.</p><p>These IPs must be unique; do not assign these IPs to any host on the network.<br>Format: <code>A.B.C.D-E</code><br>Example: <code>10.10.0.1-100</code></p></td><td></td></tr></tbody></table>

{% hint style="info" %}
To enable HA through IP takeover, all IPs must reside on the same subnet.
{% endhint %}

{% hint style="info" %}
The floating IPs configured but **MUST NOT** be in use by any other application/server in the subnet, including WEKA system management nodes, WEKA system IO nodes, or WEKA system NFS floating IPs. Setting a list of SMB floating IPs in all-cloud installations is impossible due to cloud provider network limitations. In this case, the SMB service must be accessed by using the primary addresses of the cluster nodes.
{% endhint %}

{% hint style="info" %}
The `--smb-ips` parameter must accept the virtual IPs that the SMB cluster exposes. To mount the SMB cluster in an high-availability manner, clients must be connected through one of the exposed virtual IPs, thereby ensuring that they automatically reconnect if one of the SMB containers fail.
{% endhint %}

{% hint style="info" %}
If setting the global options to the SMB library is required, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).
{% endhint %}

{% hint style="success" %}
**Example:**

`weka smb cluster create wekaSMB mydomain --container-ids 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over the WEKA system containers 0-4. The SMB cluster is called `wekaSMB,`the domain name is called `mydomain`and is directed to use virtual IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Update the SMB cluster <a href="#update-smb-cluster" id="update-smb-cluster"></a>

**Command:** `weka smb cluster update`

Use the following command line to update an existing SMB cluster:

`weka smb cluster update [--encryption encryption] [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]`

**Parameters**

<table><thead><tr><th width="247">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>encryption</code></td><td><p>The global encryption policy to use:</p><ul><li><code>enabled</code>: enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.</li><li><code>disabled</code>: doesn't support encrypted connections.</li><li><code>desired</code>: enables encryption negotiation and turns on data encryption on supported sessions and share connections.</li><li><code>required</code>: enforces data encryption on sessions and share connections. Clients that do not support encryption are denied access to the server.,</li></ul><p>Possible values in SMB-W: <code>enabled</code>, <code>desired</code>, <code>required</code><br><br>Possible values in legacy SMB: <code>enabled</code>, <code>disabled</code>, <code>desired</code>, <code>required</code></p></td></tr><tr><td><code>smb-ips-pool</code></td><td><p>A pool of virtual IPs, used as floating IPs for the SMB cluster to provide HA to clients.</p><p>These IPs must be unique; do not assign these IPs to any host on the network.<br>Format: comma-separated IP addresses.</p></td></tr><tr><td><code>smb-ips-range</code></td><td>A range of public IPs is used as floating IPs to provide high availability for the SMB cluster to serve the SMB clients.<br>These IPs must be unique; do not assign these IPs to any host on the network.<br>Format: <code>A.B.C.D-E</code><br>Example: <code>10.10.0.1-100</code></td></tr></tbody></table>

***

## Check the status of SMB cluster readiness <a href="#check-status-smb-host-readiness" id="check-status-smb-host-readiness"></a>

**Command:** `weka smb cluster status`

The SMB cluster is comprised of three to eight SMB containers. Use this command to check the status of the SMB containers that are part of the SMB cluster. Once all the SMB containers are prepared and ready, it is possible to join an SMB cluster to an Active Directory domain.

## Join an SMB cluster in Active Directory <a href="#join-smb-cluster-in-ad" id="join-smb-cluster-in-ad"></a>

**Command:** `weka smb domain join`

Use the following command line to join the SMB cluster to an Active Directory domain:

`weka smb domain join <username> <password> [--server server] [--create-computer create-computer]`

{% hint style="info" %}
Ensure the AD servers are resolvable to all WEKA servers. This resolution enables the WEKA servers to join the AD domain.
{% endhint %}

**Parameters**

<table><thead><tr><th width="207">Name</th><th width="332">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>username</code>*</td><td>Name of an AD user with permission to add a server to the domain.</td><td></td></tr><tr><td><code>password</code>*</td><td>The password of the AD user.  This password is not retained or cached.</td><td></td></tr><tr><td><code>server</code></td><td>Weka identifies the AD server automatically based on the AD name. You do not need to set the server name. In some cases, if required, specify the AD server.<br>Not applicable for SMB-W yet.</td><td>The AD server is automatically identified based on the AD name. </td></tr><tr><td><code>create-computer</code></td><td>The default AD organizational unit (OU) for the computer account is the Computers directory. You can define any OU to create the computer account in - that the joining account has permissions to - such as SMB Servers or Corporate Computers.<br>Not applicable for SMB-W yet.</td><td>The Computers directory.</td></tr></tbody></table>

To join an existing SMB cluster to another Active Directory domain, leave the current Active Directory using the following command line:

`weka smb domain leave <username> <password>`

On completion of this operation, it is possible to join the SMB cluster to another Active Directory domain.

## Delete an SMB cluster <a href="#delete-an-smb-cluster" id="delete-an-smb-cluster"></a>

**Command:** `weka smb cluster destroy`

Use this command to destroy an SMB cluster managed by the Weka system.

Deleting an existing SMB cluster managed by the WEKA system does not delete the backend WEKA filesystems but removes the SMB share exposures of these filesystems.

## Add or remove SMB cluster containers <a href="#add-or-remove-smb-cluster-hosts" id="add-or-remove-smb-cluster-hosts"></a>

**Command:** `weka smb cluster containers add`

**Command:** `weka smb cluster containers remove`

Use these commands to add or remove containers from the SMB cluster.

`weka smb cluster containers add [--containers-id containers-id]...`

`weka smb cluster containers remove [--containers-id containers-id]...`

{% hint style="info" %}
This operation might take some time to complete. During that time, SMB IOs are stalled.
{% endhint %}

**Parameters**

<table><thead><tr><th width="287">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>containers-id</code>*</td><td>Container IDs of containers with a frontend process to serve the SMB service.<br>Specify a comma-separated list with a minimum of 3 containers. </td></tr></tbody></table>

## Configure trusted domains <a href="#configure-trusted-domains" id="configure-trusted-domains"></a>

{% hint style="info" %}
SMB-W does not yet support trusted domains.
{% endhint %}

### List trusted domains

**Command:** `weka smb cluster trusted-domains`

Use this command to list all the configured trusted domains and their ID ranges.

### Add trusted domains

**Command:** `weka smb cluster trusted-domains add`

Use the following command line to add an SMB trusted domain:

`weka smb cluster trusted-domains add <domain-name> <from-id> <to-id>`

**Parameters**

<table><thead><tr><th width="221">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>domain-name</code>*</td><td>The name of the domain to add.</td></tr><tr><td><code>from-id</code>*</td><td>The first ID of the range for the domain ID mapping.<br>The range cannot overlap with other domains.</td></tr><tr><td><code>to-id</code>*</td><td>The last ID of the range for the domain ID mapping.<br>The range cannot overlap with other domains</td></tr></tbody></table>

### Remove trusted domains

**Command:** `weka smb cluster trusted-domains remove`

Use the following command line to remove an SMB-trusted domain:

`weka smb cluster trusted-domains remove <domain-id>`

**Parameters**

<table><thead><tr><th width="237">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>domain-id</code>*</td><td>The internal ID of the domain to remove</td></tr></tbody></table>

## List SMB shares <a href="#list-smb-shares" id="list-smb-shares"></a>

**Command:** `weka smb share`

Use this command to list all existing SMB shares.

## Add an SMB share <a href="#add-an-smb-share" id="add-an-smb-share"></a>

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed by SMB:

`weka smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [--mount-option mount-option] [--file-create-mask file-create-mask] [--directory-create-mask directory-create-mask] [--obs-direct obs-direct] [--encryption encryption] [--read-only read-only] [--user-list-type user-list-type] [--users users]... [--allow-guest-access allow-guest-access] [--hidden hidden]`

**Parameters**

<table><thead><tr><th>Name</th><th width="322">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>share-name</code>*</td><td>Valid name of the share to add.<br><br>SMB-W: you cannot create the same share name with different case insensitivity.</td><td>​</td></tr><tr><td><code>fs-name</code>*</td><td>Valid name of the filesystem to share.<br>A filesystem with Required Authentication set to ON cannot be used for SMB share.</td><td>​</td></tr><tr><td><code>description</code></td><td>The description of the share received in remote views.</td><td>​</td></tr><tr><td><code>internal-path</code></td><td>The internal valid path within the filesystem (relative to its root) which will be exposed</td><td>.</td></tr><tr><td><code>mount-option</code></td><td><p>The mount mode for the share.</p><p><br>Possible values: <code>readcache</code>, <code>writecache</code></p></td><td><code>readcache</code></td></tr><tr><td><code>file-create-mask</code></td><td>POSIX permissions for the file created through the SMB share.<br>Numeric (octal) notation</td><td>0744</td></tr><tr><td><code>directory-create-mask</code></td><td>POSIX permissions for directories created through the SMB share.<br>Numeric (octal) notation.<br><br>SMB-W: the specified string must be greater or equal to 0600.</td><td>0755</td></tr><tr><td><code>acl</code></td><td>Enable Windows ACLs on the share (which is translated to POSIX).<br>Supports up to 16 ACEs per file depending on the available space in the Extended Attribute (xattr). <br>For details, see <a data-mention href="../../overview/filesystems.md#filesystem-extended-attributes-considerations">#filesystem-extended-attributes-considerations</a><br>Possible values: <code>on</code>, <code>off</code></td><td><code>off</code></td></tr><tr><td><code>obs-direct</code></td><td><p>A special mount option to bypass the time-based policies. </p><p>For details, see <a data-mention href="../../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">#object-store-direct-mount-option</a><br>Possible values for legacy SMB: <code>on</code>, <code>off</code><br><br>SMB-W: not supported</p></td><td><code>off</code></td></tr><tr><td><code>encryption</code></td><td><p>The share encryption policy.</p><p><code>cluster_default:</code> The share encryption policy follows the global SMB cluster setting.</p><p><code>desired</code>: If negotiation is enabled globally, it turns on data encryption for this share for clients that support encryption.</p><p><code>required</code>: Enforces encryption for the shares. Clients that do not support encryption are denied when accessing the share. If the global option is <code>disabled</code>, the access is restricted to these shares for all clients.</p><p><br>Possible value for SMB-W: <code>cluster_default</code><br><br>Possible values for legacy SMB: <code>cluster_default</code> , <code>desired</code>, <code>required</code></p></td><td><code>cluster_default</code></td></tr><tr><td><code>read-only</code></td><td><p>Sets the share as read-only. Users cannot create or modify files in this share.</p><p><br>Possible values: <code>on</code>, <code>off</code></p></td><td><code>off</code></td></tr><tr><td><code>user-list-type</code></td><td><p>The type of initial permissions list for <code>users</code>.<br><br>SMB-W: not supported<br><br>Possible values for legacy SMB:<br><code>read_only</code> : List of users who have been denied write access to the shared resource write access to the share, regardless of the <code>read-only</code> setting.<br><code>read_write</code>: List of users given write access to the share, regardless of the <code>read-only</code> setting.</p><p><code>valid</code> : List of users that are allowed to log-in to this share SMB service (empty list all users are allowed)<code>invalid</code> - list of users that are not allowed to log-in to this share SMB service</p></td><td></td></tr><tr><td><code>users</code></td><td>A list of users to use with the <code>user-list-type</code> list. Can use the <code>@</code> notation to allow groups of users, e.g. <code>root, Jack, @domain\admins</code>.<br><br>SMB-W: not supported<br><br>Possible values for legacy SMB: Up to 8 users/groups for all lists combined per share.</td><td>Empty list</td></tr><tr><td><code>allow-guest-access</code></td><td>Allows connecting to the SMB service without a password. Permissions are as the <code>nobody</code> user account permissions.<br><br>SMB-W: not supported.<br><br>Possible values for legacy SMB: <code>on</code>, <code>off</code><br></td><td><code>off</code></td></tr><tr><td><code>hidden</code></td><td>Sets the share as non-browsable. It will be accessible for mounting and IOs but not discoverable by SMB clients.<br>Possible values: <code>on</code>, <code>off</code></td><td><code>off</code></td></tr></tbody></table>

{% hint style="info" %}
If it is necessary to set a share with specific options to the SMB library, contact Weka support.
{% endhint %}

{% hint style="success" %}
**Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default`\
`weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first SMB share added has the WEKA system share for default. The second SMB share has internal for default.
{% endhint %}

## Update SMB shares <a href="#update-smb-shares" id="update-smb-shares"></a>

**Command:** `weka smb share update`

Use the following command line to update an existing share:

`weka smb share update <share-id> [--encryption encryption] [--read-only read-only] [--allow-guest-access allow-guest-access] [--hidden hidden]`

{% hint style="info" %}
SMB-W does not yet support share update.
{% endhint %}

**Parameters**

<table><thead><tr><th width="231">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>A valid share ID to update.</td></tr><tr><td><code>encryption</code></td><td><p>The share encryption policy:</p><p><br><code>desired</code>: turns on data encryption for this share for clients that support encryption if negotiation has been enabled globally.</p><p><br><code>required</code>: enforces encryption for the shares. Clients that do not support encryption are denied access to the share. If the global option is set to <code>disabled</code>, the access is denied to these shares for all clients.<br><br>Possible values: <code>cluster_default</code>, <code>desired</code>, <code>required</code></p></td></tr><tr><td><code>read-only</code></td><td><p>Mount the SMB share as read-only.</p><p><br>Possible values: <code>on</code>, <code>off</code></p></td></tr><tr><td><code>allow-guest-access</code></td><td><p>Allow guest access.</p><p><br>Possible values: <code>on</code>, <code>off</code></p></td></tr><tr><td><code>hidden</code></td><td><p>Hide the SMB share.</p><p><br>Possible values: <code>on</code>, <code>off</code></p></td></tr></tbody></table>

## **Control SMB share user-lists** <a href="#control-smb-share-user-lists" id="control-smb-share-user-lists"></a>

{% hint style="info" %}
SMB-W does not yet support share user-lists.
{% endhint %}

**Command:** `weka smb share lists show`

Use this command to view the various user-list settings.

***

**Command:** `weka smb share lists add`

Use the following command line to add users to a share user-list:

`weka smb share lists add <share-id> <user-list-type> <--users users>...`

**Parameters**

<table><thead><tr><th width="239">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to update.</td></tr><tr><td><code>user-list-type</code>*</td><td>The type of permissions list for <code>users</code>:<br><br><code>read_only</code>: list of users that do not get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>read_write</code>: list of users get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>valid</code>: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).<br><br><code>invalid</code>: list of users that are not allowed to log in to this share SMB service.</td></tr><tr><td><code>users</code>*</td><td>A comma-separated list of users to add to the <code>user-list-type</code> list.<br>Can use the <code>@</code> notation to allow groups of users. For example, <code>root, Jack, @domain\admins.</code><br>You can set up to 8 users/groups for all lists combined per share.</td></tr></tbody></table>

***

**Command:** `weka smb share lists remove`

Use the following command line to remove users from a share user-list:

`weka smb share lists remove <share-id> <user-list-type> <--users users>...`

**Parameters**

<table><thead><tr><th width="245">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to be updated.</td></tr><tr><td><code>user-list-type</code>*</td><td>The type of permissions list for <code>users</code>:<br><br><code>read_only</code>: list of users that do not get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>read_write</code>: list of users get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>valid</code>: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).<br><br><code>invalid</code>: list of users not allowed to log in to this SMB share service.</td></tr><tr><td><code>users</code>*</td><td>A comma-separated list of users to remove from the <code>user-list-type</code> list. Can use the <code>@</code> notation to allow groups of users, e.g. <code>root, Jack, @domain\admins.</code><br>You can set up to 8 users/groups for all lists combined per share.</td></tr></tbody></table>

***

**Command:** `weka smb share lists reset`

Use the following command line to remove all users from a share user-list:

`weka smb share lists reset <share-id> <user-list-type>`

**Parameters**

<table><thead><tr><th width="244">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to be updated</td></tr><tr><td><code>user-list-type</code>*</td><td>The type of permissions list to reset:<br><br><code>read_only</code>: list of users that do not get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>read_write</code>: list of users get write access to the SMB share, regardless of the <code>read-only</code> setting.<br><br><code>valid</code>: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).<br><br><code>invalid</code>: list of users not allowed to log in to this SMB share service.</td></tr></tbody></table>

## Remove SMB shares <a href="#remove-smb-shares" id="remove-smb-shares"></a>

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`weka smb share remove <share-id>`

**Parameters**

<table><thead><tr><th width="308">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to remove.</td></tr></tbody></table>

{% hint style="success" %}
**Example:** The following is an example of removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## Control SMB access based on hosts' IP/name <a href="#control-smb-access-based-on-hosts" id="control-smb-access-based-on-hosts"></a>

It is possible to control which hosts are permitted to access the SMB service or share.

{% hint style="info" %}
SMB-W does not yet support access based on hosts' IP/name.
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

<table><thead><tr><th width="226">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to update.<br>Mandatory for the share-level command.</td></tr><tr><td><code>mode</code>*</td><td>The access mode of the host.<br>Possible values: <code>allow</code>, <code>deny</code></td></tr><tr><td><code>ips</code></td><td>Host IP addresses to allow or deny.<br>Must provide at least one of the <code>ips</code> or <code>containers</code>.<br>A comma-separated list of IPs.<br>Format example for multiple IPs: <br><code>192.</code><br><code>192.168.</code><br><code>192.168.1</code><br><code>192.168.1.1/24</code></td></tr><tr><td><code>hosts</code></td><td>Host names to allow/deny.<br>Must provide at least one of the <code>ips</code> or <code>containers</code>.<br>A comma-separated list of IPs.</td></tr></tbody></table>

**Command:** `weka smb cluster host-access remove` / `weka smb share host-access remove`

Use the following command line to remove hosts from the allow or deny list (at either cluster level or share level):

`weka smb cluster host-access remove <hosts>`

`weka smb share host-access remove <share-id> <hosts>`

**Parameters**

<table><thead><tr><th width="248">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to be updated.<br>Mandatory for the share-level command</td></tr><tr><td><code>hosts</code>*</td><td>The hosts to remove from the host-access list.<br>Space-separated list of hosts.<br>It must be the exact name as shown under the <code>HOSTNAME</code> column in the equivalent <code>list</code> command.</td></tr></tbody></table>

**Command:** `weka smb cluster host-access reset`

`weka smb share host-access reset`

Use the following command line to remove all containers from the allow or deny list (at either cluster level or share level):

`weka smb cluster host-access reset <mode>`

`weka smb share host-access reset <share-id> <mode>`

**Parameters**

<table><thead><tr><th width="301">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to update.<br>Mandatory for the share-level command.</td></tr><tr><td><code>mode</code>*</td><td>All hosts with this access mode will be removed from the list.<br>Possible values: <code>allow</code>, <code>deny</code></td></tr></tbody></table>
