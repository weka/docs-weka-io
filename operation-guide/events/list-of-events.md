---
description: >-
  Explore the various events produced by the WEKA system, organized according to
  their respective categories.
---

# List of events

### Agent

| **Type**                          | **Severity** | **Description**                          |
| --------------------------------- | ------------ | ---------------------------------------- |
| ContainerStateEvent               | INFO         | Container State.                         |
| WCGroupInvalidResourceConfigEvent | WARNING      | Container CGroup Resource Configuration. |
| WCGroupStateDisabledEvent         | MAJOR        | Container CGroup State.                  |
| WCGroupStateEnabledEvent          | INFO         | Container CGroup State.                  |
| WCGroupValidResourceConfigEvent   | INFO         | Container CGroup Resource Configuration. |

### Alerts

| **Type**             | **Severity** | **Description**                            |
| -------------------- | ------------ | ------------------------------------------ |
| AlertCleared         | DEBUG        | The system has {action} an alert.          |
| AlertContinuousEvent | DEBUG        | The system has reported continuous alerts. |
| AlertMuted           | INFO         | Alert muted.                               |
| AlertTriggered       | DEBUG        | The system has {action} an alert.          |
| AlertUnmuted         | INFO         | Alert unmuted.                             |

### Cloud

| **Type**                    | **Severity** | **Description**                             |
| --------------------------- | ------------ | ------------------------------------------- |
| CloudDisabled               | INFO         | Cloud disabled.                             |
| CloudEnabled                | INFO         | Cloud enabled.                              |
| CloudProxyUpdated           | INFO         | Cloud proxy updated.                        |
| CloudSetUploadRate          | INFO         | Cloud upload rate changed.                  |
| CloudStatsErrorClearedEvent | WARNING      | Cloud stats have been written successfully. |
| CloudStatsErrorEvent        | WARNING      | Error writing cloud stats for upload.       |
| DiagsUploaded               | INFO         | Diags uploaded.                             |
| LowDiskSpaceClearedEvent    | WARNING      | The host no longer has low disk space.      |
| LowDiskSpaceEvent           | WARNING      | The host has low disk space.                |

### Clustering

| **Type**                            | **Severity** | **Description**                                                                                |
| ----------------------------------- | ------------ | ---------------------------------------------------------------------------------------------- |
| AllBucketsResponsive                | INFO         | All compute resources are responding.                                                          |
| BucketRedist                        | INFO         | The buckets were redistributed in the cluster.                                                 |
| ClientConnected                     | INFO         | Client connected.                                                                              |
| ClientDisconnected                  | INFO         | Client disconnected.                                                                           |
| ClientRemoved                       | INFO         | Start removing a disconnected client from the cluster.                                         |
| ClientsUnavailable                  | CRITICAL     | Some clients are unavailable because too many backends are down.                               |
| ClockSkewedHostJoin                 | MINOR        | The container (host) cannot join because of a clock skew.                                      |
| ClusterInitializationFailed         | MAJOR        | The cluster initialization is failed.                                                          |
| ClusterInitialized                  | INFO         | The cluster is successfully initialized.                                                       |
| ClusteringFailure                   | MINOR        | Conainer clustering failed.                                                                    |
| ConfigChangeSetsSliderFull          | MINOR        | Configuration changeset slider is full while the process (node) pulls the configuration.       |
| ConfigGenerationHasNoFirstChunk     | MINOR        | Applying a partial configuration generation is prohibited.                                     |
| ConfigSnapshotPulled                | MINOR        | Configuration snapshot is pulled.                                                              |
| DoubleUnmatchingMachineIdentifier   | MAJOR        | There is a container with the same Agent-Machine-ID but a different SMBIOS UID.                |
| GrimReaperFencingNode               | MINOR        | A partially connected process (node) is selected to be fenced by the grim-reaper.              |
| HostActivated                       | INFO         | Host configuration change.                                                                     |
| HostAdded                           | INFO         | Host configuration change.                                                                     |
| HostAdding                          | INFO         | Host configuration change.                                                                     |
| HostDeactivated                     | INFO         | Host configuration change.                                                                     |
| HostDeactivating                    | INFO         | Host configuration change.                                                                     |
| HostRemoved                         | INFO         | Host configuration change.                                                                     |
| HostRemovingFailed                  | INFO         | Host configuration change.                                                                     |
| HostRemoving                        | INFO         | Host configuration change.                                                                     |
| LeaderChanged                       | WARNING      | The cluster leader has changed.                                                                |
| LeaderSteppingUpAfterUpgrade        | INFO         | The cluster leader is stepping up after the upgrade.                                           |
| NodeNetworkUnstable                 | MAJOR        | A process (node) with an unstable network is detected.                                         |
| NodePartiallyConnected              | MINOR        | A partially connected process (node) was removed.                                              |
| NodeRejoined                        | INFO         | The process (node) has rejoined the cluster.                                                   |
| NodeUnreachable                     | MINOR        | An unreachable process (node) was removed.                                                     |
| NodesNotInExpectedState             | MAJOR        | Some processes (nodes) are not in the expected state.                                          |
| OperationTookTooLong                | WARNING      | The operation took too long.                                                                   |
| PersistentUnresponsiveBuckets       | CRITICAL     | Some compute resources are not responding for more than {longUnresponsivenessMinutes} minutes. |
| PreviousCluster                     | INFO         | This host was part of another cluster before.                                                  |
| RejoinFailureReport                 | MINOR        | Containers (nodes) failed to rejoin.                                                           |
| UnresponsiveBuckets                 | MAJOR        | Some compute resources are not responding.                                                     |
| WrongConfigSignatureForRaftSnapshot | MINOR        | Tried to load an RAFT snapshot with an unsupported configuration root snapshot signature.      |
| WrongSchemaVersionForRaftSnapshot   | MINOR        | Tried to load an RAFT snapshot with an unsupported schema version.                             |

