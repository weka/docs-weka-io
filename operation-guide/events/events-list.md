---
description: >-
  Explore the various events the WEKA system produces, organized according to
  their respective categories.
---

# Events list

### Agent

| Type                              | Severity | Description                                                 |
| --------------------------------- | -------- | ----------------------------------------------------------- |
| ContainerStateEvent               | INFO     | Container state changed.                                    |
| DataServiceContainerStateEvent    | INFO     | Data service container state                                |
| WCGroupInvalidResourceConfigEvent | WARNING  | Container control group has invalid resource configuration. |
| WCGroupStateDisabledEvent         | MAJOR    | Container control group is disabled.                        |
| WCGroupStateEnabledEvent          | INFO     | Container control group is enabled.                         |
| WCGroupValidResourceConfigEvent   | INFO     | Container control group resource configuration is valid.    |

### Alerts

| Type                 | Severity | Description                              |
| -------------------- | -------- | ---------------------------------------- |
| AlertCleared         | DEBUG    | The system has {action} an alert         |
| AlertContinuousEvent | DEBUG    | System reports continuous active alerts. |
| AlertMuted           | INFO     | Alert is muted.                          |
| AlertTriggered       | DEBUG    | The system has {action} an alert         |
| AlertUnmuted         | INFO     | Alert is unmuted.                        |
| TenantAlertMuted     | INFO     | Alert is muted for a tenant.             |
| TenantAlertUnmuted   | INFO     | Alert is unmuted for a tenant.           |

### Catalog

| Type                                  | Severity | Description                                        |
| ------------------------------------- | -------- | -------------------------------------------------- |
| CatalogIndexFsCapacityCritical        | CRITICAL | Catalog indexfs filesystem is at critical capacity |
| CatalogIngestionCompleted             | INFO     | Catalog ingestion completed                        |
| CatalogIngestionFailed                | MAJOR    | Catalog ingestion failed                           |
| CatalogMetadataDeleteAllTaskCompleted | INFO     | Catalog metadata deletion all task completed       |
| CatalogMetadataDeleteAllTaskCreated   | INFO     | Catalog metadata deletion all task created         |
| CatalogMetadataDeleteAllTaskFailed    | MAJOR    | Catalog metadata deletion all task failed          |
| CatalogMetadataDeleteTaskCompleted    | INFO     | Catalog metadata deletion completed                |
| CatalogMetadataDeleteTaskCreated      | INFO     | Catalog metadata deletion task created             |
| CatalogMetadataDeleteTaskFailed       | MAJOR    | Catalog metadata deletion failed                   |
| CatalogServiceProcessStatus           | INFO     | Catalog service process status update              |

### Cloud

| Type                                | Severity | Description                                         |
| ----------------------------------- | -------- | --------------------------------------------------- |
| ClientsReportingViaBackendsDisabled | DEBUG    | Clients reporting to cloud via backends disabled    |
| ClientsReportingViaBackendsEnabled  | DEBUG    | Clients reporting to cloud via backends enabled     |
| CloudDisabled                       | INFO     | Cloud WEKA Home integration is disabled.            |
| CloudEnabled                        | INFO     | Cloud WEKA Home integration is enabled.             |
| CloudProxyUpdated                   | INFO     | Cloud WEKA Home proxy configuration is updated.     |
| CloudSetUploadRate                  | INFO     | Cloud WEKA Home upload rate limit changed.          |
| CloudStatsErrorClearedEvent         | WARNING  | Cloud statistics are now written successfully.      |
| CloudStatsErrorEvent                | WARNING  | Fails to write cloud statistics for upload.         |
| DiagsUploaded                       | INFO     | Diagnostic information uploaded to Cloud WEKA Home. |
| LowDiskSpaceClearedEvent            | WARNING  | Host disk space returned to normal levels.          |
| LowDiskSpaceEvent                   | WARNING  | Host is running low on available disk space.        |
| WekaHomeProxyUploaderStartFailed    | DEBUG    | Failed to start the Weka Home Proxy Uploader Server |

### Clustering

| Type                                      | Severity | Description                                                                                                                                                          |
| ----------------------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AllBucketsResponsive                      | INFO     | All compute resources are responding normally.                                                                                                                       |
| BucketDrainerCompleted                    | INFO     | NDU bucket drainer request completed successfully.                                                                                                                   |
| BucketDrainerFailed                       | WARNING  | NDU bucket drainer request failed.                                                                                                                                   |
| BucketDrainerStalled                      | WARNING  | NDU bucket drainer iteration made no progress.                                                                                                                       |
| BucketDrainerStarted                      | INFO     | NDU bucket drainer request started.                                                                                                                                  |
| BucketRandomizerSwap                      | INFO     | Bucket randomizer swaps agent assignments.                                                                                                                           |
| BucketRedist                              | INFO     | Bucket distribution rebalanced across cluster.                                                                                                                       |
| BucketRowHasStaleNodeId                   | INFO     | Bucket contains stale process identifier (NodeId).                                                                                                                   |
| CatalogClusterEventCreated                | INFO     | Catalog cluster configuration change                                                                                                                                 |
| CatalogClusterEventDestroyed              | INFO     | Catalog cluster configuration change                                                                                                                                 |
| CatalogClusterEventUpdated                | INFO     | Catalog cluster configuration change                                                                                                                                 |
| CatalogConfigUpdated                      | INFO     | Catalog indexing configuration updated                                                                                                                               |
| CatalogCoordinatorUpdated                 | INFO     | Catalog coordinator configuration updated                                                                                                                            |
| ClientConnected                           | INFO     | Client connected to cluster.                                                                                                                                         |
| ClientDisconnected                        | INFO     | Client disconnected from cluster.                                                                                                                                    |
| ClientRemoved                             | INFO     | Disconnected client is being removed from cluster.                                                                                                                   |
| ClientsUnavailable                        | CRITICAL | Some clients are unavailable due to insufficient backends.                                                                                                           |
| ClockSkewedHostJoin                       | MINOR    | Container cannot join cluster due to clock skew with existing container.                                                                                             |
| ClusterDeploymentModeChanged              | INFO     | Cluster deployment mode changed (auto-detected)                                                                                                                      |
| ClusterInitializationFailed               | MAJOR    | Cluster initialization process failed.                                                                                                                               |
| ClusterInitialized                        | INFO     | Cluster successfully initialized.                                                                                                                                    |
| ClusterLeaderInsufficientPeerConnectivity | INFO     | The cluster leader has connectivity issues with too many peers.                                                                                                      |
| ClusteringFailure                         | MINOR    | Container fails to join cluster.                                                                                                                                     |
| ConfigChangeSetsSliderErasedUponStartup   | WARNING  | Configuration ChangeSet buffer was erased upon startup.                                                                                                              |
| ConfigChangeSetsSliderFull                | MINOR    | Configuration changeset buffer is full while process pulls configuration updates.                                                                                    |
| ConfigChangeSetsSliderReset               | INFO     | Configuration ChangeSet buffer was reset.                                                                                                                            |
| ConfigGenerationHasNoFirstChunk           | MINOR    | Cannot apply partial configuration generation without initial chunk.                                                                                                 |
| ConfigSnapshotPulled                      | MINOR    | Configuration snapshot retrieved.                                                                                                                                    |
| DataServiceClusterCreated                 | INFO     | Data service cluster created                                                                                                                                         |
| DataServiceClusterDestroyed               | INFO     | Data service cluster destroyed                                                                                                                                       |
| DataServiceClusterUpdated                 | INFO     | Data service cluster updated                                                                                                                                         |
| DoubleUnmatchingMachineIdentifier         | MAJOR    | Multiple containers detected with identical Agent-Machine-ID but different SMBIOS unique identifiers.                                                                |
| GrimReaperFencingNode                     | MINOR    | Partially connected process selected for fencing by Grim Reaper process.                                                                                             |
| HostActivated                             | INFO     | Host configuration change                                                                                                                                            |
| HostAdded                                 | INFO     | Host configuration change                                                                                                                                            |
| HostAdding                                | INFO     | Host configuration change                                                                                                                                            |
| HostDeactivated                           | INFO     | Host configuration change                                                                                                                                            |
| HostDeactivating                          | INFO     | Host configuration change                                                                                                                                            |
| HostDrained                               | INFO     | Host configuration change                                                                                                                                            |
| HostDraining                              | INFO     | Host configuration change                                                                                                                                            |
| HostRemoved                               | INFO     | Host configuration change                                                                                                                                            |
| HostRemoving                              | INFO     | Host configuration change                                                                                                                                            |
| HostRemovingFailed                        | INFO     | Host configuration change                                                                                                                                            |
| HostRequestedActionTimeout                | WARNING  | Host requested action timed out.                                                                                                                                     |
| IncorrectClusterGuidHostJoin              | MINOR    | Container cannot join cluster because it reports the wrong cluster GUID.                                                                                             |
| LeaderChanged                             | WARNING  | Cluster leadership modified to different process.                                                                                                                    |
| LeaderSteppingUpAfterUpgrade              | INFO     | New cluster leader assumes control after upgrade completion.                                                                                                         |
| NetnsImprintFailure                       | MINOR    | Netns creation failed during container join                                                                                                                          |
| NodeFeTombstoned                          | INFO     | FE node tombstoned due to container FE core-count reduction.                                                                                                         |
| NodeFeTombstonedGCd                       | INFO     | Tombstoned FE node garbage-collected and removed from cluster.                                                                                                       |
| NodeJoinBlockedByPartialConnectivity      | WARNING  | Process blocked from progressing in cluster join due to partial connectivity.                                                                                        |
| NodeNetworkUnstable                       | MAJOR    | Process experiences unstable network connectivity.                                                                                                                   |
| NodePartiallyConnected                    | MINOR    | Partially connected process removed from cluster.                                                                                                                    |
| NodeRejoined                              | INFO     | Process successfully rejoined cluster.                                                                                                                               |
| NodeUnreachable                           | MINOR    | Unreachable process removed from cluster.                                                                                                                            |
| NodesNotInExpectedState                   | MAJOR    | Some processes are not in expected operational state.                                                                                                                |
| OperationTookTooLong                      | WARNING  | Cluster operation exceeds expected completion time.                                                                                                                  |
| PersistentUnresponsiveBuckets             | CRITICAL | Some compute resources unresponsive for more than {longUnresponsivenessMinutes} minutes.                                                                             |
| PreviousCluster                           | INFO     | Container was previously part of different cluster.                                                                                                                  |
| RejectedConfigSnapshotFromOlderPeer       | WARNING  | A pulled config snapshot required a schema upgrade (it came from an older-version peer) and was rejected because a same-or-newer-version source should be available. |
| RejoinFailureReport                       | MINOR    | Containers (nodes) failed to rejoin.                                                                                                                                 |
| UnresponsiveBuckets                       | MAJOR    | Some compute resources are not responding to requests.                                                                                                               |
| WrongConfigSignatureForRaftSnapshot       | MINOR    | Attempts to load RAFT snapshot with incompatible configuration signature.                                                                                            |
| WrongSchemaVersionForRaftSnapshot         | MINOR    | Attempts to load RAFT snapshot with incompatible schema version.                                                                                                     |

