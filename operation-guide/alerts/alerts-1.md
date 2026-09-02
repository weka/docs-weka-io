---
description: This page describes how to manage alerts using the CLI.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/operation-guide/alerts/alerts-1
---

# Manage alerts using the CLI

Using the CLI, you can:

* [Display alert types](alerts-1.md#view-alerts)
* [View alerts](alerts-1.md#mute-alerts)
* [Mute alerts](alerts-1.md#mute-alerts)
* [Unmute alerts](alerts-1.md#unmute-alerts)

## **Display alert types**

**Command:** `weka alerts types`

Use this command to list all possible types of alerts that the WEKA cluster can return.

**Command:**`weka alerts describe`

Use this command to describe all the alert types the WEKA cluster can return, along with possible corrective actions for each alert.

## **View alerts**

**Command:** `weka alerts`

Use the following command line to list all alerts (muted and unmuted) in the WEKA cluster:

`weka alerts [--severity severity] [--muted] [--inactive]`

**Parameters**

<table><thead><tr><th width="144.89453125">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>severity</code></td><td>List alerts with the specified severity level and higher. Default: <code>warning</code>. Supported values: <code>debug</code> (hidden), '<code>warning</code>' (lowest), <code>minor</code>, <code>major</code> or <code>critical</code> (highest).</td></tr><tr><td><code>muted</code></td><td>List muted alerts in addition to active alerts.</td></tr><tr><td><code>inactive</code></td><td>List alerts that recently transitioned to an inactive state.</td></tr></tbody></table>

#### `weka alerts` output parameters

Explore the output parameters of the `weka alerts` command.

<table><thead><tr><th width="217.90234375">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>action</code></td><td>Displays the recommended action to resolve the alert.</td></tr><tr><td><code>active_duration</code></td><td>Indicates the duration for which the alert has been active.</td></tr><tr><td><code>comment</code></td><td>Shows any user-added comments for the alert.</td></tr><tr><td><code>count</code></td><td>Provides the number of times the alert has occurred.</td></tr><tr><td><code>description</code></td><td>Explains the alert in detail.</td></tr><tr><td><code>end_time</code></td><td>Specifies the time when the alert was resolved.</td></tr><tr><td><code>mute_time_remaining</code></td><td>Indicates the remaining time until the alert is unmuted.</td></tr><tr><td><code>muted</code></td><td>Shows whether the alert is currently muted (<code>muted</code> or <code>unmuted</code>).</td></tr><tr><td><code>severity</code></td><td>Defines the severity level of the alert, for example, <code>WARNING</code>.</td></tr><tr><td><code>start_time</code></td><td>Specifies the start time when an alert type first started, not when each individual alert instance was generated.</td></tr><tr><td><code>title</code></td><td>Provides a concise title for the alert.</td></tr><tr><td><code>type</code></td><td>Identifies the unique type of the alert.</td></tr></tbody></table>

<details>

<summary>Example</summary>

```
$weka alerts
TYPE              SEVERITY  MUTED  START TIME  COUNT  TITLE                                MUTE TIME REMAINING  COMMENT
SystemDefinedTLS  WARNING   Muted  11:30:55h       1  TLS certificate is not user-defined        30d 12:32:37h

$weka alerts --format json
[
    {
        "action": "Replace the auto-generated self-signed certificate with a user-defined certificate by running the command 'weka security tls set'.",
        "active_duration": null,
        "comment": null,
        "count": 1,
        "description": "The system uses an auto-generated self-signed TLS certificate.",
        "end_time": "",
        "mute_time_remaining": 2637140,
        "muted": true,
        "severity": "WARNING",
        "start_time": "2025-08-13T03:33:18.807934Z",
        "title": "TLS certificate is not user-defined",
        "type": "SystemDefinedTLS"
    }
]
```

</details>

## **Mute alerts**

**Command:** `weka alerts mute`

Use the following command line to mute an alert type:

```
weka alerts mute <alert-type> <duration> /
[--comment comment] /
[--process process]... /
[--container container]... /
[--hostname hostname]...
```

The system does not prompt muted alerts when listing active alerts. You must specify the duration in which the alert-type is muted. After the expiry of the specified duration, the system unmutes the alert-type automatically.

**Parameters**

<table><thead><tr><th width="179.95703125">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code>*</td><td>Specifies the alert type to mute. Run <code>weka alerts types</code> to list all possible types.</td></tr><tr><td><code>duration</code>*</td><td><p>Sets the duration for the mute. Examples: <code>30m</code>, <code>2h</code>, <code>1d.</code></p><p>Format: <code>3s</code>, <code>2h</code>, <code>4m</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>, <code>infinite/unlimited</code></p></td></tr><tr><td><code>comment</code></td><td>Specifies a comment to provide context for the mute action.</td></tr><tr><td><code>process</code></td><td>Mutes alerts for specific process IDs. This parameter applies only to process-specific alerts. If omitted or used on a non-process alert, the system mutes all alerts of this type. For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr><tr><td><code>container</code></td><td>Mutes alerts for specific container IDs. This parameter applies only to container-specific alerts. If omitted or used on a non-container alert, the system mutes all alerts of this type. For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr><tr><td><code>hostname</code></td><td>Mutes alerts for specific hostnames. This parameter applies only to server-specific alerts. If omitted or used on a non-server alert, the system mutes all alerts of this type. For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr></tbody></table>

**Examples**

```bash
weka alerts mute NodeNetworkUnstable 6h --server "datasphere-*"
weka alerts mute NodeNetworkUnstable 23m --process 261 --comment "Muted until network is stable"
```

### View muted alerts

To list all currently muted alert types with their mute configuration, use the following command:

`weka alerts mute list`

### Add items to mute scope&#x20;

**Command:** `weka alerts mute add` &#x20;

Use the following command line to add more items to the mute scope for an already muted alert-type. You can add more process/container/hostname items to the existing scope. Duration and comment remain unchanged.

```
weka alerts mute add <alert-type> /
[--process process]... /
[--container container]... /
[--hostname hostname]...
```

**Parameters**

<table><thead><tr><th width="168.48828125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>alert-type</code>*</td><td>Specifies the alert type to update mute scope for. Run <code>weka alerts types</code> to list all possible types.</td></tr><tr><td><code>process</code>...</td><td>Adds specific process IDs to the mute scope. This parameter applies only to process-specific alerts. For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr><tr><td><code>container</code>...</td><td>Adds specific container IDs to the mute scope. Use this parameter for container-specific alerts only.For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr><tr><td><code>hostname</code>...</td><td>Adds specific server names to the mute scope. Use this parameter for server-specific alerts only. For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr></tbody></table>

### Remove items from mute scope

**Command:** `weka alerts mute remove` &#x20;

Remove specific items from the mute scope of an already muted alert-type. You can remove specific\
process, container, or hostname items from the existing scope. If all items are removed, the alert is completely unmuted.

```
weka alerts mute remove <alert-type> /
[--process process]... /
[--container container]... /
[--hostname hostname]...
```

**Parameters**

<table><thead><tr><th width="163.90625">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>alert-type</code>*</td><td>Specifies the alert type to remove from mute scope. Run <code>weka alerts types</code> to list all possible types.</td></tr><tr><td><code>process</code>...</td><td>Removes specific process IDs from the mute scope. This parameter applies only to process-specific alerts. For multiple entries, provide a comma-separated list or repeat the parameter.</td></tr><tr><td><code>container</code>...</td><td>Removes specific container IDs from the mute scope. Use this parameter for container-specific alerts only. Provide a comma-separated list or repeat the parameter for multiple IDs.</td></tr><tr><td><code>hostname</code>...</td><td>Removes specific server names from the mute scope. Use this parameter for server-specific alerts only. Provide a comma-separated list or repeat the parameter for multiple names.</td></tr></tbody></table>

## **Unmute alerts**

**Command:** `weka alerts unmute`

Use the following command line to unmute a muted Alert Type:

`weka alerts unmute <alert-type>`

**Parameters**

<table><thead><tr><th width="221">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code>*</td><td>An alert-type to unmute, use <code>weka alerts types</code> to list types.</td></tr></tbody></table>
