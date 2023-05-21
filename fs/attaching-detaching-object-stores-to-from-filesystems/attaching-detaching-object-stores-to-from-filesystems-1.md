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

| Name         | Value                                                                                                                                                                                                                                                                      | Default |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `fs-name`\*  | Name of the filesystem to attach with the object store.                                                                                                                                                                                                                    | ​       |
| `obs-name`\* | Name of the object store to attach.                                                                                                                                                                                                                                        |         |
| `mode`       | <p>The type of the object store bucket.<br>Possible values: <code>local</code> or <code>remote</code>.<br><br>A <code>local</code> bucket can only be attached as <code>local</code> .</p><p>A <code>remote</code> bucket can only be attached as <code>remote</code>.</p> | `local` |

## **Detach an object store bucket** from a filesystem

**Command:** `weka fs tier s3 detach`

To detach an object store from a filesystem, use the following command:

`weka fs tier s3 detach <fs-name> <obs-name>`

**Parameters**

| Name         | Value                                                       |
| ------------ | ----------------------------------------------------------- |
| `fs-name`\*  | Name of the filesystem to be detached from the object store |
| `obs-name`\* | Name of the object store to be  detached                    |

{% hint style="info" %}
**Note:** To [recover from a snapshot](../snap-to-obj/#creating-a-filesystem-from-a-snapshot-using-the-cli) uploaded when two `local` object stores have been attached, use the `--additional-obs` parameter in the `weka fs download` command. The primary object store should be the one where the locator has been uploaded to
{% endhint %}
