---
description: This page describes how to manage the statistics using the CLI.
---

# Manage statistics using the CLI

Using the CLI, you can:

* [List statistics types](statistics-1.md#list-statistics-types)
* [View statistics in real-time](statistics-1.md#view-statistics-in-real-time)
* [View statistics over time](statistics-1.md#view-statistics-over-time)
* [Set statistics retention](statistics-1.md#set-statistics-retention)

## List statistics types

**Command:** `weka stats list-types`

Use the following command line to obtain statistics definition information:\
`weka stats list-types [<name-or-category>] [--show-internal]`

**Parameters**

<table><thead><tr><th width="222">Name</th><th width="314">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name-or-category</code></td><td>Limit the output to a specific statistic name, category, or category label (in parenthesis).</td><td></td></tr><tr><td><code>show-internal</code></td><td>Include internal statistics in the output.</td><td>False</td></tr></tbody></table>

**Examples**

* Filter by category label ( `"api statistics"` )

```bash
$ weka stats list-types "api statistics"
CATEGORY  CATEGORY LABEL  IDENTIFIER    DESCRIPTION         LABEL                       TYPE      UNIT      PARAMETERS  RELATED RATE PARAMETER  PERMISSION  FOR NODE TYPE  CAN ACCUMULATE  HISTOGRAM  HISTOGRAM UNIT
api       api statistics  TOTAL_2xx_RQ  Total 2xx requests  Total 2xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_3xx_RQ  Total 3xx requests  Total 3xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_429_RQ  Total 429 requests  Total 429 requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_4xx_RQ  Total 4xx requests  Total 4xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_5xx_RQ  Total 5xx requests  Total 5xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
```

* Filter by name and category ( `api` )

```bash
$ weka stats list-types api
CATEGORY  CATEGORY LABEL   IDENTIFIER    DESCRIPTION                 LABEL                       TYPE         UNIT          PARAMETERS  RELATED RATE PARAMETER  PERMISSION  FOR NODE TYPE  CAN ACCUMULATE  HISTOGRAM  HISTOGRAM UNIT
api       api statistics   TOTAL_2xx_RQ  Total 2xx requests          Total 2xx requests (total)  Absolute     Requests                                          USER        MANAGEMENT     True            False
api       api statistics   TOTAL_3xx_RQ  Total 3xx requests          Total 3xx requests (total)  Absolute     Requests                                          USER        MANAGEMENT     True            False
api       api statistics   TOTAL_429_RQ  Total 429 requests          Total 429 requests (total)  Absolute     Requests                                          USER        MANAGEMENT     True            False
api       api statistics   TOTAL_4xx_RQ  Total 4xx requests          Total 4xx requests (total)  Absolute     Requests                                          USER        MANAGEMENT     True            False
api       api statistics   TOTAL_5xx_RQ  Total 5xx requests          Total 5xx requests (total)  Absolute     Requests                                          USER        MANAGEMENT     True            False
ops_s3    Operations (S3)  API_FAILURES  Total of failures per API   Failures per API (total)    Accumulated  Ops           api                                 USER        MANAGEMENT     False           False
ops_s3    Operations (S3)  API_OPS       Total of Ops per API        Ops per API (total)         Accumulated  Ops           api                                 USER        MANAGEMENT     False           False
ops_s3    Operations (S3)  API_TTFB      Time To First Byte per API  TTFB per API (sum)          Accumulated  Milliseconds  api                                 USER        MANAGEMENT     False           False
ops_s3    Operations (S3)  API_TTLB      Time To Last Byte per API   TTLB per API (sum)          Accumulated  Milliseconds  api                                 USER        MANAGEMENT     False           False
```

* Include internal stats and filter by name and category ( `config` )

```bash
$ weka stats list-types config --show-internal
CATEGORY  CATEGORY LABEL  IDENTIFIER                                                  DESCRIPTION                                                                                                     LABEL                                                                                           TYPE         UNIT                                                   PARAMETERS                                           RELATED RATE PARAMETER       PERMISSION  FOR NODE TYPE  CAN ACCUMULATE  HISTOGRAM  HISTOGRAM UNIT
cluster   Processes       PEER_CONFIGURE_FAILURES                                     How many times the node failed to configure peers to sync with them                                             Peer configure failures detected (total)                                                        Absolute     Peer configure failures                                                                                                                  WEKA        ANY            True            False
config    Config          AVERAGE_CHANGES_IN_CHANGESET                                The average number of changes in a changeset                                                                    Average (total)                                                                                 Rate         Changes/Sec                                                                                                                              WEKA        MANAGEMENT     True            False
config    Config          AVERAGE_CHANGES_IN_GENERATION                               The average number of changes in a generation                                                                   Average (total)                                                                                 Rate         Changes/Sec                                                                                                                              WEKA        MANAGEMENT     True            False
config    Config          BACKEND_NODE_REJOIN_TIME                                    The number of backends rejoin attempts per completion time range                                                Backend node rejoin time (total)                                                                Histogram    Number of rejoins                                                                                                                        WEKA        MANAGEMENT     True            True       mSecs
config    Config          CHANGESET_COMMIT_LATENCY                                    The average latency of committing a configuration changeset                                                     Commit changeset latency (per changeset commits)                                                Measured     Microseconds                                                                                                TOTAL_CHANGESETS_COMMITTED   WEKA        MANAGEMENT     True            False
config    Config          CLIENT_NODE_REJOIN_TIME                                     The number of clients rejoin attempts per completion time range                                                 Client node rejoin time (total)                                                                 Histogram    Number of rejoins                                                                                                                        WEKA        MANAGEMENT     True            True       mSecs
config    Config          CONFIG_PROPAGATION_LATENCY                                  The latencies of propagation of a configuration generation                                                      Config Propagation latency (total)                                                              Histogram    Generation                                                                                                                               WEKA        MANAGEMENT     True            True       Milliseconds
config    Config          FetchLocalStateChangesCallType_INTERNAL_CONTINUE            Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                         Number of RPC calls to fetch local-state LRU changes per INTERNAL & CONTINUE (total)            Absolute     RPC Calls                                              fetchLocalStateChangesCallType, overlayTreeNodeType                               WEKA        MANAGEMENT     True            False
config    Config          FetchLocalStateChangesCallType_INTERNAL_RESTART_FROM_TAIL   Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                         Number of RPC calls to fetch local-state LRU changes per INTERNAL & RESTART_FROM_TAIL (total)   Absolute     RPC Calls                                              fetchLocalStateChangesCallType, overlayTreeNodeType                               WEKA        MANAGEMENT     True            False
config    Config          FetchLocalStateChangesCallType_INTERNAL_RETRY_LAST_REQUEST  Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                         Number of RPC calls to fetch local-state LRU changes per INTERNAL & RETRY_LAST_REQUEST (total)  Absolute     RPC Calls                                              fetchLocalStateChangesCallType, overlayTreeNodeType                               WEKA        MANAGEMENT     True            False
config    Config          FetchLocalStateChangesCallType_LEAF_CONTINUE                Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                         Number of RPC calls to fetch local-state LRU changes per LEAF & CONTINUE (total)                Absolute     RPC Calls                                              fetchLocalStateChangesCallType, overlayTreeNodeType                               WEKA        MANAGEMENT     True            False
config    Config          FetchLocalStateChangesCallType_LEAF_RESTART_FROM_TAIL       Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                         Number of RPC calls to fetch local-state LRU changes per LEAF & RESTART_FROM_TAIL (total)       Absolute     RPC Calls                                              fetchLocalStateChangesCallType, overlayTreeNodeType                               WEKA        MANAGEMENT     True            False
config    Config          FetchLocalStateChangesCallType_LEAF_RETRY_LAST_REQUEST      Number of RPC calls to fetch local-state LRU changes, per overlay node type & call type                         Number of RPC calls to fetch local-state LRU changes per LEAF & RETRY_LAST_REQUEST (total)      Absolute     RPC Calls                                              fetchLocalStateChangesCallType, overlayTreeNodeType                               WEKA        MANAGEMENT     True            False
config    Config          GENERATION_COMMIT_LATENCY                                   The average latency of committing a configuration generation to the RAFT log                                    Commit changeset latency (per changeset commits)                                                Measured     Microseconds                                                                                                TOTAL_GENERATIONS_COMMITTED  WEKA        MANAGEMENT     True            False
config    Config          HEARTBEAT_PROCESSING_TIME                                   The number of non-leader heartbeats per processing time range                                                   Non-leader heartbeat processing time (total)                                                    Histogram    Number of heartbeats                                                                                                                     WEKA        MANAGEMENT     True            True       secs
config    Config          HEARTBEAT_PROCESSING_TIME_OLD                               The number of non-leader heartbeats per processing time range (OLD)                                             Non-leader heartbeat processing time (total)                                                    Histogram    Number of heartbeats                                                                                                                     WEKA        MANAGEMENT     True            True       secs
config    Config          HISTOGRAM_LEADER_ITERATION_WAIT_DURATION_CONFIG_ALIGNMENT   Wait duration of leader iteration for all nodes to align on latest configuration generation                     Leader Iteration Wait for Configuration Propagation (total)                                     Histogram    Leader iteration wait time                                                                                                               WEKA        MANAGEMENT     True            True       mSecs
config    Config          LEADER_HEARTBEAT_PROCESSING_TIME                            The number of leader heartbeats per processing time range                                                       Leader heartbeat processing time (total)                                                        Histogram    Number of heartbeats                                                                                                                     WEKA        MANAGEMENT     True            True       secs
config    Config          LEADER_HEARTBEAT_PROCESSING_TIME_OLD                        The number of leader heartbeats per processing time range (OLD)                                                 Leader heartbeat processing time (total)                                                        Histogram    Number of heartbeats                                                                                                                     WEKA        MANAGEMENT     True            True       secs
config    Config          LOCALSTATE_AGGREGATION_LATENCY                              This period between clockSkewReportTime table's update by a management process and the time the leader sees it  LocalState aggregation latency (total)                                                          Histogram    Time is taken to aggregate LocalState in milliseconds                                                                                    WEKA        MANAGEMENT     True            True       msecs
config    Config          LOCAL_STATS_FETCH_GENERATION_LAGGING                        The number of local-state generations that the parent fetch request still needs to read                         local-state generation dirty LRU length (average)                                               Accumulated  local-state generations                                overlayParentIndex                                                                WEKA        MANAGEMENT     False           False
config    Config          OVERLAY_FULL_SHIFTS                                         The number of entire overlay shifts                                                                             Full overlay shifts (total)                                                                     Absolute     Changes                                                                                                                                  WEKA        MANAGEMENT     True            False
config    Config          OVERLAY_INCREMENTAL_SHIFTS                                  The number of incremental overlay shifts                                                                        Incremental overlay shifts (total)                                                              Absolute     Changes                                                                                                                                  WEKA        MANAGEMENT     True            False
config    Config          OVERLAY_TRACKER_INCREMENTALS                                The number of incremental OverlayTracker applications                                                           Incremental OverlayTracker applications (total)                                                 Absolute     Changes                                                                                                                                  WEKA        MANAGEMENT     True            False
config    Config          OVERLAY_TRACKER_RESYNCS                                     The number of OverlayTracker full-resyncs                                                                       OverlayTracker resyncs (total)                                                                  Absolute     Changes                                                                                                                                  WEKA        MANAGEMENT     True            False
config    Config          TOTAL_CHANGESETS_COMMITTED                                  The total number of committed changesets                                                                        Changeset commits (total)                                                                       Absolute     Change Sets                                                                                                                              WEKA        MANAGEMENT     True            False
config    Config          TOTAL_COMMITTED_CHANGES                                     The total number of committed configuration change sets                                                         Changes (total)                                                                                 Absolute     Changes                                                                                                                                  WEKA        MANAGEMENT     True            False
config    Config          TOTAL_CONFIG_SNAPSHOT_PULLS                                 The total number of config snapshot pulls                                                                       Config snapshot pulls (total)                                                                   Absolute     Pulls                                                                                                                                    WEKA        MANAGEMENT     True            False
config    Config          TOTAL_GENERATIONS_COMMITTED                                 The number of committed generations                                                                             Config generation commits (total)                                                               Absolute     Generations                                                                                                                              WEKA        MANAGEMENT     True            False
raft      RAFT            Configuration_LEADER_CHANGES                                Changes of leader                                                                                               Configuration Leader Changes (total)                                                            Absolute     Changes                                                councilType                                                                       WEKA        ANY            True            False
raft      RAFT            Configuration_REQUESTS_COMPLETED                            Requests to leader completed successfully                                                                       Configuration Requests Completed (total)                                                        Absolute     Requests                                               councilType                                                                       WEKA        ANY            True            False
```

## View statistics in real-time

**Command:** `weka stats realtime`

Use the following command line to obtain the current performance-related statistics of the processes in a one-second interval:\
`weka stats realtime [<process-ids>] [--raw-units] [--UTC]`

**Parameters**

<table><thead><tr><th width="217">Name</th><th width="325">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>process-ids</code></td><td>Only show real-time stats of the specified processes in a comma-separated list.</td><td></td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units such as bytes and seconds.</td><td>Readable format.<br>Examples: 1KiB 234MiB 2GiB.</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC.</td><td>Server's local time.</td></tr></tbody></table>

## **View statistics over time**

**Command:** `weka stats`

The collected statistics can help analyze system performance and determine the source of issues that may occur during WEKA system runs. Statistics are divided according to categories. When selecting a category, a list of the possible statistics is displayed, from which you can select the specific statistics.

With the exception of real-time statistics, WEKA averages all statistics over one-minute intervals. Therefore, the total value or other aggregates relate to a specific minute.

Use the following command line to manage filters and read statistics:

`weka stats [--start-time <start-time>] [--end-time <end-time>] [--interval interval] [--resolution-secs resolution-secs] [--category category][--stat stat] [--process-ids process-ids] [--param param] [--accumulated] [--per-process] [--no-zeros] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

<table><thead><tr><th width="202">Name</th><th width="369">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>start-time</code></td><td>Start time of the reported period.<br>Format examples: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>-1m</td></tr><tr><td><code>end-time</code></td><td>End time of the reported period.<br>Format examples: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>Current time</td></tr><tr><td><code>interval</code>*</td><td>Period of time to be reported.<br>Valid interval in seconds (positive integer).</td><td></td></tr><tr><td><code>resolution-secs</code></td><td>Length of each interval in the reported period.<br>The value must be a multiple of 60 seconds</td><td>60</td></tr><tr><td><code>category</code></td><td>A specific category for retrieving statistics.<br>Valid categories: CPU, Object Store, Operations, Operations (NFS), Operations (Driver), SSD.</td><td>All</td></tr><tr><td><code>stat</code></td><td>The names of the statistics to retrieve.</td><td>All</td></tr><tr><td><code>process-ids</code></td><td>A valid process ID.</td><td>All</td></tr><tr><td><code>param</code></td><td>For parameterized statistics, it retrieves only the instantiations where the specified parameter has the specified value.<br>Format: <code>key:val</code><br>Example for multiple values:<br>'<code>--param method:putBlocks --param method:initBlock</code>'</td><td></td></tr><tr><td><code>accumulated</code></td><td>Display accumulated statistics instead of rate statistics.</td><td>False</td></tr><tr><td><code>per-process</code></td><td>Do not aggregate statistics across processes.</td><td>False</td></tr><tr><td><code>no-zeros</code></td><td>Filters out results where the value is 0.</td><td>False</td></tr><tr><td><code>show-internal</code></td><td>Display internal statistics.</td><td>False</td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units, such as bytes and seconds.</td><td>Readable format.<br>(for example: 1KiB 234MiB 2GiB)</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC.</td><td>Server's local time.</td></tr></tbody></table>

## Set statistics retention

**Command:** `weka stats retention set`

Use the following command line to set the statistics retention period.\
`weka stats retention set <--days days> [--dry-run]`

**Parameters**

<table><thead><tr><th width="207">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>days</code>*</td><td>Number of days to keep the statistics.<br>Ensure sufficient free disk space per server and the specified number of days.</td></tr><tr><td><code>dry-run</code></td><td>Only tests the required capacity per the retention period.</td></tr></tbody></table>

Use `weka stats retention status` to view the current retention and `weka stats retention restore-default` to restore the default retention settings.
