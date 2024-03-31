
## Assert failures

**Type** | **Description** | **Units**
-|-|-
ASSERTION_FAILURES_IGNORE|Assertion failures count with "IGNORE" behavior |Assertion failures
ASSERTION_FAILURES_KILL_BUCKET|Assertion failures count with "KILL_BUCKET" behavior|Assertion failures
ASSERTION_FAILURES_KILL_FIBER|Assertion failures count with "KILL_FIBER" behavior|Assertion failures
ASSERTION_FAILURES_KILL_NODE_WITH_CORE_DUMP|Assertion failures count with "KILL_NODE_WITH_CORE_DUMP" behavior|Assertion failures
ASSERTION_FAILURES_KILL_NODE|Assertion failures count with "KILL_NODE" behavior|Assertion failures
ASSERTION_FAILURES_STALL_AND_KILL_NODE|Assertion failures count with "STALL_AND_KILL_NODE" behavior|Assertion failures
ASSERTION_FAILURES_STALL|Assertion failures count with "STALL" behavior |Assertion failures
ASSERTION_FAILURES_THROW_EXCEPTION|Assertion failures count with "THROW_EXCEPTION" behavior|Assertion failures
ASSERTION_FAILURES|Assertion failures count of all available types|Assertion failures

## Attribute Cache

**Type** | **Description** | **Units**
-|-|-
GP_GETATTR_CACHE_MISS|Number of general-purpose getAttr cache misses per second|Ops/Sec
GP_GETATTR|Number of general-purpose getAttr calls per second|Ops/Sec

## Block Cache

**Type** | **Description** | **Units**
-|-|-
BUCKET_CACHED_METADATA_BLOCKS|Bucket number of cached metadata blocks|Blocks
BUCKET_CACHED_REGISTRY_L2_BLOCKS|Bucket number of cached registry L2 blocks|Blocks
BUCKET_CACHE_METADATA_HITS|Bucket block cache metadata hits|Queries
BUCKET_CACHE_METADATA_MISSES|Bucket block cache metadata misses|Queries
BUCKET_CACHE_REGISTRY_L2_HITS|Bucket block cache registry L2 hits|Queries
BUCKET_CACHE_REGISTRY_L2_MISSES|Bucket block cache registry L2 misses|Queries
BUCKET_REGISTRY_L2_BLOCKS_NUM|Bucket number of registry L2 blocks|Blocks

## Block Writes

**Type** | **Description** | **Units**
-|-|-
BLOCK_FULL_WRITES|Number of full block writes|Writes
BLOCK_PARTIAL_WRITES|Number of partial block writes|Writes

## Bucket

**Type** | **Description** | **Units**
-|-|-
BUCKET_START_TIME|Duration of bucket activation on step up|Startups
CHOKING_LEVEL_ALL|Throttling level applied on all types of IOs|%
CHOKING_LEVEL_NON_MUTATING|Throttling level applied on non-mutating only types of IOs|%
DESTAGED_BLOCKS_COUNT|Number of destaged blocks per second|Blocks/Sec
DESTAGE_COUNT|Number of destages per second|Destages/Sec
DIR_MOVE_TIME|Time to complete a directory move|Ops
EXTENT_BLOCKS_COUNT|Difference in number of EXTENT blocks|Blocks
EXTENT_BLOCK_SEQUENCES|Histogram of the number of consecutive sequences of blocks in a single extent|Extents
FREEABLE_LRU_BUFFERS|Number of unused blocks in LRU cache|Buffers
HASH_BLOCKS_COUNT|Difference in number of HASH blocks|Blocks
INODE_BLOCKS_COUNT|Difference in number of INODE blocks|Blocks
INTEGRITY_ISSUES|Number of filesystem integrity issues detected|Issues
JOURNAL_BLOCKS_COUNT|Difference in number of JOURNAL blocks|Blocks
ODH_COLLISIONS_ACCESS_CLOCK_STATES|Number of ODH items created with colliding hash in ACCESS_CLOCK_STATES ODH|Collisions
ODH_COLLISIONS_BIG_BLOB_MANIFEST|Number of ODH items created with colliding hash in BIG_BLOB_MANIFEST ODH|Collisions
ODH_COLLISIONS_DEFAULT_DIR_QUOTA|Number of ODH items created with colliding hash in DEFAULT_DIR_QUOTA ODH|Collisions
ODH_COLLISIONS_DIRECTORY|Number of ODH items created with colliding hash in DIRECTORY ODH|Collisions
ODH_COLLISIONS_DIR_QUOTA|Number of ODH items created with colliding hash in DIR_QUOTA ODH|Collisions
ODH_COLLISIONS_FLOCK_EXPIRED_FRONTENDS|Number of ODH items created with colliding hash in FLOCK_EXPIRED_FRONTENDS ODH|Collisions
ODH_COLLISIONS_GRAVEYARD|Number of ODH items created with colliding hash in GRAVEYARD ODH|Collisions
ODH_COLLISIONS_INODES_PENDING_VALIDATIONS|Number of ODH items created with colliding hash in INODES_PENDING_VALIDATIONS ODH|Collisions
ODH_COLLISIONS_INODES_POTENTIAL_PENDING_DELETION|Number of ODH items created with colliding hash in INODES_POTENTIAL_PENDING_DELETION ODH|Collisions
ODH_COLLISIONS_MODIFY_CLOCK_STATES|Number of ODH items created with colliding hash in MODIFY_CLOCK_STATES ODH|Collisions
ODH_COLLISIONS_OBS_IMMEDIATE_RELEASE|Number of ODH items created with colliding hash in OBS_IMMEDIATE_RELEASE ODH|Collisions
ODH_COLLISIONS_OBS_RECLAMATION|Number of ODH items created with colliding hash in OBS_RECLAMATION ODH|Collisions
ODH_COLLISIONS_REFERENCE_RELOCATIONS|Number of ODH items created with colliding hash in REFERENCE_RELOCATIONS ODH|Collisions
ODH_COLLISIONS_SNAPSHOT_MEMBERS|Number of ODH items created with colliding hash in SNAPSHOT_MEMBERS ODH|Collisions
ODH_COLLISIONS_SNAP_LAYER_CAPACITY|Number of ODH items created with colliding hash in SNAP_LAYER_CAPACITY ODH|Collisions
ODH_COLLISIONS_SNAP_LAYER_SIZE_V4_2|Number of ODH items created with colliding hash in SNAP_LAYER_SIZE_V4_2 ODH|Collisions
ODH_COLLISIONS_SNAP_LAYER_SIZE_V4_3|Number of ODH items created with colliding hash in SNAP_LAYER_SIZE_V4_3 ODH|Collisions
ODH_COLLISIONS_STOW_DOWNLOAD_REDISTRIBUTE_PULL_STATE_V4_3|Number of ODH items created with colliding hash in STOW_DOWNLOAD_REDISTRIBUTE_PULL_STATE_V4_3 ODH|Collisions
ODH_COLLISIONS_STOW_DOWNLOAD_REDISTRIBUTE_V4_3|Number of ODH items created with colliding hash in STOW_DOWNLOAD_REDISTRIBUTE_V4_3 ODH|Collisions
ODH_COLLISIONS_STOW_UPLOAD_MANIFEST|Number of ODH items created with colliding hash in STOW_UPLOAD_MANIFEST ODH|Collisions
ODH_COLLISIONS_SV_CAPACITY_LEADER|Number of ODH items created with colliding hash in SV_CAPACITY_LEADER ODH|Collisions
ODH_COLLISIONS|Number of ODH items created with colliding hash in all ODHs|Collisions
ODL_BLOCKS_COUNT|Difference in number of ODL blocks|Blocks
ODL_PAYLOAD_BLOCKS_COUNT|Difference in number of ODL_PAYLOAD blocks|Blocks
READS|Number of read operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_LATENCY|Average latency of READ operations|Microseconds
REGISTRY_COLLISIONS|Number of registry items created with colliding key|Collisions
REGISTRY_L1_BLOCKS_COUNT|Difference in number of REGISTRY_L1 blocks|Blocks
REGISTRY_L2_BLOCKS_COUNT|Difference in number of REGISTRY_L2 blocks|Blocks
REGISTRY_SEARCHES_COUNT|Number of registry searches per second|Queries/Sec
RESIDENT_BLOCKS_COUNT|Number of blocks in resident blocks table|Blocks
SINGLE_HOP_MISMATCH_RECOVERY|1HOP prefix mismatch recoveries|Issues
SINGLE_HOP_RDMA_MISMATCH_DPDK_FALLBACK|1HOP prefix mismatch RDMA fail|Issues
SNAPSHOT_CREATION_TIME|Time to complete a snapshot creation|Snapshots
SPATIAL_SQUELCH_BLOCKS_COUNT|Difference in number of SPATIAL_SQUELCH blocks|Blocks
SUCCESSFUL_DATA_WEDGINGS|Number of successful attempts to wedge data blocks in journal per second|Attempts/Sec
SUPERBLOCK_BLOCKS_COUNT|Difference in number of SUPERBLOCK blocks|Blocks
TEMPORAL_SQUELCH_BLOCKS_COUNT|Difference in number of TEMPORAL_SQUELCH blocks|Blocks
TRANSIENT_INTEGRITY_ISSUES|Number of transient filesystem integrity issues detected|Issues
UNSUCCESSFUL_DATA_WEDGINGS|Number of unsuccessful attempts to wedge data blocks in journal per second|Attempts/Sec
USER_DATA_BUFFERS_IN_USE|Number of data buffers used for serving ongoing IOs|Buffers
WRITES|Number of write operations per second|Ops/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_LATENCY|Average latency of WRITE operations|Microseconds

