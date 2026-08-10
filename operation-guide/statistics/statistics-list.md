---
description: >-
  Explore the various statistics the WEKA system produces, organized according
  to their respective category labels.
---

# Statistics list

### API Statistics

| Type           | Description        | Units    |
| -------------- | ------------------ | -------- |
| TOTAL\_2xx\_RQ | Total 2xx requests | Requests |
| TOTAL\_3xx\_RQ | Total 3xx requests | Requests |
| TOTAL\_429\_RQ | Total 429 replies  | Requests |
| TOTAL\_4xx\_RQ | Total 4xx requests | Requests |
| TOTAL\_5xx\_RQ | Total 5xx requests | Requests |

### Assert failures

| Type                                              | Description                                                           | Units              |
| ------------------------------------------------- | --------------------------------------------------------------------- | ------------------ |
| ASSERTION\_FAILURES                               | Assertion failures count of all available types                       | Assertion failures |
| ASSERTION\_FAILURES\_IGNORE                       | Assertion failures count with "IGNORE" behavior                       | Assertion failures |
| ASSERTION\_FAILURES\_IGNORE\_SOFT                 | Assertion failures count with "IGNORE\_SOFT" behavior                 | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_BUCKET                 | Assertion failures count with "KILL\_BUCKET" behavior                 | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_FIBER                  | Assertion failures count with "KILL\_FIBER" behavior                  | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_NODE                   | Assertion failures count with "KILL\_NODE" behavior                   | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_NODE\_ENV              | Assertion failures count with "KILL\_NODE\_ENV" behavior              | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_NODE\_OOM              | Assertion failures count with "KILL\_NODE\_OOM" behavior              | Assertion failures |
| ASSERTION\_FAILURES\_KILL\_NODE\_WITH\_CORE\_DUMP | Assertion failures count with "KILL\_NODE\_WITH\_CORE\_DUMP" behavior | Assertion failures |
| ASSERTION\_FAILURES\_STALL                        | Assertion failures count with "STALL" behavior                        | Assertion failures |
| ASSERTION\_FAILURES\_STALL\_AND\_KILL\_BUCKET     | Assertion failures count with "STALL\_AND\_KILL\_BUCKET" behavior     | Assertion failures |
| ASSERTION\_FAILURES\_STALL\_AND\_KILL\_NODE       | Assertion failures count with "STALL\_AND\_KILL\_NODE" behavior       | Assertion failures |
| ASSERTION\_FAILURES\_THROW\_EXCEPTION             | Assertion failures count with "THROW\_EXCEPTION" behavior             | Assertion failures |

### Async Delete

| Type                                 | Description                                                    | Units      |
| ------------------------------------ | -------------------------------------------------------------- | ---------- |
| ASYNC\_DELETE\_DIRS\_QUEUED          | Directories added to async delete queue, categorized by source | Dirs/Sec   |
| ASYNC\_DELETE\_DIRS\_QUEUED\_SUBDIRS | Subdirectories queued during async delete processing           | Dirs/Sec   |
| ASYNC\_DELETE\_FILES\_QUEUED         | Files queued for unlink by async delete directory shredder     | Files/Sec  |
| ASYNC\_DELETE\_SLICES\_SHREDDED      | Directory slices shredded by async delete                      | Slices/Sec |

### Attribute Cache

| Type                     | Description                                               | Units   |
| ------------------------ | --------------------------------------------------------- | ------- |
| GP\_GETATTR              | Number of general-purpose getAttr calls per second        | Ops/Sec |
| GP\_GETATTR\_CACHE\_MISS | Number of general purpose getAttr cache misses per second | Ops/Sec |

### Audit

| Type                            | Description                                                 | Units    |
| ------------------------------- | ----------------------------------------------------------- | -------- |
| AUDITS                          | Number of audits traces created for all types               | Audits   |
| AUDIT\_ACQUIRE\_CHARTER         | Number of audits traces created for ACQUIRE\_CHARTER        | Audits   |
| AUDIT\_ASYNC\_DELETE\_FILE      | Number of audits traces created for ASYNC\_DELETE\_FILE     | Audits   |
| AUDIT\_ASYNC\_DELETE\_INIT      | Number of audits traces created for ASYNC\_DELETE\_INIT     | Audits   |
| AUDIT\_ASYNC\_DELETE\_SUBDIR    | Number of audits traces created for ASYNC\_DELETE\_SUBDIR   | Audits   |
| AUDIT\_ATOMIC\_OPEN             | Number of audits traces created for ATOMIC\_OPEN            | Audits   |
| AUDIT\_CREATE\_DIRENT           | Number of audits traces created for CREATE\_DIRENT          | Audits   |
| AUDIT\_CREATE\_INODE            | Number of audits traces created for CREATE\_INODE           | Audits   |
| AUDIT\_CREATE\_OPEN\_DIRENT     | Number of audits traces created for CREATE\_OPEN\_DIRENT    | Audits   |
| AUDIT\_CREATE\_UNLINKED\_INODE  | Number of audits traces created for CREATE\_UNLINKED\_INODE | Audits   |
| AUDIT\_DEREFERENCE\_DIRENT      | Number of audits traces created for DEREFERENCE\_DIRENT     | Audits   |
| AUDIT\_DIRCLOSE                 | Number of audits traces created for DIRCLOSE                | Audits   |
| AUDIT\_DIROPEN                  | Number of audits traces created for DIROPEN                 | Audits   |
| AUDIT\_FILECLOSE                | Number of audits traces created for FILECLOSE               | Audits   |
| AUDIT\_FILEOPEN                 | Number of audits traces created for FILEOPEN                | Audits   |
| AUDIT\_GET\_ATTR                | Number of audits traces created for GET\_ATTR               | Audits   |
| AUDIT\_GET\_XATTR               | Number of audits traces created for GET\_XATTR              | Audits   |
| AUDIT\_HEARTBEAT                | Number of audits traces created for HEARTBEAT               | Audits   |
| AUDIT\_LINK                     | Number of audits traces created for LINK                    | Audits   |
| AUDIT\_LIST\_XATTR              | Number of audits traces created for LIST\_XATTR             | Audits   |
| AUDIT\_MOUNT                    | Number of audits traces created for MOUNT                   | Audits   |
| AUDIT\_READDIR                  | Number of audits traces created for READDIR                 | Audits   |
| AUDIT\_READLINK                 | Number of audits traces created for READLINK                | Audits   |
| AUDIT\_REMOVE\_XATTR            | Number of audits traces created for REMOVE\_XATTR           | Audits   |
| AUDIT\_RENAME                   | Number of audits traces created for RENAME                  | Audits   |
| AUDIT\_SET\_ATTR                | Number of audits traces created for SET\_ATTR               | Audits   |
| AUDIT\_SET\_XATTR               | Number of audits traces created for SET\_XATTR              | Audits   |
| AUDIT\_UMOUNT                   | Number of audits traces created for UMOUNT                  | Audits   |
| AUDIT\_UNKNOWN                  | Number of audits traces created for UNKNOWN                 | Audits   |
| AUDIT\_UNLINK\_DIR              | Number of audits traces created for UNLINK\_DIR             | Audits   |
| AUDIT\_UNLINK\_FILE             | Number of audits traces created for UNLINK\_FILE            | Audits   |
| FE\_AUDIT\_ENCRYPTION\_FAILURES | Number of failures to encrypt audit entities                | Failures |

### Audit Enhancer Statistics

| Type                                            | Description                                                                          | Units                |
| ----------------------------------------------- | ------------------------------------------------------------------------------------ | -------------------- |
| BACKEND\_NAME\_RESOLVE\_BATCH\_REQUESTS         | Number of resolves to backend batches                                                | Requests             |
| CACHE\_ADDED\_ENTRIES                           | Number of entries added to cache                                                     | Entries              |
| CACHE\_EVICT\_ENTRIES                           | Number of entries evicted from cache                                                 | Entries              |
| CACHE\_NUM\_ENTRIES                             | Number of entries in cache                                                           | Entries in cache     |
| CACHE\_OVERWRITTEN\_ENTRIES                     | Number of entries overwritten in the cache                                           | Entries              |
| CACHE\_PRELOAD\_HITS                            | Number of cache hits when trying to preload                                          | Entries              |
| CACHE\_PRELOAD\_MISSES                          | Number of cache miss when trying to preload                                          | Entries              |
| CACHE\_RESOLVE\_HITS                            | Number of cache hits to resolve                                                      | Entries              |
| CACHE\_RESOLVE\_MISSES                          | Number of cache miss when try to resolve                                             | Entries              |
| DECRYPT\_FILENAME\_API\_INVOCATION\_AVG\_TIME   | Average decrypt filename API invocation time                                         | Microseconds         |
| DECRYPT\_FILENAME\_API\_INVOCATION\_MAX\_TIME   | Maximum decrypt filename API invocation time                                         | Microseconds         |
| DECRYPT\_FILENAME\_API\_INVOCATION\_MIN\_TIME   | Minimum decrypt filename API invocation time                                         | Microseconds         |
| DECRYPT\_FILENAME\_API\_INVOCATION\_TOTAL\_TIME | Total decrypt filename API invocation time                                           | Microseconds         |
| DECRYPT\_FILENAME\_PER\_BATCH\_AVG\_ENTRIES     | Average entries in a decrypt filename batch                                          | Entries/Batch        |
| DECRYPT\_FILENAME\_PER\_BATCH\_MAX\_ENTRIES     | Maximum entries in a decrypt filename batch                                          | Entries/Batch        |
| DECRYPT\_FILENAME\_PER\_BATCH\_MIN\_ENTRIES     | Minimum entries in a decrypt filename batch                                          | Entries/Batch        |
| DECRYPT\_FILENAME\_REQUESTS                     | Number of decrypt filename requests                                                  | Requests             |
| DECRYPT\_FILENAME\_REQUESTS\_FAIL               | Number of decrypt filename requests failed                                           | Requests failed      |
| DECRYPT\_FILENAME\_REQUESTS\_SUCCESS            | Number of decrypt filename requests succeeded                                        | Requests succeeded   |
| DECRYPT\_FILENAME\_SLEEP\_TIME                  | Sleep time when decrypt filename API fails                                           | Microseconds         |
| DECRYPT\_FILENAME\_TOTAL\_ENTRIES               | Total filename entries decrypted                                                     | Entries              |
| ENHANCER\_BATCH\_COUNT                          | Total batch count                                                                    | Batches              |
| ENHANCER\_ENHANCED\_TOTAL\_ENTRIES              | Total entries enhanced                                                               | Entries              |
| ENHANCER\_PER\_BATCH\_AVG\_ENTRIES              | Average entries in a batch                                                           | Entries/Batch        |
| ENHANCER\_PER\_BATCH\_MAX\_ENTRIES              | Maximum entries in a batch                                                           | Entries/Batch        |
| ENHANCER\_PER\_BATCH\_MIN\_ENTRIES              | Minimum entries in a batch                                                           | Entries/Batch        |
| ENHANCE\_BACKEND\_CALL\_AVG\_TIME               | Per backend call average time                                                        | Microseconds         |
| ENHANCE\_BACKEND\_CALL\_MAX\_TIME               | Per backend call maximum time                                                        | Microseconds         |
| ENHANCE\_BACKEND\_CALL\_MIN\_TIME               | Per backend call minimum time                                                        | Microseconds         |
| ENHANCE\_BACKEND\_CALL\_TOTAL\_TIME             | Total backend call time                                                              | Microseconds         |
| ENHANCE\_RESOLVE\_PATH\_ATTEMPTS\_COUNT         | Number of resolve paths                                                              | Count                |
| ENHANCE\_RESOLVE\_PATH\_AVG\_TIME               | Average resolve path time                                                            | Microseconds         |
| ENHANCE\_RESOLVE\_PATH\_MAX\_TIME               | Maximum resolve path time                                                            | Microseconds         |
| ENHANCE\_RESOLVE\_PATH\_MIN\_TIME               | Minimum resolve path time                                                            | Microseconds         |
| ENHANCE\_RESOLVE\_PATH\_TOTAL\_TIME             | Total resolve path time                                                              | Microseconds         |
| ENHANCE\_SLEEP\_TIME                            | Sleep time when backend call fails                                                   | Microseconds         |
| INODES\_TO\_RESOLVE\_NAME                       | Number of inodes to resolve name                                                     | Inodes               |
| NAME\_RESOLVE\_FAIL\_NAME\_NOT\_IN\_CACHE       | Number of times a path could not be resolved, as one of directory names not in cache | Failed path resolves |
| NAME\_RESOLVE\_REQUESTS                         | Number of resolve name queries issued to backend                                     | Requests             |
| NAME\_RESOLVE\_REQUESTS\_FAIL                   | Number of resolve name queries failed                                                | Requests failed      |
| NAME\_RESOLVE\_REQUESTS\_SUCCESS                | Number of resolve name queries succeeded                                             | Requests succeeded   |
| PER\_BATCH\_ENHANCE\_AVG\_TIME                  | Per batch enhance average processing time                                            | Microseconds         |
| PER\_BATCH\_ENHANCE\_MAX\_TIME                  | Per batch enhance maximum processing time                                            | Microseconds         |
| PER\_BATCH\_ENHANCE\_MIN\_TIME                  | Per batch enhance minimum processing time                                            | Microseconds         |
| PER\_BATCH\_ENHANCE\_PRELOAD\_AVG\_TIME         | Per batch enhance average preload time                                               | Microseconds         |
| PER\_BATCH\_ENHANCE\_PRELOAD\_MAX\_TIME         | Per batch enhance maximum preload time                                               | Microseconds         |
| PER\_BATCH\_ENHANCE\_PRELOAD\_MIN\_TIME         | Per batch enhance minimum preload time                                               | Microseconds         |
| PER\_BATCH\_ENHANCE\_PRELOAD\_TOTAL\_TIME       | Total enhance preload time                                                           | Microseconds         |
| PER\_BATCH\_ENHANCE\_TOTAL\_TIME                | Total enhance batch processing time                                                  | Microseconds         |
| PRELOAD\_CACHE\_COUNT                           | Number of cache preloads                                                             | Number of attempts   |

### Backend I/O Latency

| Type                     | Description                                                                                                             | Units        |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------- | ------------ |
| READ\_1HOP\_LATENCY      | Backend latency for 1-hop reads: avg(getExtentBlocks) + avg(getBlocks)                                                  | Microseconds |
| READ\_1HOP\_TOTAL\_COUNT | Number of 1-hop reads per second, proxied by getExtentBlocks RPC count                                                  | Ops/Sec      |
| READ\_2HOP\_LATENCY      | Backend latency for 2-hop reads: time to complete the readWithChecksums RPC                                             | Microseconds |
| READ\_2HOP\_TOTAL\_COUNT | Number of 2-hop reads per second, proxied by readWithChecksums RPC count                                                | Ops/Sec      |
| READ\_LATENCY\_BACKEND   | Weighted average backend read latency: (1-hop\_count \* 1-hop\_latency + 2-hop\_count \* 2-hop\_latency) / total\_count | Microseconds |
| WRITE\_LATENCY\_BACKEND  | Time it takes to complete the RPC 'writeWithChecksums'                                                                  | Microseconds |

### Block Cache

| Type                                 | Description                                | Units   |
| ------------------------------------ | ------------------------------------------ | ------- |
| BUCKET\_CACHED\_METADATA\_BLOCKS     | Bucket number of cached metadata blocks    | Blocks  |
| BUCKET\_CACHED\_REGISTRY\_L2\_BLOCKS | Bucket number of cached registry L2 blocks | Blocks  |
| BUCKET\_CACHE\_METADATA\_HITS        | Bucket block cache metadata hits           | Queries |
| BUCKET\_CACHE\_METADATA\_MISSES      | Bucket block cache metadata misses         | Queries |
| BUCKET\_CACHE\_REGISTRY\_L2\_HITS    | Bucket block cache registry L2 hits        | Queries |
| BUCKET\_CACHE\_REGISTRY\_L2\_MISSES  | Bucket block cache registry L2 misses      | Queries |
| BUCKET\_REGISTRY\_L2\_BLOCKS\_NUM    | Bucket number of registry L2 blocks        | Blocks  |

### Block Writes

| Type                   | Description                    | Units  |
| ---------------------- | ------------------------------ | ------ |
| BLOCK\_FULL\_WRITES    | Number of full block writes    | Writes |
| BLOCK\_PARTIAL\_WRITES | Number of partial block writes | Writes |

### Bucket

| Type                                                              | Description                                                                                             | Units             |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ----------------- |
| BAD\_JOURNAL\_ID\_CHECKSUM                                        | Number of journals that failed to load due to invalid JournalId checksum                                | Ops/Sec           |
| BUCKET\_SESSION\_VALIDATIONS                                      | Number of bucket session validations per second                                                         | RPCs/Sec          |
| BUCKET\_SESSION\_VALIDATION\_LATENCY                              | Average latency of bucket session validation                                                            | Microseconds      |
| BUCKET\_START\_TIME                                               | Duration of bucket activation on step up                                                                | Startups          |
| CHOKING\_LEVEL\_ALL                                               | Throttling level applied on all types of IOs, both mutating and non-mutating                            | %                 |
| CHOKING\_LEVEL\_NON\_MUTATING                                     | Throttling level applied on non-mutating only types of IOs                                              | %                 |
| COALESCED\_MAY\_CREATE\_EXTENT                                    | Number of mayCreateExtent calls coalesced                                                               | Calls             |
| DESTAGED\_BLOCKS\_COUNT                                           | Number of destaged blocks per second                                                                    | Blocks/Sec        |
| DESTAGE\_COUNT                                                    | Number of destages per second                                                                           | Destages/Sec      |
| DIR\_MOVE\_TIME                                                   | Time to complete a directory move                                                                       | Ops               |
| EXTENT\_BLOCKS\_COUNT                                             | Difference in number of EXTENT blocks                                                                   | Blocks            |
| EXTENT\_BLOCK\_SEQUENCES                                          | Histogram of the number of consecutive sequences of blocks in a single extent                           | Extents           |
| FAIRNESS\_DELAYED\_MAY\_CREATE\_EXTENT                            | Number of mayCreateExtent calls not coalesced to prevent starvation                                     | Calls             |
| FREEABLE\_LRU\_BUFFERS                                            | Number of unused blocks in LRU cache                                                                    | Buffers           |
| HASH\_BLOCKS\_COUNT                                               | Difference in number of HASH blocks                                                                     | Blocks            |
| INODE\_BLOCKS\_COUNT                                              | Difference in number of INODE blocks                                                                    | Blocks            |
| INTEGRITY\_ISSUES                                                 | Number of filesystem integrity issues detected                                                          | Issues            |
| JOURNALS\_WITH\_INVALID\_RAFTTERMS                                | Number of journals with invalid raft-terms                                                              | JournalBlocks/Sec |
| JOURNAL\_BLOCKS\_COUNT                                            | Difference in number of JOURNAL blocks                                                                  | Blocks            |
| NOOP\_JOURNALS                                                    | Number of NOOP journals                                                                                 | Ops/Sec           |
| NOOP\_REPLAYS                                                     | Number of NOOP replays                                                                                  | Ops               |
| ODH\_COLLISIONS                                                   | Number of ODH items created with colliding hash in all ODHs                                             | Collisions        |
| ODH\_COLLISIONS\_ACCESS\_CLOCK\_STATES                            | Number of ODH items created with colliding hash in ACCESS\_CLOCK\_STATES ODH                            | Collisions        |
| ODH\_COLLISIONS\_BIG\_BLOB\_MANIFEST                              | Number of ODH items created with colliding hash in BIG\_BLOB\_MANIFEST ODH                              | Collisions        |
| ODH\_COLLISIONS\_DEFAULT\_DIR\_QUOTA                              | Number of ODH items created with colliding hash in DEFAULT\_DIR\_QUOTA ODH                              | Collisions        |
| ODH\_COLLISIONS\_DIRECTORY                                        | Number of ODH items created with colliding hash in DIRECTORY ODH                                        | Collisions        |
| ODH\_COLLISIONS\_DIR\_DELETIONS                                   | Number of ODH items created with colliding hash in DIR\_DELETIONS ODH                                   | Collisions        |
| ODH\_COLLISIONS\_DIR\_DELETIONS\_V2                               | Number of ODH items created with colliding hash in DIR\_DELETIONS\_V2 ODH                               | Collisions        |
| ODH\_COLLISIONS\_DIR\_QUOTA                                       | Number of ODH items created with colliding hash in DIR\_QUOTA ODH                                       | Collisions        |
| ODH\_COLLISIONS\_FLOCK\_EXPIRED\_FRONTENDS                        | Number of ODH items created with colliding hash in FLOCK\_EXPIRED\_FRONTENDS ODH                        | Collisions        |
| ODH\_COLLISIONS\_FLOCK\_EXPIRED\_FRONTENDS\_WNID                  | Number of ODH items created with colliding hash in FLOCK\_EXPIRED\_FRONTENDS\_WNID ODH                  | Collisions        |
| ODH\_COLLISIONS\_GRAVEYARD                                        | Number of ODH items created with colliding hash in GRAVEYARD ODH                                        | Collisions        |
| ODH\_COLLISIONS\_GROUP\_QUOTA                                     | Number of ODH items created with colliding hash in GROUP\_QUOTA ODH                                     | Collisions        |
| ODH\_COLLISIONS\_GROUP\_QUOTA\_PARAMS                             | Number of ODH items created with colliding hash in GROUP\_QUOTA\_PARAMS ODH                             | Collisions        |
| ODH\_COLLISIONS\_INODES\_PENDING\_VALIDATIONS                     | Number of ODH items created with colliding hash in INODES\_PENDING\_VALIDATIONS ODH                     | Collisions        |
| ODH\_COLLISIONS\_INODES\_POTENTIAL\_PENDING\_DELETION             | Number of ODH items created with colliding hash in INODES\_POTENTIAL\_PENDING\_DELETION ODH             | Collisions        |
| ODH\_COLLISIONS\_MODIFY\_CLOCK\_STATES                            | Number of ODH items created with colliding hash in MODIFY\_CLOCK\_STATES ODH                            | Collisions        |
| ODH\_COLLISIONS\_OBS\_IMMEDIATE\_RELEASE                          | Number of ODH items created with colliding hash in OBS\_IMMEDIATE\_RELEASE ODH                          | Collisions        |
| ODH\_COLLISIONS\_OBS\_RECLAMATION                                 | Number of ODH items created with colliding hash in OBS\_RECLAMATION ODH                                 | Collisions        |
| ODH\_COLLISIONS\_QUOTA\_UPDATES                                   | Number of ODH items created with colliding hash in QUOTA\_UPDATES ODH                                   | Collisions        |
| ODH\_COLLISIONS\_REFERENCE\_RELOCATIONS                           | Number of ODH items created with colliding hash in REFERENCE\_RELOCATIONS ODH                           | Collisions        |
| ODH\_COLLISIONS\_SNAPSHOT\_MEMBERS                                | Number of ODH items created with colliding hash in SNAPSHOT\_MEMBERS ODH                                | Collisions        |
| ODH\_COLLISIONS\_SNAP\_LAYER\_CAPACITY                            | Number of ODH items created with colliding hash in SNAP\_LAYER\_CAPACITY ODH                            | Collisions        |
| ODH\_COLLISIONS\_SNAP\_LAYER\_SIZE\_V4\_3                         | Number of ODH items created with colliding hash in SNAP\_LAYER\_SIZE\_V4\_3 ODH                         | Collisions        |
| ODH\_COLLISIONS\_STOW\_DOWNLOAD\_REDISTRIBUTE\_PULL\_STATE\_V4\_3 | Number of ODH items created with colliding hash in STOW\_DOWNLOAD\_REDISTRIBUTE\_PULL\_STATE\_V4\_3 ODH | Collisions        |
| ODH\_COLLISIONS\_STOW\_DOWNLOAD\_REDISTRIBUTE\_V4\_3              | Number of ODH items created with colliding hash in STOW\_DOWNLOAD\_REDISTRIBUTE\_V4\_3 ODH              | Collisions        |
| ODH\_COLLISIONS\_STOW\_UPLOAD\_MANIFEST                           | Number of ODH items created with colliding hash in STOW\_UPLOAD\_MANIFEST ODH                           | Collisions        |
| ODH\_COLLISIONS\_SV\_CAPACITY\_LEADER                             | Number of ODH items created with colliding hash in SV\_CAPACITY\_LEADER ODH                             | Collisions        |
| ODH\_COLLISIONS\_UNLINKED\_INODES                                 | Number of ODH items created with colliding hash in UNLINKED\_INODES ODH                                 | Collisions        |
| ODH\_COLLISIONS\_USER\_QUOTA                                      | Number of ODH items created with colliding hash in USER\_QUOTA ODH                                      | Collisions        |
| ODH\_COLLISIONS\_USER\_QUOTA\_PARAMS                              | Number of ODH items created with colliding hash in USER\_QUOTA\_PARAMS ODH                              | Collisions        |
| ODL\_BLOCKS\_COUNT                                                | Difference in number of ODL blocks                                                                      | Blocks            |
| ODL\_PAYLOAD\_BLOCKS\_COUNT                                       | Difference in number of ODL\_PAYLOAD blocks                                                             | Blocks            |
| READS                                                             | Number of read operations per second                                                                    | Ops/Sec           |
| READ\_BYTES                                                       | Number of bytes read per second                                                                         | Bytes/Sec         |
| READ\_LATENCY                                                     | Average latency of READ operations                                                                      | Microseconds      |
| REGISTRY\_COLLISIONS                                              | Number of registry items created with colliding key                                                     | Collisions        |
| REGISTRY\_L1\_BLOCKS\_COUNT                                       | Difference in number of REGISTRY\_L1 blocks                                                             | Blocks            |
| REGISTRY\_L2\_BLOCKS\_COUNT                                       | Difference in number of REGISTRY\_L2 blocks                                                             | Blocks            |
| REGISTRY\_SEARCHES\_COUNT                                         | Number of registry searches per second                                                                  | Queries/Sec       |
| REJECTED\_STALE\_PUT\_BLOCKS                                      | Number of putBlocks RPCs rejected due to stale serial number                                            | RPCs/Sec          |
| REJECTED\_STALE\_PUT\_BLOCKS\_FALSE\_POSITIVES                    | Number of putBlocks RPCs falsely rejected due to stale serial number                                    | RPCs/Sec          |
| RESIDENT\_BLOCKS\_COUNT                                           | Number of blocks in the resident blocks table                                                           | Blocks            |
| SINGLE\_HOP\_MISMATCH\_RECOVERY                                   | Number of single hop read prefix mismatch recoveries                                                    | Issues            |
| SINGLE\_HOP\_RDMA\_MISMATCH\_DPDK\_FALLBACK                       | Number of single hop read prefix mismatch RDMA fail                                                     | Issues            |
| SINGLE\_HOP\_WRITE\_ATTEMPTS                                      | Number of single hop write attempts per second                                                          | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_BAD\_CSUM                                     | Number of single hop write operation (BAD\_CSUM) per second                                             | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_BYTES                                         | Total single hop write bytes                                                                            | Bytes/Sec         |
| SINGLE\_HOP\_WRITE\_CLIENT\_TOO\_OLD                              | Number of single hop write operation (CLIENT\_TOO\_OLD) per second                                      | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_FAILURES                                      | Number of single hop write operation failures per second                                                | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_FE\_CALLBACK\_FAIL                            | Number of single hop write operation (FE\_CALLBACK\_FAIL) per second                                    | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_FE\_FAILOVER                                  | Number of single hop write operation (FE\_FAILOVER) per second                                          | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_FORWARDING                                    | Number of single hop write operation (FORWARDING) per second                                            | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_MANUAL\_OVERRIDE\_DENY                        | Number of single hop write operation (MANUAL\_OVERRIDE\_DENY) per second                                | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_NO\_BYPASSING\_STRIPES                        | Number of single hop write operation (NO\_BYPASSING\_STRIPES) per second                                | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_OTHER\_ERROR                                  | Number of single hop write operation (OTHER\_ERROR) per second                                          | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_SKIP                                          | Number of single hop write operation (SKIP) per second                                                  | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_SSD\_FAIL                                     | Number of single hop write operation (SSD\_FAIL) per second                                             | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_SUCCESS                                       | Number of single hop write operation (SUCCESS) per second                                               | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_TOO\_MANY\_PLACEMENTS                         | Number of single hop write operation (TOO\_MANY\_PLACEMENTS) per second                                 | Ops/Sec           |
| SINGLE\_HOP\_WRITE\_UNEXPECTED\_FAIL                              | Number of single hop write operation (UNEXPECTED\_FAIL) per second                                      | Ops/Sec           |
| SKIPPED\_QUOTA\_CHECKS                                            | Number of ops that skipped QuotaId checks                                                               | Ops/Sec           |
| SNAPSHOT\_CREATION\_TIME                                          | Time to complete a snapshot creation                                                                    | Snapshots         |
| SPATIAL\_DIGEST\_BLOCKS\_COUNT                                    | Difference in number of SPATIAL\_DIGEST blocks                                                          | Blocks            |
| SPATIAL\_SQUELCH\_BLOCKS\_COUNT                                   | Difference in number of SPATIAL\_SQUELCH blocks                                                         | Blocks            |
| SUCCESSFUL\_DATA\_WEDGINGS                                        | Number of successful attempts to wedge data blocks in journal per second                                | Attempts/Sec      |
| SUPERBLOCK\_BLOCKS\_COUNT                                         | Difference in number of SUPERBLOCK blocks                                                               | Blocks            |
| TEMPORAL\_SQUELCH\_BLOCKS\_COUNT                                  | Difference in number of TEMPORAL\_SQUELCH blocks                                                        | Blocks            |
| TRANSIENT\_INTEGRITY\_ISSUES                                      | Number of transient filesystem integrity issues detected                                                | Issues            |
| UNSUCCESSFUL\_DATA\_WEDGINGS                                      | Number of unsuccessful attempts to wedge data blocks in journal per second                              | Attempts/Sec      |
| USED\_L2\_RESERVED\_ENTRY                                         | Number of uses of L2 reserved entries                                                                   | Occurrences       |
| USER\_DATA\_BUFFERS\_IN\_USE                                      | Number of data buffers used for serving ongoing IOs                                                     | Buffers           |
| WRITES                                                            | Number of write operations per second                                                                   | Ops/Sec           |
| WRITE\_BYTES                                                      | Number of bytes written per second                                                                      | Bytes/Sec         |
| WRITE\_LATENCY                                                    | Average latency of WRITE operations                                                                     | Microseconds      |

