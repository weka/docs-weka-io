---
description: This page describes how to configure the NFS networking using the GUI.
---

# Manage NFS networking using the GUI

Using the GUI, you can:

* **Configure the NFS cluster level**
  * [Create interface groups](nfs-support.md#create-interface-groups)
  * [Set interface group ports](nfs-support.md#set-interface-group-ports)
  * [Set interface group IPs](nfs-support.md#set-interface-group-ips)
* **Configure the NFS export level (permissions)**
  * [Define client access groups](nfs-support.md#define-client-access-groups)
  * [Manage client access groups](nfs-support.md#manage-client-access-groups)
  * [Create NFS client permission](nfs-support.md#create-nfs-client-permission)
  * [Edit NFS client permission](nfs-support.md#edit-nfs-client-permission)

## Create interface groups <a href="#create-interface-groups" id="create-interface-groups"></a>

Interface Groups define the servers and ports that provide the NFS service.

{% hint style="info" %}
If you need to create the interface group in the legacy NFS stack, use the CLI. See [Create interface groups](nfs-support-1.md#create-interface-groups) and set the `allow-manage-gids` parameter to `off.`
{% endhint %}

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. On the left pane, select **NFS**.
3. In the Configuration tab, select the **+** sign near the Interface Groups title.&#x20;

![Add an NFS interface group](../../.gitbook/assets/wmng\_add\_nfs\_group\_add.png)

4. In the Create Interface Group dialog, set the following properties:
   * **Name**: A unique interface group name (maximum 11 characters).
   * **Gateway**: A valid IP address of the gateway.
   * **Subnet mask**: The subnet mask in CIDR (Classless Inter-Domain Routing) format. For example, a value of 16 equals 255.255.0.0.
5. Select **Save**.

![Create interface group dialog](../../.gitbook/assets/wmng\_add\_nfs\_group\_dialog.png)

**Related topic**

[#implement-nfs-service-from-a-weka-cluster](./#implement-nfs-service-from-a-weka-cluster "mention")

## Set interface group ports

Once you create an interface group, set its ports. You can set the ports only on frontend containers.

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group Ports table, select **+Create**.

![Group ports table](../../.gitbook/assets/wmng\_add\_nfs\_group\_ports\_add.png)

3. In the Add Port dialog, set the following properties:
   * **Hostname**: Select the server on which the port resides.
   * **Port:** Select the port from the list.

![Add port dialog](../../.gitbook/assets/wmng\_add\_nfs\_group\_ports\_dialog.png)

### Remove an interface group port

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group Ports table, select the three dots, and from the menu, select **Remove**.&#x20;

![Remove an interface group port](../../.gitbook/assets/wmng\_add\_nfs\_group\_ports\_remove.png)

## **Set interface group IPs**

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group IPs table, select **+Create**.

![Group IPs table](../../.gitbook/assets/wmng\_add\_nfs\_group\_ips\_add.png)

3. In the Add Range IP dialog, set the relevant IP range.
4. Select **Save**.

![Add range IP dialog](../../.gitbook/assets/wmng\_add\_nfs\_group\_ips\_dialog.png)

### Remove an interface group port

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group IPs table, select the three dots, and from the menu select **Remove**.&#x20;

![Remove a group IP](<../../.gitbook/assets/wmng\_add\_nfs\_group\_ip\_remove (1).png>)

## Define client access groups <a href="#define-client-access-groups" id="define-client-access-groups"></a>

**Procedure**

1. In the Permissions tab, select the **+** sign near the Client Groups title.

![Add a client group](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_add.png)

3. In the Create Client Group dialog, set the client group name (DNS server name).
4. Select **Save**.&#x20;

![Create client group dialog](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_dialog.png)

**Related topics**

[#configure-the-round-robin-dns-server](./#configure-the-round-robin-dns-server "mention")

## Manage client access groups <a href="#manage-client-access-groups" id="manage-client-access-groups"></a>

**Procedure**

1. In the Permissions tab, select **ADD DNS** for the relevant Client Group.

![Manage client access groups](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_dns-ip-buttons.png)

2. In the Create Client Group DNS Rule dialog, set the DNS server name. Then, select **Save**.

![Add DNS to a client group dialog](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_dns\_rule.png)

3. In the Permissions tab, select **ADD IP** for the relevant Client Group.
4. In the Create Client Group IP Rule dialog, set the IP address and bitmask. Then, select **Save**.

![Add IP to a client group dialog](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_ip\_rule.png)

### Remove DNS or IP of a client group

**Procedure**

1. In the Permissions tab, select the **trash** symbol displayed next to the DNS or IP for the relevant Client Group.

![Remove DNS or IP of a client group](../../.gitbook/assets/wmng\_add\_nfs\_group\_ip\_remove.png)

## Create NFS client permission <a href="#create-nfs-client-permission" id="create-nfs-client-permission"></a>

You can create NFS permission for a client group.

**Before you begin**

If you create an NFS v4 client permission, verify that a global configuration filesystem is already set in the system. If not, set it using the CLI. See [Set the global configuration filesystem](nfs-support-1.md#configure-the-nfs-configuration-filesystem).&#x20;

**Procedure**

1. In the Permissions table, select **+Create**.

![Permissions table](../../.gitbook/assets/wmng\_add\_NFS\_client\_permissions.png)

2. In the Create NFS Permission dialog, set the following properties:
   * **Client Group**: The client group to which the permissions are applied.
   * **Filesystem**: The filesystem to which the permissions are applied. A filesystem with Required Authentication set to ON cannot be used for NFS client permissions.
   * **Path**: The exported directory path (root share).
   * **Type**: The access type: RO (read-only) or RW (read/write).
   * **Priority:** Permissions are processed in ascending priority order during access evaluation, beginning with the lowest number. If a client matches multiple permission entries, the entry with the highest priority number determines the effective permission. Using a numbering system in tens (10, 20, 100) is advisable to facilitate the addition of priorities between existing ones.
   * **Supported Versions:** The supported NFS versions (V3, V4, or both).
   * **Squash Root**: The system enforces squash mode with the client's permission.
   * **Anon. UID**: Anonymous user ID. Only relevant for Root and All user squashing.
   * **Anon. GID:** Anonymous group ID. Only relevant for Root and All user squashing.
3. Select **Save**.

![Create filesystem permissions](../../.gitbook/assets/wmng\_create\_nfs\_permission.png)

## Edit NFS client permission <a href="#edit-nfs-client-permission" id="edit-nfs-client-permission"></a>

You can edit the existing NFS permission settings for a client group.  You can also move the priority to the top or bottom priority (related to other client group priorities). If the client group permission setting is no longer required, you can remove it.

**Procedure**

1. In the Permissions table, select the three dots of the client group to edit, and select **Edit**.

<figure><img src="../../.gitbook/assets/wmng_edit_nfs_permission.png" alt=""><figcaption><p>Edit a client group permissions</p></figcaption></figure>

2. Set the relevant properties: Type, Priority, Supported Versions, Squash Root, Anon. UID, and Anon. GID. Then, select **Save**.
3. To move the priority of a client group setting to the top or bottom priority, select **Move to top priority** or **Move to bottom priority**.
4. To remove the client group permission setting, select **Remove**.



**Related topics**

[#supported-nfs-client-mount-options](./#supported-nfs-client-mount-options "mention")
