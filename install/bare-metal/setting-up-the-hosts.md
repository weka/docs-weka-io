---
description: >-
  This page describes the procedures required to set up backend and client
  machines for the first time.
---

# Setting Up the Hosts

## Preparations

After meeting the hardware and software requirements, it is necessary to prepare the backend and client machines for installation of the WekaIO system. This preparation of the hosts consists of the following steps:

1. NIC driver installation.
2. SR-IOV enablement.
3. Network configuration.
4. Network configuration verification.
5. Clock synchronization.

{% hint style="info" %}
**Note:** Some of the examples in this page contain version-specific information. Since software is updated frequently, the package versions available to you may differ to those presented here.
{% endhint %}

## NIC Driver Installation

{% hint style="info" %}
**Note:** The steps describing the installation of NIC drivers are provided as a courtesy. Refer to your NIC vendor documentation for the latest information and updates.
{% endhint %}

### Mellanox OFED Installation

This section describes an OFED installation procedure that has proven to be successful. However, Mellanox supports a number of other installation methods, any of which can be used to install OFED. For more information about other installation procedures, refer to the Mellanox documentation.

#### Meeting Mellanox OFED Prerequisites

The Mellanox OFED installation has a number of dependencies. The following example shows the installation of OFED dependencies in RHEL/CentOS 7.x using yum's \[base\] and \[update\] repositories, which are supported and preconfigured in RHEL and CentOS.

```text
yum install perl libnl lsof tcl libxml2-python tk
```

This example assumes that the server was provisioned using the "Minimal installation" option and that it has access to yum repositories, either locally or over the Internet. This method can trigger updates to existing packages already installed on the server.

Alternatively, it is possible to install OFED dependencies without triggering updates to already-installed packages, as shown in the following example:

```text
yum --disablerepo=* --enablerepo=base install perl libnl lsof tcl libxml2-python tk
```

Once the dependencies have been satisfied, it is possible to perform the OFED installation procedure.

#### Mellanox OFED Installation

The Mellanox OFED installation involves decompressing the distribution archive \(which should be obtained from the Mellanox website\) and running the installation script. Refer to the following to begin the installation:

```text
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

```text
# /etc/init.d/openibd restart
```

This concludes the Mellanox OFED installation procedure.

## SR-IOV Enablement

SR-IOV enablement is mandatory for backend machines equipped with Intel NICs. However, it is not required for backend machines with Mellanox NICs \(CX-4 or newer\).

Many hardware vendors ship their products with the SR-IOV feature disabled. On such platforms, the feature must be enabled prior to installing the WekaIO system. This enablement applies to both the server BIOS and the NIC. If already enabled, it is recommend to verify the current state before proceeding with the installation of the WekaIO system.

This section assumes that NIC drivers have been installed and loaded successfully. If this is not the case, complete the procedure described in NIC Driver Installation and then continue as described below.

### SR-IOV Enablement in the Server BIOS

Refer to the screenshots below to enable the SR-IOV support in the server BIOS.

{% hint style="info" %}
**Note:** The following screenshots are vendor-specific and provided as a courtesy. Depending on the vendor, the same settings may appear differently or be located in other places. Therefore, always refer to your hardware platform and NIC vendor documentation for the latest information and updates.
{% endhint %}

![Reboot Server and Force it to Enter the BIOS Setup](../../.gitbook/assets/image%20%2810%29.png)

![Locate the PCIe Configuration and Drill Down](../../.gitbook/assets/image%20%2811%29.png)

![Locate SR-IOV Support and Drill Down](../../.gitbook/assets/image%20%286%29.png)

![Enable SR-IOV Support](../../.gitbook/assets/image%20%2821%29.png)

![Save and Exit](../../.gitbook/assets/image%20%289%29.png)

### SR-IOV Enablement in the **Mellanox** NICs

While it is possible to change the SR-IOV configuration through the NIC BIOS, Mellanox OFED offers command line tools that allow for the convenient modification and validation of SR-IOV settings, as described below: 

**Step 1**: Run Mellanox Software Tools \(mst\).

```text
# mst start
```

**Step 2**: Identify the device node for PCIe configuration access to the connected NIC device to be used with the WekaIO system.

```text
# ibdev2netdev
mlx5_0 port 1 ==> enp24s0 (Up)
mlx5_1 port 1 ==> ib0 (Down)
mlx5_2 port 1 ==> ib1 (Down)
mlx5_3 port 1 ==> ib2 (Down)
mlx5_4 port 1 ==> ib3 (Down)
```

Using the output received from the above, ascertain the following:

* The host is equipped with 5 Mellanox ports.
* Only one of the ports \(the one marked Up\) has connectivity to the switch.
* The connected port name is enp24s0. The Mellanox notation of the NIC is mlx5\_0.

**Step 3**: Using the Mellanox device notation, find the device node that can be used for PCIe configuration access of the NIC.

```text
# mst status -v | grep mlx5_0
ConnectX4(rev:0) /dev/mst/mt4115_pciconf0  18:00.0   mlx5_0  net-enp24s0               0
```

**Step 4**: Using the PCIe access device node, check the current SR-IOV setting on the NIC.

```text
# mlxconfig -d /dev/mst/mt4115_pciconf0 q | grep -e SRIOV_EN -e VFS
         NUM_OF_VFS                          0
         SRIOV_EN                            False(0)
```

**Step 5**: Modify the SR-IOV settings. In the following example, the SR-IOV is enabled and the number of Virtual Functions \(VFs\) is set to 16.

```text
# mlxconfig -y -d /dev/mst/mt4115_pciconf0 set SRIOV_EN=1 NUM_OF_VFS=16
```

**Step 6**: Reboot the host. 

**Step 7:** On completion of the server reboot, validate the SR-IOV settings.

```text
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