### Bucket Failovers

| Type                          | Description                                                                  | Units      |
| ----------------------------- | ---------------------------------------------------------------------------- | ---------- |
| BUCKET\_FAILOVERS             | Number of failovers detected in remote buckets                               | Failovers  |
| REMOTE\_BUCKET\_IS\_SECONDARY | Number of times a remote bucket reported it is secondary and cannot serve us | Exceptions |

### Bucket Rebalances

| Type                                   | Description                                               | Units           |
| -------------------------------------- | --------------------------------------------------------- | --------------- |
| BUCKET\_INITS                          | Number of bucket initializations                          | Times           |
| BUCKET\_INIT\_LATENCY                  | Average latency of bucket initialization                  | Seconds         |
| BUCKET\_INIT\_LATENCY\_HIST            | Duration of bucket initialization                         | Initializations |
| BUCKET\_REBALANCER\_STEPDOWN\_REQUESTS | Number of bucket rebalancer stepdown requests of a bucket | Times           |
| INFORMATIVE\_DENY\_BUCKET\_ACCESS      | Number of new-style NotBucketLeaderEx exceptions          | Exceptions      |
| LEGACY\_DENY\_BUCKET\_ACCESS           | Number of old-style NotBucketLeader exceptions            | Exceptions      |

### Charters

| Type                                | Description                    | Units    |
| ----------------------------------- | ------------------------------ | -------- |
| DEDGRADED\_TO\_READER\_RELINQUISHES | Charter relinquishes by reason | charters |
| EAGER\_RELINQUISHES                 | Charter relinquishes by reason | charters |
| LRU\_EXPIRED\_RELINQUISHES          | Charter relinquishes by reason | charters |
| LRU\_LENGTH\_RELINQUISHES           | Charter relinquishes by reason | charters |
| OUT\_OF\_SPACE\_RELINQUISHES        | Charter relinquishes by reason | charters |

### Choking

| Type                          | Description                                                                  | Units     |
| ----------------------------- | ---------------------------------------------------------------------------- | --------- |
| CHOKING\_LEVEL\_ALL           | Throttling level applied on all types of IOs, both mutating and non-mutating | Processes |
| CHOKING\_LEVEL\_NON\_MUTATING | Throttling level applied on non-mutating only types of IOs                   | Processes |

### Clients

| Type                  | Description                                                                     | Units       |
| --------------------- | ------------------------------------------------------------------------------- | ----------- |
| CLIENTS\_CONNECTED    | Clients connected                                                               | Clients/Sec |
| CLIENTS\_DISCONNECTED | The number of clients left or removed                                           | Clients/Sec |
| CLIENTS\_LEFT         | The number of clients left                                                      | Clients/Sec |
| CLIENTS\_RECONNECTED  | The number of clients reconnected instead of their previous connection instance | Clients/Sec |
| CLIENTS\_REMOVED      | The number of clients removed                                                   | Clients/Sec |

### Cloud

| Type                   | Description                                             | Units |
| ---------------------- | ------------------------------------------------------- | ----- |
| TOTAL\_PROXY\_REQUESTS | Number of times the process used other nodes as a proxy | Times |

### Config

| Type                                                            | Description                                                                                                                      | Units                                                 |
| --------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| AVERAGE\_CHANGES\_IN\_CHANGESET                                 | The average number of changes in a changeset                                                                                     | Changes/Sec                                           |
| AVERAGE\_CHANGES\_IN\_GENERATION                                | The average number of changes in a generation                                                                                    | Changes/Sec                                           |
| BACKEND\_NODE\_REJOIN\_TIME                                     | The number of backends rejoin attempts per completion time range                                                                 | Number of rejoins                                     |
| CHANGESET\_COMMIT\_LATENCY                                      | The average latency of committing a configuration changeset                                                                      | Microseconds                                          |
| CLIENT\_NODE\_REJOIN\_TIME                                      | The number of clients rejoin attempts per completion time range                                                                  | Number of rejoins                                     |
| CONFIG\_PROPAGATION\_LATENCY\_BACKENDS                          | The latencies of propagation of a configuration generation to backend nodes                                                      | Generation                                            |
| CONFIG\_PROPAGATION\_LATENCY\_CLIENTS                           | The latencies of propagation of a configuration generation to client nodes                                                       | Generation                                            |
| GENERATION\_COMMIT\_LATENCY                                     | The average latency of committing a configuration generation to the RAFT log                                                     | Microseconds                                          |
| GENERATION\_PROPAGATION\_AND\_APPLY\_LATENCY                    | The duration between when the leader created a ConfigGeneration until a node applies it as its active configuration              | Microseconds                                          |
| HEARTBEAT\_PROCESSING\_TIME                                     | The number of non-leader heartbeats per processing time range                                                                    | Number of heartbeats                                  |
| HEARTBEAT\_PROCESSING\_TIME\_OLD                                | The number of non-leader heartbeats per processing time range (OLD)                                                              | Number of heartbeats                                  |
| HISTOGRAM\_LEADER\_ITERATION\_WAIT\_DURATION\_CONFIG\_ALIGNMENT | Wait duration of leader iteration for all nodes to align on latest configuration generation                                      | Leader iteration wait time                            |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME                             | The number of leader heartbeats per processing time range                                                                        | Number of heartbeats                                  |
| LEADER\_HEARTBEAT\_PROCESSING\_TIME\_OLD                        | The number of leader heartbeats per processing time range (OLD)                                                                  | Number of heartbeats                                  |
| LOCALSTATE\_AGGREGATION\_LATENCY                                | This period between clockSkewReportTime table's update by a management process and the time the leader sees it                   | Time is taken to aggregate LocalState in milliseconds |
| LOCAL\_STATE\_BLOCKED\_CHANGES                                  | The number of local-state changes that were blocked from propagating to the parent                                               | Blocked LocalState Changes                            |
| LOCAL\_STATE\_DROPPED\_NON\_REPORTING\_CHILD\_KEYS              | The number of non-reporting local-state entries that a node dropped (when re-aggregating a locally-aggregated local-state table) | Dropped Non-Reporting locally-aggregated Keys         |
| LOCAL\_STATE\_LOCALLY\_AGGREGATED\_REMOVED                      | The number of times that an inner node removed a locally-aggregated key from parent facing table                                 | Overlay Parent locally-aggregated Keys Removed        |
| LOCAL\_STATE\_RE\_AGGREGATING\_LOCALLY                          | The number of times that an inner node needed to re-aggregate a locally-aggregated local-state table                             | Re-Aggregations of locally-aggregated Keys            |
| LOCAL\_STATS\_FETCH\_GENERATION\_LAGGING                        | The number of local-state generations that the parent fetch request still needs to read                                          | local-state generations                               |
| OVERLAY\_FULL\_SHIFTS                                           | The number of entire overlay shifts                                                                                              | Changes                                               |
| OVERLAY\_INCREMENTAL\_SHIFTS                                    | The number of incremental overlay shifts                                                                                         | Changes                                               |
| OVERLAY\_TRACKER\_INCREMENTALS                                  | The number of incremental OverlayTracker applications                                                                            | Changes                                               |
| OVERLAY\_TRACKER\_RESYNCS                                       | The number of OverlayTracker full-resyncs                                                                                        | Changes                                               |
| QUEUED\_CONFIG\_COMMIT\_REQUEST                                 | The number of configuration commit requests that await in the queue for RAFT to be available                                     | Commit Requests                                       |
| TOTAL\_CHANGESETS\_COMMITTED                                    | The total number of committed changesets                                                                                         | Change Sets                                           |
| TOTAL\_COMMITTED\_CHANGES                                       | The total number of committed configuration change sets                                                                          | Changes                                               |
| TOTAL\_CONFIG\_SNAPSHOT\_PULLS                                  | The total number of config snapshot pulls                                                                                        | Pulls                                                 |
| TOTAL\_GENERATIONS\_COMMITTED                                   | The number of committed generations                                                                                              | Generations                                           |

### CPU

| Type             | Description                                           | Units |
| ---------------- | ----------------------------------------------------- | ----- |
| CPU\_UTILIZATION | The percentage of the CPU time used for handling I/Os | %     |

### Data Reduction

| Type                                      | Description                                                                                                                                   | Units          |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| ACCEPTED\_INGESTS                         | Number of ingests accepted by the extent                                                                                                      | Blocks/Sec     |
| ACCEPTED\_RELOCATES                       | Number of relocation accepted by the extent                                                                                                   | Blocks/Sec     |
| ACCEPTED\_SEGMENTS                        | Number of blocks accepted for clustering                                                                                                      | Blocks/Sec     |
| AVG\_DELTAS                               | Average deltas per reference during ingestion (excluding history)                                                                             | deltas/ref     |
| CLUSTERIZE\_CALLS                         | Clusterize Calls                                                                                                                              | Calls/Sec      |
| CLUSTERIZE\_TIME                          | Average time to clusterize                                                                                                                    | Milliseconds   |
| COMPRESSED\_DELTA\_FRAGMENTS              | Average number of contiguous reads caused by delta blocks (self + reference) per delta, excluding single blocks                               | Reads          |
| COMPRESSED\_DELTA\_SIZE                   | Average size of new compressed delta segments                                                                                                 | Bytes          |
| COMPRESSED\_ETERNAL\_SINGLE\_SIZE         | Average size of new compressed eternal-single segments                                                                                        | Bytes          |
| COMPRESSED\_EXTENTS                       | Number of compressed extents whose fragmentation was sampled (one per fully-ingested extent)                                                  | Extents/Sec    |
| COMPRESSED\_EXTENT\_DELTAS                | Total number of delta blocks across all sampled compressed extents                                                                            | Blocks/Sec     |
| COMPRESSED\_EXTENT\_DELTA\_REF\_FRAGMENTS | Average number of contiguous reads attributable to delta reference reads per delta block (reads that exist only because of delta compression) | Reads          |
| COMPRESSED\_EXTENT\_FRAGMENTS             | Average number of contiguous reads needed to read a whole logical extent after data reduction                                                 | Reads          |
| COMPRESSED\_REF\_ABLE\_SIZE               | Average size of new compressed referencable segments                                                                                          | Bytes          |
| COMPRESSED\_SELF\_DELTA\_SAMPLES          | Number of sampled self-compress measurements per similarity value                                                                             | Samples        |
| COMPRESSED\_SELF\_DELTA\_SIZE             | Average self-compress size of sampled new delta segments per similarity value                                                                 | Bytes          |
| COMPRESSED\_SELF\_DELTA\_TOTAL\_SIZE      | Total self-compress size of sampled new delta segments per similarity value                                                                   | Bytes          |
| COMPRESSED\_SIZE                          | Average size of new compressed segments                                                                                                       | Bytes          |
| COMPRESS\_TASK\_CALLS                     | Compress Task Calls                                                                                                                           | Calls/Sec      |
| COMPRESS\_TASK\_TIME                      | Average time to complete compress task                                                                                                        | Milliseconds   |
| CROSS\_BLOCKS\_READ\_ERRS                 | Number of failed reads due to wrong crossBlocks flag                                                                                          | Reads/Sec      |
| DELTAS\_COMPLETE\_RELOCS                  | Number of delta blocks notified about a relocation of both delta and ref segments at the same time                                            | Blocks/Sec     |
| DELTAS\_GC                                | Number of delta blocks removed by GC                                                                                                          | Blocks/Sec     |
| DELTAS\_KEPT\_INSUFFICIENT\_SAMPLES       | Number of delta segments kept because not enough delta or self-compress samples were available for the similarity bin                         | Segments/Sec   |
| DELTAS\_KEPT\_NO\_WINDOW\_EXTENTS         | Number of delta segments kept because no deltas were observed in the stats window (fragmentation ratio unavailable)                           | Segments/Sec   |
| DELTAS\_PER\_SIMILARITY                   | Number of new compressed delta segments per similarity value                                                                                  | Segments       |
| DELTAS\_REF\_RELOCS                       | Number of delta blocks notified about reference relocations                                                                                   | Blocks/Sec     |
| DELTAS\_RESET\_BELOW\_THRESHOLD           | Number of delta segments demoted to singles because their similarity dropped below the threshold during distribution to compression buckets   | Segments/Sec   |
| DELTA\_BACKPTR\_COLLISIONS                | Number of times delta blocks with the same backptr were encountered during GC                                                                 | Blocks/Sec     |
| DELTA\_PROMOTES                           | Number of delta blocks promoted by GC                                                                                                         | Blocks/Sec     |
| DELTA\_RELOCS                             | Number of delta blocks relocated by GC                                                                                                        | Blocks/Sec     |
| DELTA\_REMOVAL\_BACKPTR\_COLLISIONS       | Number of times delta blocks with the same backptr were encountered during deletions flush                                                    | Blocks/Sec     |
| DELTA\_SIZE\_PER\_SIMILARITY              | Average size of new compressed delta segments per similarity value                                                                            | Bytes          |
| DELTA\_TOTAL\_PER\_SIMILARITY             | Total size of new compressed delta segments per similarity value                                                                              | Bytes          |
| DISCOVERED\_FREE\_BYTES                   | Free bytes discovered by scrub                                                                                                                | Bytes/Sec      |
| DROPPED\_HISTORY\_UPDATES                 | Number of History Updated Dropped                                                                                                             | Segments/Sec   |
| DROPPED\_SEGMENTS                         | Number of blocks dropped during clustering                                                                                                    | Blocks/Sec     |
| ENQUEUED\_FP\_CALCS                       | Written blocks to data-reduction filesystems, requiring fingerprint calculations                                                              | Blocks/Sec     |
| ETERNAL\_SINGLES\_UNIQUES\_EST\_LOG       | Log2 of number of unique hashes for new eternal single blocks                                                                                 | Blocks         |
| ETERNAL\_SINGLE\_PROMOTES                 | Number of eternal single blocks promoted by GC                                                                                                | Blocks/Sec     |
| ETERNAL\_SINGLE\_RELOCS                   | Number of eternal single blocks relocated by GC                                                                                               | Blocks/Sec     |
| ETERNAL\_SINGLE\_TOTAL\_SIZE              | Total size of new compressed eternal-single segments                                                                                          | Bytes          |
| GC\_PROMOTIONS                            | Number of times data was rewritten to the next GC tree level                                                                                  | Blocks/Sec     |
| HISTORY\_DOUBLE\_ADDS                     | Number of double-adds encountered in history                                                                                                  | Errs/Sec       |
| HISTORY\_READ\_ERRS                       | Number of failed reference reads from history                                                                                                 | Reads/Sec      |
| INGEST\_PERFORMED\_FP\_CALCS              | Delayed data-reduction fingerprint calculations performed during ingest                                                                       | Blocks/Sec     |
| INGEST\_START\_CALLS                      | Ingest Start Calls                                                                                                                            | Calls/Sec      |
| INGEST\_START\_TIME                       | Average time to start ingest                                                                                                                  | Milliseconds   |
| MEMORY\_HISTORY\_TRUNCATES                | Number of History Truncations due to low memory                                                                                               | Reads/Sec      |
| NEW\_DELTAS                               | Number of new delta blocks created                                                                                                            | Blocks         |
| NEW\_DELTAS\_FROM\_HISTORY                | Number of new delta blocks created with references from history                                                                               | Blocks/Sec     |
| NEW\_DELTAS\_FROM\_INGEST                 | Number of new delta blocks created with references from the same ingest batch                                                                 | Blocks/Sec     |
| NEW\_ETERNAL\_SINGLES                     | Number of new eternal single blocks created                                                                                                   | Blocks/Sec     |
| NEW\_INCOMPRESSIBLE\_DELTAS               | Number of new incompressible delta segments ingested                                                                                          | Blocks/Sec     |
| NEW\_INCOMPRESSIBLE\_REF\_ABLES           | Number of new incompressible referencable segments ingested                                                                                   | Blocks/Sec     |
| NEW\_INGESTED                             | Ingested Blocks                                                                                                                               | Blocks         |
| NEW\_REFERENCES                           | Number of new reference blocks created                                                                                                        | Blocks/Sec     |
| NEW\_REF\_ABLES                           | Number of new referencable blocks created                                                                                                     | Blocks         |
| NEW\_SINGLES                              | Number of new (non-eternal) single blocks created                                                                                             | Blocks/Sec     |
| PERFORMED\_FP\_CALCS                      | Executed data-reduction fingerprint calculations                                                                                              | Blocks/Sec     |
| REFERENCE\_GC                             | Number of reference blocks removed by GC                                                                                                      | Blocks/Sec     |
| REFERENCE\_PROMOTES                       | Number of reference blocks promoted by GC                                                                                                     | Blocks/Sec     |
| REFERENCE\_RELOCS                         | Number of reference blocks relocated by GC                                                                                                    | Blocks/Sec     |
| REFS\_DEMOTED\_WITH\_ALL\_DELTAS          | Number of reference blocks demoted to singles because all their deltas were demoted below the fragmentation threshold                         | Segments/Sec   |
| REF\_BACKPTR\_COLLISIONS                  | Number of times blocks with the same reference-backptr were encountered during GC                                                             | Blocks/Sec     |
| REJECTED\_INGESTS                         | Number of ingests rejected by the extent                                                                                                      | Blocks/Sec     |
| REJECTED\_RELOCATES                       | Number of relocation rejected by the extent                                                                                                   | Blocks/Sec     |
| REPLACED\_FP\_CALCS                       | Block rewrites replacing the data for fingerprint calculations                                                                                | Blocks/Sec     |
| SCRUBBED\_PLACEMENTS                      | Number of scrubbed placements                                                                                                                 | Placements/Sec |
| SEGMENT\_PROMOTES                         | Promoted Compressed Blocks                                                                                                                    | Blocks         |
| SEGMENT\_PROMOTES\_BYTES                  | Number of segment bytes promoted by GC                                                                                                        | Bytes/Sec      |
| SEGMENT\_RELOCS                           | Relocated Compressed Blocks                                                                                                                   | Blocks         |
| SEGMENT\_RELOCS\_BYTES                    | Number of segment bytes relocated by GC                                                                                                       | Bytes/Sec      |
| SINGLES\_DELAYED                          | Number of single blocks delayed from the COMPRESS phase to COMPRESS2 because no delta chose them as a reference                               | Segments/Sec   |
| SINGLES\_MARKED\_AS\_REFS                 | Number of single blocks marked as references due to new matches                                                                               | Blocks/Sec     |
| SKIPPED\_FP\_CALCS                        | Writes to data-reduction filesystems that skipped fingerprint calculations                                                                    | Blocks/Sec     |
| STALE\_HISTORY\_USE                       | Number of segments used as references                                                                                                         | Reads/Sec      |
| boxSize                                   | Box sizes histogram                                                                                                                           | Segments       |
| filterBoxSize                             | Box sizes During Filter                                                                                                                       | Boxes          |
| histBoxSize                               | Box sizes during histogram                                                                                                                    | Boxes          |
| historyLogHist                            | HistoryLogHist                                                                                                                                | Segments       |
| historySegsInSliceShard                   | History segments in slice shard                                                                                                               | Segments       |
| improvedFrom                              | Similarity improvements old values                                                                                                            | Segments       |
| improvedTo                                | Similarity improvements new values                                                                                                            | Segments       |
| inheritedRefs                             | Inherited Refs                                                                                                                                | Segments       |
| intoFilter                                | Segments inserted into filter                                                                                                                 | Segments       |
| refsBySource                              | Refs by ref source                                                                                                                            | Refs           |
| segsInSliceShard                          | Segments in slice shard                                                                                                                       | Segments       |
| similarityByRefSource                     | Similarity histogram per ref source                                                                                                           | Score          |
| typicalCandidatesPerHist                  | TypicalCandidatesPerHist                                                                                                                      | Segments       |
| typicalRefsPerHist                        | TypicalRefsPerHist                                                                                                                            | Segments       |

### Dataservice

