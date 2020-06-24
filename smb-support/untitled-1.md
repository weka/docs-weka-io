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

## Showing an SMB Domain Configuration

**Command:** `weka smb domain`

Use the following command line to view information about the SMB domain configuration:

`smb domain` 

## Creating an SMB Cluster

**Command:** `weka smb cluster create`

Use the following command line to create a new SMB cluster to be managed by WekaIO:

`weka smb cluster create <name> <domain> [--samba-hosts samba-hosts]... [--smb-ips-pool smb-ips-pool]... [--smb-ips-range smb-ips-range]...` 

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
      <td style="text-align:left"><code>name</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The NetBIOS name for the SMB cluster</td>
      <td style="text-align:left">Must be a valid name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>domain</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The domain which the SMB cluster is to join</td>
      <td style="text-align:left">Must be a valid name</td>
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
      <td style="text-align:left">The public IPs used as floating IPs for the SMB cluster to server the
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
      <td style="text-align:left">The public IPs used as floating IPs for the SMB cluster to server the
        SMB over and thereby provide HA; should not be assigned to any host on
        the network</td>
      <td style="text-align:left">Must be a valid name</td>
      <td style="text-align:left">No&#x200B;</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

{% hint style="info" %}
**Notes:**

All IPs must reside on the same subnet, in order to enable HA through IP takeover.

The IPs **MUST NOT** be in use by any other application/host in the subnet, including WekaIO management nodes, WekaIO IO nodes, or WekaIO NFS floating IPs. In AWS environments, these IPs should not be provided**.**

The `--smb-ips` parameter is supposed to accept the public IPs that the SMB cluster will expose. To mount the SMB cluster in an HA manner, they should be mounted via one of the exposed public IPs, thereby ensuring that they will not lose connection if one of the SMB hosts fails.
{% endhint %}

{% hint style="success" %}
**For Example:**

`weka smb cluster create oab mydomain --samba-hosts 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over WekaIO system hosts 0-4. The Samba cluster is called `oab,`the domain name is called `mydomain`and is directed to use public IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Deleting an SMB Cluster

**Command:** `weka smb cluster destroy`

Deleting an existing SMB cluster managed by WekaIO will not delete the backend WekaIO filesystems, but just stop exposure of the data of these filesystems via SMB.

Use the following command line to destroy an SMB cluster managed by WekaIO:

`smb cluster destroy` 

{% hint style="info" %}
**Note:** Editing an existing cluster is not supported. Consequently, to change anything in a SMB cluster, the cluster has to be deleted and recreated. 
{% endhint %}

## Joining an SMB Cluster to an Active Directory

**Command:** `weka smb domain join`

Use the following command line to join an SMB domain to an Active Directory:

`smb domain join <username> <password>` 

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `username` | String | The name of a user with permissions to add a machine to the domain. | Must be a valid name | Yes | Addition of up to 10 machines into the Active Directory |
| `password` | String | The password of the user. | Must be a valid password | Yes |  |

In order to join another Active Directory to the current SMB cluster configuration, it is necessary to leave the current Active Directory. This is performed using the following command line:

`smb domain leave <username> <password>` 

On completion of this operation, it is possible to join another Active Directory to the SMB cluster.

{% hint style="info" %}
**Note:** To configure a new Samba cluster, the current Samba cluster has to be deleted.
{% endhint %}

## Listing SMB Shares

**Command:** `weka smb share`

Use the following command line to list all existing SMB shares:

`smb share` 

## Adding SMB Shares

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed to SMB:

`smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [file-create-mask] [directory-create-mask]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-name` | String | The name of the share being added | Must be a valid name | Yes | ​ |
| `fs-name` | String | The name of the filesystem to share | Must be a valid name | Yes | ​ |
| `description` | String | Description of what the share will receive when viewed remotely | Must be a valid string | No | ​No description |
| `internal-path` | String | An internal path within the filesystem \(relative to its root\) which will be exposed | Must be a valid path | No | . |
| `file-create-mask` | String | POSIX permissions for file created through the SMB share | Numeric \(octal\) notation | No | 0744 |
| `directory-create-mask` | String | POSIX permissions for directories created through the SMB share | Numeric \(octal\) notation | No | 0755 |

{% hint style="info" %}
**Note:**  If it is necessary to pass to the Samba library share specific options, contact the WekaIO Support Team.
{% endhint %}

{% hint style="success" %}
**For Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default  
weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first Samba share added has the WekaIO share for default.  The second Samba share has internal for default.
{% endhint %}

## Removing SMB Shares

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`smb share remove <share-id>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-id` | String |  The ID of the share to be removed | Must be a valid name  of a currently-defined share | Yes | ​ |

{% hint style="success" %}
**For Example:** The following is an example for removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}

## \*\*\*\*



