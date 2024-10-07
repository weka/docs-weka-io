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

Use this command to view information on all the object stores configured to the WEKA system.

{% hint style="info" %}
Using the GUI, only object store buckets are present. Adding an object store bucket only adds to the present `local` or `remote` object store. If more than one is present (such as during the time recovering from a remote snapshot), use the CLI.
{% endhint %}

## Edit an object store

**Command:** `weka fs tier obs update`

Use the following command line to edit an object store:

`weka fs tier obs update <name> [--new-name new-name] [--site site] [--hostname=<hostname>] [--port=<port>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--remove-bandwidth=<remove-bandwidth>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>] [--enable-upload-tags=<enable-upload-tags>]`

**Parameters**

<table><thead><tr><th width="293">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code> *</td><td>Name of the object store to create.</td></tr><tr><td><code>new-name</code></td><td>New name for the object store. </td></tr><tr><td><code>site</code></td><td>Site location of the object store.<br>Possible values:<br><code>local</code> - for tiering+snapshots<br><code>remote</code> - for snapshots only</td></tr><tr><td><code>hostname</code></td><td>Object store host identifier (hostname or IP address) to use as a default for added buckets.</td></tr><tr><td><code>port</code></td><td>Object store port, to be used as a default for added buckets.</td></tr><tr><td><code>auth-method</code></td><td>Authentication method to use as a default for added buckets.<br>Possible values: <code>None</code>,<code>AWSSignature2</code>,<code>AWSSignature4</code></td></tr><tr><td><code>region</code></td><td>Region name to use as a default for added buckets.</td></tr><tr><td><code>access-key-id</code></td><td>Object store access key ID to use as a default for added buckets.</td></tr><tr><td><code>secret-key</code></td><td>Object store secret key to use as a default for added buckets.</td></tr><tr><td><code>protocol</code></td><td>Protocol type to use as a default for added buckets.<br>Possible values: <code>HTTP</code>,<code>HTTPS</code>,<code>HTTPS_UNVERIFIED</code></td></tr><tr><td><code>bandwidth</code></td><td>Bandwidth limitation per core (Mbps).</td></tr><tr><td><code>download-bandwidth</code></td><td>Object store download bandwidth limitation per core (Mbps).</td></tr><tr><td><code>upload-bandwidth</code></td><td>Object store upload bandwidth limitation per core (Mbps).</td></tr><tr><td><code>remove-bandwidth</code></td><td>A bandwidth (Mbps) to limit the throughput of delete requests sent to the object store.<br>Setting a bandwidth equal to or lower than the object store deletion throughput prevents an increase in the object store deletions queue.</td></tr><tr><td><code>max-concurrent-downloads</code></td><td>Maximum number of downloads concurrently performed on this object store in a single IO node.<br>Possible values: <code>1</code>-<code>64</code></td></tr><tr><td><code>max-concurrent-uploads</code></td><td>Maximum number of uploads concurrently performed on this object store in a single IO node.<br>Possible values: <code>1</code>-<code>64</code></td></tr><tr><td><code>max-concurrent-removals</code></td><td>Maximum number of removals concurrently performed on this object store in a single IO node.<br>Possible values: <code>1</code>-<code>64</code></td></tr><tr><td><code>enable-upload-tags</code></td><td>Determines whether to enable <a href="../tiering/data-management-in-tiered-filesystems.md#object-tagging">object-tagging</a> or not. To use as a default for added buckets.<br>Possible values: <code>true</code>,<code>false</code></td></tr></tbody></table>

## View object store buckets

**Command:** `weka fs tier s3`

Use this command to view information on all the object store buckets configured to the WEKA system.

## Add an object store bucket

**Command:** `weka fs tier s3 add`

Use the following command line to add an S3 object store:

`weka fs tier s3 add <name> [--site site] [--obs-name obs-name] [--hostname=<hostname>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--remove-bandwidth=<remove-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--enable-upload-tags=<enable-upload-tags>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>] [--max-extents-in-data-blob=<max-extents-in-data-blob>] [--max-data-blob-size=<max-data-blob-size>] [--sts-operation-type=<sts-operation-type>] [--sts-role-arn=<sts-role-arn>] [--sts-role-session-name=<sts-role-session-name>] [--sts-session-duration=<sts-session-duration>]`

**Parameters**

<table><thead><tr><th width="236">Name</th><th width="337">Description</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the object store to edit.</td><td>​</td></tr><tr><td><code>site</code></td><td><code>local</code> - for tiering+snapshots, <br><code>remote</code> - for snapshots only.<br>It must be  the same as the object store site it is added to <code>(obs-name)</code>.</td><td><code>local</code></td></tr><tr><td><code>obs-name</code></td><td>Name of the existing object store to add this object store bucket to.</td><td>If there is only one object store of type mentioned in <code>site</code> it is chosen automatically</td></tr><tr><td><code>hostname</code> *</td><td>Object store host identifier or IP.<br>Mandatory, if not specified at the object store level.</td><td>The <code>hostname</code> specified in <code>obs-name</code> if present</td></tr><tr><td><code>port</code></td><td>A valid object store port.</td><td>The <code>port</code> specified in <code>obs-name</code> if present,  otherwise 80</td></tr><tr><td><code>bucket</code></td><td>A valid object store bucket name.</td><td></td></tr><tr><td><code>auth-method</code> *</td><td>Authentication method.<br>Possible values: <code>None</code>, <code>AWSSignature2</code>, <code>AWSSignature4</code>.<br>Mandatory, if not specified in the object store level .</td><td>The <code>auth-method</code> specified in <code>obs-name</code> if present</td></tr><tr><td><code>region</code> *</td><td>Region name.<br>Mandatory, if not specified in the object store level .</td><td>The <code>region</code> specified in <code>obs-name</code> if present</td></tr><tr><td><code>access-key-id</code> *</td><td>Object store bucket access key ID.<br>Mandatory, if not specified in the object store level (can be left empty when using IAM role in AWS or GCP).</td><td>The <code>access-key-id</code> specified in <code>obs-name</code> if present</td></tr><tr><td><code>secret-key</code> *</td><td>Object store bucket secret key.<br>Mandatory, if not specified in the object store level (can be left empty when using IAM role in AWS  or GCP).</td><td>The <code>secret-key</code> specified in <code>obs-name</code> if present</td></tr><tr><td><code>protocol</code></td><td>Protocol type to be used.<br>Possible values: <code>HTTP</code>, <code>HTTPS</code> or <code>HTTPS_UNVERIFIED</code>.</td><td>The <code>protocol</code> specified in <code>obs-name</code> if present, otherwise<code>HTTP</code> </td></tr><tr><td><code>bandwidth</code></td><td>Bucket bandwidth limitation per core (Mbps).</td><td></td></tr><tr><td><code>download-bandwidth</code></td><td>Bucket download bandwidth limitation per core (Mbps)</td><td></td></tr><tr><td><code>upload-bandwidth</code></td><td>Bucket upload bandwidth limitation per core (Mbps)</td><td></td></tr><tr><td><code>remove-bandwidth</code></td><td>A bandwidth (Mbps) to limit the throughput of delete requests sent to the object store.<br>Setting a bandwidth equal to or lower than the object store deletion throughput prevents an increase in the object store deletions queue.</td><td></td></tr><tr><td><code>errors-timeout</code></td><td>If the object store link is down longer than this timeout period, all IOs that need data return an error.<br>Possible values: <code>1m</code>-<code>15m</code>, or <code>60s</code>-<code>900s</code>.<br>For example, <code>300s</code>.</td><td><code>300s</code></td></tr><tr><td><code>prefetch-mib</code></td><td>The data size (MiB) to prefetch when reading a whole MiB on the object store.</td><td><code>128</code></td></tr><tr><td><code>enable-upload-tags</code></td><td>Whether to enable <a href="../tiering/data-management-in-tiered-filesystems.md#object-tagging">object-tagging</a> or not.<br>Possible values: <code>true</code> or <code>false</code></td><td><code>false</code></td></tr><tr><td><code>max-concurrent-downloads</code></td><td><p>Maximum number of downloads we concurrently perform on this object store in a single IO node.</p><p>Possible values: <code>1</code>-<code>64</code></p></td><td></td></tr><tr><td><code>max-concurrent-uploads</code></td><td><p>Maximum number of uploads we concurrently perform on this object store in a single IO node.</p><p>Possible values: <code>1</code>-<code>64</code></p></td><td></td></tr><tr><td><code>max-concurrent-removals</code></td><td><p>Maximum number of removals we concurrently perform on this object store in a single IO node.</p><p>Possible values: <code>1</code>-<code>64</code></p></td><td></td></tr><tr><td><code>max-extents-in-data-blob</code></td><td>Maximum number of extents' data to upload to an object store data blob.</td><td></td></tr><tr><td><code>max-data-blob-size</code></td><td><p>Maximum size to upload to an object store data blob.</p><p>Format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB.</p></td><td></td></tr><tr><td><code>sts-operation-type</code></td><td><p>AWS <a data-footnote-ref href="#user-content-fn-1">STS</a> operation type to use.</p><p>Possible values: <code>assume_role</code> or <code>none</code></p></td><td><code>none</code></td></tr><tr><td><code>sts-role-arn</code></td><td>The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting <code>sts-operation</code> to <code>assume_role</code>.</td><td></td></tr><tr><td><code>sts-role-session</code></td><td>A unique identifier for the assumed role session.<br>The length must be between 2 and 64 characters. Allowed characters include alphanumeric characters (upper and lower case), underscore (_), equal sign (=), comma (,), period (.), at symbol (@), and hyphen (-). Space is not allowed.</td><td></td></tr><tr><td><code>sts-session-duration</code></td><td><p>The duration of the temporary security credentials in seconds.</p><p>Possible values: <code>900</code> - <code>43200</code>.</p></td><td><code>3600</code></td></tr></tbody></table>

{% hint style="info" %}
When using the CLI, by default a misconfigured object store are not created. To create an object store even when it is misconfigured, use the `--skip-verification` option.
{% endhint %}

{% hint style="warning" %}
The `max-concurrent` settings are applied per WEKA compute process and the minimum setting of all object stores is applied.
{% endhint %}

{% hint style="success" %}
When you create the object store bucket in AWS, to use the storage classes: S3 Intelligent-Tiering, S3 Standard-IA, S3 One Zone-IA, and S3 Glacier Instant Retrieval, do the following:

1. Create the bucket in S3 Standard.
2. Create an AWS lifecycle policy to transition objects to these storage classes.
3. Make the relevant changes and click **Update** to update the object store bucket.
{% endhint %}

## Edit an object store bucket

**Command:** `weka fs tier s3 update`

Use the following command line to edit an object store bucket:

`weka fs tier s3 update <name> [--new-name=<new-name>] [--new-obs-name new-obs-name] [--hostname=<hostname>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--download-bandwidth=<download-bandwidth>] [--upload-bandwidth=<upload-bandwidth>] [--remove-bandwidth=<remove-bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--enable-upload-tags=<enable-upload-tags>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>] [--max-extents-in-data-blob=<max-extents-in-data-blob>] [--max-data-blob-size=<max-data-blob-size>] [--sts-operation-type=<sts-operation-type>] [--sts-role-arn=<sts-role-arn>] [--sts-role-session-name=<sts-role-session-name>] [--sts-session-duration=<sts-session-duration>]`

**Parameters**

