---
description: >-
  List the alert types the cluster can raise, view active alerts, and mute or
  unmute an alert type from the command line.
---

# Manage alerts using the CLI

## Display alert types

Lists every alert type the cluster can raise.

**Command:** `weka alerts types`

```sh
weka alerts types
```

**Example**

{% code overflow="wrap" %}
```bash
$ weka alerts types
AdminDefaultPassword
AgentNotRunning
ApproachingClientsUnavailability
ApproachingSystemLimit
AutoRemoveTimeoutTooLow
AvailableMemory
BackendNumaBalancingEnabled
...
WTracerDaemonWriteIOFailures
WTracerLostTraces
```
{% endcode %}

### Describe alert types

Shows the description and recommended action for an alert type.

**Command:** `weka alerts describe`

```sh
weka alerts describe
```

## View alerts

Lists the alerts currently raised in the cluster. By default the output shows active alerts of severity `warning` and higher.

**Command:** `weka alerts`

```sh
weka alerts [--inactive] [--muted] [--severity <severity>]
```

**Parameters**

| Parameter                | Description                                         |
| --- | --- |
| `--inactive` | List inactive alerts. |
| `--muted` | List muted alerts alongside the unmuted ones. |
| `--severity` \<severity> | Include alerts at the specified severity or higher. |

**Output columns**

<table><thead><tr><th width="196.38671875">Column</th><th>Description</th></tr></thead><tbody><tr><td><code>TYPE</code></td><td>Alert type identifier, as listed by <code>weka alerts types</code>.</td></tr><tr><td><code>SEVERITY</code></td><td>Severity of the alert, for example <code>WARNING</code>.</td></tr><tr><td><code>MUTED</code></td><td>Whether the alert type is currently muted.</td></tr><tr><td><code>START TIME</code></td><td>Time the alert type first became active. This is not the time each individual alert instance was generated.</td></tr><tr><td><code>COUNT</code></td><td>Number of times the alert occurred.</td></tr><tr><td><code>TITLE</code></td><td>Short title of the alert.</td></tr><tr><td><code>MUTE TIME REMAINING</code></td><td>Time left until the alert type is unmuted automatically.</td></tr><tr><td><code>COMMENT</code></td><td>Comment added when the alert type was muted.</td></tr></tbody></table>

**Examples**

List the active alerts:

```bash
$ weka alerts
TYPE              SEVERITY  MUTED  START TIME  COUNT  TITLE                              MUTE TIME REMAINING  COMMENT
SystemDefinedTLS  WARNING   Muted  11:30:55h   1      TLS certificate is not user-defined  30d 12:32:37h
```

Return the same alerts in JSON to see the full description and the recommended action:

```bash
$ weka alerts --format json
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

**JSON fields**

<table><thead><tr><th width="208.6796875">Field</th><th>Description</th></tr></thead><tbody><tr><td><code>action</code></td><td>Recommended action to resolve the alert.</td></tr><tr><td><code>active_duration</code></td><td>Time the alert has been active.</td></tr><tr><td><code>comment</code></td><td>Comment added when the alert type was muted.</td></tr><tr><td><code>count</code></td><td>Number of times the alert occurred.</td></tr><tr><td><code>description</code></td><td>Full explanation of the alert.</td></tr><tr><td><code>end_time</code></td><td>Time the alert was resolved.</td></tr><tr><td><code>mute_time_remaining</code></td><td>Time left until the alert type is unmuted automatically, in seconds.</td></tr><tr><td><code>muted</code></td><td>Whether the alert type is currently muted.</td></tr><tr><td><code>severity</code></td><td>Severity of the alert, for example <code>WARNING</code>.</td></tr><tr><td><code>start_time</code></td><td>Time the alert type first became active. This is not the time each individual alert instance was generated.</td></tr><tr><td><code>title</code></td><td>Short title of the alert.</td></tr><tr><td><code>type</code></td><td>Alert type identifier, as listed by <code>weka alerts types</code>.</td></tr></tbody></table>

### Mute an alert type

Silences an alert type for a set period, so it stops appearing in the active list.

**Command:** `weka alerts mute`

```sh
weka alerts mute <alert-type> <duration> [--comment <string>] [--container <container-ids>…] [--hostname <strings>…] [--process <process-ids>…]
```

**Parameters**

| Parameter                       | Description                                                                                                                                                                                                                                        |
| --- | --- |
| `alert-type`\* | Alert type to mute. Use 'weka alerts types' to list available types. |
| `duration`\* | Duration to mute this alert type. |
| `--comment` \<string> | Explanatory comment. Provides context for the mute action. |
| `--container` \<container-ids>… | Limit muting to the specified container. Applies only to container-specific alerts; if the alert is not container-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--hostname` \<strings>… | Limit muting to the specified server. Applies only to server-specific alerts; if the alert is not server-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--process` \<process-ids>… | Limit muting to the specified process. Applies only to process-specific alerts; if the alert is not process-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |

To set a scope with more than one value, provide a comma-separated list or repeat the parameter.

If you omit `process`, `container`, and `hostname`, or set them on an alert that is not specific to that entity, the cluster mutes every alert of this type.

**Examples**

Mute an alert type on a group of servers for six hours:

```bash
weka alerts mute NodeNetworkUnstable 6h --hostname "datasphere-*"
```

Mute an alert type on one process, and record why:

```bash
weka alerts mute NodeNetworkUnstable 23m --process 261 --comment "Muted until network is stable"
```

### View muted alert types

Lists the alert types currently muted and how long each mute has left.

**Command:** `weka alerts mute list`

```sh
weka alerts mute list
```

### Add items to a mute scope

Narrows a mute to specific containers, processes, or hostnames instead of the whole cluster.

**Command:** `weka alerts mute add`

```sh
weka alerts mute add <alert-type> [--container <container-ids>…] [--hostname <strings>…] [--process <process-ids>…]
```

**Parameters**

| Parameter                       | Description                                                                                                                                                                                                                                        |
| --- | --- |
| `alert-type`\* | Alert type to modify. Use 'weka alerts types' to list available types. |
| `--container` \<container-ids>… | Mute alerts for the specified container. Applies only to container-specific alerts; if the alert is not container-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--hostname` \<strings>… | Mute alerts for the specified server. Applies only to server-specific alerts; if the alert is not server-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--process` \<process-ids>… | Mute alerts for the specified process. Applies only to process-specific alerts; if the alert is not process-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |

To add more than one value, provide a comma-separated list or repeat the parameter.

**Example**

```bash
weka alerts mute add NodeNetworkUnstable --process 261,262
```

### Remove items from a mute scope

Removes containers, processes, or hostnames from an alert type's mute scope.

**Command:** `weka alerts mute remove`

```sh
weka alerts mute remove <alert-type> [--container <container-ids>…] [--hostname <strings>…] [--process <process-ids>…]
```

**Parameters**

| Parameter                       | Description                                                                                                                                                                                                                                                  |
| --- | --- |
| `alert-type`\* | Alert type to modify. Use 'weka alerts types' to list available types. |
| `--container` \<container-ids>… | Remove mute filter for the specified container. Applies only to container-specific alerts; if the alert is not container-specific, all alerts of this type are affected. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--hostname` \<strings>… | Remove mute filter for the specified server. Applies only to server-specific alerts; if the alert is not server-specific, all alerts of this type are affected. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--process` \<process-ids>… | Remove mute filter for the specified process. Applies only to process-specific alerts; if the alert is not process-specific, all alerts of this type are affected. Multiple values may be supplied separated by commas, or the option may be repeated. |

To remove more than one value, provide a comma-separated list or repeat the parameter.

Removing the last item from the mute scope unmutes the alert type completely.

**Example**

```bash
weka alerts mute remove NodeNetworkUnstable --process 262
```

### Unmute an alert type

Ends the mute on an alert type so it appears in the active list again.

**Command:** `weka alerts unmute`

```sh
weka alerts unmute <alert-type>
```

**Parameters**

| Parameter      | Description                                                            |
| --- | --- |
| `alert-type`\* | Alert type to unmute. Use 'weka alerts types' to list available types. |

**Example**

```bash
weka alerts unmute NodeNetworkUnstable
```
