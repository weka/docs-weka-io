---
description: >-
  This requirement only applies when manually preparing and installing the WEKA
  cluster on bare metal servers.
---

# Manually install OS and WEKA on servers

If you are not using the WMS or WSA automated tools for installing a WEKA cluster, manually install a supported OS and the WEKA software on the bare metal server.

**Procedure**

1. Follow the relevant Linux documentation to install the operating system, including the required packages.

**Required packages**

| RHEL and derivatives                                                                                                 | Ubuntu                                                                                                        |
| -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| <pre><code>elfutils-libelf-devel
gcc
glibc-headers
glibc-devel
make
perl
rpcbind
xfsprogs
kernel-devel
</code></pre> | <pre><code>libelf-dev
linux-headers-$(uname -r)
gcc
make
perl
python2-minimal
rpcbind
xfsprogs

</code></pre> |

<details>

<summary>Recommended packages for remote support and maintenance</summary>

#### RHEL and derivatives

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

#### Ubuntu

```
elfutils
fio
git
hwloc
iperf
ipmitool
kexec-tools
jk
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
   * Run the `install.sh` command on each server, according to the instructions in the **Install** tab.

Once completed, the WEKA software is installed on all the allocated servers and runs in stem mode (no cluster is attached).

{% hint style="info" %}
If a failure occurs during the WEKA software installation process, an error message prompts detailing the source of the failure. Review the details and try to resolve the failure. If required, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

**Related topic**

[#operating-system](../prerequisites.md#operating-system "mention") (on the Prerequisites and compatibility topic)



## What to do next?

[setting-up-the-hosts](setting-up-the-hosts/ "mention")
