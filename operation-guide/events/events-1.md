---
description: This page describes how to manage events using the CLI.
---

# Manage events using the CLI

## View events

**Command:** `weka events`

Use the following command line to list events in the Weka cluster:

`weka events [--num-results num-results] [--start-time <start-time>] [--end-time <end-time>] [--severity severity] [--direction direction] [--fetch-order fetch-order] [--type-list type-list] [--exclude-type-list exclude-type-list] [--category-list category-list] [--cloud-time] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

| Name                | Value                                                                                                                                                                                                                                                                                                                               | Default                                    |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| `num-results`       | Maximum number of events to display.Positive integer. 0 shows all events.                                                                                                                                                                                                                                                           | 50                                         |
| `start-time`        | Include events that occurred at this start time and later.Format: `5m`, `-5m`, `-1d`, `-1w`, `1:00, 01:00`, `18:30`, `18:30:07`, `2018-12-31 10:00`, `2018/12/31 10:00`, `2018-12-31T10:00`, `9:15Z`, `10:00+2:00`.                                                                                                                 | -365 days                                  |
| `end-time`          | Include events that occurred up to this time.Format: `5m`, `-5m`, `-1d`, `-1w`, `1:00, 01:00`, `18:30`, `18:30:07`, `2018-12-31 10:00`, `2018/12/31 10:00`, `2018-12-31T10:00`, `9:15Z`, `10:00+2:00`.                                                                                                                              | Set to a time represents 'now'             |
| `severity`          | Include events with this level of severity and higher.Possible values: `info`, `warning`, `minor`, `major`, `critical`.                                                                                                                                                                                                             | `info`                                     |
| `direction`         | Sort events by ascending or descending time.Possible values: `as`c, `dsc`.                                                                                                                                                                                                                                                          | `asc`                                      |
| `fetch-order`       | Fetch from end-time and backward or start-time and forward.Possible values: `fw`, `bw`                                                                                                                                                                                                                                              | `bw`                                       |
| `type-list`         | Filter events by type (can be used multiple times).Use `weka events list-types` to see available types.                                                                                                                                                                                                                             | None                                       |
| `exclude-type-list` | Filter-out events by type (can be used multiple times).Use `weka events list-types` to see available types.                                                                                                                                                                                                                         |                                            |
| `category-list`     | Include only events matching the defined category.Possible values: `Alerts`, `Cloud`, `Clustering`, `Config`, `Custom`, `Drive`, `Events`, `Filesystem`, `InterfaceGroup`, `Kms`, `Licensing`, `NFS, Network`, `Node`, `ObjectStorage`, `Org`, `Raid`, `Resources`, `S3`, `Security`, `Smb`, `System`, `Traces`, `Upgrade`, `User`. | All                                        |
| `cloud-time`        | Query and sort results by the digested time in the cloud                                                                                                                                                                                                                                                                            | False                                      |
| `show-internal`     | Also displays internal events                                                                                                                                                                                                                                                                                                       | False                                      |
| `raw-units`         | Print values in raw units such as bytes and seconds.                                                                                                                                                                                                                                                                                | Readable format. Example: 1KiB 234MiB 2GiB |
| `UTC`               | Print times in UTC                                                                                                                                                                                                                                                                                                                  | Host's local time                          |

## View events of a specific container

**Command:** `weka events list-local`

Use the following command line to list recent events on the specific container running the command from.

This command is helpful for the following cases:

* No connectivity to the central monitoring site
* No connectivity from a specific container
* Containers that are not part of the cluster

`weka events list-local [--start-time <start-time>] [--end-time <end-time>] [--next next] [--stem-mode] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

| Name            | Value                                                                                                                                                                                                               | Default                                      |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| `start-time`    | Include events that occurred at this start time and later.Format: `5m`, `-5m`, `-1d`, `-1w`, `1:00, 01:00`, `18:30`, `18:30:07`, `2018-12-31 10:00`, `2018/12/31 10:00`, `2018-12-31T10:00`, `9:15Z`, `10:00+2:00`. | -365 days                                    |
| `end-time`      | Include events that occurred up to this time.Format: `5m`, `-5m`, `-1d`, `-1w`, `1:00, 01:00`, `18:30`, `18:30:07`, `2018-12-31 10:00`, `2018/12/31 10:00`, `2018-12-31T10:00`, `9:15Z`, `10:00+2:00`.              | Set to a time represents 'now'               |
| `next`          | Identifier to the next page of events.As returned in the previous call to `weka events list-local`.                                                                                                                 |                                              |
| `stem-mode`     | Displays events when the container has not been attached to the cluster                                                                                                                                             | False                                        |
| `show-internal` | Also displays internal events                                                                                                                                                                                       | False                                        |
| `raw-units`     | Print values in raw units, such as bytes and seconds.                                                                                                                                                               | Readable format. Examples: 1KiB 234MiB 2GiB. |
| `UTC`           | Print times in UTC.                                                                                                                                                                                                 | Server's local time.                         |

## Trigger a custom event

**Command:** `weka events trigger-event`

It can be useful to mark specific activities, maintenance work, or important changes/new usage of the system, and see that as part of the system events timeline.

To trigger a custom event, use `weka events trigger-event <text>`
