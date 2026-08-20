# weka cluster

Administer the Weka cluster.

```sh
weka cluster
```

## weka cluster add

Form a Weka cluster from containers that just had Weka installed on them.

```sh
weka cluster add <hostnames>… [--admin-password <string>] [--host-fqdn <strings>…] [--host-ips <ip-endpoints>…] [--join-secret <string>]
```

| Parameter                     | Description                                                                                                                                                                                                                                                         |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `hostnames`\*…                | List of hostnames to form the cluster.                                                                                                                                                                                                                              |
| `--admin-password` \<string>  | Initial admin password. Will be set to the default password if not provided.                                                                                                                                                                                        |
| `--host-fqdn` \<strings>…     | Management fully qualified domain name. If both FQDNs and IPs are empty, hostnames will be resolved. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                            |
| `--host-ips` \<ip-endpoints>… | Management IP addresses. If both FQDN and IPs are empty, the hostnames will be resolved. If hosts are highly-available or mixed-networking, use IP set '\<ip>+\<ip>+...+\<ip>'. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--join-secret` \<string>     | Initial join secret. All backends must agree on the same join secret to clusterize.                                                                                                                                                                                 |

## weka cluster bucket

List the cluster buckets, logical compute units used to divide the workload in the cluster.

```sh
weka cluster bucket [<bucket-ids>…]
```

| Parameter     | Description                   |
| ------------- | ----------------------------- |
| `bucket-ids`… | Only return these bucket IDs. |

**Columns:** `id`, `leader`, `leader_term`, `last_active_term`, `init_state`, `council`, `previous_leader`, `uptime`, `leader_version_sig`, `electable_mode`, `source_version_members`, `non_source_version_members`, `fill_level_percent`, `rebuild_todo`, `rebuild_total`, `fail_reason`, `activity`

## weka cluster client-target-version

Manage the target version used for clients.

```sh
weka cluster client-target-version
```

### weka cluster client-target-version reset

Reset the target version used for clients, so they will use the same version as backends.

```sh
weka cluster client-target-version reset
```

### weka cluster client-target-version set

Set the target version used for clients, used during upgrade or multiple cluster settings.

```sh
weka cluster client-target-version set <version-name>
```

| Parameter        | Description                     |
| ---------------- | ------------------------------- |
| `version-name`\* | The version to use for clients. |

### weka cluster client-target-version show

Show the target version used for clients, or None for cluster defaults.

```sh
weka cluster client-target-version show
```

## weka cluster container

List the cluster containers.

```sh
weka cluster container [<container-ids>…] [--backends] [--clients] [--council] [--hostnames <strings>…] [--leader] [--leadership] [--local]
```

| Parameter                 | Description                                                                                                                    |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `container-ids`…          | Only return these container IDs.                                                                                               |
| `-b`, `--backends`        | Only return backend containers.                                                                                                |
| `-c`, `--clients`         | Only return client containers.                                                                                                 |
| `--council`               | Get result from cluster leadership members.                                                                                    |
| `--hostnames` \<strings>… | Only return containers on these hostnames. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-L`, `--leader`          | Only return the cluster leader.                                                                                                |
| `-l`, `--leadership`      | Only return containers that are part of the cluster leadership.                                                                |
| `--local`                 | Get result from local weka host.                                                                                               |

**Columns:** `uid`, `id`, `hostname`, `container`, `machineId`, `ips`, `port`, `status`, `state`, `requestedAction`, `software`, `release`, `mode`, `fdName`, `fdId`, `fdType`, `cores`, `feCores`, `driveCores`, `coreIds`, `bw`, `scrubber_limit`, `dedicated`, `autoRemove`, `leadership`, `memory`, `uptime`, `failureText`, `failure`, `failureTime`, `failureCode`, `recentFailure`, `requestedActionFailureText`, `requestedActionFailure`, `requestedActionFailureTime`, `requestedActionFailureCode`, `addedTime`, `cloudProvider`, `availabilityZone`, `instanceType`, `instanceId`, `hypervisorType`, `osName`, `kernelName`, `kernelRelease`, `kernelVersion`, `architecture`, `tlsStrictnessLevel`, `hardwareMonitoring`

### weka cluster container activate

Activate the supplied containers, or all containers if none are supplied.

```sh
weka cluster container activate [<container-id>…] [--no-wait] [--skip-activate-drives] [--skip-resource-validation]
```

| Parameter                    | Description                            |
| ---------------------------- | -------------------------------------- |
| `container-id`…              | ID of the container to activate.       |
| `--no-wait`                  | Do not wait for operation to complete. |
| `--skip-activate-drives`     | Skip activating container's drives.    |
| `--skip-resource-validation` | Skip resource validation.              |

### weka cluster container add

Add a container to the cluster.

```sh
weka cluster container add <hostname> [--fqdn <string>] [--ip <strings>…] [--no-wait]
```

| Parameter          | Description                                                                                                                                                                                                                          |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `hostname`\*       | Hostname of the container to add.                                                                                                                                                                                                    |
| `--fqdn` \<string> | Fully qualified domain name used for validating the container's TLS certificates.                                                                                                                                                    |
| `--ip` \<strings>… | Management IP address. If empty, the hostname is resolved. For highly-available or mixed-networking containers, may be specified multiple times. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--no-wait`        | Do not wait for the container to be added to the cluster.                                                                                                                                                                            |

### weka cluster container apply

Apply the staged resources of the supplied containers, or all containers.

```sh
weka cluster container apply [<container-id>…] [--all] [--force] [--skip-resource-validation]
```

| Parameter                    | Description                                                                                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`…              | IDs of containers to apply resources on.                                                                                                    |
| `--all`                      | Apply the changes on all containers in the cluster. This will cause all backend containers in the entire cluster to restart simultaneously. |
| `-f`, `--force`              | Force action. Perform this action without further confirmation.                                                                             |
| `--skip-resource-validation` | Skip resource validation.                                                                                                                   |

