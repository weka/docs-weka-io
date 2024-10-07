---
description: >-
  Efficiently manage resource-intensive tasks with at least one Data Services
  container for improved performance and reliability.
---

# Set up a Data Services container for background tasks

The Data Services container runs tasks in the background, particularly those that can be resource-intensive. At present, it runs the [Quota Coloring](#user-content-fn-1)[^1] task. In upcoming releases, it will handle additional tasks that consume significant resources.

Running these tasks in the background ensures your CLI remains accessible and responsive without consuming compute resources. This strategy enhances performance, efficiency, and scalability when managing quotas. If a task is interrupted, it automatically resumes, providing reliability.

{% hint style="warning" %}
If the Data Services container is not operational, the quota coloring task reverts to the previous implementation and runs in a single process. This could result in the CLI hanging for an extended period. Therefore, ensuring the Data Services container runs is crucial to prevent this situation.
{% endhint %}

To improve data service performance, you can set up multiple Data Service containers, one per WEKA server.

After setting up the Data Service container, you can manage it like any other container within the cluster. If there’s a need to adjust its resources, use the `weka cluster container resources` or `weka local resources` commands. For more details, see [expansion-of-specific-resources.md](../expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md "mention").

**Before you begin**

1. Ensure the server where you’re adding this container has a minimum of 5.5 GB of memory available for the container’s use.
2. The Data Service containers require a persistent 22 GB filesystem for intermediate global configuration data. Do one of the following:
   * If a configuration filesystem for the protocol containers exists (typically named `.config_fs`), use it and expand its size by 22 GB. See [#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations](../../additional-protocols/additional-protocols-overview.md#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations "mention")
   * If a configuration filesystem does not exist, create a dedicated 22 GB configuration filesystem for the Data Service containers.
3. Set the Data Service global configuration. Run the following command:&#x20;

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

1. **Identify the leader IP address:** Run the following command:

```
weka cluster process --leader'. This IP is used in the join-ips parameter
```

<details>

<summary>Example</summary>

```bash
$ weka cluster process --leader
PROCESS ID  HOSTNAME        CONTAINER  IPS             STATUS  RELEASE  ROLES       NETWORK  CPU  MEMORY  UPTIME    LAST FAILURE
60          DatSphere-1     drives0    10.108.234.164  UP      4.3.2    MANAGEMENT  UDP           N/A     1:21:05h
```

</details>

2. **Set up the Data Services container:** Run the following command:

{% code overflow="wrap" %}
```bash
weka local setup container --name <container_name> --base-port <base-port> --join-ips <leader-IP>  --only-dataserv-cores --memory 1.5GB --allow-mix-setting
```
{% endcode %}

Parameters:

<table><thead><tr><th width="255">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The Data Services container name. Set<code>dataserv0</code> to avoid confusion.</td></tr><tr><td><code>only-dataserv-cores</code>*</td><td>Creates a Data Services container. This parameter is mandatory.</td></tr><tr><td><code>base-port</code></td><td>If a base-port is not specified, the Data Services container may still initialize as it attempts to allocate an available port range and could succeed. However, for optimal operation, it is recommended to provide the base port externally.</td></tr><tr><td><code>join-ips</code>*</td><td>The cluster's leader IP address. This parameter is mandatory to join the Data Services container to the cluster.</td></tr><tr><td><code>management-ips</code></td><td>This is optional. If not provided, it automatically takes the management IP of the server.</td></tr><tr><td><code>memory</code></td><td>Configure the container memory to be allocated for huge pages. It is recommended to set it to 1.5 GB.</td></tr></tbody></table>

<details>

<summary>Example</summary>

{% code overflow="wrap" %}
```bash
$ weka local setup container --name dataserv0 --base-port 14400 --join-ips 10.108.234.164  --only-dataserv-cores --memory 1.5GB --allow-mix-setting
Version 4.3.2 is already downloaded.
Created Weka container named dataserv0
Preparing version 4.3.2 of container dataserv0
No net parameter specified, configuring in UDP mode
Successfully set up container dataserv0
Starting container
Waiting for container to start up
Container "dataserv0" is ready (pid = 66904)
```
{% endcode %}

</details>

3. **Verify the Data Services container is up**: Run `weka local ps`.

<details>

<summary>Example</summary>

```bash
$ weka local ps
CONTAINER  STATE    DISABLED  UPTIME    MONITORING  PERSISTENT  PORT   PID    STATUS  VERSION  LAST FAILURE
compute0   Running  False     1:21:58h  True        True        14300  44600  Ready   4.3.2
dataserv0  Running  False     44.59s    True        True        14400  66904  Ready   4.3.2
drives0    Running  False     1:22:39h  True        True        14000  43448  Ready   4.3.2
frontend0  Running  False     1:21:15h  True        True        14200  45680  Ready   4.3.2
```

</details>

4. **Verify the Data Services container is visible in the cluster:** Run `weka cluster container`.

<details>

<summary>Example</summary>

See `dataserve0` in the last row (CONTAINER ID 15).&#x20;

```bash
$ weka cluster container
CONTAINER ID  HOSTNAME        CONTAINER  IPS             STATUS  RELEASE  FAILURE DOMAIN  CORES  MEMORY   UPTIME    LAST FAILURE
0             DataSphere-0    drives0    10.108.249.241  UP      4.3.2    DOM-000         1      1.54 GB  1:29:38h
1             DataSphere-1    drives0    10.108.211.190  UP      4.3.2    DOM-001         1      1.54 GB  1:29:39h
2             DataSphere-2    drives0    10.108.47.134   UP      4.3.2    DOM-002         1      1.54 GB  1:29:39h
3             DataSphere-3    drives0    10.108.234.164  UP      4.3.2    DOM-003         1      1.54 GB  1:29:39h
4             DataSphere-4    drives0    10.108.166.243  UP      4.3.2    DOM-004         1      1.54 GB  1:29:38h
5             DataSphere-0    compute0   10.108.249.241  UP      4.3.2    DOM-000         1      1.50 GB  1:28:56h
6             DataSphere-1    compute0   10.108.211.190  UP      4.3.2    DOM-001         1      1.50 GB  1:28:57h
7             DataSphere-2    compute0   10.108.47.134   UP      4.3.2    DOM-002         1      1.50 GB  1:28:57h
8             DataSphere-3    compute0   10.108.234.164  UP      4.3.2    DOM-003         1      1.50 GB  1:28:57h
9             DataSphere-4    compute0   10.108.166.243  UP      4.3.2    DOM-004         1      1.50 GB  1:28:58h
10            DataSphere-0    frontend0  10.108.249.241  UP      4.3.2    DOM-000         1      1.47 GB  1:28:13h
11            DataSphere-1    frontend0  10.108.211.190  UP      4.3.2    DOM-001         1      1.47 GB  1:28:13h
12            DataSphere-2    frontend0  10.108.47.134   UP      4.3.2    DOM-002         1      1.47 GB  1:28:13h
13            DataSphere-3    frontend0  10.108.234.164  UP      4.3.2    DOM-003         1      1.47 GB  1:28:14h
14            DataSphere-4    frontend0  10.108.166.243  UP      4.3.2    DOM-004         1      1.47 GB  1:28:14h
15            DataSphere-0    dataserv0  10.108.249.241  UP      4.3.2                    1      1.47 GB  0:07:41h
```

</details>

5. **Verify the data services and management processes have joined the cluster:** Run `weka cluster process`.

<details>

<summary>Example</summary>

See PROCESS IDs 300 and 301.

```bash
$ weka cluster process
PROCESS ID  HOSTNAME      CONTAINER  IPS             STATUS  RELEASE  ROLES       NETWORK  CPU  MEMORY   UPTIME    LAST FAILURE
0           DataSphere-0  drives0    10.108.249.241  UP      4.3.2    MANAGEMENT  UDP           N/A      1:22:26h  Host joined a new cluster (1 hour ago)
1           DataSphere-0  drives0    10.108.6.1      UP      4.3.2    DRIVES      DPDK     2    1.54 GB  1:22:24h
20          DataSphere-1  drives0    10.108.211.190  UP      4.3.2    MANAGEMENT  UDP           N/A      1:22:28h  Host joined a new cluster (1 hour ago)
21          DataSphere-1  drives0    10.108.18.211   UP      4.3.2    DRIVES      DPDK     4    1.54 GB  1:22:24h
40          DataSphere-2  drives0    10.108.47.134   UP      4.3.2    MANAGEMENT  UDP           N/A      1:22:27h  Host joined a new cluster (1 hour ago)
41          DataSphere-2  drives0    10.108.0.189    UP      4.3.2    DRIVES      DPDK     4    1.54 GB  1:22:24h
60          DataSphere-3  drives0    10.108.234.164  UP      4.3.2    MANAGEMENT  UDP           N/A      1:22:29h
61          DataSphere-3  drives0    10.108.181.42   UP      4.3.2    DRIVES      DPDK     6    1.54 GB  1:22:24h
80          DataSphere-4  drives0    10.108.166.243  UP      4.3.2    MANAGEMENT  UDP           N/A      1:22:26h  Host joined a new cluster (1 hour ago)
81          DataSphere-4  drives0    10.108.32.208   UP      4.3.2    DRIVES      DPDK     2    1.54 GB  1:22:24h
100         DataSphere-0  compute0   10.108.249.241  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:52h  Configuration snapshot pulled (1 hour ago)
101         DataSphere-0  compute0   10.108.150.39   UP      4.3.2    COMPUTE     DPDK     6    1.50 GB  1:21:50h
120         DataSphere-1  compute0   10.108.211.190  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:52h  Configuration snapshot pulled (1 hour ago)
121         DataSphere-1  compute0   10.108.162.229  UP      4.3.2    COMPUTE     DPDK     2    1.50 GB  1:21:50h
140         DataSphere-2  compute0   10.108.47.134   UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:46h  Removed from cluster: Not reachable by the cluster (1 hour ago)
141         DataSphere-2  compute0   10.108.38.178   UP      4.3.2    COMPUTE     DPDK     2    1.50 GB  1:21:50h
160         DataSphere-3  compute0   10.108.234.164  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:52h  Configuration snapshot pulled (1 hour ago)
161         DataSphere-3  compute0   10.108.254.134  UP      4.3.2    COMPUTE     DPDK     4    1.50 GB  1:21:50h
180         DataSphere-4  compute0   10.108.166.243  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:46h  Removed from cluster: Not reachable by the cluster (1 hour ago)
181         DataSphere-4  compute0   10.108.0.100    UP      4.3.2    COMPUTE     DPDK     4    1.50 GB  1:21:50h
200         DataSphere-0  frontend0  10.108.249.241  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:01h  Removed from cluster: Not reachable by the cluster (1 hour ago)
201         DataSphere-0  frontend0  10.108.10.152   UP      4.3.2    FRONTEND    DPDK     4    1.47 GB  1:21:05h
220         DataSphere-1  frontend0  10.108.211.190  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:01h  Removed from cluster: Not reachable by the cluster (1 hour ago)
221         DataSphere-1  frontend0  10.108.201.178  UP      4.3.2    FRONTEND    DPDK     6    1.47 GB  1:21:05h
240         DataSphere-2  frontend0  10.108.47.134   UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:01h  Removed from cluster: Not reachable by the cluster (1 hour ago)
241         DataSphere-2  frontend0  10.108.172.186  UP      4.3.2    FRONTEND    DPDK     6    1.47 GB  1:21:05h
260         DataSphere-3  frontend0  10.108.234.164  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:08h  Configuration snapshot pulled (1 hour ago)
261         DataSphere-3  frontend0  10.108.145.253  UP      4.3.2    FRONTEND    DPDK     2    1.47 GB  1:21:05h
280         DataSphere-4  frontend0  10.108.166.243  UP      4.3.2    MANAGEMENT  UDP           N/A      1:21:08h  Configuration snapshot pulled (1 hour ago)
281         DataSphere-4  frontend0  10.108.219.191  UP      4.3.2    FRONTEND    DPDK     6    1.47 GB  1:21:05h
300         DataSphere-0  dataserv0  10.108.249.241  UP      4.3.2    MANAGEMENT  UDP           N/A      33.05s    Configuration snapshot pulled (40 seconds ago)
301         DataSphere-0  dataserv0  10.108.249.241  UP      4.3.2    DATASERV    UDP      1    1.47 GB  14.55s
```

</details>

[^1]: **What is quota coloring?**

    During the procedure of setting or unsetting a directory quota, the Data Services container creates a background task referred to as `QUOTA_COLORING`. This task scans the entire directory tree and assigns the quota ID to each file and directory within the tree.
