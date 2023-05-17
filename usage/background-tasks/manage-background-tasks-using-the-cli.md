# Manage background tasks using the CLI

Using the CLI, you can:

* [View running background tasks](manage-background-tasks-using-the-cli.md#viewing-running-background-tasks)
* [Limit background task resources](manage-background-tasks-using-the-cli.md#limit-background-task-resources)
* [Pause/Resume/Abort a background task](manage-background-tasks-using-the-cli.md#pause-resume-abort-a-background-task)

## View active background tasks <a href="#viewing-running-background-tasks" id="viewing-running-background-tasks"></a>

You can view the active background tasks' status, progress, and description.‌

‌**Command:** `weka cluster task`‌

This command is used for viewing all active background tasks.

Example:

```
# weka cluster task
Type       | State   | Progress | Description
-----------+---------+----------+-----------------------------------------------------------
OBS_DETACH | RUNNING | 94       | Detaching Object Storage `obs_1` from filesystem `default`
```

## ‌Limit background task resources

It is possible to limit the resources being used by background tasks.

The configured limit affects external tasks and internal low-priority asynchronous operations.‌

**Command:** `weka cluster task limits`

This command is used to view the defined limits.

**Command:** `weka cluster task limits set [--cpu-limit cpu-limit]`

This command is used to update the CPU limit.

## Pause/Resume/Abort a background task

If there are other background tasks or activities that are of higher priority, you can pause and later resume the background task, or abort it.&#x20;

**Command:** `weka cluster task pause / resume / abort <task-id>`

This command is used to pause, resume, or abort a specific task process. The `abort` subcommand is not applicable when downloading a filesystem or a snapshot. Instead, delete them directly.