### Config

| **Type**                                                     | **Severity** | **Description**                                                         |
| ------------------------------------------------------------ | ------------ | ----------------------------------------------------------------------- |
| BlockTaskStateChanged                                        | DEBUG        | Block task state changed.                                               |
| CachedSnapshotIsNewerThanStreamed                            | INFO         | The streamed snapshot is older than the cached snapshot.                |
| CachedSnapshotIsOlderThanStreamed                            | INFO         | The requested snapshot doesn't exist yet.                               |
| ClientTargetVersionChange                                    | INFO         | The client target version has been set.                                 |
| ConfigAddedKeyManually                                       | INFO         | A configuration value is added manually by the cluster administrator.   |
| ConfigCapabilityFormatChanged!"max\_supported\_test\_format" | INFO         | Cluster capability max\_supported\_test\_format has been updated        |
| ConfigOverridden                                             | INFO         | A configuration value is overridden by the cluster administrator.       |
| ConfigPropagationTookTooLong                                 | MAJOR        | Config propagation took too long.                                       |
| ConfigRemovedKeyManually                                     | INFO         | A configuration value is removed manually by the cluster administrator. |
| ContainerBlacklistToggle                                     | MAJOR        | A container is blacklisted/removedFromBlacklist.                        |
| DirectoryQuotasDisabled                                      | INFO         | Directory quotas were disabled.                                         |
| DirectoryQuotasEnabled                                       | INFO         | Directory Quotas were enabled.                                          |
| IOStatusChanged                                              | INFO         | IO status changed.                                                      |
| LeaderIterationTooSlow                                       | MAJOR        | Leader iteration took too long between iterations.                      |
| LoginBannerCleared                                           | INFO         | The login banner is cleared.                                            |
| LoginBannerDisabled                                          | INFO         | Login banner is disabled.                                               |
| LoginBannerEnabled                                           | INFO         | The login banner is enabled.                                            |
| LoginBannerSet                                               | INFO         | The login banner is set.                                                |
| ProcessBlacklistToggle                                       | MAJOR        | A process is blacklisted/removedFromBlacklist.                          |
| UpgradeBlockTaskStartInvoked                                 | DEBUG        | Block task upgrade task start invoked.                                  |
| WrongVersionForRaftSnapshot                                  | MINOR        | Tried to load an RAFT snapshot with an unsupported version.             |

### Custom

| **Type**    | **Severity** | **Description**     |
| ----------- | ------------ | ------------------- |
| CustomMajor | MAJOR        | Custom major event. |
| Custom      | INFO         | Custom event.       |

### Drive

| **Type**                  | **Severity** | **Description**                                                                                               |
| ------------------------- | ------------ | ------------------------------------------------------------------------------------------------------------- |
| CorruptedDrive            | MAJOR        | A drive has a valid header but is corrupted.                                                                  |
| DriveAdded                | INFO         | Drive provisioned.                                                                                            |
| DriveDeactivated          | INFO         | Drive deactivated.                                                                                            |
| DriveDead                 | MAJOR        | The drive is unresponsive and fails to return IOs for an extended period.                                     |
| DriveExcessiveErrors      | WARNING      | The drive has an excessive error rate and will be phased out. Contact the Customer Success Team.              |
| DriveFormatUpgraded       | INFO         | The drive format was upgraded.                                                                                |
| DriveImmediateShutdown    | MAJOR        | The drive had to be shut down immediately. Contact the Customer Success Team.                                 |
| DriveInitFailed           | MAJOR        | A drive failed to initialize.                                                                                 |
| DriveIoErrorBMS           | MAJOR        | A drive found an IO error in a background media scan.                                                         |
| DriveIoError              | MAJOR        | A drive has an IO error.                                                                                      |
| DriveLimitExceeded        | WARNING      | An attempt to add more drives than supported.                                                                 |
| DriveMediumError          | MINOR        | A drive has a medium error.                                                                                   |
| DriveNotUnderIOMMU        | MAJOR        | The drive is not under IOMMU, but the host IOMMU is enabled. Contact the Customer Success Team.               |
| DriveNvmeErrorLog         | WARNING      | An NVMe drive error log entry.                                                                                |
| DriveNvmeSmartChange      | MINOR        | The NVMe drive SMART status has changed.                                                                      |
| DriveOutOfNvkvChunks      | MAJOR        | A drive is out of NVKV chunks.                                                                                |
| DriveRemoved              | INFO         | Drive removed.                                                                                                |
| DriveSignatureUnknown     | MINOR        | A drive has an unknown signature.                                                                             |
| DriveSmartCriticalWarning | MINOR        | The drive SMART reports a critical warning and fails it immediately.                                          |
| DriveStateChangesReport   | MINOR        | Drive state changes.                                                                                          |
| DriveTrimAborted          | WARNING      | The drive TRIM commands timed out and aborted at the initialization. Potentially degrading write performance. |
| DriveUnresponsive         | MAJOR        | The drive is unresponsive and fails to return IOs for an extended period.                                     |
| DriveWrongFailureDomain   | MINOR        | A drive is attached to a container (host) from an incorrect failure domain.                                   |
| MBufPoison                | MAJOR        | MBUf got a poison error.                                                                                      |
| NvmeBindTimingOut         | MAJOR        | The NVMe device binding is stuck, and the server needs a power cycle to recover.                              |

### Events

| **Type**              | **Severity** | **Description**                                                                            |
| --------------------- | ------------ | ------------------------------------------------------------------------------------------ |
| DedupEventsDiscarded  | WARNING      | Deduplicated events discarded.                                                             |
| EventsDedupReport     | INFO         | Event deduplication ended.                                                                 |
| EventsDiscarded       | MINOR        | Too many events were generated in a short period, so some of them were discarded and lost. |
| ExampleAggregated     | INFO         | Example aggregated.                                                                        |
| ExampleDebug          | DEBUG        | Example debug.                                                                             |
| Example               | INFO         | Example.                                                                                   |
| TracesDumperDownEvent | MAJOR        | The Traces Dumper is inactive.                                                             |

