---
description: >-
  Explore the various statistics the WEKA system produces, organized according
  to their respective category labels.
---

# Statistics list

## API statistics

**Type** | **Description** | **Units**
-|-|-
TOTAL_2xx_RQ|Total 2xx requests|Requests
TOTAL_3xx_RQ|Total 3xx requests|Requests
TOTAL_429_RQ|Total 429 requests|Requests
TOTAL_4xx_RQ|Total 4xx requests|Requests
TOTAL_5xx_RQ|Total 5xx requests|Requests

## Assert Failures

**Type** | **Description** | **Units**
-|-|-
ASSERTION_FAILURES_IGNORE_SOFT|Assertion failures count with "IGNORE_SOFT" behaviour|Assertion failures
ASSERTION_FAILURES_IGNORE|Assertion failures count with "IGNORE" behaviour|Assertion failures
ASSERTION_FAILURES_KILL_BUCKET|Assertion failures count with "KILL_BUCKET" behaviour|Assertion failures
ASSERTION_FAILURES_KILL_FIBER|Assertion failures count with "KILL_FIBER" behaviour|Assertion failures
ASSERTION_FAILURES_KILL_NODE_OOM|Assertion failures count with "KILL_NODE_OOM" behaviour|Assertion failures
ASSERTION_FAILURES_KILL_NODE_WITH_CORE_DUMP|Assertion failures count with "KILL_NODE_WITH_CORE_DUMP" behaviour|Assertion failures
ASSERTION_FAILURES_KILL_NODE|Assertion failures count with "KILL_NODE" behaviour|Assertion failures
ASSERTION_FAILURES_STALL_AND_KILL_NODE|Assertion failures count with "STALL_AND_KILL_NODE" behaviour|Assertion failures
ASSERTION_FAILURES_STALL|Assertion failures count with "STALL" behaviour|Assertion failures
ASSERTION_FAILURES_THROW_EXCEPTION|Assertion failures count with "THROW_EXCEPTION" behaviour|Assertion failures
ASSERTION_FAILURES|Assertion failures count of all available types|Assertion failures

## Attribute Cache

**Type** | **Description** | **Units**
-|-|-
GP_GETATTR_CACHE_MISS|Number of general purpose getAttr cache misses per second|Ops/Sec
GP_GETATTR|Number of general purpose getAttr calls per second|Ops/Sec

## Audit

**Type** | **Description** | **Units**
-|-|-
AUDIT_ACQUIRE_CHARTER|Number of audit traces created for ACQUIRE_CHARTER|Audits
AUDIT_CREATE_DIRENT|Number of audit traces created for CREATE_DIRENT|Audits
AUDIT_CREATE_INODE|Number of audit traces created for CREATE_INODE|Audits
AUDIT_CREATE_OPEN_DIRENT|Number of audit traces created for CREATE_OPEN_DIRENT|Audits
AUDIT_CREATE_UNLINKED_INODE|Number of audit traces created for CREATE_UNLINKED_INODE|Audits
AUDIT_DEREFERENCE_DIRENT|Number of audit traces created for DEREFERENCE_DIRENT|Audits
AUDIT_GET_ATTR|Number of audit traces created for GET_ATTR|Audits
AUDIT_GET_XATTR|Number of audit traces created for GET_XATTR|Audits
AUDIT_HEARTBEAT|Number of audit traces created for HEARTBEAT|Audits
AUDIT_LINK|Number of audit traces created for LINK|Audits
AUDIT_LIST_XATTR|Number of audit traces created for LIST_XATTR|Audits
AUDIT_MOUNT|Number of audit traces created for MOUNT|Audits
AUDIT_READDIR|Number of audit traces created for READDIR|Audits
AUDIT_READLINK|Number of audit traces created for READLINK|Audits
AUDIT_REMOVE_XATTR|Number of audit traces created for REMOVE_XATTR|Audits
AUDIT_RENAME|Number of audit traces created for RENAME|Audits
AUDIT_SET_ATTR|Number of audit traces created for SET_ATTR|Audits
AUDIT_SET_XATTR|Number of audit traces created for SET_XATTR|Audits
AUDIT_UMOUNT|Number of audit traces created for UMOUNT|Audits
AUDIT_UNLINK_DIR|Number of audit traces created for UNLINK_DIR|Audits
AUDIT_UNLINK_FILE|Number of audit traces created for UNLINK_FILE|Audits
AUDITS|Number of audits traces created for all types|Audits

## Audit Enhancer Statistics

**Type** | **Description** | **Units**
-|-|-
BACKEND_NAME_RESOLVE_BATCH_REQUESTS|Number of resolves to backend batches|Requests
CACHE_ADDED_ENTRIES|Number of entries added to cache|Entries
CACHE_EVICT_ENTRIES|Number of entries evicted from cache|Entries
CACHE_NUM_ENTRIES|Number of entries in cache|Entries in cache
CACHE_OVERWRITTEN_ENTRIES|Number of entries overwritten in the cache|Entries
CACHE_PRELOAD_HITS|Number of cache hits when trying to preload|Entries
CACHE_PRELOAD_MISSES|Number of cache misses when trying to preload|Entries
CACHE_RESOLVE_HITS|Number of cache hits to resolve|Entries
CACHE_RESOLVE_MISSES|Number of cache misses when trying to resolve|Entries
ENHANCE_BACKEND_CALL_AVG_TIME|Per backend call average time|hnsecs
ENHANCE_BACKEND_CALL_MAX_TIME|Per backend call maximum time|hnsecs
ENHANCE_BACKEND_CALL_MIN_TIME|Per backend call minimum time|hnsecs
ENHANCE_BACKEND_CALL_TOTAL_TIME|Total backend call time|hnsecs
ENHANCE_RESOLVE_PATH_ATTEMPTS_COUNT|Number of resolve paths|Count
ENHANCE_RESOLVE_PATH_AVG_TIME|Average resolve path time|hnsecs
ENHANCE_RESOLVE_PATH_MAX_TIME|Maximum resolve path time|hnsecs
ENHANCE_RESOLVE_PATH_MIN_TIME|Minimum resolve path time|hnsecs
ENHANCE_RESOLVE_PATH_TOTAL_TIME|Total resolve path time|hnsecs
ENHANCE_SLEEP_TIME|Sleep time when backend call fails|hnsecs
ENHANCER_BATCH_COUNT|Total batch count|Batches
ENHANCER_ENHANCED_TOTAL_ENTRIES|Total entries enhanced|Entries
ENHANCER_PER_BATCH_AVG_ENTRIES|Average entries in a batch|Entries/Batch
ENHANCER_PER_BATCH_MAX_ENTRIES|Maximum entries in a batch|Entries/Batch
ENHANCER_PER_BATCH_MIN_ENTRIES|Minimum entries in a batch|Entries/Batch
INODES_TO_RESOLVE_NAME|Number of inodes to resolve name|Inodes
NAME_RESOLVE_FAIL_NAME_NOT_IN_CACHE|Number of times a path could not be resolved, as one of the directory names was not in the cache|Failed path resolves
NAME_RESOLVE_REQUESTS_FAIL|Number of resolve name queries failed|Requests failed
NAME_RESOLVE_REQUESTS_SUCCESS|Number of resolved name queries succeeded|Requests succeeded
NAME_RESOLVE_REQUESTS|Number of resolve name queries issued to backend|Requests
PER_BATCH_ENHANCE_AVG_TIME|Per batch enhance average processing time|hnsecs
PER_BATCH_ENHANCE_MAX_TIME|Per batch enhance maximum processing time|hnsecs
PER_BATCH_ENHANCE_MIN_TIME|Per batch enhance minimum processing time|hnsecs
PER_BATCH_ENHANCE_PRELOAD_AVG_TIME|Per batch enhance average preload time|hnsecs
PER_BATCH_ENHANCE_PRELOAD_MAX_TIME|Per batch enhance maximum preload time|hnsecs
PER_BATCH_ENHANCE_PRELOAD_MIN_TIME|Per batch enhance minimum preload time|hnsecs
PER_BATCH_ENHANCE_PRELOAD_TOTAL_TIME|Total enhance preload time|hnsecs
PER_BATCH_ENHANCE_TOTAL_TIME|Total enhance batch processing time|hnsecs
PRELOAD_CACHE_COUNT|Number of cache preloads|Number of attempts

## Block Cache

**Type** | **Description** | **Units**
-|-|-
BUCKET_CACHE_METADATA_HITS|Bucket block cache metadata hits|Queries
BUCKET_CACHE_METADATA_MISSES|Bucket block cache metadata misses|Queries
BUCKET_CACHE_REGISTRY_L2_HITS|Bucket block cache registry L2 hits|Queries
BUCKET_CACHE_REGISTRY_L2_MISSES|Bucket block cache registry L2 misses|Queries
BUCKET_CACHED_METADATA_BLOCKS|Bucket number of cached metadata blocks|Blocks
BUCKET_CACHED_REGISTRY_L2_BLOCKS|Bucket number of cached registry L2 blocks|Blocks
BUCKET_REGISTRY_L2_BLOCKS_NUM|Bucket number of registry L2 blocks|Blocks

## Block Writes

**Type** | **Description** | **Units**
-|-|-
BLOCK_FULL_WRITES|Number of full block writes|Writes
BLOCK_PARTIAL_WRITES|Number of partial block writes|Writes

## Bucket

**Type** | **Description** | **Units**
-|-|-
BUCKET_SESSION_VALIDATION_LATENCY|Average latency of bucket session validation|Microseconds
BUCKET_SESSION_VALIDATIONS|Number of bucket session validations per second|RPCs/Sec
BUCKET_START_TIME|Duration of bucket activation on step up|Startups
CHOKING_LEVEL_ALL|Throttling level applied on all types of IOs|%
CHOKING_LEVEL_NON_MUTATING|Throttling level applied on non-mutating only types of IOs|%
COALESCED_MAY_CREATE_EXTENT|Number of mayCreateExtent calls coalesced|Calls
DESTAGE_COUNT|Number of destages per second|Destages/Sec
DESTAGED_BLOCKS_COUNT|Number of destaged blocks per second|Blocks/Sec
DIR_MOVE_TIME|Time to complete a directory move|Ops
EXTENT_BLOCK_SEQUENCES|Histogram of the number of consecutive sequences of blocks in a single extent|Extents
EXTENT_BLOCKS_COUNT|Difference in number of EXTENT blocks|Blocks
FAIRNESS_DELAYED_MAY_CREATE_EXTENT|Number of mayCreateExtent calls not coalesced to prevent starvation|Calls
FREEABLE_LRU_BUFFERS|Number of unused blocks in LRU cache|Buffers
HASH_BLOCKS_COUNT|Difference in number of HASH blocks|Blocks
INODE_BLOCKS_COUNT|Difference in number of INODE blocks|Blocks
INTEGRITY_ISSUES|Number of filesystem integrity issues detected|Issues
JOURNAL_BLOCKS_COUNT|Difference in number of JOURNAL blocks|Blocks
NOOP_JOURNALS|Number of NOOP journals|Ops/Sec
NOOP_REPLAYS|Number of NOOP replays|Ops
ODH_COLLISIONS_ACCESS_CLOCK_STATES|Number of ODH items created with colliding hash in ACCESS_CLOCK_STATES ODH|Collisions
ODH_COLLISIONS_BIG_BLOB_MANIFEST|Number of ODH items created with colliding hash in BIG_BLOB_MANIFEST ODH|Collisions
ODH_COLLISIONS_DEFAULT_DIR_QUOTA|Number of ODH items created with colliding hash in DEFAULT_DIR_QUOTA ODH|Collisions
ODH_COLLISIONS_DIR_QUOTA|Number of ODH items created with colliding hash in DIR_QUOTA ODH|Collisions
ODH_COLLISIONS_DIRECTORY|Number of ODH items created with colliding hash in DIRECTORY ODH|Collisions
ODH_COLLISIONS_FLOCK_EXPIRED_FRONTENDS_WNID|Number of ODH items created with colliding hash in FLOCK_EXPIRED_FRONTENDS_WNID ODH|Collisions
ODH_COLLISIONS_FLOCK_EXPIRED_FRONTENDS|Number of ODH items created with colliding hash in FLOCK_EXPIRED_FRONTENDS ODH|Collisions
ODH_COLLISIONS_GRAVEYARD|Number of ODH items created with colliding hash in GRAVEYARD ODH|Collisions
ODH_COLLISIONS_INODES_PENDING_VALIDATIONS|Number of ODH items created with colliding hash in INODES_PENDING_VALIDATIONS ODH|Collisions
ODH_COLLISIONS_INODES_POTENTIAL_PENDING_DELETION|Number of ODH items created with colliding hash in INODES_POTENTIAL_PENDING_DELETION ODH|Collisions
ODH_COLLISIONS_MODIFY_CLOCK_STATES|Number of ODH items created with colliding hash in MODIFY_CLOCK_STATES ODH|Collisions
ODH_COLLISIONS_OBS_IMMEDIATE_RELEASE|Number of ODH items created with colliding hash in OBS_IMMEDIATE_RELEASE ODH|Collisions
ODH_COLLISIONS_OBS_RECLAMATION|Number of ODH items created with colliding hash in OBS_RECLAMATION ODH|Collisions
ODH_COLLISIONS_REFERENCE_RELOCATIONS|Number of ODH items created with colliding hash in REFERENCE_RELOCATIONS ODH|Collisions
ODH_COLLISIONS_SNAP_LAYER_CAPACITY|Number of ODH items created with colliding hash in SNAP_LAYER_CAPACITY ODH|Collisions
ODH_COLLISIONS_SNAP_LAYER_SIZE_V4_3|Number of ODH items created with colliding hash in SNAP_LAYER_SIZE_V4_3 ODH|Collisions
ODH_COLLISIONS_SNAPSHOT_MEMBERS|Number of ODH items created with colliding hash in SNAPSHOT_MEMBERS ODH|Collisions
ODH_COLLISIONS_STOW_DOWNLOAD_REDISTRIBUTE_PULL_STATE_V4_3|Number of ODH items created with colliding hash in STOW_DOWNLOAD_REDISTRIBUTE_PULL_STATE_V4_3 ODH|Collisions
ODH_COLLISIONS_STOW_DOWNLOAD_REDISTRIBUTE_V4_3|Number of ODH items created with colliding hash in STOW_DOWNLOAD_REDISTRIBUTE_V4_3 ODH|Collisions
ODH_COLLISIONS_STOW_UPLOAD_MANIFEST|Number of ODH items created with colliding hash in STOW_UPLOAD_MANIFEST ODH|Collisions
ODH_COLLISIONS_SV_CAPACITY_LEADER|Number of ODH items created with colliding hash in SV_CAPACITY_LEADER ODH|Collisions
ODH_COLLISIONS_UNLINKED_INODES|Number of ODH items created with colliding hash in UNLINKED_INODES ODH|Collisions
ODH_COLLISIONS|Number of ODH items created with colliding hash in all ODHs|Collisions
ODL_BLOCKS_COUNT|Difference in number of ODL blocks|Blocks
ODL_PAYLOAD_BLOCKS_COUNT|Difference in number of ODL_PAYLOAD blocks|Blocks
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_LATENCY|Average latency of READ operations|Microseconds
READS|Number of read operations per second|Ops/Sec
REGISTRY_COLLISIONS|Number of registry items created with colliding key|Collisions
REGISTRY_L1_BLOCKS_COUNT|Difference in number of REGISTRY_L1 blocks|Blocks
REGISTRY_L2_BLOCKS_COUNT|Difference in number of REGISTRY_L2 blocks|Blocks
REGISTRY_SEARCHES_COUNT|Number of registry searches per second|Queries/Sec
REJECTED_STALE_PUT_BLOCKS_FALSE_POSITIVES|Number of putBlocks RPCs falsely rejected due to stale serial number|RPCs/Sec
REJECTED_STALE_PUT_BLOCKS|Number of putBlocks RPCs rejected due to stale serial number|RPCs/Sec
RESIDENT_BLOCKS_COUNT|Number of blocks in the resident blocks table|Blocks
SINGLE_HOP_MISMATCH_RECOVERY|Number of single-hop read prefix mismatch recoveries|Issues
SINGLE_HOP_RDMA_MISMATCH_DPDK_FALLBACK|Number of single-hop read prefix mismatch RDMA failures |Issues
SINGLE_HOP_WRITE_ATTEMPTS|Number of single hop write attempts|Ops/Sec
SINGLE_HOP_WRITE_BYTES|Total single hop write bytes|Bytes/Sec
SINGLE_HOP_WRITE_FAILURES|Number of single-hop write operation failures per second|Ops/Sec
SINGLE_HOP_WRITES_BAD_CSUM|Number of single hop write operation (BAD_CSUM) per second|Ops/Sec
SINGLE_HOP_WRITES_FE_CALLBACK_FAIL|Number of single hop write operation (FE_CALLBACK_FAIL) per second|Ops/Sec
SINGLE_HOP_WRITES_FE_FAILOVER|Number of single hop write operation (FE_FAILOVER) per second|Ops/Sec
SINGLE_HOP_WRITES_MANUAL_OVERRIDE_DENY|Number of single hop write operation (MANUAL_OVERRIDE_DENY) per second|Ops/Sec
SINGLE_HOP_WRITES_NO_BYPASSING_STRIPES|Number of single hop write operation (NO_BYPASSING_STRIPES) per second|Ops/Sec
SINGLE_HOP_WRITES_OTHER_ERROR|Number of single hop write operation (OTHER_ERROR) per second|Ops/Sec
SINGLE_HOP_WRITES_SKIP|Number of single-hop write operations (SKIP) per second|Ops/Sec
SINGLE_HOP_WRITES_SSD_FAIL|Number of single hop write operation (SSD_FAIL) per second|Ops/Sec
SINGLE_HOP_WRITES_SUCCESS|Number of single-hop write operations (SUCCESS) per second|Ops/Sec
SINGLE_HOP_WRITES_TOO_MANY_PLACEMENTS|Number of single hop write operation (TOO_MANY_PLACEMENTS) per second|Ops/Sec
SINGLE_HOP_WRITES_UNEXPECTED_FAIL|Number of single hop write operation (UNEXPECTED_FAIL) per second|Ops/Sec
SNAPSHOT_CREATION_TIME|Time to complete a snapshot creation|Snapshots
SPATIAL_DIGEST_BLOCKS_COUNT|Difference in number of SPATIAL_DIGEST blocks|Blocks
SPATIAL_SQUELCH_BLOCKS_COUNT|Difference in number of SPATIAL_SQUELCH blocks|Blocks
SUCCESSFUL_DATA_WEDGINGS|Number of successful attempts to wedge data blocks in journal per second|Attempts/Sec
SUPERBLOCK_BLOCKS_COUNT|Difference in number of SUPERBLOCK blocks|Blocks
TEMPORAL_SQUELCH_BLOCKS_COUNT|Difference in number of TEMPORAL_SQUELCH blocks|Blocks
TRANSIENT_INTEGRITY_ISSUES|Number of transient filesystem integrity issues detected|Issues
UNSUCCESSFUL_DATA_WEDGINGS|Number of unsuccessful attempts to wedge data blocks in journal per second|Attempts/Sec
USED_L2_RESERVED_ENTRY|Number of uses of L2 reserved entries|Occurrences
USER_DATA_BUFFERS_IN_USE|Number of data buffers used for serving ongoing IOs|Buffers
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITES|Number of write operations per second|Ops/Sec

## Bucket Failovers

**Type** | **Description** | **Units**
-|-|-
BUCKET_FAILOVERS|Number of failovers detected in remote buckets|Failovers
REMOTE_BUCKET_IS_SECONDARY|Number of times a remote bucket reported it is secondary and cannot serve us|Exceptions

## Bucket Rebalances

**Type** | **Description** | **Units**
-|-|-
BUCKET_INIT_LATENCY_HIST|Duration of bucket initialization|Initializations
BUCKET_INIT_LATENCY|Average latency of bucket initialization|Seconds
BUCKET_INITS|Number of bucket initializations|Times
BUCKET_REBALANCER_STEPDOWN_REQUESTS|Number of bucket rebalancer stepdown requests of a bucket|Times
INFORMATIVE_DENY_BUCKET_ACCESS|Number of new-style NotBucketLeaderEx exceptions|Exceptions
LEGACY_DENY_BUCKET_ACCESS|Number of old-style NotBucketLeader exceptions|Exceptions