## Bucket Failovers

**Type** | **Description** | **Units**
-|-|-
BUCKET_FAILOVERS|Number of failovers detected in remote buckets|Failovers
REMOTE_BUCKET_IS_SECONDARY|Number of times a remote bucket reported it is secondary and cannot serve us|Exceptions

## Bucket Rebalances

**Type** | **Description** | **Units**
-|-|-
BUCKET_INITS|Number of bucket initializations|Times
BUCKET_INIT_LATENCY_HIST|Duration of bucket initialization|Initializations
BUCKET_INIT_LATENCY|Average latency of bucket initialization|Seconds
INFORMATIVE_DENY_BUCKET_ACCESS|Number of new-style NotBucketLeaderEx exceptions|Exceptions
LEGACY_DENY_BUCKET_ACCESS|Number of old-style NotBucketLeader exceptions|Exceptions

## CPU

**Type** | **Description** | **Units**
-|-|-
CPU_UTILIZATION|The percentage of the CPU time used for handling I/Os|%

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

## Config

**Type** | **Description** | **Units**
-|-|-
AVERAGE_CHANGES_IN_CHANGESET|The average number of changes in a changeset|Changes/Sec
AVERAGE_CHANGES_IN_GENERATION|The average number of changes in generation|Changes/Sec
BACKEND_NODE_REJOIN_TIME|The number of backend rejoin attempts per completion time range|Number of rejoins
CHANGESET_COMMIT_LATENCY|The average latency of committing a configuration changeset|Microseconds
CLIENT_NODE_REJOIN_TIME|The number of client rejoin attempts per completion time range|Number of rejoins
CONFIG_PROPAGATION_LATENCY|The latencies of propagation of a configuration generation|Generation
GENERATION_COMMIT_LATENCY|The average latency of committing a configuration generation|Microseconds
HEARTBEAT_PROCESSING_TIME_OLD|The number of non-leader heartbeats per processing time range (OLD)|Number of heartbeats
HEARTBEAT_PROCESSING_TIME|The number of non-leader heartbeats per processing time range|Number of heartbeats
LEADER_HEARTBEAT_PROCESSING_TIME_OLD|The number of leader heartbeats per processing time range (OLD)|Number of heartbeats
LEADER_HEARTBEAT_PROCESSING_TIME|The number of leader heartbeats per processing time range|Number of heartbeats
OVERLAY_FULL_SHIFTS|The number of full overlay shifts|Changes
OVERLAY_INCREMENTAL_SHIFTS|The number of incremental overlay shifts|Changes
OVERLAY_TRACKER_INCREMENTALS|The number of incremental OverlayTracker applications|Changes
OVERLAY_TRACKER_RESYNCS|The number of OverlayTracker full-resyncs|Changes
TOTAL_CHANGESETS_COMMITTED|The total number of committed changesets|Change Sets
TOTAL_COMMITTED_CHANGES|The total number of committed configuration changes|Changes
TOTAL_GENERATIONS_COMMITTED|The number of committed generations per second|Generations

## Data Reduction

**Type** | **Description** | **Units**
-|-|-
ACCEPTED_SEGMENTS|Number of blocks accepted for clusterization|Blocks/Sec
AVG_DELTAS|Average deltas per reference during ingestion (excluding history)|deltas/ref
CLUSTERIZE_CALLS|Clusterize Calls|Calls/Sec
CLUSTERIZE_TIME|Average time to clusterize|Milliseconds
COMPRESS_TASK_CALLS|Compress Task Calls|Calls/Sec
COMPRESS_TASK_TIME|Average time to complete compress task|Milliseconds
DELTAS_COMPLETE_RELOCS|Number of delta blocks notified about relocation of both delta and ref segments at the same time|Blocks/Sec
DELTAS_GC|Number of delta blocks removed by GC|Blocks/Sec
DELTAS_REF_RELOCS|Number of delta blocks notified about reference relocations|Blocks/Sec
DELTA_BACKPTR_COLLISIONS|Number of times delta blocks with the same backptr were encountered during GC|Blocks/Sec
DELTA_PROMOTES|Number of delta blocks promoted by GC|Blocks/Sec
DELTA_RELOCS|Number of delta blocks relocated by GC|Blocks/Sec
DELTA_REMOVAL_BACKPTR_COLLISIONS|Number of times delta blocks with the same backptr were encountered during deletions flush|Blocks/Sec
DROPPED_SEGMENTS|Number of blocks dropped during clusterization|Blocks/Sec
GC_PROMOTIONS|Number of times data was rewritten to the next GC tree level|Blocks/Sec
HISTORY_MATCHES|Number of new delta blocks matched with references from history|Blocks/Sec
INGEST_START_CALLS|Ingest Start Calls|Calls/Sec
INGEST_START_TIME|Average time to start ingest|Milliseconds
NEW_DELTAS|Number of new delta blocks created|Blocks/Sec
NEW_INGESTED|Ingested Blocks|Blocks
NEW_REFERENCES|Number of new reference blocks created|Blocks/Sec
NEW_SINGLES|Number of new reference blocks created|Blocks/Sec
REFERENCE_GC|Number of reference blocks removed by GC|Blocks/Sec
REFERENCE_PROMOTES|Number of reference blocks promoted by GC|Blocks/Sec
REFERENCE_RELOCS|Number of reference blocks relocated by GC|Blocks/Sec
REF_BACKPTR_COLLISIONS|Number of times blocks with the same reference-backptr were encountered during GC|Blocks/Sec
SEGMENT_PROMOTES|Promoted Compressed Blocks|Blocks
SEGMENT_RELOCS|Relocated Compressed Blocks|Blocks
SINGLES_MARKED_AS_REFS|Number of single blocks marked as references due to new matches|Blocks/Sec

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
DOWNLOADS|Number of downloads per second|Ops/Sec
DOWNLOAD_LATENCY|Average latency of downloads|Microseconds
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
OBS_FREED|Number of bytes freed from disk because they are in the object store per second|Bytes/Sec
OBS_IMMEDIATE_RELEASE_FREED|Number of bytes freed from disk due to immediate release per second|Bytes/Sec
OBS_INODES_PREFETCH|Number of files prefetched from object store per second|Ops/Sec
OBS_INODES_RELEASE|Number of files released to object store per second|Ops/Sec
OBS_ONGOING_RECLAMATIONS|Number of ongoing reclamations|Ops
OBS_POLICY_FREED|Number of bytes freed from disk due to policy per second|Bytes/Sec
OBS_PROMOTE_EXTENT_WRITE_LATENCY|Average latency of extent promote writes|Microseconds
OBS_PROMOTE_EXTENT_WRITE|Number of extents promoted from object-store per second|Extents/Sec
OBS_PROMOTE_WRITE|Number of bytes promoted from object store per second|Bytes/Sec
OBS_READ|Number of reads that needed data from the object store per second|Ops/Sec
OBS_RECLAMATION_PURGED_BYTES|Number of bytes purged per second|Bytes/Sec
OBS_RECLAMATION_SCAVENGED_BLOBS|Number of blobs scavenged per second|Ops/Sec
OBS_RECLAMATION_SCAVENGED_BYTES|Number of bytes scavenged per second|Bytes/Sec
OBS_RECLAMATION_WAIT_FOR_DESTAGE|Average time waiting for destaging on space reclamation|Microseconds
OBS_RELOC_DOWNLOAD|Number of relocation blobs downloaded per second|Ops/Sec
OBS_RELOC_UPLOAD|Number of relocation blobs uploaded per second|Ops/Sec
OBS_SCAVENGED_BLOB_WASTE_LEVEL|Waste level found in blobs|Blobs
OBS_SHARED_DOWNLOADS_LATENCY|Average latency of shared downloads from object-store|Microseconds
OBS_SHARED_DOWNLOADS|Number of shared downloads from object store per second|Ops/Sec
OBS_TRUNCATE|Number of truncates that needed data from the object store per second|Ops/Sec
OBS_UNEXPECTED_TAG_ON_DOWNLOAD|Number of unexpected tags found when downloading extents|Occurrences
OBS_WRITE|Number of writes that needed data from the object store per second|Ops/Sec
STOW_COMMIT_QUEUE_HANG|Number of times metadata download queue was hanging full|Occurrences
STOW_METADATA_DESERIALIZATION_LATENCY|Average latency of metadata blob deserialization|Milliseconds
STOW_METADATA_SEED_DOWNLOADS|Number of seed downloads per second|Ops/Sec
STOW_SERIALIZED_EXTENT_DATA|Number of extent descriptors uploaded that contain data|Extent Descriptors
STOW_SERIALIZED_EXTENT_DESCS|Number of extent descriptors uploaded|Extent Descriptors
STOW_SERIALIZED_EXTENT_REDIRECTS|Number of extent descriptors uploaded that redirect to the previous snapshot|Extent Descriptors
TIERED_FS_BREAKING_POLICY|Number of tiered filesystems breaking policy|Activations
TIMEOUT_DOWNLOADS|Number of timed-out downloads per second|Ops/Sec
TIMEOUT_OPERATIONS|Total number of timed-out operations per second|Ops/Sec
TIMEOUT_UPLOADS|Number of timed-out uploads per second|Ops/Sec
UNEXPECTED_BLOCK_VERSION_POST_UPGRADE|Number of unexpected block versions found after the upgrade completed|Occurrences
UPLOADS|Number of upload attempts per second|Ops/Sec
UPLOAD_CHOKING_LATENCY|Average latency of waiting for upload choking budget|Microseconds
UPLOAD_LATENCY|Average latency of uploads|Microseconds

