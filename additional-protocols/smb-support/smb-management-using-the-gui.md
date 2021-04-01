---
description: >-
  This page details SMB management - setting up an SMB cluster over Weka
  filesystems and managing the cluster itself - using the GUI.
---

# SMB Management Using the GUI

{% hint style="info" %}
**Note:** Use ASCII format when configuring name fields \(e.g., domain, shares, etc.\)
{% endhint %}

## **Configuring an SMB Cluster**

To configure an SMB cluster, first access the SMB Service view.

![SMB Service View](../../.gitbook/assets/smb-clean-3.6.png)

To configure the SMB cluster, click the Configure button. The following Configure Cluster window will be displayed:

![Configure SMB Cluster Window](../../.gitbook/assets/smb-configure-3.6.png)

Enter the name and domain, choose between 3 to 8 hosts, and enter the IPs \(make sure to provide IPs equal to or 3 times greater than the number of hosts selected\). Then click the Configure button.

{% hint style="info" %}
**Note:** in order to add an IP range, it is possible to use`a.b.c.x-y` notation.
{% endhint %}

{% hint style="info" %}
**Note:** In AWS installations, it is not possible to enter a list of SMB service addresses. The SMB service must be accessed using the primary addresses of the cluster nodes.
{% endhint %}

The following SMB Cluster Configuration window will be displayed:

![SMB Cluster Configuration Window](../../.gitbook/assets/smb-cluster-not-joined-3.6.png)

{% hint style="info" %}
**Note:** The status of the hosts will change from not ready to ready.
{% endhint %}

## Joining the SMB Cluster to an Active Directory

To join the SMB cluster to an Active Directory, click the Join button when all hosts have been prepared and are ready. The following window will be displayed:

![Join SMB Cluster to Active Directory Window](../../.gitbook/assets/selection_758.png)

Enter the provided username and password in order to access the Active Directory. The Server input field is optional. The default for the Computers Org.Unit field is the Computers directory, but it is possible to define any other directory in Active Directory to be connected, such as SMB servers or Corporate computers.

{% hint style="info" %}
**Note:** Weka does not save the user password. A computer account is created on behalf of the user for the SMB cluster.
{% endhint %}

{% hint style="info" %}
**Note:** The AD server must be the DNS server for the Weka storage nodes in order for them to join the AD domain
{% endhint %}

On successful completion, the join status next to the domain will change to "joined" as shown below:

![SMB Cluster Configuration Window](../../.gitbook/assets/smb-cluster-joined-3.6.png)

In order to join another Active Directory to the current SMB cluster configuration, click the Leave button. To confirm this action, it is necessary to enter the username and password used to connect to the Active Directory.

## Deleting an SMB Cluster

To delete a configured SMB cluster, click the Reset button in the Configure SMB Cluster window. The following window will be displayed:

![SMB Cluster Reset Confirmation](../../.gitbook/assets/smb-cluster-reset-3.6.png)

Confirm the deletion by clicking the Reset button.

## **Listing SMB Shares**

To access SMB shares**,** click the SMB Shares tab in the SMB Service Overview screen. A list of all SMB shares will be displayed**:**

![SMB Shares List](../../.gitbook/assets/smb-shares-biew-3.6.png)

{% hint style="info" %}
**Note:** It is possible to filter this list using any column in the table.
{% endhint %}

## Adding an SMB Share

To add a new SMB share, click Create Share at the top right-hand corner of the table. The following Create Share window will be displayed:

![](../../.gitbook/assets/screen-shot-2019-07-28-at-9.49.20.png)

Enter the new share name and description, select a filesystem, and enter the path \(valid and relative internal path within the filesystem which will be exposed\). Also, determine the new default file/directory permissions created through the share. Then click the Create button. The new share will receive the `writecache` mount mode.

## Removing an SMB Share

To remove an SMB share, click anywhere on the row to be removed and then click the Delete button.

![Removing an SMB Share](../../.gitbook/assets/smb-shares-biew-3.6.png)

The SMB Share Deletion window will be displayed**:**

![SMB Share Deletion Window](../../.gitbook/assets/smb-share-deletion-3.6.png)

Click the Yes button to confirm the deletion of the share. The deleted share will no longer appear in the SMB Shares list.