## Charters

**Type** | **Description** | **Units**
-|-|-
DEDGRADED_TO_READER_RELINQUISHES|Charter relinquishes by reason|charters
EAGER_RELINQUISHES|Charter relinquishes by reason|charters
LRU_EXPIRED_RELINQUISHES|Charter relinquishes by reason|charters
LRU_LENGTH_RELINQUISHES|Charter relinquishes by reason|charters
OUT_OF_SPACE_RELINQUISHES|Charter relinquishes by reason|charters

## Choking

**Type** | **Description** | **Units**
-|-|-
CHOKING_LEVEL_ALL|Throttling level applied on all types of IOs, both mutating and non-mutating|Processes
CHOKING_LEVEL_NON_MUTATING|Throttling level applied on non-mutating only types of IOs|Processes

## Clients

**Type** | **Description** | **Units**
-|-|-
CLIENTS_CONNECTED|Clients connected|Clients/Sec
CLIENTS_DISCONNECTED|The number of clients left or removed|Clients/Sec
CLIENTS_LEFT|The number of clients left|Clients/Sec
CLIENTS_RECONNECTED|The number of clients reconnected instead of their previous connection instance|Clients/Sec
CLIENTS_REMOVED|The number of clients removed|Clients/Sec

## Cloud

**Type** | **Description** | **Units**
-|-|-
TOTAL_PROXY_REQUESTS|Number of times the process used other nodes as a proxy|Times

## Config

**Type** | **Description** | **Units**
-|-|-
AVERAGE_CHANGES_IN_CHANGESET|The average number of changes in a changeset|Changes/Sec
AVERAGE_CHANGES_IN_GENERATION|The average number of changes in a generation|Changes/Sec
BACKEND_NODE_REJOIN_TIME|The number of backends rejoin attempts per completion time range|Number of rejoins
CHANGESET_COMMIT_LATENCY|The average latency of committing a configuration changeset|Microseconds
CLIENT_NODE_REJOIN_TIME|The number of clients rejoin attempts per completion time range|Number of rejoins
CONFIG_PROPAGATION_LATENCY|The latencies of propagation of a configuration generation|Generation
FetchLocalStateChangesCallType_INTERNAL_CONTINUE|Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type|RPC Calls
FetchLocalStateChangesCallType_INTERNAL_RESTART_FROM_TAIL|Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type|RPC Calls
FetchLocalStateChangesCallType_INTERNAL_RETRY_LAST_REQUEST|Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type|RPC Calls
FetchLocalStateChangesCallType_LEAF_CONTINUE|Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type|RPC Calls
FetchLocalStateChangesCallType_LEAF_RESTART_FROM_TAIL|Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type|RPC Calls
FetchLocalStateChangesCallType_LEAF_RETRY_LAST_REQUEST|Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type|RPC Calls
GENERATION_COMMIT_LATENCY|The average latency of committing a configuration generation to the RAFT log|Microseconds
HEARTBEAT_PROCESSING_TIME_OLD|The number of non-leader heartbeats per processing time range (OLD)|Number of heartbeats
HEARTBEAT_PROCESSING_TIME|The number of non-leader heartbeats per processing time range|Number of heartbeats
HISTOGRAM_LEADER_ITERATION_WAIT_DURATION_CONFIG_ALIGNMENT|Wait duration of leader iteration for all nodes to align on the latest configuration generation|Leader iteration wait time
LEADER_HEARTBEAT_PROCESSING_TIME_OLD|The number of leader heartbeats per processing time range (OLD)|Number of heartbeats
LEADER_HEARTBEAT_PROCESSING_TIME|The number of leader heartbeats per processing time range|Number of heartbeats
LOCAL_STATS_FETCH_GENERATION_LAGGING|The number of local-state generations that the parent fetch request still needs to read|local-state generations
LOCALSTATE_AGGREGATION_LATENCY|This period between clockSkewReportTime table's update by a management process and the time the leader sees it|Time is taken to aggregate LocalState in milliseconds
OVERLAY_FULL_SHIFTS|The number of entire overlay shifts|Changes
OVERLAY_INCREMENTAL_SHIFTS|The number of incremental overlay shifts|Changes
OVERLAY_TRACKER_INCREMENTALS|The number of incremental OverlayTracker applications|Changes
OVERLAY_TRACKER_RESYNCS|The number of OverlayTracker full-resyncs|Changes
TOTAL_CHANGESETS_COMMITTED|The total number of committed changesets|Change Sets
TOTAL_COMMITTED_CHANGES|The total number of committed configuration change sets|Changes
TOTAL_CONFIG_SNAPSHOT_PULLS|The total number of config snapshot pulls|Pulls
TOTAL_GENERATIONS_COMMITTED|The number of committed generations|Generations

## CPU

**Type** | **Description** | **Units**
-|-|-
CPU_UTILIZATION|The percentage of the CPU time used for handling I/Os|%

## Data Reduction

**Type** | **Description** | **Units**
-|-|-
ACCEPTED_INGESTS|Number of ingests accepted by the extent|Blocks/Sec
ACCEPTED_RELOCATES|Number of relocation accepted by the extent|Blocks/Sec
ACCEPTED_SEGMENTS|Number of blocks accepted for clusterization|Blocks/Sec
AVG_DELTAS|Average deltas per reference during ingestion (excluding history)|deltas/ref
boxSize|Box sizes histogram|Segments
CLUSTERIZE_CALLS|Clusterize Calls|Calls/Sec
CLUSTERIZE_TIME|Average time to clusterize|Milliseconds
COMPRESS_TASK_CALLS|Compress Task Calls|Calls/Sec
COMPRESS_TASK_TIME|Average time to complete the compress task|Milliseconds
COMPRESSED_DELTA_SIZE|Average size of new compressed delta segments|Bytes
COMPRESSED_ETERNAL_SINGLE_SIZE|Average size of new compressed eternal-single segments|Bytes
COMPRESSED_REF_ABLE_SIZE|Average size of new compressed referencable segments|Bytes
COMPRESSED_SELF_DELTA_SIZE|Average self-compressed size of new delta segments|Bytes
COMPRESSED_SIZE|Average size of new compressed segments|Bytes
CROSS_BLOCKS_READ_ERRS|Number of failed reads due to wrong crossBlocks flag|Reads/Sec
DELTA_BACKPTR_COLLISIONS|Number of times delta blocks with the same backptr were encountered during GC|Blocks/Sec
DELTA_PROMOTES|Number of delta blocks promoted by GC|Blocks/Sec
DELTA_RELOCS|Number of delta blocks relocated by GC|Blocks/Sec
DELTA_REMOVAL_BACKPTR_COLLISIONS|Number of times delta blocks with the same backptr were encountered during deletions flush|Blocks/Sec
DELTA_SIZE_PER_SIMILARITY|Average size of new compressed delta segments per similarity value|Bytes
DELTA_TOTAL_PER_SIMILARITY|Total size of new compressed delta segments per similarity value|Bytes
DELTAS_COMPLETE_RELOCS|Number of delta blocks notified about a relocation of both delta and ref segments at the same time|Blocks/Sec
DELTAS_GC|Number of delta blocks removed by GC|Blocks/Sec
DELTAS_PER_SIMILARITY|Number of new compressed delta segments per similarity value|Segments
DELTAS_REF_RELOCS|Number of delta blocks notified about reference relocations|Blocks/Sec
DISCOVERED_FREE_BYTES|Free bytes discovered by scrub|Bytes/Sec
DROPPED_HISTORY_UPDATES|Number of History Updated Dropped|Segments/Sec
DROPPED_SEGMENTS|Number of blocks dropped during clusterization|Blocks/Sec
ENQUEUED_FP_CALCS|Written blocks to data-reduction filesystems, requiring fingerprint calculations|Blocks/Sec
ETERNAL_SINGLE_PROMOTES|Number of eternal single blocks promoted by GC|Blocks/Sec
ETERNAL_SINGLE_RELOCS|Number of eternal single blocks relocated by GC|Blocks/Sec
ETERNAL_SINGLE_TOTAL_SIZE|Total size of new compressed eternal-single segments|Bytes
ETERNAL_SINGLES_UNIQUES_EST_LOG|Log2 of number of unique hashes for new eternal single blocks|Blocks
GC_PROMOTIONS|Number of times data was rewritten to the next GC tree level|Blocks/Sec
HISTORY_DOUBLE_ADDS|Number of double-adds encountered in history|Errs/Sec
HISTORY_READ_ERRS|Number of failed reference reads from history|Reads/Sec
historyLogHist|historyLogHist|Segments
historySegsInSliceShard|History segments in slice shard|Segments
improvedFrom|Similarity improvements old values|Segments
improvedTo|Similarity improvements, new values|Segments
INGEST_PERFORMED_FP_CALCS|Delayed data-reduction fingerprint calculations performed during ingest|Blocks/Sec
INGEST_START_CALLS|Ingest Start Calls|Calls/Sec
INGEST_START_TIME|Average time to start ingest|Milliseconds
inheritedRefs|Inherited Refs|Segments
intoFilter|Segments inserted into filter|Segments
MEMORY_HISTORY_TRUNCATES|Number of History Truncations due to low memory|Reads/Sec
NEW_DELTAS_FROM_HISTORY|Number of new delta blocks created with references from history|Blocks/Sec
NEW_DELTAS_FROM_INGEST|Number of new delta blocks created with references from the same ingest batch|Blocks/Sec
NEW_DELTAS|Number of new delta blocks created|Blocks
NEW_ETERNAL_SINGLES|Number of new eternal single blocks created|Blocks/Sec
NEW_INCOMPRESSIBLE_DELTAS|Number of new incompressible delta segments ingested|Blocks/Sec
NEW_INCOMPRESSIBLE_REF_ABLES|Number of new incompressible referencable segments ingested|Blocks/Sec
NEW_INGESTED|Ingested Blocks|Blocks
NEW_REF_ABLES|Number of new referencable blocks created|Blocks
NEW_REFERENCES|Number of new reference blocks created|Blocks/Sec
NEW_SINGLES|Number of new (non-eternal) single blocks created|Blocks/Sec
PERFORMED_FP_CALCS|Executed data-reduction fingerprint calculations|Blocks/Sec
REF_BACKPTR_COLLISIONS|Number of times blocks with the same reference-backptr were encountered during GC|Blocks/Sec
REFERENCE_GC|Number of reference blocks removed by GC|Blocks/Sec
REFERENCE_PROMOTES|Number of reference blocks promoted by GC|Blocks/Sec
REFERENCE_RELOCS|Number of reference blocks relocated by GC|Blocks/Sec
refsBySource|Refs by ref source|Refs
REJECTED_INGESTS|Number of ingests rejected by the extent|Blocks/Sec
REJECTED_RELOCATES|Number of relocation rejected by the extent|Blocks/Sec
REPLACED_FP_CALCS|Block re-writes replacing the data for fingerprint calculations|Blocks/Sec
SCRUBBED_PLACEMENTS|Number of scrubbed placeents|Placements/Sec
SEGMENT_PROMOTES_BYTES|Number of segment bytes promoted by GC|Bytes/Sec
SEGMENT_PROMOTES|Promoted Compressed Blocks|Blocks
SEGMENT_RELOCS_BYTES|Number of segment bytes relocated by GC|Bytes/Sec
SEGMENT_RELOCS|Relocated Compressed Blocks|Blocks
segsInSliceShard|Segments in slice shard|Segments
similarityByRefSource|Similarity histogram per ref source|Score
SINGLES_MARKED_AS_REFS|Number of single blocks marked as references due to new matches|Blocks/Sec
SKIPPED_FP_CALCS|Writes to data-reduction filesystems that skipped fingerprint calculations|Blocks/Sec
STALE_HISTORY_USE|Number of segments used as references|Reads/Sec
typicalCandidatesPerHist|typicalCandidatesPerHist|Segments
typicalRefsPerHist|typicalRefsPerHist|Segments

## Dataservice

**Type** | **Description** | **Units**
-|-|-
DIFFLIST_GET_LATENCY|Average latency of getDifflist|Microseconds
DIFFLIST_GET_MANIFEST_LATENCY|Average latency of getDifflist getManifest|Microseconds
DIFFLIST_GET_MANIFEST_OPS|Number of getDifflist getManifest|Ops/Sec
DIFFLIST_GET_MANIFEST_PER_GETLIST_LATENCY|Average latency of getDifflist getmanifest per getdifflist|Microseconds
DIFFLIST_GET_MANIFEST_PER_GETLIST_OPS|Number of getDifflist getmanifest per getdifflist|Ops/Sec
DIFFLIST_GET_OPS|Number of getDifflist|Ops/Sec
DIFFLIST_RESOLVE_PATH_BATCH_LATENCY|Average latency of getDifflist resolve-path per batch|Microseconds
DIFFLIST_RESOLVE_PATH_BATCH_OPS|Number of getDifflist resolve-path per batch |Ops/Sec
DIFFLIST_RESOLVEPATH_LATENCY|Average latency of getDifflist resolvepath|Microseconds
DIFFLIST_RESOLVEPATH_OPS|Number of getDifflist resolvepath|Ops/Sec
QUOTA_TASK_ADD_DIR_ENTRIES|Number of entries added for directory quota task|Ops
QUOTA_TASK_CREATES|Number of directory quota tasks created|Ops
QUOTA_TASK_DELETE_DIR_ENTRIES|Number of entries removed for directory quota task|Ops
QUOTA_TASK_DELETES|Number of directory quota tasks removed|Ops
QUOTA_TASK_FAILED_STAMPS|Number of failed quota coloring stamp operations|Ops
QUOTA_TASK_FIBERS|Number of directory quota task fibers spawned per second|Fibers
QUOTA_TASK_READDIR_LATENCY|Average latency of directory quota task readdir operations|Microseconds
QUOTA_TASK_READDIR_OPS|Number of directory quota task readdir operations per second|Ops/Sec
QUOTA_TASK_RUNTIME|Average runtime of directory quota task fibers|Microseconds
QUOTA_TASK_STAMP_LATENCY|Average latency of directory quota task stamp operations|Microseconds
QUOTA_TASK_STAMPS|Number of directory quota stamp operations per second|Ops/Sec
QUOTA_TASK_SUCCESSFUL_STAMPS|Number of successful directory quota stamp operations|Ops
QUOTAS_MARKED|Number of directory quotas marked|Quotas

## Decisions about buckets from the cluster leader

**Type** | **Description** | **Units**
-|-|-
TOTAL_COUNCIL_CLEANUPS|The number of times a bucket council's toRemove/toAdd field member was cleared|Bucket council cleanups
TOTAL_COUNCIL_REDISTRIBUTIONS|The number of times a bucket council was changed for any bucket|Bucket council redistributions

## ExecTime

**Type** | **Description** | **Units**
-|-|-
EXECTIME_AVG|Average execution time (usec) of function calls that ran for over the threshold time|Microseconds
EXECTIME_COUNT|Number of times the function was called and ran for over the threshold time|Executions

## Filesystem OBS

**Type** | **Description** | **Units**
-|-|-
BACKPRESSURED_BUCKETS_IN_FSS|Number of backpressured buckets|Buckets
CONCURRENT_DEMOTES|Number of demotes executed concurrently|Demotes
DEMOTE_EXTENT_OBS_FETCH_BACKPRESSURE|Number of extent BACKPRESSURE object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH_IMMEDIATE_RELEASE|Number of extent IMMEDIATE_RELEASE object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH_MANHOLE|Number of extent MANHOLE object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH_MIGRATE|Number of extent MIGRATE object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH_POLICY|Number of extent POLICY object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH_RECLAMATION_REUPLOAD|Number of extent RECLAMATION_REUPLOAD object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH_STOW|Number of extent STOW object-store fetch operations per second|Ops/Sec
DEMOTE_EXTENT_OBS_FETCH|Number of extent object-store fetch operations per second|Ops/Sec
DEMOTE_WAITING_FOR_SLOT|Average time waiting for a demotion concurrency slot|Microseconds
DESERIALIZED_EXTENTS_WITH_INVALID_BLOBS|Number of deserialized extents with invalid blob id|Extents
DOWNLOAD_LATENCY|Average latency of downloads|Microseconds
DOWNLOADS|Number of downloads per second|Ops/Sec
EXTENTS_WITH_FAKE_RETENTION_TAG|Number of scanned extents with fake retention tag|Extents
FAILED_DOWNLOADS|Number of failed downloads per second|Ops/Sec
FAILED_UPLOADS|Number of failed uploads per second|Ops/Sec
OBS_4K_IOPS_READ|Number of object store dedicated 4K read operations per second|Ops/Sec
OBS_BACKPRESSURE_FREED|Number of bytes freed from disk due to backpressure per second|Bytes/Sec
OBS_BLOB_HEADER_DOWNLOAD_LATENCY|Average latency of blob header download|Microseconds
OBS_BLOB_SCAVENGE_LATENCY|Average latency of blob scavenges|Microseconds
OBS_BLOB_TIERING_DURATION|Duration of tiering blobs to object-store|Ops
OBS_COMPLETELY_ALIVE_BLOBS|Percentage of blobs with only live extents linked to them|%
OBS_COMPLETELY_DEAD_BLOBS|Percentage of blobs with no live extent linked to them|%
OBS_EXTENTS_PREFETCH|Number of extents prefetched from object-store per second|Extents/Sec
OBS_FREED|Number of bytes freed from disk because they are in the object-store per second|Bytes/Sec
OBS_IMMEDIATE_RELEASE_FREED|Number of bytes freed from disk due to immediate release per second|Bytes/Sec
OBS_INODES_PREFETCH|Number of files prefetched from object-store per second|Ops/Sec
OBS_INODES_RELEASE|Number of files released to object store per second|Ops/Sec
OBS_ONGOING_RECLAMATIONS|Number of ongoing reclamations|Ops
OBS_POLICY_FREED|Number of bytes freed from disk due to policy per second|Bytes/Sec
OBS_PROMOTE_EXTENT_WRITE_LATENCY|Average latency of extent promote writes|Microseconds
OBS_PROMOTE_EXTENT_WRITE|Number of extents promoted from object-store per second|Extents/Sec
OBS_PROMOTE_WRITE|Number of bytes promoted from object-store per second|Bytes/Sec
OBS_READ|Number of reads that needed data from the object-store per second|Ops/Sec
OBS_RECLAMATION_PURGED_BYTES|Number of bytes purged per second|Bytes/Sec
OBS_RECLAMATION_SCAVENGED_BLOBS|Number of blobs scavenged per second|Ops/Sec
OBS_RECLAMATION_SCAVENGED_BYTES|Number of bytes scavenged per second|Bytes/Sec
OBS_RECLAMATION_WAIT_FOR_DESTAGE|Average time waiting for destage on space reclamation|Microseconds
OBS_RELOC_DOWNLOAD|Number of relocation blobs downloaded per second|Ops/Sec
OBS_RELOC_UPLOAD|Number of relocation blobs uploaded per second|Ops/Sec
OBS_SCAVENGED_BLOB_WASTE_LEVEL|Waste level found in blobs|Blobs
OBS_SHARED_DOWNLOADS_LATENCY|Average latency of shared downloads from object-store|Microseconds
OBS_SHARED_DOWNLOADS|Number of shared downloads from object-store per second|Ops/Sec
OBS_TRUNCATE|Number of truncates that needed data from the object-store per second|Ops/Sec
OBS_UNEXPECTED_TAG_ON_DOWNLOAD|Number of unexpected tags found when downloading extents|Occurrences
OBS_WRITE|Number of writes that needed data from the object-store per second|Ops/Sec
STOW_COMMIT_QUEUE_HANG|Number of times metadata download queue was hanging full|Occurrences
STOW_METADATA_DESERIALIZATION_LATENCY|Average latency of metadata blob deserialization|Milliseconds
STOW_METADATA_SEED_DOWNLOADS|Number of seed downloads per second|Ops/Sec
STOW_SERIALIZED_EXTENT_DATA|Number of extent descriptors uploaded that contain data|Extent Descriptors
STOW_SERIALIZED_EXTENT_DESCS|Number of extent descriptors uploaded|Extent Descriptors
STOW_SERIALIZED_EXTENT_REDIRECTS|Number of extent descriptors uploaded that redirect to previous snapshot|Extent Descriptors
TIERED_FS_BREAKING_POLICY|Number of tiered filesystems breaking policy|Activations
TIMEOUT_DOWNLOADS|Number of timed out downloads per second|Ops/Sec
TIMEOUT_OPERATIONS|Total number of timed-out operations per second|Ops/Sec
TIMEOUT_UPLOADS|Number of timed out uploads per second|Ops/Sec
UNEXPECTED_BLOCK_VERSION_POST_UPGRADE|Number of unexpected block versions found after upgrade completed|Occurrences
UPLOAD_CHOKING_LATENCY|Average latency of waiting for upload choking budget|Microseconds
UPLOAD_LATENCY|Average latency of uploads|Microseconds
UPLOADS|Number of upload attempts per second|Ops/Sec

