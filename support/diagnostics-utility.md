---
description: >-
  This page describes the diagnostics CLI command which is used for running
  cluster diagnostics.
---

# Diagnostics CLI Command

## Overview

The diagnostics CLI command is used for collecting and uploading diagnostic data about clusters and hosts for analysis by the Weka Support and R\&D Teams in order to help with troubleshooting. There are two relevant commands:

* `weka diags` used for cluster-wide diagnostics from any host in the cluster.
* `weka local diags` used for running diagnostics on a specific host, which should be used if the host cannot connect to the cluster.

## Collecting Diags

**Command:** `weka diags collect`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Weka Support team:

`weka diags collect [--id id] [--timeout timeout] [--output-dir output-dir] [--core-limit core-limit] [--clients] [--tar]`

If the command is run with the `local` keyword, information is collected only from the host on which the command is executed. Otherwise, information is collected from the whole cluster.&#x20;

**Parameters in Command Line**

| **Name**     | **Type** | **Value**                                               | **Limitations**                                              | **Mandatory** | **Default**       |
| ------------ | -------- | ------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ----------------- |
| `id`         | String   | Specified ID for this dump                              |                                                              | No            | Auto-generated    |
| `timeout`    | String   | How long to wait when downloading diags from all hosts  | <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p> | No            | 10 minutes        |
| `output-dir` | String   | Directory to save the  dump to                          |                                                              | No            | `/opt/weka/diags` |
| `core-limit` | Number   | Limit to processing this number of core dumps, if found |                                                              | No            | 1                 |
| `clients`    | Boolean  | Collect from client hosts as well                       |                                                              | No            | No                |
| `tar`        | Boolean  | Create a TAR of all collected diags                     |                                                              | No            | No                |

{% hint style="info" %}
**Note:** In the following situations the `local` option should be used: no functioning management process in the originating host or the hosts being addressed, no connectivity between the management process and the cluster leader, the cluster has no leader, the local container is down, the host cannot reach the leader or a remote host fails to respond to the `weka diags` remote command.
{% endhint %}

## Uploading Diags to Weka Home

**Command:** `weka diags upload`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Weka Support team:

`weka diags upload [--timeout timeout] [--core-limit core-limit] [--dump-id dump-id] [--host-id host-id]... [--clients]`

**Parameters in Command Line**

| **Name**     | **Type**                        | **Value**                                               | **Limitations**                                              | **Mandatory** | **Default**                                      |
| ------------ | ------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ------------------------------------------------ |
| `timeout`    | String                          | How long to wait for diags to upload                    | <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p> | No            | 10 minutes                                       |
| `core-limit` | Number                          | Limit to processing this number of core dumps, if found |                                                              | No            | 1                                                |
| `dump-id`    | String                          | ID of an existing dump to upload                        | This dump ID has to exist on this local machine              | No            | If an ID is not specified, a new dump is created |
| `host-id`    | Comma-separated list of numbers | Host IDs to collect diags from                          | This flag causes `--clients` to be ignored                   | No            | All hosts                                        |
| `clients`    | Boolean                         | Collect from client hosts as well                       |                                                              | No            | No                                               |

When running the command with the `upload` option, the information is uploaded to a Weka-owned S3 bucket, and an access identifier is provided as an output. This access identifier should be sent to the Weka Support Team, which will retrieve the information from the S3 bucket.

{% hint style="info" %}
**Note:** The `upload` command requires Internet connectivity which allows HTTPS access to AWS S3 endpoints.
{% endhint %}

{% hint style="info" %}
**Note:** The upload process is asynchronous. Therefore connectivity failures will be reflected in failure events on the event log, while the command will still exit successfully.
{% endhint %}

## Weka Processes Traces

The Weka processes constantly create traces. These traces are rotating to consume only a defined capacity. When encountering issues, sometimes there is a need for Weka support to observe those traces and, in some situations, to prevent specific traces from rotating until resolution.

It is possible to control the traces retention settings using the various `weka debug traces` CLI commands.
