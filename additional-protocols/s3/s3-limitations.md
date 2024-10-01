---
description: >-
  This page describes limitations concerning the S3 service and protocol
  implementation.
---

# S3 supported APIs and limitations

## Supported URL styles for API requests to S3 buckets

WEKA supports two URL styles for API requests to S3 buckets: _path-style_ and _virtual-hosted-style_.

<table><thead><tr><th width="212">Style</th><th>URL format</th></tr></thead><tbody><tr><td>Path-style</td><td><code>https://s3.domain-name.com/bucket-name/object-name</code></td></tr><tr><td>Virtual-hosted-style</td><td><code>https://bucket-name.s3.domain-name.com/object-name</code></td></tr></tbody></table>

The difference between the styles is subtle but significant. When using a URL to reference an object, the DNS resolution maps the subdomain name to an IP address. With the path style, the subdomain is always `s3.domain-name.com`. With the virtual-hosted-style, the subdomain is specific to the bucket.

The addressing style used to construct the request is determined by the S3 client sending the request.

## Supported S3 APIs

The following standard S3 APIs are supported:

* **Bucket APIs:**&#x20;
  * [HEAD Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_HeadBucket.html)
  * [GET Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_GetBucket.html)
  * [PUT Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_CreateBucket.html)
  * [DELETE Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_DeleteBucket.html)
  * [List Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_ListObjects.html)
  * [List Objects V2](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_ListObjectsV2.html)
* **Bucket Lifecycle APIs:**
  * [GET Bucket Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_GetBucketLifecycleConfiguration.html)
  * [PUT Bucket Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_PutBucketLifecycleConfiguration.html)
  * [DELETE Bucket Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_DeleteBucketLifecycle.html)
* **Bucket Policy APIs:**
  * [GET Bucket Policy](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_GetBucketPolicy.html)
  * [PUT Bucket Policy](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_PutBucketPolicy.html)
  * [DELETE Bucket Policy](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_DeleteBucketPolicy.html)
* **Bucket Tagging APIs:**
  * [GET Bucket Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_GetBucketTagging.html)
  * [PUT Bucket Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_PutBucketTagging.html)
  * [DELETE Bucket Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_DeleteBucketTagging.html)
* **Object APIs:**
  * [GET Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_GetObject.html)
  * [PUT Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_PutObject.html)
  * [DELETE Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_DeleteObject.html)
* **Object Tagging APIs:**
  * [GET Object Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_GetObjectTagging.html)
  * [PUT Object Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_PutObjectTagging.html)
  * [DELETE Object Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_DeleteObjectTagging.html)
* **Object Multipart APIs:**
  * [POST Create Multipart Upload](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_CreateMultipartUpload.html)
  * [POST Complete Multipart Upload](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_CompleteMultipartUpload.html)
  * [GET Object Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_ListParts.html)
  * [PUT Part](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_UploadPart.html)
  * [DELETE Multipart Upload](https://docs.aws.amazon.com/AmazonS3/latest/API/API\_AbortMultipartUpload.html)

{% hint style="warning" %}
For a multipart object upload, the bucket’s free capacity must be at least twice the size of the object until the upload is complete.
{% endhint %}

## General limits

<table><thead><tr><th width="471">Item</th><th>Limits</th></tr></thead><tbody><tr><td>Maximum number of buckets</td><td>10000</td></tr><tr><td>Maximum object size</td><td>5 TiB</td></tr><tr><td>Maximum number of parts per upload</td><td>10000</td></tr><tr><td>Part numbers</td><td>1 to 10000 (inclusive)</td></tr><tr><td>Part size</td><td>5 MiB to 5 GiB. <br>The last part can be &#x3C; 5 MiB</td></tr><tr><td>Maximum number of parts returned for a list parts request</td><td>1000</td></tr><tr><td>Maximum number of multipart uploads returned in a list multipart uploads request</td><td>1000</td></tr><tr><td>User-defined metadata per object</td><td>2 KB</td></tr><tr><td>Maximum length of an S3 IAM user policy</td><td>2048</td></tr><tr><td>Maximum number of S3 IAM user policies</td><td>1024</td></tr><tr><td>Maximum number of S3 regular users</td><td>1024</td></tr><tr><td>Maximum number of S3 service accounts</td><td>5000</td></tr><tr><td>Maximum number of S3 STS credentials</td><td>5000</td></tr></tbody></table>

## Naming limitations

### Buckets

* Bucket names must be between 3 and 63 characters long.
* Bucket names can consist only of lowercase letters, numbers, dots ("`.`"), and hyphens ("`-`").
* Bucket names must begin and end with a letter or number.
* Bucket names must not be formatted as IP addresses (for example, `192.168.5.4`).
* Bucket names must be unique across the cluster.

### Objects

* Object key names may be up to 1024 characters long.
* An object prefix cannot begin with a forward slash ("`/`").
* Adding a forward slash ("`/`") in the object's prefix after the first character is interpreted as a directory. Such directory segments are limited to 255 characters.

{% hint style="info" %}
* For naming convention details, see [Creating object key names](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html) (AWS portal).
* Ensure the object key name is also compatible with protocols other than S3. Specifically, avoid special characters that might be unsupported in the other protocols.&#x20;
{% endhint %}

## Policy limitations

### Supported S3 policy actions

The S3 protocol implementation supports the following policy actions:

* `s3:*`\
  This wildcard is supported for IAM policies but not for bucket policies.
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

WEKA supports the [Amazon S3 Lifecycle Configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) elements and definitions, with the limitation of only supporting the lifecycle `Expiration` action.
