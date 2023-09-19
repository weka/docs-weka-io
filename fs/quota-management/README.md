---
description: >-
  This page describes how to manage quotas to alert or restrict usage of the
  WEKA filesystem.
---

# Quota management

## Overview

There are several levels on the WEKA system where capacity usage can be restricted.&#x20;

1. On an organization level: Set a different organization to manage its filesystems, where quotas for an organization can be set, as described in the [organization's usage and quota management ](../../usage/organizations/#usage-and-quota-management)section.
2. On a filesystem level: Set a different filesystem per department/project.
3. On a directory level: Set a different quota per project directory (useful when users are part of several projects) or per-user home directory.

## Directory quotas

The organization admin can set a quota on a directory. Setting a quota starts the process of counting the current directory usage. Until this process is done, the quota is not considered (for empty directories, this process is instantly done).

{% hint style="info" %}
A mount point to the relevant filesystem is required to set a quota on a directory. The quota set command should not be interrupted until the quota accounting is over.
{% endhint %}

The organization admin sets quotas to inform/restrict users from using too much of the filesystem capacity. For that, only data in the user's control is considered. Hence, the quota doesn't count the overhead of the protection bits and snapshots. It does take into account data and metadata of files in the directory, regardless if tiered or not.&#x20;

### Working with quotas

When working with quotas, consider the following:

* To set a quota, the relevant filesystem must be mounted on the server where the set quota command is to be run.
* When setting a quota, go through a new mount-point. If you are using a server with mounts from WEKA versions before 3.10, first unmount all relevant mount points and then mount them again.
* Quotas can be set within nested directories (up to 4 levels of nested quotas are supported) and over-provisioned under the same directory quota tree. For example, the`/home` directory can have a quota of 1TiB while there are 200 users; each has a user directory under it and can have a quota of 10GiB. This means that over-provisioning is used, in which parent quotas are enforced on all subdirectories, regardless of any remaining capacity in the child quotas.
* Moving files (or directories) between two directories with quotas, into a directory with a quota, or outside a directory with a quota is not supported. The WEKA filesystem returns `EXDEV` in such a case, which is usually converted by the operating system to copy and delete but is OS-dependent.
* Quotas and hard links:
  * An existing hard link is not counted as part of the quota.
  * Once a directory has a quota, creating a hardlink to files residing under directories with different (or without) directory quotas is not allowed.
* Restoring a filesystem from a snapshot turns the quotas back to the configuration at the time of the snapshot.
* Creating a new filesystem from a snap-2-obj does not preserve the original quotas.
* When working with enforcing quotas along with a `writecache` mount-mode, similarly to other POSIX solutions, getting above the quota might not sync all the cache writes to the backend servers. Use `sync`, `syncfs`, or `fsync` to commit the cached changes to the system (or fail due to exceeding the quota).

### Integration with the `df` utility

When a hard quota is set on a directory, running the `df` utility considers the hard quota as the total capacity of the directory and provides the `use%` relative to the quota. This can help users understand their usage and proximity to the hard quota.

{% hint style="info" %}
The `df` utility behavior with quotas is global to the WEKA system.&#x20;

To change global behavior, contact the Customer Success Team.
{% endhint %}
