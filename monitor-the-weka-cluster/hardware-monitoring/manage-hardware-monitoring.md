---
description: Enable hardware monitoring, view the hardware inventory of a server, and update the expected hardware after a planned change.
---

# Manage hardware monitoring

## Enable hardware monitoring

Hardware monitoring reads component health from the server's BMC.

**INTERNAL, remove before publication. TBD (Ehud):** Is monitoring on by default on WekaPod 3, so this task applies only to other servers?

**Before you begin**

* The server has a BMC with Redfish enabled.
* The BMC address and credentials, unless the monitor finds the BMC on its own. The monitor finds it through the `redfish-localhost` DNS alias, the fixed address of a WekaPod 2.6 unit, or the BMC IP address that `ipmitool` reports.
* Root access on the server.

**INTERNAL, remove before publication. TBD (Ehud):** Minimum BMC firmware or Redfish version?

**Procedure**

1. On the server, turn on hardware monitoring:

   ```bash
   weka local resources hardware-monitor --enable --bmc-url <url> --bmc-username <user> --bmc-password <password>
   ```

   * Omit the BMC parameters when the monitor finds the BMC on its own.

   **INTERNAL, remove before publication. TBD (Ehud):** Which container to target with `--container`, and whether a restart or `weka local resources apply` is needed.
2. Verify that the inventory lists the server's components:

   ```bash
   weka local hardware list
   ```

## View the hardware inventory

View the inventory of any server from anywhere in the cluster, or of the local server from the server itself.

**Procedure**

1. Do one of the following:
   * To view the hardware components of any server in the cluster, run:

     ```bash
     weka cluster server show <server> --show-hardware
     ```

     `<server>`: the server's hostname, an IP address of one of its containers, the ID of one of its containers, or its machine UID.
   * To view the hardware components of the local server, including healthy ones, run as root:

     ```bash
     weka local hardware list
     ```

     Add `-v` to show the last-seen time, component ID, PCI address, MAC address, and port link state.

**INTERNAL, remove before publication. TBD (Ehud):** Output samples, reconstructed from the CLI renderer or taken from a WekaPod 3 cluster.

## Forget a removed component

After you remove a component on purpose, for example a power supply or a drive, the cluster reports it as not detected. Forget the component to stop the alert.

**Before you begin**

* Root access on the server.
* The component's type and label, from `weka local hardware list`.

**Procedure**

1. On the server, run:

   ```bash
   weka local hardware forget <type> <label>
   ```

   * `<type>`: the component type as the list command shows it, for example `drive` or `power_supply`.
   * `<label>`: the component label, for example `PSU2`. For a component with no label, use its serial number or component ID.

A component that is still present is learned again on the next read.

## Reset the expected hardware

Reset the expected hardware after a planned change to many components of a server. The monitor learns the components present at the time of the reset as the new expected hardware.

{% hint style="warning" %}
After the reset, a component that is missing at the time of the reset is no longer reported as missing.
{% endhint %}

**INTERNAL, remove before publication. TBD (Ehud):** When should a customer reset instead of forgetting a component? A motherboard or sled swap?

**Before you begin**

* Root access on the server.
* All components that must be monitored are installed and listed by `weka local hardware list`.

**Procedure**

1. On the server, run:

   ```bash
   weka local hardware rebaseline
   ```
2. Confirm the prompt.

**Related topics**

[README.md](README.md "mention")

[list-of-alerts-and-corrective-actions.md](../../operation-guide/alerts/list-of-alerts-and-corrective-actions.md "mention")
