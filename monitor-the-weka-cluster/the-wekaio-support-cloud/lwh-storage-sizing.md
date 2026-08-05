---
description: >-
  Size /opt/wekahome/data for Local WEKA Home deployments on K3s. Capacity
  depends on monitored WEKA servers and statistics retention. This storage holds
  time-series statistics, events, and queues.
---

# LWH storage sizing

## Storage sizing summary

* Provision approximately 1 GiB per monitored WEKA server per month of statistics retention.
* Add 40 GiB for events, queues, and databases.
* Size for the retention window plus one month. VictoriaMetrics removes complete monthly partitions.

## Storage requirements by server count

Use these capacities for the default 30-day statistics retention. Values include VictoriaMetrics, Postgres, and queue storage.

| Monitored WEKA servers | /opt/wekahome/data |
| ---------------------- | ------------------ |
| 100                    | \~140 GiB          |
| 250                    | \~290 GiB          |
| 500                    | \~540 GiB          |
| 1,000                  | \~1 TiB            |
| 2,000                  | \~2 TiB            |
| 5,000                  | \~5 TiB            |
| 10,000                 | \~10 TiB           |
| 20,000                 | \~20 TiB           |

For a different retention, multiply the per-server capacity by `(retention_days + 31) / 61`.

This is approximately 0.7 for 14 days and 2 for 90 days. For 3,000 servers at 45-day retention, allocate approximately 3.8 TiB.

## Storage consumers

| Consumer                   | Scales with                          | Share             |
| -------------------------- | ------------------------------------ | ----------------- |
| VictoriaMetrics statistics | Servers × retention                  | Approximately 99% |
| Events DB (Postgres)       | event activity, bounded by retention | small, bounded    |
| Main and support databases | Fixed                                | Negligible        |
| FSQ and NATS queues        | Transient backlog                    | Tens of GiB       |

VictoriaMetrics statistics consume most of the storage.

## Statistics storage calculation

**Active series**: A unique time-series measurement stored by VictoriaMetrics.

VictoriaMetrics capacity depends on active series, samples, and sample size. LWH uses approximately 13 MiB per monitored server each day. This estimate uses 60-second raw resolution and no downsampling.

Use this formula. It includes monthly-partition peak usage and VictoriaMetrics merge headroom:

```
stats_disk ≈ 13 MiB × servers × (retention_days + 31) × 1.3
```

This simplifies to approximately 1 GiB per server per month of retention.

The estimate is validated against these environments:

* **Production fleet**: 124 TiB across six `vmstorage` shards for 336,000 servers. Usage was approximately 12.5 MiB per server daily.
* **Cluster simulator**: 6,400 servers used 24.5 GB in 6.5 hours. Usage was approximately 13.4 MiB per server daily.

### Storage requirements by retention period

Values include approximately 40 GiB for events, queues, and databases.

| Monitored servers | 14 days    | 30 days (default) | 90 days   |
| ----------------- | ---------- | ----------------- | --------- |
| 100               | \~110 GiB  | \~140 GiB         | \~240 GiB |
| 500               | \~410 GiB  | \~540 GiB         | \~1.1 TiB |
| 1,000             | \~780 GiB  | \~1.05 TiB        | \~2 TiB   |
| 5,000             | \~3.7 TiB  | \~5 TiB           | \~9.8 TiB |
| 20,000            | \~14.5 TiB | \~20 TiB          | \~39 TiB  |

### Storage requirements by resource preset

Resource presets use the expected monitored server count:

<table><thead><tr><th width="152.01171875">Preset</th><th width="192.75">wekaNodesMonitored</th><th>/opt/wekahome/data @ 30-day retention</th></tr></thead><tbody><tr><td><code>small</code></td><td>≤ 1,000</td><td>up to ~1 TiB</td></tr><tr><td><code>medium</code></td><td>1,000 – 5,000</td><td>~1 – 5 TiB</td></tr><tr><td><code>large</code></td><td>5,000 – 10,000</td><td>~5 – 10 TiB</td></tr><tr><td><code>xlarge</code></td><td>10,000+</td><td>10 TiB+</td></tr></tbody></table>

## VictoriaMetrics partition behavior

VictoriaMetrics stores data in monthly partitions. It removes a partition only after all data exceeds retention. A 30-day retention period can therefore use one or two months of storage. Peak use occurs immediately after a new month begins.

`wekaNodesMonitored` selects a resource preset. It does not change retention. Set retention with `retentionDays.stats`. The default is 30 days.

## Events database capacity

The events database uses garbage collection. Its size eventually stabilizes:

* **Raw events**: Deleted after `retentionDays.events`. The default is 30 days.
* **Hourly aggregates**: Retained for 365 days. The database stabilizes after approximately one year.

Typical deployments use less than the default 20 GiB events volume. Do not disable events retention. Without a retention period, events storage grows without limit.

## Validate capacity after deployment

Run `homecli local diagnose` to view VictoriaMetrics `data_size` and monitored server count. Calculate the observed daily rate:

```
bytes_per_node_per_day = vmstorage_used ÷ node_count ÷ days_of_data_on_disk
```

Measure after several weeks. Adjust capacity using the observed rate. `TimeToFull` provides early warning before storage fills.

## Sizing considerations

* **Role mix**: I/O-intensive deployments use approximately 13 MiB per server daily. Client-heavy deployments use less. Management-heavy deployments use more.
* **Retention**: LWH stores full-resolution statistics without downsampling. Doubling retention approximately doubles statistics storage.
* **Measured usage**: Use `homecli local diagnose` to refine estimates for your deployment.
