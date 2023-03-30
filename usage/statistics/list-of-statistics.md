---
description: >-
  This page lists all the statistics the WEKA system generates according to
  their category.
---

# List of statistics

## Attribute Cache

| **Type**                 | **Description**                                           | **Units** |
| ------------------------ | --------------------------------------------------------- | --------- |
| GP\_GETATTR\_CACHE\_MISS | Number of general purpose getAttr cache misses per second | Ops/Sec   |
| GP\_GETATTR              | Number of general purpose getAttr calls per second        | Ops/Sec   |

## Block Cache

| **Type**                             | **Description**                            | **Units** |
| ------------------------------------ | ------------------------------------------ | --------- |
| BUCKET\_CACHED\_METADATA\_BLOCKS     | Bucket number of cached metadata blocks    | Blocks    |
| BUCKET\_CACHED\_REGISTRY\_L2\_BLOCKS | Bucket number of cached registry L2 blocks | Blocks    |
| BUCKET\_CACHE\_METADATA\_HITS        | Bucket block cache metadata hits           | Queries   |
| BUCKET\_CACHE\_METADATA\_MISSES      | Bucket block cache metadata misses         | Queries   |
| BUCKET\_CACHE\_REGISTRY\_L2\_HITS    | Bucket block cache registry L2 hits        | Queries   |
| BUCKET\_CACHE\_REGISTRY\_L2\_MISSES  | Bucket block cache registry L2 misses      | Queries   |
| BUCKET\_REGISTRY\_L2\_BLOCKS\_NUM    | Bucket number of registry L2 blocks        | Blocks    |

## Block Writes

| **Type**               | **Description**      | **Units** |
| ---------------------- | -------------------- | --------- |
| BLOCK\_FULL\_WRITES    | Full block writes    | Writes    |
| BLOCK\_PARTIAL\_WRITES | Partial block writes | Writes    |

## Bucket

| **Type**                         | **Description**                                                         | **Units**    |
| -------------------------------- | ----------------------------------------------------------------------- | ------------ |
| BUCKET\_START\_TIME              | Startups                                                                |              |
| BUDGET\_UNDERFLOW\_BLOCKS        | Blocks/Sec                                                              |              |
| CHOKING\_LEVEL\_ALL              | Throttling level applied on all types of IOs                            | %            |
| CHOKING\_LEVEL\_NON\_MUTATING    | Throttling level applied on non-mutating only types of IOs              | %            |
| DESTAGED\_BLOCKS\_COUNT          | Blocks/Sec                                                              |              |
| DESTAGE\_COUNT                   | Destages/Sec                                                            |              |
| DIR\_MOVE\_TIME                  | Ops                                                                     |              |
| EXTENT\_BLOCKS\_COUNT            | Blocks                                                                  |              |
| FREEABLE\_LRU\_BUFFERS           | Buffers                                                                 |              |
| HASH\_BLOCKS\_COUNT              | Blocks                                                                  |              |
| INODE\_BLOCKS\_COUNT             | Blocks                                                                  |              |
| INODE\_REFRESHER\_QUEUE\_LENGTH  | Items                                                                   |              |
| JOURNAL\_BLOCKS\_COUNT           | Blocks                                                                  |              |
| JOURNAL\_ITERATIONS              | Histogram of number of batches of stripes committed in a single request |              |
| READS                            | Number of read operations per second                                    | Ops/Sec      |
| READ\_BYTES                      | Number of bytes read per second                                         | Bytes/Sec    |
| READ\_LATENCY                    | Average latency of READ operations                                      | Microseconds |
| REGISTRY\_L1\_BLOCKS\_COUNT      | Blocks                                                                  |              |
| REGISTRY\_L2\_BLOCKS\_COUNT      | Blocks                                                                  |              |
| REGISTRY\_SEARCHES\_COUNT        | Queries/Sec                                                             |              |
| RESIDENT\_BLOCKS\_COUNT          | Blocks/Sec                                                              |              |
| SNAPSHOT\_CREATION\_TIME         | Snaps                                                                   |              |
| SPATIAL\_SQUELCH\_BLOCKS\_COUNT  | Blocks                                                                  |              |
| SUCCESSFUL\_DATA\_WEDGINGS       | Attempts/Sec                                                            |              |
| SUPERBLOCK\_BLOCKS\_COUNT        | Blocks                                                                  |              |
| TAKEOVERS\_SUCCESSFUL            | Takeover Attempts/Sec                                                   |              |
| TAKEOVER\_ATTEMPTS               | Takeover Attempts/Sec                                                   |              |
| TEMPORAL\_SQUELCH\_BLOCKS\_COUNT | Blocks                                                                  |              |
| UNSUCCESSFUL\_DATA\_WEDGINGS     | Attempts/Sec                                                            |              |
| USER\_DATA\_BUFFERS\_IN\_USE     | Buffers                                                                 |              |
| WRITES                           | Number of write operations per second                                   | Ops/Sec      |
| WRITE\_BYTES                     | Number of byte writes per second                                        | Bytes/Sec    |
| WRITE\_LATENCY                   | Average latency of WRITE operations                                     | Microseconds |

## Bucket Failovers

| **Type**                      | **Description**                                                                 | **Units**  |
| ----------------------------- | ------------------------------------------------------------------------------- | ---------- |
| BUCKET\_FAILOVERS             | Amount of times swapping from a remote primary node to a secondary              | Failovers  |
| INVALID\_BUCKET\_TERM         | Number of times a remote bucket rejected a request because the term was invalid | Exceptions |
| REMOTE\_BUCKET\_IS\_SECONDARY | Number of times a remote bucket reported it is secondary and cannot serve us    | Exceptions |

## Bucket Rebalances

| **Type**                    | **Description**                          | **Units** |
| --------------------------- | ---------------------------------------- | --------- |
| BUCKET\_INITS               | Number of bucket initializations         | Times     |
| BUCKET\_INIT\_LATENCY\_HIST | Milliseconds                             |           |
| BUCKET\_INIT\_LATENCY       | Average latency of bucket initialization | Seconds   |

## CPU

| **Type**         | **Description**                                       | **Units** |
| ---------------- | ----------------------------------------------------- | --------- |
| CPU\_UTILIZATION | Percentage of the CPU time utilized for handling I/Os | %         |

## Choking

| **Type**                      | **Description**                                                              | **Units** |
| ----------------------------- | ---------------------------------------------------------------------------- | --------- |
| CHOKING\_LEVEL\_ALL           | Throttling level applied on all types of IOs, both mutating and non-mutating |           |
| CHOKING\_LEVEL\_NON\_MUTATING | Throttling level applied on non-mutating only types of IOs                   |           |

## Clients

| **Type**              | **Description**                                          | **Units**   |
| --------------------- | -------------------------------------------------------- | ----------- |
| CLIENTS\_CONNECTED    | Clients connected                                        | Clients/Sec |
| CLIENTS\_DISCONNECTED | Clients left or were removed                             | Clients/Sec |
| CLIENTS\_LEFT         | Clients left                                             | Clients/Sec |
| CLIENTS\_RECONNECTED  | Clients reconnected instead of an old instance of theirs | Clients/Sec |
| CLIENTS\_REMOVED      | Clients removed                                          | Clients/Sec |

## Config

| **Type**                                 | **Description**                                   | **Units**    |
| ---------------------------------------- | ------------------------------------------------- | ------------ |
| AVERAGE\_CHANGES\_IN\_CHANGESET          | Average changes in the change set                 | Changes/Sec  |
| AVERAGE\_CHANGES\_IN\_GENERATION         | Average changes in generation                     | Changes/Sec  |
| BACKEND\_NODE\_REJOIN\_TIME              | Milliseconds                                      |              |
| CHANGESET\_COMMIT\_LATENCY               | Average latency of committing a config change set | Microseconds |
| CLIENT\_NODE\_REJOIN\_TIME               | Milliseconds                                      |              |
| GENERATION\_COMMIT\_LATENCY              | Average latency of committing a config generation | Microseconds |
| HEARTBEAT\_PROCESSING\_TIME\_OLD         | Seconds                                           |              |
| HEARTBEAT\_PROCESSING\_TIME              | Seconds                                           |              |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME\_OLD | Seconds                                           |              |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME      | Seconds                                           |              |
| OVERLAY\_FULL\_SHIFTS                    | Number of full overlay shifts                     | Changes      |
| OVERLAY\_INCREMENTAL\_SHIFTS             | Number of incremental overlay shifts              | Changes      |
| OVERLAY\_TRACKER\_INCREMENTALS           | Number of incremental OverlayTracker applications | Changes      |
| OVERLAY\_TRACKER\_RESYNCS                | Number of OverlayTracker full-resyncs             | Changes      |
| TOTAL\_CHANGESETS\_COMMITTED             | Total number of change sets committed             | Change Sets  |
| TOTAL\_COMMITTED\_CHANGES                | Total number of config changes committed          | Changes      |
| TOTAL\_GENERATIONS\_COMMITTED            | Number of generations committed per second        | Generations  |

## Filesystem OBS