### Filesystem

| **Type**                                   | **Severity** | **Description**                                                                                                                                               |
| ------------------------------------------ | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| BlockReadFailure                           | CRITICAL     | Failed to read a block.                                                                                                                                       |
| BlockSeekFinished                          | MAJOR        | Block seek finished.                                                                                                                                          |
| BlockSeekStarted                           | MAJOR        | Block seek started for a secondary metadata block that could not be read.                                                                                     |
| BrokenFile                                 | MAJOR        | File metadata corruption.                                                                                                                                     |
| CWTaskTemplateFinished                     | INFO         | A cluster-wide task (CWTask) template finished.                                                                                                               |
| CacheFlushHanging                          | MAJOR        | Host hangs while trying to sync a file's write cache to the cluster.                                                                                          |
| ChecksumErrorInBackgroundWrite             | MAJOR        | Checksum error detected by SSD node in a committing block.                                                                                                    |
| ChecksumErrorInCommit                      | MAJOR        | Checksum error detected by SSD node in a committing block.                                                                                                    |
| ChecksumErrorInWrite                       | CRITICAL     | Checksum error detected by COMPUTE node in a write.                                                                                                           |
| DefaultDirectoryQuotaSet                   | INFO         | A default directory quota was set.                                                                                                                            |
| DefaultDirectoryQuotaUnset                 | INFO         | A default directory quota was unset.                                                                                                                          |
| DestageBlocked                             | CRITICAL     | Destage of a bucket cannot start.                                                                                                                             |
| DestageHanging                             | CRITICAL     | Destage of a bucket is hanging.                                                                                                                               |
| DirectoryQuotaSet                          | INFO         | The directory quota was set.                                                                                                                                  |
| DirectoryQuotaUnset                        | INFO         | The directory quota was unset.                                                                                                                                |
| DumpSnapHashCompleted                      | INFO         | Finished a snap hash manifest scan.                                                                                                                           |
| ExtentDescsPointsToFreedBlocks             | WARNING      | Extent points to freed child blocks.                                                                                                                          |
| FailedToSplitSliceNoRetry                  | CRITICAL     | Failed to split a directory slice. I will not retry.                                                                                                          |
| FilesystemAdded                            | INFO         | Filesystem configuration change.                                                                                                                              |
| FilesystemDeleted                          | INFO         | Filesystem configuration change.                                                                                                                              |
| FilesystemDownloadStarted                  | INFO         | Filesystem download started.                                                                                                                                  |
| FilesystemGroupAdded                       | INFO         | Filesystem group configuration change.                                                                                                                        |
| FilesystemGroupDeleted                     | INFO         | Filesystem group configuration change.                                                                                                                        |
| FilesystemGroupUpdated                     | INFO         | Filesystem group configuration change                                                                                                                         |
| FilesystemRemoved                          | INFO         | Filesystem configuration change.                                                                                                                              |
| FilesystemUpdated                          | INFO         | Filesystem configuration change.                                                                                                                              |
| ForcedBucketStepdown                       | MINOR        | Bucket forced to step down.                                                                                                                                   |
| FreeBlockStillUsed                         | CRITICAL     | Found a block falsely marked as free.                                                                                                                         |
| FsCapacityLimitReached                     | WARNING      | Filesystem capacity limit has been reached.                                                                                                                   |
| HangingBackendIosDetected                  | CRITICAL     | Some IOs are hanging.                                                                                                                                         |
| HangingBackendIosNoLongerDetected          | INFO         | IOs are no longer hanging.                                                                                                                                    |
| HangingBucketStepDown                      | WARNING      | Bucket step-down is hanging.                                                                                                                                  |
| HangingDirectorySplit                      | MAJOR        | Directory split hasn't progressed for a long time.                                                                                                            |
| HangingDriverFrontendIosDetected           | CRITICAL     | Some IOs are hanging.                                                                                                                                         |
| HangingDriverFrontendIosNoLongerDetected   | INFO         | IOs are no longer hanging.                                                                                                                                    |
| HangingNFSFrontendIosDetected              | CRITICAL     | Some IOs are hanging.                                                                                                                                         |
| HangingNFSFrontendIosNoLongerDetected      | INFO         | IOs are no longer hanging.                                                                                                                                    |
| IntegrityCheckFinished                     | DEBUG        | Integrity check has finished.                                                                                                                                 |
| IntegrityCheckIssue                        | CRITICAL     | Found a data integrity issue                                                                                                                                  |
| IntegrityCheckStarted                      | DEBUG        | Integrity check has started.                                                                                                                                  |
| IntegrityCheckTransientIssue               | DEBUG        | Found a transient state that is expected to be encountered. It can be ignored unless it persists. In this case, a non-transient issue event will be produced. |
| ManualOverrideStall                        | WARNING      | A service has been manually overridden and stalled.                                                                                                           |
| MetadataCommitQueueHang                    | MINOR        | Bucket step down due to hanging metadata commit queue                                                                                                         |
| ObjectStoreAttachedToFilesystem            | INFO         | The object store is attached to the filesystem.                                                                                                               |
| ObjectStoreFinishedDetachingFromFilesystem | INFO         | The object store finished detaching from the filesystem.                                                                                                      |
| ObjectStoreStartedDetachingFromFilesystem  | INFO         | The object store started detaching from the filesystem.                                                                                                       |
| QuotaGraceExpired                          | WARNING      | Directory soft capacity quota has been reached, and the grace period has expired.                                                                             |
| QuotaHardLimitReached                      | WARNING      | Directory hard capacity quota has been reached.                                                                                                               |
| RAIDDataBlockReadFailureInSnaphashDump     | WARNING      | Failed to read data block from RAID when dumping the snapshot manifest.                                                                                       |
| RAIDMDReadFailureInSnaphashDump            | WARNING      | Failed to read metadata block from RAID when dumping the snapshot manifest.                                                                                   |
| SnapshotContentCopied                      | INFO         | Snapshot content copied.                                                                                                                                      |
| SnapshotCreated                            | INFO         | Snapshot created.                                                                                                                                             |
| SnapshotDeleted                            | INFO         | Snapshot deleted.                                                                                                                                             |
| SnapshotDownloadStarted                    | INFO         | Snapshot download started.                                                                                                                                    |
| SnapshotFilesystemRestored                 | INFO         | Filesystem restored from a snapshot.                                                                                                                          |
| SnapshotParamsUpdated                      | INFO         | Snapshot updated.                                                                                                                                             |
| SnapshotUploadFinished                     | INFO         | Snapshot upload finished.                                                                                                                                     |
| SnapshotUploadStarted                      | INFO         | Snapshot upload started.                                                                                                                                      |
| SquelchBlockIdSetAbortedFlushed            | DEBUG        | While setting a squelch block's block ID for the upgrade, it was already changed to invalid.                                                                  |
| SquelchBlockIdSetAbortedRewritten          | WARNING      | While setting a squelch block's block ID for the upgrade, it was already rewritten to something else.                                                         |
| SuperblockUnreadable                       | CRITICAL     | The superblock of a bucket could not be loaded.                                                                                                               |
| UnflushedOpOnDeletingSnapview              | MAJOR        | Unflushed IO on a deleting snapshot.                                                                                                                          |

