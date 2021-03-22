---
description: >-
  This page describes the events available in the Weka system and how to work
  with them.
---

# Events

## Overview

Weka events indicate relevant information concerning the Weka cluster and customer environment. Triggered by a customer operation or an environment change, events can be informational, indicate a problem in the system or indicate a \(previous\) problem that has been resolved.

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

Use the following command line to list events in the Weka cluster:

`weka events [--num-results num-results] [--start-time <start-time>] [--end-time <end-time>] [--severity severity] [--direction direction] [--fetch-order fetch-order] [--type-list type-list] [--exclude-type-list exclude-type-list] [--category-list category-list] [--cloud-time] [--show-internal] [--raw-units] [--UTC]`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left">Name</th>
      <th style="text-align:left">Type</th>
      <th style="text-align:left">Value</th>
      <th style="text-align:left">Limitations</th>
      <th style="text-align:left">Mandatory</th>
      <th style="text-align:left">Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>num-results</code>
      </td>
      <td style="text-align:left">Integer</td>
      <td style="text-align:left">Maximum number of events to display</td>
      <td style="text-align:left">
        <p>Positive integer.</p>
        <p>0 shows all events.</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">50</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>start-time</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include events that occurred at this start time and later</td>
      <td style="text-align:left">Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00,
        2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">-365 days</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>end-time</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include events that occurred up to this time</td>
      <td style="text-align:left">Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00,
        2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">Set to a time represents &apos;now&apos;</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>severity</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include events with this level of severity and higher</td>
      <td style="text-align:left">&apos;info&apos;, &apos;warning&apos;, &apos;minor&apos;, &apos;major&apos;
        or &apos;critical&apos;</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">INFO</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>direction</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Sort events by ascending or descending time</td>
      <td style="text-align:left">&apos;asc&apos; or &apos;dsc&apos;</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">asc</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>fetch-order</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Fetch from end-time backwards or from start-time forwards</td>
      <td style="text-align:left">&apos;fw&apos; or &apos;bw&apos;</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">bw</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>type-list</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Filter events by type (can be used multiple times)</td>
      <td style="text-align:left">Use <code>weka events list-types</code> to see available types</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">None</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>exclude-type-list</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Filter-out events by type (can be used multiple times)</td>
      <td style="text-align:left">Use <code>weka events list-types</code> to see available types</td>
      <td style="text-align:left"></td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>category-list</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include only events matching the defined category</td>
      <td style="text-align:left">Categories can be Alerts, Cloud, Clustering, Drive, Events, Filesystem,
        IO, InterfaceGroup, Licensing, NFS, Network, Node, ObjectStorage, Raid,
        Statistics, System, Upgrade, User</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">All</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>cloud-time</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Query and sort results by the digested time in the cloud</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">False</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>show-internal</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Also displays internal events</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">False</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>raw-units</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Print values in raw units (bytes, seconds, etc.)</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">Human-readable format, e.g 1KiB 234MiB 2GiB</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>UTC</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Print times in UTC</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">Host&apos;s local time</td>
    </tr>
  </tbody>
</table>

**Command:** `weka events list-local`

Use the following command line to list recent events on the specific host running the command from \(can be useful for cases there is no connectivity to support cloud, no connectivity from a specific host, or for hosts which are not part of the cluster\):

`weka events list-local [--start-time <start-time>] [--end-time <end-time>] [--next next] [--stem-mode] [--show-internal] [--raw-units] [--UTC]`

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

### Triggering a Custom Event

**Command:** `weka events trigger-event` 

It can be useful to mark specific activities, maintenance work, or important changes/new usage of the system, and see that as part of the system events timeline. 

To trigger a custom event use `weka events trigger-event <text>`

### List of Events

{% page-ref page="list-of-events.md" %}

