---
description: >-
  S3 bucket migration enables non-disruptive transfer of S3 buckets from one
  WEKA S3 cluster (source) to another (target) while maintaining continuous
  availability and transparent access for S3 clients.
---

# S3 bucket migration between clusters

## Overview

WEKA’s S3 bucket migration feature enables seamless, non-disruptive transfer of S3 buckets between WEKA clusters, allowing continuous access by S3 clients without requiring any changes on the client side. This capability is essential for operations such as cluster upgrades, data center consolidation, performance rebalancing, capacity expansion, or geographic data relocation.

The migration mechanism operates at the individual bucket level, combining intelligent traffic redirection with background data migration. During migration, client requests are progressively routed through the target cluster using defined forwarding modes, while the actual data transfer occurs concurrently.

To support efficient and consistent migration, the system uses two coordinated components:

* The target cluster’s native in-line migration path, which handles live S3 client traffic and request forwarding.
* The WEKA S3 Migrator (`s3migrate`), a high-performance utility that runs out-of-band to migrate data from source to target buckets in the background. This tool performs full and differential copies, ensuring the target becomes fully authoritative with minimal disruption.

Key characteristics include:

* **Non-disruptive operation**: Client applications continue to read/write throughout the migration.
* **Transparent to clients**: No reconfiguration of S3 clients is required.
* **Per-bucket control**: Migrations are configured and managed on a per-bucket basis.
* **Support for differently sized clusters and buckets**.
* **Dry-run support**: Enables safe testing of the forwarding configuration with selected clients.
* **Rollback support**: Migration can be safely rolled back during early phases before commitment.
* **Strict 1:1 mapping**: Each source bucket maps to one target bucket with the same name.

This approach ensures operational continuity, supports detailed validation before cutover, and minimizes migration risks through controlled state transitions and rollback-safe procedures.

### Scope and considerations

To ensure a successful migration, it is important to understand the scope of the feature. The following points outline the responsibilities and boundaries of the migration process.

* **Migration scope**: The feature is designed to migrate buckets between two WEKA clusters. It does not support migrating buckets from non-WEKA sources.
* **Migration unit**: Migration operates on a full bucket basis. The process transfers the entire contents of a source bucket to its destination and does not support selective or partial bucket migration.
* **DNS configuration**: Successful traffic redirection relies on manual DNS updates. You are responsible for configuring the necessary DNS records to point S3 clients to the target cluster.
* **Target bucket setup**: The target bucket must be configured on the destination cluster before initiating the migration. The process does not automatically create or configure the target bucket.
* **Metadata transfer**: The migration transfers object data and standard S3 metadata. POSIX-specific metadata and in-progress multipart upload (MPU) information are not migrated. It is recommended to complete or abort ongoing multipart uploads before the final cutover.
* **Security settings**: Security principals, such as service accounts and STS configurations, are not migrated. You must recreate these security settings on the target cluster to maintain access control.
* **Migration performance**: The duration of the migration process is primarily determined by two factors: the total quantity of objects in the source bucket and the available network bandwidth between the clusters. Plan for a longer synchronization period for buckets containing a high volume of objects.

### Migration modes

The S3 bucket migration process is managed by a sequence of operational modes on the **target cluster**. These modes dictate how the target cluster handles client requests and coordinates the data transition from the source cluster.

The migration progresses through the following sequence of modes:

<figure><img src="../../.gitbook/assets/S3_sync_states.png" alt=""><figcaption><p>Migration modes</p></figcaption></figure>

This structured progression ensures a controlled migration, from initial setup and traffic redirection to final data transfer and cutover.

* **Ready mode:** This is the initial and final state of the target cluster.
  * **Before migration:** The target cluster is a standard, standalone cluster, ready to be configured as a migration target.
  * **After migration:** The target cluster is fully operational, serving all client traffic directly after the migration is complete and the source is decommissioned.
* **Forward mode:** In this mode, the target cluster forwards specific client requests to the source bucket. It allows you to run a dry run using the new endpoint with a small group of clients to verify functionality and configuration before the bulk data migration.\
  A rollback from **`Forward`** mode back to **`Ready`** is possible, which effectively cancels the migration before any significant data transfer occurs.
* **Migrate mode:** This is the primary data transfer phase. The system copies data from the source bucket to the target bucket. During this process, the target cluster continues to serve client requests, ensuring service continuity.

Each mode transition is controlled by an administrator using the `weka s3 bucket migrate update --mode` command.

### S3 bucket migration workflow overview

The S3 WEKA bucket migration workflow consists of four structured phases designed to ensure a seamless, secure, and controlled transition from a source cluster to a target cluster. Each phase includes validation and monitoring steps to ensure data consistency, minimize risk, and provide clear rollback or recovery points when applicable.

