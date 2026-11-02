---
description: >-
  Configure SMB-W clusters, Active Directory integration, containers, trusted
  domains, and shares using the CLI.
---

# Manage SMB using the CLI

{% hint style="info" %}
The CLI refers to the feature as SMB, but it applies to SMB-W only. Support for the legacy SMB implementation has been removed.
{% endhint %}

## Show the SMB cluster

Shows the SMB cluster configuration, including the containers serving SMB and the domain it is joined to.

**Command:** `weka smb cluster`

```sh
weka smb cluster
```

## Show the SMB domain configuration

Shows the Active Directory or workgroup domain the SMB cluster is joined to.

**Command:** `weka smb domain`

```sh
weka smb domain
```

## Add an SMB cluster

Creates the SMB service on the cluster, selecting the containers that serve SMB and the filesystem holding its configuration.

**Command:** `weka smb cluster create`

```sh
weka smb cluster create <netbios-name> <domain> <config-fs-name> --container-ids <container-ids>… [--default-domain-mapping-from-id <uint32>] [--default-domain-mapping-to-id <uint32>] [--domain-netbios-name <string>] [--encryption <smb-cluster-encryption>] [--idmap-backend <smb-idmap-backend>] [--joined-domain-mapping-from-id <uint32>] [--joined-domain-mapping-to-id <uint32>] [--ldap-bind-dn <string>] [--ldap-bind-password <string>] [--ldap-domain <string>] [--ldap-search-base <string>] [--ldap-uri <string>] [--posix-resolution-mode <smb-posix-resolution-mode>] [--prompt-ldap-bind-password] [--scale-out-mode <smb-scale-out-mode>] [--smb-conf-extra <string>] [--smb-ips-pool <ips>…] [--smb-ips-range <ips>…] [--symlink] [--userdb-trusted-domains]
```

**Parameters**

