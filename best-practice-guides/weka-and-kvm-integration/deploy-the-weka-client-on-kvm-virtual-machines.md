---
description: >-
  Deploy WEKA clients in KVM guest VMs with SR-IOV and VF-LAG for isolated,
  high-performance storage access.
---

# Deploy the WEKA client on KVM virtual machines

Deploy the WEKA client inside each KVM guest VM to provide WEKA storage with in-VM encryption and strong tenant data isolation. In this model, each VM installs the WEKA client independently within its own namespace and mounts the WEKA filesystem directly.

Using SR-IOV and VF-LAG, this deployment achieves performance comparable to the server-based model while keeping the KVM server entirely out of the data path. Each VM can be configured with a dedicated VLAN, IP address, and unique WEKA credentials, including access keys. If Kubernetes is deployed on top of the VMs, tenants can deploy the WEKA CSI driver directly within the VM.

### Considerations

* **NIC requirement:** DPDK requires a WEKA-approved Mellanox or NVIDIA adapter in switchdev mode. Supported models are ConnectX-6 Dx/Lx, ConnectX-7, and BlueField-3. Broadcom NICs are not supported for this deployment model.
* **MPESW for dual-port data path:** If using a dual-port data path, Multiport eSwitch (MPESW) is required. MPESW is supported on ConnectX-6 Dx, ConnectX-7, and BlueField-2/3 only.
* **ConnectX-6 non-Dx limitation:** The ConnectX-6 non-Dx does not support VF passthrough with LACP LAG. Its eSwitch uses per-physical-port FDBs in legacy mode, and the switch LACP hash may route replies to a port whose FDB has no rule for the VF MAC, causing 100% packet loss. Use ConnectX-6 Dx, ConnectX-7, BlueField-2, or BlueField-3 instead.
* **Server core budget:** Plan for at least one DPDK core per VM. To run eight VMs on a single KVM server, budget eight cores on that server for DPDK use.
* **One VF per VM:** Each VM requires its own VF. A single VF cannot be shared across multiple guests.
* **Live migration:** SR-IOV VFs are pinned to a NIC, so VM migration is offline or replicated. Live migration is not supported.
* **WEKA client visibility:** Because the WEKA client is installed inside the VM, the tenant is responsible for understanding WEKA client behavior and operations.
* **Qualified OS:** Ubuntu 24.04 has been tested and qualified for this deployment model.
* **`nvidia_vf_single_ip=true`:** This is a mount-time flag. It cannot be added to an already-mounted filesystem. Unmount and remount with the flag if needed.
* **Switch-side LACP:** Switch-side LACP is required for full LAG. Without it, LACP state stays in monitoring mode and the bond operates as active-backup, limiting bandwidth to one 50G port.
* **WEKA version for multi-core:** `num_cores` greater than 1 requires WEKA 5.1.20 or later. In version 5.1.19 and earlier, `num_cores` is effectively 1 regardless of the value passed.

### Before you begin

Prepare the KVM server and WEKA cluster before configuring guest VM access.

* **KVM server:** A Linux server with kernel 6.3 or later. This procedure covers Ubuntu 24.04.
* **WEKA cluster:** A running WEKA cluster at version 5.1.20 or later.
* **WEKA client installer:** The compatible WEKA client installer is available from a cluster backend.

For VF-LAG, also prepare the following:

* **NIC ports:** Two ports on the same NIC. Aggregation across two separate NICs is not supported.
* **L2 switch:** An LACP-capable switch.
* **IOMMU:** Enabled in BIOS. Intel VT-d or AMD-Vi is required for `vfio-pci` virtual function passthrough.

### Workflow

Configure VF-LAG, create the guest VM, then install and mount the WEKA client.

#### 1. Complete firmware prerequisites for VF-LAG

Skip this section if you are not using VF-LAG.

1. Begin by identifying the two Physical Function (PF) PCI addresses on the KVM server:

