---
description: >-
  S3 lifecycle rules management in WEKA automates object organization and
  expiration in S3 buckets through customizable rules, ensuring consistent
  application across all access protocols.
---

# S3 lifecycle rules management

S3 lifecycle rules management in WEKA enable you to automate the organization and expiration of objects in S3 buckets by defining rules. These rules operate consistently across all objects in a bucket, regardless of the access protocol.

**Key features and considerations:**

* **Customizable object expiration:** Define rules to automatically expire objects based on prefixes or tags, providing precise control over data retention.
* **Extensive rule support:** Apply up to 1,000 rules per bucket to address diverse data lifecycle requirements.
* **Priority handling:** When multiple rules apply to the same object, the rule with the earliest expiration takes precedence. For example, if rule A applies to objects with a certain prefix and expires after 200 days, while rule B applies to a subset of the same prefix and expires after 30 days, then rule B takes precedence. As a result, rule A is only partially applicable.

**Related topics**

[s3-information-lifecycle-management.md](s3-information-lifecycle-management.md "mention")

[s3-information-lifecycle-management-1.md](s3-information-lifecycle-management-1.md "mention")
