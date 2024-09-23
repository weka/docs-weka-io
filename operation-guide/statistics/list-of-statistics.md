---
description: Explore the statistics the WEKA system generates organized by categories.
---

# List of statistics

### Assert failures

| **Type**                                          | **Description**                                                       | **Units**          |
| ------------------------------------------------- | --------------------------------------------------------------------- | ------------------ |
| ASSERTION\_FAILURES\_IGNORE                       | Assertion failures count with "IGNORE" behavior                       | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_BUCKET                 | Assertion failures count with "KILL\_BUCKET" behavior                 | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_FIBER                  | Assertion failures count with "KILL\_FIBER" behavior                  | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_NODE\_WITH\_CORE\_DUMP | Assertion failures count with "KILL\_NODE\_WITH\_CORE\_DUMP" behavior | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_NODE                   | Assertion failures count with "KILL\_NODE" behavior                   | Assertion failures |
| ASSERTION\_FAILURES\_STALL\_AND\_KILL\_NODE       | Assertion failures count with "STALL\_AND\_KILL\_NODE" behavior       | Assertion failures |
| ASSERTION\_FAILURES\_STALL                        | Assertion failures count with "STALL" behavior                        | Assertion failures |
| ASSERTION\_FAILURES\_THROW\_EXCEPTION             | Assertion failures count with "THROW\_EXCEPTION" behavior             | Assertion failures |
| ASSERTION\_FAILURES                               | Assertion failures count of all available types                       | Assertion failures |

### Attribute Cache

| **Type**                 | **Description**                                           | **Units** |
| ------------------------ | --------------------------------------------------------- | --------- |
| GP\_GETATTR\_CACHE\_MISS | Number of general purpose getAttr cache misses per second | Ops/Sec   |
| GP\_GETATTR              | Number of general purpose getAttr calls per second        | Ops/Sec   |

### Block Cache

| **Type**                             | **Description**                            | **Units** |
| ------------------------------------ | ------------------------------------------ | --------- |
| BUCKET\_CACHED\_METADATA\_BLOCKS     | Bucket number of cached metadata blocks    | Blocks    |
| BUCKET\_CACHED\_REGISTRY\_L2\_BLOCKS | Bucket number of cached registry L2 blocks | Blocks    |
| BUCKET\_CACHE\_METADATA\_HITS        | Bucket block cache metadata hits           | Queries   |
| BUCKET\_CACHE\_METADATA\_MISSES      | Bucket block cache metadata misses         | Queries   |
| BUCKET\_CACHE\_REGISTRY\_L2\_HITS    | Bucket block cache registry L2 hits        | Queries   |
| BUCKET\_CACHE\_REGISTRY\_L2\_MISSES  | Bucket block cache registry L2 misses      | Queries   |
| BUCKET\_REGISTRY\_L2\_BLOCKS\_NUM    | Bucket number of registry L2 blocks        | Blocks    |

### Block Writes

| **Type**               | **Description**                | **Units** |
| ---------------------- | ------------------------------ | --------- |
| BLOCK\_FULL\_WRITES    | Number of full block writes    | Writes    |
| BLOCK\_PARTIAL\_WRITES | Number of partial block writes | Writes    |

### Bucket

| **Type**                                                          | **Description**                                                                                         | **Units**    |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------ |
| BUCKET\_START\_TIME                                               | Duration of bucket activation on step up                                                                | Startups     |
| CHOKING\_LEVEL\_ALL                                               | Throttling level applied on all types of IOs                                                            | %            |
| CHOKING\_LEVEL\_NON\_MUTATING                                     | Throttling level applied on non-mutating only types of IOs                                              | %            |
| COALESCED\_MAY\_CREATE\_EXTENT                                    | Number of mayCreateExtent calls coalesced                                                               | Calls        |
| DESTAGED\_BLOCKS\_COUNT                                           | Number of destaged blocks per second                                                                    | Blocks/Sec   |
| DESTAGE\_COUNT                                                    | Number of destages per second                                                                           | Destages/Sec |
| DIR\_MOVE\_TIME                                                   | Time to complete a directory move                                                                       | Ops          |
| EXTENT\_BLOCKS\_COUNT                                             | Difference in number of EXTENT blocks                                                                   | Blocks       |
| EXTENT\_BLOCK\_SEQUENCES                                          | Histogram of number of consecutive sequences of blocks in a single extent                               | Extents      |
| FAIRNESS\_DELAYED\_MAY\_CREATE\_EXTENT                            | Number of mayCreateExtent calls not coalesced to prevent starvation                                     | Calls        |
| FREEABLE\_LRU\_BUFFERS                                            | Number of unused blocks in LRU cache                                                                    | Buffers      |
| HASH\_BLOCKS\_COUNT                                               | Difference in number of HASH blocks                                                                     | Blocks       |
| INODE\_BLOCKS\_COUNT                                              | Difference in number of INODE blocks                                                                    | Blocks       |
| INTEGRITY\_ISSUES                                                 | Number of filesystem integrity issues detected                                                          | Issues       |
| JOURNAL\_BLOCKS\_COUNT                                            | Difference in number of JOURNAL blocks                                                                  | Blocks       |
| ODH\_COLLISIONS\_ACCESS\_CLOCK\_STATES                            | Number of ODH items created with colliding hash in ACCESS\_CLOCK\_STATES ODH                            | Collisions   |
| ODH\_COLLISIONS\_BIG\_BLOB\_MANIFEST                              | Number of ODH items created with colliding hash in BIG\_BLOB\_MANIFEST ODH                              | Collisions   |
| ODH\_COLLISIONS\_DEFAULT\_DIR\_QUOTA                              | Number of ODH items created with colliding hash in DEFAULT\_DIR\_QUOTA ODH                              | Collisions   |
| ODH\_COLLISIONS\_DIRECTORY                                        | Number of ODH items created with colliding hash in DIRECTORY ODH                                        | Collisions   |
| ODH\_COLLISIONS\_DIR\_QUOTA                                       | Number of ODH items created with colliding hash in DIR\_QUOTA ODH                                       | Collisions   |
| ODH\_COLLISIONS\_FLOCK\_EXPIRED\_FRONTENDS                        | Number of ODH items created with colliding hash in FLOCK\_EXPIRED\_FRONTENDS ODH                        | Collisions   |
| ODH\_COLLISIONS\_GRAVEYARD                                        | Number of ODH items created with colliding hash in GRAVEYARD ODH                                        | Collisions   |
| ODH\_COLLISIONS\_INODES\_PENDING\_VALIDATIONS                     | Number of ODH items created with colliding hash in INODES\_PENDING\_VALIDATIONS ODH                     | Collisions   |
| ODH\_COLLISIONS\_INODES\_POTENTIAL\_PENDING\_DELETION             | Number of ODH items created with colliding hash in INODES\_POTENTIAL\_PENDING\_DELETION ODH             | Collisions   |
| ODH\_COLLISIONS\_MODIFY\_CLOCK\_STATES                            | Number of ODH items created with colliding hash in MODIFY\_CLOCK\_STATES ODH                            | Collisions   |
| ODH\_COLLISIONS\_OBS\_IMMEDIATE\_RELEASE                          | Number of ODH items created with colliding hash in OBS\_IMMEDIATE\_RELEASE ODH                          | Collisions   |
| ODH\_COLLISIONS\_OBS\_RECLAMATION                                 | Number of ODH items created with colliding hash in OBS\_RECLAMATION ODH                                 | Collisions   |
| ODH\_COLLISIONS\_REFERENCE\_RELOCATIONS                           | Number of ODH items created with colliding hash in REFERENCE\_RELOCATIONS ODH                           | Collisions   |
| ODH\_COLLISIONS\_SNAPSHOT\_MEMBERS                                | Number of ODH items created with colliding hash in SNAPSHOT\_MEMBERS ODH                                | Collisions   |
| ODH\_COLLISIONS\_SNAP\_LAYER\_CAPACITY                            | Number of ODH items created with colliding hash in SNAP\_LAYER\_CAPACITY ODH                            | Collisions   |
| ODH\_COLLISIONS\_SNAP\_LAYER\_SIZE\_V4\_2                         | Number of ODH items created with colliding hash in SNAP\_LAYER\_SIZE\_V4\_2 ODH                         | Collisions   |
| ODH\_COLLISIONS\_SNAP\_LAYER\_SIZE\_V4\_3                         | Number of ODH items created with colliding hash in SNAP\_LAYER\_SIZE\_V4\_3 ODH                         | Collisions   |
| ODH\_COLLISIONS\_STOW\_DOWNLOAD\_REDISTRIBUTE\_PULL\_STATE\_V4\_3 | Number of ODH items created with colliding hash in STOW\_DOWNLOAD\_REDISTRIBUTE\_PULL\_STATE\_V4\_3 ODH | Collisions   |
| ODH\_COLLISIONS\_STOW\_DOWNLOAD\_REDISTRIBUTE\_V4\_3              | Number of ODH items created with colliding hash in STOW\_DOWNLOAD\_REDISTRIBUTE\_V4\_3 ODH              | Collisions   |
| ODH\_COLLISIONS\_STOW\_UPLOAD\_MANIFEST                           | Number of ODH items created with colliding hash in STOW\_UPLOAD\_MANIFEST ODH                           | Collisions   |
| ODH\_COLLISIONS\_SV\_CAPACITY\_LEADER                             | Number of ODH items created with colliding hash in SV\_CAPACITY\_LEADER ODH                             | Collisions   |
| ODH\_COLLISIONS\_UNLINKED\_INODES                                 | Number of ODH items created with colliding hash in UNLINKED\_INODES ODH                                 | Collisions   |
| ODH\_COLLISIONS                                                   | Number of ODH items created with colliding hash in all ODHs                                             | Collisions   |
| ODL\_BLOCKS\_COUNT                                                | Difference in number of ODL blocks                                                                      | Blocks       |
| ODL\_PAYLOAD\_BLOCKS\_COUNT                                       | Difference in number of ODL\_PAYLOAD blocks                                                             | Blocks       |
| READS                                                             | Number of read operations per second                                                                    | Ops/Sec      |
| READ\_BYTES                                                       | Number of bytes read per second                                                                         | Bytes/Sec    |
| READ\_LATENCY                                                     | Average latency of READ operations                                                                      | Microseconds |
| REGISTRY\_COLLISIONS                                              | Number of registry items created with colliding key                                                     | Collisions   |
| REGISTRY\_L1\_BLOCKS\_COUNT                                       | Difference in number of REGISTRY\_L1 blocks                                                             | Blocks       |
| REGISTRY\_L2\_BLOCKS\_COUNT                                       | Difference in number of REGISTRY\_L2 blocks                                                             | Blocks       |
| REGISTRY\_SEARCHES\_COUNT                                         | Number of registry searches per second                                                                  | Queries/Sec  |
| RESIDENT\_BLOCKS\_COUNT                                           | Number of blocks in resident blocks table                                                               | Blocks       |
| SINGLE\_HOP\_MISMATCH\_RECOVERY                                   | 1HOP prefix mismatch recoveries                                                                         | Issues       |
| SINGLE\_HOP\_RDMA\_MISMATCH\_DPDK\_FALLBACK                       | 1HOP prefix mismatch RDMA fail                                                                          | Issues       |
| SNAPSHOT\_CREATION\_TIME                                          | Time to complete a snapshot creation                                                                    | Snapshots    |
| SPATIAL\_SQUELCH\_BLOCKS\_COUNT                                   | Difference in number of SPATIAL\_SQUELCH blocks                                                         | Blocks       |
| SUCCESSFUL\_DATA\_WEDGINGS                                        | Number of successful attempts to wedge data blocks in journal per second                                | Attempts/Sec |
| SUPERBLOCK\_BLOCKS\_COUNT                                         | Difference in number of SUPERBLOCK blocks                                                               | Blocks       |
| TEMPORAL\_SQUELCH\_BLOCKS\_COUNT                                  | Difference in number of TEMPORAL\_SQUELCH blocks                                                        | Blocks       |
| TRANSIENT\_INTEGRITY\_ISSUES                                      | Number of transient filesystem integrity issues detected                                                | Issues       |
| UNSUCCESSFUL\_DATA\_WEDGINGS                                      | Number of unsuccessful attempts to wedge data blocks in journal per second                              | Attempts/Sec |
| USER\_DATA\_BUFFERS\_IN\_USE                                      | Number of data buffers used for serving ongoing IOs                                                     | Buffers      |
| WRITES                                                            | Number of write operations per second                                                                   | Ops/Sec      |
| WRITE\_BYTES                                                      | Number of byte writes per second                                                                        | Bytes/Sec    |
| WRITE\_LATENCY                                                    | Average latency of WRITE operations                                                                     | Microseconds |

### Bucket Failovers

| **Type**                      | **Description**                                                              | **Units**  |
| ----------------------------- | ---------------------------------------------------------------------------- | ---------- |
| BUCKET\_FAILOVERS             | Number of failovers detected in remote buckets                               | Failovers  |
| REMOTE\_BUCKET\_IS\_SECONDARY | Number of times a remote bucket reported it is secondary and cannot serve us | Exceptions |

### Bucket Rebalances

| **Type**                          | **Description**                                  | **Units**       |
| --------------------------------- | ------------------------------------------------ | --------------- |
| BUCKET\_INITS                     | Number of bucket initializations                 | Times           |
| BUCKET\_INIT\_LATENCY\_HIST       | Duration of bucket initialization                | Initializations |
| BUCKET\_INIT\_LATENCY             | Average latency of bucket initialization         | Seconds         |
| INFORMATIVE\_DENY\_BUCKET\_ACCESS | Number of new-style NotBucketLeaderEx exceptions | Exceptions      |
| LEGACY\_DENY\_BUCKET\_ACCESS      | Number of old-style NotBucketLeader exceptions   | Exceptions      |

### CPU

| **Type**         | **Description**                                       | **Units** |
| ---------------- | ----------------------------------------------------- | --------- |
| CPU\_UTILIZATION | The percentage of the CPU time used for handling I/Os | %         |

### Choking

| **Type**                      | **Description**                                                              | **Units** |
| ----------------------------- | ---------------------------------------------------------------------------- | --------- |
| CHOKING\_LEVEL\_ALL           | Throttling level applied on all types of IOs, both mutating and non-mutating | Processes |
| CHOKING\_LEVEL\_NON\_MUTATING | Throttling level applied on non-mutating only types of IOs                   | Processes |

### Clients

| **Type**              | **Description**                                                                 | **Units**   |
| --------------------- | ------------------------------------------------------------------------------- | ----------- |
| CLIENTS\_CONNECTED    | Clients connected                                                               | Clients/Sec |
| CLIENTS\_DISCONNECTED | The number of clients left or removed                                           | Clients/Sec |
| CLIENTS\_LEFT         | The number of clients left                                                      | Clients/Sec |
| CLIENTS\_RECONNECTED  | The number of clients reconnected instead of their previous connection instance | Clients/Sec |
| CLIENTS\_REMOVED      | The number of clients removed                                                   | Clients/Sec |

### Config

| **Type**                                 | **Description**                                                     | **Units**            |
| ---------------------------------------- | ------------------------------------------------------------------- | -------------------- |
| AVERAGE\_CHANGES\_IN\_CHANGESET          | The average number of changes in a changeset                        | Changes/Sec          |
| AVERAGE\_CHANGES\_IN\_GENERATION         | The average number of changes in generation                         | Changes/Sec          |
| BACKEND\_NODE\_REJOIN\_TIME              | The number of backend rejoin attempts per completion time range     | Number of rejoins    |
| CHANGESET\_COMMIT\_LATENCY               | The average latency of committing a configuration changeset         | Microseconds         |
| CLIENT\_NODE\_REJOIN\_TIME               | The number of client rejoin attempts per completion time range      | Number of rejoins    |
| CONFIG\_PROPAGATION\_LATENCY             | The latencies of propagation of a configuration generation          | Generation           |
| GENERATION\_COMMIT\_LATENCY              | The average latency of committing a configuration generation        | Microseconds         |
| HEARTBEAT\_PROCESSING\_TIME\_OLD         | The number of non-leader heartbeats per processing time range (OLD) | Number of heartbeats |
| HEARTBEAT\_PROCESSING\_TIME              | The number of non-leader heartbeats per processing time range       | Number of heartbeats |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME\_OLD | The number of leader heartbeats per processing time range (OLD)     | Number of heartbeats |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME      | The number of leader heartbeats per processing time range           | Number of heartbeats |
| OVERLAY\_FULL\_SHIFTS                    | The number of full overlay shifts                                   | Changes              |
| OVERLAY\_INCREMENTAL\_SHIFTS             | The number of incremental overlay shifts                            | Changes              |
| OVERLAY\_TRACKER\_INCREMENTALS           | The number of incremental OverlayTracker applications               | Changes              |
| OVERLAY\_TRACKER\_RESYNCS                | The number of OverlayTracker full-resyncs                           | Changes              |
| TOTAL\_CHANGESETS\_COMMITTED             | The total number of committed changesets                            | Change Sets          |
| TOTAL\_COMMITTED\_CHANGES                | The total number of committed configuration changes                 | Changes              |
| TOTAL\_GENERATIONS\_COMMITTED            | The number of committed generations per second                      | Generations          |

### Data Reduction