### weka cluster container bandwidth

Limit weka's bandwidth for the container.

This command is deprecated. Use 'weka local resources bandwidth' instead.

```sh
weka cluster container bandwidth <container> <bandwidth>
```

| Parameter     | Description                                    |
| ------------- | ---------------------------------------------- |
| `container`\* | Container ID to update.                        |
| `bandwidth`\* | Bandwidth in bytes per second, or 'unlimited'. |

### weka cluster container clear-failure

Clear the last failure fields for the supplied containers.

```sh
weka cluster container clear-failure <container-id>…
```

| Parameter         | Description                                  |
| ----------------- | -------------------------------------------- |
| `container-id`\*… | IDs of containers to clear last failure for. |

### weka cluster container cores

Dedicate CPU cores to container for WEKA.

This command is deprecated. Use 'weka local resources cores' instead.

```sh
weka cluster container cores <container-id> <cores> [--allow-mix-setting] [--compute-dedicated-cores <uint>] [--core-ids <uints>…] [--drives-dedicated-cores <uint>] [--frontend-dedicated-cores <uint>] [--no-frontends] [--only-compute-cores] [--only-drives-cores] [--only-frontend-cores]
```

| Parameter                            | Description                                                                                                            |
| ------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*                     | Container ID.                                                                                                          |
| `cores`\*                            | Number of CPU cores dedicated to WEKA.                                                                                 |
| `--allow-mix-setting`                | Allow specified core-ids even if there are running containers with AUTO core-ids allocation on the same server.        |
| `--compute-dedicated-cores` \<uint>  | Number of cores for compute.                                                                                           |
| `--core-ids` \<uints>…               | Core IDs for weka dedicated cores. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--drives-dedicated-cores` \<uint>   | Number of cores for drives.                                                                                            |
| `--frontend-dedicated-cores` \<uint> | Number of cores for frontends.                                                                                         |
| `--no-frontends`                     | Do not create frontend processes.                                                                                      |
| `--only-compute-cores`               | Create only compute processes.                                                                                         |
| `--only-drives-cores`                | Create only drives processes.                                                                                          |
| `--only-frontend-cores`              | Create only frontend processes.                                                                                        |

### weka cluster container deactivate

Deactivate the supplied containers.

```sh
weka cluster container deactivate <container-id>… [--allow-reduced-resilience-to <uint>] [--no-wait] [--skip-resource-validation]
```

| Parameter                               | Description                                                                                                                                  |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*…                       | IDs of containers to deactivate.                                                                                                             |
| `--allow-reduced-resilience-to` \<uint> | Minimum resilience level permitted after deactivation (0 = no minimum). Omitting this flag uses the cluster's configured minimum resilience. |
| `--no-wait`                             | Do not wait for operation to complete.                                                                                                       |
| `--skip-resource-validation`            | Skip resource validation.                                                                                                                    |

### weka cluster container deactivation-check

Check if the provided containers can be deactivated.

```sh
weka cluster container deactivation-check <container-id>…
```

| Parameter         | Description                 |
| ----------------- | --------------------------- |
| `container-id`\*… | IDs of containers to check. |

### weka cluster container dedicate

Dedicate container resources for WEKA.

This command is deprecated. Use 'weka local resources dedicate' instead.

```sh
weka cluster container dedicate <container-id> <dedicated>
```

| Parameter        | Description                                       |
| ---------------- | ------------------------------------------------- |
| `container-id`\* | Container ID.                                     |
| `dedicated`\*    | Set the container as dedicated (on) or not (off). |

### weka cluster container failure-domain

Set the container failure-domain.

This command is deprecated. Use 'weka local resources failure-domain' instead.

```sh
weka cluster container failure-domain <container> [--auto] [--name <string>]
```

| Parameter          | Description                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------------- |
| `container`\*      | Container ID to update.                                                                                 |
| `--auto`           | Set this container to be a failure-domain of its own.                                                   |
| `--name` \<string> | Add this container to a named failure-domain. A failure-domain will be created if it doesn't exist yet. |

### weka cluster container info-hw

Show hardware information about one or more containers.

```sh
weka cluster container info-hw [<hostname>] [--info-type <info-types>…]
```

| Parameter                    | Description                                                                                                     |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `hostname`                   | Containers to query, by hostname or IP. If none are supplied, all cluster containers are queried.               |
| `--info-type` \<info-types>… | Information types to query. Multiple values may be supplied separated by commas, or the option may be repeated. |

### weka cluster container join-secret

Set the join secret used by the container.

```sh
weka cluster container join-secret <container> <secret>
```

| Parameter     | Description                                                                 |
| ------------- | --------------------------------------------------------------------------- |
| `container`\* | Container ID to update.                                                     |
| `secret`\*    | Secret used when joining the cluster as backend; must match other backends. |

### weka cluster container management-ips

Set the container's management process IPs. Setting 2 IPs will turn this container's networking into highly-available or mixed networking mode.

This command is deprecated. Use 'weka local resources management-ips' instead.

```sh
weka cluster container management-ips <container-id> <management-ips>…
```

| Parameter           | Description                           |
| ------------------- | ------------------------------------- |
| `container-id`\*    | Container ID.                         |
| `management-ips`\*… | New IPs for the management processes. |

### weka cluster container memory

Dedicate a set amount of RAM to weka.

This command is deprecated. Use 'weka local resources memory' instead.

```sh
weka cluster container memory <container-id> <memory>
```

| Parameter        | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| `container-id`\* | Container ID.                                                |
| `memory`\*       | Memory dedicated to weka. Set to 0 to let the system decide. |

### weka cluster container net

Show container network devices.

```sh
weka cluster container net [<container>…]
```

| Parameter    | Description              |
| ------------ | ------------------------ |
| `container`… | Container IDs to filter. |

**Columns:** `uid`, `name`, `id`, `container`, `hostname`, `nics`, `ips`, `netmask`, `gateway`, `max_cores`, `processes`, `vlan`, `lablel`

#### weka cluster container net add

Add a network device to a container.

This command is deprecated. Use 'weka local resources net add' instead.

```sh
weka cluster container net add <container-id> <device> [--gateway <ip>] [--inet6] [--ips <ips>…] [--ips-type <ips-type>] [--label <string>] [--name <string>] [--netmask <uint8>] [--rdma-off] [--rdma-only]
```

| Parameter                | Description                                                                                                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*         | Container ID.                                                                                                                               |
| `device`\*               | Network device PCI slot, MAC address, or interface name.                                                                                    |
| `--gateway` \<ip>        | Default gateway IP address.                                                                                                                 |
| `--inet6`                | Use IPv6 for RoCE v2 RDMA. The default is IPv4; not required and ignored for Infiniband.                                                    |
| `--ips` \<ips>…          | IP addresses to be allocated to cores using the device. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--ips-type` \<ips-type> | IPs allocation type. POOL: IPs from the default data networking IP pool. USER: configured by the user.                                      |
| `--label` \<string>      | Name of the switch or network group to which this network device is attached.                                                               |
| `--name` \<string>       | Name for the net device. Auto-generated if empty.                                                                                           |
| `--netmask` \<uint8>     | Netmask length in bits.                                                                                                                     |
| `--rdma-off`             | Device will not be used for RDMA transfers.                                                                                                 |
| `--rdma-only`            | Device is used for RDMA transfers only, not for normal cluster traffic.                                                                     |