## Frontend

**Type** | **Description** | **Units**
-|-|-
FE_IDLE_CYCLES|The number of idle cycles on the frontend|Cycles/Sec
FE_IDLE_TIME|The percentage of the CPU time not used for handling I/Os on the frontend|%

## Frontend Encryption

**Type** | **Description** | **Units**
-|-|-
FE_BLOCKS_DECRYPTED|Number of blocks decrypted in the frontend|Blocks
FE_BLOCKS_ENCRYPTED|Number of blocks encrypted in the frontend|Blocks
FE_BLOCK_CRYPTO_LATENCY|Average latency of frontend block crypto|Microseconds
FE_BLOCK_DECRYPT_DURATION|Duration of decryption of blocks in the frontend|Microseconds
FE_BLOCK_ENCRYPT_DURATION|Duration of encryption of blocks in the frontend|Microseconds
FE_FILENAMES_DECRYPTED|Number of filenames decrypted in the frontend|Filenames
FE_FILENAMES_ENCRYPTED|Number of filenames encrypted in the frontend|Filenames
FE_FILENAME_CRYPTO_LATENCY|Average latency of frontend filename crypto|Microseconds
FE_FILENAME_DECRYPT_DURATION|Duration of decryption of filenames in the frontend|Microseconds
FE_FILENAME_ENCRYPT_DURATION|Duration of encryption of filenames in the frontend|Microseconds

## Garbage Collection

**Type** | **Description** | **Units**
-|-|-
GC_FREE_SIZE_AFTER_SCAN|GC pool size after the scan ends|Bytes
GC_FREE_SIZE_BEFORE_SCAN|GC pool size before the scan starts|Bytes
GC_SCANS|Number of GC scans|Scans
GC_SCAN_TIME|GC scan time|Msec
GC_USED_SIZE_AFTER_SCAN|GC used size after the scan ends|Bytes
GC_USED_SIZE_BEFORE_SCAN|GC used size before the scan starts|Bytes

## JRPC

**Type** | **Description** | **Units**
-|-|-
JRPC_SERVER_PROCESSING_AVG|The average time the JRPC server processed the JRPC requests.|Microseconds
JRPC_SERVER_PROCESSING_TIME|The number of JRPC requests processed by the server per each time range.|Requests

## Memory

**Type** | **Description** | **Units**
-|-|-
RSS_CURRENT|The process (node) memory resident size, current in sample time.|MB
RSS_PEAK|The process (node) memory resident size, peak over process lifetime.|MB

## Network

**Type** | **Description** | **Units**
-|-|-
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
GOODPUT_RX_RATIO|Percentage of goodput RX packets out of total data packets received|%
GOODPUT_TX_RATIO|Percentage of goodput TX packets out of total data packets sent|%
GW_MAC_RESOLVE_FAILURES|Number of times we failed to ARP resolve the gateway IP|Failures
GW_MAC_RESOLVE_SUCCESSES|Number of times we succeeded in ARP resolve the gateway IP|Successes
INVALID_FIRST_FRAGMENT|Number of times we got an invalid first fragment|Packets/Sec
MBUF_DUP_COUNT|Numer of Duplicate mbufs found|Occurences
MBUF_DUP_ITER|Duplicate mbuf check completions|Occurences
NODE_RECONNECTED|Number of reconnections|Reconnects/Sec
PACKETS_PUMPED|Number of packets received in each call to recvPackets|Batches
PEER_RTT|RTT per peer node|Microseconds
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
PUMPS_TXQ_FULL|Number of times we couldn't send any new packets to the NIC queue|Pumps/Sec
PUMPS_TXQ_PARTIAL|Number of times we only sent some of our queued packets to the NIC queue|Pumps/Sec
PUMP_DURATION|Duration of each pump|Requests
PUMP_INTERVAL|Interval between pumps|Requests
RDMA_ADD_CHUNK_FAILURES|Number of RDMA cookie setting failurs|Failures/Sec
RDMA_BINDING_FAILOVERS|Number of RDMA High-Availability fail-overs |Fail-overs/Sec
RDMA_CANCELED_COMPLETIONS|Number of RDMA completions that were canceled |Completions/Sec
RDMA_CLIENT_BINDING_INVALIDATIONS|Number of RDMA client binding invalidations|Invalidations/Sec
RDMA_COMPLETIONS|Number of RDMA requests that were completed|Completions/Sec
RDMA_COMP_DURATION|Histogram of RDMA completion duration times|Requests
RDMA_COMP_FAILURES|Number of RDMA requests that were completed with an error|Failures/Sec
RDMA_COMP_LATENCY|Average time of RDMA requests completion|Microseconds
RDMA_COMP_STATUSES|Histogram of RDMA completion statuses|Completions/Sec
RDMA_NET_ERR_RETRY_EXCEEDED|Number of RDMA requests with error retries exceeded|Occurences/Sec
RDMA_POOL_ALLOC_FAILED|Number of times an RDMA request was not issued due to a pool allocation failure|Failures/Sec
RDMA_POOL_LOW_CAPACITY|Number of times an RDMA request was not issued due to low RDAM pool memory|Failures/Sec
RDMA_POOL_MBUF_LEAKED|RDMA leaked mbufs|Occurences
RDMA_PORT_WAITING_FIBERS|Number of fibers pending to send an RDMA request|Waiting fibers
RDMA_REQUESTS|Number of RDMA requests sent to the NIC|Requests/Sec
RDMA_RX_BYTES|Number of bytes received with RDMA|Bytes/Sec
RDMA_SERVER_BINDING_RESTARTS|Number of RDMA server binding restarts|Restarts/Sec
RDMA_SERVER_RECV_FAILURES|Number of failed RDMA server-side receive attempts|Failures/Sec
RDMA_SERVER_SEND_FAILURES|Number of failed RDMA server-side send attempts|Failures/Sec
RDMA_SUBMIT_FAILURES|Number of RDMA submit failures, likely indicating a fabric issue|Failures/Sec
RDMA_SUBMIT_TIMEOUTS|Number of RDMA submit timeouts|Timeouts/Sec
RDMA_TX_BYTES|Number of bytes sent with RDMA|Bytes/Sec
RDMA_WAIT_INTERRUPTED|RDMA Wait interruptions|Issues
RDMA_WAIT_PREMATURE_WAKEUP|RDMA Wait for premature wakeup|Issues
RDMA_WAIT_TIMEOUT|RDMA Wait timeouts|Issues
RECEIVED_CONTROL_PACKETS|Number of received control packets|Packets/Sec
RECEIVED_DATA_PACKETS|Number of received data packets|Packets/Sec
RECEIVED_PACKETS|Number of packets received|Packets/Sec
RECEIVED_PACKET_GENERATIONS|The generation ("resend count") of the first incarnation of the packet seen by the receiver (indicates packet loss)|Packets
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
TIMELY_RESENDS|Number of packets resent due to timely resend|Packets/Sec
TIME_TO_ACK|Histogram of time to acknowledge a data packet|Requests
TIME_TO_FIRST_SEND|Time from queueing to first send|Requests
UDP_SENDMSG_FAILED_EAGAIN|Number of packets that failed to be sent on the socket backend with EAGAIN|Packets/Sec
UDP_SENDMSG_FAILED_OTHER|Number of packets that failed to be sent on the socket backend with an unknown error|Packets/Sec
UDP_SENDMSG_PARTIAL_SEND|Number of packets that we failed to send, but in the same pump, some packets were sent|Packets/Sec
UNACKED_RESENDS|Number of packets resent after receiving an ack|Packets/Sec
ZERO_CSUM|Number of checksum zero received|Packets/Sec

## Object Storage

