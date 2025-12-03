---
description: >-
  Guidelines for expansion processes that only involve the addition of a
  specific resource.
---

# Expand specific resources of a container

Expanding resources within a container involves dynamically adjusting the allocation of CPU, memory, storage, and other system resources to meet applications' changing demands. By effectively managing these resources, organizations can optimize performance, enhance scalability, and ensure the smooth operation of their containerized applications.

## Expansion guidelines

The following commands are available to expand the containers' resources:

* `weka cluster container`: Run actions on a remote container (or containers for specific sub-commands).
* `weka local resources`: Run actions locally.

Adhere to the following guidelines when expanding specific resources:

* **Specify the container:** Run the relevant `weka cluster container` command with the specific `container-id` you want to expand. Once you run the command, the container is staged to update in the cluster.
* **View existing resources:** To view the non-applied configuration, run the `weka cluster container resources <container-id>` command.
* **Apply changes on a specific container:** To apply changes on a specific container in the cluster, run the `weka cluster container apply <container-ids>` command.  It is possible to accumulate several changes on a container and apply only once on completion.
* **Apply changes on a local server:** To apply changes in the local container, run the `weka local resources apply` command.
* **The apply command saves the last configuration:** Once the apply command is complete, the last local configuration of the container that successfully joined the cluster is saved.\
  If a failure occurs with the new configuration, the container automatically remains with the existing stable configuration. \
  Run the `weka cluster container resources <container-id> --stable` command to view the existing configuration.
* **Expansion on active or deactivated containers:** Some resources can be expanded on active containers, such as adding CPU cores. Others require container deactivation, like setting failure domain. If deactivation is required, you can use the `--deactivation-check` option to check if the specified containers can be deactivated.

{% hint style="info" %}
Applying changes to a client container restarts the container. Once the restart process is complete, all active I/O operations of that client resume automatically.
{% endhint %}

## weka cluster container command description

**Command:** `weka cluster container <sub-command> <container-id> [options]`

Some sub-commands accept `<container-ids>`. See details in the following table.

**Subcommands**

<table><thead><tr><th width="192.33333333333331">Sub-command</th><th width="342">Description</th><th>Comment</th></tr></thead><tbody><tr><td><code>activate</code></td><td>Activate the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>add</code></td><td>Add a container to the cluster.</td><td></td></tr><tr><td><code>apply</code></td><td>Apply changes to the resources on the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>auto-remove-timeout</code></td><td>Set the time to wait before removing the containers from clients if they disconnect from the cluster. The minimum value is 60. Use 0 to disable automatic removal.</td><td>This subcommand only applies to clients.</td></tr><tr><td><code>bandwidth</code></td><td>Limit the bandwidth of the containers.</td><td></td></tr><tr><td><code>clear-failure</code></td><td>Clear the last failure fields of the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>cores</code></td><td>Change the number of cores in the containers.</td><td>Increasing the number of cores does not require deactivating the container, whereas decreasing the core count requires deactivation.</td></tr><tr><td><code>deactivate</code></td><td>Deactivate the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>deactivation-check</code></td><td>Check if the specified containers can be deactivated.</td><td></td></tr><tr><td><code>dedicate</code></td><td>Set the containers to be dedicated to the WEKA cluster.</td><td></td></tr><tr><td><code>failure-domain</code></td><td>Set the failure domain on the container.</td><td>Requires deactivating the container.</td></tr><tr><td><code>info-hw</code></td><td>Show hardware information about the containers.</td><td></td></tr><tr><td><code>join-secret</code></td><td>Set the secret this container uses when joining or validating other backends.</td><td></td></tr><tr><td><code>management-ips</code> </td><td>Set the management IPs of the container. To achieve high availability, set two IPs.</td><td></td></tr><tr><td><code>memory</code></td><td>Set the RAM size dedicated to the container.</td><td></td></tr><tr><td><code>net</code></td><td>List the WEKA-dedicated networking devices in the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>remove</code></td><td>Remove a container from the cluster.</td><td></td></tr><tr><td><code>requested-action</code></td><td>Set the specified containers' requested action to stop, restart, or apply resources gracefully.</td><td></td></tr><tr><td><code>resources</code></td><td>Get the resources of the containers.</td><td></td></tr><tr><td><code>restore</code></td><td>Restore staged resources of the containers or all containers to their stable state.</td><td>Specify the list of containers with a space delimiter.</td></tr></tbody></table>

