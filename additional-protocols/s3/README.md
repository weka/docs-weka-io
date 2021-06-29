---
description: This page describes the Weka implementation of the S3 protocol.
---

# S3

## Overview

The S3 protocol is widely used and spans many cloud-native or cloud-ready applications. 

With Weka, you can:

* Ingest data with S3 and then you can access the data with either S3 or other protocols.
* Expose existing data to S3, and migrate your application within the same data platform.
* Burst to the cloud and use new applications without the need to migrate your data.

In general, you can both gradually move applications to S3 and access the same data via multiple protocols \(POSIX, S3, SMB, NFS, GPUDirect Storage\). All this while enjoying Weka's scale, performance, and resiliency. 

### Architecture

The Weka S3 service is a scalable, resilient service that provides multi-protocol access to data.

Scalability is implemented by [defining many hosts that serve the S3 protocol](s3-cluster-management.md#creating-an-s3-cluster), thereby enabling higher performance by adding more hosts to the S3 cluster.

By integrating a [round-robin DNS or a load balancer](s3-cluster-management.md#round-robin-dns-load-balancer), different S3 clients will access different hosts, allowing the Weka system to scale and service thousands of clients.

The Weka S3 service works on top of the WekaFS file service. Buckets are mapped to \(top-level\) directories, and objects are mapped to files. Then, the same data can be exposed with either of the Weka-supported protocols.

## S3 Access, Security and Auditing

### S3 Access

Access to S3 APIs can be either authenticated or anonymous.

#### User Authentication

The process of gaining authenticated S3 access requires to:

1. [Create an internal Weka user with an S3 user role](../../usage/security/user-management.md#creating-users)
2. [Create and attach an IAM policy for that S3 user](s3-users-and-authentication.md#manage-users-and-authentication), to set the permissions of the user to S3 operations and resources
3. [Create temporary security tokens](s3-users-and-authentication.md#generating-a-temporary-security-token)  \(STS AssumeRole\) 

#### Anonymous Access

Anonymous access to buckets/objects can be obtained by either: 

* [Bucket policy](s3-buckets-management.md#managing-bucket-policies)
* [Pre-signed URLs](s3-examples-using-boto3.md#pre-signed-url-example)

### Security

#### Encryption at Rest

Data written via the S3 protocol can be encrypted at-rest by setting an [encrypted filesystem](../../overview/filesystems.md#encrypted-filesystems).

#### TLS

Clients' access to the service via HTTPS is provided using the same certificates Weka uses for other API access, as defined in the [TLS](../../usage/security/#tls) section.

### Audit

The S3 API calls can be audited using an HTTP webhook service and connecting to an application such as Splunk.

To set an audit target, use the `weka s3 cluster audit-webhook enable` CLI command.

For more information, refer to the [Audit S3 APIs](audit-s3-apis.md) page.

