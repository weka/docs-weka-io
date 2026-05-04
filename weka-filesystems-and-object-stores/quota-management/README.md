---
description: >-
  Implement quota management to monitor and control usage of the WEKA filesystem
  effectively.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-filesystems-and-object-stores/quota-management
---

# Quota management

## Overview

The WEKA system offers multiple layers where you can limit capacity usage:

* **Tenant level**: Monitor tenant usage, including SSD and total capacity, and restrict usage with quotas per tenant. Use this quota for chargebacks based on consumed or allocated SSD or object store capacity. See [multi-tenancy-cluster-level-administration.md](../../operation-guide/weka-native-multi-tenancy-management/multi-tenancy-cluster-level-administration.md "mention")
* **Filesystem level**: Allocate a unique filesystem for each department or project.
* **Directory level**: Assign a unique quota for each project directory (beneficial when users are involved in multiple projects) or for each user’s home directory.
* **User and group level:** Assign a quota per user (UID) or per group (GID) to limit total capacity consumed across the entire filesystem, regardless of which directories a user writes to. User and group quotas complement directory quotas: when both apply to a write operation, the most restrictive limit is enforced.

A tenant administrator can set a quota on a directory. This action initiates calculating the current directory usage in a background task. Once this calculation is complete, the quota is considered.

The tenant administrator sets quotas to inform users and prevent overuse of filesystem capacity. Only data that the user controls is considered. The quota does not include protection overhead or snapshots. It includes file data and metadata in the directory, whether tiered or not.

## Guidelines for quota management

When managing quotas, adhere to the following guidelines and requirements.

### Prerequisites

* Configure at least one Data Services container before setting any quotas. This is the recommended approach and does not require a filesystem mount. For details, see [set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention").
* If no Data Services container is available, quota operations fall back to single-process mode using a filesystem mount. In this mode:
  * The target filesystem must be mounted natively through POSIX on the server where the quota command runs.
  * The quota `set` command must run to completion without interruption, as it triggers quota accounting.
  * The POSIX user running the command must have access to the target directory within the mount point. This requirement applies even if the user has elevated privileges (for example, tenant administrator or higher).
  * If the POSIX user does not have access to the target directory, use the `--filesystem` flag and provide the path to the directory relative to the root of the target filesystem.
  * Without a Data Services container, quota operations may cause the CLI to hang for extended periods.

### Quota coloring and accounting

* When setting or unsetting a directory quota, a background process called `QUOTA_COLORING` runs. This process scans the entire directory tree and assigns the quota ID to all files and directories under it.
* When enabling user or group quotas on an existing filesystem, the same `QUOTA_COLORING` process runs to stamp existing objects with the appropriate UID or GID quota identifiers. Quotas are not enforced on pre-existing data until this process completes.
* Ownership changes (`chown` / `chgrp`) trigger an asynchronous reattribution of the file's capacity from the previous UID or GID quota domain to the new one. During the transition, usage counters may temporarily reflect the previous owner.

### Capacity enforcement

* User and group quotas track capacity across the entire filesystem, not per directory. A user's total writes across all directories contribute to a single quota domain.
* A single write operation may be subject to multiple active quota domains simultaneously: a directory quota, a user quota, and a group quota. WEKA enforces the most restrictive remaining capacity among all applicable domains.
* When a quota domain is exhausted, writes fail with `ENOSPC`.
* When quotas are enforced in `writecache` mount mode, exceeding a quota may leave some cache writes unsynced with backend servers. This behavior is consistent with other POSIX implementations. To ensure data integrity, use `sync`, `syncfs`, or `fsync` to explicitly commit changes to the backend (or fail if the quota is exceeded).

### Nested quotas

* Quotas can be defined within nested directories, up to four levels deep.
* Over-provisioning is supported under the same directory quota tree.
* Example: the `/home` directory has a 1 TiB quota, and 200 user directories under `/home` each have a 10 GiB quota. This setup exceeds 1 TiB in total child quotas but is valid. The parent quota always takes precedence and is enforced across all subdirectories.

### Hard links

* Set quotas before creating hard links to ensure accurate quota accounting.
* When a quota is set on a directory, files with two or more existing hard links are excluded from quota accounting. The system cannot verify that all links reside within the same quota boundary.
* Use files with a single hard link in quota-controlled directories to ensure accurate tracking.
* Quota rules apply only to newly created hard links. Pre-existing hard links are unaffected.
* Keep all hard links to a file within the same quota boundary to ensure consistent behavior.
* Do not create a hard link across different quotas.

### File movement

* The `rename()` operation, when implemented by `link()` and `unlink()`, behaves like an atomic file move across filesystems.
* Moving files into or out of quota-enforced directories triggers `EXDEV` (cross-device link error).
* Applications must fall back to a copy-and-delete workflow: copy the file to the new location, then delete the original. Standard tools such as `mv` in Linux handle this automatically.

### Snapshots and filesystem recovery

* Snapshot capacity is tracked separately from the live filesystem and does not count toward a user or group quota in the live filesystem. Writable snapshot usage is accounted independently within the snapshot scope.
* Restoring a filesystem from a snapshot reverts quotas to their configuration at the time of the snapshot.
* Creating a new filesystem from a snap-to-object does not preserve the original quotas.

## Integration with the `df` utility

By default, when a hard quota is set on a directory, the `df` utility interprets it as the directory's total capacity, displaying the usage percentage (`use%`) relative to the quota. This helps users understand their usage and proximity to the quota limit.

{% hint style="info" %}
The integrated behavior of the `df` utility with quotas is a global setting in the WEKA system. To modify this global behavior to instead use soft quotas or ignore quotas, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}
