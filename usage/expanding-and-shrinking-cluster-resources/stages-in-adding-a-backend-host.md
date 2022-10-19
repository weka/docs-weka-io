---
description: >-
  The page describes the expansion of a cluster with new containers, which is
  similar to the Weka System Installation Process Using the CLI and consists of
  the following stages.
---

# Workflow: Add a backend container

## Stage 1: Obtain the Weka software installation file

This stage is the same as [Obtain the Weka software installation package](../../install/bare-metal/obtaining-the-weka-install-file.md). However, it is essential to download the install file used when the existing cluster is already formed or upgraded. Use the `weka-status` command to show the current cluster install file version.

To download the appropriate install file, follow the instructions in [Download the Weka software installation file](../../install/bare-metal/obtaining-the-weka-install-file.md#download-the-weka-software-installation-file).

## Stage 2: Install the Weka software on the new server&#x20;

Follow the instructions in the [Installation of the Weka software on each server](../../install/bare-metal/using-cli.md#stage-1-installation-of-the-weka-software-on-each-host). At the end of the installation process, the container is in [stem mode](../../overview/glossary.md#stem-mode).

## Stage 3: Add the container to the cluster

**Command:** `weka cluster container add`

Once the container is in the [stem mode](../../overview/glossary.md#stem-mode), use the following command line on any container to add it to the cluster:

```
weka -H <existing-backend-hostname> cluster container add <backend-hostname>
```

**Parameters**

| **Name**                    | **Type** | **Value**                                                              | **Limitations**            | **Mandatory** | **Default**                                            |
| --------------------------- | -------- | ---------------------------------------------------------------------- | -------------------------- | ------------- | ------------------------------------------------------ |
| `existing-backend-hostname` | String   | IP or hostname of one of the existing backend instances in the cluster | Valid hostname (DNS or IP) | No            | The backend container on which the command is executed |
| `backend-hostname`          | String   | IP or hostname  of the backend currently being added                   | Valid hostname (DNS or IP) | Yes           |                                                        |

{% hint style="info" %}
**Note:** On completion of this stage, the container-id of the newly added backend container is received. Make a note of it for the next steps.
{% endhint %}

## Stage 4: Configure the networking

See _Configure the networking_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

## Stage 5: Configure the SSDs

See _Configure the SSDs_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

## Stage 6: Configure the CPU resources

See _Configure the CPU resources_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

## Stage 7: Configure the memory

To display a list of the memory defined (one line per container), run the following command:

`weka cluster container`

To configure the memory, see _Configure the memory_ in[using-cli.md](../../install/bare-metal/using-cli.md "mention").

{% hint style="info" %}
**Note:** If the memory is configured, you must use the same memory for the expanded container.
{% endhint %}

## Stage 8: Configure failure domains

See _Configure failure domains_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

{% hint style="info" %}
**Note:** Plan whether each container is added to an existing failure domain or to a new failure domain.
{% endhint %}

## Stage 9: Apply containers configuration

If containers are already added to the cluster, see _Apply containers configuration_ in [using-cli.md](../../install/bare-metal/using-cli.md "mention").

{% hint style="info" %}
**Note:** The activation of the container can be performed with a sequence of containers.
{% endhint %}

## Import container settings

Instead of carrying stages 4-9 above, it is possible to import the container setting from a previously exported container in the cluster. In most cases the container configurations are similar, and importing can save some extra steps and avoid misconfiguration.

To export settings from a container, ssh to the server with this container, and run the `weka local resources export` command.&#x20;

To import the settings to the new container, ssh to it and run the `weka local resources import` command. You can then edit the local configuration as described in [Local resources editing commands](expansion-of-specific-resources.md#local-resources-editing-commands) section and run weka local resources apply to apply the configuration.