**Options**

<table><thead><tr><th width="193">Option</th><th width="340.3333333333333">Description</th><th></th></tr></thead><tbody><tr><td>-b</td><td>Only return backend containers.</td><td></td></tr><tr><td>-c</td><td>Only return client containers.</td><td></td></tr><tr><td>-l</td><td>Only return containers that are part of the cluster leadership.</td><td>     </td></tr><tr><td>-L</td><td>Only return the cluster leader.</td><td></td></tr></tbody></table>

## Expansion procedures on a remote container&#x20;

### Modify the memory

Run the following command lines on the active container:

```
weka cluster container memory <container-id> <capacity-memory>
weka cluster container apply <container-ids>
```

<details>

<summary><strong>Example</strong></summary>

To change the memory of `container-id 0` to 1.5 GiB, run the following commands:

```
weka cluster container memory 0 1.5GiB
weka cluster container apply 0
```

</details>

After reducing the memory allocation for a container, follow these steps to release hugepages on each container:

1. Stop the container locally. Run `weka local stop`
2. Release hugepages. Run `weka local run release_hugepages`
3. Restart the container locally. Run `weka local start`

### Modify the network configuration

Run the following command lines on the active container:

```
weka cluster container net add <container-id> <device>
weka cluster container apply <container-ids>
```

<details>

<summary><strong>Example</strong></summary>

To add another network device to `container-id 0`, run the following commands:

```
weka cluster container net add 0 eth2
weka cluster container apply 0
```

</details>

### Modify the container IP addresses

Run the following command lines on the active container:

```
weka cluster container management-ips <container-id> <management-ips>
weka cluster container apply <container-ids>
```

<details>

<summary><strong>Example</strong></summary>

To change the management IPs on `container-id 0`, run the following commands:

```
weka cluster container management-ips 0 192.168.1.10 192.168.1.20
weka cluster container apply 0
```

</details>

The number of management IP addresses determines whether the container uses high-availability (HA) networking, causing each IO process to use both containers' NICs.

A container with two IP addresses uses HA networking. A container with only one IP does not use HA networking.

If the cluster uses InfiniBand and Ethernet network technologies, you can define up to four IP addresses.

### Modify the number of cores for a container

You can increase or decrease the number of dedicated cores for a container locally, even while the container is active.

* Increasing cores does not require deactivating the container for any container type.
* Decreasing cores does not require deactivating the container for compute and drive containers. However, for frontend containers, you must deactivate the container first.

**Prerequisites for decreasing frontend cores**

Before decreasing the number of dedicated cores for a frontend container, you must deactivate it using the following command:

```
weka cluster container deactivate <container-ids>
```

After completing the core modification procedure below, remember to reactivate the container.

**Procedure: Set the number of dedicated cores**

Run the following command line to set the number of dedicated cores to a container. The procedure below exemplifies the modification of a compute container, which runs compute processes.

1.  Set the number of dedicated cores for the container:

    ```bash
    weka cluster container cores <container-id> <number of total cores> / 
    --compute-dedicated-cores <number of total cores> --no-frontends
    ```

    To ensure the cores are allocated to compute processes, make sure to add the `--no-frontends` flag.
2.  Apply the changes to the container.

    ```bash
    weka cluster container apply <container-ids>
    ```
3.  Check the number of cores dedicated to the compute processes.

    ```bash
    weka cluster container <container-ids>
    ```

<details>

<summary>Example: Setting 10 cores for compute container</summary>

The following example sets 10 cores to the container with ID 1, which is running compute processes.

```
weka cluster container cores 1 10 --compute-dedicated-cores 10 --no-frontends
weka cluster container apply 1
weka cluster container 1
```

**Respnse:**