```bash
## Identify the devices on your server that are Mellanox, NVidia, Virtual, Infiniband.
lspci | grep -i 'Mellanox\|NVIDIA' | grep -v 'Virtual\|Infiniband'
PF0="0000:27:00.0"   # adjust to your hardware. Ensure leading zeros are present.
PF1="0000:27:00.1"
```

2. Check the current firmware configuration:

```bash
## Identify the parameters on the 0th physical device using mlxconfig.
## Query with q and look for srIOV, VFs, and other stuff.
mlxconfig -d $PF0 q | egrep \
  'SRIOV_EN|NUM_OF_VFS|LINK_TYPE_P|INTERNAL_CPU_OFFLOAD_ENGINE|LAG_RESOURCE_ALLOCATION'
```

3. Set the required values using the `mft` package:

```bash
# Enable Multiport eSwitch (MPESW) for a single FDB across both LAG ports
mlxconfig -d $PF0 set LAG_RESOURCE_ALLOCATION=1
mlxconfig -d $PF1 set LAG_RESOURCE_ALLOCATION=1

# Enable SR-IOV and set Ethernet mode
mlxconfig -d $PF0 set SRIOV_EN=1 NUM_OF_VFS=8 LINK_TYPE_P1=2 LINK_TYPE_P2=2
mlxconfig -d $PF1 set SRIOV_EN=1 NUM_OF_VFS=8 LINK_TYPE_P1=2 LINK_TYPE_P2=2

# BlueField only: disable the embedded ARM OS (NIC mode)
mlxconfig -d $PF0 set INTERNAL_CPU_OFFLOAD_ENGINE=1
```

A reboot is required after `mlxconfig set`. Defer the reboot until the end of the KVM server configuration step so that only one reboot is needed.

#### **2. Configure the KVM server**

1. **Install packages.**

{% tabs %}
{% tab title="Ubuntu 24.04" %}
```bash
apt-get install -y qemu-system-x86 qemu-utils libvirt-daemon-system \
  libvirt-clients libvirt-daemon-driver-qemu virtinst bridge-utils \
  cloud-image-utils ovmf mft jq
systemctl enable --now libvirtd
```
{% endtab %}

{% tab title="Rocky Linux 8" %}
<pre class="language-bash"><code class="lang-bash"><strong>dnf groupinstall -y "Virtualization Host"
</strong>dnf install -y qemu-kvm libvirt virt-install virt-manager libvirt-client
systemctl start libvirtd &#x26;&#x26; systemctl enable libvirtd

</code></pre>
{% endtab %}

{% tab title="Ubuntu 22.04" %}
```bash
apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients \
  virtinst bridge-utils cloud-image-utils ovmf mft jq
systemctl enable --now libvirtd
```
{% endtab %}
{% endtabs %}

2. **Enable IOMMU and configure hugepages.**

Use the `grub.d` append pattern rather than editing `GRUB_CMDLINE_LINUX_DEFAULT` directly. Cloud images override this variable from `/etc/default/grub.d/50-cloudimg-settings.cfg`.

Set hugepages to `16384` per VM (32 GiB). For N VMs, set `hugepages=(N * 16384)`.

{% tabs %}
{% tab title="Intel server" %}
```bash
cat > /etc/default/grub.d/vflag.cfg << 'EOF'
GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT intel_iommu=on \
iommu=pt default_hugepagesz=2M hugepagesz=2M hugepages=16384"
EOF
update-grub
```
{% endtab %}

{% tab title="AMD server" %}
```bash
cat > /etc/default/grub.d/vflag.cfg << 'EOF'
GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT amd_iommu=on \
iommu=pt default_hugepagesz=2M hugepagesz=2M hugepages=16384"
EOF
update-grub
```
{% endtab %}
{% endtabs %}

3. **Autoload `vfio-pci`.**

```bash
echo vfio-pci > /etc/modules-load.d/vfio.conf
```

4. **Snapshot network state.**

Save the current network configuration before making changes, in case a rollback is needed:

```bash
mkdir -p /root/preLAG
ip -j addr > /root/preLAG/ip-addr.json
ip -j link > /root/preLAG/ip-link.json
cp -a /etc/netplan /root/preLAG/netplan 2>/dev/null || true
mlxconfig -d $PF0 q > /root/preLAG/mlxconfig-pf0.txt
mlxconfig -d $PF1 q > /root/preLAG/mlxconfig-pf1.txt
```

Reboot now to apply the firmware and kernel command-line changes:

```bash
reboot
```

After rebooting, confirm the changes are active:

```bash
cat /proc/cmdline | grep -E 'iommu|hugepages'   # both present
grep HugePages_Total /proc/meminfo               # matches hugepages=N
dmesg | grep -iE 'AMD-Vi|DMAR|iommu'            # IOMMU active
modprobe vfio-pci && lsmod | grep vfio_pci
```

#### 3. Set up VF-LAG

Skip this section if you are not using VF-LAG.

1. **Find Physical Function device names.**

```bash
PF0_DEV=$(ls /sys/bus/pci/devices/$PF0/net/ | head -1)   # for example, ens2f0np0
PF1_DEV=$(ls /sys/bus/pci/devices/$PF1/net/ | head -1)   # for example, ens2f1np1
echo "PF0=$PF0_DEV PF1=$PF1_DEV"
```

2. **Bring Physical Functions down.**

```bash
ip link set $PF0_DEV down
ip link set $PF1_DEV down
```

3. **Switch to switchdev mode.**

switchdev mode must be enabled before SR-IOV so that VF representor netdevs are created:

```bash
devlink dev eswitch set pci/$PF0 mode switchdev
devlink dev eswitch set pci/$PF1 mode switchdev
devlink dev eswitch show pci/$PF0   # verify: mode switchdev
```

4. **Create the LACP bond on the Physical Functions.**

The LACP bond must exist before the Physical Functions are enslaved. Configure the two switch ports as a LAG or port-channel with LACP on the switch before this step. Without switch-side LACP, the Physical Functions remain in monitoring state and load balancing does not engage. Active-backup still works, but bandwidth is limited to one port.

```bash
modprobe bonding
ip link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast \
  xmit_hash_policy layer3+4
ip link set $PF0_DEV master bond0
ip link set $PF1_DEV master bond0
ip link set bond0 up
ip addr add <HOST_DATAPLANE_IP>/16 dev bond0

# Verify
cat /proc/net/bonding/bond0 | grep -E 'MII Status|Speed'
dmesg | grep -i 'lag map'   # MPESW prints lag map after bond forms
```

5. **Enable SR-IOV.**

```bash
N_VMS=1   # set to the number of VMs you want. Do not exceed NUM_OF_VFS.
echo 0 > /sys/class/net/$PF0_DEV/device/sriov_numvfs   # safety reset
echo $N_VMS > /sys/class/net/$PF0_DEV/device/sriov_numvfs

# Verify VF and representor creation
ip -br link | grep -E "${PF0_DEV}v|${PF0_DEV}r"
```

6. **Set VF MAC addresses.**

Use `devlink port function set` to assign a unique MAC address to each VF. This installs an FDB rule in the MPESW table so that frames for the VF MAC are steered to the correct VF regardless of the driver the VF is bound to. The leading `02` bit marks these as locally administered unicast MACs, which do not collide with any NIC's burned-in address.

```bash
for VF_IDX in $(seq 0 $((N_VMS-1))); do
  VF_MAC=$(printf '02:01:5a:%02x:%02x:%02x' \
    $(((VF_IDX >> 16) & 0xff)) $(((VF_IDX >> 8) & 0xff)) $((VF_IDX & 0xff)))
  VF_PORT=$(devlink -j port show | python3 -c "
import json,sys
d=json.load(sys.stdin)
for k,v in d['port'].items():
  if v.get('flavour')=='pcivf' and v.get('pfnum')==0 and v.get('vfnum')==$VF_IDX:
    print(k); break
")
  devlink port function set $VF_PORT hw_addr $VF_MAC
  echo "VF$VF_IDX: $VF_PORT mac=$VF_MAC"
done
```