| **Type**                            | **Description**                                                                                    | **Units**    |
| ----------------------------------- | -------------------------------------------------------------------------------------------------- | ------------ |
| ACCEPTED\_SEGMENTS                  | Number of blocks accepted for clusterization                                                       | Blocks/Sec   |
| AVG\_DELTAS                         | Average deltas per reference during ingestion (excluding history)                                  | deltas/ref   |
| CLUSTERIZE\_CALLS                   | Clusterize Calls                                                                                   | Calls/Sec    |
| CLUSTERIZE\_TIME                    | Average time to clusterize                                                                         | Milliseconds |
| COMPRESSED\_DELTA\_SIZE             | Average size of new compressed delta segments                                                      | Bytes        |
| COMPRESSED\_NON\_DELTA\_SIZE        | Average size of new compressed non-delta segments                                                  | Bytes        |
| COMPRESSED\_SELF\_DELTA\_SIZE       | Average self-compress size of new delta segments                                                   | Bytes        |
| COMPRESSED\_SIZE                    | Average size of new compressed segments                                                            | Bytes        |
| COMPRESS\_TASK\_CALLS               | Compress Task Calls                                                                                | Calls/Sec    |
| COMPRESS\_TASK\_TIME                | Average time to complete compress task                                                             | Milliseconds |
| CROSS\_BLOCKS\_READ\_ERRS           | Number of failed reads due to wrong crossBlocks flag                                               | Reads/Sec    |
| DELTAS\_COMPLETE\_RELOCS            | Number of delta blocks notified about a relocation of both delta and ref segments at the same time | Blocks/Sec   |
| DELTAS\_GC                          | Number of delta blocks removed by GC                                                               | Blocks/Sec   |
| DELTAS\_REF\_RELOCS                 | Number of delta blocks notified about reference relocations                                        | Blocks/Sec   |
| DELTA\_BACKPTR\_COLLISIONS          | Number of times delta blocks with the same backptr were encountered during GC                      | Blocks/Sec   |
| DELTA\_PROMOTES                     | Number of delta blocks promoted by GC                                                              | Blocks/Sec   |
| DELTA\_RELOCS                       | Number of delta blocks relocated by GC                                                             | Blocks/Sec   |
| DELTA\_REMOVAL\_BACKPTR\_COLLISIONS | Number of times delta blocks with the same backptr were encountered during deletions flush         | Blocks/Sec   |
| DROPPED\_SEGMENTS                   | Number of blocks dropped during clusterization                                                     | Blocks/Sec   |
| GC\_PROMOTIONS                      | Number of times data was rewritten to a next GC tree level                                         | Blocks/Sec   |
| HISTORY\_READ\_ERRS                 | Number of failed reference reads from history                                                      | Reads/Sec    |
| INGEST\_START\_CALLS                | Ingest Start Calls                                                                                 | Calls/Sec    |
| INGEST\_START\_TIME                 | Average time to start ingest                                                                       | Milliseconds |
| NEW\_DELTAS\_FROM\_HISTORY          | Number of new delta blocks created with references from history                                    | Blocks/Sec   |
| NEW\_DELTAS\_FROM\_INGEST           | Number of new delta blocks created with references from same ingest batch                          | Blocks/Sec   |
| NEW\_DELTAS                         | Number of new delta blocks created                                                                 | Blocks       |
| NEW\_ETERNAL\_SINGLES               | Number of new eternal single blocks created                                                        | Blocks/Sec   |
| NEW\_INCOMPRESSIBLE\_DELTAS         | Number of new incompressible delta segments ingested                                               | Blocks/Sec   |
| NEW\_INCOMPRESSIBLE\_NON\_DELTAS    | Number of new incompressible non-delta segments ingested                                           | Blocks/Sec   |
| NEW\_INGESTED                       | Ingested Blocks                                                                                    | Blocks       |
| NEW\_NON\_DELTAS                    | Number of new non-delta blocks created                                                             | Blocks       |
| NEW\_REFERENCES                     | Number of new reference blocks created                                                             | Blocks/Sec   |
| NEW\_SINGLES                        | Number of new (non-eternal) single blocks created                                                  | Blocks/Sec   |
| REFERENCE\_GC                       | Number of reference blocks removed by GC                                                           | Blocks/Sec   |
| REFERENCE\_PROMOTES                 | Number of reference blocks promoted by GC                                                          | Blocks/Sec   |
| REFERENCE\_RELOCS                   | Number of reference blocks relocated by GC                                                         | Blocks/Sec   |
| REF\_BACKPTR\_COLLISIONS            | Number of times blocks with the same reference-backptr were encountered during GC                  | Blocks/Sec   |
| SEGMENT\_PROMOTES                   | Promoted Compressed Blocks                                                                         | Blocks       |
| SEGMENT\_RELOCS                     | Relocated Compressed Blocks                                                                        | Blocks       |
| SINGLES\_MARKED\_AS\_REFS           | Number of single blocks marked as references due to new matches                                    | Blocks/Sec   |

### Dataservice

| **Type**                          | **Description**                                              | **Units**    |
| --------------------------------- | ------------------------------------------------------------ | ------------ |
| QUOTAS\_MARKED                    | Number of directory quotas marked                            | Quotas       |
| QUOTA\_TASK\_ADD\_DIR\_ENTRIES    | Number of entries added for directory quota task             | Ops          |
| QUOTA\_TASK\_CREATES              | Number of directory quota tasks created                      | Ops          |
| QUOTA\_TASK\_DELETES              | Number of directory quota tasks removed                      | Ops          |
| QUOTA\_TASK\_DELETE\_DIR\_ENTRIES | Number of entries removed for directory quota task           | Ops          |
| QUOTA\_TASK\_FAILED\_STAMPS       | Number of failed quota coloring stamp operations             | Ops          |
| QUOTA\_TASK\_FIBERS               | Number of directory quota task fibers spawned per second     | Fibers       |
| QUOTA\_TASK\_READDIR\_LATENCY     | Average latency of directory quota task readdir operations   | Microseconds |
| QUOTA\_TASK\_READDIR\_OPS         | Number of directory quota task readdir operations per second | Ops/Sec      |
| QUOTA\_TASK\_RUNTIME              | Average runtime of directory quota task fibers               | Microseconds |
| QUOTA\_TASK\_STAMPS               | Number of directory quota stamp operations per second        | Ops/Sec      |
| QUOTA\_TASK\_STAMP\_LATENCY       | Average latency of directory quota task stamp operations     | Microseconds |
| QUOTA\_TASK\_SUCCESSFUL\_STAMPS   | Number of successful directory quota stamp operations        | Ops          |

### Filesystem OBS

| **Type**                                          | **Description**                                                                 | **Units**          |
| ------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------ |
| BACKPRESSURED\_BUCKETS\_IN\_FSS                   | Number of backpressured buckets                                                 | Buckets            |
| CONCURRENT\_DEMOTES                               | Number of demotes executed concurrently                                         | Demotes            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_BACKPRESSURE          | Number of extent BACKPRESSURE object-store fetch operations per second          | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_IMMEDIATE\_RELEASE    | Number of extent IMMEDIATE\_RELEASE object-store fetch operations per second    | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_MANHOLE               | Number of extent MANHOLE object-store fetch operations per second               | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_MIGRATE               | Number of extent MIGRATE object-store fetch operations per second               | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_POLICY                | Number of extent POLICY object-store fetch operations per second                | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_RECLAMATION\_REUPLOAD | Number of extent RECLAMATION\_REUPLOAD object-store fetch operations per second | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_STOW                  | Number of extent STOW object-store fetch operations per second                  | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH                        | Number of extent object-store fetch operations per second                       | Ops/Sec            |
| DEMOTE\_WAITING\_FOR\_SLOT                        | Average time waiting for a demotion concurrency slot                            | Microseconds       |
| DESERIALIZED\_EXTENTS\_WITH\_INVALID\_BLOBS       | Number of deserialized extents with invalid blob id                             | Extents            |
| DOWNLOADS                                         | Number of downloads per second                                                  | Ops/Sec            |
| DOWNLOAD\_LATENCY                                 | Average latency of downloads                                                    | Microseconds       |
| EXTENTS\_WITH\_FAKE\_RETENTION\_TAG               | Number of scanned extents with fake retention tag                               | Extents            |
| FAILED\_DOWNLOADS                                 | Number of failed downloads per second                                           | Ops/Sec            |
| FAILED\_UPLOADS                                   | Number of failed uploads per second                                             | Ops/Sec            |
| OBS\_4K\_IOPS\_READ                               | Number of object store dedicated 4K read operations per second                  | Ops/Sec            |
| OBS\_BACKPRESSURE\_FREED                          | Number of bytes freed from disk due to backpressure per second                  | Bytes/Sec          |
| OBS\_BLOB\_HEADER\_DOWNLOAD\_LATENCY              | Average latency of blob header download                                         | Microseconds       |
| OBS\_BLOB\_SCAVENGE\_LATENCY                      | Average latency of blob scavenges                                               | Microseconds       |
| OBS\_BLOB\_TIERING\_DURATION                      | Duration of tiering blobs to object-store                                       | Ops                |
| OBS\_COMPLETELY\_ALIVE\_BLOBS                     | Percentage of blobs with only live extents linked to them                       | %                  |
| OBS\_COMPLETELY\_DEAD\_BLOBS                      | Percentage of blobs with no live extent linked to them                          | %                  |
| OBS\_EXTENTS\_PREFETCH                            | Number of extents prefetched from object-store per second                       | Extents/Sec        |
| OBS\_FREED                                        | Number of bytes freed from disk because they are in the object-store per second | Bytes/Sec          |
| OBS\_IMMEDIATE\_RELEASE\_FREED                    | Number of bytes freed from disk due to immediate release per second             | Bytes/Sec          |
| OBS\_INODES\_PREFETCH                             | Number of files prefetched from object-store per second                         | Ops/Sec            |
| OBS\_INODES\_RELEASE                              | Number of file released to object-store per second                              | Ops/Sec            |
| OBS\_ONGOING\_RECLAMATIONS                        | Number of ongoing reclamations                                                  | Ops                |
| OBS\_POLICY\_FREED                                | Number of bytes freed from disk due to policy per second                        | Bytes/Sec          |
| OBS\_PROMOTE\_EXTENT\_WRITE\_LATENCY              | Average latency of extent promote writes                                        | Microseconds       |
| OBS\_PROMOTE\_EXTENT\_WRITE                       | Number of extents promoted from object-store per second                         | Extents/Sec        |
| OBS\_PROMOTE\_WRITE                               | Number of bytes promoted from object-store per second                           | Bytes/Sec          |
| OBS\_READ                                         | Number of reads that needed data from the object-store per second               | Ops/Sec            |
| OBS\_RECLAMATION\_PURGED\_BYTES                   | Number of bytes purged per second                                               | Bytes/Sec          |
| OBS\_RECLAMATION\_SCAVENGED\_BLOBS                | Number of blobs scavenged per second                                            | Ops/Sec            |
| OBS\_RECLAMATION\_SCAVENGED\_BYTES                | Number of bytes scavenged per second                                            | Bytes/Sec          |
| OBS\_RECLAMATION\_WAIT\_FOR\_DESTAGE              | Average time waiting for destage on space reclamation                           | Microseconds       |
| OBS\_RELOC\_DOWNLOAD                              | Number of relocation blobs downloaded per second                                | Ops/Sec            |
| OBS\_RELOC\_UPLOAD                                | Number of relocation blobs uploaded per second                                  | Ops/Sec            |
| OBS\_SCAVENGED\_BLOB\_WASTE\_LEVEL                | Waste level found in blobs                                                      | Blobs              |
| OBS\_SHARED\_DOWNLOADS\_LATENCY                   | Average latency of shared downloads from object-store                           | Microseconds       |
| OBS\_SHARED\_DOWNLOADS                            | Number of shared downloads from object-store per second                         | Ops/Sec            |
| OBS\_TRUNCATE                                     | Number of truncates that needed data from the object-store per second           | Ops/Sec            |
| OBS\_UNEXPECTED\_TAG\_ON\_DOWNLOAD                | Number of unexpected tags found when downloading extents                        | Occurrences        |
| OBS\_WRITE                                        | Number of writes that needed data from the object-store per second              | Ops/Sec            |
| STOW\_COMMIT\_QUEUE\_HANG                         | Number of times metadata download queue was hanging full                        | Occurrences        |
| STOW\_METADATA\_DESERIALIZATION\_LATENCY          | Average latency of metadata blob deserialization                                | Milliseconds       |
| STOW\_METADATA\_SEED\_DOWNLOADS                   | Number of seed downloads per second                                             | Ops/Sec            |
| STOW\_SERIALIZED\_EXTENT\_DATA                    | Number of extent descriptors uploaded that contain data                         | Extent Descriptors |
| STOW\_SERIALIZED\_EXTENT\_DESCS                   | Number of extent descriptors uploaded                                           | Extent Descriptors |
| STOW\_SERIALIZED\_EXTENT\_REDIRECTS               | Number of extent descriptors uploaded that redirect to previous snapshot        | Extent Descriptors |
| TIERED\_FS\_BREAKING\_POLICY                      | Number of tiered filesystems breaking policy                                    | Activations        |
| TIMEOUT\_DOWNLOADS                                | Number of timed out downloads per second                                        | Ops/Sec            |
| TIMEOUT\_OPERATIONS                               | Total number of timed out operations per second                                 | Ops/Sec            |
| TIMEOUT\_UPLOADS                                  | Number of timed out uploads per second                                          | Ops/Sec            |
| UNEXPECTED\_BLOCK\_VERSION\_POST\_UPGRADE         | Number of unexpected block version found after upgrade completed                | Occurrences        |
| UPLOADS                                           | Number of upload attempts per second                                            | Ops/Sec            |
| UPLOAD\_CHOKING\_LATENCY                          | Average latency of waiting for upload choking budget                            | Microseconds       |
| UPLOAD\_LATENCY                                   | Average latency of uploads                                                      | Microseconds       |

### Frontend

| **Type**         | **Description**                                                           | **Units**  |
| ---------------- | ------------------------------------------------------------------------- | ---------- |
| FE\_IDLE\_CYCLES | The number of idle cycles on the frontend                                 | Cycles/Sec |
| FE\_IDLE\_TIME   | The percentage of the CPU time not used for handling I/Os on the frontend | %          |

### Frontend Encryption

| **Type**                        | **Description**                                     | **Units**    |
| ------------------------------- | --------------------------------------------------- | ------------ |
| FE\_BLOCKS\_DECRYPTED           | Number of blocks decrypted in the frontend          | Blocks       |
| FE\_BLOCKS\_ENCRYPTED           | Number of blocks encrypted in the frontend          | Blocks       |
| FE\_BLOCK\_CRYPTO\_LATENCY      | Average latency of frontend block crypto            | Microseconds |
| FE\_BLOCK\_DECRYPT\_DURATION    | Duration of decryption of blocks in the frontend    | Microseconds |
| FE\_BLOCK\_ENCRYPT\_DURATION    | Duration of encryption of blocks in the frontend    | Microseconds |
| FE\_FILENAMES\_DECRYPTED        | Number of filenames decrypted in the frontend       | Filenames    |
| FE\_FILENAMES\_ENCRYPTED        | Number of filenames encrypted in the frontend       | Filenames    |
| FE\_FILENAME\_CRYPTO\_LATENCY   | Average latency of frontend filename crypto         | Microseconds |
| FE\_FILENAME\_DECRYPT\_DURATION | Duration of decryption of filenames in the frontend | Microseconds |
| FE\_FILENAME\_ENCRYPT\_DURATION | Duration of encryption of filenames in the frontend | Microseconds |

### Garbage Collection

| **Type**                     | **Description**                     | **Units** |
| ---------------------------- | ----------------------------------- | --------- |
| GC\_ALLOC\_BYTES             | Number of bytes allocated from GC   | Bytes     |
| GC\_FREE\_SIZE\_AFTER\_SCAN  | GC pool size after the scan ends    | Bytes     |
| GC\_FREE\_SIZE\_BEFORE\_SCAN | GC pool size before the scan starts | Bytes     |
| GC\_SCANS                    | Number of GC scans                  | Scans     |
| GC\_SCAN\_TIME               | GC scan time                        | Msec      |
| GC\_USED\_SIZE\_AFTER\_SCAN  | GC used size after the scan ends    | Bytes     |
| GC\_USED\_SIZE\_BEFORE\_SCAN | GC used size before the scan starts | Bytes     |

### JRPC

| **Type**                       | **Description**                                                          | **Units**    |
| ------------------------------ | ------------------------------------------------------------------------ | ------------ |
| JRPC\_SERVER\_PROCESSING\_AVG  | The average time the JRPC server processed the JRPC requests.            | Microseconds |
| JRPC\_SERVER\_PROCESSING\_TIME | The number of JRPC requests processed by the server per each time range. | Requests     |

### Memory

| **Type**     | **Description**                                                      | **Units** |
| ------------ | -------------------------------------------------------------------- | --------- |
| RSS\_CURRENT | The process (node) memory resident size, current in sample time.     | MB        |
| RSS\_PEAK    | The process (node) memory resident size, peak over process lifetime. | MB        |

### Network