### IO

| **Type**             | **Severity** | **Description**                  |
| -------------------- | ------------ | -------------------------------- |
| SystemDriveIsTooSlow | MAJOR        | System drive is slow to respond. |

### InterfaceGroup

| **Type**                  | **Severity** | **Description**                                   |
| ------------------------- | ------------ | ------------------------------------------------- |
| FloatingIpAcquired        | INFO         | A floating IP was acquired by the process (node). |
| FloatingIpReleased        | INFO         | A floating IP was released by the process (node). |
| InterfaceGroupAdded       | INFO         | Interface group configuration change.             |
| InterfaceGroupDeleted     | INFO         | Interface group configuration change.             |
| InterfaceGroupIpsAdded    | INFO         | Interface group IPs configuration change.         |
| InterfaceGroupIpsDeleted  | INFO         | Interface group IPs configuration change.         |
| InterfaceGroupPortAdded   | INFO         | Interface group port configuration change.        |
| InterfaceGroupPortDeleted | INFO         | Interface group port configuration change.        |
| InterfaceGroupUpdated     | INFO         | Interface group configuration change.             |

### Driver

| **Type**    | **Severity** | **Description** |
| ----------- | ------------ | --------------- |
| DriverAlert | MAJOR        | Driver Alert    |

### Kms

| **Type**                | **Severity** | **Description**           |
| ----------------------- | ------------ | ------------------------- |
| KmsConfigurationAdded   | INFO         | KMS configuration change. |
| KmsConfigurationRemoved | INFO         | KMS configuration change. |
| KmsConfigurationUpdated | INFO         | KMS configuration change. |

### Licensing

| **Type**               | **Severity** | **Description**                 |
| ---------------------- | ------------ | ------------------------------- |
| LicensingReset         | INFO         | Licensing state has been reset. |
| LicensingWorkerStarted | DEBUG        | Licencing worker started.       |
| NewLicenseInstalled    | INFO         | New license installed.          |
| PaygLicensingEnabled   | INFO         | PAYG licensing enabled.         |

### ManualOverride

| **Type**              | **Severity** | **Description**               |
| --------------------- | ------------ | ----------------------------- |
| ManualOverrideChanged | INFO         | A manual override is changed. |

### NFS

| **Type**                      | **Severity** | **Description**                                    |
| ----------------------------- | ------------ | -------------------------------------------------- |
| NfsAuthTypeChangeEvent        | INFO         | NFS Authentication Types Configuration.            |
| NfsClientGroupAdded           | INFO         | NFS client group configuration change.             |
| NfsClientGroupDeleted         | INFO         | NFS client group configuration change.             |
| NfsClientGroupRuleAdded       | INFO         | NFS client group rule configuration change.        |
| NfsClientGroupRuleDeleted     | INFO         | NFS client group rule configuration change.        |
| NfsClusterStatusActiveEvent   | INFO         | NFS Cluster is active.                             |
| NfsClusterStatusInactiveEvent | CRITICAL     | NFS Cluster is inactive.                           |
| NfsCustomOptionsUpdated       | INFO         | NFS custom options configuration change.           |
| NfsExportsPermissionsAdded    | INFO         | NFS export permissions for a configuration change. |
| NfsExportsPermissionsDeleted  | INFO         | NFS export permissions for a configuration change. |
| NfsExportsPermissionsUpdated  | INFO         | NFS export permissions for a configuration change. |
| NfsKerberosSetupEvent         | INFO         | NFS Kerberos Service.                              |
| NfsLdapSetupEvent             | INFO         | NFS LDAP Setup.                                    |
| NfsMountFail                  | WARNING      | NFS mount request failed.                          |
| NfsPortmapFail                | MAJOR        | The NFS server failed to register in the portmap.  |
| NfsServiceDown                | CRITICAL     | Nfs Service Down.                                  |

### Network

