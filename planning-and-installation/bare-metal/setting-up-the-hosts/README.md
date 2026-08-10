---
description: Set the networking and other tasks before configuring the WEKA cluster.
---

# Prepare the system

Once the hardware and software prerequisites are met, prepare the backend servers and clients for the WEKA system configuration.

This preparation consists of the following steps:

1. Install NIC drivers
2. Enable SR-IOV (when required)
3. Set up ConnectX cards
4. Set custom kernel parameters
5. Configure the networking
6. Configure the HA networking
7. Verify the network configuration
8. Configure the clock synchronization
9. Enable kdump
10. Disable swap (if any)
11. Validate the system preparation

{% hint style="info" %}
Some of the examples contain version-specific information. The software is updated frequently, so the package versions available to you may differ from those presented here.
{% endhint %}

**Related topics**

[prerequisites-and-compatibility.md](../../prerequisites-and-compatibility.md "mention")

## 1. Install NIC drivers <a href="#install-nic-drivers" id="install-nic-drivers"></a>

For Mellanox OFED setup, see NVIDIA Documentation.

## 2. Enable SR-IOV <a href="#enable-sr-iov" id="enable-sr-iov"></a>

SR-IOV only needs to be enabled if any of the following statements are true:

* If WEKA is running on a VM
* If WEKA data plane is running on Broadcom highspeed NICs

**Related topic**

[sr-iov-enablement.md](sr-iov-enablement.md "mention")

## 3. Set up ConnectX cards <a href="#set-up-connectx-cards" id="set-up-connectx-cards"></a>

1.  **Configure firmware parameters:** All ConnectX ports used directly with WEKA servers and clients require specific firmware settings for optimal performance. Set the following non-default parameters:

    * `ADVANCED_PCI_SETTINGS=1`
    * `PCI_WR_ORDERING=1`

    Use the following command to apply these settings to all MLX devices:

    <pre data-overflow="wrap"><code>mst start &#x26;&#x26; for MLXDEV in /dev/mst/* ; do mlxconfig -d ${MLXDEV} -y set ADVANCED_PCI_SETTINGS=1 PCI_WR_ORDERING=1; done
    </code></pre>
2. **Set link type:** Certain ConnectX VPI cards require modification of the link type, to specifically set the port to use InfiniBand or Ethernet networking.\
   \
   If applicable, set the port mode with the following command, where 1=InfiniBand and 2=Ethernet:\
   `mlxconfig -y -d /dev/mst/<dev> set LINK_TYPE_P<1,2>=<1,2>`\
   \
   For example, the following command sets port 2 to InfiniBand: `mlxconfig -y -d /dev/mst/<dev> set LINK_TYPE_P2=1`<br>
3. **Reboot the system:** A reboot is required after applying the firmware settings to ensure the changes take effect.

**Related information**

For additional details, refer to the NVIDIA ConnectX documentation.

## 4. Set custom kernel parameters <a href="#set-custom-kernel-parameters" id="set-custom-kernel-parameters"></a>

To ensure optimal performance and stability, configure the Linux kernel with custom parameters that:

* Disable NUMA balancing to reduce latency (mandatory).
* Enable automatic reboots after kernel panic to minimize downtime.
* Optimize ARP behavior for improved network performance.

The recommended approach is to consolidate all custom kernel parameters into a single configuration file: `/etc/sysctl.d/99-weka.conf`. This ensures the settings persist across reboots, simplifies administration, and avoids conflicts with package updates.

#### Procedure

1.  **Create the configuration file:** Open a new file under `/etc/sysctl.d/` to store all custom kernel parameters:

    ```bash
    sudo vi /etc/sysctl.d/99-weka.conf
    ```
2.  **Add kernel parameter settings:** Insert the following lines into the file. Comments are included for clarity:

    <pre data-title="/etc/sysctl.d/99-weka.conf"><code># --- Disable NUMA balancing (Mandatory) ---
    kernel.numa_balancing = 0

    # --- Configure automatic reboot on kernel panic ---
    kernel.panic = 300

    # --- Minimal configuration per specific IB/Eth interface ---
    # Replace ib0 and ib1 with your specific interface names
    net.ipv4.conf.ib0.arp_announce = 2
    net.ipv4.conf.ib1.arp_announce = 2
    net.ipv4.conf.ib0.arp_filter = 1
    net.ipv4.conf.ib1.arp_filter = 1
    net.ipv4.conf.ib0.arp_ignore = 1
    net.ipv4.conf.ib1.arp_ignore = 1

    # --- Alternative network ARP settings for all interfaces ---
    net.ipv4.conf.all.arp_filter = 1
    net.ipv4.conf.default.arp_filter = 1
    net.ipv4.conf.all.arp_announce = 2
    net.ipv4.conf.default.arp_announce = 2
    net.ipv4.conf.all.arp_ignore = 1
    net.ipv4.conf.default.arp_ignore = 1
    net.ipv4.conf.all.ignore_routes_with_linkdown = 1
    </code></pre>
