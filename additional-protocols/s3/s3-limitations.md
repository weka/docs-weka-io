---
description: >-
  This page describes limitations concerning the S3 service and protocol
  implementation.
---

# S3 supported APIs and limitations

## Supported S3 APIs

The following standard S3 APIs are supported:

* Bucket (HEAD/GET/PUT/DEL)\
  Including ListObjects and ListObjectsV2
* Bucket Lifecycle (GET/PUT/DEL)
* Bucket Policy (GET/PUT/DEL)
* Bucket Tagging (GET/PUT/DEL)
* Object (GET/PUT/DEL)
* Object Tagging (GET/PUT/DEL)
* Object Multiparts (POST Create/Complete, GET/DEL/PUT, GET Parts)

## General limits

| **Item**                                                                         | **Limits**                                                   |
| -------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| Maximum number of buckets                                                        | 10000                                                        |
| Maximum object size                                                              | 5 TiB                                                        |
| Maximum number of parts per upload                                               | 10000                                                        |
| Part numbers                                                                     | 1 to 10000 (inclusive)                                       |
| Part size                                                                        | <p>5 MiB to 5 GiB. <br>The last part can be &#x3C; 5 MiB</p> |
| Maximum number of parts returned for a list parts request                        | 1000                                                         |
| Maximum number of multipart uploads returned in a list multipart uploads request | 1000                                                         |
| User-defined metadata per object                                                 | 2 KB                                                         |
| Maximum length of an S3 IAM user policy                                          | 2048                                                         |
| Maximum number of S3 IAM user policies                                           | 1024                                                         |
| Maximum number of S3 regular users                                               | 1024                                                         |
| Maximum number of S3 service accounts                                            | 5000                                                         |
| Maximum number of S3 STS credentials                                             | 5000                                                         |

## Naming limitations

### Buckets

* Bucket names must be between 3 and 63 characters long.
* Bucket names can consist only of lowercase letters, numbers, dots (.), and hyphens (-).
* Bucket names must begin and end with a letter or number.
* Bucket names must not be formatted as IP addresses (for example, 192.168.5.4).
* Bucket names must be unique across the cluster.

### Objects

* Object key names must be up to 1024 characters long.
* The prefix `/` of an object is interpreted as a directory, and such directory segments are limited to 255 characters.
* See [AWS S3 object name limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html). Match them to limitations in other protocols.

{% hint style="info" %}
**Note:** It is recommended to avoid special characters that might be unsupported using protocols other than S3.&#x20;
{% endhint %}

## Policy limitations

### Supported S3 policy actions

The S3 protocol implementation supports the following policy actions:

* `s3:*`\
  **Note**: this wildcard is supported for IAM policies but not for bucket policies
* `s3:AbortMultipartUpload`
* `s3:CreateBucket`
* `s3:DeleteBucket`
* `s3:DeleteBucketPolicy`
* `s3:DeleteObject`
* `s3:GetBucketLocation`
* `s3:GetLifecycleConfiguration`
* `s3:PutLifecycleConfiguration`
* `s3:ListBucketMultipartUploads`
* `s3:ListMultipartUploadParts`
* `s3:GetBucketPolicy`
* `s3:GetObject`
* `s3:ListAllMyBuckets`
* `s3:ListBucket`
* `s3:PutBucketPolicy`
* `s3:PutObject`
* `s3:GetBucketTagging`
* `s3:PutBucketTagging`

## Supported checksum&#x20;

Only MD5 checksum algorithm is supported.

## Lifecycle configuration

WEKA supports the [AWS S3 Lifecycle Configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) elements and definitions, with the limitation of only supporting the lifecycle `Expiration` action.