**Type** | **Description** | **Units**
-|-|-
FAILED_OBJECT_DELETES|Number of failed object deletes per second (any failure reason)|Ops/Sec
FAILED_OBJECT_DOWNLOADS|Number of failed object downloads per second (any failure reason)|Ops/Sec
FAILED_OBJECT_HEAD_QUERIES|Number of failed object head queries per second (any failure reason)|Ops/Sec
FAILED_OBJECT_OPERATIONS|Total number of failed operations per second|Ops/Sec
FAILED_OBJECT_UPLOADS|Number of failed object uploads per second (any failure reason)|Ops/Sec
OBJECT_DELETES|Number of object deletes per second|Ops/Sec
OBJECT_DELETE_DURATION|Duration of object delete request|Ops
OBJECT_DELETE_LATENCY|Average latency of deleting an object|Microseconds
OBJECT_DOWNLOADS_BACKGROUND|Number of BACKGROUND objects downloaded per second|Ops/Sec
OBJECT_DOWNLOADS_FOREGROUND|Number of FOREGROUND objects downloaded per second|Ops/Sec
OBJECT_DOWNLOADS|Number of objects downloaded per second|Ops/Sec
OBJECT_DOWNLOAD_BYTES_BACKGROUND|Number of BACKGROUND bytes sent to the object store per second|Bytes/Sec
OBJECT_DOWNLOAD_BYTES_FOREGROUND|Number of FOREGROUND bytes sent to the object store per second|Bytes/Sec
OBJECT_DOWNLOAD_DURATION|Duration of object download request|Ops
OBJECT_DOWNLOAD_LATENCY|Average latency of downloading an object|Microseconds
OBJECT_DOWNLOAD_SIZE|Size of downloaded object ranges|Ops
OBJECT_HEAD_DURATION|Duration of object head request|Ops
OBJECT_HEAD_LATENCY|Average latency of deleting an object|Microseconds
OBJECT_HEAD_QUERIES|Number of object head queries per second|Ops/Sec
OBJECT_OPERATIONS|Total number of operations per second|Ops/Sec
OBJECT_REMOVE_SIZE|Size of removed objects|Ops
OBJECT_UPLOADS_BACKPRESSURE|Number of BACKPRESSURE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_IMMEDIATE_RELEASE|Number of IMMEDIATE_RELEASE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_MANHOLE|Number of MANHOLE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_MIGRATE|Number of MIGRATE upload attempts per second|Ops/Sec
OBJECT_UPLOADS_POLICY|Number of POLICY upload attempts per second|Ops/Sec
OBJECT_UPLOADS_RECLAMATION_REUPLOAD|Number of RECLAMATION_REUPLOAD upload attempts per second|Ops/Sec
OBJECT_UPLOADS_STOW|Number of STOW upload attempts per second|Ops/Sec
OBJECT_UPLOADS|Number of object uploads per second|Ops/Sec
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
RESPONSE_COUNT_NON_AUTH_INFO|Number of HTTP NON_AUTH_INFO responses per second|Responses/Sec
RESPONSE_COUNT_NOT_ACCEPTABLE|Number of HTTP NOT_ACCEPTABLE responses per second|Responses/Sec
RESPONSE_COUNT_NOT_FOUND|Number of HTTP NOT_FOUND responses per second|Responses/Sec
RESPONSE_COUNT_NOT_IMPLEMENTED|Number of HTTP NOT_IMPLEMENTED responses per second|Responses/Sec
RESPONSE_COUNT_NOT_MODIFIED|Number of HTTP NOT_MODIFIED responses per second|Responses/Sec
RESPONSE_COUNT_NO_CONTENT|Number of HTTP NO_CONTENT responses per second|Responses/Sec
RESPONSE_COUNT_OK|Number of HTTP OK responses per second|Responses/Sec
RESPONSE_COUNT_PARTIAL_CONTENT|Number of HTTP PARTIAL_CONTENT responses per second|Responses/Sec
RESPONSE_COUNT_PAYMENT_REQUIRED|Number of HTTP PAYMENT_REQUIRED responses per second|Responses/Sec
RESPONSE_COUNT_PRECONDITION_FAILED|Number of HTTP PRECONDITION_FAILED responses per second|Responses/Sec
RESPONSE_COUNT_PROXY_AUTH_REQUIRED|Number of HTTP PROXY_AUTH_REQUIRED responses per second|Responses/Sec
RESPONSE_COUNT_REDIRECT_MULTIPLE_CHOICES|Number of HTTP REDIRECT_MULTIPLE_CHOICES responses per second|Responses/Sec
RESPONSE_COUNT_REQUESTED_RANGE_NOT_SATISFIABLE|Number of HTTP REQUESTED_RANGE_NOT_SATISFIABLE responses per second|Responses/Sec
RESPONSE_COUNT_REQUEST_HEADER_FIELDS_TOO_LARGE|Number of HTTP REQUEST_HEADER_FIELDS_TOO_LARGE responses per second|Responses/Sec
RESPONSE_COUNT_REQUEST_TIMEOUT|Number of HTTP REQUEST_TIMEOUT responses per second|Responses/Sec
RESPONSE_COUNT_REQUEST_TOO_LARGE|Number of HTTP REQUEST_TOO_LARGE responses per second|Responses/Sec
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
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READS|Number of read operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_DURATION|The number of reads per completion duration|Reads
READ_LATENCY|Average latency of READ operations|Microseconds
READ_SIZES|NFS read sizes histogram|Reads
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
THROUGHPUT|Number of byte read/writes per second|Bytes/Sec
WRITES|Number of write operations per second|Ops/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_DURATION|The number of writes per completion duration|Writes
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITE_SIZES|NFS write sizes histogram|Writes

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
NFS3_CLIENT_READ_BYTES|Number of NFSV3 bytes read per second|Bytes/Sec
NFS3_CLIENT_WRITE_BYTES|Number of NFSV3 bytes written per second|Bytes/Sec
NFS3_FSINFO_LATENCY|Average latency of NFS3_FSINFO operations|Microseconds
NFS3_FSINFO_OPS|Number of NFS3_FSINFO operation per second|Ops/Sec
NFS3_MKDIR_LATENCY|Average latency of NFS3_MKDIR operations|Microseconds
NFS3_MKDIR_OPS|Number of NFS3_MKDIR operation per second|Ops/Sec
NFS3_MKNOD_LATENCY|Average latency of NFS3_MKNOD operations|Microseconds
NFS3_MKNOD_OPS|Number of NFS3_MKNOD operation per second|Ops/Sec
NFS3_PATHCONF_LATENCY|Average latency of NFS3_PATHCONF operations|Microseconds
NFS3_PATHCONF_OPS|Number of NFS3_PATHCONF operation per second|Ops/Sec
NFS3_STATFS_LATENCY|Average latency of NFS3_STATFS operations|Microseconds
NFS3_STATFS_OPS|Number of NFS3_STATFS operation per second|Ops/Sec
NFS3_SYMLINK_LATENCY|Average latency of NFS3_SYMLINK operations|Microseconds
NFS3_SYMLINK_OPS|Number of NFS3_SYMLINK operation per second|Ops/Sec
NFS4_BACKCHANNEL_CTL_LATENCY|Average latency of NFS4_BACKCHANNEL_CTL operations|Microseconds
NFS4_BACKCHANNEL_CTL_OPS|Number of NFS4_BACKCHANNEL_CTL operation per second|Ops/Sec
NFS4_BIND_CONN_TO_SESSION_LATENCY|Average latency of NFS4_BIND_CONN_TO_SESSION operations|Microseconds
NFS4_BIND_CONN_TO_SESSION_OPS|Number of NFS4_BIND_CONN_TO_SESSION operation per second|Ops/Sec
NFS4_CLIENT_READ_BYTES|Number of NFSV4 bytes read per second|Bytes/Sec
NFS4_CLIENT_WRITE_BYTES|Number of NFSV4 bytes written per second|Bytes/Sec
NFS4_CLOSE_LATENCY|Average latency of NFS4_CLOSE operations|Microseconds
NFS4_CLOSE_OPS|Number of NFS4_CLOSE operation per second|Ops/Sec
NFS4_CREATE_SESSION_LATENCY|Average latency of NFS4_CREATE_SESSION operations|Microseconds
NFS4_CREATE_SESSION_OPS|Number of NFS4_CREATE_SESSION operation per second|Ops/Sec
NFS4_DELEGPURGE_LATENCY|Average latency of NFS4_DELEGPURGE operations|Microseconds
NFS4_DELEGPURGE_OPS|Number of NFS4_DELEGPURGE operation per second|Ops/Sec
NFS4_DELEGRETURN_LATENCY|Average latency of NFS4_DELEGRETURN operations|Microseconds
NFS4_DELEGRETURN_OPS|Number of NFS4_DELEGRETURN operation per second|Ops/Sec
NFS4_DESTROY_CLIENTID_LATENCY|Average latency of NFS4_DESTROY_CLIENTID operations|Microseconds
NFS4_DESTROY_CLIENTID_OPS|Number of NFS4_DESTROY_CLIENTID operation per second|Ops/Sec
NFS4_DESTROY_SESSION_LATENCY|Average latency of NFS4_DESTROY_SESSION operations|Microseconds
NFS4_DESTROY_SESSION_OPS|Number of NFS4_DESTROY_SESSION operation per second|Ops/Sec
NFS4_EXCHANGE_ID_LATENCY|Average latency of NFS4_EXCHANGE_ID operations|Microseconds
NFS4_EXCHANGE_ID_OPS|Number of NFS4_EXCHANGE_ID operation per second|Ops/Sec
NFS4_FREE_STATEID_LATENCY|Average latency of NFS4_FREE_STATEID operations|Microseconds
NFS4_FREE_STATEID_OPS|Number of NFS4_FREE_STATEID operation per second|Ops/Sec
NFS4_GETDEVICEINFO_LATENCY|Average latency of NFS4_GETDEVICEINFO operations|Microseconds
NFS4_GETDEVICEINFO_OPS|Number of NFS4_GETDEVICEINFO operation per second|Ops/Sec
NFS4_GETDEVICELIST_LATENCY|Average latency of NFS4_GETDEVICELIST operations|Microseconds
NFS4_GETDEVICELIST_OPS|Number of NFS4_GETDEVICELIST operation per second|Ops/Sec
NFS4_GETFH_LATENCY|Average latency of NFS4_GETFH operations|Microseconds
NFS4_GETFH_OPS|Number of NFS4_GETFH operation per second|Ops/Sec
NFS4_GET_DIR_DELEGATION_LATENCY|Average latency of NFS4_GET_DIR_DELEGATION operations|Microseconds
NFS4_GET_DIR_DELEGATION_OPS|Number of NFS4_GET_DIR_DELEGATION operation per second|Ops/Sec
NFS4_LAYOUTCOMMIT_LATENCY|Average latency of NFS4_LAYOUTCOMMIT operations|Microseconds
NFS4_LAYOUTCOMMIT_OPS|Number of NFS4_LAYOUTCOMMIT operation per second|Ops/Sec
NFS4_LAYOUTGET_LATENCY|Average latency of NFS4_LAYOUTGET operations|Microseconds
NFS4_LAYOUTGET_OPS|Number of NFS4_LAYOUTGET operation per second|Ops/Sec
NFS4_LAYOUTRETURN_LATENCY|Average latency of NFS4_LAYOUTRETURN operations|Microseconds
NFS4_LAYOUTRETURN_OPS|Number of NFS4_LAYOUTRETURN operation per second|Ops/Sec
NFS4_LOCKT_LATENCY|Average latency of NFS4_LOCKT operations|Microseconds
NFS4_LOCKT_OPS|Number of NFS4_LOCKT operation per second|Ops/Sec
NFS4_LOCKU_LATENCY|Average latency of NFS4_LOCKU operations|Microseconds
NFS4_LOCKU_OPS|Number of NFS4_LOCKU operation per second|Ops/Sec
NFS4_LOCK_LATENCY|Average latency of NFS4_LOCK operations|Microseconds
NFS4_LOCK_OPS|Number of NFS4_LOCK operation per second|Ops/Sec
NFS4_LOOKUPP_LATENCY|Average latency of NFS4_LOOKUPP operations|Microseconds
NFS4_LOOKUPP_OPS|Number of NFS4_LOOKUPP operation per second|Ops/Sec
NFS4_NVERIFY_LATENCY|Average latency of NFS4_NVERIFY operations|Microseconds
NFS4_NVERIFY_OPS|Number of NFS4_NVERIFY operation per second|Ops/Sec
NFS4_OPENATTR_LATENCY|Average latency of NFS4_OPENATTR operations|Microseconds
NFS4_OPENATTR_OPS|Number of NFS4_OPENATTR operation per second|Ops/Sec
NFS4_OPEN_CONFIRM_LATENCY|Average latency of NFS4_OPEN_CONFIRM operations|Microseconds
NFS4_OPEN_CONFIRM_OPS|Number of NFS4_OPEN_CONFIRM operation per second|Ops/Sec
NFS4_OPEN_DOWNGRADE_LATENCY|Average latency of NFS4_OPEN_DOWNGRADE operations|Microseconds
NFS4_OPEN_DOWNGRADE_OPS|Number of NFS4_OPEN_DOWNGRADE operation per second|Ops/Sec
NFS4_OPEN_LATENCY|Average latency of NFS4_OPEN operations|Microseconds
NFS4_OPEN_OPS|Number of NFS4_OPEN operation per second|Ops/Sec
NFS4_PUTFH_LATENCY|Average latency of NFS4_PUTFH operations|Microseconds
NFS4_PUTFH_OPS|Number of NFS4_PUTFH operation per second|Ops/Sec
NFS4_PUTPUBFH_LATENCY|Average latency of NFS4_PUTPUBFH operations|Microseconds
NFS4_PUTPUBFH_OPS|Number of NFS4_PUTPUBFH operation per second|Ops/Sec
NFS4_PUTROOTFH_LATENCY|Average latency of NFS4_PUTROOTFH operations|Microseconds
NFS4_PUTROOTFH_OPS|Number of NFS4_PUTROOTFH operation per second|Ops/Sec
NFS4_RECLAIM_COMPLETE_LATENCY|Average latency of NFS4_RECLAIM_COMPLETE operations|Microseconds
NFS4_RECLAIM_COMPLETE_OPS|Number of NFS4_RECLAIM_COMPLETE operation per second|Ops/Sec
NFS4_RELEASE_LOCKOWNER_LATENCY|Average latency of NFS4_RELEASE_LOCKOWNER operations|Microseconds
NFS4_RELEASE_LOCKOWNER_OPS|Number of NFS4_RELEASE_LOCKOWNER operation per second|Ops/Sec
NFS4_RENEW_LATENCY|Average latency of NFS4_RENEW operations|Microseconds
NFS4_RENEW_OPS|Number of NFS4_RENEW operation per second|Ops/Sec
NFS4_RESTOREFH_LATENCY|Average latency of NFS4_RESTOREFH operations|Microseconds
NFS4_RESTOREFH_OPS|Number of NFS4_RESTOREFH operation per second|Ops/Sec
NFS4_SAVEFH_LATENCY|Average latency of NFS4_SAVEFH operations|Microseconds
NFS4_SAVEFH_OPS|Number of NFS4_SAVEFH operation per second|Ops/Sec
NFS4_SECINFO_LATENCY|Average latency of NFS4_SECINFO operations|Microseconds
NFS4_SECINFO_NO_NAME_LATENCY|Average latency of NFS4_SECINFO_NO_NAME operations|Microseconds
NFS4_SECINFO_NO_NAME_OPS|Number of NFS4_SECINFO_NO_NAME operation per second|Ops/Sec
NFS4_SECINFO_OPS|Number of NFS4_SECINFO operation per second|Ops/Sec
NFS4_SEQUENCE_LATENCY|Average latency of NFS4_SEQUENCE operations|Microseconds
NFS4_SEQUENCE_OPS|Number of NFS4_SEQUENCE operation per second|Ops/Sec
NFS4_SETCLIENTID_CONFIRM_LATENCY|Average latency of NFS4_SETCLIENTID_CONFIRM operations|Microseconds
NFS4_SETCLIENTID_CONFIRM_OPS|Number of NFS4_SETCLIENTID_CONFIRM operation per second|Ops/Sec
NFS4_SETCLIENTID_LATENCY|Average latency of NFS4_SETCLIENTID operations|Microseconds
NFS4_SETCLIENTID_OPS|Number of NFS4_SETCLIENTID operation per second|Ops/Sec
NFS4_SET_SSV_LATENCY|Average latency of NFS4_SET_SSV operations|Microseconds
NFS4_SET_SSV_OPS|Number of NFS4_SET_SSV operation per second|Ops/Sec
NFS4_TEST_STATEID_LATENCY|Average latency of NFS4_TEST_STATEID operations|Microseconds
NFS4_TEST_STATEID_OPS|Number of NFS4_TEST_STATEID operation per second|Ops/Sec
NFS4_VERIFY_LATENCY|Average latency of NFS4_VERIFY operations|Microseconds
NFS4_VERIFY_OPS|Number of NFS4_VERIFY operation per second|Ops/Sec
NFS4_WANT_DELEGATION_LATENCY|Average latency of NFS4_WANT_DELEGATION operations|Microseconds
NFS4_WANT_DELEGATION_OPS|Number of NFS4_WANT_DELEGATION operation per second|Ops/Sec
OPS|Total number of operations|Ops/Sec
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_LATENCY|Average latency of READ operations|Microseconds
READ_OPS|Number of READ operations per second|Ops/Sec
REMOVE_LATENCY|Average latency of REMOVE operations|Microseconds
REMOVE_OPS|Number of REMOVE operations per second|Ops/Sec
RENAME_LATENCY|Average latency of RENAME operations|Microseconds
RENAME_OPS|Number of RENAME operations per second|Ops/Sec
SETATTR_LATENCY|Average latency of SETATTR operations|Microseconds
SETATTR_OPS|Number of SETATTR operations per second|Ops/Sec
THROUGHPUT|Number of byte read/writes per second|Bytes/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITE_OPS|Number of WRITE operations per second|Ops/Sec

