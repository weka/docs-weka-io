---
description: This page describes SMB management using either CLI commands or the GUI.
---

# SMB Management

## SMB Management Using CLI Commands

The WekaIO system has a number of CLI commands for setting up an SMB cluster over WekaIO filesystems. Used for managing the cluster itself, they are all located under the`weka smb cluster` command. They define what WekaIO hosts will participate in the SMB cluster, and what \(if any\) public IPs will be exposed by the SMB cluster. 

### Showing an SMB Cluster

**Command:** `weka smb cluster`

Use the following command line to view information about the SMB cluster managed by WekaIO:

`smb cluster` 

### Creating an SMB Cluster

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
        <td style="text-align:left">​</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>samba-hosts</code>
      </td>
      <td style="text-align:left">Comma- separated strings</td>
      <td style="text-align:left">A list of 3-8 WekaIO system hosts to participate in the SMB cluster, based
        on the host IDs in WekaIO</td>
      <td style="text-align:left">Must be valid host IDs</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left">​Pass</td>
    </tr>
    <tr>
      <td style="text-align:left">
        <p><code>smb-ips-pool</code>
        </p>
        <p><code></code>
        </p>
      </td>
      <td style="text-align:left">Comma- separated IP addresses</td>
      <td style="text-align:left">The public IPs used as floating IPs that the SMB cluster will server the
        SMB over, and thereby provide HA; should not be assigned to any host on
        the network</td>
      <td style="text-align:left">Must be valid IP addresses</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">​</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>smb-ips-range</code>
      </td>
      <td style="text-align:left">IP address range</td>
      <td style="text-align:left">The public IPs used as floating IPs that the SMB cluster will server the
        SMB over and thereby provide HA; should not be assigned to any host on
        the network</td>
      <td style="text-align:left">Must be a valid name</td>
      <td style="text-align:left">No​</td>
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

### Deleting an SMB Cluster

**Command:** `weka smb cluster destroy`

Deleting an existing SMB cluster managed by WekaIO will not delete the backend WekaIO filesystems, but just stop exposure of the data of these filesystems via SMB.

Use the following command line to destroy an SMB cluster managed by WekaIO:

`smb cluster destroy` 

{% hint style="info" %}
**Note:** Editing an existing cluster is not supported. Consequently, to change anything in a SMB cluster, the cluster has to be deleted and recreated. 
{% endhint %}

### Listing SMB Users

**Command:** `weka smb user`

Use the following command line to list all existing, authenticated WekaIO users of the SMB cluster.

`smb user` 

### Adding SMB Users

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

### Removing SMB Users

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

### Listing SMB Shares

**Command:** `weka smb share`

Use the following command line to list all existing SMB shares:

`smb share` 

### Adding SMB Shares

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

### Removing SMB Shares

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

### **Changing** SMB Share Owner

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

## SMB Management Using the GUI

This section details SMB management - setting up an SMB cluster over WekaIO filesystems and managing the cluster itself - using the GUI. 

{% hint style="info" %}
**Note:** For activating GUI control of Samba, contact the WekaIO Support Team.
{% endhint %}

### **Configuring a Samba Cluster**

To configure a Samba cluster, first access the SMB Service view.

![SMB Service Overview Screen](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTHvibQhAt6mOZPuEix%2Fimage.png?alt=media&token=cff1d83c-7558-4d67-a72b-a5cac8a0e2a7)

To configure the Samba cluster, click the Configure button. The following Configure Cluster window will be displayed:

![Configure SMB Cluster Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTI99ejJJTKHIWL3s63%2Fimage.png?alt=media&token=76b938f0-de2e-4e06-a61d-f17fd6fc4010)

Enter the workgroup name, choose between 3 to 8 hosts and enter the IPs \(make sure to provide IPs equal to or 3 times greater than the number of hosts selected\). Then click the Configure button.

{% hint style="info" %}
**Note:** in order to add an IP range, it is possible to use`a.b.c.x-y` notation.
{% endhint %}

The following Samba Cluster Configuration window will be displayed:

![Samba Cluster Configuration Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTIAdMwedoG9jlIcDK4%2Fimage.png?alt=media&token=f1b510d5-aa44-4e1c-9778-ef15f23f3ffa)

{% hint style="info" %}
**Note:** The status of the hosts will change from not-ready to ready.
{% endhint %}