### Config

| Type                                                         | Severity | Description                                                                                                         |
| ------------------------------------------------------------ | -------- | ------------------------------------------------------------------------------------------------------------------- |
| BlockTaskStateChanged                                        | DEBUG    | Block task state changed.                                                                                           |
| CachedSnapshotIsNewerThanStreamed                            | INFO     | Cached configuration snapshot is newer than streamed version.                                                       |
| CachedSnapshotIsOlderThanStreamed                            | INFO     | Requested configuration snapshot does not exist yet.                                                                |
| CannotAddAnotherContainerWithTheSameMachineId                | WARNING  | Cannot add additional container with duplicate server identifier.                                                   |
| ClientTargetVersionChange                                    | INFO     | Client target version updated.                                                                                      |
| ConfigAddedKeyManually                                       | INFO     | Configuration value manually added by cluster administrator.                                                        |
| ConfigCapabilityFormatChanged!"max\_supported\_test\_format" | INFO     | Cluster capability max\_supported\_test\_format has been updated                                                    |
| ConfigOverridden                                             | INFO     | Configuration value overridden by cluster administrator.                                                            |
| ConfigOverrideChanged                                        | INFO     | Config override changed.                                                                                            |
| ConfigOverrideDiscarded                                      | WARNING  | Configuration override disabled automatically.                                                                      |
| ConfigPropagationToBackendsDurationCritical                  | CRITICAL | Config propagation to backend nodes taking too long - beyond critical threshold - aborting leader.                  |
| ConfigPropagationToBackendsTakingTooLong                     | MINOR    | Config propagation to backend nodes taking too long (still ongoing).                                                |
| ConfigPropagationToBackendsTookTooLong                       | MINOR    | Config propagation to backend nodes took too long.                                                                  |
| ConfigPropagationToClientsDurationCritical                   | CRITICAL | Config propagation to client nodes taking too long - beyond critical threshold - aborting leader.                   |
| ConfigPropagationToClientsTakingTooLong                      | MINOR    | Config propagation to client nodes taking too long (still ongoing).                                                 |
| ConfigPropagationToClientsTookTooLong                        | MINOR    | Config propagation to client nodes took too long.                                                                   |
| ConfigRemovedKeyManually                                     | INFO     | Configuration value removed manually by cluster administrator.                                                      |
| ContainerBlacklistToggle                                     | INFO     | Container is denylisted or removed from denylist.                                                                   |
| DirectoryQuotasDisabled                                      | INFO     | Directory quotas disabled.                                                                                          |
| DirectoryQuotasEnabled                                       | INFO     | Directory quotas enabled.                                                                                           |
| EncounteredEntryWithNewVersionInRaftLog                      | MINOR    | Encountered RAFT entry in RAFT log with newer version than existing one.                                            |
| FetchLocalStateNoDrainTooLongReport                          | MAJOR    | Process fails to drain the local-state changes queue of some overlay children (changes rate exceeds fetching rate). |
| HostRequestedActionChange                                    | INFO     | Container requested action changed.                                                                                 |
| IOStatusChanged                                              | INFO     | IO status changed.                                                                                                  |
| LeaderIterationGapTooLong                                    | MAJOR    | Time gap between end of previous leader iteration and start of current iteration is too long.                       |
| LeaderIterationRuntimeTooLong                                | MAJOR    | Leader iteration execution time was too long.                                                                       |
| LeaderStepDownHttpMonitorUnhealthy                           | MAJOR    | Leader step down because the HTTP monitor is unhealthy                                                              |
| LoginBannerCleared                                           | INFO     | Login banner cleared.                                                                                               |
| LoginBannerDisabled                                          | INFO     | Login banner disabled.                                                                                              |
| LoginBannerEnabled                                           | INFO     | Login banner enabled.                                                                                               |
| LoginBannerSet                                               | INFO     | Login banner set.                                                                                                   |
| ProcessBlacklistToggle                                       | INFO     | Process is denylisted or removed from denylist.                                                                     |
| ProcessLimitExpanded                                         | INFO     | Process limit expanded to allow 24 bits of process ID.                                                              |
| QueryRangeErrorBucketNodeNotInConfig                         | MAJOR    | Unknown NodeId in config bucket.                                                                                    |
| QueryRangeErrorCriticalBucketNodeNotInConfig                 | MAJOR    | Unknown process ID in configuration bucket.                                                                         |
| QueryRangeErrorQueriedBucketNotFound                         | MAJOR    | Bucket Has No Quorum Monitor received unknown BucketId.                                                             |
| QueryRangeErrorQueriedDownNodeNotFound                       | MAJOR    | Bucket Has No Quorum Monitor received unknown NodeId.                                                               |
| QueryRangeErrorRangeErrorException                           | MAJOR    | Bucket Has No Quorum Monitor received RangeError exception.                                                         |
| UpgradeBlockTaskStartInvoked                                 | DEBUG    | Block task upgrade task start invoked.                                                                              |
| WrongVersionForRaftSnapshot                                  | MINOR    | Attempt to load RAFT snapshot with unsupported version.                                                             |

### Custom

| Type        | Severity | Description         |
| ----------- | -------- | ------------------- |
| Custom      | INFO     | Custom event.       |
| CustomMajor | MAJOR    | Custom major event. |

### DataService

| Type                       | Severity | Description                                |
| -------------------------- | -------- | ------------------------------------------ |
| DsUnexpectedHandlerInvoked | WARNING  | Unexpected data service handler invocation |

### Drive

| Type                                  | Severity | Description                                                                     |
| ------------------------------------- | -------- | ------------------------------------------------------------------------------- |
| AioVecMaxLeakedExceded                | DEBUG    | AioVec {leaked} netbuf leaked.                                                  |
| CorruptRPCRequest                     | CRITICAL | Corrupt RPC request received by DRIVES process                                  |
| CorruptedDrive                        | MAJOR    | Drive has valid header but is corrupted.                                        |
| DriveAdded                            | INFO     | Drive provisioned.                                                              |
| DriveCorrupted                        | MAJOR    | Drive has valid header but is corrupted.                                        |
| DriveDeactivated                      | INFO     | Drive deactivated.                                                              |
| DriveDead                             | MAJOR    | Drive is unresponsive and fails to return IOs for extended period.              |
| DriveExcessiveErrors                  | WARNING  | Drive has excessive error rate and will be phased out.                          |
| DriveFormatUpgraded                   | INFO     | Drive format upgraded.                                                          |
| DriveIdentifyChanged                  | INFO     | Drive location indicator changed                                                |
| DriveImmediateShutdown                | MAJOR    | Drive shut down immediately.                                                    |
| DriveInitFailed                       | MAJOR    | Drive initialization failed.                                                    |
| DriveIoError                          | MAJOR    | Drive has IO error.                                                             |
| DriveIoErrorBMS                       | MAJOR    | Drive finds IO error in background media scan.                                  |
| DriveLimitExceeded                    | WARNING  | Attempt to add more drives than system supports occurs.                         |
| DriveMediumError                      | MINOR    | Drive has medium error.                                                         |
| DriveNotUnderIOMMU                    | MAJOR    | Drive is not under IOMMU, but host IOMMU is enabled.                            |
| DriveNvmeErrorLog                     | WARNING  | NVMe drive error log entry.                                                     |
| DriveNvmeSmartChange                  | MINOR    | NVMe drive SMART status changed.                                                |
| DriveOutOfNvkvChunks                  | MAJOR    | Drive is out of NVKV chunks.                                                    |
| DriveRemoved                          | INFO     | Drive removed.                                                                  |
| DriveSignatureUnknown                 | MINOR    | Drive has unknown signature.                                                    |
| DriveSmartCriticalWarning             | MINOR    | Drive SMART reports critical warning and fails immediately.                     |
| DriveStateChangesReport               | MINOR    | Drive state changes.                                                            |
| DriveStuckIOs                         | MAJOR    | IOs are stuck for extended period.                                              |
| DriveUnresponsive                     | MAJOR    | Drive is unresponsive and fails to return IOs for extended period.              |
| DriveWrongFailureDomain               | MINOR    | Drive attached to container (host) from incorrect failure domain.               |
| MBufPoison                            | MAJOR    | MBuf got poison error.                                                          |
| NvkvDuplicateSuperblockEntryRecovered | MINOR    | NVKV duplicate superblock entry recovered on drive init.                        |
| NvmeBindTimingOut                     | MAJOR    | The NVMe device binding is stuck and the server needs a power cycle to recover. |
| SpdkCuseFilterBlockedCommand          | WARNING  | SPDK CUSE driver blocked command                                                |

### Environment

| Type     | Severity | Description                 |
| -------- | -------- | --------------------------- |
| EnvIssue | MAJOR    | Environment issue detected. |

### Events