## Frontend

**Type** | **Description** | **Units**
-|-|-
FE_IDLE_CYCLES|The number of idle cycles on the frontend|Cycles/Sec
FE_IDLE_TIME|The percentage of the CPU time not used for handling I/Os on the frontend|%

## Frontend Encryption

**Type** | **Description** | **Units**
-|-|-
FE_BLOCK_CRYPTO_LATENCY|Average latency of frontend block crypto|Microseconds
FE_BLOCK_DECRYPT_DURATION|Duration of decryption of blocks in the frontend|Microseconds
FE_BLOCK_ENCRYPT_DURATION|Duration of encryption of blocks in the frontend|Microseconds
FE_BLOCKS_DECRYPTED|Number of blocks decrypted in the frontend|Blocks
FE_BLOCKS_ENCRYPTED|Number of blocks encrypted in the frontend|Blocks
FE_FILENAME_CRYPTO_LATENCY|Average latency of frontend filename crypto|Microseconds
FE_FILENAME_DECRYPT_DURATION|Duration of decryption of filenames in the frontend|Microseconds
FE_FILENAME_ENCRYPT_DURATION|Duration of encryption of filenames in the frontend|Microseconds
FE_FILENAMES_DECRYPTED|Number of filenames decrypted in the frontend|Filenames
FE_FILENAMES_ENCRYPTED|Number of filenames encrypted in the frontend|Filenames

## Garbage Collection

**Type** | **Description** | **Units**
-|-|-
GC_ALLOC_BYTES|Number of bytes allocated from GC|Bytes
GC_FREE_SIZE_AFTER_SCAN|GC pool size after the scan ends|Bytes
GC_FREE_SIZE_BEFORE_SCAN|GC pool size before the scan starts|Bytes
GC_SCAN_TIME|GC scan time|Msec
GC_SCANS|Number of GC scans|Scans
GC_USED_SIZE_AFTER_SCAN|GC used size after the scan ends|Bytes
GC_USED_SIZE_BEFORE_SCAN|GC used size before the scan starts|Bytes

## JRPC

**Type** | **Description** | **Units**
-|-|-
JRPC_SERVER_CALLS_CLIENT_DOES_NOT_SUPPORT_QOS|The number of JRPC calls made from a client that does not support JRPC QoS|Requests/Sec
JRPC_SERVER_CALLS_CLIENT_SUPPORTS_QOS|The number of JRPC calls made from a client that supports JRPC QoS|Requests/Sec
JRPC_SERVER_CALLS_QOS_DECLINED|The number of JRPC calls where server returns TOO_MANY_REQUESTS (QoS declined to run a method)|Requests/Sec
JRPC_SERVER_PROCESSING_AVG|The average time the JRPC server processed the JRPC requests.|Microseconds
JRPC_SERVER_PROCESSING_TIME|The number of JRPC requests processed by the server per time range.|Requests

## Memory

**Type** | **Description** | **Units**
-|-|-
GC_CURRENT|The process (node) GC memory size, current in sample time.|Bytes
GC_PEAK|The process (node) GC memory size, peak over 1-minute intervals.|Bytes
RSS_CURRENT|The process (node) memory resident size, current in sample time.|MB
RSS_PEAK|The process (node) memory resident size, peak over process lifetime.|MB

## Network

**Type** | **Description** | **Units**
-|-|-
ACKS_LOST|Number of lost ACK packets|Packets/Sec
ACKS_REORDERED|Number of reordered ACK packets|Packets/Sec
BAD_RECV_CSUM|Number of packets received with a bad checksum|Packets/Sec
CORRUPT_PACKETS|Number of packets received and deemed corrupted|Packets/Sec
DOUBLY_RECEIVED_PACKETS|Number of packets that were received multiple times|Packets/Sec
DROPPED_LARGE_PACKETS|Number of large packets dropped in the socket backend|Packets/Sec
DROPPED_PACKETS|Number of packets received that we dropped|Packets/Sec
ECN_ENCOUNTERED|Number of ECN Encountered packets|Packets/Sec
FAULT_RECV_DELAYED_PACKETS|Number of received packets delayed due to a fault injection|Packets/Sec
FAULT_RECV_DROPPED_PACKETS|Number of received packets dropped due to a fault injection|Packets/Sec
FAULT_SENT_DELAYED_PACKETS|Number of sent packets delayed due to a fault injection|Packets/Sec
FAULT_SENT_DROPPED_PACKETS|Number of sent packets dropped due to a fault injection|Packets/Sec
FRAGMENTATION_DUPS|Number of packets duplicated during fragmentation|Packets/Sec
GOODPUT_RX_RATIO|Percentage of goodput RX packets out of total data packets received|%
GOODPUT_TX_RATIO|Percentage of goodput TX packets out of total data packets sent|%
GW_MAC_RESOLVE_FAILURES|Number of times we failed to ARP resolve the gateway IP|Failures
GW_MAC_RESOLVE_SUCCESSES|Number of times we succeeded in ARP resolving the gateway IP|Successes
INVALID_FIRST_FRAGMENT|Number of times we got an invalid first fragment|Packets/Sec
MBUF_DUP_COUNT|Number of Duplicate mbufs found|Occurrences
MBUF_DUP_ITER|Duplicate mbuf check completions|Occurrences
NDP_DAD_RECV_ADDR_CONFLICTS|NDP DAD Receive Address Conflict Detected|Packets/Sec
NDP_DAD_RECV_NO_CONFLICTS|NDP DAD Receive No Conflict|Packets/Sec
NODE_RECONNECTED|Number of reconnections|Reconnects/Sec
PACKET_ALIGN_BYTES_COPIED|Number of bytes copied during receive for packet alignment|Bytes/Sec
PACKET_COMBINE_BYTES_COPIED|Number of bytes copied during receive packet buffer combining|Bytes/Sec
PACKETS_FAILING_COMBINE|Number of packets received that failed buffer combining|Packets/Sec
PACKETS_NEEDING_ALIGN|Number of packets received that needed alignment adjustment|Packets/Sec
PACKETS_NEEDING_COMBINE|Number of packets received that needed buffer combining|Packets/Sec
PACKETS_PUMPED|Number of packets received in each call to recvPackets|Batches
PACKETS_RX_EXTMBUF|Number of packets received with external mbuf|Packets
PACKETS_VLAN_INSERTED_HW|Number of packets sent with hardware inserted VLAN tag|Packets/Sec
PACKETS_VLAN_INSERTED_SW|Number of packets sent with software-inserted VLAN tag|Packets/Sec
PACKETS_VLAN_STRIPPED_HW|Number of packets received with hardware stripped VLAN tag|Packets/Sec
PACKETS_VLAN_STRIPPED_SW|Number of packets received with software stripped VLAN tag|Packets/Sec
PEER_RTT_BACKEND|RTT histogram|Microseconds
PEER_RTT_CLIENT|RTT histogram|Microseconds
POISON_DETECTED_EXPECTED|Expected number of poisoned netbufs detected|Occurrences
POISON_DETECTED_UNEXPECTED|Unexpected number of poisoned netbufs detected|Occurrences
POISON_DETECTED|Number of poisoned netbufs detected|Occurrences
PORT_EXT_RX_PACKETS|Number of external packets received|Packets/Sec
PORT_RX_BYTES|Number of bytes received|Bytes/Sec
PORT_RX_ERRORS|Number of packet RX errors|Packets/Sec
PORT_RX_MISSED|Number of packets lost due to RX queue full|Packets/Sec
PORT_RX_NO_MBUFS|Number of packets lost due to no mbufs|Packets/Sec
PORT_RX_PACKETS|Number of packets received|Packets/Sec
PORT_TX_BYTES|Number of bytes transmitted|Bytes/Sec
PORT_TX_ERRORS|Number of packet TX errors|Packets/Sec
PORT_TX_PACKETS|Number of packets transmitted|Packets/Sec
PUMP_DURATION|Duration of each pump|Requests
PUMP_INTERVAL|Interval between pumps|Requests
PUMPS_TXQ_FULL|Number of times we couldn't send any new packets to the NIC queue|Pumps/Sec
PUMPS_TXQ_PARTIAL|Number of times we only sent some of our queued packets to the NIC queue|Pumps/Sec
RDMA_ADD_CHUNK_FAILURES|Number of RDMA cookie setting failures |Failures/Sec
RDMA_AHCACHE_POPULATIONS|Number of RDMA RDMA AH cache population attempts|Attempts/Sec
RDMA_BINDING_FAILOVERS|Number of RDMA High-Availability fail-overs|Fail-overs/Sec
RDMA_CANCELED_COMPLETIONS|Number of RDMA completions that were canceled|Completions/Sec
RDMA_CLIENT_BINDING_INVALIDATIONS|Number of RDMA client binding invalidations|Invalidations/Sec
RDMA_COMP_DURATION|Histogram of RDMA completion duration times|Requests
RDMA_COMP_FAILURES|Number of RDMA requests that were completed with an error|Failures/Sec
RDMA_COMP_LATENCY|Average time of RDMA requests completion|Microseconds
RDMA_COMP_STATUSES|Histogram of RDMA completion statuses|Completions/Sec
RDMA_COMPLETIONS|Number of RDMA requests that were completed|Completions/Sec
RDMA_FAILED_AHCACHE_POPULATIONS|Number of failed RDMA AH cache population attempts|Failed Attempts/Sec
RDMA_FALLBACK_WHILE_AH_POPULATE|Number of fallbacks from RDMA due to AH cache population in progress|Fallbacks/Sec
RDMA_NET_ERR_RETRY_EXCEEDED|Number of RDMA requests with error retries exceeded|Occurrences/Sec
RDMA_NO_LINK_LAYER|Number of RDMA lid parsing due to no link layer|RDMA-No-Link-Layer/Sec
RDMA_POOL_ALLOC_FAILED|Number of times an RDMA request was not issued due to a pool allocation failure|Failures/Sec
RDMA_POOL_LOW_CAPACITY|Number of times an RDMA request was not issued due to low RDMA pool memory|Failures/Sec
RDMA_POOL_MBUF_LEAKED|RDMA leaked mbufs|Occurrences
RDMA_PORT_WAITING_FIBERS|Number of fibers pending to send an RDMA request|Waiting fibers
RDMA_REQUESTS|Number of RDMA requests sent to the NIC|Requests/Sec
RDMA_RX_BYTES|Number of bytes received with RDMA|Bytes/Sec
RDMA_SERVER_BINDING_RESTARTS|Number of RDMA server binding restarts|Restarts/Sec
RDMA_SERVER_FAILED_BINDING_RESTARTS|Number of failed RDMA server binding restarts|Failed Restarts/Sec
RDMA_SERVER_RECV_FAILURES|Number of failed RDMA server-side receive attempts|Failures/Sec
RDMA_SERVER_SEND_FAILURES|Number of failed RDMA server-side send attempts|Failures/Sec
RDMA_SUBMIT_FAILURES|Number of RDMA submit failures, likely indicating a fabric issue|Failures/Sec
RDMA_SUBMIT_TIMEOUTS|Number of RDMA submit timeouts|Timeouts/Sec
RDMA_TX_BYTES|Number of bytes sent with RDMA|Bytes/Sec
RDMA_WAIT_INTERRUPTED|RDMA Wait interruptions|Issues
RDMA_WAIT_PREMATURE_WAKEUP|RDMA Wait for premature wakeup|Issues
RDMA_WAIT_TIMEOUT|RDMA Wait timeouts|Issues/Sec
RECEIVED_ACK_PACKETS|Number of received ack packets|Packets/Sec
RECEIVED_CONTROL_PACKETS|Number of received control packets|Packets/Sec
RECEIVED_DATA_PACKETS|Number of received data packets|Packets/Sec
RECEIVED_PACKET_GENERATIONS|The generation ("resend count") of the first incarnation of the packet seen by the receiver (indicates packet loss)|Packets
RECEIVED_PACKETS|Number of packets received|Packets/Sec
RECEIVED_PING_PACKETS|Number of received ping packets|Packets/Sec
RECEIVED_PONG_PACKETS|Number of received pong packets|Packets/Sec
RECEIVED_REJECT_PACKETS|Number of received reject packets|Packets/Sec
RECEIVED_SYNC_PACKETS|Number of received sync packets|Packets/Sec
REORDERED_PACKETS|Number of reordered packets|Packets/Sec
RESEND_BATCH_SIZE|Number of packets sent in a resend batch|Batches
RESENT_DATA_PACKETS|Number of data packets resent|Packets/Sec
SEND_BATCH_SIZE_BYTES|Number of bytes sent in a first send batch|Batches
SEND_BATCH_SIZE|Number of packets sent in a first send batch|Batches
SEND_QUEUE_TIMEOUTS|Number of packets canceled due to envelope timeout and were not in the send window|Packets/Sec
SEND_WINDOW_TIMEOUTS|Number of packets canceled due to envelope timeout while in the send window|Packets/Sec
SENT_ACKS|Number of ACK packets sent|Packets/Sec
SENT_CONTROL_PACKETS|Number of control packets sent|Packets/Sec
SENT_DATA_PACKETS|Number of data packets sent|Packets/Sec
SENT_PACKETS|Number of sent packets|Packets/Sec
SENT_REJECTS|Number of rejects sent|Packets/Sec
SHORT_CIRCUIT_SENDS|Number of packets sent to the same node|Packets/Sec
SLOW_PATH_CSUM|Number of packets that went through checksum calculation on the CPU|Packets/Sec
TIME_TO_ACK|Histogram of time to acknowledge a data packet|Requests
TIME_TO_FIRST_SEND|Time from queueing to first send|Requests
TIMELY_RESENDS|Number of packets resent due to timely resend|Packets/Sec
UCX_RXQ_FULL|UCX Drop RXQ Full|Packets/Sec
UCX_SEND_CB|UCX Send Callback|Packets/Sec
UCX_SEND_ERROR|UCX Send Error|Packets/Sec
UCX_SENT_PACKETS_ASYNC|UCX Sent Asynchronously|Packets/Sec
UCX_SENT_PACKETS_IMMEDIATE|UCX Sent Immediately|Packets/Sec
UCX_TXQ_FULL|UCX Drop TXQ Full|Packets/Sec
UDP_SENDMSG_FAILED_EAGAIN|Number of packets that failed to be sent on the socket backend with EAGAIN|Packets/Sec
UDP_SENDMSG_FAILED_OTHER|Number of packets that failed to be sent on the socket backend with an unknown error|Packets/Sec
UDP_SENDMSG_PARTIAL_SEND|Number of packets that we failed to send, but in the same pump, some packets were sent|Packets/Sec
UNACKED_RESENDS|Number of packets resent after receiving an ack|Packets/Sec
ZERO_CSUM_OVERWRITE|Number of packets with zero checksum that were overwritten with 0xFFFF|Packets/Sec
ZERO_CSUM|Number of checksum zero received|Packets/Sec

## NODE_TRANSITIONS

**Type** | **Description** | **Units**
-|-|-
JOINING_FENCED_REASON_COUNTS|Counts of reasons JOINING nodes were fenced|Occurrences/Sec
JOINING_TO_UP_TRANSITIONS|Number of nodes transitioned from JOINING to UP.|Nodes
SYNC_TO_JOIN_FAILURE_COUNTS|Counts of SYNCING to JOINING failures categorized by reason|Occurrences/Sec
SYNCING_TO_JOINING_TRANSITIONS|Number of nodes transitioned from SYNCING to JOINING|Nodes
UP_FENCED_REASON_COUNTS|Counts of reasons UP nodes were fenced|Occurrences/Sec

## Object Storage

