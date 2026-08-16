---
description: View alert types and alerts, then mute or unmute them using the CLI.
---

# Manage alerts using the CLI

## **Display alert types**

**Command:** `weka alerts types`

Use this command to list all possible types of alerts that the WEKA cluster can return.

<details>

<summary>Example</summary>

```bash
$ weka alerts types
AdminDefaultPassword
AgentNotRunning
ApproachingClientsUnavailability
ApproachingSystemLimit
AutoRemoveTimeoutTooLow
AvailableMemory
BackendNumaBalancingEnabled
BackendVersionsMismatch
BadDisksCapacityRatio
BlockedJrpcMethod
BondInterfaceCompromised
BucketCapacityExhausting
BucketHasNoQuorum
BucketUnresponsive
CPUFrequentStarvation
CPUStarvation
CWTaskAbortionStuck
ChokingDetected
ClientVersionsMismatch
ClockSkew
CloudHealth
CloudStatsError
ClusterInitializationError
ClusterIsUpgrading
ConfigOverridesActive
CoreOverlapping
DataIntegrity
DataProtection
DedicatedWatchdog
DrainingStuck
DriveCriticalWarnings
DriveDown
DriveEndurancePercentageUsed
DriveEnduranceSparesRemaining
DriveNVKVRunningLow
DriveNeedsPhaseout
ExceptionsDuringAlertsEvaluation
FaultsEnabled
FilesystemKMSError
FilesystemsThinProvisioningLowSpace
FilesystemsThinProvisioningReserveReached
HangingCacheSync
HangingClusterTasks
HangingIos
HighDrivesCapacity
HighLevelOfUnreclaimedCapacityInObjectStore
HighSSDToRAMRatio
HotspotInodes
IBNotEnhanced
ImbalancedCpuUsage
JumboConnectivity
KMSError
LeaderPreparedForUpgrade
LegacyManualOverridesActive
LicenseError
LocalTLSCertificateExpired
LocalTLSCertificateExpiringSoon
LocalTLSConnectivityToNeighbors
LongestWaitInodes
LowDiskSpace
ManualOverridesActive
ManualOverridesForced
MismatchedDriveFailureDomain
MismatchedJoinSecrets
NegativeUnprovisionedCapacity
NetworkFailedToStartPorts
NetworkInterfaceLinkDown
NfsLocksDisabled
NfsServiceDownAlert
NoCgroupsConfigured
NoClusterLicense
NoHotSpareFailureDomains
NodeBlacklisted
NodeDisconnected
NodeNetworkUnstable
NodeRDMANotActive
NodeTieringConnectivity
NonTlsApisAllowed
NotEnoughActiveDrives
NotEnoughMemoryForFilesystemOperation
NotEnoughSSDCapacity
NotificationQueueHighLoad
NotificationSendFailure
PartialConnectivityTrackingDisabled
PartialHugepageAllocation
PartiallyConnectedNode
PassedClientsAvailabilityThreshold
PathsDegraded
PerformanceDegradedLowRAM
QuotasHardLimitReached
QuotasSoftLimitReached
RAIDCapacityExhaustion
RequestedActionFailure
RequestedActionTimeout
ResourcesNotApplied
SSDCapacityDiscrepancy
SSDCapacityTooHigh
SystemDefinedTLS
TLSCertificateExpired
TLSCertificateExpiresSoon
TelemetryStatusFault
TieredFilesystemOverfillingSSD
TooManyPendingClusterwideJobs
TraceDumperDown
TracesDisabled
TracesFreezePeriodActive
UdpModePerformanceWarning
UnstableHosts
UnwritableDisksConfigured
WTracerDaemonWriteIOFailures
WTracerLostTraces
```

</details>

**Command:**`weka alerts describe`

Use this command to describe all the alert types the WEKA cluster can return, along with possible corrective actions for each alert.

## **View alerts**

**Command:** `weka alerts`

Use the following command line to list all alerts (muted and unmuted) in the WEKA cluster:

`weka alerts [--severity severity] [--muted] [--inactive]`

