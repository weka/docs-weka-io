---
description: >-
  This page provides procedures for setting up an SMB cluster over WEKA
  filesystems and managing the cluster itself, using the GUI.
---

# Manage SMB using the GUI

Using the GUI, you can:

* [Configure the SMB cluster](smb-management-using-the-gui.md#configure-the-smb-cluster) (not applicable for legacy SMB)
* [Edit the SMB cluster](smb-management-using-the-gui.md#edit-the-smb-cluster)
* [Join the SMB cluster to Active Directory](smb-management-using-the-gui.md#join-the-smb-cluster-in-the-active-directory)
* [Add servers to the SMB cluster](smb-management-using-the-gui.md#add-or-remove-smb-cluster-hosts)
* [Remove servers from the SMB cluster](smb-management-using-the-gui.md#delete-the-smb-cluster)
* [Delete the SMB cluster](smb-management-using-the-gui.md#delete-the-smb-cluster)
* [Display the SMB shares list](smb-management-using-the-gui.md#display-the-smb-shares-list)
* [Add an SMB share](smb-management-using-the-gui.md#add-an-smb-share)
* [Edit an SMB share](smb-management-using-the-gui.md#undefined)
* [Remove an SMB share](smb-management-using-the-gui.md#remove-an-smb-share)

**Considerations:**

* When configuring the SMB cluster, the default is SMB-W. To create a legacy SMB cluster, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
* When managing an SMB-W cluster using the GUI, the limitations related to SMB-W in the CLI commands also apply.
* You can manage the legacy SMB cluster using the GUI but not configure or delete it. See [Manage SMB using the CLI](smb-management-using-the-cli.md).

{% hint style="info" %}
Use ASCII format when configuring name fields, such as domain and shares.
{% endhint %}

## **Configure the SMB cluster** <a href="#configure-the-smb-cluster" id="configure-the-smb-cluster"></a>

An SMB cluster comprises at least three WEKA servers running the SMB-W stack.

**Before you begin**

Verify that the dedicated filesystem for persistent protocol configurations is created. If not, create it. For details, see [#dedicated-filesystem-requirement-for-persistent-protocol-configurations](../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations "mention")

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **SMB**.
3. On the Configuration tab, select **Configure**.

![SMB cluster configuration tab](../../.gitbook/assets/wmng\_smb\_configure\_button.png)

4\. In the SMB Cluster Configuration dialog, set the following properties:

* **Name**: A name for the SMB cluster. This will be the name of the Active Directory computer object and the hostname part of the FQDN.
* **Domain**: The Active Directory domain to join the SMB cluster to.
* **Domain NetBIOS Name**: (Optional) The domain NetBIOS name.
* **Encryption:** Select the in-transit encryption mode to use in the SMB cluster:
  * **enabled**: enables encryption negotiation but doesn't turn it on automatically for supported sessions and share connections.
  * **desired**: enables encryption negotiation and turns on data encryption on supported sessions and share connections.
  * **required**: enforces data encryption on sessions and share connections. Clients that do not support encryption will be denied access to the server.
* **Servers**: List 3-8 WEKA system servers to participate in the SMB cluster, based on the server IDs in WEKA.
* **IPs**: (Optional) List of virtual IPs (comma-separated), used as floating IPs for the SMB cluster to provide HA to clients. These IPs must be unique; do not assign these IPs to any host on the network.\
  For an IP range, use the following format: **a.b.c.x-y**.
* **Config Filesystem:** select the filesystem used for persisting cluster-wide protocol configurations.

{% hint style="info" %}
Setting a list of SMB floating IPs in all-cloud installations is impossible due to cloud provider network limitations. In this case, the SMB service must be accessed by using the primary addresses of the cluster nodes.
{% endhint %}

5. Select **Save**.

<figure><img src="../../.gitbook/assets/wmng_smb_configure_dialog_4.2.6.gif" alt=""><figcaption><p>SMB cluster configuration</p></figcaption></figure>

Once the system completes configuration, the server statuses change from not ready (❌) to ready (✅).

![SMB cluster configuration example](../../.gitbook/assets/wmng\_smb\_configure\_result.png)

## Edit the SMB cluster <a href="#edit-the-smb-cluster" id="edit-the-smb-cluster"></a>

You can modify the encryption and IPs settings according to your needs.

**Procedure**

1. In the SMB Cluster Configuration, select the **pencil** icon.

<figure><img src="../../.gitbook/assets/wmng_smb_cluster_edit.png" alt=""><figcaption><p>Edit the SMB cluster</p></figcaption></figure>

2. In the Edit SMB Configuration dialog, do the following:
   * **Encryption:** Select one of the in-transit encryption enforcements: enabled, desired, or required.
   * &#x20;**IPs:** List of virtual IPs (comma-separated) used as floating IPs for the SMB cluster. (Floating IPs are not supported for cloud installations.)

<figure><img src="../../.gitbook/assets/wmng_edit_smb_configuration.png" alt=""><figcaption><p>Edit SMB configuration</p></figcaption></figure>

3\. Select **Save**.

## Join the SMB cluster to Active Directory <a href="#join-the-smb-cluster-in-the-active-directory" id="join-the-smb-cluster-in-the-active-directory"></a>

To enable the SMB cluster to use Active Directory to resolve the access of users and user groups, join the SMB cluster to Active Directory (AD).

**Before you begin**

Ensure the AD Domain Controllers are reachable by all WEKA servers participating in the SMB cluster. This resolution enables the WEKA servers to join the AD domain.

**Procedure**

1. In the SMB Cluster Configuration, select **Join**.

<figure><img src="../../.gitbook/assets/wmng_smb_join_ad_button (2).png" alt=""><figcaption><p>Join the SMB cluster in the Active Directory</p></figcaption></figure>

2. In the Join to Active Directory dialog, set the following properties:
   * **Username** and **Password**: A username and password of an account that has join privileges to the Active Directory domain. WEKA does not save these credentials: instead, a computer account is created for use by the SMB cluster.
   * **Server**: (Optional) WEKA identifies an AD Domain Controller server automatically based on the AD domain name. You do not need to set the server name. In some cases, if required, specify the AD server.
   * **Computers Org. Unit**: The default AD organizational unit (OU) for the computer account is the Computers directory. You can define any OU to create the computer account in - that the joining account has permissions to - such as SMB Servers or Corporate Computers.

![Join Active Directory dialog](../../.gitbook/assets/wmng\_smb\_join\_ad\_dialog.png)

Once the SMB cluster joins the Active Directory domain, the join status next to the domain changes to **Joined**.

{% hint style="info" %}
To join an existing SMB cluster to a different Active Directory domain, select **Leave**. To confirm the action, enter the username and password used to join the Active Directory domain.
{% endhint %}

## Add servers to the SMB cluster <a href="#add-or-remove-smb-cluster-hosts" id="add-or-remove-smb-cluster-hosts"></a>

Adding servers to the SMB cluster can provide several benefits and address various requirements, such as scalability, load balancing, high availability, and improved fault tolerance.

You can add servers to an SMB cluster that is already joined to an Active Directory domain.

#### Procedure

1. On the Servers pane, select **Add**.
2. In the Add SMB Cluster Servers dialog, select an available server or more from the list (maximum eight servers).
3. Select **Save**.

<figure><img src="../../.gitbook/assets/wmng_add_server_to_smb_cluser.gif" alt=""><figcaption><p>Add servers to the SMB cluster</p></figcaption></figure>

## Remove servers from the SMB cluster <a href="#delete-the-smb-cluster" id="delete-the-smb-cluster"></a>

&#x20;If the SMB cluster has more servers than you need, you can remove the server.

The minimum required number of servers in an SMB cluster is three.&#x20;

#### Procedure

1. On the Servers pane, select Remove.
2. To remove one server, select the three dots next to the server to remove and select **Remove**.

<figure><img src="../../.gitbook/assets/wmng_remove_one_server.png" alt=""><figcaption><p>Remove one server from the SMB cluster</p></figcaption></figure>

3. To remove more than one server, from the Remove SMB Cluster Servers dialog, select the servers to remove (click the **X**), and select **Save**.

<figure><img src="../../.gitbook/assets/wmng_remove_few_servers.png" alt=""><figcaption><p>Remove more than one server from the SMB cluster</p></figcaption></figure>

## Delete the SMB cluster <a href="#delete-the-smb-cluster" id="delete-the-smb-cluster"></a>

Deleting the SMB cluster resets its configuration data. Deleting an SMB cluster only applies to SMB-W.

#### **Procedure**

1. In the SMB Cluster Configuration, select the **trash** icon.

![Delete the SMB cluster configuration](../../.gitbook/assets/wmng\_smb\_cluster\_remove.png)

2. In the SMB Configuration Reset message, select **Reset**.

## **Display the SMB shares list** <a href="#display-the-smb-shares-list" id="display-the-smb-shares-list"></a>

The Shares tab displays the SMB shares created in the system. You can also customize the table columns of the SMB shares.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **SMB**.
3. Select the **Shares** tab.\
   You can filter the list using any column in the table.

![SMB shares list](../../.gitbook/assets/wmng\_smb\_list\_shares.png)

## Add an SMB share <a href="#add-an-smb-share" id="add-an-smb-share"></a>

Once the SMB cluster is created and joined to the Active Directory, you can create SMB shares (maximum 1024). Each share must have a name and a shared path to the filesystem. It can be the root of the filesystem or a sub-directory.

**Before you begin**

Ensure the SMB cluster is joined to the Active Directory. For details, see [#join-the-smb-cluster-in-the-active-directory](smb-management-using-the-gui.md#join-the-smb-cluster-in-the-active-directory "mention").

**Procedure**

1. In the Shares tab, select **+Create**.
2. In the Add SMB Share dialog, set the following properties:
   * **Name**: A meaningful name for the SMB share.
   * **Filesystem**: The filesystem name that includes the directory to share. Select one from the list. A filesystem with Required Authentication set to ON cannot be used for SMB share.
   * **Description**: A description or purpose of the SMB share.
   * **Path**: A valid internal path, relative to the root, within the filesystem to expose the SMB share.
   * **Encryption:** Select in-transit encryption enforcement of the share. The global cluster encryption settings can affect the actual encryption.
   * **Read Only:** Select to set the share as read-only.
   * **Hidden:** Select if you want to hide the share so it is not visible when viewing the list of system shares.
   * **Allow Guest Access:** Select if you want guests to access without authentication.
   * **Access Permissions:** Define the share access permissions. If you select ON, select the access type and the users or groups allowed to access the share (comma-separated users and groups list, add '@' as a group prefix).
   * **Files/Directories POSIX Mode Mask**: Set the new default file and directory permissions in a numeric (octal) format created through the share.
   * **ACLs Enabled**: Determines whether to enable the Windows Access-Control Lists (ACLs) on the share. Weka translates the ACLs to POSIX.
3. Select **Save**.

![Add SMB Share dialog](<../../.gitbook/assets/wmng\_smb\_share\_add\_dialog (1).png>)

## Edit an SMB share <a href="#edit-an-smb-share" id="edit-an-smb-share"></a>

You can update some of the SMB share settings. These include encryption, hiding the share, allowing guest access, and setting the share as read only or not.

**Procedure**

1. In the Shares tab, select the three dots of the share and select **Edit**.

<figure><img src="../../.gitbook/assets/wmng_edit_smb_share_button.png" alt=""><figcaption><p>Edit an SMB share</p></figcaption></figure>

2. In the Update Share Settings dialog, update the relevant properties and select **Save**.

<figure><img src="../../.gitbook/assets/wmng_update_share_settings.png" alt="" width="563"><figcaption><p>Update the SMB share settings</p></figcaption></figure>

## Remove an SMB share <a href="#remove-an-smb-share" id="remove-an-smb-share"></a>

**Procedure**

1. In the Shares tab, select the three dots of the share and select **Remove**.

![Remove an SMB share](../../.gitbook/assets/wmng\_smb\_share\_remove.png)

2. In the confirmation message that appears, select **Confirm**.\
   The removed share no longer appears in the SMB Shares list.