| Type                                                       | Description                                                                                                                                                                                                                                                                                                                 | Units             |
| ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| DIFFLIST\_GET\_LATENCY                                     | Average latency of getDifflist                                                                                                                                                                                                                                                                                              | Microseconds      |
| DIFFLIST\_GET\_MANIFEST\_LATENCY                           | Average latency of getDifflist getManifest                                                                                                                                                                                                                                                                                  | Microseconds      |
| DIFFLIST\_GET\_MANIFEST\_OPS                               | Number of getDifflist getManifest                                                                                                                                                                                                                                                                                           | Ops/Sec           |
| DIFFLIST\_GET\_MANIFEST\_PER\_GETLIST\_LATENCY             | Average latency of getDifflist getmanifest per getdifflist                                                                                                                                                                                                                                                                  | Microseconds      |
| DIFFLIST\_GET\_MANIFEST\_PER\_GETLIST\_OPS                 | Number of getDifflist getmanifest per getdifflist                                                                                                                                                                                                                                                                           | Ops/Sec           |
| DIFFLIST\_GET\_OPS                                         | Number of getDifflist                                                                                                                                                                                                                                                                                                       | Ops/Sec           |
| DIFFLIST\_RESOLVENAME\_LATENCY                             | Average latency of getDifflist resolvename                                                                                                                                                                                                                                                                                  | Microseconds      |
| DIFFLIST\_RESOLVENAME\_OPS                                 | Number of getDifflist resolvename ops                                                                                                                                                                                                                                                                                       | Ops/Sec           |
| DIFFLIST\_RESOLVEPATH\_LATENCY                             | Average latency of getDifflist resolvepath                                                                                                                                                                                                                                                                                  | Microseconds      |
| DIFFLIST\_RESOLVEPATH\_OPS                                 | Number of getDifflist resolvepath                                                                                                                                                                                                                                                                                           | Ops/Sec           |
| DIFFLIST\_RESOLVE\_PATH\_BATCH\_LATENCY                    | Average latency of getDifflist resolve-path per batch                                                                                                                                                                                                                                                                       | Microseconds      |
| DIFFLIST\_RESOLVE\_PATH\_BATCH\_OPS                        | Number of getDifflist resolve-path per batch                                                                                                                                                                                                                                                                                | Ops/Sec           |
| DS\_BACKEND\_LOAD\_STALL\_TIME                             | Time spent stalling due to high backend load                                                                                                                                                                                                                                                                                | Seconds/Sec       |
| DS\_CLOSE\_TMP\_FILE\_LATENCY                              | Average latency of closeTmpFile operations                                                                                                                                                                                                                                                                                  | Microseconds      |
| DS\_CLOSE\_TMP\_FILE\_OPS                                  | Number of closeTmpFile operations per second                                                                                                                                                                                                                                                                                | Ops/Sec           |
| DS\_CREATE\_FILE\_LATENCY                                  | Average latency of createRegularFile operations                                                                                                                                                                                                                                                                             | Microseconds      |
| DS\_CREATE\_FILE\_OPS                                      | Number of createRegularFile operations per second                                                                                                                                                                                                                                                                           | Ops/Sec           |
| DS\_CREATE\_TMP\_FILE\_LATENCY                             | Average latency of createTmpFile operations                                                                                                                                                                                                                                                                                 | Microseconds      |
| DS\_CREATE\_TMP\_FILE\_OPS                                 | Number of createTmpFile operations per second                                                                                                                                                                                                                                                                               | Ops/Sec           |
| DS\_GET\_ATTR\_LATENCY                                     | Average latency of getAttr operations                                                                                                                                                                                                                                                                                       | Microseconds      |
| DS\_GET\_ATTR\_OPS                                         | Number of getAttr operations per second                                                                                                                                                                                                                                                                                     | Ops/Sec           |
| DS\_LINK\_INODE\_LATENCY                                   | Average latency of linkInodeToDentry operations                                                                                                                                                                                                                                                                             | Microseconds      |
| DS\_LINK\_INODE\_OPS                                       | Number of linkInodeToDentry operations per second                                                                                                                                                                                                                                                                           | Ops/Sec           |
| DS\_LOOKUP\_NAME\_LATENCY                                  | Average latency of lookupName operations                                                                                                                                                                                                                                                                                    | Microseconds      |
| DS\_LOOKUP\_NAME\_OPS                                      | Number of lookupName operations per second                                                                                                                                                                                                                                                                                  | Ops/Sec           |
| DS\_LOOKUP\_PATH\_LATENCY                                  | Average latency of lookupPath operations                                                                                                                                                                                                                                                                                    | Microseconds      |
| DS\_LOOKUP\_PATH\_OPS                                      | Number of lookupPath operations per second                                                                                                                                                                                                                                                                                  | Ops/Sec           |
| DS\_PQ\_ADD\_LATENCY                                       | Average latency of persistent queue createEntry operations across all DS tasks                                                                                                                                                                                                                                              | Microseconds      |
| DS\_PQ\_ADD\_OPS                                           | Number of persistent queue createEntry operations per second across all DS tasks                                                                                                                                                                                                                                            | Ops/Sec           |
| DS\_PQ\_DEEPEST\_LEVEL                                     | Deepest PQ level dequeued from on this node since startup (monotonic max across all DS task types). Diagnostic only — non-zero values confirm the per-tree-depth PQ layout is scheduling deepest-first as designed                                                                                                          | Levels            |
| DS\_PQ\_LIST\_LEVELS\_LATENCY                              | Average latency of persistent queue listLevels operations across all DS tasks                                                                                                                                                                                                                                               | Microseconds      |
| DS\_PQ\_LIST\_LEVELS\_OPS                                  | Number of persistent queue listLevels operations per second across all DS tasks. Each call enumerates the level\_/ subdirs of one task dir; invoked once per getNextEntries on the level-layout path and once per removeTask teardown                                                                                       | Ops/Sec           |
| DS\_PQ\_PROGRESS\_ESTIMATE\_LATENCY                        | Average latency of persistent queue progress-estimate computations (fanout-weighted cascade + projected tail) across all DS tasks                                                                                                                                                                                           | Microseconds      |
| DS\_PQ\_PROGRESS\_ESTIMATE\_OPS                            | Number of persistent queue progress-estimate computations per second. Each call wraps the fanout-weighted cascade + tail projection inside getNextEntries on the level-layout path; paired with DS\_PQ\_PROGRESS\_ESTIMATE\_LATENCY it quantifies whether the projection logic is cheap enough to keep or worth simplifying | Ops/Sec           |
| DS\_PQ\_READDIR\_LATENCY                                   | Average latency of persistent queue readdir operations across all DS tasks                                                                                                                                                                                                                                                  | Microseconds      |
| DS\_PQ\_READDIR\_OPS                                       | Number of persistent queue readdir operations per second across all DS tasks                                                                                                                                                                                                                                                | Ops/Sec           |
| DS\_PQ\_READDIR\_WRAPS                                     | Number of persistent queue readdir resume-cursor wrap-arounds                                                                                                                                                                                                                                                               | Ops               |
| DS\_PQ\_REMOVE\_LATENCY                                    | Average latency of persistent queue removeEntry operations across all DS tasks                                                                                                                                                                                                                                              | Microseconds      |
| DS\_PQ\_REMOVE\_OPS                                        | Number of persistent queue removeEntry operations per second across all DS tasks                                                                                                                                                                                                                                            | Ops/Sec           |
| DS\_READDIR\_LATENCY                                       | Average latency of readdir operations                                                                                                                                                                                                                                                                                       | Microseconds      |
| DS\_READDIR\_OPS                                           | Number of readdir operations per second                                                                                                                                                                                                                                                                                     | Ops/Sec           |
| DS\_READ\_FILE\_LATENCY                                    | Average latency of readFileContent operations                                                                                                                                                                                                                                                                               | Microseconds      |
| DS\_READ\_FILE\_OPS                                        | Number of readFileContent operations per second                                                                                                                                                                                                                                                                             | Ops/Sec           |
| DS\_RMDIR\_LATENCY                                         | Average latency of rmdir operations                                                                                                                                                                                                                                                                                         | Microseconds      |
| DS\_RMDIR\_OPS                                             | Number of rmdir operations per second                                                                                                                                                                                                                                                                                       | Ops/Sec           |
| DS\_SET\_XATTR\_LATENCY                                    | Average latency of setXAttrString operations                                                                                                                                                                                                                                                                                | Microseconds      |
| DS\_SET\_XATTR\_OPS                                        | Number of setXAttrString operations per second                                                                                                                                                                                                                                                                              | Ops/Sec           |
| DS\_UNLINK\_FILE\_LATENCY                                  | Average latency of unlinkFile operations                                                                                                                                                                                                                                                                                    | Microseconds      |
| DS\_UNLINK\_FILE\_OPS                                      | Number of unlinkFile operations per second                                                                                                                                                                                                                                                                                  | Ops/Sec           |
| FAST\_DELETE\_FILE\_DELETION\_FAILED\_PER\_TASK            | Number of times file deletion failed during fast delete task                                                                                                                                                                                                                                                                | Files             |
| FAST\_DELETE\_METADATA\_DIR\_DELETION\_FAILED              | Number of times metadata directory deletion failed during fast delete task                                                                                                                                                                                                                                                  | Directories       |
| FAST\_DELETE\_METADATA\_FILE\_DELETION\_FAILED             | Number of times metadata file deletion failed during fast delete task                                                                                                                                                                                                                                                       | Files             |
| FAST\_DELETE\_TASK\_ADD\_DIR\_ENTRIES                      | Number of directory entries added for fast delete task                                                                                                                                                                                                                                                                      | Ops/Sec           |
| FAST\_DELETE\_TASK\_CREATES                                | Number of fast delete tasks created                                                                                                                                                                                                                                                                                         | Ops               |
| FAST\_DELETE\_TASK\_DELETES                                | Number of fast delete tasks removed                                                                                                                                                                                                                                                                                         | Ops               |
| FAST\_DELETE\_TASK\_DELETE\_DIR\_ENTRIES                   | Number of entries removed for fast delete task                                                                                                                                                                                                                                                                              | Ops/Sec           |
| FAST\_DELETE\_TASK\_DIRS\_DELETED                          | Number of directories deleted by the fast delete task per shard                                                                                                                                                                                                                                                             | Directories       |
| FAST\_DELETE\_TASK\_FIBERS                                 | Number of fast delete task fibers spawned per second                                                                                                                                                                                                                                                                        | Fibers            |
| FAST\_DELETE\_TASK\_FILES\_DELETED                         | Number of files deleted by the fast delete task per shard                                                                                                                                                                                                                                                                   | Files/Sec         |
| FAST\_DELETE\_TASK\_FILES\_DELETED\_PER\_TASK              | Number of files deleted per fast delete task                                                                                                                                                                                                                                                                                | Files/Sec         |
| FAST\_DELETE\_TASK\_FILES\_PROCESSED                       | Number of files processed by the fast delete task per shard                                                                                                                                                                                                                                                                 | Files/Sec         |
| FAST\_DELETE\_TASK\_FILES\_PROCESSED\_PER\_TASK            | Number of files processed per fast delete task                                                                                                                                                                                                                                                                              | Files/Sec         |
| FAST\_DELETE\_TASK\_READDIR\_LATENCY                       | Average latency of fast delete task readdir operations                                                                                                                                                                                                                                                                      | Microseconds      |
| FAST\_DELETE\_TASK\_READDIR\_OPS                           | Number of fast delete task readdir operations per second                                                                                                                                                                                                                                                                    | Ops/Sec           |
| FAST\_DELETE\_TASK\_RUNTIME                                | Average runtime of fast delete task fibers                                                                                                                                                                                                                                                                                  | Microseconds      |
| FAST\_DELETE\_TASK\_TOTAL\_DIRS\_DELETED                   | Number of directories deleted by the fast delete task                                                                                                                                                                                                                                                                       | Directories       |
| FAST\_DELETE\_TASK\_TOTAL\_FILES\_DELETED                  | Number of files deleted by the fast delete task                                                                                                                                                                                                                                                                             | Files/Sec         |
| FAST\_DELETE\_TASK\_TOTAL\_FILES\_PROCESSED                | Number of files processed by the fast delete task                                                                                                                                                                                                                                                                           | Files/Sec         |
| QUOTAS\_MARKED                                             | Number of directory quotas marked                                                                                                                                                                                                                                                                                           | Quotas            |
| QUOTA\_TASK\_ADD\_DIR\_ENTRIES                             | Number of entries added for directory quota task                                                                                                                                                                                                                                                                            | Ops               |
| QUOTA\_TASK\_CREATES                                       | Number of directory quota tasks created                                                                                                                                                                                                                                                                                     | Ops               |
| QUOTA\_TASK\_DELETES                                       | Number of directory quota tasks removed                                                                                                                                                                                                                                                                                     | Ops               |
| QUOTA\_TASK\_DELETE\_DIR\_ENTRIES                          | Number of entries removed for directory quota task                                                                                                                                                                                                                                                                          | Ops               |
| QUOTA\_TASK\_FAILED\_STAMPS                                | Number of failed quota coloring stamp operations                                                                                                                                                                                                                                                                            | Ops               |
| QUOTA\_TASK\_FIBERS                                        | Number of directory quota task fibers spawned per second                                                                                                                                                                                                                                                                    | Fibers            |
| QUOTA\_TASK\_READDIR\_LATENCY                              | Average latency of directory quota task readdir operations                                                                                                                                                                                                                                                                  | Microseconds      |
| QUOTA\_TASK\_READDIR\_OPS                                  | Number of directory quota task readdir operations per second                                                                                                                                                                                                                                                                | Ops/Sec           |
| QUOTA\_TASK\_RUNTIME                                       | Average runtime of directory quota task fibers                                                                                                                                                                                                                                                                              | Microseconds      |
| QUOTA\_TASK\_STAMPS                                        | Number of directory quota stamp operations per second                                                                                                                                                                                                                                                                       | Ops/Sec           |
| QUOTA\_TASK\_STAMP\_LATENCY                                | Average latency of directory quota task stamp operations                                                                                                                                                                                                                                                                    | Microseconds      |
| QUOTA\_TASK\_SUCCESSFUL\_STAMPS                            | Number of successful directory quota stamp operations                                                                                                                                                                                                                                                                       | Ops               |
| S3\_LIFECYCLE\_FILE\_DELETION\_FAILED\_PER\_TASK           | Number of times file deletion failed during s3 lifecycle task                                                                                                                                                                                                                                                               | Files             |
| S3\_LIFECYCLE\_METADATA\_DIR\_DELETION\_FAILED             | Number of times metadata directory deletion failed during s3 lifecycle task                                                                                                                                                                                                                                                 | Directories       |
| S3\_LIFECYCLE\_METADATA\_FILE\_DELETION\_FAILED            | Number of times metadata file deletion failed during S3 lifecycle task                                                                                                                                                                                                                                                      | Files             |
| S3\_LIFECYCLE\_TASK\_ADD\_DIR\_ENTRIES                     | Number of directory entries added for s3 lifecycle task                                                                                                                                                                                                                                                                     | Ops/Sec           |
| S3\_LIFECYCLE\_TASK\_CREATES                               | Number of s3 lifecycle tasks created                                                                                                                                                                                                                                                                                        | Ops               |
| S3\_LIFECYCLE\_TASK\_DELETES                               | Number of s3 lifecycle tasks removed                                                                                                                                                                                                                                                                                        | Ops               |
| S3\_LIFECYCLE\_TASK\_DELETE\_DIR\_ENTRIES                  | Number of entries removed for s3 lifecycle task                                                                                                                                                                                                                                                                             | Ops/Sec           |
| S3\_LIFECYCLE\_TASK\_DELETE\_MARKERS\_CREATED              | Number of delete markers created by the S3 lifecycle task per shard (T7 current-version expiration)                                                                                                                                                                                                                         | DeleteMarkers/Sec |
| S3\_LIFECYCLE\_TASK\_DELETE\_MARKERS\_CREATED\_PER\_BUCKET | Number of delete markers created per s3 bucket                                                                                                                                                                                                                                                                              | DeleteMarkers/Sec |
| S3\_LIFECYCLE\_TASK\_DELETE\_MARKERS\_CREATED\_PER\_TASK   | Number of delete markers created per s3 lifecycle task                                                                                                                                                                                                                                                                      | DeleteMarkers/Sec |
| S3\_LIFECYCLE\_TASK\_DIRS\_DELETED                         | Number of directories deleted by the S3 lifecycle task per shard                                                                                                                                                                                                                                                            | Directories       |
| S3\_LIFECYCLE\_TASK\_FIBERS                                | Number of s3 lifecycle task fibers spawned per second                                                                                                                                                                                                                                                                       | Fibers            |
| S3\_LIFECYCLE\_TASK\_FILES\_DELETED                        | Number of files deleted by the S3 lifecycle task per shard                                                                                                                                                                                                                                                                  | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_FILES\_DELETED\_PER\_BUCKET           | Number of files deleted per s3 bucket                                                                                                                                                                                                                                                                                       | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_FILES\_DELETED\_PER\_TASK             | Number of files deleted per s3 lifecycle task                                                                                                                                                                                                                                                                               | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_FILES\_PROCESSED                      | Number of files processed by the S3 lifecycle task per shard                                                                                                                                                                                                                                                                | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_FILES\_PROCESSED\_PER\_BUCKET         | Number of files processed per s3 bucket                                                                                                                                                                                                                                                                                     | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_FILES\_PROCESSED\_PER\_TASK           | Number of files processed per s3 lifecycle task                                                                                                                                                                                                                                                                             | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_READDIR\_LATENCY                      | Average latency of s3 lifecycle task readdir operations                                                                                                                                                                                                                                                                     | Microseconds      |
| S3\_LIFECYCLE\_TASK\_READDIR\_OPS                          | Number of s3 lifecycle task readdir operations per second                                                                                                                                                                                                                                                                   | Ops/Sec           |
| S3\_LIFECYCLE\_TASK\_RUNTIME                               | Average runtime of s3 lifecycle task fibers                                                                                                                                                                                                                                                                                 | Microseconds      |
| S3\_LIFECYCLE\_TASK\_TOTAL\_DELETE\_MARKERS\_CREATED       | Number of delete markers created by the s3 lifecycle task                                                                                                                                                                                                                                                                   | DeleteMarkers/Sec |
| S3\_LIFECYCLE\_TASK\_TOTAL\_DIRS\_DELETED                  | Number of directories deleted by the s3 lifecycle task                                                                                                                                                                                                                                                                      | Directories       |
| S3\_LIFECYCLE\_TASK\_TOTAL\_FILES\_DELETED                 | Number of files deleted by the s3 lifecycle task                                                                                                                                                                                                                                                                            | Files/Sec         |
| S3\_LIFECYCLE\_TASK\_TOTAL\_FILES\_PROCESSED               | Number of files processed by the s3 lifecycle task                                                                                                                                                                                                                                                                          | Files/Sec         |
| S3\_XATTR\_CONVERSION\_FILES\_CONVERTED                    | Number of files converted by s3 xattr conversion per shard                                                                                                                                                                                                                                                                  | Files/Sec         |
| S3\_XATTR\_CONVERSION\_FILES\_PROCESSED                    | Number of files processed by s3 xattr conversion per shard                                                                                                                                                                                                                                                                  | Files/Sec         |
| S3\_XATTR\_CONVERSION\_TASK\_ADD\_DIR\_ENTRIES             | Number of directory entries added for s3 xattr conversion task                                                                                                                                                                                                                                                              | Ops/Sec           |
| S3\_XATTR\_CONVERSION\_TASK\_CREATES                       | Number of s3 xattr conversion tasks created                                                                                                                                                                                                                                                                                 | Ops               |
| S3\_XATTR\_CONVERSION\_TASK\_DELETES                       | Number of s3 xattr conversion tasks removed                                                                                                                                                                                                                                                                                 | Ops               |
| S3\_XATTR\_CONVERSION\_TASK\_DELETE\_DIR\_ENTRIES          | Number of entries removed for s3 xattr conversion task                                                                                                                                                                                                                                                                      | Ops/Sec           |
| USER\_QUOTAS\_MARKED                                       | Number of user quotas marked                                                                                                                                                                                                                                                                                                | Quotas            |
| USER\_QUOTA\_TASK\_ADD\_DIR\_ENTRIES                       | Number of entries added for user quota task                                                                                                                                                                                                                                                                                 | Ops               |
| USER\_QUOTA\_TASK\_CREATES                                 | Number of user quota tasks created                                                                                                                                                                                                                                                                                          | Ops               |
| USER\_QUOTA\_TASK\_DELETES                                 | Number of user quota tasks removed                                                                                                                                                                                                                                                                                          | Ops               |
| USER\_QUOTA\_TASK\_DELETE\_DIR\_ENTRIES                    | Number of entries removed for user quota task                                                                                                                                                                                                                                                                               | Ops               |
| USER\_QUOTA\_TASK\_FAILED\_STAMPS                          | Number of failed user quota stamp operations                                                                                                                                                                                                                                                                                | Ops               |
| USER\_QUOTA\_TASK\_FIBERS                                  | Number of user quota task fibers spawned per second                                                                                                                                                                                                                                                                         | Fibers            |
| USER\_QUOTA\_TASK\_READDIR\_LATENCY                        | Average latency of user quota task readdir operations                                                                                                                                                                                                                                                                       | Microseconds      |
| USER\_QUOTA\_TASK\_READDIR\_OPS                            | Number of user quota task readdir operations per second                                                                                                                                                                                                                                                                     | Ops/Sec           |
| USER\_QUOTA\_TASK\_RUNTIME                                 | Average runtime of user quota task fibers                                                                                                                                                                                                                                                                                   | Microseconds      |
| USER\_QUOTA\_TASK\_STAMPS                                  | Number of user quota stamp operations per second                                                                                                                                                                                                                                                                            | Ops/Sec           |
| USER\_QUOTA\_TASK\_STAMP\_LATENCY                          | Average latency of user quota task stamp operations                                                                                                                                                                                                                                                                         | Microseconds      |
| USER\_QUOTA\_TASK\_SUCCESSFUL\_STAMPS                      | Number of successful user quota stamp operations                                                                                                                                                                                                                                                                            | Ops               |

### Decisions about buckets from the cluster leader

| Type                            | Description                                                                  | Units                          |
| ------------------------------- | ---------------------------------------------------------------------------- | ------------------------------ |
| TOTAL\_COUNCIL\_CLEANUPS        | The number of times a bucket council toRemove/toAdd field member was cleared | Bucket council cleanups        |
| TOTAL\_COUNCIL\_REDISTRIBUTIONS | The number of times a bucket council was changed for any bucket              | Bucket council redistributions |

### Directory Find

| Type                                | Description                                                          | Units        |
| ----------------------------------- | -------------------------------------------------------------------- | ------------ |
| DIR\_FIND\_IOCTL\_OPS               | The number of directory find ioctl operations                        | Ops/Sec      |
| DIR\_FIND\_IOCTL\_PROCESSSING\_TIME | The time spent by directory find ioctl processing directory entries  | Microseconds |
| DIR\_FIND\_IOCTL\_READDIR\_OPS      | The number of directory find ioctl readdir operations                | Ops/Sec      |
| DIR\_FIND\_IOCTL\_READDIR\_TIME     | The time spent by the directory find ioctl reading directory entries | Microseconds |
| DIR\_FIND\_IOCTL\_TOTAL\_LATENCY    | The total time spent by directory find ioctl operations              | Microseconds |

### ExecTime

| Type            | Description                                                                          | Units        |
| --------------- | ------------------------------------------------------------------------------------ | ------------ |
| EXECTIME\_AVG   | Average execution time (usec) of function calls that ran for over the threshold time | Microseconds |
| EXECTIME\_COUNT | Number of times the function was called and ran for over the threshold time          | Executions   |
| EXECTIME\_MAX   | Max execution time (usec) of function calls that ran for over the threshold time     | Microseconds |

### Extent Forwarding

| Type                                        | Description                                                                                                          | Units        |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------ |
| FORWARDING\_PROMOTE\_EXTENT\_WRITE          | Number of extents promoted from a forwarding target per second                                                       | Extents/Sec  |
| FORWARDING\_PROMOTE\_EXTENT\_WRITE\_LATENCY | Average latency of forwarding-extent promote writes                                                                  | Microseconds |
| FORWARDING\_PROMOTE\_WRITE                  | Number of bytes promoted from a forwarding target per second                                                         | Bytes/Sec    |
| FORWARDING\_READ                            | Number of reads served by reading from a forwarding target extent per second                                         | Ops/Sec      |
| FORWARDING\_READ\_ALIGNED                   | Number of forwarding reads whose target data was aligned to the source block grid (zero-copy passthrough) per second | Ops/Sec      |
| FORWARDING\_READ\_MISALIGNED                | Number of forwarding reads whose target data was misaligned to the source block grid (SGReader stitch) per second    | Ops/Sec      |
| FORWARDING\_READ\_PLAINTEXT                 | Number of forwarding reads served as plaintext passthrough (no source-key re-encryption) per second                  | Ops/Sec      |
| FORWARDING\_READ\_REENCRYPTED               | Number of forwarding reads that re-encrypted target blocks with the source extent key per second                     | Ops/Sec      |
| FORWARDING\_TRUNCATE                        | Number of truncates on forwarding extents per second                                                                 | Ops/Sec      |
| FORWARDING\_WRITE                           | Number of writes that needed data from a forwarding target extent per second                                         | Ops/Sec      |

### Filesystem OBS

| Type                                               | Description                                                                     | Units              |
| -------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------ |
| BACKPRESSURED\_BUCKETS\_IN\_FSS                    | Number of backpressured buckets                                                 | Buckets            |
| CONCURRENT\_DEMOTES                                | Number of demotes executed concurrently                                         | Demotes            |
| DEMOTE\_EXTENT\_OBS\_FETCH                         | Number of extent object-store fetch operations per second                       | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_BACKPRESSURE           | Number of extent BACKPRESSURE object-store fetch operations per second          | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_IMMEDIATE\_RELEASE     | Number of extent IMMEDIATE\_RELEASE object-store fetch operations per second    | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_MANHOLE                | Number of extent MANHOLE object-store fetch operations per second               | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_MIGRATE                | Number of extent MIGRATE object-store fetch operations per second               | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_POLICY                 | Number of extent POLICY object-store fetch operations per second                | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_RECLAMATION\_REUPLOAD  | Number of extent RECLAMATION\_REUPLOAD object-store fetch operations per second | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_REPLICATE              | Number of extent REPLICATE object-store fetch operations per second             | Ops/Sec            |
| DEMOTE\_EXTENT\_OBS\_FETCH\_STOW                   | Number of extent STOW object-store fetch operations per second                  | Ops/Sec            |
| DEMOTE\_WAITING\_FOR\_SLOT                         | Average time waiting for a demotion concurrency slot                            | Microseconds       |
| DESERIALIZED\_EXTENTS\_WITH\_INVALID\_BLOBS        | Number of deserialized extents with invalid blob id                             | Extents            |
| DOWNLOADS                                          | Number of downloads per second                                                  | Ops/Sec            |
| DOWNLOAD\_LATENCY                                  | Average latency of downloads                                                    | Microseconds       |
| EXTENTS\_WITH\_FAKE\_RETENTION\_TAG                | Number of scanned extents with fake retention tag                               | Extents            |
| FAILED\_DOWNLOADS                                  | Number of failed downloads per second                                           | Ops/Sec            |
| FAILED\_UPLOADS                                    | Number of failed uploads per second                                             | Ops/Sec            |
| FAILED\_UPLOAD\_VERIFICATIONS                      | Number of failed verifications of uploads                                       | Failures           |
| OBS\_4K\_IOPS\_READ                                | Number of object store dedicated 4K read operations per second                  | Ops/Sec            |
| OBS\_BACKPRESSURE\_FREED                           | Number of bytes freed from disk due to backpressure per second                  | Bytes/Sec          |
| OBS\_BLOB\_HEADER\_DOWNLOAD\_LATENCY               | Average latency of blob header download                                         | Microseconds       |
| OBS\_BLOB\_SCAVENGE\_LATENCY                       | Average latency of blob scavenges                                               | Microseconds       |
| OBS\_BLOB\_TIERING\_DURATION                       | Duration of tiering blobs to object-store                                       | Ops                |
| OBS\_COMPLETELY\_ALIVE\_BLOBS                      | Percentage of blobs with only live extents linked to them                       | %                  |
| OBS\_COMPLETELY\_DEAD\_BLOBS                       | Percentage of blobs with no live extent linked to them                          | %                  |
| OBS\_EXTENTS\_PREFETCH                             | Number of extents prefetched from object-store per second                       | Extents/Sec        |
| OBS\_FREED                                         | Number of bytes freed from disk because they are in the object-store per second | Bytes/Sec          |
| OBS\_IMMEDIATE\_RELEASE\_FREED                     | Number of bytes freed from disk due to immediate release per second             | Bytes/Sec          |
| OBS\_INODES\_PREFETCH                              | Number of files prefetched from object-store per second                         | Ops/Sec            |
| OBS\_INODES\_RELEASE                               | Number of files released to object-store per second                             | Ops/Sec            |
| OBS\_ONGOING\_RECLAMATIONS                         | Number of ongoing reclamations                                                  | Ops                |
| OBS\_POLICY\_FREED                                 | Number of bytes freed from disk due to policy per second                        | Bytes/Sec          |
| OBS\_PROMOTE\_EXTENT\_WRITE                        | Number of extents promoted from object-store per second                         | Extents/Sec        |
| OBS\_PROMOTE\_EXTENT\_WRITE\_LATENCY               | Average latency of extent promote writes                                        | Microseconds       |
| OBS\_PROMOTE\_WRITE                                | Number of bytes promoted from object-store per second                           | Bytes/Sec          |
| OBS\_READ                                          | Number of reads that needed data from the object-store per second               | Ops/Sec            |
| OBS\_RECLAMATION\_PURGED\_BYTES                    | Number of bytes purged per second                                               | Bytes/Sec          |
| OBS\_RECLAMATION\_SCAVENGED\_BLOBS                 | Number of blobs scavenged per second                                            | Ops/Sec            |
| OBS\_RECLAMATION\_SCAVENGED\_BYTES                 | Number of bytes scavenged per second                                            | Bytes/Sec          |
| OBS\_RECLAMATION\_WAIT\_FOR\_DESTAGE               | Average time waiting for destage on space reclamation                           | Microseconds       |
| OBS\_RELOC\_DOWNLOAD                               | Number of relocation blobs downloaded per second                                | Ops/Sec            |
| OBS\_RELOC\_UPLOAD                                 | Number of relocation blobs uploaded per second                                  | Ops/Sec            |
| OBS\_REPLICATE                                     | Number of replica reads that needed data from the object-store per second       | Ops/Sec            |
| OBS\_SCAVENGED\_BLOB\_WASTE\_LEVEL                 | Waste level found in blobs                                                      | Blobs              |
| OBS\_SHARED\_DOWNLOADS                             | Number of shared downloads from object-store per second                         | Ops/Sec            |
| OBS\_SHARED\_DOWNLOADS\_LATENCY                    | Average latency of shared downloads from object-store                           | Microseconds       |
| OBS\_TRUNCATE                                      | Number of truncates that needed data from the object-store per second           | Ops/Sec            |
| OBS\_UNEXPECTED\_TAG\_ON\_DOWNLOAD                 | Number of unexpected tags found when downloading extents                        | Occurrences        |
| OBS\_WRITE                                         | Number of writes that needed data from the object-store per second              | Ops/Sec            |
| STOW\_COMMIT\_QUEUE\_HANG                          | Number of times metadata download queue was hanging full                        | Occurrences        |
| STOW\_METADATA\_DESERIALIZATION\_LATENCY           | Average latency of metadata blob deserialization                                | Milliseconds       |
| STOW\_METADATA\_SEED\_DOWNLOADS                    | Number of seed downloads per second                                             | Ops/Sec            |
| STOW\_SERIALIZED\_EXTENT\_DATA                     | Number of extent descriptors uploaded that contain data                         | Extent Descriptors |
| STOW\_SERIALIZED\_EXTENT\_DESCS                    | Number of extent descriptors uploaded                                           | Extent Descriptors |
| STOW\_SERIALIZED\_EXTENT\_REDIRECTS                | Number of extent descriptors uploaded that redirect to previous snapshot        | Extent Descriptors |
| TIERED\_FS\_BREAKING\_POLICY                       | Number of tiered filesystems breaking policy                                    | Activations        |
| TIMEOUT\_DOWNLOADS                                 | Number of timed out downloads per second                                        | Ops/Sec            |
| TIMEOUT\_OPERATIONS                                | Total number of timed out operations per second                                 | Ops/Sec            |
| TIMEOUT\_UPLOADS                                   | Number of timed out uploads per second                                          | Ops/Sec            |
| UNEXPECTED\_BLOCK\_VERSION\_POST\_UPGRADE          | Number of unexpected block version found after upgrade completed                | Occurrences        |
| UPLOADS                                            | Number of upload attempts per second                                            | Ops/Sec            |
| UPLOAD\_CHOKING\_LATENCY                           | Average latency of waiting for upload choking budget                            | Microseconds       |
| UPLOAD\_LATENCY                                    | Average latency of uploads                                                      | Microseconds       |
| UPLOAD\_VERIFICATIONS                              | Number of upload verification created for all types                             | Verifications      |
| UPLOAD\_VERIFICATIONS\_PER\_METHOD\_FIRST4K        | Number of upload verification for FIRST4K                                       | Verifications      |
| UPLOAD\_VERIFICATIONS\_PER\_METHOD\_FULL\_DOWNLOAD | Number of upload verification for FULL\_DOWNLOAD                                | Verifications      |
| UPLOAD\_VERIFICATIONS\_PER\_METHOD\_HEAD           | Number of upload verification for HEAD                                          | Verifications      |
| UPLOAD\_VERIFICATIONS\_PER\_METHOD\_SKIP           | Number of upload verification for SKIP                                          | Verifications      |

### Frontend

| Type             | Description                                                               | Units      |
| ---------------- | ------------------------------------------------------------------------- | ---------- |
| FE\_IDLE\_CYCLES | The number of idle cycles on the frontend                                 | Cycles/Sec |
| FE\_IDLE\_TIME   | The percentage of the CPU time not used for handling I/Os on the frontend | %          |

### Frontend Encryption

| Type                            | Description                                         | Units        |
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