| Type                  | Severity | Description                                                         |
| --------------------- | -------- | ------------------------------------------------------------------- |
| DedupEventsDiscarded  | WARNING  | Deduplicated events discarded.                                      |
| EventsDedupReport     | INFO     | Event deduplication ends.                                           |
| EventsDiscarded       | MINOR    | Too many events generated in short period; some discarded and lost. |
| Example               | INFO     | Example.                                                            |
| ExampleAggregated     | INFO     | Example aggregated.                                                 |
| ExampleDebug          | DEBUG    | Example debug.                                                      |
| TracesDumperDownEvent | MAJOR    | Traces Dumper is inactive.                                          |

### Filesystem

| Type                                       | Severity | Description                                                                           |
| ------------------------------------------ | -------- | ------------------------------------------------------------------------------------- |
| BackgroundDirDeleteTask                    | INFO     | Background directory deletion task started.                                           |
| BackgroundDirDeleteTaskProgress            | INFO     | Background directory deletion task progress                                           |
| BlockReadFailure                           | CRITICAL | Fails to read block.                                                                  |
| BlockSeekFinished                          | MAJOR    | Block seek finished.                                                                  |
| BlockSeekStarted                           | MAJOR    | Block seek started for secondary metadata block that could not be read.               |
| BrokenFile                                 | MAJOR    | File metadata corruption.                                                             |
| CWTaskTemplateFinished                     | INFO     | Cluster-wide task (CWTask) template finished.                                         |
| CacheFlushHanging                          | MAJOR    | Host hangs while syncing file's write cache to cluster.                               |
| CatalogTaskAborted                         | INFO     | Catalog task aborted                                                                  |
| CharterNotificationDropped                 | MAJOR    | Dropped a charter notification to an unresponsive client                              |
| CheckingTimeoutForFSCK                     | MAJOR    | During integrity check, a timeout occurred; some checks may have been skipped         |
| ChecksumErrorInBackgroundWrite             | MAJOR    | Checksum error detected by the drive process during block commit.                     |
| ChecksumErrorInCommit                      | MAJOR    | Checksum error detected by SSD node in committing block.                              |
| ChecksumErrorInWrite                       | CRITICAL | Checksum error detected by COMPUTE process in write.                                  |
| ChokingBlockingIOs                         | MAJOR    | Backend choking is now blocking IOs.                                                  |
| ClusterPeerAdded                           | INFO     | Cluster peer configuration change                                                     |
| ClusterPeerRemoved                         | INFO     | Cluster peer configuration change                                                     |
| ClusterPeerUpdated                         | INFO     | Cluster peer configuration change                                                     |
| ClusterwideJobAborting                     | INFO     | Clusterwide Job configuration change                                                  |
| ClusterwideJobAdded                        | INFO     | Clusterwide Job configuration change                                                  |
| ClusterwideJobRemoved                      | INFO     | Clusterwide Job configuration change                                                  |
| DefaultDirectoryQuotaSet                   | INFO     | Default directory quota set.                                                          |
| DefaultDirectoryQuotaUnset                 | INFO     | Default directory quota unset.                                                        |
| DestageBlocked                             | CRITICAL | Cannot start destage of bucket.                                                       |
| DestageBlockedByOperation                  | MAJOR    | Mutating operation stalls and prevents destage progress.                              |
| DestageHanging                             | CRITICAL | Destage of bucket is hanging.                                                         |
| DirectoryQuotaSet                          | INFO     | Directory quota set.                                                                  |
| DirectoryQuotaUnset                        | INFO     | Directory quota unset.                                                                |
| DumpSnapHashCompleted                      | INFO     | Finishes snap hash manifest scan.                                                     |
| FailedToAddClusterwideJob                  | MAJOR    | Failed to add the cluster-wide job because the queue has reached its maximum limit    |
| FailedToSplitSliceNoRetry                  | CRITICAL | Fails to split directory slice; will not retry.                                       |
| FilesystemAdded                            | INFO     | Filesystem configuration change                                                       |
| FilesystemCreated                          | INFO     | Filesystem created.                                                                   |
| FilesystemDeleteFinished                   | INFO     | Filesystem deletion finished.                                                         |
| FilesystemDeleteStarted                    | INFO     | Filesystem deletion started.                                                          |
| FilesystemDeleted                          | INFO     | Filesystem configuration change                                                       |
| FilesystemDownloadAborted                  | INFO     | Filesystem download aborted.                                                          |
| FilesystemDownloadFinished                 | INFO     | Filesystem download finished.                                                         |
| FilesystemDownloadStarted                  | INFO     | Filesystem download started.                                                          |
| FilesystemGroupAdded                       | INFO     | Filesystem group configuration change                                                 |
| FilesystemGroupDeleted                     | INFO     | Filesystem group configuration change                                                 |
| FilesystemGroupUpdated                     | INFO     | Filesystem group configuration change                                                 |
| FilesystemMounted                          | INFO     | Mount operation completed successfully.                                               |
| FilesystemRemoved                          | INFO     | Filesystem configuration change                                                       |
| FilesystemUmounted                         | INFO     | Umount operation completed successfully                                               |
| FilesystemUpdated                          | INFO     | Filesystem configuration change                                                       |
| FlockSyncHanging                           | CRITICAL | Bucket cannot finish flock resync with all clients.                                   |
| FlockSyncTimedOut                          | CRITICAL | Bucket flock resync with a client timed out.                                          |
| ForcedBucketStepdown                       | MINOR    | Bucket forced to step down.                                                           |
| FreeBlockStillUsed                         | CRITICAL | Finds block falsely marked as free.                                                   |
| FsCapacityLimitReached                     | WARNING  | Filesystem capacity limit reached.                                                    |
| GroupGraceExpired                          | WARNING  | Group soft capacity quota reached and grace period expired.                           |
| GroupHardLimitReached                      | WARNING  | Group hard capacity quota reached.                                                    |
| HangingBackendIosDetected                  | CRITICAL | Some IOs are hanging.                                                                 |
| HangingBackendIosNoLongerDetected          | INFO     | IOs are no longer hanging.                                                            |
| HangingBucketStepDown                      | WARNING  | Bucket step-down is hanging.                                                          |
| HangingDirectorySplit                      | MAJOR    | Directory split makes no progress for long time.                                      |
| HangingDriverFrontendIosDetected           | CRITICAL | Some IOs are hanging.                                                                 |
| HangingDriverFrontendIosNoLongerDetected   | INFO     | IOs are no longer hanging.                                                            |
| HangingNFSFrontendIosDetected              | CRITICAL | Some IOs are hanging.                                                                 |
| HangingNFSFrontendIosNoLongerDetected      | INFO     | IOs are no longer hanging.                                                            |
| IntegrityCheckFinished                     | DEBUG    | Integrity check finished.                                                             |
| IntegrityCheckIssueCritical                | CRITICAL | Finds data integrity issue (Critical).                                                |
| IntegrityCheckIssueCriticalNoDedup         | CRITICAL | Finds data integrity issue (Critical).                                                |
| IntegrityCheckIssueDebug                   | DEBUG    | Finds data integrity issue (Debug).                                                   |
| IntegrityCheckIssueDebugNoDedup            | DEBUG    | Finds data integrity issue (Debug).                                                   |
| IntegrityCheckIssueMajor                   | MAJOR    | Finds data integrity issue (Major).                                                   |
| IntegrityCheckIssueMajorNoDedup            | MAJOR    | Finds data integrity issue (Major).                                                   |
| IntegrityCheckIssueMinor                   | MINOR    | Finds data integrity issue (Minor).                                                   |
| IntegrityCheckIssueMinorNoDedup            | MINOR    | Finds data integrity issue (Minor).                                                   |
| IntegrityCheckIssueWarning                 | WARNING  | Finds data integrity issue (Warning).                                                 |
| IntegrityCheckIssueWarningNoDedup          | WARNING  | Finds data integrity issue (Warning).                                                 |
| IntegrityCheckStarted                      | DEBUG    | Integrity check started.                                                              |
| IntegrityCheckTransientIssue               | DEBUG    | Finds transient state expected to be encountered.                                     |
| IntegrityCheckTransientIssueNoDedup        | DEBUG    | Finds transient state expected to be encountered.                                     |
| JournalScanFailed                          | WARNING  | A slow journal-scan memento reconstruction failed.                                    |
| JournalScansSucceeded                      | INFO     | Journal scans succeeded.                                                              |
| ManualOverrideStall                        | WARNING  | Service is manually overridden and stalled.                                           |
| MetadataCommitQueueHang                    | MINOR    | Bucket step down due to hanging metadata commit queue.                                |
| ObjectStoreAttachedToFilesystem            | INFO     | Object store attached to filesystem.                                                  |
| ObjectStoreFinishedDetachingFromFilesystem | INFO     | Object store finishes detaching from filesystem.                                      |
| ObjectStoreStartedDetachingFromFilesystem  | INFO     | Object store starts detaching from filesystem.                                        |
| QuotaGraceExpired                          | WARNING  | Directory soft capacity quota reached and grace period expired.                       |
| QuotaHardLimitReached                      | WARNING  | Directory hard capacity quota reached.                                                |
| RAIDMDReadFailureInSnaphashDump            | WARNING  | Fails to read metadata block from RAID when dumping snapshot manifest.                |
| SnapshotApplied                            | INFO     | Filesystem's live view pointed at an existing snapshot.                               |
| SnapshotContentCopied                      | INFO     | Snapshot content copied.                                                              |
| SnapshotCreated                            | INFO     | Snapshot created.                                                                     |
| SnapshotCreationFailed                     | MAJOR    | Snapshot creation fails.                                                              |
| SnapshotDeleted                            | INFO     | Snapshot deleted.                                                                     |
| SnapshotDownloadAborted                    | INFO     | Snapshot download aborted.                                                            |
| SnapshotDownloadFinished                   | INFO     | Snapshot download finished.                                                           |
| SnapshotDownloadStarted                    | INFO     | Snapshot download started.                                                            |
| SnapshotFilesystemRestored                 | INFO     | Filesystem restored from snapshot.                                                    |
| SnapshotParamsUpdated                      | INFO     | Snapshot updated.                                                                     |
| SnapshotPolicyAdded                        | INFO     | Snapshot policy configuration change                                                  |
| SnapshotPolicyAttached                     | INFO     | Snapshot policy attached to filesystem.                                               |
| SnapshotPolicyDeleted                      | INFO     | Snapshot policy configuration change                                                  |
| SnapshotPolicyDetached                     | INFO     | Snapshot policy detached from filesystem.                                             |
| SnapshotPolicyUpdated                      | INFO     | Snapshot policy configuration change                                                  |
| SnapshotUploadFailed                       | MAJOR    | Snapshot upload fails.                                                                |
| SnapshotUploadFinished                     | INFO     | Snapshot upload finished.                                                             |
| SnapshotUploadStarted                      | INFO     | Snapshot upload started.                                                              |
| SquelchBlockIdSetAbortedFlushed            | DEBUG    | While setting squelch block's block ID for upgrade, it is already changed to invalid. |
| SquelchBlockIdSetAbortedRewritten          | DEBUG    | While setting squelch block's block ID for upgrade, it is already rewritten.          |
| SuperblockUnreadable                       | CRITICAL | Bucket superblock cannot be loaded from storage.                                      |
| UnflushedOpOnDeletingSnapview              | MAJOR    | Unflushed IO operation detected on snapshot being deleted.                            |
| UserGraceExpired                           | WARNING  | User soft capacity quota reached and grace period expired.                            |
| UserHardLimitReached                       | WARNING  | User hard capacity quota reached.                                                     |

