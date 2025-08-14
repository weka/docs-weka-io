---
description: This page describes how to manage alerts using the CLI.
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

`weka alerts [--severity severity]`` ``[--muted]`

**Parameters**

<table><thead><tr><th width="221.9609375">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>severity</code></td><td>Include event with equal and higher severity, default: WARNING Format: <code>debug</code>, <code>warning</code>, <code>minor</code>, <code>major</code> or <code>critical</code></td></tr><tr><td><code>muted</code></td><td>List muted alerts alongside unmuted ones.</td></tr></tbody></table>

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

`weka alerts mute <alert-type> <duration>`

The system does not prompt muted alerts when listing active alerts. You must specify the duration in which the alert-type is muted. After the expiry of the specified duration, the system unmutes the alert-type automatically.

**Parameters**

<table><thead><tr><th width="226">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code>*</td><td>An alert-type to mute, use <code>weka alerts types</code> to list types.</td></tr><tr><td><code>duration</code>*</td><td>Expiration time for muting this alert type.<br>Format: <code>3s</code>, <code>2h</code>, <code>4m</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>.</td></tr></tbody></table>

## **Unmute alerts**

**Command:** `weka alerts unmute`

Use the following command line to unmute a muted alert-type:

`weka alerts unmute <alert-type>`

**Parameters**

<table><thead><tr><th width="221">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code>*</td><td>An alert-type to unmute, use <code>weka alerts types</code> to list types.</td></tr></tbody></table>