| Parameter                                              | Description                                                                                                                                                                                                                                                                                                          |
| --- | --- |
| `netbios-name`\* | NetBIOS name for the SMB cluster. |
| `domain`\* | Domain name for the SMB cluster. |
| `config-fs-name`\* | Filesystem name for SMB configuration storage. For details, see #dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations |
| `--container-ids` \<container-ids>\*… | Containers that will serve SMB protocol. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--default-domain-mapping-from-id` \<uint32> | Default domain ID mapping range start. |
| `--default-domain-mapping-to-id` \<uint32> | Default domain ID mapping range end. |
| `--domain-netbios-name` \<string> | Domain NetBIOS name. |
| `--encryption` \<smb-cluster-encryption> | Cluster encryption mode. |
| `--idmap-backend` \<smb-idmap-backend> | ID mapping backend type. Possible values: rfc2307 or rid |
| `--joined-domain-mapping-from-id` \<uint32> | Joined domain ID mapping range start. |
| `--joined-domain-mapping-to-id` \<uint32> | Joined domain ID mapping range end. |
| `--ldap-bind-dn` \<string> | LDAP bind DN used by SSSD. |
| `--ldap-bind-password` \<string> | LDAP bind password used by SSSD. |
| `--ldap-domain` \<string> | LDAP domain used by SSSD. |
| `--ldap-search-base` \<string> | LDAP search base used by SSSD. |
| `--ldap-uri` \<string> | LDAP server URI used by SSSD. |
| `--posix-resolution-mode` \<smb-posix-resolution-mode> | POSIX UID/GID resolution mode for SMB-W: 'ad' or 'nss'. |
| `--prompt-ldap-bind-password` | Prompt interactively for the LDAP bind password instead of passing it on the command line. |
| `--scale-out-mode` \<smb-scale-out-mode> | Scale-out mode. |
| `--smb-conf-extra` \<string> | Additional smb.conf configuration. |
| `--smb-ips-pool` \<ips>… | SMB floating IP addresses. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--smb-ips-range` \<ips>… | SMB floating IP address range. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--symlink` | Enable symlink support. |
| `--userdb-trusted-domains` | Enumerate the trusted domains and their domain controllers when the SMB server starts (enabled by default). Set to false in large Active Directory environments where the enumeration times out and the SMB server keeps restarting. While it is off, users from trusted domains cannot be resolved and lose access. |

### Guidelines for configuring an SMB cluster

* **Enable High Availability (HA):**
  * Ensure all floating IPs reside on the same subnet to enable IP takeover for HA.
* **Floating IP requirements:**
  * Floating IPs must not be used by any other applications, servers, or WEKA components, including:
    * WEKA system management nodes
    * WEKA system IO nodes
    * WEKA system NFS floating IPs
  * In all-cloud installations, where listing SMB floating IPs is restricted by cloud provider network limitations, access the SMB service via the primary addresses of the cluster nodes.
* **Configure SMB floating IPs:**
  * Use the `--smb-ips` parameter to specify the virtual IPs exposed by the SMB cluster.
  * Clients must connect through one of these virtual IPs to ensure automatic reconnection if an SMB container fails.
* **Customizing SMB library options:**
  * If global options for the SMB library need adjustment, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).

**Example command:**\
In this example, an SMB cluster named `wekaSMB` is created using containers 0-4, within the domain `mydomain`. The cluster is configured with virtual IPs ranging from 1.1.1.1 to 1.1.1.5.

{% code overflow="wrap" %}
```bash
weka smb cluster create wekaSMB mydomain --container-ids 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5  
```
{% endcode %}

## Update the SMB cluster

Changes SMB cluster settings such as the serving IPs, encryption policy, and identity-mapping backend.

**Command:** `weka smb cluster update`

```sh
weka smb cluster update [--encryption <smb-cluster-encryption>] [--force] [--idmap-backend <smb-idmap-backend>] [--posix-resolution-mode <smb-posix-resolution-mode>] [--smb-ips-pool <ips>…] [--smb-ips-range <ips>…] [--userdb-trusted-domains]
```

**Parameters**

| Parameter                                              | Description                                                                                                                                                                                                                                                                                                          |
| --- | --- |
| `--encryption` \<smb-cluster-encryption> | Cluster encryption mode. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--idmap-backend` \<smb-idmap-backend> | ID mapping backend type. Required when switching --posix-resolution-mode to 'ad'; mutually exclusive with --posix-resolution-mode nss. |
| `--posix-resolution-mode` \<smb-posix-resolution-mode> | Change POSIX UID/GID resolution mode: 'ad' (resolve via the joined Active Directory) or 'nss' (resolve via NSS/SSSD against external LDAP; requires at least one LDAP domain already configured). Flipping the mode bounces the SMB cluster. |
| `--smb-ips-pool` \<ips>… | SMB floating IP addresses. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--smb-ips-range` \<ips>… | SMB floating IP address range. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--userdb-trusted-domains` | Enumerate the trusted domains and their domain controllers when the SMB server starts (enabled by default). Set to false in large Active Directory environments where the enumeration times out and the SMB server keeps restarting. While it is off, users from trusted domains cannot be resolved and lose access. |

{% hint style="info" %}
Symlink support is set when the SMB cluster is created, using the `--symlink` option of `weka smb cluster create`. It is not part of `weka smb cluster update`, so you cannot change it on an existing SMB cluster.
{% endhint %}

## Check the status of SMB cluster readiness

Shows whether each container in the SMB cluster is ready to serve traffic.

**Command:** `weka smb cluster status`

```sh
weka smb cluster status
```

## Join an SMB cluster in Active Directory

Joins the SMB cluster to an Active Directory domain so that domain users can authenticate.

**Command:** `weka smb domain join`

```sh
weka smb domain join <username> [<password>] [--create-computer <string>] [--debug] [--extra-options <string>] [--server <string>] [--timeout <duration>]
```

**Parameters**

| Parameter                     | Description                                              |
| --- | --- |
| `username`\* | Domain admin username. |
| `password` | Domain admin password. If omitted, you will be prompted. |
| `--create-computer` \<string> | Organizational unit for the computer account. |
| `--debug` | Enable debug output. |
| `--extra-options` \<string> | Extra options for the domain join. |
| `--server` \<string> | Domain controller server address. |
| `-t`, `--timeout` \<duration> | Timeout for the domain join operation. |