### IO

| Type                 | Severity | Description                                               |
| -------------------- | -------- | --------------------------------------------------------- |
| SystemDriveIsTooSlow | MAJOR    | System drive response times exceed acceptable thresholds. |

### InterfaceGroup

| Type                          | Severity | Description                                        |
| ----------------------------- | -------- | -------------------------------------------------- |
| FloatingIpAcquired            | INFO     | Floating IP address acquired by process.           |
| FloatingIpReleased            | INFO     | Floating IP address released by process.           |
| FloatingIpRemoveStateTimedout | WARNING  | Timeout occurs while removing floating IP address. |
| InterfaceGroupAdded           | INFO     | Interface group configuration change               |
| InterfaceGroupDeleted         | INFO     | Interface group configuration change               |
| InterfaceGroupIpsAdded        | INFO     | Interface group IPs configuration change           |
| InterfaceGroupIpsDeleted      | INFO     | Interface group IPs configuration change           |
| InterfaceGroupPortAdded       | INFO     | Interface group port configuration change          |
| InterfaceGroupPortDeleted     | INFO     | Interface group port configuration change          |
| InterfaceGroupUpdated         | INFO     | Interface group configuration change               |

### KDriver

| Type                      | Severity | Description                                          |
| ------------------------- | -------- | ---------------------------------------------------- |
| DriverAlert               | WARNING  | Kernel driver generates alert condition.             |
| DriverReportedBadChecksum | MAJOR    | The client driver detected a data checksum mismatch. |

### Kms

| Type                    | Severity | Description              |
| ----------------------- | -------- | ------------------------ |
| KmsConfigurationAdded   | INFO     | KMS configuration change |
| KmsConfigurationRemoved | INFO     | KMS configuration change |
| KmsConfigurationUpdated | INFO     | KMS configuration change |

### Licensing

| Type                   | Severity | Description                                 |
| ---------------------- | -------- | ------------------------------------------- |
| LicensingReset         | INFO     | Licensing state reset to default.           |
| LicensingWorkerStarted | DEBUG    | Licensing background worker process starts. |
| NewLicenseInstalled    | INFO     | New license installed on cluster.           |
| PaygLicensingEnabled   | INFO     | Pay-as-you-go licensing model enabled.      |

### ManualOverride

| Type                  | Severity | Description                             |
| --------------------- | -------- | --------------------------------------- |
| ManualOverrideChanged | INFO     | Manual configuration override modified. |

### NFS

| Type                                | Severity | Description                                                                                        |
| ----------------------------------- | -------- | -------------------------------------------------------------------------------------------------- |
| NfsAclConfigurationChangeEvent      | INFO     | NFS ACL configuration changed.                                                                     |
| NfsAuthTypeChangeEvent              | INFO     | NFS Authentication Types configuration changed.                                                    |
| NfsClientGroupAdded                 | INFO     | NFS client group configuration change                                                              |
| NfsClientGroupDeleted               | INFO     | NFS client group configuration change                                                              |
| NfsClientGroupRuleAdded             | INFO     | NFS client group rule configuration change                                                         |
| NfsClientGroupRuleDeleted           | INFO     | NFS client group rule configuration change                                                         |
| NfsClusterStatusActiveEvent         | INFO     | NFS Cluster is active.                                                                             |
| NfsClusterStatusInactiveEvent       | CRITICAL | NFS Cluster is inactive.                                                                           |
| NfsConfigMismatch                   | WARNING  | A server repeatedly failed to apply the latest NFS configuration.                                  |
| NfsCustomOptionsUpdated             | INFO     | NFS custom options configuration change                                                            |
| NfsDirectIOConfigurationChangeEvent | INFO     | NFS DirectIO configuration changed.                                                                |
| NfsExportsPermissionsAdded          | INFO     | NFS export permissions for configuration change                                                    |
| NfsExportsPermissionsDeleted        | INFO     | NFS export permissions for configuration change                                                    |
| NfsExportsPermissionsUpdated        | INFO     | NFS export permissions for configuration change                                                    |
| NfsHostRpcbindConflictEvent         | WARNING  | Host rpcbind service was disabled because NFS multi-tenancy took over the portmapper on this host. |
| NfsKerberosSetupEvent               | INFO     | NFS Kerberos Service setup complete.                                                               |
| NfsLdapSetupEvent                   | INFO     | NFS LDAP setup complete.                                                                           |
| NfsLocksConfigurationChangeEvent    | INFO     | NFS Locks configuration changed.                                                                   |
| NfsMountFail                        | WARNING  | NFS mount request fails.                                                                           |
| NfsMountTokenSigningUnavailable     | MAJOR    | The NFS server could not obtain signed mount tokens for its exports.                               |
| NfsPortmapFail                      | MAJOR    | NFS server fails to register in portmap.                                                           |
| NfsServiceDown                      | CRITICAL | NFS Service is down.                                                                               |
| NfsStatsConfigurationChangeEvent    | INFO     | NFS Extended stats configuration changed.                                                          |
| NfswServiceCriticalEvent            | CRITICAL | NFS-W posts event.                                                                                 |
| NfswServiceInfoEvent                | INFO     | NFS-W posts event.                                                                                 |
| NfswServiceWarningEvent             | WARNING  | NFS-W posts event.                                                                                 |

### Network

| Type                            | Severity | Description                                                                                                                                                                           |
| ------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ArpServerDuplicateIPDetected    | CRITICAL | ARP server detects duplicate IP address on network.                                                                                                                                   |
| ArpServerFailedToInitialize     | CRITICAL | ARP server fails to initialize.                                                                                                                                                       |
| ClientNodeDisconnected          | WARNING  | Client disconnects from cluster.                                                                                                                                                      |
| CloudMoveIpFail                 | MINOR    | Fails to reassign IP address in cloud environment.                                                                                                                                    |
| DefaultDataNetworkingChange     | INFO     | Default data networking configuration modified.                                                                                                                                       |
| DpdkIBQkeyMismatch              | MAJOR    | DPDK InfiniBand queue key mismatch detected.                                                                                                                                          |
| DpdkInitFailed                  | CRITICAL | DPDK EAL initialization failed; node will terminate.                                                                                                                                  |
| DpdkIovaModeNotDetermined       | MAJOR    | DPDK unable to determine common IOVA mode across devices.                                                                                                                             |
| DpdkPoolSummary                 | DEBUG    | DPDK memory pool status summary.                                                                                                                                                      |
| FipIsNoLongerOnDevice           | MAJOR    | Floating IP address no longer assigned to expected device.                                                                                                                            |
| HangingRPCs                     | MAJOR    | Remote procedure calls exceed expected completion time.                                                                                                                               |
| HugepagesAllocationFailure      | MINOR    | Fails to allocate hugepages memory.                                                                                                                                                   |
| IONodeCannotFetchConfig         | WARNING  | IO node unable to retrieve cluster configuration and join cluster.                                                                                                                    |
| L6PacketFormatNotInSync         | WARNING  | Layer 6 packet format inconsistent with process limit flags.                                                                                                                          |
| MemoryAllocFailed               | MINOR    | Memory allocation request fails.                                                                                                                                                      |
| MemoryClaimFailed               | MINOR    | Memory claim operation fails.                                                                                                                                                         |
| MemoryMigratedAfterPin          | MAJOR    | Hugepage memory mapping moves after being pinned to physical memory.                                                                                                                  |
| MemoryMigratedBeforePin         | MINOR    | Hugepage memory mapping moves before being pinned to physical memory.                                                                                                                 |
| MemoryPinningIoctlFailed        | MINOR    | Memory pinning system call fails.                                                                                                                                                     |
| MgmtNodeCannotFetchConfig       | WARNING  | Management process unable to retrieve cluster configuration and join cluster.                                                                                                         |
| NICNotFound                     | INFO     | Network interface card not found during initialization.                                                                                                                               |
| NetDeviceLinkDown               | MINOR    | Network interface link status is DOWN.                                                                                                                                                |
| NetDeviceLinkUp                 | INFO     | Network interface link status is UP.                                                                                                                                                  |
| NetSlaveDeviceLinkDown          | MINOR    | Bonded network slave interface link status is DOWN.                                                                                                                                   |
| NetSlaveDeviceLinkUp            | MINOR    | Bonded network slave interface link status is UP.                                                                                                                                     |
| NetnsConfigureFailure           | MAJOR    | Network namespace configuration failed.                                                                                                                                               |
| NetspaceAdded                   | INFO     | Network Space provisioned                                                                                                                                                             |
| NetspaceEnableRDMAFailed        | WARNING  | RDMA could not be enabled on a network interface after repeated attempts, most likely because the NIC's RoCE GID table is exhausted.                                                  |
| NetspaceRemoved                 | INFO     | Network Space removed                                                                                                                                                                 |
| NetspaceUpdated                 | INFO     | Network Space updated                                                                                                                                                                 |
| NetworkBan                      | MAJOR    | Network peer banned due to connectivity issues.                                                                                                                                       |
| NetworkPortConfigFail           | MINOR    | Network port configuration operation fails.                                                                                                                                           |
| NetworkPortDead                 | MAJOR    | Network port does not transmit or receive packets for extended period.                                                                                                                |
| NetworkSpaceApplyFailed         | MAJOR    | Network Space apply failed: first failed backend host reported                                                                                                                        |
| NetworkSpaceCreated             | INFO     | Network Space create completed on all backend hosts                                                                                                                                   |
| NetworkSpaceRemoved             | INFO     | Network Space removal confirmed on all backend hosts                                                                                                                                  |
| NetworkSpaceRolledBack          | MAJOR    | Network Space create/update rolled back after a host reported a failure                                                                                                               |
| NetworkSpaceUpdated             | INFO     | Network Space update completed on all backend hosts                                                                                                                                   |
| NetworkUnban                    | INFO     | Network peer unbanned and connectivity restored.                                                                                                                                      |
| NoConnectivityToLivingNode      | MAJOR    | Process loses connectivity to all active cluster members.                                                                                                                             |
| NodeCannotJoinCluster           | WARNING  | Process unable to join cluster within expected timeframe.                                                                                                                             |
| NodeCannotSendJumboFrames       | MINOR    | Process unable to send jumbo frames (packets larger than standard MTU).                                                                                                               |
| NodeDisconnected                | MINOR    | Process disconnected from cluster.                                                                                                                                                    |
| RDMAClientDisabled              | MINOR    | RDMA client optimization disabled.                                                                                                                                                    |
| RDMAClientEnabled               | MINOR    | RDMA client optimization enabled.                                                                                                                                                     |
| RDMADegraded                    | MINOR    | RDMA performance degraded                                                                                                                                                             |
| RDMADeviceDead                  | MAJOR    | RDMA device does not receive completion notifications for extended period.                                                                                                            |
| TenantNetworkApplyFailed        | MAJOR    | A floating netns failed to come up on the host that owns it.                                                                                                                          |
| TenantNetworkNoEligibleServer   | MAJOR    | Failover freed tenant networks, but no frontend server is eligible to receive them; reassignment is stalled until a frontend network port is healthy and ready to serve floating IPs. |
| TenantNetworkServerMarkedFailed | MAJOR    | A host repeatedly failed to apply a floating netns; its port for that subnet was marked FAILED so the netns can be redistributed.                                                     |