**Type** | **Description** | **Units**
-|-|-
FAILED_OBJECT_DELETES|Number of failed object deletes per second (any failure reason)|Ops/Sec
FAILED_OBJECT_DOWNLOADS|Number of failed object downloads per second (any failure reason)|Ops/Sec
FAILED_OBJECT_HEAD_QUERIES|Number of failed object head queries per second (any failure reason)|Ops/Sec
FAILED_OBJECT_OPERATIONS|Total number of failed operations per second|Ops/Sec
FAILED_OBJECT_UPLOADS|Number of failed object uploads per second (any failure reason)|Ops/Sec
OBJECT_DELETE_DURATION|Duration of object delete request|Ops
OBJECT_DELETE_LATENCY|Average latency of deleting an object|Microseconds
OBJECT_DELETES|Number of object deletes per second|Ops/Sec
OBJECT_DOWNLOAD_BYTES_BACKGROUND|Number of BACKGROUND bytes sent to the object store per second|Bytes/Sec
OBJECT_DOWNLOAD_BYTES_FOREGROUND|Number of FOREGROUND bytes sent to the object store per second|Bytes/Sec
OBJECT_DOWNLOAD_DURATION|Duration of object download request|Ops
OBJECT_DOWNLOAD_LATENCY|Average latency of downloading an object|Microseconds
OBJECT_DOWNLOAD_SIZE|Size of downloaded object ranges|Ops
OBJECT_DOWNLOADS_BACKGROUND|Number of BACKGROUND objects downloaded per second|Ops/Sec
OBJECT_DOWNLOADS_FOREGROUND|Number of FOREGROUND objects downloaded per second|Ops/Sec
OBJECT_DOWNLOADS|Number of objects downloaded per second|Ops/Sec
OBJECT_HEAD_DURATION|Duration of object head request|Ops
OBJECT_HEAD_LATENCY|Average latency of deleting an object|Microseconds
OBJECT_HEAD_QUERIES|Number of object head queries per second|Ops/Sec
OBJECT_OPERATIONS|Total number of operations per second|Ops/Sec
OBJECT_REMOVE_SIZE|Size of removed objects|Ops
OBJECT_UPLOAD_BYTES_BACKPRESSURE|Number of BACKPRESSURE bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_BYTES_IMMEDIATE_RELEASE|Number of IMMEDIATE_RELEASE bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_BYTES_MANHOLE|Number of MANHOLE bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_BYTES_MIGRATE|Number of MIGRATE bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_BYTES_POLICY|Number of POLICY bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_BYTES_RECLAMATION_REUPLOAD|Number of RECLAMATION_REUPLOAD bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_BYTES_STOW|Number of STOW bytes sent to the object store per second|Bytes/Sec
OBJECT_UPLOAD_DURATION|Duration of object upload request|Ops
OBJECT_UPLOAD_LATENCY|Average latency of uploading an object|Microseconds
OBJECT_UPLOAD_SIZE|Size of uploaded objects|Ops
OBJECT_UPLOADS_BACKPRESSURE|Number of BACKPRESSURE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_IMMEDIATE_RELEASE|Number of IMMEDIATE_RELEASE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_MANHOLE|Number of MANHOLE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_MIGRATE|Number of MIGRATE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_POLICY|Number of POLICY upload attempts per second|Ops/Sec
OBJECT_UPLOADS_RECLAMATION_REUPLOAD|Number of RECLAMATION_REUPLOAD upload attempts per second|Ops/Sec
OBJECT_UPLOADS_STOW|Number of STOW upload attempts per second|Ops/Sec
OBJECT_UPLOADS|Number of object uploads per second|Ops/Sec
OBS_READ_BYTES|Number of bytes read from object storage|Bytes/Sec
OBS_WRITE_BYTES|Number of bytes sent to object storage|Bytes/Sec
ONGOING_DOWNLOADS|Number of ongoing downloads|Ops
ONGOING_REMOVES|Number of ongoing removes|Ops
ONGOING_UPLOADS|Number of ongoing uploads|Ops
READ_BYTES|Number of bytes read from object storage|Bytes/Sec
REMOVE_BYTES|Number of bytes removed from object storage|Bytes/Sec
REQUEST_COUNT_DELETE|Number of HTTP DELETE requests per second|Requests/Sec
REQUEST_COUNT_GET|Number of HTTP GET requests per second|Requests/Sec
REQUEST_COUNT_HEAD|Number of HTTP HEAD requests per second|Requests/Sec
REQUEST_COUNT_INVALID|Number of HTTP INVALID requests per second|Requests/Sec
REQUEST_COUNT_POST|Number of HTTP POST requests per second|Requests/Sec
REQUEST_COUNT_PUT|Number of HTTP PUT requests per second|Requests/Sec
RESPONSE_COUNT_ACCEPTED|Number of HTTP ACCEPTED responses per second|Responses/Sec
RESPONSE_COUNT_BAD_GATEWAY|Number of HTTP BAD_GATEWAY responses per second|Responses/Sec
RESPONSE_COUNT_BAD_REQUEST|Number of HTTP BAD_REQUEST responses per second|Responses/Sec
RESPONSE_COUNT_CONFLICT|Number of HTTP CONFLICT responses per second|Responses/Sec
RESPONSE_COUNT_CONTINUE|Number of HTTP CONTINUE responses per second|Responses/Sec
RESPONSE_COUNT_CREATED|Number of HTTP CREATED responses per second|Responses/Sec
RESPONSE_COUNT_EXPECTATION_FAILED|Number of HTTP EXPECTATION_FAILED responses per second|Responses/Sec
RESPONSE_COUNT_FORBIDDEN|Number of HTTP FORBIDDEN responses per second|Responses/Sec
RESPONSE_COUNT_FOUND|Number of HTTP FOUND responses per second|Responses/Sec
RESPONSE_COUNT_GATEWAY_TIMEOUT|Number of HTTP GATEWAY_TIMEOUT responses per second|Responses/Sec
RESPONSE_COUNT_GONE|Number of HTTP GONE responses per second|Responses/Sec
RESPONSE_COUNT_HTTP_VERSION_NOT_SUPPORTED|Number of HTTP HTTP_VERSION_NOT_SUPPORTED responses per second|Responses/Sec
RESPONSE_COUNT_INSUFFICIENT_STORAGE|Number of HTTP INSUFFICIENT_STORAGE responses per second|Responses/Sec
RESPONSE_COUNT_INVALID|Number of HTTP INVALID responses per second|Responses/Sec
RESPONSE_COUNT_LENGTH_REQUIRED|Number of HTTP LENGTH_REQUIRED responses per second|Responses/Sec
RESPONSE_COUNT_METHOD_NOT_ALLOWED|Number of HTTP METHOD_NOT_ALLOWED responses per second|Responses/Sec
RESPONSE_COUNT_MOVED_PERMANENTLY|Number of HTTP MOVED_PERMANENTLY responses per second|Responses/Sec
RESPONSE_COUNT_NO_CONTENT|Number of HTTP NO_CONTENT responses per second|Responses/Sec
RESPONSE_COUNT_NON_AUTH_INFO|Number of HTTP NON_AUTH_INFO responses per second|Responses/Sec
RESPONSE_COUNT_NOT_ACCEPTABLE|Number of HTTP NOT_ACCEPTABLE responses per second|Responses/Sec
RESPONSE_COUNT_NOT_FOUND|Number of HTTP NOT_FOUND responses per second|Responses/Sec
RESPONSE_COUNT_NOT_IMPLEMENTED|Number of HTTP NOT_IMPLEMENTED responses per second|Responses/Sec
RESPONSE_COUNT_NOT_MODIFIED|Number of HTTP NOT_MODIFIED responses per second|Responses/Sec
RESPONSE_COUNT_OK|Number of HTTP OK responses per second|Responses/Sec
RESPONSE_COUNT_PARTIAL_CONTENT|Number of HTTP PARTIAL_CONTENT responses per second|Responses/Sec
RESPONSE_COUNT_PAYMENT_REQUIRED|Number of HTTP PAYMENT_REQUIRED responses per second|Responses/Sec
RESPONSE_COUNT_PRECONDITION_FAILED|Number of HTTP PRECONDITION_FAILED responses per second|Responses/Sec
RESPONSE_COUNT_PROXY_AUTH_REQUIRED|Number of HTTP PROXY_AUTH_REQUIRED responses per second|Responses/Sec
RESPONSE_COUNT_REDIRECT_MULTIPLE_CHOICES|Number of HTTP REDIRECT_MULTIPLE_CHOICES responses per second|Responses/Sec
RESPONSE_COUNT_REQUEST_HEADER_FIELDS_TOO_LARGE|Number of HTTP REQUEST_HEADER_FIELDS_TOO_LARGE responses per second|Responses/Sec
RESPONSE_COUNT_REQUEST_TIMEOUT|Number of HTTP REQUEST_TIMEOUT responses per second|Responses/Sec
RESPONSE_COUNT_REQUEST_TOO_LARGE|Number of HTTP REQUEST_TOO_LARGE responses per second|Responses/Sec
RESPONSE_COUNT_REQUESTED_RANGE_NOT_SATISFIABLE|Number of HTTP REQUESTED_RANGE_NOT_SATISFIABLE responses per second|Responses/Sec
RESPONSE_COUNT_RESET_CONTENT|Number of HTTP RESET_CONTENT responses per second|Responses/Sec
RESPONSE_COUNT_SEE_OTHER|Number of HTTP SEE_OTHER responses per second|Responses/Sec
RESPONSE_COUNT_SERVER_ERROR|Number of HTTP SERVER_ERROR responses per second|Responses/Sec
RESPONSE_COUNT_SERVICE_UNAVAILABLE|Number of HTTP SERVICE_UNAVAILABLE responses per second|Responses/Sec
RESPONSE_COUNT_SWITCHING_PROTOCOL|Number of HTTP SWITCHING_PROTOCOL responses per second|Responses/Sec
RESPONSE_COUNT_TEMP_REDIRECT|Number of HTTP TEMP_REDIRECT responses per second|Responses/Sec
RESPONSE_COUNT_UNAUTHORIZED|Number of HTTP UNAUTHORIZED responses per second|Responses/Sec
RESPONSE_COUNT_UNPROCESSABLE_ENTITY|Number of HTTP UNPROCESSABLE_ENTITY responses per second|Responses/Sec
RESPONSE_COUNT_UNSUPPORTED_MEDIA_TYPE|Number of HTTP UNSUPPORTED_MEDIA_TYPE responses per second|Responses/Sec
RESPONSE_COUNT_URI_TOO_LONG|Number of HTTP URI_TOO_LONG responses per second|Responses/Sec
RESPONSE_COUNT_USE_PROXY|Number of HTTP USE_PROXY responses per second|Responses/Sec
WAITING_FOR_BUCKET_DOWNLOAD_BANDWIDTH|Time requests wait for the object store bucket download bandwidth|Ops
WAITING_FOR_BUCKET_DOWNLOAD_FLOW|Time requests wait for the object store bucket download flow|Ops
WAITING_FOR_BUCKET_REMOVE_BANDWIDTH|Time requests wait for the object store bucket remove bandwidth|Ops
WAITING_FOR_BUCKET_REMOVE_FLOW|Time requests wait for the object store bucket remove flow|Ops
WAITING_FOR_BUCKET_UPLOAD_BANDWIDTH|Time requests wait for the object store bucket upload bandwidth|Ops
WAITING_FOR_BUCKET_UPLOAD_FLOW|Time requests wait for the object store bucket upload flow|Ops
WAITING_FOR_GROUP_DOWNLOAD_BANDWIDTH|Time requests wait for the object store group download bandwidth|Ops
WAITING_FOR_GROUP_DOWNLOAD_FLOW|Time requests wait for the object store group download flow|Ops
WAITING_FOR_GROUP_REMOVE_BANDWIDTH|Time requests wait for the object store group remove bandwidth|Ops
WAITING_FOR_GROUP_REMOVE_FLOW|Time requests wait for the object store group remove flow|Ops
WAITING_FOR_GROUP_UPLOAD_BANDWIDTH|Time requests wait for the object store group upload bandwidth|Ops
WAITING_FOR_GROUP_UPLOAD_FLOW|Time requests wait for the object store group upload flow|Ops
WAITING_IN_BUCKET_DOWNLOAD_QUEUE|Time requests wait in the object store bucket download queue|Ops
WAITING_IN_BUCKET_REMOVE_QUEUE|Time requests wait in the object store bucket remove queue|Ops
WAITING_IN_BUCKET_UPLOAD_QUEUE|Time requests wait in the object store bucket upload queue|Ops
WAITING_IN_GROUP_DOWNLOAD_QUEUE|Time requests wait in the object store group download queue|Ops
WAITING_IN_GROUP_REMOVE_QUEUE|Time requests wait in the object store group remove queue|Ops
WAITING_IN_GROUP_UPLOAD_QUEUE|Time requests wait in object-store group upload queue|Ops
WRITE_BYTES|Number of bytes sent to object storage|Bytes/Sec

## Operations

**Type** | **Description** | **Units**
-|-|-
ACCESS_LATENCY|Average latency of ACCESS operations|Microseconds
ACCESS_OPS|Number of ACCESS operations per second|Ops/Sec
COMMIT_LATENCY|Average latency of COMMIT operations|Microseconds
COMMIT_OPS|Number of COMMIT operations per second|Ops/Sec
CREATE_LATENCY|Average latency of CREATE operations|Microseconds
CREATE_OPS|Number of CREATE operations per second|Ops/Sec
FILEATOMICOPEN_LATENCY|Average latency of FILEATOMICOPEN operations|Microseconds
FILEATOMICOPEN_OPS|Number of FILEATOMICOPEN operations per second|Ops/Sec
FILECLOSE_LATENCY|Average latency of FILECLOSE operations|Microseconds
FILECLOSE_OPS|Number of FILECLOSE operations per second|Ops/Sec
FILEOPEN_LATENCY|Average latency of FILEOPEN operations|Microseconds
FILEOPEN_OPS|Number of FILEOPEN operations per second|Ops/Sec
FLOCK_LATENCY|Average latency of FLOCK operations|Microseconds
FLOCK_OPS|Number of FLOCK operations per second|Ops/Sec
FSINFO_LATENCY|Average latency of FSINFO operations|Microseconds
FSINFO_OPS|Number of FSINFO operations per second|Ops/Sec
GETATTR_LATENCY|Average latency of GETATTR operations|Microseconds
GETATTR_OPS|Number of GETATTR operations per second|Ops/Sec
LINK_LATENCY|Average latency of LINK operations|Microseconds
LINK_OPS|Number of LINK operations per second|Ops/Sec
LOOKUP_LATENCY|Average latency of LOOKUP operations|Microseconds
LOOKUP_OPS|Number of LOOKUP operations per second|Ops/Sec
MKDIR_LATENCY|Average latency of MKDIR operations|Microseconds
MKDIR_OPS|Number of MKDIR operations per second|Ops/Sec
MKNOD_LATENCY|Average latency of MKNOD operations|Microseconds
MKNOD_OPS|Number of MKNOD operations per second|Ops/Sec
OPS|Total number of operations|Ops/Sec
PATHCONF_LATENCY|Average latency of PATHCONF operations|Microseconds
PATHCONF_OPS|Number of PATHCONF operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_DURATION|The number of reads per completion duration|Reads
READ_LATENCY|Average latency of READ operations|Microseconds
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READS|Number of read operations per second|Ops/Sec
REMOVE_LATENCY|Average latency of REMOVE operations|Microseconds
REMOVE_OPS|Number of REMOVE operations per second|Ops/Sec
RENAME_LATENCY|Average latency of RENAME operations|Microseconds
RENAME_OPS|Number of RENAME operations per second|Ops/Sec
RMDIR_LATENCY|Average latency of RMDIR operations|Microseconds
RMDIR_OPS|Number of RMDIR operations per second|Ops/Sec
SETATTR_LATENCY|Average latency of SETATTR operations|Microseconds
SETATTR_OPS|Number of SETATTR operations per second|Ops/Sec
STATFS_LATENCY|Average latency of STATFS operations|Microseconds
STATFS_OPS|Number of STATFS operations per second|Ops/Sec
SYMLINK_LATENCY|Average latency of SYMLINK operations|Microseconds
SYMLINK_OPS|Number of SYMLINK operations per second|Ops/Sec
THROUGHPUT|Number of bytes read/writes per second|Bytes/Sec
UNLINK_LATENCY|Average latency of UNLINK operations|Microseconds
UNLINK_OPS|Number of UNLINK operations per second|Ops/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_DURATION|The number of writes per completion duration|Writes
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITES|Number of write operations per second|Ops/Sec

## Operations (driver)

**Type** | **Description** | **Units**
-|-|-
DIRECT_READ_SIZES_RATE|The number of O_DIRECT reads per each read size range per second|Reads
DIRECT_READ_SIZES|The number of O_DIRECT reads per each read size range|Reads
DIRECT_WRITE_SIZES_RATE|The number of O_DIRECT writes per each read size range per second|Writes
DIRECT_WRITE_SIZES|The number of O_DIRECT writes per each read size range|Writes
DOORBELL_RING_COUNT|The number of times the driver queue's doorbell was ringed|Ops
FAILED_1HOP_READS|Number of failed single hop reads per second|Ops/Sec
FILEATOMICOPEN_LATENCY|Average latency of FILEATOMICOPEN operations|Microseconds
FILEATOMICOPEN_OPS|Number of FILEATOMICOPEN operations per second|Ops/Sec
FILEATOMICOPEN_QOS_DELAY|Average QoS delay for FILEATOMICOPEN operations|Microseconds
FILECLOSE_LATENCY|Average latency of FILECLOSE operations|Microseconds
FILECLOSE_OPS|Number of FILECLOSE operations per second|Ops/Sec
FILECLOSE_QOS_DELAY|Average QoS delay for FILECLOSE operations|Microseconds
FILEOPEN_LATENCY|Average latency of FILEOPEN operations|Microseconds
FILEOPEN_OPS|Number of FILEOPEN operations per second|Ops/Sec
FILEOPEN_QOS_DELAY|Average QoS delay for FILEOPEN operations|Microseconds
FLOCK_LATENCY|Average latency of FLOCK operations|Microseconds
FLOCK_OPS|Number of FLOCK operations per second|Ops/Sec
FLOCK_QOS_DELAY|Average QoS delay for FLOCK operations|Microseconds
GETATTR_LATENCY|Average latency of GETATTR operations|Microseconds
GETATTR_OPS|Number of GETATTR operations per second|Ops/Sec
GETATTR_QOS_DELAY|Average QoS delay for GETATTR operations|Microseconds
GETXATTR_LATENCY|Average latency of GETXATTR operations|Microseconds
GETXATTR_OPS|Number of GETXATTR operations per second|Ops/Sec
GETXATTR_QOS_DELAY|Average QoS delay for GETXATTR operations|Microseconds
IOCTL_OBS_PREFETCH_LATENCY|Average latency of IOCTL_OBS_PREFETCH operations|Microseconds
IOCTL_OBS_PREFETCH_OPS|Number of IOCTL_OBS_PREFETCH operations per second|Ops/Sec
IOCTL_OBS_PREFETCH_QOS_DELAY|Average QoS delay for IOCTL_OBS_PREFETCH operations|Microseconds
IOCTL_OBS_RELEASE_LATENCY|Average latency of IOCTL_OBS_RELEASE operations|Microseconds
IOCTL_OBS_RELEASE_OPS|Number of IOCTL_OBS_RELEASE operations per second|Ops/Sec
IOCTL_OBS_RELEASE_QOS_DELAY|Average QoS delay for IOCTL_OBS_RELEASE operations|Microseconds
KEEPALIVES_NO_LEASE|Number of driver keepalives sent while we have no lease|Ops/Sec
LINK_LATENCY|Average latency of LINK operations|Microseconds
LINK_OPS|Number of LINK operations per second|Ops/Sec
LINK_QOS_DELAY|Average QoS delay for LINK operations|Microseconds
LISTXATTR_LATENCY|Average latency of LISTXATTR operations|Microseconds
LISTXATTR_OPS|Number of LISTXATTR operations per second|Ops/Sec
LISTXATTR_QOS_DELAY|Average QoS delay for LISTXATTR operations|Microseconds
LOOKUP_LATENCY|Average latency of LOOKUP operations|Microseconds
LOOKUP_OPS|Number of LOOKUP operations per second|Ops/Sec
LOOKUP_QOS_DELAY|Average QoS delay for LOOKUP operations|Microseconds
MKNOD_LATENCY|Average latency of MKNOD operations|Microseconds
MKNOD_OPS|Number of MKNOD operations per second|Ops/Sec
MKNOD_QOS_DELAY|Average QoS delay for MKNOD operations|Microseconds
OPS|Total number of operations|Ops/Sec
PENDING_IOS_COUNT|Pending IO count per FE container|Ops
RDMA_WRITE_REQUESTS|Number of RDMA write request operations per second|Ops/Sec
READ_BYTES_1HOP|Number of bytes read per second via single hop|Bytes/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_CHECKSUM_ERRORS|The number of times the driver's checksum validation failed upon the read's content|Ops
READ_CORRUPTIONS_DETECTED_IN_1HOP|The number of corrupt data blocks encountered during 1-hop read|Ops
READ_DURATION|The number of reads per time duration|Reads
READ_LATENCY_NO_QOS|Average latency of READ operations without QoS delay|Microseconds
READ_LATENCY|Average latency of READ operations|Microseconds
READ_PARENT_SELINUX_ATTRIBUTE|The number of times we could not get SELinux attribute from parent|Ops
READ_QOS_DELAY|Average QoS delay for READ operations|Microseconds
READ_RDMA_SIZES_RATE|The number of RDMA reads per each read size range per second|Reads
READ_RDMA_SIZES|The number of RDMA reads per each read size range|Reads
READ_SIZES_RATE|The number of reads per read size range per second|Reads
READ_SIZES|The number of reads per each read size range|Reads
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READDIR_QOS_DELAY|Average QoS delay for READDIR operations|Microseconds
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READLINK_QOS_DELAY|Average QoS delay for READLINK operations|Microseconds
READS_NO_LEASE|Number of direct reads while we have no lease|Ops/Sec
READS|Number of read operations per second|Ops/Sec
RENAME_LATENCY|Average latency of RENAME operations|Microseconds
RENAME_OPS|Number of RENAME operations per second|Ops/Sec
RENAME_QOS_DELAY|Average QoS delay for RENAME operations|Microseconds
REQUESTS_COMPLETED|The number of completions frontends sent to the driver's queue|Ops
REQUESTS_FETCHED|The number of operations frontends fetched from the driver's queue|Ops
RMDIR_LATENCY|Average latency of RMDIR operations|Microseconds
RMDIR_OPS|Number of RMDIR operations per second|Ops/Sec
RMDIR_QOS_DELAY|Average QoS delay for RMDIR operations|Microseconds
RMXATTR_LATENCY|Average latency of RMXATTR operations|Microseconds
RMXATTR_OPS|Number of RMXATTR operations per second|Ops/Sec
RMXATTR_QOS_DELAY|Average QoS delay for RMXATTR operations|Microseconds
SETATTR_LATENCY|Average latency of SETATTR operations|Microseconds
SETATTR_OPS|Number of SETATTR operations per second|Ops/Sec
SETATTR_QOS_DELAY|Average QoS delay for SETATTR operations|Microseconds
SETXATTR_LATENCY|Average latency of SETXATTR operations|Microseconds
SETXATTR_OPS|Number of SETXATTR operations per second|Ops/Sec
SETXATTR_QOS_DELAY|Average QoS delay for SETXATTR operations|Microseconds
SINGLE_HOP_WRITE_ATTEMPTS|Number of single-hop write operation attempts per second|Ops/Sec
SINGLE_HOP_WRITE_PUT_BLOCKS_RDMA_FAILURES|Number of single hop write putBlock calls per second that failed RDMA|Calls/Sec
SINGLE_HOP_WRITE_RDMA_FAILURES|Number of single-hop write operations per second that failed RDMA|Ops/Sec
SINGLE_HOP_WRITE_RETRY_NO_RDMA|Number of single hop writes per second that were retried without RDMA|Ops/Sec
SINGLE_HOP_WRITE_SKIPS_DISABLED|Number of single-hop write operation skips (DISABLED) per second|Ops/Sec
SINGLE_HOP_WRITE_SKIPS_EXTERNAL_RDMA|Number of single hop write operation skips (EXTERNAL_RDMA) per second|Ops/Sec
SINGLE_HOP_WRITE_SKIPS_MAX_CONCURRENCY|Number of single hop write operation skips (MAX_CONCURRENCY) per second|Ops/Sec
SINGLE_HOP_WRITE_SKIPS_PARTIAL_BLOCKS|Number of single hop write operation skips (PARTIAL_BLOCKS) per second|Ops/Sec
SINGLE_HOP_WRITE_SKIPS_SMALL_WRITE|Number of single hop write operation skips (SMALL_WRITE) per second|Ops/Sec
SINGLE_HOP_WRITE_SKIPS_UNINIT_CHECKSUM|Number of single hop write operation skips (UNINIT_CHECKSUM) per second|Ops/Sec
SINGLE_HOP_WRITE_SKIPS|Number of single-hop write operation skips per second|Ops/Sec
SKIPPED_1HOP_READS_DISABLED|Number of skipped single hop reads per second because it is disabled|Ops/Sec
SKIPPED_1HOP_READS_EXTERNAL_RDMA_SPARSE|Number of skipped single hop reads per second because it is a sparse read on external RDMA|Ops/Sec
SKIPPED_1HOP_READS_GET_EXTENT_FAILED|Number of skipped single hop reads per second due to get extent failed|Ops/Sec
SKIPPED_1HOP_READS_PARTIAL_READ|Number of skipped single hop reads per second due to partial read failure|Ops/Sec
SKIPPED_1HOP_READS_SSD_LOAD|Number of skipped single hop reads per second due to drive load|Ops/Sec
SKIPPED_1HOP_READS_TOO_MANY_DESCRIPTORS|Number of skipped single hop reads per second due to too many descriptors|Ops/Sec
SKIPPED_1HOP_READS_TOO_MANY_DRIVES|Number of skipped single hop reads per second due to too many drives|Ops/Sec
SKIPPED_1HOP_READS_TOO_SMALL|Number of skipped single hop reads per second because IO is too small|Ops/Sec
STATFS_LATENCY|Average latency of STATFS operations|Microseconds
STATFS_OPS|Number of STATFS operations per second|Ops/Sec
STATFS_QOS_DELAY|Average QoS delay for STATFS operations|Microseconds
SUCCEEDED_1HOP_READS|Number of successful single hop reads per second|Ops/Sec
SYMLINK_LATENCY|Average latency of SYMLINK operations|Microseconds
SYMLINK_OPS|Number of SYMLINK operations per second|Ops/Sec
SYMLINK_QOS_DELAY|Average QoS delay for SYMLINK operations|Microseconds
THROUGHPUT|Number of read/write bytes per second|Bytes/Sec
UNLINK_LATENCY|Average latency of UNLINK operations|Microseconds
UNLINK_OPS|Number of UNLINK operations per second|Ops/Sec
UNLINK_QOS_DELAY|Average QoS delay for UNLINK operations|Microseconds
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_DURATION|The number of writes per time duration|Writes
WRITE_LATENCY_NO_QOS|Average latency of WRITE operations without QoS delay|Microseconds
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITE_QOS_DELAY|Average QoS delay for WRITE operations|Microseconds
WRITE_RDMA_SIZES_RATE|The number of RDMA writes per each read size range per second|Writes
WRITE_RDMA_SIZES|The number of RDMA writes per each read size range|Writes
WRITE_SIZES_RATE|The number of writes per each read size range per second|Writes
WRITE_SIZES|The number of writes per each read size range|Writes
WRITES_NO_LEASE|Number of direct writes while we have no lease|Ops/Sec
WRITES|Number of write operations per second|Ops/Sec

