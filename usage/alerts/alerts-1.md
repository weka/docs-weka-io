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

`weka alerts [--muted]`

**Parameters**

| Name    | Value                                     | Default |
| ------- | ----------------------------------------- | ------- |
| `muted` | List muted alerts alongside unmuted ones. | False   |

## **Mute alerts**

**Command:** `weka alerts mute`

Use the following command line to mute an alert type:

`weka alerts mute <alert-type> <duration>`

The system does not prompt muted alerts when listing active alerts. You must specify the duration in which the alert-type is muted. After the expiry of the specified duration, the system unmutes the alert-type automatically.

**Parameters**

| Name           | Value                                                                                                                                                                 |
| -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alert-type`\* | An alert-type to mute, use `weka alerts types` to list types.                                                                                                         |
| `duration`\*   | <p>Expiration time for muting this alert type.<br>Format: <code>3s</code>, <code>2h</code>, <code>4m</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>.</p> |

## **Unmute alerts**

**Command:** `weka alerts unmute`

Use the following command line to unmute a muted alert-type:

`weka alerts unmute <alert-type>`

**Parameters**

| Name           | Value                                                           |
| -------------- | --------------------------------------------------------------- |
| `alert-type`\* | An alert-type to unmute, use `weka alerts types` to list types. |



**Related topics**

[list-of-alerts.md](list-of-alerts.md "mention")
