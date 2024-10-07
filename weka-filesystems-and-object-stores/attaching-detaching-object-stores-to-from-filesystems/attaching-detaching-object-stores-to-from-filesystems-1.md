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

<table><thead><tr><th>Name</th><th width="367.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Name of the filesystem to attach with the object store.</td><td>​</td></tr><tr><td><code>obs-name</code>*</td><td>Name of the object store to attach.</td><td></td></tr><tr><td><code>mode</code></td><td><p>The operational mode for the object store bucket.<br>The possible values are:</p><ul><li><code>writable</code>: Local access for read/write operations.</li><li><code>remote</code>: Read-only access for remote object stores.</li></ul></td><td><code>writable</code></td></tr></tbody></table>

## **Detach an object store bucket** from a filesystem

**Command:** `weka fs tier s3 detach`

To detach an object store from a filesystem, use the following command:

`weka fs tier s3 detach <fs-name> <obs-name>`

**Parameters**

<table><thead><tr><th width="265">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Name of the filesystem to be detached from the object store</td></tr><tr><td><code>obs-name</code>*</td><td>Name of the object store to be  detached</td></tr></tbody></table>

{% hint style="info" %}
To [recover from a snapshot](../snap-to-obj/#creating-a-filesystem-from-a-snapshot-using-the-cli) uploaded when two `local` object stores have been attached, use the `--additional-obs` parameter in the `weka fs download` command. The primary object store should be the one where the locator has been uploaded to
{% endhint %}