| Type                         | Description                                                   | Units      |
| ---------------------------- | ------------------------------------------------------------- | ---------- |
| GC\_ALLOC\_BYTES             | Number of bytes allocated from GC                             | Bytes      |
| GC\_FREE\_SIZE\_AFTER\_SCAN  | GC pool size after the scan ends                              | Bytes      |
| GC\_FREE\_SIZE\_BEFORE\_SCAN | GC pool size before the scan starts                           | Bytes      |
| GC\_MINIMIZED\_BYTES         | Number of bytes minimized out from GC                         | Bytes      |
| GC\_MINIMIZE\_EXECTIME\_AVG  | Average execution time (usec) of GC minimize                  | msec       |
| GC\_MINIMIZE\_EXEC\_CNT      | Number of GC Minimize executions                              | Executions |
| GC\_SCANS                    | Number of GC scans                                            | Scans      |
| GC\_SCAN\_EXECTIME\_AVG      | Average execution time (usec) of GC scan (excluding minimize) | msec       |
| GC\_SCAN\_FREED\_BYTES       | Number of bytes freed by GC scans                             | Bytes      |
| GC\_SCAN\_TIME               | GC scan time                                                  | msec       |
| GC\_USED\_SIZE\_AFTER\_SCAN  | GC used size after the scan ends                              | Bytes      |
| GC\_USED\_SIZE\_BEFORE\_SCAN | GC used size before the scan starts                           | Bytes      |

### JRPC

| Type                                                 | Description                                                                                      | Units        |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------ | ------------ |
| JRPC\_SERVER\_CALLS\_CLIENT\_DOES\_NOT\_SUPPORT\_QOS | The number of JRPC calls made from a client that does not support JRPC QoS                       | Requests/Sec |
| JRPC\_SERVER\_CALLS\_CLIENT\_SUPPORTS\_QOS           | The number of JRPC calls made from a client that supports JRPC QoS                               | Requests/Sec |
| JRPC\_SERVER\_CALLS\_QOS\_DECLINED                   | The number of JRPC calls where server returns TOO\_MANY\_REQUESTS (QoS declined to run a method) | Requests/Sec |
| JRPC\_SERVER\_PROCESSING\_AVG                        | Average time the JRPC server took to process JRPC requests                                       | Microseconds |
| JRPC\_SERVER\_PROCESSING\_TIME                       | Number of JRPC requests processed by the server per time range                                   | Requests     |

### Memory

| Type         | Description                                                        | Units |
| ------------ | ------------------------------------------------------------------ | ----- |
| GC\_CURRENT  | Current process (node) GC memory size at sample time               | Bytes |
| GC\_PEAK     | Peak process (node) GC memory size over 1-minute intervals         | Bytes |
| RSS\_CURRENT | Current process (node) resident memory size at sample time         | MB    |
| RSS\_PEAK    | Peak process (node) resident memory size over the process lifetime | MB    |

### NDU Bucket Drainer

| Type                                | Description                                                                               | Units      |
| ----------------------------------- | ----------------------------------------------------------------------------------------- | ---------- |
| NDU\_DRAINER\_BUCKETS\_DRAINED      | Buckets fully drained — all source council members replaced                               | Buckets    |
| NDU\_DRAINER\_BUCKETS\_FAILED       | Buckets not fully drained when request ended — suboptimal leader team                     | Buckets    |
| NDU\_DRAINER\_BUCKETS\_TO\_DRAIN    | Total buckets requested for draining across all requests                                  | Buckets    |
| NDU\_DRAINER\_FD\_REJECTIONS        | Target candidate rejections due to failure domain conflict                                | Rejections |
| NDU\_DRAINER\_ITERATIONS            | \[Diagnostic] Total iterations across all NDU drainer requests                            | Iterations |
| NDU\_DRAINER\_LOAD\_REJECTIONS      | Target candidate rejections due to agent load limit                                       | Rejections |
| NDU\_DRAINER\_REQUESTS\_COMPLETED   | \[Diagnostic] Total NDU drainer requests completed successfully — infra health check only | Requests   |
| NDU\_DRAINER\_REQUESTS\_FAILED      | \[Diagnostic] Total NDU drainer requests that failed — infra health check only            | Requests   |
| NDU\_DRAINER\_REQUESTS\_STARTED     | \[Diagnostic] Total NDU drainer requests started — infra health check only                | Requests   |
| NDU\_DRAINER\_SWAPS                 | Total bucket swaps performed by the NDU drainer                                           | Swaps      |
| NDU\_DRAINER\_WASTED\_SWAP\_BUCKETS | Buckets that received partial swaps but were not fully drained — wasted work              | Buckets    |

### Network

| Type                                    | Description                                                                                                         | Units                  |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| ACKS\_LOST                              | Number of lost ACK packets                                                                                          | Packets/Sec            |
| ACKS\_REORDERED                         | Number of reordered ACK packets                                                                                     | Packets/Sec            |
| BAD\_DEFRAG\_CSUM                       | Histogram of bad checksum validations after defrag (needs manual override to enable)                                | Packets                |
| BAD\_RECV\_CSUM                         | Number of packets received with a bad checksum                                                                      | Packets/Sec            |
| CORRUPT\_PACKETS                        | Number of packets received and deemed corrupted                                                                     | Packets/Sec            |
| DATA\_CHECKSUM\_ERRORS                  | Number of packets dropped due to data checksum errors                                                               | Packets/Sec            |
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
| MBUF\_POOL\_EMERGENCY\_FREE\_CALLBACKS  | Number of times emergency free callbacks were triggered                                                             | Callbacks/Sec          |
| MBUF\_POOL\_FREE\_CALLBACKS             | Number of times free callbacks were triggered                                                                       | Callbacks/Sec          |
| MISSED\_CSUM\_MBUFS                     | Number of MBUFs which should have had hardware checksum, but were missed                                            | Packets/Sec            |
| NDP\_DAD\_RECV\_ADDR\_CONFLICTS         | NDP DAD Receive Address Conflict Detected                                                                           | Packets/Sec            |
| NDP\_DAD\_RECV\_NO\_CONFLICTS           | NDP DAD Receive No Conflict                                                                                         | Packets/Sec            |
| NETSPACE\_TCP\_RX\_BYTES                | Number of TCP Bytes received on a VLAN                                                                              | Bytes/Sec              |
| NETSPACE\_TCP\_RX\_PACKETS              | Number of TCP Packets received on a NETSPACE                                                                        | Packets/Sec            |
| NETSPACE\_TCP\_TX\_BYTES                | Number of TCP Bytes sent on a NETSPACE                                                                              | Bytes/Sec              |
| NETSPACE\_TCP\_TX\_PACKETS              | Number of TCP Packets sent on a NETSPACE                                                                            | Packets/Sec            |
| NETSPACE\_UDP\_RX\_BYTES                | Number of UDP Bytes received on a NETSPACE                                                                          | Bytes/Sec              |
| NETSPACE\_UDP\_RX\_PACKETS              | Number of UDP Packets received on a NETSPACE                                                                        | Packets/Sec            |
| NETSPACE\_UDP\_TX\_BYTES                | Number of UDP Bytes sent on a NETSPACE                                                                              | Bytes/Sec              |
| NETSPACE\_UDP\_TX\_PACKETS              | Number of UDP Packets sent on a NETSPACE                                                                            | Packets/Sec            |
| NODE\_RECONNECTED                       | Number of reconnections                                                                                             | Reconnects/Sec         |
| PACKETS\_FAILING\_COMBINE               | Number of packets received that failed buffer combining                                                             | Packets/Sec            |
| PACKETS\_NEEDING\_ALIGN                 | Number of packets received that needed alignment adjustment                                                         | Packets/Sec            |
| PACKETS\_NEEDING\_COMBINE               | Number of packets received that needed buffer combining                                                             | Packets/Sec            |
| PACKETS\_PUMPED                         | Number of packets received in each call to recvPackets                                                              | Batches                |
| PACKETS\_RX\_EXTMBUF                    | Number of packets received with external mbuf                                                                       | Packets                |
| PACKETS\_VLAN\_INSERTED\_HW             | Number of packets sent with hardware inserted VLAN tag                                                              | Packets/Sec            |
| PACKETS\_VLAN\_INSERTED\_SW             | Number of packets sent with software-inserted VLAN tag                                                              | Packets/Sec            |
| PACKETS\_VLAN\_STRIPPED\_HW             | Number of packets received with hardware stripped VLAN tag                                                          | Packets/Sec            |
| PACKETS\_VLAN\_STRIPPED\_SW             | Number of packets received with software stripped VLAN tag                                                          | Packets/Sec            |
| PACKET\_ALIGN\_BYTES\_COPIED            | Number of bytes copied during receive for packet alignment                                                          | Bytes/Sec              |
| PACKET\_COMBINE\_BYTES\_COPIED          | Number of bytes copied during receive packet buffer combining                                                       | Bytes/Sec              |
| PEER\_RTT\_BACKEND                      | RTT histogram                                                                                                       | Microseconds           |
| PEER\_RTT\_CLIENT                       | RTT histogram                                                                                                       | Microseconds           |
| POISON\_DETECTED                        | Number of poisoned netbufs detected                                                                                 | Occurrences            |
| POISON\_DETECTED\_EXPECTED              | Expected number of poisoned netbufs detected                                                                        | Occurrences            |
| POISON\_DETECTED\_UNEXPECTED            | Unexpected number of poisoned netbufs detected                                                                      | Occurrences            |
| PORT\_EXT\_RX\_PACKETS                  | Number of external packets received                                                                                 | Packets/Sec            |
| PORT\_RX\_BYTES                         | Number of bytes received                                                                                            | Bytes/Sec              |
| PORT\_RX\_ERRORS                        | Number of packet RX errors                                                                                          | Packets/Sec            |
| PORT\_RX\_MISSED                        | Number of packets lost due to RX queue full                                                                         | Packets/Sec            |
| PORT\_RX\_NO\_MBUFS                     | Number of packets lost due to no mbufs                                                                              | Packets/Sec            |
| PORT\_RX\_PACKETS                       | Number of packets received                                                                                          | Packets/Sec            |
| PORT\_TX\_BYTES                         | Number of bytes transmitted                                                                                         | Bytes/Sec              |
| PORT\_TX\_ERRORS                        | Number of packet TX errors                                                                                          | Packets/Sec            |
| PORT\_TX\_PACKETS                       | Number of packets transmitted                                                                                       | Packets/Sec            |
| PUMPS\_TXQ\_FULL                        | Number of times we couldn't send any new packets to the NIC queue                                                   | Pumps/Sec              |
| PUMPS\_TXQ\_PARTIAL                     | Number of times we only sent some of our queued packets to the NIC queue                                            | Pumps/Sec              |
| PUMP\_DURATION                          | Duration of each pump                                                                                               | Requests               |
| PUMP\_INTERVAL                          | Interval between pumps                                                                                              | Requests               |
| RDMA\_ADD\_CHUNK\_FAILURES              | Number of RDMA cookie setting failures                                                                              | Failures/Sec           |
| RDMA\_AHCACHE\_POPULATIONS              | Number of RDMA RDMA AH cache population attempts                                                                    | Attempts/Sec           |
| RDMA\_BAD\_CSUM                         | Number of RDMA requests with incorrect and then fixed checksums                                                     | Failures/Sec           |
| RDMA\_BINDING\_FAILOVERS                | Number of RDMA High-Availability fail-overs                                                                         | Fail-overs/Sec         |
| RDMA\_CANCELED\_COMPLETIONS             | Number of RDMA completions that were canceled                                                                       | Completions/Sec        |
| RDMA\_CLIENT\_BINDING\_INVALIDATIONS    | Number of RDMA client binding invalidations                                                                         | Invalidations/Sec      |
| RDMA\_COMPLETIONS                       | Number of RDMA requests that were completed                                                                         | Completions/Sec        |
| RDMA\_COMP\_DURATION                    | Histogram of RDMA completion duration times                                                                         | Requests               |
| RDMA\_COMP\_FAILURES                    | Number of RDMA requests that were completed with an error                                                           | Failures/Sec           |
| RDMA\_COMP\_LATENCY                     | Average time of RDMA request completion                                                                             | Microseconds           |
| RDMA\_COMP\_STATUSES                    | Histogram of RDMA completion statuses                                                                               | Completions/Sec        |
| RDMA\_CSUM\_REGISTER\_FAILURES          | Number of RDMA submit failures due to checksum registration error                                                   | Failures/Sec           |
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
| RECEIVED\_PACKETS                       | Number of packets received                                                                                          | Packets/Sec            |
| RECEIVED\_PACKET\_GENERATIONS           | The generation ("resend count") of the first incarnation of the packet seen by the receiver (indicates packet loss) | Packets                |
| RECEIVED\_PING\_PACKETS                 | Number of received ping packets                                                                                     | Packets/Sec            |
| RECEIVED\_PONG\_PACKETS                 | Number of received pong packets                                                                                     | Packets/Sec            |
| RECEIVED\_REJECT\_PACKETS               | Number of received reject packets                                                                                   | Packets/Sec            |
| RECEIVED\_SYNC\_PACKETS                 | Number of received sync packets                                                                                     | Packets/Sec            |
| REORDERED\_PACKETS                      | Number of reordered packets                                                                                         | Packets/Sec            |
| RESEND\_BATCH\_SIZE                     | Number of packets sent in a resend batch                                                                            | Batches                |
| RESENT\_DATA\_PACKETS                   | Number of data packets resent                                                                                       | Packets/Sec            |
| SEND\_BATCH\_SIZE                       | Number of packets sent in a first send batch                                                                        | Batches                |
| SEND\_BATCH\_SIZE\_BYTES                | Number of bytes sent in a first send batch                                                                          | Batches                |
| SEND\_QUEUE\_TIMEOUTS                   | Number of packets canceled due to envelope timeout and were not in the send window                                  | Packets/Sec            |
| SEND\_WINDOW\_TIMEOUTS                  | Number of packets canceled due to envelope timeout while in the send window                                         | Packets/Sec            |
| SENT\_ACKS                              | Number of ACK packets sent                                                                                          | Packets/Sec            |
| SENT\_CONTROL\_PACKETS                  | Number of control packets sent                                                                                      | Packets/Sec            |
| SENT\_DATA\_PACKETS                     | Number of data packets sent                                                                                         | Packets/Sec            |
| SENT\_INLINE\_HDR\_PACKETS              | Number of data packets sent with the network header inlined (workaround for DOCA OFED chained-mbuf TX corruption)   | Packets/Sec            |
| SENT\_PACKETS                           | Number of sent packets                                                                                              | Packets/Sec            |
| SENT\_REJECTS                           | Number of rejects sent                                                                                              | Packets/Sec            |
| SHORT\_CIRCUIT\_SENDS                   | Number of packets sent to the same node                                                                             | Packets/Sec            |
| SLOW\_PATH\_CSUM                        | Number of packets that went through checksum calculation on the CPU                                                 | Packets/Sec            |
| TIMELY\_RESENDS                         | Number of packets resent due to timely resend                                                                       | Packets/Sec            |
| TIME\_TO\_ACK                           | Histogram of time to acknowledge a data packet                                                                      | Requests               |
| TIME\_TO\_FIRST\_SEND                   | Time from queueing to first send                                                                                    | Requests               |
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
| ZERO\_CSUM                              | Number of checksum zero received                                                                                    | Packets/Sec            |
| ZERO\_CSUM\_OVERWRITE                   | Number of packets with zero checksum that were overwritten with 0xFFFF                                              | Packets/Sec            |

### NODE\_TRANSITIONS

| Type                              | Description                                                 | Units           |
| --------------------------------- | ----------------------------------------------------------- | --------------- |
| JOINING\_FENCED\_REASON\_COUNTS   | Counts of reasons JOINING nodes were fenced                 | Occurrences/Sec |
| JOINING\_TO\_UP\_TRANSITIONS      | Number of nodes transitioned from JOINING to UP             | Nodes           |
| SYNCING\_TO\_JOINING\_TRANSITIONS | Number of nodes transitioned from SYNCING to JOINING        | Nodes           |
| SYNC\_TO\_JOIN\_FAILURE\_COUNTS   | Counts of SYNCING to JOINING failures categorized by reason | Occurrences/Sec |
| UP\_FENCED\_REASON\_COUNTS        | Counts of reasons UP nodes were fenced                      | Occurrences/Sec |

### Object Storage

| Type                                                 | Description                                                               | Units         |
| ---------------------------------------------------- | ------------------------------------------------------------------------- | ------------- |
| FAILED\_OBJECT\_DELETES                              | Number of failed object deletes per second (any failure reason)           | Ops/Sec       |
| FAILED\_OBJECT\_DOWNLOADS                            | Number of failed object downloads per second (any failure reason)         | Ops/Sec       |
| FAILED\_OBJECT\_HEAD\_QUERIES                        | Number of failed object head queries per second (any failure reason)      | Ops/Sec       |
| FAILED\_OBJECT\_OPERATIONS                           | Total number of failed operations per second                              | Ops/Sec       |
| FAILED\_OBJECT\_UPLOADS                              | Number of failed object uploads per second (any failure reason)           | Ops/Sec       |
| OBJECT\_DELETES                                      | Number of object deletes per second                                       | Ops/Sec       |
| OBJECT\_DELETE\_DURATION                             | Duration of object delete request                                         | Ops           |
| OBJECT\_DELETE\_LATENCY                              | Average latency of deleting an object                                     | Microseconds  |
| OBJECT\_DOWNLOADS                                    | Number of objects downloaded per second                                   | Ops/Sec       |
| OBJECT\_DOWNLOADS\_BACKGROUND                        | Number of BACKGROUND objects downloaded per second                        | Ops/Sec       |
| OBJECT\_DOWNLOADS\_FOREGROUND                        | Number of FOREGROUND objects downloaded per second                        | Ops/Sec       |
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
| OBJECT\_UPLOADS                                      | Number of object uploads per second                                       | Ops/Sec       |
| OBJECT\_UPLOADS\_BACKPRESSURE                        | Number of BACKPRESSURE upload attempts per second                         | Ops/Sec       |
| OBJECT\_UPLOADS\_IMMEDIATE\_RELEASE                  | Number of IMMEDIATE\_RELEASE upload attempts per second                   | Ops/Sec       |
| OBJECT\_UPLOADS\_MANHOLE                             | Number of MANHOLE upload attempts per second                              | Ops/Sec       |
| OBJECT\_UPLOADS\_MIGRATE                             | Number of MIGRATE upload attempts per second                              | Ops/Sec       |
| OBJECT\_UPLOADS\_POLICY                              | Number of POLICY upload attempts per second                               | Ops/Sec       |
| OBJECT\_UPLOADS\_RECLAMATION\_REUPLOAD               | Number of RECLAMATION\_REUPLOAD upload attempts per second                | Ops/Sec       |
| OBJECT\_UPLOADS\_REPLICATE                           | Number of REPLICATE upload attempts per second                            | Ops/Sec       |
| OBJECT\_UPLOADS\_STOW                                | Number of STOW upload attempts per second                                 | Ops/Sec       |
| OBJECT\_UPLOAD\_BYTES\_BACKPRESSURE                  | Number of BACKPRESSURE bytes sent to the object store per second          | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_IMMEDIATE\_RELEASE            | Number of IMMEDIATE\_RELEASE bytes sent to the object store per second    | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_MANHOLE                       | Number of MANHOLE bytes sent to the object store per second               | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_MIGRATE                       | Number of MIGRATE bytes sent to the object store per second               | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_POLICY                        | Number of POLICY bytes sent to the object store per second                | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_RECLAMATION\_REUPLOAD         | Number of RECLAMATION\_REUPLOAD bytes sent to the object store per second | Bytes/Sec     |
| OBJECT\_UPLOAD\_BYTES\_REPLICATE                     | Number of REPLICATE bytes sent to the object store per second             | Bytes/Sec     |
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
| WAITING\_FOR\_BUCKET\_DOWNLOAD\_BANDWIDTH            | Time requests wait for the object store bucket download bandwidth         | Ops           |
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

### Operations

| Type                    | Description                                    | Units        |
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
| READDIR\_LATENCY        | Average latency of READDIR operations          | Microseconds |
| READDIR\_OPS            | Number of READDIR operations per second        | Ops/Sec      |
| READLINK\_LATENCY       | Average latency of READLINK operations         | Microseconds |
| READLINK\_OPS           | Number of READLINK operations per second       | Ops/Sec      |
| READS                   | Number of read operations per second           | Ops/Sec      |
| READ\_BYTES             | Number of bytes read per second                | Bytes/Sec    |
| READ\_DURATION          | The number of reads per completion duration    | Reads        |
| READ\_LATENCY           | Average latency of READ operations             | Microseconds |
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
| THROUGHPUT              | Number of bytes read/written per second        | Bytes/Sec    |
| UNLINK\_LATENCY         | Average latency of UNLINK operations           | Microseconds |
| UNLINK\_OPS             | Number of UNLINK operations per second         | Ops/Sec      |
| WRITES                  | Number of write operations per second          | Ops/Sec      |
| WRITE\_BYTES            | Number of bytes written per second             | Bytes/Sec    |
| WRITE\_DURATION         | The number of writes per completion duration   | Writes       |
| WRITE\_LATENCY          | Average latency of WRITE operations            | Microseconds |

### Operations (Directory Quota Domain)

| Type           | Description                             | Units        |
| -------------- | --------------------------------------- | ------------ |
| READS          | Number of read operations per second    | Ops/Sec      |
| READ\_BYTES    | Number of bytes read per second         | Bytes/Sec    |
| READ\_LATENCY  | Average latency of READ operations      | Microseconds |
| THROUGHPUT     | Number of bytes read/written per second | Bytes/Sec    |
| WRITES         | Number of write operations per second   | Ops/Sec      |
| WRITE\_BYTES   | Number of bytes written per second      | Bytes/Sec    |
| WRITE\_LATENCY | Average latency of WRITE operations     | Microseconds |

### Operations (driver)