```
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
COMPUTE     1        <auto>
COMPUTE     2        <auto>
COMPUTE     3        <auto>
COMPUTE     4        <auto>
COMPUTE     5        <auto>
COMPUTE     6        <auto>
COMPUTE     7        <auto>
COMPUTE     8        <auto>
COMPUTE     9        <auto>
COMPUTE     10       <auto>
```

</details>

### Add SSDs to a container

Expand the cluster's storage capacity by adding new SSD drives to a specific container.

Adding SSD drives might alter the ratio between SSDs and drive cores, which can impact performance. When adding drives, you can assign them to specific drive pools, such as `iu4k` or `legacy`. This capability allows for integrating diverse SSD types within a single cluster, providing greater hardware flexibility.

{% hint style="info" %}
Support for mixed drive pools is only available for clusters newly installed with this software version and is not supported for upgraded clusters.
{% endhint %}

**Prerequisites**

* Ensure the cluster has an available drive core to allocate to the new SSD.
* Identify the container ID for the SSD addition.

**Procedure**

1.  Identify the relevant container ID to which you want to add the SSD drive.

    ```bash
    weka cluster container
    ```
2.  Scan for new drives.

    ```bash
    weka cluster drive scan
    ```
3.  Add the SSDs to the container. You can optionally specify a drive pool.

    ```bash
    weka cluster drive add <container-id> <device-paths> [--pool <pool>]
    ```

**Parameters**

<table><thead><tr><th width="171.95703125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>container-id</code>*</td><td>The identifier of the drive container to which to add the local SSD drives.</td></tr><tr><td><code>device-paths</code>*</td><td><p>A list of block devices that identify local SSDs. It must be a valid Unix network device name. </p><p>Format: Space-separated strings.</p><p>Example: <code>/dev/nvme0n1 /dev/nvme1n1</code></p></td></tr><tr><td><code>pool</code></td><td><p>Specifies the disk pool to which you add the drive. Disk pools help organize drives based on their indirection unit (IU) size to optimize performance and endurance.</p><p>Possible values include:</p><ul><li><code>auto</code>: Automatically selects the appropriate pool by detecting the drive's characteristics.</li><li><code>iu4k</code>: Adds the drive to the Indirection Unit 4K pool. This pool is for drives with a 4KiB indirection unit size.</li><li><code>iubig</code>: Adds the drive to the Indirection Unit "big" pool. This pool is for drives with large indirection units, such as 32KiB.</li><li><code>legacy</code>: Adds the drive to the legacy pool. Use this option for compatibility with systems that were set up before the introduction of indirection unit-based pooling.</li></ul></td></tr></tbody></table>

## weka local resources command description

You can also modify the resources on a local container by connecting to it and running the `weka local resources` command equivalent to its `weka cluster` remote counterpart command.

These local commands have the same semantics as their remote counterpart. You do not specify the `container-id` as the first parameter. All actions are done on the local container.

**Command**: `weka local resources`

**Subcommands**

<table><thead><tr><th width="192.33333333333331">Sub-command</th><th width="285">Description</th><th>Comment</th></tr></thead><tbody><tr><td><code>apply</code></td><td>Apply changes to the resources locally.</td><td></td></tr><tr><td><code>auto-remove-timeout</code></td><td>Set the time to wait before removing the containers from clients if they disconnect from the cluster. The minimum value is 60. Use 0 to disable automatic removal.</td><td>This subcommand only applies to clients.</td></tr><tr><td><code>bandwidth</code></td><td>Limit the bandwidth of the container.</td><td></td></tr><tr><td><code>base-port</code></td><td>Change the port range used by the container. WEKA containers require 100 ports to operate.</td><td></td></tr><tr><td><code>cores</code></td><td>Change the number of cores in the container.</td><td><ul><li>Increasing the number of cores does not require deactivating the container for any container type.</li><li>Decreasing the number of cores does not require deactivating the container for compute and drive types. However, for frontend container type deactivation is required.</li></ul></td></tr><tr><td><code>dedicate</code></td><td>Set the container to be dedicated to the WEKA cluster.</td><td></td></tr><tr><td><code>export</code></td><td>Export stable resources to a file.</td><td></td></tr><tr><td><code>failure-domain</code></td><td>Set the container failure-domain.</td><td>Requires deactivating the container.</td></tr><tr><td><code>fqdn</code></td><td>Configure the FQDN for other containers for TLS hostname verification when interacting with the cluster.</td><td></td></tr><tr><td><code>import</code></td><td>Import resources from a file.</td><td></td></tr><tr><td> <code>join-ips</code></td><td>Set the IPs and ports of all containers in the cluster. This enables the container to join the cluster using these IPs.</td><td></td></tr><tr><td><code>join-secret</code></td><td>Configure the secret used when joining a cluster as a backend.</td><td></td></tr><tr><td><code>management-ips</code></td><td>Set the container's management IPs. To achieve high-availability, set two IPs.</td><td></td></tr><tr><td><code>memory</code></td><td>Set the RAM size dedicated to the container.</td><td></td></tr><tr><td><code>net</code></td><td>List the WEKA-dedicated networking devices in a container.</td><td></td></tr><tr><td><code>restore</code></td><td>Restore resources from stable resources.</td><td></td></tr></tbody></table>

