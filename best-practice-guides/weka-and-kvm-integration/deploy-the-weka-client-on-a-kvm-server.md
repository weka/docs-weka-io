---
description: Provide WEKA storage to virtual machines through virtio-fs.
---

# Deploy the WEKA client on a KVM server

Deploy the WEKA client on the KVM server to provide storage to guest VMs. Guest VMs do not require a WEKA client installation.

The KVM administrator provisions and manages WEKA storage using virtio-fs. Each VM receives a dedicated virtio-fs device. Its source directory must contain only that VM's data.

Guest VMs use a standard virtio-fs filesystem and do not interact with WEKA directly. This model has the following properties:

* VMs require no WEKA knowledge. Log collection and lifecycle management use standard Linux and KVM tools.
* Day-2 VM operations such as pause, snapshot, and live migration can be performed without touching the data path.
* Folder quotas set in WEKA are visible to VMs using `df` and can be resized without interrupting the VM.

### Considerations

* **VM isolation:** Export only the VM's dedicated directory. Do not export the parent WEKA mount. Protect each directory with POSIX ownership, permissions, or ACLs. Directory scoping does not isolate data from privileged users on the KVM server or from other exports.
* **In-flight encryption:** Because virtio-fs is a shared filesystem and the KVM server is in the data path, in-flight encryption from the guest VM to the filesystem is not supported. To enable in-flight encryption, deploy the WEKA client on the VM instead. See [deploy-the-weka-client-on-kvm-virtual-machines.md](deploy-the-weka-client-on-kvm-virtual-machines.md "mention").
* **KVM server root access:** The KVM server's root user can read guest VM filesystems directly. If strict tenant isolation is required, use the VM-based deployment model.
* **Per-VM processes:** Each VM has a dedicated `virtiofsd` process and a dedicated server mount point, for example `/mnt/weka/vm1`, `/mnt/weka/vm2`, and so on.

### Before you begin

Prepare a KVM server and verify that the WEKA cluster is running.

* **KVM server:** A Linux server configured as a KVM hypervisor. This procedure covers Ubuntu 24.04.
* **WEKA cluster:** A running WEKA cluster.
* **WEKA client:** A compatible WEKA client installed on the KVM server. Verify it with `weka version`.

### Workflow

Configure the KVM server, mount the WEKA filesystem, and expose it to the VM through virtio-fs.

#### 1. Configure the KVM server

1. **Install packages.**

Install the required KVM and QEMU packages. Enable the `libvirtd` service.

{% tabs %}
{% tab title="Ubuntu 24.04" %}
```bash
apt-get install -y qemu-system-x86 qemu-utils libvirt-daemon-system \
  libvirt-clients libvirt-daemon-driver-qemu virtinst bridge-utils \
  cloud-image-utils ovmf mft jq
systemctl enable --now libvirtd
```
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

Use the `grub.d` append pattern. Do not edit `GRUB_CMDLINE_LINUX_DEFAULT` directly. Cloud images override this variable from `/etc/default/grub.d/50-cloudimg-settings.cfg`.

Set hugepages to `16384` per VM (32 GiB). For N VMs, set `hugepages=(N * 16384)`.

Run the applicable commands on the KVM server.

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

#### 2. Mount the WEKA filesystem and create a VM directory

Mount the WEKA filesystem on the KVM server using a stateless client mount. Replace the placeholders with your environment's values:

* `<interface-name>`: the network interface to mount on
* `<backend_IP>`: the IP address or hostname of the WEKA cluster
* `<filesystem>`: the WEKA filesystem name
* `<host_mountpoint>`: the mount point on the KVM server, for example `/mnt/weka`

```bash
sudo mount -t wekafs -o net=<interface-name> -o num_cores=1 \
  <backend_IP>/<filesystem> <host_mountpoint>
```

To confirm the mount was successful:

```bash
mount | grep /mnt/weka
```

Example output:

```bash
1.1.1.1/default1 on /mnt/weka type wekafs
(rw,relatime,forcedirect,inode_bits=auto,readahead_kb=32768,
dentry_max_age_positive=1000,dentry_max_age_negative=0,container_name=client)
```

Create a directory for the VM. Set ownership and permissions for the user and group used in the guest.

```bash
mkdir -p <host_mountpoint>/vm1
chown <guest-uid>:<guest-gid> <host_mountpoint>/vm1
chmod 0700 <host_mountpoint>/vm1
```

#### 3. Create a VM with a virtio-fs filesystem

Create a VM using `virt-install` with the required virtio-fs options. Replace `<vm_source_dir>` with the VM directory created in step 2, for example `/mnt/weka/vm1`. Replace `<guest_mountpoint>` with the guest mount identifier used in step 4.

```bash
virt-install \
  --name ubuntu-cloud-vm --ram 4096 --vcpus 2 \
  --os-variant ubuntu24.04 \
  --disk path=/var/lib/libvirt/images/webserver-01.qcow2,format=qcow2 \
  --disk path=/var/lib/libvirt/images/webserver-02-seed.iso,device=cdrom \
  --import --graphics none \
  --memorybacking source.type=memfd,access.mode=shared \
  --network network=default,model=virtio \
  --filesystem source.dir="<vm_source_dir>",target.dir="<guest_mountpoint>",\
type=mount,mode=passthrough,driver.type=virtiofs
```

The following options are required:

* `memorybacking` must use `source.type=memfd` and `access.mode=shared`. For details, see the [libvirt virtiofs documentation](https://libvirt.org/kbase/virtiofs.html#sharing-a-host-directory-with-a-guest).
* `filesystem` shares only the VM source directory at the specified guest mount point.

Example output:

```
Starting install...
Creating domain...
  | 0 B  00:00:00
Running text console command: virsh --connect qemu:///system console ubuntu-cloud-vm
Connected to domain 'ubuntu-cloud-vm'
Escape character is ^] (Ctrl + ])
^]Domain creation completed.
```

#### 4. Mount the virtio-fs filesystem in the VM

After the VM is running, mount the virtio-fs filesystem from within the guest. To persist the mount across reboots, add an entry to `/etc/fstab`. You can also use cloud-init to populate `/etc/fstab` automatically during VM definition.

Create a destination directory and mount the filesystem using the `<guest_mountpoint>` identifier set in step 3:

```bash
mkdir ~/share
sudo mount -t virtiofs share ~/share
```

To confirm the mount is successful:

```bash
mount | grep share
```

Expected output:

```
share on /home/ubuntu/share type virtiofs (rw,relatime)
```

The VM sees a virtio-fs filesystem backed by its assigned source directory.