<details>

<summary><strong>Phase 1: Preparation (ready mode)</strong></summary>

This phase sets up all prerequisites for a safe and controlled migration. The illustration shows a new target cluster with an empty bucket matching the source name. Key actions include:

* Installing the WEKA S3 Migrator.
* Replicating IAM users and policies.
* Configuring distinct DNS entries for both the source and target buckets.
* TLS certificates are validated to cover both hostnames.
* Performance checks confirm the target cluster can handle client load and migration throughput.

<figure><img src="../../.gitbook/assets/s3_migrate_phase_1.png" alt=""><figcaption><p>Phase 1: Preparation (ready mode)</p></figcaption></figure>

</details>

<details>

<summary><strong>Phase 2: Forward mode configuration and validation</strong></summary>

This phase initiates the migration process by enabling the `forward` mode. The goal is to allow non-disruptive client testing through the target cluster, while all operations are still handled by the source bucket.

The diagram illustrates:

* Target buckets are attached to source buckets.
* The target bucket is in `forward` mode, forwarding all client operations (GET, PUT, DELETE) to the source.
* Test clients are configured to access the target cluster (through DNS or `/etc/hosts`), allowing validation of:
  * TLS connectivity
  * Data access through forwarding
  * IAM and policy alignment
* All operations received at the target cluster are transparently forwarded to the source cluster.
* The DNS is still actively routing most client traffic to the source cluster until full cutover.

<figure><img src="../../.gitbook/assets/s3_migrate_phase_2.png" alt=""><figcaption><p>Phase 2: Forward mode configuration and validation</p></figcaption></figure>

</details>

<details>

<summary><strong>Phase 3: Migrate mode and access control configuration</strong></summary>

In this phase, the target cluster takes over write operations, while still serving read requests through fallback to the source if needed. The diagram illustrates the following:

* Clients are routed to the target cluster through DNS, and write all new data (PUT, DELETE, MPU) directly to the target.
* Read requests (GET, HEAD) are handled by the target cluster. If the requested object is not found, it is forwarded to the source cluster.
* The WEKA S3 Migrator begins actively copying data from the source to the target.
* The source buckets are set to read-only, and access is restricted to the migration user only by IAM conditions.
* The target becomes the system of record for new data, while the source serves as a fallback during this transitional state.

<figure><img src="../../.gitbook/assets/s3_migrate_phase_3.png" alt=""><figcaption><p>Phase 3: Migrate mode and access control configuration</p></figcaption></figure>

</details>

<details>

<summary><strong>Phase 4: Finalization (ready mode - final)</strong></summary>

In this final phase, the target cluster fully handles all client operations, and the source cluster is no longer involved. The diagram illustrates a system where:

* All S3 requests (GET, PUT, DELETE, MPU) are served directly by the target bucket.
* The WEKA S3 Migrator has completed all data transfers, including differential passes.
* MPUs have fully transitioned or concluded on the target.
* Lifecycle policies (ILM) can be re-enabled on the target bucket.

This state reflects the completion of the migration, where the target bucket operates independently as a standard S3 bucket with no dependency on the source cluster.

<figure><img src="../../.gitbook/assets/s3_migrate_phase_4.png" alt=""><figcaption><p>Phase 4: Finalization (ready mode – final)</p></figcaption></figure>

</details>

## Key operational principles of `s3migrate`

The `s3migrate` tool is built on several core principles that ensure migrations are efficient, resilient, and manageable at scale. Understanding these principles helps you effectively control the migration process.

### **Resumable migrations**

The tool ensures operational resilience by recording every handled object in a sorted `migrate.log` file. In the event of an interruption, such as a process failure or manual stop (CTRL-C), the migration can be resumed precisely from the point of failure.

To continue an interrupted job, retrieve the last object key from the `migrate.log` file and use it with the `--start-after` parameter in the next run. This avoids re-processing objects that have already been transferred successfully.

### **Concurrency control**

You can manage the resource impact of the migration by controlling the number of simultaneous object transfers. The number of worker threads, configured with the `--threads` parameter, determines the level of concurrency. Adjusting this value allows you to balance migration speed against the load on your systems and network.

### **Distributed migration**

For very large datasets, the migration workload can be distributed across multiple hosts to run in parallel. This is achieved using two parameters:

* `--hash-count`: Defines the total number of hosts participating in the migration.
* `--hash-value`: Assigns a unique index to each host, which then processes its designated portion of the objects.

### **Targeted failure handling**

The tool provides a streamlined process for retrying objects that fail due to transient issues, such as network interruptions or temporary disk space shortages.

All failed object transfers are recorded in a `failed.log` file. Using the `--failed-to-folder` parameter, the tool processes this log and organizes the keys of the failed objects into a new source folder. This prepares a targeted second run that attempts to migrate only the objects that failed previously.

