---
description: >-
  This page describes the diagnostics CLI commands used for collecting and
  uploading the diagnostics data.
---

# Diagnostics data management

The diagnostics CLI command is used for collecting and uploading diagnostic data about clusters, servers, and containers for analysis by the Customer Success Team to help troubleshoot. There are two relevant commands:

* `weka diags`: Run this command to get cluster-wide diagnostics from any server in the cluster.  The command includes two options: `upload` and `collect` (described in the following sections).
* `weka local diags`: Run this command to get diagnostics on a specific server when it cannot connect to the cluster.&#x20;

The `weka local diags` command is useful in the following situations:

* No functioning management process in the originating backend server or the specified backend servers.
* No connectivity between the management process and the cluster leader.
* The cluster has no leader.
* The local container is down.
* The server cannot reach the leader, or a remote server fails to respond to the `weka diags` remote command.

## Upload diagnostics to Weka Home

**Command:** `weka diags upload`

Use the following command to collect diagnostics information, save it, and upload it to Weka Home (the Weka support cloud):

`weka diags upload [--timeout timeout] [--core-limit core-limit] [--dump-id dump-id] [--container-id container-id]... [--clients]`

The command response provides an access identifier, `Diags collection ID`. Send this access identifier to the Customer Success Team for retrieving the information from the Weka Home.

When running the command for all servers in the cluster, a local diagnostics file is created in each server in the location `/opt/weka/diags/local`. The local diagnostics file of each server is consolidated in a single diagnostics file in the server where you run the command in the `/opt/weka/diags` directory.

{% hint style="info" %}
**Notes:**

* HTTPS access is required to upload the diagnostics to AWS S3 endpoints.
* The upload process is asynchronous. Therefore, connectivity failure events are reflected in the events log even if the command exits successfully.
{% endhint %}

<details>

<summary>Example: collect and upload diagnostics from the whole cluster</summary>

```
[root@wekaprod-0 ~] 2023-02-20 13:39:25 $ weka diags upload
Uploading diags from 5 hosts to the cloud
Cluster GUID: c0aca0f2-0d20-465e-9817-e747be811016
Diags collection ID: 1Ox5OYogdTP54Nah7o1cb
Cloud URL: https://api.home.weka.io

Collecting diags                             [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■] 5 / 5
Copying files for uploading                  [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■] 5 / 5
Uploading to cloud (this could take a while) [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■] 125 / 125


+------------------------+
| Diags upload completed |
+------------------------+
```

</details>

**Parameters**

| **Name**       | **Type**                        | **Value**                                                                  | **Limitations**                                              | **Mandatory** | **Default**                                      |
| -------------- | ------------------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------------ | ------------- | ------------------------------------------------ |
| `timeout`      | String                          | The maximum time available for uploading the diagnostics.                  | <p>Format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p> | No            | 10 minutes                                       |
| `core-limit`   | Number                          | Limit the diagnostics collection process to use the specified core number. |                                                              | No            | 1                                                |
| `dump-id`      | String                          | The ID of an existing diagnostics file (dump) to upload.                   | This dump ID has to exist on this local server               | No            | If an ID is not specified, a new dump is created |
| `container-id` | Comma-separated list of numbers | The container IDs to collect diagnostics from.                             | This flag causes `--clients` to be ignored                   | No            | All containers                                   |
| `clients`      | Boolean                         | Collect the diagnostics also from the clients.                             |                                                              | No            | No                                               |

## Collect diagnostics

**Command:** `weka diags collect`

Use the following command to create diagnostics information and save it without uploading it to Weka Home. This command is useful when there is no connection to Weka Home, and you want to share the diagnostics file using other options.

`weka diags collect [--id id] [--timeout timeout] [--output-dir output-dir] [--core-limit core-limit] [--container-id container-id] [--clients] [--backends] [--tar]`

If the command runs with the `local` keyword, information is collected only from the server on which the command is executed. Otherwise, information is collected from the whole cluster.&#x20;

<details>

<summary>Example: collect diagnostics from the whole cluster</summary>