#### weka cluster container net remove

Remove a network device from a container.

This command is deprecated. Use 'weka local resources net remove' instead.

```sh
weka cluster container net remove <container-id> <name>
```

| Parameter        | Description                           |
| ---------------- | ------------------------------------- |
| `container-id`\* | Container ID.                         |
| `name`\*         | Name of the network device to remove. |

### weka cluster container non-datapath-cores

Set CPU cores reserved for non-datapath (management) operations. Only supported when cgroups are disabled (None groups mode). Pass no core IDs to clear the list.

```sh
weka cluster container non-datapath-cores <container-id> [--core-ids <uints>…]
```

| Parameter              | Description                                                                                                                       |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*       | Container ID.                                                                                                                     |
| `--core-ids` \<uints>… | CPU core IDs to reserve for non-datapath use. Multiple values may be supplied separated by commas, or the option may be repeated. |

### weka cluster container remove

Remove a container from the cluster.

```sh
weka cluster container remove <container> [--no-unimprint] [--no-wait]
```

| Parameter        | Description                                                               |
| ---------------- | ------------------------------------------------------------------------- |
| `container`\*    | ID of the container to remove.                                            |
| `--no-unimprint` | Remove the container from the cluster without remotely unimprinting it.   |
| `--no-wait`      | Return immediately without waiting for the container removal to complete. |

### weka cluster container requested-action

Set the requested action of the supplied containers to one of: STOP, RESTART, APPLY\_RESOURCES to gracefully stop, restart or apply resources to the containers.

```sh
weka cluster container requested-action <action> <container-id>…
```

| Parameter         | Description                                     |
| ----------------- | ----------------------------------------------- |
| `action`\*        | Action to request.                              |
| `container-id`\*… | IDs of the containers to request the action on. |

### weka cluster container resources

Get the container resources.

```sh
weka cluster container resources <container> [--stable]
```

| Parameter     | Description                               |
| ------------- | ----------------------------------------- |
| `container`\* | Container ID.                             |
| `--stable`    | Show stable resources instead of staging. |

### weka cluster container restore

Apply the last known good stable resources of the supplied containers, or all containers.

```sh
weka cluster container restore [<container-id>…] [--all]
```

| Parameter       | Description                                                                                                                                 |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`… | Container IDs to restore.                                                                                                                   |
| `--all`         | Apply the changes on all containers in the cluster. This will cause all backend containers in the entire cluster to restart simultaneously. |

## weka cluster default-net

List the default data networking configuration.

```sh
weka cluster default-net
```

**Columns:** `range`, `available_ips`, `gateway`, `netmask`

### weka cluster default-net reset

Reset the default data networking configuration.

```sh
weka cluster default-net reset
```

### weka cluster default-net set

Set the default data networking configuration.

```sh
weka cluster default-net set [--gateway <ip>] [--netmask <uint8>] [--range <ip-range>]
```

| Parameter             | Description                     |
| --------------------- | ------------------------------- |
| `--gateway` \<ip>     | Default gateway IP address.     |
| `--netmask` \<uint8>  | Netmask length in bits.         |
| `--range` \<ip-range> | IP addresses in format IP1-IP2. |

### weka cluster default-net update

Update the default data networking configuration.

```sh
weka cluster default-net update [--gateway <ip>] [--netmask <uint8>] [--range <ip-range>]
```

| Parameter             | Description                     |
| --------------------- | ------------------------------- |
| `--gateway` \<ip>     | Default gateway IP address.     |
| `--netmask` \<uint8>  | Netmask length in bits.         |
| `--range` \<ip-range> | IP addresses in format IP1-IP2. |

## weka cluster drive

List the cluster's drives.

```sh
weka cluster drive [<drive>…] [--container <container-ids>…] [--show-removed]
```

| Parameter                       | Description                                                                                                                                                                 |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `drive`…                        | Drive IDs or UUIDs to list. If no ID is specified, all drives are listed.                                                                                                   |
| `--container` \<container-ids>… | Only return the drives of these container IDs. If not specified, all drives are listed. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--show-removed`                | Show drives that were removed from the cluster.                                                                                                                             |

