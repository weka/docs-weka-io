---
description: Discard the expected hardware of a server and learn the components present now, for example after a planned hardware change.
---

# Reset the expected hardware

Reset the expected hardware after a planned change to many components of a server. The monitor learns the components present at the time of the reset as the new expected hardware.

{% hint style="warning" %}
After the reset, a component that is missing at the time of the reset is no longer reported as missing.
{% endhint %}

**INTERNAL, remove before publication. TBD (Ehud):** When should a customer reset instead of forgetting a component? A motherboard or sled swap?

#### Before you begin

* Root access on the server.
* All components that must be monitored are installed and listed by `weka local hardware list`.

#### Procedure

1. On the server, run:

   ```bash
   weka local hardware rebaseline
   ```
2. Confirm the prompt.

**Related topics**

[forget-a-removed-component.md](forget-a-removed-component.md "mention")

[README.md](README.md "mention")
