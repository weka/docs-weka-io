---
description: >-
  With tagged VLANs, WEKA clusters can participate in secure, scalable, and
  isolated communication between clients and backend servers.
---

# VLAN tagging in the WEKA system

## Overview

WEKA support for IEEE 802.1Q VLAN encapsulation ("tagged VLAN IDs" or "tagged VLANs") enables isolation and segregation of network traffic while still granting connectivity between WEKA clients and backend servers.

Each WEKA cluster is limited to one VLAN, as each container can be assigned one VLAN per NIC. This provides granular control over network configurations while maintaining compatibility with existing workflows.

When paired with the WEKA Kubernetes Operator for backends, each tenant cluster and tenant client shares the same VLAN.

Tagged VLAN ID support is also extended to WEKA clients.

## **Enable WEKA tagged VLAN support**

To enable WEKA tagged VLAN support, add the desired VLAN IDs to the switch ports connected to WEKA backends. It is common to include one untagged VLAN and multiple tagged VLAN IDs.

After configuring the switch, update the Linux system interfaces to recognize the VLAN IDs and verify connectivity.

**Procedure**

1.  **Assign a VLAN tag to a network interface**\
    Associate a VLAN tag with a NIC using the following command:

    ```sql
    weka local resources net add <nic> --vlan <tag>  
    ```

    Example:

    ```sql
    weka local resources net add mlnx0 --vlan 501  
    ```
2.  **Add a VLAN interface**\
    Infer the VLAN tag by adding a VLAN interface:

    ```sql
    weka local resources net add vlan<tag>  
    ```

    Example:

    ```sql
    weka local resources net add vlan501  
    ```
3. **Apply configuration changes**\
   Restart all containers to apply the VLAN configuration updates.

## Mount filesystems with tagged VLANs

**Basic VLAN tagging**

Mount a filesystem with a specified NIC and VLAN tag:

```bash
mount -o net=<nic>/vlan@<tag> <mountpoint>
```

Example:

```bash
mount -o net=mlnx0/vlan@501 /mnt/weka
```

**Extended network configuration**

Include gateway, IP, and netmask for advanced configurations:

```bash
mount -o net=<nic>/vlan@<tag>/gw=<gateway>/ip=<ip>/netmask=<netmask> <mountpoint>
```

Example:

{% code overflow="wrap" %}
```bash
mount -o net=mlnx0/vlan@501/gw=192.168.1.1/ip=192.168.1.10/netmask=255.255.255.0 /mnt/weka
```
{% endcode %}

**Syntax guidelines:**

* Include additional named parameters (for example, `gw=`, `ip=`, `netmask=`) directly in the command syntax.
* Alternatively, use the legacy style by specifying name-value pairs after the positional parameters.
* Separate all parameters using `/`.

This syntax is also supported for the `weka local setup container --net ...` command.