| **Type**                                | **Description**                                                                                                     | **Units**           |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------- |
| ACKS\_LOST                              | Number of lost ACK packets                                                                                          | Packets/Sec         |
| ACKS\_REORDERED                         | Number of reordered ACK packets                                                                                     | Packets/Sec         |
| BAD\_RECV\_CSUM                         | Number of packets received with a bad checksum                                                                      | Packets/Sec         |
| CORRUPT\_PACKETS                        | Number of packets received and deemed corrupted                                                                     | Packets/Sec         |
| DOUBLY\_RECEIVED\_PACKETS               | Number of packets that were received multiple times                                                                 | Packets/Sec         |
| DROPPED\_LARGE\_PACKETS                 | Number of large packets dropped in the socket backend                                                               | Packets/Sec         |
| DROPPED\_PACKETS                        | Number of packets received that we dropped                                                                          | Packets/Sec         |
| ECN\_ENCOUNTERED                        | Number of ECN Encountered packets                                                                                   | Packets/Sec         |
| FAULT\_RECV\_DELAYED\_PACKETS           | Number of received packets delayed due to a fault injection                                                         | Packets/Sec         |
| FAULT\_RECV\_DROPPED\_PACKETS           | Number of received packets dropped due to a fault injection                                                         | Packets/Sec         |
| FAULT\_SENT\_DELAYED\_PACKETS           | Number of sent packets delayed due to a fault injection                                                             | Packets/Sec         |
| FAULT\_SENT\_DROPPED\_PACKETS           | Number of sent packets dropped due to a fault injection                                                             | Packets/Sec         |
| GOODPUT\_RX\_RATIO                      | Percentage of goodput RX packets out of total data packets received                                                 | %                   |
| GOODPUT\_TX\_RATIO                      | Percentage of goodput TX packets out of total data packets sent                                                     | %                   |
| GW\_MAC\_RESOLVE\_FAILURES              | Number of times we failed to ARP resolve the gateway IP                                                             | Failures            |
| GW\_MAC\_RESOLVE\_SUCCESSES             | Number of times we succeeded to ARP resolve the gateway IP                                                          | Successes           |
| INVALID\_FIRST\_FRAGMENT                | Number of times we got an invalid first fragment                                                                    | Packets/Sec         |
| MBUF\_DUP\_COUNT                        | Numer of Duplicate mbufs found                                                                                      | Occurrences         |
| MBUF\_DUP\_ITER                         | Duplicate mbuf check completions                                                                                    | Occurrences         |
| NDP\_DAD\_RECV\_ADDR\_CONFLICTS         | NDP DAD Receive Address Conflict Detected                                                                           | Packets/Sec         |
| NDP\_DAD\_RECV\_NO\_CONFLICTS           | NDP DAD Receive No Conflict                                                                                         | Packets/Sec         |
| NODE\_RECONNECTED                       | Number of reconnections                                                                                             | Reconnects/Sec      |
| PACKETS\_PUMPED                         | Number of packets received in each call to recvPackets                                                              | Batches             |
| PEER\_RTT                               | RTT per peer node                                                                                                   | Microseconds        |
| POISON\_DETECTED\_EXPECTED              | Expected number of poisoned netbufs detected                                                                        | Occurrences         |
| POISON\_DETECTED\_UNEXPECTED            | Unexpected number of poisoned netbufs detected                                                                      | Occurrences         |
| POISON\_DETECTED                        | Number of poisoned netbufs detected                                                                                 | Occurrences         |
| PORT\_EXT\_RX\_PACKETS                  | Number of external packets received                                                                                 | Packets/Sec         |
| PORT\_RX\_BYTES                         | Number of bytes received                                                                                            | Bytes/Sec           |
| PORT\_RX\_ERRORS                        | Number of packet RX errors                                                                                          | Packets/Sec         |
| PORT\_RX\_MISSED                        | Number of packets lost due to RX queue full                                                                         | Packets/Sec         |
| PORT\_RX\_NO\_MBUFS                     | Number of packets lost due to no mbufs                                                                              | Packets/Sec         |
| PORT\_RX\_PACKETS                       | Number of packets received                                                                                          | Packets/Sec         |
| PORT\_TX\_BYTES                         | Number of bytes transmitted                                                                                         | Bytes/Sec           |
| PORT\_TX\_ERRORS                        | Number of packet TX errors                                                                                          | Packets/Sec         |
| PORT\_TX\_PACKETS                       | Number of packets transmitted                                                                                       | Packets/Sec         |
| PUMPS\_TXQ\_FULL                        | Number of times we couldn't send any new packets to the NIC queue                                                   | Pumps/Sec           |
| PUMPS\_TXQ\_PARTIAL                     | Number of times we only sent some of our queued packets to the NIC queue                                            | Pumps/Sec           |
| PUMP\_DURATION                          | Duration of each pump                                                                                               | Requests            |
| PUMP\_INTERVAL                          | Interval between pumps                                                                                              | Requests            |
| RDMA\_ADD\_CHUNK\_FAILURES              | Number of RDMA cookie setting failurs                                                                               | Failures/Sec        |
| RDMA\_AHCACHE\_POPULATIONS              | Number of RDMA RDMA AH cache population attempts                                                                    | Attempts/Sec        |
| RDMA\_BINDING\_FAILOVERS                | Number of RDMA High-Availability fail overs                                                                         | Fail-overs/Sec      |
| RDMA\_CANCELED\_COMPLETIONS             | Number of RDMA completions that were cancelled                                                                      | Completions/Sec     |
| RDMA\_CLIENT\_BINDING\_INVALIDATIONS    | Number of RDMA client binding invalidations                                                                         | Invalidations/Sec   |
| RDMA\_COMPLETIONS                       | Number of RDMA requests that completed                                                                              | Completions/Sec     |
| RDMA\_COMP\_DURATION                    | Histogram of RDMA completion duration times                                                                         | Requests            |
| RDMA\_COMP\_FAILURES                    | Number of RDMA requests that completed with an error                                                                | Failures/Sec        |
| RDMA\_COMP\_LATENCY                     | Average time of RDMA requests completion                                                                            | Microseconds        |
| RDMA\_COMP\_STATUSES                    | Histogram of RDMA completion statuses                                                                               | Completions/Sec     |
| RDMA\_FAILED\_AHCACHE\_POPULATIONS      | Number of failed RDMA AH cache population attempts                                                                  | Failed Attempts/Sec |
| RDMA\_FALLBACK\_WHILE\_AH\_POPULATE     | Number of fallbacks from RDMA due to AH cache population in progress                                                | Fallbacks/Sec       |
| RDMA\_NET\_ERR\_RETRY\_EXCEEDED         | Number of RDMA requests with error retries exceeded                                                                 | Occurrences/Sec     |
| RDMA\_POOL\_ALLOC\_FAILED               | Number of times an RDMA request was not issued due to a pool allocation failure                                     | Failures/Sec        |
| RDMA\_POOL\_LOW\_CAPACITY               | Number of times an RDMA request was not issued due to low RDAM pool memory                                          | Failures/Sec        |
| RDMA\_POOL\_MBUF\_LEAKED                | RDMA leaked mbufs                                                                                                   | Occurrences         |
| RDMA\_PORT\_WAITING\_FIBERS             | Number of fibers pending to send an RDMA request                                                                    | Waiting fibers      |
| RDMA\_REQUESTS                          | Number of RDMA requests sent to the NIC                                                                             | Requests/Sec        |
| RDMA\_RX\_BYTES                         | Number of bytes received with RDMA                                                                                  | Bytes/Sec           |
| RDMA\_SERVER\_BINDING\_RESTARTS         | Number of RDMA server binding restarts                                                                              | Restarts/Sec        |
| RDMA\_SERVER\_FAILED\_BINDING\_RESTARTS | Number of failed RDMA server binding restarts                                                                       | Failed Restarts/Sec |
| RDMA\_SERVER\_RECV\_FAILURES            | Number of failed RDMA server-side receive attempts                                                                  | Failures/Sec        |
| RDMA\_SERVER\_SEND\_FAILURES            | Number of failed RDMA server-side send attempts                                                                     | Failures/Sec        |
| RDMA\_SUBMIT\_FAILURES                  | Number of RDMA submit failures, likely indicating a fabric issue                                                    | Failures/Sec        |
| RDMA\_SUBMIT\_TIMEOUTS                  | Number of RDMA submit timeouts                                                                                      | Timeouts/Sec        |
| RDMA\_TX\_BYTES                         | Number of bytes sent with RDMA                                                                                      | Bytes/Sec           |
| RDMA\_WAIT\_INTERRUPTED                 | RDMA Wait interruptions                                                                                             | Issues              |
| RDMA\_WAIT\_PREMATURE\_WAKEUP           | RDMA Wait premature wakeup                                                                                          | Issues              |
| RDMA\_WAIT\_TIMEOUT                     | RDMA Wait timeouts                                                                                                  | Issues              |
| RECEIVED\_ACK\_PACKETS                  | Number of received ack packets                                                                                      | Packets/Sec         |
| RECEIVED\_CONTROL\_PACKETS              | Number of received control packets                                                                                  | Packets/Sec         |
| RECEIVED\_DATA\_PACKETS                 | Number of received data packets                                                                                     | Packets/Sec         |
| RECEIVED\_PACKETS                       | Number of packets received                                                                                          | Packets/Sec         |
| RECEIVED\_PACKET\_GENERATIONS           | The generation ("resend count") of the first incarnation of the packet seen by the receiver (indicates packet loss) | Packets             |
| RECEIVED\_PING\_PACKETS                 | Number of received ping packets                                                                                     | Packets/Sec         |
| RECEIVED\_PONG\_PACKETS                 | Number of received pong packets                                                                                     | Packets/Sec         |
| RECEIVED\_REJECT\_PACKETS               | Number of received reject packets                                                                                   | Packets/Sec         |
| RECEIVED\_SYNC\_PACKETS                 | Number of received sync packets                                                                                     | Packets/Sec         |
| REORDERED\_PACKETS                      | Number of reordered packets                                                                                         | Packets/Sec         |
| RESEND\_BATCH\_SIZE                     | Number of packets sent in a resend batch                                                                            | Batches             |
| RESENT\_DATA\_PACKETS                   | Number of data packets resent                                                                                       | Packets/Sec         |
| SEND\_BATCH\_SIZE\_BYTES                | Number of bytes sent in a first send batch                                                                          | Batches             |
| SEND\_BATCH\_SIZE                       | Number of packets sent in a first send batch                                                                        | Batches             |
| SEND\_QUEUE\_TIMEOUTS                   | Number of packets cancelled due to envelope timeout and were not in the send window                                 | Packets/Sec         |
| SEND\_WINDOW\_TIMEOUTS                  | Number of packets cancelled due to envelope timeout while in the send window                                        | Packets/Sec         |
| SENT\_ACKS                              | Number of ACK packets sent                                                                                          | Packets/Sec         |
| SENT\_CONTROL\_PACKETS                  | Number of control packets sent                                                                                      | Packets/Sec         |
| SENT\_DATA\_PACKETS                     | Number of data packets sent                                                                                         | Packets/Sec         |
| SENT\_PACKETS                           | Number of sent packets                                                                                              | Packets/Sec         |
| SENT\_REJECTS                           | Number of rejects sent                                                                                              | Packets/Sec         |
| SHORT\_CIRCUIT\_SENDS                   | Number of packets sent to the same node                                                                             | Packets/Sec         |
| SLOW\_PATH\_CSUM                        | Number of packets that went through checksum calculation on the CPU                                                 | Packets/Sec         |
| TIMELY\_RESENDS                         | Number of packets resent due to timely resend                                                                       | Packets/Sec         |
| TIME\_TO\_ACK                           | Histogram of time to ack a data packet                                                                              | Requests            |
| TIME\_TO\_FIRST\_SEND                   | Time from queueing to first send                                                                                    | Requests            |
| UCX\_SEND\_CB                           | UCX Send Callback                                                                                                   | Packets/Sec         |
| UCX\_SEND\_ERROR                        | UCX Send Error                                                                                                      | Packets/Sec         |
| UCX\_SENT\_PACKETS\_ASYNC               | UCX Sent Asynchronously                                                                                             | Packets/Sec         |
| UCX\_SENT\_PACKETS\_IMMEDIATE           | UCX Sent Immediately                                                                                                | Packets/Sec         |
| UCX\_TXQ\_FULL                          | UCX Drop TXQ Full                                                                                                   | Packets/Sec         |
| UDP\_SENDMSG\_FAILED\_EAGAIN            | Number of packets that failed to be sent on the socket backend with EAGAIN                                          | Packets/Sec         |
| UDP\_SENDMSG\_FAILED\_OTHER             | Number of packets that failed to be sent on the socket backend with an unknown error                                | Packets/Sec         |
| UDP\_SENDMSG\_PARTIAL\_SEND             | Number of packets that we failed to send but in the same pump some packets were sent                                | Packets/Sec         |
| UNACKED\_RESENDS                        | Number of packets resent after receiving an ack                                                                     | Packets/Sec         |
| ZERO\_CSUM                              | Number of checksum zero received                                                                                    | Packets/Sec         |

### Object Storage

