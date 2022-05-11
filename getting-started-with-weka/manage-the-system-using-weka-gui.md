---
description: >-
  The Weka GUI application enables you to configure, administer, and monitor the
  Weka system. This page provides basic operations and an overview of the system
  dashboard and the main menu.
---

# Manage the system using Weka GUI

## Access the Weka GUI

The Weka GUI is a web application that you can access using an account that is already configured in the system and has the appropriate rights to configure, administer, or view.

You can access the Weka GUI with any standard browser using the address: \
`https://<weka system or host name>:14000`

For example: `https://WekaProd:14000` or `https://weka01:14000`.

{% hint style="info" %}
On AWS installations, you can access the Weka GUI from the self-service portal. In the **Outputs** tab of the **CloudFormation** stack, click the **GUI** link.
{% endhint %}

**Before you begin**

Make sure that port 14000 is open in the firewall of your organization.

**Procedure**

1. In your browser, go to `https://<weka system or host name>:14000`.\
   ``The sign-in page opens.

![Sign in to Weka GUI application](../.gitbook/assets/wmng\_sign\_in.png)

2\. Sign in with the username and password of an account with cluster administration or\
&#x20;   organization administration privileges. For details about the account types, see  \
&#x20;   _User management_ in the related topics.&#x20;

The system dashboard opens.

{% hint style="info" %}
The initial default username and password are _admin and admin_[.](../usage/security/user-management.md) In the first sign-in, Weka GUI enforces changing the admin password.
{% endhint %}

<mark style="color:purple;">**Related topics**</mark>

[user-management.md](../usage/security/user-management.md "mention")

## System Dashboard&#x20;

The system dashboard contains widgets that provide an overview of the Weka system, including an overall status, R/W throughput, top consumers, alerts, capacity, core usage, and hardware.

The system dashboard opens by default when you sign in. If you select another menu and you want to display again the dashboard, select **Monitor > System Dashboard**.

![Weka system dashboard](../.gitbook/assets/wmng\_dashboard.png)

### Overall status widget

This widget shows the overall status of the system health and protection.

The overall status widget includes the following indications:

* **Service Uptime**: The elapsed time since the I/O services started.
* **Data Protection**: The number of data drives and protection parity drives. The color of the protection parity drives indicates their status.
* **Virtual (Hot) Spares**: The number of failure domains that the system can lose and still complete the data rebuild while maintaining the same net capacity.

![Overall status widget](../.gitbook/assets/wmng\_dashboard\_Overall\_status\_widget.png)

### R/W Throughput widget

This widget shows the current performance statistics aggregated across the cluster.

The R/W Throughput widget includes the following indications:

* **Throughput**: The total throughput.
* **Total Ops**: The number of cluster operations.
* **Latency**: The cluster average latency of read and write operations.
* **Clients**: The number of clients connected to the cluster.

![R/W Throughput widget](../.gitbook/assets/wmng\_dashboard\_Throughput\_widget.png)

### Top Consumers widget

This widget shows the backend and client hosts in the system. You can sort the list of hosts by total IO operations per second or by total throughput.

![Top Consumers widget](../.gitbook/assets/wmng\_dashboard\_Top\_Consumers\_widget.png)

### Alerts widget

This widget shows the alerts that are not muted.

![Alerts widget](../.gitbook/assets/wmng\_dashboard\_Alerts\_widget.png)

### Capacity widget

This widget shows an overview of the managed capacity.

The top bar indicates the total capacity provisioned for all filesystems and the used capacity. For tiered filesystems, the total capacity also includes the Object Store part.

The bottom bar indicates the total SSD capacity available in the system, the provisioned capacity, and the used capacity.

![Capacity widget](../.gitbook/assets/wmng\_dashboard\_Capacity\_widget.png)

### Core Usage widget

This widget shows the average usage and the maximum load level of the Frontend, Compute, and Drive cores.

![Core Usage widget](../.gitbook/assets/wmng\_dashboard\_Core\_Usage\_widget.png)

### Hardware widget

This widget shows an overview of the hardware components (active/total).

The hardware components include:

* **Backends**: The number of the servers.
* **Cores**: The number of the cores that are configured for running processes in the backends.
* **Drives**: The number of drives.
* **OBS Buckets**: The number of the object-store buckets.

![Hardware widget](../.gitbook/assets/wmng\_dashboard\_Hardware\_widget.png)

## Main menu

From the menu, it is possible to view [statistics](../usage/statistics/) and [events](../usage/events/), manage [filesystems](../fs/managing-filesystems/), configure [NFS](../additional-protocols/nfs-support.md) and [SMB](../additional-protocols/smb-support/smb-management-using-the-gui.md) services, and manage system [security](../usage/security/user-management.md) aspects.





<mark style="color:purple;">**Related topics**</mark>

<mark style="color:purple;">****</mark>[statistics](../usage/statistics/ "mention")<mark style="color:purple;">****</mark>

[events](../usage/events/ "mention")

[managing-filesystems](../fs/managing-filesystems/ "mention")

[nfs-support.md](../additional-protocols/nfs-support.md "mention")

[smb-management-using-the-gui.md](../additional-protocols/smb-support/smb-management-using-the-gui.md "mention")

[external-monitoring.md](../appendix/external-monitoring.md "mention")