| **Type**                                          | **Description**                                                          | **Units**          |
| ------------------------------------------------- | ------------------------------------------------------------------------ | ------------------ |
| BACKPRESSURED\_BUCKETS\_IN\_FSS                   | Number of backpressured buckets                                          | Buckets            |
| CONCURRENT\_DEMOTES                               | How many demotes are executed concurrently                               | Demotes            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_BACKPRESSURE          | Number of extent BACKPRESSURE fetch operations per second                | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_IMMEDIATE\_RELEASE    | Number of extent IMMEDIATE\_RELEASE fetch operations per second          | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_MANHOLE               | Number of extent MANHOLE fetch operations per second                     | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_MIGRATE               | Number of extent MIGRATE fetch operations per second                     | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_POLICY                | Number of extent POLICY fetch operations per second                      | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_RECLAMATION\_REUPLOAD | Number of extent RECLAMATION\_REUPLOAD fetch operations per second       | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_STOW                  | Number of extent STOW fetch operations per second                        | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH                        | Number of extent fetch operations per second                             | Ops/Sec            |
| DEMOTE\_WAITING\_FOR\_SLOT                        | Average time waiting for a demotion concurrency slot                     | Microseconds       |
| DESERIALIZED\_EXTENTS\_WITH\_INVALID\_BLOBS       | Number of deserialized extents with invalid blob id                      | Extents            |
| DOWNLOADS                                         | Number of promotes operations per second                                 | Ops/Sec            |
| DOWNLOAD\_LATENCY                                 | Latency of promote operations                                            | Microseconds       |
| EXTENTS\_WITH\_FAKE\_RETENTION\_TAG               | Number of scanned extents with fake retention tag                        | Extents            |
| FAILED\_DOWNLOADS                                 | Number of failed promotes operations per second                          | Ops/Sec            |
| FAILED\_UPLOADS                                   | Number of failed demotes operations per second                           | Ops/Sec            |
| OBS\_4K\_IOPS\_READ                               | Number of object store dedicated 4K read operations per second           | Ops/Sec            |
| OBS\_BACKPRESSURE\_FREED                          | Number of bytes freed from disk due to backpressure                      | Bytes/Sec          |
| OBS\_BLOB\_HEADER\_DOWNLOAD\_LATENCY              | Average latency of blob header download                                  | Microseconds       |
| OBS\_BLOB\_SCAVENGE\_LATENCY                      | Average latency of blob scavenges                                        | Microseconds       |
| OBS\_BLOB\_TIERING\_DURATION                      | Milliseconds                                                             |                    |
| OBS\_COMPLETELY\_ALIVE\_BLOBS                     | Percentage of blobs with only live extents linked to them                | %                  |
| OBS\_COMPLETELY\_DEAD\_BLOBS                      | Percentage of blobs with no live extent linked to them                   | %                  |
| OBS\_EXTENTS\_PREFETCH                            | Number of pre-fetched extents                                            | Ops/Sec            |
| OBS\_FREED                                        | Number of bytes freed from disk because they are in the OBS              | Bytes/Sec          |
| OBS\_IMMEDIATE\_RELEASE\_FREED                    | Number of bytes freed from disk due to immediate release                 | Bytes/Sec          |
| OBS\_INODES\_PREFETCH                             | Number of pre-fetched inodes                                             | Ops/Sec            |
| OBS\_INODES\_RELEASE                              | Number of pre-fetched inodes                                             | Ops/Sec            |
| OBS\_ONGOING\_RECLAMATIONS                        | Number of ongoing reclamations                                           | Ops                |
| OBS\_POLICY\_FREED                                | Number of bytes freed from disk due to policy                            | Bytes/Sec          |
| OBS\_PROMOTE\_EXTENT\_WRITE\_LATENCY              | Microseconds                                                             |                    |
| OBS\_PROMOTE\_EXTENT\_WRITE                       | Ops/Sec                                                                  |                    |
| OBS\_PROMOTE\_WRITE                               | Bytes/Sec                                                                |                    |
| OBS\_READ                                         | Reads that needed data from the OBS                                      | Ops/Sec            |
| OBS\_RECLAMATION\_PURGED\_BYTES                   | Number of bytes purged per second                                        | Bytes/Sec          |
| OBS\_RECLAMATION\_SCAVENGED\_BLOBS                | Number of blobs scavenged per second                                     | Ops/Sec            |
| OBS\_RECLAMATION\_SCAVENGED\_BYTES                | Number of bytes scavenged per second                                     | Bytes/Sec          |
| OBS\_RECLAMATION\_WAIT\_FOR\_DESTAGE              | Average time waiting for destage on space reclamation                    | Microseconds       |
| OBS\_RELOC\_DOWNLOAD                              | Number of relocation blobs downloaded per second                         | Ops/Sec            |
| OBS\_RELOC\_UPLOAD                                | Number of relocation blobs uploaded per second                           | Ops/Sec            |
| OBS\_SCAVENGED\_BLOB\_WASTE\_LEVEL                | Histogram of waste level found in blobs                                  |                    |
| OBS\_SHARED\_DOWNLOADS\_LATENCY                   | Microseconds                                                             |                    |
| OBS\_SHARED\_DOWNLOADS                            | Ops/Sec                                                                  |                    |
| OBS\_TRUNCATE                                     | Truncates that needed data from the OBS                                  | Ops/Sec            |
| OBS\_UNEXPECTED\_TAG\_ON\_DOWNLOAD                | Unexpected tag when downloading an extent                                | Occurences         |
| OBS\_WRITE                                        | Writes that needed data from the OBS                                     | Ops/Sec            |
| STOW\_SERIALIZED\_EXTENT\_DATA                    | Number of extent descriptors uploaded that contain data                  | Extent descriptors |
| STOW\_SERIALIZED\_EXTENT\_DESCS                   | Number of extent descriptors uploaded                                    | Extent descriptors |
| STOW\_SERIALIZED\_EXTENT\_REDIRECTS               | Number of extent descriptors uploaded that redirect to previous snapshot | Extent descriptors |
| TIERED\_FS\_BREAKING\_POLICY                      | Tiered Filesystem Breaking Policy Counter                                | Activations        |
| TIMEOUT\_DOWNLOADS                                | Number of timeout'ed promotes operations per second                      | Ops/Sec            |
| TIMEOUT\_OPERATIONS                               | Total timeouted operations per second                                    | Ops/Sec            |
| TIMEOUT\_UPLOADS                                  | Number of timeout'ed demotes operations per second                       | Ops/Sec            |
| UNEXPECTED\_BLOCK\_VERSION\_POST\_UPGRADE         | Unexpected block version after upgrade completed                         | Occurences         |
| UNEXPECTED\_HASHBLOCK\_KV\_VERSION\_POST\_UPGRADE | Unexpected hash block KV version after upgrade completed                 | Occurences         |
| UPLOADS                                           | Number of upload attempts per second                                     | Ops/Sec            |
| UPLOAD\_CHOKING\_LATENCY                          | Average latency of waiting for demote choking budget                     | Microseconds       |
| UPLOAD\_LATENCY                                   | Latency of demote                                                        | Microseconds       |

## Frontend

| **Type**         | **Description**                                                       | **Units** |
| ---------------- | --------------------------------------------------------------------- | --------- |
| FE\_IDLE\_CYCLES | Cycles/Sec                                                            |           |
| FE\_IDLE\_TIME   | Percentage of the CPU time not utilized for handling I/Os on frontend | %         |

## Frontend Encryption

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

## Garbage Collection

| **Type**                     | **Description**                     | **Units** |
| ---------------------------- | ----------------------------------- | --------- |
| GC\_FREE\_SIZE\_AFTER\_SCAN  | GC pool size after the scan ends    | Bytes     |
| GC\_FREE\_SIZE\_BEFORE\_SCAN | GC pool size before the scan starts | Bytes     |
| GC\_SCAN\_TIME               | GC scan time                        | Msec      |
| GC\_USED\_SIZE\_AFTER\_SCAN  | GC used size after the scan ends    | Bytes     |
| GC\_USED\_SIZE\_BEFORE\_SCAN | GC used size before the scan starts | Bytes     |

## JRPC

| **Type**                       | **Description** | **Units** |
| ------------------------------ | --------------- | --------- |
| JRPC\_SERVER\_PROCESSING\_AVG  | Microseconds    |           |
| JRPC\_SERVER\_PROCESSING\_TIME |                 |           |

## Journal

| **Type**              | **Description**                     | **Units**           |
| --------------------- | ----------------------------------- | ------------------- |
| JOURNAL\_CURRENT\_OPS | Operations currently in journal     | Journal Entries     |
| JOURNAL\_OPS\_IN      | Operations added to the journal     | Journal Entries/Sec |
| JOURNAL\_OPS\_OUT     | Operations removed from the journal | Journal Entries/Sec |

## Memory

| **Type**     | **Description** | **Units** |
| ------------ | --------------- | --------- |
| RSS\_CURRENT | MB              |           |
| RSS\_PEAK    | MB              |           |

## Network

