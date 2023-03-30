---
description: This page describes the WEKA implementation of the S3 protocol.
---

# S3

The S3 protocol is widely used and spans many cloud-native or cloud-ready applications.&#x20;

With WEKA, you can:

* Ingest data with S3, and then you can access the data with either S3 or other protocols.
* Expose existing data to S3, and migrate your application within the same data platform.
* Burst to the cloud and use new applications without migrating your data.

While gaining WEKA's scale, performance, and resiliency advantages, you can gradually move applications to S3 and access the same data through multiple protocols, POSIX, S3, SMB, NFS, and GPUDirect Storage.

The WEKA S3 is a scalable and resilient service that provides multi-protocol access to data.

You implement the S3 service by specifying a set of storage servers that run the S3 protocol and then creating a logical S3 cluster to expose the S3 service. When defining many servers that serve the S3 protocol, the S3 cluster scales to higher performance.

By integrating a round-robin DNS or a load balancer, different S3 clients can access other servers, allowing the WEKA system to scale and service thousands of clients.

The WEKA S3 service works on top of the WEKA filesystem service. Buckets are mapped to top-level directories, and objects are mapped to files. Then, the same data can be exposed with either WEKA-supported protocols.

**Related topics**

****[s3-cluster-management](s3-cluster-management/ "mention")****

## S3 access

User access to S3 APIs can be either authenticated or anonymous.

### User authentication

The process of gaining authenticated S3 access requires to:

1. Create an internal WEKA user with an S3 user role.
2. Add and attach an IAM policy for the S3 user. The IAM policy determines the S3 user's permissions to S3 operations and resources.

As an S3 user, you can create temporary security tokens (STS AssumeRole) or service accounts with restricted permissions.

**Related topics**

****[user-management](../../usage/user-management/ "mention")****

****[s3-users-and-authentication](s3-users-and-authentication/ "mention")****

### Anonymous access

Anonymous access to buckets/objects can be obtained by one of the following:&#x20;

* Bucket policy
* Pre-signed URLs

**Related topics**

[#manage-bucket-policies](s3-buckets-management/#manage-bucket-policies "mention")

[#pre-signed-url-example](s3-examples-using-boto3.md#pre-signed-url-example "mention")

### Supported URL styles for API requests to S3 buckets

WEKA supports two URL styles for API requests to S3 buckets: _path-style_ and _virtual-hosted-style_.

| Style                | URL format                                             |
| -------------------- | ------------------------------------------------------ |
| Path-style           | `https://`s3`.domain-name.com/bucket-name/object-name` |
| Virtual-hosted-style | `https://bucket-name.s3.domain-name.com/object-name`   |

The difference between the styles is subtle but significant. When using a URL to reference an object, the DNS resolution maps the subdomain name to an IP address. With the path style, the subdomain is always `s3.domain-name.com`. With the virtual-hosted-style, the subdomain is specific to the bucket.

The addressing style used to construct the request is determined by the S3 client sending the request.

## S3 security

### Encryption **of data** at rest

Data written through the S3 protocol can be encrypted at rest by setting an encrypted filesystem.

### TLS

Clients' access to the service through HTTPS is provided using the same certificates that WEKA uses for other API access.

**Related topics**

****[#encrypted-filesystems](../../overview/filesystems.md#encrypted-filesystems "mention")****

[#tls](../../usage/security/#tls "mention")

## S3 Audit

The S3 API calls can be audited using an HTTP webhook service and connecting to an application such as Splunk.

To set an audit target, use the `weka s3 cluster audit-webhook enable` CLI command.

**Related topics**

[audit-s3-apis](audit-s3-apis/ "mention")
