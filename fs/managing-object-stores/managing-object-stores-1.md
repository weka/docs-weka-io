---
description: This page describes how to view and manage object stores using the CLI.
---

# Manage object stores using the CLI

Using the CLI, you can perform the following actions:

* [View object stores](managing-object-stores-1.md#view-object-stores)
* [Edit an object store](managing-object-stores-1.md#edit-an-object-store)
* [Add an object store](managing-object-stores-1.md#add-an-object-store-bucket)
* [View object store buckets](managing-object-stores-1.md#view-object-store-buckets)
* [Add an object store bucket](managing-object-stores-1.md#add-an-object-store-bucket)
* [Edit an object store bucket](managing-object-stores-1.md#edit-an-object-store-bucket)
* [List recent operations of an object store bucket](managing-object-stores-1.md#show-recent-operations-of-an-object-store-bucket)
* [Delete an object store bucket](managing-object-stores-1.md#delete-an-object-store-bucket)

## View object stores

**Command:** `weka fs tier obs`

This command is used to view information on all the object stores configured to the WEKA system.

{% hint style="info" %}
**Note:** Using the GUI only object-store buckets are present. Adding an object-store bucket adds it only to the present `local` or `remote` object-store. If more than one is present (such as during the time recovering from a remote snapshot), use the CLI.
{% endhint %}

## Edit an object store

**Command:** `weka fs tier obs update`

Use the following command line to edit an object store:

`weka fs tier obs update <name> [--new-name new-name] [--site site] [--hostname=<hostname>] [--port=<port>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--remove-bandwidth=<remove-bandwidth>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

| Parameter                  | Description                                                                                                                                                                                                                                 |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name` \*                  | Name of the object store to create.                                                                                                                                                                                                         |
| `new-name`                 | New name for the object store.                                                                                                                                                                                                              |
| `site`                     | <p>Site location of the object store.<br>Possible values:<br><code>local</code> - for tiering+snapshots<br><code>remote</code> - for snapshots only</p>                                                                                     |
| `hostname`                 | Object store host identifier (hostname or IP address) to use as a default for added buckets.                                                                                                                                                |
| `port`                     | Object store port, to be used as a default for added buckets.                                                                                                                                                                               |
| `auth-method`              | <p>Authentication method to use as a default for added buckets.<br>Possible values: <code>None</code>,<code>AWSSignature2</code>,<code>AWSSignature4</code></p>                                                                             |
| `region`                   | Region name to use as a default for added buckets.                                                                                                                                                                                          |
| `access-key-id`            | Object store access key ID to use as a default for added buckets.                                                                                                                                                                           |
| `secret-key`               | Object store secret key to use as a default for added buckets.                                                                                                                                                                              |
| `protocol`                 | <p>Protocol type to use as a default for added buckets.<br>Possible values: <code>HTTP</code>,<code>HTTPS</code>,<code>HTTPS_UNVERIFIED</code></p>                                                                                          |
| `bandwidth`                | Bandwidth limitation per core (Mbps).                                                                                                                                                                                                       |
| `download-bandwidth`       | Object-store download bandwidth limitation per core (Mbps).                                                                                                                                                                                 |
| `upload-bandwidth`         | Object-store upload bandwidth limitation per core (Mbps).                                                                                                                                                                                   |
| `remove-bandwidth`         | <p>A bandwidth (Mbps) to limit the throughput of delete requests sent to the object store.<br>Setting a bandwidth equal to or lower than the object store deletion throughput prevents an increase in the object store deletions queue.</p> |
| `max-concurrent-downloads` | <p>Maximum number of downloads concurrently performed on this object store in a single IO node.<br>Possible values: <code>1</code>-<code>64</code></p>                                                                                      |
| `max-concurrent-uploads`   | <p>Maximum number of uploads concurrently performed on this object store in a single IO node.<br>Possible values: <code>1</code>-<code>64</code></p>                                                                                        |
| `max-concurrent-removals`  | <p>Maximum number of removals concurrently performed on this object store in a single IO node.<br>Possible values: <code>1</code>-<code>64</code></p>                                                                                       |
| `enable-upload-tags`       | <p>Determines whether to enable <a href="../tiering/data-management-in-tiered-filesystems.md#object-tagging">object-tagging</a> or not. To use as a default for added buckets.<br>Possible values: <code>true</code>,<code>false</code></p> |

### View object store buckets

**Command:** `weka fs tier s3`

Use this command to view information on all the object-store buckets configured to the WEKA system.

## Add an object store bucket

**Command:** `weka fs tier s3 add`

Use the following command line to add an object store:

`weka fs tier s3 add <name> [--site site] [--obs-name obs-name] [--hostname=<hostname>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--remove-bandwidth=<remove-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

| Name                 | Description                                                                                                                                                                                                                                 | Default                                                                                  |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `name`\*             | Name of the object store to edit.                                                                                                                                                                                                           | ​                                                                                        |
| `site`               | <p><code>local</code> - for tiering+snapshots, <br><code>remote</code> - for snapshots only.<br>It must be  the same as the object store site it is added to <code>(obs-name)</code>.</p>                                                   | `local`                                                                                  |
| `obs-name`           | Name of the existing object store to add this object-store bucket to.                                                                                                                                                                       | If there is only one object-store of type mentioned in `site` it is chosen automatically |
| `hostname` \*        | <p>Object store host identifier or IP.<br>Mandatory, if not specified at the object store level.</p>                                                                                                                                        | The `hostname` specified in `obs-name` if present                                        |
| `port`               | A valid object store port.                                                                                                                                                                                                                  | The `port` specified in `obs-name` if present,  otherwise 80                             |
| `bucket`             | A valid object store bucket name.                                                                                                                                                                                                           |                                                                                          |
| `auth-method` \*     | <p>Authentication method.<br>Possible values: <code>None</code>, <code>AWSSignature2</code>, <code>AWSSignature4</code>.<br>Mandatory, if not specified in the object-store level .</p>                                                     | The `auth-method` specified in `obs-name` if present                                     |
| `region` \*          | <p>Region name.<br>Mandatory, if not specified in the object-store level .</p>                                                                                                                                                              | The `region` specified in `obs-name` if present                                          |
| `access-key-id` \*   | <p>Object store bucket access key ID.<br>Mandatory, if not specified in the object-store level (can be left empty when using IAM role in AWS).</p>                                                                                          | The `access-key-id` specified in `obs-name` if present                                   |
| `secret-key` \*      | <p>Object store bucket secret key.<br>Mandatory, if not specified in the object-store level (can be left empty when using IAM role in AWS).</p>                                                                                             | The `secret-key` specified in `obs-name` if present                                      |
| `protocol`           | <p>Protocol type to be used.<br>Possible values: <code>HTTP</code>, <code>HTTPS</code> or <code>HTTPS_UNVERIFIED</code>.</p>                                                                                                                | The `protocol` specified in `obs-name` if present, otherwise`HTTP`                       |
| `bandwidth`          | Bucket bandwidth limitation per core (Mbps).                                                                                                                                                                                                |                                                                                          |
| `download-bandwidth` | Bucket download bandwidth limitation per core (Mbps)                                                                                                                                                                                        |                                                                                          |
| `upload-bandwidth`   | Bucket upload bandwidth limitation per core (Mbps)                                                                                                                                                                                          |                                                                                          |
| `remove-bandwidth`   | <p>A bandwidth (Mbps) to limit the throughput of delete requests sent to the object store.<br>Setting a bandwidth equal to or lower than the object store deletion throughput prevents an increase in the object store deletions queue.</p> |                                                                                          |
| `errors-timeout`     | <p>If the object-store link is down longer than this timeout period, all IOs that need data return an error.<br>Possible values: 1m-15m, or 60s-900s.<br>For example, 300s.</p>                                                             | 300s                                                                                     |
| `prefetch-mib`       | The data size (MiB) to prefetch when reading a whole MiB on the object store.                                                                                                                                                               | 0                                                                                        |
| `enable-upload-tags` | <p>Whether to enable <a href="../tiering/data-management-in-tiered-filesystems.md#object-tagging">object-tagging</a> or not.<br>Possible values: <code>true</code> or <code>false</code></p>                                                | `false`                                                                                  |

{% hint style="info" %}
**Note:** When using the CLI, by default a misconfigured object store will not be created. To create an object store even when it is misconfigured, use the `--skip-verification`option.
{% endhint %}

{% hint style="warning" %}
**Note:** The `max-concurrent` settings are applied per Weka compute process and the minimum setting of all object stores is applied.
{% endhint %}

Make the relevant changes and click Update to update the object store bucket.

## Edit an object store bucket

**Command:** `weka fs tier s3 update`

Use the following command line to edit an object-store bucket:

`weka fs tier s3 update <name> [--new-name=<new-name>] [--new-obs-name new-obs-name] [--hostname=<hostname>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--remove-bandwidth=<remove-bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

| Name                 | Value                                                                                                                                                                                                                                       |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*             | A valid name of the object store bucket to edit.                                                                                                                                                                                            |
| `new-name`           | New name for the object-store bucket                                                                                                                                                                                                        |
| `new-obs-name`       | A new object store name to add this object-store bucket to. It must be an existing object store with the same `site` value.                                                                                                                 |
| `hostname`           | Object store host identifier or IP.                                                                                                                                                                                                         |
| `port`               | A valid object store port                                                                                                                                                                                                                   |
| `bucket`             | A valid object store bucket name                                                                                                                                                                                                            |
| `auth-method`        | <p>Authentication method.<br>Possible values: <code>None</code>, <code>AWSSignature2</code> or <code>AWSSignature4</code></p>                                                                                                               |
| `region`             | Region name                                                                                                                                                                                                                                 |
| `access-key-id`      | Object-store bucket access key ID                                                                                                                                                                                                           |
| `secret-key`         | Object-store bucket secret key                                                                                                                                                                                                              |
| `protocol`           | <p>Protocol type to be used.<br>Possible values: <code>HTTP</code>, <code>HTTPS</code> or <code>HTTPS_UNVERIFIED</code></p>                                                                                                                 |
| `bandwidth`          | Bandwidth limitation per core (Mbps)                                                                                                                                                                                                        |
| `download-bandwidth` | Bucket download bandwidth limitation per core (Mbps)                                                                                                                                                                                        |
| `upload-bandwidth`   | Bucket upload bandwidth limitation per core (Mbps)                                                                                                                                                                                          |
| `remove-bandwidth`   | <p>A bandwidth (Mbps) to limit the throughput of delete requests sent to the object store.<br>Setting a bandwidth equal to or lower than the object store deletion throughput prevents an increase in the object store deletions queue.</p> |
| `errors-timeout`     | <p>If the object store link is down longer than this timeout period, all IOs that need data return an error.<br>Possible values: 1m-15m, or 60s-900s.<br>For example, 300s.</p>                                                             |
| `prefetch-mib`       | The data size in MiB to prefetch when reading a whole MiB on the object store                                                                                                                                                               |
| `enable-upload-tags` | <p>Whether to enable <a href="../tiering/data-management-in-tiered-filesystems.md#object-tagging">object-tagging</a> or not.<br>Possible values: <code>true</code>, <code>false</code></p>                                                  |

## List recent operations of an object store bucket

**Command:** `weka fs tier ops`

Use the following command line to list the recent operations running on an object store:

`weka fs tier ops <name> [--format format] [--output output]...[--sort sort]...[--filter filter]...[--raw-units] [--UTC] [--no-header] [--verbose]`

**Parameters**

| Name        | Value                                                                                                                                                                                                                                                                                                                                                                      | Default     |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `name`\*    | A valid object store bucket name to show its recent operations.                                                                                                                                                                                                                                                                                                            | ​           |
| `format`    | <p>Specify the output format.<br>Possible values:                         <code>view</code>, <code>csv</code>, <code>markdown</code>, <code>json</code>, or <code>oldview</code></p>                                                                                                                                                                                       | `view`      |
| `output`    | <p>Specify the columns in the output.<br>Possible values: <br><code>node</code>, <code>obsBucket</code>, <code>key</code>, <code>type</code>, <code>execution</code>, <code>phase</code>, <code>previous</code>, <code>start</code>, <code>size</code>, <code>results</code>, <code>errors</code>, <code>lastHTTP</code>, <code>concurrency</code>, <code>inode</code></p> | All columns |
| `sort`      | Specify the column(s) to consider when sorting the output. For the sorting order, ascending or descending, add - or + signs respectively before the column name.                                                                                                                                                                                                           |             |
| `filter`    | Specify the values to filter by in a specific column. Usage:                           `column1=val1[,column2=val2[,..]]`                                                                                                                                                                                                                                                  |             |
| `raw-units` | <p>Print values in a readable format of raw units such as bytes and seconds.<br>Possible value examples: <code>1KiB</code> <code>234MiB</code> <code>2GiB</code>.                           </p>                                                                                                                                                                           |             |
| `no-header` | Don't show column headers in the output,                                                                                                                                                                                                                                                                                                                                   |             |
| `verbose`   | Show all columns in the output.                                                                                                                                                                                                                                                                                                                                            |             |

## Delete an object store bucket

**Command:** `weka fs tier s3 delete`

Use the following command line to delete an object store bucket:

`weka fs tier s3 delete <name>`

**Parameters**

| Name     | Value                                              |
| -------- | -------------------------------------------------- |
| `name`\* | A valid name of the object store bucket to delete. |
