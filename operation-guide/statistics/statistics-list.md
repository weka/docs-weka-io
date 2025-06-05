---
description: >-
  Explore the various statistics the WEKA system produces, organized according
  to their respective categories.
---

# Statistics list

### Bucket

| **Type**                                                          | **Description**                                                                                         | **Units**    |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------ |
| BUCKET\_SESSION\_VALIDATION\_LATENCY                              | Average latency of bucket session validation                                                            | Microseconds |
| BUCKET\_SESSION\_VALIDATIONS                                      | Number of bucket session validations per second                                                         | RPCs/Sec     |
| BUCKET\_START\_TIME                                               | Duration of bucket activation on step up                                                                | Startups     |
| CHOKING\_LEVEL\_ALL                                               | Throttling level applied on all types of IOs                                                            | %            |
| CHOKING\_LEVEL\_NON\_MUTATING                                     | Throttling level applied on non-mutating only types of IOs                                              | %            |
| COALESCED\_MAY\_CREATE\_EXTENT                                    | Number of mayCreateExtent calls coalesced                                                               | Calls        |
| DESTAGE\_COUNT                                                    | Number of destages per second                                                                           | Destages/Sec |
| DESTAGED\_BLOCKS\_COUNT                                           | Number of destaged blocks per second                                                                    | Blocks/Sec   |
| DIR\_MOVE\_TIME                                                   | Time to complete a directory move                                                                       | Ops          |
| EXTENT\_BLOCK\_SEQUENCES                                          | Histogram of the number of consecutive sequences of blocks in a single extent                           | Extents      |
| EXTENT\_BLOCKS\_COUNT                                             | Difference in number of EXTENT blocks                                                                   | Blocks       |
| FAIRNESS\_DELAYED\_MAY\_CREATE\_EXTENT                            | Number of mayCreateExtent calls not coalesced to prevent starvation                                     | Calls        |
| FREEABLE\_LRU\_BUFFERS                                            | Number of unused blocks in LRU cache                                                                    | Buffers      |
| HASH\_BLOCKS\_COUNT                                               | Difference in number of HASH blocks                                                                     | Blocks       |
| INODE\_BLOCKS\_COUNT                                              | Difference in number of INODE blocks                                                                    | Blocks       |
| INTEGRITY\_ISSUES                                                 | Number of filesystem integrity issues detected                                                          | Issues       |
| JOURNAL\_BLOCKS\_COUNT                                            | Difference in number of JOURNAL blocks                                                                  | Blocks       |
| NOOP\_JOURNALS                                                    | Number of NOOP journals                                                                                 | Ops/Sec      |
| NOOP\_REPLAYS                                                     | Number of NOOP replays                                                                                  | Ops          |
| ODH\_COLLISIONS\_ACCESS\_CLOCK\_STATES                            | Number of ODH items created with colliding hash in ACCESS\_CLOCK\_STATES ODH                            | Collisions   |
| ODH\_COLLISIONS\_BIG\_BLOB\_MANIFEST                              | Number of ODH items created with colliding hash in BIG\_BLOB\_MANIFEST ODH                              | Collisions   |
| ODH\_COLLISIONS\_DEFAULT\_DIR\_QUOTA                              | Number of ODH items created with colliding hash in DEFAULT\_DIR\_QUOTA ODH                              | Collisions   |
| ODH\_COLLISIONS\_DIR\_QUOTA                                       | Number of ODH items created with colliding hash in DIR\_QUOTA ODH                                       | Collisions   |
| ODH\_COLLISIONS\_DIRECTORY                                        | Number of ODH items created with colliding hash in DIRECTORY ODH                                        | Collisions   |
| ODH\_COLLISIONS\_FLOCK\_EXPIRED\_FRONTENDS\_WNID                  | Number of ODH items created with colliding hash in FLOCK\_EXPIRED\_FRONTENDS\_WNID ODH                  | Collisions   |
| ODH\_COLLISIONS\_FLOCK\_EXPIRED\_FRONTENDS                        | Number of ODH items created with colliding hash in FLOCK\_EXPIRED\_FRONTENDS ODH                        | Collisions   |
| ODH\_COLLISIONS\_GRAVEYARD                                        | Number of ODH items created with colliding hash in GRAVEYARD ODH                                        | Collisions   |
| ODH\_COLLISIONS\_INODES\_PENDING\_VALIDATIONS                     | Number of ODH items created with colliding hash in INODES\_PENDING\_VALIDATIONS ODH                     | Collisions   |
| ODH\_COLLISIONS\_INODES\_POTENTIAL\_PENDING\_DELETION             | Number of ODH items created with colliding hash in INODES\_POTENTIAL\_PENDING\_DELETION ODH             | Collisions   |
| ODH\_COLLISIONS\_MODIFY\_CLOCK\_STATES                            | Number of ODH items created with colliding hash in MODIFY\_CLOCK\_STATES ODH                            | Collisions   |
| ODH\_COLLISIONS\_OBS\_IMMEDIATE\_RELEASE                          | Number of ODH items created with colliding hash in OBS\_IMMEDIATE\_RELEASE ODH                          | Collisions   |
| ODH\_COLLISIONS\_OBS\_RECLAMATION                                 | Number of ODH items created with colliding hash in OBS\_RECLAMATION ODH                                 | Collisions   |
| ODH\_COLLISIONS\_REFERENCE\_RELOCATIONS                           | Number of ODH items created with colliding hash in REFERENCE\_RELOCATIONS ODH                           | Collisions   |
| ODH\_COLLISIONS\_SNAP\_LAYER\_CAPACITY                            | Number of ODH items created with colliding hash in SNAP\_LAYER\_CAPACITY ODH                            | Collisions   |
| ODH\_COLLISIONS\_SNAP\_LAYER\_SIZE\_V4\_2                         | Number of ODH items created with colliding hash in SNAP\_LAYER\_SIZE\_V4\_2 ODH                         | Collisions   |
| ODH\_COLLISIONS\_SNAP\_LAYER\_SIZE\_V4\_3                         | Number of ODH items created with colliding hash in SNAP\_LAYER\_SIZE\_V4\_3 ODH                         | Collisions   |
| ODH\_COLLISIONS\_SNAPSHOT\_MEMBERS                                | Number of ODH items created with colliding hash in SNAPSHOT\_MEMBERS ODH                                | Collisions   |
| ODH\_COLLISIONS\_STOW\_DOWNLOAD\_REDISTRIBUTE\_PULL\_STATE\_V4\_3 | Number of ODH items created with colliding hash in STOW\_DOWNLOAD\_REDISTRIBUTE\_PULL\_STATE\_V4\_3 ODH | Collisions   |
| ODH\_COLLISIONS\_STOW\_DOWNLOAD\_REDISTRIBUTE\_V4\_3              | Number of ODH items created with colliding hash in STOW\_DOWNLOAD\_REDISTRIBUTE\_V4\_3 ODH              | Collisions   |
| ODH\_COLLISIONS\_STOW\_UPLOAD\_MANIFEST                           | Number of ODH items created with colliding hash in STOW\_UPLOAD\_MANIFEST ODH                           | Collisions   |
| ODH\_COLLISIONS\_SV\_CAPACITY\_LEADER                             | Number of ODH items created with colliding hash in SV\_CAPACITY\_LEADER ODH                             | Collisions   |
| ODH\_COLLISIONS\_UNLINKED\_INODES                                 | Number of ODH items created with colliding hash in UNLINKED\_INODES ODH                                 | Collisions   |
| ODH\_COLLISIONS                                                   | Number of ODH items created with colliding hash in all ODHs                                             | Collisions   |
| ODL\_BLOCKS\_COUNT                                                | Difference in number of ODL blocks                                                                      | Blocks       |
| ODL\_PAYLOAD\_BLOCKS\_COUNT                                       | Difference in number of ODL\_PAYLOAD blocks                                                             | Blocks       |
| READ\_BYTES                                                       | Number of bytes read per second                                                                         | Bytes/Sec    |
| READ\_LATENCY                                                     | Average latency of READ operations                                                                      | Microseconds |
| READS                                                             | Number of read operations per second                                                                    | Ops/Sec      |
| REGISTRY\_COLLISIONS                                              | Number of registry items created with colliding key                                                     | Collisions   |
| REGISTRY\_L1\_BLOCKS\_COUNT                                       | Difference in number of REGISTRY\_L1 blocks                                                             | Blocks       |
| REGISTRY\_L2\_BLOCKS\_COUNT                                       | Difference in number of REGISTRY\_L2 blocks                                                             | Blocks       |
| REGISTRY\_SEARCHES\_COUNT                                         | Number of registry searches per second                                                                  | Queries/Sec  |
| REJECTED\_STALE\_PUT\_BLOCKS\_FALSE\_POSITIVES                    | Number of putBlocks RPCs falsely rejected due to stale serial number                                    | RPCs/Sec     |
| REJECTED\_STALE\_PUT\_BLOCKS                                      | Number of putBlocks RPCs rejected due to stale serial number                                            | RPCs/Sec     |
| RESIDENT\_BLOCKS\_COUNT                                           | Number of blocks in the resident blocks table                                                           | Blocks       |
| SINGLE\_HOP\_MISMATCH\_RECOVERY                                   | Number of single-hop read prefix mismatch recoveries                                                    | Issues       |
| SINGLE\_HOP\_RDMA\_MISMATCH\_DPDK\_FALLBACK                       | Number of single-hop read prefix mismatch RDMA failures                                                 | Issues       |
| SINGLE\_HOP\_WRITE\_ATTEMPTS                                      | Number of single hop write attempts                                                                     | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_BYTES                                         | Total single hop write bytes                                                                            | Bytes/Sec    |
| SINGLE\_HOP\_WRITE\_FAILURES                                      | Number of single-hop write operation failures per second                                                | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_BAD\_CSUM                                    | Number of single hop write operation (BAD\_CSUM) per second                                             | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_FE\_CALLBACK\_FAIL                           | Number of single hop write operation (FE\_CALLBACK\_FAIL) per second                                    | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_FE\_FAILOVER                                 | Number of single hop write operation (FE\_FAILOVER) per second                                          | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_MANUAL\_OVERRIDE\_DENY                       | Number of single hop write operation (MANUAL\_OVERRIDE\_DENY) per second                                | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_NO\_BYPASSING\_STRIPES                       | Number of single hop write operation (NO\_BYPASSING\_STRIPES) per second                                | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_OTHER\_ERROR                                 | Number of single hop write operation (OTHER\_ERROR) per second                                          | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_SKIP                                         | Number of single-hop write operations (SKIP) per second                                                 | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_SSD\_FAIL                                    | Number of single hop write operation (SSD\_FAIL) per second                                             | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_SUCCESS                                      | Number of single-hop write operations (SUCCESS) per second                                              | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_TOO\_MANY\_PLACEMENTS                        | Number of single hop write operation (TOO\_MANY\_PLACEMENTS) per second                                 | Ops/Sec      |
| SINGLE\_HOP\_WRITES\_UNEXPECTED\_FAIL                             | Number of single hop write operation (UNEXPECTED\_FAIL) per second                                      | Ops/Sec      |
| SNAPSHOT\_CREATION\_TIME                                          | Time to complete a snapshot creation                                                                    | Snapshots    |
| SPATIAL\_SQUELCH\_BLOCKS\_COUNT                                   | Difference in number of SPATIAL\_SQUELCH blocks                                                         | Blocks       |
| SUCCESSFUL\_DATA\_WEDGINGS                                        | Number of successful attempts to wedge data blocks in journal per second                                | Attempts/Sec |
| SUPERBLOCK\_BLOCKS\_COUNT                                         | Difference in number of SUPERBLOCK blocks                                                               | Blocks       |
| TEMPORAL\_SQUELCH\_BLOCKS\_COUNT                                  | Difference in number of TEMPORAL\_SQUELCH blocks                                                        | Blocks       |
| TRANSIENT\_INTEGRITY\_ISSUES                                      | Number of transient filesystem integrity issues detected                                                | Issues       |
| UNSUCCESSFUL\_DATA\_WEDGINGS                                      | Number of unsuccessful attempts to wedge data blocks in journal per second                              | Attempts/Sec |
| USER\_DATA\_BUFFERS\_IN\_USE                                      | Number of data buffers used for serving ongoing IOs                                                     | Buffers      |
| WRITE\_BYTES                                                      | Number of byte writes per second                                                                        | Bytes/Sec    |
| WRITE\_LATENCY                                                    | Average latency of WRITE operations                                                                     | Microseconds |
| WRITES                                                            | Number of write operations per second                                                                   | Ops/Sec      |