**Columns:** `uid`, `id`, `uuid`, `container`, `hostname`, `process`, `path`, `size`, `status`, `should_be_active`, `stime`, `fdName`, `fdId`, `writable`, `used`, `nvkvused`, `nvkvregions`, `attachment`, `vendor`, `firmware`, `serial_number`, `model`, `added`, `removed`, `block`, `remain`, `threshold`, `drive_status_message`, `pool`, `pci_vid`, `pci_id`, `pci_ssvid`, `pci_ssid`, `location`, `needs_phase_out`, `hard_deactivate`, `needs_phase_out_reason`, `auto_ejection_failure`, `auto_ejection_failure_code`, `auto_ejection_failure_time`, `failed_report_count`, `failed_reporters`

### weka cluster drive activate

Activate the supplied drives, or all drives if none are specified.

```sh
weka cluster drive activate [<drive>…]
```

| Parameter | Description                                                                              |
| --------- | ---------------------------------------------------------------------------------------- |
| `drive`…  | Drive IDs or UUIDs to activate. If not specified, all inactive drives will be activated. |

### weka cluster drive add

Add the given drive.

```sh
weka cluster drive add <container> <device-paths>… [--allow-format-non-wekafs-drives] [--force] [--pool <drive-pool>]
```

| Parameter                          | Description                                                                                                  |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `container`\*                      | ID of the container where the drive is attached.                                                             |
| `device-paths`\*…                  | Device paths or UUIDs of the drive(s) to add. A proxy-physical UUID adds all of its matching virtual drives. |
| `--allow-format-non-wekafs-drives` | Allow reuse of drives formatted by other software.                                                           |
| `--force`                          | Force formatting for WEKA. Bypasses all safety checks; use with caution.                                     |
| `--pool` \<drive-pool>             | Disk pool for the drive. Affects how blocks from the drive are used.                                         |

**Columns:** `dev_file`, `dev_uuid`, `size`, `iu_size`

### weka cluster drive deactivate

Deactivate the specified drive(s) from the cluster.

```sh
weka cluster drive deactivate <drive>… [--allow-reduced-resilience-to <uint>] [--force] [--hard] [--skip-resource-validation]
```

| Parameter                               | Description                                                                                                                                  |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `drive`\*…                              | Drive IDs or UUIDs to deactivate.                                                                                                            |
| `--allow-reduced-resilience-to` \<uint> | Minimum resilience level permitted after deactivation (0 = no minimum). Omitting this flag uses the cluster's configured minimum resilience. |
| `-f`, `--force`                         | Force action. Perform this action without further confirmation.                                                                              |
| `--hard`                                | Remove drive without phasing out first. May affect data redundancy or availability; only use at the direction of WEKA Customer Success.      |
| `--skip-resource-validation`            | Skip verification that configured hot spare capacity will remain available after deactivating drives.                                        |

### weka cluster drive identify

Illuminate the identification LED on a drive.

```sh
weka cluster drive identify <drive> <state>
```

| Parameter | Description                            |
| --------- | -------------------------------------- |
| `drive`\* | Drive ID or UUID to identify.          |
| `state`\* | State of the identify LED (on or off). |

### weka cluster drive remove

Remove the specified drive(s) from the cluster.

