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
weka [--color color] [--help] [--build] [--version] [--legal] [--opt-in]
```

| Parameter         | Description                                                                      |
| ----------------- | -------------------------------------------------------------------------------- |
| `--agent`         | Start the agent service                                                          |
| `--color`         | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help`    | Show help message                                                                |
| `--build`         | Prints the CLI build number and exits                                            |
| `-v`, `--version` | Prints the CLI version and exits                                                 |
| `--legal`         | Prints software license information and exits                                    |
| `--opt-in`        | Opt in to the new CLI experience                                                 |

### weka agent

Commands that control the weka agent (outside the weka containers)

```sh
weka agent [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

#### weka agent autocomplete

Bash autocompletion utilities

```sh
weka agent autocomplete [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka agent autocomplete export**

Export bash autocompletion script

```sh
weka agent autocomplete export [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka agent autocomplete install**

Locally install bash autocompletion utility

```sh
weka agent autocomplete install [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka agent autocomplete uninstall**

Locally uninstall bash autocompletion utility

```sh
weka agent autocomplete uninstall [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

#### weka agent install-agent

Installs Weka agent on the machine the command is executed from

```sh
weka agent install-agent [--color color] [--no-update] [--no-start] [--systemd-graceful-shutdown] [--help]
```

| Parameter                     | Description                                                                      |
| ----------------------------- | -------------------------------------------------------------------------------- |
| `--color`                     | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `--no-update`                 | Don't update the locally installed containers                                    |
| `--no-start`                  | Do not register the weka-agent service and start it after its creation           |
| `--systemd-graceful-shutdown` | Enable graceful shutdown via systemd                                             |
| `-h`, `--help`                | Show help message                                                                |

#### weka agent restart

Stop and start Weka agent on the server the command is executed from. If the agent is not running yet, it will be started

```sh
weka agent restart [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

#### weka agent uninstall

Deletes all Weka files, drivers, shared memory and any other remainder from the machine this command is executed from. WARNING - This action is destructive and might cause a loss of data!

```sh
weka agent uninstall [--color color] [--force] [--ignore-wekafs-mounts] [--keep-files] [--help]
```

| Parameter                | Description                                                                      |
| ------------------------ | -------------------------------------------------------------------------------- |
| `--color`                | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `--force`                | Force the action to actually happen                                              |
| `--ignore-wekafs-mounts` | Proceed even with active wekafs mounts                                           |
| `--keep-files`           | Do not remove Weka version images and keep in installation directory             |
| `-h`, `--help`           | Show help message                                                                |

#### weka agent update-containers

Update the currently available containers and version specs to the current agent version. This command does not update weka, only the container's representation on the local machine.

```sh
weka agent update-containers [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

### weka alerts

List alerts in the Weka cluster

```sh
weka alerts [--severity severity]
            [--color color]
            [--HOST HOST]
            [--PORT PORT]
            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
            [--TIMEOUT TIMEOUT]
            [--profile profile]
            [--format format]
            [--output output]...
            [--sort sort]...
            [--filter filter]...
            [--filter-color filter-color]...
            [--muted]
            [--inactive]
            [--help]
            [--no-header]
            [--verbose]
```

| Parameter                 | Description                                                                                                                                                                                                      |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--severity`              | Include event with equal and higher severity, default: WARNING (format: 'debug', 'warning', 'minor', 'major' or 'critical')                                                                                      |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                 |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                 |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                       |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                           |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                         |
| `-f`, `--format`          | Specify in what format to output the result (format: 'view', 'csv', 'markdown', 'json' or 'oldview')                                                                                                             |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: muted,type,severity,time,endTime,activeDuration,count,title,description,action,muteTimeRemaining,comment (may be repeated or comma-separated) |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+                          |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]] (may be repeated or comma-separated)                                                                            |
| `--filter-color`...       | Filter rows with specific colors (red/yellow/green) (may be repeated or comma-separated)                                                                                                                         |
| `--muted`                 | List muted alerts alongside the unmuted ones                                                                                                                                                                     |
| `--inactive`              | List alerts that became inactive recently                                                                                                                                                                        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                                               |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                                                       |

#### weka alerts describe

Describe all the alert types that might be returned from the weka cluster (including explanations and how to handle them)

```sh
weka alerts describe [--color color]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--format format]
                     [--output output]...
                     [--sort sort]...
                     [--filter filter]...
                     [--filter-color filter-color]...
                     [--help]
                     [--no-header]
                     [--verbose]
```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result (format: 'view', 'csv', 'markdown', 'json' or 'oldview')                                                                                    |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: type,title,action,severity (may be repeated or comma-separated)                                                      |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]] (may be repeated or comma-separated)                                                   |
| `--filter-color`...       | Filter rows with specific colors (red/yellow/green) (may be repeated or comma-separated)                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka alerts mute