### Charters

| **Type**                            | **Description**                | **Units** |
| ----------------------------------- | ------------------------------ | --------- |
| DEDGRADED\_TO\_READER\_RELINQUISHES | Charter relinquishes by reason | charters  |
| EAGER\_RELINQUISHES                 | Charter relinquishes by reason | charters  |
| LRU\_EXPIRED\_RELINQUISHES          | Charter relinquishes by reason | charters  |
| LRU\_LENGTH\_RELINQUISHES           | Charter relinquishes by reason | charters  |
| OUT\_OF\_SPACE\_RELINQUISHES        | Charter relinquishes by reason | charters  |

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

| **Type**                                                        | **Description**                                                                                                       | **Units**                                             |
| --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| AVERAGE\_CHANGES\_IN\_CHANGESET                                 | The average number of changes in a changeset                                                                          | Changes/Sec                                           |
| AVERAGE\_CHANGES\_IN\_GENERATION                                | The average number of changes in a generation                                                                         | Changes/Sec                                           |
| BACKEND\_NODE\_REJOIN\_TIME                                     | The number of backends rejoin attempts per completion time range                                                      | Number of rejoins                                     |
| CHANGESET\_COMMIT\_LATENCY                                      | The average latency of committing a configuration changeset                                                           | Microseconds                                          |
| CLIENT\_NODE\_REJOIN\_TIME                                      | The number of clients rejoin attempts per completion time range                                                       | Number of rejoins                                     |
| CONFIG\_PROPAGATION\_LATENCY                                    | The latencies of propagation of a configuration generation                                                            | Generation                                            |
| FetchLocalStateChangesCallType\_INTERNAL\_CONTINUE              | Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                               | RPC Calls                                             |
| FetchLocalStateChangesCallType\_INTERNAL\_RESTART\_FROM\_TAIL   | Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                               | RPC Calls                                             |
| FetchLocalStateChangesCallType\_INTERNAL\_RETRY\_LAST\_REQUEST  | Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                               | RPC Calls                                             |
| FetchLocalStateChangesCallType\_LEAF\_CONTINUE                  | Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                               | RPC Calls                                             |
| FetchLocalStateChangesCallType\_LEAF\_RESTART\_FROM\_TAIL       | Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                               | RPC Calls                                             |
| FetchLocalStateChangesCallType\_LEAF\_RETRY\_LAST\_REQUEST      | Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                               | RPC Calls                                             |
| GENERATION\_COMMIT\_LATENCY                                     | The average latency of committing a configuration generation to the RAFT log                                          | Microseconds                                          |
| HEARTBEAT\_PROCESSING\_TIME\_OLD                                | The number of non-leader heartbeats per processing time range (OLD)                                                   | Number of heartbeats                                  |
| HEARTBEAT\_PROCESSING\_TIME                                     | The number of non-leader heartbeats per processing time range                                                         | Number of heartbeats                                  |
| HISTOGRAM\_LEADER\_ITERATION\_WAIT\_DURATION\_CONFIG\_ALIGNMENT | Wait duration of leader iteration for all nodes to align on the latest configuration generation                       | Leader iteration wait time                            |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME\_OLD                        | The number of leader heartbeats per processing time range (OLD)                                                       | Number of heartbeats                                  |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME                             | The number of leader heartbeats per processing time range                                                             | Number of heartbeats                                  |
| LOCAL\_STATS\_FETCH\_GENERATION\_LAGGING                        | The number of local-state generations that the parent fetch request still needs to read                               | local-state generations                               |
| LOCALSTATE\_AGGREGATION\_LATENCY                                | This period is between the clockSkewReportTime table's update by a management process and the time the leader sees it | Time is taken to aggregate LocalState in milliseconds |
| OVERLAY\_FULL\_SHIFTS                                           | The number of entire overlay shifts                                                                                   | Changes                                               |
| OVERLAY\_INCREMENTAL\_SHIFTS                                    | The number of incremental overlay shifts                                                                              | Changes                                               |
| OVERLAY\_TRACKER\_INCREMENTALS                                  | The number of incremental OverlayTracker applications                                                                 | Changes                                               |
| OVERLAY\_TRACKER\_RESYNCS                                       | The number of OverlayTracker full-resyncs                                                                             | Changes                                               |
| TOTAL\_CHANGESETS\_COMMITTED                                    | The total number of committed changesets                                                                              | Change Sets                                           |
| TOTAL\_COMMITTED\_CHANGES                                       | The total number of committed configuration change sets                                                               | Changes                                               |
| TOTAL\_CONFIG\_SNAPSHOT\_PULLS                                  | The total number of config snapshot pulls                                                                             | Pulls                                                 |
| TOTAL\_GENERATIONS\_COMMITTED                                   | The number of committed generations                                                                                   | Generations                                           |

### CPU

| **Type**         | **Description**                                       | **Units** |
| ---------------- | ----------------------------------------------------- | --------- |
| CPU\_UTILIZATION | The percentage of the CPU time used for handling I/Os | %         |

### Dataservice

| **Type**                                       | **Description**                                              | **Units**    |
| ---------------------------------------------- | ------------------------------------------------------------ | ------------ |
| DIFFLIST\_GET\_LATENCY                         | Average latency of getDifflist                               | Microseconds |
| DIFFLIST\_GET\_MANIFEST\_LATENCY               | Average latency of getDifflist getManifest                   | Microseconds |
| DIFFLIST\_GET\_MANIFEST\_OPS                   | Number of getDifflist getManifest                            | Ops/Sec      |
| DIFFLIST\_GET\_MANIFEST\_PER\_GETLIST\_LATENCY | Average latency of getDifflist getmanifest per getdifflist   | Microseconds |
| DIFFLIST\_GET\_MANIFEST\_PER\_GETLIST\_OPS     | Number of getDifflist getmanifest per getdifflist            | Ops/Sec      |
| DIFFLIST\_GET\_OPS                             | Number of getDifflist                                        | Ops/Sec      |
| DIFFLIST\_RESOLVE\_PATH\_BATCH\_LATENCY        | Average latency of getDifflist resolve-path per batch        | Microseconds |
| DIFFLIST\_RESOLVE\_PATH\_BATCH\_OPS            | Number of getDifflist resolve-path per batch                 | Ops/Sec      |
| DIFFLIST\_RESOLVEPATH\_LATENCY                 | Average latency of getDifflist resolvepath                   | Microseconds |
| DIFFLIST\_RESOLVEPATH\_OPS                     | Number of getDifflist resolvepath                            | Ops/Sec      |
| QUOTA\_TASK\_ADD\_DIR\_ENTRIES                 | Number of entries added for directory quota task             | Ops          |
| QUOTA\_TASK\_CREATES                           | Number of directory quota tasks created                      | Ops          |
| QUOTA\_TASK\_DELETE\_DIR\_ENTRIES              | Number of entries removed for directory quota task           | Ops          |
| QUOTA\_TASK\_DELETES                           | Number of directory quota tasks removed                      | Ops          |
| QUOTA\_TASK\_FAILED\_STAMPS                    | Number of failed quota coloring stamp operations             | Ops          |
| QUOTA\_TASK\_FIBERS                            | Number of directory quota task fibers spawned per second     | Fibers       |
| QUOTA\_TASK\_READDIR\_LATENCY                  | Average latency of directory quota task readdir operations   | Microseconds |
| QUOTA\_TASK\_READDIR\_OPS                      | Number of directory quota task readdir operations per second | Ops/Sec      |
| QUOTA\_TASK\_RUNTIME                           | Average runtime of directory quota task fibers               | Microseconds |
| QUOTA\_TASK\_STAMP\_LATENCY                    | Average latency of directory quota task stamp operations     | Microseconds |
| QUOTA\_TASK\_STAMPS                            | Number of directory quota stamp operations per second        | Ops/Sec      |
| QUOTA\_TASK\_SUCCESSFUL\_STAMPS                | Number of successful directory quota stamp operations        | Ops          |
| QUOTAS\_MARKED                                 | Number of directory quotas marked                            | Quotas       |

### ExecTime

| **Type**        | **Description**                                                                      | **Units**    |
| --------------- | ------------------------------------------------------------------------------------ | ------------ |
| EXECTIME\_AVG   | Average execution time (usec) of function calls that ran for over the threshold time | Microseconds |
| EXECTIME\_COUNT | Number of times the function was called and ran for over the threshold time          | Executions   |

### Frontend

