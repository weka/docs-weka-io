---
description: >-
  This page describes the events available in the WekaIO system and how to work
  with them.
---

# Events

## Overview

WekaIO events indicate relevant information concerning the WekaIO cluster and customer environment. Triggered by a customer operation or an environment change, events can be informational, indicate a problem in the system or indicate a \(previous\) problem that has been resolved.

## Working with Events Using the GUI

### Viewing Events

To view the events screen using the GUI, click the Events Log button on the left bar:  

![Events View Screen](../../.gitbook/assets/events-log.png)

### Filtering Events

Events can be filtered by choosing a filter. Filtering can be performed according to event severity, category, IDs and timestamps. Selection of multiple filters is also possible \(for event categories and event IDs\).

![Event Filtering](../../.gitbook/assets/events-filtering.png)

## Working with Events Using the CLI

**Command:** `weka events`

Use this command line to list events in the WekaIO cluster.

`weka events [--num-results num-results] [--start-time <start>] [--end-time <end>] [--severity severity] [--sort-order sort-order] [--fetch-order fetch-order]` 

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
      <td style="text-align:left"><code>-n, --num-results</code>
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
      <td style="text-align:left"><code>--start-time</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include events that occurred at this start time and later</td>
      <td style="text-align:left">Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00,
        2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">-365 days</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>--end-time</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include events that occurred up to this time</td>
      <td style="text-align:left">format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00,
        2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">Set to a time represents &apos;now&apos;</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>-s, --severity</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include events with this level of severity and higher</td>
      <td style="text-align:left">&apos;info&apos;, &apos;warning&apos;, &apos;minor&apos;, &apos;major&apos;
        or &apos;critical&apos;</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">INFO</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>--sort-order</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Sort events by ascending or descending time</td>
      <td style="text-align:left">&apos;asc&apos; or &apos;dsc&apos;</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">asc</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>--fetch-order</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Fetch from end-time backwards or from start-time forwards</td>
      <td style="text-align:left">&apos;fw&apos; or &apos;bw&apos;</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">bw</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>-t, --type-list</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Filter events by type (can be used multiple times)</td>
      <td style="text-align:left">use &apos;weka events list-types&apos; to see available types</td>
      <td
      style="text-align:left">No</td>
        <td style="text-align:left">None</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>-c, --category-list</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Include only events matching the defined category</td>
      <td style="text-align:left">Categories can be Alerts, Cloud, Clustering, Drive, Events, Filesystem,
        InterfaceGroup, Licensing, NFS, Network, Node, ObjectStorage, Raid, System,
        Upgrade, User</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">All</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>--by-digested-time</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Query and sort results by digested time</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">False</td>
    </tr>
  </tbody>
</table>

