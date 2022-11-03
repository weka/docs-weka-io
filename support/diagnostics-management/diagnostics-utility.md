---
description: >-
  This page describes the diagnostics CLI commands used for collecting and
  uploading the diagnostics data.
---

# Collect and upload diagnostics data

The diagnostics CLI command is used for collecting and uploading diagnostic data about clusters, servers, and containers for analysis by the Customer Success Team to help with troubleshooting. There are two relevant commands:

* `weka diags`: Run this command to get cluster-wide diagnostics from any server in the cluster.
* `weka local diags`: Run this command to get diagnostics on a specific server when it cannot connect to the cluster.&#x20;

The `weka local diags` command is useful in the following situations:

* No functioning management process in the originating backend server or the specified backend servers.
* No connectivity between the management process and the cluster leader.
* The cluster has no leader.
* The local container is down.
* The server cannot reach the leader or a remote server fails to respond to the `weka diags` remote command.

## Collect diagnostics

**Command:** `weka diags collect`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Customer Success Team:

`weka diags collect [--id id] [--timeout timeout] [--output-dir output-dir] [--core-limit core-limit] [--container-id container-id] [--clients] [--backends] [--tar]`

If the command runs with the `local` keyword, information is collected only from the server on which the command is executed. Otherwise, information is collected from the whole cluster.&#x20;

**Parameters**

| **Name**       | **Type** | **Value**                                                         | **Limitations**                                                               | **Mandatory** | **Default**       |
| -------------- | -------- | ----------------------------------------------------------------- | ----------------------------------------------------------------------------- | ------------- | ----------------- |
| `id`           | String   | Specified ID for this dump                                        |                                                                               | No            | Auto-generated    |
| `timeout`      | String   | How long to wait when downloading diags from all servers          | <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p>                  | No            | 10 minutes        |
| `output-dir`   | String   | Directory to save the  dump to                                    |                                                                               | No            | `/opt/weka/diags` |
| `core-limit`   | Number   | Limit to processing this number of core dumps, if found           |                                                                               | No            | 1                 |
| `container-id` | Number   | Container IDs to collect diags from. Can be used multiple times.  | If set, the system ignores the `--clients` value                              | No            |                   |
| `clients`      | Boolean  | Collect diags also from clients.                                  | If `container-id` is set, the system ignores the `clients` value              | No            | No                |
| `backends`     | Boolean  | Collect diags from all backend containers and clients.            | Use in combination with `--clients` to collect from all backends and clients. | No            | No                |
| `tar`          | Boolean  | Create a TAR of all collected diags.                              |                                                                               | No            | No                |

## Upload diagnostics to Weka Home

**Command:** `weka diags upload`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Customer Success Team:

`weka diags upload [--timeout timeout] [--core-limit core-limit] [--dump-id dump-id] [--container-id container-id]... [--clients]`

**Parameters**

| **Name**       | **Type**                        | **Value**                                               | **Limitations**                                              | **Mandatory** | **Default**                                      |
| -------------- | ------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ------------------------------------------------ |
| `timeout`      | String                          | How long to wait for diags to upload                    | <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p> | No            | 10 minutes                                       |
| `core-limit`   | Number                          | Limit to processing this number of core dumps, if found |                                                              | No            | 1                                                |
| `dump-id`      | String                          | ID of an existing dump to upload                        | This dump ID has to exist on this local server               | No            | If an ID is not specified, a new dump is created |
| `container-id` | Comma-separated list of numbers | Container IDs to collect diags from                     | This flag causes `--clients` to be ignored                   | No            | All containers                                   |
| `clients`      | Boolean                         | Collect from client containers as well                  |                                                              | No            | No                                               |

When running the command with the `upload` option, the information is uploaded to the Weka support cloud (Weka Home), and an access identifier is provided as an output. You send this access identifier to the Customer Success Team for retrieving the information from the Weka Home.

{% hint style="info" %}
**Note:** The `upload` command requires HTTPS access to AWS S3 endpoints.
{% endhint %}

{% hint style="info" %}
**Note:** The upload process is asynchronous. Therefore connectivity failures are reflected in failure events on the event log, while the command still exits successfully.&#x20;
{% endhint %}
