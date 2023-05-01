---
description: This page describes how to manage events using the CLI.
---

# Manage events using the CLI

With the CLI, you can:

* [View events](events-1.md#view-events)
* [View events of a specific container](events-1.md#view-events-of-a-specific-container)
* [Trigger a custom event](events-1.md#trigger-a-custom-event)

## View events

**Command:** `weka events`

Use the following command line to list events in the Weka cluster:

`weka events [--num-results num-results] [--start-time <start-time>] [--end-time <end-time>] [--severity severity] [--direction direction] [--fetch-order fetch-order] [--type-list type-list] [--exclude-type-list exclude-type-list] [--category-list category-list] [--cloud-time] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

| **Name**            | **Type** | **Value**                                                  | **Limitations**                                                                                                                                                                                                                                   | **Mandatory** | **Default**                                 |
| ------------------- | -------- | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------------------------------------- |
| `num-results`       | Integer  | Maximum number of events to display                        | <p>Positive integer. </p><p>0 shows all events.</p>                                                                                                                                                                                               | No            | 50                                          |
| `start-time`        | String   | Include events that occurred at this start time and later  | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00                                                                                                                  | No            | -365 days                                   |
| `end-time`          | String   | Include events that occurred up to this time               | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00                                                                                                                  | No            | Set to a time represents  'now'             |
| `severity`          | String   | Include events with this level of severity and higher      |  'info', 'warning', 'minor', 'major' or 'critical'                                                                                                                                                                                                | No            | INFO                                        |
| `direction`         | String   | Sort events by ascending or descending time                | 'asc' or 'dsc'                                                                                                                                                                                                                                    | No            | asc                                         |
| `fetch-order`       | String   | Fetch from end-time backwards or from start-time forwards  | 'fw' or 'bw'                                                                                                                                                                                                                                      | No            | bw                                          |
| `type-list`         | String   | Filter events by type (can be used multiple times)         | Use `weka events list-types` to see available types                                                                                                                                                                                               | No            | None                                        |
| `exclude-type-list` | String   | Filter-out events by type (can be used multiple times)     | Use `weka events list-types` to see available types                                                                                                                                                                                               |               |                                             |
| `category-list`     | String   | Include only events matching the defined  category         | The category options include Alerts, Cloud, Clustering, Config, Custom, Drive, Events, Filesystem, InterfaceGroup, Kms, Licensing, NFS, Network, Node, ObjectStorage, Org, Raid, Resources, S3, Security, Smb, System, Traces, Upgrade, and User. | No            | All                                         |
| `cloud-time`        | Boolean  | Query and sort results by the digested time in the cloud   |                                                                                                                                                                                                                                                   | No            | False                                       |
| `show-internal`     | Boolean  | Also displays internal events                              |                                                                                                                                                                                                                                                   | No            | False                                       |
| `raw-units`         | Boolean  | Print values in raw units (bytes, seconds, etc.)           |                                                                                                                                                                                                                                                   | No            | Human-readable format, e.g 1KiB 234MiB 2GiB |
| `UTC`               | Boolean  | Print times in UTC                                         |                                                                                                                                                                                                                                                   | No            | Host's local time                           |

## View events of a specific container

**Command:** `weka events list-local`

Use the following command line to list recent events on the specific container running the command from.

This command is helpful for the following cases:

* No connectivity to the central monitoring site
* No connectivity from a specific container
* Containers that are not part of the cluster

`weka events list-local [--start-time <start-time>] [--end-time <end-time>] [--next next] [--stem-mode] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

| **Name**        | **Type** | **Value**                                                               | **Limitations**                                                                                                                  | **Mandatory** | D**efault**                                 |
| --------------- | -------- | ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------------------------------------- |
| `start-time`    | String   | Include events that occurred at this start time and later               | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No            | -365 days                                   |
| `end-time`      | String   | Include events that occurred up to this time                            | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No            | Set to a time represents  'now'             |
| `next`          | String   | Identifier to the next page of events                                   | As returned in the previous call to `weka events list-local`                                                                     | No            |                                             |
| `stem-mode`     | Boolean  | Displays events when the container has not been attached to the cluster |                                                                                                                                  | No            | False                                       |
| `show-internal` | Boolean  | Also displays internal events                                           |                                                                                                                                  | No            | False                                       |
| `raw-units`     | Boolean  | Print values in raw units (bytes, seconds, etc.)                        |                                                                                                                                  | No            | Human-readable format, e.g 1KiB 234MiB 2GiB |
| `UTC`           | Boolean  | Print times in UTC                                                      |                                                                                                                                  | No            | Server's local time                         |

## Trigger a custom event

**Command:** `weka events trigger-event`&#x20;

It can be useful to mark specific activities, maintenance work, or important changes/new usage of the system, and see that as part of the system events timeline.&#x20;

To trigger a custom event, use `weka events trigger-event <text>`



**Related topics**

[list-of-events.md](list-of-events.md "mention")
