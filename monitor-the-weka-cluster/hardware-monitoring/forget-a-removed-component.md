---
description: Stop the cluster from reporting a hardware component that was removed on purpose.
---

# Forget a removed component

After you remove a component on purpose, for example a power supply or a drive, the cluster reports it as not detected. Forget the component to stop the alert.

#### Before you begin

* Root access on the server.
* The component's type and label, from `weka local hardware list`.

#### Procedure

1. On the server, run:

   ```bash
   weka local hardware forget <type> <label>
   ```

   * `<type>`: the component type as the list command shows it, for example `drive` or `power_supply`.
   * `<label>`: the component label, for example `PSU2`. For a component with no label, use its serial number or component ID.

A component that is still present is learned again on the next read.

**Related topics**

[view-the-hardware-inventory.md](view-the-hardware-inventory.md "mention")

[reset-the-expected-hardware.md](reset-the-expected-hardware.md "mention")
