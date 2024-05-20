---
description: >-
  If the system is not prepared using the WMS, perform this procedure to set the
  networking and other tasks before configuring the WEKA cluster.
---

# Manually prepare the system for WEKA configuration

Once the hardware and software prerequisites are met, prepare the backend servers and clients for the WEKA system configuration.

This preparation consists of the following steps:

1. [Install NIC drivers](./#install-nic-drivers)
2. [Enable SR-IOV](./#enable-sr-iov) (when required)
3. [Configure the networking](./#configure-the-networking)
4. [Verify the network configuration](./#verify-the-network-configuration)
5. [Configure the HA networking](./#configure-the-ha-networking)
6. [Configure the clock synchronization](./#configure-sync)
7. [Disable the NUMA balancing](./#disable-the-numa-balancing)
8. [Disable swap (if any)](./#id-8.-disable-swap-if-any)
9. [Validate the system preparation](./#id-9.-validate-the-system-preparation)

{% hint style="info" %}
Some of the examples contain version-specific information. The software is updated frequently, so the package versions available to you may differ from those presented here.
{% endhint %}

**Related topics**

[prerequisites-and-compatibility.md](../../prerequisites-and-compatibility.md "mention")

## 1. Install NIC drivers <a href="#install-nic-drivers" id="install-nic-drivers"></a>

{% hint style="info" %}
The steps describing the installation of NIC drivers are provided as a courtesy. Refer to your NIC vendor documentation for the latest information and updates.
{% endhint %}

### Mellanox OFED installation

This section describes an OFED installation procedure that has proven to be successful. However, Mellanox supports a number of other installation methods, any of which can be used to install OFED. For more information about other installation procedures, refer to the Mellanox documentation.

#### Meeting Mellanox OFED prerequisites

The Mellanox OFED installation has a number of dependencies. The following example shows the installation of OFED dependencies in RHEL/CentOS 7.x using yum's \[base] and \[update] repositories, which are supported and preconfigured in RHEL and CentOS.

```
yum install perl libnl lsof tcl libxml2-python tk
```

This example assumes that the server was provisioned using the "Minimal installation" option and that it has access to yum repositories, either locally or over the Internet. This method can trigger updates to existing packages already installed on the server.

Alternatively, it is possible to install OFED dependencies without triggering updates to already-installed packages, as shown in the following example:

```
yum --disablerepo=* --enablerepo=base install perl libnl lsof tcl libxml2-python tk
```

Once the dependencies have been satisfied, it is possible to perform the OFED installation procedure.

#### Mellanox OFED installation

The Mellanox OFED installation involves decompressing the distribution archive, which you obtain from the Mellanox website, and running the installation script. Refer to the following to begin the installation:

```
# tar xf MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6-x86_64.tgz
# ls -lF
drwxr-xr-x   6 root root       4096 Nov 28  2018 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6-x86_64/
-rw-r--r--   1 root root  239624023 Dec  2  2018 MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.5-x86_64.tgz

# cd MLNX_OFED_LINUX-4.5-1.0.1.0-rhel7.6-x86_64/

# ./mlnxofedinstall
/tmp/MLNX_OFED_LINUX.414403.logs
General log file: /tmp/MLNX_OFED_LINUX.414403.logs/general.log
Verifying KMP rpms compatibility with target kernel...
This program will install the MLNX_OFED_LINUX package on your machine.
Note that all other Mellanox, OEM, OFED, RDMA or Distribution IB packages will be removed.
Those packages are removed due to conflicts with MLNX_OFED_LINUX, do not reinstall them.

Do you want to continue?[y/N]:y
```

On completion of the OFED installation, the NIC firmware may be updated to match the firmware requirements of the Mellanox OFED software. If an update was performed, reboot the server at the end of the installation for the new firmware to become effective. Otherwise, restart the driver by running the following:

```
# /etc/init.d/openibd restart
```

This concludes the Mellanox OFED installation procedure.

## 2. Enable SR-IOV <a href="#enable-sr-iov" id="enable-sr-iov"></a>

Single Root I/O Virtualization (SR-IOV) enablement is mandatory in the following cases:

* The servers are equipped with Intel NICs.&#x20;
* When working with client VMs, the virtual functions (VFs) of a physical NIC must be exposed to the virtual NICs.

**Related topic**

[sr-iov-enablement.md](sr-iov-enablement.md "mention")

## 3. Configure the networking <a href="#configure-the-networking" id="configure-the-networking"></a>

### Ethernet configuration

The following example of `ifcfg` script is provided as a reference for configuring the Ethernet interface.

{% code title="/etc/sysconfig/network-scripts/ifcfg-enp24s0" %}
```
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="none"
DEFROUTE="no"
IPV4_FAILURE_FATAL="no"
IPV6INIT="no"
IPV6_AUTOCONF="no"
IPV6_DEFROUTE="no"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="enp24s0"
DEVICE="enp24s0"
ONBOOT="yes"
NM_CONTROLLED=no
IPADDR=192.168.1.1
NETMASK=255.255.0.0
MTU=9000
```
{% endcode %}

MTU 9000 (jumbo frame) is recommended for the best performance. Refer to your switch vendor documentation for jumbo frame configuration.

Bring the interface up using the following command:

```
# ifup enp24s0
```

### InfiniBand configuration

{% tabs %}
{% tab title="Default partition" %}
InfiniBand network configuration normally includes Subnet Manager (SM), but the procedure involved is beyond the scope of this document. However, it is important to be aware of the specifics of your SM configuration, such as partitioning and MTU, because they can affect the configuration of the endpoint ports in Linux. For best performance, MTU of 4092 is recommended.

Refer to the following `ifcfg` script when the IB network only has the default partition, i.e., "no `pkey`":

{% code title="/etc/sysconfig/network-scripts/ifcfg-ib1" %}
```
TYPE=Infiniband
ONBOOT=yes
BOOTPROTO=static
STARTMODE=auto
USERCTL=no
NM_CONTROLLED=no
DEVICE=ib1
IPADDR=192.168.1.1
NETMASK=255.255.0.0
MTU=4092
```
{% endcode %}

Bring the interface up using the following command:

```
# ifup ib1
```

Verify that the “default partition” connection is up, with all the attributes set:

```
# ip a s ib1
4: ib1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4092 qdisc mq state UP group default qlen 256
  link/infiniband 00:00:03:72:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a8:09:48
brd 00:ff:ff:ff:ff:12:40:1b:ff:ff:00:00:00:00:00:00:ff:ff:ff:ff
    inet 10.0.20.84/24 brd 10.0.20.255 scope global noprefixroute ib0
       valid_lft forever preferred_lft forever
```
{% endtab %}

{% tab title="Non-default partition (PKEY)" %}
On an InfiniBand network with a non-default partition number, `p-key` must be configured on the interface if the InfiniBand ports on your network are members of an InfiniBand partition other than the default (`0x7FFF`). The p-key should associate the port as a full member of the partition (full members are those where the p-key number with the most-significant bit (MSB) of the 16-bits is set to 1).

{% hint style="success" %}
**Example:** If the partition number is `0x2`, the limited member p-key will equal the p-key itself, i.e.,`0x2`. The full member p-key will be calculated as the logical OR of `0x8000` and the p-key (`0x2`) and therefore will be equal to `0x8002`.
{% endhint %}

{% hint style="info" %}
**Note:** All InfiniBand ports communicating with the Weka cluster must be full members.
{% endhint %}

For each `pkey-ed IPoIB` interface, it's necessary to create two `ifcfg` scripts. To configure your own `pkey-ed IPoIB` interface, refer to the following examples, where a `pkey` of `0x8002` is used. You may need to manually create the child device.

{% code title="/etc/sysconfig/network-scripts/ifcfg-ib1" %}
```
TYPE=Infiniband
ONBOOT=yes
MTU=4092
BOOTPROTO=static
STARTMODE=auto
USERCTL=no
NM_CONTROLLED=no
DEVICE=ib1
```
{% endcode %}

{% code title="/etc/sysconfig/network-scripts/ifcfg-ib1.8002" %}
```
TYPE=Infiniband
BOOTPROTO=none
CONNECTED_MODE=yes
DEVICE=ib1.8002
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
MTU=4092
NAME=ib1.8002
NM_CONTROLLED=no
ONBOOT=yes
PHYSDEV=ib1
PKEY_ID=2
PKEY=yes
BROADCAST=192.168.255.255
NETMASK=255.255.0.0
IPADDR=192.168.1.1
```
{% endcode %}

Bring the interface up using the following command:

```
# ifup ib1.8002
```

Verify the connection is up with all the non-default partition attributes set:

```
# ip a s ib1.8002
5: ib1.8002@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4092 qdisc mq state UP qlen 256
    link/infiniband 00:00:11:03:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a8:09:48 brd 00:ff:ff:ff:ff:12:40:1b:80:02:00:00:00:00:00:00:ff:ff:ff:ff
    inet 192.168.1.1/16 brd 192.168.255.255 scope global noprefixroute ib1.8002
       valid_lft forever preferred_lft forever
```
{% endtab %}
{% endtabs %}

### Define the NICs with `ignore-carrier`

`ignore-carrier` is a NetworkManager configuration option. When set, it keeps the network interface up even if the physical link is down. It’s useful when services need to bind to the interface address at boot.

{% hint style="info" %}
The following is an example of how to configure `ignore-carrier` on systems that use NetworkManager on Rocky Linux 8. The exact steps may vary depending on your operating system and its specific network configuration tools. Always refer to your system’s official documentation for accurate information.
{% endhint %}

1. Open the  `/etc/NetworkManager/NetworkManager.conf` file to edit it.
2. Under the `[main]` section, add the line `ignore-carrier=<device-name1>,<device-name2>`. \
   Replace `<device-name1>,<device-name2>` with the actual device names you want to apply this setting to.

Example:

{% code title="/etc/NetworkManager/NetworkManager.conf" %}
```
[main]
ignore-carrier=ib0,ib1
```
{% endcode %}

3. Restart the NetworkManager service for the changes to take effect.

## 4. Verify the network configuration <a href="#verify-the-network-configuration" id="verify-the-network-configuration"></a>

Use a large-size ICMP ping to check the basic TCP/IP connectivity between the interfaces of the servers:

```
# ping -M do -s 8972 -c 3 192.168.1.2
PING 192.168.1.2 (192.168.1.2) 8972(9000) bytes of data.
8980 bytes from 192.168.1.2: icmp_seq=1 ttl=64 time=0.063 ms
8980 bytes from 192.168.1.2: icmp_seq=2 ttl=64 time=0.087 ms
8980 bytes from 192.168.1.2: icmp_seq=3 ttl=64 time=0.075 ms

--- 192.168.2.0 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 0.063/0.075/0.087/0.009 ms
```

The`-M do` flag prohibits packet fragmentation, which allows verification of correct MTU configuration between the two endpoints.

`-s 8972` is the maximum ICMP packet size that can be transferred with MTU 9000, due to the overhead of ICMP and IP protocols.

## 5. Configure dual-network links with policy-based routing <a href="#configure-the-ha-networking" id="configure-the-ha-networking"></a>

The following steps provide guidance for configuring dual-network links with policy-based routing on Linux systems. Adjust IP addresses and interface names according to your environment.

#### **General Settings in `/etc/sysctl.conf`**

1. Open the `/etc/sysctl.conf` file using a text editor.
2.  Add the following lines at the end of the file to set minimal configurations per InfiniBand (IB) or Ethernet (Eth) interface:

    ```bash
    # Minimal configuration, set per IB/Eth interface
    net.ipv4.conf.ib0.arp_announce = 2
    net.ipv4.conf.ib1.arp_announce = 2
    net.ipv4.conf.ib0.arp_filter = 1
    net.ipv4.conf.ib1.arp_filter = 1
    net.ipv4.conf.ib0.arp_ignore = 0
    net.ipv4.conf.ib1.arp_ignore = 0

    # As an alternative set for all interfaces by default
    net.ipv4.conf.all.arp_filter = 1
    net.ipv4.conf.default.arp_filter = 1
    net.ipv4.conf.all.arp_announce = 2
    net.ipv4.conf.default.arp_announce = 2
    net.ipv4.conf.all.arp_ignore = 0
    net.ipv4.conf.default.arp_ignore = 0
    ```
3. Save the file.
4.  Apply the new settings by running:

    ```bash
    sysctl -p /etc/sysctl.conf
    ```

#### **RHEL/Rocky/CentOS routing configuration using the Network Scripts**

{% hint style="info" %}
Network scripts are deprecated in RHEL/Rocky 8. For RHEL/Rocky 9, use the Network Manager.
{% endhint %}

5. Navigate to `/etc/sysconfig/network-scripts/`.
6.  Create the file `/etc/sysconfig/network-scripts/route-mlnx0` with the following content:

    ```bash
    10.90.0.0/16 dev mlnx0 src 10.90.0.1 table weka1
    default via 10.90.2.1 dev mlnx0 table weka1
    ```
7.  Create the file `/etc/sysconfig/network-scripts/route-mlnx1` with the following content:

    ```bash
    10.90.0.0/16 dev mlnx1 src 10.90.1.1 table weka2
    default via 10.90.2.1 dev mlnx1 table weka2
    ```
8.  Create the files `/etc/sysconfig/network-scripts/rule-mlnx0` and `/etc/sysconfig/network-scripts/rule-mlnx1` with the following content:

    ```bash
    table weka1 from 10.90.0.1
    table weka2 from 10.90.1.1
    ```
9.  Open `/etc/iproute2/rt_tables` and add the following lines:

    ```bash
    100 weka1
    101 weka2
    ```
10. Save the changes.

#### RHEL/Rocky 9 routing configuration using the Network Manager

* **For Ethernet (ETH):** To set up routing for Ethernet connections, use the following commands:

```bash
nmcli connection modify eth1 ipv4.routes "10.10.10.0/24 table=100" ipv4.routing-rules "priority 101 from 10.10.10.1 table 100"
nmcli connection modify eth2 ipv4.routes "10.10.10.0/24 table=200" ipv4.routing-rules "priority 102 from 10.10.10.101 table 200"
```

The route's first IP address in the provided commands represents the network's subnet to which the NIC is connected. The last address in the routing rules corresponds to the IP address of the NIC being configured, where `eth1` is set to `10.10.10.1`.

* **For InfiniBand (IB):** To configure routing for InfiniBand connections, use the following commands:

```bash
nmcli connection modify ib0 ipv4.route-metric 100
nmcli connection modify ib1 ipv4.route-metric 101

nmcli connection modify ib0 ipv4.routes "10.10.10.0/24 table=100" 
nmcli connection modify ib0 ipv4.routing-rules "priority 101 from 10.10.10.1 table 100"
nmcli connection modify ib1 ipv4.routes "10.10.10.0/24 table=200" 
nmcli connection modify ib1 ipv4.routing-rules "priority 102 from 10.10.10.101 table 200"
```

The route's first IP address in the above commands signifies the network's subnet associated with the respective NIC. The last address in the routing rules corresponds to the IP address of the NIC being configured, where `ib0` is set to `10.10.10.1`.

#### **Ubuntu Netplan configuration**

11. Open the Netplan configuration file `/etc/netplan/01-netcfg.yaml` and adjust it:

    ```yaml
    network:
        version: 2
        renderer: networkd
        ethernets:
            enp2s0:
                dhcp4: true
                nameservers:
                        addresses: [8.8.8.8]
            ib1:
                addresses:
                        [10.222.0.10/24]
                routes:
                        - to: 10.222.0.0/24
                          via: 10.222.0.10
                          table: 100
                routing-policy:
                        - from: 10.222.0.10
                          table: 100
                          priority: 32764
            ib2:
                addresses:
                        [10.222.0.20/24]
                routes:
                        - to: 10.222.0.0/24
                          via: 10.222.0.20
                          table: 101
                routing-policy:
                        - from: 10.222.0.20
                          table: 101
                          priority: 32765
    ```
12. After adjusting the Netplan configuration file, run the following commands:

    ```bash
    ip route add 10.222.0.0/24 via 10.222.0.10 dev ib1 table 100
    ip route add 10.222.0.0/24 via 10.222.0.20 dev ib2 table 101
    ```

**SLES/SUSE Configuration**

13. Create `/etc/sysconfig/network/ifrule-eth2` with:

    ```bash
    ipv4 from 192.168.11.21 table 100
    ```
14. Create `/etc/sysconfig/network/ifrule-eth4` with:

    ```bash
    ipv4 from 192.168.11.31 table 101
    ```
15. Create `/etc/sysconfig/network/scripts/ifup-route.eth2` with:

    ```bash
    ip route add 192.168.11.0/24 dev eth2 src 192.168.11.21 table weka1
    ```
16. Create `/etc/sysconfig/network/scripts/ifup-route.eth4` with:

    ```bash
    ip route add 192.168.11.0/24 dev eth4 src 192.168.11.31 table weka2
    ```
17. Add the weka lines to `/etc/iproute2/rt_tables`:

    ```bash
    100 weka1
    101 weka2
    ```
18. Restart the interfaces or reboot the machine:

    ```bash
    ifdown eth2; ifdown eth4; ifup eth2; ifup eth4
    ```

**Related topic**

[#high-availability-ha](../../../weka-system-overview/networking-in-wekaio.md#high-availability-ha "mention")

## 6. Configure the clock synchronization <a href="#configure-sync" id="configure-sync"></a>

The synchronization of time on computers and networks is considered good practice and is vitally important for the stability of the WEKA system. Proper timestamp alignment in packets and logs is very helpful for the efficient and quick resolution of issues.

Configure the clock synchronization software on the backends and clients according to the specific vendor instructions (see your OS documentation), before installing the WEKA software.

## **7. Disable the NUMA balancing** <a href="#disable-the-numa-balancing" id="disable-the-numa-balancing"></a>

The WEKA system autonomously manages NUMA balancing, making optimal decisions. Therefore, turning off the Linux kernel’s NUMA balancing feature is a **mandatory requirement** to prevent extra latencies in operations. It’s crucial that the disabled NUMA balancing remains consistent and isn’t altered by a server reboot.

To persistently disable NUMA balancing, follow these steps:

1. Open the file located at: `/etc/sysctl.conf`
2. Append the following line: `kernel.numa_balancing=disable`

## 8. Disable swap (if any)

WEKA highly recommends that any servers used as backends have no swap configured. This is distribution-dependent but is often a case of commenting out any `swap` entries in `/etc/fstab` and rebooting.

## 9. Validate the system preparation

The `wekachecker` is a tool that validates the readiness of the servers in the cluster before installing the WEKA software.

The `wekachecker` performs the following validations:

* Dataplane IP, jumbo frames, and routing
* ssh connection to all servers
* Timesync
* OS release
* Sufficient capacity in /opt/weka
* Available RAM
* Internet connection availability
* NTP
* DNS configuration
* Firewall rules
* WEKA required packages
* OFED required packages
* Recommended packages
* HT/AMT is disabled
* The kernel is supported
* CPU has a supported AES, and it is enabled
* Numa balancing is enabled
* RAM state
* XFS FS type installed
* Mellanox OFED is installed
* IOMMU mode for SSD drives is disabled
* rpcbind utility is enabled
* SquashFS is enabled
* noexec mount option on /tmp

{% hint style="info" %}
The `wekachecker`tool applies to all WEKA versions. From V4.0, the following validations are not relevant, although the tool displays them:

* OS has SELinux disabled or in permissive mode.
* Network Manager is disabled.
{% endhint %}

**Procedure**

1. Download the **wekachecker** tarball from [https://github.com/weka/tools/blob/master/install/wekachecker](https://github.com/weka/tools/blob/master/install/wekachecker) and extract it.
2. From the install directory, run `./wekachecker <hostnames/IPs>`\
   Where:\
   The `hostnames/IPs` is a space-separated list of all the cluster hostnames or IP addresses connected to the **high-speed networking**.\
   Example:\
   `./wekachecker 10.1.1.11 10.1.1.12 10.1.1.4 10.1.1.5 10.1.1.6 10.1.1.7 10.1.1.8`
3. Review the output. If failures or warnings are reported, investigate them and correct them as necessary. Repeat the validation until no important issues are reported.\
   The `wekachecker` writes any failures or warnings to the file: **`test_results.txt`**.

Once the report has no failures or warnings that must be fixed, you can install the WEKA software.

<details>

<summary><strong>wekachecker report example</strong></summary>

```
Dataplane IP Jumbo Frames/Routing test                       [PASS]
Check ssh to all hosts                                       [PASS]
Verify timesync                                              [PASS]
Check if OS has SELinux disabled or in permissive mode       [PASS]
Check OS Release...                                          [PASS]
Check /opt/weka for sufficient capacity...                   [WARN]
Check available RAM...                                       [PASS]
Check if internet connection available...                    [PASS]
Check for NTP...                                             [PASS]
Check DNS configuration...                                   [PASS]
Check Firewall rules...                                      [PASS]
Check for WEKA Required Packages...                          [PASS]
Check for OFED Required Packages...                          [PASS]
Check for Recommended Packages...                            [WARN]
Check if HT/AMT is disabled                                  [WARN]
Check if kernel is supported...                              [PASS]
Check if CPU has AES enabled and supported                   [PASS]
Check if Network Manager is disabled                         [WARN]
Checking if Numa balancing is enabled                        [WARN]
Checking RAM state for errors                                [PASS]
Check for XFS FS type installed                              [PASS]
Check if Mellanox OFED is installed                          [PASS]
Check for IOMMU disabled                                     [PASS]
Check for rpcbind enabled                                    [PASS]
Check for squashfs enabled                                   [PASS]
Check for /tmp noexec mount                                  [PASS]

RESULTS: 21 Tests Passed, 0 Failed, 5 Warnings
```

</details>

## What to do next?

If you can use the WEKA Configurator, go to:

[configure-the-weka-cluster-using-the-weka-configurator.md](../configure-the-weka-cluster-using-the-weka-configurator.md "mention")

Otherwise, go to:

[manually-configure-the-weka-cluster-using-the-resource-generator.md](../manually-configure-the-weka-cluster-using-the-resource-generator.md "mention")
