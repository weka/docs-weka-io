---
description: Turn on hardware monitoring for a server so the cluster reads component health from the server's BMC.
---

# Enable hardware monitoring

Hardware monitoring reads component health from the server's BMC.

**INTERNAL, remove before publication. TBD (Ehud):** Is monitoring on by default on WekaPod 3, so this task applies only to other servers?

#### Before you begin

* The server has a BMC with Redfish enabled.
* The BMC address and credentials, unless the monitor finds the BMC on its own. The monitor finds it through the `redfish-localhost` DNS alias, the fixed address of a WekaPod 2.6 unit, or the BMC IP address that `ipmitool` reports.
* Root access on the server.

**INTERNAL, remove before publication. TBD (Ehud):** Minimum BMC firmware or Redfish version?

#### Procedure

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

**Related topics**

[README.md](README.md "mention")

[view-the-hardware-inventory.md](view-the-hardware-inventory.md "mention")