| **Type**         | **Description**                                                           | **Units**  |
| ---------------- | ------------------------------------------------------------------------- | ---------- |
| FE\_IDLE\_CYCLES | The number of idle cycles on the frontend                                 | Cycles/Sec |
| FE\_IDLE\_TIME   | The percentage of the CPU time not used for handling I/Os on the frontend | %          |

### JRPC (API)

| **Type**                                             | **Description**                                                                                  | **Units**    |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------ | ------------ |
| JRPC\_SERVER\_CALLS\_CLIENT\_DOES\_NOT\_SUPPORT\_QOS | The number of JRPC calls made from a client that does not support JRPC QoS                       | Requests/Sec |
| JRPC\_SERVER\_CALLS\_CLIENT\_SUPPORTS\_QOS           | The number of JRPC calls made from a client that supports JRPC QoS                               | Requests/Sec |
| JRPC\_SERVER\_CALLS\_QOS\_DECLINED                   | The number of JRPC calls where server returns TOO\_MANY\_REQUESTS (QoS declined to run a method) | Requests/Sec |
| JRPC\_SERVER\_PROCESSING\_AVG                        | The average time the JRPC server processed the JRPC requests                                     | Microseconds |
| JRPC\_SERVER\_PROCESSING\_TIME                       | The number of JRPC requests processed by the server per time range                               | Requests     |

### Memory

| **Type**     | **Description**                                                     | **Units** |
| ------------ | ------------------------------------------------------------------- | --------- |
| GC\_CURRENT  | The process (node) GC memory size, current in sample time           | Bytes     |
| GC\_PEAK     | The process (node) GC memory size, peak over 1-minute intervals     | Bytes     |
| RSS\_CURRENT | The process (node) memory resident size, current in sample time     | MB        |
| RSS\_PEAK    | The process (node) memory resident size, peak over process lifetime | MB        |

### Network

| **Type**                                | **Description**                                                                                                     | **Units**              |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| ACKS\_LOST                              | Number of lost ACK packets                                                                                          | Packets/Sec            |
| ACKS\_REORDERED                         | Number of reordered ACK packets                                                                                     | Packets/Sec            |
| BAD\_RECV\_CSUM                         | Number of packets received with a bad checksum                                                                      | Packets/Sec            |
| CORRUPT\_PACKETS                        | Number of packets received and deemed corrupted                                                                     | Packets/Sec            |
| DOUBLY\_RECEIVED\_PACKETS               | Number of packets that were received multiple times                                                                 | Packets/Sec            |
| DROPPED\_LARGE\_PACKETS                 | Number of large packets dropped in the socket backend                                                               | Packets/Sec            |
| DROPPED\_PACKETS                        | Number of packets received that we dropped                                                                          | Packets/Sec            |
| ECN\_ENCOUNTERED                        | Number of ECN Encountered packets                                                                                   | Packets/Sec            |
| FAULT\_RECV\_DELAYED\_PACKETS           | Number of received packets delayed due to a fault injection                                                         | Packets/Sec            |
| FAULT\_RECV\_DROPPED\_PACKETS           | Number of received packets dropped due to a fault injection                                                         | Packets/Sec            |
| FAULT\_SENT\_DELAYED\_PACKETS           | Number of sent packets delayed due to a fault injection                                                             | Packets/Sec            |
| FAULT\_SENT\_DROPPED\_PACKETS           | Number of sent packets dropped due to a fault injection                                                             | Packets/Sec            |
| FRAGMENTATION\_DUPS                     | Number of packets duplicated during fragmentation                                                                   | Packets/Sec            |
| GOODPUT\_RX\_RATIO                      | Percentage of goodput RX packets out of total data packets received                                                 | %                      |
| GOODPUT\_TX\_RATIO                      | Percentage of goodput TX packets out of total data packets sent                                                     | %                      |
| GW\_MAC\_RESOLVE\_FAILURES              | Number of times we failed to ARP resolve the gateway IP                                                             | Failures               |
| GW\_MAC\_RESOLVE\_SUCCESSES             | Number of times we succeeded in ARP resolving the gateway IP                                                        | Successes              |
| INVALID\_FIRST\_FRAGMENT                | Number of times we got an invalid first fragment                                                                    | Packets/Sec            |
| MBUF\_DUP\_COUNT                        | Number of Duplicate mbufs found                                                                                     | Occurrences            |
| MBUF\_DUP\_ITER                         | Duplicate mbuf check completions                                                                                    | Occurrences            |
| NDP\_DAD\_RECV\_ADDR\_CONFLICTS         | NDP DAD Receive Address Conflict Detected                                                                           | Packets/Sec            |
| NDP\_DAD\_RECV\_NO\_CONFLICTS           | NDP DAD Receive No Conflict                                                                                         | Packets/Sec            |
| NODE\_RECONNECTED                       | Number of reconnections                                                                                             | Reconnects/Sec         |
| PACKET\_ALIGN\_BYTES\_COPIED            | Number of bytes copied during receive for packet alignment                                                          | Bytes/Sec              |
| PACKET\_COMBINE\_BYTES\_COPIED          | Number of bytes copied during receive packet buffer combining                                                       | Bytes/Sec              |
| PACKETS\_FAILING\_COMBINE               | Number of packets received that failed buffer combining                                                             | Packets/Sec            |
| PACKETS\_NEEDING\_ALIGN                 | Number of packets received that needed alignment adjustment                                                         | Packets/Sec            |
| PACKETS\_NEEDING\_COMBINE               | Number of packets received that needed buffer combining                                                             | Packets/Sec            |
| PACKETS\_PUMPED                         | Number of packets received in each call to recvPackets                                                              | Batches                |
| PACKETS\_VLAN\_INSERTED\_HW             | Number of packets sent with hardware-inserted VLAN tag                                                              | Packets/Sec            |
| PACKETS\_VLAN\_INSERTED\_SW             | Number of packets sent with software-inserted VLAN tag                                                              | Packets/Sec            |
| PACKETS\_VLAN\_STRIPPED\_HW             | Number of packets received with hardware stripped VLAN tag                                                          | Packets/Sec            |
| PACKETS\_VLAN\_STRIPPED\_SW             | Number of packets received with software stripped VLAN tag                                                          | Packets/Sec            |
| PEER\_RTT\_BACKEND                      | RTT histogram                                                                                                       | Microseconds           |
| PEER\_RTT\_CLIENT                       | RTT histogram                                                                                                       | Microseconds           |
| POISON\_DETECTED\_EXPECTED              | Expected number of poisoned netbufs detected                                                                        | Occurrences            |
| POISON\_DETECTED\_UNEXPECTED            | Unexpected number of poisoned netbufs detected                                                                      | Occurrences            |
| POISON\_DETECTED                        | Number of poisoned netbufs detected                                                                                 | Occurrences            |
| PORT\_EXT\_RX\_PACKETS                  | Number of external packets received                                                                                 | Packets/Sec            |
| PORT\_RX\_BYTES                         | Number of bytes received                                                                                            | Bytes/Sec              |
| PORT\_RX\_ERRORS                        | Number of packet RX errors                                                                                          | Packets/Sec            |
| PORT\_RX\_MISSED                        | Number of packets lost due to RX queue full                                                                         | Packets/Sec            |
| PORT\_RX\_NO\_MBUFS                     | Number of packets lost due to no mbufs                                                                              | Packets/Sec            |
| PORT\_RX\_PACKETS                       | Number of packets received                                                                                          | Packets/Sec            |
| PORT\_TX\_BYTES                         | Number of bytes transmitted                                                                                         | Bytes/Sec              |
| PORT\_TX\_ERRORS                        | Number of packet TX errors                                                                                          | Packets/Sec            |
| PORT\_TX\_PACKETS                       | Number of packets transmitted                                                                                       | Packets/Sec            |
| PUMP\_DURATION                          | Duration of each pump                                                                                               | Requests               |
| PUMP\_INTERVAL                          | Interval between pumps                                                                                              | Requests               |
| PUMPS\_TXQ\_FULL                        | Number of times we couldn't send any new packets to the NIC queue                                                   | Pumps/Sec              |
| PUMPS\_TXQ\_PARTIAL                     | Number of times we only sent some of our queued packets to the NIC queue                                            | Pumps/Sec              |
| RDMA\_ADD\_CHUNK\_FAILURES              | Number of RDMA cookie setting failures                                                                              | Failures/Sec           |
| RDMA\_AHCACHE\_POPULATIONS              | Number of RDMA RDMA AH cache population attempts                                                                    | Attempts/Sec           |
| RDMA\_BINDING\_FAILOVERS                | Number of RDMA High-Availability fail-overs                                                                         | Fail-overs/Sec         |
| RDMA\_CANCELED\_COMPLETIONS             | Number of RDMA completions that were canceled                                                                       | Completions/Sec        |
| RDMA\_CLIENT\_BINDING\_INVALIDATIONS    | Number of RDMA client binding invalidations                                                                         | Invalidations/Sec      |
| RDMA\_COMP\_DURATION                    | Histogram of RDMA completion duration times                                                                         | Requests               |
| RDMA\_COMP\_FAILURES                    | Number of RDMA requests that were completed with an error                                                           | Failures/Sec           |
| RDMA\_COMP\_LATENCY                     | Average time of RDMA requests completion                                                                            | Microseconds           |
| RDMA\_COMP\_STATUSES                    | Histogram of RDMA completion statuses                                                                               | Completions/Sec        |
| RDMA\_COMPLETIONS                       | Number of RDMA requests that were completed                                                                         | Completions/Sec        |
| RDMA\_FAILED\_AHCACHE\_POPULATIONS      | Number of failed RDMA AH cache population attempts                                                                  | Failed Attempts/Sec    |
| RDMA\_FALLBACK\_WHILE\_AH\_POPULATE     | Number of fallbacks from RDMA due to AH cache population in progress                                                | Fallbacks/Sec          |
| RDMA\_NET\_ERR\_RETRY\_EXCEEDED         | Number of RDMA requests with error retries exceeded                                                                 | Occurrences/Sec        |
| RDMA\_NO\_LINK\_LAYER                   | Number of RDMA lid parsing due to no link layer                                                                     | RDMA-No-Link-Layer/Sec |
| RDMA\_POOL\_ALLOC\_FAILED               | Number of times an RDMA request was not issued due to a pool allocation failure                                     | Failures/Sec           |
| RDMA\_POOL\_LOW\_CAPACITY               | Number of times an RDMA request was not issued due to low RDMA pool memory                                          | Failures/Sec           |
| RDMA\_POOL\_MBUF\_LEAKED                | RDMA leaked mbufs                                                                                                   | Occurrences            |
| RDMA\_PORT\_WAITING\_FIBERS             | Number of fibers pending to send an RDMA request                                                                    | Waiting fibers         |
| RDMA\_REQUESTS                          | Number of RDMA requests sent to the NIC                                                                             | Requests/Sec           |
| RDMA\_RX\_BYTES                         | Number of bytes received with RDMA                                                                                  | Bytes/Sec              |
| RDMA\_SERVER\_BINDING\_RESTARTS         | Number of RDMA server binding restarts                                                                              | Restarts/Sec           |
| RDMA\_SERVER\_FAILED\_BINDING\_RESTARTS | Number of failed RDMA server binding restarts                                                                       | Failed Restarts/Sec    |
| RDMA\_SERVER\_RECV\_FAILURES            | Number of failed RDMA server-side receive attempts                                                                  | Failures/Sec           |
| RDMA\_SERVER\_SEND\_FAILURES            | Number of failed RDMA server-side send attempts                                                                     | Failures/Sec           |
| RDMA\_SUBMIT\_FAILURES                  | Number of RDMA submit failures, likely indicating a fabric issue                                                    | Failures/Sec           |
| RDMA\_SUBMIT\_TIMEOUTS                  | Number of RDMA submit timeouts                                                                                      | Timeouts/Sec           |
| RDMA\_TX\_BYTES                         | Number of bytes sent with RDMA                                                                                      | Bytes/Sec              |
| RDMA\_WAIT\_INTERRUPTED                 | RDMA Wait interruptions                                                                                             | Issues                 |
| RDMA\_WAIT\_PREMATURE\_WAKEUP           | RDMA Wait for premature wakeup                                                                                      | Issues                 |
| RDMA\_WAIT\_TIMEOUT                     | RDMA Wait timeouts                                                                                                  | Issues/Sec             |
| RECEIVED\_ACK\_PACKETS                  | Number of received ack packets                                                                                      | Packets/Sec            |
| RECEIVED\_CONTROL\_PACKETS              | Number of received control packets                                                                                  | Packets/Sec            |
| RECEIVED\_DATA\_PACKETS                 | Number of received data packets                                                                                     | Packets/Sec            |
| RECEIVED\_PACKET\_GENERATIONS           | The generation ("resend count") of the first incarnation of the packet seen by the receiver (indicates packet loss) | Packets                |
| RECEIVED\_PACKETS                       | Number of packets received                                                                                          | Packets/Sec            |
| RECEIVED\_PING\_PACKETS                 | Number of received ping packets                                                                                     | Packets/Sec            |
| RECEIVED\_PONG\_PACKETS                 | Number of received pong packets                                                                                     | Packets/Sec            |
| RECEIVED\_REJECT\_PACKETS               | Number of received reject packets                                                                                   | Packets/Sec            |
| RECEIVED\_SYNC\_PACKETS                 | Number of received sync packets                                                                                     | Packets/Sec            |
| REORDERED\_PACKETS                      | Number of reordered packets                                                                                         | Packets/Sec            |
| RESEND\_BATCH\_SIZE                     | Number of packets sent in a resend batch                                                                            | Batches                |
| RESENT\_DATA\_PACKETS                   | Number of data packets resent                                                                                       | Packets/Sec            |
| SEND\_BATCH\_SIZE\_BYTES                | Number of bytes sent in a first send batch                                                                          | Batches                |
| SEND\_BATCH\_SIZE                       | Number of packets sent in a first send batch                                                                        | Batches                |
| SEND\_QUEUE\_TIMEOUTS                   | Number of packets canceled due to envelope timeout and were not in the send window                                  | Packets/Sec            |
| SEND\_WINDOW\_TIMEOUTS                  | Number of packets canceled due to envelope timeout while in the send window                                         | Packets/Sec            |
| SENT\_ACKS                              | Number of ACK packets sent                                                                                          | Packets/Sec            |
| SENT\_CONTROL\_PACKETS                  | Number of control packets sent                                                                                      | Packets/Sec            |
| SENT\_DATA\_PACKETS                     | Number of data packets sent                                                                                         | Packets/Sec            |
| SENT\_PACKETS                           | Number of sent packets                                                                                              | Packets/Sec            |
| SENT\_REJECTS                           | Number of rejects sent                                                                                              | Packets/Sec            |
| SHORT\_CIRCUIT\_SENDS                   | Number of packets sent to the same node                                                                             | Packets/Sec            |
| SLOW\_PATH\_CSUM                        | Number of packets that went through checksum calculation on the CPU                                                 | Packets/Sec            |
| TIME\_TO\_ACK                           | Histogram of time to acknowledge a data packet                                                                      | Requests               |
| TIME\_TO\_FIRST\_SEND                   | Time from queueing to first send                                                                                    | Requests               |
| TIMELY\_RESENDS                         | Number of packets resent due to timely resend                                                                       | Packets/Sec            |
| UCX\_RXQ\_FULL                          | UCX Drop RXQ Full                                                                                                   | Packets/Sec            |
| UCX\_SEND\_CB                           | UCX Send Callback                                                                                                   | Packets/Sec            |
| UCX\_SEND\_ERROR                        | UCX Send Error                                                                                                      | Packets/Sec            |
| UCX\_SENT\_PACKETS\_ASYNC               | UCX Sent Asynchronously                                                                                             | Packets/Sec            |
| UCX\_SENT\_PACKETS\_IMMEDIATE           | UCX Sent Immediately                                                                                                | Packets/Sec            |
| UCX\_TXQ\_FULL                          | UCX Drop TXQ Full                                                                                                   | Packets/Sec            |
| UDP\_SENDMSG\_FAILED\_EAGAIN            | Number of packets that failed to be sent on the socket backend with EAGAIN                                          | Packets/Sec            |
| UDP\_SENDMSG\_FAILED\_OTHER             | Number of packets that failed to be sent on the socket backend with an unknown error                                | Packets/Sec            |
| UDP\_SENDMSG\_PARTIAL\_SEND             | Number of packets that we failed to send, but in the same pump, some packets were sent                              | Packets/Sec            |
| UNACKED\_RESENDS                        | Number of packets resent after receiving an ack                                                                     | Packets/Sec            |
| ZERO\_CSUM\_OVERWRITE                   | Number of packets with zero checksum that were overwritten with 0xFFFF                                              | Packets/Sec            |
| ZERO\_CSUM                              | Number of checksum zero received                                                                                    | Packets/Sec            |