| **Type**                    | **Severity** | **Description**                                                                                    |
| --------------------------- | ------------ | -------------------------------------------------------------------------------------------------- |
| ClientNodeDisconnected      | INFO         | A client disconnected from the cluster.                                                            |
| CloudMoveIpFail             | MINOR        | Move IP on cloud failed.                                                                           |
| DefaultDataNetworkingChange | INFO         | The default data networking configuration has changed.                                             |
| DpdkIBQkeyMismatch          | MAJOR        | DPDK IB qkey Mismatch.                                                                             |
| DpdkInitFailed              | MINOR        | DPDK initialization failed.                                                                        |
| DpdkPoolSummary             | DEBUG        | Summary of DPDK pool status.                                                                       |
| FipIsNoLongerOnDevice       | MAJOR        | IP is no longer on the device.                                                                     |
| HangingRPCs                 | MAJOR        | Some RPCs are hanging too long.                                                                    |
| HugepagesAllocationFailure  | MINOR        | Hugepages allocation failure.                                                                      |
| IONodeCannotFetchConfig     | WARNING      | The IO node cannot join the cluster for too long.                                                  |
| MemoryMigratedAfterPin      | MAJOR        | Hugepage mapping migrated after it was pinned.                                                     |
| MemoryMigratedBeforePin     | MINOR        | Hugepage mapping migrated before it was pinned.                                                    |
| MemoryPinningIoctlFailed    | MINOR        | Memory pinning ioctl failed.                                                                       |
| MgmtNodeCannotFetchConfig   | WARNING      | The management process (node) cannot join the cluster for too long.                                |
| NICNotFound                 | INFO         | NIC not found when initializing.                                                                   |
| NetDeviceLinkDown           | MINOR        | Network interface DOWN.                                                                            |
| NetDeviceLinkUp             | MINOR        | Network interface UP.                                                                              |
| NetSlaveDeviceLinkDown      | MINOR        | Network slave interface DOWN.                                                                      |
| NetSlaveDeviceLinkUp        | MINOR        | Network slave interface UP.                                                                        |
| NetworkPortConfigFail       | MINOR        | Network port configuration failed.                                                                 |
| NetworkPortDead             | MAJOR        | The network port hasn't passed packets for an extended period. The port is likely not functioning. |
| NoConnectivityToLivingNode  | MAJOR        | A process (node) is disconnected from living peers.                                                |
| NoHardwareWatchdog          | MAJOR        | No hardware watchdog found.                                                                        |
| NoJumboFrames               | MINOR        | The network does not allow jumbo packets through.                                                  |
| NodeCannotJoinCluster       | WARNING      | The process (node) cannot join the cluster for too long.                                           |
| NodeCannotSendJumboFrames   | MINOR        | A process (node) cannot send jumbo packets.                                                        |
| NodeDisconnected            | MINOR        | A process (node) disconnected from the cluster.                                                    |
| RDMAClientDisabled          | MINOR        | RDMA optimization disabled.                                                                        |
| RDMAClientEnabled           | MINOR        | RDMA optimization enabled.                                                                         |

### Node

| **Type**             | **Severity** | **Description**                             |
| -------------------- | ------------ | ------------------------------------------- |
| AssertionFailed      | MAJOR        | Assertion failed.                           |
| GCCrashReport        | MINOR        | Node has crashed in GC on the previous run. |
| NodeAbruptExitReport | MINOR        | Node has crashed on the previous run.       |
| NodeExceptionExit    | MAJOR        | A process (node) exited with an exception.  |
| NodeKernelStack      | WARNING      | Kernel stack of node before reset           |
| NodeStarted          | INFO         | A process (node) started.                   |
| NodeStopped          | INFO         | A process (node) stopped.                   |
| NodeTraceback        | WARNING      | Traceback of the node before reset.         |

### Object Store

| **Type**                                             | **Severity** | **Description**                                                                                                                |
| ---------------------------------------------------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| ChecksumErrorInDownloadedObject                      | MINOR        | Checksum error detected by COMPUTE node in a downloaded OBS data block.                                                        |
| ChecksumErrorOnObjectUpload                          | MAJOR        | Checksum error detected by COMPUTE node when uploading an OBS data block (corrupted after verifying data read from the drive). |
| DataBlobDownloadFailed                               | WARNING      | Failed downloading data blob header.                                                                                           |
| DownloadedExtentHasInvalidBlobId                     | MAJOR        | Downloaded extent has invalid blob id.                                                                                         |
| DownloadedExtentMissingExpectedBlock                 | MAJOR        | Downloaded extent missing expected block.                                                                                      |
| ExtentHasFakeRetentionTag                            | MAJOR        | Extent has a non-local tag but has disk-only blocks.                                                                           |
| InvalidDataBlobHeader                                | MAJOR        | Invalid header detected by COMPUTE node in a downloaded OBS data blob.                                                         |
| ObjectStoreBucketAdded                               | INFO         | Object store bucket configuration change.                                                                                      |
| ObjectStoreBucketDeleted                             | INFO         | Object store bucket configuration change.                                                                                      |
| ObjectStoreBucketUpdated                             | INFO         | Object store bucket configuration change.                                                                                      |
| ObjectStoreGroupAdded                                | INFO         | Object store configuration change.                                                                                             |
| ObjectStoreGroupDeleted                              | INFO         | Object store configuration change.                                                                                             |
| ObjectStoreGroupUpdated                              | INFO         | Object store configuration change.                                                                                             |
| ObjectStoreHasHighLevelOfUnreclaimedCapacity         | WARNING      | The object store has a high level of unreclaimed capacity.                                                                     |
| ObjectStoreIsFull                                    | CRITICAL     | Object store is full.                                                                                                          |
| ObjectStoreNoLongerHasHighLevelOfUnreclaimedCapacity | INFO         | The object store no longer has a high level of unreclaimed capacity.                                                           |
| ObjectStoreStatusDown                                | MAJOR        | The object store status is down.                                                                                               |
| ObjectStoreStatusUp                                  | INFO         | The object store status is UP.                                                                                                 |
| ObsIsMissingObject                                   | MAJOR        | Permanently failed to download an object from object storage - The object was not found.                                       |
| PersistentChecksumErrorInDownloadedObject            | MAJOR        | A checksum error was detected by the COMPUTE node in a downloaded OBS data block.                                              |

