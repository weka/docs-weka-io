# weka local

Control local Weka resources and containers.

```sh
weka local
```

## weka local diags

Collect diagnostics from the local machine.

```sh
weka local diags
```

## weka local disable

Disable local container(s) from starting at boot.

```sh
weka local disable [<container>…] [--type <strings>…]
```

| Parameter                  | Description                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `container`…               | Container name(s).                                                                                                   |
| `-t`, `--type` \<strings>… | Container type(s) to operate on. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka local drive

Display and manage local drives.

```sh
weka local drive
```

### weka local drive identify

Illuminate the identification LED on a local drive by its serial number.

```sh
weka local drive identify <serial> <state>
```

| Parameter  | Description                            |
| ---------- | -------------------------------------- |
| `serial`\* | Serial number of the drive.            |
| `state`\*  | State of the identify LED (on or off). |

### weka local drive list

List the drives on the local machine as reported by the hardware monitor.

```sh
weka local drive list
```

**Columns:** `name`, `serial`, `capacity`, `status`, `manufacturer`, `model`, `location`, `refresh`, `component`

## weka local enable

Enable local container(s) to start at boot.

```sh
weka local enable [<container>…] [--type <strings>…]
```

| Parameter                  | Description                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `container`…               | Container name(s).                                                                                                   |
| `-t`, `--type` \<strings>… | Container type(s) to operate on. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka local events

List local events. Does not require authentication and can be used when Weka is not running.

```sh
weka local events
```

## weka local exec

Run a process inside a running container.

```sh
weka local exec
```

## weka local monitoring

Turn monitoring on/off for the given containers, or all containers if none are specified. When a container is started, it's always monitored. When a container is monitored, it will be restarted if it exits without being stopped through the CLI.

```sh
weka local monitoring <enabled> [<container>…] [--type <strings>…]
```

| Parameter                  | Description                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `enabled`\*                | Whether monitoring should be on or off.                                                                              |
| `container`…               | Container name(s).                                                                                                   |
| `-t`, `--type` \<strings>… | Container type(s) to operate on. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka local ps

List the Weka containers running on the local machine.

```sh
weka local ps
```

**Columns:** `name`, `containerId`, `state`, `running`, `disabled`, `uptime`, `ioProcessesNotUp`, `monitoring`, `persistent`, `port`, `hasLease`, `pid`, `status`, `managementIps`, `version`, `lastFailureText`, `lastFailure`, `lastFailureTime`, `recentFailure`, `upgradeState`, `type`

## weka local reset-data

Reset the data directory for a given container, making the container no longer aware of the cluster.

```sh
weka local reset-data [<version-name>…] [--clean-unused] [--container <string>] [--force]
```

| Parameter                     | Description                                                                              |
| ----------------------------- | ---------------------------------------------------------------------------------------- |
| `version-name`…               | The versions whose data directory should be reset. Defaults to the current set version.  |
| `--clean-unused`              | Delete all container data directories for versions which aren't the current set version. |
| `-C`, `--container` \<string> | The container to reset.                                                                  |
| `-f`, `--force`               | Force action. Perform this action without further confirmation.                          |

## weka local resources

Manage the resources allocated to local containers.

```sh
weka local resources [--container <container>] [--stable]
```

| Parameter                        | Description                                                                        |
| -------------------------------- | ---------------------------------------------------------------------------------- |
| `-C`, `--container` \<container> | Container name.                                                                    |
| `--stable`                       | List stable resources. Uses the resources from the last successful container boot. |

### weka local resources apply

Apply changes to the resources locally.

```sh
weka local resources apply [--container <container>] [--force] [--timeout <string>]
```

| Parameter                        | Description                                                         |
| -------------------------------- | ------------------------------------------------------------------- |
| `-C`, `--container` \<container> | Container name.                                                     |
| `-f`, `--force`                  | Force action. Perform this action without further confirmation.     |
| `--timeout` \<string>            | Maximum time for CLI to wait for resources to apply (default: 20m). |

### weka local resources auto-remove-timeout

Configure the auto-remove-timeout (in seconds) to remove inactive client containers.

