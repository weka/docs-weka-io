---
description: >-
  Learn how to configure global defaults and individual bucket settings for S3
  Performance Buckets to optimize S3 operations.
---

# Configure S3 Performance Buckets

S3 Performance Buckets optimize S3 operations for high-throughput and low-latency environments, such as analytics and AI/ML pipelines.

This optimization is achieved by modifying three S3 behaviors that can introduce performance overhead:

* [**ETag**](#user-content-fn-1)[^1] **algorithm:** Replaces the computationally intensive MD5 hash with a simple unique ID (UID) for object ETags.
* **Integrity mode:** Ignores client-side checksum validation requests to reduce processing overhead.
* **Sorting mode:** Returns unsorted LIST results directly from the filesystem, which is significantly faster for large object trees.

You can manage these settings at two levels:

* **Global configuration:** Sets the default behavior for all S3 Performance Buckets on the cluster.
* **Individual bucket configuration:** Overrides the global defaults for a specific bucket.

### Before you begin

The configuration commands in this topic only apply to buckets of type `PERFORMANCE`.

To create an S3 Performance Bucket, run the following command:

```bash
weka s3 bucket add <bucket-name> --type PERFORMANCE
```

### Manage global performance bucket defaults

Use these commands to manage the default performance settings inherited by all S3 Performance Buckets.

#### **Set the global defaults**

To set the default ETag, integrity, and sorting behavior for all S3 Performance Buckets, use the following command:

{% code overflow="wrap" %}
```bash
weka s3 cluster update performance-bucket --etag-alg <etag-alg> --integrity-mode <integrity-mode> --sorting <sorting>
```
{% endcode %}

{% hint style="info" %}
Changing these settings can significantly affect the WEKA cluster's performance and S3 compatibility.
{% endhint %}

**Parameters**

<table><thead><tr><th width="186.75390625">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--etag-alg</code></td><td><p>Sets the default ETag generation algorithm. </p><ul><li><code>md5</code>: Computes a standard MD5 hash.</li></ul><ul><li><code>uid</code>: (Default) Generates a unique ID (UID). This is faster and avoids hashing.</li></ul></td></tr><tr><td><code>--integrity-mode</code></td><td><p>Sets the default integrity handling mode.</p><ul><li><code>client_defined</code>: (Default) Respects client checksum validation requests (standard S3 behavior).</li></ul><ul><li><code>disabled</code>: Ignores client checksum requests. This is faster and reduces overhead.</li></ul></td></tr><tr><td><code>--sorting</code></td><td><p>Sets the default sorting behavior for LIST operations.</p><ul><li><code>sorted</code>: Returns objects in standard lexicographical order</li><li><code>unsorted</code>: (Default) Returns objects as they appear in the filesystem. This is significantly faster for large buckets.</li></ul></td></tr></tbody></table>

**Example**

To set the global defaults for maximum performance:

{% code overflow="wrap" %}
```bash
weka s3 cluster update performance-bucket --etag-alg uid --integrity-mode disabled --sorting unsorted
```
{% endcode %}

#### **View the global defaults**

To display the current global settings for all S3 Performance Buckets, run:

```
weka s3 cluster performance-bucket
```

#### **View details of all buckets**

To display the parameter details of all buckets, run:

```
weka s3 bucket list -v
```

#### **Reset all buckets to global defaults**

To reset the performance settings for _all_ existing S3 Performance Buckets, forcing them to inherit the cluster's global defaults, run the relevant command.

{% hint style="warning" %}
This command affects all existing S3 Performance Buckets and can impact cluster performance.
{% endhint %}

*   To reset the ETag algorithm for all buckets:

    `weka s3 cluster etag-alg reset`
*   To reset the integrity mode for all buckets:

    `weka s3 cluster integrity-mode reset`
*   To reset the sorting mode for all buckets:

    `weka s3 cluster sorting reset`

### Configure an individual performance bucket

Use these commands to override the global defaults for a specific S3 Performance Bucket.

#### **Set a specific bucket's behavior**

To set a specific performance behavior for an individual bucket, use the relevant command.

{% hint style="info" %}
Changing these settings can significantly affect the WEKA cluster's performance and S3 compatibility.
{% endhint %}

*   ETag algorithm:

    `weka s3 bucket etag-alg set <bucket-name> <md5 | uid>`
*   Integrity mode:

    `weka s3 bucket integrity-mode set <bucket-name> <client_defined | disabled>`
*   Sorting mode:

    `weka s3 bucket sorting set <bucket-name> <sorted | unsorted>`

For the parameter descriptions, see [#set-the-global-defaults](configure-s3-performance-buckets.md#set-the-global-defaults "mention").

**Example**

To configure `my-analytics-bucket` for unsorted LIST operations while leaving its other settings to inherit the global defaults:

```bash
weka s3 bucket sorting set my-analytics-bucket unsorted
```

#### **Reset a specific bucket to global defaults**

To remove an individual bucket's custom settings and make it inherit the global performance defaults, run the relevant command:

*   To reset the bucket's ETag algorithm:

    `weka s3 bucket etag-alg reset <bucket-name>`
*   To reset the bucket's integrity mode:

    `weka s3 bucket integrity-mode reset <bucket-name>`
*   To reset the bucket's sorting mode:

    `weka s3 bucket sorting reset <bucket-name>`

[^1]: In Amazon S3, an ETag (Entity Tag) is a unique identifier assigned to an object, representing a specific version of that object's content. It is a hash calculated based on the object's data and changes only when the object's content is modified, not its metadata. ETags are crucial for data integrity, caching, and conditional operations in S3.