### Organization

| **Type**             | **Severity** | **Description**                          |
| -------------------- | ------------ | ---------------------------------------- |
| OrgCreated           | INFO         | The organization is created.             |
| OrgDeleted           | INFO         | The organization is deleted.             |
| OrgRenamed           | INFO         | The organization is renamed.             |
| OrgSsdQuotaChanged   | INFO         | The organization SSD quota is changed.   |
| OrgTotalQuotaChanged | INFO         | The organization total quota is changed. |

### RAFT



| **Type**                | **Severity** | **Description**                                                   |
| ----------------------- | ------------ | ----------------------------------------------------------------- |
| IndexChangeDuringStream | INFO         | The RAFT index changed during the streaming of the raft snapshot. |

### RAID

| **Type**                             | **Severity** | **Description**                                                                                                                    |
| ------------------------------------ | ------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| BitmapChecksumMismatch               | MINOR        | Bitmap checksum mismatch detected.                                                                                                 |
| DataGenerationNumberBug              | WARNING      | An issue with advancing the applied data generation number report from a bucket.                                                   |
| DataProtectionLevelDecreased         | MINOR        | The data protection level decreased.                                                                                               |
| DataProtectionLevelIncreased         | INFO         | The data protection level increased.                                                                                               |
| DiskNvkvHighUtilization              | WARNING      | Disk's internal resource (NVKV) is highly utilized.                                                                                |
| DiskWritableStateChange              | INFO         | The disk's writable state changed.                                                                                                 |
| DrivesProcessConnectionLost          | MINOR        | The disk connection was lost.                                                                                                      |
| DrivesProcessConnectionRecovered     | INFO         | Disks quick recovery from lost connection detected.                                                                                |
| EnoughActiveFailureDomains           | MINOR        | Sufficient active failure domains.                                                                                                 |
| EvictionOfPlacementFailed            | MAJOR        | Eviction of placement encountered a potentially corrupt block marked as used.                                                      |
| FailedRecoveringData                 | MINOR        | Detected unexpected data. Not enough redundant copies are available to recover it.                                                 |
| FoundCorruptedBlockInStripe          | CRITICAL     | Detected corrupt block in a RAID stripe.                                                                                           |
| HotSpareFailureDomainsUpdated        | INFO         | Hot spare failure domains updated.                                                                                                 |
| InFlightCorruptionDetectedByScrubber | MINOR        | Detected in-flight corrupt read result from the drive.                                                                             |
| IncorrectScannedBlockChecksum        | CRITICAL     | Detected used block with a mismatching checksum.                                                                                   |
| NoDataProtection                     | CRITICAL     | No data protection.                                                                                                                |
| PersistentTooManyFailures            | CRITICAL     | Cluster has been experiencing too many failures when accessing drives for a significant time. The problem is likely not transient. |
| QuorumGenerationNumberBug            | WARNING      | An issue with advancing the applied quorum generation number report from a bucket.                                                 |
| RaidReadFreeBlock                    | MAJOR        | RAID had read a block marked as free.                                                                                              |
| RaidScrubbingRateUpdated             | INFO         | RAID scrubber limit updated.                                                                                                       |
| RaidsStarted                         | INFO         | RAIDs started.                                                                                                                     |
| RepairedCorruptDataFromDrive         | CRITICAL     | Detected corrupt data from drive\[s]. The system will rewrite with the correct data.                                               |
| SingleHopReadCorruptionDetected      | MINOR        | Single-hop read corruption detected.                                                                                               |
| SwitchPlacementHanging               | MINOR        | An active placement to write to is unavailable because of capacity constraints or disk failures.                                   |
| TooFewActiveFailureDomains           | MAJOR        | Too few active failure domains.                                                                                                    |
| TooManyFailures                      | CRITICAL     | Too many failures and some data are unavailable.                                                                                   |
| UsedSSDCapacityCriticalOverflow      | CRITICAL     | SSD capacity usage is overflowing, and the internal spares are running out. The cluster may soon become unavailable for writing.   |
| UsedSSDCapacityNoLongerOverflows     | INFO         | SSD capacity usage is no longer overflowing.                                                                                       |
| UsedSSDCapacityOverflow              | MAJOR        | SSD capacity usage is overflowing, and the internal capacity spares are used.                                                      |

### Resources

| **Type**                                   | **Severity** | **Description**                                                    |
| ------------------------------------------ | ------------ | ------------------------------------------------------------------ |
| APIServerStartFailed                       | WARNING      | Failed to start the API server.                                    |
| APIServerStarted                           | INFO         | Successfully started the API server.                               |
| BandwidthSelected                          | INFO         | Bandwidth set for host.                                            |
| CoreAllocated                              | INFO         | Allocated core.                                                    |
| DeviceIsNotAValidNetworkDevice             | WARNING      | Device is not a valid network device.                              |
| DisabledNumaBalancing                      | INFO         | Disabled NUMA Balancing.                                           |
| DriverLoaded                               | INFO         | Driver attached.                                                   |
| FailedToLoadDriver                         | WARNING      | Failed to load the wekafs driver.                                  |
| HangingHTTPRequest                         | MAJOR        | Hanging HTTP request detected.                                     |
| HttpServerFibersExhausted                  | MAJOR        | Hanging HTTP requests exhausted all available fibers.              |
| HugepagesAllocated                         | INFO         | Hugepages allocated.                                               |
| HugepagesAllocationRetries                 | WARNING      | Hugepages allocation retried.                                      |
| HugepagesAllocationStarted                 | INFO         | Hugepages allocation started.                                      |
| HugepagesAllocationTookTooLong             | WARNING      | Hugepages allocation takes an unexpectedly long duration.          |
| InactiveHostCannotJoinCluster              | INFO         | Inactive host cannot join the cluster.                             |
| LoadingStableResourcesFailed               | INFO         | Failed loading stable resources.                                   |
| NetBufsExhausted                           | MAJOR        | netbufs exhausted.                                                 |
| NetworkDeviceAllocated                     | INFO         | Allocated network device.                                          |
| NetworkDeviceHasNoIp                       | MAJOR        | The network device does not have an IP address.                    |
| NetworkDeviceNotUsedByAnySlots             | MINOR        | Network device not used by any slots.                              |
| NoIPsConfiguredForHostJoinWithNoDefaultNet | WARNING      | No IP configured for the process (node) {nid} with no default-net. |
| RevertToStableResources                    | INFO         | Reverted to stable resources.                                      |
| UnlimitedBandwidthSelected                 | INFO         | Bandwidth set to unlimited.                                        |
| WCGroupContainerEvent                      | MAJOR        | Container Status.                                                  |
| WCGroupUsageMajorEvent                     | MAJOR        | Container {resource} Status.                                       |
| WCGroupUsageWarningEvent                   | WARNING      | Container {resource} Status.                                       |