| **Type**                                             | **Description**                                                           | **Units**     |
| ---------------------------------------------------- | ------------------------------------------------------------------------- | ------------- |
| FAILED\_OBJECT\_DELETES                              | Number of failed object deletes per second (any failure reason)           | Ops/Sec       |
| FAILED\_OBJECT\_DOWNLOADS                            | Number of failed object download per second (any failure reason)          | Ops/Sec       |
| FAILED\_OBJECT\_HEAD\_QUERIES                        | Number of failed object head queries per second (any failure reason)      | Ops/Sec       |
| FAILED\_OBJECT\_OPERATIONS                           | Total number of failed operations per second                              | Ops/Sec       |
| FAILED\_OBJECT\_UPLOADS                              | Number of failed object uploads per second (any failure reason)           | Ops/Sec       |
| OBJECT\_DELETES                                      | Number of object deletes per second                                       | Ops/Sec       |
| OBJECT\_DELETE\_DURATION                             | Duration of object delete request                                         | Ops           |
| OBJECT\_DELETE\_LATENCY                              | Average latency of deleting an object                                     | Microseconds  |
| OBJECT\_DOWNLOADS\_BACKGROUND                        | Number of BACKGROUND objects downloaded per second                        | Ops/Sec       |
| OBJECT\_DOWNLOADS\_FOREGROUND                        | Number of FOREGROUND objects downloaded per second                        | Ops/Sec       |
| OBJECT\_DOWNLOADS                                    | Number of objects downloaded per second                                   | Ops/Sec       |
| OBJECT\_DOWNLOAD\_BYTES\_BACKGROUND                  | Number of BACKGROUND bytes sent to the object store per second            | Bytes/Sec     |
| OBJECT\_DOWNLOAD\_BYTES\_FOREGROUND                  | Number of FOREGROUND bytes sent to the object store per second            | Bytes/Sec     |
| OBJECT\_DOWNLOAD\_DURATION                           | Duration of object download request                                       | Ops           |
| OBJECT\_DOWNLOAD\_LATENCY                            | Average latency of downloading an object                                  | Microseconds  |
| OBJECT\_DOWNLOAD\_SIZE                               | Size of downloaded object ranges                                          | Ops           |
| OBJECT\_HEAD\_DURATION                               | Duration of object head request                                           | Ops           |
| OBJECT\_HEAD\_LATENCY                                | Average latency of deleting an object                                     | Microseconds  |
| OBJECT\_HEAD\_QUERIES                                | Number of object head queries per second                                  | Ops/Sec       |
| OBJECT\_OPERATIONS                                   | Total number of operations per second                                     | Ops/Sec       |
| OBJECT\_REMOVE\_SIZE                                 | Size of removed objects                                                   | Ops           |
| OBJECT\_UPLOADS\_BACKPRESSURE                        | Number of BACKPRESSURE upload attempts per second                         | Ops/Sec       |
| OBJECT\_UPLOADS\_IMMEDIATE\_RELEASE                  | Number of IMMEDIATE\_RELEASE upload attempts per second                   | Ops/Sec       |
| OBJECT\_UPLOADS\_MANHOLE                             | Number of MANHOLE upload attempts per second                              | Ops/Sec       |
| OBJECT\_UPLOADS\_MIGRATE                             | Number of MIGRATE upload attempts per second                              | Ops/Sec       |
| OBJECT\_UPLOADS\_POLICY                              | Number of POLICY upload attempts per second                               | Ops/Sec       |
| OBJECT\_UPLOADS\_RECLAMATION\_REUPLOAD               | Number of RECLAMATION\_REUPLOAD upload attempts per second                | Ops/Sec       |
| OBJECT\_UPLOADS\_STOW                                | Number of STOW upload attempts per second                                 | Ops/Sec       |
| OBJECT\_UPLOADS                                      | Number of object uploads per second                                       | Ops/Sec       |
| OBJECT\_UPLOAD\_BYTES\_BACKPRESSURE                  | Number of BACKPRESSURE bytes sent to the object store per second          | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_IMMEDIATE\_RELEASE            | Number of IMMEDIATE\_RELEASE bytes sent to the object store per second    | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_MANHOLE                       | Number of MANHOLE bytes sent to the object store per second               | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_MIGRATE                       | Number of MIGRATE bytes sent to the object store per second               | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_POLICY                        | Number of POLICY bytes sent to the object store per second                | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_RECLAMATION\_REUPLOAD         | Number of RECLAMATION\_REUPLOAD bytes sent to the object store per second | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_STOW                          | Number of STOW bytes sent to the object store per second                  | Bytes/Sec     |
| OBJECT\_UPLOAD\_DURATION                             | Duration of object upload request                                         | Ops           |
| OBJECT\_UPLOAD\_LATENCY                              | Average latency of uploading an object                                    | Microseconds  |
| OBJECT\_UPLOAD\_SIZE                                 | Size of uploaded objects                                                  | Ops           |
| OBS\_READ\_BYTES                                     | Number of bytes read from object storage                                  | Bytes/Sec     |
| OBS\_WRITE\_BYTES                                    | Number of bytes sent to object storage                                    | Bytes/Sec     |
| ONGOING\_DOWNLOADS                                   | Number of ongoing downloads                                               | Ops           |
| ONGOING\_REMOVES                                     | Number of ongoing removes                                                 | Ops           |
| ONGOING\_UPLOADS                                     | Number of ongoing uploads                                                 | Ops           |
| READ\_BYTES                                          | Number of bytes read from object storage                                  | Bytes/Sec     |
| REMOVE\_BYTES                                        | Number of bytes removed from object storage                               | Bytes/Sec     |
| REQUEST\_COUNT\_DELETE                               | Number of HTTP DELETE requests per second                                 | Requests/Sec  |
| REQUEST\_COUNT\_GET                                  | Number of HTTP GET requests per second                                    | Requests/Sec  |
| REQUEST\_COUNT\_HEAD                                 | Number of HTTP HEAD requests per second                                   | Requests/Sec  |
| REQUEST\_COUNT\_INVALID                              | Number of HTTP INVALID requests per second                                | Requests/Sec  |
| REQUEST\_COUNT\_POST                                 | Number of HTTP POST requests per second                                   | Requests/Sec  |
| REQUEST\_COUNT\_PUT                                  | Number of HTTP PUT requests per second                                    | Requests/Sec  |
| RESPONSE\_COUNT\_ACCEPTED                            | Number of HTTP ACCEPTED responses per second                              | Responses/Sec |
| RESPONSE\_COUNT\_BAD\_GATEWAY                        | Number of HTTP BAD\_GATEWAY responses per second                          | Responses/Sec |
| RESPONSE\_COUNT\_BAD\_REQUEST                        | Number of HTTP BAD\_REQUEST responses per second                          | Responses/Sec |
| RESPONSE\_COUNT\_CONFLICT                            | Number of HTTP CONFLICT responses per second                              | Responses/Sec |
| RESPONSE\_COUNT\_CONTINUE                            | Number of HTTP CONTINUE responses per second                              | Responses/Sec |
| RESPONSE\_COUNT\_CREATED                             | Number of HTTP CREATED responses per second                               | Responses/Sec |
| RESPONSE\_COUNT\_EXPECTATION\_FAILED                 | Number of HTTP EXPECTATION\_FAILED responses per second                   | Responses/Sec |
| RESPONSE\_COUNT\_FORBIDDEN                           | Number of HTTP FORBIDDEN responses per second                             | Responses/Sec |
| RESPONSE\_COUNT\_FOUND                               | Number of HTTP FOUND responses per second                                 | Responses/Sec |
| RESPONSE\_COUNT\_GATEWAY\_TIMEOUT                    | Number of HTTP GATEWAY\_TIMEOUT responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_GONE                                | Number of HTTP GONE responses per second                                  | Responses/Sec |
| RESPONSE\_COUNT\_HTTP\_VERSION\_NOT\_SUPPORTED       | Number of HTTP HTTP\_VERSION\_NOT\_SUPPORTED responses per second         | Responses/Sec |
| RESPONSE\_COUNT\_INSUFFICIENT\_STORAGE               | Number of HTTP INSUFFICIENT\_STORAGE responses per second                 | Responses/Sec |
| RESPONSE\_COUNT\_INVALID                             | Number of HTTP INVALID responses per second                               | Responses/Sec |
| RESPONSE\_COUNT\_LENGTH\_REQUIRED                    | Number of HTTP LENGTH\_REQUIRED responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_METHOD\_NOT\_ALLOWED                | Number of HTTP METHOD\_NOT\_ALLOWED responses per second                  | Responses/Sec |
| RESPONSE\_COUNT\_MOVED\_PERMANENTLY                  | Number of HTTP MOVED\_PERMANENTLY responses per second                    | Responses/Sec |
| RESPONSE\_COUNT\_NON\_AUTH\_INFO                     | Number of HTTP NON\_AUTH\_INFO responses per second                       | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_ACCEPTABLE                     | Number of HTTP NOT\_ACCEPTABLE responses per second                       | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_FOUND                          | Number of HTTP NOT\_FOUND responses per second                            | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_IMPLEMENTED                    | Number of HTTP NOT\_IMPLEMENTED responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_MODIFIED                       | Number of HTTP NOT\_MODIFIED responses per second                         | Responses/Sec |
| RESPONSE\_COUNT\_NO\_CONTENT                         | Number of HTTP NO\_CONTENT responses per second                           | Responses/Sec |
| RESPONSE\_COUNT\_OK                                  | Number of HTTP OK responses per second                                    | Responses/Sec |
| RESPONSE\_COUNT\_PARTIAL\_CONTENT                    | Number of HTTP PARTIAL\_CONTENT responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_PAYMENT\_REQUIRED                   | Number of HTTP PAYMENT\_REQUIRED responses per second                     | Responses/Sec |
| RESPONSE\_COUNT\_PRECONDITION\_FAILED                | Number of HTTP PRECONDITION\_FAILED responses per second                  | Responses/Sec |
| RESPONSE\_COUNT\_PROXY\_AUTH\_REQUIRED               | Number of HTTP PROXY\_AUTH\_REQUIRED responses per second                 | Responses/Sec |
| RESPONSE\_COUNT\_REDIRECT\_MULTIPLE\_CHOICES         | Number of HTTP REDIRECT\_MULTIPLE\_CHOICES responses per second           | Responses/Sec |
| RESPONSE\_COUNT\_REQUESTED\_RANGE\_NOT\_SATISFIABLE  | Number of HTTP REQUESTED\_RANGE\_NOT\_SATISFIABLE responses per second    | Responses/Sec |
| RESPONSE\_COUNT\_REQUEST\_HEADER\_FIELDS\_TOO\_LARGE | Number of HTTP REQUEST\_HEADER\_FIELDS\_TOO\_LARGE responses per second   | Responses/Sec |
| RESPONSE\_COUNT\_REQUEST\_TIMEOUT                    | Number of HTTP REQUEST\_TIMEOUT responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_REQUEST\_TOO\_LARGE                 | Number of HTTP REQUEST\_TOO\_LARGE responses per second                   | Responses/Sec |
| RESPONSE\_COUNT\_RESET\_CONTENT                      | Number of HTTP RESET\_CONTENT responses per second                        | Responses/Sec |
| RESPONSE\_COUNT\_SEE\_OTHER                          | Number of HTTP SEE\_OTHER responses per second                            | Responses/Sec |
| RESPONSE\_COUNT\_SERVER\_ERROR                       | Number of HTTP SERVER\_ERROR responses per second                         | Responses/Sec |
| RESPONSE\_COUNT\_SERVICE\_UNAVAILABLE                | Number of HTTP SERVICE\_UNAVAILABLE responses per second                  | Responses/Sec |
| RESPONSE\_COUNT\_SWITCHING\_PROTOCOL                 | Number of HTTP SWITCHING\_PROTOCOL responses per second                   | Responses/Sec |
| RESPONSE\_COUNT\_TEMP\_REDIRECT                      | Number of HTTP TEMP\_REDIRECT responses per second                        | Responses/Sec |
| RESPONSE\_COUNT\_UNAUTHORIZED                        | Number of HTTP UNAUTHORIZED responses per second                          | Responses/Sec |
| RESPONSE\_COUNT\_UNPROCESSABLE\_ENTITY               | Number of HTTP UNPROCESSABLE\_ENTITY responses per second                 | Responses/Sec |
| RESPONSE\_COUNT\_UNSUPPORTED\_MEDIA\_TYPE            | Number of HTTP UNSUPPORTED\_MEDIA\_TYPE responses per second              | Responses/Sec |
| RESPONSE\_COUNT\_URI\_TOO\_LONG                      | Number of HTTP URI\_TOO\_LONG responses per second                        | Responses/Sec |
| RESPONSE\_COUNT\_USE\_PROXY                          | Number of HTTP USE\_PROXY responses per second                            | Responses/Sec |
| WAITING\_FOR\_BUCKET\_DOWNLOAD\_BANDWIDTH            | Time requests wait for the object tore bucket download bandwidth          | Ops           |
| WAITING\_FOR\_BUCKET\_DOWNLOAD\_FLOW                 | Time requests wait for the object store bucket download flow              | Ops           |
| WAITING\_FOR\_BUCKET\_REMOVE\_BANDWIDTH              | Time requests wait for the object store bucket remove bandwidth           | Ops           |
| WAITING\_FOR\_BUCKET\_REMOVE\_FLOW                   | Time requests wait for the object store bucket remove flow                | Ops           |
| WAITING\_FOR\_BUCKET\_UPLOAD\_BANDWIDTH              | Time requests wait for the object store bucket upload bandwidth           | Ops           |
| WAITING\_FOR\_BUCKET\_UPLOAD\_FLOW                   | Time requests wait for the object store bucket upload flow                | Ops           |
| WAITING\_FOR\_GROUP\_DOWNLOAD\_BANDWIDTH             | Time requests wait for the object store group download bandwidth          | Ops           |
| WAITING\_FOR\_GROUP\_DOWNLOAD\_FLOW                  | Time requests wait for the object store group download flow               | Ops           |
| WAITING\_FOR\_GROUP\_REMOVE\_BANDWIDTH               | Time requests wait for the object store group remove bandwidth            | Ops           |
| WAITING\_FOR\_GROUP\_REMOVE\_FLOW                    | Time requests wait for the object store group remove flow                 | Ops           |
| WAITING\_FOR\_GROUP\_UPLOAD\_BANDWIDTH               | Time requests wait for the object store group upload bandwidth            | Ops           |
| WAITING\_FOR\_GROUP\_UPLOAD\_FLOW                    | Time requests wait for the object store group upload flow                 | Ops           |
| WAITING\_IN\_BUCKET\_DOWNLOAD\_QUEUE                 | Time requests wait in the object store bucket download queue              | Ops           |
| WAITING\_IN\_BUCKET\_REMOVE\_QUEUE                   | Time requests wait in the object store bucket remove queue                | Ops           |
| WAITING\_IN\_BUCKET\_UPLOAD\_QUEUE                   | Time requests wait in the object store bucket upload queue                | Ops           |
| WAITING\_IN\_GROUP\_DOWNLOAD\_QUEUE                  | Time requests wait in the object store group download queue               | Ops           |
| WAITING\_IN\_GROUP\_REMOVE\_QUEUE                    | Time requests wait in the object store group remove queue                 | Ops           |
| WAITING\_IN\_GROUP\_UPLOAD\_QUEUE                    | Time requests wait in object-store group upload queue                     | Ops           |
| WRITE\_BYTES                                         | Number of bytes sent to object storage                                    | Bytes/Sec     |

### Operations (NFS)

| **Type**          | **Description**                              | **Units**    |
| ----------------- | -------------------------------------------- | ------------ |
| ACCESS\_LATENCY   | Average latency of ACCESS operations         | Microseconds |
| ACCESS\_OPS       | Number of ACCESS operation per second        | Ops/Sec      |
| COMMIT\_LATENCY   | Average latency of COMMIT operations         | Microseconds |
| COMMIT\_OPS       | Number of COMMIT operation per second        | Ops/Sec      |
| CREATE\_LATENCY   | Average latency of CREATE operations         | Microseconds |
| CREATE\_OPS       | Number of CREATE operation per second        | Ops/Sec      |
| FSINFO\_LATENCY   | Average latency of FSINFO operations         | Microseconds |
| FSINFO\_OPS       | Number of FSINFO operation per second        | Ops/Sec      |
| GETATTR\_LATENCY  | Average latency of GETATTR operations        | Microseconds |
| GETATTR\_OPS      | Number of GETATTR operation per second       | Ops/Sec      |
| LINK\_LATENCY     | Average latency of LINK operations           | Microseconds |
| LINK\_OPS         | Number of LINK operation per second          | Ops/Sec      |
| LOOKUP\_LATENCY   | Average latency of LOOKUP operations         | Microseconds |
| LOOKUP\_OPS       | Number of LOOKUP operation per second        | Ops/Sec      |
| MKDIR\_LATENCY    | Average latency of MKDIR operations          | Microseconds |
| MKDIR\_OPS        | Number of MKDIR operation per second         | Ops/Sec      |
| MKNOD\_LATENCY    | Average latency of MKNOD operations          | Microseconds |
| MKNOD\_OPS        | Number of MKNOD operation per second         | Ops/Sec      |
| OPS               | Total number of operations                   | Ops/Sec      |
| PATHCONF\_LATENCY | Average latency of PATHCONF operations       | Microseconds |
| PATHCONF\_OPS     | Number of PATHCONF operation per second      | Ops/Sec      |
| READDIR\_LATENCY  | Average latency of READDIR operations        | Microseconds |
| READDIR\_OPS      | Number of READDIR operation per second       | Ops/Sec      |
| READLINK\_LATENCY | Average latency of READLINK operations       | Microseconds |
| READLINK\_OPS     | Number of READLINK operation per second      | Ops/Sec      |
| READS             | Number of read operations per second         | Ops/Sec      |
| READ\_BYTES       | Number of bytes read per second              | Bytes/Sec    |
| READ\_DURATION    | The number of reads per completion duration  | Reads        |
| READ\_LATENCY     | Average latency of READ operations           | Microseconds |
| READ\_SIZES       | NFS read sizes histogram                     | Reads        |
| REMOVE\_LATENCY   | Average latency of REMOVE operations         | Microseconds |
| REMOVE\_OPS       | Number of REMOVE operation per second        | Ops/Sec      |
| RENAME\_LATENCY   | Average latency of RENAME operations         | Microseconds |
| RENAME\_OPS       | Number of RENAME operation per second        | Ops/Sec      |
| SETATTR\_LATENCY  | Average latency of SETATTR operations        | Microseconds |
| SETATTR\_OPS      | Number of SETATTR operation per second       | Ops/Sec      |
| STATFS\_LATENCY   | Average latency of STATFS operations         | Microseconds |
| STATFS\_OPS       | Number of STATFS operation per second        | Ops/Sec      |
| SYMLINK\_LATENCY  | Average latency of SYMLINK operations        | Microseconds |
| SYMLINK\_OPS      | Number of SYMLINK operation per second       | Ops/Sec      |
| THROUGHPUT        | Number of byte read/writes per second        | Bytes/Sec    |
| WRITES            | Number of write operations per second        | Ops/Sec      |
| WRITE\_BYTES      | Number of byte writes per second             | Bytes/Sec    |
| WRITE\_DURATION   | The number of writes per completion duration | Writes       |
| WRITE\_LATENCY    | Average latency of WRITE operations          | Microseconds |
| WRITE\_SIZES      | NFS write sizes histogram                    | Writes       |

### Operations (NFSw)

