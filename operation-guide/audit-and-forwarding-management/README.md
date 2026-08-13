---
description: >-
  Manage the forwarding of data access audit events to external monitoring
  systems.
---

# Audit and forwarding management

## Overview

Effective data management requires a robust auditing and forwarding functionality to ensure data security, compliance with regulatory standards, and integration with advanced workflows. The auditing and forwarding functionality provides continuous event streams that record data access, modifications, and deletions, enabling organizations to monitor and respond to activity across their storage environment.

This auditing and forwarding functionality supports compliance with regulations such as HIPAA and GINA, aids in investigating security incidents, and ensures the integrity of stored data. The auditing and forwarding functionality also supports auditing on encrypted filesystems. Additionally, it facilitates operational insights by enabling analysis of user behavior, such as identifying which datasets are accessed, by whom, and at what times.

The audit event stream can also be used to trigger automated workflows. For example, an external system can monitor for specific operations in defined paths and initiate corresponding actions when conditions are met.

The auditing and forwarding functionality is designed to minimize any impact on client performance. To enable this, it is built upon a lightweight and scalable tracing system that monitors core filesystem events. To further reduce any impact on workloads, captured events are enriched asynchronously with contextual metadata, such as full file paths, to provide meaningful and actionable information.

By default, the auditing and forwarding functionality is disabled. It must first be enabled at the system level, a process that sets up the necessary infrastructure and system components required for auditing. Once active, the auditing and forwarding functionality is configurable on a per-filesystem basis, allowing fine-grained control over which datasets are monitored and which operations are of interest.

Audit events are forwarded using a modular, pluggable framework. This design enables flexible integration with a variety of external platforms, addressing diverse customer environments. The forwarding process is managed by the telemetry gateway (telemetry container) and an internal observability pipeline, which processes and routes audit events.

The auditing and forwarding functionality supports exporting audit events to the following platforms:

* Kafka
* Splunk
* Amazon S3

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Auditing_architecture.png" alt=""><figcaption><p>Audit and forwarding architecture</p></figcaption></figure></div>

## Audit operation types

The auditing and forwarding functionality records various filesystem activities. The following operations apply to actions originating from POSIX and other protocols like NFS, SMB, and S3, as they all translate into standard filesystem events. For example, deleting a file over S3 generates the same `UNLINK` event as a POSIX `rm` command.

Operations specific to filesystem management, such as `MOUNT` and `UMOUNT`, are generally considered POSIX-only events.

The following table describes each audited operation type.

| Operation | Description |
| --- | --- |
| `FILEOPEN` | Logs the initial opening of a file for read or write access. For performance reasons, subsequent opens are logged only when the access type changes or moves between system nodes. |
| `ATOMIC_FILEOPEN` | Logs the creation and opening of a file as a single, atomic action. Unlike `FILEOPEN`, this operation is always recorded. |
| `CLOSE` | Logs the closing of a file, which involves releasing the file descriptor associated with it. This operation marks the end of a session or access period for a file and is crucial for tracking file access duration and resource management. |
| `LOOKUP` | Logs the action of searching for a file or directory by its name. |
| `READDIR` | Logs the reading of a directory's contents, such as when a user lists its files. |
| `MKNOD` | Logs the creation of a file, special file, or directory. |
| `RENAME` | Logs the renaming of a file or directory. |
| `RMDIR` | Logs the removal of a directory. |
| `GETATTR` | Logs the retrieval of file attributes (metadata), such as access time or permissions. |
| `SETATTR` | Logs the modification of file attributes (metadata), such as changing permissions or file size. |
| `READLINK` | Logs the reading of a symbolic link's destination path. |
| `UNLINK` | Logs the deletion of a file, symbolic link, or hard link. |
| `SYMLINK` | Logs the creation of a symbolic link (a shortcut to another file or directory). |
| `LINK` | Logs the creation of a hard link (an additional name for an existing file). |
| `SETXATTR` | Logs the addition of a custom attribute (extended metadata) to a file. |
| `LISTXATTR` | Logs the listing of all custom attributes for a file. |
| `GETXATTR` | Logs the reading of a specific custom attribute from a file. |
| `RMXATTR` | Logs the removal of a custom attribute from a file. |
| `MOUNT` | Logs the mounting of a filesystem, making it accessible. |
| `UMOUNT` | Logs the unmounting of a filesystem, making it inaccessible. |
| `HEARTBEAT` | Sends a periodic message from each node to confirm that the audit system is operational. |
| `LOST_AUDIT` | Sends a special message to indicate that one or more audit events may have been lost, signaling a potential gap in the audit trail. |