### Node

| Type                   | Severity | Description                                |
| ---------------------- | -------- | ------------------------------------------ |
| AssertionFailed        | MAJOR    | Assertion failed.                          |
| GCCrashReport          | MINOR    | Node has crashed in GC on the previous run |
| MemoryAllocationFailed | MAJOR    | Memory allocation failed.                  |
| NodeAbruptExitReport   | MINOR    | Node has crashed on the previous run       |
| NodeExceptionExit      | MAJOR    | Process exits with exception.              |
| NodeKernelStack        | WARNING  | Kernel stack of node before reset.         |
| NodeSignalExit         | MAJOR    | Process exits due to receiving signal.     |
| NodeStarted            | DEBUG    | Process starts.                            |
| NodeStopped            | DEBUG    | Process stops.                             |
| NodeTraceback          | WARNING  | Traceback of process before reset.         |
| SoftAssertionFailed    | MAJOR    | Assertion failed (soft).                   |

### ObjectStorage

| Type                                                 | Severity | Description                                                                                                                   |
| ---------------------------------------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------- |
| ChecksumErrorInDownloadedObject                      | MINOR    | Checksum error detected by compute process in downloaded OBS data block.                                                      |
| ChecksumErrorInReplicatedDataBlock                   | MAJOR    | Checksum error detected by COMPUTE node in a replicated data block                                                            |
| ChecksumErrorOnObjectUpload                          | MAJOR    | Checksum error detected by COMPUTE node when uploading an OBS data block (corrupted after verifying data read from the drive) |
| DataBlobDownloadFailed                               | WARNING  | Fails downloading data blob header.                                                                                           |
| DownloadedExtentHasInvalidBlobId                     | MAJOR    | Downloaded extent has invalid blob ID.                                                                                        |
| DownloadedExtentMissingExpectedBlock                 | MAJOR    | Downloaded extent missing expected block.                                                                                     |
| ExtentHasFakeRetentionTag                            | MAJOR    | Extent has non-local tag but contains disk-only blocks.                                                                       |
| InvalidDataBlobHeader                                | MAJOR    | Invalid header detected by COMPUTE process in downloaded OBS data blob.                                                       |
| ObjectStoreBucketAdded                               | INFO     | Object store bucket configuration change                                                                                      |
| ObjectStoreBucketDeleted                             | INFO     | Object store bucket configuration change                                                                                      |
| ObjectStoreBucketUpdated                             | INFO     | Object store bucket configuration change                                                                                      |
| ObjectStoreGroupAdded                                | INFO     | Object store configuration change                                                                                             |
| ObjectStoreGroupDeleted                              | INFO     | Object store configuration change                                                                                             |
| ObjectStoreGroupUpdated                              | INFO     | Object store configuration change                                                                                             |
| ObjectStoreHasHighLevelOfUnreclaimedCapacity         | WARNING  | Object store has high level of unreclaimed capacity.                                                                          |
| ObjectStoreIsFull                                    | CRITICAL | Object store is full.                                                                                                         |
| ObjectStoreNoLongerHasHighLevelOfUnreclaimedCapacity | INFO     | Object store no longer has high level of unreclaimed capacity.                                                                |
| ObjectStoreStatusDown                                | MAJOR    | Object store status is down.                                                                                                  |
| ObjectStoreStatusUp                                  | INFO     | Object store status is UP.                                                                                                    |
| ObsIsMissingObject                                   | CRITICAL | Permanently fails to download object from object storage; object not found.                                                   |
| PersistentChecksumErrorInDownloadedObject            | MAJOR    | Checksum error detected by compute process in downloaded OBS data block.                                                      |

### Raft

| Type                              | Severity | Description                                           |
| --------------------------------- | -------- | ----------------------------------------------------- |
| IndexChangeDuringStream           | INFO     | RAFT index changes during streaming of RAFT snapshot. |
| OutOfMemoryErrorOnLeadershipAgent | CRITICAL | Out of memory error on leadership agent.              |

### Raid