| **Type**                               | **Description**                                              | **Units**    |
| -------------------------------------- | ------------------------------------------------------------ | ------------ |
| ACCESS\_LATENCY                        | Average latency of ACCESS operations                         | Microseconds |
| ACCESS\_OPS                            | Number of ACCESS operation per second                        | Ops/Sec      |
| COMMIT\_LATENCY                        | Average latency of COMMIT operations                         | Microseconds |
| COMMIT\_OPS                            | Number of COMMIT operation per second                        | Ops/Sec      |
| CREATE\_LATENCY                        | Average latency of CREATE operations                         | Microseconds |
| CREATE\_OPS                            | Number of CREATE operation per second                        | Ops/Sec      |
| GETATTR\_LATENCY                       | Average latency of GETATTR operations                        | Microseconds |
| GETATTR\_OPS                           | Number of GETATTR operation per second                       | Ops/Sec      |
| LINK\_LATENCY                          | Average latency of LINK operations                           | Microseconds |
| LINK\_OPS                              | Number of LINK operation per second                          | Ops/Sec      |
| LOOKUP\_LATENCY                        | Average latency of LOOKUP operations                         | Microseconds |
| LOOKUP\_OPS                            | Number of LOOKUP operation per second                        | Ops/Sec      |
| NFS3\_CLIENT\_READ\_BYTES              | Number of NFSV3 bytes read per second                        | Bytes/Sec    |
| NFS3\_CLIENT\_WRITE\_BYTES             | Number of NFSV3 bytes written per second                     | Bytes/Sec    |
| NFS3\_FSINFO\_LATENCY                  | Average latency of NFS3\_FSINFO operations                   | Microseconds |
| NFS3\_FSINFO\_OPS                      | Number of NFS3\_FSINFO operation per second                  | Ops/Sec      |
| NFS3\_MKDIR\_LATENCY                   | Average latency of NFS3\_MKDIR operations                    | Microseconds |
| NFS3\_MKDIR\_OPS                       | Number of NFS3\_MKDIR operation per second                   | Ops/Sec      |
| NFS3\_MKNOD\_LATENCY                   | Average latency of NFS3\_MKNOD operations                    | Microseconds |
| NFS3\_MKNOD\_OPS                       | Number of NFS3\_MKNOD operation per second                   | Ops/Sec      |
| NFS3\_PATHCONF\_LATENCY                | Average latency of NFS3\_PATHCONF operations                 | Microseconds |
| NFS3\_PATHCONF\_OPS                    | Number of NFS3\_PATHCONF operation per second                | Ops/Sec      |
| NFS3\_STATFS\_LATENCY                  | Average latency of NFS3\_STATFS operations                   | Microseconds |
| NFS3\_STATFS\_OPS                      | Number of NFS3\_STATFS operation per second                  | Ops/Sec      |
| NFS3\_SYMLINK\_LATENCY                 | Average latency of NFS3\_SYMLINK operations                  | Microseconds |
| NFS3\_SYMLINK\_OPS                     | Number of NFS3\_SYMLINK operation per second                 | Ops/Sec      |
| NFS4\_BACKCHANNEL\_CTL\_LATENCY        | Average latency of NFS4\_BACKCHANNEL\_CTL operations         | Microseconds |
| NFS4\_BACKCHANNEL\_CTL\_OPS            | Number of NFS4\_BACKCHANNEL\_CTL operation per second        | Ops/Sec      |
| NFS4\_BIND\_CONN\_TO\_SESSION\_LATENCY | Average latency of NFS4\_BIND\_CONN\_TO\_SESSION operations  | Microseconds |
| NFS4\_BIND\_CONN\_TO\_SESSION\_OPS     | Number of NFS4\_BIND\_CONN\_TO\_SESSION operation per second | Ops/Sec      |
| NFS4\_CLIENT\_READ\_BYTES              | Number of NFSV4 bytes read per second                        | Bytes/Sec    |
| NFS4\_CLIENT\_WRITE\_BYTES             | Number of NFSV4 bytes written per second                     | Bytes/Sec    |
| NFS4\_CLOSE\_LATENCY                   | Average latency of NFS4\_CLOSE operations                    | Microseconds |
| NFS4\_CLOSE\_OPS                       | Number of NFS4\_CLOSE operation per second                   | Ops/Sec      |
| NFS4\_CREATE\_SESSION\_LATENCY         | Average latency of NFS4\_CREATE\_SESSION operations          | Microseconds |
| NFS4\_CREATE\_SESSION\_OPS             | Number of NFS4\_CREATE\_SESSION operation per second         | Ops/Sec      |
| NFS4\_DELEGPURGE\_LATENCY              | Average latency of NFS4\_DELEGPURGE operations               | Microseconds |
| NFS4\_DELEGPURGE\_OPS                  | Number of NFS4\_DELEGPURGE operation per second              | Ops/Sec      |
| NFS4\_DELEGRETURN\_LATENCY             | Average latency of NFS4\_DELEGRETURN operations              | Microseconds |
| NFS4\_DELEGRETURN\_OPS                 | Number of NFS4\_DELEGRETURN operation per second             | Ops/Sec      |
| NFS4\_DESTROY\_CLIENTID\_LATENCY       | Average latency of NFS4\_DESTROY\_CLIENTID operations        | Microseconds |
| NFS4\_DESTROY\_CLIENTID\_OPS           | Number of NFS4\_DESTROY\_CLIENTID operation per second       | Ops/Sec      |
| NFS4\_DESTROY\_SESSION\_LATENCY        | Average latency of NFS4\_DESTROY\_SESSION operations         | Microseconds |
| NFS4\_DESTROY\_SESSION\_OPS            | Number of NFS4\_DESTROY\_SESSION operation per second        | Ops/Sec      |
| NFS4\_EXCHANGE\_ID\_LATENCY            | Average latency of NFS4\_EXCHANGE\_ID operations             | Microseconds |
| NFS4\_EXCHANGE\_ID\_OPS                | Number of NFS4\_EXCHANGE\_ID operation per second            | Ops/Sec      |
| NFS4\_FREE\_STATEID\_LATENCY           | Average latency of NFS4\_FREE\_STATEID operations            | Microseconds |
| NFS4\_FREE\_STATEID\_OPS               | Number of NFS4\_FREE\_STATEID operation per second           | Ops/Sec      |
| NFS4\_GETDEVICEINFO\_LATENCY           | Average latency of NFS4\_GETDEVICEINFO operations            | Microseconds |
| NFS4\_GETDEVICEINFO\_OPS               | Number of NFS4\_GETDEVICEINFO operation per second           | Ops/Sec      |
| NFS4\_GETDEVICELIST\_LATENCY           | Average latency of NFS4\_GETDEVICELIST operations            | Microseconds |
| NFS4\_GETDEVICELIST\_OPS               | Number of NFS4\_GETDEVICELIST operation per second           | Ops/Sec      |
| NFS4\_GETFH\_LATENCY                   | Average latency of NFS4\_GETFH operations                    | Microseconds |
| NFS4\_GETFH\_OPS                       | Number of NFS4\_GETFH operation per second                   | Ops/Sec      |
| NFS4\_GET\_DIR\_DELEGATION\_LATENCY    | Average latency of NFS4\_GET\_DIR\_DELEGATION operations     | Microseconds |
| NFS4\_GET\_DIR\_DELEGATION\_OPS        | Number of NFS4\_GET\_DIR\_DELEGATION operation per second    | Ops/Sec      |
| NFS4\_LAYOUTCOMMIT\_LATENCY            | Average latency of NFS4\_LAYOUTCOMMIT operations             | Microseconds |
| NFS4\_LAYOUTCOMMIT\_OPS                | Number of NFS4\_LAYOUTCOMMIT operation per second            | Ops/Sec      |
| NFS4\_LAYOUTGET\_LATENCY               | Average latency of NFS4\_LAYOUTGET operations                | Microseconds |
| NFS4\_LAYOUTGET\_OPS                   | Number of NFS4\_LAYOUTGET operation per second               | Ops/Sec      |
| NFS4\_LAYOUTRETURN\_LATENCY            | Average latency of NFS4\_LAYOUTRETURN operations             | Microseconds |
| NFS4\_LAYOUTRETURN\_OPS                | Number of NFS4\_LAYOUTRETURN operation per second            | Ops/Sec      |
| NFS4\_LOCKT\_LATENCY                   | Average latency of NFS4\_LOCKT operations                    | Microseconds |
| NFS4\_LOCKT\_OPS                       | Number of NFS4\_LOCKT operation per second                   | Ops/Sec      |
| NFS4\_LOCKU\_LATENCY                   | Average latency of NFS4\_LOCKU operations                    | Microseconds |
| NFS4\_LOCKU\_OPS                       | Number of NFS4\_LOCKU operation per second                   | Ops/Sec      |
| NFS4\_LOCK\_LATENCY                    | Average latency of NFS4\_LOCK operations                     | Microseconds |
| NFS4\_LOCK\_OPS                        | Number of NFS4\_LOCK operation per second                    | Ops/Sec      |
| NFS4\_LOOKUPP\_LATENCY                 | Average latency of NFS4\_LOOKUPP operations                  | Microseconds |
| NFS4\_LOOKUPP\_OPS                     | Number of NFS4\_LOOKUPP operation per second                 | Ops/Sec      |
| NFS4\_NVERIFY\_LATENCY                 | Average latency of NFS4\_NVERIFY operations                  | Microseconds |
| NFS4\_NVERIFY\_OPS                     | Number of NFS4\_NVERIFY operation per second                 | Ops/Sec      |
| NFS4\_OPENATTR\_LATENCY                | Average latency of NFS4\_OPENATTR operations                 | Microseconds |
| NFS4\_OPENATTR\_OPS                    | Number of NFS4\_OPENATTR operation per second                | Ops/Sec      |
| NFS4\_OPEN\_CONFIRM\_LATENCY           | Average latency of NFS4\_OPEN\_CONFIRM operations            | Microseconds |
| NFS4\_OPEN\_CONFIRM\_OPS               | Number of NFS4\_OPEN\_CONFIRM operation per second           | Ops/Sec      |
| NFS4\_OPEN\_DOWNGRADE\_LATENCY         | Average latency of NFS4\_OPEN\_DOWNGRADE operations          | Microseconds |
| NFS4\_OPEN\_DOWNGRADE\_OPS             | Number of NFS4\_OPEN\_DOWNGRADE operation per second         | Ops/Sec      |
| NFS4\_OPEN\_LATENCY                    | Average latency of NFS4\_OPEN operations                     | Microseconds |
| NFS4\_OPEN\_OPS                        | Number of NFS4\_OPEN operation per second                    | Ops/Sec      |
| NFS4\_PUTFH\_LATENCY                   | Average latency of NFS4\_PUTFH operations                    | Microseconds |
| NFS4\_PUTFH\_OPS                       | Number of NFS4\_PUTFH operation per second                   | Ops/Sec      |
| NFS4\_PUTPUBFH\_LATENCY                | Average latency of NFS4\_PUTPUBFH operations                 | Microseconds |
| NFS4\_PUTPUBFH\_OPS                    | Number of NFS4\_PUTPUBFH operation per second                | Ops/Sec      |
| NFS4\_PUTROOTFH\_LATENCY               | Average latency of NFS4\_PUTROOTFH operations                | Microseconds |
| NFS4\_PUTROOTFH\_OPS                   | Number of NFS4\_PUTROOTFH operation per second               | Ops/Sec      |
| NFS4\_RECLAIM\_COMPLETE\_LATENCY       | Average latency of NFS4\_RECLAIM\_COMPLETE operations        | Microseconds |
| NFS4\_RECLAIM\_COMPLETE\_OPS           | Number of NFS4\_RECLAIM\_COMPLETE operation per second       | Ops/Sec      |
| NFS4\_RELEASE\_LOCKOWNER\_LATENCY      | Average latency of NFS4\_RELEASE\_LOCKOWNER operations       | Microseconds |
| NFS4\_RELEASE\_LOCKOWNER\_OPS          | Number of NFS4\_RELEASE\_LOCKOWNER operation per second      | Ops/Sec      |
| NFS4\_RENEW\_LATENCY                   | Average latency of NFS4\_RENEW operations                    | Microseconds |
| NFS4\_RENEW\_OPS                       | Number of NFS4\_RENEW operation per second                   | Ops/Sec      |
| NFS4\_RESTOREFH\_LATENCY               | Average latency of NFS4\_RESTOREFH operations                | Microseconds |
| NFS4\_RESTOREFH\_OPS                   | Number of NFS4\_RESTOREFH operation per second               | Ops/Sec      |
| NFS4\_SAVEFH\_LATENCY                  | Average latency of NFS4\_SAVEFH operations                   | Microseconds |
| NFS4\_SAVEFH\_OPS                      | Number of NFS4\_SAVEFH operation per second                  | Ops/Sec      |
| NFS4\_SECINFO\_LATENCY                 | Average latency of NFS4\_SECINFO operations                  | Microseconds |
| NFS4\_SECINFO\_NO\_NAME\_LATENCY       | Average latency of NFS4\_SECINFO\_NO\_NAME operations        | Microseconds |
| NFS4\_SECINFO\_NO\_NAME\_OPS           | Number of NFS4\_SECINFO\_NO\_NAME operation per second       | Ops/Sec      |
| NFS4\_SECINFO\_OPS                     | Number of NFS4\_SECINFO operation per second                 | Ops/Sec      |
| NFS4\_SEQUENCE\_LATENCY                | Average latency of NFS4\_SEQUENCE operations                 | Microseconds |
| NFS4\_SEQUENCE\_OPS                    | Number of NFS4\_SEQUENCE operation per second                | Ops/Sec      |
| NFS4\_SETCLIENTID\_CONFIRM\_LATENCY    | Average latency of NFS4\_SETCLIENTID\_CONFIRM operations     | Microseconds |
| NFS4\_SETCLIENTID\_CONFIRM\_OPS        | Number of NFS4\_SETCLIENTID\_CONFIRM operation per second    | Ops/Sec      |
| NFS4\_SETCLIENTID\_LATENCY             | Average latency of NFS4\_SETCLIENTID operations              | Microseconds |
| NFS4\_SETCLIENTID\_OPS                 | Number of NFS4\_SETCLIENTID operation per second             | Ops/Sec      |
| NFS4\_SET\_SSV\_LATENCY                | Average latency of NFS4\_SET\_SSV operations                 | Microseconds |
| NFS4\_SET\_SSV\_OPS                    | Number of NFS4\_SET\_SSV operation per second                | Ops/Sec      |
| NFS4\_TEST\_STATEID\_LATENCY           | Average latency of NFS4\_TEST\_STATEID operations            | Microseconds |
| NFS4\_TEST\_STATEID\_OPS               | Number of NFS4\_TEST\_STATEID operation per second           | Ops/Sec      |
| NFS4\_VERIFY\_LATENCY                  | Average latency of NFS4\_VERIFY operations                   | Microseconds |
| NFS4\_VERIFY\_OPS                      | Number of NFS4\_VERIFY operation per second                  | Ops/Sec      |
| NFS4\_WANT\_DELEGATION\_LATENCY        | Average latency of NFS4\_WANT\_DELEGATION operations         | Microseconds |
| NFS4\_WANT\_DELEGATION\_OPS            | Number of NFS4\_WANT\_DELEGATION operation per second        | Ops/Sec      |
| OPS                                    | Total number of operations                                   | Ops/Sec      |
| READDIR\_LATENCY                       | Average latency of READDIR operations                        | Microseconds |
| READDIR\_OPS                           | Number of READDIR operation per second                       | Ops/Sec      |
| READLINK\_LATENCY                      | Average latency of READLINK operations                       | Microseconds |
| READLINK\_OPS                          | Number of READLINK operation per second                      | Ops/Sec      |
| READ\_BYTES                            | Number of bytes read per second                              | Bytes/Sec    |
| READ\_LATENCY                          | Average latency of READ operations                           | Microseconds |
| READ\_OPS                              | Number of READ operation per second                          | Ops/Sec      |
| REMOVE\_LATENCY                        | Average latency of REMOVE operations                         | Microseconds |
| REMOVE\_OPS                            | Number of REMOVE operation per second                        | Ops/Sec      |
| RENAME\_LATENCY                        | Average latency of RENAME operations                         | Microseconds |
| RENAME\_OPS                            | Number of RENAME operation per second                        | Ops/Sec      |
| SETATTR\_LATENCY                       | Average latency of SETATTR operations                        | Microseconds |
| SETATTR\_OPS                           | Number of SETATTR operation per second                       | Ops/Sec      |
| THROUGHPUT                             | Number of byte read/writes per second                        | Bytes/Sec    |
| WRITE\_BYTES                           | Number of byte writes per second                             | Bytes/Sec    |
| WRITE\_LATENCY                         | Average latency of WRITE operations                          | Microseconds |
| WRITE\_OPS                             | Number of WRITE operation per second                         | Ops/Sec      |

### Operations (S3)

| **Type**                              | **Description**                                      | **Units**    |
| ------------------------------------- | ---------------------------------------------------- | ------------ |
| AVG\_COPY\_OPS                        | Average copy operations per second                   | Ops/Sec      |
| AVG\_DELETE\_OPS                      | Average delete operations per second                 | Ops/Sec      |
| AVG\_GET\_OPS                         | Average get operations per second                    | Ops/Sec      |
| AVG\_LIST\_V1\_OPS                    | Average list v1 operations per second                | Ops/Sec      |
| AVG\_LIST\_V2\_OPS                    | Average list v2 operations per second                | Ops/Sec      |
| AVG\_MULTIPART\_UPLOAD\_OPS           | Average multipart upload operations per second       | Ops/Sec      |
| AVG\_PUT\_OBJECTPART\_OPS             | Average put objectpart operations per second         | Ops/Sec      |
| AVG\_PUT\_OPS                         | Average put operations per second                    | Ops/Sec      |
| READ\_BYTES                           | Number of byte reads per second                      | Bytes/Sec    |
| THROUGHPUT                            | Throughput                                           | Bytes/Sec    |
| TOTAL\_BUCKET\_CREATE\_OPS            | Total bucket create operations per second            | Ops/Sec      |
| TOTAL\_BUCKET\_DELETE\_OPS            | Total bucket delete operation per seconds            | Ops/Sec      |
| TOTAL\_BUCKET\_LIST\_OPS              | Total bucket list operations per second              | Ops/Sec      |
| TOTAL\_COPY\_LATENCY                  | Average latency of Copy operations                   | Microseconds |
| TOTAL\_COPY\_OPS                      | Total Copy operations                                | Ops          |
| TOTAL\_DELETE\_OPS                    | Total delete operations                              | Ops          |
| TOTAL\_GET\_BUCKET\_ACL\_OPS          | Total get bucket acl operations per second           | Ops/Sec      |
| TOTAL\_GET\_BUCKET\_NOTIFICATION\_OPS | Total get bucket notifications operations per second | Ops/Sec      |
| TOTAL\_GET\_LATENCY                   | Average latency of Get operations                    | Microseconds |
| TOTAL\_GET\_OPS                       | Total Get operations                                 | Ops          |
| TOTAL\_LIST\_V1\_OPS                  | Total list v1 operations                             | Ops          |
| TOTAL\_LIST\_V2\_OPS                  | Total list v2 operations                             | Ops          |
| TOTAL\_MULTIPART\_UPLOAD\_LATENCY     | Average latency of Multipart upload operations       | Microseconds |
| TOTAL\_MULTIPART\_UPLOAD\_OPS         | Total multipart upload operations                    | Ops          |
| TOTAL\_PUT\_BUCKET\_ACL\_OPS          | Total put bucket acl operations per second           | Ops/Sec      |
| TOTAL\_PUT\_LATENCY                   | Average latency of Put operations                    | Microseconds |
| TOTAL\_PUT\_OBJECTPART\_OPS           | Total put objectpart operations                      | Ops          |
| TOTAL\_PUT\_OPS                       | Total put operations                                 | Ops          |
| WRITE\_BYTES                          | Number of byte writes per seconds                    | Bytes/Sec    |

### Operations (SLB of S3)

| **Type**                                | **Description**                            | **Units** |
| --------------------------------------- | ------------------------------------------ | --------- |
| AVG\_1xx\_RQ                            | Average 1xx replies per second             | Ops/Sec   |
| AVG\_2xx\_RQ                            | Average 2xx replies per second             | Ops/Sec   |
| AVG\_3xx\_RQ                            | Average 3xx replies per second             | Ops/Sec   |
| AVG\_4xx\_RQ                            | Average 4xx replies per second             | Ops/Sec   |
| AVG\_5xx\_RQ                            | Average 5xx replies per second             | Ops/Sec   |
| TOTAL\_1xx\_RQ                          | Total 1xx replies                          | Ops       |
| TOTAL\_2xx\_RQ                          | Total 2xx replies                          | Ops       |
| TOTAL\_3xx\_RQ                          | Total 3xx replies                          | Ops       |
| TOTAL\_4xx\_RQ                          | Total 4xx replies                          | Ops       |
| TOTAL\_5xx\_RQ                          | Total 5xx replies                          | Ops       |
| TOTAL\_max\_duration\_RQ                | Total Max Duration Reached replies         | Ops       |
| TOTAL\_rejected\_via\_ip\_detection\_RQ | Total Rejected by IP Detection replies     | Ops       |
| TOTAL\_response\_before\_complete\_RQ   | Total S3 Responses before Complete replies | Ops       |
| TOTAL\_rx\_reset\_RQ                    | Total User RX Reset Connection replies     | Ops       |
| TOTAL\_tx\_reset\_RQ                    | Total Envoy TX Reset Connection replies    | Ops       |