Record each generated MAC address. Use the matching address in the guest network configuration.

7. **Bind each VF to `vfio-pci`.**

Use `driver_override` with `drivers_probe`, not `new_id`. The `new_id` method globally adds the device ID to vfio-pci probing. `driver_override` is per-device and is the correct method for mlx5 VFs.

```bash
for VF_IDX in $(seq 0 $((N_VMS-1))); do
  VF_PCI=$(basename $(readlink -f /sys/class/net/$PF0_DEV/device/virtfn${VF_IDX}))
  echo vfio-pci > /sys/bus/pci/devices/$VF_PCI/driver_override
  CURR=$(basename $(readlink /sys/bus/pci/devices/$VF_PCI/driver) 2>/dev/null || echo "")
  [ -n "$CURR" ] && echo $VF_PCI > /sys/bus/pci/devices/$VF_PCI/driver/unbind
  echo $VF_PCI > /sys/bus/pci/drivers_probe
  lspci -k -s $VF_PCI | grep 'Kernel driver'   # expected: mlx5_vfio_pci or vfio-pci
done
```

#### 4. Wire VF representors to `bond0`

Connect each VF representor to `bond0` to establish a Layer 2 path between each VM and the physical network. In switchdev mode, every VF has a VF representor netdev on the server, for example `eth0`. The representor is the server-side software proxy for the VF.

Without wiring the representor to `bond0`, there is no Layer 2 path between the VM and the physical network. ARP requests from the VM arrive at the representor and are dropped, and IP connectivity cannot be established.

Weka DPDK operates at Layer 2 and opens raw Ethernet ports to communicate directly with cluster backends. IP routing on the server cannot provide a Layer 2 forwarding path. A bridge or TC redirect is the required mechanism.

When the bridge forwards the first frame from a representor, it installs an `extern_learn` offload FDB entry in the eSwitch. The hardware then forwards all subsequent unicast frames for that MAC directly between the VF and the bond uplink, bypassing the server CPU entirely. The bridge remains in the data path only for the first packet of each new flow (ARP and initial TCP SYN). Measured hardware offload ratios exceed 99%.

<details>

<summary>Option A: Linux bridge. Recommended for eight VMs or fewer.</summary>

```bash
modprobe bridge
ip link add br0 type bridge
ip link set br0 up

# Move the server dataplane IP to the bridge
ip addr flush dev bond0
ip addr add <HOST_DATAPLANE_IP>/16 dev br0
ip link set bond0 master br0

# Enslave all representors
for VF_IDX in $(seq 0 $((N_VMS-1))); do
  ip link set ${PF0_DEV}r${VF_IDX} up
  ip link set ${PF0_DEV}r${VF_IDX} master br0
done

# Verify offload (within seconds of first guest traffic)
sleep 5 && bridge -d fdb show br br0 | grep -E 'offload|02:01:5a'
```

</details>

<details>

<summary>Option B: TC redirect rules. Use when you need a bridge-free path or more explicit traffic steering.</summary>

```bash
for VF_IDX in $(seq 0 $((N_VMS-1))); do
  REP="${PF0_DEV}r${VF_IDX}"
  MAC=$(printf '02:01:5a:%02x:%02x:%02x' \
    $(((VF_IDX >> 16) & 0xff)) $(((VF_IDX >> 8) & 0xff)) $((VF_IDX & 0xff)))
  PREF=$((VF_IDX + 1))

  ip link set $REP up
  tc qdisc add dev $REP ingress 2>/dev/null || true
  tc filter add dev $REP ingress pref 1 flower \
    action mirred egress redirect dev bond0
  tc qdisc add dev bond0 ingress 2>/dev/null || true
  tc filter add dev bond0 ingress pref $PREF handle $PREF flower \
    dst_mac $MAC action mirred egress redirect dev $REP
done

tc filter show dev ${PF0_DEV}r0 ingress | grep -E 'in_hw|not_in_hw'
```

