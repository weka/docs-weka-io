---
description: >-
  This page describes how to set up, update, monitor, and delete an S3 cluster
  using the GUI.
---

# Manage the S3 service using the GUI

Using the GUI, you can:

* [Create an S3 cluster](s3-cluster-management.md#create-an-s3-cluster)
* [Update an S3 cluster configuration](s3-cluster-management.md#update-an-s3-cluster-configuration)
* [Delete an S3 cluster configuration](s3-cluster-management.md#delete-an-s3-cluster)

## Create an S3 cluster

An S3 cluster configuration includes a filesystem, port, and list of servers.

**Before you begin**

Ensure a predefined filesystem exists to maintain the persisting cluster-wide protocol configurations. If not, create a filesystem with 100 GB capacity.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **S3**.
3. On the Configuration tab, select **Configure**.
4. In the S3 Cluster Configuration dialog, set the following properties:
   * **Filesystem**: The filesystem to use for the S3 service. When adding a bucket, it is created in this filesystem by default.
   * **Port**: Default 9000. If required, modify the port through which the cluster exposes the S3 service. Do not set port 9001.
   * **Anonymous Posix UID:** If required, modify the POSIX UID assigned to anonymous users.
   * **Anonymous Posix GID:** If required, modify the POSIX GID assigned to anonymous users.
   * **All servers**: To use all available servers for the S3 configuration, switch on **All servers**. If new servers are deployed later, they do not automatically participate in the S3 cluster.\
     To use specific servers, switch off **All servers**, and select one or more of the available servers from the list to participate in the S3 cluster.
   * **Virtual-hosted-style Domains:** Using the HTTP host header, virtual-hosted-style domains enable addressing the S3 bucket in a REST API request. The bucket name is part of the domain name in the URL. For the domain name, use DNS-compatible values.\
     A domain name can contain only letters, numbers, hyphens, and dots (a maximum of 64 characters for a domain).\
     You can add a list of domains with a total of 1024 characters. Press Enter after setting each domain in the list, or use a comma separator between the domains (no space allowed).
5. In the **Config Filesystem**, select the filesystem used for persisting S3 cluster-wide configuration.
6. Select **Save**.

Once the system completes configuration, the servers' statuses change from not ready (red X icon) to ready (green V icon).

<figure><img src="../../../.gitbook/assets/wmng_S3_cluster_configuration (2).gif" alt=""><figcaption><p>S3 Cluster Configuration</p></figcaption></figure>

## Update an S3 cluster configuration

You can update the port and the servers to participate in the S3 cluster.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **S3**.
3. On the **Configuratio**n tab, select the pencil icon next to the S3 cluster configuration.

![Edit an S3 cluster configuration](../../../.gitbook/assets/wmng\_s3\_edit\_configuration\_button.png)

4. Update the properties as required. Do not set port 9001.

{% hint style="warning" %}
Modifying the **Virtual-hosted-style Domains** parameter automatically triggers a restart of all S3 containers, resulting in I/O disruption.
{% endhint %}

5. Select **Save**.

![Edit S3 Cluster Configuration](../../../.gitbook/assets/wmng\_S3\_edit\_configuration.png)

## Delete an S3 cluster configuration

Deleting an existing S3 cluster managed by the WEKA system does not delete the backend WEKA filesystem but removes the S3 bucket exposures of these filesystems.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **S3**.
3. On the Configuration tab, select the trash icon next to the S3 cluster configuration.

![Delete an S3 cluster configuration](../../../.gitbook/assets/wmng\_s3\_delete\_configuration.png)

4. In the S3 Configuration Reset message, select **Reset**.&#x20;
