# Workflow: Add a backend host

Expanding a cluster with a new backend host is similar to the Weka system installation process using the CLI. &#x20;

{% hint style="info" %}
**Note:** In most cases, the host configurations are similar. Therefore, it is possible to import the host setting from a previously exported host in the cluster, saving time and avoiding misconfiguration. \
See [Expand the Cluster by Importing the Host Settings](stages-in-adding-a-backend-host.md#expand-the-cluster-by-importing-the-host-settings).
{% endhint %}

## Add a backend host to an existing cluster

### Stage 1: Obtain the Weka install file

Download the Weka Install File used when the existing cluster was last upgraded (or formed, if not upgraded)..

Use the `weka status` command to show the current cluster install file version.

See [obtaining-the-weka-install-file.md](../../install/bare-metal/obtaining-the-weka-install-file.md "mention")

### Stage 2: Install the Weka software on the new host

Run the `untar` command and `install.sh` command on the new host.\
At the end of the installation process, the host is in stem mode (the host is not attached to a cluster).

### Stage 3: Add the host to the cluster

**Command:** `weka cluster host add`

On any host that is part of the cluster, run the following command line:

```
weka cluster host add <backend-hostname>
```

**Parameters:**

| **Name**           | **Type** | **Value**                                  | **Limitations**            | **Mandatory** | **Default** |
| ------------------ | -------- | ------------------------------------------ | -------------------------- | ------------- | ----------- |
| `backend-hostname` | String   | IP/hostname of the new backend host to add | Valid hostname (DNS or IP) | Yes           |             |

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host appears in response to the command. Make a note of it to use in the following steps.
{% endhint %}

### Stage 4: Configure the networking

Perform the instructions in [#stage-6-configure-the-networking](../../install/bare-metal/using-cli.md#stage-6-configure-the-networking "mention").

### Stage 5: Configure the CPU resources

Perform the instructions in [#stage-8-configure-the-cpu-resources](../../install/bare-metal/using-cli.md#stage-8-configure-the-cpu-resources "mention").

### Stage 6: Apply the host's configuration

Apply the configuration on the newly added host. Perform the instructions in [#stage-13-apply-hosts-configuration](../../install/bare-metal/using-cli.md#stage-13-apply-hosts-configuration "mention").

{% hint style="info" %}
**Note:** You can activate the cluster hosts sequentially.
{% endhint %}

### Stage 7: Configure the SSDs

Perform the instructions in [#stage-7-configure-the-ssds](../../install/bare-metal/using-cli.md#stage-7-configure-the-ssds "mention").

## Expand the cluster by importing the host settings

In most cases, the host configurations are similar. Therefore, it is possible to import the host setting from a previously exported host in the cluster, saving time and avoiding misconfiguration.

**Procedure:**

1. Perform only stages 1 to 3 in the [Add a backend host to an existing cluster](stages-in-adding-a-backend-host.md#add-a-backend-host-to-an-existing-cluster) procedure (above).
2. Connect to one of the hosts in the cluster and export the settings by running the following command: `weka local resources export`.
3. Connect to the new host and import the settings by running the following command: \
   `weka local resources import`.
4. Edit the local configuration. See the [#local-resources-editing-commands](expansion-of-specific-resources.md#local-resources-editing-commands "mention") section.
5. Apply the configuration on the newly added host.\
   See [#stage-13-apply-hosts-configuration](../../install/bare-metal/using-cli.md#stage-13-apply-hosts-configuration "mention").
