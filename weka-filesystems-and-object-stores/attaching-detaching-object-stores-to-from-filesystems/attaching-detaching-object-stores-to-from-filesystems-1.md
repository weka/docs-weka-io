---
description: Attach or detach object store buckets for filesystems using the CLI.
---

# Attach or detach object store buckets using the CLI

## Attach an object store bucket to a filesystem

Attaches a filesystem to an existing object store bucket so the filesystem can tier data to it.

**Command:** `weka fs tier s3 attach`

```sh
weka fs tier s3 attach <filesystem> <obs-name> [--mode <obs-attach-mode>]
```

**Parameters**

| Parameter                   | Description                                 |
| --------------------------- | ------------------------------------------- |
| `filesystem`\* | Name of the filesystem. |
| `obs-name`\* | Name of the object store bucket to attach. |
| `--mode` \<obs-attach-mode> | Operation mode for the object store bucket. |

## Detach an object store bucket from a filesystem

Detaches a filesystem from an object store bucket.

**Command:** `weka fs tier s3 detach`

```sh
weka fs tier s3 detach <filesystem> <obs-name> [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `filesystem`\* | Name of the filesystem. |
| `obs-name`\* | Name of the object store bucket to detach. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

{% hint style="info" %}
To [recover from a snapshot](../snap-to-obj/#creating-a-filesystem-from-a-snapshot-using-the-cli) uploaded when two `local` object stores have been attached, use the `--additional-obs` parameter in the `weka fs download` command. The primary object store should be the one where the locator has been uploaded to
{% endhint %}
