---
description: >-
  This page describes the diagnostics CLI commands used for collecting and
  uploading the diagnostics data.
---

# Collect and upload diagnostics data

The diagnostics CLI command is used for collecting and uploading diagnostic data about clusters, servers, and containers for analysis by the Customer Success Team and R\&D team to help with troubleshooting. There are two relevant commands:

* `weka diags` used for cluster-wide diagnostics from any server in the cluster.
* `weka local diags` used for running diagnostics on a specific server, which should be used if the server cannot connect to the cluster.

## Collect diagnostics

**Command:** `weka diags collect`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Customer Success Team:

`weka diags collect [--id id] [--timeout timeout] [--output-dir output-dir] [--core-limit core-limit] [--clients] [--tar]`

If the command runs with the `local` keyword, information is collected only from the server on which the command is executed. Otherwise, information is collected from the whole cluster.&#x20;

**Parameters**

| **Name**     | **Type** | **Value**                                                | **Limitations**                                              | **Mandatory** | **Default**       |
| ------------ | -------- | -------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ----------------- |
| `id`         | String   | Specified ID for this dump                               |                                                              | No            | Auto-generated    |
| `timeout`    | String   | How long to wait when downloading diags from all servers | <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p> | No            | 10 minutes        |
| `output-dir` | String   | Directory to save the  dump to                           |                                                              | No            | `/opt/weka/diags` |
| `core-limit` | Number   | Limit to processing this number of core dumps, if found  |                                                              | No            | 1                 |
| `clients`    | Boolean  | Collect from client servers as well                      |                                                              | No            | No                |
| `tar`        | Boolean  | Create a TAR of all collected diags                      |                                                              | No            | No                |

{% hint style="info" %}
**Note:** In the following situations the `local` option should be used: no functioning management process in the originating server or the servers being addressed, no connectivity between the management process and the cluster leader, the cluster has no leader, the local container is down, the server cannot reach the leader or a remote server fails to respond to the `weka diags` remote command.
{% endhint %}

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
**Note:** The upload process is asynchronous. Therefore connectivity failures are reflected in failure events on the event log, while the command still exits successfully.the&#x20;
{% endhint %}
