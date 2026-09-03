---
description: >-
  Protect S3 objects from accidental overwrites and deletions. Bucket versioning
  retains previous versions and creates delete markers for recovery.
---

# S3 versioning

## Key terms

* **Current version:** The most recent version of an object. It's what you retrieve by default.
* **Non-current version:** Any earlier version of an object, retained after an update or overwrite.
* **Delete marker:** A placeholder that becomes the current version when you delete an object. It isn't a real object, and it hides the object from standard list and GET requests.
* **Version ID:** A unique identifier for each object version. Objects stored before you enable versioning have a version ID of `null`.

## Versioning states

Manage bucket versioning through these state transitions:

`Unset` is the initial bucket state. After enabling or suspending versioning, you cannot return to `Unset`.

* `Unset` → `Enabled`
* `Unset` → `Suspended`
* `Enabled` ↔ `Suspended`

## How enabled versioning affects operations

These behaviors apply when bucket versioning is `Enabled`.

* **Update or overwrite:** Creates a new version. WEKA retains the previous version.
* **Delete:** Creates a delete marker instead of removing the object. The object appears deleted, but every version remains accessible by version ID.
* **Delete a delete marker:** Restores the most recent non-current version as current.
* **Delete a specific version ID:** Permanently removes that version.
* **List a bucket:** Returns only current versions. List object versions to see all versions and delete markers.

## Versioning behavior across file protocols

Identify how object operations behave when you access a versioned bucket through a file protocol instead of S3. File-protocol access refers to POSIX, NFS, and SMB access, and behavior is identical across all three.

* **Delete through S3:** WEKA creates a delete marker and sets it as the current version. A standard `GET` returns 404, and the object isn't accessible through a file protocol. Every previous version remains retrievable by version ID or through a list object versions request.
* **Delete through a file protocol:** WEKA removes the object without creating a delete marker. A standard S3 `GET` returns 404, and the object isn't accessible through a file protocol. Previous versions remain retrievable by version ID or through a list object versions request.
* **Rename or move through a file protocol:** WEKA treats the operation as a file-protocol delete of the original path. The object at the original path is no longer the current version, and WEKA doesn't create a delete marker. The moved file remains accessible through the file protocol at its new path. Previous versions remain retrievable by version ID or through a list object versions request.
* **Copy through a file protocol:** The source object is unchanged and remains the current version, with versioning intact. The copy is a new, independent object at the destination path.

#### Behavior summary

| Operation | Delete marker created | Standard S3 GET | Versions by version ID | File-protocol access |
| --- | --- | --- | --- | --- |
| Delete via S3 | Yes | 404 | Retained | Not accessible |
| Delete via file protocol | No | 404 | Retained | Not accessible |
| Rename or move via file protocol | No | 404 at original path | Retained | Accessible at new path |
| Copy via file protocol | No | Source unchanged | Retained | Source and copy accessible |

To keep version state consistent, manage versioned buckets through the S3 protocol.

## Manage bucket versioning using the CLI

Check, enable, or suspend versioning for an S3 bucket.

**Before you begin**

* Ensure the WEKA CLI is configured and you can manage the target bucket.
* Enable versioning for the cluster. Versioning is off by default, and the bucket commands fail with `MethodNotAllowed: The feature is disabled in the global configuration` until you enable it.

    ```bash
    weka s3 cluster update --allow-versioning
    ```

{% hint style="warning" %}
You cannot disable cluster versioning after you enable it. To stop retaining new versions, suspend versioning on the individual buckets.
{% endhint %}

**CLI commands:**

*   Check the versioning state.

    ```bash
    weka s3 bucket versioning get <bucket-name>
    ```
*   Enable versioning.

    ```bash
    weka s3 bucket versioning enable <bucket-name>
    ```
*   Suspend versioning.

    ```bash
    weka s3 bucket versioning suspend <bucket-name>
    ```

For versioning API support, see [S3 supported APIs and limitations](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/additional-protocols/s3/s3-limitations#supported-s3-apis).

## Suspending versioning

When you suspend versioning on a bucket:

* New objects receive a version ID of `null` and overwrite only an existing `null` version. Earlier numbered versions remain retained.
* Deleting an object with a `null` version ID removes it and inserts a delete marker with a `null` version ID.
* Deleting a specific version ID still permanently removes that version.

## Reclaim capacity from noncurrent versions

A versioned bucket retains every earlier version of an object, and those versions consume capacity until you expire them. Suspending versioning does not remove the versions already retained.

Add a lifecycle rule with the `--noncurrent` option to expire earlier versions while keeping the current version of each object:

```bash
weka s3 bucket lifecycle-rule add <bucket-name> <expiry-days> --noncurrent
```

The cluster raises `S3VersioningNoNoncurrentExpirationRule` on a versioned bucket that has no such rule, and `S3VersioningNoDataservIlm` when no active Data Services container has lifecycle management configured.

**Related topics**

[s3-information-lifecycle-management](s3-information-lifecycle-management/ "mention")