| **Type**                             | **Description**                                                                                                     | **Units**      |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------- | -------------- |
| BAD\_RECV\_CSUM                      | Number of packets received with a bad checksum                                                                      | Packets/Sec    |
| CORRUPT\_PACKETS                     | Number of packets received and deemed corrupted                                                                     | Packets/Sec    |
| DOUBLY\_RECEIVED\_PACKETS            | Number of packets that were received multiple times                                                                 | Packets/Sec    |
| DROPPED\_LARGE\_PACKETS              | Number of large packets dropped in the socket backend                                                               | Packets/Sec    |
| DROPPED\_PACKETS                     | Number of packets received that we dropped                                                                          | Packets/Sec    |
| ECN\_ENCOUNTERED                     | Number of ECN Encountered packets                                                                                   | Packets/Sec    |
| FAULT\_RECV\_DELAYED\_PACKETS        | Number of received packets delayed due to a fault injection                                                         | Packets/Sec    |
| FAULT\_RECV\_DROPPED\_PACKETS        | Number of received packets dropped due to a fault injection                                                         | Packets/Sec    |
| FAULT\_SENT\_DELAYED\_PACKETS        | Number of sent packets delayed due to a fault injection                                                             | Packets/Sec    |
| FAULT\_SENT\_DROPPED\_PACKETS        | Number of sent packets dropped due to a fault injection                                                             | Packets/Sec    |
| GOODPUT\_RX\_RATIO                   | Percentage of goodput RX packets out of total data packets received                                                 | %              |
| GOODPUT\_TX\_RATIO                   | Percentage of goodput TX packets out of total data packets sent                                                     | %              |
| GW\_MAC\_RESOLVE\_FAILURES           | Number of times we failed to ARP resolve the gateway IP                                                             | Failures       |
| GW\_MAC\_RESOLVE\_SUCCESSES          | Number of times we succeeded to ARP resolve the gateway IP                                                          | Successes      |
| INVALID\_FIRST\_FRAGMENT             | Number of times we got an invalid first fragment                                                                    | Packets/Sec    |
| NODE\_RECONNECTED                    | Number of reconnections                                                                                             | Reconnects/Sec |
| PACKETS\_PUMPED                      | Number of packets received in each call to recvPackets                                                              |                |
| PEER\_RTT                            | RTT per peer node                                                                                                   | Microseconds   |
| PORT\_RX\_BYTES                      | Number of bytes received                                                                                            | Bytes/Sec      |
| PORT\_RX\_PACKETS                    | Number of packets received                                                                                          | Packets/Sec    |
| PORT\_TX\_BYTES                      | Number of bytes transmitted                                                                                         | Bytes/Sec      |
| PORT\_TX\_PACKETS                    | Number of packets transmitted                                                                                       | Packets/Sec    |
| PUMPS\_TXQ\_FULL                     | Number of times we couldn't send any new packets to the NIC queue                                                   | Pumps/Sec      |
| PUMPS\_TXQ\_PARTIAL                  | Number of times we only sent some of our queued packets to the NIC queue                                            | Pumps/Sec      |
| PUMP\_DURATION                       | Duration of each pump                                                                                               |                |
| PUMP\_INTERVAL                       | Interval between pumps                                                                                              |                |
| RDMA\_ADD\_CHUNK\_FAILURES           | Failures/Sec                                                                                                        |                |
| RDMA\_BINDING\_FAILOVERS             | Fail-overs/Sec                                                                                                      |                |
| RDMA\_CANCELED\_COMPLETIONS          | Completions/Sec                                                                                                     |                |
| RDMA\_CLIENT\_BINDING\_INVALIDATIONS | Invalidations/Sec                                                                                                   |                |
| RDMA\_COMPLETIONS                    | Completions/Sec                                                                                                     |                |
| RDMA\_COMP\_DURATION                 |                                                                                                                     |                |
| RDMA\_COMP\_FAILURES                 | Failures/Sec                                                                                                        |                |
| RDMA\_COMP\_LATENCY                  | Average time of RDMA requests completion                                                                            | Microseconds   |
| RDMA\_COMP\_STATUSES                 | Completions/Sec                                                                                                     |                |
| RDMA\_NET\_ERR\_RETRY\_EXCEEDED      | Occurences/Sec                                                                                                      |                |
| RDMA\_POOL\_ALLOC\_FAILED            | Failures/Sec                                                                                                        |                |
| RDMA\_POOL\_LOW\_CAPACITY            | Failures/Sec                                                                                                        |                |
| RDMA\_PORT\_WAITING\_FIBERS          | Waiting fibers                                                                                                      |                |
| RDMA\_REQUESTS                       | Requests/Sec                                                                                                        |                |
| RDMA\_RX\_BYTES                      | Bytes/Sec                                                                                                           |                |
| RDMA\_SERVER\_BINDING\_RESTARTS      | Restarts/Sec                                                                                                        |                |
| RDMA\_SERVER\_RECV\_FAILURES         | Failures/Sec                                                                                                        |                |
| RDMA\_SERVER\_SEND\_FAILURES         | Failures/Sec                                                                                                        |                |
| RDMA\_SUBMIT\_FAILURES               | Failures/Sec                                                                                                        |                |
| RDMA\_SUBMIT\_TIMEOUTS               | Timeouts/Sec                                                                                                        |                |
| RDMA\_TX\_BYTES                      | Bytes/Sec                                                                                                           |                |
| RECEIVED\_CONTROL\_PACKETS           | Number of received control packets                                                                                  | Packets/Sec    |
| RECEIVED\_DATA\_PACKETS              | Number of received data packets                                                                                     | Packets/Sec    |
| RECEIVED\_PACKETS                    | Number of packets received                                                                                          | Packets/Sec    |
| RECEIVED\_PACKET\_GENERATIONS        | The generation ("resend count") of the first incarnation of the packet seen by the receiver (indicates packet loss) |                |
| REORDERED\_PACKETS                   | Number of reordered packets                                                                                         | Packets/Sec    |
| RESEND\_BATCH\_SIZE                  | Number of packets sent in a resend batch                                                                            |                |
| RESENT\_DATA\_PACKETS                | Number of data packets resent                                                                                       | Packets/Sec    |
| SEND\_BATCH\_SIZE\_BYTES             | Number of bytes sent in a first send batch                                                                          |                |
| SEND\_BATCH\_SIZE                    | Number of packets sent in a first send batch                                                                        |                |
| SEND\_QUEUE\_TIMEOUTS                | Number of packets cancelled due to envelope timeout and were not in the send window                                 | Packets/Sec    |
| SEND\_WINDOW\_TIMEOUTS               | Number of packets cancelled due to envelope timeout while in the send window                                        | Packets/Sec    |
| SENT\_ACKS                           | Number of ACK packets sent                                                                                          | Packets/Sec    |
| SENT\_CONTROL\_PACKETS               | Number of control packets sent                                                                                      | Packets/Sec    |
| SENT\_DATA\_PACKETS                  | Number of data packets sent                                                                                         | Packets/Sec    |
| SENT\_PACKETS                        | Number of sent packets                                                                                              | Packets/Sec    |
| SENT\_REJECTS                        | Number of rejects sent                                                                                              | Packets/Sec    |
| SHORT\_CIRCUIT\_SENDS                | Number of packets sent to the same node                                                                             | Packets/Sec    |
| SLOW\_PATH\_CSUM                     | Number of packets that went through checksum calculation on the CPU                                                 | Packets/Sec    |
| TIMELY\_RESENDS                      | Number of packets resent due to timely resend                                                                       | Packets/Sec    |
| TIME\_TO\_ACK                        | Histogram of time to ack a data packet                                                                              |                |
| TIME\_TO\_FIRST\_SEND                | Time from queueing to first send                                                                                    |                |
| UCX\_SEND\_CB                        | Packets/Sec                                                                                                         |                |
| UCX\_SEND\_ERROR                     | Packets/Sec                                                                                                         |                |
| UCX\_SENT\_PACKETS\_ASYNC            | Packets/Sec                                                                                                         |                |
| UCX\_SENT\_PACKETS\_IMMEDIATE        | Packets/Sec                                                                                                         |                |
| UCX\_TXQ\_FULL                       | Packets/Sec                                                                                                         |                |
| UDP\_SENDMSG\_FAILED\_EAGAIN         | Number of packets that failed to be sent on the socket backend with EAGAIN                                          | Packets/Sec    |
| UDP\_SENDMSG\_FAILED\_OTHER          | Number of packets that failed to be sent on the socket backend with an unknown error                                | Packets/Sec    |
| UDP\_SENDMSG\_PARTIAL\_SEND          | Number of packets that we failed to send but in the same pump some packets were sent                                | Packets/Sec    |
| UNACKED\_RESENDS                     | Number of packets resent after receiving an ack                                                                     | Packets/Sec    |
| ZERO\_CSUM                           | Number of checksum zero received                                                                                    | Packets/Sec    |

## Object Storage