### Operations (driver)

| **Type**                                     | **Description**                                                                            | **Units**    |
| -------------------------------------------- | ------------------------------------------------------------------------------------------ | ------------ |
| DIRECT\_READ\_SIZES\_RATE                    | The number of O\_DIRECT reads per each read size range per second                          | Reads        |
| DIRECT\_READ\_SIZES                          | The number of O\_DIRECT reads per each read size range                                     | Reads        |
| DIRECT\_WRITE\_SIZES\_RATE                   | The number of O\_DIRECT writes per each read size range per second                         | Writes       |
| DIRECT\_WRITE\_SIZES                         | The number of O\_DIRECT writes per each read size range                                    | Writes       |
| DOORBELL\_RING\_COUNT                        | The number of times the driver queue's doorbell was ringed                                 | Ops          |
| FAILED\_1HOP\_READS                          | Number of failed single hop reads per second                                               | Ops/Sec      |
| FILEATOMICOPEN\_LATENCY                      | Average latency of FILEATOMICOPEN operations                                               | Microseconds |
| FILEATOMICOPEN\_OPS                          | Number of FILEATOMICOPEN operation per second                                              | Ops/Sec      |
| FILEATOMICOPEN\_QOS\_DELAY                   | Average QoS delay for FILEATOMICOPEN operations                                            | Microseconds |
| FILECLOSE\_LATENCY                           | Average latency of FILECLOSE operations                                                    | Microseconds |
| FILECLOSE\_OPS                               | Number of FILECLOSE operation per second                                                   | Ops/Sec      |
| FILECLOSE\_QOS\_DELAY                        | Average QoS delay for FILECLOSE operations                                                 | Microseconds |
| FILEOPEN\_LATENCY                            | Average latency of FILEOPEN operations                                                     | Microseconds |
| FILEOPEN\_OPS                                | Number of FILEOPEN operation per second                                                    | Ops/Sec      |
| FILEOPEN\_QOS\_DELAY                         | Average QoS delay for FILEOPEN operations                                                  | Microseconds |
| FLOCK\_LATENCY                               | Average latency of FLOCK operations                                                        | Microseconds |
| FLOCK\_OPS                                   | Number of FLOCK operation per second                                                       | Ops/Sec      |
| FLOCK\_QOS\_DELAY                            | Average QoS delay for FLOCK operations                                                     | Microseconds |
| GETATTR\_LATENCY                             | Average latency of GETATTR operations                                                      | Microseconds |
| GETATTR\_OPS                                 | Number of GETATTR operation per second                                                     | Ops/Sec      |
| GETATTR\_QOS\_DELAY                          | Average QoS delay for GETATTR operations                                                   | Microseconds |
| GETXATTR\_LATENCY                            | Average latency of GETXATTR operations                                                     | Microseconds |
| GETXATTR\_OPS                                | Number of GETXATTR operation per second                                                    | Ops/Sec      |
| GETXATTR\_QOS\_DELAY                         | Average QoS delay for GETXATTR operations                                                  | Microseconds |
| IOCTL\_OBS\_PREFETCH\_LATENCY                | Average latency of IOCTL\_OBS\_PREFETCH operations                                         | Microseconds |
| IOCTL\_OBS\_PREFETCH\_OPS                    | Number of IOCTL\_OBS\_PREFETCH operation per second                                        | Ops/Sec      |
| IOCTL\_OBS\_PREFETCH\_QOS\_DELAY             | Average QoS delay for IOCTL\_OBS\_PREFETCH operations                                      | Microseconds |
| IOCTL\_OBS\_RELEASE\_LATENCY                 | Average latency of IOCTL\_OBS\_RELEASE operations                                          | Microseconds |
| IOCTL\_OBS\_RELEASE\_OPS                     | Number of IOCTL\_OBS\_RELEASE operation per second                                         | Ops/Sec      |
| IOCTL\_OBS\_RELEASE\_QOS\_DELAY              | Average QoS delay for IOCTL\_OBS\_RELEASE operations                                       | Microseconds |
| KEEPALIVES\_NO\_LEASE                        | Number of driver keepalives sent while we have no lease                                    | Ops/Sec      |
| LINK\_LATENCY                                | Average latency of LINK operations                                                         | Microseconds |
| LINK\_OPS                                    | Number of LINK operation per second                                                        | Ops/Sec      |
| LINK\_QOS\_DELAY                             | Average QoS delay for LINK operations                                                      | Microseconds |
| LISTXATTR\_LATENCY                           | Average latency of LISTXATTR operations                                                    | Microseconds |
| LISTXATTR\_OPS                               | Number of LISTXATTR operation per second                                                   | Ops/Sec      |
| LISTXATTR\_QOS\_DELAY                        | Average QoS delay for LISTXATTR operations                                                 | Microseconds |
| LOOKUP\_LATENCY                              | Average latency of LOOKUP operations                                                       | Microseconds |
| LOOKUP\_OPS                                  | Number of LOOKUP operation per second                                                      | Ops/Sec      |
| LOOKUP\_QOS\_DELAY                           | Average QoS delay for LOOKUP operations                                                    | Microseconds |
| MKNOD\_LATENCY                               | Average latency of MKNOD operations                                                        | Microseconds |
| MKNOD\_OPS                                   | Number of MKNOD operation per second                                                       | Ops/Sec      |
| MKNOD\_QOS\_DELAY                            | Average QoS delay for MKNOD operations                                                     | Microseconds |
| OPS                                          | Total number of operations                                                                 | Ops/Sec      |
| RDMA\_WRITE\_REQUESTS                        | Number of RDMA write request operations per second                                         | Ops/Sec      |
| READDIR\_LATENCY                             | Average latency of READDIR operations                                                      | Microseconds |
| READDIR\_OPS                                 | Number of READDIR operation per second                                                     | Ops/Sec      |
| READDIR\_QOS\_DELAY                          | Average QoS delay for READDIR operations                                                   | Microseconds |
| READLINK\_LATENCY                            | Average latency of READLINK operations                                                     | Microseconds |
| READLINK\_OPS                                | Number of READLINK operation per second                                                    | Ops/Sec      |
| READLINK\_QOS\_DELAY                         | Average QoS delay for READLINK operations                                                  | Microseconds |
| READS\_NO\_LEASE                             | Number of direct reads while we have no lease                                              | Ops/Sec      |
| READS                                        | Number of read operations per second                                                       | Ops/Sec      |
| READ\_BYTES\_1HOP                            | Number of bytes read per second via single hop                                             | Bytes/Sec    |
| READ\_BYTES                                  | Number of bytes read per second                                                            | Bytes/Sec    |
| READ\_CHECKSUM\_ERRORS                       | The number of times the driver's checksum validation failed upon the read's content        | Ops          |
| READ\_CORRUPTIONS\_DETECTED\_IN\_1HOP        | The number of corrupt data blocks encountered during 1-hop read                            | Ops          |
| READ\_DURATION                               | The number of reads per each time duration                                                 | Reads        |
| READ\_LATENCY\_NO\_QOS                       | Average latency of READ operations without QoS delay                                       | Microseconds |
| READ\_LATENCY                                | Average latency of READ operations                                                         | Microseconds |
| READ\_PARENT\_SELINUX\_ATTRIBUTE             | The number of times we could not get SELinux attribute from parent                         | Ops          |
| READ\_QOS\_DELAY                             | Average QoS delay for READ operations                                                      | Microseconds |
| READ\_RDMA\_SIZES\_RATE                      | The number of RDMA reads per each read size range per second                               | Reads        |
| READ\_RDMA\_SIZES                            | The number of RDMA reads per each read size range                                          | Reads        |
| READ\_SIZES\_RATE                            | The number of reads per each read size range per second                                    | Reads        |
| READ\_SIZES                                  | The number of reads per each read size range                                               | Reads        |
| RENAME\_LATENCY                              | Average latency of RENAME operations                                                       | Microseconds |
| RENAME\_OPS                                  | Number of RENAME operation per second                                                      | Ops/Sec      |
| RENAME\_QOS\_DELAY                           | Average QoS delay for RENAME operations                                                    | Microseconds |
| REQUESTS\_COMPLETED                          | The number of completions frontends sent to driver's queue                                 | Ops          |
| REQUESTS\_FETCHED                            | The number of operations frontends fetched from driver's queue                             | Ops          |
| RMDIR\_LATENCY                               | Average latency of RMDIR operations                                                        | Microseconds |
| RMDIR\_OPS                                   | Number of RMDIR operation per second                                                       | Ops/Sec      |
| RMDIR\_QOS\_DELAY                            | Average QoS delay for RMDIR operations                                                     | Microseconds |
| RMXATTR\_LATENCY                             | Average latency of RMXATTR operations                                                      | Microseconds |
| RMXATTR\_OPS                                 | Number of RMXATTR operation per second                                                     | Ops/Sec      |
| RMXATTR\_QOS\_DELAY                          | Average QoS delay for RMXATTR operations                                                   | Microseconds |
| SETATTR\_LATENCY                             | Average latency of SETATTR operations                                                      | Microseconds |
| SETATTR\_OPS                                 | Number of SETATTR operation per second                                                     | Ops/Sec      |
| SETATTR\_QOS\_DELAY                          | Average QoS delay for SETATTR operations                                                   | Microseconds |
| SETXATTR\_LATENCY                            | Average latency of SETXATTR operations                                                     | Microseconds |
| SETXATTR\_OPS                                | Number of SETXATTR operation per second                                                    | Ops/Sec      |
| SETXATTR\_QOS\_DELAY                         | Average QoS delay for SETXATTR operations                                                  | Microseconds |
| SKIPPED\_1HOP\_READS\_DISABLED               | Number of skipped single hop reads per second because it is disabled                       | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_EXTERNAL\_RDMA\_SPARSE | Number of skipped single hop reads per second because it is a sparse read on external RDMA | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_GET\_EXTENT\_FAILED    | Number of skipped single hop reads per second due to get extent failed                     | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_PARTIAL\_READ          | Number of skipped single hop reads per second due to partial read failure                  | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_SSD\_LOAD              | Number of skipped single hop reads per second due to drive load                            | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_TOO\_MANY\_DESCRIPTORS | Number of skipped single hop reads per second due to too many descriptors                  | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_TOO\_MANY\_DRIVES      | Number of skipped single hop reads per second due to too many drives                       | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_TOO\_SMALL             | Number of skipped single hop reads per second because IO is too small                      | Ops/Sec      |
| STATFS\_LATENCY                              | Average latency of STATFS operations                                                       | Microseconds |
| STATFS\_OPS                                  | Number of STATFS operation per second                                                      | Ops/Sec      |
| STATFS\_QOS\_DELAY                           | Average QoS delay for STATFS operations                                                    | Microseconds |
| SUCCEEDED\_1HOP\_READS                       | Number of succesfull single hop reads per second                                           | Ops/Sec      |
| SYMLINK\_LATENCY                             | Average latency of SYMLINK operations                                                      | Microseconds |
| SYMLINK\_OPS                                 | Number of SYMLINK operation per second                                                     | Ops/Sec      |
| SYMLINK\_QOS\_DELAY                          | Average QoS delay for SYMLINK operations                                                   | Microseconds |
| THROUGHPUT                                   | Number of byte read/writes per second                                                      | Bytes/Sec    |
| UNLINK\_LATENCY                              | Average latency of UNLINK operations                                                       | Microseconds |
| UNLINK\_OPS                                  | Number of UNLINK operation per second                                                      | Ops/Sec      |
| UNLINK\_QOS\_DELAY                           | Average QoS delay for UNLINK operations                                                    | Microseconds |
| WRITES\_NO\_LEASE                            | Number of direct writes while we have no lease                                             | Ops/Sec      |
| WRITES                                       | Number of write operations per second                                                      | Ops/Sec      |
| WRITE\_BYTES                                 | Number of byte writes per second                                                           | Bytes/Sec    |
| WRITE\_DURATION                              | The number of writes per each time duration                                                | Writes       |
| WRITE\_LATENCY\_NO\_QOS                      | Average latency of WRITE operations without QoS delay                                      | Microseconds |
| WRITE\_LATENCY                               | Average latency of WRITE operations                                                        | Microseconds |
| WRITE\_QOS\_DELAY                            | Average QoS delay for WRITE operations                                                     | Microseconds |
| WRITE\_RDMA\_SIZES\_RATE                     | The number of RDMA writes per each read size range per second                              | Writes       |
| WRITE\_RDMA\_SIZES                           | The number of RDMA writes per each read size range                                         | Writes       |
| WRITE\_SIZES\_RATE                           | The number of writes per each read size range per second                                   | Writes       |
| WRITE\_SIZES                                 | The number of writes per each read size range                                              | Writes       |

### Operations

| **Type**                | **Description**                               | **Units**    |
| ----------------------- | --------------------------------------------- | ------------ |
| ACCESS\_LATENCY         | Average latency of ACCESS operations          | Microseconds |
| ACCESS\_OPS             | Number of ACCESS operation per second         | Ops/Sec      |
| COMMIT\_LATENCY         | Average latency of COMMIT operations          | Microseconds |
| COMMIT\_OPS             | Number of COMMIT operation per second         | Ops/Sec      |
| CREATE\_LATENCY         | Average latency of CREATE operations          | Microseconds |
| CREATE\_OPS             | Number of CREATE operation per second         | Ops/Sec      |
| FILEATOMICOPEN\_LATENCY | Average latency of FILEATOMICOPEN operations  | Microseconds |
| FILEATOMICOPEN\_OPS     | Number of FILEATOMICOPEN operation per second | Ops/Sec      |
| FILECLOSE\_LATENCY      | Average latency of FILECLOSE operations       | Microseconds |
| FILECLOSE\_OPS          | Number of FILECLOSE operation per second      | Ops/Sec      |
| FILEOPEN\_LATENCY       | Average latency of FILEOPEN operations        | Microseconds |
| FILEOPEN\_OPS           | Number of FILEOPEN operation per second       | Ops/Sec      |
| FLOCK\_LATENCY          | Average latency of FLOCK operations           | Microseconds |
| FLOCK\_OPS              | Number of FLOCK operation per second          | Ops/Sec      |
| FSINFO\_LATENCY         | Average latency of FSINFO operations          | Microseconds |
| FSINFO\_OPS             | Number of FSINFO operation per second         | Ops/Sec      |
| GETATTR\_LATENCY        | Average latency of GETATTR operations         | Microseconds |
| GETATTR\_OPS            | Number of GETATTR operation per second        | Ops/Sec      |
| LINK\_LATENCY           | Average latency of LINK operations            | Microseconds |
| LINK\_OPS               | Number of LINK operation per second           | Ops/Sec      |
| LOOKUP\_LATENCY         | Average latency of LOOKUP operations          | Microseconds |
| LOOKUP\_OPS             | Number of LOOKUP operation per second         | Ops/Sec      |
| MKDIR\_LATENCY          | Average latency of MKDIR operations           | Microseconds |
| MKDIR\_OPS              | Number of MKDIR operation per second          | Ops/Sec      |
| MKNOD\_LATENCY          | Average latency of MKNOD operations           | Microseconds |
| MKNOD\_OPS              | Number of MKNOD operation per second          | Ops/Sec      |
| OPS                     | Total number of operations                    | Ops/Sec      |
| PATHCONF\_LATENCY       | Average latency of PATHCONF operations        | Microseconds |
| PATHCONF\_OPS           | Number of PATHCONF operation per second       | Ops/Sec      |
| READDIR\_LATENCY        | Average latency of READDIR operations         | Microseconds |
| READDIR\_OPS            | Number of READDIR operation per second        | Ops/Sec      |
| READLINK\_LATENCY       | Average latency of READLINK operations        | Microseconds |
| READLINK\_OPS           | Number of READLINK operation per second       | Ops/Sec      |
| READS                   | Number of read operations per second          | Ops/Sec      |
| READ\_BYTES             | Number of bytes read per second               | Bytes/Sec    |
| READ\_DURATION          | The number of reads per completion duration   | Reads        |
| READ\_LATENCY           | Average latency of READ operations            | Microseconds |
| REMOVE\_LATENCY         | Average latency of REMOVE operations          | Microseconds |
| REMOVE\_OPS             | Number of REMOVE operation per second         | Ops/Sec      |
| RENAME\_LATENCY         | Average latency of RENAME operations          | Microseconds |
| RENAME\_OPS             | Number of RENAME operation per second         | Ops/Sec      |
| RMDIR\_LATENCY          | Average latency of RMDIR operations           | Microseconds |
| RMDIR\_OPS              | Number of RMDIR operation per second          | Ops/Sec      |
| SETATTR\_LATENCY        | Average latency of SETATTR operations         | Microseconds |
| SETATTR\_OPS            | Number of SETATTR operation per second        | Ops/Sec      |
| STATFS\_LATENCY         | Average latency of STATFS operations          | Microseconds |
| STATFS\_OPS             | Number of STATFS operation per second         | Ops/Sec      |
| SYMLINK\_LATENCY        | Average latency of SYMLINK operations         | Microseconds |
| SYMLINK\_OPS            | Number of SYMLINK operation per second        | Ops/Sec      |
| THROUGHPUT              | Number of byte read/writes per second         | Bytes/Sec    |
| UNLINK\_LATENCY         | Average latency of UNLINK operations          | Microseconds |
| UNLINK\_OPS             | Number of UNLINK operation per second         | Ops/Sec      |
| WRITES                  | Number of write operations per second         | Ops/Sec      |
| WRITE\_BYTES            | Number of byte writes per second              | Bytes/Sec    |
| WRITE\_DURATION         | The number of writes per completion duration  | Writes       |
| WRITE\_LATENCY          | Average latency of WRITE operations           | Microseconds |