```sh
weka local resources auto-remove-timeout <auto-remove-timeout> [--container <container>]
```

| Parameter                        | Description                                                              |
| -------------------------------- | ------------------------------------------------------------------------ |
| `auto-remove-timeout`\*          | The auto-remove timeout in seconds to remove inactive client containers. |
| `-C`, `--container` \<container> | Container name.                                                          |

### weka local resources bandwidth

Limit Weka's bandwidth for the container.

```sh
weka local resources bandwidth <bandwidth> [--container <container>]
```

| Parameter                        | Description                                                       |
| -------------------------------- | ----------------------------------------------------------------- |
| `bandwidth`\*                    | New bandwidth limitation per second (e.g. 1GB, 500MB, unlimited). |
| `-C`, `--container` \<container> | Container name.                                                   |

### weka local resources base-port

Change the TCP & UDP port-range used by the container. Weka containers require 100 ports to operate.

```sh
weka local resources base-port <base-port> [--container <container>]
```

| Parameter                        | Description                                                                          |
| -------------------------------- | ------------------------------------------------------------------------------------ |
| `base-port`\*                    | The first port that will be used by the Weka container, out of a total of 100 ports. |
| `-C`, `--container` \<container> | Container name.                                                                      |

### weka local resources cores

Change the core configuration for the container.

```sh
weka local resources cores <cores> [--allow-mix-setting] [--compute-dedicated-cores <int>] [--container <container>] [--core-ids <uints>…] [--drives-dedicated-cores <int>] [--frontend-dedicated-cores <int>] [--no-frontends] [--only-compute-cores] [--only-drives-cores] [--only-frontend-cores]
```

| Parameter                           | Description                                                                                                                  |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `cores`\*                           | Number of CPU cores dedicated to Weka. If set to 0, no drives can be added to this host.                                     |
| `--allow-mix-setting`               | Allow specified core-ids even if there are running containers with AUTO core-ids allocation on the same server.              |
| `--compute-dedicated-cores` \<int>  | Number of cores dedicated to Weka compute (out of the total cores).                                                          |
| `-C`, `--container` \<container>    | Container name.                                                                                                              |
| `--core-ids` \<uints>…              | Specify the IDs of Weka dedicated cores. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--drives-dedicated-cores` \<int>   | Number of cores dedicated to Weka drives (out of the total cores).                                                           |
| `--frontend-dedicated-cores` \<int> | Number of cores dedicated to Weka frontend (out of the total cores).                                                         |
| `--no-frontends`                    | Don't allocate frontend nodes.                                                                                               |
| `--only-compute-cores`              | Create only nodes with a compute role.                                                                                       |
| `--only-drives-cores`               | Create only nodes with a drives role.                                                                                        |
| `--only-frontend-cores`             | Create only nodes with a frontend role.                                                                                      |

### weka local resources dedicate

Set the host as dedicated to Weka. For example it can be rebooted whenever needed, and configured by Weka for optimal performance and stability.

```sh
weka local resources dedicate <on> [--container <container>]
```

| Parameter                        | Description                                                        |
| -------------------------------- | ------------------------------------------------------------------ |
| `on`\*                           | Set the host as Weka dedicated; off unsets host as Weka dedicated. |
| `-C`, `--container` \<container> | Container name.                                                    |

### weka local resources drive

List or specify settings for drives managed in resources.

```sh
weka local resources drive [--container <container>]
```

| Parameter                        | Description     |
| -------------------------------- | --------------- |
| `-C`, `--container` \<container> | Container name. |

#### weka local resources drive add

Add drive UUIDs that are to be exposed by the container.

```sh
weka local resources drive add [--container <container>] [--drive-uuids <strings>…]
```

| Parameter                        | Description                                                                                                                                                              |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `-C`, `--container` \<container> | Container name.                                                                                                                                                          |
| `--drive-uuids` \<strings>…      | UUIDs of signed storage drives to add to be used when the container joins a cluster. Multiple values may be supplied separated by commas, or the option may be repeated. |

#### weka local resources drive remove

Remove drive UUIDs that are to be exposed by the container.

```sh
weka local resources drive remove [--container <container>] [--drive-uuids <strings>…]
```

| Parameter                        | Description                                                                                                                                                                         |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-C`, `--container` \<container> | Container name.                                                                                                                                                                     |
| `--drive-uuids` \<strings>…      | UUIDs of signed storage drives to remove from consideration when the container joins a cluster. Multiple values may be supplied separated by commas, or the option may be repeated. |

