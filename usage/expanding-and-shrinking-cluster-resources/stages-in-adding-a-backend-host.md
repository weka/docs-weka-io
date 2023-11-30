# Stages in Adding a Backend Host

Expanding a cluster with a new backend host is similar to the Weka system installation process using the CLI. &#x20;

{% hint style="info" %}
**Note:** In most cases, the host configurations are similar. Therefore, it is possible to import the host setting from a previously exported host in the cluster, saving time and avoiding misconfiguration. \
See [Expand the Cluster by Importing the Host Settings](stages-in-adding-a-backend-host.md#expand-the-cluster-by-importing-the-host-settings).
{% endhint %}

## Adding a Backend Host to an Existing Cluster

### Stage 1: Obtaining the Weka Install File

Download the Weka Install File used when the existing cluster was last upgraded (or formed, if not upgraded).

Use the `weka status` command to show the current cluster install file version.

See [obtaining-the-weka-install-file.md](../../install/bare-metal/obtaining-the-weka-install-file.md "mention")

### Stage 2: Installing the Weka Software on the New Host

Run the `untar` command and `install.sh` command on the new host.\
At the end of the installation process, the host is in stem mode (the host is not attached to a cluster).

### Stage 3: Adding the Host to the Cluster

**Command:** `weka cluster host add`

On any host that is part of the cluster, run the following command line:

```
weka cluster host add <backend-hostname>
```

**Parameters:**

<table data-header-hidden><thead><tr><th width="267">Name</th><th>Type</th><th width="156">Value</th><th width="123">Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>backend-hostname</code></td><td>String</td><td>IP/hostname of the new backend host to add</td><td>Valid hostname (DNS or IP)</td><td>Yes</td><td></td></tr></tbody></table>

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host appears in response to the command. Make a note of it to use in the following steps.
{% endhint %}

### Stage 4: Configuration of Networking

Perform the instructions in [#stage-6-configuration-of-networking](../../install/bare-metal/using-cli.md#stage-6-configuration-of-networking "mention").

### Stage 5: Configuration of CPU Resources

Perform the instructions in [#stage-8-configuration-of-cpu-resources](../../install/bare-metal/using-cli.md#stage-8-configuration-of-cpu-resources "mention").

### Stage 6: Applying Hosts Configuration

Apply the configuration on the newly added host. Perform the instructions in [#stage-13-applying-hosts-configuration](../../install/bare-metal/using-cli.md#stage-13-applying-hosts-configuration "mention").&#x20;

{% hint style="info" %}
**Note:** You can activate the cluster hosts sequentially.
{% endhint %}

### Stage 7: Configuration of SSDs

Perform the instructions in [#stage-7-configuration-of-ssds](../../install/bare-metal/using-cli.md#stage-7-configuration-of-ssds "mention").

## Expand the Cluster by Importing the Host Settings

In most cases, the host configurations are similar. Therefore, it is possible to import the host setting from a previously exported host in the cluster, saving time and avoiding misconfiguration.

**Procedure:**

1. Perform only stages 1 to 3 in the [Adding a Backend Host to an Existing Cluster](stages-in-adding-a-backend-host.md#adding-a-backend-host-to-an-existing-cluster) procedure (above).
2. Connect to one of the hosts in the cluster and export the settings by running the following command: `weka local resources export`.
3. Connect to the new host and import the settings by running the following command: \
   `weka local resources import`.
4. Edit the local configuration. See the [#local-resources-editing-commands](expansion-of-specific-resources.md#local-resources-editing-commands "mention") section.
5. Apply the configuration on the newly added host.\
   See[#stage-13-applying-hosts-configuration](../../install/bare-metal/using-cli.md#stage-13-applying-hosts-configuration "mention").&#x20;
