---
description: >-
  This page provides the guidelines for expansion processes that only involve
  the addition of specific resources.
---

# Expansion of specific resources

## Dynamic modifications

Most modifications to container configurations can be performed dynamically, without deactivating the container. Such configurations include the addition/removal of memory and network resources, changing IPs, extending network subnets and limiting the Weka system bandwidth on the container.&#x20;

All these changes can be performed using the relevant `weka cluster container` command. Once this command is used with a specific `container-id`selected, it will be staged for update on the cluster. To view the un-applied configuration, use the `weka cluster container resources <container-id>`command. To apply the changes, use the `weka cluster container apply <container-ids>` command. You can also apply these changes locally using the `weka local resources apply` command.

The last local configuration (of a container that successfully joined a cluster) is saved. If a failure/problem occurs with the new configuration, the container will automatically revert to the last known good configuration. To view this configuration, use the `weka cluster container resources <container-id> --stable` command.&#x20;

### Memory modifications

To dynamically change the memory configuration, use the steps described for the [Configuration of Memory](../../install/bare-metal/using-cli.md#stage-10-configuration-of-memory-optional) on an active container, followed by the `weka cluster container apply` command.

{% hint style="success" %}
**Example:** To change `container-id 0` memory to 1.5 GB, run the following commands:

`weka cluster` container `memory 0 1.5GB`\
`weka cluster` container `apply 0`
{% endhint %}

### Network modifications

To dynamically change the network configuration, use the steps described for the [Configuration of Networking](../../install/bare-metal/using-cli.md#stage-6-configuration-of-networking) on an active container, followed by the `weka cluster container apply` command.

{% hint style="success" %}
**For Example:** To add another network device to `container-id 0`, run the following commands:

`weka cluster container net add 0 eth2`\
`weka cluster container apply 0`
{% endhint %}

{% hint style="info" %}
**Note:** It is possible to accumulate several changes on a container and apply only once on completion.
{% endhint %}

### Container IPs modifications

To dynamically change the container's management IPs, you can use the `management-ips` resource editing command.&#x20;

{% hint style="success" %}
**For Example:** To change the management IPs on `container-id 0`, run the following commands:

`weka cluster container management-ips 192.168.1.10 192.168.1.20`\
`weka cluster container apply 0`
{% endhint %}

{% hint style="info" %}
**Note:** The number of management IPs determines whether the container will use Highly Available Networking mode (HA), causing each IO process to use both containers' NICs. A container with 2 IPs will use HA mode and a container with only 1 IP will not use HA mode. It is also possible to define up to 4 IPs, in case the cluster is using both Infiniband and Ethernet network technologies.
{% endhint %}

### Local resources editing commands

It is also possible to run modification commands locally on the container by connecting to the desired container and running a `local resources` command equivalent to its `weka cluster` container counterpart. These local commands have the same semantics of their remote counterparts only that they don't receive the `container-id` as the first parameter and operate instead on the local container.&#x20;

Commands that can be performed dynamically on an Active container:

`weka local resources [--stable]`\
`weka local resources apply`\
`weka local resources net`\
`weka local resources net add`\
`weka local resources net remove`\
`weka local resources memory`\
`weka local resources bandwidth`\
`weka local resources management-ips`\
`weka local resources dedicate`

The following commands cannot be performed on an Active container and require deactivating the container first using `weka cluster container deactivate`:

`weka local resources failure-domain`\
`weka local resources cores`

## Addition of CPU cores

The addition of CPU cores to the cluster is not performed dynamically but on an inactive container. It requires the execution of the steps described in [Configuration of CPU Resources](../../install/bare-metal/using-cli.md#stage-9-configuration-of-cpu-resources).&#x20;

For more information, contact the WekaIO Support Team.

## Expansion of only SSDs

Follow the instructions appearing in [Configuration of SSDs](../../install/bare-metal/using-cli.md#stage-6-configuration-of-ssds).