#### weka local resources drive scan

Enable or disable drive scanning on container start.

```sh
weka local resources drive scan <scan-drives> [--container <container>]
```

| Parameter                        | Description                                |
| -------------------------------- | ------------------------------------------ |
| `scan-drives`\*                  | Scan for signed drives on container start. |
| `-C`, `--container` \<container> | Container name.                            |

### weka local resources export

Export resources to file. By default, exports target resources unless --staging or --stable is specified.

```sh
weka local resources export <path> [--container <container>] [--stable] [--staging]
```

| Parameter                        | Description                                                                     |
| -------------------------------- | ------------------------------------------------------------------------------- |
| `path`\*                         | Path to export resources.                                                       |
| `-C`, `--container` \<container> | Container name.                                                                 |
| `--stable`                       | Export the currently stable resources, which are the last known good resources. |
| `--staging`                      | Export the currently staged resources that were not yet applied.                |

### weka local resources failure-domain

Set the container failure-domain.

```sh
weka local resources failure-domain [--container <container>] [--name <string>] [--scope <string>]
```

| Parameter                        | Description                                                                                                                                                                                                  |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `-C`, `--container` \<container> | Container name.                                                                                                                                                                                              |
| `--name` \<string>               | Add this host to a named failure-domain. A failure-domain will be created if it doesn't exist yet.                                                                                                           |
| `--scope` \<string>              | Automatic failure domain scope: 'server' (each server is its own FD), 'rack' (switch discovery via LLDP or InfiniBand SMP), or 'chassis' (SMBIOS chassis serial, for multi-node enclosures such as BigTwin). |

### weka local resources fqdn

Configure the FQDN to be used by other containers for TLS hostname verification when interacting with the cluster.

```sh
weka local resources fqdn <fqdn> [--container <container>]
```

| Parameter                        | Description                                                                                                                            |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `fqdn`\*                         | The Fully Qualified Domain Name (FQDN) to be used by other containers for TLS hostname verification when interacting with the cluster. |
| `-C`, `--container` \<container> | Container name.                                                                                                                        |

### weka local resources hardware-monitor

Configure monitoring of hardware via BMC.

```sh
weka local resources hardware-monitor [--bmc-password <string>] [--bmc-url <string>] [--bmc-username <string>] [--container <container>] [--disable] [--enable]
```

| Parameter                        | Description                                                                        |
| -------------------------------- | ---------------------------------------------------------------------------------- |
| `--bmc-password` \<string>       | The password to use to connect to the BMC. Use 'default' to use the default value. |
| `--bmc-url` \<string>            | The hostname or IP address of the BMC. Use 'default' to use the default value.     |
| `--bmc-username` \<string>       | The username to use to connect to the BMC. Use 'default' to use the default value. |
| `-C`, `--container` \<container> | Container name.                                                                    |
| `--disable`                      | Disable hardware monitoring.                                                       |
| `--enable`                       | Enable hardware monitoring.                                                        |

### weka local resources import

Import resources from file.

```sh
weka local resources import <path> [--container <container>] [--force] [--with-identifiers]
```

| Parameter                        | Description                                                     |
| -------------------------------- | --------------------------------------------------------------- |
| `path`\*                         | Path of file to import resources from.                          |
| `-C`, `--container` \<container> | Container name.                                                 |
| `-f`, `--force`                  | Force action. Perform this action without further confirmation. |
| `--with-identifiers`             | Import net device unique identifiers.                           |

### weka local resources join-ips

Set the join IPs for a container. A cluster requires at least 5 backend hosts, and all containers should use the same set of join IPs. Not every host IP needs to be listed, but at least 5 are recommended.

```sh
weka local resources join-ips <management-ips>… [--container <container>] [--join-fqdns <strings>…] [--restricted]
```

