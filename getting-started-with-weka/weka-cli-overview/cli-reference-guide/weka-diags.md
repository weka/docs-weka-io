---
description: Collect and manage WEKA diagnostic information.
---

# weka diags

Understand the status of the cluster and its environment.

```sh
weka diags
```

## weka diags collect

Collect diags from the cluster's containers into a directory on this container.

```sh
weka diags collect [--backends] [--clients] [--container-id <container-ids>…] [--core-limit <uint>] [--id <string>] [--output-dir <string>] [--tar] [--timeout <duration>]
```
| Parameter | Description |
| `--backends` | Collect diags from backend containers. Use it with --clients to collect from all containers. |
| `--clients` | Collect diags from client containers only. By default diags are only collected from backends. |
| `--container-id` \<container-ids>… | Containers to collect diags from. Ignored when --clients or --backends is given. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-c`, `--core-limit` \<uint> | Limit to processing this number of core dumps, if found. The default is 1. |
| `-i`, `--id` \<string> | Optional ID for this dump. If not specified, a random ID is generated. |
| `-d`, `--output-dir` \<string> | Directory to save the diags dump to. The default is /opt/weka/diags. |
| `-t`, `--tar` | Create a TAR of all collected diags. |
| `-m`, `--timeout` \<duration> | How long to wait when downloading diags from all containers. The default is 10 minutes, 0 means indefinitely. |

## weka diags list

List the diags collections on this container, or show the report of one.

```sh
weka diags list [<id>]
```
| Parameter | Description |
| `id` | ID of the dump to show, or a path to the diags dump. If not specified, a list of all collected diags is shown. |
**Columns:** `id`, `path`, `created`

## weka diags rm

Remove a diags collection from every container, and cancel its upload to WEKA Home.

```sh
weka diags rm [<id>] [--all]
```
| Parameter | Description |
| `id` | ID of the diags collection to remove. Required unless --all is given. |
| `--all` | Remove every diags collection. |

## weka diags upload

Collect diags from the cluster's containers and upload them to WEKA Home.

```sh
weka diags upload [--backends] [--clients] [--container-id <container-ids>…] [--core-limit <uint>] [--dump-id <string>] [--no-tar] [--timeout <duration>]
```
| Parameter | Description |
| `--backends` | Collect diags from backend containers. Use it with --clients to collect from all containers. |
| `--clients` | Collect diags from client containers only. By default diags are only collected from backends. |
| `--container-id` \<container-ids>… | Containers to collect diags from. Ignored when --clients or --backends is given. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-c`, `--core-limit` \<uint> | Limit to processing this number of core dumps, if found. The default is 1. |
| `--dump-id` \<string> | ID of an existing dump to upload. This dump ID has to exist on this local server. If an ID is not specified, a new dump is created. |
| `--no-tar` | Do not tar and compress local files. |
| `-m`, `--timeout` \<duration> | How long to wait for diags to upload. The default is 10 minutes, 0 means indefinitely. |