| Name                       | Value                                                                                                                                                                                                                                                                                              |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                   | A valid name of the object store bucket to edit.                                                                                                                                                                                                                                                   |
| `new-name`                 | New name for the object store bucket                                                                                                                                                                                                                                                               |
| `new-obs-name`             | A new object store name to add this object store bucket to. It must be an existing object store with the same `site` value.                                                                                                                                                                        |
| `hostname`                 | Object store host identifier or IP.                                                                                                                                                                                                                                                                |
| `port`                     | A valid object store port                                                                                                                                                                                                                                                                          |
| `bucket`                   | A valid object store bucket name                                                                                                                                                                                                                                                                   |
| `auth-method`              | <p>Authentication method.<br>Possible values: <code>None</code>, <code>AWSSignature2</code> or <code>AWSSignature4</code></p>                                                                                                                                                                      |
| `region`                   | Region name                                                                                                                                                                                                                                                                                        |
| `access-key-id`            | Object store bucket access key ID                                                                                                                                                                                                                                                                  |
| `secret-key`               | Object store bucket secret key                                                                                                                                                                                                                                                                     |
| `protocol`                 | <p>Protocol type to be used.<br>Possible values: <code>HTTP</code>, <code>HTTPS</code> or <code>HTTPS_UNVERIFIED</code></p>                                                                                                                                                                        |
| `bandwidth`                | Bandwidth limitation per core (Mbps)                                                                                                                                                                                                                                                               |
| `download-bandwidth`       | Bucket download bandwidth limitation per core (Mbps)                                                                                                                                                                                                                                               |
| `upload-bandwidth`         | Bucket upload bandwidth limitation per core (Mbps)                                                                                                                                                                                                                                                 |
| `remove-bandwidth`         | <p>A bandwidth (Mbps) to limit the throughput of delete requests sent to the object store.<br>Setting a bandwidth equal to or lower than the object store deletion throughput prevents an increase in the object store deletions queue.</p>                                                        |
| `errors-timeout`           | <p>If the object store link is down longer than this timeout period, all IOs that need data return an error.<br>Possible values: <code>1m</code>-<code>15m</code>, or <code>60s</code>-<code>900s</code>.<br>For example, <code>300s</code>.</p>                                                   |
| `prefetch-mib`             | The data size in MiB to prefetch when reading a whole MiB on the object store                                                                                                                                                                                                                      |
| `enable-upload-tags`       | <p>Whether to enable <a href="../tiering/data-management-in-tiered-filesystems.md#object-tagging">object-tagging</a> or not.<br>Possible values: <code>true</code>, <code>false</code></p>                                                                                                         |
| `max-concurrent-downloads` | <p>Maximum number of downloads we concurrently perform on this object store in a single IO node.</p><p>Possible values: <code>1</code>-<code>64</code></p>                                                                                                                                         |
| `max-concurrent-uploads`   | <p>Maximum number of uploads we concurrently perform on this object store in a single IO node.</p><p>Possible values: <code>1</code>-<code>64</code></p>                                                                                                                                           |
| `max-concurrent-removals`  | <p>Maximum number of removals we concurrently perform on this object store in a single IO node.</p><p>Possible values: <code>1</code>-<code>64</code></p>                                                                                                                                          |
| `max-extents-in-data-blob` | Maximum number of extents' data to upload to an object store data blob.                                                                                                                                                                                                                            |
| `max-data-blob-size`       | <p>Maximum size to upload to an object store data blob.</p><p>Format: capacity in decimal or binary units: 1B, 1KB, 1MB, 1GB, 1TB, 1PB, 1EB, 1KiB, 1MiB, 1GiB, 1TiB, 1PiB, 1EiB.</p>                                                                                                               |
| `sts-operation-type`       | <p>AWS <a data-footnote-ref href="#user-content-fn-2">STS</a> operation type to use.</p><p>Possible values: <code>assume_role</code> or <code>none</code></p>                                                                                                                                      |
| `sts-role-arn`             | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting `sts-operation` to `assume_role`.                                                                                                                                                                                     |
| `sts-role-session`         | <p>A unique identifier for the assumed role session.<br>The length must be between 2 and 64 characters. Allowed characters include alphanumeric characters (upper and lower case), underscore (_), equal sign (=), comma (,), period (.), at symbol (@), and hyphen (-). Space is not allowed.</p> |
| `sts-session-duration`     | <p>The duration of the temporary security credentials in seconds.</p><p>Possible values: <code>900</code> - <code>43200</code>.</p>                                                                                                                                                                |

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

<table><thead><tr><th width="197">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>A valid name of the object store bucket to delete.</td></tr></tbody></table>

[^1]: WEKA supports the AWS Security Token Service (STS) that enables you to request temporary, limited-privilege credentials for users using the [AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API\_AssumeRole.html) API.

[^2]: WEKA supports the AWS Security Token Service (STS) that enables you to request temporary, limited-privilege credentials for users using the [AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API\_AssumeRole.html) API.