## Operations (S3)

**Type** | **Description** | **Units**
-|-|-
AVG_COPY_OPS|Average copy operations per second|Ops/Sec
AVG_DELETE_OPS|Average delete operations per second|Ops/Sec
AVG_GET_OPS|Average get operations per second|Ops/Sec
AVG_LIST_V1_OPS|Average list v1 operations per second|Ops/Sec
AVG_LIST_V2_OPS|Average list v2 operations per second|Ops/Sec
AVG_MULTIPART_UPLOAD_OPS|Average multipart upload operations per second|Ops/Sec
AVG_PUT_OBJECTPART_OPS|Average put objectpart operations per second|Ops/Sec
AVG_PUT_OPS|Average put operations per second|Ops/Sec
READ_BYTES|Number of byte reads per second|Bytes/Sec
THROUGHPUT|Throughput|Bytes/Sec
TOTAL_BUCKET_CREATE_OPS|Total bucket create operations per second|Ops/Sec
TOTAL_BUCKET_DELETE_OPS|Total bucket delete operation per second |Ops/Sec
TOTAL_BUCKET_LIST_OPS|Total bucket list operations per second|Ops/Sec
TOTAL_COPY_LATENCY|Average latency of Copy operations|Microseconds
TOTAL_COPY_OPS|Total Copy operations|Ops
TOTAL_DELETE_OPS|Total delete operations|Ops
TOTAL_GET_BUCKET_ACL_OPS|Total get bucket acl operations per second|Ops/Sec
TOTAL_GET_BUCKET_NOTIFICATION_OPS|Total get bucket notifications operations per second|Ops/Sec
TOTAL_GET_LATENCY|Average latency of Get operations|Microseconds
TOTAL_GET_OPS|Total Get operations|Ops
TOTAL_LIST_V1_OPS|Total list v1 operations|Ops
TOTAL_LIST_V2_OPS|Total list v2 operations|Ops
TOTAL_MULTIPART_UPLOAD_LATENCY|Average latency of Multipart upload operations|Microseconds
TOTAL_MULTIPART_UPLOAD_OPS|Total multipart upload operations|Ops
TOTAL_PUT_BUCKET_ACL_OPS|Total put bucket acl operations per second|Ops/Sec
TOTAL_PUT_LATENCY|Average latency of Put operations|Microseconds
TOTAL_PUT_OBJECTPART_OPS|Total put objectpart operations|Ops
TOTAL_PUT_OPS|Total put operations|Ops
WRITE_BYTES|Number of byte writes per second |Bytes/Sec

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
IOCTL_OBS_PREFETCH_OPS|Number of IOCTL_OBS_PREFETCH operation per second|Ops/Sec
IOCTL_OBS_PREFETCH_QOS_DELAY|Average QoS delay for IOCTL_OBS_PREFETCH operations|Microseconds
IOCTL_OBS_RELEASE_LATENCY|Average latency of IOCTL_OBS_RELEASE operations|Microseconds
IOCTL_OBS_RELEASE_OPS|Number of IOCTL_OBS_RELEASE operation per second|Ops/Sec
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
RDMA_WRITE_REQUESTS|Number of RDMA write request operations per second|Ops/Sec
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READDIR_QOS_DELAY|Average QoS delay for READDIR operations|Microseconds
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READLINK_QOS_DELAY|Average QoS delay for READLINK operations|Microseconds
READS_NO_LEASE|Number of direct reads while we have no lease|Ops/Sec
READS|Number of read operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_CHECKSUM_ERRORS|The number of times the driver's checksum validation failed upon the read's content|Ops
READ_CORRUPTIONS_DETECTED_IN_1HOP|The number of corrupt data blocks encountered during 1-hop read|Ops
READ_DURATION|The number of reads per each time duration|Reads
READ_LATENCY_NO_QOS|Average latency of READ operations without QoS delay|Microseconds
READ_LATENCY|Average latency of READ operations|Microseconds
READ_QOS_DELAY|Average QoS delay for READ operations|Microseconds
READ_RDMA_SIZES_RATE|The number of RDMA reads per each read size range per second|Reads
READ_RDMA_SIZES|The number of RDMA reads per each read size range|Reads
READ_SIZES_RATE|The number of reads per each read size range per second|Reads
READ_SIZES|The number of reads per each read size range|Reads
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
STATFS_LATENCY|Average latency of STATFS operations|Microseconds
STATFS_OPS|Number of STATFS operations per second|Ops/Sec
STATFS_QOS_DELAY|Average QoS delay for STATFS operations|Microseconds
SUCCEEDED_1HOP_READS|Number of successful single hop reads per second|Ops/Sec
SYMLINK_LATENCY|Average latency of SYMLINK operations|Microseconds
SYMLINK_OPS|Number of SYMLINK operations per second|Ops/Sec
SYMLINK_QOS_DELAY|Average QoS delay for SYMLINK operations|Microseconds
THROUGHPUT|Number of byte read/writes per second|Bytes/Sec
UNLINK_LATENCY|Average latency of UNLINK operations|Microseconds
UNLINK_OPS|Number of UNLINK operations per second|Ops/Sec
UNLINK_QOS_DELAY|Average QoS delay for UNLINK operations|Microseconds
WRITES_NO_LEASE|Number of direct writes while we have no lease|Ops/Sec
WRITES|Number of write operations per second|Ops/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_DURATION|The number of writes per time duration|Writes
WRITE_LATENCY_NO_QOS|Average latency of WRITE operations without QoS delay|Microseconds
WRITE_LATENCY|Average latency of WRITE operations|Microseconds
WRITE_QOS_DELAY|Average QoS delay for WRITE operations|Microseconds
WRITE_RDMA_SIZES_RATE|The number of RDMA writes per each read size range per second|Writes
WRITE_RDMA_SIZES|The number of RDMA writes per each read size range|Writes
WRITE_SIZES_RATE|The number of writes per each read size range per second|Writes
WRITE_SIZES|The number of writes per each read size range|Writes

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
READDIR_LATENCY|Average latency of READDIR operations|Microseconds
READDIR_OPS|Number of READDIR operations per second|Ops/Sec
READLINK_LATENCY|Average latency of READLINK operations|Microseconds
READLINK_OPS|Number of READLINK operations per second|Ops/Sec
READS|Number of read operations per second|Ops/Sec
READ_BYTES|Number of bytes read per second|Bytes/Sec
READ_DURATION|The number of reads per completion duration|Reads
READ_LATENCY|Average latency of READ operations|Microseconds
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
THROUGHPUT|Number of byte read/writes per second|Bytes/Sec
UNLINK_LATENCY|Average latency of UNLINK operations|Microseconds
UNLINK_OPS|Number of UNLINK operations per second|Ops/Sec
WRITES|Number of write operations per second|Ops/Sec
WRITE_BYTES|Number of byte writes per second|Bytes/Sec
WRITE_DURATION|The number of writes per completion duration|Writes
WRITE_LATENCY|Average latency of WRITE operations|Microseconds