| **Type**                                             | **Description**                                                         | **Units**     |
| ---------------------------------------------------- | ----------------------------------------------------------------------- | ------------- |
| FAILED\_OBJECT\_DELETES                              | Number of failed object deletes per second (any failure reason)         | Ops/Sec       |
| FAILED\_OBJECT\_DOWNLOADS                            | Number of failed object download per second (any failure reason)        | Ops/Sec       |
| FAILED\_OBJECT\_HEAD\_QUERIES                        | Number of failed object head queries per second (any failure reason)    | Ops/Sec       |
| FAILED\_OBJECT\_OPERATIONS                           | Total failed operations per second                                      | Ops/Sec       |
| FAILED\_OBJECT\_UPLOADS                              | Number of failed object uploads per second (any failure reason)         | Ops/Sec       |
| OBJECT\_DELETES                                      | Number of object deletes per second                                     | Ops/Sec       |
| OBJECT\_DELETE\_DURATION                             | Milliseconds                                                            |               |
| OBJECT\_DELETE\_LATENCY                              | Latency of deleting an object                                           | Microseconds  |
| OBJECT\_DOWNLOADS\_BACKGROUND                        | Number of BACKGROUND objects downloaded per second                      | Ops/Sec       |
| OBJECT\_DOWNLOADS\_FOREGROUND                        | Number of FOREGROUND objects downloaded per second                      | Ops/Sec       |
| OBJECT\_DOWNLOADS                                    | Number of objects downloaded per second                                 | Ops/Sec       |
| OBJECT\_DOWNLOAD\_BYTES\_BACKGROUND                  | Number of BACKGROUND bytes sent to object storage                       | Bytes/Sec     |
| OBJECT\_DOWNLOAD\_BYTES\_FOREGROUND                  | Number of FOREGROUND bytes sent to object storage                       | Bytes/Sec     |
| OBJECT\_DOWNLOAD\_DURATION                           | Milliseconds                                                            |               |
| OBJECT\_DOWNLOAD\_LATENCY                            | Latency of downloading an object                                        | Microseconds  |
| OBJECT\_DOWNLOAD\_SIZE                               | Bytes                                                                   |               |
| OBJECT\_HEAD\_DURATION                               | Milliseconds                                                            |               |
| OBJECT\_HEAD\_LATENCY                                | Latency of deleting an object                                           | Microseconds  |
| OBJECT\_HEAD\_QUERIES                                | Number of object head queries per second                                | Ops/Sec       |
| OBJECT\_OPERATIONS                                   | Total operations per second                                             | Ops/Sec       |
| OBJECT\_UPLOADS\_BACKPRESSURE                        | Number of BACKPRESSURE upload attempts per second                       | Ops/Sec       |
| OBJECT\_UPLOADS\_IMMEDIATE\_RELEASE                  | Number of IMMEDIATE\_RELEASE upload attempts per second                 | Ops/Sec       |
| OBJECT\_UPLOADS\_MANHOLE                             | Number of MANHOLE upload attempts per second                            | Ops/Sec       |
| OBJECT\_UPLOADS\_MIGRATE                             | Number of MIGRATE upload attempts per second                            | Ops/Sec       |
| OBJECT\_UPLOADS\_POLICY                              | Number of POLICY upload attempts per second                             | Ops/Sec       |
| OBJECT\_UPLOADS\_RECLAMATION\_REUPLOAD               | Number of RECLAMATION\_REUPLOAD upload attempts per second              | Ops/Sec       |
| OBJECT\_UPLOADS\_STOW                                | Number of STOW upload attempts per second                               | Ops/Sec       |
| OBJECT\_UPLOADS                                      | Number of object uploads per second                                     | Ops/Sec       |
| OBJECT\_UPLOAD\_BYTES\_BACKPRESSURE                  | Number of BACKPRESSURE bytes sent to object storage                     | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_IMMEDIATE\_RELEASE            | Number of IMMEDIATE\_RELEASE bytes sent to object storage               | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_MANHOLE                       | Number of MANHOLE bytes sent to object storage                          | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_MIGRATE                       | Number of MIGRATE bytes sent to object storage                          | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_POLICY                        | Number of POLICY bytes sent to object storage                           | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_RECLAMATION\_REUPLOAD         | Number of RECLAMATION\_REUPLOAD bytes sent to object storage            | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_STOW                          | Number of STOW bytes sent to object storage                             | Bytes/Sec     |
| OBJECT\_UPLOAD\_DURATION                             | Milliseconds                                                            |               |
| OBJECT\_UPLOAD\_LATENCY                              | Latency of uploading an object                                          | Microseconds  |
| OBJECT\_UPLOAD\_SIZE                                 | Bytes                                                                   |               |
| OBS\_READ\_BYTES                                     | Number of bytes read from object storage                                | Bytes/Sec     |
| OBS\_WRITE\_BYTES                                    | Number of bytes sent to object storage                                  | Bytes/Sec     |
| ONGOING\_DOWNLOADS                                   | Number of ongoing downloads                                             | Ops           |
| ONGOING\_REMOVES                                     | Number of ongoing removes                                               | Ops           |
| ONGOING\_UPLOADS                                     | Number of ongoing uploads                                               | Ops           |
| READ\_BYTES                                          | Number of bytes read from object storage                                | Bytes/Sec     |
| REQUEST\_COUNT\_DELETE                               | Number of HTTP DELETE requests per second                               | Requests/Sec  |
| REQUEST\_COUNT\_GET                                  | Number of HTTP GET requests per second                                  | Requests/Sec  |
| REQUEST\_COUNT\_HEAD                                 | Number of HTTP HEAD requests per second                                 | Requests/Sec  |
| REQUEST\_COUNT\_INVALID                              | Number of HTTP INVALID requests per second                              | Requests/Sec  |
| REQUEST\_COUNT\_POST                                 | Number of HTTP POST requests per second                                 | Requests/Sec  |
| REQUEST\_COUNT\_PUT                                  | Number of HTTP PUT requests per second                                  | Requests/Sec  |
| RESPONSE\_COUNT\_ACCEPTED                            | Number of HTTP ACCEPTED responses per second                            | Responses/Sec |
| RESPONSE\_COUNT\_BAD\_GATEWAY                        | Number of HTTP BAD\_GATEWAY responses per second                        | Responses/Sec |
| RESPONSE\_COUNT\_BAD\_REQUEST                        | Number of HTTP BAD\_REQUEST responses per second                        | Responses/Sec |
| RESPONSE\_COUNT\_CONFLICT                            | Number of HTTP CONFLICT responses per second                            | Responses/Sec |
| RESPONSE\_COUNT\_CONTINUE                            | Number of HTTP CONTINUE responses per second                            | Responses/Sec |
| RESPONSE\_COUNT\_CREATED                             | Number of HTTP CREATED responses per second                             | Responses/Sec |
| RESPONSE\_COUNT\_EXPECTATION\_FAILED                 | Number of HTTP EXPECTATION\_FAILED responses per second                 | Responses/Sec |
| RESPONSE\_COUNT\_FORBIDDEN                           | Number of HTTP FORBIDDEN responses per second                           | Responses/Sec |
| RESPONSE\_COUNT\_FOUND                               | Number of HTTP FOUND responses per second                               | Responses/Sec |
| RESPONSE\_COUNT\_GATEWAY\_TIMEOUT                    | Number of HTTP GATEWAY\_TIMEOUT responses per second                    | Responses/Sec |
| RESPONSE\_COUNT\_GONE                                | Number of HTTP GONE responses per second                                | Responses/Sec |
| RESPONSE\_COUNT\_HTTP\_VERSION\_NOT\_SUPPORTED       | Number of HTTP HTTP\_VERSION\_NOT\_SUPPORTED responses per second       | Responses/Sec |
| RESPONSE\_COUNT\_INSUFFICIENT\_STORAGE               | Number of HTTP INSUFFICIENT\_STORAGE responses per second               | Responses/Sec |
| RESPONSE\_COUNT\_INVALID                             | Number of HTTP INVALID responses per second                             | Responses/Sec |
| RESPONSE\_COUNT\_LENGTH\_REQUIRED                    | Number of HTTP LENGTH\_REQUIRED responses per second                    | Responses/Sec |
| RESPONSE\_COUNT\_METHOD\_NOT\_ALLOWED                | Number of HTTP METHOD\_NOT\_ALLOWED responses per second                | Responses/Sec |
| RESPONSE\_COUNT\_MOVED\_PERMANENTLY                  | Number of HTTP MOVED\_PERMANENTLY responses per second                  | Responses/Sec |
| RESPONSE\_COUNT\_NON\_AUTH\_INFO                     | Number of HTTP NON\_AUTH\_INFO responses per second                     | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_ACCEPTABLE                     | Number of HTTP NOT\_ACCEPTABLE responses per second                     | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_FOUND                          | Number of HTTP NOT\_FOUND responses per second                          | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_IMPLEMENTED                    | Number of HTTP NOT\_IMPLEMENTED responses per second                    | Responses/Sec |
| RESPONSE\_COUNT\_NOT\_MODIFIED                       | Number of HTTP NOT\_MODIFIED responses per second                       | Responses/Sec |
| RESPONSE\_COUNT\_NO\_CONTENT                         | Number of HTTP NO\_CONTENT responses per second                         | Responses/Sec |
| RESPONSE\_COUNT\_OK                                  | Number of HTTP OK responses per second                                  | Responses/Sec |
| RESPONSE\_COUNT\_PARTIAL\_CONTENT                    | Number of HTTP PARTIAL\_CONTENT responses per second                    | Responses/Sec |
| RESPONSE\_COUNT\_PAYMENT\_REQUIRED                   | Number of HTTP PAYMENT\_REQUIRED responses per second                   | Responses/Sec |
| RESPONSE\_COUNT\_PRECONDITION\_FAILED                | Number of HTTP PRECONDITION\_FAILED responses per second                | Responses/Sec |
| RESPONSE\_COUNT\_PROXY\_AUTH\_REQUIRED               | Number of HTTP PROXY\_AUTH\_REQUIRED responses per second               | Responses/Sec |
| RESPONSE\_COUNT\_REDIRECT\_MULTIPLE\_CHOICES         | Number of HTTP REDIRECT\_MULTIPLE\_CHOICES responses per second         | Responses/Sec |
| RESPONSE\_COUNT\_REQUESTED\_RANGE\_NOT\_SATISFIABLE  | Number of HTTP REQUESTED\_RANGE\_NOT\_SATISFIABLE responses per second  | Responses/Sec |
| RESPONSE\_COUNT\_REQUEST\_HEADER\_FIELDS\_TOO\_LARGE | Number of HTTP REQUEST\_HEADER\_FIELDS\_TOO\_LARGE responses per second | Responses/Sec |
| RESPONSE\_COUNT\_REQUEST\_TIMEOUT                    | Number of HTTP REQUEST\_TIMEOUT responses per second                    | Responses/Sec |
| RESPONSE\_COUNT\_REQUEST\_TOO\_LARGE                 | Number of HTTP REQUEST\_TOO\_LARGE responses per second                 | Responses/Sec |
| RESPONSE\_COUNT\_RESET\_CONTENT                      | Number of HTTP RESET\_CONTENT responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_SEE\_OTHER                          | Number of HTTP SEE\_OTHER responses per second                          | Responses/Sec |
| RESPONSE\_COUNT\_SERVER\_ERROR                       | Number of HTTP SERVER\_ERROR responses per second                       | Responses/Sec |
| RESPONSE\_COUNT\_SERVICE\_UNAVAILABLE                | Number of HTTP SERVICE\_UNAVAILABLE responses per second                | Responses/Sec |
| RESPONSE\_COUNT\_SWITCHING\_PROTOCOL                 | Number of HTTP SWITCHING\_PROTOCOL responses per second                 | Responses/Sec |
| RESPONSE\_COUNT\_TEMP\_REDIRECT                      | Number of HTTP TEMP\_REDIRECT responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_UNAUTHORIZED                        | Number of HTTP UNAUTHORIZED responses per second                        | Responses/Sec |
| RESPONSE\_COUNT\_UNPROCESSABLE\_ENTITY               | Number of HTTP UNPROCESSABLE\_ENTITY responses per second               | Responses/Sec |
| RESPONSE\_COUNT\_UNSUPPORTED\_MEDIA\_TYPE            | Number of HTTP UNSUPPORTED\_MEDIA\_TYPE responses per second            | Responses/Sec |
| RESPONSE\_COUNT\_URI\_TOO\_LONG                      | Number of HTTP URI\_TOO\_LONG responses per second                      | Responses/Sec |
| RESPONSE\_COUNT\_USE\_PROXY                          | Number of HTTP USE\_PROXY responses per second                          | Responses/Sec |
| WAITING\_FOR\_BUCKET\_DOWNLOAD\_BANDWIDTH            | Milliseconds                                                            |               |
| WAITING\_FOR\_BUCKET\_DOWNLOAD\_FLOW                 | Milliseconds                                                            |               |
| WAITING\_FOR\_BUCKET\_REMOVE\_FLOW                   | Milliseconds                                                            |               |
| WAITING\_FOR\_BUCKET\_UPLOAD\_BANDWIDTH              | Milliseconds                                                            |               |
| WAITING\_FOR\_BUCKET\_UPLOAD\_FLOW                   | Milliseconds                                                            |               |
| WAITING\_FOR\_GROUP\_DOWNLOAD\_BANDWIDTH             | Milliseconds                                                            |               |
| WAITING\_FOR\_GROUP\_DOWNLOAD\_FLOW                  | Milliseconds                                                            |               |
| WAITING\_FOR\_GROUP\_REMOVE\_FLOW                    | Milliseconds                                                            |               |
| WAITING\_FOR\_GROUP\_UPLOAD\_BANDWIDTH               | Milliseconds                                                            |               |
| WAITING\_FOR\_GROUP\_UPLOAD\_FLOW                    | Milliseconds                                                            |               |
| WAITING\_IN\_BUCKET\_DOWNLOAD\_QUEUE                 | Milliseconds                                                            |               |
| WAITING\_IN\_BUCKET\_REMOVE\_QUEUE                   | Milliseconds                                                            |               |
| WAITING\_IN\_BUCKET\_UPLOAD\_QUEUE                   | Milliseconds                                                            |               |
| WAITING\_IN\_GROUP\_DOWNLOAD\_QUEUE                  | Milliseconds                                                            |               |
| WAITING\_IN\_GROUP\_REMOVE\_QUEUE                    | Milliseconds                                                            |               |
| WAITING\_IN\_GROUP\_UPLOAD\_QUEUE                    | Milliseconds                                                            |               |
| WRITE\_BYTES                                         | Number of bytes sent to object storage                                  | Bytes/Sec     |

