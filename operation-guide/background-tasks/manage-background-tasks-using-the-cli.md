---
description: View, limit, pause, resume, and abort WEKA background tasks using the CLI.
---

# Manage background tasks using the CLI

## View active background tasks

Lists the background tasks running in the cluster, with the phase and progress of each.

**Command:** `weka cluster task`

```sh
weka cluster task [--show-catalog] [--show-waiting]
```

**Parameters**

| Parameter        | Description                          |
| --- | --- |
| `--show-catalog` | Include catalog tasks in the output. |
| `--show-waiting` | Include waiting tasks in the output. |

## ‌Limit background task resources

Caps the resources background tasks may consume, so they compete less with client I/O.

**Command:** `weka cluster task limits`

```sh
weka cluster task limits
```

## Pause/Resume/Abort a background task

Pauses, resumes, or aborts a running background task.

**Command:** `weka cluster task pause`

```sh
weka cluster task pause <task-id>
```

**Command:** `weka cluster task resume`

```sh
weka cluster task resume <task-id>
```

**Command:** `weka cluster task abort`

```sh
weka cluster task abort <task-id>
```

**Parameters**

| Parameter   | Description    |
| --- | --- |
| `task-id`\* | Task to pause. |