### Node transitions

| **Type**                          | **Description**                                             | **Units**       |
| --------------------------------- | ----------------------------------------------------------- | --------------- |
| JOINING\_FENCED\_REASON\_COUNTS   | Counts of reasons JOINING nodes were fenced                 | Occurrences/Sec |
| JOINING\_TO\_UP\_TRANSITIONS      | Number of nodes transitioned from JOINING to UP             | Nodes           |
| SYNC\_TO\_JOIN\_FAILURE\_COUNTS   | Counts of SYNCING to JOINING failures categorized by reason | Occurrences/Sec |
| SYNCING\_TO\_JOINING\_TRANSITIONS | Number of nodes transitioned from SYNCING to JOINING        | Nodes           |
| UP\_FENCED\_REASON\_COUNTS        | Counts of reasons UP nodes were fenced                      | Occurrences/Sec |

### Operations

| **Type**                | **Description**                                | **Units**    |
| ----------------------- | ---------------------------------------------- | ------------ |
| ACCESS\_LATENCY         | Average latency of ACCESS operations           | Microseconds |
| ACCESS\_OPS             | Number of ACCESS operations per second         | Ops/Sec      |
| COMMIT\_LATENCY         | Average latency of COMMIT operations           | Microseconds |
| COMMIT\_OPS             | Number of COMMIT operations per second         | Ops/Sec      |
| CREATE\_LATENCY         | Average latency of CREATE operations           | Microseconds |
| CREATE\_OPS             | Number of CREATE operations per second         | Ops/Sec      |
| FILEATOMICOPEN\_LATENCY | Average latency of FILEATOMICOPEN operations   | Microseconds |
| FILEATOMICOPEN\_OPS     | Number of FILEATOMICOPEN operations per second | Ops/Sec      |
| FILECLOSE\_LATENCY      | Average latency of FILECLOSE operations        | Microseconds |
| FILECLOSE\_OPS          | Number of FILECLOSE operations per second      | Ops/Sec      |
| FILEOPEN\_LATENCY       | Average latency of FILEOPEN operations         | Microseconds |
| FILEOPEN\_OPS           | Number of FILEOPEN operations per second       | Ops/Sec      |
| FLOCK\_LATENCY          | Average latency of FLOCK operations            | Microseconds |
| FLOCK\_OPS              | Number of FLOCK operations per second          | Ops/Sec      |
| FSINFO\_LATENCY         | Average latency of FSINFO operations           | Microseconds |
| FSINFO\_OPS             | Number of FSINFO operations per second         | Ops/Sec      |
| GETATTR\_LATENCY        | Average latency of GETATTR operations          | Microseconds |
| GETATTR\_OPS            | Number of GETATTR operations per second        | Ops/Sec      |
| LINK\_LATENCY           | Average latency of LINK operations             | Microseconds |
| LINK\_OPS               | Number of LINK operations per second           | Ops/Sec      |
| LOOKUP\_LATENCY         | Average latency of LOOKUP operations           | Microseconds |
| LOOKUP\_OPS             | Number of LOOKUP operations per second         | Ops/Sec      |
| MKDIR\_LATENCY          | Average latency of MKDIR operations            | Microseconds |
| MKDIR\_OPS              | Number of MKDIR operations per second          | Ops/Sec      |
| MKNOD\_LATENCY          | Average latency of MKNOD operations            | Microseconds |
| MKNOD\_OPS              | Number of MKNOD operations per second          | Ops/Sec      |
| OPS                     | Total number of operations                     | Ops/Sec      |
| PATHCONF\_LATENCY       | Average latency of PATHCONF operations         | Microseconds |
| PATHCONF\_OPS           | Number of PATHCONF operations per second       | Ops/Sec      |
| READ\_BYTES             | Number of bytes read per second                | Bytes/Sec    |
| READ\_DURATION          | The number of reads per completion duration    | Reads        |
| READ\_LATENCY           | Average latency of READ operations             | Microseconds |
| READDIR\_LATENCY        | Average latency of READDIR operations          | Microseconds |
| READDIR\_OPS            | Number of READDIR operations per second        | Ops/Sec      |
| READLINK\_LATENCY       | Average latency of READLINK operations         | Microseconds |
| READLINK\_OPS           | Number of READLINK operations per second       | Ops/Sec      |
| READS                   | Number of read operations per second           | Ops/Sec      |
| REMOVE\_LATENCY         | Average latency of REMOVE operations           | Microseconds |
| REMOVE\_OPS             | Number of REMOVE operations per second         | Ops/Sec      |
| RENAME\_LATENCY         | Average latency of RENAME operations           | Microseconds |
| RENAME\_OPS             | Number of RENAME operations per second         | Ops/Sec      |
| RMDIR\_LATENCY          | Average latency of RMDIR operations            | Microseconds |
| RMDIR\_OPS              | Number of RMDIR operations per second          | Ops/Sec      |
| SETATTR\_LATENCY        | Average latency of SETATTR operations          | Microseconds |
| SETATTR\_OPS            | Number of SETATTR operations per second        | Ops/Sec      |
| STATFS\_LATENCY         | Average latency of STATFS operations           | Microseconds |
| STATFS\_OPS             | Number of STATFS operations per second         | Ops/Sec      |
| SYMLINK\_LATENCY        | Average latency of SYMLINK operations          | Microseconds |
| SYMLINK\_OPS            | Number of SYMLINK operations per second        | Ops/Sec      |
| THROUGHPUT              | Number of bytes read/write per second          | Bytes/Sec    |
| UNLINK\_LATENCY         | Average latency of UNLINK operations           | Microseconds |
| UNLINK\_OPS             | Number of UNLINK operations per second         | Ops/Sec      |
| WRITE\_BYTES            | Number of byte writes per second               | Bytes/Sec    |
| WRITE\_DURATION         | The number of writes per completion duration   | Writes       |
| WRITE\_LATENCY          | Average latency of WRITE operations            | Microseconds |
| WRITES                  | Number of write operations per second          | Ops/Sec      |

