---
description: >-
  Manage S3 cluster configuration, containers, readiness, and tenant settings
  using the CLI.
---

# Manage the S3 service using the CLI

## Add an S3 cluster

Creates the S3 service on the cluster and selects which containers serve S3 traffic. Use `--all-servers` for every backend, or `--container` to name specific containers.

**Command:** `weka s3 cluster add`

```sh
weka s3 cluster add <config-fs-name>… [--all-servers] [--allow-versioning] [--anonymous-posix-gid <uint>] [--anonymous-posix-uid <uint>] [--container <container-ids>…] [--default-fs-name <string>] [--domain <strings>…] [--force] [--max-buckets-limit <uint>] [--port <uint16>]
```

**Parameters**

| Parameter                       | Description                                                                                                                 |
| --- | --- |
| `config-fs-name`\*… | Filesystem name for S3 configuration storage. For details, see #dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations |
| `--all-servers` | Install S3 on all servers. |
| `--allow-versioning` | Enable S3 versioning (default off, cannot be disabled once enabled). |
| `--anonymous-posix-gid` \<uint> | POSIX GID for anonymous users. |
| `--anonymous-posix-uid` \<uint> | POSIX UID for anonymous users. |
| `--container` \<container-ids>… | Containers that will serve S3 protocol. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--default-fs-name` \<string> | Default filesystem name for S3 buckets. |
| `--domain` \<strings>… | Virtual host-style domains. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--max-buckets-limit` \<uint> | Maximum buckets that can be created. value: 10000 |
| `--port` \<uint16> | S3 service port. |

Bucket creation uses the tenant default filesystem first, then the cluster default filesystem. If neither is configured and the bucket command does not specify a filesystem, bucket creation fails.

## Check the status of the S3 cluster readiness

Shows whether the S3 service is online, which containers serve it, and the filesystem backing it.

**Command:** `weka s3 cluster`

```sh
weka s3 cluster
```

## List the S3 cluster containers

Lists the containers currently serving S3 traffic.

**Command:** `weka s3 cluster container list`

```sh
weka s3 cluster container list
```

## Update an S3 cluster configuration

Changes cluster-wide S3 settings such as the serving containers, port, anonymous POSIX identity, and versioning.

**Command:** `weka s3 cluster update`

```sh
weka s3 cluster update [--all-servers] [--allow-versioning] [--anonymous-posix-gid <uint>] [--anonymous-posix-uid <uint>] [--container <container-ids>…] [--domain <strings>…] [--force] [--port <uint16>]
```

**Parameters**

| Parameter                       | Description                                                                                                                 |
| --- | --- |
| `--all-servers` | Install S3 on all servers. |
| `--allow-versioning` | Enable S3 versioning (default off, cannot be disabled once enabled). |
| `--anonymous-posix-gid` \<uint> | POSIX GID for anonymous users. |
| `--anonymous-posix-uid` \<uint> | POSIX UID for anonymous users. |
| `--container` \<container-ids>… | Containers that will serve S3 protocol. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--domain` \<strings>… | Virtual host-style domains. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--port` \<uint16> | S3 service port. |

{% hint style="info" %}
Instead of using the `weka s3 cluster update` command for adding or removing containers, use the commands `weka s3 cluster container add` or `weka s3 cluster container remove`. It is more convenient when managing an S3 cluster with many containers.
{% endhint %}

## Update per-tenant S3 configuration

Changes the S3 settings that apply to a single tenant rather than the whole cluster.

**Command:** `weka s3 cluster setup update`

```sh
weka s3 cluster setup update [--anonymous-posix-gid <uint>] [--anonymous-posix-uid <uint>] [--clear-default-fs] [--default-fs-name <string>]
```

**Parameters**

| Parameter                       | Description                                   |
| --- | --- |
| `--anonymous-posix-gid` \<uint> | POSIX GID for anonymous users. |
| `--anonymous-posix-uid` \<uint> | POSIX UID for anonymous users. |
| `--clear-default-fs` | Clear the default filesystem for this tenant. |
| `--default-fs-name` \<string> | S3 default filesystem name. |

## Add containers to the S3 cluster

Adds containers to the S3 service so they begin serving S3 traffic.

**Command:** `weka s3 cluster container add`

```sh
weka s3 cluster container add <container-id>…
```

**Parameters**

| Parameter         | Description                          |
| --- | --- |
| `container-id`\*… | Containers to add to the S3 cluster. |

## Remove containers from the S3 cluster

Removes containers from the S3 service.

**Command:** `weka s3 cluster container remove`

```sh
weka s3 cluster container remove <container-id>…
```

**Parameters**

| Parameter         | Description                               |
| --- | --- |
| `container-id`\*… | Containers to remove from the S3 cluster. |

## Remove an S3 cluster

Removes the S3 service from the cluster. Buckets and their data are not deleted.

**Command:** `weka s3 cluster remove`

```sh
weka s3 cluster remove [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
