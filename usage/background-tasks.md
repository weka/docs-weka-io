---
description: >-
  This page describes the management of background tasks running on the WEKA
  system.‌
---

# Background tasks

The WEKA system performs internal and external asynchronous operations and maintenance tasks in the background, allowing no interference nor starving the WEKA system from serving high-performing IOs.‌

Background tasks include, for example, downloading and uploading snapshots and migrating an object store.

Adhere to the following:

* **CPU resource consumption:** The WEKA system limits these tasks’ CPU resources to 5% of the overall CPU. When the CPU is idle, background tasks can use more than the configured resources but are immediately freed if needed for serving IOs.
* **Concurrent tasks:** The maximum number of concurrent tasks is 16, with restrictions such as:
  * Only a single local upload can exist inside a filesystem concurrently.
  * Only a single remote upload inside a filesystem concurrently (but local and remote uploads can co-exist).
  * Only a single upload from any filesystem can exist in the same object store bucket to prevent slowing down each other uploads.
  * Object store snapshot download operation cannot be run simultaneously with other snapshot download or upload operations.
* **Snapshot metadata prefetch:** After downloading a snapshot from the object store, a new cluster task automatically prefetches its metadata.

{% hint style="info" %}
**Note:** More restrictions exist between different tasks and multiple tasks of the same type. If a background task does not run due to a restriction, the system provides a relevant message.
{% endhint %}

## Manage background tasks <a href="#managing-background-tasks" id="managing-background-tasks"></a>

### View running background tasks <a href="#viewing-running-background-tasks" id="viewing-running-background-tasks"></a>

You can view the currently-running background tasks, including their status and progress.‌

#### Viewing background tasks using the CLI <a href="#viewing-background-tasks-using-the-cli" id="viewing-background-tasks-using-the-cli"></a>

‌**Command:** `weka cluster task`‌

This command is used for viewing all background tasks. For each task, a range of data can be displayed, as shown in the following example:

```
# weka cluster task
Type       | State   | Progress | Description
-----------+---------+----------+-----------------------------------------------------------
OBS_DETACH | RUNNING | 94       | Detaching Object Storage `obs_1` from filesystem `default`
```

### ‌Limit background task resources

It is possible to limit the resources being used by background tasks.

The configured limit affects external tasks and internal low-priority asynchronous operations.‌ You can view the tasks using the GUI and CLI.

#### **Limit background tasks using the CLI**

**Command:** `weka cluster task limits`

This command is used to view the defined limits.

**Command:** `weka cluster task limits set [--cpu-limit cpu-limit]`

This command is used to update the CPU limit.

### Pause/Resume/Abort a background task

It is possible to pause and later resume a background task, as well as completely abort it. This is useful in case there are other tasks/activities that are of higher priority.

#### **Pause/Resume/Abort a background task using the CLI**

**Command:** `weka cluster task pause / resume / abort <task-id>`

This command is used to pause, resume, or abort a specific task process. The `abort` subcommand is not applicable when downloading a filesystem or a snapshot. Instead, delete them directly.

{% hint style="info" %}
**Note:** Up to 16 background tasks can run in parallel. A paused (or aborting) task still consumes one of these spots.
{% endhint %}
