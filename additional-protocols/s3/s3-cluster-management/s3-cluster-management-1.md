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

<table><thead><tr><th>Name</th><th width="327">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>default-fs-name</code>*</td><td>The filesystem name to be used for the S3 service.</td><td></td></tr><tr><td><code>config-fs-name</code>*</td><td>The predefined filesystem name for maintaining the persisting cluster-wide protocol configurations.<br>Ensure the filesystem is already created. If not, create a filesystem with 100 GB capacity.</td><td></td></tr><tr><td><code>port</code></td><td>The port where the S3 service is exposed.<br>Do not set port 9001.</td><td>9000</td></tr><tr><td><code>key</code></td><td>The object store bucket access key ID.</td><td>As set when <a href="../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket">adding an object store bucket</a>.</td></tr><tr><td><code>secret</code></td><td>The object store bucket secret key.</td><td>As set when <a href="../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket">adding an object store bucket</a>.</td></tr><tr><td><code>max-buckets-limit</code></td><td>The maximum number of buckets that can be created.<br>Maximum value: 10000.</td><td></td></tr><tr><td><code>anonymous-posix-uid</code></td><td>POSIX UID for objects (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).</td><td>65534</td></tr><tr><td><code>anonymous-posix-gid</code></td><td>POSIX GID for objects (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).</td><td>65534</td></tr><tr><td><code>domain</code></td><td><p>Virtual hosted-style comma-separated domains.</p><p>Maximum number of characters: 1024.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br>To remove the existing domain, set <code>""</code>.<br>Example: <code>--domain ""</code></p></td><td></td></tr><tr><td><code>container-id</code>*</td><td>Container IDs with a frontend process to serve the S3 service.<br>To ensure redundancy and fault tolerance a minimum of two containers is required for the S3 cluster. However, it is possible to create a single-container S3 cluster, which means there will be no redundancy.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container-id</code> parameter.</td><td></td></tr><tr><td><code>all-servers</code>*</td><td>Use all backend servers to serve S3 commands.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container-id</code> parameter.</td><td>None</td></tr></tbody></table>

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

<table><thead><tr><th>Name</th><th width="325">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>key</code></td><td>The object store bucket access key ID.</td><td>As set when <a href="../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket">adding an object store bucket</a>.</td></tr><tr><td><code>secret</code></td><td>The object store bucket secret key.</td><td>As set when <a href="../../../fs/managing-object-stores/managing-object-stores-1.md#add-an-object-store-bucket">adding an object store bucket</a>.</td></tr><tr><td><code>port</code></td><td>The port where the S3 service is exposed.<br>Do not set port 9001.</td><td></td></tr><tr><td><code>anonymous-posix-uid</code></td><td>POSIX UID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).</td><td>65534</td></tr><tr><td><code>anonymous-posix-gid</code></td><td>POSIX GID for objects  (when accessed via POSIX) created with anonymous access (for buckets with an IAM policy allowing that).</td><td>65534</td></tr><tr><td><code>domain</code></td><td><p>Virtual-hosted-style comma-separated domains.<br>Maximum number of characters: 1024.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br></p><p>To remove the existing domain, set <code>""</code>. <br>Example: <code>--domain ""</code></p><p></p><p><strong>Note:</strong> Modifying the domain parameter value triggers an automatic restart of all S3 containers, resulting in I/O disruption.</p></td><td></td></tr><tr><td><code>container</code>*</td><td><p>Container IDs associated with a frontend process responsible for serving the S3 service.</p><p></p><p>For redundancy and fault tolerance, a minimum of two containers is necessary for the S3 cluster. Nevertheless, it is possible to create a single-container S3 cluster, which means there will be no redundancy.</p><p></p><p>If you include <code>all-servers</code> in the command, do not specify a list of containers in the <code>container</code> parameter.</p></td><td></td></tr><tr><td><code>all-servers</code>*</td><td>Use all backend servers to serve S3 commands.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container</code> parameter.</td><td>None</td></tr></tbody></table>

{% hint style="info" %}
Instead of using the `weka s3 cluster update` command for adding or removing containers, use the commands `weka s3 cluster containers add` or `weka s3 cluster containers remove`. It is more convenient when managing an S3 cluster with many containers.
{% endhint %}

## Add containers to the S3 cluster

**Command:** `weka s3 cluster containers add`

Use the following command line to add containers to the S3 cluster:

`weka s3 cluster containers add <container-ids>`

The following command example adds two containers with the IDs 8 and 9:

`weka s3 cluster containers add 8 9`

**Parameters**

<table><thead><tr><th width="282">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>container-ids</code>*</td><td>Container IDs to add to the S3 cluster.<br>Space-separated list of numbers.</td></tr></tbody></table>

## Remove containers from the S3 cluster

**Command:** `weka s3 cluster containers remove`

Use the following command line to remove containers from the S3 cluster:

`weka s3 cluster containers remove <container-ids>`

**Parameters**

<table><thead><tr><th width="281">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>container-ids</code>*</td><td>Container IDs to remove from the S3 cluster.<br>Space-separated list of numbers</td></tr></tbody></table>

## Delete an S3 cluster

**Command:** `weka s3 cluster destroy`

Use this command to destroy an S3 cluster managed by the Weka system.

Deleting an existing S3 cluster removes the S3 service and configuration, such as IAM policies, buckets, and ILM rules. S3 access is no longer available for clients. Data that resides within the buckets is not deleted. Internal users with S3 roles are deleted from the system.