| Type                                            | Description                                                                                            | Units        |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------ | ------------ |
| DIRECT\_READ\_SIZES                             | The number of O\_DIRECT reads per read size range                                                      | Reads        |
| DIRECT\_READ\_SIZES\_RATE                       | The number of O\_DIRECT reads per read size range per second                                           | Reads        |
| DIRECT\_WRITE\_SIZES                            | The number of O\_DIRECT writes per read size range                                                     | Writes       |
| DIRECT\_WRITE\_SIZES\_RATE                      | The number of O\_DIRECT writes per read size range per second                                          | Writes       |
| DOORBELL\_RING\_COUNT                           | The number of times the driver queue's doorbell was ringed                                             | Ops          |
| FAILED\_1HOP\_READS                             | Number of failed single hop reads per second                                                           | Ops/Sec      |
| FILEATOMICOPEN\_LATENCY                         | Average latency of FILEATOMICOPEN operations                                                           | Microseconds |
| FILEATOMICOPEN\_OPS                             | Number of FILEATOMICOPEN operations per second                                                         | Ops/Sec      |
| FILEATOMICOPEN\_QOS\_DELAY                      | Average QoS delay for FILEATOMICOPEN operations                                                        | Microseconds |
| FILECLOSE\_LATENCY                              | Average latency of FILECLOSE operations                                                                | Microseconds |
| FILECLOSE\_OPS                                  | Number of FILECLOSE operations per second                                                              | Ops/Sec      |
| FILECLOSE\_QOS\_DELAY                           | Average QoS delay for FILECLOSE operations                                                             | Microseconds |
| FILEOPEN\_LATENCY                               | Average latency of FILEOPEN operations                                                                 | Microseconds |
| FILEOPEN\_OPS                                   | Number of FILEOPEN operations per second                                                               | Ops/Sec      |
| FILEOPEN\_QOS\_DELAY                            | Average QoS delay for FILEOPEN operations                                                              | Microseconds |
| FLOCK\_LATENCY                                  | Average latency of FLOCK operations                                                                    | Microseconds |
| FLOCK\_OPS                                      | Number of FLOCK operations per second                                                                  | Ops/Sec      |
| FLOCK\_QOS\_DELAY                               | Average QoS delay for FLOCK operations                                                                 | Microseconds |
| FORWARDING\_1HOP\_READS                         | Number of forwarding reads per second served single-hop by following the redirect to the target extent | Ops/Sec      |
| GETATTR\_LATENCY                                | Average latency of GETATTR operations                                                                  | Microseconds |
| GETATTR\_OPS                                    | Number of GETATTR operations per second                                                                | Ops/Sec      |
| GETATTR\_QOS\_DELAY                             | Average QoS delay for GETATTR operations                                                               | Microseconds |
| GETXATTR\_LATENCY                               | Average latency of GETXATTR operations                                                                 | Microseconds |
| GETXATTR\_OPS                                   | Number of GETXATTR operations per second                                                               | Ops/Sec      |
| GETXATTR\_QOS\_DELAY                            | Average QoS delay for GETXATTR operations                                                              | Microseconds |
| IOCTL\_OBS\_PREFETCH\_LATENCY                   | Average latency of IOCTL\_OBS\_PREFETCH operations                                                     | Microseconds |
| IOCTL\_OBS\_PREFETCH\_OPS                       | Number of IOCTL\_OBS\_PREFETCH operations per second                                                   | Ops/Sec      |
| IOCTL\_OBS\_PREFETCH\_QOS\_DELAY                | Average QoS delay for IOCTL\_OBS\_PREFETCH operations                                                  | Microseconds |
| IOCTL\_OBS\_RELEASE\_LATENCY                    | Average latency of IOCTL\_OBS\_RELEASE operations                                                      | Microseconds |
| IOCTL\_OBS\_RELEASE\_OPS                        | Number of IOCTL\_OBS\_RELEASE operations per second                                                    | Ops/Sec      |
| IOCTL\_OBS\_RELEASE\_QOS\_DELAY                 | Average QoS delay for IOCTL\_OBS\_RELEASE operations                                                   | Microseconds |
| KEEPALIVES\_NO\_LEASE                           | Number of driver keepalives sent while we have no lease                                                | Ops/Sec      |
| LINK\_LATENCY                                   | Average latency of LINK operations                                                                     | Microseconds |
| LINK\_OPS                                       | Number of LINK operations per second                                                                   | Ops/Sec      |
| LINK\_QOS\_DELAY                                | Average QoS delay for LINK operations                                                                  | Microseconds |
| LISTXATTR\_LATENCY                              | Average latency of LISTXATTR operations                                                                | Microseconds |
| LISTXATTR\_OPS                                  | Number of LISTXATTR operations per second                                                              | Ops/Sec      |
| LISTXATTR\_QOS\_DELAY                           | Average QoS delay for LISTXATTR operations                                                             | Microseconds |
| LOOKUP\_LATENCY                                 | Average latency of LOOKUP operations                                                                   | Microseconds |
| LOOKUP\_OPS                                     | Number of LOOKUP operations per second                                                                 | Ops/Sec      |
| LOOKUP\_QOS\_DELAY                              | Average QoS delay for LOOKUP operations                                                                | Microseconds |
| MKNOD\_LATENCY                                  | Average latency of MKNOD operations                                                                    | Microseconds |
| MKNOD\_OPS                                      | Number of MKNOD operations per second                                                                  | Ops/Sec      |
| MKNOD\_QOS\_DELAY                               | Average QoS delay for MKNOD operations                                                                 | Microseconds |
| OPS                                             | Total number of operations                                                                             | Ops/Sec      |
| PENDING\_IOS\_COUNT                             | Pending IO count per FE container                                                                      | Ops          |
| RDMA\_WRITE\_REQUESTS                           | Number of RDMA write request operations per second                                                     | Ops/Sec      |
| READDIR\_LATENCY                                | Average latency of READDIR operations                                                                  | Microseconds |
| READDIR\_OPS                                    | Number of READDIR operations per second                                                                | Ops/Sec      |
| READDIR\_QOS\_DELAY                             | Average QoS delay for READDIR operations                                                               | Microseconds |
| READLINK\_LATENCY                               | Average latency of READLINK operations                                                                 | Microseconds |
| READLINK\_OPS                                   | Number of READLINK operations per second                                                               | Ops/Sec      |
| READLINK\_QOS\_DELAY                            | Average QoS delay for READLINK operations                                                              | Microseconds |
| READS                                           | Number of read operations per second                                                                   | Ops/Sec      |
| READS\_NO\_LEASE                                | Number of direct reads while we have no lease                                                          | Ops/Sec      |
| READ\_BYTES                                     | Number of bytes read per second                                                                        | Bytes/Sec    |
| READ\_BYTES\_1HOP                               | Number of bytes read per second via single hop                                                         | Bytes/Sec    |
| READ\_CHECKSUM\_ERRORS                          | The number of times the driver's checksum validation failed upon the read's content                    | Ops          |
| READ\_CORRUPTIONS\_DETECTED\_IN\_1HOP           | The number of corrupt data blocks encountered during 1-hop read                                        | Ops          |
| READ\_DURATION                                  | The number of reads per completion duration                                                            | Reads        |
| READ\_LATENCY                                   | Average latency of READ operations                                                                     | Microseconds |
| READ\_LATENCY\_NO\_QOS                          | Average latency of READ operations without QoS delay                                                   | Microseconds |
| READ\_QOS\_DELAY                                | Average QoS delay for READ operations                                                                  | Microseconds |
| READ\_RDMA\_SIZES                               | The number of RDMA reads per read size range                                                           | Reads        |
| READ\_RDMA\_SIZES\_RATE                         | The number of RDMA reads per read size range per second                                                | Reads        |
| READ\_SIZES                                     | NFS read sizes histogram                                                                               | Reads        |
| READ\_SIZES\_RATE                               | The number of reads per read size range per second                                                     | Reads        |
| RENAME\_LATENCY                                 | Average latency of RENAME operations                                                                   | Microseconds |
| RENAME\_OPS                                     | Number of RENAME operations per second                                                                 | Ops/Sec      |
| RENAME\_QOS\_DELAY                              | Average QoS delay for RENAME operations                                                                | Microseconds |
| REQUESTS\_COMPLETED                             | The number of completions frontends sent to the driver's queue                                         | Ops          |
| REQUESTS\_FETCHED                               | The number of operations frontends fetched from the driver's queue                                     | Ops          |
| RMDIR\_LATENCY                                  | Average latency of RMDIR operations                                                                    | Microseconds |
| RMDIR\_OPS                                      | Number of RMDIR operations per second                                                                  | Ops/Sec      |
| RMDIR\_QOS\_DELAY                               | Average QoS delay for RMDIR operations                                                                 | Microseconds |
| RMXATTR\_LATENCY                                | Average latency of RMXATTR operations                                                                  | Microseconds |
| RMXATTR\_OPS                                    | Number of RMXATTR operations per second                                                                | Ops/Sec      |
| RMXATTR\_QOS\_DELAY                             | Average QoS delay for RMXATTR operations                                                               | Microseconds |
| SETATTR\_LATENCY                                | Average latency of SETATTR operations                                                                  | Microseconds |
| SETATTR\_OPS                                    | Number of SETATTR operations per second                                                                | Ops/Sec      |
| SETATTR\_QOS\_DELAY                             | Average QoS delay for SETATTR operations                                                               | Microseconds |
| SETXATTR\_LATENCY                               | Average latency of SETXATTR operations                                                                 | Microseconds |
| SETXATTR\_OPS                                   | Number of SETXATTR operations per second                                                               | Ops/Sec      |
| SETXATTR\_QOS\_DELAY                            | Average QoS delay for SETXATTR operations                                                              | Microseconds |
| SINGLE\_HOP\_WRITE\_ATTEMPTS                    | Number of single hop write attempts per second                                                         | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_PUT\_BLOCKS\_RDMA\_FAILURES | Number of single hop write putBlock calls per second that failed RDMA                                  | Calls/Sec    |
| SINGLE\_HOP\_WRITE\_RDMA\_FAILURES              | Number of single hop write operation writes per second that failed RDMA                                | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_RETRY\_NO\_RDMA             | Number of single-hop writes per second that were retried without using RDMA                            | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS                       | Number of single-hop write operations per second skipped for any reason                                | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS\_DISABLED             | Number of single hop write operation skips (DISABLED) per second                                       | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS\_EXTERNAL\_RDMA       | Number of single hop write operation skips (EXTERNAL\_RDMA) per second                                 | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS\_MAX\_CONCURRENCY     | Number of single hop write operation skips (MAX\_CONCURRENCY) per second                               | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS\_PARTIAL\_BLOCKS      | Number of single hop write operation skips (PARTIAL\_BLOCKS) per second                                | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS\_SMALL\_WRITE         | Number of single hop write operation skips (SMALL\_WRITE) per second                                   | Ops/Sec      |
| SINGLE\_HOP\_WRITE\_SKIPS\_UNINIT\_CHECKSUM     | Number of single hop write operation skips (UNINIT\_CHECKSUM) per second                               | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_DISABLED                  | Number of single-hop reads per second skipped because the feature is disabled                          | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_EXTERNAL\_RDMA\_SPARSE    | Number of single-hop reads per second skipped because of sparse read on external RDMA                  | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_GET\_EXTENT\_FAILED       | Number of single-hop reads per second skipped because the get extent operation failed                  | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_PARTIAL\_READ             | Number of single-hop reads per second skipped due to partial read                                      | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_SSD\_LOAD                 | Number of single-hop reads per second skipped due to high drive load                                   | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_TOO\_MANY\_DESCRIPTORS    | Number of single-hop reads per second skipped because of too many descriptors                          | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_TOO\_MANY\_DRIVES         | Number of single-hop reads per second skipped because of too many drives                               | Ops/Sec      |
| SKIPPED\_1HOP\_READS\_TOO\_SMALL                | Number of single-hop reads per second skipped because the IO size is too small                         | Ops/Sec      |
| STATFS\_LATENCY                                 | Average latency of STATFS operations                                                                   | Microseconds |
| STATFS\_OPS                                     | Number of STATFS operations per second                                                                 | Ops/Sec      |
| STATFS\_QOS\_DELAY                              | Average QoS delay for STATFS operations                                                                | Microseconds |
| SUCCEEDED\_1HOP\_READS                          | Number of successful single hop reads per second                                                       | Ops/Sec      |
| SYMLINK\_LATENCY                                | Average latency of SYMLINK operations                                                                  | Microseconds |
| SYMLINK\_OPS                                    | Number of SYMLINK operations per second                                                                | Ops/Sec      |
| SYMLINK\_QOS\_DELAY                             | Average QoS delay for SYMLINK operations                                                               | Microseconds |
| THROUGHPUT                                      | Number of bytes read/written per second                                                                | Bytes/Sec    |
| UNLINK\_LATENCY                                 | Average latency of UNLINK operations                                                                   | Microseconds |
| UNLINK\_OPS                                     | Number of UNLINK operations per second                                                                 | Ops/Sec      |
| UNLINK\_QOS\_DELAY                              | Average QoS delay for UNLINK operations                                                                | Microseconds |
| WRITES                                          | Number of write operations per second                                                                  | Ops/Sec      |
| WRITES\_NO\_LEASE                               | Number of direct writes per second when no lease is held                                               | Ops/Sec      |
| WRITE\_BYTES                                    | Number of bytes written per second                                                                     | Bytes/Sec    |
| WRITE\_DURATION                                 | The number of writes per completion duration                                                           | Writes       |
| WRITE\_LATENCY                                  | Average latency of WRITE operations                                                                    | Microseconds |
| WRITE\_LATENCY\_NO\_QOS                         | Average latency of WRITE operations without QoS delay                                                  | Microseconds |
| WRITE\_QOS\_DELAY                               | Average QoS delay for WRITE operations                                                                 | Microseconds |
| WRITE\_RDMA\_SIZES                              | Number of RDMA writes by write size range                                                              | Writes       |
| WRITE\_RDMA\_SIZES\_RATE                        | Number of RDMA writes per second by write size range                                                   | Writes       |
| WRITE\_SIZES                                    | NFS write sizes histogram                                                                              | Writes       |
| WRITE\_SIZES\_RATE                              | Number of writes per second by write size range                                                        | Writes       |

### Operations (Filesystem)

| Type                    | Description                                                                            | Units        |
| ----------------------- | -------------------------------------------------------------------------------------- | ------------ |
| METADATA\_LATENCY       | Average latency of metadata operations per filesystem, broken down by operation type   | Microseconds |
| METADATA\_OPS           | Number of metadata operations per second per filesystem, broken down by operation type | Ops/Sec      |
| READS                   | Number of read operations per second                                                   | Ops/Sec      |
| READ\_BYTES             | Number of bytes read per second                                                        | Bytes/Sec    |
| READ\_LATENCY           | Average latency of READ operations                                                     | Microseconds |
| READ\_LATENCY\_NO\_QOS  | Average latency of READ operations without QoS delay                                   | Microseconds |
| READ\_QOS\_DELAY        | Average QoS delay for READ operations                                                  | Microseconds |
| THROUGHPUT              | Number of bytes read/written per second                                                | Bytes/Sec    |
| WRITES                  | Number of write operations per second                                                  | Ops/Sec      |
| WRITE\_BYTES            | Number of bytes written per second                                                     | Bytes/Sec    |
| WRITE\_LATENCY          | Average latency of WRITE operations                                                    | Microseconds |
| WRITE\_LATENCY\_NO\_QOS | Average latency of WRITE operations without QoS delay                                  | Microseconds |
| WRITE\_QOS\_DELAY       | Average QoS delay for WRITE operations                                                 | Microseconds |

### Operations (NFS)

| Type              | Description                                  | Units        |
| ----------------- | -------------------------------------------- | ------------ |
| ACCESS\_LATENCY   | Average latency of ACCESS operations         | Microseconds |
| ACCESS\_OPS       | Number of ACCESS operations per second       | Ops/Sec      |
| COMMIT\_LATENCY   | Average latency of COMMIT operations         | Microseconds |
| COMMIT\_OPS       | Number of COMMIT operations per second       | Ops/Sec      |
| CREATE\_LATENCY   | Average latency of CREATE operations         | Microseconds |
| CREATE\_OPS       | Number of CREATE operations per second       | Ops/Sec      |
| FSINFO\_LATENCY   | Average latency of FSINFO operations         | Microseconds |
| FSINFO\_OPS       | Number of FSINFO operations per second       | Ops/Sec      |
| GETATTR\_LATENCY  | Average latency of GETATTR operations        | Microseconds |
| GETATTR\_OPS      | Number of GETATTR operations per second      | Ops/Sec      |
| LINK\_LATENCY     | Average latency of LINK operations           | Microseconds |
| LINK\_OPS         | Number of LINK operations per second         | Ops/Sec      |
| LOOKUP\_LATENCY   | Average latency of LOOKUP operations         | Microseconds |
| LOOKUP\_OPS       | Number of LOOKUP operations per second       | Ops/Sec      |
| MKDIR\_LATENCY    | Average latency of MKDIR operations          | Microseconds |
| MKDIR\_OPS        | Number of MKDIR operations per second        | Ops/Sec      |
| MKNOD\_LATENCY    | Average latency of MKNOD operations          | Microseconds |
| MKNOD\_OPS        | Number of MKNOD operations per second        | Ops/Sec      |
| OPS               | Total number of operations                   | Ops/Sec      |
| PATHCONF\_LATENCY | Average latency of PATHCONF operations       | Microseconds |
| PATHCONF\_OPS     | Number of PATHCONF operations per second     | Ops/Sec      |
| READDIR\_LATENCY  | Average latency of READDIR operations        | Microseconds |
| READDIR\_OPS      | Number of READDIR operations per second      | Ops/Sec      |
| READLINK\_LATENCY | Average latency of READLINK operations       | Microseconds |
| READLINK\_OPS     | Number of READLINK operations per second     | Ops/Sec      |
| READS             | Number of read operations per second         | Ops/Sec      |
| READ\_BYTES       | Number of bytes read per second              | Bytes/Sec    |
| READ\_DURATION    | The number of reads per completion duration  | Reads        |
| READ\_LATENCY     | Average latency of READ operations           | Microseconds |
| READ\_SIZES       | NFS read sizes histogram                     | Reads        |
| REMOVE\_LATENCY   | Average latency of REMOVE operations         | Microseconds |
| REMOVE\_OPS       | Number of REMOVE operations per second       | Ops/Sec      |
| RENAME\_LATENCY   | Average latency of RENAME operations         | Microseconds |
| RENAME\_OPS       | Number of RENAME operations per second       | Ops/Sec      |
| SETATTR\_LATENCY  | Average latency of SETATTR operations        | Microseconds |
| SETATTR\_OPS      | Number of SETATTR operations per second      | Ops/Sec      |
| STATFS\_LATENCY   | Average latency of STATFS operations         | Microseconds |
| STATFS\_OPS       | Number of STATFS operations per second       | Ops/Sec      |
| SYMLINK\_LATENCY  | Average latency of SYMLINK operations        | Microseconds |
| SYMLINK\_OPS      | Number of SYMLINK operations per second      | Ops/Sec      |
| THROUGHPUT        | Number of bytes read/written per second      | Bytes/Sec    |
| WRITES            | Number of write operations per second        | Ops/Sec      |
| WRITE\_BYTES      | Number of bytes written per second           | Bytes/Sec    |
| WRITE\_DURATION   | The number of writes per completion duration | Writes       |
| WRITE\_LATENCY    | Average latency of WRITE operations          | Microseconds |
| WRITE\_SIZES      | NFS write sizes histogram                    | Writes       |

### Operations (NFSw)

