---
description: View and configure object stores and object store buckets using the CLI.
---

# Manage object stores using the CLI

## View object stores

Lists the object stores configured on the cluster, with the connection settings, bucket counts, and per-core transfer limits of each.

**Command:** `weka fs tier obs`

```sh
weka fs tier obs [--name <string>]
```

**Parameters**

| Parameter          | Description                                |
| --- | --- |
| `--name` \<string> | Show only the object store with this name. |

{% hint style="info" %}
Using the GUI, only object store buckets are present. Adding an object store bucket only adds to the present `local` or `remote` object store. If more than one is present (such as during the time recovering from a remote snapshot), use the CLI.
{% endhint %}

## Edit an object store

Changes an existing object store's endpoint, credentials, protocol, or transfer limits. These settings apply as the defaults for buckets added to this object store.

**Command:** `weka fs tier obs update`

```sh
weka fs tier obs update <name> [--access-key-id <string>] [--auth-method <s3-auth-method>] [--bandwidth <uint>] [--download-bandwidth <uint>] [--enable-upload-tags] [--hostname <string>] [--max-concurrent-downloads <uint8>] [--max-concurrent-removals <uint8>] [--max-concurrent-uploads <uint8>] [--max-data-blob-size <capacity>] [--max-extents-in-data-blob <uint>] [--new-name <string>] [--obs-type <obs-type>] [--port <uint16>] [--protocol <obs-http-protocol>] [--region <string>] [--remove-bandwidth <uint>] [--secret-key <string>] [--sts-operation-type <sts-operation>] [--sts-role-arn <string>] [--sts-role-session-name <string>] [--sts-session-duration <duration>] [--upload-bandwidth <uint>] [--upload-memory-limit <capacity>]
```

**Parameters**

| Parameter                               | Description                                                                                                 |
| --- | --- |
| `name`\* | Name of the object store. |
| `--access-key-id` \<string> | Access key used for AWS Signature authentications. |
| `--auth-method` \<s3-auth-method> | Authentication method. Possible values: `None`,`AWSSignature2`,`AWSSignature4` |
| `--bandwidth` \<uint> | Bandwidth limitation. Value is per core (Mbps). |
| `--download-bandwidth` \<uint> | Download bandwidth limitation. Value is per core (Mbps). |
| `--enable-upload-tags` | Enable tagging of uploaded objects. For details, see [Object tagging](../tiering.md#object-tagging). Possible values: `true`,`false` |
| `--hostname` \<string> | Hostname or IP address of object store. |
| `--max-concurrent-downloads` \<uint8> | Limits how many downloads we concurrently perform on this object store in a single IO node. Possible values: `1`-`64` |
| `--max-concurrent-removals` \<uint8> | Limits the number of removals we concurrently perform on this object store in a single IO node. Possible values: `1`-`64` |
| `--max-concurrent-uploads` \<uint8> | Limits the number of uploads we concurrently perform on this object store in a single IO node. Possible values: `1`-`64` |
| `--max-data-blob-size` \<capacity> | Maximum size of a data object to upload to an object store data blob. |
| `--max-extents-in-data-blob` \<uint> | Limits the number of extents to upload to an object store data blob. |
| `--new-name` \<string> | New name for the object store. |
| `--obs-type` \<obs-type> | Object store type. |
| `--port` \<uint16> | TCP port to use when connecting to object store (single Accessor or Load Balancer). |
| `--protocol` \<obs-http-protocol> | Transport protocol. Possible values: `HTTP`,`HTTPS`,`HTTPS_UNVERIFIED` |
| `--region` \<string> | Name of the region we are assigned to work with (usually empty). |
| `--remove-bandwidth` \<uint> | Removal bandwidth limitation. Value is per core (Mbps). |
| `--secret-key` \<string> | Secret key used for AWS Signature authentications. |
| `--sts-operation-type` \<sts-operation> | AWS STS operation type. Default is none. |
| `--sts-role-arn` \<string> | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE. |
| `--sts-role-session-name` \<string> | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64. |
| `--sts-session-duration` \<duration> | Duration of the temporary security credentials in seconds. Must be between 900 and 43200; default is 3600. |
| `--upload-bandwidth` \<uint> | Upload bandwidth limitation. Value is per core (Mbps). |
| `--upload-memory-limit` \<capacity> | Maximum RAM to allocate for concurrent uploads to this object store (per node). |

## View object store buckets

Lists the object store buckets connected to the cluster and the object store each one belongs to.

**Command:** `weka fs tier s3`

```sh
weka fs tier s3 [--name <string>] [--obs-name <string>]
```

**Parameters**

| Parameter              | Description                                       |
| --- | --- |
| `--name` \<string> | Show only the object store bucket with this name. |
| `--obs-name` \<string> | Show only buckets belonging to this object store. |

## Add an object store bucket

Connects an S3 bucket to the cluster so that filesystems can tier data to it. Settings omitted here are inherited from the object store named by `--obs-name`.

**Command:** `weka fs tier s3 add`

```sh
weka fs tier s3 add <name> [--access-key-id <string>] [--auth-method <s3-auth-method>] [--bandwidth <uint>] [--bucket <string>] [--data-storage-class <string>] [--download-bandwidth <uint>] [--dry-run] [--enable-upload-tags] [--errors-timeout <duration>] [--gcp-auth-token-file <string>] [--hostname <string>] [--max-concurrent-downloads <uint8>] [--max-concurrent-removals <uint8>] [--max-concurrent-uploads <uint8>] [--max-data-blob-size <capacity>] [--max-extents-in-data-blob <uint>] [--metadata-storage-class <string>] [--obs-name <string>] [--obs-type <obs-type>] [--port <uint16>] [--prefetch-mib <uint16>] [--prefetch-size <capacity>] [--protocol <obs-http-protocol>] [--region <string>] [--remove-bandwidth <uint>] [--secret-key <string>] [--site <obs-site>] [--skip-verification] [--sts-operation-type <sts-operation>] [--sts-role-arn <string>] [--sts-role-session-name <string>] [--sts-session-duration <duration>] [--upload-bandwidth <uint>] [--verbose-errors]
```

**Parameters**

| Parameter                               | Description                                                                                                               |
| --- | --- |
| `name`\* | Name of the object store bucket. |
| `--access-key-id` \<string> | Access key used for AWS Signature authentications. |
| `--auth-method` \<s3-auth-method> | Authentication method. Possible values: None, AWSSignature2, AWSSignature4. Mandatory, if not specified in the object store level |
| `--bandwidth` \<uint> | Bandwidth limitation. Value is per core (Mbps). |
| `--bucket` \<string> | Name of the bucket we are assigned to work with. |
| `--data-storage-class` \<string> | AWS storage class or Azure access tier to use for uploaded data blobs. For details, see the documentation for Amazon S3 Storage Classes. Azure Configurable Azure access storage tier, allowing users to optimize storage based on cost and access needs. Supports HOT, COOL, and COLD. For details, see the documentation for Azure Access tiers for blob data |
| `--download-bandwidth` \<uint> | Download bandwidth limitation. Value is per core (Mbps). |
| `--dry-run` | Only test the command. Does not affect the system. |
| `--enable-upload-tags` | Enable tagging of uploaded objects. For details, see Object tagging. Possible values: true or false |
| `--errors-timeout` \<duration> | If the object store bucket link is down for longer than this, all IOs that need data return with an error. Possible values: 1m-15m, or 60s-900s. For example, 300s |
| `--gcp-auth-token-file` \<string> | File containing a GCP authentication token. |
| `--hostname` \<string> | Hostname or IP address of object store. |
| `--max-concurrent-downloads` \<uint8> | Limits how many downloads we concurrently perform on this object store in a single IO node. Possible values: 1-64 |
| `--max-concurrent-removals` \<uint8> | Limits the number of removals we concurrently perform on this object store in a single IO node. Possible values: 1-64 |
| `--max-concurrent-uploads` \<uint8> | Limits the number of uploads we concurrently perform on this object store in a single IO node. Possible values: 1-64 |
| `--max-data-blob-size` \<capacity> | Maximum size of a data object to upload to an object store data blob. |
| `--max-extents-in-data-blob` \<uint> | Limits the number of extents to upload to an object store data blob. |
| `--metadata-storage-class` \<string> | AWS storage class or Azure access tier to use for uploaded metadata blobs. |
| `--obs-name` \<string> | Name of the object store to associate this new bucket with. |
| `--obs-type` \<obs-type> | Object store type. |
| `--port` \<uint16> | TCP port to use when connecting to object store (single Accessor or Load Balancer). |
| `--prefetch-mib` \<uint16> | How many MiB of data to prefetch when reading a whole MiB on object store. Default is 128 MiB. |
| `--prefetch-size` \<capacity> | How much data to prefetch when reading a whole MiB on object store, rounded to nearest MiB. (0-600 MiB, default 128 MiB.) |
| `--protocol` \<obs-http-protocol> | Transport protocol. Possible values: HTTP, HTTPS or HTTPS_UNVERIFIED |
| `--region` \<string> | Name of the region we are assigned to work with (usually empty). |
| `--remove-bandwidth` \<uint> | Removal bandwidth limitation. Value is per core (Mbps). |
| `--secret-key` \<string> | Secret key used for AWS Signature authentications. |
| `--site` \<obs-site> | Site of the object store. Default is local. |
| `--skip-verification` | Do not verify the connection to the given storage. |
| `--sts-operation-type` \<sts-operation> | AWS STS operation type. Default is none. Possible values: assume_role or none |
| `--sts-role-arn` \<string> | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE. |
| `--sts-role-session-name` \<string> | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64. |
| `--sts-session-duration` \<duration> | Duration of the temporary security credentials in seconds. Must be between 900 and 43200; default is 3600. Possible values: 900 - 43200 |
| `--upload-bandwidth` \<uint> | Upload bandwidth limitation. Value is per core (Mbps). |
| `--verbose-errors` | Dump HTTP info on error. |

{% hint style="info" %}
When using the CLI, by default a misconfigured object store is not created. To create an object store even when it is misconfigured, use the `--skip-verification` option.
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

Changes an existing bucket connection's endpoint, credentials, storage class, or transfer limits.

**Command:** `weka fs tier s3 update`

```sh
weka fs tier s3 update <name> [--access-key-id <string>] [--auth-method <s3-auth-method>] [--bandwidth <uint>] [--bucket <string>] [--data-storage-class <string>] [--download-bandwidth <uint>] [--dry-run] [--enable-upload-tags] [--errors-timeout <duration>] [--gcp-auth-token-file <string>] [--hostname <string>] [--max-concurrent-downloads <uint8>] [--max-concurrent-removals <uint8>] [--max-concurrent-uploads <uint8>] [--max-data-blob-size <capacity>] [--max-extents-in-data-blob <uint>] [--metadata-storage-class <string>] [--new-name <string>] [--new-obs-name <string>] [--port <uint16>] [--prefetch-mib <uint16>] [--prefetch-size <capacity>] [--protocol <obs-http-protocol>] [--region <string>] [--remove-bandwidth <uint>] [--secret-key <string>] [--skip-verification] [--sts-operation-type <sts-operation>] [--sts-role-arn <string>] [--sts-role-session-name <string>] [--sts-session-duration <duration>] [--upload-bandwidth <uint>] [--verbose-errors]
```

**Parameters**

| Parameter                               | Description                                                                                                               |
| --- | --- |
| `name`\* | Name of the object store bucket. |
| `--access-key-id` \<string> | Access key used for AWS Signature authentications. |
| `--auth-method` \<s3-auth-method> | Authentication method. Possible values: None, AWSSignature2 or AWSSignature4 |
| `--bandwidth` \<uint> | Bandwidth limitation. Value is per core (Mbps). |
| `--bucket` \<string> | Name of the bucket we are assigned to work with. |
| `--data-storage-class` \<string> | AWS storage class or Azure access tier to use for uploaded data blobs. |
| `--download-bandwidth` \<uint> | Download bandwidth limitation. Value is per core (Mbps). |
| `--dry-run` | Only test the command. Does not affect the system. |
| `--enable-upload-tags` | Enable tagging of uploaded objects. Possible values: true, false |
| `--errors-timeout` \<duration> | If the object store bucket link is down for longer than this, all IOs that need data return with an error. Possible values: 1m-15m, or 60s-900s. For example, 300s |
| `--gcp-auth-token-file` \<string> | File containing a GCP authentication token. |
| `--hostname` \<string> | Hostname or IP address of object store. |
| `--max-concurrent-downloads` \<uint8> | Limits how many downloads we concurrently perform on this object store in a single IO node. Possible values: 1-64 |
| `--max-concurrent-removals` \<uint8> | Limits the number of removals we concurrently perform on this object store in a single IO node. Possible values: 1-64 |
| `--max-concurrent-uploads` \<uint8> | Limits the number of uploads we concurrently perform on this object store in a single IO node. Possible values: 1-64 |
| `--max-data-blob-size` \<capacity> | Maximum size of a data object to upload to an object store data blob. |
| `--max-extents-in-data-blob` \<uint> | Limits the number of extents to upload to an object store data blob. |
| `--metadata-storage-class` \<string> | AWS storage class or Azure access tier to use for uploaded metadata blobs. |
| `--new-name` \<string> | New name for the object store bucket. |
| `--new-obs-name` \<string> | New object store name. |
| `--port` \<uint16> | TCP port to use when connecting to object store (single Accessor or Load Balancer). |
| `--prefetch-mib` \<uint16> | How many MiB of data to prefetch when reading a whole MiB on object store. Default is 128 MiB. |
| `--prefetch-size` \<capacity> | How much data to prefetch when reading a whole MiB on object store, rounded to nearest MiB. (0-600 MiB, default 128 MiB.) |
| `--protocol` \<obs-http-protocol> | Transport protocol. Possible values: HTTP, HTTPS or HTTPS_UNVERIFIED |
| `--region` \<string> | Name of the region we are assigned to work with (usually empty). |
| `--remove-bandwidth` \<uint> | Removal bandwidth limitation. Value is per core (Mbps). |
| `--secret-key` \<string> | Secret key used for AWS Signature authentications. |
| `--skip-verification` | Do not verify the connection to the given storage. |
| `--sts-operation-type` \<sts-operation> | AWS STS operation type. Default is none. Possible values: assume_role or none |
| `--sts-role-arn` \<string> | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE. |
| `--sts-role-session-name` \<string> | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64. |
| `--sts-session-duration` \<duration> | Duration of the temporary security credentials in seconds. Must be between 900 and 43200; default is 3600. Possible values: 900 - 43200 |
| `--upload-bandwidth` \<uint> | Upload bandwidth limitation. Value is per core (Mbps). |
| `--verbose-errors` | Dump HTTP info on error. |

## List recent operations of an object store bucket

Lists the upload, download, and removal operations currently running against an object store, across all containers in the cluster. Omit the name to list operations for every object store.

**Command:** `weka fs tier ops`

```sh
weka fs tier ops [<name>]
```

**Parameters**

| Parameter | Description                      |
| --- | --- |
| `name` | Name of the object store bucket. |

## Delete an object store bucket

Removes an S3 object store bucket connection from the cluster.

**Command:** `weka fs tier s3 remove`

```sh
weka fs tier s3 remove <name>
```

**Parameters**

| Parameter | Description                      |
| --- | --- |
| `name`\* | Name of the object store bucket. |

[^1]: WEKA supports the AWS Security Token Service (STS) that enables you to request temporary, limited-privilege credentials for users using the [AssumeRole](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html) API.
