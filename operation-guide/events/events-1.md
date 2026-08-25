---
description: View, filter, and trigger cluster and container events using the CLI.
---

# Manage events using the CLI

## View events

Lists cluster events, filtered by time range, severity, type, or category.

**Command:** `weka events`

```sh
weka events [--category <event-categories>…] [--cloud-time] [--direction <direction>] [--end-time <time>] [--exclude-type <event-types>…] [--no-proxy] [--num-results <uint>] [--proxy <string>] [--severity <severity>] [--show-internal] [--start-time <time>] [--type <event-types>…]
```

**Parameters**

| Parameter                               | Description                                                                                                                                          |
| --- | --- |
| `-c`, `--category` \<event-categories>… | Include only events in this category. Multiple values may be supplied separated by commas, or the option may be repeated. Possible values: `Alerts`, `Cloud`, `Clustering`, `Config`, `Custom`, `Drive`, `Events`, `Filesystem`, `InterfaceGroup`, `Kms`, `Licensing`, `NFS, Network`, `Node`, `ObjectStorage`, `Org`, `Raid`, `Resources`, `S3`, `Security`, `Smb`, `System`, `Traces`, `Upgrade`, `User` |
| `-l`, `--cloud-time` | Sort by cloud time. |
| `-d`, `--direction` \<direction> | Fetch events from the first available event (forward) or the latest created event (backward). Default is backward. Possible values: `forward`, `backward` |
| `--end-time` \<time> | Include only events that occurred at or before this time. |
| `-x`, `--exclude-type` \<event-types>… | Remove events by type. Glob patterns (\*, ?, \[]) are supported. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--no-proxy` | Do not use an HTTP proxy when connecting to the cloud. |
| `-n`, `--num-results` \<uint> | Maximum number of events to report. |
| `--proxy` \<string> | Use the given proxy for connecting to the cloud. |
| `--severity` \<severity> | Include events with equal and higher severity. Possible values: `info`, `warning`, `minor`, `major`, `critical` |
| `-i`, `--show-internal` | Show internal events. |
| `--start-time` \<time> | Include only events that occurred at or after this time. |
| `-t`, `--type` \<event-types>… | Filter events by type. Glob patterns (\*, ?, \[]) are supported. Multiple values may be supplied separated by commas, or the option may be repeated. |

## View events of a specific container

Lists the events recorded locally by one container, which is useful when the container cannot reach the cluster leader.

**Command:** `weka events local`

```sh
weka events local [--all] [--end-time <time>] [--next <string>] [--show-internal] [--start-time <time>] [--stem-mode] [--tenant <tenant>]
```

**Parameters**

| Parameter               | Description                                                                |
| --- | --- |
| `--all` | Instead of only retrieving a single page, get the entire set of events. |
| `--end-time` \<time> | Include only events that occurred at or before this time. |
| `--next` \<string> | Token for next page of events. Leave empty to start paging through events. |
| `-i`, `--show-internal` | Show internal events. |
| `--start-time` \<time> | Include only events that occurred at or after this time. |
| `--stem-mode` | Show STEM mode events. |
| `--tenant` \<tenant> | Filter events by tenant name or ID. |

## Trigger a custom event

Records a custom event in the cluster event log, for marking a maintenance window or a change made outside the CLI.

**Command:** `weka events trigger`

```sh
weka events trigger <message>
```

**Parameters**

| Parameter   | Description                                          |
| --- | --- |
| `message`\* | User defined text to trigger as the event parameter. |
