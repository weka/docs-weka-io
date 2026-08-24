---
description: >-
  Manage S3 cluster configuration, containers, readiness, and tenant settings
  using the CLI.
---

# Manage the S3 service using the CLI

## Add an S3 cluster

**Command:** `weka s3 cluster add`

Use the following command line to add an S3 cluster:

`weka s3 cluster add [--default-fs-name default-fs-name] [--port port] [--max-buckets-limit max-buckets-limit] [--anonymous-posix-uid anonymous-posix-uid] [--anonymous-posix-gid anonymous-posix-gid] [--domain domain] [--container container]... [--all-servers] [config-fs-name]...`

**Parameters**

<table><thead><tr><th width="207">Name</th><th width="434">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>default-fs-name</code></td><td>Cluster default filesystem name for the S3 service. This value applies to Tenant 0 and serves as the fallback for tenants that do not define a tenant default filesystem.</td><td></td></tr><tr><td><code>port</code></td><td>The port where the S3 service is exposed.<br>Do not set port 9001.</td><td>9000</td></tr><tr><td><code>max-buckets-limit</code></td><td>The maximum number of buckets that can be created.<br>Maximum value: 10000.</td><td></td></tr><tr><td><code>anonymous-posix-uid</code></td><td>Cluster default POSIX UID for objects created with anonymous or public access. Tenants can override this value for their own workloads.</td><td>65534</td></tr><tr><td><code>anonymous-posix-gid</code></td><td>Cluster default POSIX GID for objects created with anonymous or public access. Tenants can override this value for their own workloads.</td><td>65534</td></tr><tr><td><code>domain</code></td><td><p>Virtual hosted-style comma-separated domains.</p><p>Maximum characters for a domain: 64.</p><p>Maximum characters for a list: 1024.</p><p>Example: <code>--domain sub1.domain-name.com,sub2.domain-name.com</code>.<br>To remove the existing domain, set <code>""</code>.<br>Example: <code>--domain ""</code></p></td><td></td></tr><tr><td><code>container</code>*</td><td>Container IDs with a frontend process to serve the S3 service.<br>To ensure redundancy and fault tolerance, a minimum of two containers is required for the S3 cluster. However, it is possible to create a single-container S3 cluster, which means there will be no redundancy.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container</code> parameter.</td><td></td></tr><tr><td><code>all-servers</code></td><td>Use all backend servers to serve S3 commands.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container</code> parameter.</td><td>None</td></tr><tr><td><code>config-fs-name</code></td><td>The predefined filesystem name for maintaining the persisting cluster-wide protocols' configurations.<br>Verify that the filesystem is already created. If not, create it. For details, see <a data-mention href="../../additional-protocols-overview.md#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations">#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations</a></td><td></td></tr></tbody></table>

Bucket creation uses the tenant default filesystem first, then the cluster default filesystem. If neither is configured and the bucket command does not specify a filesystem, bucket creation fails.

## Check the status of the S3 cluster readiness

**Command:** `weka s3 cluster` or `weka s3 cluster status`

The S3 cluster is comprised of a few S3 containers. Use this command to check the status of the S3 containers that are part of the S3 cluster. Once all the S3 containers are prepared and ready, it is possible to use the S3 service.

## List the S3 cluster containers <a href="#list-the-s3-cluster-containers" id="list-the-s3-cluster-containers"></a>

**Command:** `weka s3 cluster container list`

Use this command to list the containers that serve the S3 cluster.

## Update an S3 cluster configuration <a href="#update-an-s3-cluster-configuration" id="update-an-s3-cluster-configuration"></a>

**Command:** `weka s3 cluster update`

Use the following command line to update an S3 cluster configuration:

`weka s3 cluster update [--port port] [--anonymous-posix-uid anonymous-posix-uid] [--anonymous-posix-gid anonymous-posix-gid] [--domain domain] [--container container]... [--all-servers]`

**Parameters**