```sh
weka cluster drive remove <drive>… [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `drive`\*…      | Drive IDs or UUIDs to remove.                                   |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka cluster drive scan

Scan for provisioned drives on the cluster's containers.

```sh
weka cluster drive scan [<container>…]
```

| Parameter    | Description                                                                             |
| ------------ | --------------------------------------------------------------------------------------- |
| `container`… | Container IDs to scan for drives. If none are supplied, all containers will be scanned. |

## weka cluster failure-domain

List the cluster failure domains.

```sh
weka cluster failure-domain [--show-removed]
```

| Parameter        | Description                                     |
| ---------------- | ----------------------------------------------- |
| `--show-removed` | Show drives that were removed from the cluster. |

**Columns:** `uid`, `id`, `fd`, `active_drives`, `failed_drives`, `total_drives`, `removed_drives`, `containers`, `total_containers`, `drive_proces`, `total_drive_proces`, `compute_proces`, `total_compute_proces`, `capacity`

## weka cluster hot-spare

Get or set the number of hot-spare failure-domains in the cluster. If no count is given, the current number of hot-spare failure-domains will be shown.

```sh
weka cluster hot-spare [<count>] [--skip-resource-validation]
```

| Parameter                    | Description                                                                                  |
| ---------------------------- | -------------------------------------------------------------------------------------------- |
| `count`                      | Number of hot-spare failure-domains to configure.                                            |
| `--skip-resource-validation` | Do not verify that the cluster has enough RAM and SSD resources allocated for the hot-spare. |

## weka cluster license

Report the current license status, resource consumption in the cluster, and whether your current license is valid.

```sh
weka cluster license
```

### weka cluster license reset

Remove existing license information, returning the cluster to an unlicensed mode.

```sh
weka cluster license reset
```

### weka cluster license set

Set the cluster license.

```sh
weka cluster license set <license>
```

| Parameter   | Description             |
| ----------- | ----------------------- |
| `license`\* | License key to install. |

## weka cluster mount-defaults

Manage default mount options.

```sh
weka cluster mount-defaults
```

### weka cluster mount-defaults reset

Reset default mount options.

```sh
weka cluster mount-defaults reset [--qos-max-ops] [--qos-max-throughput] [--qos-preferred-throughput]
```

| Parameter                    | Description                                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------------- |
| `--qos-max-ops`              | Reset limit of number of operations of any kind for the client.                             |
| `--qos-max-throughput`       | Reset the maximum throughput allowed for the client for either receive or transmit traffic. |
| `--qos-preferred-throughput` | Reset throughput that gets preferred state (NORMAL instead of LOW) in QoS.                  |

### weka cluster mount-defaults set

Set default mount options.

```sh
weka cluster mount-defaults set [--qos-max-ops <uint>] [--qos-max-throughput <capacity>] [--qos-preferred-throughput <capacity>]
```

| Parameter                                | Description                                                                          |
| ---------------------------------------- | ------------------------------------------------------------------------------------ |
| `--qos-max-ops` \<uint>                  | Limits the number of operations of any kind for the client.                          |
| `--qos-max-throughput` \<capacity>       | Limits the throughput allowed for the client for either receive or transmit traffic. |
| `--qos-preferred-throughput` \<capacity> | Throughput that gets preferred state (NORMAL instead of LOW) in QoS.                 |

### weka cluster mount-defaults show

View default mount options.

```sh
weka cluster mount-defaults show
```

**Columns:** `qos_max_throughput`, `qos_preferred_throughput`, `qos_max_ops`, `qos_max_user_ops`

## weka cluster network-space

List the cluster's network spaces. Optionally filter by tenant.

```sh
weka cluster network-space [--tenant <string>]
```

| Parameter            | Description                  |
| -------------------- | ---------------------------- |
| `--tenant` \<string> | Filter by tenant name or ID. |

**Columns:** `nid`, `name`, `tenant`, `ip_range`, `fip_range`, `vlan`, `gateway`, `netmask_bits`, `rdma_state`

### weka cluster network-space add

Add a new network space and corresponding VLAN and IP pool for backend cluster use.

```sh
weka cluster network-space add <name> --range <ip-range> --vlan <uint16> [--fip-range <ip-range>] [--gateway <ip>] [--netmask <uint8>] [--wait]
```

| Parameter                 | Description                                                                  |
| ------------------------- | ---------------------------------------------------------------------------- |
| `name`\*                  | Network space name.                                                          |
| `--range` \<ip-range>\*   | IP addresses in format IP1-IP2.                                              |
| `--vlan` \<uint16>\*      | VLAN ID (1..4094).                                                           |
| `--fip-range` \<ip-range> | Floating IP address range for NFS multi-tenant assignment (format IP1-IP2).  |
| `--gateway` \<ip>         | Default gateway IP address for the network space.                            |
| `--netmask` \<uint8>      | Subnet mask length in bits.                                                  |
| `--wait`                  | Block until every backend applies and verifies the network space, then exit. |

**Columns:** `nid`, `name`, `tenant`, `ip_range`, `fip_range`, `vlan`, `gateway`, `netmask_bits`, `rdma_state`

### weka cluster network-space proxy

Show per-node proxy state for a network space.

```sh
weka cluster network-space proxy [--id <netspace-id>] [--name <string>] [--node <process-id>]
```

| Parameter              | Description                                 |
| ---------------------- | ------------------------------------------- |
| `--id` \<netspace-id>  | Network space ID.                           |
| `--name` \<string>     | Network space name.                         |
| `--node` \<process-id> | Limit output to a specific process/node ID. |

**Columns:** `owner_node`, `netspace_ip`, `container_name`, `port`, `proxy_ip`, `num_static_flows`, `num_dynamic_flows`

#### weka cluster network-space proxy show

Show per-node proxy state (proxy IP, port, static/dynamic flow counts) for a network space.

```sh
weka cluster network-space proxy show [--id <netspace-id>] [--name <string>] [--node <process-id>]
```

| Parameter              | Description                                 |
| ---------------------- | ------------------------------------------- |
| `--id` \<netspace-id>  | Network space ID.                           |
| `--name` \<string>     | Network space name.                         |
| `--node` \<process-id> | Limit output to a specific process/node ID. |

**Columns:** `owner_node`, `netspace_ip`, `container_name`, `port`, `proxy_ip`, `num_static_flows`, `num_dynamic_flows`

#### weka cluster network-space proxy subnet

Show the cluster's proxy base subnet.

```sh
weka cluster network-space proxy subnet
```

**weka cluster network-space proxy subnet set**

Set the proxy base subnet. Must be an IPv4 /16 base ending in .0.0. No container may be joined to any network space at the time of the change. Existing network-space definitions are preserved; their proxy IPs are recomputed from the new base when containers next join.

```sh
weka cluster network-space proxy subnet set <subnet>
```

| Parameter  | Description                                           |
| ---------- | ----------------------------------------------------- |
| `subnet`\* | Proxy base subnet (e.g. 198.18.0.0 or 198.18.0.0/16). |

**weka cluster network-space proxy subnet show**

Show the cluster's proxy base subnet.

```sh
weka cluster network-space proxy subnet show
```

### weka cluster network-space remove

Remove a network space from the cluster.

```sh
weka cluster network-space remove <name> [--force] [--wait]
```

| Parameter       | Description                                                                  |
| --------------- | ---------------------------------------------------------------------------- |
| `name`\*        | Network space name.                                                          |
| `-f`, `--force` | Force operation even when clients are present.                               |
| `--wait`        | Block until every backend applies and verifies the network space, then exit. |

### weka cluster network-space show-usage

Show which containers are using IPs from a specific network space. Defaults to backend containers only; use --include-clients to also show mounted clients.

```sh
weka cluster network-space show-usage [--backends] [--clients] [--id <netspace-id>] [--include-clients] [--name <string>]
```

| Parameter             | Description                                                                       |
| --------------------- | --------------------------------------------------------------------------------- |
| `-b`, `--backends`    | Only return backend containers.                                                   |
| `-c`, `--clients`     | Only return client containers.                                                    |
| `--id` \<netspace-id> | Network space ID.                                                                 |
| `--include-clients`   | Also show client containers mounted on this network space, in a separate section. |
| `--name` \<string>    | Network space name.                                                               |

**Columns:** `container_id`, `ip`, `netspace_ip_idx`, `mode`, `containerName`, `hostname`, `device`, `networkLabel`, `proxy_nodes`

### weka cluster network-space update

Update an existing network space's IP pool and VLAN configuration.

```sh
weka cluster network-space update <netspace> [--fip-range <ip-range>] [--force] [--gateway <ip>] [--name <string>] [--netmask <uint8>] [--range <ip-range>] [--vlan <uint16>] [--wait]
```

| Parameter                 | Description                                                                  |
| ------------------------- | ---------------------------------------------------------------------------- |
| `netspace`\*              | Network space name or ID.                                                    |
| `--fip-range` \<ip-range> | Floating IP address range for NFS multi-tenant assignment (format IP1-IP2).  |
| `-f`, `--force`           | Force operation even when clients are present.                               |
| `--gateway` \<ip>         | Default gateway IP address for the network space.                            |
| `--name` \<string>        | New name for the network space.                                              |
| `--netmask` \<uint8>      | Subnet mask length in bits.                                                  |
| `--range` \<ip-range>     | IP addresses in format IP1-IP2.                                              |
| `--vlan` \<uint16>        | VLAN ID (1..4094).                                                           |
| `--wait`                  | Block until every backend applies and verifies the network space, then exit. |

## weka cluster peer

List cluster peers configuration and status.

```sh
weka cluster peer [--name <cluster-peer>]
```

| Parameter                | Description                  |
| ------------------------ | ---------------------------- |
| `--name` \<cluster-peer> | Filter by cluster peer name. |

**Columns:** `id`, `uid`, `name`, `peer_guid`, `obs_bucket_id`, `num_buckets`, `task_ids`, `connection`, `pairing`, `join_ips`, `http_port`

### weka cluster peer add

Register a remote peer cluster for cross-cluster replication. Paste the token from the peer's 'weka cluster peer init' output as the second argument. Optional flags override individual fields from the decoded token.

```sh
weka cluster peer add <name> [<token>] [--dry-run] [--guid <uuid>] [--http-port <port>] [--join-ips <ip>…] [--obs-bucket <object-store>] [--s3-bucket <bucket>] [--s3-hostname <hostname>] [--s3-port <port>]
```

| Parameter                      | Description                                                                                                                                              |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                       | Name for the peer cluster.                                                                                                                               |
| `token`                        | Pairing token from the peer's 'weka cluster peer init' output.                                                                                           |
| `--dry-run`                    | Only test the command, don't affect the system.                                                                                                          |
| `--guid` \<uuid>               | Override the peer GUID from the token.                                                                                                                   |
| `--http-port` \<port>          | Override the peer's management HTTP port from the token.                                                                                                 |
| `--join-ips` \<ip>…            | Override the peer's management IPs (comma-separated) from the token. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--obs-bucket` \<object-store> | Local object-store bucket to create on this cluster for communication with the peer (default: \<peer-name>-obs).                                         |
| `--s3-bucket` \<bucket>        | Override the peer's S3 bucket name from the token.                                                                                                       |
| `--s3-hostname` \<hostname>    | Override the peer's S3 hostname from the token.                                                                                                          |
| `--s3-port` \<port>            | Override the peer's S3 port from the token.                                                                                                              |

