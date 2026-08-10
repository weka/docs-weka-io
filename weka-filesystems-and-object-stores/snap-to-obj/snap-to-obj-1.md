---
description: >-
  The Snap-To-Object feature enables the committing of all the data of a
  specific snapshot to an object store.
---

# Manage Snap-To-Object using the CLI

Using the CLI, you can:

* [Upload a snapshot](snap-to-obj-1.md#upload-a-snapshot)
* [Create a filesystem from a local uploaded snapshot](snap-to-obj-1.md#create-a-filesystem-from-a-local-uploaded-snapshot)
* [Manage synchronous snapshots](snap-to-obj-1.md#manage-synchronous-snapshots)
* [Recover a filesystem from a remote-only snapshot](snap-to-obj-1.md#recover-a-filesystem-from-a-remote-only-snapshot)

## Upload a snapshot

**Command:** `weka fs snapshot upload`

Use the following command line to upload an existing snapshot:

`weka fs snapshot upload <file-system> <snapshot> [--site site]`

**Parameters**

<table><thead><tr><th width="186.33333333333331">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>Filesystem name.</td></tr><tr><td><code>snapshot</code>*</td><td>Snapshot name of the <code>&#x3C;file-system></code> filesystem to upload.<br></td></tr><tr><td><code>site</code>*</td><td>Location for the snapshot upload.<br>Mandatory only if both <code>local</code> and <code>remote</code> buckets are attached.<br>Possible values: <code>local</code> or <code>remote</code><br>Default: Auto-selected if only one bucket for upload is attached.</td></tr></tbody></table>

## Create a filesystem from a local uploaded snapshot

**Command:** `weka fs download`

Create or recreate a filesystem from a snapshot that is available in a local object store bucket. Use this procedure after a regular snapshot upload, or after you temporarily map a remote snapshot bucket as local during recovery. If the snapshot exists only in a remote bucket, use [Recover a filesystem from a remote-only snapshot](snap-to-obj-1.md#recover-a-filesystem-from-a-remote-only-snapshot). If the snapshot originates from an encrypted source, include the required KMS-related parameters:

`weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator>` \[--auth-required auth-required] `[--additional-obs additional-obs] [--snapshot-name snapshot-name] [--access-point access-point] [--kms-key-identifier kms-key-identifier] [--kms-namespace kms-namespace] [--kms-role-id kms-role-id] [--kms-secret-id kms-secret-id] [--skip-resource-validation]`

When creating a filesystem from a snapshot, a background cluster task automatically prefetches its metadata, providing better latency for metadata queries.

**Parameters**

<table><thead><tr><th width="240">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the filesystem to create.</td></tr><tr><td><code>group-name</code>*</td><td>Name of the filesystem group in which the new filesystem is placed.</td></tr><tr><td><code>total-capacity</code>*</td><td>The total capacity of the downloaded filesystem.</td></tr><tr><td><code>ssd-capacity</code>*</td><td>SSD capacity of the downloaded filesystem.</td></tr><tr><td><code>obs-bucket</code>*</td><td>Object store name for tiering.</td></tr><tr><td><code>locator</code>*</td><td>Object store locator obtained from a previously successful snapshot upload.</td></tr><tr><td><code>auth-required</code></td><td>Require authentication for the mounting user when mounting this filesystem. This setting is only applicable in the root organization; users in non-root organizations must always be authenticated to perform a mount operation. Format: <code>yes</code> or <code>no</code>.<br>Default: <code>no</code></td></tr><tr><td><code>additional-obs</code></td><td>An additional object-store name.<br>If the data to recover reside in two object stores (a second object store attached to the filesystem, and the filesystem has not undergone full migration), this object store is attached in a <code>read-only</code> mode.<br>The snapshot locator must be in the primary object store specified in the <code>obs</code> parameter.</td></tr><tr><td><code>snapshot-name</code></td><td>The downloaded snapshot name.<br>Default: The uploaded snapshot name.</td></tr><tr><td><code>access-point</code></td><td>The downloaded snapshot access point.<br>Default: The uploaded access point.</td></tr><tr><td><code>kms-key-identifier</code></td><td>Customize KMS key name for this filesystem (applicable only for HashiCorp Vault).</td></tr><tr><td><code>kms-namespace</code></td><td>Customize the KMS role ID for this filesystem (applicable only for HashiCorp Vault).</td></tr><tr><td><code>kms-role-id</code></td><td>Customize the KMS role ID for this filesystem (applicable only for HashiCorp Vault).</td></tr><tr><td><code>kms-secret-id</code></td><td>Customize the KMS secret ID for this filesystem (applicable only for HashiCorp Vault).</td></tr><tr><td><code>skip-resource-validation</code></td><td>Skip verifying RAM and SSD resource allocation for the downloaded filesystem on the cluster.</td></tr></tbody></table>

{% hint style="info" %}
For encrypted filesystems, when downloading, you must use the same KMS cluster-wide key or, if configured, the per-filesystem encryption parameters to decrypt the snapshot data. For more information, see [kms-management](../../security/kms-management/ "mention").
{% endhint %}

The `locator` can be a previously saved locator for disaster scenarios, or you can obtain the `locator` using the `weka fs snapshot` command on a system with a live filesystem with snapshots.

If you need to pause and resume the download process, use the command: `weka cluster task pause / resume`. To abort the download process, delete the downloaded filesystem directly. For details, see [background-tasks](../../operation-guide/background-tasks/ "mention").

{% hint style="info" %}
Use this procedure only when the uploaded snapshot is available in a local object store bucket. Direct download from a remote object store bucket is not allowed because of bandwidth and cost considerations. If the snapshot exists only in a remote bucket, follow [Recover a filesystem from a remote-only snapshot](snap-to-obj-1.md#recover-a-filesystem-from-a-remote-only-snapshot).
{% endhint %}

## Manage synchronous snapshots

The workflow to manage the synchronous snapshots includes:

1. Upload snapshots using, for example, the snapshots scheduler.
2. Download the synchronous snapshot (described below).
3. Restore a specific snapshot to a filesystem. See

**Related topics**

[snapshots](../snapshots/ "mention")

[#restore-a-snapshot-to-a-filesystem-or-another-snapshot](../snapshots/snapshots-1.md#restore-a-snapshot-to-a-filesystem-or-another-snapshot "mention")

### Download a synchronous snapshot

**Command:** `weka fs snapshot download`

Use the following command line to download a synchronous snapshot. This command is only relevant for snapshots uploaded from a system of version 4.3 and later:

`weka fs snapshot download <file-system> <locator>`

{% hint style="warning" %}
Make sure to download synchronous snapshots in chronological order. Non-chronological snapshots are inefficient and are not synchronous.

If you need to download a snapshot earlier than the latest downloaded one, for example, when you need one of the daily synchronous snapshots after the weekly synchronous snapshot was downloaded, add the `--allow-non-chronological` flag to download it anyway.
{% endhint %}

**Parameters**

<table><thead><tr><th width="146">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>Name of the filesystem.</td></tr><tr><td><code>locator</code>*</td><td>Object store locator obtained from a previously successful snapshot upload.</td></tr></tbody></table>

If you need to pause and resume the download process, use the command: `weka cluster task pause / resume`. To abort the download process, delete the downloaded snapshot directly.

**Related topics**

[#synchronous-snapshots](./#synchronous-snapshots "mention")

[background-tasks](../../operation-guide/background-tasks/ "mention")

## Recover a filesystem from a remote-only snapshot

Recover a filesystem when the required snapshot exists only in a remote object store bucket. This workflow differs from the local download workflow in one step. You still use `weka fs download` to create the filesystem, but you first create a temporary local bucket definition that points to the remote snapshot bucket.

**Before you begin**

* Identify the remote bucket endpoint, bucket name, region, and credentials.
* Use object store credentials that can read and write the bucket. For example, use an S3 user with a `readwrite` policy.
* Ensure the WEKA cluster has network connectivity to the remote object store.
* Identify the filesystem group, capacities, and snapshot locator.
* Verify sufficient licensing for the new filesystem capacity.

**Procedure**

1.  Add a temporary local bucket definition that points to the remote snapshot bucket:

    <pre class="language-bash" data-overflow="wrap"><code class="lang-bash">weka fs tier s3 add &#x3C;recovery-bucket-name> [--site local] [--obs-name obs-name] [--hostname hostname] [--bucket bucket] [--auth-method auth-method] [--region region] [--access-key-id access-key-id] [--secret-key secret-key] [--protocol protocol]
    </code></pre>

    Use the bucket that contains the uploaded snapshot. The `recovery-bucket-name` value is the WEKA OBS connection name. Use this name in later `attach` and `detach` commands. If the endpoint is another WEKA system that uses a self-signed certificate, set `--protocol HTTPS_UNVERIFIED`.
2.  Create the filesystem from the snapshot:

    <pre class="language-bash" data-overflow="wrap"><code class="lang-bash">weka fs download &#x3C;name> &#x3C;group-name> &#x3C;total-capacity> &#x3C;ssd-capacity> &#x3C;recovery-bucket-name> &#x3C;locator>
    </code></pre>
3.  If the recovered filesystem needs a writable tiering bucket, add it and attach it:

    <pre class="language-bash" data-overflow="wrap"><code class="lang-bash">weka fs tier s3 add &#x3C;tier-bucket-name> [--site local] [--obs-name obs-name] [--hostname hostname] [--bucket bucket] [--auth-method auth-method] [--region region] [--access-key-id access-key-id] [--secret-key secret-key] [--protocol protocol]
    weka fs tier s3 attach &#x3C;fs-name> &#x3C;tier-bucket-name> [--mode writable]
    </code></pre>
4.  Detach the temporary recovery bucket from the recovered filesystem:

    ```bash
    weka fs tier s3 detach <fs-name> <recovery-bucket-name>
    ```

    If the CLI asks for confirmation, rerun the command with `-f`.
5.  If the filesystem also needs a remote backup bucket, create the bucket definition and attach it in remote mode:

    <pre class="language-bash" data-overflow="wrap"><code class="lang-bash">weka fs tier s3 add &#x3C;remote-bucket-name> --site remote [--obs-name obs-name] [--hostname hostname] [--bucket bucket] [--auth-method auth-method] [--region region] [--access-key-id access-key-id] [--secret-key secret-key] [--protocol protocol]
    weka fs tier s3 attach &#x3C;fs-name> &#x3C;remote-bucket-name> --mode remote
    </code></pre>
6.  Delete the temporary recovery bucket definition when recovery is complete:

    ```bash
    weka fs tier s3 delete <recovery-bucket-name>
    ```

    If the delete command reports that the bucket is still in use, wait a few seconds and retry.

{% hint style="info" %}
For full bucket syntax, see [Manage object stores using the CLI](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/weka-filesystems-and-object-stores/managing-object-stores/managing-object-stores-1). For attach and detach syntax, see [Attach or detach object store buckets using the CLI](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/weka-filesystems-and-object-stores/attaching-detaching-object-stores-to-from-filesystems/attaching-detaching-object-stores-to-from-filesystems-1).
{% endhint %}

**Related topic**

[managing-object-stores](../managing-object-stores/ "mention")