```
[root@wekaprod-0 ~] 2023-02-20 13:38:58 $ weka diags collect
Downloading cluster diagnostics from 5 hosts to this host
Diags will be saved to: /opt/weka/diags/ody2uRl8xOfDESd6vkbYH4

Collecting diags      [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■] 5 / 5
Downloading artifacts [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■] 46.43 MiB / 46.43 MiB

CATEGORY   DIAG                       H0  H1  H2  H3  H4
host       uptime                     ●   ●   ●   ●   ●
host       date                       ●   ●   ●   ●   ●
host       uname                      ●   ●   ●   ●   ●
host       top                        ●   ●   ●   ●   ●
host       free_hugepages             ●   ●   ●   ●   ●
host       nr_hugepages               ●   ●   ●   ●   ●
host       nr_hugepages_mempolicy     ●   ●   ●   ●   ●
host       nr_overcommit_hugepages    ●   ●   ●   ●   ●
host       surplus_hugepages          ●   ●   ●   ●   ●
host       meminfo                    ●   ●   ●   ●   ●
host       cpuinfo                    ●   ●   ●   ●   ●
host       netstat                    ●   ●   ●   ●   ●
host       etc-hosts                  ●   ●   ●   ●   ●
host       ps                         ●   ●   ●   ●   ●
host       mount                      ●   ●   ●   ●   ●
host       rpcinfo                    ●   ●   ●   ●   ●
host       kernel_modules             ●   ●   ●   ●   ●
host       pci_devices                ●   ●   ●   ●   ●
host       pci_tree                   ●   ●   ●   ●   ●
host       ip_links                   ●   ●   ●   ●   ●
host       ip_routes                  ●   ●   ●   ●   ●
host       arp_table                  ●   ●   ●   ●   ●
host       iptables                   ●   ●   ●   ●   ●
host       resolv.conf                ●   ●   ●   ●   ●
host       root_disk_usage            ●   ●   ●   ●   ●
host       dmesg                      ●   ●   ●   ●   ●
host       dmidecode                  ●   ●   ●   ●   ●
host       network_manager            X   X   X   X   X
host       selinux                    ●   ●   ●   ●   ●
host       fstab                      ●   ●   ●   ●   ●
host       journalctl                 ●   ●   ●   ●   ●
host       systemctl                  ●   ●   ●   ●   ●
host       ip4addr                    ●   ●   ●   ●   ●
host       ip4link                    ●   ●   ●   ●   ●
host       syslog                     ●   ●   ●   ●   ●
host       boot_log                   -   -   -   -   -
host       ofed-version               -   -   -   -   -
host       ofed                       -   -   -   -   -
host       mlnx4_core                 -   -   -   -   -
host       mlnx5_core                 -   -   -   -   -
host       memtest                    ●   ●   ●   ●   ●
host       is-numa-balancing-active   ●   ●   ●   ●   ●
host       is-swap-on                 ●   ●   ●   ●   ●
host       lsblk                      ●   ●   ●   ●   ●
host       system-release             ●   ●   ●   ●   ●
host       os-release                 ●   ●   ●   ●   ●
host       lsb-release                -   -   -   -   -
host       redhat-release             ●   ●   ●   ●   ●
host       lscpu                      ●   ●   ●   ●   ●
host       ifconfig                   ●   ●   ●   ●   ●
host       ip_rule                    ●   ●   ●   ●   ●
host       weka_local_status          ●   ●   ●   ●   ●
weka_host  container_list             ●   ●   ●   ●   ●
weka_host  lstopo                     ●   ●   ●   ●   ●
weka_host  numactl                    ●   ●   ●   ●   ●
weka_host  ipmi-sel                   ●   ●   ●   ●   ●
weka_host  ipmi-sdr                   ●   ●   ●   ●   ●
weka_host  logs                       ●   ●   ●   ●   ●
weka_host  driver_queue               ●   ●   ●   ●   ●
weka_host  local_events               ●   ●   ●   ●   ●
weka_host  traces_analysis            ●   ●   ●   ●   ●
weka_host  resources_files            ●   ●   ●   ●   ●
weka_host  core_dumps                 ●   ●   ●   ●   ●
cluster    api-status                 ●
cluster    api-alerts                 ●
cluster    api-realtime_stats         ●
cluster    api-hosts                  ●
cluster    api-nodes                  ●
cluster    api-drives                 ●
cluster    api-failure_domains        ●
cluster    api-host_hardware          ●
cluster    api-filesystems            ●
cluster    api-filesystem_groups      ●
cluster    api-snapshots              ●
cluster    api-tiering                ●
cluster    api-users                  ●
cluster    api-default_data_net       ●
cluster    api-nfs_client_groups      ●
cluster    api-nfs_interface_groups   ●
cluster    api-nfs_permissions        ●
cluster    api-nfs_status             ●
cluster    cli-status                 ●
cluster    cli-filesystems            ●
cluster    cli-host                   ●
cluster    cli-net                    ●
cluster    cli-nodes                  ●
cluster    cli-drives                 ●
cluster    cli-buckets                ●
cluster    cli-cluster-tasks          ●
cluster    cli-alerts                 ●
cluster    cli-rebuild_status         ●
cluster    cli-filesystem_groups      ●
cluster    cli-kms                    ●
cluster    cli-fs_tier_s3             ●
cluster    cli-org                    ●
cluster    cli-realtime_stats         ●
cluster    cli-smb                    ●
cluster    cli-smb-cluster-status     ●
cluster    cli-smb-domain             ●
cluster    cli-smb-share              ●
cluster    cli-smb-share-lists-show   ●
cluster    cli-cloud                  ●
cluster    cli-buckets-dist           ●
cluster    cli-net-links              ●
cluster    cli-blacklist-list         ●
cluster    cli-manual-overrides-list  ●
cluster    cli-traces-status          ●
cluster    cli-traces-freeze          ●
cluster    cli-s3-cluster             ●
cluster    cli-s3-cluster-status      ●
cluster    cli-s3-bucket-list         -
cluster    cli-config-list-overrides  ●
cluster    api-cfgdump                ●
report     summary                    ●   ●   ●   ●   ●
report     errors                     ●   ●   ●   ●   ●

The following errors were found:

   h0:
      network_manager:
         - The NetworkManager service is running on this host, it must be turned off for weka to run properly

   h1:
      network_manager:
         - The NetworkManager service is running on this host, it must be turned off for weka to run properly

   h2:
      network_manager:
         - The NetworkManager service is running on this host, it must be turned off for weka to run properly

   h3:
      network_manager:
         - The NetworkManager service is running on this host, it must be turned off for weka to run properly

   h4:
      network_manager:
         - The NetworkManager service is running on this host, it must be turned off for weka to run properly
```

