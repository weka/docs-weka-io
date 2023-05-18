---
description: >-
  This page describes the management of background tasks running on the WEKA
  system.‌
---

# Background tasks

The WEKA system performs internal and external asynchronous operations and maintenance tasks in the background using minimal CPU resources, allowing no interference nor starving the WEKA system from serving high-performing IOs.‌

Background tasks include, for example, checking metadata integrity, downloading and uploading snapshots, and detaching an object store.

Adhere to the following considerations:

* **CPU resource consumption:** The WEKA system limits these tasks’ CPU resources to 5% of the overall CPU. When the CPU is idle, background tasks can use more than the configured resources but are immediately freed if needed for serving IOs.
* **Concurrent tasks:** The maximum number of concurrent tasks is 16, with restrictions such as:
  * Only a single local upload can exist inside a filesystem concurrently.
  * Only a single remote upload inside a filesystem concurrently (but local and remote uploads can co-exist).
  * Only a single upload from any filesystem can exist in the same object store bucket to prevent slowing down each other uploads.
  * Object store snapshot download operation cannot be run simultaneously with other snapshot download or upload operations.
  * A paused or aborted task is counted as part of the maximum number of concurrent tasks.
* **Snapshot metadata prefetch:** After downloading a snapshot from the object store, a new cluster task automatically prefetches its metadata.
* **Up to 16 background tasks can run in parallel:** A paused or aborted task is also counted as a running background task.

{% hint style="info" %}
**Note:** More restrictions exist between different tasks and multiple tasks of the same type. If a background task does not run due to a restriction, the system provides a relevant message.
{% endhint %}

### Background tasks list <a href="#managing-background-tasks" id="managing-background-tasks"></a>

| Taks name                  | Task description                                                                                                        | Possible actions     |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------- | -------------------- |
| OBS\_DETACH                | Detaching Object Storage \<OBS name> from filesystem \<fs name>                                                         | Pause, Resume        |
| STOW\_UPLOAD               | Uploading snapshot \<snapshot name> from filesystem \<fs name> to \<OBS site> object-store bucket \<OBS bucket name>    | Pause, Resume, Abort |
| STOW\_DOWNLOAD\_FILESYSTEM | Downloading filesystem \<fs name> from locator \<snapshot locator> in object-store \<OBS bucket name>                   | Pause, Resume        |
| STOW\_DOWNLOAD\_SNAPSHOT   | Downloading snapshot \<snapshot name> to \<fs name> from locator \<snapshot locator> in object-store \<OBS bucket name> | Pause, Resume        |
| FSCK                       | Checking metadata integrity                                                                                             | Pause, Resume, Abort |
| FILESYSTEM\_SQUASH         | Squashing filesystem \<fs name>                                                                                         | Pause, Resume        |
| SNAPSHOT\_PREFETCH         | Fetching metadata of snapshot \<snapshot name> of filesystem \<fs name> from object-store \<OBS bucket name>            | Pause, Resume, Abort |
| DATA\_REDUCTION            | Compressing data                                                                                                        | Pause, Resume, Abort |
| DATA\_REDUCTION\_GC        | Garbage collection (GC)                                                                                                 | Pause, Resume, Abort |

