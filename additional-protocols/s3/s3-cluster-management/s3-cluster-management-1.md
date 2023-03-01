---
description: >-
  This page describes how to set up, update, monitor, and delete an S3 cluster
  using the GUI.
---

# Manage the S3 service using the CLI

Using the CLI, you can:

* [Create an S3 cluster](s3-cluster-management-1.md#create-an-s3-cluster)
* [Check the status of the S3 cluster readiness](s3-cluster-management-1.md#check-the-status-of-the-s3-cluster-readiness)
* [List the S3 cluster containers](s3-cluster-management-1.md#list-the-s3-cluster-containers)
* [Update an S3 cluster configuration](s3-cluster-management-1.md#update-an-s3-cluster-configuration)
* [Add containers to the S3 cluster](s3-cluster-management-1.md#add-containers-to-the-s3-cluster)
* [Remove containers from the S3 cluster](s3-cluster-management-1.md#remove-hosts-from-the-s3-cluster)
* [Delete an S3 cluster](s3-cluster-management-1.md#delete-an-s3-cluster)

## Create an S3 cluster

**Command:** `weka s3 cluster create`

Use the following command line to create an S3 cluster:

`weka s3 cluster create <default-fs-name> <config-fs-name> [--port port] [--key key] [--secret secret] [--max-buckets-limit max-buckets-limit] [--anonymous-posix-uid anonymous-posix-uid] [--anonymous-posix-gid anonymous-posix-gid] [--domain domain] [--container-id container-id]... [--all-servers]`

**Parameters**

| **Name**              | **Type**                        | **Value**                                                                                                                                                                                                                         | **Limitations**                                | **Mandatory**                                                     | **Default**                                                                                                                             |
| --------------------- | ------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `default-fs-name`     | String                          | The filesystem name to be used for the S3 service.                                                                                                                                                                                | None                                           | Yes                                                               |                                                                                                                                         |
| `config-fs-name`      | String                          | The filesystem used for persisting cluster-wide configuration for all protocols.                                                                                                                                                  | Must be the same filesystem for all protocols. | Yes                                                               |                                                                                                                                         |
| `port`                | Number                          | The port where the S3 service is exposed.                                                                                                                                                                                         | Do not set port 9001                           | No                                                                | 9000                                                                                                                                    |
| `key`                 | String                          | The object store bucket access key ID.                                                                                                                                                                                            | Must be a valid key                            | No                                                                | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `secret`              | String                          | The object store bucket secret key.                                                                                                                                                                                               | Must be a valid secret key                     | No                                                                | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `max-buckets-limit`   | Number                          | The maximum number of buckets that can be created.                                                                                                                                                                                | 10000                                          | No                                                                |                                                                                                                                         |
| `anonymous-posix-uid` | Number                          | POSIX UID for objects (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                     | None                                           | No                                                                | 65534                                                                                                                                   |
| `anonymous-posix-gid` | Number                          | POSIX GID for objects (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                     | None                                           | No                                                                | 65534                                                                                                                                   |
| `domain`              | String                          | <p>Virtual hosted-style comma-separated domains.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br>To remove the existing domain, set <code>""</code>.<br>Example: <code>--domain ""</code>.</p> | Maximum 1024 characters                        | No                                                                |                                                                                                                                         |
| `container-id`        | Comma-separated list of Numbers | Container IDs of containers with a frontend process to serve the S3 service.                                                                                                                                                      | Specify a minimum of 3 containers              | Either `all-servers` or a list of `container-id` must be provided |                                                                                                                                         |
| `all-servers`         | Boolean                         | Use all backend servers to serve S3 commands.                                                                                                                                                                                     | None                                           | Either `all-servers` or a list of `container-id` must be provided | Off                                                                                                                                     |

## Check the status of the S3 cluster readiness

**Command:** `weka s3 cluster` or `weka s3 cluster status`

The S3 cluster is comprised of a few S3 containers. Use this command to check the status of the S3 containers that are part of the S3 cluster. Once all the S3 containers are prepared and ready, it is possible to use the S3 service.

## List the S3 cluster containers <a href="#list-the-s3-cluster-containers" id="list-the-s3-cluster-containers"></a>

**Command:** `weka s3 cluster containers list`

Use this command to list the containers that serve the S3 cluster.

## Update an S3 cluster configuration <a href="#update-an-s3-cluster-configuration" id="update-an-s3-cluster-configuration"></a>

**Command:** `weka s3 cluster update`

Use the following command line to update an S3 cluster configuration:

`weka s3 cluster update [--key key] [--secret secret] [--port port] [--anonymous-posix-uid anonymous-posix-uid] [--anonymous-posix-gid anonymous-posix-gid] [--domain domain] [--container container]... [--all-servers]`

**Parameters**

| **Name**              | **Type**                        | **Value**                                                                                                                                                                                                                                           | **Limitations**            | **Mandatory**                                              | **Default**                                                                                                                             |
| --------------------- | ------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `key`                 | String                          | The object store bucket access key ID.                                                                                                                                                                                                              | Must be a valid key        | No                                                         | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `secret`              | String                          | The object store bucket secret key.                                                                                                                                                                                                                 | Must be a valid secret key | No                                                         | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `port`                | Number                          | The port where the S3 service is exposed.                                                                                                                                                                                                           | Do not set port 9001       |                                                            |                                                                                                                                         |
| `anonymous-posix-uid` | Number                          | POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                                      | None                       | No                                                         | 65534                                                                                                                                   |
| `anonymous-posix-gid` | Number                          | POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                                      | None                       | No                                                         | 65534                                                                                                                                   |
| `domain`              | String                          | <p>Virtual-hosted-style comma-separated domains.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br><strong></strong>To remove the existing domain, set <code>""</code>. <br>Example: <code>--domain ""</code>.</p> | Maximum 1024 characters    | No                                                         |                                                                                                                                         |
| `container`           | Comma-separated list of numbers | Container IDs of containers with frontend processes to serve the S3 service.                                                                                                                                                                        | Minimum 3 containers       | Either `container` list or `all-servers` must be provided. |                                                                                                                                         |
| `all-servers`         | Boolean                         | Use all backend servers to serve S3 commands.                                                                                                                                                                                                       | None                       | Either `container` list or `all-servers` must be provided. | Off                                                                                                                                     |

{% hint style="info" %}
**Note:** Instead of using the `weka s3 cluster update` command for adding or removing containers, use the commands `weka s3 cluster containers add` or `weka s3 cluster containers remove`. It is more convenient when managing an S3 cluster with many containers.
{% endhint %}

## Add containers to the S3 cluster

**Command:** `weka s3 cluster containers add`

Use the following command line to add containers to the S3 cluster:

`weka s3 cluster containers add <container-ids>`

The following command example adds two containers with the IDs 8 and 9:

`weka s3 cluster containers add 8 9`

**Parameters**

| **Name**        | **Type**                        | **Value**                               | **Mandatory** | **Default** |
| --------------- | ------------------------------- | --------------------------------------- | ------------- | ----------- |
| `container-ids` | Space-separated list of numbers | Container IDs to add to the S3 cluster. | Yes           |             |

## Remove containers from the S3 cluster

**Command:** `weka s3 cluster containers remove`

Use the following command line to remove containers from the S3 cluster:

`weka s3 cluster containers remove <container-ids>`

**Parameters**

| **Name**        | **Type**                        | **Value**                                    | **Mandatory** | **Default** |
| --------------- | ------------------------------- | -------------------------------------------- | ------------- | ----------- |
| `container-ids` | Space-separated list of numbers | Container IDs to remove from the S3 cluster. | Yes           |             |

## Delete an S3 cluster

**Command:** `weka s3 cluster destroy`

Use this command to destroy an S3 cluster managed by the Weka system.

Deleting an existing S3 cluster managed by the Weka system does not delete the backend Weka filesystem but removes the S3 bucket exposures of these filesystems.