| Type                                       | Description                                                   | Units        |
| ------------------------------------------ | ------------------------------------------------------------- | ------------ |
| ACCESS\_LATENCY                            | Average latency of ACCESS operations                          | Microseconds |
| ACCESS\_OPS                                | Number of ACCESS operations per second                        | Ops/Sec      |
| COMMIT\_LATENCY                            | Average latency of COMMIT operations                          | Microseconds |
| COMMIT\_OPS                                | Number of COMMIT operations per second                        | Ops/Sec      |
| CREATE\_LATENCY                            | Average latency of CREATE operations                          | Microseconds |
| CREATE\_OPS                                | Number of CREATE operations per second                        | Ops/Sec      |
| GETATTR\_LATENCY                           | Average latency of GETATTR operations                         | Microseconds |
| GETATTR\_OPS                               | Number of GETATTR operations per second                       | Ops/Sec      |
| LINK\_LATENCY                              | Average latency of LINK operations                            | Microseconds |
| LINK\_OPS                                  | Number of LINK operations per second                          | Ops/Sec      |
| LOOKUP\_LATENCY                            | Average latency of LOOKUP operations                          | Microseconds |
| LOOKUP\_OPS                                | Number of LOOKUP operations per second                        | Ops/Sec      |
| NFS3\_ACCESS\_ID\_LATENCY                  | Average latency of NFS3\_ACCESS operations                    | Microseconds |
| NFS3\_ACCESS\_ID\_OPS                      | Number of NFS3\_ACCESS operations per second                  | Ops/Sec      |
| NFS3\_COMMIT\_ID\_LATENCY                  | Average latency of NFS3\_COMMIT operations                    | Microseconds |
| NFS3\_COMMIT\_ID\_OPS                      | Number of NFS3\_COMMIT operations per second                  | Ops/Sec      |
| NFS3\_CREATE\_ID\_LATENCY                  | Average latency of NFS3\_CREATE operations                    | Microseconds |
| NFS3\_CREATE\_ID\_OPS                      | Number of NFS3\_CREATE operations per second                  | Ops/Sec      |
| NFS3\_FSINFO\_ID\_LATENCY                  | Average latency of NFS3\_FSINFO operations                    | Microseconds |
| NFS3\_FSINFO\_ID\_OPS                      | Number of NFS3\_FSINFO operations per second                  | Ops/Sec      |
| NFS3\_FSINFO\_LATENCY                      | Average latency of NFS3\_FSINFO operations                    | Microseconds |
| NFS3\_FSINFO\_OPS                          | Number of NFS3\_FSINFO operations per second                  | Ops/Sec      |
| NFS3\_GETATTR\_ID\_LATENCY                 | Average latency of NFS3\_GETATTR operations                   | Microseconds |
| NFS3\_GETATTR\_ID\_OPS                     | Number of NFS3\_GETATTR operations per second                 | Ops/Sec      |
| NFS3\_LINK\_ID\_LATENCY                    | Average latency of NFS3\_LINK operations                      | Microseconds |
| NFS3\_LINK\_ID\_OPS                        | Number of NFS3\_LINK operations per second                    | Ops/Sec      |
| NFS3\_LOOKUP\_ID\_LATENCY                  | Average latency of NFS3\_LOOKUP operations                    | Microseconds |
| NFS3\_LOOKUP\_ID\_OPS                      | Number of NFS3\_LOOKUP operations per second                  | Ops/Sec      |
| NFS3\_MKDIR\_ID\_LATENCY                   | Average latency of NFS3\_MKDIR operations                     | Microseconds |
| NFS3\_MKDIR\_ID\_OPS                       | Number of NFS3\_MKDIR operations per second                   | Ops/Sec      |
| NFS3\_MKDIR\_LATENCY                       | Average latency of NFS3\_MKDIR operations                     | Microseconds |
| NFS3\_MKDIR\_OPS                           | Number of NFS3\_MKDIR operations per second                   | Ops/Sec      |
| NFS3\_MKNOD\_ID\_LATENCY                   | Average latency of NFS3\_MKNOD operations                     | Microseconds |
| NFS3\_MKNOD\_ID\_OPS                       | Number of NFS3\_MKNOD operations per second                   | Ops/Sec      |
| NFS3\_MKNOD\_LATENCY                       | Average latency of NFS3\_MKNOD operations                     | Microseconds |
| NFS3\_MKNOD\_OPS                           | Number of NFS3\_MKNOD operations per second                   | Ops/Sec      |
| NFS3\_OPS\_ID                              | Number of NFS3\_OPS per second                                | Ops/Sec      |
| NFS3\_PATHCONF\_ID\_LATENCY                | Average latency of NFS3\_PATHCONF operations                  | Microseconds |
| NFS3\_PATHCONF\_ID\_OPS                    | Number of NFS3\_PATHCONF operations per second                | Ops/Sec      |
| NFS3\_PATHCONF\_LATENCY                    | Average latency of NFS3\_PATHCONF operations                  | Microseconds |
| NFS3\_PATHCONF\_OPS                        | Number of NFS3\_PATHCONF operations per second                | Ops/Sec      |
| NFS3\_READDIR\_ID\_LATENCY                 | Average latency of NFS3\_READDIR operations                   | Microseconds |
| NFS3\_READDIR\_ID\_OPS                     | Number of NFS3\_READDIR operations per second                 | Ops/Sec      |
| NFS3\_READLINK\_ID\_LATENCY                | Average latency of NFS3\_READLINK operations                  | Microseconds |
| NFS3\_READLINK\_ID\_OPS                    | Number of NFS3\_READLINK operations per second                | Ops/Sec      |
| NFS3\_READ\_BYTES\_ID                      | Number of NFS3\_READ\_BYTES per second                        | Bytes/Sec    |
| NFS3\_READ\_ID\_LATENCY                    | Average latency of NFS3\_READ operations                      | Microseconds |
| NFS3\_READ\_ID\_OPS                        | Number of NFS3\_READ operations per second                    | Ops/Sec      |
| NFS3\_REMOVE\_ID\_LATENCY                  | Average latency of NFS3\_REMOVE operations                    | Microseconds |
| NFS3\_REMOVE\_ID\_OPS                      | Number of NFS3\_REMOVE operations per second                  | Ops/Sec      |
| NFS3\_RENAME\_ID\_LATENCY                  | Average latency of NFS3\_RENAME operations                    | Microseconds |
| NFS3\_RENAME\_ID\_OPS                      | Number of NFS3\_RENAME operations per second                  | Ops/Sec      |
| NFS3\_SETATTR\_ID\_LATENCY                 | Average latency of NFS3\_SETATTR operations                   | Microseconds |
| NFS3\_SETATTR\_ID\_OPS                     | Number of NFS3\_SETATTR operations per second                 | Ops/Sec      |
| NFS3\_STATFS\_ID\_LATENCY                  | Average latency of NFS3\_STATFS operations                    | Microseconds |
| NFS3\_STATFS\_ID\_OPS                      | Number of NFS3\_STATFS operations per second                  | Ops/Sec      |
| NFS3\_STATFS\_LATENCY                      | Average latency of NFS3\_STATFS operations                    | Microseconds |
| NFS3\_STATFS\_OPS                          | Number of NFS3\_STATFS operations per second                  | Ops/Sec      |
| NFS3\_SYMLINK\_ID\_LATENCY                 | Average latency of NFS3\_SYMLINK operations                   | Microseconds |
| NFS3\_SYMLINK\_ID\_OPS                     | Number of NFS3\_SYMLINK operations per second                 | Ops/Sec      |
| NFS3\_SYMLINK\_LATENCY                     | Average latency of NFS3\_SYMLINK operations                   | Microseconds |
| NFS3\_SYMLINK\_OPS                         | Number of NFS3\_SYMLINK operations per second                 | Ops/Sec      |
| NFS3\_WRITE\_BYTES\_ID                     | Number of NFS3\_WRITE\_BYTES per second                       | Bytes/Sec    |
| NFS3\_WRITE\_ID\_LATENCY                   | Average latency of NFS3\_WRITE operations                     | Microseconds |
| NFS3\_WRITE\_ID\_OPS                       | Number of NFS3\_WRITE operations per second                   | Ops/Sec      |
| NFS4\_ACCESS\_ID\_LATENCY                  | Average latency of NFS4\_ACCESS operations                    | Microseconds |
| NFS4\_ACCESS\_ID\_OPS                      | Number of NFS4\_ACCESS operations per second                  | Ops/Sec      |
| NFS4\_BACKCHANNEL\_CTL\_ID\_LATENCY        | Average latency of NFS4\_BACKCHANNEL\_CTL operations          | Microseconds |
| NFS4\_BACKCHANNEL\_CTL\_ID\_OPS            | Number of NFS4\_BACKCHANNEL\_CTL operations per second        | Ops/Sec      |
| NFS4\_BACKCHANNEL\_CTL\_LATENCY            | Average latency of NFS4\_BACKCHANNEL\_CTL operations          | Microseconds |
| NFS4\_BACKCHANNEL\_CTL\_OPS                | Number of NFS4\_BACKCHANNEL\_CTL operations per second        | Ops/Sec      |
| NFS4\_BIND\_CONN\_TO\_SESSION\_ID\_LATENCY | Average latency of NFS4\_BIND\_CONN\_TO\_SESSION operations   | Microseconds |
| NFS4\_BIND\_CONN\_TO\_SESSION\_ID\_OPS     | Number of NFS4\_BIND\_CONN\_TO\_SESSION operations per second | Ops/Sec      |
| NFS4\_BIND\_CONN\_TO\_SESSION\_LATENCY     | Average latency of NFS4\_BIND\_CONN\_TO\_SESSION operations   | Microseconds |
| NFS4\_BIND\_CONN\_TO\_SESSION\_OPS         | Number of NFS4\_BIND\_CONN\_TO\_SESSION operations per second | Ops/Sec      |
| NFS4\_CLOSE\_ID\_LATENCY                   | Average latency of NFS4\_CLOSE operations                     | Microseconds |
| NFS4\_CLOSE\_ID\_OPS                       | Number of NFS4\_CLOSE operations per second                   | Ops/Sec      |
| NFS4\_CLOSE\_LATENCY                       | Average latency of NFS4\_CLOSE operations                     | Microseconds |
| NFS4\_CLOSE\_OPS                           | Number of NFS4\_CLOSE operations per second                   | Ops/Sec      |
| NFS4\_COMMIT\_ID\_LATENCY                  | Average latency of NFS4\_COMMIT operations                    | Microseconds |
| NFS4\_COMMIT\_ID\_OPS                      | Number of NFS4\_COMMIT operations per second                  | Ops/Sec      |
| NFS4\_CREATE\_ID\_LATENCY                  | Average latency of NFS4\_CREATE operations                    | Microseconds |
| NFS4\_CREATE\_ID\_OPS                      | Number of NFS4\_CREATE operations per second                  | Ops/Sec      |
| NFS4\_CREATE\_SESSION\_ID\_LATENCY         | Average latency of NFS4\_CREATE\_SESSION operations           | Microseconds |
| NFS4\_CREATE\_SESSION\_ID\_OPS             | Number of NFS4\_CREATE\_SESSION operations per second         | Ops/Sec      |
| NFS4\_CREATE\_SESSION\_LATENCY             | Average latency of NFS4\_CREATE\_SESSION operations           | Microseconds |
| NFS4\_CREATE\_SESSION\_OPS                 | Number of NFS4\_CREATE\_SESSION operations per second         | Ops/Sec      |
| NFS4\_DELEGPURGE\_ID\_LATENCY              | Average latency of NFS4\_DELEGPURGE operations                | Microseconds |
| NFS4\_DELEGPURGE\_ID\_OPS                  | Number of NFS4\_DELEGPURGE operations per second              | Ops/Sec      |
| NFS4\_DELEGPURGE\_LATENCY                  | Average latency of NFS4\_DELEGPURGE operations                | Microseconds |
| NFS4\_DELEGPURGE\_OPS                      | Number of NFS4\_DELEGPURGE operations per second              | Ops/Sec      |
| NFS4\_DELEGRETURN\_ID\_LATENCY             | Average latency of NFS4\_DELEGRETURN operations               | Microseconds |
| NFS4\_DELEGRETURN\_ID\_OPS                 | Number of NFS4\_DELEGRETURN operations per second             | Ops/Sec      |
| NFS4\_DELEGRETURN\_LATENCY                 | Average latency of NFS4\_DELEGRETURN operations               | Microseconds |
| NFS4\_DELEGRETURN\_OPS                     | Number of NFS4\_DELEGRETURN operations per second             | Ops/Sec      |
| NFS4\_DESTROY\_CLIENTID\_ID\_LATENCY       | Average latency of NFS4\_DESTROY\_CLIENTID operations         | Microseconds |
| NFS4\_DESTROY\_CLIENTID\_ID\_OPS           | Number of NFS4\_DESTROY\_CLIENTID operations per second       | Ops/Sec      |
| NFS4\_DESTROY\_CLIENTID\_LATENCY           | Average latency of NFS4\_DESTROY\_CLIENTID operations         | Microseconds |
| NFS4\_DESTROY\_CLIENTID\_OPS               | Number of NFS4\_DESTROY\_CLIENTID operations per second       | Ops/Sec      |
| NFS4\_DESTROY\_SESSION\_ID\_LATENCY        | Average latency of NFS4\_DESTROY\_SESSION operations          | Microseconds |
| NFS4\_DESTROY\_SESSION\_ID\_OPS            | Number of NFS4\_DESTROY\_SESSION operations per second        | Ops/Sec      |
| NFS4\_DESTROY\_SESSION\_LATENCY            | Average latency of NFS4\_DESTROY\_SESSION operations          | Microseconds |
| NFS4\_DESTROY\_SESSION\_OPS                | Number of NFS4\_DESTROY\_SESSION operations per second        | Ops/Sec      |
| NFS4\_EXCHANGEID\_ID\_LATENCY              | Average latency of NFS4\_EXCHANGEID operations                | Microseconds |
| NFS4\_EXCHANGEID\_ID\_OPS                  | Number of NFS4\_EXCHANGEID operations per second              | Ops/Sec      |
| NFS4\_EXCHANGE\_ID\_LATENCY                | Average latency of NFS4\_EXCHANGE\_ID operations              | Microseconds |
| NFS4\_EXCHANGE\_ID\_OPS                    | Number of NFS4\_EXCHANGE\_ID operations per second            | Ops/Sec      |
| NFS4\_FREE\_STATEID\_ID\_LATENCY           | Average latency of NFS4\_FREE\_STATEID operations             | Microseconds |
| NFS4\_FREE\_STATEID\_ID\_OPS               | Number of NFS4\_FREE\_STATEID operations per second           | Ops/Sec      |
| NFS4\_FREE\_STATEID\_LATENCY               | Average latency of NFS4\_FREE\_STATEID operations             | Microseconds |
| NFS4\_FREE\_STATEID\_OPS                   | Number of NFS4\_FREE\_STATEID operations per second           | Ops/Sec      |
| NFS4\_GETATTR\_ID\_LATENCY                 | Average latency of NFS4\_GETATTR operations                   | Microseconds |
| NFS4\_GETATTR\_ID\_OPS                     | Number of NFS4\_GETATTR operations per second                 | Ops/Sec      |
| NFS4\_GETDEVICEINFO\_ID\_LATENCY           | Average latency of NFS4\_GETDEVICEINFO operations             | Microseconds |
| NFS4\_GETDEVICEINFO\_ID\_OPS               | Number of NFS4\_GETDEVICEINFO operations per second           | Ops/Sec      |
| NFS4\_GETDEVICEINFO\_LATENCY               | Average latency of NFS4\_GETDEVICEINFO operations             | Microseconds |
| NFS4\_GETDEVICEINFO\_OPS                   | Number of NFS4\_GETDEVICEINFO operations per second           | Ops/Sec      |
| NFS4\_GETDEVICELIST\_ID\_LATENCY           | Average latency of NFS4\_GETDEVICELIST operations             | Microseconds |
| NFS4\_GETDEVICELIST\_ID\_OPS               | Number of NFS4\_GETDEVICELIST operations per second           | Ops/Sec      |
| NFS4\_GETDEVICELIST\_LATENCY               | Average latency of NFS4\_GETDEVICELIST operations             | Microseconds |
| NFS4\_GETDEVICELIST\_OPS                   | Number of NFS4\_GETDEVICELIST operations per second           | Ops/Sec      |
| NFS4\_GETFH\_ID\_LATENCY                   | Average latency of NFS4\_GETFH operations                     | Microseconds |
| NFS4\_GETFH\_ID\_OPS                       | Number of NFS4\_GETFH operations per second                   | Ops/Sec      |
| NFS4\_GETFH\_LATENCY                       | Average latency of NFS4\_GETFH operations                     | Microseconds |
| NFS4\_GETFH\_OPS                           | Number of NFS4\_GETFH operations per second                   | Ops/Sec      |
| NFS4\_GET\_DIR\_DELEGATION\_ID\_LATENCY    | Average latency of NFS4\_GET\_DIR\_DELEGATION operations      | Microseconds |
| NFS4\_GET\_DIR\_DELEGATION\_ID\_OPS        | Number of NFS4\_GET\_DIR\_DELEGATION operations per second    | Ops/Sec      |
| NFS4\_GET\_DIR\_DELEGATION\_LATENCY        | Average latency of NFS4\_GET\_DIR\_DELEGATION operations      | Microseconds |
| NFS4\_GET\_DIR\_DELEGATION\_OPS            | Number of NFS4\_GET\_DIR\_DELEGATION operations per second    | Ops/Sec      |
| NFS4\_LAYOUTCOMMIT\_ID\_LATENCY            | Average latency of NFS4\_LAYOUTCOMMIT operations              | Microseconds |
| NFS4\_LAYOUTCOMMIT\_ID\_OPS                | Number of NFS4\_LAYOUTCOMMIT operations per second            | Ops/Sec      |
| NFS4\_LAYOUTCOMMIT\_LATENCY                | Average latency of NFS4\_LAYOUTCOMMIT operations              | Microseconds |
| NFS4\_LAYOUTCOMMIT\_OPS                    | Number of NFS4\_LAYOUTCOMMIT operations per second            | Ops/Sec      |
| NFS4\_LAYOUTGET\_ID\_LATENCY               | Average latency of NFS4\_LAYOUTGET operations                 | Microseconds |
| NFS4\_LAYOUTGET\_ID\_OPS                   | Number of NFS4\_LAYOUTGET operations per second               | Ops/Sec      |
| NFS4\_LAYOUTGET\_LATENCY                   | Average latency of NFS4\_LAYOUTGET operations                 | Microseconds |
| NFS4\_LAYOUTGET\_OPS                       | Number of NFS4\_LAYOUTGET operations per second               | Ops/Sec      |
| NFS4\_LAYOUTRETURN\_ID\_LATENCY            | Average latency of NFS4\_LAYOUTRETURN operations              | Microseconds |
| NFS4\_LAYOUTRETURN\_ID\_OPS                | Number of NFS4\_LAYOUTRETURN operations per second            | Ops/Sec      |
| NFS4\_LAYOUTRETURN\_LATENCY                | Average latency of NFS4\_LAYOUTRETURN operations              | Microseconds |
| NFS4\_LAYOUTRETURN\_OPS                    | Number of NFS4\_LAYOUTRETURN operations per second            | Ops/Sec      |
| NFS4\_LINK\_ID\_LATENCY                    | Average latency of NFS4\_LINK operations                      | Microseconds |
| NFS4\_LINK\_ID\_OPS                        | Number of NFS4\_LINK operations per second                    | Ops/Sec      |
| NFS4\_LOCKT\_ID\_LATENCY                   | Average latency of NFS4\_LOCKT operations                     | Microseconds |
| NFS4\_LOCKT\_ID\_OPS                       | Number of NFS4\_LOCKT operations per second                   | Ops/Sec      |
| NFS4\_LOCKT\_LATENCY                       | Average latency of NFS4\_LOCKT operations                     | Microseconds |
| NFS4\_LOCKT\_OPS                           | Number of NFS4\_LOCKT operations per second                   | Ops/Sec      |
| NFS4\_LOCKU\_ID\_LATENCY                   | Average latency of NFS4\_LOCKU operations                     | Microseconds |
| NFS4\_LOCKU\_ID\_OPS                       | Number of NFS4\_LOCKU operations per second                   | Ops/Sec      |
| NFS4\_LOCKU\_LATENCY                       | Average latency of NFS4\_LOCKU operations                     | Microseconds |
| NFS4\_LOCKU\_OPS                           | Number of NFS4\_LOCKU operations per second                   | Ops/Sec      |
| NFS4\_LOCK\_ID\_LATENCY                    | Average latency of NFS4\_LOCK operations                      | Microseconds |
| NFS4\_LOCK\_ID\_OPS                        | Number of NFS4\_LOCK operations per second                    | Ops/Sec      |
| NFS4\_LOCK\_LATENCY                        | Average latency of NFS4\_LOCK operations                      | Microseconds |
| NFS4\_LOCK\_OPS                            | Number of NFS4\_LOCK operations per second                    | Ops/Sec      |
| NFS4\_LOOKUPP\_ID\_LATENCY                 | Average latency of NFS4\_LOOKUPP operations                   | Microseconds |
| NFS4\_LOOKUPP\_ID\_OPS                     | Number of NFS4\_LOOKUPP operations per second                 | Ops/Sec      |
| NFS4\_LOOKUPP\_LATENCY                     | Average latency of NFS4\_LOOKUPP operations                   | Microseconds |
| NFS4\_LOOKUPP\_OPS                         | Number of NFS4\_LOOKUPP operations per second                 | Ops/Sec      |
| NFS4\_LOOKUP\_ID\_LATENCY                  | Average latency of NFS4\_LOOKUP operations                    | Microseconds |
| NFS4\_LOOKUP\_ID\_OPS                      | Number of NFS4\_LOOKUP operations per second                  | Ops/Sec      |
| NFS4\_NVERIFY\_ID\_LATENCY                 | Average latency of NFS4\_NVERIFY operations                   | Microseconds |
| NFS4\_NVERIFY\_ID\_OPS                     | Number of NFS4\_NVERIFY operations per second                 | Ops/Sec      |
| NFS4\_NVERIFY\_LATENCY                     | Average latency of NFS4\_NVERIFY operations                   | Microseconds |
| NFS4\_NVERIFY\_OPS                         | Number of NFS4\_NVERIFY operations per second                 | Ops/Sec      |
| NFS4\_OPENATTR\_ID\_LATENCY                | Average latency of NFS4\_OPENATTR operations                  | Microseconds |
| NFS4\_OPENATTR\_ID\_OPS                    | Number of NFS4\_OPENATTR operations per second                | Ops/Sec      |
| NFS4\_OPENATTR\_LATENCY                    | Average latency of NFS4\_OPENATTR operations                  | Microseconds |
| NFS4\_OPENATTR\_OPS                        | Number of NFS4\_OPENATTR operations per second                | Ops/Sec      |
| NFS4\_OPEN\_CONFIRM\_ID\_LATENCY           | Average latency of NFS4\_OPEN\_CONFIRM operations             | Microseconds |
| NFS4\_OPEN\_CONFIRM\_ID\_OPS               | Number of NFS4\_OPEN\_CONFIRM operations per second           | Ops/Sec      |
| NFS4\_OPEN\_CONFIRM\_LATENCY               | Average latency of NFS4\_OPEN\_CONFIRM operations             | Microseconds |
| NFS4\_OPEN\_CONFIRM\_OPS                   | Number of NFS4\_OPEN\_CONFIRM operations per second           | Ops/Sec      |
| NFS4\_OPEN\_DOWNGRADE\_ID\_LATENCY         | Average latency of NFS4\_OPEN\_DOWNGRADE operations           | Microseconds |
| NFS4\_OPEN\_DOWNGRADE\_ID\_OPS             | Number of NFS4\_OPEN\_DOWNGRADE operations per second         | Ops/Sec      |
| NFS4\_OPEN\_DOWNGRADE\_LATENCY             | Average latency of NFS4\_OPEN\_DOWNGRADE operations           | Microseconds |
| NFS4\_OPEN\_DOWNGRADE\_OPS                 | Number of NFS4\_OPEN\_DOWNGRADE operations per second         | Ops/Sec      |
| NFS4\_OPEN\_ID\_LATENCY                    | Average latency of NFS4\_OPEN operations                      | Microseconds |
| NFS4\_OPEN\_ID\_OPS                        | Number of NFS4\_OPEN operations per second                    | Ops/Sec      |
| NFS4\_OPEN\_LATENCY                        | Average latency of NFS4\_OPEN operations                      | Microseconds |
| NFS4\_OPEN\_OPS                            | Number of NFS4\_OPEN operations per second                    | Ops/Sec      |
| NFS4\_OPS\_ID                              | Number of NFS4\_OPS per second                                | Ops/Sec      |
| NFS4\_PUTFH\_ID\_LATENCY                   | Average latency of NFS4\_PUTFH operations                     | Microseconds |
| NFS4\_PUTFH\_ID\_OPS                       | Number of NFS4\_PUTFH operations per second                   | Ops/Sec      |
| NFS4\_PUTFH\_LATENCY                       | Average latency of NFS4\_PUTFH operations                     | Microseconds |
| NFS4\_PUTFH\_OPS                           | Number of NFS4\_PUTFH operations per second                   | Ops/Sec      |
| NFS4\_PUTPUBFH\_ID\_LATENCY                | Average latency of NFS4\_PUTPUBFH operations                  | Microseconds |
| NFS4\_PUTPUBFH\_ID\_OPS                    | Number of NFS4\_PUTPUBFH operations per second                | Ops/Sec      |
| NFS4\_PUTPUBFH\_LATENCY                    | Average latency of NFS4\_PUTPUBFH operations                  | Microseconds |
| NFS4\_PUTPUBFH\_OPS                        | Number of NFS4\_PUTPUBFH operations per second                | Ops/Sec      |
| NFS4\_PUTROOTFH\_ID\_LATENCY               | Average latency of NFS4\_PUTROOTFH operations                 | Microseconds |
| NFS4\_PUTROOTFH\_ID\_OPS                   | Number of NFS4\_PUTROOTFH operations per second               | Ops/Sec      |
| NFS4\_PUTROOTFH\_LATENCY                   | Average latency of NFS4\_PUTROOTFH operations                 | Microseconds |
| NFS4\_PUTROOTFH\_OPS                       | Number of NFS4\_PUTROOTFH operations per second               | Ops/Sec      |
| NFS4\_READDIR\_ID\_LATENCY                 | Average latency of NFS4\_READDIR operations                   | Microseconds |
| NFS4\_READDIR\_ID\_OPS                     | Number of NFS4\_READDIR operations per second                 | Ops/Sec      |
| NFS4\_READLINK\_ID\_LATENCY                | Average latency of NFS4\_READLINK operations                  | Microseconds |
| NFS4\_READLINK\_ID\_OPS                    | Number of NFS4\_READLINK operations per second                | Ops/Sec      |
| NFS4\_READ\_BYTES\_ID                      | Number of NFS4\_READ\_BYTES per second                        | Bytes/Sec    |
| NFS4\_READ\_ID\_LATENCY                    | Average latency of NFS4\_READ operations                      | Microseconds |
| NFS4\_READ\_ID\_OPS                        | Number of NFS4\_READ operations per second                    | Ops/Sec      |
| NFS4\_RECLAIM\_COMPLETE\_ID\_LATENCY       | Average latency of NFS4\_RECLAIM\_COMPLETE operations         | Microseconds |
| NFS4\_RECLAIM\_COMPLETE\_ID\_OPS           | Number of NFS4\_RECLAIM\_COMPLETE operations per second       | Ops/Sec      |
| NFS4\_RECLAIM\_COMPLETE\_LATENCY           | Average latency of NFS4\_RECLAIM\_COMPLETE operations         | Microseconds |
| NFS4\_RECLAIM\_COMPLETE\_OPS               | Number of NFS4\_RECLAIM\_COMPLETE operations per second       | Ops/Sec      |
| NFS4\_RELEASE\_LOCKOWNER\_ID\_LATENCY      | Average latency of NFS4\_RELEASE\_LOCKOWNER operations        | Microseconds |
| NFS4\_RELEASE\_LOCKOWNER\_ID\_OPS          | Number of NFS4\_RELEASE\_LOCKOWNER operations per second      | Ops/Sec      |
| NFS4\_RELEASE\_LOCKOWNER\_LATENCY          | Average latency of NFS4\_RELEASE\_LOCKOWNER operations        | Microseconds |
| NFS4\_RELEASE\_LOCKOWNER\_OPS              | Number of NFS4\_RELEASE\_LOCKOWNER operations per second      | Ops/Sec      |
| NFS4\_REMOVE\_ID\_LATENCY                  | Average latency of NFS4\_REMOVE operations                    | Microseconds |
| NFS4\_REMOVE\_ID\_OPS                      | Number of NFS4\_REMOVE operations per second                  | Ops/Sec      |
| NFS4\_RENAME\_ID\_LATENCY                  | Average latency of NFS4\_RENAME operations                    | Microseconds |
| NFS4\_RENAME\_ID\_OPS                      | Number of NFS4\_RENAME operations per second                  | Ops/Sec      |
| NFS4\_RENEW\_ID\_LATENCY                   | Average latency of NFS4\_RENEW operations                     | Microseconds |
| NFS4\_RENEW\_ID\_OPS                       | Number of NFS4\_RENEW operations per second                   | Ops/Sec      |
| NFS4\_RENEW\_LATENCY                       | Average latency of NFS4\_RENEW operations                     | Microseconds |
| NFS4\_RENEW\_OPS                           | Number of NFS4\_RENEW operations per second                   | Ops/Sec      |
| NFS4\_RESTOREFH\_ID\_LATENCY               | Average latency of NFS4\_RESTOREFH operations                 | Microseconds |
| NFS4\_RESTOREFH\_ID\_OPS                   | Number of NFS4\_RESTOREFH operations per second               | Ops/Sec      |
| NFS4\_RESTOREFH\_LATENCY                   | Average latency of NFS4\_RESTOREFH operations                 | Microseconds |
| NFS4\_RESTOREFH\_OPS                       | Number of NFS4\_RESTOREFH operations per second               | Ops/Sec      |
| NFS4\_SAVEFH\_ID\_LATENCY                  | Average latency of NFS4\_SAVEFH operations                    | Microseconds |
| NFS4\_SAVEFH\_ID\_OPS                      | Number of NFS4\_SAVEFH operations per second                  | Ops/Sec      |
| NFS4\_SAVEFH\_LATENCY                      | Average latency of NFS4\_SAVEFH operations                    | Microseconds |
| NFS4\_SAVEFH\_OPS                          | Number of NFS4\_SAVEFH operations per second                  | Ops/Sec      |
| NFS4\_SECINFO\_ID\_LATENCY                 | Average latency of NFS4\_SECINFO operations                   | Microseconds |
| NFS4\_SECINFO\_ID\_OPS                     | Number of NFS4\_SECINFO operations per second                 | Ops/Sec      |
| NFS4\_SECINFO\_LATENCY                     | Average latency of NFS4\_SECINFO operations                   | Microseconds |
| NFS4\_SECINFO\_NO\_NAME\_ID\_LATENCY       | Average latency of NFS4\_SECINFO\_NO\_NAME operations         | Microseconds |
| NFS4\_SECINFO\_NO\_NAME\_ID\_OPS           | Number of NFS4\_SECINFO\_NO\_NAME operations per second       | Ops/Sec      |
| NFS4\_SECINFO\_NO\_NAME\_LATENCY           | Average latency of NFS4\_SECINFO\_NO\_NAME operations         | Microseconds |
| NFS4\_SECINFO\_NO\_NAME\_OPS               | Number of NFS4\_SECINFO\_NO\_NAME operations per second       | Ops/Sec      |
| NFS4\_SECINFO\_OPS                         | Number of NFS4\_SECINFO operations per second                 | Ops/Sec      |
| NFS4\_SEQUENCE\_ID\_LATENCY                | Average latency of NFS4\_SEQUENCE operations                  | Microseconds |
| NFS4\_SEQUENCE\_ID\_OPS                    | Number of NFS4\_SEQUENCE operations per second                | Ops/Sec      |
| NFS4\_SEQUENCE\_LATENCY                    | Average latency of NFS4\_SEQUENCE operations                  | Microseconds |
| NFS4\_SEQUENCE\_OPS                        | Number of NFS4\_SEQUENCE operations per second                | Ops/Sec      |
| NFS4\_SETATTR\_ID\_LATENCY                 | Average latency of NFS4\_SETATTR operations                   | Microseconds |
| NFS4\_SETATTR\_ID\_OPS                     | Number of NFS4\_SETATTR operations per second                 | Ops/Sec      |
| NFS4\_SETCLIENTID\_CONFIRM\_ID\_LATENCY    | Average latency of NFS4\_SETCLIENTID\_CONFIRM operations      | Microseconds |
| NFS4\_SETCLIENTID\_CONFIRM\_ID\_OPS        | Number of NFS4\_SETCLIENTID\_CONFIRM operations per second    | Ops/Sec      |
| NFS4\_SETCLIENTID\_CONFIRM\_LATENCY        | Average latency of NFS4\_SETCLIENTID\_CONFIRM operations      | Microseconds |
| NFS4\_SETCLIENTID\_CONFIRM\_OPS            | Number of NFS4\_SETCLIENTID\_CONFIRM operations per second    | Ops/Sec      |
| NFS4\_SETCLIENTID\_ID\_LATENCY             | Average latency of NFS4\_SETCLIENTID operations               | Microseconds |
| NFS4\_SETCLIENTID\_ID\_OPS                 | Number of NFS4\_SETCLIENTID operations per second             | Ops/Sec      |
| NFS4\_SETCLIENTID\_LATENCY                 | Average latency of NFS4\_SETCLIENTID operations               | Microseconds |
| NFS4\_SETCLIENTID\_OPS                     | Number of NFS4\_SETCLIENTID operations per second             | Ops/Sec      |
| NFS4\_SET\_SSV\_ID\_LATENCY                | Average latency of NFS4\_SET\_SSV operations                  | Microseconds |
| NFS4\_SET\_SSV\_ID\_OPS                    | Number of NFS4\_SET\_SSV operations per second                | Ops/Sec      |
| NFS4\_SET\_SSV\_LATENCY                    | Average latency of NFS4\_SET\_SSV operations                  | Microseconds |
| NFS4\_SET\_SSV\_OPS                        | Number of NFS4\_SET\_SSV operations per second                | Ops/Sec      |
| NFS4\_TEST\_STATEID\_ID\_LATENCY           | Average latency of NFS4\_TEST\_STATEID operations             | Microseconds |
| NFS4\_TEST\_STATEID\_ID\_OPS               | Number of NFS4\_TEST\_STATEID operations per second           | Ops/Sec      |
| NFS4\_TEST\_STATEID\_LATENCY               | Average latency of NFS4\_TEST\_STATEID operations             | Microseconds |
| NFS4\_TEST\_STATEID\_OPS                   | Number of NFS4\_TEST\_STATEID operations per second           | Ops/Sec      |
| NFS4\_VERIFY\_ID\_LATENCY                  | Average latency of NFS4\_VERIFY operations                    | Microseconds |
| NFS4\_VERIFY\_ID\_OPS                      | Number of NFS4\_VERIFY operations per second                  | Ops/Sec      |
| NFS4\_VERIFY\_LATENCY                      | Average latency of NFS4\_VERIFY operations                    | Microseconds |
| NFS4\_VERIFY\_OPS                          | Number of NFS4\_VERIFY operations per second                  | Ops/Sec      |
| NFS4\_WANT\_DELEGATION\_ID\_LATENCY        | Average latency of NFS4\_WANT\_DELEGATION operations          | Microseconds |
| NFS4\_WANT\_DELEGATION\_ID\_OPS            | Number of NFS4\_WANT\_DELEGATION operations per second        | Ops/Sec      |
| NFS4\_WANT\_DELEGATION\_LATENCY            | Average latency of NFS4\_WANT\_DELEGATION operations          | Microseconds |
| NFS4\_WANT\_DELEGATION\_OPS                | Number of NFS4\_WANT\_DELEGATION operations per second        | Ops/Sec      |
| NFS4\_WRITE\_BYTES\_ID                     | Number of NFS4\_WRITE\_BYTES per second                       | Bytes/Sec    |
| NFS4\_WRITE\_ID\_LATENCY                   | Average latency of NFS4\_WRITE operations                     | Microseconds |
| NFS4\_WRITE\_ID\_OPS                       | Number of NFS4\_WRITE operations per second                   | Ops/Sec      |
| OPS                                        | Total number of operations                                    | Ops/Sec      |
| READDIR\_LATENCY                           | Average latency of READDIR operations                         | Microseconds |
| READDIR\_OPS                               | Number of READDIR operations per second                       | Ops/Sec      |
| READLINK\_LATENCY                          | Average latency of READLINK operations                        | Microseconds |
| READLINK\_OPS                              | Number of READLINK operations per second                      | Ops/Sec      |
| READ\_BYTES                                | Number of bytes read per second                               | Bytes/Sec    |
| READ\_LATENCY                              | Average latency of READ operations                            | Microseconds |
| READ\_OPS                                  | Number of READ operations per second                          | Ops/Sec      |
| REMOVE\_LATENCY                            | Average latency of REMOVE operations                          | Microseconds |
| REMOVE\_OPS                                | Number of REMOVE operations per second                        | Ops/Sec      |
| RENAME\_LATENCY                            | Average latency of RENAME operations                          | Microseconds |
| RENAME\_OPS                                | Number of RENAME operations per second                        | Ops/Sec      |
| SETATTR\_LATENCY                           | Average latency of SETATTR operations                         | Microseconds |
| SETATTR\_OPS                               | Number of SETATTR operations per second                       | Ops/Sec      |
| THROUGHPUT                                 | Number of bytes read/written per second                       | Bytes/Sec    |
| WRITE\_BYTES                               | Number of bytes written per second                            | Bytes/Sec    |
| WRITE\_LATENCY                             | Average latency of WRITE operations                           | Microseconds |
| WRITE\_OPS                                 | Number of WRITE operations per second                         | Ops/Sec      |

### Operations (S3)

| Type                              | Description                                                                                     | Units         |
| --------------------------------- | ----------------------------------------------------------------------------------------------- | ------------- |
| API\_FAILURES                     | Total of failures per API                                                                       | Ops           |
| API\_OPS                          | Total of Ops per API                                                                            | Ops           |
| API\_TTFB                         | Time To First Byte per API                                                                      | Milliseconds  |
| API\_TTLB                         | Time To Last Byte per API                                                                       | Milliseconds  |
| AVG\_TTLB\_HIST                   | TTLB (Time To Last Byte) Milliseconds Histogram per Tenant                                      | Count         |
| AVG\_TTLB\_PERCENT                | TTLB (Time To Last Byte) Percentile                                                             | Milliseconds  |
| FS\_READ\_BYTES                   | Total Read Bytes per Bucket/FS/Tenant                                                           | Bytes/Sec     |
| FS\_RQ                            | Total Requests per Bucket/FS/Tenant                                                             | Ops           |
| FS\_STATUS                        | Count HTTP Status Code per Bucket/FS/Tenant                                                     | Ops           |
| FS\_WRITE\_BYTES                  | Total Write Bytes per Bucket/FS/Tenant                                                          | Bytes/Sec     |
| NOTIFICATION\_LOST                | Total notification lost per notification target                                                 | Notifications |
| QOS\_BUCKET\_BUSY\_REJECT         | QoS bucket-busy gate 503 rejections in interval, per tenant/API                                 | Ops           |
| QOS\_IO\_RETRY\_ATTEMPT           | QoS EXFULL retry attempts in interval, per tenant/op                                            | Ops           |
| QOS\_IO\_RETRY\_BUDGET\_EXHAUSTED | QoS retry sessions that exhausted the budget (503) in interval, per tenant/op                   | Ops           |
| QOS\_IO\_RETRY\_CANCELED          | QoS retry sessions aborted by ctx cancel (client disconnect/timeout) in interval, per tenant/op | Ops           |
| QOS\_IO\_RETRY\_ENTER             | QoS retry sessions that observed EXFULL in interval, per tenant/op                              | Ops           |
| TOTAL\_BUCKET\_CREATE\_OPS        | Total bucket create operations per second                                                       | Ops/Sec       |
| TOTAL\_BUCKET\_DELETE\_OPS        | Total bucket delete operations per second                                                       | Ops/Sec       |
| TOTAL\_BUCKET\_LIST\_OPS          | Total bucket list operations per second                                                         | Ops/Sec       |

### Operations (SLB of S3)

| Type                                    | Description                                             | Units       |
| --------------------------------------- | ------------------------------------------------------- | ----------- |
| AVG\_1xx\_RQ                            | Average 1xx replies per second                          | Ops/Sec     |
| AVG\_2xx\_RQ                            | Average 2xx replies per second                          | Ops/Sec     |
| AVG\_3xx\_RQ                            | Average 3xx replies per second                          | Ops/Sec     |
| AVG\_429\_RQ                            | Average 429 replies per second                          | Ops/Sec     |
| AVG\_4xx\_RQ                            | Average 4xx replies per second                          | Ops/Sec     |
| AVG\_503\_RQ                            | Average 503 replies per second                          | Ops/Sec     |
| AVG\_5xx\_RQ                            | Average 5xx replies per second                          | Ops/Sec     |
| SLB\_1xx\_RQ                            | 1xx responses to traffic originating from adjacent SLBs | Ops         |
| SLB\_2xx\_RQ                            | 2xx responses to traffic originating from adjacent SLBs | Ops         |
| SLB\_3xx\_RQ                            | 3xx responses to traffic originating from adjacent SLBs | Ops         |
| SLB\_4xx\_RQ                            | 4xx responses to traffic originating from adjacent SLBs | Ops         |
| SLB\_5xx\_RQ                            | 5xx responses to traffic originating from adjacent SLBs | Ops         |
| TOTAL\_1xx\_RQ                          | Total 1xx replies                                       | Ops         |
| TOTAL\_2xx\_RQ                          | Total 2xx replies                                       | Ops         |
| TOTAL\_3xx\_RQ                          | Total 3xx replies                                       | Ops         |
| TOTAL\_429\_RQ                          | Total 429 replies                                       | Ops         |
| TOTAL\_4xx\_RQ                          | Total 4xx replies                                       | Ops         |
| TOTAL\_503\_RQ                          | Total 503 replies                                       | Ops         |
| TOTAL\_5xx\_RQ                          | Total 5xx replies                                       | Ops         |
| TOTAL\_active\_connection               | Total SLB Downstream Active Connections                 | Connections |
| TOTAL\_max\_duration\_RQ                | Total Max Duration Reached replies                      | Ops         |
| TOTAL\_rejected\_via\_ip\_detection\_RQ | Total Rejected by IP Detection replies                  | Ops         |
| TOTAL\_response\_before\_complete\_RQ   | Total S3 Responses before Complete replies              | Ops         |
| TOTAL\_rx\_reset\_RQ                    | Total User RX Reset Connection replies                  | Ops         |
| TOTAL\_tx\_reset\_RQ                    | Total Envoy TX Reset Connection replies                 | Ops         |

