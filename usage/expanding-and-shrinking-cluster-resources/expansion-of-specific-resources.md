---
description: >-
  Guidelines for expansion processes that only involve the addition of a
  specific resource.
---

# Expand specific resources of a container

You can expand the container's resources dynamically without deactivating the container. These include:

* Add and remove memory and network resources.
* Modify the IP addresses.
* Extend the network subnets.
* Limit the WEKA system bandwidth on the container.

Adhere to the following guidelines when expanding specific resources:

* Run the relevant `weka cluster container` command with the specific `container-id` you want to expand. Once you run the command, the container is staged to update in the cluster.
* To view the non-applied configuration, run the `weka cluster container resources <container-id>`command.
* To apply changes on a specific container in the cluster, run the `weka cluster container apply <container-ids>` command.  It is possible to accumulate several changes on a container and apply only once on completion.
* To apply changes in the local container, run the `weka local resources apply` command.
* Once the apply command completes, the last local configuration of the container successfully joined the cluster is saved.
* If a failure occurs with the new configuration, the container automatically reverts to the last stable configuration. To view the last stable configuration, run the `weka cluster container resources <container-id> --stable` command.&#x20;

## Modify the memory

Run the following command lines on the active container:

```
weka cluster container memory <container-id> <capacity-memory>
weka cluster container apply <container-id>
```

<details>

<summary><strong>Example</strong></summary>

To change the memory of `container-id 0` to 1.5 GB, run the following commands:

`weka cluster container memory 0 1.5GB`

`weka cluster container apply 0`

</details>

For more details and options, see [#9.-configure-the-memory-optional](../../install/bare-metal/using-cli.md#9.-configure-the-memory-optional "mention").

## Modify the network configuration

Run the following command lines on the active container:

```
weka cluster container net add <container-id> <device>
weka cluster container apply <container-id>
```

<details>

<summary><strong>Example</strong></summary>

To add another network device to `container-id 0`, run the following commands:

`weka cluster container net add 0 eth2`

`weka cluster container apply 0`

</details>

For more details and options, see [#6.-configure-the-networking](../../install/bare-metal/using-cli.md#6.-configure-the-networking "mention").

## Modify the container IP addresses

Run the following command lines on the active container:

```
weka cluster container management-ips <container-id> <device>
weka cluster container apply <container-id>
```

<details>

<summary><strong>Example</strong></summary>

To change the management IPs on `container-id 0`, run the following commands:

`weka cluster container management-ips 192.168.1.10 192.168.1.20`

`weka cluster container apply 0`

</details>

The number of management IP addresses determines whether the container uses high-availability (HA) networking, causing each IO process to use both containers' NICs.

A container with two IP addresses uses HA networking. A container with only one IP does not use HA networking.

If the cluster uses InfiniBand and Ethernet network technologies, you can define up to four IP addresses.

## Add CPU cores to a container

Adding CPU cores to the cluster can only be done on a deactivated container.

For more details and options, see [#8.-configure-the-cpu-resources](../../install/bare-metal/using-cli.md#8.-configure-the-cpu-resources "mention").

## Expand SSDs only

Adding SSD drives can alter the ratio between SSDs and drive cores.

#### Procedure

1. Ensure the cluster has a drive core to allocate for the new SSD. If required, deactivate the container and then add the drive core to the container.&#x20;
2. Determine the relevant container ID by running  the command:\
   `weka cluster container`
3. Scan for new drives by running  the command:\
   `weka cluster drive scan`
4. Depending on the architecture, use the following instructions to add the SSDs:&#x20;
   * [Legacy architecture](../../install/bare-metal/using-cli.md#7.-configure-the-ssds)&#x20;
   * [Multiple container architecture](../../install/bare-metal/weka-system-installation-with-multiple-containers-using-the-cli.md#6.-configure-the-ssd-drives)

## Modify resources on a local container

You can also modify the resources on a local container by connecting to it and running the `local resources` command equivalent to its `weka cluster` remote counterpart command.

These local commands have the same semantics as their remote counterpart commands. They don't receive the `container-id` as the first parameter. Instead, they operate on the local container.

{% tabs %}
{% tab title="Available commands on an active container" %}
You can run the following commands dynamically on an active container:

`weka local resources [--stable]`

`weka local resources apply`

`weka local resources net`

`weka local resources net add`

`weka local resources net remove`

`weka local resources memory`

`weka local resources bandwidth`

`weka local resources management-ips`

`weka local resources dedicate`
{% endtab %}

{% tab title="Available commands on a deactivated container" %}
First, deactivate the container by running the `weka cluster container deactivate` command and then you can run the following commands:

`weka local resources failure-domain`

`weka local resources cores`
{% endtab %}
{% endtabs %}