### Processes

| **Type**                  | **Description**                                                              | **Units**               |
| ------------------------- | ---------------------------------------------------------------------------- | ----------------------- |
| ABRUPT\_EXITS             | How many abrupt exits of a process (node) occured                            | Abrupt process exits    |
| PEER\_CONFIGURE\_FAILURES | How many times the node failed to configure peers in order to sync with them | Peer configure failures |

### RAFT

| **Type**                           | **Description**                                     | **Units** |
| ---------------------------------- | --------------------------------------------------- | --------- |
| Bucket\_LEADER\_CHANGES            | Changes of leader                                   | Changes   |
| Bucket\_REQUESTS\_COMPLETED        | Requests to leader completed successfully           | Requests  |
| Configuration\_LEADER\_CHANGES     | Changes of leader                                   | Changes   |
| Configuration\_REQUESTS\_COMPLETED | Requests to leader completed successfully           | Requests  |
| Invalid\_LEADER\_CHANGES           | Changes of leader                                   | Changes   |
| Invalid\_REQUESTS\_COMPLETED       | Requests to leader completed successfully           | Requests  |
| SYNCLOG\_TIMEOUTS                  | The number of timeouts of syncing logs to a process | Timeouts  |
| Test\_LEADER\_CHANGES              | Changes of leader                                   | Changes   |
| Test\_REQUESTS\_COMPLETED          | Requests to leader completed successfully           | Requests  |

### RAID

| **Type**                                     | **Description**                                                            | **Units**  |
| -------------------------------------------- | -------------------------------------------------------------------------- | ---------- |
| IS\_BLOCK\_USED\_FREE\_LATENCY               | Average latency of handling an isBlockUsed of a free block                 | Micros     |
| IS\_BLOCK\_USED\_FREE                        | Number of isBlockUsed returning free                                       | Blocks/Sec |
| IS\_BLOCK\_USED\_USED\_LATENCY               | Average latency of handling an isBlockUsed of a used block                 | Micros     |
| IS\_BLOCK\_USED\_USED                        | Number of isBlockUsed returning used                                       | Blocks/Sec |
| NVKV\_RECOVERY\_NETBUF\_REREAD\_UNEQUAL      | Number of unequal netbufs encountered that caused NVKV recovery to restart | Blocks/Sec |
| RAID\_BLOCKS\_IN\_PREPARED\_STRIPE           | Free blocks in prepared stripe                                             | Blocks     |
| RAID\_CHUNKS\_CLEANED\_BY\_SHIFT             | Dirty chunks cleaned by being shifted out                                  | Occurences |
| RAID\_CHUNKS\_SHIFTED                        | Dirty chunks that shifted out                                              | Occurences |
| RAID\_COMMITTED\_STRIPES                     | Number of stripes written                                                  | Stripes    |
| RAID\_COMPRESSED\_BLOCKS\_WRITTEN            | Physical blocks written containing compressed data                         | Blocks/Sec |
| RAID\_CORRUPTION\_RECOVERY\_FAILURE          | Corrupt data could not be recovered                                        | Occurences |
| RAID\_PLACEMENT\_SWITCHES                    | Number of placement switches                                               | Switches   |
| RAID\_READ\_BATCHES\_PER\_REQUEST\_HISTOGRAM | Histogram of the number of batches of stripes read in a single request     | Request    |
| RAID\_READ\_BLOCKS\_STRIPE\_HISTOGRAM        | Histogram of the number of blocks read from a single stripe                | Reads      |
| RAID\_READ\_BLOCKS                           | Number of blocks read by the RAID                                          | Blocks/Sec |
| RAID\_READ\_DEGRADED                         | Degraded mode reads                                                        | Blocks/Sec |
| RAID\_READ\_FREE                             | Read Free                                                                  | Occurences |
| RAID\_READ\_IOS                              | Raw read blocks performed by the RAID                                      | Blocks/Sec |
| RAID\_STALE\_WRITES\_DETECTED                | Stale write detected in read                                               | Occurences |
| RAID\_STALE\_WRITES\_REPROTECTIONS           | Stale write reprotections in read                                          | Occurences |
| WRONG\_DRIVE\_DELTAS                         | Delta segments written to wrong drive                                      | Blocks/Sec |
| WRONG\_DRIVE\_REFS                           | Reference segments written to wrong drive                                  | Blocks/Sec |

### RPC

| **Type**                           | **Description**                                                    | **Units**    |
| ---------------------------------- | ------------------------------------------------------------------ | ------------ |
| CLIENT\_CANCELED\_REQUESTS         | Number of requests cancelled by the client                         | Calls/Sec    |
| CLIENT\_DROPPED\_RESPONSES         | Number of responses dropped by the client                          | Calls/Sec    |
| CLIENT\_ENCRYPTION\_AUTH\_FAILURES | Number of authentication failures by the client                    | Calls/Sec    |
| CLIENT\_MISSING\_ENCRYPTION\_KEY   | Number of times client was missing an encryption key               | Calls/Sec    |
| CLIENT\_RECEIVED\_EXCEPTIONS       | Number of exceptions received by the client                        | Calls/Sec    |
| CLIENT\_RECEIVED\_RESPONSES        | Number of responses received by the client                         | Calls/Sec    |
| CLIENT\_RECEIVED\_TIMEOUTS         | Number of timeouts experienced by the client                       | Calls/Sec    |
| CLIENT\_ROUNDTRIP\_AVG\_LOW        | Roundtrip average of client low-priority RPC calls                 | Microseconds |
| CLIENT\_ROUNDTRIP\_AVG\_NORM       | Roundtrip average of client normal priority RPC calls              | Microseconds |
| CLIENT\_ROUNDTRIP\_AVG             | Roundtrip average of client normal and low priority RPC calls      | Microseconds |
| CLIENT\_RPC\_CALLS\_DOWNGRADED     | Number of client-downgraded RPC calls                              | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_LOW            | Number of low priority RPC calls                                   | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_NORM           | Number of normal priority RPC calls                                | RPC/Sec      |
| CLIENT\_RPC\_CALLS                 | Number of all priorities of RPC calls                              | RPC/Sec      |
| CLIENT\_SENT\_REQUESTS             | Number of requests sent by the client                              | Calls/Sec    |
| DEUS\_EX\_MBUF\_LIMITED            | Number of RPCs slow down due to low MBuf reserves                  | Ops/Sec      |
| DEUS\_EX\_NOT\_EMPTY               | Number of RPCs put in DeusEx to preserve RPC order                 | Ops/Sec      |
| DEUS\_EX\_NO\_FIBERS               | Number of RPCs put in DeusEx due to lack of global fibers          | Ops/Sec      |
| DEUS\_EX\_RPC\_MAX\_FIBERS         | Number of RPCs put in DeusEx due to RPC max fibers                 | Ops/Sec      |
| FIRST\_RESULTS                     | Number of first results per second                                 | Ops/Sec      |
| MBUF\_LIMITED\_SLEEP               | Number of times wait due to low MBuf reserves                      | Actions/Sec  |
| RPC\_ENCRYPTION\_SETUP\_FAILURES   | Number of encryptiuon key setup failures                           | Failures     |
| SERVER\_ABORTS                     | Number of server received aborts                                   | Calls/Sec    |
| SERVER\_DROPPED\_REQUESTS          | Number of requests dropped by the server                           | Calls/Sec    |
| SERVER\_ENCRYPTION\_AUTH\_FAILURES | Number of encryption authentication failures at the server         | Calls/Sec    |
| SERVER\_MISSING\_ENCRYPTION\_KEY   | Number of requests missing encryption key at the server            | Calls/Sec    |
| SERVER\_PROCESSING\_AVG            | Average time to process server RPC calls                           | Microseconds |
| SERVER\_PROCESSING\_TIME           | Histogram of the time it took the server to process a request      | RPCs         |
| SERVER\_REJECTS                    | Number of times the server rejected a request                      | Calls/Sec    |
| SERVER\_RPC\_CALLS\_UPGRADED       | Number of server-upgraded RPC calls                                | RPC/Sec      |
| SERVER\_RPC\_CALLS                 | Number of server RPC calls                                         | RPC/Sec      |
| SERVER\_SENT\_EXCEPTIONS           | Number of exceptions sent by the server as a response              | Calls/Sec    |
| SERVER\_SENT\_RESPONSES            | Number of responses the server sent                                | Calls/Sec    |
| SERVER\_UNENCRYPTED\_REFUSALS      | Number of requests refused due to missing encryption at the server | Calls/Sec    |
| TIME\_TO\_FIRST\_RESULT            | Average latency to the first result of a MultiCall                 | Microseconds |

### Reactor

| **Type**                            | **Description**                                                                                                                                            | **Units**               |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| BACKGROUND\_CYCLES                  | Number of cycles spent in background fibers                                                                                                                | Cycles/Sec              |
| BACKGROUND\_FIBERS                  | Number of background fibers that are ready to run and eager to get CPU cycles                                                                              | Fibers                  |
| BACKGROUND\_TIME                    | The percentage of the CPU time used for background operations                                                                                              | %                       |
| BucketInvocationState\_CAPACITY     | Number of data structures allocated to the BucketInvocationState pool                                                                                      | Structs                 |
| BucketInvocationState\_STRUCT\_SIZE | Number of bytes in each struct of the BucketInvocationState pool                                                                                           | Bytes                   |
| BucketInvocationState\_USED         | Number of structs in the BucketInvocationState pool which are currently being used                                                                         | Structs                 |
| CYCLES\_PER\_SECOND                 | Number of cycles the cpu runs per second                                                                                                                   | Cycles/Sec              |
| DEFUNCT\_FIBERS                     | Number of defunct buffers, which are just memory structures allocated for future fiber needs                                                               | Fibers                  |
| DeferredTask2\_CAPACITY             | Number of data structures allocated to the DeferredTask2 pool                                                                                              | Structs                 |
| DeferredTask2\_STRUCT\_SIZE         | Number of bytes in each struct of the DeferredTask2 pool                                                                                                   | Bytes                   |
| DeferredTask2\_USED                 | Number of structs in the DeferredTask2 pool which are currently being used                                                                                 | Structs                 |
| EXCEPTIONS                          | Number of excpetions caught by the reactor                                                                                                                 | Exceptions/Sec          |
| HOGGED\_TIME                        | Histogram of time used by hogger fibers (only in debug builds)                                                                                             | Hogs                    |
| IDLE\_CALLBACK\_INVOCATIONS         | Number of background work invocations                                                                                                                      | Invocations/Sec         |
| IDLE\_CYCLES                        | Number of cycles spent in idle                                                                                                                             | Cycles/Sec              |
| IDLE\_TIME                          | The percentage of the CPU time not used for handling I/Os                                                                                                  | %                       |
| LINGERING\_FIBERS                   | Number of LINGERING fibers                                                                                                                                 | Fibers                  |
| NODE\_CONTEXT\_SWITCHES             | Number of context switches.                                                                                                                                | Switches                |
| NODE\_HANG                          | The number of process (node) hangs per hang time range.                                                                                                    | Number of hangs         |
| NODE\_POLL\_TIME                    | Time of scheduler stats polling.                                                                                                                           | usecs                   |
| NODE\_RUN\_PERCENTAGE               | Percentage of time process is running                                                                                                                      | percentage              |
| NODE\_RUN\_TIME                     | Time process is running.                                                                                                                                   | usecs                   |
| NODE\_WAIT\_PERCENTAGE              | Percentage of time process is waiting on waitqueue                                                                                                         | percentage              |
| NODE\_WAIT\_TIME                    | Time process is waiting on waitqueue.                                                                                                                      | usecs                   |
| OUTRAGEOUS\_HOGGERS                 | Number of hoggers taking excessive amount of time to run                                                                                                   | Invocations             |
| ObsBucketManagement\_CAPACITY       | Number of data structures allocated to the ObsBucketManagement pool                                                                                        | Structs                 |
| ObsBucketManagement\_STRUCT\_SIZE   | Number of bytes in each struct of the ObsBucketManagement pool                                                                                             | Bytes                   |
| ObsBucketManagement\_USED           | Number of structs in the ObsBucketManagement pool which are currently being used                                                                           | Structs                 |
| ObsGateway\_CAPACITY                | Number of data structures allocated to the ObsGateway pool                                                                                                 | Structs                 |
| ObsGateway\_STRUCT\_SIZE            | Number of bytes in each struct of the ObsGateway pool                                                                                                      | Bytes                   |
| ObsGateway\_USED                    | Number of structs in the ObsGateway pool which are currently being used                                                                                    | Structs                 |
| PENDING\_FIBERS                     | Number of fibers pending for external events, such as a network packet or SSD response. Upon such an external event, they change state to scheduled fibers | Fibers                  |
| SCHEDULED\_FIBERS                   | Number of current fibers that are ready to run and eager to get CPU cycles                                                                                 | Fibers                  |
| SLEEPY\_FIBERS                      | Number of SLEEPY fibers                                                                                                                                    | Fibers                  |
| SLEEPY\_RPC\_SERVER\_FIBERS         | Number of SLEEPY RPC server fibers                                                                                                                         | Sleepy fiber detections |
| SSD\_CAPACITY                       | Number of data structures allocated to the SSD pool                                                                                                        | Structs                 |
| SSD\_STRUCT\_SIZE                   | Number of bytes in each struct of the SSD pool                                                                                                             | Bytes                   |
| SSD\_USED                           | Number of structs in the SSD pool which are currently being used                                                                                           | Structs                 |
| STEP\_CYCLES                        | Histogram of time spent in a fiber                                                                                                                         | Fiber steps             |
| TIMER\_CALLBACKS                    | Current number of timer callbacks                                                                                                                          | Callbacks               |
| TOTAL\_FIBERS\_COUNT                | Number of fibers                                                                                                                                           | Fibers                  |
| TimedCallback\_CAPACITY             | Number of data structures allocated to the TimedCallback pool                                                                                              | Structs                 |
| TimedCallback\_STRUCT\_SIZE         | Number of bytes in each struct of the TimedCallback pool                                                                                                   | Bytes                   |
| TimedCallback\_USED                 | Number of structs in the TimedCallback pool which are currently being used                                                                                 | Structs                 |
| UploadFileInfo\_CAPACITY            | Number of data structures allocated to the UploadFileInfo pool                                                                                             | Structs                 |
| UploadFileInfo\_STRUCT\_SIZE        | Number of bytes in each struct of the UploadFileInfo pool                                                                                                  | Bytes                   |
| UploadFileInfo\_USED                | Number of structs in the UploadFileInfo pool which are currently being used                                                                                | Structs                 |
| networkBuffers\_CAPACITY            | Number of data structures allocated to the networkBuffers pool                                                                                             | Structs                 |
| networkBuffers\_USED                | Number of structs in the networkBuffers pool which are currently being used                                                                                | Structs                 |
| rdmaNetworkBuffers\_CAPACITY        | Number of data structures allocated to the rdmaNetworkBuffers pool                                                                                         | Structs                 |
| rdmaNetworkBuffers\_USED            | Number of structs in the rdmaNetworkBuffers pool which are currently being used                                                                            | Structs                 |

### SSD