## Operations (Filesystem)

**Type** | **Description** | **Units**
-|-|-
READ_BYTES|Total read bytes per filesystem|Bytes/Sec
READ_LATENCY|Average latency of read operations per filesystem|Microseconds
READS|Number of read operations per second per filesystem|Ops/Sec
THROUGHPUT|Number of bytes read/writes per second per filesystem|Bytes/Sec
WRITE_BYTES|Total write bytes per filesystem|Bytes/Sec
WRITE_LATENCY|Average latency of write operations per filesystem |Microseconds
WRITES|Number of write operations per second per filesystem|Ops/Sec

## Operations (NFS)

**Type** | **Description** | **Units**
-|-|-
ACCESS_LATENCY|Average latency of ACCESS operations|Microseconds
ACCESS_OPS|Number of ACCESS operations per second|Ops/Sec
COMMIT_LATENCY|Average latency of COMMIT operations|Microseconds
COMMIT_OPS|Number of COMMIT operations per second|Ops/Sec
CREATE_LATENCY|Average latency of CREATE operations|Microseconds
CREATE_OPS|Number of CREATE operations per second|Ops/Sec
FSINFO_LATENCY|Average latency of FSINFO operations|Microseconds
FSINFO_OPS|Number of FSINFO operations per second|Ops/Sec
GETATTR_LATENCY|Average latency of GETATTR operations|Microseconds
GETATTR_OPS|Number of GETATTR operations per second|Ops/Sec
LINK_LATENCY|Average latency of LINK operations|Microseconds
LINK_OPS|Number of LINK operations per second|Ops/Sec
LOOKUP_LATENCY|Average latency of LOOKUP operations|Microseconds
LOOKUP_OPS|Number of LOOKUP operations per second|Ops/Sec
MKDIR_LATENCY|Average latency of MKDIR operations|Microseconds
MKDIR_OPS|Number of MKDIR operations per second|Ops/Sec
MKNOD_LATENCY|Average latency of MKNOD operations|Microseconds
MKNOD_OPS|Number of MKNOD operations per second|Ops/Sec
OPS|Total number of operations|Ops/Sec
PATHCONF_LATENCY|Average latency of PATHCONF operations|Microseconds
PATHCONF_OPS|Number of PATHCONF operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_DURATION|The number of reads per completion duration|Reads
READ_LATENCY|Average latency of READ operations|Microseconds
READ_SIZES|NFS read sizes histogram|Reads
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READS|Number of read operations per second|Ops/Sec
REMOVE_LATENCY|Average latency of REMOVE operations|Microseconds
REMOVE_OPS|Number of REMOVE operations per second|Ops/Sec
RENAME_LATENCY|Average latency of RENAME operations|Microseconds
RENAME_OPS|Number of RENAME operations per second|Ops/Sec
SETATTR_LATENCY|Average latency of SETATTR operations|Microseconds
SETATTR_OPS|Number of SETATTR operations per second|Ops/Sec
STATFS_LATENCY|Average latency of STATFS operations|Microseconds
STATFS_OPS|Number of STATFS operations per second|Ops/Sec
SYMLINK_LATENCY|Average latency of SYMLINK operations|Microseconds
SYMLINK_OPS|Number of SYMLINK operations per second|Ops/Sec
THROUGHPUT|Number of bytes read/writes per second|Bytes/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_DURATION|The number of writes per completion duration|Writes
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITE_SIZES|NFS write sizes histogram|Writes
WRITES|Number of write operations per second|Ops/Sec

## Operations (NFSw)