### Operations (Tenant)

| Type                    | Description                                           | Units        |
| ----------------------- | ----------------------------------------------------- | ------------ |
| READS                   | Number of read operations per second                  | Ops/Sec      |
| READ\_BYTES             | Number of bytes read per second                       | Bytes/Sec    |
| READ\_LATENCY           | Average latency of READ operations                    | Microseconds |
| READ\_LATENCY\_NO\_QOS  | Average latency of READ operations without QoS delay  | Microseconds |
| READ\_QOS\_DELAY        | Average QoS delay for READ operations                 | Microseconds |
| THROUGHPUT              | Number of bytes read/written per second               | Bytes/Sec    |
| WRITES                  | Number of write operations per second                 | Ops/Sec      |
| WRITE\_BYTES            | Number of bytes written per second                    | Bytes/Sec    |
| WRITE\_LATENCY          | Average latency of WRITE operations                   | Microseconds |
| WRITE\_LATENCY\_NO\_QOS | Average latency of WRITE operations without QoS delay | Microseconds |
| WRITE\_QOS\_DELAY       | Average QoS delay for WRITE operations                | Microseconds |

### Platform

| Type                          | Description                                             | Units         |
| ----------------------------- | ------------------------------------------------------- | ------------- |
| REPORTED\_MMAP\_ALLOCS        | Number of reported mmap allocations                     | Allocations   |
| REPORTED\_MMAP\_ALLOC\_MEM    | Memory allocated through reported memory maps, in bytes | Bytes         |
| REPORTED\_MMAP\_DEALLOCS      | Number of reported mmap deallocations                   | Deallocations |
| REPORTED\_MMAP\_RESERVED\_MEM | Memory reserved for reported memory maps, in bytes      | Bytes         |

### Processes

| Type                      | Description                                                         | Units                   |
| ------------------------- | ------------------------------------------------------------------- | ----------------------- |
| ABRUPT\_EXITS             | How many abrupt exits of a process (node) occurred                  | Abrupt process exits    |
| NO\_JUMBO\_FRAMES\_PEERS  | Number of peers with no jumbo frames (low MTU)                      | Peers                   |
| PEER\_CONFIGURE\_FAILURES | How many times the node failed to configure peers to sync with them | Peer configure failures |

### RAFT

| Type                               | Description                                                    | Units    |
| ---------------------------------- | -------------------------------------------------------------- | -------- |
| Bucket\_LEADER\_CHANGES            | Changes of leader                                              | Changes  |
| Bucket\_REQUESTS\_COMPLETED        | The number of completions frontends sent to the driver's queue | Requests |
| Configuration\_LEADER\_CHANGES     | Changes of leader                                              | Changes  |
| Configuration\_REQUESTS\_COMPLETED | The number of completions frontends sent to the driver's queue | Requests |
| Invalid\_LEADER\_CHANGES           | Changes of leader                                              | Changes  |
| Invalid\_REQUESTS\_COMPLETED       | The number of completions frontends sent to the driver's queue | Requests |
| RAFT\_BYTES\_WRITTEN               | Number of writes written to disk for RAFT                      | Bytes    |
| SYNCLOG\_TIMEOUTS                  | The number of timeouts of syncing logs to a process            | Timeouts |
| Test\_LEADER\_CHANGES              | Changes of leader                                              | Changes  |
| Test\_REQUESTS\_COMPLETED          | The number of completions frontends sent to the driver's queue | Requests |

### RAID

| Type                                                   | Description                                                                | Units           |
| ------------------------------------------------------ | -------------------------------------------------------------------------- | --------------- |
| IS\_BLOCK\_USED\_FREE                                  | Number of isBlockUsed returning free                                       | Blocks/Sec      |
| IS\_BLOCK\_USED\_FREE\_LATENCY                         | Average latency of handling an isBlockUsed of a free block                 | Micros          |
| IS\_BLOCK\_USED\_USED                                  | Number of isBlockUsed returning used                                       | Blocks/Sec      |
| IS\_BLOCK\_USED\_USED\_LATENCY                         | Average latency of handling an isBlockUsed of a used block                 | Micros          |
| NVKV\_RECOVERY\_NETBUF\_REREAD\_UNEQUAL                | Number of unequal netbufs encountered that caused NVKV recovery to restart | Blocks/Sec      |
| RAID\_ALLOCATION\_FAILED\_HOLES                        | Slots failed to be allocated and were left as holes                        | Holes/Sec       |
| RAID\_BITMAP\_CHECKSUM\_MISMATCH                       | Bitmap checksum mismatches detected                                        | Occurrences/Sec |
| RAID\_BLOCKS\_COMMITTED\_VIA\_BYPASS\_PlacementSpace0  | Number of blocks committed via bypass-stripes                              | Blocks/Sec      |
| RAID\_BLOCKS\_COMMITTED\_VIA\_BYPASS\_PlacementSpaceN  | Number of blocks committed via bypass-stripes                              | Blocks/Sec      |
| RAID\_BLOCKS\_COMMITTED\_VIA\_NVKV\_PlacementSpace0    | Number of blocks committed via NVKV                                        | Blocks/Sec      |
| RAID\_BLOCKS\_COMMITTED\_VIA\_NVKV\_PlacementSpaceN    | Number of blocks committed via NVKV                                        | Blocks/Sec      |
| RAID\_BLOCKS\_IN\_PREPARED\_STRIPE                     | Available blocks to commit in prepared stripe                              | Blocks          |
| RAID\_CHUNKS\_CLEANED\_BY\_SHIFT                       | Dirty chunks cleaned by being shifted out                                  | Occurences      |
| RAID\_CHUNKS\_SHIFTED                                  | Dirty chunks that shifted out                                              | Occurences      |
| RAID\_COMMITTED\_STRIPES                               | Number of stripes written                                                  | Stripes         |
| RAID\_COMPRESSED\_BLOCKS\_WRITTEN                      | Physical blocks are written containing compressed data                     | Blocks/Sec      |
| RAID\_COMPRESSED\_PADDING                              | Zero-Blocks written to compressed space for alignment                      | Blocks/Sec      |
| RAID\_CORRUPTION\_RECOVERY\_FAILURE                    | Corrupt data could not be recovered                                        | Occurences      |
| RAID\_DIRTIED\_CHUNKS                                  | Chunks newly marked DIRTY in a placement after quorum commit               | Chunks/Sec      |
| RAID\_DRIVE\_FAILURE                                   | Drive failures viewed from compute or front-end nodes                      | Occurrences/Sec |
| RAID\_PLACEMENT\_ALLOC\_PlacementSpace0                | Number of placement allocations                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_ALLOC\_PlacementSpaceN\_Compressed    | Number of placement allocations                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_ALLOC\_PlacementSpaceN\_Uncompressed  | Number of placement allocations                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_RETIRE\_PlacementSpace0               | Number of placement retirements                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_RETIRE\_PlacementSpaceN\_Compressed   | Number of placement retirements                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_RETIRE\_PlacementSpaceN\_Uncompressed | Number of placement retirements                                            | Occurrences/Sec |
| RAID\_PLACEMENT\_SWITCHES                              | Number of placement switches                                               | Switches        |
| RAID\_READ\_BATCHES\_PER\_REQUEST\_HISTOGRAM           | Histogram of the number of batches of stripes read in a single request     | Request         |
| RAID\_READ\_BLOCKS                                     | Number of blocks read by the RAID                                          | Blocks/Sec      |
| RAID\_READ\_BLOCKS\_STRIPE\_HISTOGRAM                  | Histogram of the number of blocks read from a single stripe                | Reads           |
| RAID\_READ\_DEGRADED                                   | Degraded mode reads                                                        | Blocks/Sec      |
| RAID\_READ\_FREE                                       | Read Free                                                                  | Occurences      |
| RAID\_READ\_IOS                                        | Raw read blocks performed by the RAID                                      | Blocks/Sec      |
| RAID\_STALE\_WRITES\_DETECTED                          | Stale write detected in read                                               | Occurences      |
| RAID\_STALE\_WRITES\_REPROTECTIONS                     | Stale write reprotections in read                                          | Occurences      |
| RAID\_UNDIRTY\_CHUNKS                                  | Dirty chunks un-dirtied in a placement after quorum commit                 | Chunks/Sec      |
| RAID\_WRITE\_PlacementSpace0                           | Blocks written by spaces                                                   | Blocks/Sec      |
| RAID\_WRITE\_PlacementSpaceN                           | Blocks written by spaces                                                   | Blocks/Sec      |
| WRONG\_DRIVE\_DELTAS                                   | Delta segments are written to the wrong drive                              | Blocks/Sec      |
| WRONG\_DRIVE\_REFS                                     | Reference segments are written to the wrong drive                          | Blocks/Sec      |

### Reactor

| Type                                            | Description                                                                                                                                                | Units                   |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| AVG\_QUEUE\_TIME\_FLEX\_TASKS                   | Average queue time of deferred flex tasks                                                                                                                  | Cycles                  |
| BACKGROUND\_CYCLES                              | Number of cycles spent in background fibers                                                                                                                | Cycles/Sec              |
| BACKGROUND\_FIBERS                              | Number of background fibers that are ready to run and eager to get CPU cycles                                                                              | Fibers                  |
| BACKGROUND\_TIME                                | The percentage of the CPU time used for background operations                                                                                              | %                       |
| BucketInvocationState\_CAPACITY                 | Number of data structures allocated to the BucketInvocationState pool                                                                                      | Structs                 |
| BucketInvocationState\_STRUCT\_SIZE             | Number of bytes in each struct of the BucketInvocationState pool                                                                                           | Bytes                   |
| BucketInvocationState\_USED                     | Number of structs in the BucketInvocationState pool that are currently being used                                                                          | Structs                 |
| CPU\_HANGS                                      | Number of CPU hangs detected                                                                                                                               | Hangs/Sec               |
| CPU\_HANGS\_AND\_KNOWN\_HOGGER                  | Number of CPU hangs detected while known hogger                                                                                                            | Hangs/Sec               |
| CYCLES\_PER\_SECOND                             | Number of cycles the CPU runs per second                                                                                                                   | Cycles/Sec              |
| DEFUNCT\_FIBERS                                 | Number of defunct buffers, which are just memory structures allocated for future fiber needs                                                               | Fibers                  |
| DeferredTask2\_CAPACITY                         | Number of data structures allocated to the DeferredTask2 pool                                                                                              | Structs                 |
| DeferredTask2\_STRUCT\_SIZE                     | Number of bytes in each struct of the DeferredTask2 pool                                                                                                   | Bytes                   |
| DeferredTask2\_USED                             | Number of structs in the DeferredTask2 pool that are currently being used                                                                                  | Structs                 |
| EXCEPTIONS                                      | Number of exceptions caught by the reactor                                                                                                                 | Exceptions/Sec          |
| FLEX\_TASKS\_INLINE\_FULLQUEUE                  | Number of flex tasks run inline on main thread due to full defer queue                                                                                     | Invocations/Sec         |
| FLEX\_TASKS\_INLINE\_LIGHTLOAD                  | Number of flex tasks run inline on main thread due to light load                                                                                           | Invocations/Sec         |
| FLEX\_TASKS\_INLINE\_OVERRIDE                   | Number of flex tasks run inline on main thread due to override                                                                                             | Invocations/Sec         |
| FLEX\_TASKS\_LATENCY                            | Histogram of flex tasks latency                                                                                                                            | usecs                   |
| FLEX\_TASKS\_QUEUED                             | Number of deferred flex tasks queued                                                                                                                       | Invocations/Sec         |
| FLEX\_TASKS\_QUEUED\_RUN\_MAINTHREAD            | Number of deferred flex tasks run by main thread                                                                                                           | Invocations/Sec         |
| FLEX\_TASKS\_QUEUED\_RUN\_THREADPOOL            | Number of deferred flex tasks run on thread pool                                                                                                           | Invocations/Sec         |
| FLEX\_TASKS\_SUBMITTED                          | Number of flex tasks submitted                                                                                                                             | Invocations/Sec         |
| IDLE\_CALLBACK\_INVOCATIONS                     | Number of background work invocations                                                                                                                      | Invocations/Sec         |
| IDLE\_CYCLES                                    | Number of cycles spent in idle                                                                                                                             | Cycles/Sec              |
| IDLE\_TIME                                      | The percentage of the CPU time not used for handling I/Os                                                                                                  | %                       |
| LINGERING\_FIBERS                               | Number of LINGERING fibers                                                                                                                                 | Fibers                  |
| MAIN\_THREAD\_DEFERRED\_FLEX\_TASK\_CYCLES      | Number of cycles main thread spent running deferred flex tasks                                                                                             | Cycles/Sec              |
| MAIN\_THREAD\_INLINE\_FLEX\_TASKS\_AVG\_RUNTIME | Average runtime of inline flex tasks run by the main thread                                                                                                | Cycles                  |
| MAIN\_THREAD\_INLINE\_FLEX\_TASK\_CYCLES        | Number of cycles main thread spent running inline flex tasks                                                                                               | Cycles/Sec              |
| MAIN\_THREAD\_QUEUED\_FLEX\_TASKS\_AVG\_RUNTIME | Average runtime of deferred flex tasks run by the main thread                                                                                              | Cycles                  |
| NODE\_CONTEXT\_SWITCHES                         | Number of context switches                                                                                                                                 | Switches                |
| NODE\_HANG                                      | Number of process (node) hangs per hang time range                                                                                                         | Number of hangs         |
| NODE\_POLL\_TIME                                | Time spent polling scheduler stats                                                                                                                         | usecs                   |
| NODE\_RUN\_PERCENTAGE                           | Percentage of time process is running                                                                                                                      | percentage              |
| NODE\_RUN\_TIME                                 | Time the process spends running                                                                                                                            | usecs                   |
| NODE\_WAIT\_PERCENTAGE                          | Percentage of time process is waiting on waitqueue                                                                                                         | percentage              |
| NODE\_WAIT\_TIME                                | Time the process spends waiting on the wait queue                                                                                                          | usecs                   |
| OUTRAGEOUS\_HOGGERS                             | Number of hoggers taking an excessive amount of time to run                                                                                                | Invocations             |
| ObsBucketManagement\_CAPACITY                   | Number of data structures allocated to the ObsBucketManagement pool                                                                                        | Structs                 |
| ObsBucketManagement\_STRUCT\_SIZE               | Number of bytes in each struct of the ObsBucketManagement pool                                                                                             | Bytes                   |
| ObsBucketManagement\_USED                       | Number of structs in the ObsBucketManagement pool that are currently being used                                                                            | Structs                 |
| ObsGateway\_CAPACITY                            | Number of data structures allocated to the ObsGateway pool                                                                                                 | Structs                 |
| ObsGateway\_STRUCT\_SIZE                        | Number of bytes in each struct of the ObsGateway pool                                                                                                      | Bytes                   |
| ObsGateway\_USED                                | Number of structs in the ObsGateway pool that are currently being used                                                                                     | Structs                 |
| PENDING\_FIBERS                                 | Number of fibers pending for external events, such as a network packet or SSD response. Upon such an external event, they change state to scheduled fibers | Fibers                  |
| QUEUE\_TIME\_FLEX\_TASK\_CYCLES                 | Queue time of deferred flex tasks                                                                                                                          | Cycles/Sec              |
| REACTOR\_MONITOR\_SCHEDULING\_LATENCY           | Histogram of fiber scheduling latency as measured by the reactor monitor fiber                                                                             | usecs                   |
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
| THREAD\_POOL\_FLEX\_TASK\_CYCLES                | Number of cycles thread pool spent running flex tasks                                                                                                      | Cycles/Sec              |
| THREAD\_POOL\_QUEUED\_FLEX\_TASKS\_AVG\_RUNTIME | Average runtime of deferred flex tasks run on thread pool                                                                                                  | Cycles                  |
| THREAD\_POOL\_TASK\_INVOCATIONS                 | Number of tasks run by thread pool                                                                                                                         | Invocations/Sec         |
| TIMER\_CALLBACKS                                | Current number of timer callbacks                                                                                                                          | Callbacks               |
| TOTAL\_FIBERS\_COUNT                            | Number of fibers                                                                                                                                           | Fibers                  |
| TimedCallback\_CAPACITY                         | Number of data structures allocated to the TimedCallback pool                                                                                              | Structs                 |
| TimedCallback\_STRUCT\_SIZE                     | Number of bytes in each struct of the TimedCallback pool                                                                                                   | Bytes                   |
| TimedCallback\_USED                             | Number of structs in the TimedCallback pool that are currently being used                                                                                  | Structs                 |
| UploadFileInfo\_CAPACITY                        | Number of data structures allocated to the UploadFileInfo pool                                                                                             | Structs                 |
| UploadFileInfo\_STRUCT\_SIZE                    | Number of bytes in each struct of the UploadFileInfo pool                                                                                                  | Bytes                   |
| UploadFileInfo\_USED                            | Number of structs in the UploadFileInfo pool that are currently being used                                                                                 | Structs                 |
| networkBuffers\_CAPACITY                        | Number of data structures allocated to the networkBuffers pool                                                                                             | Structs                 |
| networkBuffers\_USED                            | Number of structs in the networkBuffers pool that are currently being used                                                                                 | Structs                 |
| rdmaNetworkBuffers\_CAPACITY                    | Number of data structures allocated to the rdmaNetworkBuffers pool                                                                                         | Structs                 |
| rdmaNetworkBuffers\_USED                        | Number of structs in the rdmaNetworkBuffers pool that are currently being used                                                                             | Structs                 |

### Replication

| Type                                         | Description                                               | Units        |
| -------------------------------------------- | --------------------------------------------------------- | ------------ |
| REPLICA\_RX\_BLOBS                           | Number of replica blobs received                          | Blobs/Sec    |
| REPLICA\_RX\_BLOB\_BAD\_CHECKSUMS            | Number of replica blobs received with checksum mismatch   | Blobs/Sec    |
| REPLICA\_RX\_BLOB\_BYTES                     | Number of bytes in replica blobs received                 | Bytes/Sec    |
| REPLICA\_RX\_ON\_DEMAND\_DATA\_READS         | Number of reads receiving replica data on demand          | Extents/Sec  |
| REPLICA\_RX\_ON\_DEMAND\_DATA\_READ\_BYTES   | Number of bytes read receiving replica data on demand     | Bytes/Sec    |
| REPLICA\_RX\_ON\_DEMAND\_DATA\_READ\_LATENCY | Average latency of reads receiving replica data on demand | Microseconds |
| REPLICA\_TX\_BLOBS                           | Number of replica blobs sent                              | Blobs/Sec    |
| REPLICA\_TX\_BLOB\_BAD\_CHECKSUMS            | Number of replica blobs sent with checksum mismatch       | Blobs/Sec    |
| REPLICA\_TX\_BLOB\_BYTES                     | Number of bytes in replica blobs sent                     | Bytes/Sec    |
| REPLICA\_TX\_ON\_DEMAND\_DATA\_READS         | Number of reads sending replica data on demand            | Extents/Sec  |
| REPLICA\_TX\_ON\_DEMAND\_DATA\_READ\_BYTES   | Number of bytes read sending replica data on demand       | Bytes/Sec    |
| REPLICA\_TX\_ON\_DEMAND\_DATA\_READ\_LATENCY | Average latency of reads sending replica data on demand   | Microseconds |

### Resolve Inode Cache

| Type                                   | Description                                                     | Units   |
| -------------------------------------- | --------------------------------------------------------------- | ------- |
| RESOLVER\_CACHE\_ENTRIES               | Number of entries currently in the resolver inode-to-path cache | Entries |
| RESOLVER\_INODE\_TO\_PATH\_CACHE\_HITS | Resolve-inode-to-path cache hits                                | Queries |
| RESOLVER\_INODE\_TO\_PATH\_CACHE\_MISS | Resolve-inode-to-path cache misses                              | Queries |

### RPC

| Type                                                | Description                                                        | Units        |
| --------------------------------------------------- | ------------------------------------------------------------------ | ------------ |
| CLIENT\_CANCELED\_REQUESTS                          | Number of requests canceled by the client                          | Calls/Sec    |
| CLIENT\_DROPPED\_RESPONSES                          | Number of responses dropped by the client                          | Calls/Sec    |
| CLIENT\_ENCRYPTION\_AUTH\_FAILURES                  | Number of authentication failures by the client                    | Calls/Sec    |
| CLIENT\_MISSING\_ENCRYPTION\_KEY                    | Number of times the client was missing an encryption key           | Calls/Sec    |
| CLIENT\_RECEIVED\_EXCEPTIONS                        | Number of exceptions received by the client                        | Calls/Sec    |
| CLIENT\_RECEIVED\_RESPONSES                         | Number of responses received by the client                         | Calls/Sec    |
| CLIENT\_RECEIVED\_TIMEOUTS                          | Number of timeouts experienced by the client                       | Calls/Sec    |
| CLIENT\_ROUNDTRIP\_AVG                              | Roundtrip average of client normal and low priority RPC calls      | Microseconds |
| CLIENT\_ROUNDTRIP\_AVG\_LOW                         | Roundtrip average of client low-priority RPC calls                 | Microseconds |
| CLIENT\_ROUNDTRIP\_AVG\_NORM                        | Roundtrip average of client normal priority RPC calls              | Microseconds |
| CLIENT\_RPC\_CALLS                                  | Number of all priorities of RPC calls                              | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_DOWNGRADED                      | Number of client-downgraded RPC calls                              | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_LOW                             | Number of low-priority RPC calls                                   | RPC/Sec      |
| CLIENT\_RPC\_CALLS\_NORM                            | Number of normal priority RPC calls                                | RPC/Sec      |
| CLIENT\_SENT\_REQUESTS                              | Number of requests sent by the client                              | Calls/Sec    |
| CLIENT\_USED\_NATIVE\_FORMAT\_FOR\_MISSING\_REFTYPE | Number of RPCs sent to a node whose reftypes lacked a function     | Calls/Sec    |
| DEUS\_EX\_MBUF\_LIMITED                             | Number of RPCs slow down due to low MBuf reserves                  | Ops/Sec      |
| DEUS\_EX\_NOT\_EMPTY                                | Number of RPCs put in DeusEx to preserve RPC order                 | Ops/Sec      |
| DEUS\_EX\_NO\_FIBERS                                | Number of RPCs put in DeusEx due to lack of global fibers          | Ops/Sec      |
| DEUS\_EX\_OVERLOADED                                | Number of RPCs rejected as overloaded by Deus Ex                   | Ops/Sec      |
| DEUS\_EX\_RPC\_MAX\_FIBERS                          | Number of RPCs put in DeusEx due to RPC max fibers                 | Ops/Sec      |
| FIRST\_RESULTS                                      | Number of first results per second                                 | Ops/Sec      |
| MBUF\_LIMITED\_SLEEP                                | Number of times wait due to low MBuf reserves                      | Actions/Sec  |
| RPC\_ENCRYPTION\_SETUP\_FAILURES                    | Number of encryption key setup failures                            | Failures     |
| SERVER\_ABORTS                                      | Number of server received aborts                                   | Calls/Sec    |
| SERVER\_DROPPED\_REQUESTS                           | Number of requests dropped by the server                           | Calls/Sec    |
| SERVER\_ENCRYPTION\_AUTH\_FAILURES                  | Number of encryption authentication failures at the server         | Calls/Sec    |
| SERVER\_INCOMING\_RPCS                              | Number of incoming RPCs                                            | RPCs         |
| SERVER\_MISSING\_ENCRYPTION\_KEY                    | Number of requests missing encryption key at the server            | Calls/Sec    |
| SERVER\_PROCESSING\_AVG                             | Average time to process server RPC calls                           | Microseconds |
| SERVER\_PROCESSING\_TIME                            | Histogram of the time it took the server to process a request      | RPCs         |
| SERVER\_REJECTS                                     | Number of times the server rejected a request                      | Calls/Sec    |
| SERVER\_RPC\_CALLS                                  | Number of server RPC calls                                         | RPC/Sec      |
| SERVER\_RPC\_CALLS\_UPGRADED                        | Number of server-upgraded RPC calls                                | RPC/Sec      |
| SERVER\_SENT\_EXCEPTIONS                            | Number of exceptions sent by the server as a response              | Calls/Sec    |
| SERVER\_SENT\_RESPONSES                             | Number of responses the server sent                                | Calls/Sec    |
| SERVER\_UNENCRYPTED\_REFUSALS                       | Number of requests refused due to missing encryption at the server | Calls/Sec    |
| TIME\_TO\_FIRST\_RESULT                             | Average latency to the first result of a MultiCall                 | Microseconds |

### Scale Test

| Type             | Description                | Units   |
| ---------------- | -------------------------- | ------- |
| SCALE\_TEST\_PER | Scale test per-entity stat | Ops/Sec |

### Scrubber

