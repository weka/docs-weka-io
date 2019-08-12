---
description: >-
  This page presents an overview of the cluster expand and shrink process in a
  homogeneous WekaIO system configuration.
---

# Expand & Shrink Overview

{% hint style="info" %}
**Note:** The cluster expansion process described here is only applicable to a homogeneous WekaIO system configuration, which is highly recommended. For non-homogeneous WekaIO system configurations, contact the WekaIO Support Team. 

**Note:** For AWS deployments, ****CloudFormation should only be used for initial deployment, and not for expanding & shrinking cluster resources.
{% endhint %}

## About Expanding & Shrinking Cluster

In the WekaIO system, it is possible to expand and shrink a cluster as follows:

1. Add or delete backend hosts
2. Add or delete SSDs from an existing backend host
3. Change the number of cores assigned to the WekaIO system in existing backend hosts
4. Change the amount of memory allocated to the WekaIO system in existing backend hosts
5. Change the network resources assigned to the WekaIO system in existing backend hosts

{% hint style="info" %}
**Note:** The expansion or shrinking of networking resources is performed infrequently.
{% endhint %}

## Planning an Expansion or Shrink

{% hint style="info" %}
**Note:** The expansion of a WekaIO system offers the opportunity to increase performance, while the shrinking of a WekaIO system may reduce performance. Contact the WekaIO Support Team for more details and to receive estimates.

**Note:** In the following descriptions, cluster expansion also relates to cluster shrinking.
{% endhint %}

Expansion procedures are similar to the [Bare Metal WekaIO system Installation Procedure](../../install/bare-metal/). Similar to planning a new cluster, the objectives of the expansion, in terms of space and performance, need to be translated to the actual cluster resources. This process is practically a repeat of the planning process for new clusters, with the following options and limitations:

#### Possible Expansion Options

* Addition of new backend hosts.
* Addition of new failure domains, as long the system was installed with failure domains.
* Addition of new SSDs to existing backend hosts.
* Assignment of additional cores to WekaIO in existing backend hosts.
* Assignment of more memory to WekaIO in existing backend hosts.
* Assignment of additional network resources to WekaIO in existing backend hosts.
* Reconfiguration of hot spares.

#### Expansion Limitations

* It is not possible to change the defined WekaIO system protection scheme.
* It is not possible to define failure domains on a system that was installed without failure domains.
* A WekaIO system configured with failure domains cannot be configured to be without failure domains.
* Only the same network technology can be implemented i.e., it is not possible to mix between Ethernet and InfiniBand.

To plan the capacity of the WekaIO system after expansion, refer to [SSD Capacity Management](../../overview/ssd-capacity-management.md).

## The Cluster Expansion Process

Once an expansion of more SSDs or backend hosts has been planned and executed, the WekaIO system starts a redistribution process. This involves the redistribution of all the existing data to be perfectly balanced between the original hosts or SSDs and newly added resources. This process can take from minutes to hours, depending on the capacity and the networking CPU resources. However, the capacity increase is instant, and therefore it is possible to define more filesystems immediately, without waiting for completion of the redistribution process.

{% hint style="info" %}
**Note:** If necessary, contact the WekaIO Support Team for more details on the redistribution process and its expected duration.
{% endhint %}

Once the expansion of more cores or backend hosts has been implemented, the added CPU resources are operational in less than a minute. Write performance improves almost immediately, while read performance only improves on completion of the redistribution of the data.

{% hint style="info" %}
**Note:** As part of the requirements for a homogeneous WekaIO system configuration, when expanding memory resources, the new hosts must have the same memory as the existing hosts.
{% endhint %}

