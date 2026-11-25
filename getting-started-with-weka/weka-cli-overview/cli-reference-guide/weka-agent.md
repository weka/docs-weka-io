---
description: Manage the local WEKA agent process.
---

# weka agent

Manage the WEKA agent process.

```sh
weka agent
```

## weka agent autocomplete

Install, remove, or export auto-completion script for bash.

```sh
weka agent autocomplete
```

## weka agent install-agent

Install WEKA agent on the local machine.

```sh
weka agent install-agent [--no-start] [--no-update] [--systemd-graceful-shutdown]
```

| Parameter                     | Description                                                             |
| ----------------------------- | ----------------------------------------------------------------------- |
| `--no-start`                  | Do not register the weka-agent service and start it after its creation. |
| `--no-update`                 | Don't update the locally installed containers.                          |
| `--systemd-graceful-shutdown` | Enable graceful shutdown via systemd.                                   |

## weka agent restart

Stop and start WEKA agent on the server the command is executed from. If the agent is not running yet, it will be started.

```sh
weka agent restart
```

## weka agent uninstall

Delete all WEKA files, drivers, shared memory and any other remainder from the machine this command is executed from. This action is destructive and might cause a loss of data!

```sh
weka agent uninstall [--force] [--ignore-wekafs-mounts] [--keep-files]
```

| Parameter                | Description                                                             |
| ------------------------ | ----------------------------------------------------------------------- |
| `-f`, `--force`          | Force action. Perform this action without further confirmation.         |
| `--ignore-wekafs-mounts` | Proceed even with active wekafs mounts. This may result in hung mounts! |
| `--keep-files`           | Do not remove WEKA version images and keep in installation directory.   |

## weka agent update-containers

Update the currently available containers and version specs to the current agent version. This command does not update WEKA, only the container's representation on the local machine.

```sh
weka agent update-containers
```