| Type                                   | Severity | Description                                                                                                                                                                                                             |
| -------------------------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| BitmapFlushMissingChunk                | INFO     | RAID bitmap flush operation encountered a missing chunk                                                                                                                                                                 |
| DataGenerationNumberBug                | WARNING  | The system encountered an issue while advancing the applied data generation number report from a bucket.                                                                                                                |
| DataProtectionLevelDecreased           | MINOR    | Data protection level decreased.                                                                                                                                                                                        |
| DataProtectionLevelIncreased           | INFO     | Data protection level increased.                                                                                                                                                                                        |
| DiskAutoDeactivationAcknowledged       | INFO     | Auto-deactivated disk acknowledged by a manual operation                                                                                                                                                                |
| DiskAutoReactivated                    | INFO     | Disk automatically reactivated                                                                                                                                                                                          |
| DiskLongUnwritable                     | MAJOR    | Drive(s) have been unwritable for an extended period, risking NVKV overload when they become writable again. Workaround: fully deactivate the drive, wait for INACTIVE state, mark it writable, then activate it again. |
| DiskMarkedForAutoEjection              | WARNING  | Disk marked for automatic ejection                                                                                                                                                                                      |
| DiskNvkvHighUtilization                | WARNING  | Disk's internal resource (NVKV) has high utilization.                                                                                                                                                                   |
| DiskWritableStateChange                | INFO     | Disk writable state changes.                                                                                                                                                                                            |
| DrivesProcessConnectionLost            | MINOR    | Disk connection lost.                                                                                                                                                                                                   |
| DrivesProcessConnectionRecovered       | INFO     | Disks quick recovery from lost connection detected.                                                                                                                                                                     |
| EnoughActiveFailureDomains             | MINOR    | Sufficient active failure domains.                                                                                                                                                                                      |
| EvictionOfPlacementFailed              | MAJOR    | Eviction of placement encounters potentially corrupt block marked as used.                                                                                                                                              |
| FailedRecoveringData                   | MAJOR    | Detects unexpected data; not enough redundant copies available to recover.                                                                                                                                              |
| FoundCorruptedBlockInStripe            | CRITICAL | Detects corrupt block in RAID stripe.                                                                                                                                                                                   |
| FoundOrphanedRaidBlock                 | MINOR    | Detects block marked as Used in RAID stripe yet Free on FS.                                                                                                                                                             |
| HashRingAlgoRedistCompleted            | INFO     | Hash ring gradual transition reached an endpoint (fully one algorithm).                                                                                                                                                 |
| HashRingTransitionStepSet              | INFO     | Hash ring gradual-transition step (velocity) set.                                                                                                                                                                       |
| HotSpareFailureDomainsUpdated          | INFO     | Hot spare failure domains updated.                                                                                                                                                                                      |
| InFlightCorruptionDetectedByScrubber   | MINOR    | Detects in-flight corrupt read result from drive.                                                                                                                                                                       |
| IncorrectScannedBlockChecksum          | CRITICAL | Detects used block with mismatching checksum.                                                                                                                                                                           |
| NoDataProtection                       | MAJOR    | No data protection.                                                                                                                                                                                                     |
| PersistentNoDataProtection             | CRITICAL | Cluster is without data protection for significant period.                                                                                                                                                              |
| PersistentTooManyFailures              | CRITICAL | Cluster experiences excessive failures accessing drives for extended period.                                                                                                                                            |
| QuorumGenerationNumberBug              | WARNING  | The system encountered an issue while advancing the applied quorum generation number report from a bucket.                                                                                                              |
| RaidReadFreeBlock                      | CRITICAL | RAID reads block marked as free.                                                                                                                                                                                        |
| RaidScannerFinished                    | DEBUG    | RAID scan finished.                                                                                                                                                                                                     |
| RaidScrubbingRateUpdated               | INFO     | RAID scrubber limit updated.                                                                                                                                                                                            |
| RaidSpaceFull                          | MAJOR    | RAID space is full.                                                                                                                                                                                                     |
| RaidsStarted                           | INFO     | RAIDs started.                                                                                                                                                                                                          |
| ReadMissingChunk                       | MINOR    | RAID read operation encountered a missing chunk                                                                                                                                                                         |
| RepairedCorruptDataFromDrive           | CRITICAL | Detected corrupt data from drive\[s]. The system will rewrite with the correct data.                                                                                                                                    |
| SafeRelocateBlocked                    | MAJOR    | Safe-mode relocation refused to write a block whose content could not be verified.                                                                                                                                      |
| ScrubberBatchHanging                   | MAJOR    | RAID Scrubber is making no progress on a single batch                                                                                                                                                                   |
| ScrubberCorruptStripeRelocated         | MINOR    | Scrubber queued all blocks from a corrupt stripe for safe relocation.                                                                                                                                                   |
| ScrubberCorruptStripeRelocationPartial | MAJOR    | Scrubber stopped mid-queuing of corrupt stripe blocks for safe relocation due to space exhaustion.                                                                                                                      |
| ScrubberCorruptStripeRelocationSkipped | MINOR    | Scrubber skipped relocation of corrupt stripe due to too many down disks.                                                                                                                                               |
| ScrubberStalling                       | MAJOR    | RAID Scrubber is hanging on the placement                                                                                                                                                                               |
| ScrubberUnrecoverableCorruptStripe     | CRITICAL | Scrubber detected an unrecoverable corrupt RAID stripe.                                                                                                                                                                 |
| SingleHopReadCorruptionDetected        | MINOR    | Single-hop read corruption detected.                                                                                                                                                                                    |
| SoulDeserializationFailed              | MINOR    | Failed to deserialize bucket soul during startup                                                                                                                                                                        |
| SoulSerializationFailed                | MINOR    | Failed to serialize bucket soul during graceful shutdown                                                                                                                                                                |
| SoulValidationFailed                   | INFO     | Bucket soul validation failed during startup                                                                                                                                                                            |
| SwitchPlacementHanging                 | MINOR    | Active placement to write to is not available due to capacity constraints or disk failures.                                                                                                                             |
| TooFewActiveFailureDomains             | MAJOR    | Too few active failure domains.                                                                                                                                                                                         |
| TooManyFailures                        | MAJOR    | Too many failures; some data is unavailable.                                                                                                                                                                            |
| UsedSSDCapacityCriticalOverflow        | CRITICAL | SSD capacity usage critically overflowing; internal spares running out.                                                                                                                                                 |
| UsedSSDCapacityNoLongerOverflows       | INFO     | SSD capacity usage no longer overflowing.                                                                                                                                                                               |
| UsedSSDCapacityOverflow                | MAJOR    | SSD capacity usage overflowing; internal capacity spares are used.                                                                                                                                                      |
| WriteMissingChunk                      | MAJOR    | RAID write operation encountered a missing chunk                                                                                                                                                                        |

### Replication

| Type                              | Severity | Description                                                          |
| --------------------------------- | -------- | -------------------------------------------------------------------- |
| ReplicaPairCreated                | INFO     | Replication pair was created                                         |
| ReplicaPairPaused                 | INFO     | Replication pair was paused                                          |
| ReplicaPairRemoved                | INFO     | Replication pair was removed                                         |
| ReplicaPairResumed                | INFO     | Replication pair was resumed                                         |
| ReplicaPairUpdated                | INFO     | Replication pair configuration was updated                           |
| ReplicaSnapshotApplyFailed        | MAJOR    | Failed to apply replicated snapshot to filesystem                    |
| ReplicaSnapshotApplyFinished      | INFO     | Finished applying replicated snapshot to filesystem                  |
| ReplicaSnapshotApplyStarted       | INFO     | Started applying replicated snapshot to filesystem                   |
| ReplicaSnapshotCopyAborted        | INFO     | Aborted copying snapshot replica data                                |
| ReplicaSnapshotCopyFilesSkipped   | MINOR    | Some files failed to copy during replication data hydration          |
| ReplicaSnapshotCopyFinished       | INFO     | Finished copying snapshot replica data                               |
| ReplicaSnapshotCopyPathMissing    | MINOR    | Configured replication copy paths not present on target              |
| ReplicaSnapshotCopyStarted        | INFO     | Started copying snapshot replica data                                |
| ReplicaSnapshotCycleAborted       | WARNING  | Replication engine aborted a replication cycle and will retry        |
| ReplicaSnapshotCycleCompleted     | INFO     | Replication engine completed a replication cycle                     |
| ReplicaSnapshotCycleFailed        | MAJOR    | Replication engine failed a replication cycle                        |
| ReplicaSnapshotCycleStarted       | INFO     | Replication engine started a replication cycle                       |
| ReplicaSnapshotPhaseStarted       | INFO     | Replication engine started a replication phase on the source cluster |
| ReplicaSnapshotReceiveAborted     | INFO     | Aborted receiving snapshot replica                                   |
| ReplicaSnapshotReceiveFinished    | INFO     | Finished receiving snapshot replica                                  |
| ReplicaSnapshotReceiveStarted     | INFO     | Started receiving snapshot replica                                   |
| ReplicaSnapshotSendAborted        | INFO     | Aborted sending snapshot replica                                     |
| ReplicaSnapshotSendCopyFinished   | INFO     | Finished sending data of snapshot replica (copy)                     |
| ReplicaSnapshotSendFinished       | INFO     | Finished sending snapshot replica                                    |
| ReplicaSnapshotSendStarted        | INFO     | Started sending snapshot replica                                     |
| ReplicaSnapshotSourceDeleteFailed | MINOR    | Failed to delete the source snapshot                                 |
| ReplicaSnapshotTargetDeleteFailed | MINOR    | Failed to delete the replica snapshot on the target cluster          |

### Resources

| Type                                       | Severity | Description                                                                  |
| ------------------------------------------ | -------- | ---------------------------------------------------------------------------- |
| APIServerStartFailed                       | WARNING  | Fails to start API server.                                                   |
| APIServerStarted                           | INFO     | API server started successfully.                                             |
| DeviceIsNotAValidNetworkDevice             | WARNING  | Device is not valid network device.                                          |
| DriverLoaded                               | INFO     | Driver attached.                                                             |
| FailedToLoadDriver                         | WARNING  | Fails to load WekaFS driver.                                                 |
| FrontendNodeMemoryBelowMinimum             | MAJOR    | A frontend process was allocated fewer hugepages than the supported minimum. |
| HangingHTTPRequest                         | MINOR    | Hanging HTTP request detected.                                               |
| HttpServerFibersExhausted                  | MAJOR    | Hanging HTTP requests exhaust all available fibers.                          |
| HugepagesAllocationRetries                 | WARNING  | Hugepages allocation retried.                                                |
| HugepagesAllocationTookTooLong             | WARNING  | Hugepages allocation takes unexpectedly long duration.                       |
| InactiveHostCannotJoinCluster              | INFO     | Inactive host cannot join cluster.                                           |
| LoadingStableResourcesFailed               | INFO     | Fails loading stable resources.                                              |
| NetBufsExhausted                           | MAJOR    | Netbufs are exhausted.                                                       |
| NetDevDriverReloadFailed                   | MINOR    | Net device driver reload failed                                              |
| NetworkDeviceHasNoIp                       | MAJOR    | Network device has no IP address.                                            |
| NetworkDeviceNotUsedByAnySlots             | MINOR    | Network device not used by any slots.                                        |
| NoIPsConfiguredForHostJoinWithNoDefaultNet | WARNING  | No IP configured for process {nid} with no default-net.                      |
| RevertToStableResources                    | INFO     | Reverts to stable resources.                                                 |
| WCGroupContainerEvent                      | MAJOR    | Container Status.                                                            |
| WCGroupUsageMajorEvent                     | MAJOR    | Container {resource} status.                                                 |
| WCGroupUsageWarningEvent                   | WARNING  | Container {resource} status.                                                 |

### S3