### Platform

| **Type**                      | **Description**                                  | **Units**     |
| ----------------------------- | ------------------------------------------------ | ------------- |
| REPORTED\_MMAP\_ALLOC\_MEM    | Memory allocated through reportedMmaps, in bytes | Bytes         |
| REPORTED\_MMAP\_ALLOCS        | Number of reported mmap allocations              | Allocations   |
| REPORTED\_MMAP\_DEALLOCS      | Number of reported mmap deallocations            | Deallocations |
| REPORTED\_MMAP\_RESERVED\_MEM | Memory reserved for reportedMmaps, in bytes      | Bytes         |

### Processes

| **Type**                  | **Description**                                                     | **Units**               |
| ------------------------- | ------------------------------------------------------------------- | ----------------------- |
| ABRUPT\_EXITS             | How many abrupt exits of a process (node) occurred                  | Abrupt process exits    |
| PEER\_CONFIGURE\_FAILURES | How many times the node failed to configure peers to sync with them | Peer configure failures |

### RAFT

| **Type**                           | **Description**                                     | **Units** |
| ---------------------------------- | --------------------------------------------------- | --------- |
| Bucket\_LEADER\_CHANGES            | Changes of leader                                   | Changes   |
| Bucket\_REQUESTS\_COMPLETED        | Requests to leader completed successfully           | Requests  |
| Configuration\_LEADER\_CHANGES     | Changes of leader                                   | Changes   |
| Configuration\_REQUESTS\_COMPLETED | Requests to leader completed successfully           | Requests  |
| Invalid\_LEADER\_CHANGES           | Changes of leader                                   | Changes   |
| Invalid\_REQUESTS\_COMPLETED       | Requests to leader completed successfully           | Requests  |
| RAFT\_BYTES\_WRITTEN               | Number of writes written to disk for RAFT           | Bytes     |
| SYNCLOG\_TIMEOUTS                  | The number of timeouts of syncing logs to a process | Timeouts  |
| Test\_LEADER\_CHANGES              | Changes of leader                                   | Changes   |
| Test\_REQUESTS\_COMPLETED          | Requests to leader completed successfully           | Requests  |

### RAID

| **Type**                                               | **Description**                                                            | **Units**       |
| ------------------------------------------------------ | -------------------------------------------------------------------------- | --------------- |
| IS\_BLOCK\_USED\_FREE\_LATENCY                         | Average latency of handling an isBlockUsed of a free block                 | Micros          |
| IS\_BLOCK\_USED\_FREE                                  | Number of isBlockUsed returning free                                       | Blocks/Sec      |
| IS\_BLOCK\_USED\_USED\_LATENCY                         | Average latency of handling an isBlockUsed of a used block                 | Micros          |
| IS\_BLOCK\_USED\_USED                                  | Number of isBlockUsed returning used                                       | Blocks/Sec      |
| NVKV\_RECOVERY\_NETBUF\_REREAD\_UNEQUAL                | Number of unequal netbufs encountered that caused NVKV recovery to restart | Blocks/Sec      |
| RAID\_ALLOCATION\_FAILED\_HOLES                        | Slots failed to be allocated and were left as holes                        | Holes/Sec       |
| RAID\_BLOCKS\_IN\_PREPARED\_STRIPE                     | Free blocks in prepared stripe                                             | Blocks          |
| RAID\_CHUNKS\_CLEANED\_BY\_SHIFT                       | Dirty chunks cleaned by being shifted out                                  | Occurrences     |
| RAID\_CHUNKS\_SHIFTED                                  | Dirty chunks that shifted out                                              | Occurrences     |
| RAID\_COMMITTED\_STRIPES                               | Number of stripes written                                                  | Stripes         |
| RAID\_COMPRESSED\_BLOCKS\_WRITTEN                      | Physical blocks are written containing compressed data                     | Blocks/Sec      |
| RAID\_COMPRESSED\_PADDING                              | Zero-Blocks written to compressed space for alignment                      | Blocks/Sec      |
| RAID\_CORRUPTION\_RECOVERY\_FAILURE                    | Corrupt data could not be recovered                                        | Occurrences     |
| RAID\_PLACEMENT\_ALLOC\_PlacementSpace0                | Number of placement allocations                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_ALLOC\_PlacementSpaceN\_Compressed    | Number of placement allocations                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_ALLOC\_PlacementSpaceN\_Uncompressed  | Number of placement allocations                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_RETIRE\_PlacementSpace0               | Number of placement retirements                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_RETIRE\_PlacementSpaceN\_Compressed   | Number of placement retirements                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_RETIRE\_PlacementSpaceN\_Uncompressed | Number of placement retirements                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_SWITCHES                              | Number of placement switches                                               | Switches        |
| RAID\_READ\_BATCHES\_PER\_REQUEST\_HISTOGRAM           | Histogram of the number of batches of stripes read in a single request     | Request         |
| RAID\_READ\_BLOCKS\_STRIPE\_HISTOGRAM                  | Histogram of the number of blocks read from a single stripe                | Reads           |
| RAID\_READ\_BLOCKS                                     | Number of blocks read by the RAID                                          | Blocks/Sec      |
| RAID\_READ\_DEGRADED                                   | Degraded mode reads                                                        | Blocks/Sec      |
| RAID\_READ\_FREE                                       | Read Free                                                                  | Occurences      |
| RAID\_READ\_IOS                                        | Raw read blocks performed by the RAID                                      | Blocks/Sec      |
| RAID\_STALE\_WRITES\_DETECTED                          | Stale write detected in read                                               | Occurrences     |
| RAID\_STALE\_WRITES\_REPROTECTIONS                     | Stale write reprotections in read                                          | Occurrences     |
| WRONG\_DRIVE\_DELTAS                                   | Delta segments are written to the wrong drive                              | Blocks/Sec      |
| WRONG\_DRIVE\_REFS                                     | Reference segments are written to the wrong drive                          | Blocks/Sec      |

### Reactor

