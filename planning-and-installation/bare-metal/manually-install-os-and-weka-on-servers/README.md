---
description: >-
  Install a supported operating system and the WEKA software on each bare metal
  server when using the manual installation path.
---

# Install OS and WEKA software

Install a supported operating system and the WEKA software manually on each bare metal server.

Follow this page if you are using the manual installation and configuration path.

{% hint style="info" %}
For optimal server performance and configuration, use `bios_tool` to set BIOS settings on your servers.

For details, see [Use bios\_tool](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/appendices/bios-tool).
{% endhint %}

**Procedure**

1. Follow the relevant Linux documentation to install the operating system, including the required packages.

**Required packages**

These packages also apply to clients.

{% hint style="info" %}
On Ubuntu, a client with missing required packages runs `apt-get update` and installs them during its first mount. Preinstall the packages during provisioning to avoid repository access and package downloads at mount time.
{% endhint %}

| RHEL and derivatives                                                                                                               | Ubuntu                                                                                                                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <p>elfutils-libelf-devel<br>gcc<br>glibc-headers<br>glibc-devel<br>make<br>perl<br>rpcbind<br>xfsprogs<br>kernel-devel<br>sssd</p> | <p>libelf-dev<br>linux-headers-$(uname -r)<br>gcc<br>make</p><p>perl<br>python2-minimal (python3-minimal on >=24.04)<br>rpcbind<br>xfsprogs<br>sssd</p> |

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
If a failure occurs during the WEKA software installation process, an error message prompts detailing the source of the failure. Review the details and try to resolve the failure. If required, contact the [Customer Success Team](../../../support/getting-support-for-your-weka-system.md#open-a-support-case).
{% endhint %}

**Related topic**

[Operating system prerequisites](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/planning-and-installation/prerequisites-and-compatibility#operating-system)

## What to do next?

Go to [Prepare the system](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/planning-and-installation/bare-metal/setting-up-the-hosts).