### S3

| **Type**                                | **Severity** | **Description**                      |
| --------------------------------------- | ------------ | ------------------------------------ |
| S3AddBucketILMRuleEvent                 | INFO         | S3 add bucket ILM rule.              |
| S3AsssumeRoleEvent                      | INFO         | S3 STS token created.                |
| S3AttachIAMPolicyEvent                  | INFO         | S3 attach IAM policy.                |
| S3AuditWebhookDisabledEvent             | INFO         | The S3 Audit Webhook disabled.       |
| S3AuditWebhookEnabledEvent              | INFO         | The S3 Audit Webhook enabled.        |
| S3BucketDestroyedEvent                  | INFO         | The S3 bucket destroyed.             |
| S3ClusterCreated                        | INFO         | An S3 cluster created.               |
| S3ClusterDestroyFailed                  | MAJOR        | Failed to destroy the S3 cluster.    |
| S3ClusterDestroyed                      | INFO         | The S3 cluster was destroyed.        |
| S3ClusterStatusActiveEvent              | INFO         | S3 Cluster is active.                |
| S3ClusterStatusInactiveEvent            | CRITICAL     | S3 Cluster is inactive.              |
| S3ClusterUpdated                        | INFO         | The S3 cluster updated.              |
| S3ContainerStateChangesEvent            | INFO         | S3 container status change.          |
| S3ContainerStatusActiveEvent            | INFO         | S3 container active.                 |
| S3ContainerStatusInactiveEvent          | MAJOR        | S3 container inactive.               |
| S3CreateBucketEvent                     | INFO         | The S3 bucket is created.            |
| S3CreateIAMPolicyEvent                  | INFO         | The S3 created an IAM policy.        |
| S3CreateServiceAccountEvent             | INFO         | S3 created a service account.        |
| S3DestroyBucketEvent                    | INFO         | The S3 bucket destroyed.             |
| S3DetachIAMPolicyEvent                  | INFO         | S3 detach IAM policy.                |
| S3DrainEvent                            | INFO         | S3 container drain.                  |
| S3ETCDDisabledEvent                     | INFO         | S3 cluster etcd disabled.            |
| S3ETCDEnabledEvent                      | INFO         | S3 cluster etcd enabled.             |
| S3HealthyEtcdEndpointEvent              | MAJOR        | S3 etcd endpoint healthy.            |
| S3KVAddedEvent                          | INFO         | S3 Config Add Key.                   |
| S3KVRemovedEvent                        | INFO         | S3 configuration remove key.         |
| S3KVResetEvent                          | INFO         | S3 KV store configuration reset.     |
| S3MultipleContainersStatusInactiveEvent | CRITICAL     | Multiple S3 containers are inactive. |
| S3RemoveBucketILMRuleEvent              | INFO         | S3 remove bucket ILM rule.           |
| S3RemoveIAMPolicyEvent                  | INFO         | The S3 removed the IAM policy.       |
| S3RemoveServiceAccountEvent             | INFO         | S3 remove service account.           |
| S3ResetBucketILMRuleEvent               | INFO         | S3 reset bucket ILM rules.           |
| S3SetBucketPolicyEvent                  | INFO         | S3 set bucket policy.                |
| S3UnDrainEvent                          | INFO         | S3 container undrain.                |
| S3UnhealthyEtcdEndpointEvent            | MAJOR        | S3 etcd endpoint is unhealthy.       |

### Security

| **Type**    | **Severity** | **Description**                              |
| ----------- | ------------ | -------------------------------------------- |
| CaCertSet   | INFO         | The CA certificate was added to the cluster. |
| CaCertUnset | INFO         | The CA certificate was unset.                |
| TLSSet      | INFO         | TLS was set.                                 |
| TLSUnset    | INFO         | TLS was unset.                               |

### SMB

| **Type**                          | **Severity** | **Description**                        |
| --------------------------------- | ------------ | -------------------------------------- |
| SmbAdJoined                       | INFO         | Active Directory configuration change. |
| SmbAdLeft                         | INFO         | Active Directory configuration change. |
| SmbClusterConfigured              | INFO         | SMB cluster configuration change.      |
| SmbClusterCreateCreated           | INFO         | SMB cluster configuration change.      |
| SmbClusterDestroyed               | INFO         | SMB cluster configuration change.      |
| SmbConfigGenerationUpdated        | INFO         | SMB Config configuration change.       |
| SmbShareAdded                     | INFO         | Share configuration change.            |
| SmbShareConfigured                | INFO         | Share configuration change.            |
| SmbShareHostnameACERemovedRemoved | INFO         | SambaHostnameACE configuration change. |
| SmbShareHostnameACEResetDestroyed | INFO         | SambaHostnameACE configuration change. |
| SmbShareRemoved                   | INFO         | Share configuration change.            |
| SmbTrustedDomainAdded             | INFO         | TrustedDomain configuration change.    |
| SmbTrustedDomainRemoved           | INFO         | TrustedDomain configuration change.    |