| **Type**                                        | **Description**                                                                                                                                            | **Units**               |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| AVG\_QUEUE\_TIME\_FLEX\_TASKS                   | Average queue time of deferred flex tasks                                                                                                                  | Cycles                  |
| BACKGROUND\_CYCLES                              | Number of cycles spent in background fibers                                                                                                                | Cycles/Sec              |
| BACKGROUND\_FIBERS                              | Number of background fibers that are ready to run and eager to get CPU cycles                                                                              | Fibers                  |
| BACKGROUND\_TIME                                | The percentage of the CPU time used for background operations                                                                                              | %                       |
| BucketInvocationState\_CAPACITY                 | Number of data structures allocated to the BucketInvocationState pool                                                                                      | Structs                 |
| BucketInvocationState\_STRUCT\_SIZE             | Number of bytes in each struct of the BucketInvocationState pool                                                                                           | Bytes                   |
| BucketInvocationState\_USED                     | Number of structs in the BucketInvocationState pool that are currently being used                                                                          | Structs                 |
| CPU\_HANGS\_AND\_KNOWN\_HOGGER                  | Number of CPU hangs detected while known hogger                                                                                                            | Hangs/Sec               |
| CPU\_HANGS                                      | Number of CPU hangs detected                                                                                                                               | Hangs/Sec               |
| CYCLES\_PER\_SECOND                             | Number of cycles the CPU runs per second                                                                                                                   | Cycles/Sec              |
| DeferredTask2\_CAPACITY                         | Number of data structures allocated to the DeferredTask2 pool                                                                                              | Structs                 |
| DeferredTask2\_STRUCT\_SIZE                     | Number of bytes in each struct of the DeferredTask2 pool                                                                                                   | Bytes                   |
| DeferredTask2\_USED                             | Number of structs in the DeferredTask2 pool that are currently being used                                                                                  | Structs                 |
| DEFUNCT\_FIBERS                                 | Number of defunct buffers, which are just memory structures allocated for future fiber needs                                                               | Fibers                  |
| EXCEPTIONS                                      | Number of exceptions caught by the reactor                                                                                                                 | Exceptions/Sec          |
| FLEX\_TASKS\_INLINE\_FULLQUEUE                  | Number of flex tasks run inline on main thread due to full defer queue                                                                                     | Invocations/Sec         |
| FLEX\_TASKS\_INLINE\_LIGHTLOAD                  | Number of flex tasks run inline on main thread due to light load                                                                                           | Invocations/Sec         |
| FLEX\_TASKS\_INLINE\_OVERRIDE                   | Number of flex tasks run inline on main thread due to override                                                                                             | Invocations/Sec         |
| FLEX\_TASKS\_LATENCY                            | Histogram of flex tasks latency                                                                                                                            | usecs                   |
| FLEX\_TASKS\_QUEUED\_RUN\_MAINTHREAD            | Number of deferred flex tasks run by main thread                                                                                                           | Invocations/Sec         |
| FLEX\_TASKS\_QUEUED\_RUN\_THREADPOOL            | Number of deferred flex tasks run on thread pool                                                                                                           | Invocations/Sec         |
| FLEX\_TASKS\_QUEUED                             | Number of deferred flex tasks queued                                                                                                                       | Invocations/Sec         |
| FLEX\_TASKS\_SUBMITTED                          | Number of flex tasks submitted                                                                                                                             | Invocations/Sec         |
| IDLE\_CALLBACK\_INVOCATIONS                     | Number of background work invocations                                                                                                                      | Invocations/Sec         |
| IDLE\_CYCLES                                    | Number of cycles spent in idle                                                                                                                             | Cycles/Sec              |
| IDLE\_TIME                                      | The percentage of the CPU time not used for handling I/Os                                                                                                  | %                       |
| LINGERING\_FIBERS                               | Number of LINGERING fibers                                                                                                                                 | Fibers                  |
| MAIN\_THREAD\_DEFERRED\_FLEX\_TASK\_CYCLES      | Number of cycles main thread spent running deferred flex tasks                                                                                             | Cycles/Sec              |
| MAIN\_THREAD\_INLINE\_FLEX\_TASK\_CYCLES        | Number of cycles main thread spent running inline flex tasks                                                                                               | Cycles/Sec              |
| MAIN\_THREAD\_INLINE\_FLEX\_TASKS\_AVG\_RUNTIME | Average runtime of inline flex tasks run by the main thread                                                                                                | Cycles                  |
| MAIN\_THREAD\_QUEUED\_FLEX\_TASKS\_AVG\_RUNTIME | Average runtime of deferred flex tasks run by the main thread                                                                                              | Cycles                  |
| networkBuffers\_CAPACITY                        | Number of data structures allocated to the networkBuffers pool                                                                                             | Structs                 |
| networkBuffers\_USED                            | Number of structs in the networkBuffers pool that are currently being used                                                                                 | Structs                 |
| NODE\_CONTEXT\_SWITCHES                         | Number of context switches                                                                                                                                 | Switches                |
| NODE\_HANG                                      | The number of process (node) hangs per hang time range                                                                                                     | Number of hangs         |
| NODE\_POLL\_TIME                                | Time of scheduler stats polling                                                                                                                            | usecs                   |
| NODE\_RUN\_PERCENTAGE                           | Percentage of time process is running                                                                                                                      | percentage              |
| NODE\_RUN\_TIME                                 | Time process is running                                                                                                                                    | usecs                   |
| NODE\_WAIT\_PERCENTAGE                          | Percentage of time process is waiting on waitqueue                                                                                                         | percentage              |
| NODE\_WAIT\_TIME                                | The Time the process is waiting on the wait queue                                                                                                          | usecs                   |
| ObsBucketManagement\_CAPACITY                   | Number of data structures allocated to the ObsBucketManagement pool                                                                                        | Structs                 |
| ObsBucketManagement\_STRUCT\_SIZE               | Number of bytes in each struct of the ObsBucketManagement pool                                                                                             | Bytes                   |
| ObsBucketManagement\_USED                       | Number of structs in the ObsBucketManagement pool that are currently being used                                                                            | Structs                 |
| ObsGateway\_CAPACITY                            | Number of data structures allocated to the ObsGateway pool                                                                                                 | Structs                 |
| ObsGateway\_STRUCT\_SIZE                        | Number of bytes in each struct of the ObsGateway pool                                                                                                      | Bytes                   |
| ObsGateway\_USED                                | Number of structs in the ObsGateway pool that are currently being used                                                                                     | Structs                 |
| OUTRAGEOUS\_HOGGERS                             | Number of hoggers taking an excessive amount of time to run                                                                                                | Invocations             |
| PENDING\_FIBERS                                 | Number of fibers pending for external events, such as a network packet or SSD response. Upon such an external event, they change state to scheduled fibers | Fibers                  |
| QUEUE\_TIME\_FLEX\_TASK\_CYCLES                 | Queue time of deferred flex tasks                                                                                                                          | Cycles/Sec              |
| rdmaNetworkBuffers\_CAPACITY                    | Number of data structures allocated to the rdmaNetworkBuffers pool                                                                                         | Structs                 |
| rdmaNetworkBuffers\_USED                        | Number of structs in the rdmaNetworkBuffers pool that are currently being used                                                                             | Structs                 |
| RELENTLESS\_CYCLES                              | Number of cycles spent in relentless fibers                                                                                                                | Cycles/Sec              |
| RELENTLESS\_FIBERS                              | Number of relentless fibers that are ready to run and eager to get CPU cycles                                                                              | Fibers                  |
| SCHEDULED\_FIBERS                               | Number of current fibers that are ready to run and eager to get CPU cycles                                                                                 | Fibers                  |
| SLEEPY\_FIBERS                                  | Number of SLEEPY fibers                                                                                                                                    | Fibers                  |
| SLEEPY\_RPC\_SERVER\_FIBERS                     | Number of SLEEPY RPC server fibers                                                                                                                         | Sleepy fiber detections |
| SSD\_CAPACITY                                   | Number of data structures allocated to the SSD pool                                                                                                        | Structs                 |
| SSD\_STRUCT\_SIZE                               | Number of bytes in each struct of the SSD pool                                                                                                             | Bytes                   |
| SSD\_USED                                       | Number of structs in the SSD pool that are currently being used                                                                                            | Structs                 |
| STEP\_CYCLES                                    | Histogram of time spent in a fiber                                                                                                                         | Fiber steps             |
| THREAD\_POOL\_DEFERRED\_TASK\_CYCLES            | Number of cycles thread pool spent running deferred tasks                                                                                                  | Cycles/Sec              |
| THREAD\_POOL\_FLEX\_TASK\_CYCLES                | Number of cycles the thread pool spent running flex tasks                                                                                                  | Cycles/Sec              |
| THREAD\_POOL\_QUEUED\_FLEX\_TASKS\_AVG\_RUNTIME | Average runtime of deferred flex tasks run on thread pool                                                                                                  | Cycles                  |
| THREAD\_POOL\_TASK\_INVOCATIONS                 | Number of tasks run by thread pool                                                                                                                         | Invocations/Sec         |
| TimedCallback\_CAPACITY                         | Number of data structures allocated to the TimedCallback pool                                                                                              | Structs                 |
| TimedCallback\_STRUCT\_SIZE                     | Number of bytes in each struct of the TimedCallback pool                                                                                                   | Bytes                   |
| TimedCallback\_USED                             | Number of structs in the TimedCallback pool that are currently being used                                                                                  | Structs                 |
| TIMER\_CALLBACKS                                | Current number of timer callbacks                                                                                                                          | Callbacks               |
| TOTAL\_FIBERS\_COUNT                            | Number of fibers                                                                                                                                           | Fibers                  |
| UploadFileInfo\_CAPACITY                        | Number of data structures allocated to the UploadFileInfo pool                                                                                             | Structs                 |
| UploadFileInfo\_STRUCT\_SIZE                    | Number of bytes in each struct of the UploadFileInfo pool                                                                                                  | Bytes                   |
| UploadFileInfo\_USED                            | Number of structs in the UploadFileInfo pool that are currently being used                                                                                 | Structs                 |

### RPC

| **Type**                           | **Description**                                                    | **Units**    |
| ---------------------------------- | ------------------------------------------------------------------ | ------------ |
| CLIENT\_CANCELED\_REQUESTS         | Number of requests canceled by the client                          | Calls/Sec    |
| CLIENT\_DROPPED\_RESPONSES         | Number of responses dropped by the client                          | Calls/Sec    |
| CLIENT\_ENCRYPTION\_AUTH\_FAILURES | Number of authentication failures by the client                    | Calls/Sec    |
| CLIENT\_MISSING\_ENCRYPTION\_KEY   | Number of times the client was missing an encryption key           | Calls/Sec    |
| CLIENT\_RECEIVED\_EXCEPTIONS       | Number of exceptions received by the client                        | Calls/Sec    |
| CLIENT\_RECEIVED\_RESPONSES        | Number of responses received by the client                         | Calls/Sec    |
| CLIENT\_RECEIVED\_TIMEOUTS         | Number of timeouts experienced by the client                       | Calls/Sec    |
| CLIENT\_ROUNDTRIP\_AVG\_LOW        | Round-trip average of client low-priority RPC calls                | Microseconds |
| CLIENT\_ROUNDTRIP\_AVG\_NORM       | Round-trip average of client normal priority RPC calls             | Microseconds |
| CLIENT\_ROUNDTRIP\_AVG             | Round-trip average of client normal and low-priority RPC calls     | Microseconds |
| CLIENT\_RPC\_CALLS\_DOWNGRADED     | Number of client-downgraded RPC calls                              | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_LOW            | Number of low-priority RPC calls                                   | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_NORM           | Number of normal priority RPC calls                                | RPC/Sec      |
| CLIENT\_RPC\_CALLS                 | Number of all priorities of RPC calls                              | RPC/Sec      |
| CLIENT\_SENT\_REQUESTS             | Number of requests sent by the client                              | Calls/Sec    |
| DEUS\_EX\_MBUF\_LIMITED            | Number of RPCs slow down due to low MBuf reserves                  | Ops/Sec      |
| DEUS\_EX\_NO\_FIBERS               | Number of RPCs put in DeusEx due to lack of global fibers          | Ops/Sec      |
| DEUS\_EX\_NOT\_EMPTY               | Number of RPCs put in DeusEx to preserve RPC order                 | Ops/Sec      |
| DEUS\_EX\_RPC\_MAX\_FIBERS         | Number of RPCs put in DeusEx due to RPC max fibers                 | Ops/Sec      |
| FIRST\_RESULTS                     | Number of first results per second                                 | Ops/Sec      |
| MBUF\_LIMITED\_SLEEP               | Number of times wait due to low MBuf reserves                      | Actions/Sec  |
| RPC\_ENCRYPTION\_SETUP\_FAILURES   | Number of encryption key setup failures                            | Failures     |
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

### Scrubber

