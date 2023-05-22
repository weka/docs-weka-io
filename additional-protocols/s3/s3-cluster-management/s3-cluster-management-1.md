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

| Name                  | Value                                                                                                                                                                                                                                                                                     | Default                                                                                                                                 |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `default-fs-name`\*   | The filesystem name to be used for the S3 service.                                                                                                                                                                                                                                        |                                                                                                                                         |
| `config-fs-name`\*    | <p>The filesystem used for persisting cluster-wide configuration for all protocols.<br>It must be the same configuration filesystem for all protocols.</p>                                                                                                                                |                                                                                                                                         |
| `port`                | <p>The port where the S3 service is exposed.<br>Do not set port 9001.</p>                                                                                                                                                                                                                 | 9000                                                                                                                                    |
| `key`                 | The object store bucket access key ID.                                                                                                                                                                                                                                                    | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `secret`              | The object store bucket secret key.                                                                                                                                                                                                                                                       | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `max-buckets-limit`   | <p>The maximum number of buckets that can be created.<br>Maximum value: 10000.</p>                                                                                                                                                                                                        |                                                                                                                                         |
| `anonymous-posix-uid` | POSIX UID for objects (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                                                                             | 65534                                                                                                                                   |
| `anonymous-posix-gid` | POSIX GID for objects (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                                                                             | 65534                                                                                                                                   |
| `domain`              | <p>Virtual hosted-style comma-separated domains.</p><p>Maximum number of characters: 1024.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br>To remove the existing domain, set <code>""</code>.<br>Example: <code>--domain ""</code>.</p>               |                                                                                                                                         |
| `container-id`\*      | <p>Container IDs with a frontend process to serve the S3 service.<br>Specify a minimum of 3 containers in a comma-separated list of numbers.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container-id</code> parameter.</p> |                                                                                                                                         |
| `all-servers`\*       | <p>Use all backend servers to serve S3 commands.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container-id</code> parameter.</p>                                                                                             | None                                                                                                                                    |

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

| Name                  | Value                                                                                                                                                                                                                                                                                  | Default                                                                                                                                 |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `key`                 | The object store bucket access key ID.                                                                                                                                                                                                                                                 | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `secret`              | The object store bucket secret key.                                                                                                                                                                                                                                                    | As set when [adding an object store bucket](../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket). |
| `port`                | <p>The port where the S3 service is exposed.<br>Do not set port 9001.</p>                                                                                                                                                                                                              |                                                                                                                                         |
| `anonymous-posix-uid` | POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                                                                         | 65534                                                                                                                                   |
| `anonymous-posix-gid` | POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).                                                                                                                                                         | 65534                                                                                                                                   |
| `domain`              | <p>Virtual-hosted-style comma-separated domains.<br>Maximum number of characters: 1024.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br>To remove the existing domain, set <code>""</code>. <br>Example: <code>--domain ""</code>.</p>              |                                                                                                                                         |
| `container`\*         | <p>Container IDs with a frontend process to serve the S3 service.<br>Specify a minimum of 3 containers in a comma-separated list of numbers.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container</code> parameter.</p> |                                                                                                                                         |
| `all-servers`\*       | <p>Use all backend servers to serve S3 commands.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container</code> parameter.</p>                                                                                             | None                                                                                                                                    |

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

| Name              | Value                                                                              |
| ----------------- | ---------------------------------------------------------------------------------- |
| `container-ids`\* | <p>Container IDs to add to the S3 cluster.<br>Space-separated list of numbers.</p> |

## Remove containers from the S3 cluster

**Command:** `weka s3 cluster containers remove`

Use the following command line to remove containers from the S3 cluster:

`weka s3 cluster containers remove <container-ids>`

**Parameters**

| Name              | Value                                                                                  |
| ----------------- | -------------------------------------------------------------------------------------- |
| `container-ids`\* | <p>Container IDs to remove from the S3 cluster.<br>Space-separated list of numbers</p> |

## Delete an S3 cluster

**Command:** `weka s3 cluster destroy`

Use this command to destroy an S3 cluster managed by the Weka system.

Deleting an existing S3 cluster removes the S3 service and configuration, such as IAM policies, buckets, and ILM rules. S3 access is no longer available for clients. Data that resides within the buckets are not deleted. Internal users with S3 roles are deleted from the system.
