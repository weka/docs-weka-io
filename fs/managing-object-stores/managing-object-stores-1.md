---
description: This page describes how to view and manage object stores using the CLI.
---

# Manage object stores using the CLI

Using the CLI, you can perform the following actions:

* [View object stores](managing-object-stores-1.md#view-object-stores)
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
**Note:** Using the GUI only object-store buckets are present. Adding an object-store bucket will add it to the only `local` or `remote` object-store present. If more than one is present (such as during the time recovering from a remote snapshot), the CLI should be used.
{% endhint %}

## Edit an object store

**Command:** `weka fs tier obs update`

Use the following command line to edit an object store:

`weka fs tier obs update <name> [--new-name new-name] [--site site] [--hostname=<hostname>] [--port=<port>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

| **Name**                   | **Type** | **Value**                                                                                                                                                | **Limitations**                            | **Mandatory** | **Default** |
| -------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ | ------------- | ----------- |
| `name`                     | String   | Name of the object store being created                                                                                                                   | Must be a valid name                       | Yes           | ​           |
| `new-name`                 | String   | New name for the object store                                                                                                                            | Must be a valid name                       | No            |             |
| `site`                     | String   | `local` - for tiering+snapshots, `remote` - for snapshots only                                                                                           | `local` or `remote`                        | No            |             |
| `hostname`                 | String   | Object store host identifier, to be used as a default for added buckets                                                                                  | Must be a valid name/IP                    | No            |             |
| `port`                     | String   | Object store port, to be used as a default for added buckets                                                                                             | Must be a valid name                       | No            |             |
| `auth-method`              | String   | Authentication method, to be used as a default for added buckets                                                                                         | `None`, `AWSSignature2` or `AWSSignature4` | No            |             |
| `region`                   | String   | Region name, to be used as a default for added buckets                                                                                                   |                                            | No            |             |
| `access-key-id`            | String   | Object store  access key ID, to be used as a default for added buckets                                                                                   |                                            | No            |             |
| `secret-key`               | String   | Object store  secret key, to be used as a default for added buckets                                                                                      |                                            | No            |             |
| `protocol`                 | String   | Protocol type, to be used as a default for added buckets                                                                                                 | `HTTP`, `HTTPS` or `HTTPS_UNVERIFIED`      | No            |             |
| `bandwidth`                | Number   | Bandwidth limitation per core (Mbps)                                                                                                                     |                                            | No            |             |
| `download-bandwidth`       | Number   | Object-store download bandwidth limitation per core (Mbps)                                                                                               |                                            | No            |             |
| `upload-bandwidth`         | Number   | Object-store upload bandwidth limitation per core (Mbps)                                                                                                 |                                            | No            |             |
| `max-concurrent-downloads` | Number   | Maximum number of downloads concurrently performed on this object store in a single IO node                                                              | 1-64                                       | No            |             |
| `max-concurrent-uploads`   | Number   | Maximum number of uploads concurrently performed on this object store in a single IO node                                                                | 1-64                                       | No            |             |
| `max-concurrent-removals`  | Number   | Maximum number of removals concurrently performed on this object store in a single IO node                                                               | 1-64                                       | No            |             |
| `enable-upload-tags`       | String   | Whether to enable [object-tagging](../tiering/data-management-in-tiered-filesystems.md#object-tagging) or not, to be used as a default for added buckets | `true` or `false`                          | No            |             |

### View object store buckets

**Command:** `weka fs tier s3`

This command is used to view information on all the object-store buckets configured to the WEKA system.

## Add an object store bucket

**Command:** `weka fs tier s3 add`

Use the following command line to add an object store:

`weka fs tier s3 add <name> [--site site] [--obs-name obs-name] [--hostname=<hostname>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

| **Name**             | **Type** | **Value**                                                                                                         | **Limitations**                                                        | **Mandatory**                                                                                  | **Default**                                                                              |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `name`               | String   | Name of the object-store bucket being created                                                                     | Must be a valid name                                                   | Yes                                                                                            | ​                                                                                        |
| `site`               | String   | `local` - for tiering+snapshots, `remote` - for snapshots only                                                    | Must be  the same as the object store site it is added to `(obs-name)` | No                                                                                             | `local`                                                                                  |
| `obs-name`           | String   | Name of the object-store to add  this object-store bucket to                                                      | Must be an existing object-store                                       | No                                                                                             | If there is only one object-store of type mentioned in `site` it is chosen automatically |
| `hostname`           | String   | Object store host identifier                                                                                      | Must be a valid name/IP                                                | Yes, if not specified in the object-store level                                                | The `hostname` specified in `obs-name` if present                                        |
| `port`               | String   | Object store port                                                                                                 | Must be a valid name                                                   | No                                                                                             | The `port` specified in `obs-name` if present,  otherwise 80                             |
| `bucket`             | String   | Object store bucket name                                                                                          | Must be a valid name                                                   | Yes                                                                                            |                                                                                          |
| `auth-method`        | String   | Authentication method                                                                                             | `None`, `AWSSignature2` or `AWSSignature4`                             | Yes, if not specified in the object-store level                                                | The `auth-method` specified in `obs-name` if present                                     |
| `region`             | String   | Region name                                                                                                       |                                                                        | Yes, if not specified in the object-store level                                                | The `region` specified in `obs-name` if present                                          |
| `access-key-id`      | String   | Object store bucket access key ID                                                                                 |                                                                        | Yes, if not specified in the object-store level (can be left empty when using IAM role in AWS) | The `access-key-id` specified in `obs-name` if present                                   |
| `secret-key`         | String   | Object store bucket secret key                                                                                    |                                                                        | Yes, if not specified in the object-store level (can be left empty when using IAM role in AWS) | The `secret-key` specified in `obs-name` if present                                      |
| `protocol`           | String   | Protocol type to be used                                                                                          | `HTTP`, `HTTPS` or `HTTPS_UNVERIFIED`                                  | No                                                                                             | The `protocol` specified in `obs-name` if present, otherwise`HTTP`                       |
| `bandwidth`          | Number   | Bucket bandwidth limitation per core (Mbps)                                                                       |                                                                        | No                                                                                             |                                                                                          |
| `download-bandwidth` | Number   | Bucket download bandwidth limitation per core (Mbps)                                                              |                                                                        | No                                                                                             |                                                                                          |
| `upload-bandwidth`   | Number   | Bucket upload bandwidth limitation per core (Mbps)                                                                |                                                                        | No                                                                                             |                                                                                          |
| `errors-timeout`     | Number   | If the object-store link is down for longer than this timeout period, all IOs that need data return with an error | 1-15 minutes, e.g: 5m or 300s                                          | No                                                                                             | 300                                                                                      |
| `prefetch-mib`       | Number   | How many MiB of data to prefetch when reading a whole MiB on the object store                                     |                                                                        | No                                                                                             | 0                                                                                        |
| `enable-upload-tags` | String   | Whether to enable [object-tagging](../tiering/data-management-in-tiered-filesystems.md#object-tagging) or not     | `true` or `false`                                                      | No                                                                                             | `false`                                                                                  |

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

`weka fs tier s3 update <name> [--new-name=<new-name>] [--new-obs-name new-obs-name] [--hostname=<hostname>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

| **Name**             | **Type** | **Value**                                                                                                         | **Limitations**                                               | **Mandatory** | **Default** |
| -------------------- | -------- | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- | ------------- | ----------- |
| `name`               | String   | Name of the object-store bucket being edited                                                                      | Must be a valid name                                          | Yes           | ​           |
| `new-name`           | String   | New name for the object-store bucket                                                                              | Must be a valid name                                          | No            |             |
| `new-obs-name`       | String   | New name of the object-store to add  this object-store bucket to                                                  | Must be an existing object-store, with the same `site` value. | No            |             |
| `hostname`           | String   | Object store host identifier                                                                                      | Must be a valid name/IP                                       | No            |             |
| `port`               | String   | Object store port                                                                                                 | Must be a valid name                                          | No            |             |
| `bucket`             | String   | Object store bucket name                                                                                          | Must be a valid name                                          | No            |             |
| `auth-method`        | String   | Authentication method                                                                                             | `None`, `AWSSignature2` or `AWSSignature4`                    | No            |             |
| `region`             | String   | Region name                                                                                                       |                                                               | No            |             |
| `access-key-id`      | String   | Object-store bucket access key ID                                                                                 |                                                               | No            |             |
| `secret-key`         | String   | Object-store bucket secret key                                                                                    |                                                               | No            |             |
| `protocol`           | String   | Protocol type to be used                                                                                          | `HTTP`, `HTTPS` or `HTTPS_UNVERIFIED`                         | No            |             |
| `bandwidth`          | Number   | Bandwidth limitation per core (Mbps)                                                                              |                                                               | No            |             |
| `download-bandwidth` | Number   | Bucket download bandwidth limitation per core (Mbps)                                                              |                                                               | No            |             |
| `upload-bandwidth`   | Number   | Bucket upload bandwidth limitation per core (Mbps)                                                                |                                                               | No            |             |
| `errors-timeout`     | Number   | If the object-store link is down for longer than this timeout period, all IOs that need data return with an error | 1-15 minutes, e.g: 5m or 300s                                 | No            |             |
| `prefetch-mib`       | Number   | How many MiB of data to prefetch when reading a whole MiB on the object store                                     |                                                               | No            |             |
| `enable-upload-tags` | String   | Whether to enable [object-tagging](../tiering/data-management-in-tiered-filesystems.md#object-tagging) or not     | `true` or `false`                                             | No            |             |

## List recent operations of an object store bucket

**Command:** `weka fs tier ops`

Use the following command line to list the recent operations running on an object store:

`weka fs tier ops <name> [--format format] [--output output]...[--sort sort]...[--filter filter]...[--raw-units] [--UTC] [--no-header] [--verbose]`

**Parameters**

| **Name**    | **Type** | **Value**                                                                                                                                                        | **Limitations**                                                                                                                                                                                                                                                                                                                       | **Mandatory** | **Default**                                           |
| ----------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------------------------------------------------- |
| `name`      | String   | Name of the object store bucket to show its recent operations.                                                                                                   | Must be a valid name                                                                                                                                                                                                                                                                                                                  | Yes           | ​                                                     |
| `format`    | String   | Specify the output format.                                                                                                                                       | Available options:                         `view`, `csv`, `markdown`, `json`, or `oldview`                                                                                                                                                                                                                                            | No            | `view`                                                |
| `output`    | String   | Specify the columns in the output.                                                                                                                               | <p>Available columns:<br><code>node</code>, <code>obsBucket</code>, <code>key</code>, <code>type</code>, <code>execution</code>, <code>phase</code>, <code>previous</code>, <code>start</code>, <code>size</code>, <code>results</code>, <code>errors</code>, <code>lastHTTP</code>, <code>concurrency</code>, <code>inode</code></p> | No            | All columns                                           |
| `sort`      | String   | Specify the column(s) to consider when sorting the output. For the sorting order, ascending or descending, add - or + signs respectively before the column name. |                                                                                                                                                                                                                                                                                                                                       | No            |                                                       |
| `filter`    | String   | Specify the values to filter by in a specific column. Usage:                           `column1=val1[,column2=val2[,..]]`                                        |                                                                                                                                                                                                                                                                                                                                       |               |                                                       |
| `raw-units` | Boolean  | <p>Print values in raw units such as bytes, and seconds.</p><p>                           </p>                                                                   |                                                                                                                                                                                                                                                                                                                                       | No            | Human-readable format, for example, 1KiB 234MiB 2GiB. |
| `no-header` | Boolean  | Don't show column headers in the output,                                                                                                                         |                                                                                                                                                                                                                                                                                                                                       | No            |                                                       |
| `verbose`   | Boolean  | Show all columns in the output.                                                                                                                                  |                                                                                                                                                                                                                                                                                                                                       | No            |                                                       |

## Delete an object store bucket

**Command:** `weka fs tier s3 delete`

Use the following command line to delete an object-store bucket:

`weka fs tier s3 delete <name>`

**Parameters**

<table data-header-hidden><thead><tr><th>Name</th><th width="113">Type</th><th width="180">Value</th><th>Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>name</code></td><td>String</td><td>Name of the object store bucket to delete.</td><td>Must be a valid name</td><td>Yes</td><td>​</td></tr></tbody></table>