## S3 bucket migration procedures

### Phase 1: Preparation (ready mode)

This phase involves preparing the target environment to mirror the source configuration. Key activities include deploying the target cluster, creating and configuring the bucket, replicating security policies, and setting up the necessary DNS and TLS records. Successful completion of these steps ensures that the target environment is fully provisioned and ready to begin the migration process.

**Procedure**

1. **Prepare the target environment:**
   * Deploy a WEKA cluster that supports S3 bucket migration (for the version details, contact the Customer success Team).
   * Obtain and install the WEKA S3 Migrator (`s3migrate`) on either a server within the source cluster or on a standalone server with network connectivity to both the source and target clusters. For parallel execution, the WEKA S3 Migrator can be installed on multiple servers. Contact the Customer Success Team for access credentials and detailed installation instructions.
2. **Create and validate the target bucket:**
   *   Create a new, empty S3 bucket on the target cluster.

       The target bucket must use the same name as the source bucket to preserve seamless access for clients.
   * Capacity planning: Ensure the target cluster has sufficient capacity to store all objects from the source bucket, with at least an additional 10% overhead or more if growth is expected.
   * Performance validation: Confirm that the target bucket can sustain the peak load of the source bucket, including regular client access and migration throughput.
3. **Disable ILM on the target bucket:**
   * Ensure that S3 Lifecycle Management (ILM) is disabled on the target bucket during migration.
   * ILM settings are not migrated automatically and must be reconfigured after finalization if required.
4. **Replicate users and IAM policies:** Manually replicate all relevant S3 users, bucket policies, and IAM policies from the source to the target cluster.

{% hint style="info" %}
UID/GID metadata associated with S3 objects is not preserved. Ensure that the target environment reflects the correct access model independently.
{% endhint %}

5. **Adjust DNS TTL for the source bucket:** Reduce the TTL (Time-To-Live) value of the source bucket’s DNS record to a low value (for example, 30 seconds) to allow fast DNS propagation when traffic is later redirected.
6. **Configure a dedicated source bucket DNS record:** Create a DNS host record that points to the IPs of the source bucket. This record must remain fixed and associated with the source cluster throughout the migration process.
7. **Configure a dedicated target bucket DNS record:** Create a dedicated DNS host record that resolves to the target bucket. This record must remain constant and will serve as the long-term access point after migration is complete.
8. **Provision S3 migration users:**
   1. Create two users on the source cluster and one on the target cluster to support both inline and background migration operations:
      * On the source cluster:
        * s3\_ro\_migrate: Read-only access for the WEKA S3 Migrator.
        * s3\_rw\_migrate: Read/write access used by the target cluster for inline forwarding operations.
      * On the target cluster:
        * s3\_rw\_migrate: Read/write access for the WEKA S3 Migrator to write data into the target bucket.
   2. Ensure credentials for these users are securely configured on the systems that require them:
      * The target cluster requires s3\_rw\_migrate credentials for the source bucket.
      * The WEKA S3 Migrator requires:
        * s3\_ro\_migrate for the source bucket.
        * s3\_rw\_migrate for the target bucket.
9. **Configure and validate TLS on the target cluster:** Ensure that the target cluster presents a valid TLS certificate that covers both the source bucket hostname and the target bucket hostname. This is necessary to support seamless client redirection and avoid TLS validation errors during migration.

<details>

<summary>Accepted certificate formats</summary>

* A single certificate with multiple Subject Alternative Name (SAN) entries that explicitly list the source and target hostnames.
* A wildcard certificate (e.g., \*.example.com) that covers all required DNS names.

If the current TLS certificate does not cover both hostnames, a new certificate must be generated and uploaded to the WEKA system using the following CLI command:

```bash
weka security tls set [--private-key private-key]
                     [--certificate certificate]
```

For certificate format requirements and update procedures, see [tls-certificate-management](../../security/tls-certificate-management/ "mention").

To inspect which DNS names are currently covered by the certificate on the target cluster, use this diagnostic command:

{% code overflow="wrap" %}
```bash
CERT_TEXT=$(echo | openssl s_client  -connect <weka_hostname>:14000 2>/dev/null | openssl x509 -noout -text); \
if echo "$CERT_TEXT" | grep -q 'DNS:'; then \
echo "$CERT_TEXT" | grep 'DNS:' | sed 's/DNS://g' | tr -d ' ' | tr ',' '\n'; \
else echo "$CERT_TEXT" | grep 'Subject:' | sed 's/.*CN *= *//'; \
fi; }
```
{% endcode %}

</details>