## Operations (NFS)

| **Type**          | **Description**                         | **Units**    |
| ----------------- | --------------------------------------- | ------------ |
| ACCESS\_LATENCY   | Average latency of ACCESS operations    | Microseconds |
| ACCESS\_OPS       | Number of ACCESS operation per second   | Ops/Sec      |
| COMMIT\_LATENCY   | Average latency of COMMIT operations    | Microseconds |
| COMMIT\_OPS       | Number of COMMIT operation per second   | Ops/Sec      |
| CREATE\_LATENCY   | Average latency of CREATE operations    | Microseconds |
| CREATE\_OPS       | Number of CREATE operation per second   | Ops/Sec      |
| FSINFO\_LATENCY   | Average latency of FSINFO operations    | Microseconds |
| FSINFO\_OPS       | Number of FSINFO operation per second   | Ops/Sec      |
| GETATTR\_LATENCY  | Average latency of GETATTR operations   | Microseconds |
| GETATTR\_OPS      | Number of GETATTR operation per second  | Ops/Sec      |
| LINK\_LATENCY     | Average latency of LINK operations      | Microseconds |
| LINK\_OPS         | Number of LINK operation per second     | Ops/Sec      |
| LOOKUP\_LATENCY   | Average latency of LOOKUP operations    | Microseconds |
| LOOKUP\_OPS       | Number of LOOKUP operation per second   | Ops/Sec      |
| MKDIR\_LATENCY    | Average latency of MKDIR operations     | Microseconds |
| MKDIR\_OPS        | Number of MKDIR operation per second    | Ops/Sec      |
| MKNOD\_LATENCY    | Average latency of MKNOD operations     | Microseconds |
| MKNOD\_OPS        | Number of MKNOD operation per second    | Ops/Sec      |
| OPS               | Total number of operations              | Ops/Sec      |
| PATHCONF\_LATENCY | Average latency of PATHCONF operations  | Microseconds |
| PATHCONF\_OPS     | Number of PATHCONF operation per second | Ops/Sec      |
| READDIR\_LATENCY  | Average latency of READDIR operations   | Microseconds |
| READDIR\_OPS      | Number of READDIR operation per second  | Ops/Sec      |
| READLINK\_LATENCY | Average latency of READLINK operations  | Microseconds |
| READLINK\_OPS     | Number of READLINK operation per second | Ops/Sec      |
| READS             | Number of read operations per second    | Ops/Sec      |
| READ\_BYTES       | Number of bytes read per second         | Bytes/Sec    |
| READ\_DURATION    | Microseconds                            |              |
| READ\_LATENCY     | Average latency of READ operations      | Microseconds |
| READ\_SIZES       | NFS read sizes histogram                |              |
| REMOVE\_LATENCY   | Average latency of REMOVE operations    | Microseconds |
| REMOVE\_OPS       | Number of REMOVE operation per second   | Ops/Sec      |
| RENAME\_LATENCY   | Average latency of RENAME operations    | Microseconds |
| RENAME\_OPS       | Number of RENAME operation per second   | Ops/Sec      |
| SETATTR\_LATENCY  | Average latency of SETATTR operations   | Microseconds |
| SETATTR\_OPS      | Number of SETATTR operation per second  | Ops/Sec      |
| STATFS\_LATENCY   | Average latency of STATFS operations    | Microseconds |
| STATFS\_OPS       | Number of STATFS operation per second   | Ops/Sec      |
| SYMLINK\_LATENCY  | Average latency of SYMLINK operations   | Microseconds |
| SYMLINK\_OPS      | Number of SYMLINK operation per second  | Ops/Sec      |
| THROUGHPUT        | Number of byte read/writes per second   | Bytes/Sec    |
| WRITES            | Number of write operations per second   | Ops/Sec      |
| WRITE\_BYTES      | Number of byte writes per second        | Bytes/Sec    |
| WRITE\_DURATION   | Microseconds                            |              |
| WRITE\_LATENCY    | Average latency of WRITE operations     | Microseconds |
| WRITE\_SIZES      | NFS write sizes histogram               |              |

## Operations (NFSw)

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

## Operations (S3)

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

## Operations (driver)

| **Type**                      | **Description**                                       | **Units**    |
| ----------------------------- | ----------------------------------------------------- | ------------ |
| DIRECT\_READ\_SIZES\_RATE     | Blocks/Sec                                            |              |
| DIRECT\_READ\_SIZES           | Blocks                                                |              |
| DIRECT\_WRITE\_SIZES\_RATE    | Blocks                                                |              |
| DIRECT\_WRITE\_SIZES          | Blocks                                                |              |
| DOORBELL\_RING\_COUNT         | Ops                                                   |              |
| FAILED\_1HOP\_READS           | Number of failed single hop reads per second          | Ops/Sec      |
| FILEATOMICOPEN\_LATENCY       | Average latency of FILEATOMICOPEN operations          | Microseconds |
| FILEATOMICOPEN\_OPS           | Number of FILEATOMICOPEN operation per second         | Ops/Sec      |
| FILECLOSE\_LATENCY            | Average latency of FILECLOSE operations               | Microseconds |
| FILECLOSE\_OPS                | Number of FILECLOSE operation per second              | Ops/Sec      |
| FILEOPEN\_LATENCY             | Average latency of FILEOPEN operations                | Microseconds |
| FILEOPEN\_OPS                 | Number of FILEOPEN operation per second               | Ops/Sec      |
| FLOCK\_LATENCY                | Average latency of FLOCK operations                   | Microseconds |
| FLOCK\_OPS                    | Number of FLOCK operation per second                  | Ops/Sec      |
| GETATTR\_LATENCY              | Average latency of GETATTR operations                 | Microseconds |
| GETATTR\_OPS                  | Number of GETATTR operation per second                | Ops/Sec      |
| GETXATTR\_LATENCY             | Average latency of GETXATTR operations                | Microseconds |
| GETXATTR\_OPS                 | Number of GETXATTR operation per second               | Ops/Sec      |
| IOCTL\_OBS\_PREFETCH\_LATENCY | Average latency of IOCTL\_OBS\_PREFETCH operations    | Microseconds |
| IOCTL\_OBS\_PREFETCH\_OPS     | Number of IOCTL\_OBS\_PREFETCH operation per second   | Ops/Sec      |
| IOCTL\_OBS\_RELEASE\_LATENCY  | Average latency of IOCTL\_OBS\_RELEASE operations     | Microseconds |
| IOCTL\_OBS\_RELEASE\_OPS      | Number of IOCTL\_OBS\_RELEASE operation per second    | Ops/Sec      |
| LINK\_LATENCY                 | Average latency of LINK operations                    | Microseconds |
| LINK\_OPS                     | Number of LINK operation per second                   | Ops/Sec      |
| LISTXATTR\_LATENCY            | Average latency of LISTXATTR operations               | Microseconds |
| LISTXATTR\_OPS                | Number of LISTXATTR operation per second              | Ops/Sec      |
| LOOKUP\_LATENCY               | Average latency of LOOKUP operations                  | Microseconds |
| LOOKUP\_OPS                   | Number of LOOKUP operation per second                 | Ops/Sec      |
| MKNOD\_LATENCY                | Average latency of MKNOD operations                   | Microseconds |
| MKNOD\_OPS                    | Number of MKNOD operation per second                  | Ops/Sec      |
| OPS                           | Total number of operations                            | Ops/Sec      |
| RDMA\_WRITE\_REQUESTS         | Number of RDMA write request operations per second    | Ops/Sec      |
| READDIR\_LATENCY              | Average latency of READDIR operations                 | Microseconds |
| READDIR\_OPS                  | Number of READDIR operation per second                | Ops/Sec      |
| READLINK\_LATENCY             | Average latency of READLINK operations                | Microseconds |
| READLINK\_OPS                 | Number of READLINK operation per second               | Ops/Sec      |
| READS                         | Number of read operations per second                  | Ops/Sec      |
| READ\_BYTES                   | Number of bytes read per second                       | Bytes/Sec    |
| READ\_CHECKSUM\_ERRORS        | Ops                                                   |              |
| READ\_DURATION                | Microseconds                                          |              |
| READ\_LATENCY\_NO\_QOS        | Average latency of READ operations without QoS delay  | Microseconds |
| READ\_LATENCY                 | Average latency of READ operations                    | Microseconds |
| READ\_QOS\_DELAY              | Average QoS delay for READ operations                 | Microseconds |
| READ\_RDMA\_SIZES\_RATE       | Blocks/Sec                                            |              |
| READ\_RDMA\_SIZES             | Blocks                                                |              |
| READ\_SIZES\_RATE             | Blocks/Sec                                            |              |
| READ\_SIZES                   | Blocks                                                |              |
| RENAME\_LATENCY               | Average latency of RENAME operations                  | Microseconds |
| RENAME\_OPS                   | Number of RENAME operation per second                 | Ops/Sec      |
| REQUESTS\_COMPLETED           | Ops                                                   |              |
| REQUESTS\_FETCHED             | Ops                                                   |              |
| RMDIR\_LATENCY                | Average latency of RMDIR operations                   | Microseconds |
| RMDIR\_OPS                    | Number of RMDIR operation per second                  | Ops/Sec      |
| RMXATTR\_LATENCY              | Average latency of RMXATTR operations                 | Microseconds |
| RMXATTR\_OPS                  | Number of RMXATTR operation per second                | Ops/Sec      |
| SETATTR\_LATENCY              | Average latency of SETATTR operations                 | Microseconds |
| SETATTR\_OPS                  | Number of SETATTR operation per second                | Ops/Sec      |
| SETXATTR\_LATENCY             | Average latency of SETXATTR operations                | Microseconds |
| SETXATTR\_OPS                 | Number of SETXATTR operation per second               | Ops/Sec      |
| STATFS\_LATENCY               | Average latency of STATFS operations                  | Microseconds |
| STATFS\_OPS                   | Number of STATFS operation per second                 | Ops/Sec      |
| SUCCEEDED\_1HOP\_READS        | Number of succesfull single hop reads per second      | Ops/Sec      |
| SYMLINK\_LATENCY              | Average latency of SYMLINK operations                 | Microseconds |
| SYMLINK\_OPS                  | Number of SYMLINK operation per second                | Ops/Sec      |
| THROUGHPUT                    | Number of byte read/writes per second                 | Bytes/Sec    |
| UNLINK\_LATENCY               | Average latency of UNLINK operations                  | Microseconds |
| UNLINK\_OPS                   | Number of UNLINK operation per second                 | Ops/Sec      |
| WRITES                        | Number of write operations per second                 | Ops/Sec      |
| WRITE\_BYTES                  | Number of byte writes per second                      | Bytes/Sec    |
| WRITE\_DURATION               | Microseconds                                          |              |
| WRITE\_LATENCY\_NO\_QOS       | Average latency of WRITE operations without QoS delay | Microseconds |
| WRITE\_LATENCY                | Average latency of WRITE operations                   | Microseconds |
| WRITE\_QOS\_DELAY             | Average QoS delay for WRITE operations                | Microseconds |
| WRITE\_RDMA\_SIZES\_RATE      | Blocks/Sec                                            |              |
| WRITE\_RDMA\_SIZES            | Blocks                                                |              |
| WRITE\_SIZES\_RATE            | Blocks/Sec                                            |              |
| WRITE\_SIZES                  | Blocks                                                |              |

