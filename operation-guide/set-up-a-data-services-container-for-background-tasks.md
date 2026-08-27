---
description: >-
  Configure a Data Services container to run quota coloring and S3 lifecycle
  background tasks.
---

# Set up a Data Services container for background tasks

The Data Services container runs tasks in the background, particularly those that can be resource-intensive. It runs the [Quota Coloring](#user-content-fn-1)[^1] task and the [S3 lifecycle management](#user-content-fn-2)[^2] tasks.

Running these tasks in the background ensures your CLI remains accessible and responsive without consuming compute resources. This strategy enhances performance, efficiency, and scalability when managing quotas and S3 lifecycle rules. If a task is interrupted, it automatically resumes, providing reliability.

{% hint style="warning" %}
If the Data Services container is not operational, the quota coloring task reverts to the previous implementation and runs in a single process. This could result in the CLI hanging for an extended period. Therefore, ensuring the Data Services container runs is crucial to prevent this situation.
{% endhint %}

To improve data service performance, you can set up multiple Data Service containers, one per WEKA server.

After setting up the Data Service container, you can manage it like any other container within the cluster. If there’s a need to adjust its resources, use the `weka cluster container resources` or `weka local resources` commands. For more details, see [expansion-of-specific-resources.md](expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md "mention").

## **Set up Data Services container**

**Before you begin**

1. Ensure the server where you’re adding this container has sufficient memory available:
   * 3.5 GB if no dedicated core is specified.
   * 5.5 GB if a dedicated core is specified.
2. The Data Service containers require a persistent 22 GB filesystem for intermediate global configuration data. Do one of the following:
   * If a configuration filesystem for the protocol containers exists (typically named `.config_fs`), use it and expand its size by 22 GB. See [#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations](../additional-protocols/additional-protocols-overview.md#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations "mention")
   * If a configuration filesystem does not exist, create a dedicated 22 GB configuration filesystem for the Data Service containers.
3. Set the Data Service global configuration. Run the following command:

```
weka dataservice global-config set --config-fs <configuration filesystem name>
```

Example:

```
weka dataservice global-config set --config-fs .config_fs
```

{% hint style="info" %}
By default, the Data Service containers share the core of the Management process. However, if you have enough resources, you can assign a separate core to it.
{% endhint %}

**Procedure**

1. **Set up the Data Services container:** Run the following command:

{% code overflow="wrap" %}
```bash
weka local setup container --name <container_name> --base-port <base-port> --join-ips <management-ip> --only-dataserv-cores --allow-mix-setting
```
{% endcode %}

**Parameters:**

<table><thead><tr><th width="214.4921875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The Data Services container name. Set <code>dataserv0</code> to avoid confusion.</td></tr><tr><td><code>only-dataserv-cores</code>*</td><td>Creates a Data Services container. This parameter is mandatory.</td></tr><tr><td><code>base-port</code></td><td>If a base-port is not specified, the Data Services container may still initialize as it attempts to allocate an available port range and could succeed. However, for optimal operation, it is recommended to provide the base port externally.</td></tr><tr><td><code>join-ips</code>*</td><td>Specify the management IP of one of the servers in the cluster to join.</td></tr><tr><td><code>management-ips</code></td><td>This is optional. If not provided, it automatically takes the management IP of the server.</td></tr><tr><td><code>memory</code></td><td>Configure the container memory to be allocated for huge pages. It is recommended to set it to 1.5 GB.</td></tr><tr><td><code>allow-mix-setting</code></td><td>This option enables using specified core IDs, even when containers with AUTO core ID allocation run on the same server. It is required if the core allocation is not explicitly specified.</td></tr></tbody></table>

<details>

<summary>Example</summary>

{% code overflow="wrap" %}
```bash
$ weka local setup container --name dataserv0 --base-port 14400 --join-ips 10.108.233.213 --only-dataserv-cores --allow-mix-setting
Version 6.0.0 is already downloaded.
Created Weka container named dataserv0
Preparing version 6.0.0 of container dataserv0
No net parameter specified, configuring in UDP mode
Successfully set up container dataserv0
Starting container
Waiting for container to start up
Container "dataserv0" is ready (pid = 84273)
```
{% endcode %}

</details>

2. **Verify the Data Services container is up**: Run `weka local ps`.

<details>

<summary>Example</summary>

```bash
$ weka local ps
Container  Container ID  State    Disabled    Uptime  Persistent   Port    PID  Status  Version  Recent Failure (5 min)  Container Type
compute0              9  Running    False   0:33:17h     True     14300  16944  Ready   6.0.0                            weka
dataserv0            19  Running    False   0:06:35h     True     14400  84273  Ready   6.0.0                            weka
drives0               0  Running    False   0:34:50h     True     14000  15943  Ready   6.0.0                            weka
frontend0            17  Running    False   0:33:07h     True     14200  17453  Ready   6.0.0                            weka
smbw                N/A  Running    False   0:30:42h     True     14000  18612          6.0.0                            smbw
```

</details>

3. **Verify the Data Services container is visible in the cluster:** Run `weka cluster container`.

<details>

<summary>Example</summary>

See `dataserv0` in the last row (ID 19).

```bash
$ weka cluster container
ID  Hostname                   Name       IPs             Status  Requested Action  Release Failure Domain  Cores    Memory    Uptime  Recent Failure (5 min)  Requested Action Failure
 0  DataSphere-0               drives0    10.108.233.213  UP      NONE              6.0.0   DOM-000             1  1.46 GiB  0:35:19h
 1  DataSphere-1               drives0    10.108.111.114  UP      NONE              6.0.0   DOM-001             1  1.46 GiB  0:35:21h
 2  DataSphere-2               drives0    10.108.190.195  UP      NONE              6.0.0   DOM-002             1  1.46 GiB  0:35:20h
 3  DataSphere-3               drives0    10.108.220.165  UP      NONE              6.0.0   DOM-003             1  1.46 GiB  0:35:20h
 4  DataSphere-4               drives0    10.108.107.173  UP      NONE              6.0.0   DOM-004             1  1.46 GiB  0:35:18h
 5  DataSphere-5               drives0    10.108.176.219  UP      NONE              6.0.0   DOM-005             1  1.46 GiB  0:35:17h
 6  DataSphere-3               compute0   10.108.220.165  UP      NONE              6.0.0   DOM-003             1  1.41 GiB  0:33:47h
 7  DataSphere-5               compute0   10.108.176.219  UP      NONE              6.0.0   DOM-005             1  1.41 GiB  0:33:46h
 8  DataSphere-4               compute0   10.108.107.173  UP      NONE              6.0.0   DOM-004             1  1.41 GiB  0:33:46h
 9  DataSphere-0               compute0   10.108.233.213  UP      NONE              6.0.0   DOM-000             1  1.41 GiB  0:33:45h
10  DataSphere-1               compute0   10.108.111.114  UP      NONE              6.0.0   DOM-001             1  1.41 GiB  0:33:46h
11  DataSphere-2               compute0   10.108.190.195  UP      NONE              6.0.0   DOM-002             1  1.41 GiB  0:33:45h
12  DataSphere-1               frontend0  10.108.111.114  UP      NONE              6.0.0   DOM-001             1  1.38 GiB  0:33:38h
13  DataSphere-2               frontend0  10.108.190.195  UP      NONE              6.0.0   DOM-002             1  1.38 GiB  0:33:37h
14  DataSphere-3               frontend0  10.108.220.165  UP      NONE              6.0.0   DOM-003             1  1.38 GiB  0:33:37h
15  DataSphere-4               frontend0  10.108.107.173  UP      NONE              6.0.0   DOM-004             1  1.38 GiB  0:33:37h
16  DataSphere-5               frontend0  10.108.176.219  UP      NONE              6.0.0   DOM-005             1  1.38 GiB  0:33:37h
17  DataSphere-0               frontend0  10.108.233.213  UP      NONE              6.0.0   DOM-000             1  1.38 GiB  0:33:35h
18  DataSphere-LinuxClients-6  default    10.108.169.39   UP      NONE              6.0.0                       1  1.38 GiB  0:31:32h
19  DataSphere-0               dataserv0  10.108.233.213  UP      NONE              6.0.0                       0       N/A  0:07:03h
```

</details>

4. **Verify the data services and management processes have joined the cluster:** Run `weka cluster process`.

<details>

<summary>Example</summary>

See PROCESS IDs 380 and 381.

```bash
$ weka cluster process
Process  Container ID  Slot  Hostname                   Container  IPs             Status  Release  Roles       Network  CPU    Memory    Uptime  Recent Failure (5 min)
      0             0     0  DataSphere-0               drives0    10.108.233.213  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:35:23h
      1             0     1  DataSphere-0               drives0    10.108.62.198   UP      6.0.0    DRIVES      DPDK       4  1.46 GiB  0:35:19h
     20             1     0  DataSphere-1               drives0    10.108.111.114  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:35:15h
     21             1     1  DataSphere-1               drives0    10.108.93.124   UP      6.0.0    DRIVES      DPDK       4  1.46 GiB  0:35:10h
     40             2     0  DataSphere-2               drives0    10.108.190.195  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:35:15h
     41             2     1  DataSphere-2               drives0    10.108.217.168  UP      6.0.0    DRIVES      DPDK       4  1.46 GiB  0:35:10h
     60             3     0  DataSphere-3               drives0    10.108.220.165  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:35:15h
     61             3     1  DataSphere-3               drives0    10.108.199.216  UP      6.0.0    DRIVES      DPDK       4  1.46 GiB  0:35:10h
     80             4     0  DataSphere-4               drives0    10.108.107.173  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:35:15h
     81             4     1  DataSphere-4               drives0    10.108.230.210  UP      6.0.0    DRIVES      DPDK       4  1.46 GiB  0:35:10h
    100             5     0  DataSphere-5               drives0    10.108.176.219  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:35:14h
    101             5     1  DataSphere-5               drives0    10.108.147.66   UP      6.0.0    DRIVES      DPDK       4  1.46 GiB  0:35:10h
    120             6     0  DataSphere-3               compute0   10.108.220.165  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:54h
    121             6     1  DataSphere-3               compute0   10.108.94.64    UP      6.0.0    COMPUTE     DPDK       6  1.41 GiB  0:33:49h
    140             7     0  DataSphere-5               compute0   10.108.176.219  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:54h
    141             7     1  DataSphere-5               compute0   10.108.213.132  UP      6.0.0    COMPUTE     DPDK       6  1.41 GiB  0:33:49h
    160             8     0  DataSphere-4               compute0   10.108.107.173  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:54h
    161             8     1  DataSphere-4               compute0   10.108.143.165  UP      6.0.0    COMPUTE     DPDK       6  1.41 GiB  0:33:49h
    180             9     0  DataSphere-0               compute0   10.108.233.213  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:54h
    181             9     1  DataSphere-0               compute0   10.108.197.159  UP      6.0.0    COMPUTE     DPDK       6  1.41 GiB  0:33:48h
    200            10     0  DataSphere-1               compute0   10.108.111.114  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:49h
    201            10     1  DataSphere-1               compute0   10.108.112.214  UP      6.0.0    COMPUTE     DPDK       6  1.41 GiB  0:33:43h
    220            11     0  DataSphere-2               compute0   10.108.190.195  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:49h
    221            11     1  DataSphere-2               compute0   10.108.35.79    UP      6.0.0    COMPUTE     DPDK       6  1.41 GiB  0:33:43h
    240            12     0  DataSphere-1               frontend0  10.108.111.114  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:44h
    241            12     1  DataSphere-1               frontend0  10.108.7.198    UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:33:39h
    260            13     0  DataSphere-2               frontend0  10.108.190.195  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:44h
    261            13     1  DataSphere-2               frontend0  10.108.99.123   UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:33:39h
    280            14     0  DataSphere-3               frontend0  10.108.220.165  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:44h
    281            14     1  DataSphere-3               frontend0  10.108.118.79   UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:33:39h
    300            15     0  DataSphere-4               frontend0  10.108.107.173  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:44h
    301            15     1  DataSphere-4               frontend0  10.108.148.247  UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:33:39h
    320            16     0  DataSphere-5               frontend0  10.108.176.219  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:44h
    321            16     1  DataSphere-5               frontend0  10.108.159.245  UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:33:39h
    340            17     0  DataSphere-0               frontend0  10.108.233.213  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:33:44h
    341            17     1  DataSphere-0               frontend0  10.108.200.201  UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:33:39h
    360            18     0  DataSphere-LinuxClients-6  default    10.108.169.39   UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:31:38h
    361            18     1  DataSphere-LinuxClients-6  default    10.108.18.155   UP      6.0.0    FRONTEND    DPDK       2  1.38 GiB  0:31:34h
    380            19     0  DataSphere-0               dataserv0  10.108.233.213  UP      6.0.0    MANAGEMENT  UDP        0       N/A  0:07:09h
    381            19     1  DataSphere-0               dataserv0  10.108.233.213  UP      6.0.0    DATASERV    UDP        1       N/A  0:07:03h
```

</details>

## Set up S3 lifecycle task management

After setting up the Data Services container, you can enable and configure S3 lifecycle task management to automate object expiration in S3 buckets.

#### Enable S3 lifecycle task management

Run the following command to enable the S3 lifecycle task manager:

```bash
weka dataservice s3-lifecycle-task enable
```

#### Configure S3 lifecycle task settings (optional)

You can customize the S3 lifecycle task manager behavior using the following command:

```bash
weka dataservice s3-lifecycle-task set [--max-tasks <max-tasks>] [--interval <interval>]
```

**Parameters:**

<table><thead><tr><th width="181">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--max-tasks</code></td><td><p>Maximum number of concurrent S3 lifecycle tasks that can run simultaneously.</p><p>Default: 4</p></td></tr><tr><td><code>--interval</code></td><td><p>Interval between lifecycle task manager runs.</p><p>Accepts time format: <code>3s</code>, <code>2h</code>, <code>4m</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>, <code>infinite</code>, or <code>unlimited</code>. Default: 60 seconds</p></td></tr></tbody></table>

**Example:** Set maximum concurrent tasks to 6 and interval to 5 minutes

```bash
weka dataservice s3-lifecycle-task set --max-tasks 6 --interval 5m
```

#### View S3 lifecycle task configuration

To view the current S3 lifecycle task manager configuration, run:

```bash
weka dataservice s3-lifecycle-task show
```

Example output:

```
S3 Lifecycle Task Manager Status
  Status: Enabled
  Max Concurrent Tasks: 4
  Interval (seconds): 60
```

#### Disable S3 lifecycle task management

To disable the S3 lifecycle task manager, run:

<pre class="language-bash"><code class="lang-bash"><strong>weka dataservice s3-lifecycle-task disable
</strong></code></pre>

{% hint style="info" %}
Disabling the task manager prevents new lifecycle tasks from being scheduled. Any currently running tasks will complete, but no new tasks will start until theS3 lifecycle task manager is re-enabled.
{% endhint %}

[^1]: **What is quota coloring?**

    During the procedure of setting or unsetting a directory quota, the Data Services container creates a background task referred to as `QUOTA_COLORING`. This task scans the entire directory tree and assigns the quota ID to each file and directory within the tree.

[^2]: S3 lifecycle task management to automate object expiration in S3 buckets.
