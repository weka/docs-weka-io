---
description: >-
  Upload snapshots to object storage and recover filesystems from local or
  remote snapshots using the CLI.
---

# Manage Snap-To-Object using the CLI

## Upload a snapshot

Uploads a snapshot to the object store attached to its filesystem, so it can be restored later or on another cluster.

**Command:** `weka fs snapshot upload`

```sh
weka fs snapshot upload <filesystem> <name> [--allow-non-chronological] [--site <obs-site>]
```

**Parameters**

| Parameter                   | Description                                                                                   |
| --- | --- |
| `filesystem`\* | Filesystem name. |
| `name`\* | Snapshot name. |
| `--allow-non-chronological` | Allow uploading snapshots to remote object store in non-chronological order. Not recommended. |
| `--site` \<obs-site> | Site of the object store to upload to (LOCAL or REMOTE). Possible values: `local` or `remote`Default: Auto-selected if only one bucket for upload is attached |

## Create a filesystem from a local uploaded snapshot

Creates a filesystem from a snapshot previously uploaded to an object store.

**Command:** `weka fs download`

```sh
weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator> [--access-point <string>] [--additional-obs-bucket <string>] [--audit-enabled] [--auth-required] [--kms-key-identifier <string>] [--kms-namespace <string>] [--kms-role-id <string>] [--kms-secret-id <string>] [--snapshot-name <string>]
```

**Parameters**

| Parameter                           | Description                                                                                                                      |
| --- | --- |
| `name`\* | Name of filesystem for this operation. |
| `group-name`\* | Filesystem group to create the downloaded filesystem in. |
| `total-capacity`\* | Total capacity of the downloaded filesystem. |
| `ssd-capacity`\* | SSD capacity of the downloaded filesystem. |
| `obs-bucket`\* | Object Store bucket containing the filesystem data. |
| `locator`\* | Locator for the filesystem snapshot in object storage. |
| `--access-point` \<string> | Access point for the downloaded snapshot. Defaults to the uploaded access point. Default: The uploaded access point |
| `--additional-obs-bucket` \<string> | Additional Object Store bucket for the downloaded filesystem. |
| `--audit-enabled` | Enable filesystem auditing. |
| `--auth-required` | Require the mounting user to be authenticated. Effective only in the root organization; non-root users must always authenticate. Default: `no` |
| `--kms-key-identifier` \<string> | Customize KMS key identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-namespace` \<string> | Customize KMS namespace for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-role-id` \<string> | Customize KMS role identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-secret-id` \<string> | Customize KMS secret identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--snapshot-name` \<string> | Name for the downloaded snapshot. Defaults to the uploaded name. Default: The uploaded snapshot name |

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

Downloads a snapshot from the object store into an existing filesystem.

**Command:** `weka fs snapshot download`

```sh
weka fs snapshot download <filesystem> <locator> [--access-point <string>] [--allow-divergence] [--allow-non-chronological] [--name <string>]
```

**Parameters**

| Parameter                   | Description                                                                                       |
| --- | --- |
| `filesystem`\* | Filesystem name. |
| `locator`\* | Object store locator for the snapshot. |
| `--access-point` \<string> | Access point. Defaults to the uploaded access point. |
| `--allow-divergence` | Allow downloading snapshots that are not descendants of the last downloaded snapshot. |
| `--allow-non-chronological` | Allow downloading snapshots from remote object store in non-chronological order. Not recommended. |
| `--name` \<string> | Snapshot name. Defaults to the uploaded name. |

If you need to pause and resume the download process, use the command: `weka cluster task pause / resume`. To abort the download process, delete the downloaded snapshot directly.

**Related topics**

[#synchronous-snapshots](./#synchronous-snapshots "mention")

[background-tasks](../../operation-guide/background-tasks/ "mention")

{% hint style="warning" %}
Make sure to download synchronous snapshots in chronological order. Non-chronological snapshots are inefficient and are not synchronous.

If you need to download a snapshot earlier than the latest downloaded one, for example, when you need one of the daily synchronous snapshots after the weekly synchronous snapshot was downloaded, add the `--allow-non-chronological` flag to download it anyway.
{% endhint %}

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
    weka fs tier s3 remove <recovery-bucket-name>
    ```

    If the delete command reports that the bucket is still in use, wait a few seconds and retry.

{% hint style="info" %}
For full bucket syntax, see [Manage object stores using the CLI](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/weka-filesystems-and-object-stores/managing-object-stores/managing-object-stores-1). For attach and detach syntax, see [Attach or detach object store buckets using the CLI](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/weka-filesystems-and-object-stores/attaching-detaching-object-stores-to-from-filesystems/attaching-detaching-object-stores-to-from-filesystems-1).
{% endhint %}

**Related topic**

[managing-object-stores](../managing-object-stores/ "mention")
