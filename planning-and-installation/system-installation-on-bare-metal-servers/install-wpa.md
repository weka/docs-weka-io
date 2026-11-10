---
description: Install the WEKA Platform Appliance (WPA) on each bare metal server.
---

# Install WPA

WPA is an operating system image based on Ubuntu 24.04 Server Minimal.&#x20;

The WPA `iso` does not need internet access during the installation – all included packages are set to their latest versions as of the WPA release date, and the Linux kernel package is pinned to the latest major+minor release line that is known to work with WEKA.

See the `cloud-init` config file on each WPA release page in [get.weka.io](https://get.weka.io) for further details about the included packages and system settings.&#x20;

The WPA release cycle is designed to prioritize a secure installation experience. So new WPA images are released regularly and independently of the WEKA software release cycle. As such, WEKA software is intentionally not included in the WPA `iso`.&#x20;

Please download and install your WEKA software release from [get.weka.io](https://get.weka.io) after the WPA installation has completed.<br>

**Before you begin**

* Make sure each server meets the following requirements:
  * **Boot type:** UEFI.
  * **Boot drive:** At least one drive of 64 GiB or larger. WPA ignores smaller drives. When WPA finds two installation drives of the same size, it installs the operating system on the first drive and uses the second drive for `/opt/weka`. WPA does not mirror the two drives.
* Download the WPA ISO image. See [Obtain the installation packages](obtain-the-installation-packages.md).
* When you download WPA from [get.weka.io](https://get.weka.io), record the server sign-in credentials under **OS login**.
* Make sure you can boot each server from the ISO image, through the server's BMC virtual media or from USB media.

{% hint style="warning" %}
WPA selects the slowest drive or pair of drives for the bootable operating system partition and the `/opt/weka` partition.&#x20;

WPA installs the operating system on the first match from the following list of devices: a Dell BOSS device, a hardware RAID virtual disk, a SATA/M.2 drive or matching pair of dives, the smallest NVMe drive or smallest matching pair of NVMe drives.

Before you install, back up or disconnect any drive that holds data you need.
{% endhint %}

**Procedure**

1. **Install WPA:** Boot the server from the WPA ISO image. Use one of the following methods:
   * **BMC virtual media:** Copy the WPA ISO image to a location that the server's BMC can mount as a virtual DVD, such as a workstation connected to the BMC web interface, an SMB share, or an NFS share. For mounting and booting from the image, see the documentation for the server's BMC (for example, iLO, iDRAC, or IPMI).
   * **USB media:** Write the WPA ISO image to a USB drive, and boot the server from it.
2.  **Wait for the installation to complete:** The boot menu starts the automatic installation after 30 seconds. The installer partitions the drives, installs and configures the operating system, installs the required packages, and reboots the server.

    To follow the installation on a server without a monitor, open the BMC serial-over-LAN console (115200 baud).
3. **Sign in to the server console:** The login credentials are provided on the WPA download page on [get.weka.io](https://get.weka.io). \
   The WPA sets the host name to `weka-` followed by the last segment of the server's DMI serial number. \
   The WPA enables DHCP on the management interface but makes no further assumptions about the installation network — so each NIC will need to be configured for each server.
4. Verify the installed WPA version:

```bash
cat /etc/wpa-release
```

The `PRETTY_NAME` field shows the WPA version, for example `WPA-1.2.1`.

Repeat the procedure on each server.

## What to do next?

Go to [Install the WEKA software](install-the-weka-software/).