Mute an alert-type. Muted alerts will not appear in the list of active alerts. It is required to specify a duration for the mute. Once the set duration concludes, the alert-type will automatically be unmuted.

```sh
weka alerts mute <alert-type>
                 <duration>
                 [--comment comment]
                 [--color color]
                 [--HOST HOST]
                 [--PORT PORT]
                 [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                 [--TIMEOUT TIMEOUT]
                 [--profile profile]
                 [--process process]...
                 [--container container]...
                 [--hostname hostname]...
                 [--help]
```

| Parameter                 | Description                                                                                                                                                                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `alert-type`\*            | Specifies the alert type to mute. Run `weka alerts types` to list all possible types.                                                                                                                                                                                                            |
| `duration`\*              | Sets the duration for the mute. Examples - 30m, 2h, 1d. (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                   |
| `--comment`               | Specifies a comment to provide context for the mute action.                                                                                                                                                                                                                                      |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                                                                                                                                 |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                                 |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                                 |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                       |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                           |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                         |
| `--process`...            | Mutes alerts for specific process IDs. This parameter applies only to process-specific alerts. If omitted or used on a non-process alert, all alerts of this type are muted. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated)       |
| `--container`...          | Mutes alerts for specific container IDs. This parameter applies only to container-specific alerts. If omitted or used on a non-container alert, all alerts of this type are muted. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated) |
| `--hostname`...           | Mutes alerts for specific server IDs. This parameter applies only to server-specific alerts. If omitted or used on a non-server alert, all alerts of this type are muted. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated)          |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                                |

**weka alerts mute add**

Add more items to the mute scope for an already muted alert-type. You can add more process/container/hostname items to the existing scope. Duration and comment remain unchanged.

```sh
weka alerts mute add <alert-type>
                     [--color color]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--process process]...
                     [--container container]...
                     [--hostname hostname]...
                     [--help]
```

| Parameter                 | Description                                                                                                                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `alert-type`\*            | Specifies the alert type to update mute scope for. Run `weka alerts types` to list all possible types.                                                                                                             |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                   |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                   |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                         |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                             |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                           |
| `--process`...            | Adds more process IDs to the mute scope. This parameter applies only to process-specific alerts. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated)     |
| `--container`...          | Adds more container IDs to the mute scope. This parameter applies only to container-specific alerts. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated) |
| `--hostname`...           | Adds more hostnames to the mute scope. This parameter applies only to server-specific alerts. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated)        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                  |

**weka alerts mute list**

List all currently muted alert types with their mute configurations

```sh
weka alerts mute list [--color color]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--format format]
                      [--output output]...
                      [--sort sort]...
                      [--filter filter]...
                      [--filter-color filter-color]...
                      [--help]
                      [--no-header]
                      [--verbose]
```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result (format: 'view', 'csv', 'markdown', 'json' or 'oldview')                                                                                    |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: alertType,muteTimeRemaining,description,comment (may be repeated or comma-separated)                                 |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]] (may be repeated or comma-separated)                                                   |
| `--filter-color`...       | Filter rows with specific colors (red/yellow/green) (may be repeated or comma-separated)                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka alerts mute remove**

