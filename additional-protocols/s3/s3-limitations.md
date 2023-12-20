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

* Bucket (HEAD/GET/PUT/DEL)\
  Including ListObjects and ListObjectsV2
* Bucket Lifecycle (GET/PUT/DEL)
* Bucket Policy (GET/PUT/DEL)
* Bucket Tagging (GET/PUT/DEL)
* Object (GET/PUT/DEL)
* Object Tagging (GET/PUT/DEL)
* Object Multiparts (POST Create/Complete, GET/DEL/PUT, GET Parts)

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