**Type** | **Description** | **Units**
-|-|-
ACCESS_LATENCY|Average latency of ACCESS operations|Microseconds
ACCESS_OPS|Number of ACCESS operations per second|Ops/Sec
COMMIT_LATENCY|Average latency of COMMIT operations|Microseconds
COMMIT_OPS|Number of COMMIT operations per second|Ops/Sec
CREATE_LATENCY|Average latency of CREATE operations|Microseconds
CREATE_OPS|Number of CREATE operations per second|Ops/Sec
GETATTR_LATENCY|Average latency of GETATTR operations|Microseconds
GETATTR_OPS|Number of GETATTR operations per second|Ops/Sec
LINK_LATENCY|Average latency of LINK operations|Microseconds
LINK_OPS|Number of LINK operations per second|Ops/Sec
LOOKUP_LATENCY|Average latency of LOOKUP operations|Microseconds
LOOKUP_OPS|Number of LOOKUP operations per second|Ops/Sec
NFS3_ACCESS_ID_LATENCY|Average latency of NFS3_ACCESS  operations|Microseconds
NFS3_ACCESS_ID_OPS|Number of NFS3_ACCESS operations per second|Ops/Sec
NFS3_COMMIT_ID_LATENCY|Average latency of NFS3_COMMIT  operations|Microseconds
NFS3_COMMIT_ID_OPS|Number of NFS3_COMMIT operations per second|Ops/Sec
NFS3_CREATE_ID_LATENCY|Average latency of NFS3_CREATE  operations|Microseconds
NFS3_CREATE_ID_OPS|Number of NFS3_CREATE operations per second|Ops/Sec
NFS3_FSINFO_ID_LATENCY|Average latency of NFS3_FSINFO  operations|Microseconds
NFS3_FSINFO_ID_OPS|Number of NFS3_FSINFO operations per second|Ops/Sec
NFS3_FSINFO_LATENCY|Average latency of NFS3_FSINFO operations|Microseconds
NFS3_FSINFO_OPS|Number of NFS3_FSINFO operations per second|Ops/Sec
NFS3_GETATTR_ID_LATENCY|Average latency of NFS3_GETATTR  operations|Microseconds
NFS3_GETATTR_ID_OPS|Number of NFS3_GETATTR operations per second|Ops/Sec
NFS3_LINK_ID_LATENCY|Average latency of NFS3_LINK  operations|Microseconds
NFS3_LINK_ID_OPS|Number of NFS3_LINK operations per second|Ops/Sec
NFS3_LOOKUP_ID_LATENCY|Average latency of NFS3_LOOKUP  operations|Microseconds
NFS3_LOOKUP_ID_OPS|Number of NFS3_LOOKUP operations per second|Ops/Sec
NFS3_MKDIR_ID_LATENCY|Average latency of NFS3_MKDIR  operations|Microseconds
NFS3_MKDIR_ID_OPS|Number of NFS3_MKDIR operations per second|Ops/Sec
NFS3_MKDIR_LATENCY|Average latency of NFS3_MKDIR operations|Microseconds
NFS3_MKDIR_OPS|Number of NFS3_MKDIR operations per second|Ops/Sec
NFS3_MKNOD_ID_LATENCY|Average latency of NFS3_MKNOD  operations|Microseconds
NFS3_MKNOD_ID_OPS|Number of NFS3_MKNOD operations per second|Ops/Sec
NFS3_MKNOD_LATENCY|Average latency of NFS3_MKNOD operations|Microseconds
NFS3_MKNOD_OPS|Number of NFS3_MKNOD operations per second|Ops/Sec
NFS3_OPS_ID|Number of NFS3_OPS per second|Ops/Sec
NFS3_PATHCONF_ID_LATENCY|Average latency of NFS3_PATHCONF  operations|Microseconds
NFS3_PATHCONF_ID_OPS|Number of NFS3_PATHCONF operations per second|Ops/Sec
NFS3_PATHCONF_LATENCY|Average latency of NFS3_PATHCONF operations|Microseconds
NFS3_PATHCONF_OPS|Number of NFS3_PATHCONF operations per second|Ops/Sec
NFS3_READ_BYTES_ID|Number of NFS3_READ_BYTES per second|Bytes/Sec
NFS3_READ_ID_LATENCY|Average latency of NFS3_READ  operations|Microseconds
NFS3_READ_ID_OPS|Number of NFS3_READ operations per second|Ops/Sec
NFS3_READDIR_ID_LATENCY|Average latency of NFS3_READDIR  operations|Microseconds
NFS3_READDIR_ID_OPS|Number of NFS3_READDIR operations per second|Ops/Sec
NFS3_READLINK_ID_LATENCY|Average latency of NFS3_READLINK  operations|Microseconds
NFS3_READLINK_ID_OPS|Number of NFS3_READLINK operations per second|Ops/Sec
NFS3_REMOVE_ID_LATENCY|Average latency of NFS3_REMOVE  operations|Microseconds
NFS3_REMOVE_ID_OPS|Number of NFS3_REMOVE operations per second|Ops/Sec
NFS3_RENAME_ID_LATENCY|Average latency of NFS3_RENAME  operations|Microseconds
NFS3_RENAME_ID_OPS|Number of NFS3_RENAME operations per second|Ops/Sec
NFS3_SETATTR_ID_LATENCY|Average latency of NFS3_SETATTR  operations|Microseconds
NFS3_SETATTR_ID_OPS|Number of NFS3_SETATTR operations per second|Ops/Sec
NFS3_STATFS_ID_LATENCY|Average latency of NFS3_STATFS  operations|Microseconds
NFS3_STATFS_ID_OPS|Number of NFS3_STATFS operations per second|Ops/Sec
NFS3_STATFS_LATENCY|Average latency of NFS3_STATFS operations|Microseconds
NFS3_STATFS_OPS|Number of NFS3_STATFS operations per second|Ops/Sec
NFS3_SYMLINK_ID_LATENCY|Average latency of NFS3_SYMLINK  operations|Microseconds
NFS3_SYMLINK_ID_OPS|Number of NFS3_SYMLINK operations per second|Ops/Sec
NFS3_SYMLINK_LATENCY|Average latency of NFS3_SYMLINK operations|Microseconds
NFS3_SYMLINK_OPS|Number of NFS3_SYMLINK operations per second|Ops/Sec
NFS3_WRITE_BYTES_ID|Number of NFS3_WRITE_BYTES per second|Bytes/Sec
NFS3_WRITE_ID_LATENCY|Average latency of NFS3_WRITE  operations|Microseconds
NFS3_WRITE_ID_OPS|Number of NFS3_WRITE operations per second|Ops/Sec
NFS4_ACCESS_ID_LATENCY|Average latency of NFS4_ACCESS  operations|Microseconds
NFS4_ACCESS_ID_OPS|Number of NFS4_ACCESS operations per second|Ops/Sec
NFS4_BACKCHANNEL_CTL_ID_LATENCY|Average latency of NFS4_BACKCHANNEL_CTL  operations|Microseconds
NFS4_BACKCHANNEL_CTL_ID_OPS|Number of NFS4_BACKCHANNEL_CTL operations per second|Ops/Sec
NFS4_BACKCHANNEL_CTL_LATENCY|Average latency of NFS4_BACKCHANNEL_CTL operations|Microseconds
NFS4_BACKCHANNEL_CTL_OPS|Number of NFS4_BACKCHANNEL_CTL operations per second|Ops/Sec
NFS4_BIND_CONN_TO_SESSION_ID_LATENCY|Average latency of NFS4_BIND_CONN_TO_SESSION  operations|Microseconds
NFS4_BIND_CONN_TO_SESSION_ID_OPS|Number of NFS4_BIND_CONN_TO_SESSION operations per second|Ops/Sec
NFS4_BIND_CONN_TO_SESSION_LATENCY|Average latency of NFS4_BIND_CONN_TO_SESSION operations|Microseconds
NFS4_BIND_CONN_TO_SESSION_OPS|Number of NFS4_BIND_CONN_TO_SESSION operations per second|Ops/Sec
NFS4_CLOSE_ID_LATENCY|Average latency of NFS4_CLOSE  operations|Microseconds
NFS4_CLOSE_ID_OPS|Number of NFS4_CLOSE operations per second|Ops/Sec
NFS4_CLOSE_LATENCY|Average latency of NFS4_CLOSE operations|Microseconds
NFS4_CLOSE_OPS|Number of NFS4_CLOSE operations per second|Ops/Sec
NFS4_COMMIT_ID_LATENCY|Average latency of NFS4_COMMIT  operations|Microseconds
NFS4_COMMIT_ID_OPS|Number of NFS4_COMMIT operations per second|Ops/Sec
NFS4_CREATE_ID_LATENCY|Average latency of NFS4_CREATE  operations|Microseconds
NFS4_CREATE_ID_OPS|Number of NFS4_CREATE operations per second|Ops/Sec
NFS4_CREATE_SESSION_ID_LATENCY|Average latency of NFS4_CREATE_SESSION  operations|Microseconds
NFS4_CREATE_SESSION_ID_OPS|Number of NFS4_CREATE_SESSION operations per second|Ops/Sec
NFS4_CREATE_SESSION_LATENCY|Average latency of NFS4_CREATE_SESSION operations|Microseconds
NFS4_CREATE_SESSION_OPS|Number of NFS4_CREATE_SESSION operations per second|Ops/Sec
NFS4_DELEGPURGE_ID_LATENCY|Average latency of NFS4_DELEGPURGE  operations|Microseconds
NFS4_DELEGPURGE_ID_OPS|Number of NFS4_DELEGPURGE operations per second|Ops/Sec
NFS4_DELEGPURGE_LATENCY|Average latency of NFS4_DELEGPURGE operations|Microseconds
NFS4_DELEGPURGE_OPS|Number of NFS4_DELEGPURGE operations per second|Ops/Sec
NFS4_DELEGRETURN_ID_LATENCY|Average latency of NFS4_DELEGRETURN  operations|Microseconds
NFS4_DELEGRETURN_ID_OPS|Number of NFS4_DELEGRETURN operations per second|Ops/Sec
NFS4_DELEGRETURN_LATENCY|Average latency of NFS4_DELEGRETURN operations|Microseconds
NFS4_DELEGRETURN_OPS|Number of NFS4_DELEGRETURN operations per second|Ops/Sec
NFS4_DESTROY_CLIENTID_ID_LATENCY|Average latency of NFS4_DESTROY_CLIENTID  operations|Microseconds
NFS4_DESTROY_CLIENTID_ID_OPS|Number of NFS4_DESTROY_CLIENTID operations per second|Ops/Sec
NFS4_DESTROY_CLIENTID_LATENCY|Average latency of NFS4_DESTROY_CLIENTID operations|Microseconds
NFS4_DESTROY_CLIENTID_OPS|Number of NFS4_DESTROY_CLIENTID operations per second|Ops/Sec
NFS4_DESTROY_SESSION_ID_LATENCY|Average latency of NFS4_DESTROY_SESSION  operations|Microseconds
NFS4_DESTROY_SESSION_ID_OPS|Number of NFS4_DESTROY_SESSION operations per second|Ops/Sec
NFS4_DESTROY_SESSION_LATENCY|Average latency of NFS4_DESTROY_SESSION operations|Microseconds
NFS4_DESTROY_SESSION_OPS|Number of NFS4_DESTROY_SESSION operations per second|Ops/Sec
NFS4_EXCHANGE_ID_LATENCY|Average latency of NFS4_EXCHANGE_ID operations|Microseconds
NFS4_EXCHANGE_ID_OPS|Number of NFS4_EXCHANGE_ID operations per second|Ops/Sec
NFS4_EXCHANGEID_ID_LATENCY|Average latency of NFS4_EXCHANGEID  operations|Microseconds
NFS4_EXCHANGEID_ID_OPS|Number of NFS4_EXCHANGEID operations per second|Ops/Sec
NFS4_FREE_STATEID_ID_LATENCY|Average latency of NFS4_FREE_STATEID  operations|Microseconds
NFS4_FREE_STATEID_ID_OPS|Number of NFS4_FREE_STATEID operations per second|Ops/Sec
NFS4_FREE_STATEID_LATENCY|Average latency of NFS4_FREE_STATEID operations|Microseconds
NFS4_FREE_STATEID_OPS|Number of NFS4_FREE_STATEID operations per second|Ops/Sec
NFS4_GET_DIR_DELEGATION_ID_LATENCY|Average latency of NFS4_GET_DIR_DELEGATION  operations|Microseconds
NFS4_GET_DIR_DELEGATION_ID_OPS|Number of NFS4_GET_DIR_DELEGATION operations per second|Ops/Sec
NFS4_GET_DIR_DELEGATION_LATENCY|Average latency of NFS4_GET_DIR_DELEGATION operations|Microseconds
NFS4_GET_DIR_DELEGATION_OPS|Number of NFS4_GET_DIR_DELEGATION operations per second|Ops/Sec
NFS4_GETATTR_ID_LATENCY|Average latency of NFS4_GETATTR  operations|Microseconds
NFS4_GETATTR_ID_OPS|Number of NFS4_GETATTR operations per second|Ops/Sec
NFS4_GETDEVICEINFO_ID_LATENCY|Average latency of NFS4_GETDEVICEINFO  operations|Microseconds
NFS4_GETDEVICEINFO_ID_OPS|Number of NFS4_GETDEVICEINFO operations per second|Ops/Sec
NFS4_GETDEVICEINFO_LATENCY|Average latency of NFS4_GETDEVICEINFO operations|Microseconds
NFS4_GETDEVICEINFO_OPS|Number of NFS4_GETDEVICEINFO operations per second|Ops/Sec
NFS4_GETDEVICELIST_ID_LATENCY|Average latency of NFS4_GETDEVICELIST  operations|Microseconds
NFS4_GETDEVICELIST_ID_OPS|Number of NFS4_GETDEVICELIST operations per second|Ops/Sec
NFS4_GETDEVICELIST_LATENCY|Average latency of NFS4_GETDEVICELIST operations|Microseconds
NFS4_GETDEVICELIST_OPS|Number of NFS4_GETDEVICELIST operations per second|Ops/Sec
NFS4_GETFH_ID_LATENCY|Average latency of NFS4_GETFH  operations|Microseconds
NFS4_GETFH_ID_OPS|Number of NFS4_GETFH operations per second|Ops/Sec
NFS4_GETFH_LATENCY|Average latency of NFS4_GETFH operations|Microseconds
NFS4_GETFH_OPS|Number of NFS4_GETFH operations per second|Ops/Sec
NFS4_LAYOUTCOMMIT_ID_LATENCY|Average latency of NFS4_LAYOUTCOMMIT  operations|Microseconds
NFS4_LAYOUTCOMMIT_ID_OPS|Number of NFS4_LAYOUTCOMMIT operations per second|Ops/Sec
NFS4_LAYOUTCOMMIT_LATENCY|Average latency of NFS4_LAYOUTCOMMIT operations|Microseconds
NFS4_LAYOUTCOMMIT_OPS|Number of NFS4_LAYOUTCOMMIT operations per second|Ops/Sec
NFS4_LAYOUTGET_ID_LATENCY|Average latency of NFS4_LAYOUTGET  operations|Microseconds
NFS4_LAYOUTGET_ID_OPS|Number of NFS4_LAYOUTGET operations per second|Ops/Sec
NFS4_LAYOUTGET_LATENCY|Average latency of NFS4_LAYOUTGET operations|Microseconds
NFS4_LAYOUTGET_OPS|Number of NFS4_LAYOUTGET operations per second|Ops/Sec
NFS4_LAYOUTRETURN_ID_LATENCY|Average latency of NFS4_LAYOUTRETURN  operations|Microseconds
NFS4_LAYOUTRETURN_ID_OPS|Number of NFS4_LAYOUTRETURN operations per second|Ops/Sec
NFS4_LAYOUTRETURN_LATENCY|Average latency of NFS4_LAYOUTRETURN operations|Microseconds
NFS4_LAYOUTRETURN_OPS|Number of NFS4_LAYOUTRETURN operations per second|Ops/Sec
NFS4_LINK_ID_LATENCY|Average latency of NFS4_LINK  operations|Microseconds
NFS4_LINK_ID_OPS|Number of NFS4_LINK operations per second|Ops/Sec
NFS4_LOCK_ID_LATENCY|Average latency of NFS4_LOCK  operations|Microseconds
NFS4_LOCK_ID_OPS|Number of NFS4_LOCK operations per second|Ops/Sec
NFS4_LOCK_LATENCY|Average latency of NFS4_LOCK operations|Microseconds
NFS4_LOCK_OPS|Number of NFS4_LOCK operations per second|Ops/Sec
NFS4_LOCKT_ID_LATENCY|Average latency of NFS4_LOCKT  operations|Microseconds
NFS4_LOCKT_ID_OPS|Number of NFS4_LOCKT operations per second|Ops/Sec
NFS4_LOCKT_LATENCY|Average latency of NFS4_LOCKT operations|Microseconds
NFS4_LOCKT_OPS|Number of NFS4_LOCKT operations per second|Ops/Sec
NFS4_LOCKU_ID_LATENCY|Average latency of NFS4_LOCKU  operations|Microseconds
NFS4_LOCKU_ID_OPS|Number of NFS4_LOCKU operations per second|Ops/Sec
NFS4_LOCKU_LATENCY|Average latency of NFS4_LOCKU operations|Microseconds
NFS4_LOCKU_OPS|Number of NFS4_LOCKU operations per second|Ops/Sec
NFS4_LOOKUP_ID_LATENCY|Average latency of NFS4_LOOKUP  operations|Microseconds
NFS4_LOOKUP_ID_OPS|Number of NFS4_LOOKUP operations per second|Ops/Sec
NFS4_LOOKUPP_ID_LATENCY|Average latency of NFS4_LOOKUPP  operations|Microseconds
NFS4_LOOKUPP_ID_OPS|Number of NFS4_LOOKUPP operations per second|Ops/Sec
NFS4_LOOKUPP_LATENCY|Average latency of NFS4_LOOKUPP operations|Microseconds
NFS4_LOOKUPP_OPS|Number of NFS4_LOOKUPP operations per second|Ops/Sec
NFS4_NVERIFY_ID_LATENCY|Average latency of NFS4_NVERIFY  operations|Microseconds
NFS4_NVERIFY_ID_OPS|Number of NFS4_NVERIFY operations per second|Ops/Sec
NFS4_NVERIFY_LATENCY|Average latency of NFS4_NVERIFY operations|Microseconds
NFS4_NVERIFY_OPS|Number of NFS4_NVERIFY operations per second|Ops/Sec
NFS4_OPEN_CONFIRM_ID_LATENCY|Average latency of NFS4_OPEN_CONFIRM  operations|Microseconds
NFS4_OPEN_CONFIRM_ID_OPS|Number of NFS4_OPEN_CONFIRM operations per second|Ops/Sec
NFS4_OPEN_CONFIRM_LATENCY|Average latency of NFS4_OPEN_CONFIRM operations|Microseconds
NFS4_OPEN_CONFIRM_OPS|Number of NFS4_OPEN_CONFIRM operations per second|Ops/Sec
NFS4_OPEN_DOWNGRADE_ID_LATENCY|Average latency of NFS4_OPEN_DOWNGRADE  operations|Microseconds
NFS4_OPEN_DOWNGRADE_ID_OPS|Number of NFS4_OPEN_DOWNGRADE operations per second|Ops/Sec
NFS4_OPEN_DOWNGRADE_LATENCY|Average latency of NFS4_OPEN_DOWNGRADE operations|Microseconds
NFS4_OPEN_DOWNGRADE_OPS|Number of NFS4_OPEN_DOWNGRADE operations per second|Ops/Sec
NFS4_OPEN_ID_LATENCY|Average latency of NFS4_OPEN  operations|Microseconds
NFS4_OPEN_ID_OPS|Number of NFS4_OPEN operations per second|Ops/Sec
NFS4_OPEN_LATENCY|Average latency of NFS4_OPEN operations|Microseconds
NFS4_OPEN_OPS|Number of NFS4_OPEN operations per second|Ops/Sec
NFS4_OPENATTR_ID_LATENCY|Average latency of NFS4_OPENATTR  operations|Microseconds
NFS4_OPENATTR_ID_OPS|Number of NFS4_OPENATTR operations per second|Ops/Sec
NFS4_OPENATTR_LATENCY|Average latency of NFS4_OPENATTR operations|Microseconds
NFS4_OPENATTR_OPS|Number of NFS4_OPENATTR operations per second|Ops/Sec
NFS4_OPS_ID|Number of NFS4_OPS per second|Ops/Sec
NFS4_PUTFH_ID_LATENCY|Average latency of NFS4_PUTFH  operations|Microseconds
NFS4_PUTFH_ID_OPS|Number of NFS4_PUTFH operations per second|Ops/Sec
NFS4_PUTFH_LATENCY|Average latency of NFS4_PUTFH operations|Microseconds
NFS4_PUTFH_OPS|Number of NFS4_PUTFH operations per second|Ops/Sec
NFS4_PUTPUBFH_ID_LATENCY|Average latency of NFS4_PUTPUBFH  operations|Microseconds
NFS4_PUTPUBFH_ID_OPS|Number of NFS4_PUTPUBFH operations per second|Ops/Sec
NFS4_PUTPUBFH_LATENCY|Average latency of NFS4_PUTPUBFH operations|Microseconds
NFS4_PUTPUBFH_OPS|Number of NFS4_PUTPUBFH operations per second|Ops/Sec
NFS4_PUTROOTFH_ID_LATENCY|Average latency of NFS4_PUTROOTFH  operations|Microseconds
NFS4_PUTROOTFH_ID_OPS|Number of NFS4_PUTROOTFH operations per second|Ops/Sec
NFS4_PUTROOTFH_LATENCY|Average latency of NFS4_PUTROOTFH operations|Microseconds
NFS4_PUTROOTFH_OPS|Number of NFS4_PUTROOTFH operations per second|Ops/Sec
NFS4_READ_BYTES_ID|Number of NFS4_READ_BYTES per second|Bytes/Sec
NFS4_READ_ID_LATENCY|Average latency of NFS4_READ  operations|Microseconds
NFS4_READ_ID_OPS|Number of NFS4_READ operations per second|Ops/Sec
NFS4_READDIR_ID_LATENCY|Average latency of NFS4_READDIR  operations|Microseconds
NFS4_READDIR_ID_OPS|Number of NFS4_READDIR operations per second|Ops/Sec
NFS4_READLINK_ID_LATENCY|Average latency of NFS4_READLINK  operations|Microseconds
NFS4_READLINK_ID_OPS|Number of NFS4_READLINK operations per second|Ops/Sec
NFS4_RECLAIM_COMPLETE_ID_LATENCY|Average latency of NFS4_RECLAIM_COMPLETE  operations|Microseconds
NFS4_RECLAIM_COMPLETE_ID_OPS|Number of NFS4_RECLAIM_COMPLETE operations per second|Ops/Sec
NFS4_RECLAIM_COMPLETE_LATENCY|Average latency of NFS4_RECLAIM_COMPLETE operations|Microseconds
NFS4_RECLAIM_COMPLETE_OPS|Number of NFS4_RECLAIM_COMPLETE operations per second|Ops/Sec
NFS4_RELEASE_LOCKOWNER_ID_LATENCY|Average latency of NFS4_RELEASE_LOCKOWNER  operations|Microseconds
NFS4_RELEASE_LOCKOWNER_ID_OPS|Number of NFS4_RELEASE_LOCKOWNER operations per second|Ops/Sec
NFS4_RELEASE_LOCKOWNER_LATENCY|Average latency of NFS4_RELEASE_LOCKOWNER operations|Microseconds
NFS4_RELEASE_LOCKOWNER_OPS|Number of NFS4_RELEASE_LOCKOWNER operations per second|Ops/Sec
NFS4_REMOVE_ID_LATENCY|Average latency of NFS4_REMOVE  operations|Microseconds
NFS4_REMOVE_ID_OPS|Number of NFS4_REMOVE operations per second|Ops/Sec
NFS4_RENAME_ID_LATENCY|Average latency of NFS4_RENAME  operations|Microseconds
NFS4_RENAME_ID_OPS|Number of NFS4_RENAME operations per second|Ops/Sec
NFS4_RENEW_ID_LATENCY|Average latency of NFS4_RENEW  operations|Microseconds
NFS4_RENEW_ID_OPS|Number of NFS4_RENEW operations per second|Ops/Sec
NFS4_RENEW_LATENCY|Average latency of NFS4_RENEW operations|Microseconds
NFS4_RENEW_OPS|Number of NFS4_RENEW operations per second|Ops/Sec
NFS4_RESTOREFH_ID_LATENCY|Average latency of NFS4_RESTOREFH  operations|Microseconds
NFS4_RESTOREFH_ID_OPS|Number of NFS4_RESTOREFH operations per second|Ops/Sec
NFS4_RESTOREFH_LATENCY|Average latency of NFS4_RESTOREFH operations|Microseconds
NFS4_RESTOREFH_OPS|Number of NFS4_RESTOREFH operations per second|Ops/Sec
NFS4_SAVEFH_ID_LATENCY|Average latency of NFS4_SAVEFH  operations|Microseconds
NFS4_SAVEFH_ID_OPS|Number of NFS4_SAVEFH operations per second|Ops/Sec
NFS4_SAVEFH_LATENCY|Average latency of NFS4_SAVEFH operations|Microseconds
NFS4_SAVEFH_OPS|Number of NFS4_SAVEFH operations per second|Ops/Sec
NFS4_SECINFO_ID_LATENCY|Average latency of NFS4_SECINFO  operations|Microseconds
NFS4_SECINFO_ID_OPS|Number of NFS4_SECINFO operations per second|Ops/Sec
NFS4_SECINFO_LATENCY|Average latency of NFS4_SECINFO operations|Microseconds
NFS4_SECINFO_NO_NAME_ID_LATENCY|Average latency of NFS4_SECINFO_NO_NAME  operations|Microseconds
NFS4_SECINFO_NO_NAME_ID_OPS|Number of NFS4_SECINFO_NO_NAME operations per second|Ops/Sec
NFS4_SECINFO_NO_NAME_LATENCY|Average latency of NFS4_SECINFO_NO_NAME operations|Microseconds
NFS4_SECINFO_NO_NAME_OPS|Number of NFS4_SECINFO_NO_NAME operations per second|Ops/Sec
NFS4_SECINFO_OPS|Number of NFS4_SECINFO operations per second|Ops/Sec
NFS4_SEQUENCE_ID_LATENCY|Average latency of NFS4_SEQUENCE  operations|Microseconds
NFS4_SEQUENCE_ID_OPS|Number of NFS4_SEQUENCE operations per second|Ops/Sec
NFS4_SEQUENCE_LATENCY|Average latency of NFS4_SEQUENCE operations|Microseconds
NFS4_SEQUENCE_OPS|Number of NFS4_SEQUENCE operations per second|Ops/Sec
NFS4_SET_SSV_ID_LATENCY|Average latency of NFS4_SET_SSV  operations|Microseconds
NFS4_SET_SSV_ID_OPS|Number of NFS4_SET_SSV operations per second|Ops/Sec
NFS4_SET_SSV_LATENCY|Average latency of NFS4_SET_SSV operations|Microseconds
NFS4_SET_SSV_OPS|Number of NFS4_SET_SSV operations per second|Ops/Sec
NFS4_SETATTR_ID_LATENCY|Average latency of NFS4_SETATTR  operations|Microseconds
NFS4_SETATTR_ID_OPS|Number of NFS4_SETATTR operations per second|Ops/Sec
NFS4_SETCLIENTID_CONFIRM_ID_LATENCY|Average latency of NFS4_SETCLIENTID_CONFIRM  operations|Microseconds
NFS4_SETCLIENTID_CONFIRM_ID_OPS|Number of NFS4_SETCLIENTID_CONFIRM operations per second|Ops/Sec
NFS4_SETCLIENTID_CONFIRM_LATENCY|Average latency of NFS4_SETCLIENTID_CONFIRM operations|Microseconds
NFS4_SETCLIENTID_CONFIRM_OPS|Number of NFS4_SETCLIENTID_CONFIRM operations per second|Ops/Sec
NFS4_SETCLIENTID_ID_LATENCY|Average latency of NFS4_SETCLIENTID  operations|Microseconds
NFS4_SETCLIENTID_ID_OPS|Number of NFS4_SETCLIENTID operations per second|Ops/Sec
NFS4_SETCLIENTID_LATENCY|Average latency of NFS4_SETCLIENTID operations|Microseconds
NFS4_SETCLIENTID_OPS|Number of NFS4_SETCLIENTID operations per second|Ops/Sec
NFS4_TEST_STATEID_ID_LATENCY|Average latency of NFS4_TEST_STATEID  operations|Microseconds
NFS4_TEST_STATEID_ID_OPS|Number of NFS4_TEST_STATEID operations per second|Ops/Sec
NFS4_TEST_STATEID_LATENCY|Average latency of NFS4_TEST_STATEID operations|Microseconds
NFS4_TEST_STATEID_OPS|Number of NFS4_TEST_STATEID operations per second|Ops/Sec
NFS4_VERIFY_ID_LATENCY|Average latency of NFS4_VERIFY  operations|Microseconds
NFS4_VERIFY_ID_OPS|Number of NFS4_VERIFY operations per second|Ops/Sec
NFS4_VERIFY_LATENCY|Average latency of NFS4_VERIFY operations|Microseconds
NFS4_VERIFY_OPS|Number of NFS4_VERIFY operations per second|Ops/Sec
NFS4_WANT_DELEGATION_ID_LATENCY|Average latency of NFS4_WANT_DELEGATION  operations|Microseconds
NFS4_WANT_DELEGATION_ID_OPS|Number of NFS4_WANT_DELEGATION operations per second|Ops/Sec
NFS4_WANT_DELEGATION_LATENCY|Average latency of NFS4_WANT_DELEGATION operations|Microseconds
NFS4_WANT_DELEGATION_OPS|Number of NFS4_WANT_DELEGATION operations per second|Ops/Sec
NFS4_WRITE_BYTES_ID|Number of NFS4_WRITE_BYTES per second|Bytes/Sec
NFS4_WRITE_ID_LATENCY|Average latency of NFS4_WRITE  operations|Microseconds
NFS4_WRITE_ID_OPS|Number of NFS4_WRITE operations per second|Ops/Sec
OPS|Total number of operations|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_LATENCY|Average latency of READ operations|Microseconds
READ_OPS|Number of READ operations per second|Ops/Sec
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
REMOVE_LATENCY|Average latency of REMOVE operations|Microseconds
REMOVE_OPS|Number of REMOVE operations per second|Ops/Sec
RENAME_LATENCY|Average latency of RENAME operations|Microseconds
RENAME_OPS|Number of RENAME operations per second|Ops/Sec
SETATTR_LATENCY|Average latency of SETATTR operations|Microseconds
SETATTR_OPS|Number of SETATTR operations per second|Ops/Sec
THROUGHPUT|Number of bytes read/written per second|Bytes/Sec
WRITE_BYTES|Number of bytes written per second|Bytes/Sec
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITE_OPS|Number of WRITE operations per second|Ops/Sec

## Operations (S3)

**Type** | **Description** | **Units**
-|-|-
API_FAILURES|Total of failures per API|Ops
API_OPS|Total of Ops per API|Ops
API_TTFB|Time To First Byte per API|Milliseconds
API_TTLB|Time To Last Byte per API|Milliseconds
AVG_TTLB_HIST|TTLB (Time To Last Byte) Milliseconds Histogram|Count
AVG_TTLB_PERCENT|TTLB (Time To Last Byte) Percentile|Milliseconds
FS_READ_BYTES|Total Read Bytes per FS|Bytes/Sec
FS_RQ|Total Requests per FS|Ops
FS_STATUS|Count HTTP Status Code per FS|Ops
FS_WRITE_BYTES|Total Write Bytes per FS|Bytes/Sec
TOTAL_BUCKET_CREATE_OPS|Total bucket create operations per second|Ops/Sec
TOTAL_BUCKET_DELETE_OPS|Total bucket delete operations per second|Ops/Sec
TOTAL_BUCKET_LIST_OPS|Total bucket list operations per second|Ops/Sec

## Operations (SLB of S3)

