---
description: >-
  List the alert types the cluster can raise, view active alerts, and mute or
  unmute an alert type from the command line.
---

# Manage alerts using the CLI

## Display alert types

List the identifiers of every alert type the cluster can raise. Use an identifier from this list wherever a command takes an `alert-type` value.

**Command:** `weka alerts types`

{% code overflow="wrap" %}
```bash
weka alerts types
```
{% endcode %}

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

Show each alert type with its description and the recommended corrective action. Run this command to understand what an alert means before you act on it or mute it.

**Command:** `weka alerts describe`

```bash
weka alerts describe
```

## View alerts

List the alerts currently raised in the cluster. By default, the output shows active alerts of severity `warning` and higher.

**Command:** `weka alerts`

```bash
weka alerts [--severity <severity>] [--muted] [--inactive]
```

**Parameters**

<table><thead><tr><th width="137.8046875">Name</th><th width="480.16015625">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>severity</code></td><td>List alerts of the specified severity and higher. Supported values, from lowest to highest: <code>debug</code> (hidden from the default output), <code>warning</code>, <code>minor</code>, <code>major</code>, <code>critical</code>.</td><td><code>warning</code></td></tr><tr><td><code>muted</code></td><td>Include muted alerts in the output.</td><td>False</td></tr><tr><td><code>inactive</code></td><td>Include alerts that recently transitioned to an inactive state.</td><td>False</td></tr></tbody></table>

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

Mute an alert type for a set duration. Muted alerts do not appear in the default output of `weka alerts`. When the duration expires, the cluster unmutes the alert type automatically.

Mute an alert type for the whole cluster, or limit the mute to specific processes, containers, or servers. These are the mute scope.

**Command:** `weka alerts mute`

```bash
weka alerts mute <alert-type> <duration> [--comment <comment>]
[--process <process>]... [--container <container>]... [--hostname <hostname>]...
```

**Parameters**

<table><thead><tr><th width="158.71875">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code> *</td><td>Alert type to mute. Run <code>weka alerts types</code> to list the available types.</td></tr><tr><td><code>duration</code> *</td><td>Length of the mute. Format examples: <code>3s</code>, <code>4m</code>, <code>2h</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>, <code>infinite</code>, <code>unlimited</code>.</td></tr><tr><td><code>comment</code></td><td>Comment that records why the alert type is muted.</td></tr><tr><td><code>process</code></td><td>Mute the alert only for the specified process IDs. Applies to process-specific alerts only.</td></tr><tr><td><code>container</code></td><td>Mute the alert only for the specified container IDs. Applies to container-specific alerts only.</td></tr><tr><td><code>hostname</code></td><td>Mute the alert only for the specified servers. Applies to server-specific alerts only.</td></tr></tbody></table>

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

List the currently muted alert types with their mute duration, comment, and scope.

**Command:** `weka alerts mute list`

```bash
weka alerts mute list
```

### Add items to a mute scope

Extend the mute scope of an alert type that is already muted. The duration and the comment remain unchanged.

**Command:** `weka alerts mute add`

```bash
weka alerts mute add <alert-type>
[--process <process>]... [--container <container>]... [--hostname <hostname>]...
```

**Parameters**

<table><thead><tr><th width="159.8359375">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code> *</td><td>Alert type to update. Run <code>weka alerts types</code> to list the available types.</td></tr><tr><td><code>process</code></td><td>Add the specified process IDs to the mute scope. Applies to process-specific alerts only.</td></tr><tr><td><code>container</code></td><td>Add the specified container IDs to the mute scope. Applies to container-specific alerts only.</td></tr><tr><td><code>hostname</code></td><td>Add the specified servers to the mute scope. Applies to server-specific alerts only.</td></tr></tbody></table>

To add more than one value, provide a comma-separated list or repeat the parameter.

**Example**

```bash
weka alerts mute add NodeNetworkUnstable --process 261,262
```

### Remove items from a mute scope

Remove processes, containers, or servers from the mute scope of an alert type that is already muted.

**Command:** `weka alerts mute remove`

```bash
weka alerts mute remove <alert-type>
[--process <process>]... [--container <container>]... [--hostname <hostname>]...
```

**Parameters**

<table><thead><tr><th width="154.83203125">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code> *</td><td>Alert type to update. Run <code>weka alerts types</code> to list the available types.</td></tr><tr><td><code>process</code></td><td>Remove the specified process IDs from the mute scope. Applies to process-specific alerts only.</td></tr><tr><td><code>container</code></td><td>Remove the specified container IDs from the mute scope. Applies to container-specific alerts only.</td></tr><tr><td><code>hostname</code></td><td>Remove the specified servers from the mute scope. Applies to server-specific alerts only.</td></tr></tbody></table>

To remove more than one value, provide a comma-separated list or repeat the parameter.

Removing the last item from the mute scope unmutes the alert type completely.

**Example**

```bash
weka alerts mute remove NodeNetworkUnstable --process 262
```

### Unmute an alert type

Unmute an alert type before its mute duration expires. The alert type returns to the default output of `weka alerts`.

**Command:** `weka alerts unmute`

```bash
weka alerts unmute <alert-type>
```

**Parameters**

<table><thead><tr><th width="165.07421875">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>alert-type</code> *</td><td>Alert type to unmute. Run <code>weka alerts types</code> to list the available types.</td></tr></tbody></table>

**Example**

```bash
weka alerts unmute NodeNetworkUnstable
```
