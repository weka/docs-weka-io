---
description: >-
  Learn the hardware and software requirements for using Broadcom network
  adapters with the WEKA system.
hidden: true
---

# Broadcom NIC requirements for WEKA system

{% hint style="info" %}
This guidance applies to environments using Broadcom adapters. Adapter setup procedures may change. Always refer to Broadcom’s official documentation for current tools and firmware packages.
{% endhint %}

## Hardware requirements

The following table lists the hardware requirements for Broadcom adapters.

<table><thead><tr><th width="192.89453125">Component</th><th>Requirement</th></tr></thead><tbody><tr><td>Broadcom adapter</td><td>Confirm compatibility with WEKA-supported models. See <a data-mention href="../../prerequisites-and-compatibility.md#networking-ethernet">#networking-ethernet</a>.</td></tr><tr><td>Virtual Function count</td><td>The adapter must support a sufficient number of VFs to match the WEKA core count per server.</td></tr><tr><td>SR-IOV enabled</td><td><p>The system BIOS and NIC BIOS must support and enable SR-IOV.</p><p>See<a data-mention href="sr-iov-enablement.md">sr-iov-enablement.md</a>.</p></td></tr><tr><td>IOMMU disabled</td><td><p>WEKA backend servers and clients with Broadcom NICs do not support IOMMU. You must disable IOMMU before installing the cluster.</p><p>To disable IOMMU, update the kernel boot parameters to include <code>intel_iommu=off</code> or <code>amd_iommu=off</code>, depending on the CPU type.</p></td></tr></tbody></table>

## Software prerequisites

The following table lists the software prerequisites for Broadcom adapters.

<table><thead><tr><th width="236.921875">Component</th><th>Requirement</th></tr></thead><tbody><tr><td>OS</td><td>WEKA-supported Linux distribution.</td></tr><tr><td>Kernel Version</td><td>Compatible with <code>bnxt_en</code> driver version included in the OS.</td></tr><tr><td>NIC driver</td><td>Use the in-kernel <code>bnxt_en</code> driver. Avoid using legacy versions.</td></tr><tr><td>Management utility</td><td>Use the latest available version of the Broadcom <code>niccli</code> . Avoid using legacy versions.</td></tr></tbody></table>

## Broadcom NIC setup

Follow this procedure to set up your Broadcom NICs for use with the WEKA system.

**Procedure**

1. **Install the firmware:** Install the latest qualified firmware for your specific Broadcom NIC model. You can obtain the firmware from the official Broadcom downloads portal: [Broadcom Driver and Firmware Downloads](https://www.broadcom.com/support/download-search).
2.  **Configure the VFs on the NIC:** The number of Virtual Functions (VFs) configured on the NIC must be at least equal to the number of IO process cores on the server.

    The standard recommendation is to configure 64 VFs, which is sufficient for most deployments with 64 or fewer IO cores. To reduce the creation of unnecessary network interfaces, you can optionally configure the exact number of VFs to match your IO core count.

    Use the `niccli` utility to set the number of VFs. The following example configures the standard 64 VFs per physical function (PF).

    ```bash
    # Enable SR-IOV
    niccli -dev <ID> nvm setoption -name enable_sriov -value 1

    # Set 64 VFs for the first physical function (scope 0)
    niccli -dev <ID> nvm setoption -name number_of_vfs_per_pf -scope 0 -value 0x40
        
    # Set 64 VFs for the second physical function (scope 1)
    niccli -dev <ID> nvm setoption -name number_of_vfs_per_pf -scope 1 -value 0x40
    ```

    Replace `<ID>` with the appropriate device identifier. The `-value` `0x40` is the hexadecimal representation of 64. If a server has more than 64 IO cores, you must adjust this value to match the core count.
3.  **Enable TruFlow and offload features:** Run the following commands to ensure that TruFlow and other performance offload features are enabled on the NIC:

    ```
    niccli -dev <ID> nvmsetoption -name enable_truflow -scope 0 -value 1
    niccli -dev <ID> nvmsetoption -name enable_truflow -scope 1 -value 1
    ```

### After installing the WEKA software

Configure the WEKA software to use the VFs. After installing the WEKA software, configure it to recognize and use the VFs you created on the NIC. You can do this during the WEKA container setup using one of the following methods:

*   **Method 1:** Using the `weka local setup` command When setting up the WEKA container, use the `--net` flag with the `vfs@<num_vfs>` syntax. The `<num_vfs>` value must match the number of VFs you configured on the NIC.

    Example: `weka local setup container --net vfs@40 ...`
*   **Method 2:** Using the resources file For automated or large-scale deployments, update the `vfs_to_create` field in the `resources.yaml` file. Set the value of this field to the number of VFs configured on the NIC.

    Example: `vfs_to_create: 40`
