---
description: >-
  This page presents an overview of the cluster expand and shrink process in a
  homogeneous Weka system configuration.
---

# Expand and shrink overview

In the Weka system, it is possible to expand and shrink a cluster as follows:

1. Add or delete containers from backend servers.
2. Add or delete SSDs from an existing container.
3. Change the number of cores assigned to the Weka system in existing containers.
4. Change the amount of memory allocated to the Weka system in existing containers.
5. Change the network resources assigned to the Weka system in existing containers.

{% hint style="info" %}
**Note:** The expansion or shrinking of networking resources is performed infrequently.
{% endhint %}

{% hint style="info" %}
**Note:** The cluster expansion process described here is only applicable to a homogeneous Weka system configuration, which is highly recommended. For non-homogeneous Weka system configurations, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

For AWS deployments, use the \*\*CloudFormation for the initial deployment, and not for expanding and shrinking cluster resources.
{% endhint %}

## Expand or shrink plan

{% hint style="info" %}
**Note:** The expansion of a Weka system offers the opportunity to increase performance, while the shrinking of a Weka system may reduce performance. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) for more details and to receive estimates.

**Note:** In the following descriptions, cluster expansion also relates to cluster shrinking.
{% endhint %}

Expansion procedures are similar to the [Bare Metal Weka system Installation Procedure](../../install/bare-metal/). Similar to planning a new cluster, the objectives of the expansion, in terms of space and performance, need to be translated into the actual cluster resources. This process is practically a repeat of the planning process for new clusters, with the following options and limitations:

### Expansion options

* Addition of new containers to backend servers.
* Addition of new failure domains, as long the system was installed with failure domains.
* Addition of new SSDs to an existing container.
* Assignment of additional cores to the Weka system in existing containers.
* Assignment of more memory to the Weka system in existing containers.
* Assignment of additional network resources to the Weka system in existing containers.
* Reconfiguration of hot spares.

### Expansion limitations

* It is not possible to change the defined Weka system protection scheme.
* It is not possible to define failure domains on a system that was installed without failure domains.
* A Weka system configured with failure domains cannot be configured to be without failure domains.
* Only the same network technology can be implemented (mixing between Ethernet and InfiniBand is not possible).

To plan the capacity of the Weka system after expansion, refer to [SSD Capacity Management](../../overview/ssd-capacity-management.md).

## The cluster expansion process

Once an expansion of more SSDs or containers has been planned and executed, the Weka system starts a redistribution process. This involves the redistribution of all the existing data to be perfectly balanced between the original containers or SSDs and newly added resources.

This process can take from minutes to hours, depending on the capacity and the networking CPU resources. However, the capacity increase is instant, and therefore it is possible to define more filesystems immediately, without waiting for the completion of the redistribution process.

{% hint style="info" %}
**Note:** If necessary, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) for more details on the redistribution process and its expected duration.
{% endhint %}

Once the expansion of more cores or containers has been implemented, the added CPU resources are operational in less than a minute. Write performance improves almost immediately, while read performance only improves on the completion of the redistribution of the data.

{% hint style="info" %}
**Note:** As part of the requirements for a homogeneous Weka system configuration, when expanding memory resources, the new containers must have the same memory as the existing containers.
{% endhint %}
