|Type                             | Category       | Severity | Description                                                                                                     |
|-|-|-|-|
|DisksRecoveryDetected            | Raid           | INFO     | Disk(s) quick recovery detected                                                                                 |
|InterfaceGroupPortDeleted        | InterfaceGroup | INFO     | Interface group port configuration change                                                                       |
|HotSpareFailureDomainsUpdated    | Raid           | INFO     | Hot spare updated                                                                                               |
|HostAdding                       | Clustering     | INFO     | Host configuration change                                                                                       |
|DriveUnderIOMMU                  | Drive          | CRITICAL | Drive is under IOMMU and cannot be used                                                                         |
|HostRemovingFailed               | Clustering     | INFO     | Host configuration change                                                                                       |
|InterfaceGroupIpsAdded           | InterfaceGroup | INFO     | Interface group IPs configuration change                                                                        |
|ClusteringFailure                | Clustering     | MINOR    | Failing clustering a node                                                                                       |
|DriveUnresponsive                | Drive          | MAJOR    | Drive {driveId} is unresponsive, did not return IOs for an extended time, consider power cycling the host       |
|DriveScanBlockLifted             | Drive          | MINOR    | Drive blocked during scan and is now responsive                                                                 |
|NoConnectivityToLivingNode       | Network        | MAJOR    | Node is disconnected from living peer(s)                                                                        |
|StopIORequested                  | System         | INFO     | The user has requested that IO be stopped                                                                       |
|NfsClientGroupRuleAdded          | NFS            | INFO     | NFS client group rule configuration change                                                                      |
|RejoinFailureReport              | Clustering     | MINOR    | Node(s) failed to rejoin                                                                                        |
|FilesystemGroupAdded             | Filesystem     | INFO     | Filesystem group configuration change                                                                           |
|ObjectStorageAdded               | ObjectStorage  | INFO     | Object storage configuration change                                                                             |
|DriveExcessiveErrors             | Drive          | WARNING  | Drive has excessive error rate, the drive will be phased out and requires a support call for a bad drive issue  |
|HaveEnoughSSDCapacity            | System         | MINOR    | Enough SSD capacity now exists for all provisioned file systems                                                 |
|NodeHasNetDevicesWithDifferentNu | Network        | WARNING  | Multiple net devices different numas performance warning                                                        |
|NetDeviceLinkDown                | Network        | MAJOR    | Network interface DOWN                                                                                          |
|ObjectStorageDeleted             | ObjectStorage  | INFO     | Object storage configuration change                                                                             |
|ClientDisconnected               | Clustering     | INFO     | Client disconnected                                                                                             |
|CloudEnabled                     | Cloud          | INFO     | Cloud enabled                                                                                                   |
|DedupEventsDiscarded             | Events         | WARNING  | Deduplicated events discarded                                                                                   |
|ClientRemoved                    | Clustering     | INFO     | Disconnected client is being removed from the cluster                                                           |
|SnapshotUploadStarted            | Filesystem     | INFO     | Snapshot upload started                                                                                         |
|NfsExportsPermissionsDeleted     | NFS            | INFO     | NFS export permissions for configuration change                                                                 |
|HostRemoved                      | Clustering     | INFO     | Host configuration change                                                                                       |
|NfsMountFail                     | NFS            | WARNING  | NFS mount request failed                                                                                        |
|ExternalUpgradeStarting          | Upgrade        | INFO     | External Upgrade was started                                                                                    |
|NodeCannotJoinCluster            | Network        | WARNING  | Node cannot join cluster for too long                                                                           |
|NfsPortmapFail                   | NFS            | MAJOR    | NFS server failed to register in portmap                                                                        |
|DriveMediumError                 | Drive          | MAJOR    | Drive had a Medium Error                                                                                        |
|UserAdded                        | User           | INFO     | User configuration change                                                                                       |
|FilesystemGroupUpdated           | Filesystem     | INFO     | Filesystem group configuration change                                                                           |
|CloudDisabled                    | Cloud          | INFO     | Cloud disabled                                                                                                  |
|HostPrepareUpgradeFailed         | Upgrade        | MAJOR    | Host failed to prepare for upgrade                                                                              |
|DriveStateChangesReport          | Drive          | MINOR    | Drive state changes                                                                                             |
|DriveWrongFailureDomain          | Drive          | MINOR    | Drive is attached to a host from a wrong failure domain                                                         |
|NodeStopped                      | Node           | INFO     | Node stopped                                                                                                    |
|UserLoggedIn                     | User           | INFO     | User logged in                                                                                                  |
|StartingExternalHostUpgrade      | Upgrade        | INFO     | Starting host upgrade                                                                                           |
|StartIONodeNotUp                 | Clustering     | MAJOR    | Node has not joined the cluster during Start-IO                                                                 |
|NodeRemoved                      | Clustering     | MAJOR    | Node removed from cluster (failed)                                                                              |
|FilesystemAdded                  | Filesystem     | INFO     | Filesystem configuration change                                                                                 |
|FilesystemDeleted                | Filesystem     | INFO     | Filesystem configuration change                                                                                 |
|IPConflictDetected               | Network        | MAJOR    | IP conflict detected                                                                                            |
|NfsClientGroupAdded              | NFS            | INFO     | NFS client group configuration change                                                                           |
|DefaultDataNetworkingChange      | Network        | INFO     | Default data networking configuration changed                                                                   |
|LDAPConfigUpdated                | User           | INFO     | LDAP configuration updated                                                                                      |
|AlertUnmuted                     | Alerts         | INFO     | Alert unmuted                                                                                                   |
|HostActivated                    | Clustering     | INFO     | Host configuration change                                                                                       |
|ObjectStorageStatusChanged       | ObjectStorage  | INFO     | Object Storage status changed.                                                                                  |
|HostDeactivating                 | Clustering     | INFO     | Host configuration change                                                                                       |
|NfsExportsPermissionsAdded       | NFS            | INFO     | NFS export permissions for configuration change                                                                 |
|SnapshotUploadAborted            | Filesystem     | INFO     | Snapshot upload aborted                                                                                         |
|CloudSetUploadRate               | Cloud          | INFO     | Cloud upload rate changed                                                                                       |
|FilesystemDownloadStarted        | Filesystem     | INFO     | Filesystem download started                                                                                     |
|FilesystemUpdated                | Filesystem     | INFO     | Filesystem configuration change                                                                                 |
|FailedToLoadDriver               | Node           | CRITICAL | Failed to load the wekafs drvier                                                                                |
|UserPasswordChangedByAnotherUser | User           | INFO     | User password changed by an admin                                                                               |
|DriveRemoved                     | Drive          | INFO     | Drive removed                                                                                                   |
|NetDeviceLinkUp                  | Network        | MINOR    | Network interface UP                                                                                            |
|LDAPAuthEnabled                  | User           | INFO     | LDAP authentication enabled                                                                                     |
|DriveScanBlocked                 | Drive          | MINOR    | Drive blocked during scan and is unresponsive                                                                   |
|DriveSignatureUnknown            | Drive          | MINOR    | Drive has an unknown signature                                                                                  |
|ClientFailedAutoUpgrade          | Upgrade        | WARNING  | Node failed auto-upgrade                                                                                        |
|ExternalUpgradeCancelled         | Upgrade        | INFO     | External Upgrade was cancelled                                                                                  |
|UserDeleted                      | User           | INFO     | User configuration change                                                                                       |
|LDAPAuthDisabled                 | User           | INFO     | LDAP authentication disabled                                                                                    |
|HostUpgradeFailed                | Upgrade        | MAJOR    | Host failed to upgrade                                                                                          |
|InterfaceGroupUpdated            | InterfaceGroup | INFO     | Interface group configuration change                                                                            |
|TooFewActiveFailureDomains       | Raid           | CRITICAL | Too few active failure domains                                                                                  |
|InterfaceGroupDeleted            | InterfaceGroup | INFO     | Interface group configuration change                                                                            |
|ClientAttemptingAutoUpgrade      | Upgrade        | INFO     | Node is attempting to auto-upgrade in order to join cluster                                                     |
|IONodeCannotFetchConfig          | Network        | WARNING  | Node cannot join cluster for too long                                                                           |
|ObjectStorageIsFull              | ObjectStorage  | CRITICAL | Object Storage reports that its full.                                                                           |
|NetDeviceWithNumaFittingNodeCore | Network        | WARNING  | Cannot find net device with numa to match cores performance warning                                             |
|PaygLicensingEnabled             | Licensing      | INFO     | PAYG licensing enabled                                                                                          |
|RaidScrubbingRateUpdated         | Raid           | INFO     | RAID scrubber limit updated                                                                                     |
|AlertMuted                       | Alerts         | INFO     | Alert muted                                                                                                     |
|FinishedExternalHostUpgrade      | Upgrade        | INFO     | Finished host upgrade                                                                                           |
|HostUpgradeStarted               | Upgrade        | INFO     | Host started upgrade                                                                                            |
|SnapshotDownloadStarted          | Filesystem     | INFO     | Snapshot download started                                                                                       |
|CongestionEnded                  | Filesystem     | INFO     | Congestion ended                                                                                                |
|DriveInitFailed                  | Drive          | CRITICAL | Drive has failed to initialize                                                                                  |
|HostDeactivated                  | Clustering     | INFO     | Host configuration change                                                                                       |
|LicensingReset                   | Licensing      | INFO     | Licensing state has been reset                                                                                  |
|InterfaceGroupPortAdded          | InterfaceGroup | INFO     | Interface group port configuration change                                                                       |
|DataProtectionLevelDecreased     | Raid           | CRITICAL | Data protection level decreased                                                                                 |
|EnoughActiveFailureDomains       | Raid           | MINOR    | Enough active failure domains                                                                                   |
|ObjectStorageUpdated             | ObjectStorage  | INFO     | Object storage configuration change                                                                             |
|NfsClientGroupRuleDeleted        | NFS            | INFO     | NFS client group rule configuration change                                                                      |
|HostRemoving                     | Clustering     | INFO     | Host configuration change                                                                                       |
|NfsExportsPermissionsUpdated     | NFS            | INFO     | NFS export permissions for configuration change                                                                 |
|HostUpgradeDone                  | Upgrade        | INFO     | Host finished upgrade                                                                                           |
|NodeRejoined                     | Clustering     | INFO     | Node rejoined the cluster                                                                                       |
|UserPasswordChanged              | User           | INFO     | User changed password                                                                                           |
|InterfaceGroupAdded              | InterfaceGroup | INFO     | Interface group configuration change                                                                            |
|CongestionStarted                | Filesystem     | WARNING  | Congestion started                                                                                              |
|NodeStarted                      | Node           | INFO     | Node started                                                                                                    |
|InterfaceGroupIpsDeleted         | InterfaceGroup | INFO     | Interface group IPs configuration change                                                                        |
|ExternalUpgradeFinished          | Upgrade        | INFO     | External Upgrade has finished                                                                                   |
|NewLicenseInstalled              | Licensing      | INFO     | New license installed                                                                                           |
|DriveNvmeSmartChange             | Drive          | MINOR    | NVMe Drive SMART status changed                                                                                 |
|StartIORequested                 | System         | INFO     | The user has requested that IO be started                                                                       |
|DriveDeactivated                 | Drive          | INFO     | Drive deactivated                                                                                               |
|NetworkPortConfigFail            | Network        | MINOR    | Failure to configure network port                                                                               |
|CorruptedDrive                   | Drive          | CRITICAL | Drive has a valid header but was detected as corrupt                                                            |
|DataProtectionLevelIncreased     | Raid           | CRITICAL | Data protection level increased                                                                                 |
|UserLoginFailed                  | User           | INFO     | User login failed                                                                                               |
|MgmtNodeCannotFetchConfig        | Network        | WARNING  | Node cannot join cluster for too long                                                                           |
|IOStarted                        | System         | INFO     | System has started                                                                                              |
|EventsDedupReport                | Events         | INFO     | Event deduplication ended                                                                                       |
|DriveProvisioned                 | Drive          | INFO     | Drive provisioned                                                                                               |
|HostAdded                        | Clustering     | INFO     | Host configuration change                                                                                       |
|IOStopped                        | System         | INFO     | System has stopped                                                                                              |
|DriveIoError                     | Drive          | MAJOR    | Drive had an IO Error                                                                                           |
|DriveActivated                   | Drive          | INFO     | Drive activated                                                                                                 |
|DisksFailureDetected             | Raid           | MAJOR    | Disk(s) failures detected                                                                                       |
|TieredFilesystemBreakingPolicy   | ObjectStorage  | MINOR    | Breaking policy, too much disk pressure                                                                         |
|ExtremeCongestionStarted         | Filesystem     | WARNING  | Extreme congestion started                                                                                      |
|ClientConnected                  | Clustering     | INFO     | Client connected                                                                                                |
|CloudCredentialsManualSetup      | Cloud          | INFO     | Cloud credentials manually set                                                                                  |
|NfsClientGroupDeleted            | NFS            | INFO     | NFS client group configuration change                                                                           |
|NotEnoughSSDCapacity             | System         | CRITICAL | Not enough SSD capacity exists for all provisioned file systems                                                 |
|HardwareFailure                  | Network        | CRITICAL | Hardware failure                                                                                                |
|FilesystemGroupDeleted           | Filesystem     | INFO     | Filesystem group configuration change                                                                           |
|ExtremeCongestionEnded           | Filesystem     | INFO     | Extreme congestion ended                                                                                        |
|CloudCredentialsRefreshed        | Cloud          | INFO     | Cloud credentials refreshed                                                                                     |
|DiagsUploaded                    | Cloud          | INFO     | Diags uploaded                                                                                                  |
|NvmeBindTimingOut                | Drive          | CRITICAL | NVMe device bind is stuck, server needs power cycle to recover                                                  |
