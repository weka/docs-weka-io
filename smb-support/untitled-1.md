---
description: >-
  This page details SMB management - setting up an SMB cluster over WekaIO
  filesystems and managing the cluster itself - using CLIs.
---

# SMB Management Using CLIs

## Overview

The WekaIO system has a number of CLI commands for setting up an SMB cluster over WekaIO filesystems. Used for managing the cluster itself, they are all located under the`weka smb cluster` command. They define what WekaIO hosts will participate in the SMB cluster, and what \(if any\) public IPs will be exposed by the SMB cluster. 

## Showing an SMB Cluster

**Command:** `weka smb cluster`

Use the following command line to view information about the SMB cluster managed by WekaIO:

`smb cluster` 

## Creating an SMB Cluster

**Command:** `weka smb cluster create`

Use the following command line to create a new SMB cluster to be managed by WekaIO:

`weka smb cluster create <workgroup> [--samba-hosts] [--samba-hosts samba-hosts]... [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]...` 

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>workgroup</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The name of the SMB cluster being created, used as the SMB workgroup name</td>
      <td
      style="text-align:left">Must be a valid name</td>
        <td style="text-align:left">Yes</td>
        <td style="text-align:left">&#x200B;</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>samba-hosts</code>
      </td>
      <td style="text-align:left">Comma- separated strings</td>
      <td style="text-align:left">A list of 3-8 WekaIO system hosts to participate in the SMB cluster, based
        on the host IDs in WekaIO</td>
      <td style="text-align:left">Must be valid host IDs</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left">&#x200B;Pass</td>
    </tr>
    <tr>
      <td style="text-align:left">
        <p><code>smb-ips-pool</code>
        </p>
        <p>&lt;code&gt;&lt;/code&gt;</p>
      </td>
      <td style="text-align:left">Comma- separated IP addresses</td>
      <td style="text-align:left">The public IPs used as floating IPs that the SMB cluster will server the
        SMB over, and thereby provide HA; should not be assigned to any host on
        the network</td>
      <td style="text-align:left">Must be valid IP addresses</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">&#x200B;</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>smb-ips-range</code>
      </td>
      <td style="text-align:left">IP address range</td>
      <td style="text-align:left">The public IPs used as floating IPs that the SMB cluster will server the
        SMB over and thereby provide HA; should not be assigned to any host on
        the network</td>
      <td style="text-align:left">Must be a valid name</td>
      <td style="text-align:left">No&#x200B;</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>{% hint style="info" %}
**Notes:**

All IPs must reside on the same subnet, in order to enable HA through IP takeover.

The IPs **MUST NOT** be in use by any other application/host in the subnet, including WekaIO management nodes, WekaIO IO nodes, or WekaIO NFS floating IPs. In AWS environments, these IPs should not be provided**.**

The `--smb-ips` parameter is supposed to accept the public IPs that the SMB cluster will expose. To mount the SMB cluster in an HA manner, they should be mounted via one of the exposed public IPs, thereby ensuring that they will not lose connection if one of the SMB hosts fails.
{% endhint %}

{% hint style="warning" %}
**For Example:**

`weka smb cluster create oab --samba-hosts 0,1,2,3 --samba-hosts 4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over WekaIO system hosts 0-4. The Samba cluster is called `oab`and is directed to use public IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Deleting an SMB Cluster

**Command:** `weka smb cluster destroy`

Deleting an existing SMB cluster managed by WekaIO will not delete the backend WekaIO filesystems, but just stop exposure of the data of these filesystems via SMB.

Use the following command line to destroy an SMB cluster managed by WekaIO:

`smb cluster destroy` 

{% hint style="info" %}
**Note:** Editing an existing cluster is not supported. Consequently, to change anything in a SMB cluster, the cluster has to be deleted and recreated. 
{% endhint %}

## Listing SMB Users

**Command:** `weka smb user`

Use the following command line to list all existing, authenticated WekaIO users of the SMB cluster.

`smb user` 

## Adding SMB Users

**Command:** `weka smb user add`

Use the following command line to add a new WekaIO user to the SMB cluster:

`smb user add <username> <password> [--uid uid] [--gid gid]` 

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `username` | String |  The name of the user to be added | Must be a valid name | Yes | ​ |
| `password` | String | The password of the user to be added | Must be a valid password | Yes | ​ |
| `uid` | Number | The UID to be given to the user | Must be a valid number | Yes | ​ |
| `gid` | Number | The GID to be given to the user | Must be a valid number | Yes |  |

{% hint style="warning" %}
**For Example:** 

`weka smb user add testuser pass  
weka smb user add testuser2 pass --uid 1002 --gid 1003`

In this example, the first SMB user ID is 0, the username is testuser, the user ID is -1 and the GID is -1. The second SMB user ID is 1, the username is testuser2, the user ID is 1002 and the GID is 1003.
{% endhint %}

## Removing SMB Users

**Command:** `weka smb user remove`

Use the following command line to  remove authorization of a WekaIO user from the SMB cluster:

 `smb user remove <user-id>` 

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `user-id` | Number |  The ID of the user to be removed, as it appears using the `weka smb user` command | Must be a valid number | Yes | ​ |

{% hint style="warning" %}
**For Example:** 

`weka smb user remove 0`

 In this example, the SMB user with ID 0 is removed.
{% endhint %}

## Listing SMB Shares

**Command:** `weka smb share`

Use the following command line to list all existing SMB shares:

`smb share` 

## Adding SMB Shares

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed to SMB:

`smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [--mount-option mount-option]` 

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-name` | String | The name of the share being added | Must be a valid name | Yes | ​ |
| `fs-name` | String | The name of the filesystem to share | Must be a valid name | Yes | ​ |
| `description` | String | Description of what the share will receive when viewed remotely | Must be a valid string | No | ​No description |
| `internal-path` | String | An internal path within the filesystem \(relative to its root\) which will be exposed | Must be a valid path | No | / |
| `mount-option` | String | Definition of the filesystem mounting - readcache/writecache | Must be a valid mount | No | Write cache |

{% hint style="warning" %}
**For Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default  
weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first Samba share added has the WekaIO share for default.  The second Samba share has internal for default.
{% endhint %}

{% hint style="info" %}
**Note:**  if it is necessary to pass to the Samba library share specific options, contact the WekaIO Support Team.
{% endhint %}

## Removing SMB Shares

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`smb share remove <share-name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-name` | String |  The ID of the share to be removed | Must be a valid name  of a currently-defined share | Yes | ​ |

{% hint style="warning" %}
**For Example:** The following is an example for removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## **Changing** SMB Share Owner

**Command:** `weka smb share chown`

Use the following command line to chown a share to a specific user, i.e., to chown a share to a specific UID/GID that belongs to a known SMB user in the WekaIO system:

`smb share chown <share-id> [--uid uid] [--gid gid]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-id` | String | The ID of the share to be removed | Must be a valid name | Yes | ​ |
| `uid` | String | The UID of the share to be chowned | Must be a valid name | No | ​ |
| `gid` | String | The GID of the share to be chowned | Must be a valid name |  | ​ |

{% hint style="warning" %}
**For Example:** For a WekaIO SMB with user ID `1`, username`testuser 2`, UID `1002` and GID `1003,` the following command will be given for chowning:

`weka smb share chown 0 --UID 1002 --GID 1003`
{% endhint %}



