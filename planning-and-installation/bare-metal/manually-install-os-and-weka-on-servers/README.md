---
description: >-
  Install a supported operating system and the WEKA software on each bare metal
  server when using the manual installation path.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/planning-and-installation/bare-metal/manually-install-os-and-weka-on-servers
---

# Install OS and WEKA software

Install a supported operating system and the WEKA software manually on each bare metal server.

Follow this page if you are using the manual installation and configuration path.

{% hint style="info" %}
For optimal server performance and configuration, use `bios_tool` to set BIOS settings on your servers.

For details, see [Use bios\_tool](../../../appendices/bios-tool.md).
{% endhint %}

**Procedure**

1. Follow the relevant Linux documentation to install the operating system, including the required packages.

**Required packages**

<table><thead><tr><th>RHEL and derivatives</th><th>Ubuntu</th></tr></thead><tbody><tr><td><pre><code>elfutils-libelf-devel
gcc
glibc-headers
glibc-devel
make
perl
rpcbind
xfsprogs
kernel-devel
sssd
</code></pre></td><td><pre><code>libelf-dev
linux-headers-$(uname -r)
gcc
make
perl
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

2. Install the WEKA software.
   * Once the WEKA software tarball is downloaded from [get.weka.io](https://get.weka.io), run the untar command.
   * Run the installation command on each server, following the instructions in the **Install** tab of [get.weka.io](https://get.weka.io/ui/dashboard).
   *   (Optional) Enable safe shutdown:

       To ensure data integrity during server reboots or shutdowns, you can enable the safe shutdown feature during installation. This is highly recommended for converged servers.

       For instructions, see [safe-server-shutdown.md](safe-server-shutdown.md "mention").

Once completed, the WEKA software is installed on all the allocated servers and runs in stem mode (no cluster is attached).

{% hint style="info" %}
If a failure occurs during the WEKA software installation process, an error message prompts detailing the source of the failure. Review the details and try to resolve the failure. If required, contact the [Customer Success Team](../../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

**Related topic**

[Operating system prerequisites](../../prerequisites-and-compatibility.md#operating-system)

## What to do next?

Go to [Validate the system preparation](../setting-up-the-hosts/).