3. **Save the file and exit the editor.**
4.  **Apply the new settings:** Reload all kernel parameters from configuration files without rebooting:

    ```bash
    sudo sysctl --system
    ```
5. **Verify configuration changes:**
   1.  Verify NUMA balancing:

       ```bash
       sysctl kernel.numa_balancing
       ```

       Expected output:

       ```bash
       kernel.numa_balancing = 0
       ```
   2.  Verify kernel panic timer:

       ```bash
       sysctl kernel.panic
       ```

       Expected output:

       ```bash
       kernel.panic = 300
       ```

## 5. Configure the networking <a href="#configure-the-networking" id="configure-the-networking"></a>

### Ethernet configuration

The following example of the `ifcfg` script is a reference for configuring the Ethernet interface.

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
The following is an example of configuring `ignore-carrier` on systems that use NetworkManager on Rocky Linux 8. The exact steps may vary depending on your operating system and its specific network configuration tools. Always refer to your system’s official documentation for accurate information.
{% endhint %}

1. Open the `/etc/NetworkManager/NetworkManager.conf` file to edit it.
2. Under the `[main]` section, add one of the following lines depending on the operating system:
   * For some versions of Rocky Linux, RHEL, and CentOS: `ignore-carrier=*`
   * For some other versions: `ignore-carrier=<device-name1>,<device-name2>`.\
     Replace `<device-name1>,<device-name2>` with the actual device names you want to apply this setting to.

Example for RockyLinux and RHEL 8.7:

{% code title="/etc/NetworkManager/NetworkManager.conf" %}
```
[main]
ignore-carrier=*
```
{% endcode %}

Example for some other versions:

```
[main]
ignore-carrier=ib0,ib1
```

3. Restart the NetworkManager service for the changes to take effect.

### RoCE configuration

Configure RoCE (RDMA over Converged Ethernet) when the data plane runs over Ethernet and RDMA traffic must be carried losslessly across it. Skip this section for InfiniBand fabrics.

{% hint style="info" %}
Follow NVIDIA's RoCE configuration procedure for your switch operating system and NIC. Apply the WEKA-required values below wherever the NVIDIA procedure asks for a traffic class, DSCP value, or priority.

NVIDIA owns and maintains this procedure, and updates it as switch operating system versions change. The links below may move or be replaced over time. If a link is broken or outdated, search NVIDIA's documentation site for the current RoCE configuration procedure matching your switch operating system version.
{% endhint %}

**Before you begin**

Confirm the switch operating system (NVIDIA Onyx or Cumulus Linux) and check NVIDIA's documentation for the procedure matching your switch software version:

* [RDMA Over Converged Ethernet (RoCE), NVIDIA Onyx documentation](https://networking-docs.nvidia.com/onyxum/3104606lts/rdma-over-converged-ethernet-roce)
* [RDMA over Converged Ethernet (RoCE), NVIDIA Cumulus Linux documentation](https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-59/Layer-1-and-Switch-Ports/Quality-of-Service/RDMA-over-Converged-Ethernet-RoCE/)
* [Lossless RoCE configuration for Onyx switches in DSCP-based QoS mode, NVIDIA Enterprise Support](https://enterprise-support.nvidia.com/s/article/lossless-roce-configuration-for-mlnx-os-switches-in-dscp-based-qos-mode--advanced-mode-x)

**Required parameters for WEKA**

<table><thead><tr><th width="216.5859375">Parameter</th><th width="165.8515625">Value</th><th>Notes</th></tr></thead><tbody><tr><td>Marking method</td><td>Layer 3 (DSCP)</td><td>Required when WEKA traffic is routed across subnets. Layer 2 (TOS) marking works only when all servers share a subnet, but WEKA doesn't recommend it.</td></tr><tr><td>DSCP value</td><td>24</td><td>Register value 96 (DSCP x 4) on the NIC.</td></tr><tr><td>Traffic class, data</td><td>3</td><td>Maps to switch priority 3.</td></tr><tr><td>Traffic class, congestion notification (CNP)</td><td>6</td><td>Maps to switch priority 6.</td></tr><tr><td>PFC priority</td><td>3</td><td>Enable Priority Flow Control on this priority so RoCE traffic isn't dropped.</td></tr><tr><td>Congestion control</td><td>ECN</td><td>Enable alongside PFC.</td></tr></tbody></table>

Configure the switch first, using the `roce` macro (Onyx) or `nv set qos roce` (Cumulus Linux) from the NVIDIA procedure, then configure each server's NIC with `mlnx_qos` and `cma_roce_tos` using the values above.

After configuration, verify the network as described in step 7.

## 6. Configure dual-network links with policy-based routing <a href="#configure-dual-network-links-with-policy-based-routing" id="configure-dual-network-links-with-policy-based-routing"></a>

The following steps provide guidance for configuring dual-network links with policy-based routing on Linux systems. Adjust IP addresses and interface names according to your environment.

### **RHEL/Rocky/CentOS routing configuration using the network scripts**

{% hint style="info" %}
Network scripts are deprecated in RHEL/Rocky 8. For RHEL/Rocky 8 and onwards, use the Network Manager.
{% endhint %}

1. Navigate to `/etc/sysconfig/network-scripts/`.
2.  Create the file `/etc/sysconfig/network-scripts/route-mlnx0` with the following content:

    ```bash
    10.90.0.0/16 dev mlnx0 src 10.90.0.1 table weka1
    default via 10.90.2.1 dev mlnx0 table weka1
    ```
3.  Create the file `/etc/sysconfig/network-scripts/route-mlnx1` with the following content:

    ```bash
    10.90.0.0/16 dev mlnx1 src 10.90.1.1 table weka2
    default via 10.90.2.1 dev mlnx1 table weka2
    ```
4.  Create the files `/etc/sysconfig/network-scripts/rule-mlnx0` and `/etc/sysconfig/network-scripts/rule-mlnx1` with the following content:

    ```bash
    table weka1 from 10.90.0.1
    table weka2 from 10.90.1.1
    ```
5.  Open `/etc/iproute2/rt_tables` and add the following lines:

    ```bash
    100 weka1
    101 weka2
    ```
6. Save the changes.

### RHEL/Rocky 8+ routing configuration using the Network Manager

You can configure routing for your Ethernet or InfiniBand connections using Network Manager command-line interface (`nmcli`) commands.

**Configure ethernet routing**

To set up routing for Ethernet connections, use the following `nmcli` commands. In these commands, the first IP address of the route (`10.10.10.0/24`) represents the subnet of the network to which the NIC connects. The last address in the routing rule (`10.10.10.1` for `eth1`) is the IP address of the NIC you are configuring.

{% code overflow="wrap" %}
```bash
nmcli connection modify eth1 ipv4.routes "10.10.10.0/24 src=10.10.10.1 table=100" ipv4.routing-rules "priority 101 from 10.10.10.1 table 100"
nmcli connection modify eth2 ipv4.routes "10.10.10.0/24 src=10.10.10.101 table=200" ipv4.routing-rules "priority 102 from 10.10.10.101 table 200"
```
{% endcode %}

**Configure InfiniBand routing**

To set up routing for InfiniBand connections, use the following `nmcli` commands. The route's first IP address (`10.10.10.0/24`) signifies the network's subnet for the NIC. The last address in the routing rules (`10.10.10.1` for `ib0`) is the IP address of the NIC you are configuring.

{% code overflow="wrap" %}
```bash
nmcli connection modify ib0 ipv4.route-metric 100
nmcli connection modify ib1 ipv4.route-metric 101

nmcli connection modify ib0 ipv4.routes "10.10.10.0/24 src=10.10.10.1 table=100" 
nmcli connection modify ib0 ipv4.routing-rules "priority 101 from 10.10.10.1 table 100"
nmcli connection modify ib1 ipv4.routes "10.10.10.0/24 src=10.10.10.101 table=200" 
nmcli connection modify ib1 ipv4.routing-rules "priority 102 from 10.10.10.101 table 200"
```
{% endcode %}

**View network configuration**

Run the `nmcli` commands to view the current network configuration, including interfaces, IP addresses, routes, and DNS settings.

<table><thead><tr><th width="290.3636474609375">Goal</th><th>Command</th></tr></thead><tbody><tr><td>Full details (IP, DNS, routes)</td><td><code>nmcli device show</code></td></tr><tr><td>Brief status</td><td><code>nmcli device status</code></td></tr><tr><td>Active connections</td><td><code>nmcli connection show --active</code></td></tr><tr><td>Specific device</td><td><code>nmcli device show eth0</code></td></tr></tbody></table>

**Example**

```bash
eno12409: connected to eno12409
        "Mellanox MT2894"
        ethernet (mlx5_core), 50:00:E6:42:FC:27, hw, mtu 9000
        ip4 default
        inet4 10.10.35.140/25
        route4 10.10.35.128/25 metric 101
        route4 default via 10.10.35.129 metric 101
        inet6 fe80::207c:c202:d22f:d26b/64
        route6 fe80::/64 metric 1024

ens1: connected to ens1
        "Mellanox MT2910"
        ethernet (mlx5_core), 9C:63:C0:EB:7C:02, hw, mtu 9000
        inet4 10.10.50.1/24
        route4 10.10.50.0/24 metric 0
        route4 10.10.30.0/24 metric 0
        route4 10.10.37.0/25 via 10.10.50.1 metric 0
        inet6 fe80::f0d6:8ea:5be4:f4ed/64
        route6 fe80::/64 metric 1024

DNS configuration:
        servers: 10.219.59.120 10.211.188.61 10.211.188.73
        domains: example.net
        interface: eno12409
```

### **Ubuntu Netplan configuration**

Configure source-based routing for each data plane interface. This preserves the management default route in the main routing table.

Identify the data plane gateway and every remote network reachable from the data plane. Replace the example addresses, interface names, and additional network CIDRs.

1.  Create or edit `/etc/netplan/10-weka.yaml`:

    <pre class="language-yaml" data-title="/etc/netplan/10-weka.yaml"><code class="lang-yaml"># Host: weka-node-01
    # Apply:  sudo netplan apply

    network:
      version: 2
      renderer: networkd
      ethernets:
        enp2s0:
          dhcp4: yes
          dhcp6: no
          nameservers:
            addresses: [8.8.8.8, 8.8.4.4]
          # Default route via DHCP — no SBR policy needed on management interface

        ib1:
          dhcp4: no
          dhcp6: no
          optional: true
          ignore-carrier: true  # configure even without physical link (IB/RDMA NICs may be slow to init)
          addresses:
            - 10.222.0.10/24
          routes:
            # Main table entries
            - to: 10.222.0.0/24
              scope: link
            # ── Additional subnets reachable via ib1 (main table) ──────────────
            # Add any other CIDRs that hosts/clients on this fabric need to reach.
            # Without a main-table entry, locally-originated traffic (e.g. weka
            # backend&#x3C;->backend, S3, SMB, NFS) may egress the wrong interface.
            # - to: &#x3C;ADDITIONAL_SUBNET>
            #   via: 10.222.0.1
            # Source-based routing table 101
            - to: 0.0.0.0/0
              via: 10.222.0.1
              table: 101
            - to: 10.222.0.0/24
              scope: link
              table: 101
          routing-policy:
            - from: 10.222.0.10/32
              table: 101
              priority: 1010

        ib2:
          dhcp4: no
          dhcp6: no
          optional: true
          ignore-carrier: true  # configure even without physical link (IB/RDMA NICs may be slow to init)
          addresses:
            - 10.222.0.20/24
          routes:
            # Main table entries
            - to: 10.222.0.0/24
              scope: link
            # ── Additional subnets reachable via ib2 (main table) ──────────────
            # Add any other CIDRs that hosts/clients on this fabric need to reach.
            # Without a main-table entry, locally-originated traffic (e.g. weka
            # backend&#x3C;->backend, S3, SMB, NFS) may egress the wrong interface.
            # - to: &#x3C;ADDITIONAL_SUBNET>
            #   via: 10.222.0.1
            # Source-based routing table 102
            - to: 0.0.0.0/0
              via: 10.222.0.1
              table: 102
            - to: 10.222.0.0/24
              scope: link
              table: 102
          routing-policy:
            - from: 10.222.0.20/32
              table: 102
              priority: 1020
    </code></pre>
2.  Apply the configuration:

    ```bash
    sudo netplan apply
    ```

The source-based routing tables select the correct interface for traffic from each data plane IP. The main-table routes reach data plane networks when the data plane is not the default network.

### **SLES/SUSE configuration**

1.  Create `/etc/sysconfig/network/ifrule-eth2` with:

    ```bash
    ipv4 from 192.168.11.21 table 100
    ```
2.  Create `/etc/sysconfig/network/ifrule-eth4` with:

    ```bash
    ipv4 from 192.168.11.31 table 101
    ```
3.  Create `/etc/sysconfig/network/scripts/ifup-route.eth2` with:

    ```bash
    ip route add 192.168.11.0/24 dev eth2 src 192.168.11.21 table weka1
    ```
4.  Create `/etc/sysconfig/network/scripts/ifup-route.eth4` with:

    ```bash
    ip route add 192.168.11.0/24 dev eth4 src 192.168.11.31 table weka2
    ```
5.  Add the weka lines to `/etc/iproute2/rt_tables`:

    ```bash
    100 weka1
    101 weka2
    ```
6.  Restart the interfaces or reboot the machine:

    ```bash
    ifdown eth2; ifdown eth4; ifup eth2; ifup eth4
    ```

**Related topic**

[#high-availability-ha](../../../weka-system-overview/networking-in-wekaio.md#high-availability-ha "mention")

## 7. Verify the network configuration <a href="#verify-the-network-configuration" id="verify-the-network-configuration"></a>

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

{% hint style="info" %}
All WEKA server interfaces within the same subnet must have connectivity and be able to ping each other.
{% endhint %}

## 8. Configure the clock synchronization <a href="#configure-the-clock-synchronization" id="configure-the-clock-synchronization"></a>

The synchronization of time on computers and networks is considered good practice and is vitally important for the stability of the WEKA system. Proper timestamp alignment in packets and logs is very helpful for the efficient and quick resolution of issues.

Configure the clock synchronization software on the backends and clients according to the specific vendor instructions (see your OS documentation), before installing the WEKA software.

## **9. (Optional) Enable kdump** <a href="#enable-kdump" id="enable-kdump"></a>

Enabling kdump ensures crash diagnostic data is captured (`/var/crash`).

1. Install kdump tools (if not exist): `sudo yum install kexec-tools crash`.
2. Enable the kdump service: `sudo systemctl enable kdump.service`.
3. Open the file located at: `/etc/kdump.conf`.
4. Set the crash dump path and size. Example:

```plaintext
path /var/crash
core_collector makedumpfile -c --message-level 1 -d 31
```

## 10. Disable swap

WEKA highly recommends that any servers used as backends have no swap configured. This is distribution-dependent but is often a case of commenting out any `swap` entries in `/etc/fstab` and rebooting.

## 11. Validate the system preparation

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
* Numa balancing is disabled
* RAM state
* XFS FS type installed
* Mellanox OFED is installed
* IOMMU setting in all servers is consistent, either all enabled or all disabled.
* rpcbind utility is enabled
* SquashFS is enabled
* noexec mount option on /tmp

{% hint style="info" %}
The `wekachecker`tool applies to all WEKA versions. From V4.0, the following validations are not relevant, although the tool displays them:

* OS has SELinux disabled or in permissive mode.
* Network Manager is disabled.
{% endhint %}

**Procedure**

1. Clone the the **tools** repository:\
   `git clone --depth 1` [`https://github.com/weka/tools.git`](https://github.com/weka/tools.git)
2. Change directory to **tools/install**.
3. From the **install** directory, run `./wekachecker <hostnames/IPs>`\
   Where:\
   The `hostnames/IPs` is a space-separated list of all the cluster hostnames or IP addresses connected to the **high-speed networking**.\
   Example:\
   `./wekachecker 10.1.1.11 10.1.1.12 10.1.1.4 10.1.1.5 10.1.1.6 10.1.1.7 10.1.1.8`
4. Review the output. If failures or warnings are reported, investigate them and correct them as necessary. Repeat the validation until no important issues are reported.\
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
Checking if Numa balancing is disabled                       [WARN]
Checking RAM state for errors                                [PASS]
Check for XFS FS type installed                              [PASS]
Check if Mellanox OFED is installed                          [PASS]
Check for consistent IOMMU                                   [PASS]
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

[manually-configure-the-weka-cluster-using-the-resource-generator](../manually-configure-the-weka-cluster-using-the-resource-generator/ "mention")