| **Type**                                 | **Description**                                                    | **Units**      |
| ---------------------------------------- | ------------------------------------------------------------------ | -------------- |
| CLEAN\_CHUNK\_SKIPPED                    | Number of clean chunks skips                                       | Chunks         |
| DRIVE\_ACTIVE\_IOS                       | The number of in-flight IO against the SSD during sampling         | IOs            |
| DRIVE\_AER\_RECEIVED                     | Number of AER reports                                              | reports        |
| DRIVE\_CANCELLED\_COMPLETED\_BLOCKS      | Drive cancelled completed blocks                                   | Blocks/Sec     |
| DRIVE\_CANCELLED\_NOT\_SUBMITTED\_BLOCKS | Drive cancelled not submitted blocks                               | Blocks/Sec     |
| DRIVE\_COMPLETED\_OVER\_COUNT            | Drive completed count > 1 detected                                 | Occurrences    |
| DRIVE\_E2E\_CORRECTION\_COUNT            | Drive E2E correction count                                         | Error Count    |
| DRIVE\_ENDURANCE\_USED                   | Drive endurance percentage used                                    | %              |
| DRIVE\_FORFEITS                          | Number of IOs forfeited due to lack of memory buffers              | Operations/Sec |
| DRIVE\_IDLE\_CYCLES                      | Number of cycles spent in idle                                     | Cycles/Sec     |
| DRIVE\_IDLE\_TIME                        | Percentage of the CPU time not used for handling I/Os              | %              |
| DRIVE\_IO\_OVERLAPPED                    | Number of overlapping IOs                                          | Operations     |
| DRIVE\_IO\_TOO\_LONG                     | Number of IOs that took longer than expected                       | Operations/Sec |
| DRIVE\_LATENCY                           | Measure the latencies up to 5ms (higher latencies are grouped)     | Requests       |
| DRIVE\_LOAD                              | Drive Load at sampling time                                        | Load           |
| DRIVE\_MAX\_ERASE\_COUNT                 | Drive maximum block erase count                                    | Erase Count    |
| DRIVE\_MEDIA\_BLOCKS\_READ               | Blocks read from the SSD media                                     | Blocks/Sec     |
| DRIVE\_MEDIA\_BLOCKS\_WRITE              | Blocks written to the SSD media                                    | Blocks/Sec     |
| DRIVE\_MEDIA\_ERRORS                     | SSD Media Errors                                                   | IO/Sec         |
| DRIVE\_MIN\_ERASE\_COUNT                 | Drive minimum block erase count                                    | Erase Count    |
| DRIVE\_NON\_MEDIA\_ERRORS                | SSD Non-Media Errors                                               | IO/Sec         |
| DRIVE\_PCI\_CORRECTABLE\_ERROR\_COUNT    | Drive PCI Correctable error count                                  | Error Count    |
| DRIVE\_PCI\_LINK\_RETRAIN\_COUNT         | Drive PCI link retrain count                                       | Error Count    |
| DRIVE\_PENDING\_IOS                      | The number of IOs waiting to start executing during sampling       | IOs            |
| DRIVE\_PUMPED\_IOS                       | Number of requests returned in a pump                              | Pumps          |
| DRIVE\_PUMPS\_DELAYED                    | Number of Drive pumps that got delayed                             | Operations/Sec |
| DRIVE\_PUMPS\_SEVERELY\_DELAYED          | Number of Drive pumps that got severely delayed                    | Operations/Sec |
| DRIVE\_PUMP\_LATENCY                     | Latency between SSD pumps                                          | Microseconds   |
| DRIVE\_READ\_LATENCY                     | Drive Read Execution Latency                                       | Microseconds   |
| DRIVE\_READ\_OPS                         | Drive Read Operations                                              | IO/Sec         |
| DRIVE\_READ\_RATIO\_PER\_SSD\_READ       | Drive Read OPS Per SSD Request                                     | Ratio          |
| DRIVE\_REMAINING\_IOS                    | Number of requests still in the drive after a pump                 | Pumps          |
| DRIVE\_REMAINING\_SPARES                 | Drive remaining spares                                             | %              |
| DRIVE\_REQUEST\_BLOCKS                   | Measure drive request size distribution                            | Requests       |
| DRIVE\_SOFT\_ECC\_COUNT                  | Drive Soft ECC Error Count                                         | Error Count    |
| DRIVE\_SSD\_PUMPS                        | Number of drive pumps that resulted in the data flow from/to drive | Pump/Sec       |
| DRIVE\_UNALIGNED\_IOS                    | Drive unaligend IOs count                                          | Error Count    |
| DRIVE\_UNCORRECTABLE\_READ\_COUNT        | Drive uncorrectable read count                                     | Error Count    |
| DRIVE\_UTILIZATION                       | Percentage of time the drive had an active IO submitted to it      | %              |
| DRIVE\_WAF\_INTERVAL                     | Drive Interval write amplification                                 | Factor         |
| DRIVE\_WAF\_LIFETIME                     | Drive lifetime write amplification                                 | Factor         |
| DRIVE\_WRITE\_LATENCY                    | Drive Write Execution Latency                                      | Microseconds   |
| DRIVE\_WRITE\_OPS                        | Drive Write Operations                                             | IO/Sec         |
| DRIVE\_WRITE\_RATIO\_PER\_SSD\_WRITE     | Drive Write OPS Per SSD Request                                    | Ratio          |
| DRIVE\_XOR\_RECOVERY\_COUNT              | Drive XOR recovery count                                           | Error Count    |
| NVKV\_CHUNK\_OUT\_OF\_SPACE              | Number of failed attempts to allocate a stripe in an NVKV chunk    | Attempts/Sec   |
| NVKV\_OUT\_OF\_CHUNKS                    | Number of failed attempts to allocate an NVKV chunk                | Attempts/Sec   |
| NVKV\_OUT\_OF\_SUPERBLOCK\_ENTRIES       | Number of failed attempts to allocate a superblock NVKV entry      | Attempts/Sec   |
| SSDS\_IOS                                | IOs performed on the SSD service                                   | IO/Sec         |
| SSDS\_IO\_ERRORS                         | IO errors on the SSD service                                       | Blocks/Sec     |
| SSD\_BLOCKS\_READ                        | Number of blocks read from the SSD service                         | Blocks/Sec     |
| SSD\_BLOCKS\_WRITTEN                     | Number of blocks written to the SSD service                        | Blocks/Sec     |
| SSD\_CHUNKS\_IN\_USE                     | Number of allocated chunks                                         | Chunks         |
| SSD\_CHUNK\_ALLOCS\_TRIMMED              | Number of chunk allocations from the trimmed queue                 | Chunks         |
| SSD\_CHUNK\_ALLOCS\_UNTRIMMED            | Number of chunk allocations from the untrimmed queue               | Chunks         |
| SSD\_CHUNK\_ALLOCS                       | Number of chunk allocations                                        | Chunks         |
| SSD\_CHUNK\_FREES                        | Number of chunk frees                                              | Chunks         |
| SSD\_CHUNK\_FREE\_TRIMMED                | Number of free trimmed chunks                                      | Chunks         |
| SSD\_CHUNK\_FREE\_UNTRIMMED              | Number of free untrimmed chunks                                    | Chunks         |
| SSD\_CHUNK\_TRIMS                        | Number of trims performed                                          | Chunks         |
| SSD\_E2E\_BAD\_CSUM                      | End-to-End checksum failures                                       | IO/Sec         |
| SSD\_READ\_ERRORS                        | Errors in reading blocks from the SSD service                      | Blocks/Sec     |
| SSD\_READ\_LATENCY                       | Avg. latency of read requests from the SSD service                 | Microseconds   |
| SSD\_READ\_REQS\_LARGE\_NORMAL           | Number of large normal read requests from the SSD service          | IO/Sec         |
| SSD\_READ\_REQS                          | Number of read requests from the SSD service                       | IO/Sec         |
| SSD\_SCRATCH\_BUFFERS\_USED              | Number of scratch blocks used                                      | Blocks         |
| SSD\_TRIM\_TIMEOUTS                      | Number of trim timeouts                                            | Timeouts       |
| SSD\_WRITES\_REQS\_LARGE\_NORMAL         | Number of large normal priority write requests to the SSD service  | IO/Sec         |
| SSD\_WRITES                              | Number of write requests to the SSD service                        | IO/Sec         |
| SSD\_WRITE\_ERRORS                       | Errors in writing blocks to the SSD service                        | Blocks/Sec     |
| SSD\_WRITE\_LATENCY                      | Latency of writes to the SSD service                               | Microseconds   |

### Scrubber

| **Type**                                | **Description**                                                                                                      | **Units**      |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | -------------- |
| BLOCK\_CONSISTENCY\_CHECKS              | Number of blocks that were checked for consistency against their block-used-state                                    | Blocks/Sec     |
| BLOCK\_CONSISTENCY\_CHECK\_LATENCY      | Average latency of checking block consistency                                                                        | Micros         |
| CLEANED\_CHUNKS                         | Number of chunks that were cleaned by the scrubber                                                                   | Chunks/Sec     |
| DEGRADED\_READS                         | Number of degraded reads for scrubbing                                                                               | Requests/Sec   |
| FALSE\_USED\_CHECK\_LATENCY             | Average latency of checking false used per block                                                                     | Micros         |
| FALSE\_USED\_EXTRA\_NOTIFIED            | Number of blocks that were notified as used by the mark-extra-used mechanism                                         | Blocks/Sec     |
| INTERRUPTS                              | Number of scrubs that were interrupted                                                                               | Occurences/Sec |
| NETWORK\_BUDGET\_WAIT\_LATENCY          | Average latency of waiting for our network budget                                                                    | Micros         |
| NOT\_REALLY\_DIRTY\_BLOCKS              | Number of marked dirty blocks that ScrubMissingWrites found were actually clean                                      | Blocks/Sec     |
| NUM\_COPY\_DISCARDED\_BLOCKS            | Number of copied blocks that were discarded                                                                          | Blocks/Sec     |
| NUM\_COPY\_DISCARDS                     | Number of times we discarded scrubber copy work                                                                      | Occurences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARDS        | Number of times we discarded all scrubber work due to invented stripes                                               | Occurences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARD\_BLOCKS | Number of blocks that were discarded due to invented stripes                                                         | Blocks/Sec     |
| NUM\_SCRUBBER\_DISCARD\_INTERMEDIATES   | Number of times we discarded all intermediate scrubber work                                                          | Occurences/Sec |
| NUM\_SMW\_DISCARDED\_BLOCKS             | Number of SMW'd blocks that were discarded                                                                           | Blocks/Sec     |
| NUM\_SMW\_DISCARDS                      | Number of times we discarded scrubber SMW work                                                                       | Occurences/Sec |
| NUM\_STRIPE\_SKIPPED\_NOT\_FULLY\_READ  | Number of stripe skipped since stripe is not fully read                                                              | Occurrences    |
| PLACEMENT\_SELECTION\_LATENCY           | Average latency of scrubbed placement selection                                                                      | Micros         |
| READS\_CALLED                           | Number of blocks that were read                                                                                      | Blocks/Sec     |
| READ\_BATCH\_SOURCE\_BLOCKS             | Number of source blocks read per batch                                                                               | Batches        |
| READ\_BLOCKS\_LATENCY                   | Average latency of read blocks                                                                                       | Micros         |
| RELOCATED\_BLOCKS                       | Number of blocks that were relocated for eviction                                                                    | Blocks/Sec     |
| RELOCATE\_BLOCKS\_LATENCY               | Average latency of relocating blocks                                                                                 | Micros         |
| RETRUSTED\_UNPROTECTED\_DIRTY\_BLOCKS   | Number of dirty blocks that ScrubMissingWrites retrusted because they were unprotected                               | Blocks/Sec     |
| REWRITTEN\_DIRTY\_BLOCKS                | Number of dirty blocks that ScrubMissingWrites rewrote to clean them                                                 | Blocks/Sec     |
| SCAN\_LIKELY\_LEAKED\_BLOCKS            | Number of free blocks encountered during scan that were marked as KnownUsed in the RAID                              | Occurences     |
| SCRUB\_BATCHES\_LATENCY                 | Average latency of scrub batches                                                                                     | Millis         |
| SCRUB\_FALSE\_USED\_FAILED\_READS       | Number of blocks that we failed to read for scrub-false-used                                                         | Blocks/Sec     |
| SCRUB\_FALSE\_USED\_FAILED              | Number of placements we failed to fully scrub-false-used                                                             | Occurences/Sec |
| SCRUB\_FALSE\_USED\_PLACEMENTS          | Number of placements we finished scrub-false-used                                                                    | Occurences/Sec |
| SCRUB\_FALSE\_USED\_WAS\_UNPROTECTED    | Number of blocks that were false marked used and unprotected                                                         | Blocks/Sec     |
| SCRUB\_IN\_FLIGHT\_CORRUPTION\_DETECTED | Number of in-flight corruptions detected when scrubbing                                                              | Occurences     |
| SCRUB\_PREPARATION\_FAILED              | Number of times we failed to prepare() a task and aborted scrub of placement                                         | Occurences/Sec |
| SFU\_CHECKS                             | Number of blocks that were scrubbed-false-used                                                                       | Blocks/Sec     |
| SFU\_CHECK\_FREE                        | Number of blocks that were detected as false-used and freed                                                          | Blocks/Sec     |
| SFU\_CHECK\_SECONDARY                   | Number of blocks that were detected as secondary                                                                     | Blocks/Sec     |
| SFU\_CHECK\_USED\_CKSUM\_ERR            | Number of blocks that were detected as used with checksum error                                                      | Blocks/Sec     |
| SFU\_CHECK\_USED                        | Number of blocks that were detected as used                                                                          | Blocks/Sec     |
| SFU\_FREE\_STRIPES                      | Number of free stripes that were scrubbed-false-used                                                                 | Stripes/Sec    |
| SFU\_FREE\_STRIPE\_LATENCY              | Average latency of handling a read of a free stripe                                                                  | Micros         |
| SFU\_USED\_STRIPES                      | Number of used stripes that were scrubbed-false-used                                                                 | Stripes/Sec    |
| SFU\_USED\_STRIPE\_LATENCY              | Average latency of handling a read of a used stripe                                                                  | Micros         |
| SOURCE\_READS                           | Number of source/committed superset blocks directly read by the scrubber                                             | Blocks/Sec     |
| STRIPE\_DATA\_IS\_BLOCK\_USED\_LATENCY  | Average latency of isBlockUsed during stripe verification                                                            | Micros         |
| STRIPE\_DATA\_IS\_BLOCK\_USED           | Number of isBlockUsed during stripe verification                                                                     | Blocks/Sec     |
| TARGET\_COPIED\_CHUNKS                  | Number of chunks that were copied to target by the scrubber                                                          | Chunks/Sec     |
| UPDATE\_PLACEMENT\_INFO\_LATENCY        | Average latency of updating the placement info quorum                                                                | Micros         |
| UPDATE\_PLACEMENT\_INFO                 | Number of times we ran updatePlacementInfo                                                                           | Occurences/Sec |
| WONT\_CLEAN\_COPYING                    | Number of actually dirty blocks that ScrubMissingWrites refused to clean because they will be moved to target anyway | Blocks/Sec     |
| WRITES\_CALLED                          | Number of blocks that were written                                                                                   | Blocks/Sec     |
| WRITE\_BATCH\_SOURCE\_BLOCKS            | Number of source blocks to write in batch                                                                            | Batches        |
| WRITE\_BATCH\_TARGET\_BLOCKS            | Number of target blocks to write in batch                                                                            | Batches        |
| WRITE\_BLOCKS\_LATENCY                  | Average latency of writing blocks                                                                                    | Micros         |

### Squelch

| **Type**                                                | **Description**                                       | **Units**     |
| ------------------------------------------------------- | ----------------------------------------------------- | ------------- |
| BLOCKS\_PER\_DESQUELCH                                  | Number of squelch blocks per desquelch                | Desquelches   |
| EXTENT\_DESQUELCHES\_NUM                                | Number of desquelches                                 | Times         |
| EXTENT\_SQUELCH\_BLOCKS\_READ                           | Number of squelch blocks desquelched                  | Blocks        |
| HASH\_DESQUELCHES\_NUM                                  | Number of desquelches                                 | Times         |
| HASH\_SQUELCH\_BLOCKS\_READ                             | Number of squelch blocks desquelched                  | Blocks        |
| INODE\_DESQUELCHES\_NUM                                 | Number of desquelches                                 | Times         |
| INODE\_SQUELCH\_BLOCKS\_READ                            | Number of squelch blocks desquelched                  | Blocks        |
| JOURNAL\_DESQUELCHES\_NUM                               | Number of desquelches                                 | Times         |
| JOURNAL\_SQUELCH\_BLOCKS\_READ                          | Number of squelch blocks desquelched                  | Blocks        |
| MAX\_BLOCKS\_WITH\_TEMPORAL\_SQUELCH\_ITEMS\_IN\_BUCKET | Number of block with temporal squelch items in bucket | Blocks        |
| MAX\_TEMPORAL\_SQUELCH\_ITEMS\_IN\_BUCKET               | Number temporal squelch items in bucket               | Squelch items |
| ODL\_DESQUELCHES\_NUM                                   | Number of desquelches                                 | Times         |
| ODL\_PAYLOAD\_DESQUELCHES\_NUM                          | Number of desquelches                                 | Times         |
| ODL\_PAYLOAD\_SQUELCH\_BLOCKS\_READ                     | Number of squelch blocks desquelched                  | Blocks        |
| ODL\_SQUELCH\_BLOCKS\_READ                              | Number of squelch blocks desquelched                  | Blocks        |
| REGISTRY\_L1\_DESQUELCHES\_NUM                          | Number of desquelches                                 | Times         |
| REGISTRY\_L1\_SQUELCH\_BLOCKS\_READ                     | Number of squelch blocks desquelched                  | Blocks        |
| REGISTRY\_L2\_DESQUELCHES\_NUM                          | Number of desquelches                                 | Times         |
| REGISTRY\_L2\_SQUELCH\_BLOCKS\_READ                     | Number of squelch blocks desquelched                  | Blocks        |
| SPATIAL\_SQUELCH\_DESQUELCHES\_NUM                      | Number of desquelches                                 | Times         |
| SPATIAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ                 | Number of squelch blocks desquelched                  | Blocks        |
| SUPERBLOCK\_DESQUELCHES\_NUM                            | Number of desquelches                                 | Times         |
| SUPERBLOCK\_SQUELCH\_BLOCKS\_READ                       | Number of squelch blocks desquelched                  | Blocks        |
| TEMPORAL\_SQUELCH\_DESQUELCHES\_NUM                     | Number of desquelches                                 | Times         |
| TEMPORAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ                | Number of squelch blocks desquelched                  | Blocks        |

### Statistics

| **Type**                         | **Description**                                                                        | **Units**   |
| -------------------------------- | -------------------------------------------------------------------------------------- | ----------- |
| GATHER\_FROM\_NODE\_LATENCY\_NET | Time spent on responding to a stats-gathering request (not including metadata)         | Seconds/Sec |
| GATHER\_FROM\_NODE\_LATENCY      | Time spent responding to a stats-gathering request (not including metadata)            | Seconds/Sec |
| GATHER\_FROM\_NODE\_SLEEP        | Time spent in-between responding to a stats-gathering request (not including metadata) | Seconds/Sec |
| TIMES\_QUERIED\_STATS            | Number of times the process queried other processes for stats                          | Times       |
| TIMES\_QUERIED                   | Number of times the process was queried for stats (not including metadata)             | Times       |
