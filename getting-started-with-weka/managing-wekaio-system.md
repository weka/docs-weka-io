---
description: This page describes the various ways to manage Weka system.
---

# Managing the Weka System

The Weka system is now installed. Now let's learn how to view, manage and operate it using either the [CLI](managing-wekaio-system.md#cli) or the [GUI](managing-wekaio-system.md#gui), and [perform the first IO](performing-the-first-io.md) to a WekaFS filesystem.

## CLI

The Weka CLI is installed on each Weka host and is available through the `weka` command. It's possible to`ssh` one of the hosts and run the `weka` command. This displays a list of all available top-level commands. You can go ahead and explore them.

```text
$ weka
Usage:
    weka [--help] [--build] [--version] [--legal]

Description:
    The base command for all weka related CLIs

Subcommands:
   agent      Command s that control the weka agent (outside the weka containers)
   alerts     List alerts in the Weka cluster
   cloud      Cloud commands. List the cluster's cloud status, if no subcommand supplied.
   cluster    Commands that manage the cluster
   debug      Commands used to debug a weka cluster
   diags      Diagnostics commands to help understand the status of the cluster and its environment
   events     List all events that conform to the filter criteria
   fs         List filesystems defined in this Weka cluster
   local      Commands that control weka and its containers on the local machine
   mount      Mounts a wekafs filesystem. This is the helper utility installed at /sbin/mount.wekafs.
   nfs        Commands that manage client-groups, permissions and interface-groups
   org        List organizations defined in the Weka cluster
   security   Security commands.
   smb        Commands that manage Weka's SMB container
   stats      List all statistics that conform to the filter criteria
   status     Get an overall status of the Weka cluster
   umount     Unmounts wekafs filesystems. This is the helper utility installed at /sbin/umount.wekafs.
   user       List users defined in the Weka cluster
   version    When run without arguments, lists the versions available on this machine. Subcommands allow for
              downloading of versions, setting the current version and other actions to manage versions.

Options:
   --agent         Start the agent service
   -h, --help      Show help message
   --build         Prints the CLI build number and exits
   -v, --version   Prints the CLI version and exits
   --legal         Prints software license information and exits
```

For more information about the CLI, refer to [Getting Started with Weka CLI](cli-overview.md).

## GUI

The Weka GUI is accessible at port 14000. It can be accessed from any host or by using the cluster name. For example: `http://weka01:14000` or `http://WekaProd:14000`.

{% hint style="info" %}
**Note:** If it's not possible to access the GUI, make sure that it has been opened in your firewall, as described in the [Prerequisites](../install/bare-metal/prerequisites-for-installation-of-weka-dedicated-hosts.md) page.
{% endhint %}

![Weka Login Page](../.gitbook/assets/wekaio-login-page.png)

The initial default username/password is _admin/admin,_ as described in [User Management.](../usage/user-management.md) It is recommended to change this.

For more information about the GUI, refer to [Getting Started with Weka GUI](gui.md).

{% hint style="info" %}
**Note:** It is possible to set up external monitoring via Grafana. For more information, refer to [External Monitoring](../appendix/external-monitoring.md).
{% endhint %}
