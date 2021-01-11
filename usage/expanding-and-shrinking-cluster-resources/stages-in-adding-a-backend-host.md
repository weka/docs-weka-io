---
description: >-
  The page describes the expansion of a cluster with new hosts, which is similar
  to the Weka System Installation Process Using the CLI and consists of the
  following stages.
---

# Stages in Adding a Backend Host

## Stage 1: Obtaining the Weka Install File

This stage is the same as [Obtaining the Weka Install File](../../install/bare-metal/obtaining-the-weka-install-file.md). However, it is essential to download the install file used when the existing cluster was formed or last upgraded. Use the `weka-status` command to show the current cluster install file version.

To download the appropriate install file, follow the instructions in [Download the Weka Software](../../install/bare-metal/obtaining-the-weka-install-file.md#step-2-download-the-weka-software).

## Stage 2: Installing the Weka Software on the New Host

Follow the instructions appearing in [Installation of the Weka Software on Each Host](../../install/bare-metal/using-cli.md#stage-1-installation-of-the-weka-software-on-each-host). At the end of the install process, the host is in [stem mode](../../overview/glossary.md#stem-mode).

## Stage 3: Adding a Host to the Cluster

**Command:** `weka cluster host add`

Once the backend host is in the [stem mode](../../overview/glossary.md#stem-mode), use the following command line on any host to add it to the cluster:

```text
weka -H <existing-backend-hostname> cluster host add <backend-hostname>
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `existing-backend-hostname` | String | IP/hostname of one of the existing backend instances in the cluster | Valid hostname \(DNS or IP\) | No | The host on which the command is executed |
| `backend-hostname` | String | IP/hostname of the backend currently being added | Valid hostname \(DNS or IP\) | Yes |  |

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host will be received. Make a note of it for the next steps.
{% endhint %}

## Stage 4: Configuration of Networking

Follow the instructions appearing in [Configuration of Networking](../../install/bare-metal/using-cli.md#stage-5-configuration-of-networking).

{% hint style="info" %}
**Note:** The networking technology has to be the same as the existing networking technology in the cluster, i.e., it is not possible to mix Ethernet and IB technologies.
{% endhint %}

## Stage 5: Configuration of SSDs

Follow the instructions appearing in [Configuration of SSDs](../../install/bare-metal/using-cli.md#stage-6-configuration-of-ssds).

## Stage 6: Configuration of CPU Resources

Follow the instructions appearing in [Configuration of CPU Resources](../../install/bare-metal/using-cli.md#stage-8-configuration-of-cpu-resources).

## Stage 7: Configuration of Memory

Use the following command line to display a listing of the memory defined \(one line for each host\):

`weka cluster host`

To configure the memory, follow the instructions appearing in [Configuration of Memory](../../install/bare-metal/using-cli.md#stage-9-configuration-of-memory-optional).

{% hint style="info" %}
**Note:** If the memory has been configured, it is mandatory to use the same memory for the expanded host.
{% endhint %}

## Stage 8: Configuration of Failure Domains

Follow the instructions appearing in [Configuration of Failure Domains](../../install/bare-metal/using-cli.md#stage-10-configuration-of-failure-domains-optional).

{% hint style="info" %}
**Note:** Plan whether each host is being added to an existing failure domain or to a new failure domain.
{% endhint %}

## Stage 9: Applying Hosts Configuration

If hosts have been added to the cluster, follow the instructions appearing in [Applying Hosts Configuration](../../install/bare-metal/using-cli.md#stage-13-applying-hosts-configuration). 

{% hint style="info" %}
**Note:** The activation of cluster hosts can be performed with a sequence of hosts.
{% endhint %}

## Import Host Settings

Instead of carrying steps 4-9 above, it is possible to import the host setting from a previously exported host in the cluster. In most cases the host configurations are similar, and importing can save some extra steps and avoid misconfiguration.

To export settings from a host, ssh to this host, and run the `weka local resources export` command. 

To import the settings to the new host, ssh to it and run the `weka local resources import` command. You can then edit the local configuration as described in [Local resources editing commands](expansion-of-specific-resources.md#local-resources-editing-commands) section and run weka local resources apply to apply the configuration.



