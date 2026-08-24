---
description: View and manage WEKA system events.
---

# weka events

List all events that conform to the filter criteria.

```sh
weka events [--category <event-categories>…] [--cloud-time] [--direction <direction>] [--end-time <time>] [--exclude-type <event-types>…] [--no-proxy] [--num-results <uint>] [--proxy <string>] [--severity <severity>] [--show-internal] [--start-time <time>] [--type <event-types>…]
```

| Parameter                               | Description                                                                                                                                          |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-c`, `--category` \<event-categories>… | Include only events in this category. Multiple values may be supplied separated by commas, or the option may be repeated.                            |
| `-l`, `--cloud-time`                    | Sort by cloud time.                                                                                                                                  |
| `-d`, `--direction` \<direction>        | Fetch events from the first available event (forward) or the latest created event (backward). Default is backward.                                   |
| `--end-time` \<time>                    | Include only events that occurred at or before this time.                                                                                            |
| `-x`, `--exclude-type` \<event-types>…  | Remove events by type. Glob patterns (\*, ?, \[]) are supported. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--no-proxy`                            | Do not use an HTTP proxy when connecting to the cloud.                                                                                               |
| `-n`, `--num-results` \<uint>           | Maximum number of events to report.                                                                                                                  |
| `--proxy` \<string>                     | Use the given proxy for connecting to the cloud.                                                                                                     |
| `--severity` \<severity>                | Include events with equal and higher severity.                                                                                                       |
| `-i`, `--show-internal`                 | Show internal events.                                                                                                                                |
| `--start-time` \<time>                  | Include only events that occurred at or after this time.                                                                                             |
| `-t`, `--type` \<event-types>…          | Filter events by type. Glob patterns (\*, ?, \[]) are supported. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `timestamp`, `cloudTime`, `process`, `category`, `severity`, `type`, `entity`, `synopsis`, `description`

## weka events categories

Show the event categories.

```sh
weka events categories [--show-internal]
```

| Parameter         | Description           |
| ----------------- | --------------------- |
| `--show-internal` | Show internal events. |

**Columns:** `category`

## weka events local

List recent events that happened on the machine running this command.

```sh
weka events local [--all] [--end-time <time>] [--next <string>] [--show-internal] [--start-time <time>] [--stem-mode] [--tenant <tenant>]
```

| Parameter               | Description                                                                |
| ----------------------- | -------------------------------------------------------------------------- |
| `--all`                 | Instead of only retrieving a single page, get the entire set of events.    |
| `--end-time` \<time>    | Include only events that occurred at or before this time.                  |
| `--next` \<string>      | Token for next page of events. Leave empty to start paging through events. |
| `-i`, `--show-internal` | Show internal events.                                                      |
| `--start-time` \<time>  | Include only events that occurred at or after this time.                   |
| `--stem-mode`           | Show STEM mode events.                                                     |
| `--tenant` \<tenant>    | Filter events by tenant name or ID.                                        |

**Columns:** `timestamp`, `process`, `category`, `severity`, `type`, `entity`, `synopsis`, `description`

## weka events trigger

Trigger a custom event with a user defined parameter.

```sh
weka events trigger <message>
```

| Parameter   | Description                                          |
| ----------- | ---------------------------------------------------- |
| `message`\* | User defined text to trigger as the event parameter. |

## weka events types

Show the event type definition information.

```sh
weka events types [--category <event-categories>…] [--show-internal] [--type <event-types>…]
```

| Parameter                               | Description                                                                                                                       |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-c`, `--category` \<event-categories>… | List only events of the specified categories. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--show-internal`                       | Show internal events.                                                                                                             |
| `-t`, `--type` \<event-types>…          | List only events of the specified types. Multiple values may be supplied separated by commas, or the option may be repeated.      |

**Columns:** `type`, `category`, `severity`, `description`, `format`, `permission`, `parameters`, `dedup`, `dedupParams`
