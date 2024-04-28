---
description: >-
  Guidelines for expansion processes that only involve the addition of a
  specific resource.
---

# Expand specific resources of a container

Expanding resources within a container involves dynamically adjusting the allocation of CPU, memory, storage, and other system resources to meet the changing demands of applications. By effectively managing these resources, organizations can optimize performance, enhance scalability, and ensure the smooth operation of their containerized applications.

## Expansion guidelines

The following commands are available to expand the containers' resources:

* `weka cluster container`: Run actions on a remote container (or containers for specific sub-commands).
* `weka local resources`: Run actions locally.

Adhere to the following guidelines when expanding specific resources:

* **Specify the container:** Run the relevant `weka cluster container` command with the specific `container-id` you want to expand. Once you run the command, the container is staged to update in the cluster.
* **View existing resources:** To view the non-applied configuration, run the `weka cluster container resources <container-id>`command.
* **Apply changes on a specific container:** To apply changes on a specific container in the cluster, run the `weka cluster container apply <container-id>` command.  It is possible to accumulate several changes on a container and apply only once on completion.
* **Apply changes on a local server:** To apply changes in the local container, run the `weka local resources apply` command.
* **The apply command saves the last configuration:** Once the apply command completes, the last local configuration of the container successfully joined the cluster is saved.\
  If a failure occurs with the new configuration, the container automatically remains with the existing stable configuration. \
  Run the `weka cluster container resources <container-id> --stable` command to view the existing configuration.
* **Expansion on active or deactivated containers:** You can dynamically expand some of the resources on active containers, and others only after deactivating the container. For example, you can add CPU cores only on a deactivated container.

## weka cluster container command description

**Command:** `weka cluster container <sub-command> <container-id> [options]`

Some sub-commands accept `<container-ids>`. See details in the following table.

**Subcommands**

<table><thead><tr><th width="192.33333333333331">Sub-command</th><th width="342">Description</th><th>Comment</th></tr></thead><tbody><tr><td><code>info-hw</code></td><td>Show hardware information about the containers.</td><td></td></tr><tr><td><code>failure-domain</code></td><td>Set the containers as failure domains.</td><td>Can only be done on a deactivated container.</td></tr><tr><td><code>dedicate</code></td><td>Set the containers as dedicated to the WEKA cluster.</td><td></td></tr><tr><td><code>bandwidth</code></td><td>Limit the bandwidth of the containers.</td><td></td></tr><tr><td><code>cores</code></td><td>Change the number of cores in the containers.</td><td>Can only be done on a deactivated container.</td></tr><tr><td><code>memory</code></td><td>Set the RAM size dedicated to the container.</td><td></td></tr><tr><td><code>auto-remove-timeout</code></td><td>Set the time to wait before removing the containers if it disconnects from the cluster.<br>The minimum value is 60. Use 0 to disable automatic removal.</td><td>This subcommand only applies to clients.</td></tr><tr><td><code>management-ips</code> </td><td>Set the management IPs of the container. To achieve high availability, set two IPs.</td><td></td></tr><tr><td><code>resources</code></td><td>Get the resources of the containers.</td><td></td></tr><tr><td><code>restore</code></td><td>Restore staged resources of the containers or all containers to their stable state.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>apply</code></td><td>Apply changes to the resources on the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>activate</code></td><td>Activate the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>deactivate</code></td><td>Deactivate the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>clear-failure</code></td><td>Clear the last failure fields of the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr><tr><td><code>add</code></td><td>Add a container to the cluster.</td><td></td></tr><tr><td><code>remove</code></td><td>Remove a container from the cluster.</td><td></td></tr><tr><td><code>net</code></td><td>List the WEKA-dedicated networking devices in the containers.</td><td>Specify the list of containers with a space delimiter.</td></tr></tbody></table>

**Options**

<table><thead><tr><th width="193">Option</th><th width="340.3333333333333">Description</th><th></th></tr></thead><tbody><tr><td>-b</td><td>Only return backend containers.</td><td></td></tr><tr><td>-c</td><td>Only return client containers.</td><td></td></tr><tr><td>-l</td><td>Only return containers that are part of the cluster leadership.</td><td>     </td></tr><tr><td>-L</td><td>Only return the cluster leader.</td><td></td></tr></tbody></table>

## Expansion procedures on a remote container&#x20;

### Modify the memory

Run the following command lines on the active container:

```
weka cluster container memory <container-id> <capacity-memory>
weka cluster container apply <container-id>
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
weka cluster container apply <container-id>
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
weka cluster container apply <container-id>
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

### Add CPU cores to a container

You can add dedicated CPU cores to a container locally and on a deactivated container. The added cores must be dedicated to a specific process type: compute, drives, or frontend.

For clarity, the following procedure exemplifies expansion on the container running the compute processes.

**Procedure**

1. Deactivate the container. Run the following command:\
   `weka cluster container deactivate <container-ids>`
2. Run the following command line to set the number of dedicate cores to the compute container:\
   `weka cluster container cores <container-id> <number of total cores> --compute-dedicated-cores <number of total cores> --no-frontends`
3. Apply the changes. Run the following command:\
   `weka cluster container apply <containr-id>`
4. Check the number of cores dedicated to the compute processes. Run the following command: \
   `weka cluster container <container-ids>`

<details>

<summary>Example</summary>

The following example sets 10 cores to the `compute0` container. The container id is 1. It is important to add `--no-frontends` to allocate the cores dedicated to the compute processes.

```
weka cluster container deactivate 1
weka cluster container cores 1 10 --compute-dedicated-cores 10 --no-frontends
weka cluster container apply 1
weka cluster container 1
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

5. Activate the container.\
   Run the following command:\
   `weka cluster container activate <container-ids>`

### Expand SSDs only

You can add new SSD drives to a container. Adding SSD drives may alter the ratio between SSDs and drive cores, potentially impacting performance. Take note of this adjustment when considering expansion, for optimal system efficiency.

#### Procedure

1. Ensure the cluster has a drive core to allocate for the new SSD. If a drive core is required, deactivate the container and then add the drive core to the container. See [Add CPU cores to a container](expansion-of-specific-resources.md#add-cpu-cores-to-a-container).
2. Identify the relevant container ID to which you want to add the SSD drive. Run the command:\
   `weka cluster container`
3. Scan for new drives. Run the command:\
   `weka cluster drive scan`
4. To add the SSDs, run the following command:\
   `weka cluster drive add <container-id> <device-paths>`\
   Where:\
   `container-id` is the Identifier of the drive container to add the local SSD drives.\
   `device-paths` is a list of block devices that identify local SSDs. \
   It must be a valid Unix network device name**.**\
   Format: Space-separated strings. Example:  `/dev/nvme0n1 /dev/nvme1n1`

## weka local resources command description

You can also modify the resources on a local container by connecting to it and running the `weka local resources` command equivalent to its `weka cluster` remote counterpart command.

These local commands have the same semantics as their remote counterpart commands. You do not specify the `container-id` as the first parameter. All actions are done on the local container.

**Command**: `weka local resources`

**Subcommands**

<table><thead><tr><th width="192.33333333333331">Sub-command</th><th width="342">Description</th><th>Comment</th></tr></thead><tbody><tr><td><code>import</code></td><td>Import resources from a file.</td><td></td></tr><tr><td><code>export</code></td><td>Export stable resources to a file.</td><td></td></tr><tr><td><code>restore</code></td><td>Restore resources from stable resources.</td><td></td></tr><tr><td><code>apply</code></td><td>Apply changes to the resources locally.</td><td></td></tr><tr><td><code>cores</code></td><td>Change the number of cores in the container.</td><td>Can only be done on a deactivated container.</td></tr><tr><td><code>base-port</code></td><td>Change the port-range used by the container. Weka containers require 100 ports to operate.</td><td></td></tr><tr><td><code>memory</code></td><td>Set the RAM size dedicated to the container.</td><td></td></tr><tr><td><code>dedicate</code></td><td>Set the container as dedicated to the WEKA cluster.</td><td></td></tr><tr><td><code>bandwidth</code></td><td>Limit the bandwidth of the container.</td><td></td></tr><tr><td><code>management-ips</code></td><td>Set the container's management IPs. To achieve high-availability, set two IPs.</td><td></td></tr><tr><td> <code>join-ips</code></td><td>Set the IPs and ports of all containers in the cluster. This enables the container to join the cluster using these IPs.</td><td></td></tr><tr><td><code>failure-domain</code></td><td>Set the container failure-domain.</td><td>Can only be done on a deactivated container.</td></tr><tr><td><code>net</code></td><td>List the WEKA-dedicated networking devices in a container.</td><td></td></tr></tbody></table>

**Options**

<table><thead><tr><th width="194.33333333333331">Option</th><th width="337">Description</th><th>Comment</th></tr></thead><tbody><tr><td><code>--stable</code></td><td>List the resources from the last successful container boot.</td><td></td></tr><tr><td><code>-C</code></td><td>The container name.</td><td></td></tr></tbody></table>

<details>

<summary>Example: Set dedicated cores for the compute processes locally</summary>

The following example sets 10 cores to the `compute0` container. The container id is 1. It is important to add `--no-frontends` to allocate the cores dedicated to the compute processes.

```
weka cluster container deactivate 1

//Connect to the relevant server to run the following commands locally.

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
