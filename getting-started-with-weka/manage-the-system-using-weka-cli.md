---
description: >-
  This page provides an overview for Weka CLI, including the top-level commands,
  command hierarchy, how to connect to another server, auto-completion, and how
  to check the status of the cluster.
---

# Manage the system using the Weka CLI

The Weka CLI is installed on each Weka server and is available through the `weka` command. It's possible to connect to any of the servers using `ssh` and running the `weka` command. The `weka` command displays a list of all top-level commands.

## Top-level commands

The Weka CLI is installed on each Weka server and is available through the `weka` command. Running this command will display a list of all available top-level commands:

```
$ weka -h
Usage:
    weka [--help] [--build] [--version] [--legal]

Description:
    The base command for all weka-related CLIs

Subcommands:
   agent      Commands that control the weka agent (outside the weka containers)
   alerts     List alerts in the Weka cluster
   cloud      Cloud commands. List the cluster's cloud status, if no subcommand supplied.
   cluster    Commands that manage the cluster
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
   s3         Commands that manage Weka's S3 container

Options:
   --agent         Start the agent service
   -h, --help      Show help message
   --build         Prints the CLI build number and exits
   -v, --version   Prints the CLI version and exits
   --legal         Prints software license information and exits

```

The options that are common to many commands include:

| Option                  | Flag description                                                                                                                  |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `-J\|--json`            | Prints the raw JSON value returned by the cluster.                                                                                |
| `-H\|--hostname`        | Directs the CLI to communicate with the cluster through the specified hostname or IP.                                             |
| `--raw-units`           | Sets the units such as capacity and bytes to be printed in their raw format, as returned by the cluster.                          |
| `--UTC`                 | Sets the timestamps to be printed in UTC timezone, instead of the local time of the server running the CLI command.               |
| `-f\|--format`          | Specifies the format to output the result (view, csv, markdown, or JSON).                                                         |
| `-o\|--output`          | Specifies the columns to include in the output.                                                                                   |
| `-s\|--sort`            | Specifies the order to sort the output. May include a '+' or '-' before the column name to sort by ascending or descending order. |
| `-F\| --filter`         | Specifies the filter values for a member (without forcing it to be in the output).                                                |
| `--no-header`           | Indicates that the column header should not be shown when printing the output.                                                    |
| `-C\|--CONNECT-TIMEOUT` | Modifies the default timeout used for connecting to the system via the JRPC protocol.                                             |
| `-T\|--TIMEOUT`         | Modifies the default timeout for which the commands wait for a response before giving up.                                         |

## Commands hierarchy

Most Weka system top-level commands are the default list command for their own collection. Additional sub-commands may be available under them.

**Example:** The `weka fs` command displays a list of all filesystems and is also the top-level command for all filesystems, filesystem groups, and snapshot-related operations. It is possible to use the `-h`/`--help` flags or the `help` command to display a list of available commands at each level, as shown below:

```
$ weka fs
| FileSystem | Name    | Group   | SSD Bu | Total  | Is re | Is creat | Is remov 
|  ID        |         |         | dget   | Budget | ady   | ing      | ing      
+------------+---------+---------+--------+--------+-------+----------+----------
| FSId: 0    | default | default | 57 GiB | 57 GiB | True  | False    | False
```

