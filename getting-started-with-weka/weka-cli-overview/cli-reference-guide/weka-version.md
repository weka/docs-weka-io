# weka version

Lists the versions available on this machine.

```sh
weka version [--checksum] [--client-only] [--driver-only] [--full]
```

| Parameter       | Description                                                |
| --------------- | ---------------------------------------------------------- |
| `--checksum`    | Verify content checksums. This can take a bit longer.      |
| `--client-only` | Show versions with components required for a client.       |
| `--driver-only` | Show versions with components required to compile drivers. |
| `--full`        | Show only fully installed versions.                        |

**Columns:** `version`, `current`, `full`, `client`, `driver`

## weka version current

Print the current software version. If no version is set, a failure exit status is returned.

```sh
weka version current [--container <container>]
```

| Parameter                        | Description                         |
| -------------------------------- | ----------------------------------- |
| `-C`, `--container` \<container> | Get version for specific container. |

## weka version get

Download a software version to the local machine.

```sh
weka version get <version> [--agent-only] [--client-only] [--driver-only] [--from <server>…] [--no-progress-bar] [--set-current] [--set-dist-servers] [--token <string>]
```

| Parameter            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `version`\*          | Software version to download.                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `--agent-only`       | Only download the agent.                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `--client-only`      | Only download the components needed for a client.                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `--driver-only`      | Only download the components required for compiling drivers.                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `--from` \<server>…  | Download from this distribution server. Accepts https:// (and http://) URLs as well as file:// for a local on-disk tree (e.g. file:///opt/weka-mirror laid out as \<root>/dist/{release,image,drivers}/...). If not specified, distribution servers are taken from the $WEKA\_DIST\_SERVERS environment variable, the /etc/wekaio/dist-servers file, or /etc/wekaio/service.conf in that order of precedence. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--no-progress-bar`  | Don't render download progress bar.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `--set-current`      | Set downloaded version as current version. Fails if any containers are running.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `--set-dist-servers` | Update the default list of distribution servers upon successful download.                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `--token` \<string>  | This token is used when downloading from get.weka.io. Visit https://get.weka.io/ui/account/api-tokens to obtain a token.                                                                                                                                                                                                                                                                                                                                                                          |

## weka version prepare

Prepare the software version for use. This includes compiling the version drivers for the local machine.

```sh
weka version prepare <version> [<container>…]
```

| Parameter    | Description              |
| ------------ | ------------------------ |
| `version`\*  | Version name to prepare. |
| `container`… | Containers to prepare.   |

## weka version reset

Reset the current version. Containers must be stopped before resetting the current version.

```sh
weka version reset
```

## weka version rm

Delete an installed software version from the machine this command is executed from.

```sh
weka version rm [<version>…] [--clean-unused] [--force]
```

| Parameter        | Description                                                                       |
| ---------------- | --------------------------------------------------------------------------------- |
| `version`…       | Version name(s) to remove.                                                        |
| `--clean-unused` | Remove all versions which aren't the current version or in use by any containers. |
| `-f`, `--force`  | Force action. Perform this action without further confirmation.                   |

## weka version set

Set the current version. Containers must be stopped before setting the current version and the new version must have already been downloaded.

```sh
weka version set <version> [--agent-only] [--allow-running-containers] [--client-only] [--container <container>] [--default-only] [--set-dependent]
```

| Parameter                        | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
| `version`\*                      | Version name to use.                                                  |
| `--agent-only`                   | Only set the agent version.                                           |
| `--allow-running-containers`     | Do not verify that all containers are stopped before setting version. |
| `--client-only`                  | Only require client components when setting the version.              |
| `-C`, `--container` \<container> | Set the version for this container only.                              |
| `--default-only`                 | Only set the default version used for creating containers.            |
| `--set-dependent`                | Updates all containers depending on the specified container.          |