Remove specific items from the mute scope of an already muted alert-type. You can remove specific process/container/hostname items from the existing scope. If all items are removed, the alert will be completely unmuted.

```sh
weka alerts mute remove <alert-type>
                        [--color color]
                        [--HOST HOST]
                        [--PORT PORT]
                        [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                        [--TIMEOUT TIMEOUT]
                        [--profile profile]
                        [--process process]...
                        [--container container]...
                        [--hostname hostname]...
                        [--help]
```

| Parameter                 | Description                                                                                                                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alert-type`\*            | Specifies the alert type to remove from mute scope. Run `weka alerts types` to list all possible types.                                                                                                                     |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                                                            |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                            |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                            |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                  |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                      |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                    |
| `--process`...            | Removes specific process IDs from the mute scope. This parameter applies only to process-specific alerts. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated)     |
| `--container`...          | Removes specific container IDs from the mute scope. This parameter applies only to container-specific alerts. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated) |
| `--hostname`...           | Removes specific hostnames from the mute scope. This parameter applies only to server-specific alerts. Provide a comma-separated list or repeat the parameter for multiple IDs. (may be repeated or comma-separated)        |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                           |

#### weka alerts types

List all alert types that can be returned from the Weka cluster

```sh
weka alerts types [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka alerts unmute

Unmute an alert-type which was previously muted.

```sh
weka alerts unmute <alert-type>
                   [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

### weka audit

Commands used for audit in a weka cluster

```sh
weka audit [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

#### weka audit cluster

Audit cluster CLI

```sh
weka audit cluster [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka audit cluster decrypt-filename**

Decrypt filename in audit telemetry

```sh
weka audit cluster decrypt-filename [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka audit cluster decrypt-filename disable**

Disable decrypting filename in audit telemetry

```sh
weka audit cluster decrypt-filename disable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster decrypt-filename enable**

Enable decrypting filename in audit telemetry

```sh
weka audit cluster decrypt-filename enable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster decrypt-fullpath**

Decrypt full file paths in audit telemetry

```sh
weka audit cluster decrypt-fullpath [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka audit cluster decrypt-fullpath disable**

Disable decrypting full file paths in audit telemetry

```sh
weka audit cluster decrypt-fullpath disable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster decrypt-fullpath enable**

Enable decrypting full file paths in audit telemetry

```sh
weka audit cluster decrypt-fullpath enable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster disable**

Disable audit logging cluster-wide

```sh
weka audit cluster disable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster enable**

Enable audit logging cluster-wide

```sh
weka audit cluster enable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster enhancer**

Audit cluster enhancer CLI

```sh
weka audit cluster enhancer [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka audit cluster enhancer disable**

Disable audit logging enhancement cluster-wide

```sh
weka audit cluster enhancer disable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster enhancer enable**

Enable audit logging enhancement cluster-wide

```sh
weka audit cluster enhancer enable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster resolve-paths**

Resolve full file paths in audit telemetry

```sh
weka audit cluster resolve-paths [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka audit cluster resolve-paths disable**

Disable resolving full file paths in audit telemetry

```sh
weka audit cluster resolve-paths disable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster resolve-paths enable**

Enable resolving full file paths in audit telemetry

```sh
weka audit cluster resolve-paths enable [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka audit cluster set-global-operations**

Define which operations to audit globally (can be 'All' or any subset)

```sh
weka audit cluster set-global-operations [--color color]
                                         [--HOST HOST]
                                         [--PORT PORT]
                                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                                         [--TIMEOUT TIMEOUT]
                                         [--profile profile]
                                         [--help]
                                         [--json]
                                         [<operations>]...
```

| Parameter                 | Description                                                                                                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `operations`...           | Audit operations to enable (e.g. 'All' or any from \[Open, Create, Read, ...]), replaces any previously enabled operations (format: 'none', 'open', 'create', 'read', 'modify', 'delete', 'rename', 'close', 'sessionmanagement' or 'all') |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                                                                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                 |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                     |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                   |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                                                                                                                                                      |

**weka audit cluster stats**

Audit logging cluster-wide stats

```sh
weka audit cluster stats [--color color]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--format format]
                         [--output output]...
                         [--sort sort]...
                         [--filter filter]...
                         [--filter-color filter-color]...
                         [--help]
                         [--raw-units]
                         [--UTC]
                         [--no-header]
                         [--verbose]
```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result (format: 'view', 'csv', 'markdown', 'json' or 'oldview')                                                                                    |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: node,category,timestamp,stat,unit,value,containerId,container,hostname,roles (may be repeated or comma-separated)    |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]] (may be repeated or comma-separated)                                                   |
| `--filter-color`...       | Filter rows with specific colors (red/yellow/green) (may be repeated or comma-separated)                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

**weka audit cluster status**

Audit logging cluster-wide status

```sh
weka audit cluster status [--color color]
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
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

#### weka audit fs

Audit filesystems CLI

```sh
weka audit fs [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka audit fs disable**

Disable audit on a filesystem

```sh
weka audit fs disable <name>
                      [--color color]
                      [--HOST HOST]
                      [--PORT PORT]
                      [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                      [--TIMEOUT TIMEOUT]
                      [--profile profile]
                      [--help]
```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Filesystem name                                                                                            |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka audit fs enable**

Enable audit on a filesystem

```sh
weka audit fs enable <name>
                     [--color color]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--help]
```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Filesystem name                                                                                            |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `-h`, `--help`            | Show help message                                                                                          |

**weka audit fs set-operations**

Override audit operations for a specific filesystem

```sh
weka audit fs set-operations <name>
                             [--color color]
                             [--HOST HOST]
                             [--PORT PORT]
                             [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                             [--TIMEOUT TIMEOUT]
                             [--profile profile]
                             [--help]
                             [--json]
                             [<operations>]...
```

| Parameter                 | Description                                                                                                                                                                                                                                                                                  |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Filesystem name                                                                                                                                                                                                                                                                              |
| `operations`...           | Audit operations to enable (e.g. 'All' or any subset of \[Open, Create, Read, Modify, Delete, Rename, Close, SessionManagement], replaces any previously enabled operations) (format: 'none', 'open', 'create', 'read', 'modify', 'delete', 'rename', 'close', 'sessionmanagement' or 'all') |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                                                                                                                             |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                                                                                                                             |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                                                                                                                             |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                   |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                                                                                                                       |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                                                                                                                     |
| `-h`, `--help`            | Show help message                                                                                                                                                                                                                                                                            |
| `-J`, `--json`            | Format output as JSON                                                                                                                                                                                                                                                                        |

**weka audit fs status**

List filesystems audit status

```sh
weka audit fs status [--name name]
                     [--color color]
                     [--HOST HOST]
                     [--PORT PORT]
                     [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                     [--TIMEOUT TIMEOUT]
                     [--profile profile]
                     [--format format]
                     [--output output]...
                     [--sort sort]...
                     [--filter filter]...
                     [--filter-color filter-color]...
                     [--help]
                     [--raw-units]
                     [--UTC]
                     [--no-header]
                     [--verbose]
```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--name`                  | Filesystem name                                                                                                                                                                         |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result (format: 'view', 'csv', 'markdown', 'json' or 'oldview')                                                                                    |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: uid,id,name,audit,audit\_string (may be repeated or comma-separated)                                                 |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]] (may be repeated or comma-separated)                                                   |
| `--filter-color`...       | Filter rows with specific colors (red/yellow/green) (may be repeated or comma-separated)                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |

#### weka catalog

Manage the Data Catalog service and indexed filesystem data

```sh
weka catalog [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

#### weka catalog cluster

Manage the catalog cluster infrastructure and status

```sh
weka catalog cluster [--color color] [--help]
```

| Parameter      | Description                                                                      |
| -------------- | -------------------------------------------------------------------------------- |
| `--color`      | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled') |
| `-h`, `--help` | Show help message                                                                |

**weka catalog cluster add**

Create a catalog cluster

```sh
weka catalog cluster add <indexfs>
                         [--color color]
                         [--HOST HOST]
                         [--PORT PORT]
                         [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                         [--TIMEOUT TIMEOUT]
                         [--profile profile]
                         [--containers containers]...
                         [--all-servers]
                         [--help]
                         [--json]
```

| Parameter                 | Description                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `indexfs`\*               | Name of the filesystem to store the catalog metadata                                                       |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                           |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                           |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                           |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited) |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)     |
| `--profile`               | Name of the connection and authentication profile to use                                                   |
| `--containers`...         | The dataservice containers that will be used to form catalog cluster (may be repeated or comma-separated)  |
| `--all-servers`           | Use all dataservice containers to form catalog cluster                                                     |
| `-h`, `--help`            | Show help message                                                                                          |
| `-J`, `--json`            | Format output as JSON                                                                                      |

**weka catalog cluster remove**

Destroy the catalog cluster

```sh
weka catalog cluster remove [--color color]
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--help]
                            [--force]
                            [--json]
```

| Parameter                 | Description                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                   |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                   |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                   |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)         |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)             |
| `--profile`               | Name of the connection and authentication profile to use                                                           |
| `-h`, `--help`            | Show help message                                                                                                  |
| `-f`, `--force`           | Force this action without further confirmation. This action will destroy the catalog cluster and cannot be undone. |
| `-J`, `--json`            | Format output as JSON                                                                                              |

**weka catalog cluster status**

Get catalog cluster status

```sh
weka catalog cluster status [--color color]
                            [--HOST HOST]
                            [--PORT PORT]
                            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
                            [--TIMEOUT TIMEOUT]
                            [--profile profile]
                            [--format format]
                            [--output output]...
                            [--sort sort]...
                            [--filter filter]...
                            [--filter-color filter-color]...
                            [--help]
                            [--raw-units]
                            [--UTC]
                            [--no-header]
                            [--verbose]
```

| Parameter                 | Description                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--color`                 | Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')                                                                                                        |
| `-H`, `--HOST`            | Specify the host. Alternatively, use the WEKA\_HOST env variable                                                                                                                        |
| `-P`, `--PORT`            | Specify the port. Alternatively, use the WEKA\_PORT env variable                                                                                                                        |
| `-C`, `--CONNECT-TIMEOUT` | Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                              |
| `-T`, `--TIMEOUT`         | Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited)                                                                                  |
| `--profile`               | Name of the connection and authentication profile to use                                                                                                                                |
| `-f`, `--format`          | Specify in what format to output the result (format: 'view', 'csv', 'markdown', 'json' or 'oldview')                                                                                    |
| `-o`, `--output`...       | Specify which columns to output. May include any of the following: servicename,id,hostname,container,ip,status,role (may be repeated or comma-separated)                                |
| `-s`, `--sort`...         | Specify which column(s) to take into account when sorting the output. May include a '+' or '-' before the column name to sort in ascending or descending order respectively. Usage: \[+ |
| `-F`, `--filter`...       | Specify what values to filter by in a specific column. Usage: column1=val1\[,column2=val2\[,..]] (may be repeated or comma-separated)                                                   |
| `--filter-color`...       | Filter rows with specific colors (red/yellow/green) (may be repeated or comma-separated)                                                                                                |
| `-h`, `--help`            | Show help message                                                                                                                                                                       |
| `-R`, `--raw-units`       | Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in human-readable format, e.g 1KiB 234MiB 2GiB.                                                       |
| `-U`, `--UTC`             | Print times in UTC. When not set, times are converted to the local time of this host.                                                                                                   |
| `--no-header`             | Don't show column headers when printing the output                                                                                                                                      |
| `-v`, `--verbose`         | Show all columns in output                                                                                                                                                              |
