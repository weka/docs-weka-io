---
description: >-
  Review the following known issues and their resolutions when integrating WEKA
  with KVM.
---

# Troubleshoot KVM integration issues

<details>

<summary>VM has no SSH key or hostname after first boot</summary>

`cloud-init` caches per-instance state keyed on `instance-id`. If you reuse the same ID after recycling a disk, `cloud-init` skips all modules on first boot and the SSH key and hostname are not applied. Increment the `instance-id` in the `meta-data` block for each VM deployment, for example `iid-local01` → `iid-local02`.

</details>

<details>

<summary>Cloned VMs have conflicting identities</summary>

When cloning KVM VMs, every VM must have a unique and persistent `libvirt` domain UUID. Using `virt-clone` regenerates the UUID and MAC address automatically. A manual copy of the XML or disk does not regenerate these values and will cause conflicts.

</details>

<details>

<summary>WEKA DPDK crashes on guest VM startup</summary>

This occurs when Secure Boot is enabled in the VM. Use `OVMF_CODE_4M.fd` as the UEFI firmware, not `OVMF_CODE_4M.ms.fd`. The `.ms.fd` variant enables Secure Boot, which triggers kernel lockdown and blocks the `mpin_user` module required by WEKA DPDK.

</details>

<details>

<summary>Filesystem mount fails with "Missing ibverbs device"</summary>

The `mlx5_ib` kernel module is missing. Minimal cloud images do not include it. Fix:

```bash
apt-get install -y linux-modules-extra-$(uname -r)
modprobe mlx5_ib
```

</details>

<details>

<summary>Hugepages configuration is lost after reboot</summary>

The `grub.d` configuration was overridden by `cloud-init`. Use `/etc/default/grub.d/hugepages.cfg` to configure hugepages, not `GRUB_CMDLINE_LINUX` directly. Follow the hugepage configuration step in [#id-2.-configure-the-kvm-server](deploy-the-weka-client-on-kvm-virtual-machines.md#id-2.-configure-the-kvm-server "mention") procedure in Deploy the WEKA client on KVM virtual machines.

</details>

<details>

<summary>`RTNETLINK: Operation not supported` warning</summary>

This is a known `mlx5` switchdev limitation that appears when attempting switchdev configuration. It can be safely disregarded and does not affect functionality.

</details>

<details>

<summary>VF not binding correctly to vfio-pci</summary>

Use `driver_override` with `drivers_probe`, not `new_id`. The `new_id` method globally adds the device ID to vfio-pci probing. `driver_override` is per-device and is the correct method for mlx5 VFs. Follow the [#id-3.-set-up-vf-lag](deploy-the-weka-client-on-kvm-virtual-machines.md#id-3.-set-up-vf-lag "mention") procedure in Deploy the WEKA client on KVM virtual machines.

</details>

<details>

<summary>VF MAC frames not reaching the correct VF</summary>

Ensure you used `devlink port function set hw_addr` in switchdev mode. Generate and assign a unique MAC address for every VF. Follow the **Set VF MAC addresses** step in the [#id-3.-set-up-vf-lag](deploy-the-weka-client-on-kvm-virtual-machines.md#id-3.-set-up-vf-lag "mention") procedure in Deploy the WEKA client on KVM virtual machines.

</details>

<details>

<summary>100% ICMP loss after adding a dataplane IP to a bonded NIC</summary>

Never add the dataplane IP to a NIC that is part of a bonded LAG. If this was done, remove the address:

```bash
ip addr del <IP> dev $PF0_DEV
```

Adding an IP to a Physical Function during takedown causes ARP to resolve but packets to exit on the wrong interface.

</details>

<details>

<summary>`SoC on vfio-pci` message appears</summary>

This is a cosmetic message and can be disregarded. It does not affect the VF data path.

</details>

<details>

<summary>LACP bond members remain in monitoring state (ping works but no load balancing)</summary>

Switch-side LAG is not configured. Configure the LAG or port-channel with LACP on the upstream switch before creating the bond. Follow the LACP bond procedure in [deploy-the-weka-client-on-kvm-virtual-machines.md](deploy-the-weka-client-on-kvm-virtual-machines.md "mention"). Without switch-side LACP, the bond operates as active-backup only.

</details>

<details>

<summary>MultiPorteSwitch (MPeSW) does not engage after a warm reboot</summary>

Perform a full power cycle using iDRAC/iLO chassis power off. A warm reboot is insufficient to reinitialize MPeSW.

</details>

<details>

<summary>`dmesg: VF BAR 0: can't assign; no space` error at VM boot</summary>

The PCIe MMIO window is too small. Lower `NUM_OF_VFS` in `mlxconfig`. As a secondary mitigation, add `pci=realloc=on` to the kernel command line.

</details>
