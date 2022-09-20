---
description: This page describes the procedure required in order to set up SR-IOV.
---

# SR-IOV enablement

## Overview

Many hardware vendors ship their products with the SR-IOV feature disabled. On such platforms, the feature must be enabled prior to installing the Weka system. This enablement applies to both the server BIOS and the NIC. If already enabled, it is recommended to verify the current state before proceeding with the installation of the Weka system.

This section assumes that NIC drivers have been installed and loaded successfully. If this is not the case, complete the procedure described in NIC Driver Installation and then continue as described below.

## SR-IOV enablement in the server BIOS

Refer to the screenshots below to enable the SR-IOV support in the server BIOS.

{% hint style="info" %}
**Note:** The following screenshots are vendor-specific and provided as a courtesy. Depending on the vendor, the same settings may appear differently or be located in other places. Therefore, always refer to your hardware platform and NIC vendor documentation for the latest information and updates.
{% endhint %}

![Reboot Server and Force it to Enter the BIOS Setup](<../../../.gitbook/assets/image (26).png>)

![Locate the PCIe Configuration and Drill Down](<../../../.gitbook/assets/image (4).png>)

![Locate SR-IOV Support and Drill Down](<../../../.gitbook/assets/image (21).png>)

![Enable SR-IOV Support](<../../../.gitbook/assets/image (5).png>)

![Save and Exit](../../../.gitbook/assets/image.png)

## SR-IOV enablement in the **Mellanox** NICs

While it is possible to change the SR-IOV configuration through the NIC BIOS, Mellanox OFED offers command line tools that allow for the convenient modification and validation of SR-IOV settings, as described below:

**Step 1**: Run Mellanox Software Tools (mst).

```
# mst start
```

**Step 2**: Identify the device node for PCIe configuration access to the connected NIC device to be used with the Weka system.

```
# ibdev2netdev
mlx5_0 port 1 ==> enp24s0 (Up)
mlx5_1 port 1 ==> ib0 (Down)
mlx5_2 port 1 ==> ib1 (Down)
mlx5_3 port 1 ==> ib2 (Down)
mlx5_4 port 1 ==> ib3 (Down)
```

Using the output received from the above, ascertain the following:

* The host is equipped with 5 Mellanox ports.
* Only one of the ports (the one marked Up) has connectivity to the switch.
* The connected port name is enp24s0. The Mellanox notation of the NIC is mlx5\_0.

**Step 3**: Using the Mellanox device notation, find the device node that can be used for PCIe configuration access of the NIC.

```
# mst status -v | grep mlx5_0
ConnectX4(rev:0) /dev/mst/mt4115_pciconf0  18:00.0   mlx5_0  net-enp24s0               0
```

**Step 4**: Using the PCIe access device node, check the current SR-IOV setting on the NIC.

```
# mlxconfig -d /dev/mst/mt4115_pciconf0 q | grep -e SRIOV_EN -e VFS
         NUM_OF_VFS                          0
         SRIOV_EN                            False(0)
```

**Step 5**: Modify the SR-IOV settings. In the following example, the SR-IOV is enabled and the number of Virtual Functions (VFs) is set to 16.

```
# mlxconfig -y -d /dev/mst/mt4115_pciconf0 set SRIOV_EN=1 NUM_OF_VFS=16
```

**Step 6**: Reboot the host.

**Step 7:** On completion of the server reboot, validate the SR-IOV settings.

```
# mst start && mlxconfig -d /dev/mst/mt4115_pciconf0 q | grep -e SRIOV_EN -e VFS
Starting MST (Mellanox Software Tools) driver set
Loading MST PCI module - Success
Loading MST PCI configuration module - Success
Create devices
-W- Missing "lsusb" command, skipping MTUSB devices detection
Unloading MST PCI module (unused) - Success
         NUM_OF_VFS                          16
         SRIOV_EN                            True(1)
```

This concludes the SR-IOV enablement procedure.
