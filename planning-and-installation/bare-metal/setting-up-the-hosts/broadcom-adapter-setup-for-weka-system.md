---
hidden: true
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/planning-and-installation/bare-metal/setting-up-the-hosts/broadcom-adapter-setup-for-weka-system
---

# Broadcom adapter setup for WEKA system

Before a WEKA system can use a Broadcom adapters, the server must have the necessary drivers and firmware from Broadcom's download center.

## **Set up the drivers and software**

**Procedure:**

1. **Prerequisites:** Enable SR-IOV in both the BIOS and the NIC settings. See [sr-iov-enablement.md](sr-iov-enablement.md "mention").
2. **Download software bundle**: Access Broadcom's download center and download the software bundle onto the target server. Carefully review the instructions included in the bundle.
3. **Compile and install**: Follow the provided instructions to compile and install the following components:
   * `bnxt_en` driver.
   * `sliff` driver.
   * `niccli` command line utility.
4. **Post-installation steps**: After installation, run one of the following commands based on the Linux distribution:
   * `dracut -f`
   * `update-initramfs -u`
5. **Reboot the server**: Reboot the server to apply the changes.

## **Install the firmware**

After installing Broadcom drivers and software, install the firmware included in the download bundle. Firmware files are typically named after the adapter they are intended for, such as `BCM957508-P2100G.pkg`.

**Procedure:**

1. **Identify the target adapter**: Use the command `niccli --list` to list Broadcom adapters and identify the target adapter by its decimal device number:

```shell
# niccli --list
----------------------------------------------------------------------------
Scrutiny NIC CLI v227.0.130.0 - Broadcom Inc. (c) 2023 (Bld-61.52.25.90.16.0) 
----------------------------------------------------------------------------
     BoardId     MAC Address        FwVersion    PCIAddr      Type   Mode
  1) BCM57508    84:16:0A:3E:0E:20  224.1.102.0  00:0d:00:00  NIC    PCI
  2) BCM57508    84:16:0A:3E:0E:21  224.1.102.0  00:0d:00:01  NIC    PCI
```

2. **Identify the device**: From the `niccli --list` output, choose the device identifier (for example, `1` for `BCM57508`).

```
# niccli --dev 1 install BCM957508-P2100G.pkg
```

3. **Confirm and complete the installation**: Follow the prompts to confirm and complete the firmware update.

{% code overflow="wrap" %}
```shell
Broadcom NetXtreme-C/E/S firmware update and configuration utility version v227.0.120.0
NetXtreme-E Controller #1 at PCI Domain:0000 Bus:3b Dev:00 Firmware on NVM - v224.1.102.0
NetXtreme-E Controller #1 will be updated to firmware version v227.1.111.0

Do you want to continue (Y/N)?y

NetXtreme-C/E/S Controller #1 is being updated....................................................
Firmware update is completed.
A system reboot is needed for the firmware update to take effect.
```
{% endcode %}

4. **Reboot the server**: Reboot the server to apply the firmware update.

## **Update NVM settings**

To enable WEKA system compatibility, configure certain NVM options to increase the number of Virtual Functions (VFs) and enable TruFlow.

**Procedure:**

1.  **Increase the number of VFs to 64**: Run the following commands:

    ```shell
    niccli --dev 1 nvm --setoption enable_sriov --value 1
    niccli --dev 1 nvm --setoption number_of_vfs_per_pf --scope 0 --value 0x40
    niccli --dev 1 nvm --setoption number_of_vfs_per_pf --scope 1 --value 0x40
    ```
2.  **Enable TruFlow**: Run the following commands:

    ```shell
    niccli --dev 1 nvm --setoption enable_truflow --scope 0 --value 1
    niccli --dev 1 nvm --setoption enable_truflow --scope 1 --value 1
    ```
3.  **Additional configuration for BCM57508-P2100G**: Run the following command:

    ```shell
    niccli --dev 1 nvm --setoption afm_rm_resc_strategy --value 1
    ```
4. **Reboot the server**: Reboot the server to apply the changes.

The adapter is ready for use by the WEKA system.

## Configure Broadcom P2100G adapters for 200 Gbps operation

Convert a dual-port 100 Gbps Broadcom P2100G adapter into a single-port 200 Gbps configuration by consolidating both ports. This mode is optimal for high-throughput applications requiring maximum bandwidth on a single interface.

#### Procedure

1.  **Determine NIC index:** Run the following command to list all installed NICs and determine the correct index (`<index>`) of the target P2100G adapter:

    ```
    niccli list
    ```
2.  **Set link speed and port:** Use the Linux `niccli` tools to set the default link speed to 200G for both the driver (when the OS is running) and the firmware (PXE boot), and hide the second network port with the following commands:

    ```
    niccli -i <index> nvm --setoption firmware_link_speed_d0 --scope 0 --value 0x07
    niccli -i <index> nvm --setoption port_operation_mode --value 
    ```
