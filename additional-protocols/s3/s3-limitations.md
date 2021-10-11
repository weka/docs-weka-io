---
description: >-
  This page describes limitations concerning the S3 service and protocol
  implementation.
---

# S3 Limitations

## Supported S3 APIs

The following standard S3 APIs are supported:

* Bucket (HEAD/GET/PUT/DEL)
  * Including ListObjects and ListObjectsV2
* Bucket Lifecycle (GET/PUT/DEL)
* Bucket Policy (GET/PUT/DEL)
* Bucket Tagging (GET/PUT/DEL)
* Object (GET/PUT/DEL)
* Object Tagging (GET/PUT/DEL)
* Object Multiparts (POST Create/Complete, GET/DEL/PUT, GET Parts)

## General Limits

| Item                                                                             | Limits                                       |
| -------------------------------------------------------------------------------- | -------------------------------------------- |
| <p></p><p>Maximum number of buckets</p>                                          | <p></p><p>10000</p>                          |
| Maximum object size                                                              | 5 TiB                                        |
| Maximum number of parts per upload                                               | 10000                                        |
| Part numbers                                                                     | 1 to 10000 (inclusive)                       |
| Part size                                                                        | 5 MiB to 5 GiB. The last part can be < 5 MiB |
| Maximum number of parts returned for a list parts request                        | 1000                                         |
| Maximum number of multipart uploads returned in a list multipart uploads request | 1000                                         |

{% hint style="info" %}
**Note:** Currently, S3 buckets and objects can only be shared from a single Weka filesystem.
{% endhint %}

## Naming Limitations

### Buckets

* Bucket names must be between 3 and 63 characters long.
* Bucket names can consist only of lowercase letters, numbers, dots (.), and hyphens (-).
* Bucket names must begin and end with a letter or number.
* Bucket names must not be formatted as an IP address (for example, 192.168.5.4).
* Must be unique within the filesystem

### Objects

* Object key names must be up to 1024 characters long.
* A `/` prefix of an object is interpreted as a directory, and such directory segments are limited to 255 characters.
* Refer to [AWS S3 object name limitations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html). Match them to limitations in other protocols.

{% hint style="info" %}
**Note:** It is advisable to avoid special characters that might be unsupported using protocols other than S3. 
{% endhint %}

## Policy Limitations

### Supported S3 Policy Actions

The S3 protocol implementation supports the following policy actions:

* `s3:*`
  * Note: this wildcard is supported for IAM policies but not for bucket policies
* `s3:AbortMultipartUpload`
* `s3:CreateBucket`
* `s3:DeleteBucket`
* `s3:DeleteBucketPolicy`
* `s3:DeleteObject`
* `s3:GetBucketLocation`
* `s3:GetBucketPolicy`
* `s3:GetObject`
* `s3:ListAllMyBuckets`
* `s3:ListBucket`
* `s3:ListMultipartUploads`
* `s3:ListParts`
* `s3:PutBucketLifecycle`
* `s3:GetBucketLifecycle`
* `s3:PutBucketPolicy`
* `s3:PutObject`
* `s3:GetBucketTagging`
* `s3:PutBucketTagging`
* `s3:Get`
* `s3:Put`
* `s3:Delete`

## Lifecycle Configuration

Weka supports the [AWS S3 Lifecycle Configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) elements and definitions, with the limitation of only supporting the lifecycle `Expiration` action.

## Quotas

Currently, data ingested by the S3 protocol is not counted against a defined directory quota.