</details>

**Parameters**

| **Name**       | **Type** | **Value**                                                                      | **Limitations**                                                            | **Mandatory** | **Default**       |
| -------------- | -------- | ------------------------------------------------------------------------------ | -------------------------------------------------------------------------- | ------------- | ----------------- |
| `id`           | String   | Specified ID for this diagnostics file.                                        |                                                                            | No            | Auto-generated    |
| `timeout`      | String   | The maximum time available for collecting diagnostics from all servers.        | <p>Format: 3s, 2h, 4m, 1d, 1d5h, 1w </p><p>0 is infinite</p>               | No            | 10 minutes        |
| `output-dir`   | String   | The directory for saving the diagnostics file.                                 |                                                                            | No            | `/opt/weka/diags` |
| `core-limit`   | Number   | Limit the diagnostics collection process to use the specified core number.     |                                                                            | No            | 1                 |
| `container-id` | Number   | The container IDs to collect diagnostics from. It can be used multiple times.  | If set, the system ignores the `--clients` value                           | No            |                   |
| `clients`      | Boolean  | Collect the diagnostics also from the clients.                                 | If `container-id` is set, the system ignores the `clients` value           | No            | No                |
| `backends`     | Boolean  | Collect the diagnostics from all backend containers and clients.               | Use it combined with `--clients` to collect from all backends and clients. | No            | No                |
| `tar`          | Boolean  | Package the collected diagnostics in a TAR file.                               |                                                                            | No            | No                |

## Clean up the diagnostic files

When you collect diagnostics data using `weka diags collect`, it creates a separate diagnostic file that consumes disk space. Therefore, the system may end up with many diagnostic files that are no longer required, for example, after uploading the diagnostic file to Weka Home. You can clean up a specified diagnostic file or a directory with multiple diagnostic files to free up space from the disk.

First, list the diagnostic files in the system and their IDs, then delete the specific diagnostic file according to its ID.

{% hint style="danger" %}
**Warning:** The diagnostic files are essential for troubleshooting purposes. Only delete these files if you are sure they are already uploaded to Weka Home and are no longer required. If you need clarification, contact the [Customer Success Team](../getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### List the diagnostic files

**Command:** `weka diags list`

Use the following command to list the collected diagnostic files:

`weka diags list [--verbose] [<id>]...`

**Parameters**

| **Name**  | **Type** | **Value**                                                                                                                                                                            | **Limitations** | **Mandatory** | **Default**   |
| --------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------- | ------------- | ------------- |
| `id`      | String   | <p>The ID of the diagnostic file (dump) to display or a path to the location of the diagnostic files.<br>A list of all the collected diagnostic files is shown if not specified.</p> |                 | No            | Not specified |
| `verbose` | Boolean  | Displays the results of all the diagnostic files, including the successful ones.                                                                                                     |                 | No            |               |

### Delete a diagnostic file

**Command:** `weka diags rm`

Use the following command to stop a running diagnostics instance, cancel its upload, and delete it from the disk:

`weka diags rm [--all] [<id>]...`

**Parameters**

| **Name** | **Type** | **Value**                                                                                                                                                                           | **Limitations** | **Mandatory**                              | **Default** |
| -------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- | ------------------------------------------ | ----------- |
| `all`    | Boolean  | Delete all the diagnostic files.                                                                                                                                                    |                 | No                                         |             |
| `id`     | String   | <p>The ID of the diagnostic file (dump) to delete or a path to the location of the diagnostic files.<br>A list of all the collected diagnostic files is shown if not specified.</p> |                 | Yes, if the option `all` is not specified. |             |