## Operations

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
| READ\_DURATION          | Microseconds                                  |              |
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
| WRITE\_DURATION         | Microseconds                                  |              |
| WRITE\_LATENCY          | Average latency of WRITE operations           | Microseconds |

## RAFT

| **Type**                           | **Description**                                   | **Units** |
| ---------------------------------- | ------------------------------------------------- | --------- |
| Bucket\_LEADER\_CHANGES            | Changes of leader                                 | Changes   |
| Bucket\_REQUESTS\_COMPLETED        | Requests to leader completed successfully         | Requests  |
| Configuration\_LEADER\_CHANGES     | Changes of leader                                 | Changes   |
| Configuration\_REQUESTS\_COMPLETED | Requests to leader completed successfully         | Requests  |
| Invalid\_LEADER\_CHANGES           | Changes of leader                                 | Changes   |
| Invalid\_REQUESTS\_COMPLETED       | Requests to leader completed successfully         | Requests  |
| SYNCLOG\_TIMEOUTS                  | Number of times timeouted on syncing logs to node | Timeouts  |
| Test\_LEADER\_CHANGES              | Changes of leader                                 | Changes   |
| Test\_REQUESTS\_COMPLETED          | Requests to leader completed successfully         | Requests  |

## RAID

| **Type**                                     | **Description**                                                    | **Units**  |
| -------------------------------------------- | ------------------------------------------------------------------ | ---------- |
| LONG\_RPC\_TIMEOUTS                          | Long RPC timeouts encountered                                      | Occurences |
| RAID\_BLOCKS\_IN\_PREPARED\_STRIPE           | Free blocks in prepared stripe                                     |            |
| RAID\_CHUNKS\_CLEANED\_BY\_SHIFT             | Dirty chunks cleaned by being shifted out                          | Occurences |
| RAID\_CHUNKS\_SHIFTED                        | Dirty chunks that shifted out                                      | Occurences |
| RAID\_COMMITTED\_STRIPES                     | Num stripes written                                                | Stripes    |
| RAID\_PLACEMENT\_SWITCHES                    | Num placement switches                                             | Switches   |
| RAID\_READ\_BATCHES\_PER\_REQUEST\_HISTOGRAM | Histogram of number of batches of stripes read in a single request |            |
| RAID\_READ\_BLOCKS\_STRIPE\_HISTOGRAM        | Histogram of number of blocks read from a single stripe            |            |
| RAID\_READ\_BLOCKS                           | Number of blocks read by the RAID                                  | Blocks/Sec |
| RAID\_READ\_DEGRADED                         | Degraded mode reads                                                | Blocks/Sec |
| RAID\_READ\_IOS                              | Raw read blocks performed by the RAID                              | Blocks/Sec |
| RAID\_STALE\_WRITES\_DETECTED                | Stale write detected in read                                       | Occurences |

## RPC

| **Type**                           | **Description**                                    | **Units**    |
| ---------------------------------- | -------------------------------------------------- | ------------ |
| CLIENT\_CANCELED\_REQUESTS         | Calls/Sec                                          |              |
| CLIENT\_DROPPED\_RESPONSES         | Calls/Sec                                          |              |
| CLIENT\_ENCRYPTION\_AUTH\_FAILURES | Calls/Sec                                          |              |
| CLIENT\_MISSING\_ENCRYPTION\_KEY   | Calls/Sec                                          |              |
| CLIENT\_RECEIVED\_EXCEPTIONS       | Calls/Sec                                          |              |
| CLIENT\_RECEIVED\_RESPONSES        | Calls/Sec                                          |              |
| CLIENT\_RECEIVED\_TIMEOUTS         | Calls/Sec                                          |              |
| CLIENT\_ROUNDTRIP\_AVG\_LOW        | Microseconds                                       |              |
| CLIENT\_ROUNDTRIP\_AVG\_NORM       | Microseconds                                       |              |
| CLIENT\_ROUNDTRIP\_AVG             | Microseconds                                       |              |
| CLIENT\_RPC\_CALLS\_LOW            | RPC/Sec                                            |              |
| CLIENT\_RPC\_CALLS\_NORM           | RPC/Sec                                            |              |
| CLIENT\_RPC\_CALLS                 | RPC/Sec                                            |              |
| CLIENT\_SENT\_REQUESTS             | Calls/Sec                                          |              |
| FIRST\_RESULTS                     | Number of first results per second                 | Ops/Sec      |
| SERVER\_ABORTS                     | Calls/Sec                                          |              |
| SERVER\_DROPPED\_REQUESTS          | Calls/Sec                                          |              |
| SERVER\_ENCRYPTION\_AUTH\_FAILURES | Calls/Sec                                          |              |
| SERVER\_MISSING\_ENCRYPTION\_KEY   | Calls/Sec                                          |              |
| SERVER\_PROCESSING\_AVG            | Microseconds                                       |              |
| SERVER\_PROCESSING\_TIME           |                                                    |              |
| SERVER\_RECEIVED\_REQUESTS         | Calls/Sec                                          |              |
| SERVER\_REJECTS                    | Calls/Sec                                          |              |
| SERVER\_RPC\_CALLS                 | RPC/Sec                                            |              |
| SERVER\_SENT\_EXCEPTIONS           | Calls/Sec                                          |              |
| SERVER\_SENT\_RESPONSES            | Calls/Sec                                          |              |
| SERVER\_UNENCRYPTED\_REFUSALS      | Calls/Sec                                          |              |
| TIME\_TO\_FIRST\_RESULT            | Average latency to the first result of a MultiCall | Microseconds |

## Reactor

