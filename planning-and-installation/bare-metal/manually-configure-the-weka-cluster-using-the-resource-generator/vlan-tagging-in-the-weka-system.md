---
description: >-
  WEKA tenant clusters use VLAN tagging to enable isolated network communication
  between clusters and their clients.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/planning-and-installation/bare-metal/manually-configure-the-weka-cluster-using-the-resource-generator/vlan-tagging-in-the-weka-system
---

# VLAN tagging in the WEKA system

## Overview

WEKA support for IEEE 802.1Q VLAN encapsulation ("tagged VLAN IDs" or "tagged VLANs") enables isolation and segregation of network traffic while still granting connectivity between WEKA clients and backend servers.

A WEKA tenant cluster operates on a single VLAN ID, where all containers within that cluster must use the same VLAN ID. All clients connecting to a tenant cluster must use that cluster's assigned VLAN ID. When using the WEKA Kubernetes Operator, this VLAN ID consistency between the tenant cluster and its clients is automatically maintained.

In multi-cluster environments, each tenant cluster can operate on a different VLAN ID. For example, you can assign VLAN ID 100 to Tenant Cluster A and VLAN ID 200 to Tenant Cluster B, providing network isolation between clusters.

## **Enable WEKA tagged VLAN support**

To enable WEKA tagged VLAN support, add the desired VLAN IDs to the switch ports connected to WEKA backends. It is common to include one untagged VLAN and multiple tagged VLAN IDs.

After configuring the switch, update the Linux system interfaces to recognize the VLAN IDs and verify connectivity.

Use the following procedure on each WEKA backend and each WEKA stateful client. You do not need to perform this procedure on WEKA stateless clients because it is automatically applied during the mount command.

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

## Confirm which tagged VLAN is attached to the interfaces

To determine which tagged VLANs are configured, query the local resources of a container using a command like this:

```
weka local resources -C <containername>
```

Example:

```bash
weka local resources -C drives0
```

You can also display the cluster container network data with this command by requesting verbose output with `-v` to list the VLAN ID or by using syntax like `-o id,hostname,name,ips,vlan`:

```
weka cluster container net -v
```

## Mount filesystems with tagged VLANs

When running a mount command on a WEKA stateless client where the backends have a tagged VLAN, specify the same VLAN in the mount command as follows:

### **Basic VLAN tagging**

Mount a filesystem with a specified NIC and VLAN tag:

```bash
mount -o net=<nic>/vlan@<tag> <backendip/filesystem> <mountpoint>
```

Example:

```bash
mount -o net=mlnx0/vlan@501 10.10.0.10/default /mnt/weka
```

### **Extended network configuration**

Include gateway, IP, and netmask (in CIDR format) for advanced configurations:

{% code overflow="wrap" %}
```bash
mount -o net=<nic>/vlan@<tag>/gw@<gateway>/ip@<ip>/netmask@<netmask> <backendip/filesystem> <mountpoint>
```
{% endcode %}

Example:

{% code overflow="wrap" %}
```bash
mount -o net=mlnx0/vlan@501/gw@192.168.1.1/ip@192.168.1.10/netmask@22 10.10.0.10/default /mnt/weka
```
{% endcode %}

**Syntax guidelines:**

* Include additional named parameters (for example, `gw@`, `ip@`, `netmask@`) directly in the command syntax.
* Alternatively, use the legacy style by specifying name-value pairs after the positional parameters.
* Separate all parameters using `/`.

This syntax is also supported for the `weka local setup container --net ...` command.
