---
description: Manage Data Services configuration and background tasks.
---

# weka dataservice

Manage dataservice configuration and tasks.

```sh
weka dataservice
```

## weka dataservice global-config

Manage global configuration for the dataservice.

```sh
weka dataservice global-config
```

### weka dataservice global-config set

Set the dataservice global configuration filesystem name.

```sh
weka dataservice global-config set --config-fs <string>
```

| Parameter                 | Description                                                          |
| ------------------------- | -------------------------------------------------------------------- |
| `--config-fs` \<string>\* | Name of the filesystem to use for storing dataservice configuration. |

### weka dataservice global-config show

Show global configuration for the dataservice.

```sh
weka dataservice global-config show
```

## weka dataservice s3-lifecycle-task

Manage S3 lifecycle task manager settings.

```sh
weka dataservice s3-lifecycle-task
```

### weka dataservice s3-lifecycle-task disable

Disable the S3 lifecycle task manager.

```sh
weka dataservice s3-lifecycle-task disable
```

### weka dataservice s3-lifecycle-task enable

Enable the S3 lifecycle task manager.

```sh
weka dataservice s3-lifecycle-task enable
```

### weka dataservice s3-lifecycle-task set

Configure S3 lifecycle task manager settings.

```sh
weka dataservice s3-lifecycle-task set [--interval <duration>] [--max-tasks <uint>]
```

| Parameter                | Description                         |
| ------------------------ | ----------------------------------- |
| `--interval` \<duration> | Interval between task runs.         |
| `--max-tasks` \<uint>    | Maximum number of concurrent tasks. |

### weka dataservice s3-lifecycle-task show

Show S3 lifecycle task manager status and settings.

```sh
weka dataservice s3-lifecycle-task show
```
