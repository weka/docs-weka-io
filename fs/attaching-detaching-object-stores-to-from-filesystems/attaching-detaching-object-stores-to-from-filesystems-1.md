---
description: >-
  This page describes how to attach or detach object store buckets to or from
  filesystems using the CLI.
---

# Attach or detach object store buckets using the CLI

Using the CLI, you can:&#x20;

* [Attach an object store bucket to a filesystem](attaching-detaching-object-stores-to-from-filesystems-1.md#attach-an-object-store-bucket)
* [Detach an object store bucket from a filesystem](attaching-detaching-object-stores-to-from-filesystems-1.md#detach-an-object-store-bucket)

## **Attach an object store bucket** to a filesystem

**Command:** `weka fs tier s3 attach`

To attach an object store to a filesystem, use the following command:

`weka fs tier s3 attach <fs-name> <obs-name> [--mode mode]`

**Parameters**

| **Name**   | **Type** | **Value**                                                 | **Limitations**                                                                                                                             | **Mandatory** | **Default** |
| ---------- | -------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `fs-name`  | String   | Name of the filesystem to be attached to the object store | Must be a valid name                                                                                                                        | Yes           | ​           |
| `obs-name` | String   | Name of the object store to be  attached                  | Must be a valid name                                                                                                                        | Yes           |             |
| `mode`     | String   | `writable` or `remote`                                    | <p><code>writable</code>: Local access for read/write operations.</p><p><code>remote</code>: Read-only access for remote object stores.</p> | No            | `writable`  |

## **Detach an object store bucket** from a filesystem

**Command:** `weka fs tier s3 detach`

To detach an object store from a filesystem, use the following command:

`weka fs tier s3 detach <fs-name> <obs-name>`

**Parameters**

| **Name**   | **Type** | **Value**                                                   | **Limitations**      | **Mandatory** | **Default** |
| ---------- | -------- | ----------------------------------------------------------- | -------------------- | ------------- | ----------- |
| `fs-name`  | String   | Name of the filesystem to be detached from the object store | Must be a valid name | Yes           | ​           |
| `obs-name` | String   | Name of the object store to be  detached                    | Must be a valid name | Yes           |             |

{% hint style="info" %}
**Note:** To [recover from a snapshot](../snap-to-obj/#creating-a-filesystem-from-a-snapshot-using-the-cli) uploaded when two `local` object stores have been attached, use the `--additional-obs` parameter in the `weka fs download` command. The primary object store should be the one where the locator has been uploaded to
{% endhint %}