```
$ weka fs -h
Usage:
    weka fs [--name name]
            [--HOST HOST]
            [--PORT PORT]
            [--CONNECT-TIMEOUT CONNECT-TIMEOUT]
            [--TIMEOUT TIMEOUT]
            [--format format]
            [--output output]...
            [--sort sort]...
            [--filter filter]...
            [--capacities]
            [--force-fresh]
            [--help]
            [--raw-units]
            [--UTC]
            [--no-header]
            [--verbose]

Description:
    List filesystems defined in this Weka cluster

Subcommands:
   create     Create a filesystem
   download   Download a filesystem from object store
   update     Update a filesystem
   delete     Delete a filesystem
   restore    Restore filesystem content from a snapshot
   quota      Commands used to control directory quotas
   group      List filesystem groups
   snapshot   List snapshots
   tier       Show object store connectivity for each node in the cluster
   reserve    Thin provisioning reserve for organizations

Options:
   --name                  Filesystem name
   -H, --HOST              Specify the host. Alternatively, use the WEKA_HOST env variable
   -P, --PORT              Specify the port. Alternatively, use the WEKA_PORT env variable
   -C, --CONNECT-TIMEOUT   Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w,
                           infinite/unlimited)
   -T, --TIMEOUT           Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w,
                           infinite/unlimited)
   -f, --format            Specify in what format to output the result. Available options are:
                           view|csv|markdown|json|oldview (format: 'view', 'csv', 'markdown', 'json' or 'oldview')
   -o, --output            Specify which columns to output. May include any of the following:
                           uid,id,name,group,usedSSD,usedSSDD,usedSSDM,freeSSD,availableSSDM,availableSSD,usedTotal,usedTotalD,freeTotal,availableTotal,maxFiles,status,encrypted,stores,auth,thinProvisioned,thinProvisioningMinSSDBugdet,thinProvisioningMaxSSDBugdet,usedSSDWD,usedSSDRD
   -s, --sort              Specify which column(s) to take into account when sorting the output. May include a '+' or
                           '-' before the column name to sort in ascending or descending order respectively. Usage:
                           [+|-]column1[,[+|-]column2[,..]]
   -F, --filter            Specify what values to filter by in a specific column. Usage:
                           column1=val1[,column2=val2[,..]]
   --capacities            Display all capacity columns
   --force-fresh           Refresh the capacities to make sure they are most updated
   -h, --help              Show help message
   -R, --raw-units         Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in
                           human-readable format, e.g 1KiB 234MiB 2GiB.
   -U, --UTC               Print times in UTC. When not set, times are converted to the local time of this host.
   --no-header             Don't show column headers when printing the output
   -v, --verbose           Show all columns in output

```

## Connect to another server

Most Weka system commands deliver the same result on all cluster servers. However, it is sometimes necessary to execute a command on a specific server. This is performed using the `-H`/`--hostname` option and specifying the hostname or IP address of the target server.

## CLI auto-completion

Using `bash` you can use auto-completion for CLI commands and parameters. The auto-completion script is automatically installed.

To disable the auto-completion script, run `weka agent autocomplete uninstall`

To (re-)install the script on a server, run `weka agent autocomplete install` and re-enter your shell session.

You can also use `weka agent autocomplete export`to get the bash completions script and write it to any desired location.

## Cluster status

The `weka status` command displays the overall status of the Weka system.

**Example: status of a healthy system**

```
$ weka status
WekaIO v4.1.0 (CLI build 4.1.0)

       cluster: wekaprod (a5d41195-a9b2-4668-914a-77c175f4cfb4)
        status: OK (8 backends UP, 48 drives UP)
    protection: 6+2
     hot spare: 1 failure domains (1.23 TiB)
 drive storage: 82.94 TiB total
         cloud: connected
       license: OK, valid thru 2022-10-20T06:23:01Z

     io status: STARTED 2 hours ago (8 io-nodes UP, 80 Buckets UP)
    link layer: Ethernet
       clients: 1 connected
         reads: 0 B/s (0 IO/s)
        writes: 512 B/s (60 IO/s)
    operations: 9 ops/s
        alerts: none
```

**Example: status of a system with one backend failure (DEGRADED)**

```
   $ weka status
WekaIO v4.1.0 (CLI build 4.1.0)

       cluster: WekaProd (b231e060-c5c1-421d-a68d-1dfa94ff149b)
        status: DEGRADED (7 backends UP, 42 drives UP)
    protection: 6+2
     hot spare: 1 failure domains (1.23 TiB)
 drive storage: 82.94 TiB total
         cloud: connected
       license: OK, valid thru 2022-10-20T06:23:01Z

     io status: STARTED 2 hours (8 io-nodes UP, 80 Buckets UP)
                Rebuild in progress (3%)
    link layer: Ethernet
       clients: 0 connected
         reads: 0 B/s (0 IO/s)
        writes: 0 B/s (0 IO/s)
    operations: 0 ops/s
        alerts: none
```
