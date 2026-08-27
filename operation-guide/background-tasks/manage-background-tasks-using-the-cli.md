# Manage background tasks using the CLI

## Monitor background tasks

List the running background tasks and their status:

```
weka cluster task
```

```
Task ID  Type            State    Phase         Progress  Description
57       QUOTA_COLORING  RUNNING  STAMPING 1/2  34%       Setting Directory Quota for fs1:/data/proj
```

<table><thead><tr><th width="167.68359375">Column</th><th>Description</th></tr></thead><tbody><tr><td>Task ID</td><td>Identifier of the task. Use it with the pause, resume, and abort commands.</td></tr><tr><td>Type</td><td>Task type, as listed in the table above.</td></tr><tr><td>State</td><td>Current state of the task, such as RUNNING, PAUSED, PAUSING, ABORTING, or WAITING.</td></tr><tr><td>Phase</td><td>Current phase and the total number of phases. A task in the first phase has not started its main work.</td></tr><tr><td>Progress</td><td>Completion percentage of the current phase.</td></tr><tr><td>User Paused</td><td>Whether a user paused the task, as opposed to the system.</td></tr><tr><td>Description</td><td>The operation the task performs, including the filesystem and path where relevant.</td></tr><tr><td>Time</td><td>How long ago the task started.</td></tr></tbody></table>

Add `-v` to include the task UID and the throttle percentage.

A task that stays in its first phase with no progress is queued and waiting for a slot. It is not stuck.

## Control background tasks

Pause, resume, or abort a task by its ID:

```
weka cluster task pause <task-id>
weka cluster task resume <task-id>
weka cluster task abort <task-id>
```

You can pause and resume any background task. Abort is not available for every task type, and for some types it is available only during specific phases. See the Possible actions column in the table above.

{% hint style="warning" %}
Aborting a task stops the operation before it completes. Work already performed is not rolled back, and the operation must be started again from the beginning.
{% endhint %}

## Directory quota tasks

Setting or clearing a directory quota on a directory that already contains data starts a QUOTA\_COLORING task. The task applies the quota to the existing contents of the directory.

A QUOTA\_COLORING task reports two phases:

| Phase        | Description                                                                                                    |
| ------------ | -------------------------------------------------------------------------------------------------------------- |
| PREPARE 0/2  | The task is queued and waiting for a slot.                                                                     |
| STAMPING 1/2 | The task is applying the quota to the existing contents of the directory. Progress advances during this phase. |

While the task runs, `weka fs quota list` reports the quota status as `ADDING`. The status changes to `ACTIVE` when the task completes.

{% hint style="warning" %}
The quota is not enforced while its status is `ADDING`. Reported usage rises as the task progresses and is accurate only once the status changes to `ACTIVE`. Creating hardlinks in the directory fails until the task completes.
{% endhint %}

The directory remains readable and writable throughout.

Setting a quota on an empty directory does not start a task. The quota applies immediately, because the system accounts for new data as it is written.

{% hint style="info" %}
To increase the number of concurrent directory quota tasks, contact the Customer Success Team. The setting requires WEKA supervision.
{% endhint %}