## Processes

**Type** | **Description** | **Units**
-|-|-
ABRUPT_EXITS|How many abrupt exits of a process (node) occurred |Abrupt process exits
PEER_CONFIGURE_FAILURES|How many times the node failed to configure peers to sync with them|Peer configure failures

## RAFT

**Type** | **Description** | **Units**
-|-|-
Bucket_LEADER_CHANGES|Changes of leader|Changes
Bucket_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests
Configuration_LEADER_CHANGES|Changes of leader|Changes
Configuration_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests
Invalid_LEADER_CHANGES|Changes of leader|Changes
Invalid_REQUESTS_COMPLETED|Requests to leader completed successfully|Requests
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
RAID_BLOCKS_IN_PREPARED_STRIPE|Free blocks in prepared stripe|Blocks
RAID_CHUNKS_CLEANED_BY_SHIFT|Dirty chunks cleaned by being shifted out|Occurences
RAID_CHUNKS_SHIFTED|Dirty chunks that shifted out|Occurences
RAID_COMMITTED_STRIPES|Written number of stripes|Stripes
RAID_COMPRESSED_BLOCKS_WRITTEN|Written physical blocks containing compressed data|Blocks/Sec
RAID_CORRUPTION_RECOVERY_FAILURE|Corrupt data could not be recovered|Occurences
RAID_PLACEMENT_SWITCHES|Number of placement switches|Switches
RAID_READ_BATCHES_PER_REQUEST_HISTOGRAM|Histogram of the number of batches of stripes read in a single request|Request
RAID_READ_BLOCKS_STRIPE_HISTOGRAM|Histogram of the number of blocks read from a single stripe|Reads
RAID_READ_BLOCKS|Number of blocks read by the RAID|Blocks/Sec
RAID_READ_DEGRADED|Degraded mode reads|Blocks/Sec
RAID_READ_FREE|Read Free|Occurences
RAID_READ_IOS|Raw read blocks performed by the RAID|Blocks/Sec
RAID_STALE_WRITES_DETECTED|Stale write detected in read|Occurences
RAID_STALE_WRITES_REPROTECTIONS|Stale write re-protections in read|Occurences
WRONG_DRIVE_DELTAS|Delta segments are written to the wrong drive|Blocks/Sec
WRONG_DRIVE_REFS|Reference segments are written to the wrong drive|Blocks/Sec

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
CLIENT_ROUNDTRIP_AVG_LOW|Roundtrip average of client low-priority RPC calls|Microseconds
CLIENT_ROUNDTRIP_AVG_NORM|Roundtrip average of client normal priority RPC calls|Microseconds
CLIENT_ROUNDTRIP_AVG|Roundtrip average of client regular and low priority RPC calls|Microseconds
CLIENT_RPC_CALLS_DOWNGRADED|Number of client-downgraded RPC calls|RPC/Sec
CLIENT_RPC_CALLS_LOW|Number of low-priority RPC calls|RPC/Sec
CLIENT_RPC_CALLS_NORM|Number of normal priority RPC calls|RPC/Sec
CLIENT_RPC_CALLS|Number of all priorities of RPC calls|RPC/Sec
CLIENT_SENT_REQUESTS|Number of requests sent by the client|Calls/Sec
DEUS_EX_MBUF_LIMITED|Number of RPCs slow down due to low MBuf reserves|Ops/Sec
DEUS_EX_NOT_EMPTY|Number of RPCs put in DeusEx to preserve RPC order|Ops/Sec
DEUS_EX_NO_FIBERS|Number of RPCs put in DeusEx due to lack of global fibers|Ops/Sec
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

## Reactor