| Type                                    | Severity | Description                                                                                          |
| --------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------- |
| S3AddBucketILMRuleEvent                 | INFO     | A new ILM rule is added to an S3 bucket.                                                             |
| S3AfterUpgradeResult                    | INFO     | S3 after upgrade result.                                                                             |
| S3AfterUpgradeStart                     | INFO     | S3 after upgrade started.                                                                            |
| S3AsssumeRoleEvent                      | INFO     | An STS token is issued for temporary S3 access.                                                      |
| S3AttachIAMPolicyEvent                  | INFO     | An IAM policy is attached to an S3 bucket.                                                           |
| S3AttachIAMPolicyToGroupEvent           | INFO     | An IAM policy is attached to an S3 group.                                                            |
| S3AuditWebhookDisabledEvent             | INFO     | The S3 audit webhook is disabled.                                                                    |
| S3AuditWebhookEnabledEvent              | INFO     | The S3 audit webhook is enabled.                                                                     |
| S3BucketNotificationAdded               | INFO     | S3 bucket notification added.                                                                        |
| S3BucketNotificationRemoved             | INFO     | S3 bucket notification removed.                                                                      |
| S3BucketObjectLockEnabledEvent          | INFO     | Object lock was enabled on a new S3 bucket.                                                          |
| S3BucketPerformanceConfigReset          | INFO     | S3 bucket performance configuration reset                                                            |
| S3BucketPerformanceConfigSet            | INFO     | S3 bucket performance configuration set                                                              |
| S3BucketTypeChangedEvent                | INFO     | The S3 bucket type changed                                                                           |
| S3BucketVersioningChangedEvent          | INFO     | The versioning state of an S3 bucket changed.                                                        |
| S3ClusterCreated                        | INFO     | A new S3 cluster is successfully created.                                                            |
| S3ClusterDestroyFailed                  | MAJOR    | The attempt to destroy the S3 cluster fails.                                                         |
| S3ClusterDestroyed                      | INFO     | The S3 cluster is successfully destroyed.                                                            |
| S3ClusterPerformanceConfigReset         | INFO     | S3 cluster performance configuration reset                                                           |
| S3ClusterSetupEvent                     | INFO     | S3 cluster setup is updated.                                                                         |
| S3ClusterStatusActiveEvent              | INFO     | The S3 cluster returns to an operational state.                                                      |
| S3ClusterStatusInactiveEvent            | CRITICAL | The S3 cluster is currently non-operational.                                                         |
| S3ClusterUpdated                        | DEBUG    | Configuration of the S3 cluster is updated.                                                          |
| S3ContainerStateChangesEvent            | DEBUG    | The status of an S3 container changes.                                                               |
| S3ContainerStatusActiveEvent            | INFO     | The S3 container returns to an operational state.                                                    |
| S3ContainerStatusInactiveEvent          | MAJOR    | The S3 container is currently non-operational.                                                       |
| S3ContainerStatusOnlineEvent            | INFO     | The S3 container returns to an online state.                                                         |
| S3ContainerStatusSaturatedEvent         | MAJOR    | The S3 container reaches saturation or capacity limits.                                              |
| S3CreateBucketEvent                     | INFO     | A new S3 bucket is successfully created.                                                             |
| S3CreateGroupEvent                      | INFO     | A new S3 group is created.                                                                           |
| S3CreateIAMPolicyEvent                  | INFO     | A new IAM policy is created within S3.                                                               |
| S3CreateServiceAccountEvent             | INFO     | A new S3 service account is created.                                                                 |
| S3DefaultFilesystemClearedEvent         | INFO     | S3 tenant default filesystem is cleared.                                                             |
| S3DestroyBucketEvent                    | INFO     | The S3 bucket is deleted and all contents are removed.                                               |
| S3DetachIAMPolicyEvent                  | INFO     | An IAM policy is detached from an S3 role.                                                           |
| S3DetachIAMPolicyFromGroupEvent         | INFO     | An IAM policy is detached from an S3 group.                                                          |
| S3DrainEvent                            | INFO     | The S3 container is drained for maintenance or shutdown.                                             |
| S3GlobalPerformanceConfigSet            | INFO     | S3 global performance configuration set                                                              |
| S3ILMTaskProgress                       | INFO     | S3 Lifecycle task progress.                                                                          |
| S3KVAddedEvent                          | INFO     | S3 Config Add Key.                                                                                   |
| S3KVRemovedEvent                        | INFO     | S3 configuration remove key.                                                                         |
| S3KVResetEvent                          | INFO     | S3 KV store configuration reset.                                                                     |
| S3KwasFallback                          | DEBUG    | S3 KWAS fallback occurred.                                                                           |
| S3MigrationAttachEvent                  | INFO     | S3 attach migration.                                                                                 |
| S3MigrationDetachEvent                  | INFO     | S3 detach migration.                                                                                 |
| S3MigrationUpdateEvent                  | INFO     | S3 update migration.                                                                                 |
| S3MultipleContainersStatusInactiveEvent | CRITICAL | Multiple S3 containers become inactive.                                                              |
| S3NotSupportedInMixedVersion            | INFO     | Not supported on mixed version.                                                                      |
| S3NotificationDropped                   | CRITICAL | Some S3 notifications are lost or dropped.                                                           |
| S3NotificationTargetAdded               | INFO     | S3 notification-target added.                                                                        |
| S3NotificationTargetCertificateAdded    | INFO     | S3 notification-target certificate added.                                                            |
| S3NotificationTargetCertificateRemoved  | INFO     | S3 notification-target certificate removed.                                                          |
| S3NotificationTargetRemoved             | INFO     | S3 notification-target removed.                                                                      |
| S3NotificationTargetUpdated             | INFO     | S3 notification-target updated.                                                                      |
| S3OIDCAddedEvent                        | INFO     | The S3 OIDC configuration is added.                                                                  |
| S3OIDCRemovedEvent                      | INFO     | The S3 OIDC configuration is removed.                                                                |
| S3OIDCUpdatedEvent                      | INFO     | The S3 OIDC configuration is updated.                                                                |
| S3ObjectLegalHoldChangedEvent           | INFO     | The legal-hold status of an S3 object version was set.                                               |
| S3ObjectRetentionBypassedEvent          | INFO     | A valid governance retention on an S3 object version was bypassed.                                   |
| S3ObjectRetentionSetEvent               | INFO     | A retention period was set on an S3 object version.                                                  |
| S3RemoveBucketILMRuleEvent              | INFO     | An ILM rule is removed from an S3 bucket.                                                            |
| S3RemoveGroupEvent                      | INFO     | An S3 group is removed.                                                                              |
| S3RemoveIAMPolicyEvent                  | INFO     | An IAM policy is deleted from the system.                                                            |
| S3RemoveServiceAccountEvent             | INFO     | An S3 service account is removed.                                                                    |
| S3ResetBucketILMRuleEvent               | INFO     | All ILM rules for the S3 bucket are removed.                                                         |
| S3SetBucketPolicyEvent                  | INFO     | A bucket policy is set or updated for an S3 bucket.                                                  |
| S3XattrConversionAborted                | INFO     | S3 metadata conversion was aborted by an operator.                                                   |
| S3XattrConversionCompleted              | INFO     | S3 metadata conversion to xattr scheme has completed.                                                |
| S3XattrConversionForceCompleted         | INFO     | S3 metadata conversion was force-completed by an operator.                                           |
| S3XattrConversionStarted                | INFO     | S3 metadata conversion to xattr scheme has started.                                                  |
| SLBContainerStatusActiveEvent           | INFO     | The SLB container is active and operational.                                                         |
| SLBContainerStatusInactiveEvent         | MAJOR    | The SLB container is inactive or stopped.                                                            |
| SLBUpgradeRequiredEvent                 | WARNING  | The cluster software includes a newer S3 load balancer (SLB) version that requires a manual upgrade. |

### Security

| Type                                | Severity | Description                                                        |
| ----------------------------------- | -------- | ------------------------------------------------------------------ |
| BackendJoinTLSVerificationFailure   | MINOR    | Backend attempts to join cluster but fails TLS verification check. |
| BackendNodeJoinSecurityPolicyDenied | WARNING  | Backend join denied due to security policy.                        |
| CaCertSet                           | INFO     | CA certificate added to cluster.                                   |
| CaCertUnset                         | INFO     | CA certificate unset.                                              |
| ClientNodeJoinSecurityPolicyDenied  | WARNING  | Client join denied due to security policy.                         |
| ContainerJoinSecretDenied           | WARNING  | Container fails to rejoin due to missing or incorrect join-secret. |
| FileSystemSecurityPoliciesChange    | INFO     | Filesystem security policies changed.                              |
| JoinSecurityPoliciesUpdated         | INFO     | Join Security Policies for {mode} configuration change             |
| LocalTLSCertAdded                   | INFO     | CertificateChange configuration change                             |
| LocalTLSCertRemoved                 | INFO     | CertificateChange configuration change                             |
| LocalTLSCertUpdated                 | INFO     | CertificateChange configuration change                             |
| MountAccessDenied                   | WARNING  | Mount access denied                                                |
| MountSecurityPolicyAllowed          | INFO     | Mount access allowed by security policy.                           |
| MountSecurityPolicyDenied           | WARNING  | Mount Access denied by security policy.                            |
| SecurityPolicyAccessDenied          | WARNING  | Access denied due to security policy.                              |
| SecurityPolicyCreated               | INFO     | Security policy configuration change                               |
| SecurityPolicyDeleted               | INFO     | Security policy configuration change                               |
| SecurityPolicyUpdated               | INFO     | Security policy configuration change                               |
| TLSSet                              | INFO     | TLS set.                                                           |
| TLSStrictnessUpdated                | INFO     | TLS strictness updated.                                            |
| TLSUnset                            | INFO     | TLS unset.                                                         |
| TenantSecurityPoliciesChanged       | INFO     | Tenant security policies updated.                                  |
| TenantTokensRevoked                 | INFO     | Tenant API tokens revoked.                                         |
| TokenTimeoutsChange                 | INFO     | Token timeouts for authentication updated.                         |

### Smb

| Type                               | Severity | Description                                                            |
| ---------------------------------- | -------- | ---------------------------------------------------------------------- |
| SmbAdJoined                        | INFO     | Active Directory configuration change                                  |
| SmbAdLeft                          | INFO     | Active Directory configuration change                                  |
| SmbClusterConfigured               | INFO     | SMB cluster configuration change                                       |
| SmbClusterCreateCreated            | INFO     | SMB cluster configuration change                                       |
| SmbClusterDestroyed                | INFO     | SMB cluster configuration change                                       |
| SmbConfigGenerationUpdated         | INFO     | SMB Config configuration change                                        |
| SmbLDAPAdded                       | INFO     | LdapDomain configuration change                                        |
| SmbLDAPRemoved                     | INFO     | LdapDomain configuration change                                        |
| SmbLDAPUpdated                     | INFO     | LdapDomain configuration change                                        |
| SmbPostUpgradeReloadFailed         | WARNING  | SMB post-upgrade reload failed.                                        |
| SmbPostUpgradeReloadNotReadyInTime | WARNING  | SMB cluster did not reach readiness in time after post-upgrade reload. |
| SmbShareAdded                      | INFO     | Share configuration change                                             |
| SmbShareConfigured                 | INFO     | Share configuration change                                             |
| SmbShareHostnameACERemovedRemoved  | INFO     | SambaHostnameACE configuration change                                  |
| SmbShareHostnameACEResetDestroyed  | INFO     | SambaHostnameACE configuration change                                  |
| SmbShareRemoved                    | INFO     | Share configuration change                                             |
| SmbTrustedDomainAdded              | INFO     | TrustedDomain configuration change                                     |
| SmbTrustedDomainRemoved            | INFO     | TrustedDomain configuration change                                     |

