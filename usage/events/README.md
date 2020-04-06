---
description: >-
  This page describes the events available in the WEKA system and how to work
  with them.
---

# Events

## Overview

WEKA events indicate relevant information concerning the WEKA cluster and customer environment. Triggered by a customer operation or an environment change, events can be informational, indicate a problem in the system or indicate a \(previous\) problem that has been resolved.

## Working with Events Using the GUI

### Viewing Events

To view the events screen using the GUI, click the Events Log button on the left bar:

![Events View Screen](../../.gitbook/assets/events-log.png)

### Filtering Events

Events can be filtered by choosing a filter. Filtering can be performed according to event severity, category, IDs and timestamps. Selection of multiple filters is also possible \(for event categories and event IDs\).

![Event Filtering](../../.gitbook/assets/events-filtering.png)

## Working with Events Using the CLI

### Viewing Events

**Command:** `weka events`

Use the following command line to list events in the WEKA cluster:

`weka events [--num-results num-results] [--start-time <start>] [--end-time <end>] [--severity severity] [--direction direction] [--fetch-order fetch-order] [--type-list type-list] [--exclude-type-list exclude-type-list] [--category-list category-list] [--by-digested-time] [--show-internal] [--raw-units] [--UTC]`

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |


<table>
  <thead>
    <tr>
      <th style="text-align:left"><code>num-results</code>
      </th>
      <th style="text-align:left">Integer</th>
      <th style="text-align:left">Maximum number of events to display</th>
      <th style="text-align:left">
        <p>Positive integer.</p>
        <p>0 shows all events.</p>
      </th>
      <th style="text-align:left">No</th>
      <th style="text-align:left">50</th>
    </tr>
  </thead>
  <tbody></tbody>
</table>| `start-time` | String | Include events that occurred at this start time and later | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No | -365 days |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `end-time` | String | Include events that occurred up to this time | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No | Set to a time represents 'now' |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `severity` | String | Include events with this level of severity and higher | 'info', 'warning', 'minor', 'major' or 'critical' | No | INFO |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `direction` | String | Sort events by ascending or descending time | 'asc' or 'dsc' | No | asc |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `fetch-order` | String | Fetch from end-time backwards or from start-time forwards | 'fw' or 'bw' | No | bw |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `type-list` | String | Filter events by type \(can be used multiple times\) | Use `weka events list-types` to see available types | No | None |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `exclude-type-list` | String | Filter-out events by type \(can be used multiple times\) | Use `weka events list-types` to see available types |  |  |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `category-list` | String | Include only events matching the defined category | Categories can be Alerts, Cloud, Clustering, Drive, Events, Filesystem, IO, InterfaceGroup, Licensing, NFS, Network, Node, ObjectStorage, Raid, Statistics, System, Upgrade, User | No | All |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `digested-time` | Boolean | Query and sort results by digested time |  | No | False |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `show-internal` | Boolean | Also displays internal events |  | No | False |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `raw-units` | Boolean | Print values in raw units \(bytes, seconds, etc.\) |  | No | Human-readable format, e.g 1KiB 234MiB 2GiB |
| :--- | :--- | :--- | :--- | :--- | :--- |


| `UTC` | Boolean | Print times in UTC |  | No | Host's local time |
| :--- | :--- | :--- | :--- | :--- | :--- |


**Command:** `weka events list-local`

Use the following command line to list recent events on the specific host running the command from \(can be useful for cases there is no connectivity to support cloud, no connectivity from a specific host, or for hosts which are not part of the cluster\):

`weka events list-local [--start-time <start>] [--end-time <end>] [--next next] [--stem-mode] [--show-internal] [--raw-units] [--UTC]`

**Parameters in Command Line**

| Name | Type | Value | Limitations | Mandatory | Default |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `start-time` | String | Include events that occurred at this start time and later | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No | -365 days |
| `end-time` | String | Include events that occurred up to this time | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No | Set to a time represents  'now' |
| `next` | String | Identifier to the next page of events | As returned in the previous call to `weka events list-local` | No |  |
| `stem-mode` | Boolean | Displays events when the host has not been attached to the cluster |  | No | False |
| `show-internal` | Boolean | Also displays internal events |  | No | False |
| `raw-units` | Boolean | Print values in raw units \(bytes, seconds, etc.\) |  | No | Human-readable format, e.g 1KiB 234MiB 2GiB |
| `UTC` | Boolean | Print times in UTC |  | No | Host's local time |

### List of Events

{% page-ref page="list-of-events.md" %}

