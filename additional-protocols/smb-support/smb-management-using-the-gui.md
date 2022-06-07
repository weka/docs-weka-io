---
description: >-
  This page provides procedures for setting up an SMB cluster over Weka
  filesystems and managing the cluster itself, using the GUI.
---

# Manage SMB using the GUI

Using the GUI, you can:

* [Configure the SMB cluster](smb-management-using-the-gui.md#configure-an-smb-cluster)
* [Join the SMB cluster in the Active Directory](smb-management-using-the-gui.md#join-the-smb-cluster-in-an-active-directory)
* [Delete the SMB cluster](smb-management-using-the-gui.md#delete-an-smb-cluster)
* [Display the SMB shares list](smb-management-using-the-gui.md#list-smb-shares)
* [Add an SMB share](smb-management-using-the-gui.md#add-an-smb-share)
* [Remove an SMB share](smb-management-using-the-gui.md#remove-an-smb-share)

{% hint style="info" %}
**Note:** Use ASCII format when configuring name fields, such as domain and shares.
{% endhint %}

## **Configure the SMB cluster**

Define the Weka system hosts that participate in the SMB cluster**.**

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **SMB**.
3. On the Configuration tab, select **Configure**.

![SMB cluster configuration tab](../../.gitbook/assets/wmng\_smb\_configure\_button.png)

4\. In the SMB Cluster Configuration dialog, set the following properties:

* **Name**: A NetBIOS name for the SMB cluster.
* **Domain**: The domain which the SMB cluster is to join.
* **Domain NetBIOS Name**: (Optional) The domain NetBIOS name.
* **Hosts**: List of 3-8 Weka system hosts to participate in the SMB cluster, based on the host IDs in Weka.
* **IPs**: (Optional) List of public IPs (comma-separated) used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA (do not assign these IPs to any host on the network). For IP range, use the following format: **a.b.c.x-y**.

{% hint style="info" %}
In AWS installations, it is not possible to set a list of SMB service addresses. The SMB service must be accessed using the primary addresses of the cluster nodes.
{% endhint %}

5\. Select **Save**.

![SMB Cluster Configuration dialog](../../.gitbook/assets/wmng\_smb\_configure\_dialog.gif)

Once the system completes the configuration process, the host statuses change from not ready (red X icon) to ready (green V icon), as shown in the following example:

![SMB cluster configuration example](../../.gitbook/assets/wmng\_smb\_configure\_result.png)

## Join the SMB cluster in the Active Directory

To enable the organizational Active Directory to resolve the access of users and user groups to the SMB cluster, join the SMB cluster in the Active Directory (AD).

**Before you begin**

To enable the Weka storage nodes to join the AD domain, verify that the AD server is the DNS server.&#x20;

**Procedure**

1. In the SMB Cluster Configuration, select **Join**.

![Join the SMB cluster in the Active Directory](../../.gitbook/assets/wmng\_smb\_join\_ad\_button.png)



2\. In the Join to Active Directory dialog, set the following properties:

* **Username** and **Password**: A username and password of an account that has access privileges to the Active Directory. Weka does not save the user password. A computer account is created on behalf of the user for the SMB cluster.
* **Server**: (Optional) Weka identifies the AD server automatically based on the AD name. You do not need to set the server name. In some cases, if required, specify the AD server.
* **Computers Org. Unit**: The default organization unit is the Computers directory. You can define any other directory to connect to in Active Directory, such as SMB servers or Corporate computers.

![Join To Active Directory dialog](../../.gitbook/assets/wmng\_smb\_join\_ad\_dialog.png)

Once the SMB cluster joins in the Active Directory, the join status next to the domain changes to **Joined**.

{% hint style="info" %}
To join a different Active Directory to the existing SMB cluster configuration, select **Leave**. To confirm the action, enter the username and password used to connect to the Active Directory.
{% endhint %}

## Delete the SMB cluster

Deleting the SMB cluster resets its configuration data.

**Procedure**

1. In the SMB Cluster Configuration, select the **trash** icon.
2. In the SMB Configuration Reset message, to confirm, select **Reset**.

![Delete the SMB cluster configuration](../../.gitbook/assets/wmng\_smb\_cluster\_remove.png)

## **Display the SMB shares list**

The Shares tab displays the list of the SMB shares that are already created in the system.&#x20;

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **SMB**.
3. Select the **Shares** tab.\
   You can filter the list using any column in the table.

![SMB shares list](../../.gitbook/assets/wmng\_smb\_list\_shares.png)

## Add an SMB share

**Procedure**

1. In the Shares tab, select **+Create**.

![Create an SMB share](../../.gitbook/assets/wmng\_smb\_share\_create\_button.png)

2\. In the Add SMB Share dialog, set the following properties:

* **Name**: A meaningful name for the SMB share.&#x20;
* **Description**: A description of the SMB share.&#x20;
* **Filesystem**: The filesystem to use for the SMB share. Select one from the list.
* **Path**: A valid internal path, relative to the root, within the filesystem to expose for the SMB share.
* **Files/Directories POSIX Mode Mask**: Set the new default file and directory permissions in a numeric (octal) format created through the share.
* **ACLs Enabled**: Determines whether to enable the Windows Access-Control Lists (ACLs) on the share. Weka translates the ACLs to POSIX.

3\. Select **Save**.

![Add SMB Share dialog](../../.gitbook/assets/wmng\_smb\_share\_add\_dialog.png)

## Remove an SMB share

**Procedure**

1. In the Shares tab, select the three dots of the share and select **Remove**.

![Remove an SMB . share](../../.gitbook/assets/wmng\_smb\_share\_remove.png)

2\. In the confirmation message that appears, select **Confirm**.\
&#x20;   The removed share no longer appears in the SMB Shares list.