| **Type**                                | **Description**                                                                                                      | **Units**       |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | --------------- |
| BLOCK\_CONSISTENCY\_CHECK\_LATENCY      | Average latency of checking block consistency                                                                        | Micros          |
| BLOCK\_CONSISTENCY\_CHECKS              | Number of blocks that were checked for consistency against their block-used-state                                    | Blocks/Sec      |
| CLEANED\_CHUNKS                         | Number of chunks that were cleaned by the scrubber                                                                   | Chunks/Sec      |
| DEGRADED\_READS                         | Number of degraded reads for scrubbing                                                                               | Requests/Sec    |
| FALSE\_USED\_CHECK\_LATENCY             | Average latency of checking false used per block                                                                     | Micros          |
| FALSE\_USED\_EXTRA\_NOTIFIED            | Number of blocks that were notified as used by the mark-extra-used mechanism                                         | Blocks/Sec      |
| INTERRUPTS                              | Number of scrubs that were interrupted                                                                               | Occurrences/Sec |
| NETWORK\_BUDGET\_WAIT\_LATENCY          | Average latency of waiting for our network budget                                                                    | Micros          |
| NOT\_REALLY\_DIRTY\_BLOCKS              | Number of marked dirty blocks that ScrubMissingWrites found were clean                                               | Blocks/Sec      |
| NUM\_COPY\_DISCARDED\_BLOCKS            | Number of copied blocks that were discarded                                                                          | Blocks/Sec      |
| NUM\_COPY\_DISCARDS                     | Number of times we discarded scrubber copy work                                                                      | Occurrences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARD\_BLOCKS | Number of blocks that were discarded due to invented stripes                                                         | Blocks/Sec      |
| NUM\_INVENTED\_STRIPES\_DISCARDS        | Number of times we discarded all scrubber work due to invented stripes                                               | Occurrences/Sec |
| NUM\_SCRUBBER\_DISCARD\_INTERMEDIATES   | Number of times we discarded all intermediate scrubber work                                                          | Occurrences/Sec |
| NUM\_SMW\_DISCARDED\_BLOCKS             | Number of SMW'd blocks that were discarded                                                                           | Blocks/Sec      |
| NUM\_SMW\_DISCARDS                      | Number of times we discarded scrubber SMW work                                                                       | Occurrences/Sec |
| NUM\_STRIPE\_SKIPPED\_NOT\_FULLY\_READ  | Number of stripes skipped since stripe is not fully read                                                             | Occurrences     |
| PLACEMENT\_SELECTION\_LATENCY           | Average latency of scrubbed placement selection                                                                      | Micros          |
| RAID\_PLACEMENT\_SCANS\_COMPLETED       | Number of placement scan completions                                                                                 | Occurrences     |
| READ\_BATCH\_SOURCE\_BLOCKS             | Number of source blocks read per batch                                                                               | Batches         |
| READ\_BLOCKS\_LATENCY                   | Average latency of read blocks                                                                                       | Micros          |
| READS\_CALLED                           | Number of blocks that were read                                                                                      | Blocks/Sec      |
| RELOCATE\_BLOCKS\_LATENCY               | Average latency of relocating blocks                                                                                 | Micros          |
| RELOCATED\_BLOCKS                       | Number of blocks that were relocated for eviction                                                                    | Blocks/Sec      |
| RETRUSTED\_UNPROTECTED\_DIRTY\_BLOCKS   | Number of dirty blocks that ScrubMissingWrites retrusted because they were unprotected                               | Blocks/Sec      |
| REWRITTEN\_DIRTY\_BLOCKS                | Number of dirty blocks that ScrubMissingWrites rewrote to clean them                                                 | Blocks/Sec      |
| SCAN\_LIKELY\_LEAKED\_BLOCKS            | Number of free blocks encountered during a scan that was marked as KnownUsed in the RAID                             | Occurrences     |
| SCRUB\_BATCHES\_LATENCY                 | Average latency of scrub batches                                                                                     | Millis          |
| SCRUB\_FALSE\_USED\_FAILED\_READS       | Number of blocks that we failed to read for scrub-false-used                                                         | Blocks/Sec      |
| SCRUB\_FALSE\_USED\_FAILED              | Number of placements we failed to fully scrub-false-used                                                             | Occurrences/Sec |
| SCRUB\_FALSE\_USED\_PLACEMENTS          | Number of placements we finished scrub-false-used                                                                    | Occurences/Sec  |
| SCRUB\_FALSE\_USED\_WAS\_UNPROTECTED    | Number of blocks that were falsely marked used and unprotected                                                       | Blocks/Sec      |
| SCRUB\_IN\_FLIGHT\_CORRUPTION\_DETECTED | Number of in-flight corruptions detected when scrubbing                                                              | Occurrences     |
| SCRUB\_PREPARATION\_FAILED              | Number of times we failed to prepare() a task and aborted scrub of placement                                         | Occurrences/Sec |
| SFU\_CHECK\_FREE                        | Number of blocks that were detected as false-used and freed                                                          | Blocks/Sec      |
| SFU\_CHECK\_SECONDARY                   | Number of blocks that were detected as secondary                                                                     | Blocks/Sec      |
| SFU\_CHECK\_USED\_CKSUM\_ERR            | Number of blocks that were detected as used with checksum error                                                      | Blocks/Sec      |
| SFU\_CHECK\_USED                        | Number of blocks that were detected as used                                                                          | Blocks/Sec      |
| SFU\_CHECKS                             | Number of blocks that were scrubbed-false-used                                                                       | Blocks/Sec      |
| SFU\_FREE\_STRIPE\_LATENCY              | Average latency of handling a read of a free stripe                                                                  | Micros          |
| SFU\_FREE\_STRIPES                      | Number of free stripes that were scrubbed-false-used                                                                 | Stripes/Sec     |
| SFU\_USED\_STRIPE\_LATENCY              | Average latency of handling a read of a used stripe                                                                  | Micros          |
| SFU\_USED\_STRIPES                      | Number of used stripes that were scrubbed-false-used                                                                 | Stripes/Sec     |
| SOURCE\_READS                           | Number of source/committed superset blocks directly read by the scrubber                                             | Blocks/Sec      |
| STRIPE\_DATA\_IS\_BLOCK\_USED\_LATENCY  | Average latency of isBlockUsed during stripe verification                                                            | Micros          |
| STRIPE\_DATA\_IS\_BLOCK\_USED           | Number of isBlockUsed during stripe verification                                                                     | Blocks/Sec      |
| TARGET\_COPIED\_CHUNKS                  | Number of chunks that were copied to the target by the scrubber                                                      | Chunks/Sec      |
| UPDATE\_PLACEMENT\_INFO\_LATENCY        | Average latency of updating the placement info quorum                                                                | Micros          |
| UPDATE\_PLACEMENT\_INFO                 | Number of times we ran updatePlacementInfo                                                                           | Occurrences/Sec |
| WONT\_CLEAN\_COPYING                    | Number of actually dirty blocks that ScrubMissingWrites refused to clean because they will be moved to target anyway | Blocks/Sec      |
| WRITE\_BATCH\_SOURCE\_BLOCKS            | Number of source blocks to write in batch                                                                            | Batches         |
| WRITE\_BATCH\_TARGET\_BLOCKS            | Number of target blocks to write in batch                                                                            | Batches         |
| WRITE\_BLOCKS\_LATENCY                  | Average latency of writing blocks                                                                                    | Micros          |
| WRITES\_CALLED                          | Number of blocks that were written                                                                                   | Blocks/Sec      |

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

### SSD

