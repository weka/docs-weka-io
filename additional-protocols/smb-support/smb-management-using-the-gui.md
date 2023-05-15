---
description: >-
  This page provides procedures for setting up an SMB cluster over WEKA
  filesystems and managing the cluster itself, using the GUI.
---

# Manage SMB using the GUI

WEKAWEKAUsing the GUI, you can:

* [Configure the SMB cluster](smb-management-using-the-gui.md#configure-the-smb-cluster) (not applicable for SMB-W)
* [Edit the SMB cluster](smb-management-using-the-gui.md#edit-the-smb-cluster)
* [Join the SMB cluster in the Active Directory](smb-management-using-the-gui.md#join-the-smb-cluster-in-the-active-directory)
* [Delete the SMB cluster](smb-management-using-the-gui.md#delete-the-smb-cluster)
* [Display the SMB shares list](smb-management-using-the-gui.md#display-the-smb-shares-list)
* [Add an SMB share](smb-management-using-the-gui.md#add-an-smb-share)
* [Edit an SMB share](smb-management-using-the-gui.md#undefined)
* [Remove an SMB share](smb-management-using-the-gui.md#remove-an-smb-share)

{% hint style="info" %}
Using the GUI, you can manage the SMB-W cluster, but not configure and delete it. See [Manage SMB using the CLI](smb-management-using-the-cli.md).\
When managing an SMB-W cluster using the GUI, the limitations related to SMB-W in the CLI commands also apply.
{% endhint %}

{% hint style="info" %}
**Note:** Use ASCII format when configuring name fields, such as domain and shares.
{% endhint %}

## **Configure the SMB cluster** <a href="#configure-the-smb-cluster" id="configure-the-smb-cluster"></a>

Define the WEKA system servers that participate in the SMB cluster (with legacy SMB only)**.**

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **SMB**.
3. On the Configuration tab, select **Configure**.

![SMB cluster configuration tab](../../.gitbook/assets/wmng\_smb\_configure\_button.png)

4\. In the SMB Cluster Configuration dialog, set the following properties:

* **Name**: A NetBIOS name for the SMB cluster.
* **Domain**: The domain the SMB cluster joins.
* **Domain NetBIOS Name**: (Optional) The domain NetBIOS name.
* **Servers**: List of 3-8 WEKA system servers to participate in the SMB cluster, based on the server IDs in WEKA.
* **Encryption:** Select the in-transit encryption to use in the SMB cluster:\
  \- enabled: enables encryption negotiation but doesn't turn it on automatically for supported\
  sessions and share connections.\
  \- disabled: doesn't support encrypted connections.\
  \- desired: enables encryption negotiation and turns on data encryption on supported sessions\
  and share connections.\
  \- required: enforces data encryption on sessions and share connections. Clients that do not\
  support encryption will be denied access to the server.
* **IPs**: (Optional) List of public IPs (comma-separated) used as floating IPs for the SMB cluster to serve the SMB over and thereby provide HA (do not assign these IPs to any server on the network). For IP range, use the following format: **a.b.c.x-y**.

{% hint style="info" %}
In all cloud installations, it is not possible to set a list of SMB service addresses. The SMB service must be accessed using the primary addresses of the cluster nodes.
{% endhint %}

5\. Select **Save**.

<figure><img src="../../.gitbook/assets/wmng_smb_configure_dialog (2).gif" alt=""><figcaption><p>SMB cluster configuration</p></figcaption></figure>

Once the system completes the configuration process, the server statuses change from not ready (red X icon) to ready (green V icon).

![SMB cluster configuration example](../../.gitbook/assets/wmng\_smb\_configure\_result.png)

## Edit the SMB cluster <a href="#edit-the-smb-cluster" id="edit-the-smb-cluster"></a>

You can modify the encryption and IPs settings according to your needs.

**Procedure**

1. In the SMB Cluster Configuration, select the **pencil** icon.

<figure><img src="../../.gitbook/assets/wmng_smb_cluster_edit.png" alt=""><figcaption><p>Edit the SMB cluster</p></figcaption></figure>

2\. In the Edit SMB Configuration dialog, update the encryption and IPs settings.

<figure><img src="../../.gitbook/assets/wmng_edit_smb_configuration.png" alt=""><figcaption><p>Edit SMB configuration</p></figcaption></figure>

3\. Select **Save**.

## Join the SMB cluster in the Active Directory <a href="#join-the-smb-cluster-in-the-active-directory" id="join-the-smb-cluster-in-the-active-directory"></a>

To enable the organizational Active Directory to resolve the access of users and user groups to the SMB cluster, join the SMB cluster in the Active Directory (AD).

**Before you begin**

Enable the WEKA storage nodes to join the AD domain. On all backend servers used for SMB, set the AD servers as DNS servers in the  /`etc/resolv.conf` file.

**Procedure**

1. In the SMB Cluster Configuration, select **Join**.

![Join the SMB cluster in the Active Directory](<../../.gitbook/assets/wmng\_smb\_join\_ad\_button (1).png>)

2\. In the Join to Active Directory dialog, set the following properties:

* **Username** and **Password**: A username and password of an account that has access privileges to the Active Directory. WEKA does not save the user password. A computer account is created on behalf of the user for the SMB cluster.
* **Server**: (Optional) WEKA identifies the AD server automatically based on the AD name. You do not need to set the server name. In some cases, if required, specify the AD server.
* **Computers Org. Unit**: The default organization unit is the Computers directory. You can define any other directory to connect to in Active Directory, such as SMB servers or Corporate computers.

![Join Active Directory dialog](../../.gitbook/assets/wmng\_smb\_join\_ad\_dialog.png)

Once the SMB cluster joins in the Active Directory, the join status next to the domain changes to **Joined**.

{% hint style="info" %}
To join a different Active Directory to the existing SMB cluster configuration, select **Leave**. To confirm the action, enter the username and password used to connect to the Active Directory.
{% endhint %}

## Delete the SMB cluster <a href="#delete-the-smb-cluster" id="delete-the-smb-cluster"></a>

Deleting the SMB cluster resets its configuration data.

**Procedure**

1. In the SMB Cluster Configuration, select the **trash** icon.

![Delete the SMB cluster configuration](../../.gitbook/assets/wmng\_smb\_cluster\_remove.png)

2\. In the SMB Configuration Reset message, select **Reset**.

## **Display the SMB shares list** <a href="#display-the-smb-shares-list" id="display-the-smb-shares-list"></a>

The Shares tab displays the list of SMB shares that are already created in the system. You can also customize the table columns of the SMB shares list.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **SMB**.
3. Select the **Shares** tab.\
   You can filter the list using any column in the table.

![SMB shares list](../../.gitbook/assets/wmng\_smb\_list\_shares.png)

## Add an SMB share <a href="#add-an-smb-share" id="add-an-smb-share"></a>

**Procedure**

1. In the Shares tab, select **+Create**.

![Create an SMB share](../../.gitbook/assets/wmng\_smb\_share\_create\_button.png)

3. In the Add SMB Share dialog, set the following properties:
   * **Name**: A meaningful name for the SMB share.
   * **Filesystem**: The filesystem name that includes the directory to share. Select one from the list.
   * **Description**: A description or purpose of the SMB share.
   * **Path**: A valid internal path, relative to the root, within the filesystem to expose the SMB share.
   * **Encryption:** Select in-transit encryption enforcement of the share. The global cluster encryption settings can affect the actual encryption.
   * **Read Only:** Select to set the share as read-only.
   * **Hidden:** Select if you want to hide the share so it is not visible when viewing the list of system shares.
   * **Allow Guest Access:** Select if you want guests to access without authentication.
   * **Access Permissions:** Define the share access permissions. If you select ON, select the access type and the users or groups allowed to access the share (comma-separated users and groups list, add '@' as a group prefix).
   * **Files/Directories POSIX Mode Mask**: Set the new default file and directory permissions in a numeric (octal) format created through the share.
   * **ACLs Enabled**: Determines whether to enable the Windows Access-Control Lists (ACLs) on the share. Weka translates the ACLs to POSIX.
4. Select **Save**.

![Add SMB Share dialog](../../.gitbook/assets/wmng\_smb\_share\_add\_dialog.png)

## Edit an SMB share <a href="#edit-an-smb-share" id="edit-an-smb-share"></a>

You can update some of the SMB share settings. These include encryption, hiding the share, allowing guest access, and setting the share as read only or not.

**Procedure**

1. In the Shares tab, select the three dots of the share and select **Edit**.

<figure><img src="../../.gitbook/assets/wmng_edit_smb_share_button.png" alt=""><figcaption></figcaption></figure>

2. In the Update Share Settings dialog, update the relevant properties and select **Save**.

<figure><img src="../../.gitbook/assets/wmng_update_share_settings.png" alt=""><figcaption><p>Update the SMB share settings</p></figcaption></figure>

## Remove an SMB share <a href="#remove-an-smb-share" id="remove-an-smb-share"></a>

**Procedure**

1. In the Shares tab, select the three dots of the share and select **Remove**.

![Remove an SMB . share](../../.gitbook/assets/wmng\_smb\_share\_remove.png)

2. In the confirmation message that appears, select **Confirm**.\
   The removed share no longer appears in the SMB Shares list.
