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

* **Organization level**: You can monitor an organization’s usage (SSD and total) and restrict usage with quotas per organization. This feature can be used for charge-backs based on the capacity used or allocated by SSD or object store data. For more details, see [organizations](../../operation-guide/organizations/ "mention").
* **Filesystem level**: Allocate a unique filesystem for each department or project.
* **Directory level**: Assign a unique quota for each project directory (beneficial when users are involved in multiple projects) or for each user’s home directory.

In the context of directory quotas, the organization admin can set a quota on a directory. This action initiates calculating the current directory usage in a background task. Once this calculation is complete, the quota is considered.

The organization admin’s role in setting quotas is to inform and restrict users from overusing the filesystem capacity. In this regard, only data that the user controls is considered. Therefore, the quota does not include the overhead of protection bits and snapshots. However, it accounts for the data and metadata of files in the directory, irrespective of whether they are tiered.

## Guidelines for quota management

When managing quotas, adhere to the following guidelines and requirements:

* **Ensure proper mounting:**
  * The target filesystem must be mounted natively through POSIX on the server where the quota command runs.
  * The quota set command must run to completion without interruption, as it triggers quota accounting.
* **Quota setting using mount points:**
  * The POSIX user running the command must have access to the target directory within the mount point.
  * This requirement applies even if the user has elevated privileges (for example, Organization Admin or higher).
* **Quota setting without directory access:**
  * If the POSIX user does not have access to the target directory, use the `--filesystem` flag.
  * Provide the path to the directory relative to the root of the target filesystem.
* **Quota coloring:**
  * When setting or unsetting a directory quota, a background process called `QUOTA_COLORING` runs. This process scans the entire directory tree and assigns the quota ID to all files and directories under it.
  * Configure at least one Data Services container to run this process in the background to maintain system performance. For details, see [set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention").
* **Quotas and hard links:**
  * Set quotas before creating hard links to ensure accurate quota accounting.
  * When a quota is set on a directory, files with two or more existing hard links are excluded from quota accounting. The system cannot verify that all links reside within the same quota boundary.
  * Use files with a single hard link in quota-controlled directories to ensure accurate tracking.
  * Quota rules apply only to newly created hard links. Pre-existing hard links are unaffected.
  * Keep all hard links to a file within the same quota boundary to ensure consistent behavior.
* **Nested quotas**:
  * Quotas can be defined within nested directories, up to four levels deep.
  * Over-provisioning is supported under the same directory quota tree.
  * Examples:
    * `/home` directory has a 1 TiB quota.
    * 200 user directories under `/home`, each with a 10 GiB quota.
    * This setup exceeds 1 TiB in total child quotas but is valid. The parent quota always takes precedence and is enforced across all subdirectories.
* **File movement**:
  * The `rename()` operation, when implemented by `link()` and `unlink()`, behaves like an atomic file move across filesystems.
  * Moving files into or out of quota-enforced directories triggers `EXDEV` (cross-device link error).
  * Applications must fall back to a copy-and-delete workflow: copy the file to the new location, then delete the original.
  * Standard tools such as `mv` in Linux handle this automatically.
* **Restoring filesystems**:
  * Restoring a filesystem from a snapshot reverts quotas to their configuration at the time of the snapshot.
* **Creating new filesystems**:
  * Creating a new filesystem from a snap-to-object does not preserve the original quotas.
* **Enforcing quotas**:
  * When quotas are enforced in `writecache` mount mode, exceeding a quota may leave some cache writes unsynced with backend servers.
  * This behavior is consistent with other POSIX implementations.
  * To ensure data integrity, use `sync`, `syncfs`, or `fsync` to explicitly commit changes to the backend (or fail if the quota is exceeded).

## Integration with the `df` utility

By default, when a hard quota is set on a directory, the `df` utility interprets it as the directory's total capacity, displaying the usage percentage (`use%`) relative to the quota. This helps users understand their usage and proximity to the quota limit.

{% hint style="info" %}
The integrated behavior of the `df` utility with quotas is a global setting in the WEKA system. To modify this global behavior to instead use soft quotas or ignore quotas, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}
