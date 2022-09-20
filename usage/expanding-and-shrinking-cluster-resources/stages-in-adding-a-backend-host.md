---
description: >-
  The page describes the expansion of a cluster with new hosts, which is similar
  to the Weka System Installation Process Using the CLI and consists of the
  following stages.
---

# Workflow: Add a backend host

## Stage 1: Obtain the Weka software installation file

This stage is the same as [Obtaining the Weka Install File](../../install/bare-metal/obtaining-the-weka-install-file.md). However, it is essential to download the install file used when the existing cluster was formed or last upgraded. Use the `weka-status` command to show the current cluster install file version.

To download the appropriate install file, follow the instructions in [Download the Weka Software](../../install/bare-metal/obtaining-the-weka-install-file.md#step-2-download-the-weka-software).

## Stage 2: Install the Weka software on the new host

Follow the instructions appearing in [Installation of the Weka Software on Each Host](../../install/bare-metal/using-cli.md#stage-1-installation-of-the-weka-software-on-each-host). At the end of the installation process, the host is in [stem mode](../../overview/glossary.md#stem-mode).

## Stage 3: Add the host to the cluster

**Command:** `weka cluster host add`

Once the backend host is in the [stem mode](../../overview/glossary.md#stem-mode), use the following command line on any host to add it to the cluster:

```
weka -H <existing-backend-hostname> cluster host add <backend-hostname>
```

**Parameters**

| **Name**                    | **Type** | **Value**                                                           | **Limitations**            | **Mandatory** | **Default**                               |
| --------------------------- | -------- | ------------------------------------------------------------------- | -------------------------- | ------------- | ----------------------------------------- |
| `existing-backend-hostname` | String   | IP/hostname of one of the existing backend instances in the cluster | Valid hostname (DNS or IP) | No            | The host on which the command is executed |
| `backend-hostname`          | String   | IP/hostname of the backend currently being added                    | Valid hostname (DNS or IP) | Yes           |                                           |

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host will be received. Make a note of it for the next steps.
{% endhint %}

## Stage 4: Configure the networking

See _Configure the networking_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

## Stage 5: Configure the SSDs

See _Configure the SSDs_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

## Stage 6: Configure the CPU resources

See _Configure the CPU resources_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

## Stage 7: Configure the memory

To display a list of the memory defined (one line per host), run the following command:

`weka cluster host`

To configure the memory, see _Configure the memory_ in[using-cli.md](../../install/bare-metal/using-cli.md "mention").

{% hint style="info" %}
**Note:** If the memory is configured, you must use the same memory for the expanded host.
{% endhint %}

## Stage 8: Configure failure domains

See _Configure failure domains_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

{% hint style="info" %}
**Note:** Plan whether each host is added to an existing failure domain or to a new failure domain.
{% endhint %}

## Stage 9: Apply hosts configuration

If hosts are already added to the cluster, see _Apply hosts configuration_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

{% hint style="info" %}
**Note:** The activation of cluster hosts can be performed with a sequence of hosts.
{% endhint %}

## Import host settings

Instead of carrying stages 4-9 above, it is possible to import the host setting from a previously exported host in the cluster. In most cases the host configurations are similar, and importing can save some extra steps and avoid misconfiguration.

To export settings from a host, ssh to this host, and run the `weka local resources export` command.&#x20;

To import the settings to the new host, ssh to it and run the `weka local resources import` command. You can then edit the local configuration as described in [Local resources editing commands](expansion-of-specific-resources.md#local-resources-editing-commands) section and run weka local resources apply to apply the configuration.

