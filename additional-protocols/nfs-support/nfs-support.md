---
description: This page describes how to configure the NFS networking using the GUI.
---

# Manage NFS networking using the GUI

Using the GUI, you can:

* **Configure the NFS cluster level**
  * [Create interface groups](nfs-support.md#define-interface-groups)
  * [Set interface group ports](nfs-support.md#set-interface-group-ports)
  * [Set interface group IPs](nfs-support.md#set-interface-group-ips)
* **Configure the NFS export level (permissions)**
  * [Define client access groups](nfs-support.md#define-client-access-groups)
  * [Manage client access groups](nfs-support.md#manage-client-access-groups)
  * [Manage NFS client permissions](nfs-support.md#manage-nfs-client-permissions)

## Create interface groups

Interface Groups define the hosts and ports that provide the NFS service.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. On the left pane, select **NFS**.
3. In the Configuration tab, select the **+** sign near the Interface Groups title.&#x20;

![Add an NFS interface group](../../.gitbook/assets/wmng\_add\_nfs\_group\_add.png)

4\. In the Create Interface Group dialog set the following properties:

* **Name**: A unique interface group name (maximum 11 characters).
* **Gateway**: A valid IP address of the gateway.
* **Subnet mask**: The subnet mask in CIDR (Classless Inter-Domain Routing) format. For example, a value of 16 equals 255.255.0.0.

5\. Select **Save**.

![Create inteface group dialog](../../.gitbook/assets/wmng\_add\_nfs\_group\_dialog.png)

**Related topic**

[#implement-nfs-service-from-a-weka-cluster](./#implement-nfs-service-from-a-weka-cluster "mention")

## Set interface group ports

Once you create an interface group, set its ports.

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group Ports table, select **+Create**.

![Group ports table](../../.gitbook/assets/wmng\_add\_nfs\_group\_ports\_add.png)

3\. In the Add Port dialog, set the following properties:

* **Hostname**: Select the host ID on which the port resides.
* **Port:** Select the port from the list.

![Add port dialog](../../.gitbook/assets/wmng\_add\_nfs\_group\_ports\_dialog.png)

### Remove an interface group port

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group Ports table, select the three dots, and from the menu select **Remove**.&#x20;

![Remove an interface group port](../../.gitbook/assets/wmng\_add\_nfs\_group\_ports\_remove.png)

## **Set interface group IPs**

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group IPs table, select **+Create**.

![Group IPs table](../../.gitbook/assets/wmng\_add\_nfs\_group\_ips\_add.png)

3\. In the Add Rang IP dialog, set the relevant IP range.

4\. Select **Save**.

![Add range IP dialog](../../.gitbook/assets/wmng\_add\_nfs\_group\_ips\_dialog.png)

### Remove an interface group port

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group IPs table, select the three dots, and from the menu select **Remove**.&#x20;

![Remove a group IP](<../../.gitbook/assets/wmng\_add\_nfs\_group\_ip\_remove (1).png>)

## Define client access groups

**Procedure**

1. In the Permissions tab, select the **+** sign near the Client Groups title.

![Add a client group](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_add.png)

2\. In the Create Client Group dialog, set the client group name (DNS server name).

3\. Select **Save**.&#x20;

![Create client group dialog](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_dialog.png)

**Related topics**

[#configure-the-round-robin-dns-server](./#configure-the-round-robin-dns-server "mention")

## Manage client access groups

**Procedure**

1. In the Permissions tab, select **ADD DNS** for the relevant Client Group.

![Manage client access groups](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_dns-ip-buttons.png)

3\. In the Create Client Group DNS Rule dialog, set the DNS server name. Then, select **Save**.

![Add DNS to a client group dialog](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_dns\_rule.png)

3\. In the Permissions tab, select **ADD IP** for the relevant Client Group.

4\. In the Create Client Group IP Rule dialog, set the IP address and bitmask. Then, select **Save**.

![Add IP to a client group dialog](../../.gitbook/assets/wmng\_add\_nfs\_client\_group\_ip\_rule.png)

### Remove DNS or IP of a client group

**Procedure**

1. In the Permissions tab, select the **trash** symbol displayed next to the DNS or IP for the relevant Client Group.

![Remove DNS or IP of a client group](../../.gitbook/assets/wmng\_add\_nfs\_group\_ip\_remove.png)

## Manage NFS client permissions

**Procedure**

1. In the Permissions table, select **+Create**.

![Permissions table](../../.gitbook/assets/wmng\_add\_NFS\_client\_permissions.png)

2\. In the Filesystem Permission Creation dialog, set the following properties:

* **Client Group**: The client group to which the permissions are applied.
* **Filesystem**: The filesystem to which the permissions are applied.
* **Path**: The exported directory path (root share).
* **Type**: The access type: RO (read-only) or RW (read/write)..
* **Squash Root**: The squash mode that the system enforces with the client permission.
* **Anon. UID**: Anonymous user ID. Only relevant for Root and All user squashing.
* **Anon. GID:** Anonymous group ID. Only relevant for Root and All user squashing.

3\. Select **Save**.

![Create filesystem permissions](../../.gitbook/assets/wmng\_add\_fs\_permission.png)

**Related topics**

****[#supported-nfs-client-mount-options](nfs-support.md#supported-nfs-client-mount-options "mention")****
