---
description: >-
  This page describes how to set up, update, monitor, and delete an S3 cluster
  using the GUI.
---

# Manage the S3 service using the CLI

Using the CLI, you can:

* [Create an S3 cluster](s3-cluster-management-1.md#create-an-s3-cluster)
* [Check the status of the S3 cluster and hosts readiness](s3-cluster-management-1.md#check-the-status-of-the-s3-cluster-and-hosts-readiness)
* [List the S3 cluster hosts](s3-cluster-management-1.md#list-the-the-s3-cluster-hosts)
* [Update an S3 cluster configuration](s3-cluster-management-1.md#update-an-s3-cluster-configuration)
* [Add hosts to the S3 cluster](s3-cluster-management-1.md#add-hosts-to-the-s3-cluster)
* [Remove hosts from the S3 cluster](s3-cluster-management-1.md#remove-hosts-from-the-s3-cluster)
* [Delete an S3 cluster](s3-cluster-management-1.md#delete-an-s3-cluster)

## Create an S3 cluster&#x20;

**Command:** `weka s3 cluster create`

Use the following command line to create an S3 cluster:

`weka s3 cluster create <default-fs-name> [--all-hosts] [--host hosts] [--port port] [--anonymous-posix-uid uid] [--anonymous-posix-gid gid] [--config-fs-name config-fs-name]`

{% hint style="warning" %}
**Note:** As a best practice, it is recommended to have only one of the following protocol containers, NFS, SMB, or S3, installed on the same server. Starting from version 4.2, setting more than one additional protocol to the existing POSIX is not allowed.
{% endhint %}

**Parameters**

<table data-header-hidden><thead><tr><th width="164">Name</th><th width="150">Type</th><th>Value</th><th width="150">Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>filesystem</code></td><td>String</td><td>The filesystem name to be used for the S3 service.</td><td>None</td><td>Yes</td><td></td></tr><tr><td><code>all-hosts</code></td><td>Boolean</td><td>Use all backend hosts to serve S3 commands.</td><td>None</td><td>Either <code>host</code> list or <code>all-hosts</code> must be provided</td><td>Off</td></tr><tr><td><code>host</code></td><td>Comma-separated list of Numbers</td><td>Host IDs to serve the S3 service.</td><td>Minimum of 3 hosts must be supplied.</td><td>Either <code>host</code> list or <code>all-hosts</code> must be provided</td><td></td></tr><tr><td><code>port</code></td><td>Number</td><td>The port where the S3 service is exposed.</td><td>Do not set port 9001.</td><td>No</td><td>9000</td></tr><tr><td><code>anonymous-posix-uid</code></td><td>Number</td><td>POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).</td><td>None</td><td>No</td><td>65534</td></tr><tr><td><code>anonymous-posix-gid</code></td><td>Number</td><td>POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).</td><td>None</td><td>No</td><td>65534</td></tr><tr><td><code>config-fs-name</code></td><td>String</td><td>S3 config filesystem name.</td><td>S3 supports config filesystem for persisting S3 cluster-wide configuration</td><td>No</td><td>If not supplied it defaults to the value provided in <code>filesystem</code></td></tr></tbody></table>

## Check the status of the S3 cluster and hosts readiness

**Command:** `weka s3 cluster` or `weka s3 cluster status`

Use these commands to check the status and configuration of the S3 cluster. Once all hosts are prepared and ready, it is possible to use the S3 service.

## List the S3 cluster hosts

**Command:** `weka s3 cluster hosts list`

Use this command to list the hosts that serve the S3 cluster.

## Update an S3 cluster configuration

**Command:** `weka s3 cluster update`

Use the following command line to update an S3 cluster configuration:

`weka s3 cluster update [--all-hosts] [--host hosts] [--port port] [--anonymous-posix-uid uid] [--anonymous-posix-gid gid] [--config-fs-name config-fs-name]`

{% hint style="info" %}
**Note:** Instead of using the `weka s3 cluster update` command for adding or removing hosts, use the commands `weka s3 cluster hosts add` or `weka s3 cluster hosts remove`. It is more convenient when managing an S3 cluster with many hosts.
{% endhint %}

**Parameters**

| **Name**              | **Type**                        | **Value**                                                                                                                      | **Limitations**                                                            | **Mandatory** | **Default** |
| --------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------- | ------------- | ----------- |
| `all-hosts`           | Boolean                         | Use all backend hosts to serve S3 commands.                                                                                    | None                                                                       | No            |             |
| `host`                | Comma-separated list of numbers | Host IDs to serve the S3 service.                                                                                              | Minimum of 3 hosts                                                         | No            |             |
| `port`                | Number                          | The port where the S3 service is exposed.                                                                                      | None                                                                       | No            |             |
| `anonymous-posix-uid` | Number                          | POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that). | None                                                                       | No            |             |
| `anonymous-posix-gid` | Number                          | POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that). | None                                                                       | No            |             |
| `config-fs-name`      | String                          | S3 config filesystem name.                                                                                                     | S3 supports config filesystem for persisting S3 cluster-wide configuration |               |             |

## Add hosts to the S3 cluster <a href="#add-hosts-to-the-s3-cluster" id="add-hosts-to-the-s3-cluster"></a>

**Command:** `weka s3 cluster hosts add`

Use the following command line to add hosts to the S3 cluster:

`weka s3 cluster hosts add <hosts>`

The following command example adds two hosts with the IDs 8 and 9:

`weka s3 cluster hosts add 8 9`

**Parameters**

<table data-header-hidden><thead><tr><th width="150">Name</th><th width="167">Type</th><th width="184">Value</th><th>Limitations</th><th width="150">Mandatory</th><th width="150">Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>hosts</code></td><td>Space-separated list of numbers</td><td>Host IDs to add to the S3 cluster.</td><td><p></p><p></p></td><td>Yes</td><td></td></tr></tbody></table>

## Remove hosts from the S3 cluster <a href="#remove-hosts-from-the-s3-cluster" id="remove-hosts-from-the-s3-cluster"></a>

**Command:** `weka s3 cluster hosts remove`

Use the following command line to remove hosts from the S3 cluster:

`weka s3 cluster hosts remove <hosts>`

**Parameters**

<table data-header-hidden><thead><tr><th width="150">Name</th><th width="169">Type</th><th width="184">Value</th><th>Limitations</th><th width="150">Mandatory</th><th width="150">Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>hosts</code></td><td>Space-separated list of numbers</td><td>Host IDs to remove from the S3 cluster.</td><td><p></p><p></p></td><td>Yes</td><td></td></tr></tbody></table>

## Delete an S3 cluster

**Command:** `weka s3 cluster destroy`

Use this command to destroy an S3 cluster managed by the Weka system.

Deleting an existing S3 cluster managed by the Weka system does not delete the backend Weka filesystem but removes the S3 bucket exposures of these filesystems.