<table><thead><tr><th width="207">Name</th><th width="423">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>port</code></td><td>The port where the S3 service is exposed.<br>Do not set port 9001.</td><td></td></tr><tr><td><code>anonymous-posix-uid</code></td><td>Cluster default POSIX UID for objects created with anonymous or public access. Tenants can override this value for their own workloads.</td><td>65534</td></tr><tr><td><code>anonymous-posix-gid</code></td><td>Cluster default POSIX GID for objects created with anonymous or public access. Tenants can override this value for their own workloads.</td><td>65534</td></tr><tr><td><code>domain</code></td><td><p>Virtual-hosted-style comma-separated domains.<br>Maximum number of characters: 1024.</p><p>Example: <code>--domain sub1.domain-name.com,sub3.domain-name.com</code>.<br></p><p>To remove the existing domain, set <code>""</code>.<br>Example: <code>--domain ""</code></p><p><strong>Note:</strong> Modifying the domain parameter value automatically triggers a restart of all S3 containers, resulting in I/O disruption.</p></td><td></td></tr><tr><td><code>container</code>*</td><td><p>Container IDs associated with a frontend process responsible for serving the S3 service.</p><p>For redundancy and fault tolerance, a minimum of two containers is necessary for the S3 cluster. Nevertheless, it is possible to create a single-container S3 cluster, which means there will be no redundancy.</p><p>If you include <code>all-servers</code> in the command, do not specify a list of containers in the <code>container</code> parameter.</p></td><td></td></tr><tr><td><code>all-servers</code></td><td>Use all backend servers to serve S3 commands.<br>If you add <code>all-servers</code> to the command, do not specify the list of containers in the <code>container</code> parameter.</td><td>None</td></tr></tbody></table>

{% hint style="info" %}
Instead of using the `weka s3 cluster update` command for adding or removing containers, use the commands `weka s3 cluster containers add` or `weka s3 cluster containers remove`. It is more convenient when managing an S3 cluster with many containers.
{% endhint %}

## Update per-tenant S3 configuration

Configure S3 settings at the tenant level to override the cluster defaults for workloads within that tenant. Each tenant can customize the following settings independently:

* Default filesystem
* Anonymous POSIX UID
* Anonymous POSIX GID

**Before you begin**

Ensure you have TenantAdmin permissions. This command applies only within the boundary of the current tenant.

**Command**

`weka s3 cluster setup update [--default-fs-name default-fs-name] [--anonymous-posix-uid anonymous-posix-uid] [--anonymous-posix-gid anonymous-posix-gid]`

**Parameters**

| Parameter             | Description                                                                                      |
| --------------------- | ------------------------------------------------------------------------------------------------ |
| `default-fs-name`     | The filesystem name to use as the default for this tenant, overriding the cluster-level default. |
| `anonymous-posix-uid` | The POSIX user ID to assign to anonymous access requests for this tenant.                        |
| `anonymous-posix-gid` | The POSIX group ID to assign to anonymous access requests for this tenant.                       |

## Add containers to the S3 cluster

**Command:** `weka s3 cluster container add`

Use the following command line to add containers to the S3 cluster:

`weka s3 cluster container add <container-ids>`

The following command example adds two containers with the IDs 8 and 9:

`weka s3 cluster container add 8 9`

**Parameters**

| Name              | Value                                                                   |
| ----------------- | ----------------------------------------------------------------------- |
| `container-ids`\* | Container IDs to add to the S3 cluster.Space-separated list of numbers. |

## Remove containers from the S3 cluster

**Command:** `weka s3 cluster container remove`

Use the following command line to remove containers from the S3 cluster:

`weka s3 cluster container remove <container-ids>`

**Parameters**

| Name              | Value                                                                       |
| ----------------- | --------------------------------------------------------------------------- |
| `container-ids`\* | Container IDs to remove from the S3 cluster.Space-separated list of numbers |

## Remove an S3 cluster

**Command:** `weka s3 cluster remove`

Use this command to remove an S3 cluster managed by the WEKA system.

Removing an existing S3 cluster removes the S3 service and configuration, such as IAM policies, buckets, and ILM rules. S3 access is no longer available for clients. Data that resides within the buckets is not deleted. Internal users with S3 roles are deleted from the system.
