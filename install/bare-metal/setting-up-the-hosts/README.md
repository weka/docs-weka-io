---
description: >-
  This page describes the procedures required to system for the Weka software
  installation.
---

# Prepare the system for Weka installation

Once the hardware and software prerequisites are met, prepare the backend hosts and client machines for the installation of the Weka system.

This preparation consists of the following steps:

1. [Install NIC drivers](./#install-nic-drivers).
2. [Enable SR-IOV](./#enable-sr-iov) (when required).
3. [Configure the networking](./#undefined).
4. [Verify the network configuration](./#verify-the-network-configuration).
5. [Configure the clock synchronization](./#configure-the-clock-synchronization).
6. [Disable the Numa balancing](./#disable-the-numa-balancing).
7. [Validate the system preparation](./#validate-the-system-preparation).

{% hint style="info" %}
**Note:** Some of the examples on this page contain version-specific information. The software is updated frequently, and therefore the package versions available to you may differ from those presented here.
{% endhint %}

**Related topics**

[prerequisites-and-compatibility.md](../../../support/prerequisites-and-compatibility.md "mention")

## Install NIC drivers <a href="#install-nic-drivers" id="install-nic-drivers"></a>

{% hint style="info" %}
**Note:** The steps describing the installation of NIC drivers are provided as a courtesy. Refer to your NIC vendor documentation for the latest information and updates.
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

The Mellanox OFED installation involves decompressing the distribution archive (which should be obtained from the Mellanox website) and running the installation script. Refer to the following to begin the installation:

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

## Enable SR-IOV <a href="#enable-sr-iov" id="enable-sr-iov"></a>

SR-IOV enablement is mandatory for hosts equipped with Intel NICs or when working with client VMs where there is a need to expose VFs of a physical NIC to the virtual NICs.

{% hint style="info" %}
SR-IOV enablement is optional for hosts with Mellanox NICs (CX-4 or newer).
{% endhint %}

**Related topic**

[sr-iov-enablement.md](sr-iov-enablement.md "mention")

## Configure the networking <a href="#configure-the-networking" id="configure-the-networking"></a>

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

Two `ifcfg` scripts must be created for each pkey-ed IPoIB interface. To determine your own pkey-ed IPoIB interface configuration, refer to the following two examples where a `pkey` of `0x8002` is used:

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

## Verify the network configuration <a href="#verify-the-network-configuration" id="verify-the-network-configuration"></a>

Use a large-size ICMP ping to check the basic TCP/IP connectivity between the interfaces of the hosts:

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

## Configure the HA networking <a href="#configure-the-ha-networking" id="configure-the-ha-networking"></a>

As described in [Weka Networking HA](../../../overview/networking-in-wekaio.md#ha) section, bonded interfaces are supported for ethernet can be added to Weka after setting the bonded device in the host.

When there is a need to configure Dual Network (IB or ETH) without LACP, each NIC must have its own IP address and you will need to properly configure the routing of the interfaces involved.

{% tabs %}
{% tab title="Infiniband" %}
**Example using CentOS:**

Add the following lines at the end of `/etc/sysctl.conf`:

```
net.ipv4.conf.ib0.arp_announce =2
net.ipv4.conf.ib1.arp_announce =2
net.ipv4.conf.ib0.arp_filter =1
net.ipv4.conf.ib1.arp_filter =1
```

This can be added per interface, as described above, or to all interfaces:

```
net.ipv4.conf.all.arp_filter = 1 
net.ipv4.conf.default.arp_filter = 1 
net.ipv4.conf.all.arp_announce = 2 
net.ipv4.conf.default.arp_announce = 2
```

**Routing tables**

Append the following to `/etc/iproute2/rt_tables`:

```
100 weka1
101 weka2
```

Assuming the interfaces are `mlnx0` and `mlnx1` and assuming that the network is 10.90.0.0/16 with IPs 10.90.0.1 and 10.90.1.1 and a default gw of 10.90.2.1, set the following routing rules:

**/etc/sysconfig/network-scripts/route-mlnx0**

```
10.90.0.0/16 dev mlnx0 src 10.90.0.1 table weka1
default via 10.90.2.1 dev mlnx0 table weka1
```

**/etc/sysconfig/network-scripts/route-mlnx1**

```
10.90.0.0/16 dev mlnx1 src 10.90.1.1 table weka2
default via 10.90.2.1 dev mlnx1 table weka2
```

**/etc/sysconfig/network-scripts/rule-mlnx0**

```
table weka1 from 10.90.0.1
```

**/etc/sysconfig/network-scripts/rule-mlnx1**

```
table weka2 from 10.90.1.1
```
{% endtab %}

{% tab title="Ethernet" %}
Refer to this [link](https://access.redhat.com/solutions/30564) to learn how to configure dual Ethernet network in RHEL
{% endtab %}
{% endtabs %}

## Configure the clock synchronization <a href="#configure-sync" id="configure-sync"></a>

The synchronization of time on computers and networks is considered good practice and is vitally important for the stability of the Weka system. Proper timestamp alignment in packets and logs is very helpful for the efficient and quick resolution of issues.

Configure the clock synchronization software on the backend and client machines according to the specific vendor instructions (see your OS documentation), prior to installing the Weka software.

## **Disable the NUMA balancing** <a href="#disable-the-numa-balancing" id="disable-the-numa-balancing"></a>

The Weka system manages the NUMA balancing by itself and makes the best possible decisions. Therefore, we recommend disabling the NUMA balancing feature of the Linux kernel to avoid additional latencies in the operations.

To disable NUMA balancing, run the following command on the host:

```
echo 0 > /proc/sys/kernel/numa_balancing
```

## Validate the system preparation <a href="#validate-the-system-preparation" id="validate-the-system-preparation"></a>

The `wekachecker` is a tool that validates the readiness of the hosts in the cluster before installing the Weka software.

The `wekachecker` performs the following validations:

* Dataplane IP, jumbo frames, and routing
* ssh connection to all hosts
* Timesync
* OS release
* Sufficient capacity in /opt/weka
* Available RAM
* Internet connection availability
* NTP
* DNS configuration
* Firewall rules
* Weka required packages
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
**Note:** The `wekachecker`tool applies to all Weka versions. From V4.0, the following validations are not relevant, although the tool displays them:

* OS has SELinux disabled or in permissive mode.
* Network Manager is disabled.
{% endhint %}

**Procedure**

1. Download the Wekachecker tarball from [https://github.com/weka/tools/blob/master/install/wekachecker](https://github.com/weka/tools/blob/master/install/wekachecker) and extract it.
2. From the install directory, run `./wekachecker <hostnames/IPs>`\
   Where:\
   The `hostnames/IPs` is a space-separated list of all the cluster hostnames or IP addresses connected to the **high-speed networking**.\
   Example:\
   `./wekachecker 10.1.1.11 10.1.1.12 10.1.1.4 10.1.1.5 10.1.1.6 10.1.1.7 10.1.1.8`
3. Review the output. If failures or warnings are reported, investigate them and correct them as necessary. Repeat the validation until no important issues are reported.\
   The `wekachecker` writes any failures or warnings to the file: **`test_results.txt`**.

Once the report has no failures or warnings that must be fixed, you can install the Weka software.

**wekachecker report example**

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
Check for Weka Required Packages...                          [PASS]
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