To join an existing SMB cluster to another Active Directory domain, leave the current Active Directory using the following command line:

`weka smb domain leave <username> <password>`

On completion of this operation, it is possible to join the SMB cluster to another Active Directory domain.

{% hint style="info" %}
Ensure the AD servers are resolvable to all WEKA servers. This resolution enables the WEKA servers to join the AD domain.
{% endhint %}

## Remove an SMB cluster

Removes the SMB service from the cluster. The underlying filesystems and their data are not deleted.

**Command:** `weka smb cluster destroy`

```sh
weka smb cluster destroy [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## Add or remove SMB cluster containers

Adds containers to or removes them from the SMB cluster, changing which containers serve SMB traffic.

**Command:** `weka smb cluster containers add`

```sh
weka smb cluster containers add --container-ids <container-ids>… [--force]
```

**Command:** `weka smb cluster containers remove`

```sh
weka smb cluster containers remove --container-ids <container-ids>… [--force]
```

**Parameters**

| Parameter                             | Description                                                                                                |
| --- | --- |
| `--container-ids` \<container-ids>\*… | SMB containers to add. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

{% hint style="info" %}
This operation might take some time to complete. During that time, SMB IOs are stalled.
{% endhint %}

## Configure trusted domains <a href="#configure-trusted-domains" id="configure-trusted-domains"></a>


### List trusted domains

Lists the trusted domains configured on the SMB cluster and the ID range mapped to each.

**Command:** `weka smb cluster trusted-domains`

```sh
weka smb cluster trusted-domains
```

### Add trusted domains

Adds a trusted domain and the range of IDs its users map onto.

**Command:** `weka smb cluster trusted-domains add`

```sh
weka smb cluster trusted-domains add <domain-name> <from-id> <to-id> [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `domain-name`\* | Trusted domain name. |
| `from-id`\* | ID mapping range start. |
| `to-id`\* | ID mapping range end. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### Remove trusted domains

Removes a trusted domain from the SMB cluster.

**Command:** `weka smb cluster trusted-domains remove`

```sh
weka smb cluster trusted-domains remove <trusteddomain-id> [--force]
```

**Parameters**

| Parameter            | Description                                                     |
| --- | --- |
| `trusteddomain-id`\* | Trusted domain ID to remove. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

{% hint style="info" %}
**SMB-W cluster restart and verification**

The commands `weka smb cluster trusted-domains add` and `weka smb cluster trusted-domains remove` (and the related APIs) trigger a background restart of the SMB-W cluster. This restart is necessary for the changes to take effect.

To confirm that the cluster has resumed normal operation following the restart, run the command: `weka smb cluster status`

This command provides the current status of the SMB-W cluster and ensures that it is operational.
{% endhint %}

## List SMB shares

Lists the SMB shares exposed by the cluster.

**Command:** `weka smb share`

```sh
weka smb share
```

## Add an SMB share

Exposes a directory of a filesystem as an SMB share.

**Command:** `weka smb share add`

```sh
weka smb share add <share-name> <fs-name> [--acl] [--allow-guest-access] [--case-sensitivity] [--description <string>] [--directory-create-mask <string>] [--enable-ADS] [--encryption <smb-share-encryption>] [--file-create-mask <string>] [--force] [--hidden] [--internal-path <string>] [--map-acls <smb-map-acls>] [--obs-direct] [--read-only] [--user-list-type <smb-user-list-type>] [--users <strings>…] [--vfs-zerocopy-read]
```

**Parameters**

| Parameter                                | Description                                                                                     |
| --- | --- |
| `share-name`\* | Share name. |
| `fs-name`\* | Filesystem name. |
| `--acl` | Enable ACLs. For details, see Broken link Possible values: on, off For a MAC client, if acl is off, set enable-ADS to off |
| `--allow-guest-access` | Allow guest access. Possible values: on, off |
| `--case-sensitivity` | Case sensitivity. |
| `--description` \<string> | Share description. |
| `--directory-create-mask` \<string> | Directory create mask. |
| `--enable-ADS` | Enable named streams (ADS). Possible values: yes, no macOS clients: If ACLs are disabled (acl=off), set enable-ADS to off. Windows clients: When enabled, ADS data is stored in the file’s extended attributes (XAttr), which consumes XAttr space |
| `--encryption` \<smb-share-encryption> | Encryption mode. default: The share encryption policy follows the global SMB cluster setting. desired: If negotiation is enabled globally, it turns on data encryption for this share for clients that support encryption. required: Enforces encryption for the shares. Clients that do not support encryption are denied when accessing the share |
| `--file-create-mask` \<string> | File create mask. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--hidden` | Hidden share. Possible values: on, off |
| `--internal-path` \<string> | Internal path within the filesystem. |
| `--map-acls` \<smb-map-acls> | Map ACLs mode. |
| `--obs-direct` | OBS direct. For details, see Broken link Possible values: on, off |
| `--read-only` | Read only share. Possible values: on, off |
| `--user-list-type` \<smb-user-list-type> | User list type. Possible values: read_only: List of users who have been denied write access to the share, regardless of the read-only setting. read_write: List of users given write access to the share, regardless of the read-only setting. valid : List of users that are allowed to log in to this share (empty list = all users are allowed) invalid: List of users that are not allowed to log in to this share |
| `--users` \<strings>… | Users list. Multiple values may be supplied separated by commas, or the option may be repeated. Possible values: Up to 8 users/groups for all lists combined per share |
| `--vfs-zerocopy-read` | VFS zerocopy read. Possible values: on, off |

{% hint style="info" %}
The mount mode for the SMB share is `readcache` and cannot be modified.
{% endhint %}

### Guidelines for adding an SMB share

* **Adding SMB shares:**
  *   Example commands:

      ```bash
      weka smb share add rootShare default  
      weka smb share add internalShare default --internal-path /some/dir --description "Exposed share"  
      ```

      The first command creates a root SMB share for the `default` filesystem.

      The second command creates an internal SMB share for the `default` filesystem with a specified subdirectory and description.
* **Custom SMB library options:** For configuring SMB shares with specific library options, contact the Customer Success Team.
* **Setting share permissions:** After adding an SMB share, configure POSIX permissions to grant SMB users access.\
  **Examples:**
  *   Grant full access:

      ```bash
      mount -t wekafs smbw-fs /mnt/smbw  
      chmod 777 /mnt/smbw  
      umount /mnt/smbw  
      ```
  *   Assign group ownership:

      ```bash
      mount -t wekafs smbw-fs /mnt/smbw  
      chown :smb-group /mnt/smbw  
      umount /mnt/smbw  
      ```

For more details, see [#filesystem-permissions-and-access-rights-for-smb-w](./#filesystem-permissions-and-access-rights-for-smb-w "mention").

## Update SMB shares

Changes an existing share's encryption, guest access, visibility, or read-only setting.

**Command:** `weka smb share update`

```sh
weka smb share update <share-id> [--allow-guest-access] [--encryption <smb-share-encryption>] [--hidden] [--read-only]
```

**Parameters**

| Parameter                              | Description         |
| --- | --- |
| `share-id`\* | Share ID. |
| `--allow-guest-access` | Allow guest access. Possible values: on, off |
| `--encryption` \<smb-share-encryption> | Encryption mode. default: The share encryption policy follows the global SMB cluster setting. desired: If negotiation is enabled globally, it turns on data encryption for this share for clients that support encryption. required: Enforces encryption for the shares. Clients that do not support encryption are denied when accessing the share. If the global option is disabled, access is restricted to these shares for all clients |
| `--hidden` | Hidden share. Possible values: on, off |
| `--read-only` | Read only share. Possible values: on, off |

## Control SMB share user-lists

Manages a share's user lists, which allow or deny named users access to that share.

**Command:** `weka smb share lists show`

```sh
weka smb share lists show
```

**Command:** `weka smb share lists add`

```sh
weka smb share lists add <share-id> <user-list-type> [--users <strings>…]
```

**Command:** `weka smb share lists remove`

```sh
weka smb share lists remove <share-id> <user-list-type> [--users <strings>…]
```

**Command:** `weka smb share lists reset`

```sh
weka smb share lists reset <share-id> <user-list-type>
```

**Parameters**

| Parameter             | Description                                                                                       |
| --- | --- |
| `share-id`\* | Share ID. |
| `user-list-type`\* | User list type (read\_only, read\_write, valid, invalid). |
| `--users` \<strings>… | Users to add. Multiple values may be supplied separated by commas, or the option may be repeated. |

***

Use the following command line to remove users from a share user-list:

`weka smb share lists remove <share-id> <user-list-type> <--users users>...`

**Parameters**

| Name               | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `share-id`\*       | The ID of the share to be updated.                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `user-list-type`\* | The type of permissions list for `users`:`read_only`: list of users that do not get write access to the SMB share, regardless of the `read-only` setting.`read_write`: list of users get write access to the SMB share, regardless of the `read-only` setting.`valid`: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).`invalid`: list of users not allowed to log in to this SMB share service. |
| `users`\*          | A comma-separated list of users to remove from the `user-list-type` list. Can use the `@` notation to allow groups of users, e.g. `root, Jack, @domain\admins.`You can set up to 8 users/groups for all lists combined per share.                                                                                                                                                                                                                      |

***

Use the following command line to remove all users from a share user-list:

`weka smb share lists reset <share-id> <user-list-type>`

**Parameters**

| Name               | Value                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `share-id`\*       | The ID of the share to be updated                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `user-list-type`\* | The type of permissions list to reset:`read_only`: list of users that do not get write access to the SMB share, regardless of the `read-only` setting.`read_write`: list of users get write access to the SMB share, regardless of the `read-only` setting.`valid`: list of users allowed to log in to this SMB share service (an empty list means all users are allowed).`invalid`: list of users not allowed to log in to this SMB share service. |

## Remove SMB shares

Removes an SMB share. The underlying directory and its data are not deleted.

**Command:** `weka smb share remove`

```sh
weka smb share remove <share-id> [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `share-id`\* | Share ID. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

{% hint style="success" %}
**Example:** The following is an example of removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## Control SMB access based on hosts' IP/name

Manages a share's host-access rules, which allow or deny clients by IP address or host name.

**Command:** `weka smb share host-access list`

```sh
weka smb share host-access list
```

**Command:** `weka smb share host-access add`

```sh
weka smb share host-access add <share-id> <mode> [--ips <strings>…]
```

**Command:** `weka smb share host-access remove`

```sh
weka smb share host-access remove <share-id> <hosts>…
```

**Command:** `weka smb share host-access reset`

```sh
weka smb share host-access reset <share-id> <mode> [--force]
```

**Parameters**

| Parameter           | Description                                                                                       |
| --- | --- |
| `share-id`\* | Share ID. |
| `mode`\* | Access mode (allow/deny). Possible values: allow, deny |
| `--ips` \<strings>… | IP addresses. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `hosts`\*… | Hosts to remove. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

Use the following command line to remove hosts from the allow or deny list.

`weka smb share host-access remove <share-id> <hosts>`

**Parameters**

<table><thead><tr><th width="248">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to update.<br>Mandatory for the share-level command.</td></tr><tr><td><code>hosts</code>*</td><td><p>A list of hostnames you want to remove from access.</p><ul><li>Separate host names with spaces.</li><li>Use the IP addresses displayed under the <code>HOST</code> column when running the corresponding <code>list</code> command.</li></ul></td></tr></tbody></table>

Use the following command line to remove all hosts from the allow or deny list:

`weka smb share host-access reset <share-id> <mode>`

**Parameters**

<table><thead><tr><th width="301">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>share-id</code>*</td><td>The ID of the share to update.<br>Mandatory for the share-level command.</td></tr><tr><td><code>mode</code>*</td><td><p>The specified access mode will remove all associated hosts from the list.</p><p>Possible values: <code>allow</code>, <code>deny</code>.</p></td></tr></tbody></table>

[^1]: **Control characters** are non-printable characters used to manage the flow of text and commands, such as starting a new line, triggering alerts, or formatting text. They do not represent visible symbols and are typically not allowed in filenames or share names.

{% hint style="info" %}
SMB-W supports access based on the host IP addresses (but not host names).
{% endhint %}
