---
description: >-
  This page presents how to expand and shrink a cluster in a homogeneous Weka
  system configuration.
---

# Expanding & Shrinking Cluster Resources

{% hint style="info" %}
**Note:** The cluster expansion process described here is only applicable to a homogeneous Weka system configuration, which is highly recommended. For non-homogeneous Weka system configurations, contact the Weka Support Team.
{% endhint %}

## About Expanding & Shrinking Cluster

In the Weka system, it is possible to expand and shrink a cluster as follows:

1. Add or delete backend hosts
2. Add or delete SSDs from an existing backend host
3. Change the number of cores assigned to the Weka system in existing backend hosts
4. Change the amount of memory allocated to the Weka system in existing backend hosts
5. Change the network resources assigned to the Weka system in existing backend hosts

{% hint style="info" %}
**Note:** The expansion or shrinking of networking resources is performed infrequently.
{% endhint %}

## Planning an Expansion or Shrink

{% hint style="info" %}
**Note:** The expansion of a Weka system offers the opportunity to increase performance, while the shrinking of a Weka system may reduce performance. Contact the Weka Support Team for more details and to receive estimates.

**Note:** In the following descriptions, cluster expansion also relates to cluster shrinking.
{% endhint %}

Expansion procedures are similar to the [Bare Metal Weka system Installation Procedure](install/bare-metal/planning-a-weka-system-installation.md). Similar to planning a new cluster, the objectives of the expansion, in terms of space and performance, need to be translated to the actual cluster resources. This process is practically a repeat of the planning process for new clusters, with the following options and limitations:

#### Possible Expansion Options

* Addition of new backend hosts.
* Addition of new failure domains, as long the system was installed with failure domains.
* Addition of new SSDs to existing backend hosts.
* Assignment of additional cores to Weka in existing backend hosts.
* Assignment of more memory to Weka in existing backend hosts.
* Assignment of additional network resources to Weka in existing backend hosts.
* Reconfiguration of hot spares.

#### Expansion Limitations

* It is not possible to change the defined Weka system protection scheme.
* It is not possible to define failure domains on a system that was installed without failure domains..
* A Weka system configured with failure domains cannot be configured to be without failure domains.
* Only the same network technology can be implemented i.e., it is not possible to mix between Ethernet and InfiniBand.

To plan the capacity of the Weka system after expansion, refer to [SSD Capacity Management](overview/ssd-capacity-management.md).

## The Cluster Expansion Process

Once an expansion of more SSDs or backend hosts has been planned and executed, the Weka system starts a redistribution process. This involves the redistribution of all the existing data to be perfectly balanced between the original hosts or SSDs and newly added resources. This process can take from minutes to hours, depending on the capacity and the networking CPU resources. However, the capacity increase is instant, and therefore it is possible to define more filesystems immediately, without waiting for completion of the redistribution process.

{% hint style="info" %}
**Note:** If necessary, contact the Weka Support Team for more details on the redistribution process and its expected duration.
{% endhint %}

Once the expansion of more cores or backend hosts has been implemented, the added CPU resources are operational in less than a minute. Write performance improves almost immediately, while read performance only improves on completion of the redistribution of the data.

{% hint style="info" %}
**Note:** As part of the requirements for a homogeneous Weka system configuration, when expanding memory resources, the new hosts must have the same memory as the existing hosts.
{% endhint %}

## Stages in Adding a Backend Host

