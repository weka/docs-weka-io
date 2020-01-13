---
description: This page provides an overview of the WekaIO system CLI.
---

# CLI Overview

## Available Top-Level Commands

The WekaIO CLI is installed on each WekaIO host and is available through the `weka` command. Running this command will display a list of all available top-level commands:

```text
$ weka
Usage:
    weka [<args>...] [options]
    weka --agent

Description:
    Base command for all the weka related CLIs

The available subcommands are:
    status      Weka cluster status
    alerts      List and manage active alerts
    events      Commands for reading events and managing events settings
    stats       Commands for reading system statistics
    cluster     Commands that manage the cluster
    fs          Commands that manage filesystems, snapshots and filesystem-groups
    nfs         Commands that manage client-groups, permissions and interface-groups
    cloud       Cloud commands
    user        Manage users and login
    local       Commands that control weka and its containers on the local machine
    version     Commands that manager the installed weka versions on the host
    agent       Commands that control the weka agent (outside the weka containers)
    smb         Commands for setting up and managing smb shares and users
    diags       Commands for collecting weka-related diagnostics for support

Use 'weka --legal' for information about open-source libraries
Use 'weka <command> --help' for more help on a specific command
```

{% hint style="info" %}
**Note:** There are a number of options which are common to many commands:

`-J|--json`flag prints the raw JSON value returned by the cluster.

`-H|--hostname`flag directs the CLI to communicate with the cluster through the given host name.

`--raw-units` flag causes units such as capacity and bytes to be printed in their raw format, as returned by the cluster.

`--UTC` flag causes timestamps to be printed in the UTC timezone, rather than in the local time of the machine running the CLI command.

`-f|--format` flag specifies the format to output the result \(view, csv, markdown or JSON\)

 `-o|--output` flag specifies the columns of the output to be included. 

`-s|--sort` flag specifies the order to sort the output. May include a '+' or '-' before the column name to sort by ascending or descending order.

 `-F| --filter` flag specifies the filter values for a member \(without forcing it to be in the output\). 

 `--no-header` flag indicates that the column header should not be shown when printing the output.

`-C|--CONNECT-TIMEOUT` flag can be used to change the default timeout used for connecting to the system via the JRPC protocol. 

`-T|--TIMEOUT` flag  can be used to change the default timeout for which the commands waits for a response before giving up.
{% endhint %}

## Command Hierarchy

Most WekaIO system top-level commands are the default list command for their own collection. Additional sub-commands may be available under them.

{% hint style="success" %}
**For Example:** The `weka fs` command displays a list of all filesystems and is also the top-level command for all filesystems, filesystem groups and snapshot-related operations. It is possible to use the `-h`/`--help` flags or the `help` command to display a list of available commands at each level, as shown below:
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

Most WekaIO system commands deliver the same result on all cluster hosts. However, it is sometimes necessary to execute a command on a specific host. This is performed using the `-H`/`--hostname` option and specifying the host name or IP address of the target host.

## Cluster Status

The `weka status` command displays the overall status of the WekaIO system. 

{% hint style="success" %}
**For Example:** If the cluster is healthy, a result similar to the following should be displayed:
{% endhint %}

```text
$ weka status
Weka v3.1 (CLI build 17No144)

       status: OK (6 hosts healthy)
   protection: 3+2 (with 2 hot spares)
  ssd storage: 57 GiB total, 0 bytes free

        reads: 0 bytes/s (0 IO/s)
       writes: 0 bytes/s (0 IO/s)
```

{% hint style="success" %}
**For Example:** If the cluster has one failed host, a result similar to the following should be displayed:
{% endhint %}

```text
$ weka status
Weka v3.1 (CLI build 17No144)

       status: DEGRADED (1 host down, 5 hosts healthy)
               Rebuild in progress (3%)
   protection: 3+2 (with 2 hot spares)
  ssd storage: 42.75 GiB total, 0 bytes free

        reads: 0 bytes/s (0 IO/s)
       writes: 0 bytes/s (0 IO/s)
```