| Type                                    | Description                                                                                                              | Units          |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | -------------- |
| BLOCK\_CONSISTENCY\_CHECKS              | Number of blocks that were checked for consistency against their block-used-state                                        | Blocks/Sec     |
| BLOCK\_CONSISTENCY\_CHECK\_LATENCY      | Average latency of checking block consistency                                                                            | Micros         |
| CLEANED\_CHUNKS                         | Number of chunks that were cleaned by the scrubber                                                                       | Chunks/Sec     |
| DEGRADED\_READS                         | Number of degraded reads for scrubbing                                                                                   | Requests/Sec   |
| FALSE\_USED\_CHECK\_LATENCY             | Average latency of checking false used per block                                                                         | Micros         |
| FALSE\_USED\_EXTRA\_NOTIFIED            | Number of blocks that were notified as used by the mark-extra-used mechanism                                             | Blocks/Sec     |
| INTERRUPTS                              | Number of scrubs that were interrupted                                                                                   | Occurences/Sec |
| NETWORK\_BUDGET\_WAIT\_LATENCY          | Average latency of waiting for our network budget                                                                        | Micros         |
| NOT\_REALLY\_DIRTY\_BLOCKS              | Number of marked dirty blocks that ScrubMissingWrites found were clean                                                   | Blocks/Sec     |
| NUM\_COPY\_DISCARDED\_BLOCKS            | Number of copied blocks that were discarded                                                                              | Blocks/Sec     |
| NUM\_COPY\_DISCARDS                     | Number of times we discarded scrubber copy work                                                                          | Occurences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARDS        | Number of times we discarded all scrubber work due to invented stripes                                                   | Occurences/Sec |
| NUM\_INVENTED\_STRIPES\_DISCARD\_BLOCKS | Number of blocks that were discarded due to invented stripes                                                             | Blocks/Sec     |
| NUM\_SCRUBBER\_DISCARD\_INTERMEDIATES   | Number of times we discarded all intermediate scrubber work                                                              | Occurences/Sec |
| NUM\_SMW\_DISCARDED\_BLOCKS             | Number of SMW'd blocks that were discarded                                                                               | Blocks/Sec     |
| NUM\_SMW\_DISCARDS                      | Number of times we discarded scrubber SMW work                                                                           | Occurences/Sec |
| NUM\_STRIPE\_SKIPPED\_NOT\_FULLY\_READ  | Number of stripes skipped since stripe is not fully read                                                                 | Occurrences    |
| PLACEMENT\_SELECTION\_LATENCY           | Average latency of scrubbed placement selection                                                                          | Micros         |
| RAID\_PLACEMENT\_SCANS\_COMPLETED       | Number of placement scan completions                                                                                     | Occurences     |
| READS\_CALLED                           | Number of blocks that were read                                                                                          | Blocks/Sec     |
| READ\_BATCH\_SOURCE\_BLOCKS             | Number of source blocks read per batch                                                                                   | Batches        |
| READ\_BLOCKS\_LATENCY                   | Average latency of read blocks                                                                                           | Micros         |
| RELOCATED\_BLOCKS                       | Number of blocks that were relocated for eviction                                                                        | Blocks/Sec     |
| RELOCATE\_BLOCKS\_LATENCY               | Average latency of relocating blocks                                                                                     | Micros         |
| RETRUSTED\_UNPROTECTED\_DIRTY\_BLOCKS   | Number of dirty blocks that ScrubMissingWrites retrusted because they were unprotected                                   | Blocks/Sec     |
| REWRITTEN\_DIRTY\_BLOCKS                | Number of dirty blocks that ScrubMissingWrites rewrote to clean them                                                     | Blocks/Sec     |
| SCAN\_LIKELY\_LEAKED\_BLOCKS            | Number of free blocks encountered during a scan that was marked as KnownUsed in the RAID                                 | Occurences     |
| SCRUB\_BATCHES\_LATENCY                 | Average latency of scrub batches                                                                                         | Millis         |
| SCRUB\_FALSE\_USED\_FAILED              | Number of placements we failed to fully scrub-false-used                                                                 | Occurences/Sec |
| SCRUB\_FALSE\_USED\_FAILED\_READS       | Number of blocks that we failed to read for scrub-false-used                                                             | Blocks/Sec     |
| SCRUB\_FALSE\_USED\_PLACEMENTS          | Number of placements we finished scrub-false-used                                                                        | Occurences/Sec |
| SCRUB\_FALSE\_USED\_WAS\_UNPROTECTED    | Number of blocks that were falsely marked used and unprotected                                                           | Blocks/Sec     |
| SCRUB\_IN\_FLIGHT\_CORRUPTION\_DETECTED | Number of in-flight corruptions detected when scrubbing                                                                  | Occurences     |
| SCRUB\_PREPARATION\_FAILED              | Number of times we failed to prepare() a task and aborted scrub of placement                                             | Occurences/Sec |
| SFU\_CHECKS                             | Number of blocks that were scrubbed-false-used                                                                           | Blocks/Sec     |
| SFU\_CHECK\_FREE                        | Number of blocks that were detected as false-used and freed                                                              | Blocks/Sec     |
| SFU\_CHECK\_SECONDARY                   | Number of blocks that were detected as secondary                                                                         | Blocks/Sec     |
| SFU\_CHECK\_USED                        | Number of blocks that were detected as used                                                                              | Blocks/Sec     |
| SFU\_CHECK\_USED\_CKSUM\_ERR            | Number of blocks that were detected as used with checksum error                                                          | Blocks/Sec     |
| SFU\_FREE\_STRIPES                      | Number of free stripes that were scrubbed-false-used                                                                     | Stripes/Sec    |
| SFU\_FREE\_STRIPE\_LATENCY              | Average latency of handling a read of a free stripe                                                                      | Micros         |
| SFU\_USED\_STRIPES                      | Number of used stripes that were scrubbed-false-used                                                                     | Stripes/Sec    |
| SFU\_USED\_STRIPE\_LATENCY              | Average latency of handling a read of a used stripe                                                                      | Micros         |
| SOURCE\_READS                           | Number of source/committed superset blocks directly read by the scrubber                                                 | Blocks/Sec     |
| STRIPE\_DATA\_IS\_BLOCK\_USED           | Number of isBlockUsed during s                                                                                           | Blocks/Sec     |
| STRIPE\_DATA\_IS\_BLOCK\_USED\_LATENCY  | Average latency of isBlockUsed during stripe verification                                                                | Micros         |
| TARGET\_COPIED\_CHUNKS                  | Number of chunks that were copied to target by the scrubber                                                              | Chunks/Sec     |
| UPDATE\_PLACEMENT\_INFO                 | Number of times we ran updatePlacementInfo                                                                               | Occurences/Sec |
| UPDATE\_PLACEMENT\_INFO\_LATENCY        | Average latency of updating the placement info quorum                                                                    | Micros         |
| WONT\_CLEAN\_COPYING                    | Number of actually dirty blocks that ScrubMissingWrites refused to clean because they will be moved to the target anyway | Blocks/Sec     |
| WRITES\_CALLED                          | Number of blocks that were written                                                                                       | Blocks/Sec     |
| WRITE\_BATCH\_SOURCE\_BLOCKS            | Number of source blocks to write in batch                                                                                | Batches        |
| WRITE\_BATCH\_TARGET\_BLOCKS            | Number of target blocks to write in batch                                                                                | Batches        |
| WRITE\_BLOCKS\_LATENCY                  | Average latency of writing blocks                                                                                        | Micros         |

### Squelch

| Type                                                    | Description                                               | Units         |
| ------------------------------------------------------- | --------------------------------------------------------- | ------------- |
| BLOCKS\_PER\_DESQUELCH                                  | Number of squelch blocks per desquelch                    | Desquelches   |
| EXTENT\_DESQUELCHES\_NUM                                | Number of desquelches                                     | Times         |
| EXTENT\_DIGEST\_BLOCKS\_READ                            | Number of digest blocks read for registry initialization  | Blocks        |
| EXTENT\_REGISTRY\_BLOCKS\_READ                          | Number of registry blocks read                            | Blocks        |
| EXTENT\_SQUELCH\_BLOCKS\_READ                           | Number of squelch blocks desquelched                      | Blocks        |
| EXTENT\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST              | Number of squelch blocks read for registry initialization | Blocks        |
| HASH\_DESQUELCHES\_NUM                                  | Number of desquelches                                     | Times         |
| HASH\_DIGEST\_BLOCKS\_READ                              | Number of digest blocks read for registry initialization  | Blocks        |
| HASH\_REGISTRY\_BLOCKS\_READ                            | Number of registry blocks read                            | Blocks        |
| HASH\_SQUELCH\_BLOCKS\_READ                             | Number of squelch blocks desquelched                      | Blocks        |
| HASH\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST                | Number of squelch blocks read for registry initialization | Blocks        |
| INODE\_DESQUELCHES\_NUM                                 | Number of desquelches                                     | Times         |
| INODE\_DIGEST\_BLOCKS\_READ                             | Number of digest blocks read for registry initialization  | Blocks        |
| INODE\_REGISTRY\_BLOCKS\_READ                           | Number of registry blocks read                            | Blocks        |
| INODE\_SQUELCH\_BLOCKS\_READ                            | Number of squelch blocks desquelched                      | Blocks        |
| INODE\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST               | Number of squelch blocks read for registry initialization | Blocks        |
| JOURNAL\_DESQUELCHES\_NUM                               | Number of desquelches                                     | Times         |
| JOURNAL\_DIGEST\_BLOCKS\_READ                           | Number of digest blocks read for registry initialization  | Blocks        |
| JOURNAL\_REGISTRY\_BLOCKS\_READ                         | Number of registry blocks read                            | Blocks        |
| JOURNAL\_SQUELCH\_BLOCKS\_READ                          | Number of squelch blocks desquelched                      | Blocks        |
| JOURNAL\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST             | Number of squelch blocks read for registry initialization | Blocks        |
| MAX\_BLOCKS\_WITH\_TEMPORAL\_SQUELCH\_ITEMS\_IN\_BUCKET | Number of blocks with temporal squelch items in bucket    | Blocks        |
| MAX\_TEMPORAL\_SQUELCH\_ITEMS\_IN\_BUCKET               | Number temporal squelch items in bucket                   | Squelch items |
| ODL\_DESQUELCHES\_NUM                                   | Number of desquelches                                     | Times         |
| ODL\_DIGEST\_BLOCKS\_READ                               | Number of digest blocks read for registry initialization  | Blocks        |
| ODL\_PAYLOAD\_DESQUELCHES\_NUM                          | Number of desquelches                                     | Times         |
| ODL\_PAYLOAD\_DIGEST\_BLOCKS\_READ                      | Number of digest blocks read for registry initialization  | Blocks        |
| ODL\_PAYLOAD\_REGISTRY\_BLOCKS\_READ                    | Number of registry blocks read                            | Blocks        |
| ODL\_PAYLOAD\_SQUELCH\_BLOCKS\_READ                     | Number of squelch blocks desquelched                      | Blocks        |
| ODL\_PAYLOAD\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST        | Number of squelch blocks read for registry initialization | Blocks        |
| ODL\_REGISTRY\_BLOCKS\_READ                             | Number of registry blocks read                            | Blocks        |
| ODL\_SQUELCH\_BLOCKS\_READ                              | Number of squelch blocks desquelched                      | Blocks        |
| ODL\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST                 | Number of squelch blocks read for registry initialization | Blocks        |
| REGISTRY\_L1\_DESQUELCHES\_NUM                          | Number of desquelches                                     | Times         |
| REGISTRY\_L1\_DIGEST\_BLOCKS\_READ                      | Number of digest blocks read for registry initialization  | Blocks        |
| REGISTRY\_L1\_REGISTRY\_BLOCKS\_READ                    | Number of registry blocks read                            | Blocks        |
| REGISTRY\_L1\_SQUELCH\_BLOCKS\_READ                     | Number of squelch blocks desquelched                      | Blocks        |
| REGISTRY\_L1\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST        | Number of squelch blocks read for registry initialization | Blocks        |
| REGISTRY\_L2\_DESQUELCHES\_NUM                          | Number of desquelches                                     | Times         |
| REGISTRY\_L2\_DIGEST\_BLOCKS\_READ                      | Number of digest blocks read for registry initialization  | Blocks        |
| REGISTRY\_L2\_REGISTRY\_BLOCKS\_READ                    | Number of registry blocks read                            | Blocks        |
| REGISTRY\_L2\_SQUELCH\_BLOCKS\_READ                     | Number of squelch blocks desquelched                      | Blocks        |
| REGISTRY\_L2\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST        | Number of squelch blocks read for registry initialization | Blocks        |
| SPATIAL\_DIGEST\_DESQUELCHES\_NUM                       | Number of desquelches                                     | Times         |
| SPATIAL\_DIGEST\_DIGEST\_BLOCKS\_READ                   | Number of digest blocks read for registry initialization  | Blocks        |
| SPATIAL\_DIGEST\_REGISTRY\_BLOCKS\_READ                 | Number of registry blocks read                            | Blocks        |
| SPATIAL\_DIGEST\_SQUELCH\_BLOCKS\_READ                  | Number of squelch blocks desquelched                      | Blocks        |
| SPATIAL\_DIGEST\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST     | Number of squelch blocks read for registry initialization | Blocks        |
| SPATIAL\_SQUELCH\_DESQUELCHES\_NUM                      | Number of desquelches                                     | Times         |
| SPATIAL\_SQUELCH\_DIGEST\_BLOCKS\_READ                  | Number of digest blocks read for registry initialization  | Blocks        |
| SPATIAL\_SQUELCH\_REGISTRY\_BLOCKS\_READ                | Number of registry blocks read                            | Blocks        |
| SPATIAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ                 | Number of squelch blocks desquelched                      | Blocks        |
| SPATIAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST    | Number of squelch blocks read for registry initialization | Blocks        |
| SUPERBLOCK\_DESQUELCHES\_NUM                            | Number of desquelches                                     | Times         |
| SUPERBLOCK\_DIGEST\_BLOCKS\_READ                        | Number of digest blocks read for registry initialization  | Blocks        |
| SUPERBLOCK\_REGISTRY\_BLOCKS\_READ                      | Number of registry blocks read                            | Blocks        |
| SUPERBLOCK\_SQUELCH\_BLOCKS\_READ                       | Number of squelch blocks desquelched                      | Blocks        |
| SUPERBLOCK\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST          | Number of squelch blocks read for registry initialization | Blocks        |
| TEMPORAL\_SQUELCH\_DESQUELCHES\_NUM                     | Number of desquelches                                     | Times         |
| TEMPORAL\_SQUELCH\_DIGEST\_BLOCKS\_READ                 | Number of digest blocks read for registry initialization  | Blocks        |
| TEMPORAL\_SQUELCH\_REGISTRY\_BLOCKS\_READ               | Number of registry blocks read                            | Blocks        |
| TEMPORAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ                | Number of squelch blocks desquelched                      | Blocks        |
| TEMPORAL\_SQUELCH\_SQUELCH\_BLOCKS\_READ\_FOR\_DIGEST   | Number of squelch blocks read for registry initialization | Blocks        |

### SSD

| Type                                               | Description                                                                                    | Units          |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------- | -------------- |
| CHUNK\_ALLOC\_LATENCY                              | Average latency of allocChunk operations per disk                                              | Microseconds   |
| CHUNK\_ALLOC\_OPS                                  | Number of allocChunk operations per disk                                                       | Operations/Sec |
| CHUNK\_RELEASE\_LATENCY                            | Average latency of releaseChunk operations per disk                                            | Microseconds   |
| CHUNK\_RELEASE\_OPS                                | Number of releaseChunk operations per disk                                                     | Operations/Sec |
| CHUNK\_UPDATE\_LATENCY                             | Average latency of updateChunk operations per disk                                             | Microseconds   |
| CHUNK\_UPDATE\_OPS                                 | Number of updateChunk operations per disk                                                      | Operations/Sec |
| CLEAN\_CHUNK\_SKIPPED                              | Number of clean chunks skipped                                                                 | Chunks         |
| DRIVE\_ACTIVE\_IOS                                 | The number of in-flight IOs against the SSD during sampling                                    | IOs            |
| DRIVE\_AER\_RECEIVED                               | Number of AER reports                                                                          | reports        |
| DRIVE\_CANCELLED\_COMPLETED\_BLOCKS                | Drive canceled completed blocks                                                                | Blocks/Sec     |
| DRIVE\_CANCELLED\_NOT\_SUBMITTED\_BLOCKS           | Drive canceled not submitted blocks                                                            | Blocks/Sec     |
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
| DRIVE\_PUMPED\_IOS                                 | Number of requests returned in a pump                                                          | Pumps          |
| DRIVE\_PUMPS\_DELAYED                              | Number of Drive pumps that got delayed                                                         | Operations/Sec |
| DRIVE\_PUMPS\_SEVERELY\_DELAYED                    | Number of Drive pumps that got severely delayed                                                | Operations/Sec |
| DRIVE\_PUMP\_LATENCY                               | Latency between SSD pumps                                                                      | Microseconds   |
| DRIVE\_READ\_LATENCY                               | Drive Read Execution Latency                                                                   | Microseconds   |
| DRIVE\_READ\_OPS                                   | Drive Read Operations                                                                          | IO/Sec         |
| DRIVE\_READ\_RATIO\_PER\_SSD\_READ                 | Drive Read OPS Per SSD Request                                                                 | Ratio          |
| DRIVE\_REMAINING\_IOS                              | Number of requests still in the drive after a pump                                             | Pumps          |
| DRIVE\_REMAINING\_SPARES                           | Drive remaining spares                                                                         | %              |
| DRIVE\_REQUEST\_BLOCKS                             | Measure drive request size distribution                                                        | Requests       |
| DRIVE\_SOFT\_ECC\_COUNT                            | Drive Soft ECC Error Count                                                                     | Error Count    |
| DRIVE\_SSD\_PUMPS                                  | Number of drive pumps that resulted in the data flow from/to drive                             | Pump/Sec       |
| DRIVE\_UNALIGNED\_IOS                              | Drive unaligned IOs count                                                                      | IOs            |
| DRIVE\_UNCORRECTABLE\_READ\_COUNT                  | Drive uncorrectable read count                                                                 | Error Count    |
| DRIVE\_UTILIZATION                                 | Percentage of time the drive had an active IO submitted to it                                  | %              |
| DRIVE\_WAF\_INTERVAL                               | Drive Interval write amplification                                                             | Factor         |
| DRIVE\_WAF\_LIFETIME                               | Drive lifetime write amplification                                                             | Factor         |
| DRIVE\_WRITE\_LATENCY                              | Drive Write Execution Latency                                                                  | Microseconds   |
| DRIVE\_WRITE\_OPS                                  | Drive Write Operations                                                                         | IO/Sec         |
| DRIVE\_WRITE\_RATIO\_PER\_SSD\_WRITE               | Drive Write OPS Per SSD Request                                                                | Ratio          |
| DRIVE\_XOR\_RECOVERY\_COUNT                        | Drive XOR recovery count                                                                       | Error Count    |
| LEAKED\_AIOVEC\_NETBUF                             | Number of leaked AIOVec netbufs on uncompleted IO                                              | Operations     |
| MULTI\_TURN\_GET\_COMPRESSED\_BLOCKS               | The number of compressed blocks reads which required more than a single turn                   | Requests/Sec   |
| NVKV\_CHUNK\_OUT\_OF\_SPACE                        | Number of failed attempts to allocate a stripe in an NVKV chunk                                | Attempts/Sec   |
| NVKV\_INVALIDATOR\_MATCHED                         | Number of NVKV invalidators matching the data                                                  | Attempts/Sec   |
| NVKV\_OUT\_OF\_CHUNKS                              | Number of failed attempts to allocate an NVKV chunk                                            | Attempts/Sec   |
| NVKV\_OUT\_OF\_SUPERBLOCK\_ENTRIES                 | Number of failed attempts to allocate a superblock NVKV entry                                  | Attempts/Sec   |
| NVME\_NAMESPACE\_CAPACITY                          | NVMe namespace capacity                                                                        | Blocks         |
| NVME\_NAMESPACE\_SIZE                              | The size of the NVMe namespace                                                                 | Blocks         |
| NVME\_NAMESPACE\_UTILIZATION                       | NVMe namespace utilization                                                                     | Blocks         |
| NVME\_SMART\_AVAILABLE\_SPARE                      | Normalized percentage when the available spare falls below the threshold                       | %              |
| NVME\_SMART\_AVAILABLE\_SPARE\_THRESHOLD           | Normalized percentage of the available spare falls below the threshold                         | %              |
| NVME\_SMART\_COMPOSITE\_TEMP                       | Current composite temperature of the container in Kelvins                                      | Kelvin         |
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
| SPDK\_CUSE\_CMDS\_BLOCKED                          | Number of SPDK CUSE commands blocked                                                           | Count          |
| SPDK\_CUSE\_CMDS\_FAILED                           | Number of SPDK CUSE commands failed                                                            | Count          |
| SPDK\_CUSE\_CMDS\_INPROGRESS                       | Number of SPDK CUSE commands in-progress                                                       | Count          |
| SPDK\_CUSE\_CMDS\_ISSUED                           | Number of SPDK CUSE commands issued                                                            | Count          |
| SPDK\_CUSE\_CMDS\_SUCCEEDED                        | Number of SPDK CUSE commands succeeded                                                         | Count          |
| SSDS\_IOS                                          | IOs performed on the SSD service                                                               | IO/Sec         |
| SSDS\_IO\_ERRORS                                   | IO errors on the SSD service                                                                   | Blocks/Sec     |
| SSD\_BLOCKS\_READ                                  | Number of blocks read from the SSD service                                                     | Blocks/Sec     |
| SSD\_BLOCKS\_WRITTEN                               | Number of blocks written to the SSD service                                                    | Blocks/Sec     |
| SSD\_CHUNKS\_IN\_USE                               | Number of allocated chunks                                                                     | Chunks         |
| SSD\_CHUNK\_ALLOCS                                 | Number of chunk allocations                                                                    | Chunks         |
| SSD\_CHUNK\_ALLOCS\_TRIMMED                        | Number of chunk allocations from the trimmed queue                                             | Chunks         |
| SSD\_CHUNK\_ALLOCS\_UNTRIMMED                      | Number of chunk allocations from the untrimmed queue                                           | Chunks         |
| SSD\_CHUNK\_FREES                                  | Number of chunk frees                                                                          | Chunks         |
| SSD\_CHUNK\_FREE\_TRIMMED                          | Number of free trimmed chunks                                                                  | Chunks         |
| SSD\_CHUNK\_FREE\_UNTRIMMED                        | Number of free untrimmed chunks                                                                | Chunks         |
| SSD\_CHUNK\_TRIMS                                  | Number of trims performed                                                                      | Chunks         |
| SSD\_E2E\_BAD\_CSUM                                | End-to-End checksum failures                                                                   | IO/Sec         |
| SSD\_READ\_ERRORS                                  | Errors in reading blocks from the SSD service                                                  | Blocks/Sec     |
| SSD\_READ\_LATENCY                                 | Avg. latency of read requests from the SSD service                                             | Microseconds   |
| SSD\_READ\_REQS                                    | Number of read requests from the SSD service                                                   | IO/Sec         |
| SSD\_READ\_REQS\_LARGE\_NORMAL                     | Number of large normal read requests from the SSD service                                      | IO/Sec         |
| SSD\_SCRATCH\_BUFFERS\_USED                        | Number of scratch blocks used                                                                  | Blocks         |
| SSD\_TRIM\_TIMEOUTS                                | Number of trim timeouts                                                                        | Timeouts       |
| SSD\_UNALIGNED\_WRITES                             | Number of unaligned writes                                                                     | Ops            |
| SSD\_WRITES                                        | Number of write requests to the SSD service                                                    | IO/Sec         |
| SSD\_WRITES\_REQS\_LARGE\_NORMAL                   | Number of large normal priority write requests to the SSD service                              | IO/Sec         |
| SSD\_WRITE\_ERRORS                                 | Errors in writing blocks to the SSD service                                                    | Blocks/Sec     |
| SSD\_WRITE\_LATENCY                                | Latency of writes to the SSD service                                                           | Microseconds   |

### Statistics

| Type                             | Description                                                                            | Units       |
| -------------------------------- | -------------------------------------------------------------------------------------- | ----------- |
| AVAILABLE\_HOST\_MEMORY\_MB      | Amount of Free Memory                                                                  | MB          |
| GATHER\_FROM\_NODE\_LATENCY      | Time spent responding to a stats-gathering request (not including metadata)            | Seconds/Sec |
| GATHER\_FROM\_NODE\_LATENCY\_NET | Time spent on responding to a stats-gathering request (not including metadata)         | Seconds/Sec |
| GATHER\_FROM\_NODE\_SLEEP        | Time spent in-between responding to a stats-gathering request (not including metadata) | Seconds/Sec |
| TIMES\_QUERIED                   | Number of times the process was queried for stats (not including metadata)             | Times       |
| TIMES\_QUERIED\_STATS            | Number of times the process queried other processes for stats                          | Times       |

### Telemetry

| Type                                               | Description                                                         | Units  |
| -------------------------------------------------- | ------------------------------------------------------------------- | ------ |
| CURRENT\_BUFFER\_BYTES                             | Buffer memory usage in bytes                                        | Bytes  |
| CURRENT\_BUFFER\_EVENTS                            | Events currently queued in buffer                                   | Events |
| CURRENT\_UTILIZATION                               | Telemetry gateway component load ratio                              | Ratio  |
| TOTAL\_ADDED\_FILES                                | Total number of files added                                         | Files  |
| TOTAL\_BUFFER\_DISCARDED\_EVENTS                   | Total number of discarded events by vector buffers                  | Events |
| TOTAL\_BUFFER\_RECEIVED\_BYTES                     | Total number of bytes received to vector buffers                    | Bytes  |
| TOTAL\_BUFFER\_RECEIVED\_EVENTS                    | Total number of events received to vector buffers                   | Events |
| TOTAL\_BUFFER\_SENT\_BYTES                         | Total number of bytes sent to vector buffers                        | Bytes  |
| TOTAL\_BUFFER\_SENT\_EVENTS                        | Total number of events sent to vector buffers                       | Events |
| TOTAL\_COMPONENT\_ERRORS                           | Total number of errors reported by vector components                | Errors |
| TOTAL\_COMPONENT\_RECEIVED\_BYTES                  | Total number of bytes received to vector components                 | Bytes  |
| TOTAL\_COMPONENT\_RECEIVED\_EVENTS                 | Total number of events received to vector components                | Events |
| TOTAL\_COMPONENT\_SENT\_BYTES                      | Total number of bytes sent to vector components                     | Bytes  |
| TOTAL\_COMPONENT\_SENT\_EVENTS                     | Total number of events sent to vector components                    | Events |
| TOTAL\_DELETED\_FILES                              | Total number of files deleted                                       | Files  |
| TOTAL\_INTENTIONAL\_COMPONENT\_DISCARDED\_EVENTS   | Total number intentional of discarded events by vector components   | Events |
| TOTAL\_RESUMED\_FILES                              | Total number of files resumed                                       | Files  |
| TOTAL\_UNINTENTIONAL\_COMPONENT\_DISCARDED\_EVENTS | Total number unintentional of discarded events by vector components | Events |
| TOTAL\_UNWATCHED\_FILES                            | Total number of files unwatched                                     | Files  |

### Unlink Log

| Type                                        | Description                                                        | Units       |
| ------------------------------------------- | ------------------------------------------------------------------ | ----------- |
| UNLINK\_LOG\_APPEND\_DENIALS                | Number of rejects for add new entry due to ODH marked as non clean | Denials     |
| UNLINK\_LOG\_UNEXPECTED\_ODH\_INDEX\_CHANGE | Number of unexpected ODH index changes                             | Occurrences |

### WTracer Daemon Stats

| Type                             | Description                                                 | Units       |
| -------------------------------- | ----------------------------------------------------------- | ----------- |
| DAEMON\_EXPORTED\_BYTES          | Number of exported bytes by the wtracer daemon              | Bytes/Sec   |
| DAEMON\_FOUND\_ENTRIES           | Number of found entries by the wtracer daemon               | Entries/Sec |
| DAEMON\_IO\_WRITE\_FAILURES      | Number of write I/O operations failed by the wtracer daemon | Errors      |
| DAEMON\_NUM\_BULK\_FLUSHES       | Number of bulk flushes of entries in the wtracer daemon     | Flushes/Sec |
| DAEMON\_PROCESSED\_BLOBS         | Number of processed blobs by the wtracer daemon             | Blobs/Sec   |
| DAEMON\_PROCESSED\_ENTRIES       | Number of processed entries by the wtracer daemon           | Entries/Sec |
| DAEMON\_PROCESSED\_LOST\_ENTRIES | Number of processed lost entries by the wtracer daemon      | Entries/Sec |
| DAEMON\_SKIPPED\_FILES           | Number of skipped files by the wtracer daemon               | Files/Sec   |
| DAEMON\_TIME\_SPENT\_ENHANCER    | Time spent in the wtracer daemon enhancer                   | hnsecs      |

### WTracer Dumper Stats

| Type                       | Description                                       | Units       |
| -------------------------- | ------------------------------------------------- | ----------- |
| DUMPER\_ACTIVE\_AREAS      | Number of areas dumpers currently have active     | Areas       |
| DUMPER\_ACTIVE\_HISTOGRAMS | Number of histogram dumpers currently have active | Histograms  |
| DUMPER\_BYTES\_OUT         | Number of bytes the dumper outputs to files       | Bytes/Sec   |
| DUMPER\_ENTRIES\_OUT       | Number of entries the dumper outputs to files     | Entries/Sec |
| DUMPER\_ERRORS             | Total number of errors dumper triggered           | Errors      |
| DUMPER\_LOST\_TRACES       | Number of lost traces detected by the dumper      | Entries/Sec |
| DUMPER\_SKIPPED\_BYTES     | Total bytes skipped by the dumper                 | Bytes       |
| DUMPER\_TOTAL\_AREAS       | Total number of areas dumped                      | Areas       |
| DUMPER\_TOTAL\_BLOBS       | Number of blobs the dumper dumped                 | Blobs/Sec   |
| DUMPER\_TOTAL\_CHUNKS      | Number of chunks the dumper dumped                | Chunks/Sec  |
| DUMPER\_TOTAL\_HISTOGRAMS  | Total number of histograms dumped                 | Histograms  |

### XAttr

| Type                          | Description                                                                                  | Units   |
| ----------------------------- | -------------------------------------------------------------------------------------------- | ------- |
| GETXATTR\_INODE\_BLOB         | GetXAttr calls serving an inode value from blob                                              | Ops/Sec |
| GETXATTR\_INODE\_OVERFLOW     | GetXAttr calls serving an inode value from overflow directory                                | Ops/Sec |
| GETXATTR\_OVERSIZE            | GetXAttr calls where the value exceeded 64 KB (returns an error; implies an ioctl-set xattr) | Ops/Sec |
| GETXATTR\_STRING              | GetXAttr calls serving a string value from blob                                              | Ops/Sec |
| LISTXATTR\_OVERSIZE           | ListXAttr calls where the total key list exceeded 64 KB (returns an error)                   | Ops/Sec |
| XATTR\_OVERFLOW\_DIR\_CREATED | XAttr overflow directories created                                                           | Ops/Sec |
| XATTR\_SET\_INODE             | XAttr set operations (add or replace) storing an inode reference value                       | Ops/Sec |
| XATTR\_SET\_STRING            | XAttr set operations (add or replace) storing a string value                                 | Ops/Sec |
