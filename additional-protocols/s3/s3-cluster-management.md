---
description: This page describes how to set up, update, monitor, and delete an S3 cluster.
---

# S3 Cluster Management

## Considerations

The S3 service can be exposed from the cluster hosts, ranging from three hosts to the entire cluster. The service performance scales linearly as the S3 cluster scales.

{% hint style="info" %}
**Note:** Depending on the workload, you may need to use several FE cores to gain maximum performance.
{% endhint %}

## Round Robin DNS / Load Balancer

To ensure that the various S3 clients will balance the load on the different Weka hosts serving S3, it is recommended to define a [Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS) entry that will resolve to the list of hosts' IPs, ensuring that the clients' load will be equally distributed across all hosts. A DNS server that supports health checks can help with resiliency if any of the hosts serving S3 become unresponsive for whatever reason.

With extreme load, even a robust DNS server / load-balancer may become overloaded. You can also use a client-side load balancer, where each client checks the health of each S3 host in the cluster. One such load balancer is the open-source [Sidekick Load Balancer](https://github.com/minio/sidekick).

## S3 Service Management using the GUI

### Creating an S3 Cluster

To configure an S3 cluster, first access the S3 Service view.

![S3 Service View](<../../.gitbook/assets/s3 cluster create 3.12.png>)

To configure the S3 cluster, click the Configure button. The following Configure S3 Cluster window will be displayed:

![Configure S3 Cluster Window](<../../.gitbook/assets/s3 cluster configure 3.12.png>)

Select which filesystem to use for the S3 service, select the Weka backend hosts to form the S3 cluster, and optionally change the port for exposing the S3 service (do not set port 9001). Then click the Configure button.

The following S3 Cluster Configuration window will be displayed:

![S3 Cluster Configuration Window](<../../.gitbook/assets/s3 cluster status 3.12.png>)

{% hint style="info" %}
**Note:** The status of the hosts will change from not ready to ready.
{% endhint %}

### Updating an S3 Cluster Configuration

To update the S3 cluster, click the Update button. An Update S3 Cluster window will be displayed:

![Update S3 Cluster Window](<../../.gitbook/assets/s3 cluster update 3.12.png>)

Update the list of Weka hosts or S3 service port. Then click the Update button.

### Deleting an S3 Cluster

To delete a configured S3 cluster, click the Reset button in the S3 Cluster Configuration window. The following window will be displayed:

![S3 Cluster Reset Confirmation WIndow](<../../.gitbook/assets/s3 cluster delete 3.12.png>)

Confirm the deletion by clicking the Reset button.

## S3 Service Management using the CLI

### Creating an S3 Cluster&#x20;

**Command:** `weka s3 cluster create`

Use the following command line to create an S3 cluster:

`weka s3 cluster create <filesystem> [--all-hosts] [--host hosts] [--port port] [--anonymous-posix-uid uid] [--anonymous-posix-gid gid]`&#x20;

**Parameters in Command Line**

<table data-header-hidden><thead><tr><th width="164">Name</th><th width="150">Type</th><th>Value</th><th width="150">Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>filesystem</code></td><td>String</td><td>The filesystem name to be used for the S3 service</td><td>None</td><td>Yes</td><td></td></tr><tr><td><code>all-hosts</code></td><td>Boolean</td><td>Use all backend hosts to serve S3 commands</td><td>None</td><td>Either <code>host</code> list or <code>all-hosts</code> must be provided</td><td>Off</td></tr><tr><td><code>host</code></td><td>Comma-separated list of Numbers</td><td>Host IDs to serve the S3 service</td><td>Minimum of 3 hosts must be supplied.</td><td>Either <code>host</code> list or <code>all-hosts</code> must be provided</td><td></td></tr><tr><td><code>port</code></td><td>Number</td><td>The port where the S3 service is exposed</td><td>Do not set port 9001.</td><td>No</td><td>9000</td></tr><tr><td><code>anonymous-posix-uid</code></td><td>Number</td><td>POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for bukets with an IAM pocliy allowing that).</td><td>None</td><td>No</td><td>65534</td></tr><tr><td><code>anonymous-posix-gid</code></td><td>Number</td><td>POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for bukets with an IAM pocliy allowing that).</td><td>None</td><td>No</td><td>65534</td></tr></tbody></table>

### Checking the Status of the S3 Cluster and Hosts Readiness

**Command:** `weka s3 cluster` / `weka s3 cluster status`

Use these commands to check the status and configuration of the S3 cluster. Once all hosts are prepared and ready, it is possible to use the S3 service.

### Updating an S3 Cluster Configuration&#x20;

**Command:** `weka s3 cluster update`

Use the following command line to update an S3 cluster configuration:

`weka s3 cluster update [--all-hosts] [--host hosts] [--port port] [--anonymous-posix-uid uid] [--anonymous-posix-gid gid]`&#x20;

**Parameters in Command Line**

| **Name**              | **Type**                        | **Value**                                                                                                                     | **Limitations**    | **Mandatory** | **Default** |
| --------------------- | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------ | ------------- | ----------- |
| `all-hosts`           | Boolean                         | Use all backend hosts to serve S3 commands                                                                                    | None               | No            |             |
| `host`                | Comma-separated list of Numbers | Host IDs to serve the S3 service                                                                                              | Minimum of 3 hosts | No            |             |
| `port`                | Number                          | The port where the S3 service is exposed                                                                                      | None               | No            |             |
| `anonymous-posix-uid` | Number                          | POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for bukets with an IAM pocliy allowing that). | None               | No            |             |
| `anonymous-posix-gid` | Number                          | POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for bukets with an IAM pocliy allowing that). | None               | No            |             |

## Deleting an S3 Cluster

**Command:** `weka s3 cluster destroy`

Use this command to destroy an S3 cluster managed by the Weka system.

Deleting an existing S3 cluster managed by the Weka system does not delete the backend Weka filesystem but removes the S3 bucket exposures of these filesystems.