The expansion of a cluster with new hosts is similar to the [Weka System Installation Process Using the CLI](https://docs.weka.io/bare-metal/installation/untitled) and consists of the following stages.

### Stage 1: Obtaining the Weka Install File

This stage is the same as [Obtaining the Weka Install File](https://docs.weka.io/bare-metal/installation/obtaining-the-weka-install-file). However, it is essential to download the install file used when the existing cluster was formed or last upgraded. Use the `weka-status` command to show the current cluster install file version.

To download the appropriate install file, follow the instructions in [Download the Weka Software](https://docs.weka.io/bare-metal/installation/obtaining-the-weka-install-file#step-2-download-the-weka-software).

### Stage 2: Installing the Weka Software on the New Host

Follow the instructions appearing in [Installation of the Weka Software on Each Host](https://docs.weka.io/bare-metal/installation/untitled#stage-1-installation-of-the-weka-software-on-each-host). At the end of the install process the host is in [stem mode](overview/glossary.md#stem-mode).

### Stage 3: Adding a Host to the Cluster

**Command:** `cluster host add`

Once the backend host is in the [stem mode](overview/glossary.md#stem-mode), use the following command line on  any host to add it to the cluster:

```text
weka -H <existing-backend-hostname> cluster host add <backend-hostname>
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `existing-backend-hostname` | String | IP/host name of one of the existing backend instances in the cluster | Valid host name \(DNS or IP\) | No | The host on which the command is executed |
| `backend-hostname` | String | IP/host name of the backend currently being added |  Valid host name \(DNS or IP\) | Yes |  |

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host will be received. Make a note of it for the next steps.
{% endhint %}

### Stage 4: Configuration of Networking

Follow the instructions appearing in [Configuration of Networking](https://docs.weka.io/bare-metal/installation/untitled#stage-5-configuration-of-networking).

{% hint style="info" %}
**Note:** The networking technology has to be the same as the existing networking technology in the cluster, i.e., it is not possible to mix Ethernet and IB technologies.
{% endhint %}

### Stage 5: Configuration of SSDs

Follow the instructions appearing in [Configuration of SSDs](https://docs.weka.io/bare-metal/installation/untitled#stage-6-configuration-of-ssds).

### Stage 6: Scanning Drives

Follow the instructions appearing in [Scanning Drives](https://docs.weka.io/bare-metal/installation/untitled#stage-7-scanning-drives).

### Stage 7: Configuration of CPU Resources

Follow the instructions appearing in [Configuration of CPU Resources](https://docs.weka.io/bare-metal/installation/untitled#stage-8-configuration-of-cpu-resources).

### Stage 8: Configuration of Memory

Use the following command line to display a listing of the memory defined \(one line for each host\):

`weka cluster host`

To configure the memory, follow the instructions appearing in [Configuration of Memory](https://docs.weka.io/bare-metal/installation/untitled#stage-9-configuration-of-memory-optional).

{% hint style="info" %}
**Note:** If memory has been configured, it is mandatory to use the same memory for the expanded host.
{% endhint %}

### Stage 9: Configuration of Failure Domains

Follow the instructions appearing in [Configuration of Failure Domains](https://docs.weka.io/bare-metal/installation/untitled#stage-10-configuration-of-failure-domains-optional).

{% hint style="info" %}
**Note:** Plan whether each host is being added to an existing failure domain or to a new failure domain.
{% endhint %}

### Stage 10: Activation of Cluster Hosts

If hosts have been added to the cluster, follow the instructions appearing in [Activation of Cluster Hosts](https://docs.weka.io/bare-metal/installation/untitled#stage-13-activation-of-cluster-hosts).

{% hint style="info" %}
**Note:** The activation of cluster hosts can be performed with a sequence of hosts.
{% endhint %}

### Stage 11: Activation of Cluster SSDs

If SSDs have been added to the cluster, follow the instructions appearing in [Activation of Cluster SSDs](https://docs.weka.io/bare-metal/installation/untitled#stage-14-activation-of-cluster-ssds).

## Expansion of Specific Resources

If the expansion process only involves the addition of specific resources, use the following guidelines.

### Expansion of Only SSDs

The addition of new SSDs only to existing servers requires execution of the following stages:

1. [Configuration of SSDs](https://docs.weka.io/bare-metal/installation/untitled#stage-6-configuration-of-ssds)
2. [Scanning Drives](https://docs.weka.io/bare-metal/installation/untitled#stage-7-scanning-drives)
3. [Activation of Cluster SSDs](https://docs.weka.io/bare-metal/installation/untitled#stage-14-activation-of-cluster-ssds)

### Addition of Only CPU Cores

The addition of only CPU cores to the cluster requires execution of [Configuration of CPU Resources](https://docs.weka.io/bare-metal/installation/untitled#stage-8-configuration-of-cpu-resources).

Contact the Weka Support Team for more information.

### Addition of Memory and Network Interface

Contact the Weka Support Team for more information.