**Type** | **Description** | **Units**
-|-|-
BACKGROUND_CYCLES|Number of cycles spent in background fibers|Cycles/Sec
BACKGROUND_FIBERS|Number of background fibers that are ready to run and eager to get CPU cycles|Fibers
BACKGROUND_TIME|The percentage of the CPU time used for background operations|%
BucketInvocationState_CAPACITY|Number of data structures allocated to the BucketInvocationState pool|Structs
BucketInvocationState_STRUCT_SIZE|Number of bytes in each struct of the BucketInvocationState pool|Bytes
BucketInvocationState_USED|Number of structs in the BucketInvocationState pool which are currently being used|Structs
Bucket_CAPACITY|Number of data structures allocated to the Bucket pool|Structs
Bucket_STRUCT_SIZE|Number of bytes in each struct of the Bucket pool|Bytes
Bucket_USED|Number of structs in the Bucket pool which are currently being used|Structs
CLASS_BLOB_RAID_CAPACITY|Number of data structures allocated to the CLASS_BLOB_RAID pool|Structs
CLASS_BLOB_RAID_STRUCT_SIZE|Number of bytes in each struct of the CLASS_BLOB_RAID pool|Bytes
CLASS_BLOB_RAID_USED|Number of structs in the CLASS_BLOB_RAID pool which are currently being used|Structs
CYCLES_PER_SECOND|Number of cycles the CPU runs per second|Cycles/Sec
ChainedSpan_CAPACITY|Number of data structures allocated to the ChainedSpan pool|Structs
ChainedSpan_STRUCT_SIZE|Number of bytes in each struct of the ChainedSpan pool|Bytes
ChainedSpan_USED|Number of structs in the ChainedSpan pool which are currently being used|Structs
Charter_CAPACITY|Number of data structures allocated to the Charter pool|Structs
Charter_STRUCT_SIZE|Number of bytes in each struct of the Charter pool|Bytes
Charter_USED|Number of structs in the Charter pool which are currently being used|Structs
CrossDestageDesc_CAPACITY|Number of data structures allocated to the CrossDestageDesc pool|Structs
CrossDestageDesc_STRUCT_SIZE|Number of bytes in each struct of the CrossDestageDesc pool|Bytes
CrossDestageDesc_USED|Number of structs in the CrossDestageDesc pool which are currently being used|Structs
DEFUNCT_FIBERS|Number of defunct buffers, which are just memory structures allocated for future fiber needs|Fibers
DeferredTask2_CAPACITY|Number of data structures allocated to the DeferredTask2 pool|Structs
DeferredTask2_STRUCT_SIZE|Number of bytes in each struct of the DeferredTask2 pool|Bytes
DeferredTask2_USED|Number of structs in the DeferredTask2 pool which are currently being used|Structs
EXCEPTIONS|Number of exceptions caught by the reactor|Exceptions/Sec
GenericBaseBlock_CAPACITY|Number of data structures allocated to the GenericBaseBlock pool|Structs
GenericBaseBlock_STRUCT_SIZE|Number of bytes in each struct of the GenericBaseBlock pool|Bytes
GenericBaseBlock_USED|Number of structs in the GenericBaseBlock pool which are currently being used|Structs
HOGGED_TIME|Histogram of time used by hogger fibers (only in debug builds)|Hogs
IDLE_CALLBACK_INVOCATIONS|Number of background work invocations|Invocations/Sec
IDLE_CYCLES|Number of cycles spent in idle|Cycles/Sec
IDLE_TIME|The percentage of the CPU time not used for handling I/Os|%
LINGERING_FIBERS|Number of LINGERING fibers|Fibers
NODE_CONTEXT_SWITCHES|Number of context switches.|Switches
NODE_HANG|The number of process (node) hangs per hang time range.|Number of hangs
NODE_POLL_TIME|Time of scheduler stats polling.|usecs
NODE_RUN_PERCENTAGE|Percentage of time process is running|percentage
NODE_RUN_TIME|Time process is running.|usecs
NODE_WAIT_PERCENTAGE|Percentage of time process is waiting on waitqueue|percentage
NODE_WAIT_TIME| The Time process is waiting on the wait queue.|usecs
OUTRAGEOUS_HOGGERS|Number of hoggers taking an excessive amount of time to run|Invocations
ObsBucketManagement_CAPACITY|Number of data structures allocated to the ObsBucketManagement pool|Structs
ObsBucketManagement_STRUCT_SIZE|Number of bytes in each struct of the ObsBucketManagement pool|Bytes
ObsBucketManagement_USED|Number of structs in the ObsBucketManagement pool that are currently being used|Structs
ObsGateway_CAPACITY|Number of data structures allocated to the ObsGateway pool|Structs
ObsGateway_STRUCT_SIZE|Number of bytes in each struct of the ObsGateway pool|Bytes
ObsGateway_USED|Number of structs in the ObsGateway pool which are currently being used|Structs
PENDING_FIBERS|Number of fibers pending for external events, such as a network packet or SSD response. Upon such an external event, they change state to scheduled fibers|Fibers
QueuedBlock_CAPACITY|Number of data structures allocated to the QueuedBlock pool|Structs
QueuedBlock_STRUCT_SIZE|Number of bytes in each struct of the QueuedBlock pool|Bytes
QueuedBlock_USED|Number of structs in the QueuedBlock pool which are currently being used|Structs
SCHEDULED_FIBERS|Number of current fibers that are ready to run and eager to get CPU cycles|Fibers
SLEEPY_FIBERS|Number of SLEEPY fibers|Fibers
SLEEPY_RPC_SERVER_FIBERS|Number of SLEEPY RPC server fibers|Sleepy fiber detections
SSD_CAPACITY|Number of data structures allocated to the SSD pool|Structs
SSD_STRUCT_SIZE|Number of bytes in each struct of the SSD pool|Bytes
SSD_USED|Number of structs in the SSD pool which are currently being used|Structs
STEP_CYCLES|Histogram of time spent in a fiber|Fiber steps
TIMER_CALLBACKS|Current number of timer callbacks|Callbacks
TOTAL_FIBERS_COUNT|Number of fibers|Fibers
TimedCallback_CAPACITY|Number of data structures allocated to the TimedCallback pool|Structs
TimedCallback_STRUCT_SIZE|Number of bytes in each struct of the TimedCallback pool|Bytes
TimedCallback_USED|Number of structs in the TimedCallback pool which are currently being used|Structs
UploadFileInfo_CAPACITY|Number of data structures allocated to the UploadFileInfo pool|Structs
UploadFileInfo_STRUCT_SIZE|Number of bytes in each struct of the UploadFileInfo pool|Bytes
UploadFileInfo_USED|Number of structs in the UploadFileInfo pool which are currently being used|Structs
_ReadBlocksImpl_RAID_CAPACITY|Number of data structures allocated to the _ReadBlocksImpl_RAID pool|Structs
_ReadBlocksImpl_RAID_STRUCT_SIZE|Number of bytes in each struct of the _ReadBlocksImpl_RAID pool|Bytes
_ReadBlocksImpl_RAID_USED|Number of structs in the _ReadBlocksImpl_RAID pool which are currently being used|Structs
networkBuffers_CAPACITY|Number of data structures allocated to the networkBuffers pool|Structs
networkBuffers_USED|Number of structs in the networkBuffers pool which are currently being used|Structs
rdmaNetworkBuffers_CAPACITY|Number of data structures allocated to the rdmaNetworkBuffers pool|Structs
rdmaNetworkBuffers_USED|Number of structs in the rdmaNetworkBuffers pool which are currently being used|Structs

## SSD

**Type** | **Description** | **Units**
-|-|-
CLEAN_CHUNK_SKIPPED|Number of clean chunks skips|Chunks
DRIVE_ACTIVE_IOS|The number of in-flight IO against the SSD during sampling|IOs
DRIVE_AER_RECEIVED|Number of AER reports|reports
DRIVE_COMPLETED_OVER_COUNT|Drive completed count > 1 detected|Occurrences
DRIVE_FORFEITS|Number of IOs forfeited due to lack of memory buffers|Operations/Sec
DRIVE_IDLE_CYCLES|Number of cycles spent in idle|Cycles/Sec
DRIVE_IDLE_TIME|Percentage of the CPU time not used for handling I/Os|%
DRIVE_IO_OVERLAPPED|Number of overlapping IOs|Operations
DRIVE_IO_TOO_LONG|Number of IOs that took longer than expected|Operations/Sec
DRIVE_LATENCY|Measure the latencies up to 5ms (higher latencies are grouped)|Requests
DRIVE_LOAD|Drive Load at sampling time|Load
DRIVE_MEDIA_BLOCKS_READ|Blocks read from the SSD media|Blocks/Sec
DRIVE_MEDIA_BLOCKS_WRITE|Blocks are written to the SSD media|Blocks/Sec
DRIVE_MEDIA_ERRORS|SSD Media Errors|IO/Sec
DRIVE_NON_MEDIA_ERRORS|SSD Non-Media Errors|IO/Sec
DRIVE_PENDING_IOS|The number of IOs waiting to start executing during sampling|IOs
DRIVE_PUMPED_IOS|Number of requests returned in a pump|Pumps
DRIVE_PUMPS_DELAYED|Number of Drive pumps that got delayed|Operations/Sec
DRIVE_PUMPS_SEVERELY_DELAYED|Number of Drive pumps that got severely delayed|Operations/Sec
DRIVE_PUMP_LATENCY|Latency between SSD pumps|Microseconds
DRIVE_READ_LATENCY|Drive Read Execution Latency|Microseconds
DRIVE_READ_OPS|Drive Read Operations|IO/Sec
DRIVE_READ_RATIO_PER_SSD_READ|Drive Read OPS Per SSD Request|Ratio
DRIVE_REMAINING_IOS|Number of requests still in the drive after a pump|Pumps
DRIVE_REQUEST_BLOCKS|Measure drive request size distribution|Requests
DRIVE_SSD_PUMPS|Number of drive pumps that resulted in the data flow from/to drive|Pump/Sec
DRIVE_UTILIZATION|Percentage of time the drive had an active IO submitted to it|%
DRIVE_WRITE_LATENCY|Drive Write Execution Latency|Microseconds
DRIVE_WRITE_OPS|Drive Write Operations|IO/Sec
DRIVE_WRITE_RATIO_PER_SSD_WRITE|Drive Write OPS Per SSD Request|Ratio
NVKV_CHUNK_OUT_OF_SPACE|Number of failed attempts to allocate a stripe in an NVKV chunk|Attempts/Sec
NVKV_OUT_OF_CHUNKS|Number of failed attempts to allocate an NVKV chunk|Attempts/Sec
NVKV_OUT_OF_SUPERBLOCK_ENTRIES|Number of failed attempts to allocate a superblock NVKV entry|Attempts/Sec
SSDS_IOS|IOs performed on the SSD service|IO/Sec
SSDS_IO_ERRORS|IO errors on the SSD service|Blocks/Sec
SSD_BLOCKS_READ|Number of blocks read from the SSD service|Blocks/Sec
SSD_BLOCKS_WRITTEN|Number of blocks written to the SSD service|Blocks/Sec
SSD_CHUNK_ALLOCS_TRIMMED|Number of chunk allocations from the trimmed queue|Chunks
SSD_CHUNK_ALLOCS_UNTRIMMED|Number of chunk allocations from the untrimmed queue|Chunks
SSD_CHUNK_ALLOCS|Number of chunk allocations|Chunks
SSD_CHUNK_FREES|Number of chunk frees|Chunks
SSD_CHUNK_FREE_TRIMMED|Number of free trimmed chunks|Chunks
SSD_CHUNK_FREE_UNTRIMMED|Number of free untrimmed chunks|Chunks
SSD_CHUNK_TRIMS|Number of trims performed|Chunks
SSD_E2E_BAD_CSUM|End-to-End checksum failures|IO/Sec
SSD_READ_ERRORS|Errors in reading blocks from the SSD service|Blocks/Sec
SSD_READ_LATENCY|Avg. latency of read requests from the SSD service|Microseconds
SSD_READ_REQS_LARGE_NORMAL|Number of large normal read requests from the SSD service|IO/Sec
SSD_READ_REQS|Number of read requests from the SSD service|IO/Sec
SSD_SCRATCH_BUFFERS_USED|Number of scratch blocks used|Blocks
SSD_TRIM_TIMEOUTS|Number of trim timeouts|Timeouts
SSD_WRITES_REQS_LARGE_NORMAL|Number of large normal priority write requests to the SSD service|IO/Sec
SSD_WRITES|Number of write requests to the SSD service|IO/Sec
SSD_WRITE_ERRORS|Errors in writing blocks to the SSD service|Blocks/Sec
SSD_WRITE_LATENCY|Latency of writes to the SSD service|Microseconds

