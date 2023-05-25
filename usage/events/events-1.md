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

<table><thead><tr><th width="197">Name</th><th width="358">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>num-results</code></td><td>Maximum number of events to display.<br>Positive integer. 0 shows all events.</td><td>50</td></tr><tr><td><code>start-time</code></td><td>Include events that occurred at this start time and later.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00, 01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>-365 days</td></tr><tr><td><code>end-time</code></td><td>Include events that occurred up to this time.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00, 01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>Set to a time represents  'now'</td></tr><tr><td><code>severity</code></td><td>Include events with this level of severity and higher.<br>Possible values: <code>info</code>, <code>warning</code>, <code>minor</code>, <code>major</code>, <code>critical</code>.</td><td><code>info</code></td></tr><tr><td><code>direction</code></td><td>Sort events by ascending or descending time.<br>Possible values: <code>as</code>c, <code>dsc</code>.</td><td><code>asc</code></td></tr><tr><td><code>fetch-order</code></td><td>Fetch from end-time and backward or start-time and forward.<br>Possible values: <code>fw</code>, <code>bw</code></td><td><code>bw</code></td></tr><tr><td><code>type-list</code></td><td>Filter events by type (can be used multiple times).<br>Use <code>weka events list-types</code> to see available types.</td><td>None</td></tr><tr><td><code>exclude-type-list</code></td><td>Filter-out events by type (can be used multiple times).<br>Use <code>weka events list-types</code> to see available types.</td><td></td></tr><tr><td><code>category-list</code></td><td>Include only events matching the defined category.<br>Possible values: <code>Alerts</code>, <code>Cloud</code>, <code>Clustering</code>, <code>Config</code>, <code>Custom</code>, <code>Drive</code>, <code>Events</code>, <code>Filesystem</code>, <code>InterfaceGroup</code>, <code>Kms</code>, <code>Licensing</code>, <code>NFS, Network</code>, <code>Node</code>, <code>ObjectStorage</code>, <code>Org</code>, <code>Raid</code>, <code>Resources</code>, <code>S3</code>, <code>Security</code>, <code>Smb</code>, <code>System</code>, <code>Traces</code>, <code>Upgrade</code>, <code>User</code>.</td><td>All</td></tr><tr><td><code>cloud-time</code></td><td>Query and sort results by the digested time in the cloud</td><td>False</td></tr><tr><td><code>show-internal</code></td><td>Also displays internal events</td><td>False</td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units such as bytes and seconds.</td><td>Readable format. Example: 1KiB 234MiB 2GiB</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC</td><td>Host's local time</td></tr></tbody></table>

## View events of a specific container

**Command:** `weka events list-local`

Use the following command line to list recent events on the specific container running the command from.

This command is helpful for the following cases:

* No connectivity to the central monitoring site
* No connectivity from a specific container
* Containers that are not part of the cluster

`weka events list-local [--start-time <start-time>] [--end-time <end-time>] [--next next] [--stem-mode] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

<table><thead><tr><th width="181">Name</th><th width="357">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>start-time</code></td><td>Include events that occurred at this start time and later.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00, 01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>-365 days</td></tr><tr><td><code>end-time</code></td><td>Include events that occurred up to this time.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00, 01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>Set to a time represents  'now'</td></tr><tr><td><code>next</code></td><td>Identifier to the next page of events.<br>As returned in the previous call to <code>weka events list-local</code>.</td><td></td></tr><tr><td><code>stem-mode</code></td><td>Displays events when the container has not been attached to the cluster</td><td>False</td></tr><tr><td><code>show-internal</code></td><td>Also displays internal events</td><td>False</td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units, such as bytes and seconds.</td><td>Readable format. Examples: 1KiB 234MiB 2GiB.</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC.</td><td>Server's local time.</td></tr></tbody></table>

## Trigger a custom event

**Command:** `weka events trigger-event`&#x20;

It can be useful to mark specific activities, maintenance work, or important changes/new usage of the system, and see that as part of the system events timeline.&#x20;

To trigger a custom event, use `weka events trigger-event <text>`



**Related topics**

[list-of-events.md](list-of-events.md "mention")
