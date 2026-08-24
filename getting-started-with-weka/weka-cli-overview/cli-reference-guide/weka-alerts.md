---
description: View and manage WEKA cluster alerts.
---

# weka alerts

List alerts in the Weka cluster.

```sh
weka alerts [--inactive] [--muted] [--severity <severity>]
```

| Parameter                | Description                                         |
| ------------------------ | --------------------------------------------------- |
| `--inactive`             | List inactive alerts.                               |
| `--muted`                | List muted alerts alongside the unmuted ones.       |
| `--severity` \<severity> | Include alerts at the specified severity or higher. |

**Columns:** `type`, `muted`, `severity`, `time`, `end_time`, `activeDuration`, `count`, `title`, `description`, `action`, `mute_time_remaining`, `mute_reason`

## weka alerts describe

Describe all the alert types that might be returned from the Weka cluster, including explanations and how to handle them.

```sh
weka alerts describe
```

**Columns:** `type`, `title`, `action`, `severity`

## weka alerts mute

Mute an alert type. Muted alerts will not appear in the list of active alerts. A duration is required; the alert type unmutes automatically when the duration expires.

```sh
weka alerts mute <alert-type> <duration> [--comment <string>] [--container <container-ids>…] [--hostname <strings>…] [--process <process-ids>…]
```

| Parameter                       | Description                                                                                                                                                                                                                                        |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alert-type`\*                  | Alert type to mute. Use 'weka alerts types' to list available types.                                                                                                                                                                               |
| `duration`\*                    | Duration to mute this alert type.                                                                                                                                                                                                                  |
| `--comment` \<string>           | Explanatory comment. Provides context for the mute action.                                                                                                                                                                                         |
| `--container` \<container-ids>… | Limit muting to the specified container. Applies only to container-specific alerts; if the alert is not container-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--hostname` \<strings>…        | Limit muting to the specified server. Applies only to server-specific alerts; if the alert is not server-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated.          |
| `--process` \<process-ids>…     | Limit muting to the specified process. Applies only to process-specific alerts; if the alert is not process-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated.       |

### weka alerts mute add

Add processes, containers, or hostnames to an existing muted alert type.

```sh
weka alerts mute add <alert-type> [--container <container-ids>…] [--hostname <strings>…] [--process <process-ids>…]
```

| Parameter                       | Description                                                                                                                                                                                                                                        |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alert-type`\*                  | Alert type to modify. Use 'weka alerts types' to list available types.                                                                                                                                                                             |
| `--container` \<container-ids>… | Mute alerts for the specified container. Applies only to container-specific alerts; if the alert is not container-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--hostname` \<strings>…        | Mute alerts for the specified server. Applies only to server-specific alerts; if the alert is not server-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated.          |
| `--process` \<process-ids>…     | Mute alerts for the specified process. Applies only to process-specific alerts; if the alert is not process-specific, all alerts of this type are muted. Multiple values may be supplied separated by commas, or the option may be repeated.       |

### weka alerts mute list

List active mute rules for alerts.

```sh
weka alerts mute list
```

**Columns:** `alert_type`, `tenant`, `description`, `mute_time_remaining`, `mute_reason`

### weka alerts mute remove

Remove processes, containers, or hostnames from an existing muted alert type.

```sh
weka alerts mute remove <alert-type> [--container <container-ids>…] [--hostname <strings>…] [--process <process-ids>…]
```

| Parameter                       | Description                                                                                                                                                                                                                                                  |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `alert-type`\*                  | Alert type to modify. Use 'weka alerts types' to list available types.                                                                                                                                                                                       |
| `--container` \<container-ids>… | Remove mute filter for the specified container. Applies only to container-specific alerts; if the alert is not container-specific, all alerts of this type are affected. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--hostname` \<strings>…        | Remove mute filter for the specified server. Applies only to server-specific alerts; if the alert is not server-specific, all alerts of this type are affected. Multiple values may be supplied separated by commas, or the option may be repeated.          |
| `--process` \<process-ids>…     | Remove mute filter for the specified process. Applies only to process-specific alerts; if the alert is not process-specific, all alerts of this type are affected. Multiple values may be supplied separated by commas, or the option may be repeated.       |

## weka alerts types

List all alert types that can be returned from the Weka cluster.

```sh
weka alerts types
```

**Columns:** `type`

## weka alerts unmute

Unmute an alert type that was previously muted.

```sh
weka alerts unmute <alert-type>
```

| Parameter      | Description                                                            |
| -------------- | ---------------------------------------------------------------------- |
| `alert-type`\* | Alert type to unmute. Use 'weka alerts types' to list available types. |