**Type** | **Description** | **Units**
-|-|-
AVG_1xx_RQ|Average 1xx replies per second|Ops/Sec
AVG_2xx_RQ|Average 2xx replies per second|Ops/Sec
AVG_3xx_RQ|Average 3xx replies per second|Ops/Sec
AVG_429_RQ|Average 429 replies per second|Ops/Sec
AVG_4xx_RQ|Average 4xx replies per second|Ops/Sec
AVG_503_RQ|Average 503 replies per second|Ops/Sec
AVG_5xx_RQ|Average 5xx replies per second|Ops/Sec
SLB_1xx_RQ|1xx responses to traffic originating from adjacent SLBs|Ops
SLB_2xx_RQ|2xx responses to traffic originating from adjacent SLBs|Ops
SLB_3xx_RQ|3xx responses to traffic originating from adjacent SLBs|Ops
SLB_4xx_RQ|4xx responses to traffic originating from adjacent SLBs|Ops
SLB_5xx_RQ|5xx responses to traffic originating from adjacent SLBs|Ops
TOTAL_1xx_RQ|Total 1xx replies|Ops
TOTAL_2xx_RQ|Total 2xx replies|Ops
TOTAL_3xx_RQ|Total 3xx replies|Ops
TOTAL_429_RQ|Total 429 replies|Ops
TOTAL_4xx_RQ|Total 4xx replies|Ops
TOTAL_503_RQ|Total 503 replies|Ops
TOTAL_5xx_RQ|Total 5xx replies|Ops
TOTAL_active_connection|Total SLB Downstream Active Connections|Connections
TOTAL_max_duration_RQ|Total Max Duration Reached replies|Ops
TOTAL_rejected_via_ip_detection_RQ|Total Rejected by IP Detection replies|Ops
TOTAL_response_before_complete_RQ|Total S3 Responses before Complete replies|Ops
TOTAL_rx_reset_RQ|Total User RX Reset Connection replies|Ops
TOTAL_tx_reset_RQ|Total Envoy TX Reset Connection replies|Ops

## Platform

**Type** | **Description** | **Units**
-|-|-
REPORTED_MMAP_ALLOC_MEM|Memory allocated through reportedMmaps, in bytes.|Bytes
REPORTED_MMAP_ALLOCS|Number of reported mmap allocations|Allocations
REPORTED_MMAP_DEALLOCS|Number of reported mmap deallocations|Deallocations
REPORTED_MMAP_RESERVED_MEM|Memory reserved for reportedMmaps, in bytes.|Bytes

## Processes

**Type** | **Description** | **Units**
-|-|-
ABRUPT_EXITS|Tracks the number of times a process exits unexpectedly|Abrupt process exits
PEER_CONFIGURE_FAILURES|Tracks the number of times a process fails to configure a peer for synchronization|Peer configure failures

## RAFT

**Type** | **Description** | **Units**
-|-|-
Bucket_LEADER_CHANGES|Changes of leader|Changes
Bucket_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests
Configuration_LEADER_CHANGES|Changes of leader|Changes
Configuration_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests
Invalid_LEADER_CHANGES|Changes of leader|Changes
Invalid_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests
RAFT_BYTES_WRITTEN|Number of writes written to disk for RAFT|Bytes
SYNCLOG_TIMEOUTS|The number of timeouts of syncing logs to a process|Timeouts
Test_LEADER_CHANGES|Changes of leader|Changes
Test_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests

## RAID

**Type** | **Description** | **Units**
-|-|-
IS_BLOCK_USED_FREE_LATENCY|Average latency of handling an isBlockUsed of a free block|Micros
IS_BLOCK_USED_FREE|Number of isBlockUsed returning free|Blocks/Sec
IS_BLOCK_USED_USED_LATENCY|Average latency of handling an isBlockUsed of a used block|Micros
IS_BLOCK_USED_USED|Number of isBlockUsed returning used|Blocks/Sec
NVKV_RECOVERY_NETBUF_REREAD_UNEQUAL|Number of unequal netbufs encountered that caused NVKV recovery to restart|Blocks/Sec
RAID_ALLOCATION_FAILED_HOLES|Slots failed to be allocated and were left as holes|Holes/Sec
RAID_BLOCKS_IN_PREPARED_STRIPE|Free blocks in prepared stripe|Blocks
RAID_CHUNKS_CLEANED_BY_SHIFT|Dirty chunks cleaned by being shifted out|Occurrences
RAID_CHUNKS_SHIFTED|Dirty chunks that shifted out|Occurrences
RAID_COMMITTED_STRIPES|Number of stripes written|Stripes
RAID_COMPRESSED_BLOCKS_WRITTEN|Physical blocks are written containing compressed data|Blocks/Sec
RAID_COMPRESSED_PADDING|Zero-Blocks written to compressed space for alignment|Blocks/Sec
RAID_CORRUPTION_RECOVERY_FAILURE|Corrupt data could not be recovered|Occurrences
RAID_DRIVE_FAILURE|Drive failures viewed from compute or front-end nodes|Occurrences/Sec
RAID_PLACEMENT_ALLOC_PlacementSpace0|Number of placement allocations|Occurrences/Sec
RAID_PLACEMENT_ALLOC_PlacementSpaceN_Compressed|Number of placement allocations|Occurrences/Sec
RAID_PLACEMENT_ALLOC_PlacementSpaceN_Uncompressed|Number of placement allocations|Occurrences/Sec
RAID_PLACEMENT_RETIRE_PlacementSpace0|Number of placement retirements|Occurrences/Sec
RAID_PLACEMENT_RETIRE_PlacementSpaceN_Compressed|Number of placement retirements|Occurrences/Sec
RAID_PLACEMENT_RETIRE_PlacementSpaceN_Uncompressed|Number of placement retirements|Occurrences/Sec
RAID_PLACEMENT_SWITCHES|Number of placement switches|Switches
RAID_READ_BATCHES_PER_REQUEST_HISTOGRAM|Histogram of the number of batches of stripes read in a single request|Request
RAID_READ_BLOCKS_STRIPE_HISTOGRAM|Histogram of the number of blocks read from a single stripe|Reads
RAID_READ_BLOCKS|Number of blocks read by the RAID|Blocks/Sec
RAID_READ_DEGRADED|Degraded mode reads|Blocks/Sec
RAID_READ_FREE|Read Free|Occurences
RAID_READ_IOS|Raw read blocks performed by the RAID|Blocks/Sec
RAID_STALE_WRITES_DETECTED|Stale write detected in read|Occurrences
RAID_STALE_WRITES_REPROTECTIONS|Stale write reprotections in read|Occurrences
WRONG_DRIVE_DELTAS|Delta segments are written to the wrong drive|Blocks/Sec
WRONG_DRIVE_REFS|Reference segments are written to the wrong drive|Blocks/Sec

## Reactor

**Type** | **Description** | **Units**
-|-|-
AVG_QUEUE_TIME_FLEX_TASKS|Average queue time of deferred flex tasks|Cycles
BACKGROUND_CYCLES|Number of cycles spent in background fibers|Cycles/Sec
BACKGROUND_FIBERS|Number of background fibers that are ready to run and eager to get CPU cycles|Fibers
BACKGROUND_TIME|The percentage of the CPU time used for background operations|%
BucketInvocationState_CAPACITY|Number of data structures allocated to the BucketInvocationState pool|Structs
BucketInvocationState_STRUCT_SIZE|Number of bytes in each struct of the BucketInvocationState pool|Bytes
BucketInvocationState_USED|Number of structs in the BucketInvocationState pool that are currently being used|Structs
CPU_HANGS_AND_KNOWN_HOGGER|Number of CPU hangs detected while known hogger|Hangs/Sec
CPU_HANGS|Number of CPU hangs detected|Hangs/Sec
CYCLES_PER_SECOND|Number of cycles the CPU runs per second|Cycles/Sec
DeferredTask2_CAPACITY|Number of data structures allocated to the DeferredTask2 pool|Structs
DeferredTask2_STRUCT_SIZE|Number of bytes in each struct of the DeferredTask2 pool|Bytes
DeferredTask2_USED|Number of structs in the DeferredTask2 pool that are currently being used|Structs
DEFUNCT_FIBERS|Number of defunct buffers, which are just memory structures allocated for future fiber needs|Fibers
EXCEPTIONS|Number of exceptions caught by the reactor|Exceptions/Sec
FLEX_TASKS_INLINE_FULLQUEUE|Number of flex tasks run inline on main thread due to full defer queue|Invocations/Sec
FLEX_TASKS_INLINE_LIGHTLOAD|Number of flex tasks run inline on main thread due to light load|Invocations/Sec
FLEX_TASKS_INLINE_OVERRIDE|Number of flex tasks run inline on main thread due to override|Invocations/Sec
FLEX_TASKS_LATENCY|Histogram of flex tasks latency|usecs
FLEX_TASKS_QUEUED_RUN_MAINTHREAD|Number of deferred flex tasks run by main thread|Invocations/Sec
FLEX_TASKS_QUEUED_RUN_THREADPOOL|Number of deferred flex tasks run on thread pool|Invocations/Sec
FLEX_TASKS_QUEUED|Number of deferred flex tasks queued|Invocations/Sec
FLEX_TASKS_SUBMITTED|Number of flex tasks submitted|Invocations/Sec
IDLE_CALLBACK_INVOCATIONS|Number of background work invocations|Invocations/Sec
IDLE_CYCLES|Number of cycles spent in idle|Cycles/Sec
IDLE_TIME|The percentage of the CPU time not used for handling I/Os|%
LINGERING_FIBERS|Number of LINGERING fibers|Fibers
MAIN_THREAD_DEFERRED_FLEX_TASK_CYCLES|Number of cycles main thread spent running deferred flex tasks|Cycles/Sec
MAIN_THREAD_INLINE_FLEX_TASK_CYCLES|Number of cycles main thread spent running inline flex tasks|Cycles/Sec
MAIN_THREAD_INLINE_FLEX_TASKS_AVG_RUNTIME|Average runtime of inline flex tasks run by the main thread|Cycles
MAIN_THREAD_QUEUED_FLEX_TASKS_AVG_RUNTIME|Average runtime of deferred flex tasks run by the main thread|Cycles
networkBuffers_CAPACITY|Number of data structures allocated to the networkBuffers pool|Structs
networkBuffers_USED|Number of structs in the networkBuffers pool that are currently being used|Structs
NODE_CONTEXT_SWITCHES|Number of context switches.|Switches
NODE_HANG|The number of process (node) hangs per hang time range.|Number of hangs
NODE_POLL_TIME|Time of scheduler stats polling.|usecs
NODE_RUN_PERCENTAGE|Percentage of time process is running|percentage
NODE_RUN_TIME|Time process is running.|usecs
NODE_WAIT_PERCENTAGE|Percentage of time process is waiting on waitqueue|percentage
NODE_WAIT_TIME|The Time the process is waiting on the wait queue.|usecs
ObsBucketManagement_CAPACITY|Number of data structures allocated to the ObsBucketManagement pool|Structs
ObsBucketManagement_STRUCT_SIZE|Number of bytes in each struct of the ObsBucketManagement pool|Bytes
ObsBucketManagement_USED|Number of structs in the ObsBucketManagement pool that are currently being used|Structs
ObsGateway_CAPACITY|Number of data structures allocated to the ObsGateway pool|Structs
ObsGateway_STRUCT_SIZE|Number of bytes in each struct of the ObsGateway pool|Bytes
ObsGateway_USED|Number of structs in the ObsGateway pool that are currently being used|Structs
OUTRAGEOUS_HOGGERS|Number of hoggers taking an excessive amount of time to run|Invocations
PENDING_FIBERS|Number of fibers pending for external events, such as a network packet or SSD response. Upon such an external event, they change state to scheduled fibers|Fibers
QUEUE_TIME_FLEX_TASK_CYCLES|Queue time of deferred flex tasks|Cycles/Sec
rdmaNetworkBuffers_CAPACITY|Number of data structures allocated to the rdmaNetworkBuffers pool|Structs
rdmaNetworkBuffers_USED|Number of structs in the rdmaNetworkBuffers pool that are currently being used|Structs
RELENTLESS_CYCLES|Number of cycles spent in relentless fibers|Cycles/Sec
RELENTLESS_FIBERS|Number of relentless fibers that are ready to run and eager to get CPU cycles|Fibers
SCHEDULED_FIBERS|Number of current fibers that are ready to run and eager to get CPU cycles|Fibers
SLEEPY_FIBERS|Number of SLEEPY fibers|Fibers
SLEEPY_RPC_SERVER_FIBERS|Number of SLEEPY RPC server fibers|Sleepy fiber detections
SSD_CAPACITY|Number of data structures allocated to the SSD pool|Structs
SSD_STRUCT_SIZE|Number of bytes in each struct of the SSD pool|Bytes
SSD_USED|Number of structs in the SSD pool that are currently being used|Structs
STEP_CYCLES|Histogram of time spent in a fiber|Fiber steps
THREAD_POOL_DEFERRED_TASK_CYCLES|Number of cycles the thread pool spent running deferred tasks|Cycles/Sec
THREAD_POOL_FLEX_TASK_CYCLES|Number of cycles the thread pool spent running flex tasks|Cycles/Sec
THREAD_POOL_QUEUED_FLEX_TASKS_AVG_RUNTIME|Average runtime of deferred flex tasks run on thread pool|Cycles
THREAD_POOL_TASK_INVOCATIONS|Number of tasks run by thread pool|Invocations/Sec
TimedCallback_CAPACITY|Number of data structures allocated to the TimedCallback pool|Structs
TimedCallback_STRUCT_SIZE|Number of bytes in each struct of the TimedCallback pool|Bytes
TimedCallback_USED|Number of structs in the TimedCallback pool that are currently being used|Structs
TIMER_CALLBACKS|Current number of timer callbacks|Callbacks
TOTAL_FIBERS_COUNT|Number of fibers|Fibers
UploadFileInfo_CAPACITY|Number of data structures allocated to the UploadFileInfo pool|Structs
UploadFileInfo_STRUCT_SIZE|Number of bytes in each struct of the UploadFileInfo pool|Bytes
UploadFileInfo_USED|Number of structs in the UploadFileInfo pool that are currently being used|Structs

## Resolve Inode Cache

**Type** | **Description** | **Units**
-|-|-
RESOLVER_INODE_TO_PATH_CACHE_HITS|resolveInodeToPath cache hits|Queries
RESOLVER_INODE_TO_PATH_CACHE_MISS|resolveInodeToPath cache miss|Queries

## RPC

**Type** | **Description** | **Units**
-|-|-
CLIENT_CANCELED_REQUESTS|Number of requests canceled by the client|Calls/Sec
CLIENT_DROPPED_RESPONSES|Number of responses dropped by the client|Calls/Sec
CLIENT_ENCRYPTION_AUTH_FAILURES|Number of authentication failures by the client|Calls/Sec
CLIENT_MISSING_ENCRYPTION_KEY|Number of times the client was missing an encryption key|Calls/Sec
CLIENT_RECEIVED_EXCEPTIONS|Number of exceptions received by the client|Calls/Sec
CLIENT_RECEIVED_RESPONSES|Number of responses received by the client|Calls/Sec
CLIENT_RECEIVED_TIMEOUTS|Number of timeouts experienced by the client|Calls/Sec
CLIENT_ROUNDTRIP_AVG_LOW| Round-trip average of client low-priority RPC calls|Microseconds
CLIENT_ROUNDTRIP_AVG_NORM| Round-trip average of client normal priority RPC calls|Microseconds
CLIENT_ROUNDTRIP_AVG| Round-trip average of client normal and low priority RPC calls|Microseconds
CLIENT_RPC_CALLS_DOWNGRADED|Number of client-downgraded RPC calls|RPC/Sec
CLIENT_RPC_CALLS_LOW|Number of low-priority RPC calls|RPC/Sec
CLIENT_RPC_CALLS_NORM|Number of normal priority RPC calls|RPC/Sec
CLIENT_RPC_CALLS|Number of all priorities of RPC calls|RPC/Sec
CLIENT_SENT_REQUESTS|Number of requests sent by the client|Calls/Sec
DEUS_EX_MBUF_LIMITED|Number of RPCs slow down due to low MBuf reserves|Ops/Sec
DEUS_EX_NO_FIBERS|Number of RPCs put in DeusEx due to lack of global fibers|Ops/Sec
DEUS_EX_NOT_EMPTY|Number of RPCs put in DeusEx to preserve RPC order|Ops/Sec
DEUS_EX_RPC_MAX_FIBERS|Number of RPCs put in DeusEx due to RPC max fibers|Ops/Sec
FIRST_RESULTS|Number of first results per second|Ops/Sec
MBUF_LIMITED_SLEEP|Number of times wait due to low MBuf reserves|Actions/Sec
RPC_ENCRYPTION_SETUP_FAILURES|Number of encryption key setup failures|Failures
SERVER_ABORTS|Number of server received aborts|Calls/Sec
SERVER_DROPPED_REQUESTS|Number of requests dropped by the server|Calls/Sec
SERVER_ENCRYPTION_AUTH_FAILURES|Number of encryption authentication failures at the server|Calls/Sec
SERVER_MISSING_ENCRYPTION_KEY|Number of requests missing encryption key at the server|Calls/Sec
SERVER_PROCESSING_AVG|Average time to process server RPC calls|Microseconds
SERVER_PROCESSING_TIME|Histogram of the time it took the server to process a request|RPCs
SERVER_REJECTS|Number of times the server rejected a request|Calls/Sec
SERVER_RPC_CALLS_UPGRADED|Number of server-upgraded RPC calls|RPC/Sec
SERVER_RPC_CALLS|Number of server RPC calls|RPC/Sec
SERVER_SENT_EXCEPTIONS|Number of exceptions sent by the server as a response|Calls/Sec
SERVER_SENT_RESPONSES|Number of responses the server sent|Calls/Sec
SERVER_UNENCRYPTED_REFUSALS|Number of requests refused due to missing encryption at the server|Calls/Sec
TIME_TO_FIRST_RESULT|Average latency to the first result of a MultiCall|Microseconds

## Scrubber

