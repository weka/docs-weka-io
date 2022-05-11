---
description: >-
  This page provides an overview for Weka CLI, including the top-level commands,
  command hierarchy, how to connect to another host, auto-completion, and how to
  check the status of the cluster.
---

# Manage the system using Weka CLI

The Weka CLI is installed on each Weka host and is available through the `weka` command. It's possible to`ssh` one of the hosts and run the `weka` command. This displays a list of all available top-level commands.

## Top-level commands

The Weka CLI is installed on each Weka host and is available through the `weka` command. Running this command will display a list of all available top-level commands:

```
$ weka -h
Usage:
    weka [--help] [--build] [--version] [--legal]

Description:
    The base command for all weka related CLIs

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

{% hint style="info" %}
**Note:** There are a number of options which are common to many commands:

`-J|--json`flag prints the raw JSON value returned by the cluster.

`-H|--hostname`flag directs the CLI to communicate with the cluster through the given hostname.

`--raw-units` flag causes units such as capacity and bytes to be printed in their raw format, as returned by the cluster.

`--UTC` flag causes timestamps to be printed in the UTC timezone, rather than in the local time of the machine running the CLI command.

`-f|--format` flag specifies the format to output the result (view, csv, markdown, or JSON)

`-o|--output` flag specifies the columns of the output to be included.

`-s|--sort` flag specifies the order to sort the output. May include a '+' or '-' before the column name to sort by ascending or descending order.

`-F| --filter` flag specifies the filter values for a member (without forcing it to be in the output).

`--no-header` flag indicates that the column header should not be shown when printing the output.

`-C|--CONNECT-TIMEOUT` flag can be used to change the default timeout used for connecting to the system via the JRPC protocol.

`-T|--TIMEOUT` flag can be used to change the default timeout for which the commands waits for a response before giving up.
{% endhint %}

## Command hierarchy

Most Weka system top-level commands are the default list command for their own collection. Additional sub-commands may be available under them.

{% hint style="success" %}
**For Example:** The `weka fs` command displays a list of all filesystems and is also the top-level command for all filesystems, filesystem groups, and snapshot-related operations. It is possible to use the `-h`/`--help` flags or the `help` command to display a list of available commands at each level, as shown below:
{% endhint %}

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
            [--help]
            [--raw-units]
            [--UTC]
            [--no-header]
            [--verbose]
            [--json]

Description:
    List filesystems defined in this Weka cluster

Subcommands:
   create     Create a filesystem
   download   Download a filesystem from object store
   update     Update a filesystem
   delete     Delete a filesystem
   restore    Restore filesystem content from a snapshot
   group      List filesystem groups
   snapshot   List snapshots
   tier       Show object storage connectivity for each node in the cluster

Options:
   --name                  Filesystem name
   -H, --HOST              Specify the host. Alternatively, use the WEKA_HOST env variable
   -P, --PORT              Specify the port. Alternatively, use the WEKA_PORT env variable
   -C, --CONNECT-TIMEOUT   Timeout for connecting to cluster, default: 10 secs (format: 3s, 2h, 4m, 1d, 1d5h, 1w)
   -T, --TIMEOUT           Timeout to wait for response, default: 1 minute (format: 3s, 2h, 4m, 1d, 1d5h, 1w)
   -f, --format            Specify in what format to output the result. Available options are:
                           view|csv|markdown|json|oldview (format: 'view', 'csv', 'markdown', 'json' or 'oldview')
   -o, --output            Specify which columns to output. May include any of the following:
                           id,name,group,usedSSDD,usedSSDM,usedSSD,freeSSD,availableSSDM,availableSSD,usedTotalD,usedTotal,freeTotal,availableTotal,maxFiles,status,encrypted,stores,auth
   -s, --sort              Specify which column(s) to take into account when sorting the output. May include a '+' or
                           '-' before the column name to sort in ascending or descending order respectively. Usage:
                           [+|-]column1[,[+|-]column2[,..]]
   -F, --filter            Specify what values to filter by in a specific column. Usage:
                           column1=val1[,column2=val2[,..]]
   -h, --help              Show help message
   -R, --raw-units         Print values in raw units (bytes, seconds, etc.). When not set, sizes are printed in
                           human-readable format, e.g 1KiB 234MiB 2GiB.
   -U, --UTC               Print times in UTC. When not set, times are converted to the local time of this host.
   --no-header             Don't show column headers when printing the output
   -v, --verbose           Show all columns in output

```

## Connect to another host

Most Weka system commands deliver the same result on all cluster hosts. However, it is sometimes necessary to execute a command on a specific host. This is performed using the `-H`/`--hostname` option and specifying the hostname or IP address of the target host.

## CLI auto-completion

Using `bash` you can use auto-completion for CLI commands and parameters. The auto-completion script is automatically installed.

To disable the auto-completion script, run `weka agent autocomplete uninstall`

To (re-)install the script on a host, run `weka agent autocomplete install` and re-enter your shell session.

You can also use `weka agent autocomplete export` to get the bash completions script and write it to any desired location.

## Cluster status

The `weka status` command displays the overall status of the Weka system.

{% hint style="success" %}
**For Example:** If the cluster is healthy, a result similar to the following should be displayed:
{% endhint %}

```
$ weka status
WekaIO v3.10.0 (CLI build 3.10.0)

       cluster: WekaProd (00569cef-5679-4e1d-afe5-7e82748887de)
        status: OK (8 backends UP, 48 drives UP)
    protection: 6+2
     hot spare: 1 failure domains
 drive storage: 82.94 TiB total, 82.94 TiB unprovisioned
```

{% hint style="success" %}
**For Example:** If the cluster has one failed host, a result similar to the following should be displayed:
{% endhint %}

```
$ weka status
WekaIO v3.10.0 (CLI build 3.10.0)

       cluster: WekaProd (00569cef-5679-4e1d-afe5-7e82748887de)
        status: DEGRADED (7 backends UP, 42 drives UP)
                Rebuild in progress (3%)
    protection: 6+2
     hot spare: 1 failure domains
 drive storage: 82.94 TiB total, 82.94 TiB unprovisioned
```
