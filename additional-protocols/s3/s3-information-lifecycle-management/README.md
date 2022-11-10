---
description: >-
  This page describes how to manage information lifecycle (ILM) rules for S3
  buckets.
---

# S3 rules information lifecycle management (ILM)

For S3 buckets, you can set information lifecycle rules to apply to the objects within the bucket. The lifecycle rules apply to the data within the bucket, regardless of the protocol.

Weka supports rules for expiring objects and enables you to set different expirations per object prefix and tags. Weka supports up to 1000 rules per bucket. If multiple rules overlap, the rule with the earliest expiration that applies for an object deletes this object from the bucket.



**Related topics**

[s3-information-lifecycle-management.md](s3-information-lifecycle-management.md "mention")****

****[s3-information-lifecycle-management-1.md](s3-information-lifecycle-management-1.md "mention")****