| **Type**                            | **Description**                                                                                                                                              | **Units**               |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- |
| BACKGROUND\_CYCLES                  | Number of cycles spent in background fibers                                                                                                                  | Cycles/Sec              |
| BACKGROUND\_FIBERS                  | Number of background fibers that are ready to run and eager to get CPU cycles                                                                                | Fibers                  |
| BACKGROUND\_TIME                    | Percentage of the CPU time utilized for background operations                                                                                                | %                       |
| BucketInvocationState\_CAPACITY     | Number of data structures allocated to the BucketInvocationState pool                                                                                        | Structs                 |
| BucketInvocationState\_STRUCT\_SIZE | Number of bytes in each struct of the BucketInvocationState pool                                                                                             | Bytes                   |
| BucketInvocationState\_USED         | Number of structs in the BucketInvocationState pool which are currently being used                                                                           | Structs                 |
| Bucket\_CAPACITY                    | Number of data structures allocated to the Bucket pool                                                                                                       | Structs                 |
| Bucket\_STRUCT\_SIZE                | Number of bytes in each struct of the Bucket pool                                                                                                            | Bytes                   |
| Bucket\_USED                        | Number of structs in the Bucket pool which are currently being used                                                                                          | Structs                 |
| CLASS\_BLOB!(RAID)\_CAPACITY        | Number of data structures allocated to the CLASS\_BLOB!(RAID) pool                                                                                           | Structs                 |
| CLASS\_BLOB!(RAID)\_STRUCT\_SIZE    | Number of bytes in each struct of the CLASS\_BLOB!(RAID) pool                                                                                                | Bytes                   |
| CLASS\_BLOB!(RAID)\_USED            | Number of structs in the CLASS\_BLOB!(RAID) pool which are currently being used                                                                              | Structs                 |
| CYCLES\_PER\_SECOND                 | Number of cycles the cpu runs per second                                                                                                                     | Cycles/Sec              |
| ChainedSpan\_CAPACITY               | Number of data structures allocated to the ChainedSpan pool                                                                                                  | Structs                 |
| ChainedSpan\_STRUCT\_SIZE           | Number of bytes in each struct of the ChainedSpan pool                                                                                                       | Bytes                   |
| ChainedSpan\_USED                   | Number of structs in the ChainedSpan pool which are currently being used                                                                                     | Structs                 |
| Charter\_CAPACITY                   | Number of data structures allocated to the Charter pool                                                                                                      | Structs                 |
| Charter\_STRUCT\_SIZE               | Number of bytes in each struct of the Charter pool                                                                                                           | Bytes                   |
| Charter\_USED                       | Number of structs in the Charter pool which are currently being used                                                                                         | Structs                 |
| CrossDestageDesc\_CAPACITY          | Number of data structures allocated to the CrossDestageDesc pool                                                                                             | Structs                 |
| CrossDestageDesc\_STRUCT\_SIZE      | Number of bytes in each struct of the CrossDestageDesc pool                                                                                                  | Bytes                   |
| CrossDestageDesc\_USED              | Number of structs in the CrossDestageDesc pool which are currently being used                                                                                | Structs                 |
| DEFUNCT\_FIBERS                     | Number of defunct buffers, which are really just memory structures allocated for future fiber needs.                                                         | Fibers                  |
| DeferredTask2\_CAPACITY             | Number of data structures allocated to the DeferredTask2 pool                                                                                                | Structs                 |
| DeferredTask2\_STRUCT\_SIZE         | Number of bytes in each struct of the DeferredTask2 pool                                                                                                     | Bytes                   |
| DeferredTask2\_USED                 | Number of structs in the DeferredTask2 pool which are currently being used                                                                                   | Structs                 |
| EXCEPTIONS                          | Number of excpetions caught by the reactor                                                                                                                   | Exceptions/Sec          |
| GenericBaseBlock\_CAPACITY          | Number of data structures allocated to the GenericBaseBlock pool                                                                                             | Structs                 |
| GenericBaseBlock\_STRUCT\_SIZE      | Number of bytes in each struct of the GenericBaseBlock pool                                                                                                  | Bytes                   |
| GenericBaseBlock\_USED              | Number of structs in the GenericBaseBlock pool which are currently being used                                                                                | Structs                 |
| HOGGED\_TIME                        | Histogram of time used by hogger fibers (only in debug builds)                                                                                               |                         |
| IDLE\_CALLBACK\_INVOCATIONS         | Number of background work invocations                                                                                                                        | Invocations/Sec         |
| IDLE\_CYCLES                        | Number of cycles spent in idle                                                                                                                               | Cycles/Sec              |
| IDLE\_TIME                          | Percentage of the CPU time not utilized for handling I/Os                                                                                                    | %                       |
| NODE\_HANG                          |                                                                                                                                                              |                         |
| OUTRAGEOUS\_HOGGERS                 | Number of hoggers taking really excessive amount of time to run                                                                                              | Invocations             |
| ObsGateway\_CAPACITY                | Number of data structures allocated to the ObsGateway pool                                                                                                   | Structs                 |
| ObsGateway\_STRUCT\_SIZE            | Number of bytes in each struct of the ObsGateway pool                                                                                                        | Bytes                   |
| ObsGateway\_USED                    | Number of structs in the ObsGateway pool which are currently being used                                                                                      | Structs                 |
| PENDING\_FIBERS                     | Number of fibers pending for external events, such as a network packet, or SSD response. Upon such external event they will change state to scheduled fibers | Fibers                  |
| QueuedBlock\_CAPACITY               | Number of data structures allocated to the QueuedBlock pool                                                                                                  | Structs                 |
| QueuedBlock\_STRUCT\_SIZE           | Number of bytes in each struct of the QueuedBlock pool                                                                                                       | Bytes                   |
| QueuedBlock\_USED                   | Number of structs in the QueuedBlock pool which are currently being used                                                                                     | Structs                 |
| ReadBlocksImpl!(RAID)\_CAPACITY     | Number of data structures allocated to the ReadBlocksImpl!(RAID) pool                                                                                        | Structs                 |
| ReadBlocksImpl!(RAID)\_STRUCT\_SIZE | Number of bytes in each struct of the ReadBlocksImpl!(RAID) pool                                                                                             | Bytes                   |
| ReadBlocksImpl!(RAID)\_USED         | Number of structs in the ReadBlocksImpl!(RAID) pool which are currently being used                                                                           | Structs                 |
| SCHEDULED\_FIBERS                   | Number of current fibers that are ready to run and eager to get CPU cycles                                                                                   | Fibers                  |
| SLEEPY\_FIBERS                      | Number of SLEEPY fibers                                                                                                                                      | Fibers                  |
| SLEEPY\_RPC\_SERVER\_FIBERS         | Number of SLEEPY RPC server fibers                                                                                                                           | Sleepy fiber detections |
| SSD\_CAPACITY                       | Number of data structures allocated to the SSD pool                                                                                                          | Structs                 |
| SSD\_STRUCT\_SIZE                   | Number of bytes in each struct of the SSD pool                                                                                                               | Bytes                   |
| SSD\_USED                           | Number of structs in the SSD pool which are currently being used                                                                                             | Structs                 |
| STEP\_CYCLES                        | Histogram of time spent in a fiber                                                                                                                           |                         |
| TIMER\_CALLBACKS                    | Current number of timer callbacks                                                                                                                            | Callbacks               |
| TOTAL\_FIBERS\_COUNT                | Number of fibers                                                                                                                                             | Fibers                  |
| TimedCallback\_CAPACITY             | Number of data structures allocated to the TimedCallback pool                                                                                                | Structs                 |
| TimedCallback\_STRUCT\_SIZE         | Number of bytes in each struct of the TimedCallback pool                                                                                                     | Bytes                   |
| TimedCallback\_USED                 | Number of structs in the TimedCallback pool which are currently being used                                                                                   | Structs                 |
| UploadFileInfo\_CAPACITY            | Number of data structures allocated to the UploadFileInfo pool                                                                                               | Structs                 |
| UploadFileInfo\_STRUCT\_SIZE        | Number of bytes in each struct of the UploadFileInfo pool                                                                                                    | Bytes                   |
| UploadFileInfo\_USED                | Number of structs in the UploadFileInfo pool which are currently being used                                                                                  | Structs                 |
| networkBuffers\_CAPACITY            | Number of data structures allocated to the networkBuffers pool                                                                                               | Structs                 |
| networkBuffers\_USED                | Number of structs in the networkBuffers pool which are currently being used                                                                                  | Structs                 |
| rdmaNetworkBuffers\_CAPACITY        | Number of data structures allocated to the rdmaNetworkBuffers pool                                                                                           | Structs                 |
| rdmaNetworkBuffers\_USED            | Number of structs in the rdmaNetworkBuffers pool which are currently being used                                                                              | Structs                 |

## SSD

| **Type**                         | **Description**                                                             | **Units**      |
| -------------------------------- | --------------------------------------------------------------------------- | -------------- |
| DRIVE\_ACTIVE\_IOS               | The number of in flight IO against the SSD at the time of sampling          | IOs            |
| DRIVE\_FORFEITS                  | Number of IOs forfeited due to lack of memory buffers                       | Operations/Sec |
| DRIVE\_IDLE\_CYCLES              | Number of cycles spent in idle                                              | Cycles/Sec     |
| DRIVE\_IDLE\_TIME                | Percentage of the CPU time not utilized for handling I/Os                   | %              |
| DRIVE\_IO\_OVERLAPPED            | Number of overlapping IOs                                                   | Operations     |
| DRIVE\_IO\_TOO\_LONG             | Number of IOs that took longer than expected                                | Operations/Sec |
| DRIVE\_LATENCY                   | Measure the latencies up to 5ms (higher latencies will be grouped together) |                |
| DRIVE\_LOAD                      | Drive Load at sampling time                                                 | Load           |
| DRIVE\_MEDIA\_BLOCKS\_READ       | Blocks read from the SSD media                                              | Blocks/Sec     |
| DRIVE\_MEDIA\_BLOCKS\_WRITE      | Blocks written to the SSD media                                             | Blocks/Sec     |
| DRIVE\_MEDIA\_ERRORS             | SSD Media Errors                                                            | IO/Sec         |
| DRIVE\_NON\_MEDIA\_ERRORS        | SSD Non-Media Errors                                                        | IO/Sec         |
| DRIVE\_PENDING\_IOS              | The number of IOs waiting to start executing at the time of sampling        | IOs            |
| DRIVE\_PUMPED\_IOS               | Number of requests returned in a pump                                       |                |
| DRIVE\_PUMPS\_DELAYED            | Number of Drive pumps that got delayed                                      | Operations/Sec |
| DRIVE\_PUMPS\_SEVERELY\_DELAYED  | Number of Drive pumps that got severely delayed                             | Operations/Sec |
| DRIVE\_PUMP\_LATENCY             | Latency between SSD pumps                                                   | Microseconds   |
| DRIVE\_READ\_LATENCY             | Drive Read Execution Latency                                                | Microseconds   |
| DRIVE\_READ\_OPS                 | Drive Read Operations                                                       | IO/Sec         |
| DRIVE\_REMAINING\_IOS            | Number of requests still in the drive after a pump                          |                |
| DRIVE\_REQUEST\_BLOCKS           | Measure drive request size distribution                                     |                |
| DRIVE\_SSD\_PUMPS                | Number of drive pumps that resulted in data flowin from/to drive            | Pump/Sec       |
| DRIVE\_UTILIZATION               | Percentage of time the drive had an active IO submitted to it               | %              |
| DRIVE\_WRITE\_LATENCY            | Drive Write Execution Latency                                               | Microseconds   |
| DRIVE\_WRITE\_OPS                | Drive Write Operations                                                      | IO/Sec         |
| SSDS\_IOS                        | IOs performed on the SSD service                                            | IO/Sec         |
| SSDS\_IO\_ERRORS                 | IO errors on the SSD service                                                | Blocks/Sec     |
| SSD\_BLOCKS\_READ                | Number of blocks read from the SSD service                                  | Blocks/Sec     |
| SSD\_BLOCKS\_WRITTEN             | Number of blocks written to the SSD service                                 | Blocks/Sec     |
| SSD\_CHUNK\_ALLOCS               | Rate of chunk allocations                                                   | Chunks/Sec     |
| SSD\_CHUNK\_FREES                | Rate of chunk frees                                                         | Chunks/Sec     |
| SSD\_E2E\_BAD\_CSUM              | End-to-End checksum failures                                                | IO/Sec         |
| SSD\_READ\_ERRORS                | Errors in reading blocks from the SSD service                               | Blocks/Sec     |
| SSD\_READ\_LATENCY               | Avg. latency of read requests from the SSD service                          | Microseconds   |
| SSD\_READ\_REQS\_LARGE\_NORMAL   | Number of large normal read requests from the SSD service                   | IO/Sec         |
| SSD\_READ\_REQS                  | Number of read requests from the SSD service                                | IO/Sec         |
| SSD\_WRITES\_REQS\_LARGE\_NORMAL | Number of large normal priority write requests to the SSD service           | IO/Sec         |
| SSD\_WRITES                      | Number of write requests to the SSD service                                 | IO/Sec         |
| SSD\_WRITE\_ERRORS               | Errors in writing blocks to the SSD service                                 | Blocks/Sec     |
| SSD\_WRITE\_LATENCY              | Latency of writes to the SSD service                                        | Microseconds   |