{% hint style="warning" %}
**Important:** Once the source-to-target configuration synchronization is complete, any modifications to the bucket configuration during migration must be coordinated with WEKA.
{% endhint %}

### Phase 2: Forward mode configuration and validation

This phase configures the target bucket to operate in `forward` mode. This setup transparently redirects all S3 client traffic from the target cluster to the source bucket, ensuring all operations remain centralized on the source and providing seamless service continuity for clients during the DNS transition.

It is important to understand the performance implications of this mode. Because each request involves an additional network round trip from the target to the source, `forward` mode inherently adds latency to client operations. As a general guideline, this can approximately double the request latency compared to a direct operation.

**Procedure**

1. **Attach the target bucket to the source bucket:** Link the target bucket to the source bucket, allowing forwarding behavior to be initiated. The target and source buckets must exist and be accessible using the provided S3 credentials.\
   Use the following command on the target cluster. For command details, see [#weka-s3-bucket-migrate-attach](s3-bucket-migration-between-clusters.md#weka-s3-bucket-migrate-attach "mention").

{% code overflow="wrap" %}
```bash
weka s3 bucket migrate attach <target-bucket> <source-url> <s3_key> <s3_secret> <tls_cert> [--source <source-bucket>]
```
{% endcode %}

2. **Set the target bucket to forward mode:** The forward mode redirects all S3 client requests arriving at the target cluster to the source bucket, ensuring no disruption during the DNS switchover. \
   Use the following command to set the target bucket to `forward` mode. For command details, see [#weka-s3-bucket-migrate-update](s3-bucket-migration-between-clusters.md#weka-s3-bucket-migrate-update "mention").

```bash
weka s3 bucket migrate update --url <source-url> --mode forward
```

3. **Update DNS or load balancer configuration:**
   * Repoint the S3 bucket hostname to the target cluster’s IP addresses.
   * Ensure DNS TTL is low (for example, 30 seconds) to allow fast client redirection.
4. **Monitor DNS propagation and client behavior:**
   * Allow time for DNS changes to take effect.
   * Some clients may continue using cached DNS entries and still contact the source.
   * System behavior in forward mode:
     * All incoming requests (GET, PUT, DELETE, etc.) to the target cluster are forwarded to the source bucket.
     * Operations received directly at the source continue to be processed natively.
     * This guarantees that all modifications are centralized on the source bucket, ensuring full consistency.
5. **Validate the forward mode functionality:**
   * Point test clients to the target bucket hostname and verify functional access.
   * Confirm TLS certificate resolution by temporarily adding an entry in `/etc/hosts` mapping the source hostname to the target IP.
   * Perform functional checks (for example, read/write operations), then revert the `/etc/hosts` changes.
   * Notify internal users that the target bucket is available for early testing and validation.

### Phase 3: **Migrate mode and access control configuration**

This phase transitions the migration from traffic forwarding to active data transfer. The target cluster assumes responsibility for processing client operations while the WEKA S3 Migrator begins copying data from the source bucket.

**Procedure**

1. **Migrate source bucket hostname to the target cluster:**&#x20;
   * Modify the DNS or load balancer record for the source bucket to point to the target cluster IPs.
   * Prepare to handle residual traffic from clients using cached IP addresses still pointing to the source.
2. **Verify source bucket is not accessed by non-migration access:**
   * Monitor the source bucket and confirm that no S3 clients (other than the migration client or the target system) are actively accessing it.
   * Do not proceed until the source is fully idle, ensuring a clean cutover.
3. **Restrict access to the source cluster:** To prevent direct access to source data during the migration, apply one of the following access control approaches based on your operational preference:

{% hint style="warning" %}
This step is crucial and must be completed successfully before you proceed. Restricting access prevents clients from updating the source data. Any updates made to the source after this point might not be migrated to the target, which can lead to data inconsistencies.
{% endhint %}

<details>

<summary>Option 1: Cluster-wide restriction</summary>

This is the recommended approach as it ensures consistent enforcement and minimizes risk. Only apply this after confirming that no direct client access to the source cluster is active.

1. Back up the IAM policies for all S3 buckets in the source cluster.
2. Take snapshots of all associated filesystems.
3. Detach all IAM policies from the source buckets.
4. Create a new user named s3\_ro\_migrate with read-only access to S3 objects. This account will be used exclusively by the WEKA S3 Migrator.

</details>

<details>

<summary>Option 2: Per-bucket restriction</summary>

If restricting access to a single bucket (while allowing client access to others):

1. Back up the IAM policy for the specific bucket.
2. Take a snapshot of the corresponding filesystem.
3. Review IAM policies and:
   * Explicitly deny access to the bucket.
   * If a user’s access is limited exclusively to this bucket, detach or delete the policy to fully revoke access.
   * Otherwise, update the policy to add an explicit deny condition for the target bucket only.
4. Create (or confirm existence of) the s3\_ro\_migrate user with read-only access to the specific bucket.

</details>

4. **Run the `s3find` script on both clusters**: Use the script to locate and list all objects for each bucket on both the source and target systems. For details, see [#find-and-filter-s3-objects-using-the-s3find-script](s3-bucket-migration-between-clusters.md#find-and-filter-s3-objects-using-the-s3find-script "mention").

{% hint style="info" %}
The process of listing the bucket objects may take a significant amount of time (from minutes to hours), depending on the size of the bucket.
{% endhint %}

5. **Run the WEKA S3 Migrator in dry-run:** To ensure that the WEKA S3 Migrator can access and interpret data correctly from the source cluster before performing a full operation, access the server installed with WEKA S3 Migrator and run it to simulate processing the first 10,000 records using the WEKA S3 Migrator command with the `--dry-run` and `--first 10000` options. For details, see [#weka-s3-migrator-s3migrate-command](s3-bucket-migration-between-clusters.md#weka-s3-migrator-s3migrate-command "mention").&#x20;

{% hint style="warning" %}
After this step, the target bucket becomes the system of record. Reversing the migration from this point is a complex procedure with a significant risk of data inconsistency and is strongly discouraged.
{% endhint %}

6. **Set the target bucket to migrate mode:** Use the following command to change the migration mode of the bucket to `migrate`. For command details, see [#weka-s3-bucket-migrate-update](s3-bucket-migration-between-clusters.md#weka-s3-bucket-migrate-update "mention").

```bash
weka s3 bucket migrate update --bucket <bucket-name> --mode migrate
```

7. **Run the WEKA S3 Migrator to start data transfer:** If the WEKA S3 Migrator is installed on multiple servers, you can run each instance in parallel. To use the the WEKA S3 Migrator, see [#weka-s3-migrator-s3migrate-command](s3-bucket-migration-between-clusters.md#weka-s3-migrator-s3migrate-command "mention").

The WEKA S3 Migrator performs:

* A full copy of all objects from source to target.
* Iterative differential passes to identify and copy any remaining objects.
* Conditional PUTs to avoid overwriting newer objects.
* Optional resume support for interrupted jobs.

**System behavior in `migrate` mode:**

* New writes (PUT/DELETE/MPU): Handled entirely by the target cluster and stored in the target bucket.
* Reads (GET/HEAD):
  * Served from the target bucket if the object exists there.
  * Fallback to the source bucket if the object has not yet been migrated.
* List operations: Present a unified, deduplicated view from both source and target.
* Multi-Part Uploads (MPUs):
  * In-flight MPUs (initiated before the transition) complete on the source.
  * New MPUs are handled by the target.
* Delete operations: Applied to both source and target for consistency.
* Copy operations: The object is read from the target bucket if it is available. Otherwise, it is read from the source bucket. The new, resulting object is always written to the target bucket.

8. **Verify completion of data migration:**  Use the WEKA S3 Migrator to confirm that:
   *   All in-flight multi-part uploads (MPUs) on the source are completed or aborted. To verify this, run the `s3find` script with the `--inflight-mpu-only` flag. A successful check will return the message:

       ```
       No inflight MPUs in the bucket!
       ```

       If the command reports that MPUs still exist, wait for them to finish. You can re-run the script periodically to monitor the status. If the count does not decrease, you may need to manually abort the stalled uploads on the source bucket.
   * All objects have been successfully copied to the target bucket.
   * No data remains to be transferred.

### Phase 4: Finalization (ready mode – final)

In this final phase, the migration is completed and the bucket operates independently on the target cluster. All data and operational control are fully transitioned, and the source bucket is no longer involved.

**Procedure**

1. **Remove migration configuration:** When validation is complete, detach the migration configuration using the following CLI command. This detachment finalizes the migration and decouples the target bucket from the source. For command details, see [#weka-s3-bucket-migrate-detach](s3-bucket-migration-between-clusters.md#weka-s3-bucket-migrate-detach "mention").

```bash
weka s3 bucket migrate detach <target-bucket>
```

3. **Re-enable and configure ILM on the target bucket:** If S3 Lifecycle Management (ILM) was configured on the source bucket:
   * Manually copy the ILM policies and rules to the target bucket.
   * Re-enable ILM on the target once policy validation is complete.
4. **(Optional) Decommission or repurpose the source bucket:**&#x20;
   * The source bucket is no longer serving traffic for the migrated bucket.
   * Perform any final backups, audits, or access removal steps as needed.
   * You may now decommission, archive, or repurpose the source bucket and its configuration.

#### System behavior in `ready` mode (final):

* The bucket is now a standalone operational unit on the target WEKA S3 cluster.
* All S3 client operations (reads, writes, deletes) are fully handled by the target bucket.
* The source cluster is no longer involved in any operation related to this bucket.

## Find and filter S3 objects using the s3find script

Use the `s3find` script to efficiently locate files within a directory of a mounted filesystem. The script searches for files, divides the results into chunks of 100,000 entries, and provides an option to filter for recently modified files before sorting each chunk in parallel.

**Before you begin**

Ensure you have POSIX access to the objects in the S3 bucket. To enable this, mount the corresponding filesystem on a WEKA client.

**Procedure**

1. Navigate to the directory containing the script.
2.  Run the `s3find` command with the required parameters.

    ```bash
    s3find <directory> <output_dir> [--later-than <N_days>] [--inflight-mpu-only]
    ```

**Parameters**

<table><thead><tr><th width="213.9375">Parameter</th><th width="541.87109375">Description</th></tr></thead><tbody><tr><td><code>directory</code>*</td><td>Specifies the source directory within the mounted filesystem to search for objects.</td></tr><tr><td><code>output_dir</code>*</td><td>Specifies the output directory for the generated file lists. This directory is then used as the input for the <code>--src-folder</code> parameter in the <code>s3migrate</code> tool.</td></tr><tr><td><code>later-than &#x3C;N_days></code></td><td>Filters the results to include only files modified within the last <code>&#x3C;N_days></code>.</td></tr><tr><td><code>inflight-mpu-only</code></td><td>Reports the total count of in-flight multi-part uploads (MPUs).</td></tr></tbody></table>

{% hint style="info" %}
**Performance considerations:**

* The script's processing time can be lengthy for directories that contain a large number of files.
* Using the optional `-later-than` parameter adds to the processing overhead, causing the script to run slower. It is best to use this filter only when it is essential for your search.
{% endhint %}

## Monitor and check health

Use the WEKA S3 Migrator to monitor detailed metrics throughout the migration process. This ensures optimal performance, maintains data consistency, and supports timely completion. Monitoring allows you to validate progress, proactively identify issues, and mitigate operational risks before they affect workloads.

**Monitor S3 migration metrics**

Track the following key metrics exposed by the WEKA S3 Migrator:

* Throughput: Bytes transferred per second.
* Object rate: Number of objects processed per second.
* Remaining objects estimate: Estimated number of objects left to migrate.
* Per-Iteration job summary:
  * Number of objects copied
  * Number of bytes copied
  * Execution time
  * Error count and error details

## Interpret the s3migrate progress output

The `s3migrate` tool provides a real-time, single-line progress indicator to monitor the status of the data transfer. Understand each field in the output to track the migration effectively.

**Sample output**

The following is an example of the progress indicator line:

{% code overflow="wrap" %}
```
obj=1234 :: ign=56 exist=89 work=123 [45% ~2h:34m:12s] :: fail=2 skip(dn=3 up=4) dnld=567 (12.3/s) dl.byt=1.2GB (45MB/s) upld=560 (12.1/s) ul.byt=1.1GB (43MB/s)
```
{% endcode %}

**Field descriptions**

The following table describes each field that appears in the progress output string.

<table><thead><tr><th width="177.95703125">Field</th><th>Description</th></tr></thead><tbody><tr><td><code>obj</code></td><td>The total number of objects discovered in the source bucket for processing.</td></tr><tr><td><code>ign</code></td><td>The number of objects ignored. This applies when using hash-based parallel processing (<code>--hash-count</code> and <code>--hash-value</code>).</td></tr><tr><td><code>exist</code></td><td>The number of objects skipped because they were found to already exist on the target bucket.</td></tr><tr><td><code>work</code></td><td>The number of objects currently being processed by active worker threads.</td></tr><tr><td><code>[%% ~time]</code></td><td>The completion percentage and the estimated time remaining for the migration.</td></tr><tr><td><code>fail</code></td><td>The total number of objects that failed to migrate. For details, check the error fields in the log files.</td></tr><tr><td><code>skip(dn=X up=Y)</code></td><td><p>The number of objects skipped during the download (<code>dn</code>) or upload (<code>up</code>) phases.</p><ul><li><strong>dn</strong>: A download skip typically occurs when the object is not found on the source bucket.</li><li><strong>up</strong>: An upload skip typically occurs when a conditional PUT operation fails on the target, often because the object already exists.</li></ul></td></tr><tr><td><code>dnld</code></td><td>The total number of objects successfully downloaded from the source. The value in parentheses indicates the download rate in objects per second.</td></tr><tr><td><code>dl.byt</code></td><td>The total volume of data downloaded from the source. The value in parentheses indicates the current download speed (for example, in MB/s).</td></tr><tr><td><code>upld</code></td><td>The total number of objects successfully uploaded to the target. The value in parentheses indicates the upload rate in objects per second.</td></tr><tr><td><code>ul.byt</code></td><td>The total volume of data uploaded to the target. The value in parentheses indicates the current upload speed (for example, in MB/s).</td></tr></tbody></table>

## WEKA S3 **Migrator:** s3migrate command

The WEKA S3 Migrator facilitates object migration between S3-compatible storage systems. It supports parallel execution, detailed reporting, and fine-grained control through various parameters.

#### **Example usage**

```
./s3migrate \
--src-url http://host-source:9000 \
--src-bucket default \
--src-key user1 \
--src-secret password123 \
--src-folder /path/to/file/lists
--dest-url http://host-dest:9000 \
--dest-bucket dest \
--dest-key user1 \
--dest-secret password123 \
--dest-folder /path/to/dest/lists
```

All parameters used in the example are mandatory, as indicated by an asterisk (\*) in the following table.

#### CLI parameters

The following table describes the parameters used in the example. For a comprehensive list of all available command-line options and usage examples, refer to the `README` file included with the `s3migrate` tool.

<table><thead><tr><th width="192.72265625">Parameter</th><th width="286.76171875">Description</th><th>Example</th></tr></thead><tbody><tr><td><code>--src-url</code>*</td><td>URL of the source S3 endpoint.</td><td><code>https://s3.amazonaws.com</code></td></tr><tr><td><code>--src-bucket</code>*</td><td>Name of the source S3 bucket.</td><td><code>my-source-bucket</code></td></tr><tr><td><code>--src-key</code>*</td><td>Access key for the source bucket.</td><td><code>AKIAIOSFODNN7EXAMPLE</code></td></tr><tr><td><code>--src-secret</code>*</td><td>Secret key for the source bucket.</td><td><code>wJalrXUtnFEMI/K7MDENG/...</code></td></tr><tr><td><code>--src-folder</code>*</td><td>Path to the directory containing file lists from the source (file-based listing).</td><td><code>/path/to/src/lists</code></td></tr><tr><td>-<code>-dest-url</code>*</td><td>URL of the destination S3 endpoint.</td><td><code>https://s3.us-west-2.amazonaws.com</code></td></tr><tr><td><code>--dest-bucket</code>*</td><td>Name of the destination S3 bucket.</td><td><code>my-dest-bucket</code></td></tr><tr><td><code>--dest-key</code>*</td><td>Access key for the destination bucket.</td><td><code>AKIAIOSFODNN7EXAMPLE</code></td></tr><tr><td><code>--dest-secret</code>*</td><td>Secret key for the destination bucket.</td><td><code>wJalrXUtnFEMI/K7MDENG/...</code></td></tr><tr><td><code>--dest-folder</code>*</td><td>Path to the directory for destination-related file lists or outputs (file-based listing).</td><td><code>/path/to/dest/lists</code></td></tr></tbody></table>

## Rollback procedures

The S3 bucket migration feature provides defined rollback paths to ensure you can safely abort the process with minimal disruption. The appropriate procedure depends on the current migration mode.

### Rollback from forward mode to ready mode

This procedure cancels the forward mode and returns the target bucket to a standalone state.

**When to use**

Initiate this rollback if:

* You detect issues, such as application errors or misconfigurations, during the `forward` mode.
* You decide to postpone the migration before transitioning to `migrate` mode.

**Prerequisites**

The source bucket must still be the single source of truth.

**Rollback steps**

1. **Redirect traffic to source:** Update your DNS or load balancer configuration to point the S3 bucket’s hostname back to the source cluster's IP addresses. After DNS propagation, all client traffic will be handled by the source cluster.
2.  **Reset target bucket to ready mode:** Run the following CLI command to transition the target bucket out of `forward` mode. The target cluster stops forwarding requests.

    ```bash
    weka s3 bucket migrate update --bucket <bucket-name> --mode ready
    ```

    **Example:**

    ```bash
    weka s3 bucket migrate update --bucket target-bucket --mode ready
    ```

### Rollback from migration mode to using the source

This procedure is a critical recovery path for aborting the migration after it has entered `migrate` mode and data has been copied to the target. Use this as a last resort to make the source bucket primary again.

**When to use**

Initiate this rollback if you discover critical issues after the data migration has started and you must completely abandon the migration process.

**Rollback steps**

1. **Block access to the target bucket:** Immediately restrict all client access to the target S3 bucket to prevent further writes and ensure a stable state for data migration. During this process, the S3 service will be **inaccessible** to clients.
2. **Migrate data from target to source:** Use a WEKA S3 Migrator to copy any new or modified data from the target bucket **back** to the source bucket. This step requires an S3 user with read-write permissions on the source cluster.

{% hint style="info" %}
In-flight multipart uploads (MPUs) that were initiated on the target cluster cannot be resumed on the source cluster. They will need to be restarted after the rollback is complete.
{% endhint %}

3. **Reload source IAM policies:** Once data migration is complete, reload the IAM policies on the source bucket to restore its original permissions.
4. **Redirect traffic to source:** Update your DNS or load balancer configuration to point the S3 bucket’s hostname back to the source cluster.
5.  **Reset target bucket to ready mode:** After traffic is flowing to the source, reset the target bucket to a standalone `ready` state using the following command:

    ```bash
    weka s3 bucket migrate update --bucket <bucket-name> --mode ready
    ```

## Migration CLI reference

WEKA provides commands to manage the lifecycle of S3 bucket migration.

### weka s3 bucket migrate attach

Attach a target bucket to a source bucket to begin the migration process.

**Usage**

{% code overflow="wrap" %}
```bash
weka s3 bucket migrate attach <bucket> <url> <tls-cert> [--s3-key s3-key] [--s3-secret s3-secret] [--force]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="159.9296875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>Name of the target bucket.</td></tr><tr><td><code>url</code>*</td><td>URL of the source WEKA S3 cluster.</td></tr><tr><td><code>tls-cert</code>*</td><td>Source TLS certificate file.</td></tr><tr><td><code>s3-key</code>*</td><td>Source access key.</td></tr><tr><td><code>s3-secret</code>*</td><td>Source access secret.</td></tr><tr><td><code>-f</code>, <code>--force</code></td><td>Forces the migration even if the target bucket is not empty.</td></tr></tbody></table>

**Example**

{% code overflow="wrap" %}
```bash
weka s3 bucket migrate attach target-bucket https://192.168.1.100:9000 ~/cert.pem --s3-key S3_key --s3-secret S3_secret
```
{% endcode %}

### weka s3 bucket migrate detach

Detach migration configuration from a target S3 bucket.

**Usage**

```bash
weka s3 bucket migrate detach <bucket>
```

**Parameters**

<table><thead><tr><th width="159.9296875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>Name of the target bucket.</td></tr></tbody></table>

**Example**

```bash
weka s3 bucket migrate detach target-bucket
```

### weka s3 bucket migrate update

Use this command to update the migration mode for a bucket, transitioning it between the key phases of the migration lifecycle.

The command manages the following three modes:

* `ready`: The initial state before the migration process is active.
* `forward`: Redirects client traffic from the target to the source cluster.
* `migrate`: Actively migrates data while the target cluster handles all client operations.

The migration modes must be updated in a specific sequence. The following transitions are allowed:

* From `ready` to `forward`
* From `forward` to `migrate`
* From `migrate` back to `ready` (after finalization)
* From `forward` back to `ready` (to roll back the forwarding setup)

**Usage**

**Update a single bucket:** To update the mode for an individual bucket, specify the bucket name:

```bash
weka s3 bucket migrate update --bucket <bucket-name> --mode <allowed-mode>
```

**Update multiple buckets:** The command also provides flags for updating multiple buckets at once.

*   To update all buckets attached to a specific source cluster, use the `--url` flag:

    ```bash
    weka s3 bucket migrate update --url <source-url> --mode <allowed-mode>
    ```
*   To update all buckets attached to any source cluster, use the `--all` flag:

    ```bash
    weka s3 bucket migrate update --all --mode <allowed-mode>
    ```

**Parameters**

<table><thead><tr><th width="159.9296875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>mode</code></td><td><p>Migration modes.</p><p>Possible values: <code>ready</code>, <code>forward</code>, and <code>migrate</code>.</p></td></tr><tr><td><code>url</code></td><td>Update all buckets pointing to the specified S3 endpoint.</td></tr><tr><td><code>bucket</code></td><td>Update the bucket name with the specified name.</td></tr><tr><td><code>all</code></td><td>Update all buckets.</td></tr></tbody></table>

**Examples**

{% code overflow="wrap" %}
```bash
weka s3 bucket migrate update --url https://192.168.1.100:9000 --mode forward
weka s3 bucket migrate update --bucket target-bucket --mode migrate 
weka s3 bucket migrate update --all --mode forward
```
{% endcode %}

### weka s3 bucket migrate show

Show the details of an S3 bucket migration configuration.

**Usage**

`weka s3 bucket migrate show <bucket>`

**Parameters**

<table><thead><tr><th width="159.9296875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>Name of the bucket.</td></tr></tbody></table>

**Example**

```
weka s3 bucket migrate show target-bucket
```

### weka s3 bucket migrate list

Show all the S3 bucket migration configurations on the cluster.

**Usage**

`weka s3 bucket migrate list`