**Options**

<table><thead><tr><th width="194.33333333333331">Option</th><th width="337">Description</th><th>Comment</th></tr></thead><tbody><tr><td><code>--stable</code></td><td>List the resources from the last successful container boot.</td><td></td></tr><tr><td><code>-C</code></td><td>The container name.</td><td></td></tr></tbody></table>

<details>

<summary>Example: Set dedicated cores for the compute processes locally</summary>

The following example sets 10 cores to the `compute0` container. The container id is 1. It is important to add `--no-frontends` to allocate the cores dedicated to the compute processes. Connect to the relevant server to run the following commands locally.

```
weka local resources cores 10 --compute-dedicated-cores 10 -C compute0 --no-frontends
weka local resources -C compute0

//response
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
COMPUTE     1        <auto>
COMPUTE     2        <auto>
COMPUTE     3        <auto>
COMPUTE     4        <auto>
COMPUTE     5        <auto>
COMPUTE     6        <auto>
COMPUTE     7        <auto>
COMPUTE     8        <auto>
COMPUTE     9        <auto>
COMPUTE     10       <auto>
```

</details>

## Graceful container management: ensuring safe actions

The `weka local stop`, `restart`, and `apply resources` commands perform graceful stop operations by default, ensuring actions are executed safely to minimize the risk of unexpected issues or disruptions. The system automatically prioritizes safety during cluster maintenance without requiring the `--graceful` option. If non-graceful action is required, add the `--force` option.

Additionally, stopping and starting dependent containers is the default behavior for the `weka local stop/start` commands, providing seamless management of dependent services. To override this behavior, use the `--skip-start-and-enable-dependent` or `--skip-stop-and-enable-dependent` options.

**How the default graceful process works:**

* **Action Initiation:** Sends a request to the container for the specified action (STOP, RESTART, or APPLY\_RESOURCES).
* **Safety check:** Evaluates feasibility based on current state and safety constraints (for example, ensuring sufficient resources post-action).
* **Draining and execution:** If safe, the container transitions to the DRAINING state to complete ongoing operations. Once DRAINED, the action is executed.

**Example: Prioritizing stability**

If stopping a container would violate minimum failure domain requirements, the graceful stop prevents the action to maintain system health.

The graceful process applies exclusively to cluster containers, not to protocol containers.

<pre class="language-bash" data-title="Example: prioritizing stability" data-full-width="true"><code class="lang-bash"><strong>CONTAINER ID  HOSTNAME  CONTAINER  IPS             STATUS          REQUESTED ACTION  REQUESTED ACTION FAILURE
</strong>0             Host-0    drives0    10.108.206.201  UP              STOP              Upon completion of this operation, there are 4 reliable containers available for cluster leadership, while the requirement is for 5.                 
6             Host-0    compute0   10.108.206.201  DRAINED (DOWN)  STOP                                 
12            Host-0    frontend0  10.108.206.201  DRAINING        RESTART     
</code></pre>