| Parameter                        | Description                                                                                                                                                                                      |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `management-ips`\*…              | New IP:port pairs for the management processes. If no port is used the command will use the default Weka port.                                                                                   |
| `-C`, `--container` \<container> | Container name.                                                                                                                                                                                  |
| `--join-fqdns` \<strings>…       | FQDN:port pairs for the management processes. If no port is used the command will use the default Weka port. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--restricted`                   | Join using restricted client port.                                                                                                                                                               |

### weka local resources join-secret

Configure the secret used when joining a cluster as a backend.

```sh
weka local resources join-secret <secret> [--container <container>] [--purge]
```

| Parameter                        | Description                  |
| -------------------------------- | ---------------------------- |
| `secret`\*                       | Cluster join secret.         |
| `-C`, `--container` \<container> | Container name.              |
| `--purge`                        | Purge previous join secrets. |

### weka local resources management-ips

Set the container's management IPs. Setting 2 IPs will enable highly-available networking mode.

```sh
weka local resources management-ips <management-ips>… [--container <container>]
```

| Parameter                        | Description                       |
| -------------------------------- | --------------------------------- |
| `management-ips`\*…              | New IPs for the management nodes. |
| `-C`, `--container` \<container> | Container name.                   |

### weka local resources management-nets

Set the host's management network interfaces used to auto detect the management IPs.

```sh
weka local resources management-nets <network-interfaces>… [--container <container>]
```

| Parameter                        | Description                                                |
| -------------------------------- | ---------------------------------------------------------- |
| `network-interfaces`\*…          | Network interfaces used to auto detect the management IPs. |
| `-C`, `--container` \<container> | Container name.                                            |

### weka local resources memory

Set the memory used by this container.

```sh
weka local resources memory <memory> [--container <container>]
```

| Parameter                        | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
| `memory`\*                       | Memory dedicated to Weka in bytes, set to 0 to let the system decide. |
| `-C`, `--container` \<container> | Container name.                                                       |

### weka local resources net

Configure or display the networking resources used by this container.

```sh
weka local resources net [--container <container>] [--rdma] [--stable]
```

| Parameter                        | Description                                                 |
| -------------------------------- | ----------------------------------------------------------- |
| `-C`, `--container` \<container> | Container name.                                             |
| `--rdma`                         | Include RDMA devices in the resources list.                 |
| `--stable`                       | List the resources from the last successful container boot. |

#### weka local resources net add

Allocate a dedicated networking device on a host (to the cluster).

```sh
weka local resources net add <device> [--auto-label] [--container <container>] [--gateway <string>] [--inet6] [--ips <ip-addrs>…] [--label <string>] [--name <string>] [--netmask <int>] [--rdma-off] [--rdma-only] [--vfs <int>] [--vlan <int>]
```

| Parameter                        | Description                                                                                                                        |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `device`\*                       | Network device PCI-slot/MAC-address/interface-name.                                                                                |
| `--auto-label`                   | Derive the label automatically from LLDP (Ethernet) or InfiniBand SMP discovery on this device. Mutually exclusive with --label.   |
| `-C`, `--container` \<container> | Container name.                                                                                                                    |
| `--gateway` \<string>            | Default gateway IP.                                                                                                                |
| `--inet6`                        | Use IPv6 for RoCE v2 RDMA. The default is IPv4.                                                                                    |
| `--ips` \<ip-addrs>…             | IPs to be allocated to cores using the device. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--label` \<string>              | The name of the switch or network group to which this network device is attached.                                                  |
| `--name` \<string>               | If empty, a name will be auto generated.                                                                                           |
| `--netmask` \<int>               | Netmask in bits number.                                                                                                            |
| `--rdma-off`                     | The device will not be used for RDMA data transfers.                                                                               |
| `--rdma-only`                    | The device will be explicitly configured for RDMA.                                                                                 |
| `--vfs` \<int>                   | The number of VFs to preallocate (default is all supported by NIC).                                                                |
| `--vlan` \<int>                  | The VLAN to use (802.1Q, Ethernet only, 1-4094).                                                                                   |

#### weka local resources net remove

Undedicate a networking device in a host.

```sh
weka local resources net remove <name> [--container <container>]
```