### weka cluster peer init

Provision (or re-emit) this cluster's cross-cluster replication endpoint. Prints the connection details and a pairing token the peer admin feeds into 'weka cluster peer add' on the other side. Re-running on an already-initialized cluster is safe. Use --reinit to rotate credentials.

```sh
weka cluster peer init [--all-servers] [--config-fs-name <filesystem>] [--container <container-ids>…] [--force] [--fs-group <filesystem-group>] [--obs-fs <filesystem>] [--obs-hostname <hostname>] [--reinit]
```

| Parameter                        | Description                                                                                                                                                                                                               |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--all-servers`                  | All backend servers will form an S3 cluster and will be used for replication via the S3 protocol. Mutually exclusive with --container.                                                                                    |
| `--config-fs-name` \<filesystem> | Filesystem holding cluster-wide protocol configuration (default: the cluster's existing config filesystem; required only if the cluster has none yet).                                                                    |
| `--container` \<container-ids>…  | These containers will form an S3 cluster and will be used for replication via the S3 protocol. Mutually exclusive with --all-servers. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-f`, `--force`                  | Force action. Perform this action without further confirmation.                                                                                                                                                           |
| `--fs-group` \<filesystem-group> | Filesystem group for the replication OBS filesystem (default: the cluster's default group). Only meaningful on first-time provisioning.                                                                                   |
| `--obs-fs` \<filesystem>         | Filesystem name for the OBS used by replication (default: weka-repl-fs). Only meaningful on first-time provisioning; ignored on subsequent runs.                                                                          |
| `--obs-hostname` \<hostname>     | S3 endpoint advertised to the peer (default: an S3-serving host's IP; pass a DNS name for failover).                                                                                                                      |
| `--reinit`                       | Rotate this cluster's S3 credentials. All existing peer relationships that reference this cluster become invalid and must be re-paired. Requires interactive confirmation.                                                |

### weka cluster peer remove

Remove an existing cluster peer. Specify the peer by name (positional), by --guid, or by --peer-id; exactly one selector must be supplied.

```sh
weka cluster peer remove [<name>] [--force] [--guid <uuid>] [--peer-id <cluster-peer-id>]
```

| Parameter                      | Description                                                                                                                                                                                                         |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`                         | Name of the cluster peer to remove.                                                                                                                                                                                 |
| `-f`, `--force`                | Remove the peer even if it still holds a replica received from it (teardown/escape hatch, e.g. the source cluster is gone). Still refused while a replication task is actively running or a pair targets this peer. |
| `--guid` \<uuid>               | GUID of the peer cluster to remove.                                                                                                                                                                                 |
| `--peer-id` \<cluster-peer-id> | Local cluster-peer ID of the peer to remove.                                                                                                                                                                        |

### weka cluster peer update

Update the configuration of a cluster peer.

```sh
weka cluster peer update <name> [--dry-run] [--guid <uuid>] [--http-port <port>] [--join-ips <ip>…] [--new-name <cluster-peer>] [--obs-bucket <object-store>] [--peer-public-key <public-key>]
```

| Parameter                         | Description                                                                                                                             |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                          | Name of the cluster peer to update.                                                                                                     |
| `--dry-run`                       | Only test the command, don't affect the system.                                                                                         |
| `--guid` \<uuid>                  | New GUID of the peer cluster.                                                                                                           |
| `--http-port` \<port>             | Override management HTTP port.                                                                                                          |
| `--join-ips` \<ip>…               | Replace the peer's reachable IPs (comma-separated). Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--new-name` \<cluster-peer>      | New name for the cluster peer.                                                                                                          |
| `--obs-bucket` \<object-store>    | New Object Store bucket for communication with the peer cluster.                                                                        |
| `--peer-public-key` \<public-key> | New peer public inter-cluster key.                                                                                                      |

## weka cluster process

List the cluster processes.

```sh
weka cluster process [<process-ids>…] [--backends] [--clients] [--container <container-ids>…] [--council] [--hostnames <strings>…] [--leader] [--leadership] [--local] [--role <process-roles>…]
```

| Parameter                       | Description                                                                                                                                                                                        |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `process-ids`…                  | Only return these process IDs.                                                                                                                                                                     |
| `-b`, `--backends`              | Only return processes on backend containers.                                                                                                                                                       |
| `-c`, `--clients`               | Only return processes on client containers.                                                                                                                                                        |
| `--container` \<container-ids>… | Only return processes located on these containers. If not specified, processes for all hosts will be returned. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--council`                     | Get result from cluster leadership members.                                                                                                                                                        |
| `--hostnames` \<strings>…       | Only return processes on these hostnames. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                      |
| `-L`, `--leader`                | Only return the cluster leader.                                                                                                                                                                    |
| `-l`, `--leadership`            | Only return processes that are part of the cluster leadership.                                                                                                                                     |
| `--local`                       | Get result from local weka host instead of leader.                                                                                                                                                 |
| `--role` \<process-roles>…      | Only return processes with these roles. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                        |

**Columns:** `uid`, `process`, `containerId`, `slot`, `hostname`, `container`, `ips`, `status`, `software`, `release`, `role`, `mode`, `netmode`, `configuredNet`, `leadership`, `cpuId`, `core`, `socket`, `numa`, `cpuModel`, `memory`, `uptime`, `fdName`, `fdId`, `traceHistory`, `fencingReason`, `joinRejectReason`, `failureText`, `failure`, `failureTime`, `failureCode`, `recentFailure`, `deniedReason`, `deniedTime`

## weka cluster server

Manage physical (or in some cases virtual) servers.

```sh
weka cluster server [--roles <machine-roles>…]
```

| Parameter                   | Description                                                                                                               |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `--roles` \<machine-roles>… | Only return servers with these roles. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `hostname`, `uid`, `ip`, `port`, `roles`, `status`, `up_since`, `uptime`, `cores`, `memory`, `drives`, `processes`, `load`, `versions`, `architecture`, `ready_for_maintenance`, `requested_action`

### weka cluster server list

List the cluster servers.

```sh
weka cluster server list [--roles <machine-roles>…]
```

| Parameter                   | Description                                                                                                               |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `--roles` \<machine-roles>… | Only return servers with these roles. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `hostname`, `uid`, `ip`, `port`, `roles`, `status`, `up_since`, `uptime`, `cores`, `memory`, `drives`, `processes`, `load`, `versions`, `architecture`, `ready_for_maintenance`, `requested_action`

### weka cluster server requested-action

Set the requested action for all backend containers on the supplied servers to gracefully stop, restart, or apply container resources.

```sh
weka cluster server requested-action <action> <servers>… [--timeout <duration>]
```

| Parameter               | Description                                                         |
| ----------------------- | ------------------------------------------------------------------- |
| `action`\*              | Action to request on all backend containers.                        |
| `servers`\*…            | Server(s) to request action on — specify by server UID or hostname. |
| `--timeout` \<duration> | Timeout for the action to be applied.                               |

### weka cluster server show

Show details for one cluster server.

```sh
weka cluster server show <machine-uid> [--show-all] [--show-containers] [--show-drives] [--show-networks] [--show-processes]
```

| Parameter           | Description                                                 |
| ------------------- | ----------------------------------------------------------- |
| `machine-uid`\*     | Machine UID to display.                                     |
| `--show-all`        | Include containers, processes, drives, and network devices. |
| `--show-containers` | Show container details.                                     |
| `--show-drives`     | Show drive details.                                         |
| `--show-networks`   | Show network device details.                                |
| `--show-processes`  | Show process details.                                       |

## weka cluster start-io

Start the cluster IO service.

```sh
weka cluster start-io [--force]
```

| Parameter       | Description                                                                                                                            |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `-f`, `--force` | Do not prompt before starting I/O for the first time. The prompt is only shown for interactive use; non-interactive use never prompts. |

## weka cluster status

Show overall status of the Weka cluster.

```sh
weka cluster status [--detailed-capacity]
```

| Parameter             | Description                                        |
| --------------------- | -------------------------------------------------- |
| `--detailed-capacity` | Include capacity details including data reduction. |

### weka cluster status meta

Show metadata about the API service.

```sh
weka cluster status meta
```

**Columns:** `api_major_version`, `api_minor_version`, `build`, `legal`, `banner`, `multi_org`, `stem_mode`, `git_version`

### weka cluster status rebuild

Show the cluster phasing in/out progress, and protection per fault-level.

```sh
weka cluster status rebuild
```

### weka cluster status reduction

Show cluster data reduction information.

```sh
weka cluster status reduction
```

**Columns:** `ReductionRatio`, `SavedBytes.Value`

## weka cluster stop-io

Stop I/O service for the cluster.

```sh
weka cluster stop-io [--brutal-no-flush] [--force] [--keep-external-containers]
```

| Parameter                    | Description                                                                                                                                                                        |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--brutal-no-flush`          | Stop I/O services immediately without graceful flushing of ongoing operations. Using this flag may cause data-loss if used without explicit guidance from WekaIO customer support. |
| `-f`, `--force`              | Force action. Perform this action without further confirmation.                                                                                                                    |
| `--keep-external-containers` | Keep external containers such as S3, SMB, and NFS running.                                                                                                                         |

## weka cluster task

List background tasks running in the cluster.

```sh
weka cluster task [--show-catalog] [--show-waiting]
```

| Parameter        | Description                          |
| ---------------- | ------------------------------------ |
| `--show-catalog` | Include catalog tasks in the output. |
| `--show-waiting` | Include waiting tasks in the output. |

**Columns:** `uid`, `id`, `type`, `state`, `state_plain`, `phase`, `phase_name`, `phase_number`, `phase_count`, `progress_percent`, `normalized_progress_percent`, `paused`, `desc`, `time`, `throttle`

### weka cluster task abort

Abort a background task.

```sh
weka cluster task abort <task-id>
```

| Parameter   | Description    |
| ----------- | -------------- |
| `task-id`\* | Task to abort. |

### weka cluster task bucket

List the status of a background task on specific buckets.

```sh
weka cluster task bucket [--bucket <bucket-ids>…] [--task <task-ids>…]
```

| Parameter                       | Description                                                                                                           |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `-b`, `--bucket` \<bucket-ids>… | Only return these bucket IDs. Multiple values may be supplied separated by commas, or the option may be repeated.     |
| `--task` \<task-ids>…           | Only return tasks with these IDs. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `bucket`, `task`, `type`, `phase`, `progress_percent`, `last_progress`, `stuck`, `paused_at_generation`

### weka cluster task limits

Show the current limits for background tasks.

```sh
weka cluster task limits
```

#### weka cluster task limits set

Set the current limits for background tasks.

```sh
weka cluster task limits set --cpu-limit <float>
```

| Parameter                | Description                                                   |
| ------------------------ | ------------------------------------------------------------- |
| `--cpu-limit` \<float>\* | Percent of the CPU resources to dedicate to background tasks. |

### weka cluster task pause

Pause a currently running background task.

```sh
weka cluster task pause <task-id>
```

| Parameter   | Description    |
| ----------- | -------------- |
| `task-id`\* | Task to pause. |

### weka cluster task resume

Resume a currently paused background task.

```sh
weka cluster task resume <task-id>
```

| Parameter   | Description     |
| ----------- | --------------- |
| `task-id`\* | Task to resume. |

### weka cluster task throttle

Slow down the rate of progress of a currently running background task.

```sh
weka cluster task throttle <task-id> [--throttle <float>]
```

| Parameter             | Description                            |
| --------------------- | -------------------------------------- |
| `task-id`\*           | Task to throttle.                      |
| `--throttle` \<float> | Percent by which to throttle the task. |

## weka cluster update

Update cluster configuration.

```sh
weka cluster update [--bucket-raft-size <uint8>] [--cluster-name <string>] [--data-drives <uint8>] [--hot-spare-failure-domains <uint16>] [--parity-drives <uint8>] [--scrubber-bytes-per-sec <bytes>]
```

| Parameter                               | Description                              |
| --------------------------------------- | ---------------------------------------- |
| `--bucket-raft-size` \<uint8>           | Number of members in bucket raft.        |
| `--cluster-name` \<string>              | Cluster name.                            |
| `--data-drives` \<uint8>                | Number of RAID data drives.              |
| `--hot-spare-failure-domains` \<uint16> | Number of hot spare failure domains.     |
| `--parity-drives` \<uint8>              | Number of RAID protection parity drives. |
| `--scrubber-bytes-per-sec` \<bytes>     | Rate of RAID scrubbing per second.       |
