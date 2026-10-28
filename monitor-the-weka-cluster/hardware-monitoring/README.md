---
description: Monitor the health of server hardware components, such as drives, memory modules, power supplies, and network adapters, and get alerts when a component fails or disappears.
---

# Hardware monitoring

The cluster reads the health of each server's hardware components from the server's baseboard management controller (BMC). It keeps an inventory of the components, raises an alert when a component reports a problem or is no longer detected, and records an event when a component changes state or is replaced.

**INTERNAL, remove before publication. TBD (Ehud):** Which servers are supported: WekaPod 3 only, or any server with a Redfish BMC? The code resolves any BMC and handles AMI, Supermicro, and Dell iDRAC.

## Monitored components

The inventory covers the components the BMC reports:

* Drives
* Memory modules
* Processors
* Network adapters, including the link state and speed of each port
* Power supplies
* Fans
* Chassis and drive bays

**INTERNAL, remove before publication. TBD (Ehud):** Confirm the component list and the type names the CLI shows, for example `drive` and `power_supply`.

## How monitoring works

1. The hardware monitor runs in the SSD proxy container of each server and reads the BMC over Redfish every 3 minutes.
2. On the first read, the monitor records the components present as the expected hardware of the server.
3. On each later read, the monitor compares the components with the expected hardware:
   * A component that reports a warning or critical health status raises an alert.
   * A component that is missing from two consecutive reads is reported as not detected, 3 to 6 minutes after it was removed.
   * A component in the same slot with a new serial number is recorded as replaced.
4. One container per server publishes the inventory to the cluster.

**INTERNAL, remove before publication. TBD (Ehud):** Is the 3-minute interval worth stating to customers?

## Component states

| State | Description |
| --- | --- |
| `ok` | The component reports no problem. |
| `warning` | The BMC reports a warning for the component. |
| `critical` | The BMC reports a critical health status for the component. |
| `offline` | The BMC reports the component as offline. |
| `disabled` | The BMC reports the component as disabled. |
| `missing` | The component was expected but is no longer reported. |

**INTERNAL, remove before publication. TBD (Ehud):** `identity-lost` appears as a reason, not a state. Document it?

## Alerts and events

| Alert | Raised when |
| --- | --- |
| HardwareComponentCritical | A component reports a critical health status. |
| HardwareComponentDegraded | A component reports a warning health status. |
| HardwareComponentNotDetected | A component that was present is no longer reported. |
| HardwareMonitoringUnavailable | The hardware monitor cannot read data from the BMC. |

On servers that report a component inventory, these alerts replace the HardwareComponentWarning and HardwareComponentFaulty alerts.

Events: HardwareComponentStateWorsened, HardwareComponentStateImproved, HardwareComponentReplaced, HardwareInventoryRelabeled, HardwareInventoryComponentForgotten, and HardwareInventoryReset.

## Monitoring in dark sites

The CLI commands and the alerts work without an internet connection. To receive the alerts outside the cluster, deploy Local WEKA Home and create an integration: Email (SMTP), PagerDuty, SNMP trap, or Syslog.

**INTERNAL, remove before publication. TBD (Ehud):** Does Local WEKA Home show the hardware inventory, or only receive the alerts?

## Hardware monitoring in NeuralMesh Observe

**INTERNAL, remove before publication. TBD (Ehud):** Inventory view and alerts view, with screenshots from a 6.1 cluster on physical servers connected to Cloud WEKA Home.

**Related topics**

[manage-hardware-monitoring.md](manage-hardware-monitoring.md "mention")

[list-of-alerts-and-corrective-actions.md](../../operation-guide/alerts/list-of-alerts-and-corrective-actions.md "mention")

[manage-alerts-and-integrations.md](../the-wekaio-support-cloud/manage-alerts-and-integrations.md "mention")
