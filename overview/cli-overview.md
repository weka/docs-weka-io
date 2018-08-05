---
description: This page is an overview of the WekaIO system CLI.
---

# About the CLI

## Available Top-Level Commands

The WekaIO CLI is installed on each WekaIO host and is available through the `weka` command. Running this command will display a list of all available top-level commands:

```text
$ weka
usage: weka <command>

The most commonly used commands are:
    status      Weka cluster status
    events      Commands for reading events and managing events settings
    stats       Commands for reading system statistics
    cluster     Commands that manage the cluster
    fs          Commands that manage filesystems, snapshots and filesystem-groups
    nfs         Commands that manage client-groups, permissions and interface-groups
    cloud       Cloud commands
    local       Control the local weka application: start, stop, status
    user        Manage users & login

Options:
     -h, --help                         Display help
     --help-syntax                      Display help on the syntax of the switches
     -H=<hostname> ,--host=<hostname>   Specify the host. Alternatively, use the $WEKA_HOST env variable
     -J, --json                         Format output as JSON
     --server-timezone                  Use the server's timezone instead of the local one
     --raw-units                        Print sizes in Bytes. When not set, sizes are printed in human readable format, e.g 1KiB 234MiB 2GiB.

See 'weka <command> --help' for more help on a specific command
```

## Command Hierarchy

Most WekaIO system top-level commands are the default list command for their own collection. Additional sub-commands may be available under them.

{% hint style="warning" %}
**For Example:** The `weka fs` command displays a list of all filesystems and is also the top-level command for all filesystem, filesystem group and snapshot-related operations. It is possible to use the `-h`/`--help` flags or the `help` command to display a list of available commands at each level, as shown below:
{% endhint %}

```text
$ weka fs
| FileSystem | Name    | Group   | SSD Bu | Total  | Is re | Is creat | Is remov 
|  ID        |         |         | dget   | Budget | ady   | ing      | ing      
+------------+---------+---------+--------+--------+-------+----------+----------
| FSId: 0    | default | default | 57 GiB | 57 GiB | True  | False    | False
```

```text
$ weka fs -h
Description:
    Commands that manage filesystems, snapshots and filesystem-groups.
    weka fs:    List the system's filesystems

Usage:
    weka fs [--name=<name>]
    weka fs info [--filesystem=<name>]...
    weka fs create <name> <group-name> <total-capacity> [--ssd-capacity=<ssd>] [--filesystem-id=<id>]
    weka fs update <name> [--new-name=<new-name>] [--total-capacity=<total>] [--ssd-capacity=<ssd>]
    weka fs delete <name>
    weka fs restore <file-system> <source-name>
    weka fs <command> [<args>...] [options]

Available subcommands:
    group                   Commands that manage filesystem-groups
    snapshot                Commands that manage snapshots
    tier                    Commands that fs tiering
    capacity-events         Commands that define & manage events alerts capacity

See 'weka fs <command> --help' for more help on a specific command
```

## Connecting to Another Host

Most WekaIO system commands deliver the same result on all cluster hosts. However, sometimes it is necessary to execute a command on a specific host. This is performed using the `-H`/`--hostname` option and specifying the host name or IP address of the target host.

## Cluster Status

The `weka status` command displays the overall status of the WekaIO system. 

{% hint style="warning" %}
**For Example:** If the cluster is healthy, a result similar to the following should be displayed:
{% endhint %}

```bash
$ weka status
Weka v3.1 (CLI build 17No144)

       status: OK (6 hosts healthy)
   protection: 3+2 (with 2 hot spares)
  ssd storage: 57 GiB total, 0 bytes free

        reads: 0 bytes/s (0 IO/s)
       writes: 0 bytes/s (0 IO/s)
```

{% hint style="warning" %}
**For Example:** If the cluster has one failed host, a result similar to the following should be displayed:
{% endhint %}

```bash
$ weka status
Weka v3.1 (CLI build 17No144)

       status: DEGRADED (1 host down, 5 hosts healthy)
               Rebuild in progress (3%)
   protection: 3+2 (with 2 hot spares)
  ssd storage: 42.75 GiB total, 0 bytes free

        reads: 0 bytes/s (0 IO/s)
       writes: 0 bytes/s (0 IO/s)
```



