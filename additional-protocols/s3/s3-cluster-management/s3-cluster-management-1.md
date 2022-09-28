---
description: >-
  This page describes how to set up, update, monitor, and delete an S3 cluster
  using the GUI.
---

# Manage the S3 service using the CLI

Using the CLI, you can:

* [Create an S3 cluster](s3-cluster-management-1.md#create-an-s3-cluster)
* [Check the status of the S3 cluster and hosts readiness](s3-cluster-management-1.md#check-the-status-of-the-s3-cluster-and-hosts-readiness)
* [Update an S3 cluster configuration](s3-cluster-management-1.md#update-an-s3-cluster-configuration)
* [Add hosts to the S3 cluster](s3-cluster-management-1.md#add-hosts-to-the-s3-cluster)
* [Remove hosts from the S3 cluster](s3-cluster-management-1.md#add-hosts-to-the-s3-cluster-1)
* [Delete an S3 cluster](s3-cluster-management-1.md#delete-an-s3-cluster)

## Create an S3 cluster&#x20;

**Command:** `weka s3 cluster create`

Use the following command line to create an S3 cluster:

`weka s3 cluster create <default-fs-name> [--all-hosts] [--host hosts] [--port port] [--anonymous-posix-uid uid] [--anonymous-posix-gid gid] [--config-fs-name config-fs-name]`

**Parameters**

| **Name**              | **Type**                        | **Value**                                                                                                                      | **Limitations**                                                            | **Mandatory**                                      | **Default**                                                       |
| --------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------- | -------------------------------------------------- | ----------------------------------------------------------------- |
| `filesystem`          | String                          | The filesystem name to be used for the S3 serviceץ                                                                             | None                                                                       | Yes                                                |                                                                   |
| `all-hosts`           | Boolean                         | Use all backend hosts to serve S3 commandsץ                                                                                    | None                                                                       | Either `host` list or `all-hosts` must be provided | Off                                                               |
| `host`                | Comma-separated list of Numbers | Host IDs to serve the S3 serviceץ                                                                                              | Minimum of 3 hosts must be supplied.                                       | Either `host` list or `all-hosts` must be provided |                                                                   |
| `port`                | Number                          | The port where the S3 service is exposedץ                                                                                      | None                                                                       | No                                                 | 9000                                                              |
| `anonymous-posix-uid` | Number                          | POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that). | None                                                                       | No                                                 | 65534                                                             |
| `anonymous-posix-gid` | Number                          | POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that). | None                                                                       | No                                                 | 65534                                                             |
| `config-fs-name`      | String                          | S3 config filesystem name.                                                                                                     | S3 supports config filesystem for persisting S3 cluster-wide configuration | No                                                 | If not supplied it defaults to the value provided in `filesystem` |

## Check the status of the S3 cluster and hosts readiness

**Command:** `weka s3 cluster` or `weka s3 cluster status`

Use these commands to check the status and configuration of the S3 cluster. Once all hosts are prepared and ready, it is possible to use the S3 service.

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
| `all-hosts`           | Boolean                         | Use all backend hosts to serve S3 commands                                                                                     | None                                                                       | No            |             |
| `host`                | Comma-separated list of numbers | Host IDs to serve the S3 service                                                                                               | Minimum of 3 hosts                                                         | No            |             |
| `port`                | Number                          | The port where the S3 service is exposed                                                                                       | None                                                                       | No            |             |
| `anonymous-posix-uid` | Number                          | POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that). | None                                                                       | No            |             |
| `anonymous-posix-gid` | Number                          | POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that). | None                                                                       | No            |             |
| `config-fs-name`      | String                          | S3 config filesystem name.                                                                                                     | S3 supports config filesystem for persisting S3 cluster-wide configuration |               |             |

## Add hosts to the S3 cluster

**Command:** `weka s3 cluster hosts add`

Use the following command line to add hosts to the S3 cluster:

`weka s3 cluster hosts add <hosts>`

The following command example adds two hosts with the IDs 8 and 9:

`weka s3 cluster hosts add 8 9`

**Parameters**

| **Name** | **Type**                        | **Value**                          | **Limitations** | **Mandatory** | **Default** |
| -------- | ------------------------------- | ---------------------------------- | --------------- | ------------- | ----------- |
| `hosts`  | Space-separated list of numbers | Host IDs to add to the S3 cluster. | <p></p><p></p>  | Yes           |             |

## Remove hosts from the S3 cluster

**Command:** `weka s3 cluster hosts remove`

Use the following command line to remove hosts from the S3 cluster:

`weka s3 cluster hosts remove <hosts>`

**Parameters**

| **Name** | **Type**                        | **Value**                               | **Limitations** | **Mandatory** | **Default** |
| -------- | ------------------------------- | --------------------------------------- | --------------- | ------------- | ----------- |
| `hosts`  | Space-separated list of numbers | Host IDs to remove from the S3 cluster. | <p></p><p></p>  | Yes           |             |

## Delete an S3 cluster

**Command:** `weka s3 cluster destroy`

Use this command to destroy an S3 cluster managed by the Weka system.

Deleting an existing S3 cluster managed by the Weka system does not delete the backend Weka filesystem but removes the S3 bucket exposures of these filesystems.
