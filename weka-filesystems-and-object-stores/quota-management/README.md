---
description: >-
  Implement quota management to monitor and control usage of the WEKA filesystem
  effectively.
---

# Quota management

## Overview

The WEKA system offers multiple layers where you can limit capacity usage:

* **Organization level**: You can monitor an organization’s usage (SSD and total) and restrict usage with quotas per organization. This feature can be used for charge-backs based on the capacity used or allocated by SSD or object store data. For more details, see [organizations](../../operation-guide/organizations/ "mention").&#x20;
* **Filesystem level**: Allocate a unique filesystem for each department or project.
* **Directory level**: Assign a unique quota for each project directory (beneficial when users are involved in multiple projects) or for each user’s home directory.

In the context of directory quotas, the organization admin can set a quota on a directory. This action initiates the calculation of the current directory usage, which is instantaneous for empty directories. The quota is considered once this calculation is complete.

In the context of directory quotas, the organization admin can set a quota on a directory. This action initiates calculating the current directory usage in a background task. Once this calculation is complete, the quota is considered.

{% hint style="info" %}
To set a quota on a directory, a native POSIX mount to the relevant filesystem is necessary. The quota set command must not be interrupted until the quota accounting process is finished.
{% endhint %}

The organization admin’s role in setting quotas is to inform and restrict users from overusing the filesystem capacity. In this regard, only data that the user controls is considered. Therefore, the quota does not include the overhead of protection bits and snapshots. However, it accounts for the data and metadata of files in the directory, irrespective of whether they are tiered.

## Guidelines for quota management

When managing quotas, adhere to the following guidelines:

* **Setting quotas**: To establish a quota, ensure the relevant filesystem is mounted on the server where the quota command is executed.
* **Quota coloring:** During the procedure of setting or unsetting a directory quota, a background task referred to as `QUOTA_COLORING` is launched. This process scans the entire directory tree and assigns the quota ID to each file and directory within the tree. Set at least one Data Services container to run this task in the background to optimize system performance. For details, see [set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention").
* **Nested quotas**: Quotas can be established within nested directories (supporting up to 4 levels of nested quotas) and over-provisioned under the same directory quota tree. For instance, a `/home` directory can have a 1TiB quota with 200 users, each having a user directory under it with a 10GiB quota. This scenario illustrates over-provisioning, where parent quotas are enforced on all subdirectories, irrespective of any remaining capacity in the child quotas.
* **File movement**: The movement of files (or directories) between two directories with quotas, into a directory with a quota, or outside a directory with a quota is unsupported. In such instances, the WEKA filesystem returns an `EXDEV` error, typically converted by the operating system to a copy-and-delete operation, although this is OS-dependent.
* **Quotas and hard links**: Once a directory has a quota, only newly created hard links within the quota limits are part of quota calculations.
* **Restoring filesystems**: Restoring a filesystem from a snapshot reverts the quotas to the configuration at the time of the snapshot.
* **Creating new filesystems**: Creating a new filesystem from a snap-to-object does not retain the original quotas.
* **Enforcing quotas**: When enforcing quotas in conjunction with a `writecache` mount-mode, exceeding the quota might not sync all the cache writes to the backend servers, similar to other POSIX solutions. Use `sync`, `syncfs`, or `fsync` to commit the cached changes to the system (or fail due to exceeding the quota).

## Integration with the `df` utility

When a hard quota is set on a directory, running the `df` utility treats the hard quota as the total capacity of the directory. It displays the usage percentage (`use%`) relative to the quota. This feature aids users in comprehending their usage and how close they are to reaching the hard quota.

{% hint style="info" %}
The behavior of the `df` utility with quotas is a global setting in the WEKA system. To modify this global behavior, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}
