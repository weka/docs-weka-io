---
description: >-
  This page describes limitations concerning the S3 service and protocol
  implementation.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-limitations
---

# S3 supported APIs and limitations

## Supported URL styles for API requests to S3 buckets

WEKA supports two URL styles for API requests to S3 buckets: _path-style_ and _virtual-hosted-style_.

<table><thead><tr><th width="212">Style</th><th>URL format</th></tr></thead><tbody><tr><td>Path-style</td><td><code>https://s3.domain-name.com/bucket-name/object-name</code></td></tr><tr><td>Virtual-hosted-style</td><td><code>https://bucket-name.s3.domain-name.com/object-name</code></td></tr></tbody></table>

The difference between the styles is subtle but significant. When using a URL to reference an object, the DNS resolution maps the subdomain name to an IP address. With the path style, the subdomain is always `s3.domain-name.com`. With the virtual-hosted-style, the subdomain is specific to the bucket.

The addressing style used to construct the request is determined by the S3 client sending the request.

{% hint style="info" %}
Ensure S3 clients support HTTP 1.1 or higher. WEKA S3 requires this protocol version for compatibility.
{% endhint %}

## URL-formatted object keys in WEKA S3

WEKA S3 supports non-posix compliant object keys (for example, [`https://company.com/id`](https://company.com/id)), expanding compatibility with AWS S3–native applications.

* **Standard keys:** Maintain full multi-protocol interoperability; keys map directly to standard posix filenames in the WEKA filesystem..



* **Non-posix compliant keys:** Keys cannot be represented with identical names in the filesystem view. These objects also remain fully accessible as POSIX files and other protocols, however under alternative naming convention that represents and is derived from the original S3 keys.

This allows organizations to integrate applications using non-posix compliant keys as identifiers, without requiring changes to naming conventions, while still preserving cross-protocol access.

## Supported S3 APIs

The following standard S3 APIs are supported for bucket and object management:

* **Bucket APIs:**
  * [HEAD Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadBucket.html)
  * [CREATE Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html)
  * [DELETE Bucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html)
  * [LIST Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html)
  * [LIST Objects V2](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjectsV2.html)
  * [LIST Buckets](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html)
* **Bucket Lifecycle APIs:**
  * [GET Bucket Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketLifecycleConfiguration.html)
  * [PUT Bucket Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)
  * [DELETE Bucket Lifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketLifecycle.html)
* **Bucket Policy APIs:**
  * [GET Bucket Policy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketPolicy.html)
  * [PUT Bucket Policy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketPolicy.html)
  * [DELETE Bucket Policy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketPolicy.html)
* **Bucket Tagging APIs:**
  * [GET Bucket Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketTagging.html)
  * [PUT Bucket Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketTagging.html)
  * [DELETE Bucket Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketTagging.html)
* **Object APIs:**
  * [GET Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
  * [PUT Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
  * [DELETE Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html)
  * [DELETE Objects](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObjects.html)
  * [COPY Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html)
  * [HEAD Object](https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadObject.html)
* **Object Tagging APIs:**
  * [GET Object Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html)
  * [PUT Object Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObjectTagging.html)
  * [DELETE Object Tagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObjectTagging.html)
* **Object Multipart APIs:**
  * [POST Create Multipart Upload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html)
  * [POST Complete Multipart Upload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html)
  * [GET Object Parts](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html)
  * [PUT Part](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html)
  * [DELETE Multipart Upload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html)
* **Bucket Notification APIs:**
  * [GET Bucket Notification](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketNotification.html)
  * [GET Bucket Notification Configuration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketNotificationConfiguration.html)
  * [PUT Bucket Notification](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketNotification.html)
  * [PUT Bucket Notification Configuration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketNotificationConfiguration.html)

## General limits

<table><thead><tr><th width="471">Item</th><th>Limits</th></tr></thead><tbody><tr><td>Maximum number of buckets</td><td>10000</td></tr><tr><td>Maximum object size</td><td>5 TiB</td></tr><tr><td>Maximum number of parts per upload</td><td>10000</td></tr><tr><td>Part numbers</td><td>1 to 10000 (inclusive)</td></tr><tr><td>Part size</td><td>5 MiB to 5 GiB.<br>The last part can be &#x3C; 5 MiB</td></tr><tr><td>Maximum number of parts returned for a list parts request</td><td>1000</td></tr><tr><td>Maximum number of multipart uploads returned in a list multipart uploads request</td><td>1000</td></tr><tr><td>User-defined metadata per object</td><td>2 KB</td></tr><tr><td>Maximum length of an S3 IAM user policy</td><td>2048</td></tr><tr><td>Maximum number of S3 IAM user policies</td><td>1024</td></tr><tr><td>Maximum number of S3 regular users</td><td>1024</td></tr><tr><td>Maximum number of S3 service accounts</td><td>5000</td></tr><tr><td>Maximum number of S3 STS credentials</td><td>5000</td></tr></tbody></table>

## Bucket naming limitations

* **Length:** Bucket names must be between 3 and 63 characters long.
* **Characters:** Names can consist only of lowercase letters, numbers, dots (`.`), and hyphens (`-`).
* **Structure:** Names must begin and end with a letter or number.
* **Format:** Do not format bucket names as IP addresses, for example, `192.168.5.4`.
* **Uniqueness:** Bucket names must be unique across the cluster.

## Object naming limitations

* **Key length:** Object key names can be up to 1024 characters long.
* **Prefixes:** An object prefix cannot begin with a forward slash (`/`).
* **Directories:** A forward slash (`/`) added after the first character is interpreted as a directory.
* **Segment length:** Directory segments are limited to 255 characters.
* **Compatibility:** Ensure the object key name is compatible with protocols other than S3 by avoiding special characters that are unsupported in those protocols.

{% hint style="info" %}
- For naming convention details, see [Creating object key names](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html) (AWS portal).
- Ensure the object key name is also compatible with protocols other than S3. Specifically, avoid special characters that might be unsupported in the other protocols.
{% endhint %}

## Supported S3 policy actions

The S3 protocol implementation supports the following policy actions:

* `s3:*` (supported for IAM policies only)
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

## Supported AWS-aligned integrity algorithms

The WEKA system supports end-to-end checksum validation for S3 data integrity protections. The following AWS-aligned integrity algorithms are supported:

* CRC32
* CRC32C
* CRC64NVME
* SHA1
* SHA256

The system provides validation at the whole-object (`FULL_OBJECT`) and part-level, and supports trailer-based signed chunked uploads. Clients can select the desired algorithm on a per-request basis.

{% hint style="info" %}
For optimal performance, CRC32 or CRC32C is recommended.
{% endhint %}

## ETag handling in WEKA S3

The WEKA S3 cluster manages the S3 object ETag field using the MD5 algorithm to generate checksums based on the specific upload method. For standard single-part uploads, the returned ETag represents the MD5 checksum of the uploaded data.

In multipart uploads, the system generates an MD5 ETag for each part and ensures sequential validation, deriving the final object ETag from a checksum calculated across the individual parts' ETags.

## Lifecycle configuration

WEKA supports the [Amazon S3 Lifecycle Configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/intro-lifecycle-rules.html) elements and definitions, with the limitation of only supporting the lifecycle `Expiration` action.