## Scrubber

**Type** | **Description** | **Units**
-|-|-
BLOCK_CONSISTENCY_CHECKS|Number of blocks that were checked for consistency against their block-used-state|Blocks/Sec
BLOCK_CONSISTENCY_CHECK_LATENCY|Average latency of checking block consistency|Micros
CLEANED_CHUNKS|Number of chunks that were cleaned by the scrubber|Chunks/Sec
DEGRADED_READS|Number of degraded reads for scrubbing|Requests/Sec
FALSE_USED_CHECK_LATENCY|Average latency of checking false used per block|Micros
FALSE_USED_EXTRA_NOTIFIED|Number of blocks that were notified as used by the mark-extra-used mechanism|Blocks/Sec
INTERRUPTS|Number of scrubs that were interrupted|Occurences/Sec
NETWORK_BUDGET_WAIT_LATENCY|Average latency of waiting for our network budget|Micros
NOT_REALLY_DIRTY_BLOCKS|Number of marked dirty blocks that ScrubMissingWrites found were clean|Blocks/Sec
NUM_COPY_DISCARDED_BLOCKS|Number of copied blocks that were discarded|Blocks/Sec
NUM_COPY_DISCARDS|Number of times we discarded scrubber copy work|Occurences/Sec
NUM_INVENTED_STRIPES_DISCARDS|Number of times we discarded all scrubber work due to invented stripes|Occurences/Sec
NUM_INVENTED_STRIPES_DISCARD_BLOCKS|Number of blocks that were discarded due to invented stripes|Blocks/Sec
NUM_SCRUBBER_DISCARD_INTERMEDIATES|Number of times we discarded all intermediate scrubber work|Occurences/Sec
NUM_SMW_DISCARDED_BLOCKS|Number of SMW'd blocks that were discarded|Blocks/Sec
NUM_SMW_DISCARDS|Number of times we discarded scrubber SMW work|Occurences/Sec
PLACEMENT_SELECTION_LATENCY|Average latency of scrubbed placement selection|Micros
READS_CALLED|Number of blocks that were read|Blocks/Sec
READ_BATCH_SOURCE_BLOCKS|Number of source blocks read per batch|Batches
READ_BLOCKS_LATENCY|Average latency of read blocks|Micros
RELOCATED_BLOCKS|Number of blocks that were relocated for eviction|Blocks/Sec
RELOCATE_BLOCKS_LATENCY|Average latency of relocating blocks|Micros
RETRUSTED_UNPROTECTED_DIRTY_BLOCKS|Number of dirty blocks that ScrubMissingWrites re-trusted because they were unprotected|Blocks/Sec
REWRITTEN_DIRTY_BLOCKS|Number of dirty blocks that ScrubMissingWrites rewrote to clean them|Blocks/Sec
SCAN_LIKELY_LEAKED_BLOCKS|Number of free blocks encountered during the scan that were marked as KnownUsed in the RAID|Occurences
SCRUB_BATCHES_LATENCY|Average latency of scrub batches|Millis
SCRUB_FALSE_USED_FAILED_READS|Number of blocks that we failed to read for scrub-false-used|Blocks/Sec
SCRUB_FALSE_USED_FAILED|Number of placements we failed to fully scrub-false-used|Occurences/Sec
SCRUB_FALSE_USED_PLACEMENTS|Number of placements we finished scrub-false-used|Occurences/Sec
SCRUB_FALSE_USED_WAS_UNPROTECTED|Number of blocks that were falsely marked used and unprotected|Blocks/Sec
SCRUB_IN_FLIGHT_CORRUPTION_DETECTED|Number of in-flight corruptions detected when scrubbing|Occurences
SCRUB_PREPARATION_FAILED|Number of times we failed to prepare() a task and aborted scrub of placement|Occurences/Sec
SFU_CHECKS|Number of blocks that were scrubbed-false-used|Blocks/Sec
SFU_CHECK_FREE|Number of blocks that were detected as false-used and freed|Blocks/Sec
SFU_CHECK_SECONDARY|Number of blocks that were detected as secondary|Blocks/Sec
SFU_CHECK_USED_CKSUM_ERR|Number of blocks that were detected as used with checksum error|Blocks/Sec
SFU_CHECK_USED|Number of blocks that were detected as used|Blocks/Sec
SFU_FREE_STRIPES|Number of free stripes that were scrubbed-false-used|Stripes/Sec
SFU_FREE_STRIPE_LATENCY|Average latency of handling a read of a free stripe|Micros
SFU_USED_STRIPES|Number of used stripes that were scrubbed-false-used|Stripes/Sec
SFU_USED_STRIPE_LATENCY|Average latency of handling a read of a used stripe|Micros
SOURCE_READS|Number of source/committed superset blocks directly read by the scrubber|Blocks/Sec
STRIPE_DATA_IS_BLOCK_USED_LATENCY|Average latency of isBlockUsed during stripe verification|Micros
STRIPE_DATA_IS_BLOCK_USED|Number of isBlockUsed during stripe verification|Blocks/Sec
TARGET_COPIED_CHUNKS|Number of chunks that were copied to target by the scrubber|Chunks/Sec
UPDATE_PLACEMENT_INFO_LATENCY|Average latency of updating the placement info quorum|Micros
UPDATE_PLACEMENT_INFO|Number of times we ran updatePlacementInfo|Occurences/Sec
WONT_CLEAN_COPYING|Number of actually dirty blocks that ScrubMissingWrites refused to clean because they will be moved to target anyway|Blocks/Sec
WRITES_CALLED|Number of blocks that were written|Blocks/Sec
WRITE_BATCH_SOURCE_BLOCKS|Number of source blocks to write in batch|Batches
WRITE_BATCH_TARGET_BLOCKS|Number of target blocks to write in batch|Batches
WRITE_BLOCKS_LATENCY|Average latency of writing blocks|Micros

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
MAX_BLOCKS_WITH_TEMPORAL_SQUELCH_ITEMS_IN_BUCKET|Number of block with temporal squelch items in bucket|Blocks
MAX_TEMPORAL_SQUELCH_ITEMS_IN_BUCKET|Number temporal squelch items in bucket|Squelch items
ODL_DESQUELCHES_NUM|Number of desquelches|Times
ODL_PAYLOAD_DESQUELCHES_NUM|Number of desquelches|Times
ODL_PAYLOAD_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
ODL_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
REGISTRY_L1_DESQUELCHES_NUM|Number of desquelches|Times
REGISTRY_L1_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
REGISTRY_L2_DESQUELCHES_NUM|Number of desquelches|Times
REGISTRY_L2_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
SPATIAL_SQUELCH_DESQUELCHES_NUM|Number of desquelches|Times
SPATIAL_SQUELCH_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
SUPERBLOCK_DESQUELCHES_NUM|Number of desquelches|Times
SUPERBLOCK_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks
TEMPORAL_SQUELCH_DESQUELCHES_NUM|Number of desquelches|Times
TEMPORAL_SQUELCH_SQUELCH_BLOCKS_READ|Number of squelch blocks desquelched|Blocks

## Statistics

**Type** | **Description** | **Units**
-|-|-
GATHER_FROM_NODE_LATENCY_NET|Time spent on responding to a stats-gathering request (not including metadata)|Seconds/Sec
GATHER_FROM_NODE_LATENCY|Time spent responding to a stats-gathering request (not including metadata)|Seconds/Sec
GATHER_FROM_NODE_SLEEP|Time spent in-between responding to a stats-gathering request (not including metadata)|Seconds/Sec
TIMES_QUERIED_STATS|Number of times the process queried other processes for stats|Times
TIMES_QUERIED|Number of times the process was queried for stats (not including metadata)|Times