| Parameter                        | Description                                                             |
| -------------------------------- | ----------------------------------------------------------------------- |
| `name`\*                         | Net device name or identifier as appears in 'weka local resources net'. |
| `-C`, `--container` \<container> | Container name.                                                         |

### weka local resources non-datapath-cores

Set the list of CPU cores reserved for non-datapath operations (e.g. management tasks). Pass no core IDs to clear the list.

```sh
weka local resources non-datapath-cores [<core-ids>…] [--container <container>]
```

| Parameter                        | Description                           |
| -------------------------------- | ------------------------------------- |
| `core-ids`…                      | CPU core IDs to mark as non-datapath. |
| `-C`, `--container` \<container> | Container name.                       |

### weka local resources restore

Restore resources from stable resources.

```sh
weka local resources restore [--container <container>]
```

| Parameter                        | Description     |
| -------------------------------- | --------------- |
| `-C`, `--container` \<container> | Container name. |

## weka local restart

Restart a Weka container.

```sh
weka local restart [<container>…] [--dont-restart-dependent-containers] [--force] [--timeout <string>] [--type <strings>…] [--wait-time <string>]
```

| Parameter                             | Description                                                                                                          |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `container`…                          | Container name(s).                                                                                                   |
| `--dont-restart-dependent-containers` | Do not restart dependent containers.                                                                                 |
| `-f`, `--force`                       | Force the operation.                                                                                                 |
| `--timeout` \<string>                 | Maximum time for CLI to wait for restart operation to complete.                                                      |
| `-t`, `--type` \<strings>…            | Container type(s) to operate on. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-w`, `--wait-time` \<string>         | How long to wait for the container to start.                                                                         |

## weka local rm

Delete a Weka container from the local machine.

```sh
weka local rm [<containers>…] [--all] [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `containers`…   | Container name(s).                                              |
| `--all`         | Remove all containers.                                          |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## weka local run

Run a process inside a temporary container.

```sh
weka local run
```

## weka local setup

Setup local containers.

```sh
weka local setup
```

### weka local setup client

Setup a persistent Weka client container.

```sh
weka local setup client [--allow-mix-setting] [--auto-remove-timeout <uint>] [--bandwidth <float>] [--base-port <uint16>] [--container-id <uint16>] [--core-ids <ints>…] [--cores <uint>] [--dedicate] [--dedicated-mode <string>] [--disable] [--disable-nvidia-vf-single-ip] [--failure-domain <string>] [--force] [--fqdn <string>] [--ignore-used-ports] [--join-fqdns <strings>…] [--join-ips <strings>…] [--management-ips <strings>…] [--management-net <string>] [--memory <capacity>] [--name <string>] [--net <strings>…] [--no-start] [--resources-path <string>] [--restricted] [--scan-rdma <string>] [--skip-management-ips-check] [--timeout <string>] [--weka-version <string>]
```

| Parameter                       | Description                                                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `--allow-mix-setting`           | Allow specified core IDs even if there are running containers with auto core ID allocation.                                          |
| `--auto-remove-timeout` \<uint> | Timeout (in seconds) to remove inactive client containers.                                                                           |
| `--bandwidth` \<float>          | Bandwidth limitation in Mbps.                                                                                                        |
| `--base-port` \<uint16>         | First port used by the container.                                                                                                    |
| `--container-id` \<uint16>      | Designate a container ID to use when joining the cluster.                                                                            |
| `--core-ids` \<ints>…           | Specific CPU core IDs to use. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--cores` \<uint>               | Number of CPU cores to allocate.                                                                                                     |
| `--dedicate`                    | Set the host as Weka-dedicated.                                                                                                      |
| `--dedicated-mode` \<string>    | DPDK networking dedication mode.                                                                                                     |
| `--disable`                     | Create the container as disabled.                                                                                                    |
| `--disable-nvidia-vf-single-ip` | Disable single-IP mode for Nvidia VFs (single IP is the default).                                                                    |
| `--failure-domain` \<string>    | Named failure domain for this container.                                                                                             |
| `--force`                       | Force creation even if a container already exists.                                                                                   |
| `--fqdn` \<string>              | FQDN for TLS verification.                                                                                                           |
| `--ignore-used-ports`           | Allow container to start even if required ports are used by other processes.                                                         |
| `--join-fqdns` \<strings>…      | FQDN:port pairs of management processes to join. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--join-ips` \<strings>…        | IP:port pairs of management processes to join. Multiple values may be supplied separated by commas, or the option may be repeated.   |
| `--management-ips` \<strings>…  | IPs for management nodes. Multiple values may be supplied separated by commas, or the option may be repeated.                        |
| `--management-net` \<string>    | Auto-configure management network IPs.                                                                                               |
| `--memory` \<capacity>          | Memory dedicated to Weka, set to 0 to let the system decide.                                                                         |
| `-n`, `--name` \<string>        | Container name.                                                                                                                      |
| `--net` \<strings>…             | Network device specification. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--no-start`                    | Do not start the container after setup.                                                                                              |
| `--resources-path` \<string>    | Import the container's resources from a file (other flags override values from the file).                                            |
| `--restricted`                  | Restricted client mode functionality only.                                                                                           |
| `--scan-rdma` \<string>         | Scan for RDMA devices.                                                                                                               |
| `--skip-management-ips-check`   | Skip enforcement of management IPs.                                                                                                  |
| `-t`, `--timeout` \<string>     | Timeout for join operation.                                                                                                          |
| `--weka-version` \<string>      | Weka version to use for this container.                                                                                              |

### weka local setup compute

Setup a container with only compute-role cores.

```sh
weka local setup compute [--allow-mix-setting] [--bandwidth <float>] [--base-port <uint16>] [--container-id <uint16>] [--core-ids <ints>…] [--cores <uint>] [--dedicate] [--dedicated-mode <string>] [--disable] [--disable-nvidia-vf-single-ip] [--failure-domain <string>] [--force] [--fqdn <string>] [--ignore-used-ports] [--join-fqdns <strings>…] [--join-ips <strings>…] [--management-ips <strings>…] [--management-net <string>] [--memory <capacity>] [--name <string>] [--net <strings>…] [--no-start] [--resources-path <string>] [--scan-rdma <string>] [--skip-management-ips-check] [--timeout <string>] [--weka-version <string>]
```

| Parameter                       | Description                                                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `--allow-mix-setting`           | Allow specified core IDs even if there are running containers with auto core ID allocation.                                          |
| `--bandwidth` \<float>          | Bandwidth limitation in Mbps.                                                                                                        |
| `--base-port` \<uint16>         | First port used by the container.                                                                                                    |
| `--container-id` \<uint16>      | Designate a container ID to use when joining the cluster.                                                                            |
| `--core-ids` \<ints>…           | Specific CPU core IDs to use. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--cores` \<uint>               | Number of CPU cores to allocate.                                                                                                     |
| `--dedicate`                    | Set the host as Weka-dedicated.                                                                                                      |
| `--dedicated-mode` \<string>    | DPDK networking dedication mode.                                                                                                     |
| `--disable`                     | Create the container as disabled.                                                                                                    |
| `--disable-nvidia-vf-single-ip` | Disable single-IP mode for Nvidia VFs (single IP is the default).                                                                    |
| `--failure-domain` \<string>    | Named failure domain for this container.                                                                                             |
| `--force`                       | Force creation even if a container already exists.                                                                                   |
| `--fqdn` \<string>              | FQDN for TLS verification.                                                                                                           |
| `--ignore-used-ports`           | Allow container to start even if required ports are used by other processes.                                                         |
| `--join-fqdns` \<strings>…      | FQDN:port pairs of management processes to join. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--join-ips` \<strings>…        | IP:port pairs of management processes to join. Multiple values may be supplied separated by commas, or the option may be repeated.   |
| `--management-ips` \<strings>…  | IPs for management nodes. Multiple values may be supplied separated by commas, or the option may be repeated.                        |
| `--management-net` \<string>    | Auto-configure management network IPs.                                                                                               |
| `--memory` \<capacity>          | Memory dedicated to Weka, set to 0 to let the system decide.                                                                         |
| `-n`, `--name` \<string>        | Container name.                                                                                                                      |
| `--net` \<strings>…             | Network device specification. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--no-start`                    | Do not start the container after setup.                                                                                              |
| `--resources-path` \<string>    | Import the container's resources from a file (other flags override values from the file).                                            |
| `--scan-rdma` \<string>         | Scan for RDMA devices.                                                                                                               |
| `--skip-management-ips-check`   | Skip enforcement of management IPs.                                                                                                  |
| `-t`, `--timeout` \<string>     | Timeout for join operation.                                                                                                          |
| `--weka-version` \<string>      | Weka version to use for this container.                                                                                              |

### weka local setup container

Setup a local weka container with the full set of container options.

```sh
weka local setup container
```

### weka local setup drives

Setup a container with only drives-role cores.

```sh
weka local setup drives [--allow-mix-setting] [--bandwidth <float>] [--base-port <uint16>] [--clusterize] [--container-id <uint16>] [--core-ids <ints>…] [--cores <uint>] [--dedicate] [--dedicated-mode <string>] [--disable] [--disable-nvidia-vf-single-ip] [--drive-uuids <strings>…] [--failure-domain <string>] [--force] [--fqdn <string>] [--ignore-used-ports] [--join-fqdns <strings>…] [--join-ips <strings>…] [--management-ips <strings>…] [--management-net <string>] [--memory <capacity>] [--name <string>] [--net <strings>…] [--no-start] [--resources-path <string>] [--scan-drives] [--scan-rdma <string>] [--skip-management-ips-check] [--timeout <string>] [--weka-version <string>]
```

| Parameter                       | Description                                                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `--allow-mix-setting`           | Allow specified core IDs even if there are running containers with auto core ID allocation.                                          |
| `--bandwidth` \<float>          | Bandwidth limitation in Mbps.                                                                                                        |
| `--base-port` \<uint16>         | First port used by the container.                                                                                                    |
| `--clusterize`                  | Form a cluster with the supplied join IPs.                                                                                           |
| `--container-id` \<uint16>      | Designate a container ID to use when joining the cluster.                                                                            |
| `--core-ids` \<ints>…           | Specific CPU core IDs to use. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--cores` \<uint>               | Number of CPU cores to allocate.                                                                                                     |
| `--dedicate`                    | Set the host as Weka-dedicated.                                                                                                      |
| `--dedicated-mode` \<string>    | DPDK networking dedication mode.                                                                                                     |
| `--disable`                     | Create the container as disabled.                                                                                                    |
| `--disable-nvidia-vf-single-ip` | Disable single-IP mode for Nvidia VFs (single IP is the default).                                                                    |
| `--drive-uuids` \<strings>…     | Storage drive UUIDs for joining. Multiple values may be supplied separated by commas, or the option may be repeated.                 |
| `--failure-domain` \<string>    | Named failure domain for this container.                                                                                             |
| `--force`                       | Force creation even if a container already exists.                                                                                   |
| `--fqdn` \<string>              | FQDN for TLS verification.                                                                                                           |
| `--ignore-used-ports`           | Allow container to start even if required ports are used by other processes.                                                         |
| `--join-fqdns` \<strings>…      | FQDN:port pairs of management processes to join. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--join-ips` \<strings>…        | IP:port pairs of management processes to join. Multiple values may be supplied separated by commas, or the option may be repeated.   |
| `--management-ips` \<strings>…  | IPs for management nodes. Multiple values may be supplied separated by commas, or the option may be repeated.                        |
| `--management-net` \<string>    | Auto-configure management network IPs.                                                                                               |
| `--memory` \<capacity>          | Memory dedicated to Weka, set to 0 to let the system decide.                                                                         |
| `-n`, `--name` \<string>        | Container name.                                                                                                                      |
| `--net` \<strings>…             | Network device specification. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--no-start`                    | Do not start the container after setup.                                                                                              |
| `--resources-path` \<string>    | Import the container's resources from a file (other flags override values from the file).                                            |
| `--scan-drives`                 | Scan for signed drives on container start.                                                                                           |
| `--scan-rdma` \<string>         | Scan for RDMA devices.                                                                                                               |
| `--skip-management-ips-check`   | Skip enforcement of management IPs.                                                                                                  |
| `-t`, `--timeout` \<string>     | Timeout for join operation.                                                                                                          |
| `--weka-version` \<string>      | Weka version to use for this container.                                                                                              |

### weka local setup envoy

Setup a local envoy container.

```sh
weka local setup envoy [--disable] [--name <string>] [--no-start]
```

| Parameter                | Description                             |
| ------------------------ | --------------------------------------- |
| `--disable`              | Create the container as disabled.       |
| `-n`, `--name` \<string> | Container name.                         |
| `--no-start`             | Do not start the container after setup. |

### weka local setup ssdproxy

Setup a local SSD Proxy container.

```sh
weka local setup ssdproxy [--base-port <uint16>] [--disable] [--enable-ssdproxy-nginx] [--expected-max-drive-size <capacity>] [--expected-max-vid-num-per-drive <uint8>] [--max-drives <uint8>] [--memory <capacity>] [--name <string>] [--no-start]
```

| Parameter                                   | Description                                                                                                    |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `--base-port` \<uint16>                     | First port used by the SSD Proxy container.                                                                    |
| `--disable`                                 | Create the container as disabled.                                                                              |
| `--enable-ssdproxy-nginx`                   | Enable the nginx server for the SSD Proxy viewer.                                                              |
| `--expected-max-drive-size` \<capacity>     | Expected maximum drive size, used for chunkdb memory sizing; ignored when --memory is set.                     |
| `--expected-max-vid-num-per-drive` \<uint8> | Expected maximum number of VIDs per drive, used for DPDK memory sizing.                                        |
| `--max-drives` \<uint8>                     | Maximum number of drives supported by the proxy.                                                               |
| `--memory` \<capacity>                      | Memory dedicated to the SSD Proxy; overrides auto-calculation from --max-drives and --expected-max-drive-size. |
| `-n`, `--name` \<string>                    | Container name.                                                                                                |
| `--no-start`                                | Do not start the container after setup.                                                                        |

### weka local setup taskmon

Setup a local taskmon container.

```sh
weka local setup taskmon [--disable] [--no-start]
```

| Parameter    | Description                             |
| ------------ | --------------------------------------- |
| `--disable`  | Create the container as disabled.       |
| `--no-start` | Do not start the container after setup. |

### weka local setup telemetry

Setup a local telemetry container.

```sh
weka local setup telemetry [--dependent-container-name <string>] [--disable] [--no-start]
```

| Parameter                              | Description                                                    |
| -------------------------------------- | -------------------------------------------------------------- |
| `--dependent-container-name` \<string> | Name of the container that the telemetry container depends on. |
| `--disable`                            | Create the container as disabled.                              |
| `--no-start`                           | Do not start the container after setup.                        |

## weka local start

Start local container(s).

```sh
weka local start [<container>…] [--skip-start-and-enable-dependent] [--type <strings>…] [--wait-time <string>]
```

| Parameter                           | Description                                                                                                          |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `container`…                        | Container name(s).                                                                                                   |
| `--skip-start-and-enable-dependent` | Skip starting and enabling dependent containers.                                                                     |
| `-t`, `--type` \<strings>…          | Container type(s) to operate on. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-w`, `--wait-time` \<string>       | How long to wait for the container to start.                                                                         |

## weka local status

Show the status of a local Weka container.

```sh
weka local status [--type <string>]
```

| Parameter          | Description                        |
| ------------------ | ---------------------------------- |
| `--type` \<string> | Container type to show status for. |

## weka local stop

Stop local container(s).

```sh
weka local stop [<container>…] [--force] [--reason <string>] [--timeout <string>] [--type <strings>…]
```

| Parameter                  | Description                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `container`…               | Container name(s).                                                                                                   |
| `-f`, `--force`            | Force the operation.                                                                                                 |
| `--reason` \<string>       | The reason weka was stopped.                                                                                         |
| `--timeout` \<string>      | Timeout for the stop operation (e.g. 60s, 1m).                                                                       |
| `-t`, `--type` \<strings>… | Container type(s) to operate on. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka local upgrade

Upgrade a Weka container to its cluster version.

```sh
weka local upgrade
```