</details>

#### 5. Create the guest VM.

1. **Prepare the disk and cloud-init seed.**

```bash
# Download the base image (Ubuntu 22.04)
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img \
  -O /var/lib/libvirt/images/ubuntu22-base.img

# Create per-VM overlays (thin-provisioned, 60 GiB)
for VM_IDX in $(seq 0 $((N_VMS-1))); do
  qemu-img create -f qcow2 -F qcow2 \
    -b /var/lib/libvirt/images/ubuntu22-base.img \
    /var/lib/libvirt/images/weka-vm${VM_IDX}.qcow2 60G
done

# Create the seed image (one per VM). Increment `instance-id` on each redeployment.
cat > /tmp/meta-data << 'EOF'
instance-id: iid-local01
local-hostname: weka-vm0
EOF

cat > /tmp/user-data.yaml << 'EOF'
#cloud-config
users:
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - <YOUR_PUBLIC_KEY_HERE>
EOF

cloud-localds /var/lib/libvirt/images/weka-vm0-seed.img \
  /tmp/user-data.yaml /tmp/meta-data
```

2. **Find the VF PCI address for the guest VM.**

```bash
VF0_PCI=$(basename $(readlink -f /sys/class/net/$PF0_DEV/device/virtfn0))
echo $VF0_PCI   # for example: 0000:27:00.3 → bus=0x27 slot=0x00 function=0x3
```

3. **Define the VM XML.**

Update the following XML for each VM. Change the name, disk, seed image, VF address, and NUMA cpuset as needed.

<details>

<summary>Example VM XML</summary>

```xml
<domain type='kvm'>
  <name>weka-vm0</name>
  <memory unit='KiB'>33554432</memory>   <!-- 32 GiB -->
  <memoryBacking>
    <hugepages/>      <!-- server hugepage backing -->
    <nosharepages/>   <!-- no KSM merging -->
    <locked/>         <!-- pin pages, required for VFIO -->
  </memoryBacking>
  <vcpu placement='static'>6</vcpu>
  <cputune>
    <!-- Pin vCPUs to the NUMA node that owns the NIC PCI bus -->
    <!-- Find NUMA node: cat /sys/bus/pci/devices/$PF0/numa_node -->
    <vcpupin vcpu='0' cpuset='0-23,48-71'/>   <!-- NUMA 0 example for AMD EPYC 2S -->
    <vcpupin vcpu='1' cpuset='0-23,48-71'/>
    <vcpupin vcpu='2' cpuset='0-23,48-71'/>
    <vcpupin vcpu='3' cpuset='0-23,48-71'/>
    <vcpupin vcpu='4' cpuset='0-23,48-71'/>
    <vcpupin vcpu='5' cpuset='0-23,48-71'/>
  </cputune>
  <numatune>
    <memory mode='strict' nodeset='0'/>   <!-- strict NUMA 0 -->
  </numatune>
  <os>
    <type arch='x86_64' machine='q35'>hvm</type>
    <!-- Use OVMF_CODE_4M.fd, not OVMF_CODE_4M.ms.fd. The .ms.fd variant enables
         Secure Boot, which triggers kernel lockdown and blocks the mpin_user module
         required by WEKA DPDK. -->
    <loader readonly='yes' type='pflash'>/usr/share/OVMF/OVMF_CODE_4M.fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/weka-vm0_VARS.fd</nvram>
  </os>
  <cpu mode='host-passthrough' check='none'/>
  <features><acpi/><apic/><ioapic driver='kvm'/></features>
  <devices>
    <emulator>/usr/bin/qemu-system-x86_64</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/weka-vm0.qcow2'/>
      <target dev='vda' bus='virtio'/>
    </disk>
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <source file='/var/lib/libvirt/images/weka-vm0-seed.img'/>
      <target dev='sda' bus='sata'/><readonly/>
    </disk>
    <interface type='network'>
      <source network='default'/><model type='virtio'/>   <!-- SSH management -->
    </interface>
    <!-- managed='no' prevents libvirt from rebinding the representor -->
    <hostdev mode='subsystem' type='pci' managed='no'>
      <driver name='vfio'/>
      <source>
        <address domain='0x0000' bus='0x27' slot='0x00' function='0x3'/>
        <!-- Replace bus/slot/function with values from $VF0_PCI -->
      </source>
    </hostdev>
  </devices>
</domain>
```

