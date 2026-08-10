---
description: >-
  Explore how S3 lifecycle rules automate object expiration. These rules apply
  to the underlying data, ensuring changes reflect across all access protocols.
---

# S3 lifecycle rules management

## Overview

S3 lifecycle rules management enables the automatic deletion of objects in S3 buckets based on configurable rules. You can define rules to expire specific objects or all objects within a bucket. This feature focuses strictly on data expiration and does not perform object organization or tiering.

Because the platform utilizes a single, unified namespace, changes apply to the underlying data rather than a specific protocol. When a rule expires an object, the system deletes the file from the filesystem, making it immediately unavailable to other protocols such as NFS, SMB, and POSIX.

The system processes lifecycle rules using a scalable, distributed architecture. Tasks run as background jobs within the Data Services container. This distributed framework ensures high performance for large-scale deployments containing billions of objects.

### Key features and considerations

* **Customizable object expiration**: Define rules to automatically expire objects based on age, prefixes and tags, providing precise control over data retention. ILM rules are processed and enforced by the Dataservice container.
* **Scalable distributed processing**: Lifecycle tasks run as distributed background jobs across Data Service containers, enabling efficient processing of large object volumes.
* **Rule capacity**: Apply up to 10 rules per bucket and 5,000 rules cluster-wide to address diverse data lifecycle requirements.
* **Priority handling**: When multiple rules apply to the same object, the rule with the earliest expiration takes precedence. For example, if rule A applies to objects with a certain prefix and expires after 200 days, while rule B applies to a subset of the same prefix and expires after 30 days, then rule B takes precedence. As a result, rule A is only partially applicable.
* **Concurrent task execution**: Multiple lifecycle tasks can run concurrently (default: 4 tasks), with all rules for a given bucket processed together in a single task.
* **Task visibility and control**: Monitor and manage lifecycle tasks using standard cluster task commands, including the ability to view progress, abort tasks, and access detailed statistics.
* **Comprehensive statistics:** Monitor the performance and health of S3 lifecycle operations, providing insights into metrics such as the number of files deleted, average task runtime, and occurrences of metadata deletion failures.
* **S3 audit:** The Data Service logs S3 Information Lifecycle Management (ILM) delete operations and automatically pushes them to Splunk. This provides centralized auditability and monitoring for all automated deletions triggered by ILM policies.

#### Prerequisites

Before using S3 lifecycle rules management, ensure you have:

* A configured Data Services container (DataServ) with the configuration filesystem set.
* Enabled S3 lifecycle task manager using: `weka dataservice s3-lifecycle-task enable`

{% hint style="info" %}
In multi-tenant deployments, ILM rules are scoped to the tenant in which they are defined. Rules apply only to buckets owned by that tenant. The lifecycle crawler runs cluster-wide across all tenants automatically. No additional configuration is required per tenant.
{% endhint %}

**Related topics**

[set-up-a-data-services-container-for-background-tasks.md](../../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention")

[s3-information-lifecycle-management.md](s3-information-lifecycle-management.md "mention")

[s3-information-lifecycle-management-1.md](s3-information-lifecycle-management-1.md "mention")