### Operation categories for configuration

When configuring audit logging, the system allows enabling auditing based on high-level operation categories. These categories serve as groupings of multiple specific audit operations. This simplifies the configuration process by allowing users to select broader classes of operations to monitor.

These categories are specified in the command-line and configuration interfaces to control the scope of audit logging efficiently.

| Category (configurable operation type) | Included audit operations |
| --- | --- |
| `open` | `FILEOPEN`, `ATOMIC_FILEOPEN` |
| `close` | `CLOSE` |
| `create` | `MKNOD`, `SYMLINK`, `LINK`, `SETATTR`, `ATOMIC_FILEOPEN` |
| `read` | `READDIR` |
| `modify` | `SETATTR`, `SETXATTR`, `RMXATTR` |
| `delete` | `UNLINK`, `RMDIR` |
| `rename` | `RENAME` |
| `session_management` | `MOUNT`, `UMOUNT`, `HEARTBEAT`, `LOST_AUDIT` |

## Audit message format

Each audit event sent to an external system is structured in a consistent message format containing fields that provide detailed information about the audited operation. The audit message can contain the following fields:

| Field | Description |
| --- | --- |
| `category` | The management category of the audited operation. |
| `recordType` | The type of record. For audit events, this is always `AUDIT`. |
| `recordId` | A unique identifier for the specific audit record. |
| `recordVersion` | The version number of the audit message format. |
| `operation` | The type of filesystem operation that was performed (for example, `FILEOPEN`, `SETATTR`). |
| `timestamp` | The date and time when the operation occurred. |
| `clusterGuid` | The unique identifier of the cluster. |
| `clusterName` | The name of the cluster where the event occurred. |
| `clientIp` | The IP address of the client machine that initiated the operation. |
| `clientHostname` | The hostname of the client machine that initiated the operation. |
| `uid` | The user ID (UID) of the user who performed the operation. |
| `gid` | The group ID (GID) of the user who performed the operation. |
| `fsId` | The unique identifier for the filesystem where the operation occurred. |
| `fsName` | The name of the filesystem where the operation occurred. |
| `snapshotId` | The ID of the snapshot related to the transaction. An ID of `0` indicates the live filesystem. |
| `snapshotName` | The name of the snapshot related to the transaction. |
| `inodeId` | The unique inode identifier for the file or directory involved in the operation. |
| `parentinodeID` | The unique inode identifier of the parent directory. |
| `fullPath` | The complete path used to identify the object in the filesystem. |
| `errorCode` | The status code of the operation. A value of `0` indicates success. |
| `targetFullPath` | For operations such as `RENAME` or `SYMLINK`, this is the destination path of the object. |
| `feOpId` | The operation ID from the front-end container. |
| `requestedAccess` | The type of access requested during an open operation, such as `read` or `write`. |
| `timeSent` | The timestamp of when the audit message was sent from the telemetry gateway. |
| `wekaServer` | The hostname of the server that serviced the audit event. |
| `key` | The key of the extended attribute involved in an `xattr` operation. |
| `modeBits` | The new POSIX mode bits of a file or directory after a permission change operation. |
| `outageStart` | For `LOST_AUDIT` events, an estimate of when the audit message outage started. |
| `outageEnd` | For `LOST_AUDIT` events, an estimate of when the audit message outage ended. |

<details>

<summary>Audit message example</summary>

```
{
  "header": {
    "clusterId": "0",
    "recordType": "AUDIT",
    "recordVersion": "1",
    "recordId": 8,
    "timestamp": "2024-02-08T14:06:46.413235500Z"
  },
  "auditInfo": {
    "operation": "FILEOPEN",
    "clientHostname": "0",
    "clientIp": "0",
    "uid": "4294967295",
    "ouid": "0",
    "ogid": "0",
    "gid": "4294967295",
    "fsId": "0",
    "fsName": "0",
    "snapshotId": "1",
    "snapshotName": "1",
    "inodeId": "5478414575613706240",
    "fullPath": "0",
    "targetInodeId": "0",
    "targetFullPath": "0",
    "errorCode": "SUCCESS",
    "feOpId": "5919",
    "nodeId": "1",
    "parentInodeId": "63447005790208",
    "parentInodeSnapViewId": "1"
  },
  "wekaServerInfo": {
      "wekaServerOrigin": "lf-0",
      "source_type": "file",
      "timeSent": "2024-02-08T14:06:46.4132355Z"
  }
}
```

</details>