## Scrubber

| **Type**                                | **Description**                                                                                                      | **Units**      |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | -------------- |
| ACTUALLY\_FALSE\_FREE                   | Number of blocks that were detected as false-used and freed                                                          | Blocks/Sec     |
| CLEANED\_CHUNKS                         | Number of chunks that were cleaned by the scrubber                                                                   | Chunks/Sec     |
| DEGRADED\_READS                         | Number of degraded reads for scrubbing                                                                               | Requests/Sec   |
| FALSE\_FREE\_CHECKED\_BLOCKS            | Number of blocks that were scrubbed-false-used                                                                       | Blocks/Sec     |
| FALSE\_FREE\_CHECK\_LATENCY             | Average latency of checking false free per block                                                                     | Micros         |
| FALSE\_USED\_CHECK\_LATENCY             | Average latency of checking false used per block                                                                     | Micros         |
| FALSE\_USED\_EXTRA\_NOTIFIED            | Number of blocks that were notified as used by the mark-extra-used mechanism                                         | Blocks/Sec     |
| INTERRUPTS                              | Number of scrubs that were interrupted                                                                               | Occurences/Sec |
| NETWORK\_BUDGET\_WAIT\_LATENCY          | Average latency of waiting for our network budget                                                                    | Micros         |
| NOT\_ACTUALLY\_FALSE\_FREE              | Number of blocks that were detected as used                                                                          | Blocks/Sec     |
| NOT\_REALLY\_DIRTY\_BLOCKS              | Number of marked dirty blocks that ScrubMissingWrites found were actually clean                                      | Blocks/Sec     |
| NUM\_COPY\_DISCARDED\_BLOCKS            | Number of copied blocks that were discarded                                                                          | Blocks/Sec     |
| NUM\_COPY\_DISCARDS                     | Number of times we discarded scrubber copy work                                                                      | Occurences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARDS        | Number of times we discarded all scrubber work due to invented stripes                                               | Occurences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARD\_BLOCKS | Number of blocks that were discarded due to invented stripes                                                         | Blocks/Sec     |
| NUM\_SCRUBBER\_DISCARD\_INTERMEDIATES   | Number of times we discarded all intermediate scrubber work                                                          | Occurences/Sec |
| NUM\_SMW\_DISCARDED\_BLOCKS             | Number of SMW'd blocks that were discarded                                                                           | Blocks/Sec     |
| NUM\_SMW\_DISCARDS                      | Number of times we discarded scrubber SMW work                                                                       | Occurences/Sec |
| PLACEMENT\_SELECTION\_LATENCY           | Average latency of scrubbed placement selection                                                                      | Micros         |
| READS\_CALLED                           | Number of blocks that were read                                                                                      | Blocks/Sec     |
| READ\_BATCH\_SOURCE\_BLOCKS             | Number of source blocks to read in batch                                                                             |                |
| READ\_BLOCKS\_LATENCY                   | Average latency of read blocks                                                                                       | Micros         |
| RELOCATED\_BLOCKS                       | Number of blocks that were relocated for eviction                                                                    | Blocks/Sec     |
| RELOCATE\_BLOCKS\_LATENCY               | Average latency of relocating blocks                                                                                 | Micros         |
| RETRUSTED\_UNPROTECTED\_DIRTY\_BLOCKS   | Number of dirty blocks that ScrubMissingWrites retrusted because they were unprotected                               | Blocks/Sec     |
| REWRITTEN\_DIRTY\_BLOCKS                | Number of dirty blocks that ScrubMissingWrites rewrote to clean them                                                 | Blocks/Sec     |
| SCRUB\_BATCHES\_LATENCY                 | Average latency of scrub batches                                                                                     | Millis         |
| SCRUB\_FALSE\_FREE\_FAILED\_READS       | Number of blocks that we failed to read for scrub-false-free                                                         | Blocks/Sec     |
| SCRUB\_FALSE\_FREE\_FAILED              | Number of placements we failed to fully scrub-false-free                                                             | Occurences/Sec |
| SCRUB\_FALSE\_FREE\_PLACEMENTS          | Number of placements we finished scrub-false-used                                                                    | Occurences/Sec |
| SCRUB\_FALSE\_FREE\_WAS\_UNPROTECTED    | Number of blocks that were false marked freed and unprotected                                                        | Blocks/Sec     |
| SCRUB\_FALSE\_USED\_FAILED\_READS       | Number of blocks that we failed to read for scrub-false-used                                                         | Blocks/Sec     |
| SCRUB\_FALSE\_USED\_FAILED              | Number of placements we failed to fully scrub-false-used                                                             | Occurences/Sec |
| SCRUB\_FALSE\_USED\_PLACEMENTS          | Number of placements we finished scrub-false-used                                                                    | Occurences/Sec |
| SCRUB\_FALSE\_USED\_WAS\_UNPROTECTED    | Number of blocks that were false marked used and unprotected                                                         | Blocks/Sec     |
| SCRUB\_PREPARATION\_FAILED              | Number of times we failed to prepare() a task and aborted scrub of placement                                         | Occurences/Sec |
| SFU\_CHECKS                             | Number of blocks that were scrubbed-false-used                                                                       | Blocks/Sec     |
| SFU\_CHECK\_FREE                        | Number of blocks that were detected as false-used and freed                                                          | Blocks/Sec     |
| SFU\_CHECK\_SECONDARY                   | Number of blocks that were detected as secondary                                                                     | Blocks/Sec     |
| SFU\_CHECK\_USED                        | Number of blocks that were detected as used                                                                          | Blocks/Sec     |
| SOURCE\_READS                           | Number of source/committed superset blocks directly read by the scrubber                                             | Blocks/Sec     |
| TARGET\_COPIED\_CHUNKS                  | Number of chunks that were copied to target by the scrubber                                                          | Chunks/Sec     |
| UPDATE\_PLACEMENT\_INFO\_LATENCY        | Average latency of updating the placement info quorum                                                                | Micros         |
| UPDATE\_PLACEMENT\_INFO                 | Number of times we ran updatePlacementInfo                                                                           | Occurences/Sec |
| WONT\_CLEAN\_COPYING                    | Number of actually dirty blocks that ScrubMissingWrites refused to clean because they will be moved to target anyway | Blocks/Sec     |
| WRITES\_CALLED                          | Number of blocks that were written                                                                                   | Blocks/Sec     |
| WRITE\_BATCH\_SOURCE\_BLOCKS            | Number of source blocks to write in batch                                                                            |                |
| WRITE\_BATCH\_TARGET\_BLOCKS            | Number of target blocks to write in batch                                                                            |                |
| WRITE\_BLOCKS\_LATENCY                  | Average latency of writing blocks                                                                                    | Micros         |

## Squelch

| **Type**                                                | **Description**                                       | **Units**     |
| ------------------------------------------------------- | ----------------------------------------------------- | ------------- |
| BLOCKS\_PER\_DESQUELCH                                  | Blocks                                                |               |
| EXTENT\_DESQUELCHES\_NUM                                | Times                                                 |               |
| EXTENT\_SQUELCH\_BLOCKS\_READ                           | Blocks                                                |               |
| HASH\_DESQUELCHES\_NUM                                  | Times                                                 |               |
| HASH\_SQUELCH\_BLOCKS\_READ                             | Blocks                                                |               |
| INODE\_DESQUELCHES\_NUM                                 | Times                                                 |               |
| INODE\_SQUELCH\_BLOCKS\_READ                            | Blocks                                                |               |
| JOURNAL\_DESQUELCHES\_NUM                               | Times                                                 |               |
| JOURNAL\_SQUELCH\_BLOCKS\_READ                          | Blocks                                                |               |
| MAX\_BLOCKS\_WITH\_TEMPORAL\_SQUELCH\_ITEMS\_IN\_BUCKET | Number of block with temporal squelch items in bucket | Blocks        |
| MAX\_TEMPORAL\_SQUELCH\_ITEMS\_IN\_BUCKET               | Number temporal squelch items in bucket               | Squelch items |
| REGISTRY\_L1\_DESQUELCHES\_NUM                          | Times                                                 |               |
| REGISTRY\_L1\_SQUELCH\_BLOCKS\_READ                     | Blocks                                                |               |
| REGISTRY\_L2\_DESQUELCHES\_NUM                          | Times                                                 |               |
| REGISTRY\_L2\_SQUELCH\_BLOCKS\_READ                     | Blocks                                                |               |
| SPATIAL\_SQUELCH\_DESQUELCHES\_NUM                      | Times                                                 |               |
| SPATIAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ                 | Blocks                                                |               |
| SUPERBLOCK\_DESQUELCHES\_NUM                            | Times                                                 |               |
| SUPERBLOCK\_SQUELCH\_BLOCKS\_READ                       | Blocks                                                |               |
| TEMPORAL\_SQUELCH\_DESQUELCHES\_NUM                     | Times                                                 |               |
| TEMPORAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ                | Blocks                                                |               |

## Statistics

| **Type**                         | **Description**                                                                        | **Units**   |
| -------------------------------- | -------------------------------------------------------------------------------------- | ----------- |
| GATHER\_FROM\_NODE\_LATENCY\_NET | Time spent on responding to a stats gathering request (not including metadata)         | Seconds/Sec |
| GATHER\_FROM\_NODE\_LATENCY      | Time spent responding to a stats gathering request (not including metadata)            | Seconds/Sec |
| GATHER\_FROM\_NODE\_SLEEP        | Time spent in-between responding to a stats gathering request (not including metadata) | Seconds/Sec |
| TIMES\_QUERIED\_STATS            | Number of times the node queried other nodes for stats                                 | Times       |
| TIMES\_QUERIED                   | Number of times the node was queried for stats (not including metadata)                | Times       |
