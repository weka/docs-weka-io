---
description: >-
  Install a supported operating system and the required packages on each bare
  metal server when using the manual installation path.
---

# Install the operating system

Install a supported operating system and the required packages manually on each bare metal server.

Follow this page if you are using the manual installation and configuration path.

{% hint style="info" %}
For optimal server performance and configuration, use `bios_tool` to set BIOS settings on your servers.

For details, see [Use bios\_tool](../../appendices/bios-tool.md).
{% endhint %}

**Procedure**

1. Follow the relevant Linux documentation to install the operating system, including the required packages.

**Required packages**

These packages also apply to clients.

{% hint style="info" %}
On Ubuntu, a client with missing required packages runs `apt-get update` and installs them during its first mount. Preinstall the packages during provisioning to avoid repository access and package downloads at mount time.
{% endhint %}

<table><thead><tr><th width="326.72265625">RHEL and derivatives</th><th>Ubuntu</th></tr></thead><tbody><tr><td><pre><code>elfutils-libelf-devel
gcc
glibc-headers
glibc-devel
make
perl
rpcbind
xfsprogs
kernel-devel-$(uname -r)
sssd
</code></pre></td><td><pre><code>libelf-dev
linux-headers-$(uname -r)
gcc
make
perl
python2-minimal (python3-minimal on >=24.04)
rpcbind
xfsprogs
sssd
</code></pre></td></tr></tbody></table>

<details>

<summary>Recommended packages for remote support and maintenance</summary>

**RHEL and derivatives**

```
@network-tools
@large-systems
@hardware-monitoring
bind-utils
elfutils
ipmitool
kexec-tools
nvme-cli
python3
yum-utils
sysstat
telnet
nmap
git
sshpass
lldpd
fio
numactl
numactl-devel
libaio-devel
hwloc
tmux
pdsh
pdsh-rcmd-ssh
pdsh-mod-dshgroup
tmate
iperf
htop
nload
screen
ice
```

**Ubuntu**

```
elfutils
fio
git
hwloc
iperf
ipmitool
kexec-tools
jq
ldap-client
libaio-dev
lldpd
nfs-client
nload
nmap
numactl
nvme-cli
pdsh
python3
sshpass
sysstat
tmate
```

</details>

**Related topic**

[Operating system prerequisites](../prerequisites-and-compatibility.md#operating-system)

## What to do next?

Go to [Install the WEKA software](install-the-weka-software/).
