---
description: View the hardware components of a server and their health, from the server itself or from any server in the cluster.
---

# View the hardware inventory

View the inventory of any server from anywhere in the cluster, or of the local server from the server itself.

#### Procedure

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

**Related topics**

[README.md](README.md "mention")

[forget-a-removed-component.md](forget-a-removed-component.md "mention")
