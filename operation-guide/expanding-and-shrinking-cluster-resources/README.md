---
description: Expand and shrink a cluster in a homogeneous WEKA system configuration.
---

# Expand and shrink cluster resources

A WEKA cluster is a collection of backend servers configured with containers, SSDs, cores, memory, and network resources. You can expand or shrink your cluster resources to meet ongoing business changes.

* **Expansion:** To increase the performance and capacity of your cluster, you can expand your cluster by adding new servers to the cluster and configuring new resources anytime after installing and connecting them to the network on the same subnet as the cluster.
* **Shrinking:** If you want to reduce the cluster's costs and the performance degradation does not affect your business, you can shrink the cluster by removing SSDs and backend servers.

The expansion and shrinking procedures only apply to homogeneous WEKA clusters in which all the cluster servers are similar and have the same number of cores, memory, SSD capacity per server, and servers per failure domain (if any).

{% hint style="info" %}
* For heterogeneous WEKA cluster configurations and estimation of the performance change, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
* For AWS deployments, use the CloudFormation for the initial deployment, not for expanding and shrinking cluster resources.
{% endhint %}

The expansion and shrinking procedures include:

* Add or delete backend servers and containers.
* Add or delete SSDs (drives).
* Modify the number of cores assigned to the WEKA cluster.
* Modify the memory size allocated to the WEKA cluster.
* Modify the network resources assigned to the WEKA cluster (not required frequently).

## Expansion considerations

The expansion procedures are similar to the _WEKA installation on bare metal_ procedures but require specific attention to the following considerations when planning the expansion:

* **Containers architecture:** The WEKA container architecture must be retained. Two procedures for adding a backend server are provided:
  * Add a backend server in a multiple-container architecture.
  * Add a backend server in a single container architecture.
* **Protection scheme:** The WEKA cluster protection scheme is retained. You cannot modify it.
* **Failure domains:** Adding or removing failure domains are done automatically.
* **Memory expansion:** When expanding memory resources, the new containers must have the same memory allocated as the existing containers.

{% hint style="info" %}
To calculate the capacity of the WEKA cluster after expansion, refer to the [SSD net storage capacity calculation](../../weka-system-overview/ssd-capacity-management.md#ssd-net-storage-capacity-calculation) section.
{% endhint %}

**Related topics**

[bare-metal](../../planning-and-installation/bare-metal/ "mention")

[weka-containers-architecture-overview.md](../../weka-system-overview/weka-containers-architecture-overview.md "mention")

## What happens after expansion or shrinking?

Once the WEKA cluster expansion or shrinking is completed, the system starts a redistribution process. This involves redistributing all the existing data, to be balanced between the original system SSDs and newly added SSDs.

The redistribution process time depends on the cluster capacity and the networking CPU resources. It can take between minutes and hours.&#x20;

The capacity increase is instant. Therefore, it is possible to define more filesystems immediately without waiting to complete the redistribution process.

When more containers or cores are expanded, the added CPU resources are operational in less than a minute. The write performance improves almost immediately, while the read performance only improves upon completing the data redistribution.