## Network Configuration

### NetworkManager Disablement

NetworkManager is a dynamic network control and configuration daemon. It is the default network management tool in some operating systems such as RHEL 6 and 7. 

The WekaIO system requires network management to be handled by Network Initscripts \(also known as "ifcfg configuration files"\). This method is a basic network interface start/stop framework that is part of the initscripts package, and is the method that the WekaIO system currently supports in Red Hat and it derivatives. 

The following commands can be used to permanently disable NetworkManager:

To stop NetworkManager:

`systemctl stop NetworkManager`

To disable NetworkManager:

`systemctl disable NetworkManager`

To validate NetworkManager is disabled

```text
# systemctl is-enabled NetworkManager
disabled
```

### Ethernet Configuration

The following example of ifcfg script is provided a reference for configuring the Ethernet interface.

{% code-tabs %}
{% code-tabs-item title="/etc/sysconfig/network-scripts/ifcfg-enp24s0" %}
```text
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
{% endcode-tabs-item %}
{% endcode-tabs %}

MTU 9000 \(jumbo frame\) is recommended for best performance. Refer to your switch vendor documentation for jumbo frame configuration.

Bring the interface up using the following command:

```text
# ifup enp24s0
```

### InfiniBand Configuration

#### Default Partition

InfiniBand network configuration normally includes Subnet Manager \(SM\), but the procedure involved is beyond the scope of this document. However, it is important to be aware of the specifics of your SM configuration, such as partitioning and MTU, because they can affect the configuration of the endpoint ports in Linux. For best performance, MTU of 4092 is recommended.

Refer to the following ifcfg script when the IB network only has the default partition, i.e., "no pkey":

{% code-tabs %}
{% code-tabs-item title="/etc/sysconfig/network-scripts/ifcfg-ib1" %}
```text
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
{% endcode-tabs-item %}
{% endcode-tabs %}

Bring the interface up using the following command:

```text
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

#### Non-default Partition \(PKEY\)

On an InfiniBand network with a non-default partition number, _p-key_ must be configured on the interface if the InfiniBand ports on your network are members of an InfiniBand partition other than the default \(`0x7FFF`\). The p-key should associate the port as a full member of the partition \(full members are those where the p-key number with the most-significant bit \(MSB\) of the 16-bits is set to 1\). 

{% hint style="success" %}
**For Example:** If the partition number is `0x2`, the limited member p-key will equal the p-key itself, i.e.,`0x2`. The full member p-key will be calculated as the logical AND of `0x8000` and the p-key \(`0x2`\) and therefore will be equal to `0x8002`. 
{% endhint %}

{% hint style="info" %}
**Note:** All InfiniBand ports communicating with the WekaIO cluster must be full members.
{% endhint %}

Two ifcfg scripts must be created for each pkey-ed IPoIB interface. To determine your own pkey-ed IPoIB interface configuration, refer to the following two examples where a pkey of `0x8002` is used:

{% code-tabs %}
{% code-tabs-item title="/etc/sysconfig/network-scripts/ifcfg-ib1" %}
```text
TYPE=Infiniband
ONBOOT=yes
MTU=4092
BOOTPROTO=static
STARTMODE=auto
USERCTL=no
NM_CONTROLLED=no
DEVICE=ib1
```
{% endcode-tabs-item %}
{% endcode-tabs %}

{% code-tabs %}
{% code-tabs-item title="/etc/sysconfig/network-scripts/ifcfg-ib1.8002" %}
```text
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
{% endcode-tabs-item %}
{% endcode-tabs %}

Bring the interface up using the following command:

```text
# ifup ib1.8002
```

Verify the connection is up with all the non-default partition attributes set:

```text
# ip a s ib1.8002
5: ib1.8002@ib0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4092 qdisc mq state UP qlen 256
    link/infiniband 00:00:11:03:fe:80:00:00:00:00:00:00:24:8a:07:03:00:a8:09:48 brd 00:ff:ff:ff:ff:12:40:1b:80:02:00:00:00:00:00:00:ff:ff:ff:ff
    inet 192.168.1.1/16 brd 192.168.255.255 scope global noprefixroute ib1.8002
       valid_lft forever preferred_lft forever
```

## Network Configuration Verification

Use a large size ICMP ping to check the basic TCP/IP connectivity between the interfaces of the hosts:

```text
# ping -M do -s 8972 -c 3 192.168.1.2
PING 192.168.1.2 (192.168.1.2) 8972(9000) bytes of data.
8980 bytes from 192.168.1.2: icmp_seq=1 ttl=64 time=0.063 ms
8980 bytes from 192.168.1.2: icmp_seq=2 ttl=64 time=0.087 ms
8980 bytes from 192.168.1.2: icmp_seq=3 ttl=64 time=0.075 ms

--- 192.168.2.0 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1999ms
rtt min/avg/max/mdev = 0.063/0.075/0.087/0.009 ms
```

The`-M do` flag prohibits packet fragmentation, which allows verification of correct MTU configuration between the two end points.

`-s 8972` is the maximum ICMP packet size that can be transferred with MTU 9000, due to the overhead of ICMP and IP protocols.

## Clock Synchronization

The synchronization of time on computers and networks is considered good practice and is vitally important for the stability of the WekaIO system. Proper timestamp alignment in packets and logs is very helpful for the efficient and quick resolution of issues. 

Configure the time synchronization software on the backend and client machines according to the specific vendor instructions \(see your OS documentation\), prior to installing the WekaIO software.