### Statistics

| **Type**          | **Severity** | **Description**                        |
| ----------------- | ------------ | -------------------------------------- |
| StatLimitExceeded | WARNING      | A set limit on statistics is exceeded. |

### System

| **Type**                    | **Severity** | **Description**                                                      |
| --------------------------- | ------------ | -------------------------------------------------------------------- |
| BlockTaskAborted            | INFO         | The bucket task was aborted successfully.                            |
| BlockTaskComplete           | INFO         | A bucket task was completed successfully.                            |
| BucketsCreated              | INFO         | The system has created buckets.                                      |
| ClusterTaskAborted          | INFO         | Cluster task aborted.                                                |
| ClusterTaskAborting         | INFO         | Cluster task started aborting.                                       |
| ClusterTaskPaused           | INFO         | Cluster task paused.                                                 |
| ClusterTaskResumed          | INFO         | Cluster task resumed.                                                |
| ClusterTasksCpuLimitUpdated | INFO         | Cluster tasks CPU limit set.                                         |
| ClusterwideTaskChanged      | DEBUG        | The cluster-wide task has changed.                                   |
| HaveEnoughSSDCapacity       | MINOR        | Sufficient SSD capacity exists for all the provisioned filesystems.  |
| IOStarted                   | INFO         | The system has started.                                              |
| IOStopped                   | INFO         | The system has stopped.                                              |
| NotEnoughSSDCapacity        | CRITICAL     | WEKA requires more SSD capacity for all the provisioned filesystems. |
| QOSConfigReset              | INFO         | QoS configuration reset.                                             |
| QOSConfigSet                | INFO         | QoS configuration set.                                               |
| StartIORequested            | INFO         | The user has requested to start the IO.                              |
| StopIORequested             | INFO         | The user has requested to stop the IO.                               |
| SystemInfoReport            | INFO         | The management process (node) started, reporting OS info.            |
| ThreadPoolCanNotStartThread | MINOR        | The reactor's thread pool failed to start a thread.                  |
| TooManyFibers               | MINOR        | Too many fiber allocations.                                          |

### Traces

| **Type**                       | **Severity** | **Description**                      |
| ------------------------------ | ------------ | ------------------------------------ |
| TracesConfigurationActivated   | INFO         | Traces configuration change.         |
| TracesConfigurationDeactivated | INFO         | Traces configuration change.         |
| TracesConfigurationReset       | INFO         | Traces configuration change.         |
| TracesConfigurationUpdated     | INFO         | Traces configuration change.         |
| TracesFreezePeriodReset        | INFO         | Traces freeze period has been reset. |
| TracesFreezePeriodSet          | INFO         | Traces freeze period has been set.   |

### Upgrade

| **Type**                    | **Severity** | **Description**                                   |
| --------------------------- | ------------ | ------------------------------------------------- |
| CleanupUpgradePhaseSkipped  | MAJOR        | Skipped Cleanup in Upgrade Phase: {currentPhase}. |
| ClientUpgradeRequested      | INFO         | A client upgrade is requested.                    |
| ComputeUpgradeFinished      | INFO         | The compute containers upgrade has finished.      |
| ComputeUpgradeInvoked       | INFO         | The compute containers upgrade has started.       |
| ComputeUpgradeStarted       | INFO         | The compute containers upgrade has started.       |
| DrivesUpgradeFinished       | INFO         | The drives containers upgrade has finished.       |
| DrivesUpgradeStarted        | INFO         | The drives containers upgrade has started.        |
| ExternalUpgradeCancelled    | INFO         | The external upgrade has been cancelled.          |
| ExternalUpgradeFinished     | INFO         | The external upgrade has finished.                |
| ExternalUpgradeStarting     | INFO         | An external upgrade has started.                  |
| FinishedExternalHostUpgrade | INFO         | The external server (host) upgrade has finished.  |
| FrontendUpgradeFinished     | INFO         | The frontend containers upgrade has finished.     |
| FrontendUpgradeStarted      | INFO         | The frontend containers upgrade has started.      |
| StartingExternalHostUpgrade | INFO         | The external server (host) upgrade has started.   |
| TargetVersionChange         | DEBUG        | The target version has changed.                   |
| UpgradeStatusChange         | DEBUG        | Upgrade status has changed.                       |
| WekaVersionDowngraded       | WARNING      | The cluster is running a lower version.           |

### User

| **Type**                         | **Severity** | **Description**                              |
| -------------------------------- | ------------ | -------------------------------------------- |
| AccessGroupsDisabled             | INFO         | Access groups are disabled.                  |
| AccessGroupsEnabled              | INFO         | Access groups are enabled.                   |
| LDAPAuthDisabled                 | INFO         | LDAP authentication is disabled.             |
| LDAPAuthEnabled                  | INFO         | LDAP authentication is enabled.              |
| LDAPConfigUpdated                | INFO         | LDAP configuration is updated.               |
| UserCreated                      | INFO         | The user is created.                         |
| UserDeleted                      | INFO         | The user is deleted.                         |
| UserLoggedIn                     | INFO         | The user is logged in.                       |
| UserLoginFailed                  | INFO         | The user login is failed.                    |
| UserLoginLocked                  | MINOR        | The user login is locked.                    |
| UserPasswordChangedByAnotherUser | INFO         | The administrator changed the user password. |
| UserPasswordChanged              | INFO         | The user changed the password.               |
| UserRoleChanged                  | INFO         | The user role is changed.                    |