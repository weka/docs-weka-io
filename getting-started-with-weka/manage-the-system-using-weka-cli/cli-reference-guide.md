---
description: >-
  This CLI reference guide is generated from the output of running the weka
  command with the help option. It provides detailed descriptions of available
  commands, arguments, and options.
---

# CLI reference guide

## weka

The base command for all weka related CLIs

```sh
weka [--help] [--build] [--version] [--legal]

```

| Parameter         | Description                                   |
| ----------------- | --------------------------------------------- |
| `--agent`         | Start the agent service                       |
| `-h`, `--help`    | Show help message                             |
| `--build`         | Prints the CLI build number and exits         |
| `-v`, `--version` | Prints the CLI version and exits              |
| `--legal`         | Prints software license information and exits |

### weka agent

Commands that control the weka agent (outside the weka containers)

```sh
weka agent [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka agent install-agent

Installs Weka agent on the machine the command is executed from

```sh
weka agent install-agent [--no-update] [--help]

```

| Parameter      | Description                                   |
| -------------- | --------------------------------------------- |
| `--no-update`  | Don't update the locally installed containers |
| `-h`, `--help` | Show help message                             |

#### weka agent update-containers

Update the currently available containers and version specs to the current agent version. This command does not update weka, only the container's representation on the local machine.

```sh
weka agent update-containers [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka agent supported-specs

List the Weka spec versions that are supported by this agent version

```sh
weka agent supported-specs [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka agent uninstall

Deletes all Weka files, drivers, shared memory and any other remainder from the machine this command is executed from. WARNING - This action is destructive and might cause a loss of data!

```sh
weka agent uninstall [--force] [--ignore-wekafs-mounts] [--keep-files] [--help]

```

| Parameter                | Description                                                          |
| ------------------------ | -------------------------------------------------------------------- |
| `--force`                | Force the action to actually happen                                  |
| `--ignore-wekafs-mounts` | Proceed even with active wekafs mounts                               |
| `--keep-files`           | Do not remove Weka version images and keep in installation directory |
| `-h`, `--help`           | Show help message                                                    |

#### weka agent autocomplete

Bash autocompletion utilities

```sh
weka agent autocomplete [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka agent autocomplete install**

Locally install bash autocompletion utility

```sh
weka agent autocomplete install [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka agent autocomplete uninstall**

Locally uninstall bash autocompletion utility

```sh
weka agent autocomplete uninstall [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka agent autocomplete export**

Export bash autocompletion script

```sh
weka agent autocomplete export [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

### weka alerts

List alerts in the Weka cluster

```sh
weka alerts [--HOST HOST]
            [--PORT PORT]
            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
            [--TIMEOUT TIMEOUT]
            [--profile profile]
            [--format format]
            [--output output]...
            [--sort sort]...
            [--filter filter]...
            [--muted]
            [--help]
            [--no-header]
            [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: muted,type,count,title,description,action                                                                            |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `--muted`                 | List muted alerts alongside the unmuted ones                                                                                                                                            |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka alerts types

List all alert types that can be returned from the Weka cluster

```sh
weka alerts types [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--help]
                  [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka alerts mute

Mute an alert-type. Muted alerts will not be prompted when listing active alerts. Alerts cannot be suppressed indefinitely, so a duration must be supplied. Once the supplied duration has passed, the alert-type would be automatically unmuted

```sh
weka alerts mute <alert-type>
                 <duration>
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `alert-type`\*            | An alert-type to mute, use `weka alerts types` to list types                                               |
| `duration`\*              | How long to mute this alert type for (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka alerts unmute

Unmute an alert-type which was previously muted.

```sh
weka alerts unmute <alert-type>
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `alert-type`\*            | An alert-type to unmute, use `weka alerts types` to list types                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka alerts describe

Describe all the alert types that might be returned from the weka cluster (including explanations and how to handle them)

```sh
weka alerts describe [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--format format]
                     [--output output]...
                     [--sort sort]...
                     [--filter filter]...
                     [--help]
                     [--no-header]
                     [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: type,title,action                                                                                                    |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

### weka cloud

Cloud commands. List the cluster's cloud status, if no subcommand supplied.

```sh
weka cloud [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka cloud status

Show cloud connectivity status

```sh
weka cloud status [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--format format]
                  [--output output]...
                  [--sort sort]...
                  [--filter filter]...
                  [--help]
                  [--no-header]
                  [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: host,health                                                                                                          |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka cloud enable

Turn cloud features on

```sh
weka cloud enable [--cloud-url cloud]
                  [--cloud-stats on/off]
                  [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--cloud-url`             | The base url of the cloud service                                                                          |
| `--cloud-stats`           | Enable or disable uploading stats to the cloud (format: 'on' or 'off')                                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cloud disable

Turn cloud features off

```sh
weka cloud disable [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cloud proxy

Get or set the HTTP proxy used to connect to cloud services

```sh
weka cloud proxy [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--set url]
                 [--help]
                 [--json]
                 [--unset]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-s`, `--set`             | Set a new proxy setting                                                                                    |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |
| `-u`, `--unset`           | Remove the HTTP proxy setting                                                                              |

#### weka cloud update

Update cloud settings

```sh
weka cloud update <bucket-name>
                  <region>
                  <access-key-id>
                  <secret-key>
                  [--session-token token]
                  [--bucket-prefix prefix]
                  [--proxy proxy]
                  [--bytes-per-second bytes-per-second]
                  [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*           | AWS bucket name                                                                                            |
| `region`\*                | AWS region                                                                                                 |
| `access-key-id`\*         | AWS access key                                                                                             |
| `secret-key`\*            | AWS secret                                                                                                 |
| `--session-token`         | S3 session token                                                                                           |
| `--bucket-prefix`         | S3 bucket prefix                                                                                           |
| `--proxy`                 | HTTP(S) proxy to connect to the cloud through                                                              |
| `--bytes-per-second`      | Maximum uploaded bytes per second                                                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cloud upload-rate

Get the cloud upload rate

```sh
weka cloud upload-rate [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--help]
                       [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka cloud upload-rate set**

Set the cloud upload rate

```sh
weka cloud upload-rate set [--bytes-per-second bps]
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--bytes-per-second`      | Maximum uploaded bytes per second                                                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

### weka cluster

Commands that manage the cluster

```sh
weka cluster [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka cluster create

Form a Weka cluster from hosts that just has Weka installed on them

```sh
weka cluster create [--admin-password admin-password]
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--host-ips host-ips]...
                    [--help]
                    [--json]
                    [<host-hostnames>]...

```

| Parameter                 | Description                                                                                                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `host-hostnames`...       | A list of hostname to be included in the new cluster                                                                                       |
| `--admin-password`        | The password for the cluster admin user; will be set to the default password if not provided                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                 |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                     |
| `--profile`               | Name of the connection and authentication profile to use                                                                                   |
| `--host-ips`...           | Management IP addresses; If empty, the hostnames will be resolved; If hosts are highly-available or mixed-networking, use IP set '++...+'; |
| `-h`, `--help`            | Show help message                                                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                                                      |

#### weka cluster update

Update cluster configuration

```sh
weka cluster update [--cluster-name cluster-name]
                    [--data-drives data-drives]
                    [--parity-drives parity-drives]
                    [--scrubber-bytes-per-sec scrubber-bytes-per-sec]
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--help]

```

| Parameter                  | Description                                                                                                                                                    |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--cluster-name`           | Cluster name                                                                                                                                                   |
| `--data-drives`            | Number of RAID data drives                                                                                                                                     |
| `--parity-drives`          | Number of RAID protection parity drives                                                                                                                        |
| `--scrubber-bytes-per-sec` | Rate of RAID scrubbing in units per second (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-H`, `--HOST`             | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                               |
| `-P`, `--PORT`             | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                               |
| `-C`, `--CONNECT-TIMEOUT`  | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                     |
| `-T`, `--TIMEOUT`          | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                         |
| `--profile`                | Name of the connection and authentication profile to use                                                                                                       |
| `-h`, `--help`             | Show help message                                                                                                                                              |

#### weka cluster process

List the cluster processes

```sh
weka cluster process [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--format format]
                     [--container container]...
                     [--output output]...
                     [--sort sort]...
                     [--filter filter]...
                     [--backends]
                     [--clients]
                     [--leadership]
                     [--leader]
                     [--help]
                     [--raw-units]
                     [--UTC]
                     [--no-header]
                     [--verbose]
                     [<process-ids>]...

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `process-ids`...          | Only return these processes IDs.                                                                                                                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                        |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                      |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                      |
| `--container`...          | Only return the processes of these container IDs, if not specified the weka-processes for all the containers will be returned                                                                                                                                                                                 |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,containerId,slot,hostname,container,ips,status,software,release,role,mode,netmode,cpuId,core,socket,numa,cpuModel,memory,uptime,fdName,fdId,traceHistory,fencingReason,joinRejectReason,failureText,failure,failureTime,failureCode |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                       |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                              |
| `-b`, `--backends`        | Only return backend containers                                                                                                                                                                                                                                                                                |
| `-c`, `--clients`         | Only return client containers                                                                                                                                                                                                                                                                                 |
| `-l`, `--leadership`      | Only return containers that are part of the cluster leadership                                                                                                                                                                                                                                                |
| `-L`, `--leader`          | Only return the cluster leader                                                                                                                                                                                                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                             |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                         |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                            |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                                    |

#### weka cluster bucket

List the cluster buckets, logical compute units used to divide the workload in the cluster

```sh
weka cluster bucket [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--format format]
                    [--output output]...
                    [--sort sort]...
                    [--filter filter]...
                    [--help]
                    [--raw-units]
                    [--UTC]
                    [--no-header]
                    [--verbose]
                    [<bucket-ids>]...

```

| Parameter                 | Description                                                                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bucket-ids`...           | Only return these bucket IDs.                                                                                                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                        |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                      |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                      |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: id,leader,term,lastActiveTerm,state,council,uptime,leaderVersionSig,electableMode,sourceMembers,nonSourceMembers,fillLevel |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+       |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                              |
| `-h`, `--help`            | Show help message                                                                                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                             |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                         |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                            |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                    |

#### weka cluster failure-domain

List the Weka cluster failure domains

```sh
weka cluster failure-domain [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--format format]
                            [--output output]...
                            [--sort sort]...
                            [--filter filter]...
                            [--show-removed]
                            [--help]
                            [--raw-units]
                            [--UTC]
                            [--no-header]
                            [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                      |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                      |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                            |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                              |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                              |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,fd,active\_drives,failed\_drives,total\_drives,removed\_drives,containers,total\_containers,drive\_proces,total\_drive\_proces,compute\_proces,total\_compute\_proces,capacity |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                               |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                      |
| `--show-removed`          | Show drives that were removed from the cluster                                                                                                                                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                     |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                     |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                 |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                    |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                            |

#### weka cluster hot-spare

Get or set the number of hot-spare failure-domains in the cluster. If param is not given, the current number of hot-spare FDs will be listed

```sh
weka cluster hot-spare [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--skip-resource-validation]
                       [--help]
                       [--json]
                       [--raw-units]
                       [--UTC]
                       [<count>]...

```

| Parameter                    | Description                                                                                                                       |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `count`...                   | The number of failure-domains                                                                                                     |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`                  | Name of the connection and authentication profile to use                                                                          |
| `--skip-resource-validation` | Skip verifying that the cluster has enough RAM and SSD resources allocated for the hot-spare                                      |
| `-h`, `--help`               | Show help message                                                                                                                 |
| `-J`, `--json`               | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`          | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`                | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

#### weka cluster start-io

Start IO services

```sh
weka cluster start-io [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cluster stop-io

Stop IO services

```sh
weka cluster stop-io [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--brutal-no-flush]
                     [--keep-external-containers]
                     [--force]
                     [--help]

```

| Parameter                    | Description                                                                                                                                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                            |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                            |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                      |
| `--profile`                  | Name of the connection and authentication profile to use                                                                                                                                    |
| `--brutal-no-flush`          | Force stopping IO services immediately without graceful flushing of ongoing operations. Using this flag may cause data-loss if used without explicit guidance from WekaIO customer support. |
| `--keep-external-containers` | Keep external containers(S3, SMB, NFS) running                                                                                                                                              |
| `-f`, `--force`              | Force this action without further confirmation. This action will disrupt operation of all connected clients. To restore IO service run 'weka cluster start-io'.                             |
| `-h`, `--help`               | Show help message                                                                                                                                                                           |

#### weka cluster drive

List the cluster's drives

```sh
weka cluster drive [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--format format]
                   [--container container]...
                   [--output output]...
                   [--sort sort]...
                   [--filter filter]...
                   [--show-removed]
                   [--help]
                   [--raw-units]
                   [--UTC]
                   [--no-header]
                   [--verbose]
                   [<uuids>]...

```

| Parameter                 | Description                                                                                                                                                                                                                                                     |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `uuids`...                | A list of drive IDs or UUIDs to list. If no ID is specified, all drives are listed.                                                                                                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                      |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                          |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                        |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                        |
| `--container`...          | Only return the drives of these container IDs, if not specified, all drives are listed                                                                                                                                                                          |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,uuid,host,hostname,node,path,size,status,stime,fdName,fdId,writable,used,nvkvused,attachment,vendor,firmware,serial,model,added,removed,block,remain,threshold,drive\_status\_message |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                         |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                |
| `--show-removed`          | Show drives that were removed from the cluster                                                                                                                                                                                                                  |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                               |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                               |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                           |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                              |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                      |

**weka cluster drive scan**

Scan for provisioned drives on the cluster's containers

```sh
weka cluster drive scan [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--raw-units]
                        [--UTC]
                        [<container-ids>]...

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `container-ids`...        | A list of container ids to scan for drives                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster drive activate**

Activate the supplied drive, or all drives (if none supplied)

```sh
weka cluster drive activate [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]
                            [--raw-units]
                            [--UTC]
                            [<uuids>]...

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `uuids`...                | A list of drive IDs or UUIDs to activate. If no ID is supplied, all inactive drives will be activated.                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster drive deactivate**

Deactivate the supplied drive(s)

```sh
weka cluster drive deactivate [--HOST HOST]
                              [--PORT PORT]
                              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                              [--TIMEOUT TIMEOUT]
                              [--profile profile]
                              [--skip-resource-validation]
                              [--force]
                              [--help]
                              [<uuids>]...

```

| Parameter                    | Description                                                                                                        |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `uuids`...                   | A list of drive IDs or UUIDs to deactivate.                                                                        |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                   |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                   |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)         |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)             |
| `--profile`                  | Name of the connection and authentication profile to use                                                           |
| `--skip-resource-validation` | Skip verifying that the configured hot spare capacity will remain available after deactivating the drives          |
| `-f`, `--force`              | Force this action without further confirmation. This action may impact performance while the drive is phasing out. |
| `-h`, `--help`               | Show help message                                                                                                  |

**weka cluster drive add**

Add the given drive

```sh
weka cluster drive add <container-id>
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--format format]
                       [--output output]...
                       [--sort sort]...
                       [--filter filter]...
                       [--force]
                       [--allow-format-non-wekafs-drives]
                       [--help]
                       [--raw-units]
                       [--UTC]
                       [--no-header]
                       [--verbose]
                       [<device-paths>]...

```

| Parameter                          | Description                                                                                                                                                                             |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*                   | The container the drive attached to (given by ids)                                                                                                                                      |
| `device-paths`...                  | Device paths of the drives to add                                                                                                                                                       |
| `-H`, `--HOST`                     | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`                     | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT`          | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`                  | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`                        | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`                   | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...                | Specify which columns to output. May include any of the following: path,uuid                                                                                                            |
| `-s`, `--sort`...                  | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...                | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `--force`                          | Force formatting the drive for weka, avoiding all safety checks!                                                                                                                        |
| `--allow-format-non-wekafs-drives` | Allow reuse of drives formatted by another versions                                                                                                                                     |
| `-h`, `--help`                     | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`                | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`                      | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`                      | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`                  | Show all columns in output                                                                                                                                                              |

**weka cluster drive remove**

Remove the supplied drive(s)

```sh
weka cluster drive remove [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--force]
                          [--help]
                          [<uuids>]...

```

| Parameter                 | Description                                                                                                                                    |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `uuids`...                | A list of drive UUIDs to remove. A UUID is a hex string formatted as 8-4-4-4-12 e.g. 'abcdef12-1234-abcd-1234-1234567890ab'                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                               |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                               |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                     |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                         |
| `--profile`               | Name of the connection and authentication profile to use                                                                                       |
| `-f`, `--force`           | Force this action without further confirmation. To undo the removal, add the drive back and re-scan the drives on the host local to the drive. |
| `-h`, `--help`            | Show help message                                                                                                                              |

#### weka cluster mount-defaults

Commands for editing default mount options

```sh
weka cluster mount-defaults [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka cluster mount-defaults set**

Set default mount options.

```sh
weka cluster mount-defaults set [--qos-max-throughput qos-max-throughput]
                                [--qos-preferred-throughput qos-preferred-throughput]
                                [--qos-max-ops qos-max-ops]
                                [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]

```

| Parameter                    | Description                                                                                                 |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `--qos-max-throughput`       | qos-max-throughput is the maximum throughput allowed for the client for either receive or transmit traffic. |
| `--qos-preferred-throughput` | qos-preferred-throughput is the throughput that gets preferred state (NORMAL instead of LOW) in QoS.        |
| `--qos-max-ops`              | qos-max-ops is the maximum number of operations of any kind for the client                                  |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                            |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                            |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)  |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)      |
| `--profile`                  | Name of the connection and authentication profile to use                                                    |
| `-h`, `--help`               | Show help message                                                                                           |

**weka cluster mount-defaults show**

View default mount options

```sh
weka cluster mount-defaults show [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--json]
                                 [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-J`, `--json`            | Format output as JSON                                                                                      |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster mount-defaults reset**

Reset default mount options

```sh
weka cluster mount-defaults reset [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--qos-max-throughput]
                                  [--qos-preferred-throughput]
                                  [--qos-max-ops]
                                  [--help]

```

| Parameter                    | Description                                                                                                 |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                            |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                            |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)  |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)      |
| `--profile`                  | Name of the connection and authentication profile to use                                                    |
| `--qos-max-throughput`       | qos-max-throughput is the maximum throughput allowed for the client for either receive or transmit traffic. |
| `--qos-preferred-throughput` | qos-preferred-throughput is the throughput that gets preferred state (NORMAL instead of LOW) in QoS.        |
| `--qos-max-ops`              | qos-max-ops is the maximum number of operations of any kind for the client                                  |
| `-h`, `--help`               | Show help message                                                                                           |

#### weka cluster servers

Commands for physical servers

```sh
weka cluster servers [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka cluster servers list**

List the cluster servers

```sh
weka cluster servers list [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--format format]
                          [--role role]...
                          [--output output]...
                          [--sort sort]...
                          [--filter filter]...
                          [--help]
                          [--no-header]
                          [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `--role`...               | Only list machines with specified roles. Possible roles: (format: 'backend', 'client', 'nfs', 'smb' or 's3')                                                                            |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: hostname,uid,ip,roles,status,up\_since,cores,memory,drives,nodes,load,versions                                       |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka cluster servers show**

Show a single server overview according to given server uid

```sh
weka cluster servers show <uid>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--json]
                          [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `uid`\*                   | The Server UID                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-J`, `--json`            | Format output as JSON                                                                                      |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cluster container

List the cluster containers

```sh
weka cluster container [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--format format]
                       [--output output]...
                       [--sort sort]...
                       [--filter filter]...
                       [--backends]
                       [--clients]
                       [--leadership]
                       [--leader]
                       [--help]
                       [--raw-units]
                       [--UTC]
                       [--no-header]
                       [--verbose]
                       [<container-ids>]...

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `container-ids`...        | Only return these container IDs.                                                                                                                                                                                                                                                                                                                                                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                                                                                                                                               |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                                                                                                                                               |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                                     |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                                         |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                                                                                                                                       |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                                                                                                                                       |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,hostname,container,machineIdentifier,ips,status,software,release,mode,fd,fdName,fdType,fdId,cores,feCores,driveCores,coreIds,memory,bw,scrubberLimit,dedicated,autoRemove,leadership,failureText,failure,failureTime,failureCode,uptime,added,cloudProvider,availabilityZone,instanceType,instanceId,kernelName,kernelRelease,kernelVersion,platform |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                                                                                                                                        |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                                                                                                                                               |
| `-b`, `--backends`        | Only return backend containers                                                                                                                                                                                                                                                                                                                                                                                                 |
| `-c`, `--clients`         | Only return client containers                                                                                                                                                                                                                                                                                                                                                                                                  |
| `-l`, `--leadership`      | Only return containers that are part of the cluster leadership                                                                                                                                                                                                                                                                                                                                                                 |
| `-L`, `--leader`          | Only return the cluster leader                                                                                                                                                                                                                                                                                                                                                                                                 |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                                                                                                                                              |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                                                                                                                                              |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                                                                                                                                          |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                                                                                                                                             |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                                                                                                                                                     |

**weka cluster container info-hw**

Show hardware information about one or more containers

```sh
weka cluster container info-hw [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--info-type info-type]...
                               [--help]
                               [--json]
                               [--raw-units]
                               [--UTC]
                               [<hostnames>]...

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `hostnames`...            | A list of containers to query (by hostnames or IPs). If no container is supplied, all of the cluster containers will be queried   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `--info-type`...          | Specify what information to query: version                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster container failure-domain**

Set the container failure-domain

```sh
weka cluster container failure-domain <container-id>
                                      [--name name]
                                      [--HOST HOST]
                                      [--PORT PORT]
                                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                      [--TIMEOUT TIMEOUT]
                                      [--profile profile]
                                      [--auto]
                                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                          |
| `--name`                  | Add this container to a named failure-domain. A failure-domain will be created if it doesn't exist yet.    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--auto`                  | Set this container to be a failure-domain of its own                                                       |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster container dedicate**

Set the container as dedicated to weka. For example it can be rebooted whenever needed, and configured by weka for optimal performance and stability

```sh
weka cluster container dedicate <container-id>
                                <on>
                                [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                          |
| `on`\*                    | Set the container as weka dedicated, off unsets container as weka dedicated (format: 'on' or 'off')        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster container bandwidth**

Limit weka's bandwidth for the container

```sh
weka cluster container bandwidth <container-id>
                                 <bandwidth>
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--help]

```

| Parameter                 | Description                                                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                                                                                                          |
| `bandwidth`\*             | New bandwidth limitation per second (format: either "unlimited" or bandwidth per second in binary or decimal values: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                 |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                     |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                   |
| `-h`, `--help`            | Show help message                                                                                                                                                                          |

**weka cluster container cores**

Dedicate container's cores to weka

```sh
weka cluster container cores <container-id>
                             <cores>
                             [--frontend-dedicated-cores frontend-dedicated-cores]
                             [--drives-dedicated-cores drives-dedicated-cores]
                             [--compute-dedicated-cores compute-dedicated-cores]
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--cores-ids cores-ids]...
                             [--no-frontends]
                             [--only-drives-cores]
                             [--only-compute-cores]
                             [--only-frontend-cores]
                             [--allow-mix-setting]
                             [--help]

```

| Parameter                    | Description                                                                                                       |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `container-id`\*             | Container ID as shown in `weka cluster container`                                                                 |
| `cores`\*                    | Number of CPU cores dedicated to weka - If set to 0 - no drive could be added to this container                   |
| `--frontend-dedicated-cores` | Number of cores dedicated to weka frontend (out of the total )                                                    |
| `--drives-dedicated-cores`   | Number of cores dedicated to weka drives (out of the total )                                                      |
| `--compute-dedicated-cores`  | Number of cores dedicated to weka compute (out of the total )                                                     |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                  |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                  |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)            |
| `--profile`                  | Name of the connection and authentication profile to use                                                          |
| `--cores-ids`...             | Specify the ids of weka dedicated cores.                                                                          |
| `--no-frontends`             | Do not create any processes with a frontend role                                                                  |
| `--only-drives-cores`        | Create only processes with a drives role                                                                          |
| `--only-compute-cores`       | Create only processes with a compute role                                                                         |
| `--only-frontend-cores`      | Create only processes with a frontend role                                                                        |
| `--allow-mix-setting`        | Allow specified cores-ids even if there are running containers with AUTO cores-ids allocation on the same server. |
| `-h`, `--help`               | Show help message                                                                                                 |

**weka cluster container memory**

Dedicate a set amount of RAM to weka

```sh
weka cluster container memory <container-id>
                              <memory>
                              [--HOST HOST]
                              [--PORT PORT]
                              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                              [--TIMEOUT TIMEOUT]
                              [--profile profile]
                              [--help]

```

| Parameter                 | Description                                                                                                                                                                              |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                                                                                                        |
| `memory`\*                | Memory dedicated to weka in bytes, set to 0 to let the system decide (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                 |
| `-h`, `--help`            | Show help message                                                                                                                                                                        |

**weka cluster container auto-remove-timeout**

Set how long to wait before removing this container if it disconnects from the cluster (for clients only)

```sh
weka cluster container auto-remove-timeout <container-id>
                                           <auto-remove-timeout>
                                           [--HOST HOST]
                                           [--PORT PORT]
                                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                           [--TIMEOUT TIMEOUT]
                                           [--profile profile]
                                           [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                          |
| `auto-remove-timeout`\*   | Minimum value is 60, use 0 to disable automatic removal                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster container management-ips**

Set the container's management process IPs. Setting 2 IPs will turn this containers networking into highly-available mode

```sh
weka cluster container management-ips <container-id>
                                      [--HOST HOST]
                                      [--PORT PORT]
                                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                      [--TIMEOUT TIMEOUT]
                                      [--profile profile]
                                      [--help]
                                      [<management-ips>]...

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                          |
| `management-ips`...       | New IPs for the management processes                                                                       |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster container resources**

Get the resources of the supplied container

```sh
weka cluster container resources <container-id>
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--stable]
                                 [--help]
                                 [--json]
                                 [--raw-units]
                                 [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | Container ID as shown in `weka cluster container`                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `--stable`                | List the resources from the last successfull container boot                                                                       |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster container restore**

Restore staged resources of the supplied containers, or all containers, to their stable state

```sh
weka cluster container restore [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--all]
                               [--help]
                               [<container-ids>]...

```

| Parameter                 | Description                                                                                                                                  |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-ids`...        | A list of container ids for which to apply resources config                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                             |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                             |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                   |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                       |
| `--profile`               | Name of the connection and authentication profile to use                                                                                     |
| `--all`                   | Apply resources on all the containers in the cluster. This will cause all backend containers in the entire cluter to restart simultaneously! |
| `-h`, `--help`            | Show help message                                                                                                                            |

**weka cluster container apply**

Apply the staged resources of the supplied containers, or all containers

```sh
weka cluster container apply [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--skip-resource-validation]
                             [--all]
                             [--force]
                             [--help]
                             [<container-ids>]...

```

| Parameter                    | Description                                                                                                                                  |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-ids`...           | A list of container ids for which to apply resources config                                                                                  |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                             |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                             |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                   |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                       |
| `--profile`                  | Name of the connection and authentication profile to use                                                                                     |
| `--skip-resource-validation` | Skip verifying that the cluster will still have enough RAM and SSD resources after deactivating the containers                               |
| `--all`                      | Apply resources on all the containers in the cluster. This will cause all backend containers in the entire cluter to restart simultaneously! |
| `-f`, `--force`              | Force this action without further confirmation. This action will restart the containers on the containers and cannot be undone.              |
| `-h`, `--help`               | Show help message                                                                                                                            |

**weka cluster container activate**

Activate the supplied containers, or all containers (if none supplied)

```sh
weka cluster container activate [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--no-wait]
                                [--skip-resource-validation]
                                [--skip-activate-drives]
                                [--help]
                                [<container-ids>]...

```

| Parameter                    | Description                                                                                                    |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `container-ids`...           | A list of container ids to activate                                                                            |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                               |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                               |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)         |
| `--profile`                  | Name of the connection and authentication profile to use                                                       |
| `--no-wait`                  |                                                                                                                |
| `--skip-resource-validation` | Skip verifying that the cluster will still have enough RAM and SSD resources after deactivating the containers |
| `--skip-activate-drives`     | Do not activate the drives of the container                                                                    |
| `-h`, `--help`               | Show help message                                                                                              |

**weka cluster container deactivate**

Deactivate the supplied container(s)

```sh
weka cluster container deactivate [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--no-wait]
                                  [--skip-resource-validation]
                                  [--allow-unavailable]
                                  [--help]
                                  [<container-ids>]...

```

| Parameter                    | Description                                                                                                    |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `container-ids`...           | A list of container ids to deactivate                                                                          |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                               |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                               |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)         |
| `--profile`                  | Name of the connection and authentication profile to use                                                       |
| `--no-wait`                  |                                                                                                                |
| `--skip-resource-validation` | Skip verifying that the cluster will still have enough RAM and SSD resources after deactivating the containers |
| `--allow-unavailable`        | Allow the container to be unavailable while it is deactivated which skips setting its local resources          |
| `-h`, `--help`               | Show help message                                                                                              |

**weka cluster container clear-failure**

Clear the last failure fields for all supplied containers

```sh
weka cluster container clear-failure [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--help]
                                     [<container-ids>]...

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-ids`...        | A list of container ids for which to clear the last failure                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster container add**

Add a container to the cluster

```sh
weka cluster container add <hostname>
                           [--ip ip]
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--no-wait]
                           [--help]
                           [--json]
                           [--raw-units]
                           [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `hostname`\*              | Management network hostname                                                                                                       |
| `--ip`                    | Management IP; If empty, the hostname is resolved; If container is highly-available or mixed-networking, use IP set '++...+';     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `--no-wait`               | Skip waiting for the container to be added to the cluster                                                                         |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster container remove**

Remove a container from the cluster

```sh
weka cluster container remove <container-id>
                              [--HOST HOST]
                              [--PORT PORT]
                              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                              [--TIMEOUT TIMEOUT]
                              [--profile profile]
                              [--no-wait]
                              [--no-unimprint]
                              [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | The container ID of the container to be removed                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--no-wait`               | Don't wait for the container removal to complete, return immediately                                       |
| `--no-unimprint`          | Don't remotely unimprint the container, just remove it from the cluster configuration                      |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster container factory-reset**

Factory resets the containers. NOTE! This can't be undone!

```sh
weka cluster container factory-reset <guid>
                                     [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--force]
                                     [--help]
                                     [--json]
                                     [--raw-units]
                                     [--UTC]
                                     [<container-names-or-ips>]...

```

| Parameter                   | Description                                                                                                                       |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `guid`\*                    | The cluster GUID                                                                                                                  |
| `container-names-or-ips`... | A list of containers (given by container-name or IP)                                                                              |
| `-H`, `--HOST`              | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`              | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT`   | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`           | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`                 | Name of the connection and authentication profile to use                                                                          |
| `--force`                   | When set, broute force reset                                                                                                      |
| `-h`, `--help`              | Show help message                                                                                                                 |
| `-J`, `--json`              | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`         | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`               | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster container net**

List Weka dedicated networking devices in a container

```sh
weka cluster container net [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--format format]
                           [--output output]...
                           [--sort sort]...
                           [--filter filter]...
                           [--help]
                           [--raw-units]
                           [--UTC]
                           [--no-header]
                           [--verbose]
                           [<container-ids>]...

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-ids`...        | Container IDs to get the network devices of                                                                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,name,id,host,hostname,device,ips,netmask,gateway,cores,owner,vlan,netlabel                                       |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka cluster container net add**

Allocate a dedicated networking device on a container (to the cluster).

```sh
weka cluster container net add <container-id>
                               <device>
                               [--ips-type ips-type]
                               [--gateway gateway]
                               [--netmask netmask]
                               [--name name]
                               [--label label]
                               [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--ips ips]...
                               [--help]
                               [--json]
                               [--raw-units]
                               [--UTC]

```

| Parameter                 | Description                                                                                                                                                                                                                                    |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | The container's id                                                                                                                                                                                                                             |
| `device`\*                | Network device pci-slot/mac-address/interface-name(s)                                                                                                                                                                                          |
| `--ips-type`              | IPs type: POOL: IPs from the default data networking IP pool would be used, USER: configured by the user (format: 'pool' or 'user')                                                                                                            |
| `--gateway`               | Default gateway IP. In AWS this value is auto-detected, otherwise the default data networking gateway will be used.                                                                                                                            |
| `--netmask`               | Netmask in bits number. In AWS this value is auto-detected, otherwise the default data networking netmask will be used.                                                                                                                        |
| `--name`                  | If empty, a name will be auto generated.                                                                                                                                                                                                       |
| `--label`                 | The name of the switch or network group to which this network device is attached                                                                                                                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                               |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                               |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                     |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                         |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                       |
| `--ips`...                | IPs to be allocated to cores using the device. If not given - IPs may be set automatically according the interface's IPs, or taken from the default networking IPs pool (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H) |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                              |
| `-J`, `--json`            | Format output as JSON                                                                                                                                                                                                                          |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                              |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                          |

**weka cluster container net remove**

Undedicate a networking device in a container.

```sh
weka cluster container net remove <container-id>
                                  <name>
                                  [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-id`\*          | The container's id                                                                                         |
| `name`\*                  | Net device name, e.g. container0net0                                                                       |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cluster default-net

List the default data networking configuration

```sh
weka cluster default-net [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]
                         [--json]
                         [--raw-units]
                         [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster default-net set**

Set the default data networking configuration

```sh
weka cluster default-net set [--range range]
                             [--gateway gateway]
                             [--netmask-bits netmask-bits]
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--range`                 | IP range (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                            |
| `--gateway`               | Default gateway IP                                                                                         |
| `--netmask-bits`          | Subnet mask bits (0..32)                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster default-net update**

Update the default data networking configuration

```sh
weka cluster default-net update [--range range]
                                [--gateway gateway]
                                [--netmask-bits netmask-bits]
                                [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--range`                 | IP range (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                            |
| `--gateway`               | Default gateway IP                                                                                         |
| `--netmask-bits`          | Subnet mask bits (0..32)                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster default-net reset**

Reset the default data networking configuration

```sh
weka cluster default-net reset [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cluster license

Get information about the current license status, how much resources are being used in the cluster and whether or not your current license is valid.

```sh
weka cluster license [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--help]
                     [--json]
                     [--raw-units]
                     [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka cluster license payg**

Enable pay-as-you-go for the cluster

```sh
weka cluster license payg <plan-id>
                          <secret-key>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `plan-id`\*               | Plan ID connected to a payment method                                                                      |
| `secret-key`\*            | Secret key of the payment plan                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster license reset**

Removes existing license information, returning the cluster to an unlicensed mode

```sh
weka cluster license reset [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster license set**

Set the cluster license

```sh
weka cluster license set <license>
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `license`\*               | The new license to set to the system                                                                       |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cluster task

List the currently running background tasks and their status

```sh
weka cluster task [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--format format]
                  [--output output]...
                  [--sort sort]...
                  [--filter filter]...
                  [--help]
                  [--raw-units]
                  [--UTC]
                  [--no-header]
                  [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,type,state,phase,progress,paused,desc,time                                                                    |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka cluster task pause**

Pause a currently running background task

```sh
weka cluster task pause <task-id>
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `task-id`\*               | Id of the task to pause                                                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster task resume**

Resume a currently paused background task

```sh
weka cluster task resume <task-id>
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `task-id`\*               | Id of the task to resume                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster task abort**

Abort a currently running background task

```sh
weka cluster task abort <task-id>
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `task-id`\*               | Id of the task to abort                                                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster task limits**

List the current limits for background tasks

```sh
weka cluster task limits [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]
                         [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka cluster task limits set**

Set the limits for background tasks

```sh
weka cluster task limits set [--cpu-limit cpu-limit]
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--cpu-limit`             | Percent of the CPU resources to dedicate to background tasks                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka cluster client-target-version

Commands that manage the clients target version

```sh
weka cluster client-target-version [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka cluster client-target-version show**

Show clients target version to be used in case of upgrade or a new mount (stateless client).

```sh
weka cluster client-target-version show [--HOST HOST]
                                        [--PORT PORT]
                                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                        [--TIMEOUT TIMEOUT]
                                        [--profile profile]
                                        [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster client-target-version set**

Determine clients target version to be used in case of upgrade or a new mount (stateless client).

```sh
weka cluster client-target-version set <version-name>
                                       [--HOST HOST]
                                       [--PORT PORT]
                                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                       [--TIMEOUT TIMEOUT]
                                       [--profile profile]
                                       [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `version-name`\*          | The version to set                                                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka cluster client-target-version reset**

Clear cluster's client target version value

```sh
weka cluster client-target-version reset [--HOST HOST]
                                         [--PORT PORT]
                                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                         [--TIMEOUT TIMEOUT]
                                         [--profile profile]
                                         [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

### weka diags

Diagnostics commands to help understand the status of the cluster and its environment

```sh
weka diags [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka diags collect

Collect diags from all cluster hosts to a directory on the host running this command

```sh
weka diags collect [--id id]
                   [--timeout timeout]
                   [--output-dir output-dir]
                   [--core-limit core-limit]
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--container-id container-id]...
                   [--clients]
                   [--backends]
                   [--tar]
                   [--verbose]
                   [--help]
                   [--raw-units]
                   [--UTC]
                   [--json]

```

| Parameter                 | Description                                                                                                                                              |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-i`, `--id`              | Optional ID for this dump, if not specified a random ID is generated                                                                                     |
| `-m`, `--timeout`         | How long to wait when downloading diags from all hosts. Default is 10 minutes, 0 means indefinite (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-d`, `--output-dir`      | Directory to save the diags dump to, default: /opt/weka/diags                                                                                            |
| `-c`, `--core-limit`      | Limit to processing this number of core dumps, if found (default: 1)                                                                                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                 |
| `--container-id`...       | Container IDs to collect diags from, can be used multiple times. This flag causes --clients to be ignored.                                               |
| `--clients`               | Collect diags from client hosts only (by default diags are only collected from backends)                                                                 |
| `--backends`              | Collect diags from backend hosts (to be used in combination with --clients to collect from all hosts)                                                    |
| `-t`, `--tar`             | Create a TAR of all collected diags                                                                                                                      |
| `-v`, `--verbose`         | Print results of all diags, including successful ones                                                                                                    |
| `-h`, `--help`            | Show help message                                                                                                                                        |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                        |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                    |
| `-J`, `--json`            | Format output as JSON                                                                                                                                    |

#### weka diags list

Prints results of a previously collected diags report

```sh
weka diags list [--verbose] [--help] [<id>]...

```

| Parameter         | Description                                                                                                  |
| ----------------- | ------------------------------------------------------------------------------------------------------------ |
| `id`...           | ID of the dump to show or a path to the diags dump. If not specified a list of all collected diags is shown. |
| `-v`, `--verbose` | Print results of all diags, including successful ones                                                        |
| `-h`, `--help`    | Show help message                                                                                            |

#### weka diags rm

Stop a running instance of diags, and cancel its uploads.

```sh
weka diags rm [--HOST HOST]
              [--PORT PORT]
              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
              [--TIMEOUT TIMEOUT]
              [--profile profile]
              [--all]
              [--help]
              [<id>]...

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `id`...                   | ID of the diags to cancel. Must be specified unless the all option is set.                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--all`                   | Delete all.                                                                                                |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka diags upload

Collect and upload diags from all cluster hosts to Weka's support cloud

```sh
weka diags upload [--timeout timeout]
                  [--core-limit core-limit]
                  [--dump-id dump-id]
                  [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--container-id container-id]...
                  [--clients]
                  [--backends]
                  [--help]
                  [--json]

```

| Parameter                 | Description                                                                                                                            |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `-m`, `--timeout`         | How long to wait for diags to upload. Default is 10 minutes, 0 means indefinite (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-c`, `--core-limit`      | Limit to processing this number of core dumps, if found (default: 1)                                                                   |
| `--dump-id`               | ID of an existing dump to upload. This dump ID has to exist on this local server. If an ID is not specified, a new dump is created.    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                       |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                       |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                             |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                 |
| `--profile`               | Name of the connection and authentication profile to use                                                                               |
| `--container-id`...       | Container IDs to collect diags from, can be used multiple times. This flag causes --clients to be ignored.                             |
| `--clients`               | Collect diags from client hosts only (by default diags are only collected from backends)                                               |
| `--backends`              | Collect diags from backend hosts (to be used in combination with --clients to collect from all hosts)                                  |
| `-h`, `--help`            | Show help message                                                                                                                      |
| `-J`, `--json`            | Format output as JSON                                                                                                                  |

### weka events

List all events that conform to the filter criteria

```sh
weka events [--num-results num-results]
            [--start-time <start>]
            [--end-time <end>]
            [--severity severity]
            [--direction direction]
            [--HOST HOST]
            [--PORT PORT]
            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
            [--TIMEOUT TIMEOUT]
            [--profile profile]
            [--format format]
            [--type-list type-list]...
            [--exclude-type-list exclude-type-list]...
            [--category-list category-list]...
            [--output output]...
            [--show-internal]
            [--cloud-time]
            [--help]
            [--raw-units]
            [--UTC]
            [--no-header]
            [--verbose]

```

| Parameter                      | Description                                                                                                                                                                                                                                                                                          |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-n`, `--num-results`          | Get up to this number of events, default: 50                                                                                                                                                                                                                                                         |
| `--start-time`                 | Include events occurred in this time point and later (format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00)                                                                                    |
| `--end-time`                   | Include events occurred not later then this time point (format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00)                                                                                  |
| `--severity`                   | Include event with equal and higher severity, default: INFO (format: 'debug', 'info', 'warning', 'minor', 'major' or 'critical')                                                                                                                                                                     |
| `-d`, `--direction`            | Fetch events from the first available event (forward) or the latest created event (backward), default: backward (format: 'forward' or 'backward')                                                                                                                                                    |
| `-H`, `--HOST`                 | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                     |
| `-P`, `--PORT`                 | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                     |
| `-C`, `--CONNECT-TIMEOUT`      | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                           |
| `-T`, `--TIMEOUT`              | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                               |
| `--profile`                    | Name of the connection and authentication profile to use                                                                                                                                                                                                                                             |
| `-f`, `--format`               | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                             |
| `-t`, `--type-list`...         | Filter events by type, can be used multiple times (use 'weka events list-types' to see available types)                                                                                                                                                                                              |
| `-x`, `--exclude-type-list`... | Remove events by type, can be used multiple times (use 'weka events list-types' to see available types)                                                                                                                                                                                              |
| `-c`, `--category-list`...     | Include only events matches to the category\_list. Category can be Events, Node, Raid, Drive, ObjectStorage, System, Resources, Clustering, Network, Filesystem, Upgrade, NFS, Config, Cloud, InterfaceGroup, Org, User, Alerts, Licensing, Custom, Kms, Smb, Traces, S3, Security, Agent or KDriver |
| `-o`, `--output`...            | Specify which columns to output. May include any of the following: time,cloudTime,node,category,severity,type,entity,desc                                                                                                                                                                            |
| `-i`, `--show-internal`        | Show internal events                                                                                                                                                                                                                                                                                 |
| `-l`, `--cloud-time`           | Sort by cloud time instead of local timestamp                                                                                                                                                                                                                                                        |
| `-h`, `--help`                 | Show help message                                                                                                                                                                                                                                                                                    |
| `-R`, `--raw-units`            | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                    |
| `-U`, `--UTC`                  | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                |
| `--no-header`                  | Don't show column headers when printing the output                                                                                                                                                                                                                                                   |
| `-v`, `--verbose`              | Show all columns in output                                                                                                                                                                                                                                                                           |

#### weka events list-local

List recent events that happened on the machine running this command

```sh
weka events list-local [--start-time <start>]
                       [--end-time <end>]
                       [--next next]
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--format format]
                       [--output output]...
                       [--sort sort]...
                       [--filter filter]...
                       [--stem-mode]
                       [--show-internal]
                       [--help]
                       [--raw-units]
                       [--UTC]
                       [--no-header]
                       [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                         |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--start-time`            | Include events occurred in this time point and later (format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00)   |
| `--end-time`              | Include events occurred not later then this time point (format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00) |
| `--next`                  | Token for the next page of events                                                                                                                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                    |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                    |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                          |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                              |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                            |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                            |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: time,category,severity,permission,type,entity,node,hash                                                                                          |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                             |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                    |
| `--stem-mode`             | List stem mode events                                                                                                                                                                                               |
| `--show-internal`         | Show internal events                                                                                                                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                   |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                   |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                               |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                  |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                          |

#### weka events list-types

Show the event type definition information

```sh
weka events list-types [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--format format]
                       [--category category]...
                       [--type type]...
                       [--output output]...
                       [--sort sort]...
                       [--filter filter]...
                       [--show-internal]
                       [--help]
                       [--no-header]
                       [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                |
| `-c`, `--category`...     | List only the events that fall under one of the following categories: Events, Node, Raid, Drive, ObjectStorage, System, Resources, Clustering, Network, Filesystem, Upgrade, NFS, Config, Cloud, InterfaceGroup, Org, User, Alerts, Licensing, Custom, Kms, Smb, Traces, S3, Security, Agent or KDriver |
| `-t`, `--type`...         | List only events of the specified types                                                                                                                                                                                                                                                                 |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: type,category,severity,description,format,permission,parameters,dedup,dedupParams                                                                                                                                                    |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                 |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                        |
| `--show-internal`         | Show internal events                                                                                                                                                                                                                                                                                    |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                              |

#### weka events trigger-event

Trigger a custom event with a user defined parameter

```sh
weka events trigger-event <message>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `message`\*               | User defined text to trigger as the events parameter                                                       |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

### weka fs

List filesystems defined in this Weka cluster

```sh
weka fs [--name name]
        [--HOST HOST]
        [--PORT PORT]
        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
        [--TIMEOUT TIMEOUT]
        [--profile profile]
        [--format format]
        [--output output]...
        [--sort sort]...
        [--filter filter]...
        [--capacities]
        [--force-fresh]
        [--help]
        [--raw-units]
        [--UTC]
        [--no-header]
        [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                                                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--name`                  | Filesystem name                                                                                                                                                                                                                                                                                                                                                                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                                                                                                                                   |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                                                                                                                                   |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                         |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                             |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                                                                                                                           |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                                                                                                                           |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,name,group,usedSSD,usedSSDD,usedSSDM,freeSSD,availableSSDM,availableSSD,usedTotal,usedTotalD,freeTotal,availableTotal,maxFiles,status,encrypted,stores,auth,thinProvisioned,thinProvisioningMinSSDBudget,thinProvisioningMaxSSDBudget,usedSSDWD,usedSSDRD,reductionRatio,pendingReduction,dataReduction,reducedProcessedSize,reducedSize |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                                                                                                                            |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                                                                                                                                   |
| `--capacities`            | Display all capacity columns                                                                                                                                                                                                                                                                                                                                                                                       |
| `--force-fresh`           | Refresh the capacities to make sure they are most updated                                                                                                                                                                                                                                                                                                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                                                                                                                                  |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                                                                                                                                  |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                                                                                                                              |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                                                                                                                                 |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                                                                                                                                         |

#### weka fs create

Create a filesystem

```sh
weka fs create <name>
               <group-name>
               <total-capacity>
               [--obs-name obs-name]
               [--ssd-capacity ssd-capacity]
               [--thin-provision-min-ssd thin-provision-min-ssd]
               [--thin-provision-max-ssd thin-provision-max-ssd]
               [--auth-required auth-required]
               [--HOST HOST]
               [--PORT PORT]
               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
               [--TIMEOUT TIMEOUT]
               [--profile profile]
               [--encrypted]
               [--allow-no-kms]
               [--data-reduction]
               [--help]
               [--json]
               [--raw-units]
               [--UTC]

```

| Parameter                  | Description                                                                                                                                                                                                                                   |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                   | Filesystem name                                                                                                                                                                                                                               |
| `group-name`\*             | Group name                                                                                                                                                                                                                                    |
| `total-capacity`\*         | Total capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                                            |
| `--obs-name`               | Object Store bucket name. Mandatory for tiered filesystems                                                                                                                                                                                    |
| `--ssd-capacity`           | SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                                              |
| `--thin-provision-min-ssd` | Thin provisioned minimum SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                     |
| `--thin-provision-max-ssd` | Thin provisioned maximum SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                     |
| `--auth-required`          | Require the mounting user to be authenticated for mounting this filesystem. This flag is only effective in the root organization, users in non-root organizations must be authenticated to perform a mount operation. (format: 'yes' or 'no') |
| `-H`, `--HOST`             | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                              |
| `-P`, `--PORT`             | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                              |
| `-C`, `--CONNECT-TIMEOUT`  | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                    |
| `-T`, `--TIMEOUT`          | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                        |
| `--profile`                | Name of the connection and authentication profile to use                                                                                                                                                                                      |
| `--encrypted`              | Creates an encrypted filesystem                                                                                                                                                                                                               |
| `--allow-no-kms`           | Allow (insecurely) creating an encrypted filesystem without a KMS configured                                                                                                                                                                  |
| `--data-reduction`         | Enable data reduction                                                                                                                                                                                                                         |
| `-h`, `--help`             | Show help message                                                                                                                                                                                                                             |
| `-J`, `--json`             | Format output as JSON                                                                                                                                                                                                                         |
| `-R`, `--raw-units`        | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                             |
| `-U`, `--UTC`              | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                         |

#### weka fs download

Download a filesystem from object store

```sh
weka fs download <name>
                 <group-name>
                 <total-capacity>
                 <ssd-capacity>
                 <obs-bucket>
                 <locator>
                 [--auth-required auth-required]
                 [--additional-obs-bucket additional-obs-bucket]
                 [--snapshot-name snapshot-name]
                 [--access-point access-point]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--skip-resource-validation]
                 [--help]
                 [--json]
                 [--raw-units]
                 [--UTC]

```

| Parameter                    | Description                                                                                                                                                                                                                                   |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                     | Filesystem name                                                                                                                                                                                                                               |
| `group-name`\*               | Group name                                                                                                                                                                                                                                    |
| `total-capacity`\*           | Total capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                                            |
| `ssd-capacity`\*             | SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                                              |
| `obs-bucket`\*               | Object Store bucket                                                                                                                                                                                                                           |
| `locator`\*                  | Locator                                                                                                                                                                                                                                       |
| `--auth-required`            | Require the mounting user to be authenticated for mounting this filesystem. This flag is only effective in the root organization, users in non-root organizations must be authenticated to perform a mount operation. (format: 'yes' or 'no') |
| `--additional-obs-bucket`    | Additional Object Store bucket                                                                                                                                                                                                                |
| `--snapshot-name`            | Downloaded snapshot name (default: uploaded name)                                                                                                                                                                                             |
| `--access-point`             | Downloaded snapshot access point (default: uploaded access-point)                                                                                                                                                                             |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                              |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                              |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                    |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                        |
| `--profile`                  | Name of the connection and authentication profile to use                                                                                                                                                                                      |
| `--skip-resource-validation` | Skip verifying that the cluster has enough RAM and SSD resources allocated for the downloaded filesystem                                                                                                                                      |
| `-h`, `--help`               | Show help message                                                                                                                                                                                                                             |
| `-J`, `--json`               | Format output as JSON                                                                                                                                                                                                                         |
| `-R`, `--raw-units`          | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                             |
| `-U`, `--UTC`                | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                         |

#### weka fs update

Update a filesystem

```sh
weka fs update <name>
               [--new-name new-name]
               [--total-capacity total-capacity]
               [--ssd-capacity ssd-capacity]
               [--thin-provision-min-ssd thin-provision-min-ssd]
               [--thin-provision-max-ssd thin-provision-max-ssd]
               [--data-reduction data-reduction]
               [--auth-required auth-required]
               [--HOST HOST]
               [--PORT PORT]
               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
               [--TIMEOUT TIMEOUT]
               [--profile profile]
               [--help]

```

| Parameter                  | Description                                                                                                                                                                                                                                   |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                   | Filesystem name                                                                                                                                                                                                                               |
| `--new-name`               | New name                                                                                                                                                                                                                                      |
| `--total-capacity`         | Total capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                                            |
| `--ssd-capacity`           | SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                                              |
| `--thin-provision-min-ssd` | Thin provision minimum SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                       |
| `--thin-provision-max-ssd` | Thin provision maximum SSD capacity (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                                                                                       |
| `--data-reduction`         | Enable data reduction                                                                                                                                                                                                                         |
| `--auth-required`          | Require the mounting user to be authenticated for mounting this filesystem. This flag is only effective in the root organization, users in non-root organizations must be authenticated to perform a mount operation. (format: 'yes' or 'no') |
| `-H`, `--HOST`             | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                              |
| `-P`, `--PORT`             | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                              |
| `-C`, `--CONNECT-TIMEOUT`  | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                    |
| `-T`, `--TIMEOUT`          | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                        |
| `--profile`                | Name of the connection and authentication profile to use                                                                                                                                                                                      |
| `-h`, `--help`             | Show help message                                                                                                                                                                                                                             |

#### weka fs delete

Delete a filesystem

```sh
weka fs delete <name>
               [--HOST HOST]
               [--PORT PORT]
               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
               [--TIMEOUT TIMEOUT]
               [--profile profile]
               [--purge-from-obs]
               [--force]
               [--help]

```

| Parameter                 | Description                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Filesystem name                                                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                     |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                     |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)           |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)               |
| `--profile`               | Name of the connection and authentication profile to use                                                             |
| `--purge-from-obs`        | Delete filesystem's objects from the local writable Object Store, making all locally uploaded snapshots unusable     |
| `-f`, `--force`           | Force this action without further confirmation. This action DELETES ALL DATA in the filesystem and cannot be undone. |
| `-h`, `--help`            | Show help message                                                                                                    |

#### weka fs restore

Restore filesystem content from a snapshot

```sh
weka fs restore <file-system>
                <source-name>
                [--preserved-overwritten-snapshot-name preserved-overwritten-snapshot-name]
                [--preserved-overwritten-snapshot-access-point preserved-overwritten-snapshot-access-point]
                [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--force]
                [--help]
                [--json]

```

| Parameter                                       | Description                                                                                                                                            |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `file-system`\*                                 | The name of the Filesystem to be restored                                                                                                              |
| `source-name`\*                                 | The name of the source snapshot                                                                                                                        |
| `--preserved-overwritten-snapshot-name`         | Name of a snapshot to create with the old content of the filesystem                                                                                    |
| `--preserved-overwritten-snapshot-access-point` | Access point of the preserved overwritten snapshot                                                                                                     |
| `-H`, `--HOST`                                  | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                       |
| `-P`, `--PORT`                                  | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                       |
| `-C`, `--CONNECT-TIMEOUT`                       | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                             |
| `-T`, `--TIMEOUT`                               | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                 |
| `--profile`                                     | Name of the connection and authentication profile to use                                                                                               |
| `-f`, `--force`                                 | Force this action without further confirmation. This action replaces all data in the filesystem with the content of the snapshot and cannot be undone. |
| `-h`, `--help`                                  | Show help message                                                                                                                                      |
| `-J`, `--json`                                  | Format output as JSON                                                                                                                                  |

#### weka fs quota

Commands used to control directory quotas

```sh
weka fs quota [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka fs quota set**

Set a directory quota in a filesystem

```sh
weka fs quota set <path>
                  [--soft soft]
                  [--hard hard]
                  [--grace grace]
                  [--owner owner]
                  [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--help]

```

| Parameter                 | Description                                                                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `path`\*                  | Path in the filesystem                                                                                                                                               |
| `--soft`                  | Soft limit for the directory, or 0 for unlimited (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--hard`                  | Hard limit for the directory, or 0 for unlimited (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--grace`                 | Soft limit grace period (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                       |
| `--owner`                 | Quota owner (e.g., email)                                                                                                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                     |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                     |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                           |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                               |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                             |
| `-h`, `--help`            | Show help message                                                                                                                                                    |

**weka fs quota set-default**

Set a default directory quota in a filesystem

```sh
weka fs quota set-default <path>
                          [--soft soft]
                          [--hard hard]
                          [--grace grace]
                          [--owner owner]
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]

```

| Parameter                 | Description                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `path`\*                  | Path in the filesystem                                                                                                                           |
| `--soft`                  | Soft limit for the directory (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--hard`                  | Hard limit for the directory (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--grace`                 | Soft limit grace period (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                   |
| `--owner`                 | Quota owner (e.g., email)                                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                 |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                 |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                       |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                           |
| `--profile`               | Name of the connection and authentication profile to use                                                                                         |
| `-h`, `--help`            | Show help message                                                                                                                                |

**weka fs quota unset**

Unsets a directory quota in a filesystem

```sh
weka fs quota unset <path>
                    [--generation generation]
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `path`\*                  | Path in the filesystem                                                                                     |
| `--generation`            | Remove a specific generation of quota                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka fs quota unset-default**

Unsets a default directory quota in a filesystem

```sh
weka fs quota unset-default <path>
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `path`\*                  | Path in the filesystem                                                                                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka fs quota list**

List filesystem quotas (by default, only exceeding ones)

```sh
weka fs quota list [fs-name]
                   [--snap-name snap-name]
                   [--path path]
                   [--under under]
                   [--over over]
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--format format]
                   [--output output]...
                   [--sort sort]...
                   [--filter filter]...
                   [--all]
                   [--quick]
                   [--help]
                   [--raw-units]
                   [--UTC]
                   [--no-header]
                   [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `fs-name`                 | Filesystem name                                                                                                                                                                         |
| `--snap-name`             | Optional snapshot name                                                                                                                                                                  |
| `-p`, `--path`            | Show this path only                                                                                                                                                                     |
| `-u`, `--under`           | List under (and including) this path only                                                                                                                                               |
| `--over`                  | Show only quotas over this percentage of usage (format: 0..100)                                                                                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: quotaId,path,used,dblk,mblk,soft,hard,usage,owner,grace\_seconds,time\_over\_soft\_limit,status                      |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `--all`                   | Show all (not only exceeding) quotas                                                                                                                                                    |
| `-q`, `--quick`           | Skip resolving inodes to paths                                                                                                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs quota list-default**

List filesystem default quotas

```sh
weka fs quota list-default [fs-name]
                           [--snap-name snap-name]
                           [--path path]
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--format format]
                           [--output output]...
                           [--sort sort]...
                           [--filter filter]...
                           [--help]
                           [--raw-units]
                           [--UTC]
                           [--no-header]
                           [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `fs-name`                 | Filesystem name                                                                                                                                                                         |
| `--snap-name`             | Optional snapshot name                                                                                                                                                                  |
| `-p`, `--path`            | Show this path only                                                                                                                                                                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: inodeId,path,soft,hard,owner,grace                                                                                   |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka fs group

List filesystem groups

```sh
weka fs group [--HOST HOST]
              [--PORT PORT]
              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
              [--TIMEOUT TIMEOUT]
              [--profile profile]
              [--format format]
              [--output output]...
              [--sort sort]...
              [--filter filter]...
              [--help]
              [--raw-units]
              [--UTC]
              [--no-header]
              [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,group,name,retention,demote                                                                                      |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs group create**

Create a filesystem group

```sh
weka fs group create <name>
                     [--target-ssd-retention target-ssd-retention]
                     [--start-demote start-demote]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--help]
                     [--json]
                     [--raw-units]
                     [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | The filesystem group name to be created                                                                                           |
| `--target-ssd-retention`  | Period of time to keep an SSD copy of the data (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                             |
| `--start-demote`          | Period of time to wait before copying data to the Object Store (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs group update**

Update a filesystem group

```sh
weka fs group update <name>
                     [--new-name new-name]
                     [--target-ssd-retention target-ssd-retention]
                     [--start-demote start-demote]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--help]

```

| Parameter                 | Description                                                                                                           |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | The filesystem group name to be created                                                                               |
| `--new-name`              | Updated name of the specified filesystem group                                                                        |
| `--target-ssd-retention`  | Period of time to keep an SSD copy of the data (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                 |
| `--start-demote`          | Period of time to wait before copying data to the Object Store (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                      |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                      |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)            |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                |
| `--profile`               | Name of the connection and authentication profile to use                                                              |
| `-h`, `--help`            | Show help message                                                                                                     |

**weka fs group delete**

Delete a filesystem group

```sh
weka fs group delete <name>
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | The name of the filesystem group to be deleted                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka fs snapshot

List snapshots

```sh
weka fs snapshot [--file-system file-system]
                 [--name name]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--format format]
                 [--output output]...
                 [--sort sort]...
                 [--filter filter]...
                 [--help]
                 [--raw-units]
                 [--UTC]
                 [--no-header]
                 [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                                                  |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--file-system`           | Filesystem name                                                                                                                                                                                                                                                                                                              |
| `--name`                  | Snapshot name                                                                                                                                                                                                                                                                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                                             |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                                             |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                   |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                       |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                                     |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                                     |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,filesystem,name,access,writeable,created,local\_upload\_size,remote\_upload\_size,local\_object\_status,local\_object\_progress,local\_object\_locator,remote\_object\_status,remote\_object\_progress,remote\_object\_locator,removing,prefetched |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                                      |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                                             |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                                            |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                                            |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                                        |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                                           |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                                                   |

**weka fs snapshot create**

Create a snapshot

```sh
weka fs snapshot create <file-system>
                        <name>
                        [--access-point access-point]
                        [--source-snapshot source-snapshot]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--format format]
                        [--output output]...
                        [--sort sort]...
                        [--filter filter]...
                        [--is-writable]
                        [--help]
                        [--raw-units]
                        [--UTC]
                        [--no-header]
                        [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `file-system`\*           | Source Filesystem name                                                                                                                                                                  |
| `name`\*                  | Target Snapshot name                                                                                                                                                                    |
| `--access-point`          | Access point                                                                                                                                                                            |
| `--source-snapshot`       | Source snapshot                                                                                                                                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: id,name,access,writeable,created                                                                                     |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `--is-writable`           | Writable                                                                                                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs snapshot copy**

Copy one snapshot over another

```sh
weka fs snapshot copy <file-system>
                      <source-name>
                      <destination-name>
                      [--preserved-overwritten-snapshot-name preserved-overwritten-snapshot-name]
                      [--preserved-overwritten-snapshot-access-point preserved-overwritten-snapshot-access-point]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]
                      [--raw-units]
                      [--UTC]

```

| Parameter                                       | Description                                                                                                                       |
| ----------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `file-system`\*                                 | Source Filesystem name                                                                                                            |
| `source-name`\*                                 | Source snapshot name                                                                                                              |
| `destination-name`\*                            | Destination snapshot name                                                                                                         |
| `--preserved-overwritten-snapshot-name`         | Name of a snapshot to create with the old content of the destination                                                              |
| `--preserved-overwritten-snapshot-access-point` | Access point of the preserved overwritten snapshot                                                                                |
| `-H`, `--HOST`                                  | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`                                  | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT`                       | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`                               | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`                                     | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`                                  | Show help message                                                                                                                 |
| `-J`, `--json`                                  | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`                             | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`                                   | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs snapshot update**

Update snapshot parameters

```sh
weka fs snapshot update <file-system>
                        <name>
                        [--new-name new-name]
                        [--access-point access-point]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--json]
                        [--raw-units]
                        [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `file-system`\*           | Source Filesystem name                                                                                                            |
| `name`\*                  | Snapshot name                                                                                                                     |
| `--new-name`              | Updated snapshot name                                                                                                             |
| `--access-point`          | Access point                                                                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs snapshot access-point-naming-convention**

Access point naming convention

```sh
weka fs snapshot access-point-naming-convention [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka fs snapshot access-point-naming-convention status**

Show access point naming convention

```sh
weka fs snapshot access-point-naming-convention status [--HOST HOST]
                                                       [--PORT PORT]
                                                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                                       [--TIMEOUT TIMEOUT]
                                                       [--profile profile]
                                                       [--help]
                                                       [--json]
                                                       [--raw-units]
                                                       [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs snapshot access-point-naming-convention update**

Update access point naming convention

```sh
weka fs snapshot access-point-naming-convention update <access-point-naming-convention>
                                                       [--HOST HOST]
                                                       [--PORT PORT]
                                                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                                       [--TIMEOUT TIMEOUT]
                                                       [--profile profile]
                                                       [--help]

```

| Parameter                          | Description                                                                                                |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `access-point-naming-convention`\* | access point naming configuration (format: 'date' or 'name')                                               |
| `-H`, `--HOST`                     | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`                     | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT`          | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`                  | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`                        | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`                     | Show help message                                                                                          |

**weka fs snapshot upload**

Upload a snapshot to object store

```sh
weka fs snapshot upload <file-system>
                        <snapshot>
                        [--site site]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--allow-non-chronological]
                        [--help]
                        [--json]
                        [--raw-units]
                        [--UTC]

```

| Parameter                   | Description                                                                                                                                |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `file-system`\*             | Filesystem name                                                                                                                            |
| `snapshot`\*                | Snapshot name                                                                                                                              |
| `--site`                    | The site of the Object Store to upload to (format: 'local' or 'remote')                                                                    |
| `-H`, `--HOST`              | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                           |
| `-P`, `--PORT`              | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                           |
| `-C`, `--CONNECT-TIMEOUT`   | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                 |
| `-T`, `--TIMEOUT`           | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                     |
| `--profile`                 | Name of the connection and authentication profile to use                                                                                   |
| `--allow-non-chronological` | Allow uploading snapshots to remote object-store in non-chronological order. This is not recommended, as it will incur high data overhead. |
| `-h`, `--help`              | Show help message                                                                                                                          |
| `-J`, `--json`              | Format output as JSON                                                                                                                      |
| `-R`, `--raw-units`         | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.          |
| `-U`, `--UTC`               | Print times in UTC. When not set, times are converted to the local time of this host.                                                      |

**weka fs snapshot download**

Download a snapshot into an existing filesystem

```sh
weka fs snapshot download <file-system>
                          <locator>
                          [--name name]
                          [--access-point access-point]
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--allow-non-chronological]
                          [--allow-divergence]
                          [--help]
                          [--json]
                          [--raw-units]
                          [--UTC]

```

| Parameter                   | Description                                                                                                                       |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `file-system`\*             | Filesystem name                                                                                                                   |
| `locator`\*                 | Locator                                                                                                                           |
| `--name`                    | Snapshot name (default: uploaded name)                                                                                            |
| `--access-point`            | Access point (default: uploaded access point)                                                                                     |
| `-H`, `--HOST`              | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`              | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT`   | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`           | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`                 | Name of the connection and authentication profile to use                                                                          |
| `--allow-non-chronological` | Allow downloading snapshots in non-chronological order. This is not recommended, as it will incur high data overhead.             |
| `--allow-divergence`        | Allow downloading snapshots which are not descendants of the last downloaded snapshot.                                            |
| `-h`, `--help`              | Show help message                                                                                                                 |
| `-J`, `--json`              | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`         | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`               | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs snapshot delete**

Delete a snapshot

```sh
weka fs snapshot delete <file-system>
                        <name>
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--force]
                        [--help]

```

| Parameter                 | Description                                                                                                               |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `file-system`\*           | Source Filesystem name                                                                                                    |
| `name`\*                  | Snapshot name                                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                          |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                          |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                    |
| `--profile`               | Name of the connection and authentication profile to use                                                                  |
| `-f`, `--force`           | Force this action without further confirmation. This action deletes all data stored by the snapshot and cannot be undone. |
| `-h`, `--help`            | Show help message                                                                                                         |

#### weka fs tier

Show object store connectivity for each node in the cluster

```sh
weka fs tier [--HOST HOST]
             [--PORT PORT]
             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
             [--TIMEOUT TIMEOUT]
             [--profile profile]
             [--format format]
             [--output output]...
             [--sort sort]...
             [--filter filter]...
             [--help]
             [--raw-units]
             [--UTC]
             [--no-header]
             [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: obsBucket,statusUpload,statusDownload,statusRemove,nodesDown,errors                                                  |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs tier location**

Show data storage location for a given path

```sh
weka fs tier location <path>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--help]
                      [--raw-units]
                      [--UTC]
                      [--no-header]
                      [--verbose]
                      [<paths>]...

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `path`\*                  | Path to get information about                                                                                                                                                           |
| `paths`...                | Extra paths to get information about                                                                                                                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: path,type,size,ssdWrite,ssdRead,obsBytes,remoteBytes                                                                 |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs tier fetch**

Fetch object-stored files to SSD storage

```sh
weka fs tier fetch [--non-existing non-existing]
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--verbose]
                   [--help]
                   [--raw-units]
                   [--UTC]
                   [<path>]...

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `path`...                 | A file path to fetch to SSD storage. Multiple paths can be passed, e.g. \`find ...                                                |
| `--non-existing`          | Behavior for non-existing files (default: error) (format: 'error', 'warn' or 'ignore')                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-v`, `--verbose`         | Verbose output, showing fetch requests as they are submitted                                                                      |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs tier release**

Release object-stored files from SSD storage

```sh
weka fs tier release [--non-existing non-existing]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--verbose]
                     [--help]
                     [--raw-units]
                     [--UTC]
                     [<path>]...

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `path`...                 | A file path to release from SSD storage. Multiple paths can be passed, e.g. \`find ...                                            |
| `--non-existing`          | Behavior for non-existing files (default: error) (format: 'error', 'warn' or 'ignore')                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-v`, `--verbose`         | Verbose output, showing release requests as they are submitted                                                                    |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs tier capacity**

List capacities for object store buckets attached to filesystems

```sh
weka fs tier capacity [--filesystem filesystem]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--force-fresh]
                      [--help]
                      [--raw-units]
                      [--UTC]
                      [--no-header]
                      [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                               |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--filesystem`            | Filesystem name                                                                                                                                                                                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                          |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                          |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                    |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                  |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                  |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: fsUid,fsName,bucketUid,bucketName,totalConsumedCapacity,UsedCapacity,reclaimable,reclaimableThreshold,reclaimableLowThreshold,reclaimableHighThreshold |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                   |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                          |
| `--force-fresh`           | Refresh the capacities to make sure they are most updated                                                                                                                                                                 |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                         |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                         |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                     |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                        |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                |

**weka fs tier s3**

List S3 object store buckets configuration and status

```sh
weka fs tier s3 [--obs-name obs-name]
                [--name name]
                [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--format format]
                [--output output]...
                [--sort sort]...
                [--filter filter]...
                [--help]
                [--raw-units]
                [--UTC]
                [--no-header]
                [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--obs-name`              | Name of the Object Store                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `--name`                  | Name of the Object Store bucket                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                                                                                                                                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                                                                                                                                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                                                                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                                                                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                                                                                                                                                                          |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                                                                                                                                                                          |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,obsId,obsName,id,name,site,statusUpload,statusDownload,statusRemove,nodesUp,nodesDown,nodesUnknown,errors,protocol,hostname,port,bucket,auth,region,access,secret,status,up,downloadBandwidth,uploadBandwidth,removeBandwidth,errorsTimeout,prefetch,downloads,uploads,removals,maxUploadExtents,maxUploadSize,enableUploadTags,stsOperationType,stsRoleArn,stsRoleSessionName,stsDuration |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                                                                                                                                                                           |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                                                                                                                                                                                  |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                                                                                                                                                                                 |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                                                                                                                                                                             |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                                                                                                                                                                                |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                                                                                                                                                                                        |

**weka fs tier s3 add**

Create a new S3 object store bucket connection

```sh
weka fs tier s3 add <name>
                    [--site site]
                    [--obs-name obs-name]
                    [--hostname hostname]
                    [--port port]
                    [--bucket bucket]
                    [--auth-method auth-method]
                    [--region region]
                    [--access-key-id access-key-id]
                    [--secret-key secret-key]
                    [--protocol protocol]
                    [--obs-type obs-type]
                    [--bandwidth bandwidth]
                    [--download-bandwidth download-bandwidth]
                    [--upload-bandwidth upload-bandwidth]
                    [--remove-bandwidth remove-bandwidth]
                    [--errors-timeout errors-timeout]
                    [--prefetch-mib prefetch-mib]
                    [--max-concurrent-downloads max-concurrent-downloads]
                    [--max-concurrent-uploads max-concurrent-uploads]
                    [--max-concurrent-removals max-concurrent-removals]
                    [--max-extents-in-data-blob max-extents-in-data-blob]
                    [--max-data-blob-size max-data-blob-size]
                    [--enable-upload-tags enable-upload-tags]
                    [--sts-operation-type sts-operation-type]
                    [--sts-role-arn sts-role-arn]
                    [--sts-role-session-name sts-role-session-name]
                    [--sts-session-duration sts-session-duration]
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--dry-run]
                    [--skip-verification]
                    [--verbose-errors]
                    [--help]
                    [--json]
                    [--raw-units]
                    [--UTC]

```

| Parameter                       | Description                                                                                                                                                             |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                        | Name of the Object Store bucket                                                                                                                                         |
| `--site`                        | The site of the Object Store, default: local (format: 'local' or 'remote')                                                                                              |
| `--obs-name`                    | Name of the Object Store to associate this new bucket to                                                                                                                |
| `--hostname`                    | Hostname (or IP) of the entrypoint to the storage                                                                                                                       |
| `--port`                        | Port of the entrypoint to S3 (single Accesser or Load-Balancer)                                                                                                         |
| `--bucket`                      | Name of the bucket we are assigned to work with                                                                                                                         |
| `--auth-method`                 | Authentication method. S3AuthMethod can be None, AWSSignature2 or AWSSignature4                                                                                         |
| `--region`                      | Name of the region we are assigned to work with (usually empty)                                                                                                         |
| `--access-key-id`               | Access Key ID for AWS Signature authentications                                                                                                                         |
| `--secret-key`                  | Secret Key for AWS Signature authentications                                                                                                                            |
| `--protocol`                    | One of: HTTP (default), HTTPS, HTTPS\_UNVERIFIED                                                                                                                        |
| `--obs-type`                    | One of: AWS (default), AZURE                                                                                                                                            |
| `--bandwidth`                   | Bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                            |
| `--download-bandwidth`          | Download bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                   |
| `--upload-bandwidth`            | Upload bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                     |
| `--remove-bandwidth`            | Remove bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                     |
| `--errors-timeout`              | If the Object Store bucket link is down for longer than this, all IOs that need data return with an error (format: duration between 1 minute and 15 minutes)            |
| `--prefetch-mib`                | How many MiB of data to prefetch when reading a whole MiB on object store (format: 0..600)                                                                              |
| `--max-concurrent-downloads`    | Maximum number of downloads we concurrently perform on this object store in a single IO node (format: 1..64)                                                            |
| `--max-concurrent-uploads`      | Maximum number of uploads we concurrently perform on this object store in a single IO node (format: 1..64)                                                              |
| `--max-concurrent-removals`     | Maximum number of removals we concurrently perform on this object store in a single IO node (format: 1..64)                                                             |
| `--max-extents-in-data-blob`    | Maximum number of extents' data to upload to an object store data blob                                                                                                  |
| `--max-data-blob-size`          | Maximum size to upload to an object store data blob (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--enable-upload-tags`          | Enable tagging of uploaded objects                                                                                                                                      |
| `--sts-operation-type`          | AWS STS operation type to use. Default: none (format: 'assume\_role' or 'none')                                                                                         |
| `--sts-role-arn`                | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE                                                              |
| `--sts-role-session-name`       | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64.                                                              |
| `owed characters: upper and lo` | wer-case alphanumeric characters with no spaces.                                                                                                                        |

**weka fs tier s3 update**

Edit an existing S3 object store bucket connection

```sh
weka fs tier s3 update <name>
                       [--new-name new-name]
                       [--new-obs-name new-obs-name]
                       [--hostname hostname]
                       [--port port]
                       [--protocol protocol]
                       [--bucket bucket]
                       [--auth-method auth-method]
                       [--region region]
                       [--access-key-id access-key-id]
                       [--secret-key secret-key]
                       [--bandwidth bandwidth]
                       [--download-bandwidth download-bandwidth]
                       [--upload-bandwidth upload-bandwidth]
                       [--remove-bandwidth remove-bandwidth]
                       [--prefetch-mib prefetch-mib]
                       [--errors-timeout errors-timeout]
                       [--max-concurrent-downloads max-concurrent-downloads]
                       [--max-concurrent-uploads max-concurrent-uploads]
                       [--max-concurrent-removals max-concurrent-removals]
                       [--max-extents-in-data-blob max-extents-in-data-blob]
                       [--max-data-blob-size max-data-blob-size]
                       [--enable-upload-tags enable-upload-tags]
                       [--sts-operation-type sts-operation-type]
                       [--sts-role-arn sts-role-arn]
                       [--sts-role-session-name sts-role-session-name]
                       [--sts-session-duration sts-session-duration]
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--format format]
                       [--output output]...
                       [--sort sort]...
                       [--filter filter]...
                       [--dry-run]
                       [--skip-verification]
                       [--verbose-errors]
                       [--help]
                       [--raw-units]
                       [--UTC]
                       [--no-header]
                       [--verbose]

```

| Parameter                       | Description                                                                                                                                                             |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                        | Name of the Object Store bucket                                                                                                                                         |
| `--new-name`                    | New name                                                                                                                                                                |
| `--new-obs-name`                | New Object Store name                                                                                                                                                   |
| `--hostname`                    | Hostname (or IP) of the entrypoint to the storage                                                                                                                       |
| `--port`                        | Port of the entrypoint to S3 (single Accesser or Load-Balancer)                                                                                                         |
| `--protocol`                    | One of: HTTP (default), HTTPS, HTTPS\_UNVERIFIED                                                                                                                        |
| `--bucket`                      | Name of the bucket we are assigned to work with                                                                                                                         |
| `--auth-method`                 | Authentication method. S3AuthMethod can be None, AWSSignature2 or AWSSignature4                                                                                         |
| `--region`                      | Name of the region we are assigned to work with (usually empty)                                                                                                         |
| `--access-key-id`               | Access Key ID for AWS Signature authentications                                                                                                                         |
| `--secret-key`                  | Secret Key for AWS Signature authentications                                                                                                                            |
| `--bandwidth`                   | Bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                            |
| `--download-bandwidth`          | Download bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                   |
| `--upload-bandwidth`            | Upload bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                     |
| `--remove-bandwidth`            | Remove bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                     |
| `--prefetch-mib`                | How many MiB of data to prefetch when reading a whole MiB on object store (format: 0..600)                                                                              |
| `--errors-timeout`              | If the Object Store bucket link is down for longer than this, all IOs that need data return with an error (format: duration between 1 minute and 15 minutes)            |
| `--max-concurrent-downloads`    | Maximum number of downloads we concurrently perform on this object store in a single IO node (format: 1..64)                                                            |
| `--max-concurrent-uploads`      | Maximum number of uploads we concurrently perform on this object store in a single IO node (format: 1..64)                                                              |
| `--max-concurrent-removals`     | Maximum number of removals we concurrently perform on this object store in a single IO node (format: 1..64)                                                             |
| `--max-extents-in-data-blob`    | Maximum number of extents' data to upload to an object store data blob                                                                                                  |
| `--max-data-blob-size`          | Maximum size to upload to an object store data blob (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--enable-upload-tags`          | Enable tagging of uploaded objects                                                                                                                                      |
| `--sts-operation-type`          | AWS STS operation type to use. Default: none (format: 'assume\_role' or 'none')                                                                                         |
| `--sts-role-arn`                | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE                                                              |
| `--sts-role-session-name`       | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64.                                                              |
| `owed characters: upper and lo` | wer-case alphanumeric characters with no spaces.                                                                                                                        |

**weka fs tier s3 delete**

Delete an existing S3 object store connection

```sh
weka fs tier s3 delete <name>
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Name of the Object Store bucket                                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka fs tier s3 attach**

Attach a filesystem to an existing Object Store

```sh
weka fs tier s3 attach <fs-name>
                       <obs-name>
                       [--mode mode]
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--help]
                       [--raw-units]
                       [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `fs-name`\*               | Name of the Filesystem                                                                                                            |
| `obs-name`\*              | Name of the Object Store bucket to attach                                                                                         |
| `--mode`                  | The operation mode for the Object Store bucket (format: 'writable' or 'remote')                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka fs tier s3 detach**

Detach a filesystem from an attached object store

```sh
weka fs tier s3 detach <fs-name>
                       <obs-name>
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--help]
                       [--force]

```

| Parameter                 | Description                                                                                                                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `fs-name`\*               | Name of the Filesystem                                                                                                                                                                                                            |
| `obs-name`\*              | Name of the Object Store bucket to detach                                                                                                                                                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                 |
| `-f`, `--force`           | Force this action without further confirmation. This process might take a while to complete and it cannot be aborted. The data will remain intact on the object store, and you can still use the uploaded snapshots for recovery. |

**weka fs tier s3 snapshot**

Commands used to display info about uploaded snapshots

```sh
weka fs tier s3 snapshot [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

\####### weka fs tier s3 snapshot list

List and show info about snapshots uploaded to Object Storage

```sh
weka fs tier s3 snapshot list <name>
                              [--locator locator]
                              [--HOST HOST]
                              [--PORT PORT]
                              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                              [--TIMEOUT TIMEOUT]
                              [--profile profile]
                              [--format format]
                              [--output output]...
                              [--sort sort]...
                              [--filter filter]...
                              [--help]
                              [--raw-units]
                              [--UTC]
                              [--no-header]
                              [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                    |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Name of the Object Store bucket                                                                                                                                                                                |
| `--locator`               | Locator                                                                                                                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                               |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                               |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                     |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                         |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                       |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                       |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: guid,fsId,snapId,origFsId,fsName,snapName,accessPoint,totalMetaData,totalSize,ssdCapacity,totalCapacity,maxFiles,numGuids,compatibleVersion |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                        |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                               |
| `-h`, `--help`            | Show help message                                                                                                                                                                                              |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                              |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                          |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                             |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                     |

**weka fs tier ops**

List all the operations currently running on an object store from all the hosts in the cluster

```sh
weka fs tier ops [name]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--format format]
                 [--output output]...
                 [--sort sort]...
                 [--filter filter]...
                 [--help]
                 [--raw-units]
                 [--UTC]
                 [--no-header]
                 [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`                    | Name of the Object Store bucket                                                                                                                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: node,obsBucket,key,type,execution,phase,previous,start,size,results,errors,lastHTTP,concurrency,inode                |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs tier obs**

List object stores configuration and status

```sh
weka fs tier obs [--name name]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--format format]
                 [--output output]...
                 [--sort sort]...
                 [--filter filter]...
                 [--help]
                 [--raw-units]
                 [--UTC]
                 [--no-header]
                 [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                                                                                                                                                                               |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Name of the Object Store                                                                                                                                                                                                                                                                                                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                                                                                                                          |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                                                                                                                          |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                                                                                                                                    |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                                                                                                                                  |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                                                                                                                                                                  |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,name,site,bucketsCount,uploadBucketsUp,downloadBucketsUp,removeBucketsUp,protocol,hostname,port,auth,region,access,secret,downloadBandwidth,uploadBandwidth,remove3Bandwidth,downloads,uploads,removals,maxUploadExtents,maxUploadSize,enableUploadTags,maxUploadRam,stsOperationType,stsRoleArn,stsRoleSessionName,stsDuration |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                                                                                                                                                                   |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                                                                                                                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                                                                                                                         |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                                                                                                                                                                         |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                                                                                                                                                                     |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                                                                                                                                                                        |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                                                                                                                                                                                |

**weka fs tier obs update**

Edit an existing object store

```sh
weka fs tier obs update <name>
                        [--new-name new-name]
                        [--hostname hostname]
                        [--port port]
                        [--protocol protocol]
                        [--auth-method auth-method]
                        [--region region]
                        [--access-key-id access-key-id]
                        [--secret-key secret-key]
                        [--bandwidth bandwidth]
                        [--download-bandwidth download-bandwidth]
                        [--upload-bandwidth upload-bandwidth]
                        [--remove-bandwidth remove-bandwidth]
                        [--max-concurrent-downloads max-concurrent-downloads]
                        [--max-concurrent-uploads max-concurrent-uploads]
                        [--max-concurrent-removals max-concurrent-removals]
                        [--max-extents-in-data-blob max-extents-in-data-blob]
                        [--max-data-blob-size max-data-blob-size]
                        [--upload-memory-limit upload-memory-limit]
                        [--enable-upload-tags enable-upload-tags]
                        [--sts-operation-type sts-operation-type]
                        [--sts-role-arn sts-role-arn]
                        [--sts-role-session-name sts-role-session-name]
                        [--sts-session-duration sts-session-duration]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--raw-units]
                        [--UTC]

```

| Parameter                       | Description                                                                                                                                                                                        |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                        | Name of the Object Store                                                                                                                                                                           |
| `--new-name`                    | New name                                                                                                                                                                                           |
| `--hostname`                    | Hostname (or IP) of the entrypoint to the bucket                                                                                                                                                   |
| `--port`                        | Port of the entrypoint to S3 (single Accesser or Load-Balancer)                                                                                                                                    |
| `--protocol`                    | One of: HTTP (default), HTTPS, HTTPS\_UNVERIFIED                                                                                                                                                   |
| `--auth-method`                 | Authentication method. S3AuthMethod can be None, AWSSignature2 or AWSSignature4                                                                                                                    |
| `--region`                      | Name of the region we are assigned to work with (usually empty)                                                                                                                                    |
| `--access-key-id`               | Access Key ID for AWS Signature authentications                                                                                                                                                    |
| `--secret-key`                  | Secret Key for AWS Signature authentications                                                                                                                                                       |
| `--bandwidth`                   | Bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                                                       |
| `--download-bandwidth`          | Download bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                                              |
| `--upload-bandwidth`            | Upload bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                                                |
| `--remove-bandwidth`            | Remove bandwidth limitation per core (Mbps) (format: 1..4294967295)                                                                                                                                |
| `--max-concurrent-downloads`    | Maximum number of downloads we concurrently perform on this object store in a single IO node (format: 1..64)                                                                                       |
| `--max-concurrent-uploads`      | Maximum number of uploads we concurrently perform on this object store in a single IO node (format: 1..64)                                                                                         |
| `--max-concurrent-removals`     | Maximum number of removals we concurrently perform on this object store in a single IO node (format: 1..64)                                                                                        |
| `--max-extents-in-data-blob`    | Maximum number of extents' data to upload to an object store data blob                                                                                                                             |
| `--max-data-blob-size`          | Maximum size to upload to an object store data blob (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)                            |
| `--upload-memory-limit`         | Maximum RAM to allocate for concurrent uploads to this object store (per node) (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--enable-upload-tags`          | Enable tagging of uploaded objects                                                                                                                                                                 |
| `--sts-operation-type`          | AWS STS operation type to use. Default: none (format: 'assume\_role' or 'none')                                                                                                                    |
| `--sts-role-arn`                | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE                                                                                         |
| `--sts-role-session-name`       | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64.                                                                                         |
| `owed characters: upper and lo` | wer-case alphanumeric characters with no spaces.                                                                                                                                                   |

#### weka fs reserve

Thin provisioning reserve for organizations

```sh
weka fs reserve [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka fs reserve status**

Thin provisioning reserve for organizations

```sh
weka fs reserve status [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--format format]
                       [--output output]...
                       [--sort sort]...
                       [--filter filter]...
                       [--help]
                       [--raw-units]
                       [--UTC]
                       [--no-header]
                       [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: id,name,ssdReserve                                                                                                   |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka fs reserve set**

Set an organization's thin provisioning SSD reserve

```sh
weka fs reserve set <ssd-capacity>
                    [--org org]
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--help]
                    [--json]
                    [--raw-units]
                    [--UTC]

```

| Parameter                 | Description                                                                                                                                 |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `ssd-capacity`\*          | SSD capacity to reserve (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--org`                   | Organization name or ID                                                                                                                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                    |
| `-h`, `--help`            | Show help message                                                                                                                           |
| `-J`, `--json`            | Format output as JSON                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.           |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                       |

**weka fs reserve unset**

Unset an organization's thin provisioning SSD's reserve

```sh
weka fs reserve unset [--org org]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]
                      [--raw-units]
                      [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `--org`                   | Organization name or ID                                                                                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

### weka interface-group

List interface groups

```sh
weka interface-group [--name name]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--format format]
                     [--output output]...
                     [--sort sort]...
                     [--filter filter]...
                     [--help]
                     [--no-header]
                     [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Group name                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,name,mask,gateway,type,status,ips,ports,allowManageGids                                                          |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka interface-group assignment

List the currently assigned interface for each floating-IP address in the given interface-group. If is not supplied, assignments for all floating-IP addresses will be listed

```sh
weka interface-group assignment [--name name]
                                [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--format format]
                                [--output output]...
                                [--sort sort]...
                                [--filter filter]...
                                [--help]
                                [--no-header]
                                [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Group name                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: ip,host,port,group                                                                                                   |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka interface-group add

Create an interface group

```sh
weka interface-group add <name>
                         <type>
                         [--subnet subnet]
                         [--gateway gateway]
                         [--allow-manage-gids allow-manage-gids]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--format format]
                         [--output output]...
                         [--sort sort]...
                         [--filter filter]...
                         [--help]
                         [--no-header]
                         [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                             |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                                                                                                    |
| `type`\*                  | Group type                                                                                                                                                                                                              |
| `--subnet`                | subnet mask in the 255.255.0.0 format                                                                                                                                                                                   |
| `--gateway`               | gateway ip                                                                                                                                                                                                              |
| `--allow-manage-gids`     | Allow to use manage-gids in exports. With manage-gids, the list of group ids received from the client will be replaced by a list of group ids determined by an appropriate lookup on the server (format: 'on' or 'off') |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: name,mask,gateway,type,status,ips,ports,allowManageGids                                                                                              |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                 |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                              |

#### weka interface-group update

Update an interface group

```sh
weka interface-group update <name>
                            [--subnet subnet]
                            [--gateway gateway]
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                       |
| `--subnet`                | subnet mask in the 255.255.0.0 format                                                                      |
| `--gateway`               | gateway ip                                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka interface-group delete

Delete an interface group

```sh
weka interface-group delete <name>
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--force]
                            [--help]

```

| Parameter                 | Description                                                                                                                                                    |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                               |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                               |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                     |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                         |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                       |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected clients and can be undone by re-creating the interface group. |
| `-h`, `--help`            | Show help message                                                                                                                                              |

#### weka interface-group ip-range

Commands that manage interface-groups' ip-ranges

```sh
weka interface-group ip-range [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka interface-group ip-range add**

Add an ip range to an interface group

```sh
weka interface-group ip-range add <name>
                                  <ips>
                                  [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                       |
| `ips`\*                   | IP range (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka interface-group ip-range delete**

Delete an ip range from an interface group

```sh
weka interface-group ip-range delete <name>
                                     <ips>
                                     [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--force]
                                     [--help]

```

| Parameter                 | Description                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                                    |
| `ips`\*                   | IP range (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected clients and can be undone by re-creating the IP range. |
| `-h`, `--help`            | Show help message                                                                                                                                       |

#### weka interface-group port

Commands that manage interface-groups' ports

```sh
weka interface-group port [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka interface-group port add**

Add a server port to an interface group

```sh
weka interface-group port add <name>
                              <server-id>
                              <port>
                              [--HOST HOST]
                              [--PORT PORT]
                              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                              [--TIMEOUT TIMEOUT]
                              [--profile profile]
                              [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                       |
| `server-id`\*             | Server ID on which the port resides                                                                        |
| `port`\*                  | Port's device. (e.g. eth1)                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka interface-group port delete**

Delete a server port from an interface group

```sh
weka interface-group port delete <name>
                                 <server-id>
                                 <port>
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--force]
                                 [--help]

```

| Parameter                 | Description                                                                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                              |
| `server-id`\*             | Server ID on which the port resides                                                                                                               |
| `port`\*                  | Port's device. (e.g. eth1)                                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                                          |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected clients and can be undone by re-adding the port. |
| `-h`, `--help`            | Show help message                                                                                                                                 |

### weka local

Commands that control weka and its containers on the local machine

```sh
weka local [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka local install-agent

Installs Weka agent on the machine the command is executed from

```sh
weka local install-agent [--no-update] [--help]

```

| Parameter      | Description                                   |
| -------------- | --------------------------------------------- |
| `--no-update`  | Don't update the locally installed containers |
| `-h`, `--help` | Show help message                             |

#### weka local diags

Collect diagnostics from the local machine

```sh
weka local diags [--id id]
                 [--output-dir output-dir]
                 [--core-dump-limit core-dump-limit]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--collect-cluster-info]
                 [--tar]
                 [--verbose]
                 [--help]

```

| Parameter                      | Description                                                                                                       |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| `-i`, `--id`                   | A unique identifier for this dump                                                                                 |
| `-d`, `--output-dir`           | Directory to save the diags dump to, default: /opt/weka/diags                                                     |
| `-c`, `--core-dump-limit`      | Limit to processing this number of core dumps, if found (default: 1)                                              |
| `-H`, `--HOST`                 | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                  |
| `-P`, `--PORT`                 | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                  |
| `-C`, `--CONNECT-TIMEOUT`      | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `-T`, `--TIMEOUT`              | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)            |
| `--profile`                    | Name of the connection and authentication profile to use                                                          |
| `-s`, `--collect-cluster-info` | Collect cluster-related information. Warning: Use this flag on one host at a time to avoid straining the cluster. |
| `-t`, `--tar`                  | Create a TAR of all collected diags                                                                               |
| `-v`, `--verbose`              | Print results of all diags, including successful ones                                                             |
| `-h`, `--help`                 | Show help message                                                                                                 |

#### weka local events

List the events saved to the local drive. This command does not require authentication and can be used when Weka is turned off.

```sh
weka local events [--path path]
                  [--container-name container-name]
                  [--format format]
                  [--output output]...
                  [--sort sort]...
                  [--filter filter]...
                  [--help]
                  [--raw-units]
                  [--UTC]
                  [--no-header]
                  [--verbose]

```

| Parameter           | Description                                                                                                                                                                             |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--path`            | Path to where local events are stored                                                                                                                                                   |
| `--container-name`  | Name of the container whose events will be collected (default default)                                                                                                                  |
| `-f`, `--format`    | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`... | Specify which columns to output. May include any of the following: time,uuid,category,severity,permission,type,entity,node,parameters,hash                                              |
| `-s`, `--sort`...   | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`... | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`      | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units` | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`       | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`       | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`   | Show all columns in output                                                                                                                                                              |

#### weka local ps

List the Weka containers running on the machine this command is executed from

```sh
weka local ps [--format format]
              [--output output]...
              [--sort sort]...
              [--filter filter]...
              [--help]
              [--raw-units]
              [--UTC]
              [--no-header]
              [--verbose]

```

| Parameter           | Description                                                                                                                                                                                          |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-f`, `--format`    | Specify in what format to output the result. Available options are: view                                                                                                                             |
| `-o`, `--output`... | Specify which columns to output. May include any of the following: name,state,running,disabled,uptime,monitoring,persistent,port,pid,status,versionName,failureText,failure,failureTime,upgradeState |
| `-s`, `--sort`...   | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+              |
| `-F`, `--filter`... | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                     |
| `-h`, `--help`      | Show help message                                                                                                                                                                                    |
| `-R`, `--raw-units` | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                    |
| `-U`, `--UTC`       | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                |
| `--no-header`       | Don't show column headers when printing the output                                                                                                                                                   |
| `-v`, `--verbose`   | Show all columns in output                                                                                                                                                                           |

#### weka local rm

Delete a Weka container from the machine this command is executed from (this removed the data associated with the container, but retains the downloaded software)

```sh
weka local rm [--all] [--force] [--help] [<containers>]...

```

| Parameter       | Description                                                                                                                                                   |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `containers`... | The containers to remove                                                                                                                                      |
| `--all`         | Remove all containers                                                                                                                                         |
| `-f`, `--force` | Force this action without further confirmation. This would delete all data associated with the container(s) and can potentially lose all data in the cluster. |
| `-h`, `--help`  | Show help message                                                                                                                                             |

#### weka local start

Start a Weka container

```sh
weka local start [--wait-time wait-time] [--type type]... [--start-and-enable-dependent] [--help] [<container>]...

```

| Parameter                            | Description                                                                                                       |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| `container`...                       | The container to start                                                                                            |
| `-w`, `--wait-time`                  | How long to wait for the container to start (default: 15m) (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-t`, `--type`...                    | The container types to start                                                                                      |
| `-d`, `--start-and-enable-dependent` | Start and enable dependent containers even if we state container by name                                          |
| `-h`, `--help`                       | Show help message                                                                                                 |

#### weka local stop

Stop a Weka container

```sh
weka local stop [--reason reason] [--type type]... [--force] [--stop-and-disable-dependent] [--help] [<container>]...

```

| Parameter                            | Description                                                                        |
| ------------------------------------ | ---------------------------------------------------------------------------------- |
| `container`...                       | The container to stop                                                              |
| `--reason`                           | The reason weka was stopped, will be presented to the user during 'weka status'    |
| `-t`, `--type`...                    | The container types to stop                                                        |
| `-f`, `--force`                      | Stop containers even if there are active mounts                                    |
| `-d`, `--stop-and-disable-dependent` | Implictly stop and disable dependent containers even if we state container by name |
| `-h`, `--help`                       | Show help message                                                                  |

#### weka local restart

Restart a Weka container

```sh
weka local restart [--wait-time wait-time] [--type type]... [--help] [<container>]...

```

| Parameter           | Description                                                                                                       |
| ------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `container`...      | The container to restart                                                                                          |
| `-w`, `--wait-time` | How long to wait for the container to start (default: 15m) (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-t`, `--type`...   | The container types to restart                                                                                    |
| `-h`, `--help`      | Show help message                                                                                                 |

#### weka local status

Show the status of a Weka container

```sh
weka local status [--type type]... [--verbose] [--help] [--json] [<container>]...

```

| Parameter         | Description                          |
| ----------------- | ------------------------------------ |
| `container`...    | The container to display it's status |
| `-t`, `--type`... | The container types to show          |
| `-v`, `--verbose` | Verbose mode                         |
| `-h`, `--help`    | Show help message                    |
| `-J`, `--json`    | Format output as JSON                |

#### weka local enable

Enable monitoring for the requested containers so they automaticlly start on machine boot. This does not affect the current running status of the container. In order to change the current status, use the "weka local start/stop" commands. If no container names are specified, this command runs on all containers.

```sh
weka local enable [--type type]... [--help] [<container>]...

```

| Parameter         | Description                   |
| ----------------- | ----------------------------- |
| `container`...    | The container to enable       |
| `-t`, `--type`... | The container types to enable |
| `-h`, `--help`    | Show help message             |

#### weka local disable

Disable containers by not launching them on machine boot. This does not affect the current running status of the container. In order to change the current status, use the "weka local start/stop" commands. If no container names are specified, this command runs on all containers.

```sh
weka local disable [--type type]... [--help] [<container>]...

```

| Parameter         | Description                    |
| ----------------- | ------------------------------ |
| `container`...    | The container to disable       |
| `-t`, `--type`... | The container types to disable |
| `-h`, `--help`    | Show help message              |

#### weka local monitoring

Turn monitoring on/off for the given containers, or all containers if none are specified. When a container is started, it's always monitored. When a container is monitored, it will be restarted if it exits without being stopped through the CLI.

```sh
weka local monitoring <enabled> [--type type]... [--help] [<container>]...

```

| Parameter         | Description                                                    |
| ----------------- | -------------------------------------------------------------- |
| `enabled`\*       | Whether monitoring should be on or off (format: 'on' or 'off') |
| `container`...    | The container to disable                                       |
| `-t`, `--type`... | The container types to disable                                 |
| `-h`, `--help`    | Show help message                                              |

#### weka local run

Execute a command inside a new container that has the same mounts as the given container. If no container is specified, either "default" or the only defined container is selected. If no command is specified, opens an interactive shell.

```sh
weka local run [--container container] [--in in] [--environment environment]... [--help] [<command>]...

```

| Parameter                | Description                                 |
| ------------------------ | ------------------------------------------- |
| `-C`, `--container`      | The container to run in                     |
| `--in`                   | The container version to run the command in |
| `-e`, `--environment`... | Environment variable to add                 |
| `-h`, `--help`           | Show help message                           |

#### weka local reset-data

Resets the data directory for a given container, making the host no longer aware of the rest of the cluster

```sh
weka local reset-data [--container container] [--clean-unused] [--force] [--help] [<version-name>]...

```

| Parameter           | Description                                                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `version-name`...   | The versions to remove                                                                                                       |
| `-C`, `--container` | The container to run in                                                                                                      |
| `--clean-unused`    | Delete all container data directories for versions which aren't the current set version                                      |
| `-f`, `--force`     | Force this action without further confirmation. This action is destructive and can potentially lose all data in the cluster. |
| `-h`, `--help`      | Show help message                                                                                                            |

#### weka local resources

List and control container resources

```sh
weka local resources [--container container] [--stable] [--help] [--json] [--raw-units] [--UTC]

```

| Parameter           | Description                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-C`, `--container` | The container name                                                                                                                |
| `--stable`          | List the resources from the last successful container boot                                                                        |
| `-h`, `--help`      | Show help message                                                                                                                 |
| `-J`, `--json`      | Format output as JSON                                                                                                             |
| `-R`, `--raw-units` | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`       | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

**weka local resources import**

Import resources from file

```sh
weka local resources import <path> [--container container] [--with-identifiers] [--help] [--force]

```

| Parameter            | Description                                                                                                                                      |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `path`\*             | Path of file to import resources from                                                                                                            |
| `-C`, `--container`  | The container name                                                                                                                               |
| `--with-identifiers` | Import net device unique identifiers                                                                                                             |
| `-h`, `--help`       | Show help message                                                                                                                                |
| `-f`, `--force`      | Force this action without further confirmation. This action will override any resource changes that have not been applied, and cannot be undone. |

**weka local resources export**

Export stable resources to file

```sh
weka local resources export <path> [--container container] [--staging] [--stable] [--help]

```

| Parameter           | Description                                                                                     |
| ------------------- | ----------------------------------------------------------------------------------------------- |
| `path`\*            | Path to export resources                                                                        |
| `-C`, `--container` | The container name                                                                              |
| `--staging`         | List the resources from the currently staged resources that were not yet applied                |
| `--stable`          | List the resources from the currently stable resources, which are the last known good resources |
| `-h`, `--help`      | Show help message                                                                               |

**weka local resources restore**

Restore resources from Stable resources

```sh
weka local resources restore [--container container] [--help]

```

| Parameter           | Description        |
| ------------------- | ------------------ |
| `-C`, `--container` | The container name |
| `-h`, `--help`      | Show help message  |

**weka local resources apply**

Apply changes to resources locally

```sh
weka local resources apply [--container container] [--help] [--force]

```

| Parameter           | Description                                                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `-C`, `--container` | The container name                                                                                                        |
| `-h`, `--help`      | Show help message                                                                                                         |
| `-f`, `--force`     | Force this action without further confirmation. This action will restart the container on this host and cannot be undone. |

**weka local resources cores**

Change the core configuration of the host

```sh
weka local resources cores <cores>
                           [--container container]
                           [--frontend-dedicated-cores frontend-dedicated-cores]
                           [--drives-dedicated-cores drives-dedicated-cores]
                           [--compute-dedicated-cores compute-dedicated-cores]
                           [--core-ids core-ids]...
                           [--no-frontends]
                           [--only-drives-cores]
                           [--only-compute-cores]
                           [--only-frontend-cores]
                           [--allow-mix-setting]
                           [--help]

```

| Parameter                     | Description                                                                                                       |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `cores`\*                     | Number of CPU cores dedicated to weka - If set to 0 - no drive could be added to this host                        |
| `-C`, `--container`           | The container name                                                                                                |
| `--frontend-dedicated-cores`  | Number of cores dedicated to weka frontend (out of the total )                                                    |
| `--drives-dedicated-cores`    | Number of cores dedicated to weka drives (out of the total )                                                      |
| `--compute-dedicated-cores`   | Number of cores dedicated to weka compute (out of the total )                                                     |
| `-cores-ids`, `--core-ids`... | Specify the ids of weka dedicated cores                                                                           |
| `--no-frontends`              | Don't allocate frontend nodes                                                                                     |
| `--only-drives-cores`         | Create only nodes with a drives role                                                                              |
| `--only-compute-cores`        | Create only nodes with a compute role                                                                             |
| `--only-frontend-cores`       | Create only nodes with a frontend role                                                                            |
| `--allow-mix-setting`         | Allow specified cores-ids even if there are running containers with AUTO cores-ids allocation on the same server. |
| `-h`, `--help`                | Show help message                                                                                                 |

**weka local resources base-port**

Change the port-range used by the container. Weka containers require 100 ports to operate.

```sh
weka local resources base-port <base-port> [--container container] [--help]

```

| Parameter           | Description                                                                          |
| ------------------- | ------------------------------------------------------------------------------------ |
| `base-port`\*       | The first port that will be used by the Weka container, out of a total of 100 ports. |
| `-C`, `--container` | The container name                                                                   |
| `-h`, `--help`      | Show help message                                                                    |

**weka local resources memory**

Dedicate a set amount of RAM to weka

```sh
weka local resources memory <memory> [--container container] [--help]

```

| Parameter           | Description                                                                                                                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `memory`\*          | Memory dedicated to weka in bytes, set to 0 to let the system decide (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-C`, `--container` | The container name                                                                                                                                                                       |
| `-h`, `--help`      | Show help message                                                                                                                                                                        |

**weka local resources dedicate**

Set the host as dedicated to weka. For example it can be rebooted whenever needed, and configured by weka for optimal performance and stability

```sh
weka local resources dedicate <on> [--container container] [--help]

```

| Parameter           | Description                                                                               |
| ------------------- | ----------------------------------------------------------------------------------------- |
| `on`\*              | Set the host as weka dedicated, off unsets host as weka dedicated (format: 'on' or 'off') |
| `-C`, `--container` | The container name                                                                        |
| `-h`, `--help`      | Show help message                                                                         |

**weka local resources bandwidth**

Limit weka's bandwidth for the host

```sh
weka local resources bandwidth <bandwidth> [--container container] [--help]

```

| Parameter           | Description                                                                                                                                                                                |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `bandwidth`\*       | New bandwidth limitation per second (format: either "unlimited" or bandwidth per second in binary or decimal values: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-C`, `--container` | The container name                                                                                                                                                                         |
| `-h`, `--help`      | Show help message                                                                                                                                                                          |

**weka local resources management-ips**

Set the host's management node IPs. Setting 2 IPs will turn this hosts networking into highly-available mode

```sh
weka local resources management-ips [--container container] [--help] [<management-ips>]...

```

| Parameter           | Description                      |
| ------------------- | -------------------------------- |
| `management-ips`... | New IPs for the management nodes |
| `-C`, `--container` | The container name               |
| `-h`, `--help`      | Show help message                |

**weka local resources join-ips**

Set the IPs and ports of all hosts in the cluster. This will enable the host to join the cluster using these IPs.

```sh
weka local resources join-ips [--container container] [--help] [<management-ips>]...

```

| Parameter           | Description                                                                                                   |
| ------------------- | ------------------------------------------------------------------------------------------------------------- |
| `management-ips`... | New IP:port pairs for the management processes. If no port is used the command will use the default Weka port |
| `-C`, `--container` | The container name                                                                                            |
| `-h`, `--help`      | Show help message                                                                                             |

**weka local resources failure-domain**

Set the host failure-domain

```sh
weka local resources failure-domain [--container container] [--name name] [--auto] [--help]

```

| Parameter           | Description                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------- |
| `-C`, `--container` | The container name                                                                                 |
| `--name`            | Add this host to a named failure-domain. A failure-domain will be created if it doesn't exist yet. |
| `--auto`            | Set this host to be a failure-domain of its own                                                    |
| `-h`, `--help`      | Show help message                                                                                  |

**weka local resources net**

List and control container resources

```sh
weka local resources net [--container container] [--stable] [--help] [--json]

```

| Parameter           | Description                                                |
| ------------------- | ---------------------------------------------------------- |
| `-C`, `--container` | The container name                                         |
| `--stable`          | List the resources from the last successful container boot |
| `-h`, `--help`      | Show help message                                          |
| `-J`, `--json`      | Format output as JSON                                      |

**weka local resources net add**

Allocate a dedicated networking device on a host (to the cluster).

```sh
weka local resources net add <device>
                             [--container container]
                             [--gateway gateway]
                             [--netmask netmask]
                             [--name name]
                             [--label label]
                             [--vfs vfs]
                             [--ips ips]...
                             [--help]

```

| Parameter           | Description                                                                                                                                                                                                                                    |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `device`\*          | Network device pci-slot/mac-address/interface-name(s)                                                                                                                                                                                          |
| `-C`, `--container` | The container name                                                                                                                                                                                                                             |
| `--gateway`         | Default gateway IP. In AWS this value is auto-detected, otherwise the default data networking gateway will be used.                                                                                                                            |
| `--netmask`         | Netmask in bits number. In AWS this value is auto-detected, otherwise the default data networking netmask will be used.                                                                                                                        |
| `--name`            | If empty, a name will be auto generated.                                                                                                                                                                                                       |
| `--label`           | The name of the switch or network group to which this network device is attached                                                                                                                                                               |
| `--vfs`             | The number of VFs to preallocate (default is all supported by NIC)                                                                                                                                                                             |
| `--ips`...          | IPs to be allocated to cores using the device. If not given - IPs may be set automatically according the interface's IPs, or taken from the default networking IPs pool (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H) |
| `-h`, `--help`      | Show help message                                                                                                                                                                                                                              |

**weka local resources net remove**

Undedicate a networking device in a host.

```sh
weka local resources net remove <name> [--container container] [--help]

```

| Parameter           | Description                                                            |
| ------------------- | ---------------------------------------------------------------------- |
| `name`\*            | Net device name or identifier as appears in `weka local resources net` |
| `-C`, `--container` | The container name                                                     |
| `-h`, `--help`      | Show help message                                                      |

#### weka local setup

Container setup commands

```sh
weka local setup [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka local setup weka**

Setup a local weka container

```sh
weka local setup weka [--name name] [--disable] [--no-start] [--help]

```

| Parameter      | Description                                   |
| -------------- | --------------------------------------------- |
| `-n`, `--name` | The name to give the container                |
| `--disable`    | Should the container be created as disabled   |
| `--no-start`   | Do not start the container after its creation |
| `-h`, `--help` | Show help message                             |

**weka local setup container**

Setup a local weka container

```sh
weka local setup container [--name name]
                           [--cores cores]
                           [--frontend-dedicated-cores frontend-dedicated-cores]
                           [--drives-dedicated-cores drives-dedicated-cores]
                           [--compute-dedicated-cores compute-dedicated-cores]
                           [--memory memory]
                           [--bandwidth bandwidth]
                           [--failure-domain failure-domain]
                           [--timeout timeout]
                           [--container-id container-id]
                           [--base-port base-port]
                           [--resources-path resources-path]
                           [--weka-version weka-version]
                           [--core-ids core-ids]...
                           [--management-ips management-ips]...
                           [--join-ips join-ips]...
                           [--net net]...
                           [--disable]
                           [--no-start]
                           [--no-frontends]
                           [--only-drives-cores]
                           [--only-compute-cores]
                           [--only-frontend-cores]
                           [--allow-mix-setting]
                           [--dedicate]
                           [--force]
                           [--ignore-used-ports]
                           [--help]

```

| Parameter                     | Description                                                                                                                                                                              |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-n`, `--name`                | The name to give the container                                                                                                                                                           |
| `--cores`                     | Number of CPU cores dedicated to weka - If set to 0 - no drive could be added to this container                                                                                          |
| `--frontend-dedicated-cores`  | Number of cores dedicated to weka frontend (out of the total )                                                                                                                           |
| `--drives-dedicated-cores`    | Number of cores dedicated to weka drives (out of the total )                                                                                                                             |
| `--compute-dedicated-cores`   | Number of cores dedicated to weka compute (out of the total )                                                                                                                            |
| `--memory`                    | Memory dedicated to weka in bytes, set to 0 to let the system decide (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--bandwidth`                 | bandwidth limitation per second (format: either "unlimited" or bandwidth per second in binary or decimal values: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)   |
| `--failure-domain`            | Add this container to a named failure-domain. A failure-domain will be created if it doesn't exist yet. If not specified, an automatic failure domain will be assigned.                  |
| `-t`, `--timeout`             | Join command timeout in seconds (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                   |
| `--container-id`              | Decide on a specific container-id for the container to join using                                                                                                                        |
| `--base-port`                 | The first port that will be used by the Weka container, out of a total of 100 ports.                                                                                                     |
| `--resources-path`            | Import the container's resources from a file (additional command-line flags specified will override the resources in the file)                                                           |
| `--weka-version`              | Use the specified version to start the container in                                                                                                                                      |
| `-cores-ids`, `--core-ids`... | Specify the ids of weka dedicated cores                                                                                                                                                  |
| `--management-ips`...         | New IPs for the management nodes                                                                                                                                                         |
| `--join-ips`...               | New IP:port pairs for the management processes. If no port is used the command will use the default Weka port                                                                            |
| `--net`...                    | Network specification - /\[ip]/\[bits]/\[gateway]. Or: 'udp' to enforce UDP and avoid an attempt of auto deduction                                                                       |
| `--disable`                   | Should the container be created as disabled                                                                                                                                              |
| `--no-start`                  | Do not start the container after its creation                                                                                                                                            |
| `--no-frontends`              | Don't allocate frontend nodes                                                                                                                                                            |
| `--only-drives-cores`         | Create only nodes with a drives role                                                                                                                                                     |
| `--only-compute-cores`        | Create only nodes with a compute role                                                                                                                                                    |
| `--only-frontend-cores`       | Create only nodes with a frontend role                                                                                                                                                   |
| `--allow-mix-setting`         | Allow specified cores-ids even if there are running containers with AUTO cores-ids allocation on the same server.                                                                        |
| `--dedicate`                  | Set the host as weka dedicated                                                                                                                                                           |
| `--force`                     | Create a new container even if a container with the same name exists, disregarding all safety checks!                                                                                    |
| `--ignore-used-ports`         | Allow container to start even if the required ports are used by other processes                                                                                                          |
| `-h`, `--help`                | Show help message                                                                                                                                                                        |

#### weka local upgrade

Upgrade a Weka Host Container to its cluster version

```sh
weka local upgrade [--container container]
                   [--target-version target-version]
                   [--upgrade-container-timeout upgrade-container-timeout]
                   [--prepare-container-timeout prepare-container-timeout]
                   [--container-action-timeout container-action-timeout]
                   [--allow-not-ready]
                   [--dont-upgrade-agent]
                   [--upgrade-dependents]
                   [--all]
                   [--help]

```

| Parameter                     | Description                                                                                                                                |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `-C`, `--container`           | The container name                                                                                                                         |
| `-t`, `--target-version`      | Specify a specific target version for upgrade, instead of upgrading to the backend's version.                                              |
| `NOTE - This parameter is`    | DANGEROUS, use with caution. Incorrect usage may cause upgrade failure.                                                                    |
| `--upgrade-container-timeout` | How long to wait for the container to upgrade. default is 120s (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                      |
| `--prepare-container-timeout` | How long to wait for the container to prepare for upgrade. default is 120s (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)          |
| `--container-action-timeout`  | How long to wait for the container action to run before timing out and retrying 30s (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `--allow-not-ready`           | Allow starting local upgrade while the container is not fully up                                                                           |
| `--dont-upgrade-agent`        | Don't upgrade the weka agent                                                                                                               |
| `--upgrade-dependents`        | Upgrade dependent containers                                                                                                               |
| `--all`                       | Upgrade all containers                                                                                                                     |
| `-h`, `--help`                | Show help message                                                                                                                          |

### weka mount

Mounts a wekafs filesystem. This is the helper utility installed at /sbin/mount.wekafs.

```sh
weka mount <source>
           <target>
           [--option option]
           [--type type]
           [--no-mtab]
           [--sloppy]
           [--fake]
           [--verbose]
           [--help]
           [--raw-units]
           [--UTC]

```

| Parameter           | Description                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `source`\*          | Source filesystem to mount                                                                                                        |
| `target`\*          | Location to mount the source filesystem on                                                                                        |
| `-o`, `--option`    | Mount options                                                                                                                     |
| `-t`, `--type`      | The filesystem type                                                                                                               |
| `-n`, `--no-mtab`   | Mount without writing in /etc/mtab. This is necessary for example when /etc is on a read-only filesystem                          |
| `-s`, `--sloppy`    | Tolerate sloppy mount options rather than failing                                                                                 |
| `-f`, `--fake`      | Causes everything to be done except for the actual system call                                                                    |
| `-v`, `--verbose`   | Verbose mode                                                                                                                      |
| `-h`, `--help`      | Show help message                                                                                                                 |
| `-R`, `--raw-units` | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`       | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

### weka nfs

Commands that manage client-groups, permissions and interface-groups

```sh
weka nfs [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka nfs rules

Commands that manage NFS-rules

```sh
weka nfs rules [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs rules add**

Commands that add NFS-rules

```sh
weka nfs rules add [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs rules add dns**

Add a DNS rule to an NFS client group

```sh
weka nfs rules add dns <name>
                       <dns>
                       [--ip ip]
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Group name                                                                                                 |
| `dns`\*                   | DNS rule with \*?\[] wildcards rule                                                                        |
| `--ip`                    | IP with mask or CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka nfs rules add ip**

Add an IP rule to an NFS client group

```sh
weka nfs rules add ip <name>
                      <ip>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Group name                                                                                                 |
| `ip`\*                    | IP with CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka nfs rules delete**

Commands for deleting NFS-rules

```sh
weka nfs rules delete [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs rules delete dns**

Delete a DNS rule from an NFS client group

```sh
weka nfs rules delete dns <name>
                          <dns>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Group name                                                                                                 |
| `dns`\*                   | DNS rule with \*?\[] wildcards rule                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka nfs rules delete ip**

Delete an IP rule from an NFS client group

```sh
weka nfs rules delete ip <name>
                         <ip>
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Group name                                                                                                 |
| `ip`\*                    | IP with CIDR rule, in the 1.1.1.1/255.255.0.0 or 1.1.1.1/16 format                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka nfs client-group

Lists NFS client groups

```sh
weka nfs client-group [--name name]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--help]
                      [--no-header]
                      [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Group name                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,name,rules                                                                                                       |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka nfs client-group add**

Create an NFS client group

```sh
weka nfs client-group add <name>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--format format]
                          [--output output]...
                          [--sort sort]...
                          [--filter filter]...
                          [--help]
                          [--no-header]
                          [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Group name                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: name,rules                                                                                                           |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka nfs client-group delete**

Delete an NFS client group

```sh
weka nfs client-group delete <name>
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--force]
                             [--help]

```

| Parameter                 | Description                                                                                                                                                     |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Group name                                                                                                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                      |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                          |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                        |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected NFS clients and can be undone by re-creating the client group. |
| `-h`, `--help`            | Show help message                                                                                                                                               |

#### weka nfs permission

List NFS permissions for a filesystem

```sh
weka nfs permission [--filesystem filesystem]
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--format format]
                    [--output output]...
                    [--sort sort]...
                    [--filter filter]...
                    [--help]
                    [--no-header]
                    [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--filesystem`            | File system name                                                                                                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,filesystem,group,path,type,squash,auid,agid,obsdirect,manageGids,options,customOptions,privilegedPort,priority,supportedVersions |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                 |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                              |

**weka nfs permission add**

Allow a client group to access a file system

```sh
weka nfs permission add <filesystem>
                        <group>
                        [--path path]
                        [--permission-type permission-type]
                        [--root-squashing root-squashing]
                        [--squash squash]
                        [--anon-uid anon-uid]
                        [--anon-gid anon-gid]
                        [--obs-direct obs-direct]
                        [--manage-gids manage-gids]
                        [--privileged-port privileged-port]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--supported-versions supported-versions]...
                        [--force]
                        [--help]

```

| Parameter                 | Description                                                                                                                                                                                                                              |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `filesystem`\*            | File system name                                                                                                                                                                                                                         |
| `group`\*                 | Client group name                                                                                                                                                                                                                        |
| `--path`                  | path \[default: /]                                                                                                                                                                                                                       |
| `--permission-type`       | Permission type (format: 'ro' or 'rw')                                                                                                                                                                                                   |
| `--root-squashing`        | Root squashing (format: 'on' or 'off')                                                                                                                                                                                                   |
| `--squash`                | Permission squashing. NOTE - The option 'all' can be used only on interface groups with --allow-manage-gids=on (format: 'none', 'root' or 'all')                                                                                         |
| `--anon-uid`              | Anonymous UID to be used instead of root when root squashing is enabled                                                                                                                                                                  |
| `--anon-gid`              | Anonymous GID to be used instead of root when root squashing is enabled                                                                                                                                                                  |
| `--obs-direct`            | Obs direct (format: 'on' or 'off')                                                                                                                                                                                                       |
| `--manage-gids`           | the list of group ids received from the client will be replaced by a list of group ids determined by an appropriate lookup on the server. NOTE - this only works with a interface group which allows manage-gids (format: 'on' or 'off') |
| `--privileged-port`       | Privileged port (format: 'on' or 'off')                                                                                                                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                 |
| `--supported-versions`... | A comma-separated list of supported NFS versions (format: 'v3' or 'v4')                                                                                                                                                                  |
| `-f`, `--force`           | Force this action without further confirmation. This action will affect all NFS users of this permission/export, Use it with caution and consult the Weka Customer Success team at need.                                                 |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                        |

**weka nfs permission update**

Edit a file system permission

```sh
weka nfs permission update <filesystem>
                           <group>
                           [--path path]
                           [--permission-type permission-type]
                           [--root-squashing root-squashing]
                           [--squash squash]
                           [--anon-uid anon-uid]
                           [--anon-gid anon-gid]
                           [--obs-direct obs-direct]
                           [--manage-gids manage-gids]
                           [--custom-options custom-options]
                           [--privileged-port privileged-port]
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--supported-versions supported-versions]...
                           [--help]

```

| Parameter                 | Description                                                                                                                                                                                                                              |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `filesystem`\*            | File system name                                                                                                                                                                                                                         |
| `group`\*                 | Client group name                                                                                                                                                                                                                        |
| `--path`                  | path \[default: /]                                                                                                                                                                                                                       |
| `--permission-type`       | Permission type (format: 'ro' or 'rw')                                                                                                                                                                                                   |
| `--root-squashing`        | Root squashing (format: 'on' or 'off')                                                                                                                                                                                                   |
| `--squash`                | Permission squashing. NOTE - The option 'all' can be used only on interface groups with --allow-manage-gids=on (format: 'none', 'root' or 'all')                                                                                         |
| `--anon-uid`              | Anonymous UID to be used instead of root when root squashing is enabled                                                                                                                                                                  |
| `--anon-gid`              | Anonymous GID to be used instead of root when root squashing is enabled                                                                                                                                                                  |
| `--obs-direct`            | Obs direct (format: 'on' or 'off')                                                                                                                                                                                                       |
| `--manage-gids`           | the list of group ids received from the client will be replaced by a list of group ids determined by an appropriate lookup on the server. NOTE - this only works with a interface group which allows manage-gids (format: 'on' or 'off') |
| `--custom-options`        | Custom export options                                                                                                                                                                                                                    |
| `--privileged-port`       | Privileged port (format: 'on' or 'off')                                                                                                                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                 |
| `--supported-versions`... | A comma-separated list of supported NFS versions (format: 'v3' or 'v4')                                                                                                                                                                  |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                        |

**weka nfs permission delete**

Delete a file system permission

```sh
weka nfs permission delete <filesystem>
                           <group>
                           [--path path]
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--force]
                           [--help]

```

| Parameter                 | Description                                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `filesystem`\*            | File system name                                                                                                                                                         |
| `group`\*                 | Client group name                                                                                                                                                        |
| `--path`                  | path \[default: /]                                                                                                                                                       |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                 |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected NFS clients and can be undone by re-creating the filesystem permission. |
| `-h`, `--help`            | Show help message                                                                                                                                                        |

#### weka nfs interface-group

List interface groups

```sh
weka nfs interface-group [--name name]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--format format]
                         [--output output]...
                         [--sort sort]...
                         [--filter filter]...
                         [--help]
                         [--no-header]
                         [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Group name                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,name,mask,gateway,type,status,ips,ports,allowManageGids                                                          |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka nfs interface-group assignment**

List the currently assigned interface for each floating-IP address in the given interface-group. If is not supplied, assignments for all floating-IP addresses will be listed

```sh
weka nfs interface-group assignment [--name name]
                                    [--HOST HOST]
                                    [--PORT PORT]
                                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                    [--TIMEOUT TIMEOUT]
                                    [--profile profile]
                                    [--format format]
                                    [--output output]...
                                    [--sort sort]...
                                    [--filter filter]...
                                    [--help]
                                    [--no-header]
                                    [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Group name                                                                                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: ip,host,port,group                                                                                                   |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka nfs interface-group add**

Create an interface group

```sh
weka nfs interface-group add <name>
                             <type>
                             [--subnet subnet]
                             [--gateway gateway]
                             [--allow-manage-gids allow-manage-gids]
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--format format]
                             [--output output]...
                             [--sort sort]...
                             [--filter filter]...
                             [--help]
                             [--no-header]
                             [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                             |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                                                                                                    |
| `type`\*                  | Group type. cli subnet type can be NFS                                                                                                                                                                                  |
| `--subnet`                | subnet mask in the 255.255.0.0 format                                                                                                                                                                                   |
| `--gateway`               | gateway ip                                                                                                                                                                                                              |
| `--allow-manage-gids`     | Allow to use manage-gids in exports. With manage-gids, the list of group ids received from the client will be replaced by a list of group ids determined by an appropriate lookup on the server (format: 'on' or 'off') |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: name,mask,gateway,type,status,ips,ports,allowManageGids                                                                                              |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                 |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                              |

**weka nfs interface-group update**

Update an interface group

```sh
weka nfs interface-group update <name>
                                [--subnet subnet]
                                [--gateway gateway]
                                [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                       |
| `--subnet`                | subnet mask in the 255.255.0.0 format                                                                      |
| `--gateway`               | gateway ip                                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka nfs interface-group delete**

Delete an interface group

```sh
weka nfs interface-group delete <name>
                                [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--force]
                                [--help]

```

| Parameter                 | Description                                                                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `name`\*                  | Interface group name                                                                                                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                   |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                   |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                         |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                             |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                           |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected NFS clients and can be undone by re-creating the interface group. |
| `-h`, `--help`            | Show help message                                                                                                                                                  |

**weka nfs interface-group ip-range**

Commands that manage nfs interface-groups' ip-ranges

```sh
weka nfs interface-group ip-range [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs interface-group ip-range add**

Add an ip range to an interface group

```sh
weka nfs interface-group ip-range add <name>
                                      <ips>
                                      [--HOST HOST]
                                      [--PORT PORT]
                                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                      [--TIMEOUT TIMEOUT]
                                      [--profile profile]
                                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                       |
| `ips`\*                   | IP range (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka nfs interface-group ip-range delete**

Delete an ip range from an interface group

```sh
weka nfs interface-group ip-range delete <name>
                                         <ips>
                                         [--HOST HOST]
                                         [--PORT PORT]
                                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                         [--TIMEOUT TIMEOUT]
                                         [--profile profile]
                                         [--force]
                                         [--help]

```

| Parameter                 | Description                                                                                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                                        |
| `ips`\*                   | IP range (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                    |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected NFS clients and can be undone by re-creating the IP range. |
| `-h`, `--help`            | Show help message                                                                                                                                           |

**weka nfs interface-group port**

Commands that manage nfs interface-groups' ports

```sh
weka nfs interface-group port [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs interface-group port add**

Add a server port to an interface group

```sh
weka nfs interface-group port add <name>
                                  <server-id>
                                  <port>
                                  [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                       |
| `server-id`\*             | Server ID on which the port resides                                                                        |
| `port`\*                  | Port's device. (e.g. eth1)                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka nfs interface-group port delete**

Delete a server port from an interface group

```sh
weka nfs interface-group port delete <name>
                                     <server-id>
                                     <port>
                                     [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--force]
                                     [--help]

```

| Parameter                 | Description                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Interface group name                                                                                                                                  |
| `server-id`\*             | Server ID on which the port resides                                                                                                                   |
| `port`\*                  | Port's device. (e.g. eth1)                                                                                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                      |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                      |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                            |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                |
| `--profile`               | Name of the connection and authentication profile to use                                                                                              |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected NFS clients and can be undone by re-adding the port. |
| `-h`, `--help`            | Show help message                                                                                                                                     |

#### weka nfs debug-level

Manage debug level for nfs servers.

```sh
weka nfs debug-level [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs debug-level show**

Get debug level for nfs servers.

```sh
weka nfs debug-level show [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--format format]
                          [--nfs-hosts nfs-hosts]...
                          [--output output]...
                          [--sort sort]...
                          [--filter filter]...
                          [--help]
                          [--no-header]
                          [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `--nfs-hosts`...          | Only return these host IDs (pass weka's host id as a number). All hosts as default                                                                                                      |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: host,debugLevel                                                                                                      |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka nfs debug-level set**

Set debug level for nfs servers. Return to default (EVENT) when finish debugging.

```sh
weka nfs debug-level set <level>
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--nfs-hosts nfs-hosts]...
                         [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `level`\*                 | The debug level, can be one of this options: EVENT, INFO, DEBUG, MID\_DEBUG, FULL\_DEBUG                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--nfs-hosts`...          | Hosts to set debug level (pass weka's host id as a number). All hosts as default                           |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka nfs global-config

NFS Global Configuration

```sh
weka nfs global-config [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs global-config set**

Set NFS global configuration options

```sh
weka nfs global-config set [--mountd-port mountd-port]
                           [--config-fs config-fs]
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--default-supported-versions default-supported-versions]...
                           [--help]
                           [--force]

```

| Parameter                         | Description                                                                                                |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--mountd-port`                   | Configure the port number of the mountd service                                                            |
| `--config-fs`                     | NFSv4 config filesystem name, use "" to invalidate                                                         |
| `-H`, `--HOST`                    | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`                    | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT`         | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`                 | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`                       | Name of the connection and authentication profile to use                                                   |
| `--default-supported-versions`... | A comma-separated list of the default supported NFS versions for new permissions (format: 'v3' or 'v4')    |
| `-h`, `--help`                    | Show help message                                                                                          |
| `-f`, `--force`                   | Force this action without further confirmation. This may cause a temporary disruption in the NFS service.  |

**weka nfs global-config show**

Show the NFS global configuration

```sh
weka nfs global-config show [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]
                            [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka nfs clients

NFS Clients usage information

```sh
weka nfs clients [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka nfs clients show**

Show NFS Clients usage information. If no options are given, all NFS Ganesha containers will be selected.

```sh
weka nfs clients show [--interface-group interface-group]
                      [--container-id container-id]
                      [--fip fip]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--help]
                      [--no-header]
                      [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--interface-group`       | interface-group-name                                                                                                                                                                    |
| `--container-id`          | container-id                                                                                                                                                                            |
| `--fip`                   | floating-ip                                                                                                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: hostid,client\_ip,idle\_time,num\_v3\_ops,num\_v4\_ops,num\_v4\_open\_ops,num\_v4\_close\_ops                        |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

### weka org

List organizations defined in the Weka cluster

```sh
weka org [--HOST HOST]
         [--PORT PORT]
         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
         [--TIMEOUT TIMEOUT]
         [--profile profile]
         [--format format]
         [--output output]...
         [--sort sort]...
         [--filter filter]...
         [--help]
         [--raw-units]
         [--UTC]
         [--no-header]
         [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,name,allocSSD,quotaSSD,allocTotal,quotaTotal                                                                  |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka org create

Create a new organization in the Weka cluster

```sh
weka org create <name>
                <username>
                [password]
                [--ssd-quota ssd-quota]
                [--total-quota total-quota]
                [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--help]
                [--json]

```

| Parameter                 | Description                                                                                                                     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Organization name                                                                                                               |
| `username`\*              | Username of organization admin                                                                                                  |
| `password`                | Password of organization admin                                                                                                  |
| `--ssd-quota`             | SSD quota (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)   |
| `--total-quota`           | Total quota (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                      |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                          |
| `--profile`               | Name of the connection and authentication profile to use                                                                        |
| `-h`, `--help`            | Show help message                                                                                                               |
| `-J`, `--json`            | Format output as JSON                                                                                                           |

#### weka org rename

Change an organization name

```sh
weka org rename <org>
                <new-name>
                [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--help]
                [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `org`\*                   | Current organization name or ID                                                                            |
| `new-name`\*              | New organization name                                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka org set-quota

Set an organization's SSD and/or total quotas

```sh
weka org set-quota <org>
                   [--ssd-quota ssd-quota]
                   [--total-quota total-quota]
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--help]
                   [--json]

```

| Parameter                 | Description                                                                                                                     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `org`\*                   | Organization name or ID                                                                                                         |
| `--ssd-quota`             | SSD quota (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB)   |
| `--total-quota`           | Total quota (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                      |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                          |
| `--profile`               | Name of the connection and authentication profile to use                                                                        |
| `-h`, `--help`            | Show help message                                                                                                               |
| `-J`, `--json`            | Format output as JSON                                                                                                           |

#### weka org delete

Delete an organization

```sh
weka org delete <org>
                [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--force]
                [--help]
                [--json]

```

| Parameter                 | Description                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `org`\*                   | Organization name or ID                                                                                                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                 |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                 |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                       |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                           |
| `--profile`               | Name of the connection and authentication profile to use                                                                                         |
| `-f`, `--force`           | Force this action without further confirmation. This action will DELETE ALL DATA stored in this organization's filesystems and cannot be undone. |
| `-h`, `--help`            | Show help message                                                                                                                                |
| `-J`, `--json`            | Format output as JSON                                                                                                                            |

### weka security

Security commands.

```sh
weka security [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka security kms

List the currently configured key management service settings

```sh
weka security kms [--HOST HOST]
                  [--PORT PORT]
                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                  [--TIMEOUT TIMEOUT]
                  [--profile profile]
                  [--help]
                  [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka security kms set**

Configure the active KMS

```sh
weka security kms set <type>
                      <address>
                      <key-identifier>
                      [--token token]
                      [--namespace namespace]
                      [--client-cert client-cert]
                      [--client-key client-key]
                      [--ca-cert ca-cert]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `type`\*                  | KMS type, one of \["vault", "kmip"]                                                                        |
| `address`\*               | Server address, usually a hostname:port or a URL                                                           |
| `key-identifier`\*        | Key to secure the filesystem keys with, e.g a key name (for Vault) or a key uid (for KMIP)                 |
| `--token`                 | auth: API token to access the KMS                                                                          |
| `--namespace`             | Namespace (Vault, optional)                                                                                |
| `--client-cert`           | auth: Path to the client certificate PEM file                                                              |
| `--client-key`            | auth: Path to the client key PEM file                                                                      |
| `--ca-cert`               | auth: Path to the CA certificate PEM file                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security kms unset**

Remove external KMS configurations. This will fail if there are any encrypted filesystems that rely on the KMS.

```sh
weka security kms unset [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--allow-downgrade]
                        [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--allow-downgrade`       | Allows downgrading existing encrypted filesystems to local encryption instead of a KMS                     |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security kms rewrap**

Rewraps all the master filesystem keys using the configured KMS. This can be used to rewrap with a rotated KMS key, or to change wrapping to the newly-configured KMS.

```sh
weka security kms rewrap [--new-key-uid new-key-uid]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--new-key-uid`           | (KMIP-only) Unique identifier for the new key to be used to wrap filesystem keys                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka security tls

TLS commands.

```sh
weka security tls [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka security tls status**

Show the Weka cluster TLS status and certificate

```sh
weka security tls status [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]
                         [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka security tls download**

Download the Weka cluster TLS certificate

```sh
weka security tls download <path>
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `path`\*                  | Path to output file                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security tls set**

Make Ngnix use TLS when accessing UI. If TLS already set this command updates the key and certificate.

```sh
weka security tls set [--private-key private-key]
                      [--certificate certificate]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--private-key`           | Path to TLS private key pem file                                                                           |
| `--certificate`           | Path to TLS certificate pem file                                                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security tls unset**

Make Ngnix not use TLS when accessing UI

```sh
weka security tls unset [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka security lockout-config

Commands used to interact with the account lockout config parameters

```sh
weka security lockout-config [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka security lockout-config set**

Configure the number of failed attempts before lockout and the duration of lock

```sh
weka security lockout-config set [--failed-attempts failed-attempts]
                                 [--lockout-duration lockout-duration]
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--help]

```

| Parameter                 | Description                                                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `--failed-attempts`       | Number of consecutive failed logins before user account locks out                                                        |
| `--lockout-duration`      | How long the account should be locked out for after failed logins (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                 |
| `-h`, `--help`            | Show help message                                                                                                        |

**weka security lockout-config reset**

Reset the number of failed attempts before lockout and the duration of lock to their defaults

```sh
weka security lockout-config reset [--HOST HOST]
                                   [--PORT PORT]
                                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                   [--TIMEOUT TIMEOUT]
                                   [--profile profile]
                                   [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security lockout-config show**

Show the current number of attempts needed to lockout and how long the lockout is for

```sh
weka security lockout-config show [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]
                                  [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka security login-banner

Commands used to view and edit the login banner

```sh
weka security login-banner [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka security login-banner set**

Set the login banner

```sh
weka security login-banner set <login-banner>
                               [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `login-banner`\*          | Text banner to be displayed before the user logs into the web UI                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security login-banner reset**

Resets the login banner back to the default state (empty)

```sh
weka security login-banner reset [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security login-banner enable**

Enable the login banner

```sh
weka security login-banner enable [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]
                                  [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka security login-banner disable**

Disable the login banner

```sh
weka security login-banner disable [--HOST HOST]
                                   [--PORT PORT]
                                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                   [--TIMEOUT TIMEOUT]
                                   [--profile profile]
                                   [--help]
                                   [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka security login-banner show**

Show the current login banner

```sh
weka security login-banner show [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]
                                [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka security ca-cert

Commands handling custom CA signed certificate

```sh
weka security ca-cert [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka security ca-cert set**

Add a custom certificate to the certificates list. If a custom certificate is already set, this command updates it.

```sh
weka security ca-cert set [--cert-file cert-file]
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--cert-file`             | Path to certificate file                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security ca-cert status**

Show the Weka cluster CA-cert status and certificate

```sh
weka security ca-cert status [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--help]
                             [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka security ca-cert download**

Download the Weka cluster custom certificate, if such certificate was set

```sh
weka security ca-cert download <path>
                               [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `path`\*                  | Path to output file                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka security ca-cert unset**

Unsets custom CA signed certificate from cluster

```sh
weka security ca-cert unset [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

### weka smb

Commands that manage Weka's SMB container

```sh
weka smb [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka smb cluster

View info about the SMB cluster managed by weka

```sh
weka smb cluster [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--help]
                 [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb cluster containers**

Update an SMB cluster containers

```sh
weka smb cluster containers [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka smb cluster containers add**

Update an SMB cluster

```sh
weka smb cluster containers add [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--container-ids container-ids]...
                                [--help]
                                [--force]

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `--container-ids`...      | The SMB containers being added (pass weka's host id as a number)                                              |
| `-h`, `--help`            | Show help message                                                                                             |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients. |

**weka smb cluster containers remove**

Update an SMB cluster

```sh
weka smb cluster containers remove [--HOST HOST]
                                   [--PORT PORT]
                                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                   [--TIMEOUT TIMEOUT]
                                   [--profile profile]
                                   [--container-ids container-ids]...
                                   [--help]
                                   [--force]

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `--container-ids`...      | The SMB containers being removed (pass weka's container id as a number)                                       |
| `-h`, `--help`            | Show help message                                                                                             |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients. |

**weka smb cluster wait**

Wait for SMB cluster to become ready

```sh
weka smb cluster wait [--timeout timeout]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-t`, `--timeout`         | Timeout (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka smb cluster update**

Update an SMB cluster

```sh
weka smb cluster update [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--encryption encryption]
                        [--smb-ips-pool smb-ips-pool]...
                        [--smb-ips-range smb-ips-range]...
                        [--help]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `--encryption`            | Encryption (format: 'enabled', 'disabled', 'desired' or 'required')                                                                                                                     |
| `--smb-ips-pool`...       | IPs used as floating IPs for SMB to serve in a HA manner. Then should not be assigned to any host on the network                                                                        |
| `--smb-ips-range`...      | IPs used as floating IPs for SMB to serve in a HA manner. Then should not be assigned to any host on the network (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H) |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |

**weka smb cluster create**

Create a SMB cluster managed by weka

```sh
weka smb cluster create <netbios-name>
                        <domain>
                        <config-fs-name>
                        [--domain-netbios-name domain-netbios-name]
                        [--idmap-backend idmap-backend]
                        [--default-domain-mapping-from-id default-domain-mapping-from-id]
                        [--default-domain-mapping-to-id default-domain-mapping-to-id]
                        [--joined-domain-mapping-from-id joined-domain-mapping-from-id]
                        [--joined-domain-mapping-to-id joined-domain-mapping-to-id]
                        [--encryption encryption]
                        [--smb-conf-extra smb-conf-extra]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--container-ids container-ids]...
                        [--smb-ips-pool smb-ips-pool]...
                        [--smb-ips-range smb-ips-range]...
                        [--smb]
                        [--help]

```

| Parameter                          | Description                                                                                                                                                                                                                                                     |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `netbios-name`\*                   | The netbios name to give to the SMB cluster                                                                                                                                                                                                                     |
| `domain`\*                         | The domain to join the SMB cluster to                                                                                                                                                                                                                           |
| `config-fs-name`\*                 | SMB config filesystem name                                                                                                                                                                                                                                      |
| `--domain-netbios-name`            | The domain netbios name; If not given, the default will be the first part of the given domain name                                                                                                                                                              |
| `--idmap-backend`                  | The SMB domain backend type (rid, rfc2307, etc.). Note that rfc2307 requires uid/gid configuration on the Active Directory and is persistent, while rid does not require any Active Directory configuration but in case of range changes uids/gids could break. |
| `--default-domain-mapping-from-id` | The SMB default domain first id                                                                                                                                                                                                                                 |
| `--default-domain-mapping-to-id`   | The SMB default domain last id                                                                                                                                                                                                                                  |
| `--joined-domain-mapping-from-id`  | The joined domain first id                                                                                                                                                                                                                                      |
| `--joined-domain-mapping-to-id`    | The joined domain last id                                                                                                                                                                                                                                       |
| `--encryption`                     | Encryption (format: 'enabled', 'disabled', 'desired' or 'required')                                                                                                                                                                                             |
| `--smb-conf-extra`                 | Extra smb configuration options                                                                                                                                                                                                                                 |
| `-H`, `--HOST`                     | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                |
| `-P`, `--PORT`                     | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                |
| `-C`, `--CONNECT-TIMEOUT`          | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                      |
| `-T`, `--TIMEOUT`                  | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                          |
| `--profile`                        | Name of the connection and authentication profile to use                                                                                                                                                                                                        |
| `--container-ids`...               | The containers that will serve via the SMB protocol (pass weka's container id as a number)                                                                                                                                                                      |
| `--smb-ips-pool`...                | IPs used as floating IPs for samba to server SMB in a HA manner. Then should not be assigned to any container on the network                                                                                                                                    |
| `--smb-ips-range`...               | IPs used as floating IPs for samba to server SMB in a HA manner. Then should not be assigned to any container on the network (format: A.B.C.D-E.F.G.H or A.B.C.D-F.G.H or A.B.C.D-G.H or A.B.C.D-H)                                                             |
| `--smb`                            | SMB Legacy cluster type                                                                                                                                                                                                                                         |
| `-h`, `--help`                     | Show help message                                                                                                                                                                                                                                               |

**weka smb cluster debug**

Set debug level in an SMB container

```sh
weka smb cluster debug <level>
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--container-ids container-ids]...
                       [--help]
                       [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `level`\*                 | The debug level                                                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--container-ids`...      | Hosts to set debug level (pass weka's host id as a number). All hosts as default                           |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb cluster destroy**

Destroy the SMB cluster managed by weka. This will not delete the data, just stop exposing it via SMB

```sh
weka smb cluster destroy [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--force]
                         [--help]

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients. |
| `-h`, `--help`            | Show help message                                                                                             |

**weka smb cluster trusted-domains**

List all trusted domains

```sh
weka smb cluster trusted-domains [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--format format]
                                 [--output output]...
                                 [--sort sort]...
                                 [--filter filter]...
                                 [--help]
                                 [--no-header]
                                 [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: id,domain,idmap,from,to                                                                                              |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka smb cluster trusted-domains add**

Add a new trusted domain

```sh
weka smb cluster trusted-domains add <domain-name>
                                     <from-id>
                                     <to-id>
                                     [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--force]
                                     [--help]
                                     [--json]

```

| Parameter                 | Description                                                                                                                                 |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `domain-name`\*           | The name of the domain being added                                                                                                          |
| `from-id`\*               | The first id                                                                                                                                |
| `to-id`\*                 | The last id                                                                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                    |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients and modify existing uids/gids. |
| `-h`, `--help`            | Show help message                                                                                                                           |
| `-J`, `--json`            | Format output as JSON                                                                                                                       |

**weka smb cluster trusted-domains remove**

Remove a trusted domain

```sh
weka smb cluster trusted-domains remove <trusteddomain-id>
                                        [--HOST HOST]
                                        [--PORT PORT]
                                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                        [--TIMEOUT TIMEOUT]
                                        [--profile profile]
                                        [--force]
                                        [--help]

```

| Parameter                 | Description                                                                                                                                 |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| `trusteddomain-id`\*      | The id of the domain to remove                                                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                    |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients and modify existing uids/gids. |
| `-h`, `--help`            | Show help message                                                                                                                           |

**weka smb cluster status**

Show which of the containers are ready.

```sh
weka smb cluster status [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb cluster host-access**

Show host access help

```sh
weka smb cluster host-access [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka smb cluster host-access list**

Show host access list

```sh
weka smb cluster host-access list [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--format format]
                                  [--output output]...
                                  [--sort sort]...
                                  [--filter filter]...
                                  [--help]
                                  [--no-header]
                                  [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: id,mode,hostname                                                                                                     |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka smb cluster host-access reset**

Reset host access lists

```sh
weka smb cluster host-access reset <mode>
                                   [--HOST HOST]
                                   [--PORT PORT]
                                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                   [--TIMEOUT TIMEOUT]
                                   [--profile profile]
                                   [--force]
                                   [--help]
                                   [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `mode`\*                  | allow/deny host access (format: 'allow' or 'deny')                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-f`, `--force`           | Force this action without further confirmation. This action will delete all host access ips.               |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb cluster host-access add**

Add hosts to host access lists

```sh
weka smb cluster host-access add <mode>
                                 [--timeout timeout]
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--ips ips]...
                                 [--hosts hosts]...
                                 [--force]
                                 [--help]
                                 [--json]

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `mode`\*                  | allow/deny host access (format: 'allow' or 'deny')                                                            |
| `-t`, `--timeout`         | Timeout in seconds (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `--ips`...                | ips to add                                                                                                    |
| `--hosts`...              | hosts to add                                                                                                  |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients. |
| `-h`, `--help`            | Show help message                                                                                             |
| `-J`, `--json`            | Format output as JSON                                                                                         |

**weka smb cluster host-access remove**

Remove hosts from a user list

```sh
weka smb cluster host-access remove [--HOST HOST]
                                    [--PORT PORT]
                                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                    [--TIMEOUT TIMEOUT]
                                    [--profile profile]
                                    [--force]
                                    [--help]
                                    [--json]
                                    [<hosts>]...

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `hosts`...                | hosts to remove                                                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients. |
| `-h`, `--help`            | Show help message                                                                                             |
| `-J`, `--json`            | Format output as JSON                                                                                         |

#### weka smb share

List all shares exposed via SMB

```sh
weka smb share [--HOST HOST]
               [--PORT PORT]
               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
               [--TIMEOUT TIMEOUT]
               [--profile profile]
               [--format format]
               [--output output]...
               [--sort sort]...
               [--filter filter]...
               [--help]
               [--no-header]
               [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                              |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                         |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                         |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                               |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                   |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                 |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                 |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: id,share,filesystem,description,path,fmask,dmask,acls,options,additional,direct,encryption,validUsers,invalidUsers,readonlyUsers,readwriteUsers,readonlyShare,allowGuestAccess,hidden |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                  |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                         |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                        |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                       |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                               |

**weka smb share update**

Update an SMB share

```sh
weka smb share update <share-id>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--encryption encryption]
                      [--read-only read-only]
                      [--allow-guest-access allow-guest-access]
                      [--hidden hidden]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `share-id`\*              | The id of the share to update                                                                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--encryption`            | Encryption (format: 'cluster\_default', 'desired' or 'required')                                           |
| `--read-only`             | Mount as read-only (format: 'on' or 'off')                                                                 |
| `--allow-guest-access`    | Allow Guest Access (format: 'on' or 'off')                                                                 |
| `--hidden`                | Hidden (format: 'on' or 'off')                                                                             |
| `-h`, `--help`            | Show help message                                                                                          |

**weka smb share lists**

Show lists help

```sh
weka smb share lists [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka smb share lists show**

Show user lists

```sh
weka smb share lists show [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--format format]
                          [--output output]...
                          [--sort sort]...
                          [--filter filter]...
                          [--help]
                          [--no-header]
                          [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,share,readonly,validusers,invalidusers,readonlyusers,readwriteusers                                           |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka smb share lists reset**

Reset a user list

```sh
weka smb share lists reset <share-id>
                           <user-list-type>
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--help]
                           [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `share-id`\*              | The id of the share                                                                                        |
| `user-list-type`\*        | The list type (format: 'read\_only', 'read\_write', 'valid' or 'invalid')                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb share lists add**

Add users to a user list

```sh
weka smb share lists add <share-id>
                         <user-list-type>
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--users users]...
                         [--help]
                         [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `share-id`\*              | The id of the share                                                                                        |
| `user-list-type`\*        | The list type (format: 'read\_only', 'read\_write', 'valid' or 'invalid')                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--users`...              | Users to add                                                                                               |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb share lists remove**

Remove users from a user list

```sh
weka smb share lists remove <share_id>
                            <user-list-type>
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--users users]...
                            [--help]
                            [--json]

```

| Parameter                 | Description                                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `share_id`\*              | The id of the share being removed from                                                                      |
| `user-list-type`\*        | The list type from which users are removed from (format: 'read\_only', 'read\_write', 'valid' or 'invalid') |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)      |
| `--profile`               | Name of the connection and authentication profile to use                                                    |
| `--users`...              | Users to remove                                                                                             |
| `-h`, `--help`            | Show help message                                                                                           |
| `-J`, `--json`            | Format output as JSON                                                                                       |

**weka smb share add**

Add a new share to be exposed by SMB

```sh
weka smb share add <share-name>
                   <fs-name>
                   [--description description]
                   [--internal-path internal-path]
                   [--file-create-mask file-create-mask]
                   [--directory-create-mask directory-create-mask]
                   [--mount-option mount-option]
                   [--acl acl]
                   [--obs-direct obs-direct]
                   [--encryption encryption]
                   [--read-only read-only]
                   [--user-list-type user-list-type]
                   [--allow-guest-access allow-guest-access]
                   [--hidden hidden]
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--share-option share-option]...
                   [--users users]...
                   [--force]
                   [--help]
                   [--json]

```

| Parameter                 | Description                                                                                                                                                                  |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `share-name`\*            | The name of the share being added                                                                                                                                            |
| `fs-name`\*               | Filesystem name to share                                                                                                                                                     |
| `--description`           | A description for SMB to show regarding the share                                                                                                                            |
| `--internal-path`         | The path inside the filesystem to share                                                                                                                                      |
| `--file-create-mask`      | POSIX mode mask files will be created with. E.g. "0744"                                                                                                                      |
| `--directory-create-mask` | POSIX mode mask directories will be created with. E.g. "0755"                                                                                                                |
| `-o`, `--mount-option`    | Option to pass to the mount command when mounting weka. NOTE - This parameter is DANGEROUS, use with caution. Incorrect usage may lead to DATA LOSS.                         |
| `--acl`                   | Enable Windows ACLs on the share. Will also be translated (as possible) to POSIX ACLs. (format: 'on' or 'off')                                                               |
| `--obs-direct`            | Mount share in obs-direct mode (format: 'on' or 'off')                                                                                                                       |
| `--encryption`            | Encryption (format: 'cluster\_default', 'desired' or 'required')                                                                                                             |
| `--read-only`             | Mount share as read-only (format: 'on' or 'off')                                                                                                                             |
| `--user-list-type`        | The list type to which users are added to (format: 'read\_only', 'read\_write', 'valid' or 'invalid')                                                                        |
| `--allow-guest-access`    | Allow guests to access the share (format: 'on' or 'off')                                                                                                                     |
| `--hidden`                | Hidden (format: 'on' or 'off')                                                                                                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                             |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                             |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                   |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                       |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                     |
| `--share-option`...       | Additional options to pass on to SMB. NOTE - This parameter is DANGEROUS, use with caution. Incorrect usage may lead to DATA LOSS.                                           |
| `--users`...              | Users to add                                                                                                                                                                 |
| `-f`, `--force`           | Force this action without further confirmation. This action will affect all SMB users of this share, Use it with caution and consult the Weka Customer Success team at need. |
| `-h`, `--help`            | Show help message                                                                                                                                                            |
| `-J`, `--json`            | Format output as JSON                                                                                                                                                        |

**weka smb share remove**

Remove a share exposed by SMB

```sh
weka smb share remove <share-id>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--force]
                      [--help]

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `share-id`\*              | The id of the share to remove                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected SMB clients. |
| `-h`, `--help`            | Show help message                                                                                             |

**weka smb share host-access**

Show host access help

```sh
weka smb share host-access [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka smb share host-access list**

Show host access list

```sh
weka smb share host-access list [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--format format]
                                [--output output]...
                                [--sort sort]...
                                [--filter filter]...
                                [--help]
                                [--no-header]
                                [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,share,mode,hostname                                                                                           |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka smb share host-access reset**

Reset host access lists

```sh
weka smb share host-access reset <share-id>
                                 <mode>
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--force]
                                 [--help]
                                 [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `share-id`\*              | The id of the share                                                                                        |
| `mode`\*                  | allow/deny host access (format: 'allow' or 'deny')                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-f`, `--force`           | Force this action without further confirmation. This action will delete all host access ips.               |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb share host-access add**

Add hosts to host access lists

```sh
weka smb share host-access add <share-id>
                               <mode>
                               [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--ips ips]...
                               [--hosts hosts]...
                               [--help]
                               [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `share-id`\*              | The id of the share                                                                                        |
| `mode`\*                  | allow/deny host access (format: 'allow' or 'deny')                                                         |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--ips`...                | ips to add                                                                                                 |
| `--hosts`...              | hosts to add                                                                                               |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb share host-access remove**

Remove hosts from a user list

```sh
weka smb share host-access remove <share_id>
                                  [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]
                                  [--json]
                                  [<hosts>]...

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `share_id`\*              | The id of the share being removed from                                                                     |
| `hosts`...                | Hosts to add                                                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka smb domain

View info about the domain

```sh
weka smb domain [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--help]
                [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb domain join**

Join cluster to Active Directory domain

```sh
weka smb domain join <username>
                     [password]
                     [--server server]
                     [--create-computer create-computer]
                     [--extra-options extra-options]
                     [--timeout timeout]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--debug]
                     [--help]
                     [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `username`\*              | The name of the administrator user to join the domain using it                                             |
| `password`                | The administrator user password                                                                            |
| `--server`                | The domain controller server                                                                               |
| `--create-computer`       | Precreate the computer account in a specific OU                                                            |
| `--extra-options`         | Consult with SMB 'net ads join' manual for extra options                                                   |
| `-t`, `--timeout`         | Join command timeout in seconds (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                     |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--debug`                 | Run the command in debug mode                                                                              |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka smb domain leave**

Leave Active Directory domain

```sh
weka smb domain leave <username>
                      [password]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--debug]
                      [--force]
                      [--help]
                      [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `username`\*              | The name of the administrator user to leave the domain using it                                            |
| `password`                | The administrator user password                                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--debug`                 | Run the command in debug mode                                                                              |
| `-f`, `--force`           | Force to leave the domain. Use when Active Directory is unresponsive                                       |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

### weka stats

List all statistics that conform to the filter criteria

```sh
weka stats [--start-time <start>]
           [--end-time <end>]
           [--interval interval]
           [--resolution-secs <secs>]
           [--role role]
           [--HOST HOST]
           [--PORT PORT]
           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
           [--TIMEOUT TIMEOUT]
           [--profile profile]
           [--format format]
           [--category category]...
           [--stat stat]...
           [--process-ids process-ids]...
           [--param param]...
           [--output output]...
           [--sort sort]...
           [--filter filter]...
           [--accumulated]
           [--per-process]
           [--no-zeros]
           [--show-internal]
           [--skip-validations]
           [--help]
           [--raw-units]
           [--UTC]
           [--no-header]
           [--verbose]

```

| Parameter                 | Description                                                                                                                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--start-time`            | Query for stats starting at this time (format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00)                                                      |
| `--end-time`              | Query for stats up to this time point (format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00)                                                      |
| `--interval`              | Period (in seconds) of time of the report                                                                                                                                                                                                               |
| `--resolution-secs`       | Length of each interval in the report period                                                                                                                                                                                                            |
| `--role`                  | Limit the report to processes with the specified role                                                                                                                                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                                                                                |
| `--category`...           | Retrieve only statistics of the specified categories                                                                                                                                                                                                    |
| `--stat`...               | Retrieve only the specified statistics                                                                                                                                                                                                                  |
| `--process-ids`...        | Limit the report to the specified processes                                                                                                                                                                                                             |
| `--param`...              | For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'. (format: key:value) |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: node,category,timestamp,stat,unit,value,containerId,container,hostname,roles                                                                                                         |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                                                                 |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                                                                        |
| `--accumulated`           | Show accumulated statistics, not rate statistics                                                                                                                                                                                                        |
| `--per-process`           | Do not aggregate statistics across processes                                                                                                                                                                                                            |
| `-Z`, `--no-zeros`        | Do not retrieve results where the value is 0                                                                                                                                                                                                            |
| `--show-internal`         | Show internal statistics                                                                                                                                                                                                                                |
| `--skip-validations`      | Skip category/stat name validations                                                                                                                                                                                                                     |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                                                              |

#### weka stats realtime

Get performance related stats which are updated in a one-second interval.

```sh
weka stats realtime [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--format format]
                    [--output output]...
                    [--sort sort]...
                    [--filter filter]...
                    [--help]
                    [--raw-units]
                    [--UTC]
                    [--show-total]
                    [--no-header]
                    [--verbose]
                    [<process-ids>]...

```

| Parameter                 | Description                                                                                                                                                                                          |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `process-ids`...          | Only show realtime stats of these processes                                                                                                                                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                     |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                     |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                           |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                               |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                             |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                             |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: node,hostname,role,mode,writeps,writebps,wlatency,readps,readbps,rlatency,ops,cpu,l6recv,l6send,upload,download,rdmarecv,rdmasend |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+              |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                                     |
| `-h`, `--help`            | Show help message                                                                                                                                                                                    |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                                    |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                                |
| `--show-total`            | Show each column's sum of values in the real-time statistics output                                                                                                                                  |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                   |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                           |

#### weka stats list-types

Show the statistics definition information

```sh
weka stats list-types [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--show-internal]
                      [--help]
                      [--no-header]
                      [--verbose]
                      [<name-or-category>]...

```

| Parameter                 | Description                                                                                                                                                                                  |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name-or-category`...     | Filter by these names or categories                                                                                                                                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                             |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                             |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                   |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                       |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                     |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                     |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: category,clabel,identifier,description,label,type,unit,params,realted,permission,ntype,accumulate,histogram,histogramUnit |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+      |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                             |
| `--show-internal`         | Show internal statistics                                                                                                                                                                     |
| `-h`, `--help`            | Show help message                                                                                                                                                                            |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                           |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                   |

#### weka stats retention

Configure retention for statistics

```sh
weka stats retention [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka stats retention set**

Choose how long to keep statistics for

```sh
weka stats retention set [--days days]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--dry-run]
                         [--help]
                         [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--days`                  | Number of days to keep the statistics                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--dry-run`               | Only test the command, don't affect the system                                                             |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka stats retention status**

Show configured statistics retention

```sh
weka stats retention status [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]
                            [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka stats retention restore-default**

Restore default retention for statistics

```sh
weka stats retention restore-default [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--dry-run]
                                     [--help]
                                     [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--dry-run`               | Only test the command, don't affect the system                                                             |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

### weka status

Get an overall status of the Weka cluster

```sh
weka status [--HOST HOST]
            [--PORT PORT]
            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
            [--TIMEOUT TIMEOUT]
            [--profile profile]
            [--help]
            [--json]
            [--raw-units]
            [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

#### weka status rebuild

Show the cluster phasing in/out progress, and protection per fault-level

```sh
weka status rebuild [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--help]
                    [--json]
                    [--raw-units]
                    [--UTC]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB. |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                             |

### weka umount

Unmounts wekafs filesystems. This is the helper utility installed at /sbin/umount.wekafs.

```sh
weka umount <target> [--type type] [--verbose] [--no-mtab] [--lazy-unmount] [--force] [--readonly] [--help]

```

| Parameter              | Description                                                                                                                             |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `target`\*             | The target mount point to unmount                                                                                                       |
| `-t`, `--type`         | Indicate that the actions should only be taken on file systems of the specified type                                                    |
| `-v`, `--verbose`      | Verbose mode                                                                                                                            |
| `-n`, `--no-mtab`      | Unmount without writing in /etc/mtab                                                                                                    |
| `-l`, `--lazy-unmount` | Detach the filesystem from the filesystem hierarchy now, and cleanup all references to the filesystem as soon as it is not busy anymore |
| `-f`, `--force`        | Force unmount                                                                                                                           |
| `-r`, `--readonly`     | In case unmounting fails, try to remount read-only                                                                                      |
| `-h`, `--help`         | Show help message                                                                                                                       |

### weka upgrade

Commands that control the upgrade precedure of Weka

```sh
weka upgrade [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka upgrade supported-features

List upgrade features supported by the running cluster

```sh
weka upgrade supported-features [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]
                                [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

### weka user

List users defined in the Weka cluster

```sh
weka user [--HOST HOST]
          [--PORT PORT]
          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
          [--TIMEOUT TIMEOUT]
          [--profile profile]
          [--format format]
          [--output output]...
          [--sort sort]...
          [--filter filter]...
          [--help]
          [--no-header]
          [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,user,source,role,s3Policy,posix\_uid,posix\_gid                                                                  |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka user login

Logs a user into the Weka cluster. If login is successful, the user credentials are saved to the user homedir.

```sh
weka user login [username]
                [password]
                [--org org]
                [--path path]
                [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--help]

```

| Parameter                 | Description                                                                                                                                                                                                                                                           |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `username`                | User's username                                                                                                                                                                                                                                                       |
| `password`                | User's password                                                                                                                                                                                                                                                       |
| `-g`, `--org`             | Organization name or ID                                                                                                                                                                                                                                               |
| `-p`, `--path`            | The path where the login token will be saved (default: \~/.weka/auth-token.json). This path can also be specified using the WEKA\_TOKEN environment variable. After logging-in, use the WEKA\_TOKEN environment variable to specify where the login token is located. |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                      |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                      |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                            |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                              |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                     |

#### weka user logout

Logs the current user out of the Weka cluster by removing the user credentials from WEKA\_TOKEN if exists, or otherwise from the user homedir

```sh
weka user logout [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka user whoami

Get information about currently logged-in user

```sh
weka user whoami [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--format format]
                 [--output output]...
                 [--help]
                 [--no-header]
                 [--verbose]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                   |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: orgId,orgName,user,source,role          |
| `-h`, `--help`            | Show help message                                                                                          |
| `--no-header`             | Don't show column headers when printing the output                                                         |
| `-v`, `--verbose`         | Show all columns in output                                                                                 |

#### weka user passwd

Set a user's password. If the currently logged-in user is an admin, it can change the password for all other users in the organization.

```sh
weka user passwd [password]
                 [--username username]
                 [--current-password current-password]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--help]

```

| Parameter                 | Description                                                                                                                                                                                                                        |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `password`                | New password: must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping |
| `--username`              | Username to change the password for, by default password is changed for the current user                                                                                                                                           |
| `--current-password`      | User's current password. Only necessary if changing current user's password                                                                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                   |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                   |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                         |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                             |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                           |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                  |

#### weka user change-role

Change the role of an existing user.

```sh
weka user change-role <username>
                      <role>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `username`\*              | Username of user to change the role of                                                                     |
| `role`\*                  | New role to set for the user (format: 'clusteradmin', 'orgadmin', 'regular', 'readonly' or 's3')           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka user update

Change parameters of an existing user.

```sh
weka user update <username>
                 [--posix-uid posix-uid]
                 [--posix-gid posix-gid]
                 [--role role]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `username`\*              | Username of user to update                                                                                 |
| `--posix-uid`             | POSIX UID for user (S3 Only)                                                                               |
| `--posix-gid`             | POSIX GID for user (S3 Only)                                                                               |
| `--role`                  | New role to set for the user (format: 'clusteradmin', 'orgadmin', 'regular', 'readonly' or 's3')           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka user add

Create a new user in the Weka cluster

```sh
weka user add <username>
              <role>
              [password]
              [--posix-uid posix-uid]
              [--posix-gid posix-gid]
              [--HOST HOST]
              [--PORT PORT]
              [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
              [--TIMEOUT TIMEOUT]
              [--profile profile]
              [--help]
              [--json]

```

| Parameter                 | Description                                                                                                                                                                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `username`\*              | Username of the new user to create                                                                                                                                                                                                              |
| `role`\*                  | The role of the new user (format: 'clusteradmin', 'orgadmin', 'regular', 'readonly' or 's3')                                                                                                                                                    |
| `password`                | Password for the new user: must contain at least 8 characters, and have at least one uppercase letter, one lowercase letter, and one number or special character. Typing special characters as arguments to this command might require escaping |
| `--posix-uid`             | POSIX UID for user (S3 Only)                                                                                                                                                                                                                    |
| `--posix-gid`             | POSIX GID for user (S3 Only)                                                                                                                                                                                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                      |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                          |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                               |
| `-J`, `--json`            | Format output as JSON                                                                                                                                                                                                                           |

#### weka user delete

Delete user from the Weka cluster

```sh
weka user delete <username>
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `username`\*              | User's name                                                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka user revoke-tokens

Revoke all existing login tokens of an internal user

```sh
weka user revoke-tokens <username>
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `username`\*              | Username of user to revoke the tokens for                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka user generate-token

Generate an access token for the current logged in user for use with REST API

```sh
weka user generate-token [--access-token-timeout access-token-timeout]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]
                         [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--access-token-timeout`  | In how long should the access token expire (format: 3s, 2h, 4m, 1d, 1d5h, 1w)                              |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka user ldap

Show current LDAP configuration used for authenticating users

```sh
weka user ldap [--HOST HOST]
               [--PORT PORT]
               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
               [--TIMEOUT TIMEOUT]
               [--profile profile]
               [--help]
               [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka user ldap setup**

Setup an LDAP server for user authentication

```sh
weka user ldap setup <server-uri>
                     <base-dn>
                     <user-object-class>
                     <user-id-attribute>
                     <group-object-class>
                     <group-membership-attribute>
                     <group-id-attribute>
                     <reader-username>
                     [--cluster-admin-group cluster-admin-group]
                     [--org-admin-group org-admin-group]
                     [--regular-group regular-group]
                     [--readonly-group readonly-group]
                     [--start-tls start-tls]
                     [--ignore-start-tls-failure ignore-start-tls-failure]
                     [--server-timeout-secs server-timeout-secs]
                     [--protocol-version protocol-version]
                     [--user-revocation-attribute user-revocation-attribute]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--help]
                     [--json]

```

| Parameter                      | Description                                                                                                               |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| `server-uri`\*                 | LDAP server URI (\[ldap://]hostname\[:port] or ldaps://hostname\[:port])                                                  |
| `base-dn`\*                    | Base DN                                                                                                                   |
| `user-object-class`\*          | User object class                                                                                                         |
| `user-id-attribute`\*          | User ID attribute                                                                                                         |
| `group-object-class`\*         | Group object class                                                                                                        |
| `group-membership-attribute`\* | Group membership attribute                                                                                                |
| `group-id-attribute`\*         | Group ID attribute                                                                                                        |
| `reader-username`\*            | Reader username                                                                                                           |
| `reader-password`\*            | Reader password                                                                                                           |
| `--cluster-admin-group`        | LDAP group of users that should get ClusterAdmin role (this role is only available for the root tenant to configure)      |
| `--org-admin-group`            | LDAP group of users that should get OrgAdmin role                                                                         |
| `--regular-group`              | LDAP group of users that should get Regular role                                                                          |
| `--readonly-group`             | LDAP group of users that should get ReadOnly role                                                                         |
| `--start-tls`                  | Issue StartTLS after connecting (should not be used with ldaps://) (format: 'yes' or 'no')                                |
| `--ignore-start-tls-failure`   | Ignore start TLS failure (format: 'yes' or 'no')                                                                          |
| `--server-timeout-secs`        | LDAP connection timeout in seconds                                                                                        |
| `--protocol-version`           | LDAP protocol version                                                                                                     |
| `--user-revocation-attribute`  | User revocation attribute: If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `-H`, `--HOST`                 | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                          |
| `-P`, `--PORT`                 | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                          |
| `-C`, `--CONNECT-TIMEOUT`      | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                |
| `-T`, `--TIMEOUT`              | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                    |
| `--profile`                    | Name of the connection and authentication profile to use                                                                  |
| `-h`, `--help`                 | Show help message                                                                                                         |
| `-J`, `--json`                 | Format output as JSON                                                                                                     |

**weka user ldap setup-ad**

Setup an Active Directory server for user authentication

```sh
weka user ldap setup-ad <server-uri>
                        <domain>
                        <reader-username>
                        [--cluster-admin-group cluster-admin-group]
                        [--org-admin-group org-admin-group]
                        [--regular-group regular-group]
                        [--readonly-group readonly-group]
                        [--start-tls start-tls]
                        [--ignore-start-tls-failure ignore-start-tls-failure]
                        [--server-timeout-secs server-timeout-secs]
                        [--user-revocation-attribute user-revocation-attribute]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--json]

```

| Parameter                     | Description                                                                                                               |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `server-uri`\*                | LDAP server URI (\[ldap://]hostname\[:port] or ldaps://hostname\[:port])                                                  |
| `domain`\*                    | Domain                                                                                                                    |
| `reader-username`\*           | Reader username                                                                                                           |
| `reader-password`\*           | Reader password                                                                                                           |
| `--cluster-admin-group`       | LDAP group of users that should get ClusterAdmin role (this role is only available for the root tenant to configure)      |
| `--org-admin-group`           | LDAP group of users that should get OrgAdmin role                                                                         |
| `--regular-group`             | LDAP group of users that should get Regular role                                                                          |
| `--readonly-group`            | LDAP group of users that should get ReadOnly role                                                                         |
| `--start-tls`                 | Issue StartTLS after connecting (should not be used with ldaps://) (format: 'yes' or 'no')                                |
| `--ignore-start-tls-failure`  | Ignore start TLS failure (format: 'yes' or 'no')                                                                          |
| `--server-timeout-secs`       | LDAP connection timeout in seconds                                                                                        |
| `--user-revocation-attribute` | User revocation attribute: If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `-H`, `--HOST`                | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                          |
| `-P`, `--PORT`                | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                          |
| `-C`, `--CONNECT-TIMEOUT`     | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                |
| `-T`, `--TIMEOUT`             | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                    |
| `--profile`                   | Name of the connection and authentication profile to use                                                                  |
| `-h`, `--help`                | Show help message                                                                                                         |
| `-J`, `--json`                | Format output as JSON                                                                                                     |

**weka user ldap update**

Edit LDAP server configuration

```sh
weka user ldap update [--server-uri server-uri]
                      [--base-dn base-dn]
                      [--user-object-class user-object-class]
                      [--user-id-attribute user-id-attribute]
                      [--group-object-class group-object-class]
                      [--group-membership-attribute group-membership-attribute]
                      [--group-id-attribute group-id-attribute]
                      [--reader-username reader-username]
                      [--reader-password reader-password]
                      [--cluster-admin-group cluster-admin-group]
                      [--org-admin-group org-admin-group]
                      [--regular-group regular-group]
                      [--readonly-group readonly-group]
                      [--start-tls start-tls]
                      [--certificate certificate]
                      [--ignore-start-tls-failure ignore-start-tls-failure]
                      [--server-timeout-secs server-timeout-secs]
                      [--protocol-version protocol-version]
                      [--user-revocation-attribute user-revocation-attribute]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]

```

| Parameter                      | Description                                                                                                               |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| `--server-uri`                 | LDAP server URI (\[ldap://]hostname\[:port] or ldaps://hostname\[:port])                                                  |
| `--base-dn`                    | Base DN                                                                                                                   |
| `--user-object-class`          | User object class                                                                                                         |
| `--user-id-attribute`          | User ID attribute                                                                                                         |
| `--group-object-class`         | Group object class                                                                                                        |
| `--group-membership-attribute` | Group membership attribute                                                                                                |
| `--group-id-attribute`         | Group ID attribute                                                                                                        |
| `--reader-username`            | Reader username                                                                                                           |
| `--reader-password`            | Reader password                                                                                                           |
| `--cluster-admin-group`        | LDAP group of users that should get ClusterAdmin role (this role is only available for the root tenant to configure)      |
| `--org-admin-group`            | LDAP group of users that should get OrgAdmin role                                                                         |
| `--regular-group`              | LDAP group of users that should get Regular role                                                                          |
| `--readonly-group`             | LDAP group of users that should get ReadOnly role                                                                         |
| `--start-tls`                  | Issue StartTLS after connecting (should not be used with ldaps://) (format: 'yes' or 'no')                                |
| `--certificate`                | Certificate or certificate chain for the LDAP server                                                                      |
| `--ignore-start-tls-failure`   | Ignore certificate verification errors (format: 'yes' or 'no')                                                            |
| `--server-timeout-secs`        | LDAP connection timeout in seconds                                                                                        |
| `--protocol-version`           | LDAP protocol version                                                                                                     |
| `--user-revocation-attribute`  | User revocation attribute: If provided, updating this attribute in the LDAP server automatically revokes all user tokens. |
| `-H`, `--HOST`                 | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                          |
| `-P`, `--PORT`                 | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                          |
| `-C`, `--CONNECT-TIMEOUT`      | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                |
| `-T`, `--TIMEOUT`              | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                    |
| `--profile`                    | Name of the connection and authentication profile to use                                                                  |
| `-h`, `--help`                 | Show help message                                                                                                         |
| `-J`, `--json`                 | Format output as JSON                                                                                                     |

**weka user ldap enable**

Enable authentication through the configured LDAP server (has no effect if LDAP server is already enabled)

```sh
weka user ldap enable [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka user ldap disable**

Disable authentication through the configured LDAP server

```sh
weka user ldap disable [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--force]
                       [--help]
                       [--json]

```

| Parameter                 | Description                                                                                                                    |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                               |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                               |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                     |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                         |
| `--profile`               | Name of the connection and authentication profile to use                                                                       |
| `-f`, `--force`           | Force this action without further confirmation. This would prevent all LDAP users from logging-in until LDAP is enabled again. |
| `-h`, `--help`            | Show help message                                                                                                              |
| `-J`, `--json`            | Format output as JSON                                                                                                          |

**weka user ldap reset**

Delete all LDAP settings from the cluster

```sh
weka user ldap reset [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--force]
                     [--help]
                     [--json]

```

| Parameter                 | Description                                                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                  |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                  |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                        |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                            |
| `--profile`               | Name of the connection and authentication profile to use                                                                          |
| `-f`, `--force`           | Force this action without further confirmation. This would prevent all LDAP users from logging-in until LDAP is configured again. |
| `-h`, `--help`            | Show help message                                                                                                                 |
| `-J`, `--json`            | Format output as JSON                                                                                                             |

### weka version

When run without arguments, lists the versions available on this machine. Subcommands allow for downloading of versions, setting the current version and other actions to manage versions.

```sh
weka version [--help] [--json]

```

| Parameter      | Description           |
| -------------- | --------------------- |
| `-h`, `--help` | Show help message     |
| `-J`, `--json` | Format output as JSON |

#### weka version supported-specs

List the Weka spec versions that are supported by this agent version

```sh
weka version supported-specs [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka version get

Download a Weka version to the machine this command is executed from

```sh
weka version get <version> [--from from]... [--set-current] [--no-progress-bar] [--set-dist-servers] [--help]

```

| Parameter            | Description                                                                                                                                                                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `version`\*          | Version to download                                                                                                                                                                                                                                           |
| `--from`...          | Download from this distribution server (can be given multiple times). Otherwise distribution servers are taken from the $WEKA\_DIST\_SERVERS environment variable, the /etc/wekaio/dist-servers file, or /etc/wekaio/service.conf in that order of precedence |
| `--set-current`      | Set the downloaded version as the current version. Will fail if any containers are currently running.                                                                                                                                                         |
| `--no-progress-bar`  | Don't render download progress bar                                                                                                                                                                                                                            |
| `--set-dist-servers` | Override the default distribution servers upon successful download                                                                                                                                                                                            |
| `-h`, `--help`       | Show help message                                                                                                                                                                                                                                             |

#### weka version set

Set the current version. Containers must be stopped before setting the current version and the new version must have already been downloaded.

```sh
weka version set <version>
                 [--container container]
                 [--allow-running-containers]
                 [--default-only]
                 [--agent-only]
                 [--set-dependent]
                 [--help]

```

| Parameter                    | Description                                                             |
| ---------------------------- | ----------------------------------------------------------------------- |
| `version`\*                  | The version name to use                                                 |
| `-C`, `--container`          | The container to set the version for                                    |
| `--allow-running-containers` | Do not verify that all containers are stopped                           |
| `--default-only`             | Only set the default version used for creating containers               |
| `--agent-only`               | Only set the agent version                                              |
| `--set-dependent`            | Set the version for all containers depending on the specified container |
| `-h`, `--help`               | Show help message                                                       |

#### weka version unset

Unset the current version. Containers must be stopped before setting the current version and the new version must have already been downloaded.

```sh
weka version unset [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka version current

Prints the current version. If no version is set, a failure exit status is returned.

```sh
weka version current [--container container] [--help]

```

| Parameter           | Description                              |
| ------------------- | ---------------------------------------- |
| `-C`, `--container` | Get the version for a specific container |
| `-h`, `--help`      | Show help message                        |

#### weka version rm

Delete a version from the machine this command is executed from

```sh
weka version rm [--clean-unused] [--force] [--help] [<version-name>]...

```

| Parameter         | Description                                                                                              |
| ----------------- | -------------------------------------------------------------------------------------------------------- |
| `version-name`... | The versions to remove                                                                                   |
| `--clean-unused`  | Delete all versions which aren't the current set version, or the version of any of the containers        |
| `-f`, `--force`   | Force this action without further confirmation. This action may be undone by re-downloading the version. |
| `-h`, `--help`    | Show help message                                                                                        |

#### weka version prepare

Prepare the version for use. This includes things like compiling the version drivers for the local machine.

```sh
weka version prepare <version-name> [--help] [<containers>]...

```

| Parameter        | Description                               |
| ---------------- | ----------------------------------------- |
| `version-name`\* | The version to prepare                    |
| `containers`...  | The containers to prepare the version for |
| `-h`, `--help`   | Show help message                         |

### weka s3

Commands that manage Weka's S3 container

```sh
weka s3 [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

#### weka s3 cluster

View info about the S3 cluster managed by weka

```sh
weka s3 cluster [--HOST HOST]
                [--PORT PORT]
                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                [--TIMEOUT TIMEOUT]
                [--profile profile]
                [--verbose]
                [--help]
                [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-v`, `--verbose`         | Verbose mode                                                                                               |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 cluster create**

Create an S3 cluster managed by weka

```sh
weka s3 cluster create <default-fs-name>
                       <config-fs-name>
                       [--port port]
                       [--key key]
                       [--secret secret]
                       [--max-buckets-limit max-buckets-limit]
                       [--anonymous-posix-uid anonymous-posix-uid]
                       [--anonymous-posix-gid anonymous-posix-gid]
                       [--domain domain]
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--container container]...
                       [--all-servers]
                       [--force]
                       [--help]

```

| Parameter                 | Description                                                                                                                                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `default-fs-name`\*       | S3 default filesystem name                                                                                                                                                                                  |
| `config-fs-name`\*        | S3 config filesystem name                                                                                                                                                                                   |
| `--port`                  | S3 service port                                                                                                                                                                                             |
| `--key`                   | S3 service key                                                                                                                                                                                              |
| `--secret`                | S3 service secret                                                                                                                                                                                           |
| `--max-buckets-limit`     | Limit the number of buckets that can be created                                                                                                                                                             |
| `--anonymous-posix-uid`   | POSIX UID for anonymous users                                                                                                                                                                               |
| `--anonymous-posix-gid`   | POSIX GID for anonymous users                                                                                                                                                                               |
| `--domain`                | Virtual host-style comma seperated domains                                                                                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                    |
| `--container`...          | The containers that will serve via the S3 protocol (pass weka's container ID as a number)                                                                                                                   |
| `--all-servers`           | Install S3 on all servers                                                                                                                                                                                   |
| `-f`, `--force`           | Force this action without further confirmation. Be aware that this will impact all S3 buckets within the S3 service. Exercise caution and consult the WEKA Customer Success team if assistance is required. |
| `-h`, `--help`            | Show help message                                                                                                                                                                                           |

**weka s3 cluster update**

Update an S3 cluster

```sh
weka s3 cluster update [--key key]
                       [--secret secret]
                       [--port port]
                       [--anonymous-posix-uid anonymous-posix-uid]
                       [--anonymous-posix-gid anonymous-posix-gid]
                       [--domain domain]
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--container container]...
                       [--all-servers]
                       [--force]
                       [--help]

```

| Parameter                 | Description                                                                                                                                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--key`                   | S3 service key                                                                                                                                                                                              |
| `--secret`                | S3 service secret                                                                                                                                                                                           |
| `--port`                  | S3 service port                                                                                                                                                                                             |
| `--anonymous-posix-uid`   | POSIX UID for anonymous users                                                                                                                                                                               |
| `--anonymous-posix-gid`   | POSIX GID for anonymous users                                                                                                                                                                               |
| `--domain`                | Virtual host-style comma seperated domains. Empty to disable                                                                                                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                    |
| `--container`...          | The containers that will serve via the S3 protocol                                                                                                                                                          |
| `--all-servers`           | Install S3 on all servers                                                                                                                                                                                   |
| `-f`, `--force`           | Force this action without further confirmation. Be aware that this will impact all S3 buckets within the S3 service. Exercise caution and consult the WEKA Customer Success team if assistance is required. |
| `-h`, `--help`            | Show help message                                                                                                                                                                                           |

**weka s3 cluster destroy**

Destroy the S3 cluster managed by weka. This will not delete the data, just stop exposing it via S3

```sh
weka s3 cluster destroy [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--force]
                        [--help]

```

| Parameter                    | Description                                                                                                                                             |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`               | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                        |
| `-P`, `--PORT`               | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                        |
| `-C`, `--CONNECT-TIMEOUT`    | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                              |
| `-T`, `--TIMEOUT`            | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                  |
| `--profile`                  | Name of the connection and authentication profile to use                                                                                                |
| `-f`, `--force`              | Force this action without further confirmation.                                                                                                         |
| `troying the S3 cluster r`   | emoves the S3 service and its associated configuration, including IAM policies, buckets, and ILM rules. access will no longer be available for clients. |
| `s operation does not aut`   | omatically delete the data stored within the buckets.                                                                                                   |
| `ever`, `internal users wit` | h S3 roles will be permanently removed from the system..                                                                                                |
| `-h`, `--help`               | Show help message                                                                                                                                       |

**weka s3 cluster status**

Show which of the containers are ready.

```sh
weka s3 cluster status [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--help]
                       [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 cluster audit-webhook**

S3 Cluster Audit Webhook Commands

```sh
weka s3 cluster audit-webhook [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 cluster audit-webhook enable**

Enable/Disable the S3 audit webhook on the S3 Cluster

```sh
weka s3 cluster audit-webhook enable [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--endpoint endpoint]
                                     [--auth-token auth-token]
                                     [--help]
                                     [--verify]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--endpoint`              | The webhook endpoint                                                                                       |
| `--auth-token`            | The webhook authentication token                                                                           |
| `-h`, `--help`            | Show help message                                                                                          |
| `--verify`                | verification to apply configuration                                                                        |

**weka s3 cluster audit-webhook disable**

Disable the Audit Webhook

```sh
weka s3 cluster audit-webhook disable [--HOST HOST]
                                      [--PORT PORT]
                                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                      [--TIMEOUT TIMEOUT]
                                      [--profile profile]
                                      [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka s3 cluster audit-webhook show**

Show the S3 Audit Webhook configuration

```sh
weka s3 cluster audit-webhook show [--HOST HOST]
                                   [--PORT PORT]
                                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                   [--TIMEOUT TIMEOUT]
                                   [--profile profile]
                                   [--help]
                                   [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 cluster containers**

Commands that manage Weka's S3 cluster's containers

```sh
weka s3 cluster containers [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 cluster containers add**

Add S3 containers to S3 cluster

```sh
weka s3 cluster containers add [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--help]
                               [<container-ids>]...

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-ids`...        | The containers to add to the S3 cluster                                                                    |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka s3 cluster containers remove**

Remove S3 containers from S3 cluster

```sh
weka s3 cluster containers remove [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--help]
                                  [<container-ids>]...

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `container-ids`...        | The containers to remove from the S3 cluster                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka s3 cluster containers list**

Lists containers in S3 cluster

```sh
weka s3 cluster containers list [--HOST HOST]
                                [--PORT PORT]
                                [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                [--TIMEOUT TIMEOUT]
                                [--profile profile]
                                [--help]
                                [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka s3 bucket

S3 Cluster Bucket Commands

```sh
weka s3 bucket [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 bucket create**

Create an S3 bucket

```sh
weka s3 bucket create <name>
                      [--policy policy]
                      [--policy-json policy-json]
                      [--hard-quota hard-quota]
                      [--existing-path existing-path]
                      [--fs-name fs-name]
                      [--fs-id fs-id]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--force]
                      [--help]
                      [--json]

```

| Parameter                 | Description                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `name`\*                  | bucket name to create                                                                                                                            |
| `--policy`                | Set an existing S3 policy for a bucket                                                                                                           |
| `--policy-json`           | Get S3 policy for bucket in JSON format                                                                                                          |
| `--hard-quota`            | Hard limit for the directory (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `--existing-path`         | existing path                                                                                                                                    |
| `--fs-name`               | file system name                                                                                                                                 |
| `--fs-id`                 | file system id                                                                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                 |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                 |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                       |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                           |
| `--profile`               | Name of the connection and authentication profile to use                                                                                         |
| `-f`, `--force`           | Force when existing-path has quota                                                                                                               |
| `-h`, `--help`            | Show help message                                                                                                                                |
| `-J`, `--json`            | Format output as JSON                                                                                                                            |

**weka s3 bucket list**

Show all the buckets on the S3 cluster

```sh
weka s3 bucket list [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--format format]
                    [--output output]...
                    [--sort sort]...
                    [--filter filter]...
                    [--help]
                    [--raw-units]
                    [--UTC]
                    [--no-header]
                    [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: name,hard,used,path,fs                                                                                               |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka s3 bucket destroy**

Destroy an S3 bucket

```sh
weka s3 bucket destroy <name>
                       [--HOST HOST]
                       [--PORT PORT]
                       [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                       [--TIMEOUT TIMEOUT]
                       [--profile profile]
                       [--unlink]
                       [--help]
                       [--json]
                       [--force]

```

| Parameter                 | Description                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | bucket name to destroy                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                              |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                              |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)    |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)        |
| `--profile`               | Name of the connection and authentication profile to use                                                      |
| `--unlink`                | unlinks the bucket, but leave the data directory in place                                                     |
| `-h`, `--help`            | Show help message                                                                                             |
| `-J`, `--json`            | Format output as JSON                                                                                         |
| `-f`, `--force`           | Force this action without further confirmation. This action may disrupt IO service for connected S3 clients.. |

**weka s3 bucket lifecycle-rule**

S3 Bucket Lifecycle

```sh
weka s3 bucket lifecycle-rule [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 bucket lifecycle-rule add**

Add a lifecycle rule to an S3 Bucket

```sh
weka s3 bucket lifecycle-rule add <bucket>
                                  <expiry-days>
                                  [--HOST HOST]
                                  [--PORT PORT]
                                  [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                  [--TIMEOUT TIMEOUT]
                                  [--profile profile]
                                  [--prefix prefix]
                                  [--tags tags]
                                  [--help]
                                  [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket`\*                | S3 Bucket Name                                                                                             |
| `expiry-days`\*           | expiry days                                                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--prefix`                | prefix                                                                                                     |
| `--tags`                  | object tags                                                                                                |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket lifecycle-rule remove**

Remove a lifecycle rule from an S3 bucket

```sh
weka s3 bucket lifecycle-rule remove <bucket>
                                     <name>
                                     [--HOST HOST]
                                     [--PORT PORT]
                                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                     [--TIMEOUT TIMEOUT]
                                     [--profile profile]
                                     [--help]
                                     [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket`\*                | S3 Bucket Name                                                                                             |
| `name`\*                  | rule name                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket lifecycle-rule reset**

Reset all lifecycle rules of an S3 bucket

```sh
weka s3 bucket lifecycle-rule reset <bucket>
                                    [--HOST HOST]
                                    [--PORT PORT]
                                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                    [--TIMEOUT TIMEOUT]
                                    [--profile profile]
                                    [--help]
                                    [--json]
                                    [--force]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket`\*                | S3 Bucket Name                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |
| `-f`, `--force`           | Force this action without further confirmation. This action will delete the existing S3 bucket rules.      |

**weka s3 bucket lifecycle-rule list**

List all lifecycle rules of an S3 bucket

```sh
weka s3 bucket lifecycle-rule list <bucket>
                                   [--HOST HOST]
                                   [--PORT PORT]
                                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                   [--TIMEOUT TIMEOUT]
                                   [--profile profile]
                                   [--format format]
                                   [--output output]...
                                   [--sort sort]...
                                   [--filter filter]...
                                   [--help]
                                   [--no-header]
                                   [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bucket`\*                | S3 Bucket Name                                                                                                                                                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,expiry\_days,prefix,tags                                                                                      |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka s3 bucket policy**

S3 bucket policy commands

```sh
weka s3 bucket policy [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 bucket policy get**

Get S3 policy for bucket

```sh
weka s3 bucket policy get <bucket-name>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]
                          [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*           | full path to bucket to get policy for                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket policy set**

Set an existing S3 policy for a bucket, Available predefined options are : none|download|upload|public

```sh
weka s3 bucket policy set <bucket-name>
                          <bucket-policy>
                          [--HOST HOST]
                          [--PORT PORT]
                          [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                          [--TIMEOUT TIMEOUT]
                          [--profile profile]
                          [--help]
                          [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*           | full path to bucket to set policy for                                                                      |
| `bucket-policy`\*         | Set an existing S3 policy. Available predefined options are: none                                          |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket policy unset**

Unset the configured S3 policy for bucket

```sh
weka s3 bucket policy unset <bucket-name>
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]
                            [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*           | full path to bucket to unset the policy for                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket policy get-json**

Get S3 policy for bucket in JSON format

```sh
weka s3 bucket policy get-json <bucket-name>
                               [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--help]
                               [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*           | full path to bucket to get policy for                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket policy set-custom**

Set a custom S3 policy for bucket

```sh
weka s3 bucket policy set-custom <bucket-name>
                                 <policy-file>
                                 [--HOST HOST]
                                 [--PORT PORT]
                                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                 [--TIMEOUT TIMEOUT]
                                 [--profile profile]
                                 [--help]
                                 [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*           | Full path to bucket to set policy for                                                                      |
| `policy-file`\*           | Path of the file containing the policy rules                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 bucket quota**

S3 Bucket Quota, configure the hard limit of bucket disk usage

```sh
weka s3 bucket quota [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 bucket quota set**

Set the hard limit of bucket's disk usage

```sh
weka s3 bucket quota set <name>
                         <hard-quota>
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--help]

```

| Parameter                 | Description                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `name`\*                  | bucket name                                                                                                                                      |
| `hard-quota`\*            | Hard limit for the directory (format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB) |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                 |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                 |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                       |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                           |
| `--profile`               | Name of the connection and authentication profile to use                                                                                         |
| `-h`, `--help`            | Show help message                                                                                                                                |

**weka s3 bucket quota unset**

Remove the hard limit on bucket's disk usage

```sh
weka s3 bucket quota unset <name>
                           [--HOST HOST]
                           [--PORT PORT]
                           [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                           [--TIMEOUT TIMEOUT]
                           [--profile profile]
                           [--help]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | bucket name                                                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

#### weka s3 policy

S3 policy commands

```sh
weka s3 policy [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 policy list**

Print a list of the existing S3 IAM policies

```sh
weka s3 policy list [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--format format]
                    [--output output]...
                    [--sort sort]...
                    [--filter filter]...
                    [--help]
                    [--no-header]
                    [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: name                                                                                                                 |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka s3 policy show**

Show the details of an S3 IAM policy

```sh
weka s3 policy show <policy-name>
                    [--HOST HOST]
                    [--PORT PORT]
                    [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                    [--TIMEOUT TIMEOUT]
                    [--profile profile]
                    [--help]
                    [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `policy-name`\*           | Policy name to show                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 policy add**

Add an S3 IAM policy

```sh
weka s3 policy add <policy-name>
                   <policy-file>
                   [--HOST HOST]
                   [--PORT PORT]
                   [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                   [--TIMEOUT TIMEOUT]
                   [--profile profile]
                   [--help]
                   [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `policy-name`\*           | The policy name                                                                                            |
| `policy-file`\*           | Path of the file containing the policy rules                                                               |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 policy remove**

Remove an S3 IAM policy

```sh
weka s3 policy remove <policy>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `policy`\*                | Policy name to remove                                                                                      |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 policy attach**

Attach an S3 policy to a user

```sh
weka s3 policy attach <policy>
                      <user>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `policy`\*                | Policy name to attach                                                                                      |
| `user`\*                  | User name                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 policy detach**

Detach an S3 policy from a user

```sh
weka s3 policy detach <user>
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
                      [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `user`\*                  | User name                                                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka s3 service-account

S3 service account commands. Should be run only with an S3 user role

```sh
weka s3 service-account [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 service-account list**

Print a list of the user's S3 service accounts

```sh
weka s3 service-account list [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--format format]
                             [--output output]...
                             [--sort sort]...
                             [--filter filter]...
                             [--help]
                             [--no-header]
                             [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: accessKey                                                                                                            |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka s3 service-account show**

Show the details of an S3 service account

```sh
weka s3 service-account show <access_key>
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--help]
                             [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `access_key`\*            | Access key of the service account to show                                                                  |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 service-account add**

Add an S3 service account

```sh
weka s3 service-account add [--policy-file policy-file]
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]
                            [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--policy-file`           | Policy file path                                                                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka s3 service-account remove**

Remove an S3 service account

```sh
weka s3 service-account remove <access_key>
                               [--HOST HOST]
                               [--PORT PORT]
                               [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                               [--TIMEOUT TIMEOUT]
                               [--profile profile]
                               [--help]
                               [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `access_key`\*            | Access key of the service account to remove                                                                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka s3 sts

S3 security token commands

```sh
weka s3 sts [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 sts assume-role**

Generate a temporary security token with an assumed role using existing user credentials

```sh
weka s3 sts assume-role [--access-key access-key]
                        [--secret-key secret-key]
                        [--policy-file policy-file]
                        [--duration duration]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--help]
                        [--json]

```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `--access-key`            | Access key                                                                                                 |
| `--secret-key`            | Secret key                                                                                                 |
| `--policy-file`           | Policy file path                                                                                           |
| `--duration`              | Duration, valid values: 15 minutes to 52 weeks and 1 day (format: 3s, 2h, 4m, 1d, 1d5h, 1w)                |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka s3 log-level

S3 log-level Commands

```sh
weka s3 log-level [--help]

```

| Parameter      | Description       |
| -------------- | ----------------- |
| `-h`, `--help` | Show help message |

**weka s3 log-level get**

Show current S3 log level on container

```sh
weka s3 log-level get [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--container container]...
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--help]
                      [--no-header]
                      [--verbose]

```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result. Available options are: view                                                                                                                |
| `--container`...          | The containers that will change their log level severity                                                                                                                                |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: host,stdout                                                                                                          |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]]                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |
