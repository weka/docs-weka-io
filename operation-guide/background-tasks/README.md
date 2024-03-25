---
description: >-
  This page describes the management of background tasks running on the WEKA
  system.‌
---

# Background tasks

The WEKA system performs internal and external asynchronous operations and maintenance tasks in the background using minimal CPU resources, allowing no interference nor starving the WEKA system from serving high-performing IOs.‌

Background tasks include, for example, checking metadata integrity, downloading and uploading snapshots, and detaching an object store.

Adhere to the following considerations:

* **CPU resource consumption:** The WEKA system limits these tasks’ CPU resources to 5% of the overall CPU. When the CPU is idle, background tasks can use more than the configured resources but are immediately freed if needed to serve IOs.
* **Concurrent tasks:** The maximum number of concurrent tasks is 16, with restrictions such as:
  * Only a single local upload can exist concurrently inside a filesystem.
  * Only a single remote upload inside a filesystem can be done concurrently (but local and remote uploads can co-exist).
  * Only a single upload from any filesystem can exist in the same object store bucket to prevent slowing down each other uploads.
  * Object store snapshot download operation cannot be run simultaneously with other snapshot download or upload operations.
  * A paused or aborted task is counted as part of the maximum number of concurrent tasks.
* **Snapshot metadata prefetch:** When a snapshot is downloaded from the object store, the system automatically prefetches its metadata as the initial step.
* **Up to 16 background tasks can run in parallel:** A paused or aborted task is also counted as a running background task.

{% hint style="info" %}
More restrictions exist between different tasks and multiple tasks of the same type. If a background task does not run due to a restriction, the system provides a relevant message.
{% endhint %}

### Background tasks list <a href="#managing-background-tasks" id="managing-background-tasks"></a>

<table><thead><tr><th width="317.3333333333333">Taks name</th><th width="279">Task description</th><th>Possible actions</th></tr></thead><tbody><tr><td>OBS_DETACH</td><td>Detaching Object Storage &#x3C;OBS name> from filesystem &#x3C;fs name>.</td><td>Pause, Resume</td></tr><tr><td>STOW_UPLOAD</td><td>Uploading snapshot &#x3C;snapshot name> from filesystem &#x3C;fs name> to &#x3C;OBS site> object-store bucket &#x3C;OBS bucket name>.</td><td>Pause, Resume, Abort</td></tr><tr><td>STOW_DOWNLOAD_FILESYSTEM</td><td>Downloading filesystem &#x3C;fs name> from locator &#x3C;snapshot locator> in object-store &#x3C;OBS bucket name>.</td><td>Pause, Resume</td></tr><tr><td>STOW_DOWNLOAD_SNAPSHOT</td><td><p>Downloading the snapshot &#x3C;snapshot name> to &#x3C;fs name> from locator &#x3C;snapshot locator> in object-store &#x3C;OBS bucket name>.<br>This task includes two additional internal phases:</p><ul><li>Fetching the snapshot metadata.</li><li>Squashing the filesystem.</li></ul></td><td>Pause, Resume</td></tr><tr><td>FSCK</td><td>Checking metadata integrity.</td><td>Pause, Resume, Abort</td></tr><tr><td>DATA_REDUCTION</td><td>Compressing data.</td><td>Pause, Resume, Abort</td></tr><tr><td>DATA_REDUCTION_GC</td><td>Garbage collection (GC).</td><td>Pause, Resume, Abort</td></tr></tbody></table>