**Parameters**

| Name       | Value                                                                                                                                                                             |
| ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `severity` | List alerts with the specified severity level and higher. Default: `warning`. Supported values: `debug` (hidden), '`warning`' (lowest), `minor`, `major` or `critical` (highest). |
| `muted`    | List muted alerts in addition to active alerts.                                                                                                                                   |
| `inactive` | List alerts that recently transitioned to an inactive state.                                                                                                                      |

#### `weka alerts` output parameters

Explore the output parameters of the `weka alerts` command.

| Parameter             | Description                                                                                                       |
| --------------------- | ----------------------------------------------------------------------------------------------------------------- |
| `action`              | Displays the recommended action to resolve the alert.                                                             |
| `active_duration`     | Indicates the duration for which the alert has been active.                                                       |
| `comment`             | Shows any user-added comments for the alert.                                                                      |
| `count`               | Provides the number of times the alert has occurred.                                                              |
| `description`         | Explains the alert in detail.                                                                                     |
| `end_time`            | Specifies the time when the alert was resolved.                                                                   |
| `mute_time_remaining` | Indicates the remaining time until the alert is unmuted.                                                          |
| `muted`               | Shows whether the alert is currently muted (`muted` or `unmuted`).                                                |
| `severity`            | Defines the severity level of the alert, for example, `WARNING`.                                                  |
| `start_time`          | Specifies the start time when an alert type first started, not when each individual alert instance was generated. |
| `title`               | Provides a concise title for the alert.                                                                           |
| `type`                | Identifies the unique type of the alert.                                                                          |

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

### Add items to mute scope

**Command:** `weka alerts mute add`

Use the following command line to add more items to the mute scope for an already muted alert-type. You can add more process/container/hostname items to the existing scope. Duration and comment remain unchanged.

```
weka alerts mute add <alert-type> /
[--process process]... /
[--container container]... /
[--hostname hostname]...
```

**Parameters**

| Parameter      | Description                                                                                                                                                                        |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alert-type`\* | Specifies the alert type to update mute scope for. Run `weka alerts types` to list all possible types.                                                                             |
| `process`...   | Adds specific process IDs to the mute scope. This parameter applies only to process-specific alerts. For multiple entries, provide a comma-separated list or repeat the parameter. |
| `container`... | Adds specific container IDs to the mute scope. Use this parameter for container-specific alerts only.For multiple entries, provide a comma-separated list or repeat the parameter. |
| `hostname`...  | Adds specific server names to the mute scope. Use this parameter for server-specific alerts only. For multiple entries, provide a comma-separated list or repeat the parameter.    |

### Remove items from mute scope

**Command:** `weka alerts mute remove`

Remove specific items from the mute scope of an already muted alert-type. You can remove specific\
process, container, or hostname items from the existing scope. If all items are removed, the alert is completely unmuted.

```
weka alerts mute remove <alert-type> /
[--process process]... /
[--container container]... /
[--hostname hostname]...
```

**Parameters**

| Parameter      | Description                                                                                                                                                                             |
| -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `alert-type`\* | Specifies the alert type to remove from mute scope. Run `weka alerts types` to list all possible types.                                                                                 |
| `process`...   | Removes specific process IDs from the mute scope. This parameter applies only to process-specific alerts. For multiple entries, provide a comma-separated list or repeat the parameter. |
| `container`... | Removes specific container IDs from the mute scope. Use this parameter for container-specific alerts only. Provide a comma-separated list or repeat the parameter for multiple IDs.     |
| `hostname`...  | Removes specific server names from the mute scope. Use this parameter for server-specific alerts only. Provide a comma-separated list or repeat the parameter for multiple names.       |

## **Unmute alerts**

**Command:** `weka alerts unmute`

Use the following command line to unmute a muted Alert Type:

`weka alerts unmute <alert-type>`

**Parameters**

| Name           | Value                                                           |
| -------------- | --------------------------------------------------------------- |
| `alert-type`\* | An alert-type to unmute, use `weka alerts types` to list types. |