| **Type**                                           | **Description**                                                                                | **Units**      |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------- | -------------- |
| CLEAN\_CHUNK\_SKIPPED                              | Number of clean chunks skipped                                                                 | Chunks         |
| DRIVE\_ACTIVE\_IOS                                 | The number of in-flight IOs against the SSD during sampling                                    | IOs            |
| DRIVE\_AER\_RECEIVED                               | Number of AER reports                                                                          | reports        |
| DRIVE\_CANCELLED\_COMPLETED\_BLOCKS                | Drive cancelled completed blocks                                                               | Blocks/Sec     |
| DRIVE\_CANCELLED\_NOT\_SUBMITTED\_BLOCKS           | Drive cancelled not submitted blocks                                                           | Blocks/Sec     |
| DRIVE\_COMPLETED\_OVER\_COUNT                      | Drive completed count > 1 detected                                                             | Occurrences    |
| DRIVE\_E2E\_CORRECTION\_COUNT                      | Drive E2E correction count                                                                     | Error Count    |
| DRIVE\_ENDURANCE\_USED                             | Drive endurance percentage used                                                                | %              |
| DRIVE\_FORFEITS                                    | Number of IOs forfeited due to lack of memory buffers                                          | Operations/Sec |
| DRIVE\_IDLE\_CYCLES                                | Number of cycles spent in idle                                                                 | Cycles/Sec     |
| DRIVE\_IDLE\_TIME                                  | Percentage of the CPU time not used for handling I/Os                                          | %              |
| DRIVE\_IO\_OVERLAPPED                              | Number of overlapping IOs                                                                      | Operations     |
| DRIVE\_IO\_TOO\_LONG                               | Number of IOs that took longer than expected                                                   | Operations/Sec |
| DRIVE\_LATENCY                                     | Measure the latencies up to 5ms (higher latencies are grouped)                                 | Requests       |
| DRIVE\_LOAD                                        | Drive Load at sampling time                                                                    | Load           |
| DRIVE\_MAX\_ERASE\_COUNT                           | Drive maximum block erase count                                                                | Erase Count    |
| DRIVE\_MEDIA\_BLOCKS\_READ                         | Blocks read from the SSD media                                                                 | Blocks/Sec     |
| DRIVE\_MEDIA\_BLOCKS\_WRITE                        | Blocks are written to the SSD media                                                            | Blocks/Sec     |
| DRIVE\_MEDIA\_ERRORS                               | SSD Media Errors                                                                               | IO/Sec         |
| DRIVE\_MIN\_ERASE\_COUNT                           | Drive minimum block erase count                                                                | Erase Count    |
| DRIVE\_NON\_MEDIA\_ERRORS                          | SSD Non-Media Errors                                                                           | IO/Sec         |
| DRIVE\_PCI\_CORRECTABLE\_ERROR\_COUNT              | Drive PCI Correctable error count                                                              | Error Count    |
| DRIVE\_PCI\_INACCESSIBLE                           | Number of PCI Inaccessible errors detected                                                     | Count          |
| DRIVE\_PCI\_LINK\_RETRAIN\_COUNT                   | Drive PCI link retrain count                                                                   | Error Count    |
| DRIVE\_PENDING\_IOS                                | The number of IOs waiting to start executing during sampling                                   | IOs            |
| DRIVE\_PUMP\_LATENCY                               | Latency between SSD pumps                                                                      | Microseconds   |
| DRIVE\_PUMPED\_IOS                                 | Number of requests returned in a pump                                                          | Pumps          |
| DRIVE\_PUMPS\_DELAYED                              | Number of Drive pumps that got delayed                                                         | Operations/Sec |
| DRIVE\_PUMPS\_SEVERELY\_DELAYED                    | Number of Drive pumps that got severely delayed                                                | Operations/Sec |
| DRIVE\_READ\_LATENCY                               | Drive Read Execution Latency                                                                   | Microseconds   |
| DRIVE\_READ\_OPS                                   | Drive Read Operations                                                                          | IO/Sec         |
| DRIVE\_READ\_RATIO\_PER\_SSD\_READ                 | Drive Read OPS Per SSD Request                                                                 | Ratio          |
| DRIVE\_REMAINING\_IOS                              | Number of requests still in the drive after a pump                                             | Pumps          |
| DRIVE\_REMAINING\_SPARES                           | Drive remaining spares                                                                         | %              |
| DRIVE\_REQUEST\_BLOCKS                             | Measure drive request size distribution                                                        | Requests       |
| DRIVE\_SOFT\_ECC\_COUNT                            | Drive Soft ECC Error Count                                                                     | Error Count    |
| DRIVE\_SSD\_PUMPS                                  | Number of drive pumps that resulted in the data flow from/to drive                             | Pump/Sec       |
| DRIVE\_UNALIGNED\_IOS                              | Drive unaligned IOs count                                                                      | Error Count    |
| DRIVE\_UNCORRECTABLE\_READ\_COUNT                  | Drive uncorrectable read count                                                                 | Error Count    |
| DRIVE\_UTILIZATION                                 | Percentage of time the drive had an active IO submitted to it                                  | %              |
| DRIVE\_WAF\_INTERVAL                               | Drive Interval write amplification                                                             | Factor         |
| DRIVE\_WAF\_LIFETIME                               | Drive lifetime write amplification                                                             | Factor         |
| DRIVE\_WRITE\_LATENCY                              | Drive Write Execution Latency                                                                  | Microseconds   |
| DRIVE\_WRITE\_OPS                                  | Drive Write Operations                                                                         | IO/Sec         |
| DRIVE\_WRITE\_RATIO\_PER\_SSD\_WRITE               | Drive Write OPS Per SSD Request                                                                | Ratio          |
| DRIVE\_XOR\_RECOVERY\_COUNT                        | Drive XOR recovery count                                                                       | Error Count    |
| NVKV\_CHUNK\_OUT\_OF\_SPACE                        | Number of failed attempts to allocate a stripe in an NVKV chunk                                | Attempts/Sec   |
| NVKV\_INVALIDATOR\_MATCHED                         | Number of NVKV invalidators matching the data                                                  | Attempts/Sec   |
| NVKV\_OUT\_OF\_CHUNKS                              | Number of failed attempts to allocate an NVKV chunk                                            | Attempts/Sec   |
| NVKV\_OUT\_OF\_SUPERBLOCK\_ENTRIES                 | Number of failed attempts to allocate a superblock NVKV entry                                  | Attempts/Sec   |
| NVME\_NAMESPACE\_CAPACITY                          | NVMe namespace capacity                                                                        | Blocks         |
| NVME\_NAMESPACE\_SIZE                              | The size of the NVMe namespace                                                                 | Blocks         |
| NVME\_NAMESPACE\_UTILIZATION                       | NVMe namespace utilization                                                                     | Blocks         |
| NVME\_SMART\_AVAILABLE\_SPARE\_THRESHOLD           | Normalized percentage of the available spare falls below the threshold                         | %              |
| NVME\_SMART\_AVAILABLE\_SPARE                      | Normalized percentage when the available spare falls below the threshold                       | %              |
| NVME\_SMART\_COMPOSITE\_TEMP                       | Current composite temperature of the container                                                 | Kelvin         |
| NVME\_SMART\_CONTROLLER\_BUSY\_TIME                | The duration the controller is busy with I/O commands                                          | Minutes        |
| NVME\_SMART\_CRITICAL\_COMPOSITE\_TEMP\_TIME       | The time spent in critical composite temperature state                                         | Minutes        |
| NVME\_SMART\_CRITICAL\_WARNING                     | Critical warnings regarding the drive controller state                                         | BitFields      |
| NVME\_SMART\_DATA\_UNITS\_READ                     | The number of 512-byte data units the server has read from the controller (in millions)        | Count          |
| NVME\_SMART\_DATA\_UNITS\_WRITTEN                  | The number of 512-byte data units the host has written to the controller (in millions)         | Count          |
| NVME\_SMART\_ERROR\_LOG\_ENTRIES                   | The total number of Error Information log entries over the controller's lifetime               | Occurrences    |
| NVME\_SMART\_HOST\_READ\_CMDS                      | The number of read commands completed by the controller                                        | Occurrences    |
| NVME\_SMART\_HOST\_WRITE\_CMDS                     | The number of write commands completed by the controller                                       | Occurrences    |
| NVME\_SMART\_MEDIA\_ERRORS                         | The number of unrecovered data integrity errors detected by the controller                     | Occurrences    |
| NVME\_SMART\_POWER\_CYCLES                         | The number of power cycles                                                                     | Occurrences    |
| NVME\_SMART\_TEMP\_SENSOR\_1                       | The current temperature reported by temperature sensor 1                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_2                       | The current temperature reported by temperature sensor 2                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_3                       | The current temperature reported by temperature sensor 3                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_4                       | The current temperature reported by temperature sensor 4                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_5                       | The current temperature reported by temperature sensor 5                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_6                       | The current temperature reported by temperature sensor 6                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_7                       | The current temperature reported by temperature sensor 7                                       | Kelvin         |
| NVME\_SMART\_TEMP\_SENSOR\_8                       | The current temperature reported by temperature sensor 8                                       | Kelvin         |
| NVME\_SMART\_THERMAL\_MGMT\_TEMP1\_TRANSITION\_CNT | The number of times the controller entered lower active power states due to thermal management | Occurrences    |
| NVME\_SMART\_THERMAL\_MGMT\_TEMP2\_TRANSITION\_CNT | The number of times the controller entered lower active power states due to thermal management | Occurrences    |
| NVME\_SMART\_TOTAL\_THERMAL\_MGMT\_TEMP1\_TIME     | The total time the controller spent in lower power states for thermal management temperature 1 | Seconds        |
| NVME\_SMART\_TOTAL\_THERMAL\_MGMT\_TEMP2\_TIME     | The total time the controller spent in lower power states for thermal management temperature 2 | Seconds        |
| NVME\_SMART\_UNSAFE\_SHUTDOWNS                     | The number of unsafe shutdown events                                                           | Occurrences    |
| NVME\_SMART\_USED\_PERCENTAGE                      | Vendor-specific estimate of the percentage of NVM subsystem life used                          | %              |
| NVME\_SMART\_WARNING\_COMPOSITE\_TEMP\_TIME        | The time spent in warning composite temperature state                                          | Minutes        |
| SSD\_BLOCKS\_READ                                  | Number of blocks read from the SSD service                                                     | Blocks/Sec     |
| SSD\_BLOCKS\_WRITTEN                               | Number of blocks written to the SSD service                                                    | Blocks/Sec     |
| SSD\_CHUNK\_ALLOCS\_TRIMMED                        | Number of chunk allocations from the trimmed queue                                             | Chunks         |
| SSD\_CHUNK\_ALLOCS\_UNTRIMMED                      | Number of chunk allocations from the untrimmed queue                                           | Chunks         |
| SSD\_CHUNK\_ALLOCS                                 | Number of chunk allocations                                                                    | Chunks         |
| SSD\_CHUNK\_FREE\_TRIMMED                          | Number of free trimmed chunks                                                                  | Chunks         |
| SSD\_CHUNK\_FREE\_UNTRIMMED                        | Number of free untrimmed chunks                                                                | Chunks         |
| SSD\_CHUNK\_FREES                                  | Number of chunk frees                                                                          | Chunks         |
| SSD\_CHUNK\_TRIMS                                  | Number of trims performed                                                                      | Chunks         |
| SSD\_CHUNKS\_IN\_USE                               | Number of allocated chunks                                                                     | Chunks         |
| SSD\_E2E\_BAD\_CSUM                                | End-to-End checksum failures                                                                   | IO/Sec         |
| SSD\_READ\_ERRORS                                  | Errors in reading blocks from the SSD service                                                  | Blocks/Sec     |
| SSD\_READ\_LATENCY                                 | Avg latency of read requests from the SSD service                                              | Microseconds   |
| SSD\_READ\_REQS\_LARGE\_NORMAL                     | Number of large normal read requests from the SSD service                                      | IO/Sec         |
| SSD\_READ\_REQS                                    | Number of read requests from the SSD service                                                   | IO/Sec         |
| SSD\_SCRATCH\_BUFFERS\_USED                        | Number of scratch blocks used                                                                  | Blocks         |
| SSD\_TRIM\_TIMEOUTS                                | Number of trim timeouts                                                                        | Timeouts       |
| SSD\_WRITE\_ERRORS                                 | Errors in writing blocks to the SSD service                                                    | Blocks/Sec     |
| SSD\_WRITE\_LATENCY                                | Latency of writes to the SSD service                                                           | Microseconds   |
| SSD\_WRITES\_REQS\_LARGE\_NORMAL                   | Number of large normal priority write requests to the SSD service                              | IO/Sec         |
| SSD\_WRITES                                        | Number of write requests to the SSD service                                                    | IO/Sec         |
| SSDS\_IO\_ERRORS                                   | IO errors on the SSD service                                                                   | Blocks/Sec     |
| SSDS\_IOS                                          | IOs performed on the SSD service                                                               | IO/Sec         |

### Statistics

| **Type**                         | **Description**                                                                        | **Units**   |
| -------------------------------- | -------------------------------------------------------------------------------------- | ----------- |
| AVAILABLE\_HOST\_MEMORY\_MB      | Amount of Free Memory                                                                  | MB          |
| GATHER\_FROM\_NODE\_LATENCY\_NET | Time spent on responding to a stats-gathering request (not including metadata)         | Seconds/Sec |
| GATHER\_FROM\_NODE\_LATENCY      | Time spent responding to a stats-gathering request (not including metadata)            | Seconds/Sec |
| GATHER\_FROM\_NODE\_SLEEP        | Time spent in-between responding to a stats-gathering request (not including metadata) | Seconds/Sec |
| TIMES\_QUERIED\_STATS            | Number of times the process queried other processes for stats                          | Times       |
| TIMES\_QUERIED                   | Number of times the process was queried for stats (not including metadata)             | Times       |