**Type** | **Description** | **Units**
-|-|-
BLOCK_CONSISTENCY_CHECK_LATENCY|Average latency of checking block consistency|Micros
BLOCK_CONSISTENCY_CHECKS|Number of blocks that were checked for consistency against their block-used-state|Blocks/Sec
CLEANED_CHUNKS|Number of chunks that were cleaned by the scrubber|Chunks/Sec
DEGRADED_READS|Number of degraded reads for scrubbing|Requests/Sec
FALSE_USED_CHECK_LATENCY|Average latency of checking false used per block|Micros
FALSE_USED_EXTRA_NOTIFIED|Number of blocks that were notified as used by the mark-extra-used mechanism|Blocks/Sec
INTERRUPTS|Number of scrubs that were interrupted|Occurrences/Sec
NETWORK_BUDGET_WAIT_LATENCY|Average latency of waiting for our network budget|Micros
NOT_REALLY_DIRTY_BLOCKS|Number of marked dirty blocks that ScrubMissingWrites found were clean|Blocks/Sec
NUM_COPY_DISCARDED_BLOCKS|Number of copied blocks that were discarded|Blocks/Sec
NUM_COPY_DISCARDS|Number of times we discarded scrubber copy work|Occurrences/Sec
NUM_INVENTED_STRIPES_DISCARD_BLOCKS|Number of blocks that were discarded due to invented stripes|Blocks/Sec
NUM_INVENTED_STRIPES_DISCARDS|Number of times we discarded all scrubber work due to invented stripes|Occurrences/Sec
NUM_SCRUBBER_DISCARD_INTERMEDIATES|Number of times we discarded all intermediate scrubber work|Occurrences/Sec
NUM_SMW_DISCARDED_BLOCKS|Number of SMW'd blocks that were discarded|Blocks/Sec
NUM_SMW_DISCARDS|Number of times we discarded scrubber SMW work|Occurrences/Sec
NUM_STRIPE_SKIPPED_NOT_FULLY_READ|Number of stripes skipped since stripe is not fully read|Occurrences
PLACEMENT_SELECTION_LATENCY|Average latency of scrubbed placement selection|Micros
RAID_PLACEMENT_SCANS_COMPLETED|Number of placement scan completions|Occurrences
READ_BATCH_SOURCE_BLOCKS|Number of source blocks read per batch|Batches
READ_BLOCKS_LATENCY|Average latency of read blocks|Micros
READS_CALLED|Number of blocks that were read|Blocks/Sec
RELOCATE_BLOCKS_LATENCY|Average latency of relocating blocks|Micros
RELOCATED_BLOCKS|Number of blocks that were relocated for eviction|Blocks/Sec
RETRUSTED_UNPROTECTED_DIRTY_BLOCKS|Number of dirty blocks that ScrubMissingWrites retrusted because they were unprotected|Blocks/Sec
REWRITTEN_DIRTY_BLOCKS|Number of dirty blocks that ScrubMissingWrites rewrote to clean them|Blocks/Sec
SCAN_LIKELY_LEAKED_BLOCKS|Number of free blocks encountered during a scan that was marked as KnownUsed in the RAID|Occurrences
SCRUB_BATCHES_LATENCY|Average latency of scrub batches|Millis
SCRUB_FALSE_USED_FAILED_READS|Number of blocks that we failed to read for scrub-false-used|Blocks/Sec
SCRUB_FALSE_USED_FAILED|Number of placements we failed to fully scrub-false-used|Occurrences/Sec
SCRUB_FALSE_USED_PLACEMENTS|Number of placements we finished scrub-false-used|Occurences/Sec
SCRUB_FALSE_USED_WAS_UNPROTECTED|Number of blocks that were falsely marked used and unprotected|Blocks/Sec
SCRUB_IN_FLIGHT_CORRUPTION_DETECTED|Number of in-flight corruptions detected when scrubbing|Occurrences
SCRUB_PREPARATION_FAILED|Number of times we failed to prepare() a task and aborted scrub of placement|Occurrences/Sec
SFU_CHECK_FREE|Number of blocks that were detected as false-used and freed|Blocks/Sec
SFU_CHECK_SECONDARY|Number of blocks that were detected as secondary|Blocks/Sec
SFU_CHECK_USED_CKSUM_ERR|Number of blocks that were detected as used with checksum error|Blocks/Sec
SFU_CHECK_USED|Number of blocks that were detected as used|Blocks/Sec
SFU_CHECKS|Number of blocks that were scrubbed-false-used|Blocks/Sec
SFU_FREE_STRIPE_LATENCY|Average latency of handling a read of a free stripe|Micros
SFU_FREE_STRIPES|Number of free stripes that were scrubbed-false-used|Stripes/Sec
SFU_USED_STRIPE_LATENCY|Average latency of handling a read of a used stripe|Micros
SFU_USED_STRIPES|Number of used stripes that were scrubbed-false-used|Stripes/Sec
SOURCE_READS|Number of source/committed superset blocks directly read by the scrubber|Blocks/Sec
STRIPE_DATA_IS_BLOCK_USED_LATENCY|Average latency of isBlockUsed during stripe verification|Micros
STRIPE_DATA_IS_BLOCK_USED|Number of isBlockUsed during stripe verification|Blocks/Sec
TARGET_COPIED_CHUNKS|Number of chunks that were copied to the target by the scrubber|Chunks/Sec
UPDATE_PLACEMENT_INFO_LATENCY|Average latency of updating the placement info quorum|Micros
UPDATE_PLACEMENT_INFO|Number of times we ran updatePlacementInfo|Occurrences/Sec
WONT_CLEAN_COPYING|Number of actually dirty blocks that ScrubMissingWrites refused to clean because they will be moved to target anyway|Blocks/Sec
WRITE_BATCH_SOURCE_BLOCKS|Number of source blocks to write in batch|Batches
WRITE_BATCH_TARGET_BLOCKS|Number of target blocks to write in batch|Batches
WRITE_BLOCKS_LATENCY|Average latency of writing blocks|Micros
WRITES_CALLED|Number of blocks that were written|Blocks/Sec

## Squelch

**Type** | **Description** | **Units**
-|-|-
BLOCKS_PER_DESQUELCH|Number of squelch blocks per desquelch|Desquelches
EXTENT_DESQUELCHES_NUM|Number of desquelches|Times
EXTENT_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
HASH_DESQUELCHES_NUM|Number of desquelches|Times
HASH_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
INODE_DESQUELCHES_NUM|Number of desquelches|Times
INODE_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
JOURNAL_DESQUELCHES_NUM|Number of desquelches|Times
JOURNAL_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
MAX_BLOCKS_WITH_TEMPORAL_SQUELCH_ITEMS_IN_BUCKET|Number of blocks with temporal squelch items in bucket|Blocks
MAX_TEMPORAL_SQUELCH_ITEMS_IN_BUCKET|Number of temporal squelch items in bucket|Squelch items
ODL_DESQUELCHES_NUM|Number of desquelches|Times
ODL_PAYLOAD_DESQUELCHES_NUM|Number of desquelches|Times
ODL_PAYLOAD_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
ODL_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
REGISTRY_L1_DESQUELCHES_NUM|Number of desquelches|Times
REGISTRY_L1_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
REGISTRY_L2_DESQUELCHES_NUM|Number of desquelches|Times
REGISTRY_L2_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
SPATIAL_DIGEST_DESQUELCHES_NUM|Number of desquelches|Times
SPATIAL_DIGEST_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
SPATIAL_SQUELCH_DESQUELCHES_NUM|Number of desquelches|Times
SPATIAL_SQUELCH_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
SUPERBLOCK_DESQUELCHES_NUM|Number of desquelches|Times
SUPERBLOCK_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
TEMPORAL_SQUELCH_DESQUELCHES_NUM|Number of desquelches|Times
TEMPORAL_SQUELCH_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks

## SSD

**Type** | **Description** | **Units**
-|-|-
CLEAN_CHUNK_SKIPPED|Number of clean chunks skipped |Chunks
DRIVE_ACTIVE_IOS|The number of in-flight IOs against the SSD during sampling|IOs
DRIVE_AER_RECEIVED|Number of AER reports|reports
DRIVE_CANCELLED_COMPLETED_BLOCKS|Drive cancelled completed blocks|Blocks/Sec
DRIVE_CANCELLED_NOT_SUBMITTED_BLOCKS|Drive cancelled not submitted blocks|Blocks/Sec
DRIVE_COMPLETED_OVER_COUNT|Drive completed count > 1 detected|Occurrences
DRIVE_E2E_CORRECTION_COUNT|Drive E2E correction count|Error Count
DRIVE_ENDURANCE_USED|Drive endurance percentage used|%
DRIVE_FORFEITS|Number of IOs forfeited due to lack of memory buffers|Operations/Sec
DRIVE_IDLE_CYCLES|Number of cycles spent in idle|Cycles/Sec
DRIVE_IDLE_TIME|Percentage of the CPU time not used for handling I/Os|%
DRIVE_IO_OVERLAPPED|Number of overlapping IOs|Operations
DRIVE_IO_TOO_LONG|Number of IOs that took longer than expected|Operations/Sec
DRIVE_LATENCY|Measure the latencies up to 5ms (higher latencies are grouped)|Requests
DRIVE_LOAD|Drive Load at sampling time|Load
DRIVE_MAX_ERASE_COUNT|Drive maximum block erase count|Erase Count
DRIVE_MEDIA_BLOCKS_READ|Blocks read from the SSD media|Blocks/Sec
DRIVE_MEDIA_BLOCKS_WRITE|Blocks are written to the SSD media|Blocks/Sec
DRIVE_MEDIA_ERRORS|SSD Media Errors|IO/Sec
DRIVE_MIN_ERASE_COUNT|Drive minimum block erase count|Erase Count
DRIVE_NON_MEDIA_ERRORS|SSD Non-Media Errors|IO/Sec
DRIVE_PCI_CORRECTABLE_ERROR_COUNT|Drive PCI Correctable error count|Error Count
DRIVE_PCI_INACCESSIBLE|Number of PCI Inaccessible errors detected|Count
DRIVE_PCI_LINK_RETRAIN_COUNT|Drive PCI link retrain count|Error Count
DRIVE_PENDING_IOS|The number of IOs waiting to start executing during sampling|IOs
DRIVE_PUMP_LATENCY|Latency between SSD pumps|Microseconds
DRIVE_PUMPED_IOS|Number of requests returned in a pump|Pumps
DRIVE_PUMPS_DELAYED|Number of Drive pumps that got delayed|Operations/Sec
DRIVE_PUMPS_SEVERELY_DELAYED|Number of Drive pumps that got severely delayed|Operations/Sec
DRIVE_READ_LATENCY|Drive Read Execution Latency|Microseconds
DRIVE_READ_OPS|Drive Read Operations|IO/Sec
DRIVE_READ_RATIO_PER_SSD_READ|Drive Read OPS Per SSD Request|Ratio
DRIVE_REMAINING_IOS|Number of requests still in the drive after a pump|Pumps
DRIVE_REMAINING_SPARES|Drive remaining spares|%
DRIVE_REQUEST_BLOCKS|Measure drive request size distribution|Requests
DRIVE_SOFT_ECC_COUNT|Drive Soft ECC Error Count|Error Count
DRIVE_SSD_PUMPS|Number of drive pumps that resulted in the data flow from/to drive|Pump/Sec
DRIVE_UNALIGNED_IOS|Drive unaligned IOs count|Error Count
DRIVE_UNCORRECTABLE_READ_COUNT|Drive uncorrectable read count|Error Count
DRIVE_UTILIZATION|Percentage of time the drive had an active IO submitted to it|%
DRIVE_WAF_INTERVAL|Drive Interval write amplification|Factor
DRIVE_WAF_LIFETIME|Drive lifetime write amplification|Factor
DRIVE_WRITE_LATENCY|Drive Write Execution Latency|Microseconds
DRIVE_WRITE_OPS|Drive Write Operations|IO/Sec
DRIVE_WRITE_RATIO_PER_SSD_WRITE|Drive Write OPS Per SSD Request|Ratio
DRIVE_XOR_RECOVERY_COUNT|Drive XOR recovery count|Error Count
LEAKED_AIOVEC_NETBUF|Number of leaked AIOVec netbufs on uncompleted IO|Operations
NVKV_CHUNK_OUT_OF_SPACE|Number of failed attempts to allocate a stripe in an NVKV chunk|Attempts/Sec
NVKV_INVALIDATOR_MATCHED|Number of NVKV invalidators matching the data|Attempts/Sec
NVKV_OUT_OF_CHUNKS|Number of failed attempts to allocate an NVKV chunk|Attempts/Sec
NVKV_OUT_OF_SUPERBLOCK_ENTRIES|Number of failed attempts to allocate a superblock NVKV entry|Attempts/Sec
NVME_NAMESPACE_CAPACITY|NVMe namespace capacity|Blocks
NVME_NAMESPACE_SIZE|The size of the NVMe namespace|Blocks
NVME_NAMESPACE_UTILIZATION|NVMe namespace utilization|Blocks
NVME_SMART_AVAILABLE_SPARE_THRESHOLD|Normalized percentage of the available spare falls below the threshold|%
NVME_SMART_AVAILABLE_SPARE|Normalized percentage when the available spare falls below the threshold|%
NVME_SMART_COMPOSITE_TEMP|Current composite temperature of the container in Kelvins|Kelvin
NVME_SMART_CONTROLLER_BUSY_TIME|The duration the controller is busy with I/O commands|Minutes
NVME_SMART_CRITICAL_COMPOSITE_TEMP_TIME|The time spent in critical composite temperature state|Minutes
NVME_SMART_CRITICAL_WARNING|Critical warnings regarding the drive controller state|BitFields
NVME_SMART_DATA_UNITS_READ|The number of 512-byte data units the server has read from the controller (in millions)|Count
NVME_SMART_DATA_UNITS_WRITTEN|The number of 512-byte data units the host has written to the controller (in millions)|Count
NVME_SMART_ERROR_LOG_ENTRIES|The total number of Error Information log entries over the controller's lifetime|Occurrences
NVME_SMART_HOST_READ_CMDS|The number of read commands completed by the controller|Occurrences
NVME_SMART_HOST_WRITE_CMDS|The number of write commands completed by the controller|Occurrences
NVME_SMART_MEDIA_ERRORS|The number of unrecovered data integrity errors detected by the controller|Occurrences
NVME_SMART_POWER_CYCLES|The number of power cycles|Occurrences
NVME_SMART_TEMP_SENSOR_1|The current temperature reported by temperature sensor 1|Kelvin
NVME_SMART_TEMP_SENSOR_2|The current temperature reported by temperature sensor 2|Kelvin
NVME_SMART_TEMP_SENSOR_3|The current temperature reported by temperature sensor 3|Kelvin
NVME_SMART_TEMP_SENSOR_4|The current temperature reported by temperature sensor 4|Kelvin
NVME_SMART_TEMP_SENSOR_5|The current temperature reported by temperature sensor 5|Kelvin
NVME_SMART_TEMP_SENSOR_6|The current temperature reported by temperature sensor 6|Kelvin
NVME_SMART_TEMP_SENSOR_7|The current temperature reported by temperature sensor 7|Kelvin
NVME_SMART_TEMP_SENSOR_8|The current temperature reported by temperature sensor 8|Kelvin
NVME_SMART_THERMAL_MGMT_TEMP1_TRANSITION_CNT|The number of times the controller entered lower active power states due to thermal management|Occurrences
NVME_SMART_THERMAL_MGMT_TEMP2_TRANSITION_CNT|The number of times the controller entered lower active power states due to thermal management|Occurrences
NVME_SMART_TOTAL_THERMAL_MGMT_TEMP1_TIME|The total time the controller spent in lower power states for thermal management temperature 1|Seconds
NVME_SMART_TOTAL_THERMAL_MGMT_TEMP2_TIME|The total time the controller spent in lower power states for thermal management temperature 2|Seconds
NVME_SMART_UNSAFE_SHUTDOWNS|The number of unsafe shutdown events|Occurrences
NVME_SMART_USED_PERCENTAGE|Vendor-specific estimate of the percentage of NVM subsystem life used|%
NVME_SMART_WARNING_COMPOSITE_TEMP_TIME|The time spent in warning composite temperature state|Minutes
SPDK_CUSE_CMDS_BLOCKED|Number of SPDK CUSE commands blocked|Count
SPDK_CUSE_CMDS_FAILED|Number of SPDK CUSE commands failed|Count
SPDK_CUSE_CMDS_INPROGRESS|Number of SPDK CUSE commands in progress |Count
SPDK_CUSE_CMDS_ISSUED|Number of SPDK CUSE commands issued|Count
SPDK_CUSE_CMDS_SUCCEEDED|Number of SPDK CUSE commands succeeded|Count
SSD_BLOCKS_READ|Number of blocks read from the SSD service|Blocks/Sec
SSD_BLOCKS_WRITTEN|Number of blocks written to the SSD service|Blocks/Sec
SSD_CHUNK_ALLOCS_TRIMMED|Number of chunk allocations from the trimmed queue|Chunks
SSD_CHUNK_ALLOCS_UNTRIMMED|Number of chunk allocations from the untrimmed queue|Chunks
SSD_CHUNK_ALLOCS|Number of chunk allocations|Chunks
SSD_CHUNK_FREE_TRIMMED|Number of free trimmed chunks|Chunks
SSD_CHUNK_FREE_UNTRIMMED|Number of free untrimmed chunks|Chunks
SSD_CHUNK_FREES|Number of chunk frees|Chunks
SSD_CHUNK_TRIMS|Number of trims performed|Chunks
SSD_CHUNKS_IN_USE|Number of allocated chunks|Chunks
SSD_E2E_BAD_CSUM|End-to-End checksum failures|IO/Sec
SSD_READ_ERRORS|Errors in reading blocks from the SSD service|Blocks/Sec
SSD_READ_LATENCY|Avg. latency of read requests from the SSD service|Microseconds
SSD_READ_REQS_LARGE_NORMAL|Number of large normal read requests from the SSD service|IO/Sec
SSD_READ_REQS|Number of read requests from the SSD service|IO/Sec
SSD_SCRATCH_BUFFERS_USED|Number of scratch blocks used|Blocks
SSD_TRIM_TIMEOUTS|Number of trim timeouts|Timeouts
SSD_UNALIGNED_WRITES|Number of unaligned writes|Ops
SSD_WRITE_ERRORS|Errors in writing blocks to the SSD service|Blocks/Sec
SSD_WRITE_LATENCY|Latency of writes to the SSD service|Microseconds
SSD_WRITES_REQS_LARGE_NORMAL|Number of large normal priority write requests to the SSD service|IO/Sec
SSD_WRITES|Number of write requests to the SSD service|IO/Sec
SSDS_IO_ERRORS|IO errors on the SSD service|Blocks/Sec
SSDS_IOS|IOs performed on the SSD service|IO/Sec

## Statistics

**Type** | **Description** | **Units**
-|-|-
AVAILABLE_HOST_MEMORY_MB|Amount of Free Memory|MB
GATHER_FROM_NODE_LATENCY_NET|Time spent on responding to a stats-gathering request (not including metadata)|Seconds/Sec
GATHER_FROM_NODE_LATENCY|Time spent responding to a stats-gathering request (not including metadata)|Seconds/Sec
GATHER_FROM_NODE_SLEEP|Time spent in-between responding to a stats-gathering request (not including metadata)|Seconds/Sec
TIMES_QUERIED_STATS|Number of times the process queried other processes for stats|Times
TIMES_QUERIED|Number of times the process was queried for stats (not including metadata)|Times

## Telemetry

**Type** | **Description** | **Units**
-|-|-
TOTAL_ADDED_FILES|Total number of files added|Files
TOTAL_BUFFER_RECEIVED_BYTES|Total number of bytes received by vector buffers|Bytes
TOTAL_BUFFER_RECEIVED_EVENTS|Total number of events received to vector buffers|Events
TOTAL_BUFFER_SENT_BYTES|Total number of bytes sent to vector buffers|Bytes
TOTAL_BUFFER_SENT_EVENTS|Total number of events sent to vector buffers|Events
TOTAL_COMPONENT_RECEIVED_BYTES|Total number of bytes received by vector components|Bytes
TOTAL_COMPONENT_RECEIVED_EVENTS|Total number of events received by vector components|Events
TOTAL_COMPONENT_SENT_BYTES|Total number of bytes sent to vector components|Bytes
TOTAL_COMPONENT_SENT_EVENTS|Total number of events sent to vector components|Events
TOTAL_DELETED_FILES|Total number of files deleted|Files
TOTAL_RESUMED_FILES|Total number of files resumed|Files
TOTAL_UNWATCHED_FILES|Total number of files unwatched|Files

## Unlink Log

**Type** | **Description** | **Units**
-|-|-
UNLINK_LOG_APPEND_DENIALS|Number of rejects for adding new entry due to ODH marked as non-clean |Denials
UNLINK_LOG_UNEXPECTED_ODH_INDEX_CHANGE|Number of unexpected ODH index changes|Occurrences

## WTracer Daemon Stats

**Type** | **Description** | **Units**
-|-|-
DAEMON_EXPORTED_BYTES|Number of exported bytes by the wtracer daemon|Bytes/Sec
DAEMON_FOUND_ENTRIES|Number of found entries by the wtracer daemon|Entries/Sec
DAEMON_IO_WRITE_FAILURES|Number of write I/O operations failed by the wtracer daemon|Errors
DAEMON_NUM_BULK_FLUSHES|Number of bulk flushes of entries in the wtracer daemon|Flushes/Sec
DAEMON_PROCESSED_BLOBS|Number of processed blobs by the wtracer daemon|Blobs/Sec
DAEMON_PROCESSED_ENTRIES|Number of processed entries by the wtracer daemon|Entries/Sec
DAEMON_PROCESSED_LOST_ENTRIES|Number of processed lost entries by the wtracer daemon|Entries/Sec
DAEMON_TIME_SPENT_ENHANCER|Time spent in the wtracer daemon enhancer|hnsecs

## WTracer Dumper Stats

**Type** | **Description** | **Units**
-|-|-
DUMPER_ACTIVE_AREAS|Number of areas dumpers currently have active|Areas
DUMPER_ACTIVE_HISTOGRAMS|Number of histogram dumpers currently active|Histograms
DUMPER_BYTES_OUT|Number of bytes the dumper outputs to files|Bytes/Sec
DUMPER_ENTRIES_OUT|Number of entries the dumper outputs to files|Entries/Sec
DUMPER_ERRORS|Total number of errors dumper triggered|Errors
DUMPER_LOST_TRACES|Number of lost traces detected by the dumper|Entries/Sec
DUMPER_SKIPPED_BYTES|Total bytes skipped by the dumper|Bytes
DUMPER_TOTAL_AREAS|Total number of areas dumped|Areas
DUMPER_TOTAL_BLOBS|Number of blobs the dumper dumped|Blobs/Sec
DUMPER_TOTAL_CHUNKS|Number of chunks the dumper dumped|Chunks/Sec
DUMPER_TOTAL_HISTOGRAMS|Total number of histograms dumped|Histograms