### Statistics

| Type              | Severity | Description                       |
| ----------------- | -------- | --------------------------------- |
| StatLimitExceeded | WARNING  | Set limit on statistics exceeded. |

### System

| Type                               | Severity | Description                                                                              |
| ---------------------------------- | -------- | ---------------------------------------------------------------------------------------- |
| BlockTaskAborted                   | INFO     | Bucket task aborted successfully.                                                        |
| BlockTaskComplete                  | INFO     | Bucket task completes successfully.                                                      |
| BucketsCreated                     | INFO     | System creates buckets.                                                                  |
| ClusterTaskAborted                 | INFO     | Cluster task aborted                                                                     |
| ClusterTaskAborting                | INFO     | Cluster task started aborting                                                            |
| ClusterTaskPaused                  | INFO     | Cluster task paused                                                                      |
| ClusterTaskResumed                 | INFO     | Cluster task resumed                                                                     |
| ClusterTasksCpuLimitUpdated        | INFO     | Cluster tasks CPU limit set.                                                             |
| ClusterwideTaskChanged             | DEBUG    | Cluster-wide task changed.                                                               |
| DSAsyncDeleteConfigUpdated         | INFO     | Data service async-delete config changed                                                 |
| DataServiceLogWriterFlushFailed    | MAJOR    | Data service log writer flush failed                                                     |
| DataServiceTaskFailedWithError     | MINOR    | Data service task fails.                                                                 |
| DataServiceTaskWaitingForChildTask | INFO     | Data service task waiting.                                                               |
| DsShardViewChanged                 | INFO     | Change in data service shard view.                                                       |
| GcHighExecutionTime                | MINOR    | GC execution time percent of total time is too high.                                     |
| GcTooManyScans                     | MINOR    | Too many GC scans in a short period.                                                     |
| GcTopAllocationSite                | INFO     | The garbage collector allocation histogram reported one of its largest allocation sites. |
| HardwareCriticalLog                | MINOR    | Hardware Critical Log                                                                    |
| HardwareInfoLog                    | INFO     | Hardware Info Log                                                                        |
| HardwareWarningLog                 | WARNING  | Hardware Warning Log                                                                     |
| HaveEnoughSSDCapacity              | MINOR    | Sufficient SSD capacity available for all provisioned filesystems.                       |
| HostScanDrivesFailed               | MAJOR    | Call to host\_scan\_drives failed.                                                       |
| IOStarted                          | INFO     | System starts.                                                                           |
| IOStopped                          | INFO     | System stops.                                                                            |
| LeaderFailedToReachBaseline        | CRITICAL | Reports from too many processes fail to reach newly elected cluster leader in time.      |
| NotEnoughSSDCapacity               | CRITICAL | Insufficient SSD capacity for all provisioned filesystems.                               |
| OOMLog                             | MAJOR    | OOM killer has been triggered                                                            |
| QOSConfigReset                     | INFO     | QoS configuration reset                                                                  |
| QOSConfigSet                       | INFO     | QoS configuration set                                                                    |
| S3ILMTaskManagerConfigUpdated      | INFO     | S3 ILM task manager config changed.                                                      |
| SleepyDeusExFiber                  | MAJOR    | Deus-ex worker fiber is sleepy; deadlock likely.                                         |
| StartIORequested                   | INFO     | User requests to start IO.                                                               |
| StopIORequested                    | INFO     | User requests to stop IO.                                                                |
| ThreadPoolCanNotStartThread        | MINOR    | Reactor's thread pool fails to start thread.                                             |
| TooManyFibers                      | MINOR    | Too many fiber allocations.                                                              |
| WekanodeCrashEvent                 | WARNING  | Wekanode process crashed, reporting crash info.                                          |

### Telemetry

| Type                               | Severity | Description                             |
| ---------------------------------- | -------- | --------------------------------------- |
| AuditTracesStatusChange            | INFO     | Audit traces status changed.            |
| TelemetryExportAdded               | INFO     | Telemetry Export configuration change   |
| TelemetryExportDisabled            | INFO     | Telemetry export disabled.              |
| TelemetryExportEnabled             | INFO     | Telemetry export enabled.               |
| TelemetryExportRemoved             | INFO     | Telemetry Export configuration change   |
| TelemetryExportUpdated             | INFO     | Telemetry Export configuration change   |
| TelemetrySourcesAttachedToExport   | INFO     | Telemetry Sources Attached To Export    |
| TelemetrySourcesDetachedFromExport | INFO     | Telemetry sources detached from export. |

### Tenant

| Type                       | Severity | Description                                           |
| -------------------------- | -------- | ----------------------------------------------------- |
| TenantClientClockSkew      | WARNING  | Clock skew was detected on a tenant's client machine. |
| TenantCreated              | INFO     | Tenant created.                                       |
| TenantDeleted              | INFO     | Tenant deleted.                                       |
| TenantNetworkSpaceAttached | INFO     | Network space attached to tenant.                     |
| TenantNetworkSpaceDetached | INFO     | Network space detached from tenant.                   |
| TenantQOSChanged           | INFO     | Tenant's quality of service terms have changed.       |
| TenantRenamed              | INFO     | Tenant renamed.                                       |
| TenantSsdQuotaChanged      | INFO     | Tenant's SSD quota changed.                           |
| TenantTotalQuotaChanged    | INFO     | Tenant's total quota changed.                         |

### Traces

| Type                               | Severity | Description                                  |
| ---------------------------------- | -------- | -------------------------------------------- |
| RemoteTraceStreamerEndpointInvalid | INFO     | Invalid remote trace streamer endpoint.      |
| RemoteTracesDisabled               | INFO     | Remote traces disabled.                      |
| RemoteTracesEnabled                | INFO     | Remote traces enabled.                       |
| TracesConfigurationActivated       | INFO     | Traces configuration change                  |
| TracesConfigurationDeactivated     | INFO     | Traces configuration change                  |
| TracesConfigurationReset           | INFO     | Traces configuration change                  |
| TracesConfigurationUpdated         | INFO     | Traces configuration change                  |
| TracesFreezeOnEventOfInterest      | MAJOR    | Traces frozen on event of interest.          |
| TracesFreezePeriodReset            | INFO     | Traces freeze period reset.                  |
| TracesFreezePeriodSet              | INFO     | Traces freeze period set.                    |
| TracesVerbosityLevelChange         | MAJOR    | The Traces Verbosity level has been modified |

### Upgrade

| Type                         | Severity | Description                                              |
| ---------------------------- | -------- | -------------------------------------------------------- |
| CleanupUpgradePhaseSkipped   | MAJOR    | Skips cleanup in upgrade phase: {currentPhase}.          |
| ClientUpgradeRequested       | INFO     | Client upgrade requested.                                |
| ComputeUpgradeFinished       | INFO     | Compute containers upgrade finished.                     |
| ComputeUpgradeInvoked        | INFO     | Compute containers upgrade invoked.                      |
| ComputeUpgradeStarted        | INFO     | Compute containers upgrade started.                      |
| ContainerUpgradeFailed       | MAJOR    | Container upgrade fails.                                 |
| ContainerUpgradeFinished     | INFO     | Container upgrade finished.                              |
| ContainerUpgradeStarted      | INFO     | Container upgrade started.                               |
| DataservUpgradeFinished      | INFO     | Dataserv containers upgrade finished.                    |
| DataservUpgradeStarted       | INFO     | Dataserv containers upgrade started.                     |
| DrivesUpgradeFinished        | INFO     | Drives containers upgrade finished.                      |
| DrivesUpgradeStarted         | INFO     | Drives containers upgrade started.                       |
| EventGeneratorTestWithReport | INFO     | An event for the Event Generator Utility, with reporting |
| FailureDomainUpgradeStarted  | INFO     | Starts to upgrade containers of failure domain.          |
| FrontendUpgradeFinished      | INFO     | Frontend containers upgrade finished.                    |
| FrontendUpgradeStarted       | INFO     | Frontend containers upgrade started.                     |
| TargetVersionChange          | DEBUG    | Target version changed.                                  |
| UpgradePaused                | INFO     | Upgrade paused.                                          |
| UpgradeResumed               | INFO     | Upgrade resumed.                                         |
| UpgradeStateChange           | DEBUG    | Upgrade state changed.                                   |
| UpgradeStatusChange          | DEBUG    | Upgrade status has changed.                              |
| WekaVersionDowngraded        | WARNING  | The cluster is running a lower version.                  |

### User

| Type                             | Severity | Description                                  |
| -------------------------------- | -------- | -------------------------------------------- |
| GuiIdleTimeoutChanged            | INFO     | GUI idle timeout changed                     |
| LDAPAuthDisabled                 | INFO     | LDAP authentication disabled                 |
| LDAPAuthEnabled                  | INFO     | LDAP authentication enabled                  |
| LDAPConfigUpdated                | INFO     | LDAP configuration updated                   |
| LdapS3AuthFailed                 | MAJOR    | LDAP S3 authentication failed                |
| LdapS3UserCreated                | INFO     | LDAP S3 user created                         |
| LdapS3UserDeleted                | INFO     | LDAP S3 user deleted                         |
| LdapS3UserUpdated                | INFO     | LDAP S3 user updated                         |
| UserCreated                      | INFO     | The user is created.                         |
| UserDeleted                      | INFO     | The user is deleted.                         |
| UserLoggedIn                     | INFO     | User logged in                               |
| UserLoginFailed                  | INFO     | User login failed                            |
| UserLoginLocked                  | MINOR    | User login locked                            |
| UserPasswordChanged              | INFO     | The user changed the password.               |
| UserPasswordChangedByAnotherUser | INFO     | The administrator changed the user password. |
| UserRoleChanged                  | INFO     | The user role is changed.                    |