</details>

Define and start the guest VM:

```bash
virsh define /tmp/weka-vm0.xml
virsh start weka-vm0
```

#### 6. Configure the guest OS

SSH into the guest using the management NIC. To identify the guest IP address, run `virsh net-dhcp-leases default` on the server.

1. **Name and address the VF.**

Identify the VF network interface:

```bash
lspci -nn | grep -i Mellanox
ip -br link   # the non-management interface is the VF, for example enp4s0
```

Create `/etc/netplan/60-vf.yaml`:

```yaml
network:
  version: 2
  ethernets:
    enp4s0:
      match:
        macaddress: "02:01:5a:00:00:00"   # the MAC generated for VF 0
      set-name: enp4s0
      dhcp4: false
      addresses:
        - 10.222.29.50/16   # a free IP on the cluster dataplane subnet
```

Apply and verify:

```bash
netplan apply
ping -c2 <BACKEND_IP>   # confirms the full VF-LAG path is working
```

2. **Set hugepages inside the guest.**

```bash
cat > /etc/default/grub.d/hugepages.cfg << 'EOF'
GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT \
  default_hugepagesz=2M hugepagesz=2M hugepages=8192"
EOF
update-grub
reboot
```

After rebooting, verify: `grep HugePages_Total /proc/meminfo`.

3. **Install `mlx5_ib`.**

Minimal cloud images do not include `mlx5_ib`. WEKA checks `/sys/class/infiniband/` at mount time, so this module must be present:

```bash
apt-get install -y linux-modules-extra-$(uname -r)
modprobe mlx5_ib
echo mlx5_ib >> /etc/modules   # persist across reboots
```

#### 7. Install and mount the WEKA client

1. **Install the WEKA client.**

Install the WEKA client from a cluster backend. No external internet connection is required. The backends serve the installer directly:

```bash
curl --proto '=https' --tlsv1.2 -sSfk \
  "https://<BACKEND_IP>:14000/dist/v1/install/<VERSION>/<VERSION>" | sh
weka version   # verify
```

2. **Mount the WEKA filesystem.**

Use the `nvidia_vf_single_ip=true` mount option. This option tells WEKA that the NIC is a VF backed by a hardware LAG bond, that all DPDK processes on this VF share a single IP, and to use `rte_flow_isolate(1)` to pull flows away from the kernel netdev.

```bash
mkdir -p /mnt/weka/default
mount -t wekafs \
  -o num_cores=4,net=enp4s0,nvidia_vf_single_ip=true \
  <BACKEND_IP>/default /mnt/weka/default

mount | grep wekafs    # verify
weka local ps          # verify the container state is READY
```

#### 8. Configure multiple cores

Each core maps to a separate hardware TX/RX queue pair on the VF. Use the following table to choose `num_cores` based on the number of guest vCPUs:

<table><thead><tr><th width="142">Guest vCPUs</th><th width="154">Recommended num_cores</th><th>Notes</th></tr></thead><tbody><tr><td>4</td><td>2</td><td>Leaves 2 vCPUs for the OS and WEKA agent.</td></tr><tr><td>6</td><td>4</td><td>Sweet spot for throughput. Measured at parity with bare metal.</td></tr><tr><td>8</td><td>6</td><td>For high-throughput workloads. Monitor guest CPU utilization.</td></tr><tr><td>10+</td><td>8</td><td>Do not exceed the hardware queue count. Check with <code>ethtool -l &#x3C;vf-dev></code>.</td></tr></tbody></table>
