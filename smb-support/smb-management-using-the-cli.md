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

Use this command to view information about the SMB cluster managed by the WekaIO system.

## Showing an SMB Domain Configuration

**Command:** `weka smb domain`

Use this command to view information about the SMB domain configuration.

## Creating an SMB Cluster

**Command:** `weka smb cluster create`

Use the following command line to create a new SMB cluster to be managed by the WekaIO system:

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
      <td style="text-align:left">NetBIOS name for the SMB cluster</td>
      <td style="text-align:left">Must be a valid name (ASCII)</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>domain</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Domain which the SMB cluster is to join</td>
      <td style="text-align:left">Must be a valid name (ASCII)</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left">&#x200B;</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>samba-hosts</code>
      </td>
      <td style="text-align:left">Comma- separated strings</td>
      <td style="text-align:left">List of 3-8 WekaIO system hosts to participate in the SMB cluster, based
        on the host IDs in WekaIO</td>
      <td style="text-align:left">Must be valid host IDs</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left">&#x200B;</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>smb-ips-pool</code>
      </td>
      <td style="text-align:left">Comma- separated IP addresses</td>
      <td style="text-align:left">Public IPs used as floating IPs for the SMB cluster to server the SMB
        over, and thereby provide HA; should not be assigned to any host on the
        network</td>
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
      <td style="text-align:left">
        <p>Format: A.B.C.D-E</p>
        <p>E.g., 10.10.0.1-100</p>
      </td>
      <td style="text-align:left">No&#x200B;</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>domain-netbios-name</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Domain NetBIOS name</td>
      <td style="text-align:left">Must be a valid name (ASCII)</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">First part of<code>domain</code> parameter</td>
    </tr>
  </tbody>
</table>{% hint style="info" %}
**Note:** All IPs must reside on the same subnet, in order to enable HA through IP takeover.
{% endhint %}

{% hint style="info" %}
**Note:** The IPs **MUST NOT** be in use by any other application/host in the subnet, including WekaIO system management nodes, WekaIO system IO nodes, or WekaIO system NFS floating IPs. In AWS environments, this is not supported and these IPs should not be provided**.**
{% endhint %}

{% hint style="info" %}
**Note:** The `--smb-ips` parameter is supposed to accept the public IPs that the SMB cluster will expose. To mount the SMB cluster in an HA manner, they should be mounted via one of the exposed public IPs, thereby ensuring that they will not lose connection if one of the SMB hosts fails.
{% endhint %}

{% hint style="info" %}
**Note:** If it is necessary to set global options to the SMB library, contact the WekaIO Support Team.
{% endhint %}

{% hint style="success" %}
**For Example:**

`weka smb cluster create wekaSMB mydomain --samba-hosts 0,1,2,3,4 --smb-ips-pool 1.1.1.1,1.1.1.2 --smb-ips-range 1.1.1.3-5`

In this example of a full command, an SMB cluster is configured over WekaIO system hosts 0-4. The SMB cluster is called `wekaSMB,`the domain name is called `mydomain`and is directed to use public IPs 1.1.1.1 to 1.1.1.5.
{% endhint %}

## Checking Status of SMB Host Readiness

**Command:** `weka smb cluster status`

Use this command to check the status of the hosts which are part of the SMB cluster. Once all host are prepared and ready, it is possible to join an SMB cluster to an Active Directory.

## Joining an SMB Cluster to an Active Directory

**Command:** `weka smb domain join`

Use the following command line to join an SMB domain to an Active Directory:

`smb domain join <username> <password>` 

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `username` | String | Name of a user with permissions to add a machine to the domain | Must be a valid name \(ASCII\) | Yes |  |
| `password` | String | Password of the user | Must be a valid password \(ASCII\) | Yes |  |

In order to join another Active Directory to the current SMB cluster configuration, it is necessary to leave the current Active Directory. This is performed using the following command line:

`smb domain leave <username> <password>` 

On completion of this operation, it is possible to join another Active Directory to the SMB cluster.

{% hint style="info" %}
**Note:** To configure a new SMB cluster, the current SMB cluster has to be deleted.
{% endhint %}

## Deleting an SMB Cluster

**Command:** `weka smb cluster destroy`

Use this command to destroy an SMB cluster managed by the WekaIO system.

Deleting an existing SMB cluster managed by the WekaIO system does not delete the backend WekaIO filesystems, but removes the SMB share exposures of these filesystems.

{% hint style="info" %}
**Note:** Editing an existing cluster is not supported. Consequently, to change an SMB cluster configuration, the cluster has to be deleted and recreated. 
{% endhint %}

## Listing SMB Shares

**Command:** `weka smb share`

Use this command to list all existing SMB shares.

## Adding SMB Shares

**Command:** `weka smb share add`

Use the following command line to add a new share to be exposed to SMB:

`smb share add <share-name> <fs-name> [--description description] [--internal-path internal-path] [file-create-mask] [directory-create-mask]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-name` | String | Name of the share being added | Must be a valid name \(ASCII\) | Yes | ​ |
| `fs-name` | String | Name of the filesystem to share | Must be a valid name | Yes | ​ |
| `description` | String | Description of what the share will receive when viewed remotely | Must be a valid string | No | ​No description |
| `internal-path` | String | Internal path within the filesystem \(relative to its root\) which will be exposed | Must be a valid path | No | . |
| `file-create-mask` | String | POSIX permissions for file created through the SMB share | Numeric \(octal\) notation | No | 0744 |
| `directory-create-mask` | String | POSIX permissions for directories created through the SMB share | Numeric \(octal\) notation | No | 0755 |

{% hint style="info" %}
**Note:**  If it is necessary to set share specific options to the SMB library, contact the WekaIO Support Team.
{% endhint %}

{% hint style="success" %}
**For Example:** The following is an example for adding users to a share mounted on a filesystem named "default":

`weka smb share add rootShare default  
weka smb share add internalShare default --internal-path some/dir --description "Exposed share"`

In this example, the first SMB share added has the WekaIO system share for default.  The second SMB share has internal for default.
{% endhint %}

## Removing SMB Shares

**Command:** `weka smb share remove`

Use the following command line to remove a share exposed to SMB:

`smb share remove <share-id>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `share-id` | String | ID of the share to be removed | Must be a valid name  of a currently-defined share | Yes | ​ |

{% hint style="success" %}
**For Example:** The following is an example for removing an SMB share defined as ID 1:

`weka smb share remove 1`
{% endhint %}