### Deleting a Samba Cluster <a id="deleting-a-samba-cluster"></a>

To delete a configured Samba cluster, click the Reset button in the Configure Samba Cluster window. The following window will be displayed:

![Samba Cluster Reset Confirmation](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTIBT97FiPHaaztFlHj%2Fimage.png?alt=media&token=eb11e80b-624c-44f0-b587-305caccd63ee)

Confirm the deletion by clicking the Reset button.

### **Listing SMB Users** <a id="listing-smb-users-1"></a>

To access the list of SMB users, click the Authentication tab in the SMB Service Overview screen. A list of all authenticated users will be displayed**:**

![SMB Authenticated Users List](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI-14rs2vp46wOPQ3k%2Fimage.png?alt=media&token=3984a6a2-1fe2-497c-8123-10ec8bbc9090)

### Adding SMB Users <a id="adding-smb-users-1"></a>

To add a new user, click Create User at the top right-hand corner of the table. The following Create User window will be displayed:

![Create SMB User Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI-SApeR0rM8xcfAHP%2Fimage.png?alt=media&token=3ddb12d9-dab6-410a-9582-27c967aa0601)

Enter the username, UID \(must be unique\), GID, password and confirm the password by re-typing it. Then click the Create button. The newly-created user now appears in the SMB Authenticated Users list.

### Removing SMB Users <a id="removing-smb-users-1"></a>

To remove an SMB user, click on a trash icon in the SMB Authenticated Users list. The following Samba User Deletion window is displayed:

![SMB User Deletion Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI0ukQHCzZC8H4RMyk%2Fimage.png?alt=media&token=5beb397b-fdf3-4c7e-ae09-2915408ff7ae)

Click the Yes button to confirm deletion of the user. The deleted user will no longer appear in the SMB Authenticated Users list.

### **Listing SMB Shares** <a id="listing-smb-shares-1"></a>

To access SMB shares**,** click the SMB Shares tab in the SMB Service Overview screen. A list of all SMB shares will be displayed**:**

![SMB Shares List](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI3bjjcEJCiHJXlhRT%2Fimage.png?alt=media&token=3f65387b-e362-43c1-873a-ae40853aaa6c)

{% hint style="info" %}
**Note:** It is possible to filter this list using any column in the table.
{% endhint %}

### Adding an SMB Share <a id="adding-an-smb-share"></a>

To add a new SMB share, click Create Share at the top right-hand corner of the table. The following Create Share window will be displayed:

![Create SMB Share Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTICCwBp8DJ-2POLbLa%2Fimage.png?alt=media&token=082ece86-984f-4905-99a6-8d2b54eb46cd)

Enter the new share name and description, select a filesystem, enter the path and select the mount mode. Then click the Create button.

### Removing an SMB Share <a id="removing-an-smb-share"></a>

To remove an SMB share, click anywhere on the row to be removed and then click the Delete button.

![Removing an SMB Share](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI5UZ-eCnsqvaLKX9s%2Fimage.png?alt=media&token=f97b446e-750c-42f4-8946-a0ecf16b396a)

The Samba Share Deletion window will be displayed**:**

![Samba Share Deletion Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI5Bt6q5vavn9uS_hS%2Fimage.png?alt=media&token=15b7f458-c61a-470c-b79a-430a2cb81dd6)

Click the Yes button to confirm deletion of the share. The deleted share will no longer appear in the SMB Shares list.

### Changing an SMB Share Owner <a id="changing-an-smb-share-owner"></a>

To change an SMB share owner, click anywhere on the relevant share row and then click the Chown button. The following Chown Share window will be displayed**:**

![Chown Share Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI63Ba2Xp6_8dhNJvv%2Fimage.png?alt=media&token=1ef3268a-efc6-470e-8b25-3139cb0398f8)

Select the owner to be changed by selecting the UID and GID of the relevant user\(s\). Then click the Chown button.

In order to check the current owner\(s\) of a share, click the Show Owner button in the SMB Shares window. A window detailing the current owner\(s\) will be displayed. Click the OK button to exit this window.

![Current SMB Share Owner Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI6qDMwjD2L2rx_cLp%2Fimage.png?alt=media&token=c7c62edd-165f-4fe0-8b8d-c6e3bcc43257)

## ​ <a id="undefined"></a>



