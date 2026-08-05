---
description: Limit Prometheus metrics by category, collection, or metric name.
---

# Configure selective Prometheus metric collection

## Configure selective Prometheus metric collection

Limit exporter metrics with the `collect[]` and `exclude[]` parameters. Use these parameters with Prometheus jobs for Observe or Local WEKA Home.

### Metric filters

`collect[]`: An allowlist that selects categories, collections, or individual metrics. Omit it to return all endpoint metrics.

`exclude[]`: A denylist that removes metrics from the selected set. It applies after `collect[]`.

#### Categories and collections

A category groups metrics sharing a name prefix. For example, `s3` returns metrics beginning `weka_s3_`. The `drive` category returns metrics beginning `weka_drive_`.

Categories include newly added metrics with their matching prefix. No configuration changes are needed.

Collections split large categories into focused subsets. For example, `cluster_health` returns health and alerting metrics without performance metrics.

Download the YAML metric reference from the exporter panel. It lists metrics, categories, and collections for your cluster version.

### Configure metric collection

Add filter parameters to a Prometheus job.

**Before you begin**

* Configure a Prometheus scrape job for the desired exporter endpoint.
* Download the metric reference from the exporter panel.

**Procedure**

1. Select the category, collection, or metric names to collect.
2. Add them under `params.collect[]` in the scrape job.
3. Add metric names under `params.exclude[]` to remove them.
4. Reload Prometheus after saving the configuration.

#### Examples

**Alerting metrics only**

```yaml
params:
  collect[]: [cluster_health]
```

**Dashboard metrics**

```yaml
params:
  collect[]: [cluster_health, cluster_performance, s3, drive]
```

**Exclude a high-cardinality metric**

```yaml
params:
  collect[]: [cluster_health, cluster_performance]
  exclude[]: [weka_cpu_utilization_percent]
```

**Collect one metric**

```yaml
params:
  collect[]: [weka_cluster_status]
```

**Complete alerting job**

```yaml
- job_name: weka_alerting
  scheme: https
  authorization:
    credentials: <your-token>
  metrics_path: <base-url>
  params:
    collect[]: [cluster_health]
  static_configs:
    - targets: ['<exporter-host>']
```

You can define several jobs for one endpoint. Use separate `collect[]` values for alerting and dashboards.
