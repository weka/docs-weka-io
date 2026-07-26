---
description: Export WEKA cluster metrics from Observe to Prometheus.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/monitor-the-weka-cluster/the-wekaio-support-cloud/export-cluster-metrics-to-prometheus
---

# Export cluster metrics from Observe to Prometheus

## Export cluster metrics from Observe to Prometheus

Observe exposes WEKA cluster metrics directly as Prometheus scrape endpoints. Configure your Prometheus server to scrape these endpoints and get metrics delivered in standard Prometheus format. For access details, see [NeuralMesh Observe overview](./#connectivity-and-access).

Metrics are organized across four endpoints, each covering a distinct area of cluster telemetry. This keeps the cardinality of each individual scrape manageable, rather than one large payload that grows with every drive, client, and filesystem added to the cluster.

Use the exporter to build alerts on cluster health, track I/O performance and latency, monitor drive health, or visualize metrics in Grafana through Prometheus.

### Generate an authentication token

Access to the scrape endpoints is protected by token-based authentication. Each request to an endpoint must include a valid token in the Authorization header. Unauthenticated requests are rejected.

Each cluster has one active token. The token authenticates all four scrape endpoints.

**Before you begin**

* Ensure you have access to the Observe dashboard and the cluster you want to monitor.
* Have a secure password manager or secrets vault ready to store the token. The token is shown only once. If you lose it, you must generate a new one.

**Procedure**

1. In Observe, go to the cluster settings and locate the Prometheus Exporter section.
2. Select **Generate New Key**. A dialog opens displaying:
   * The **Authentication Token**. Copy and store it securely now.
   * The URLs for all four scrape endpoints, ready to copy.
3. Copy the token and all endpoint URLs you intend to use.
4. Select **I've Saved the Token** to close the dialog.

<figure><img src="../../.gitbook/assets/Observe_generate_token.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Each cluster supports one active token. Generating a new token immediately invalidates the previous one. Update your Prometheus configuration with the new token as soon as possible to avoid a gap in metric collection.
{% endhint %}

### Scrape endpoints

The exporter exposes metrics across four endpoints. Each endpoint covers a distinct area of cluster telemetry.

| Endpoint                    | Coverage                                   |
| --------------------------- | ------------------------------------------ |
| Base URL                    | Cluster health, capacity, and S3 metrics   |
| Base URL + `/clients`       | Per-client and per-filesystem I/O metrics  |
| Base URL + `/drives`        | Per-drive health, I/O, and network metrics |
| Base URL + `/quota_domains` | Per-quota-domain I/O metrics               |

Each endpoint URL is available in the cluster settings under the Prometheus Exporter section, and is also shown in the token dialog when a new token is generated. When configuring Prometheus, use the hostname portion of the URL as the target and the path portion (everything after the hostname) as the `metrics_path` value.

### Configure Prometheus

Configure Prometheus to scrape metrics from Observe by adding one scrape job per endpoint. Each job authenticates using a Bearer token and targets the Observe hostname.

**Before you begin**

Obtain the following from the Observe token dialog:

* The authentication token
* The full URL for each endpoint you want to scrape (hostname and path)

**Procedure**

1. Open your Prometheus configuration file.
2. Under `scrape_configs`, add one job block for each endpoint you want to collect.
3. In each job, set the following values:
   * `metrics_path`: the path portion of the endpoint URL copied from the token dialog
   * `targets`: the hostname portion of the URL from the cluster settings
   * `credentials`: your authentication token
4. Save the configuration file and reload Prometheus.

**Example: scrape all four endpoints**

{% code title="prometheus.yaml" %}
```yaml
...
scrape_configs:

  - job_name: weka_cluster
    metrics_path: <base-url>
    scheme: https
    authorization:
      credentials: <your-token>
    static_configs:
      - targets: ['<observe-host>']

  - job_name: weka_clients
    metrics_path: <base-url>/clients
    scheme: https
    authorization:
      credentials: <your-token>
    static_configs:
      - targets: ['<observe-host>']

  - job_name: weka_drives
    metrics_path: <base-url>/drives
    scheme: https
    authorization:
      credentials: <your-token>
    static_configs:
      - targets: ['<observe-host>']

  - job_name: weka_quota_domains
    metrics_path: <base-url>/quota_domains
    scheme: https
    authorization:
      credentials: <your-token>
    static_configs:
      - targets: ['<observe-host>']
```
{% endcode %}

Replace the placeholders with your values:

<table><thead><tr><th width="183">Placeholder</th><th>Value</th></tr></thead><tbody><tr><td><code>&#x3C;observe-host></code></td><td>Hostname from the cluster settings URL</td></tr><tr><td><code>&#x3C;base-url></code></td><td>Path portion of the endpoint URL from the token dialog</td></tr><tr><td><code>&#x3C;your-token></code></td><td>Authentication token from the token dialog</td></tr></tbody></table>

### Selective metric collection

By default, every scrape returns the full metric set for that endpoint. If you want to limit what is collected, for example, to reduce Prometheus memory usage or to configure separate jobs for alerting and dashboards, you can use the `collect[]` and `exclude[]` parameters.

**How it works**

* `collect[]`: allowlist. Specifies which metrics to return. Accepts category names, collection names, or individual metric names, in any combination. Omitting `collect[]` returns all metrics.
* `exclude[]`: denylist. Removes specific metrics from the selected set. Applied after `collect[]`.

**Categories**

A category is a short name that maps to all metrics sharing a common name prefix. For example, the `s3` category returns all metrics whose names start with `weka_s3_`, and the `drive` category returns all metrics starting with `weka_drive_`.

Category membership is self-evident from the metric names themselves, no explicit list is needed. When the exporter is updated and new metrics are added under an existing prefix, they are automatically included in that category without any configuration change.

**Collections**

Some categories, particularly `cluster`, cover a large number of metrics spanning several distinct use cases. Collections break a category into smaller, named subsets, each focused on a specific purpose such as alerting, performance dashboards, or capacity management.

This reduces the number of metrics you need to explicitly exclude when you only care about a subset: instead of collecting the full category and listing many individual `exclude[]` entries, you can specify only the collection you need. For example, rather than collecting the full `cluster` category and excluding everything performance-related, you can collect `cluster_health` directly and get only the health and alerting metrics.

**Metric reference**

The complete list of available metrics, categories, and collections for your cluster version is available as a downloadable YAML file from the Prometheus Exporter panel on the Settings page.

**Examples**

Alerting only: minimal metric set for health monitoring:

```yaml
params:
  collect[]: [cluster_health]
```

Full dashboard: health, performance, S3, and drives:

```yaml
params:
  collect[]: [cluster_health, cluster_performance, s3, drive]
```

Drop a specific high-cardinality metric from a collection:

```yaml
params:
  collect[]: [cluster_health, cluster_performance]
  exclude[]: [weka_cpu_utilization_percent]
```

Single metric only:

```yaml
params:
  collect[]: [weka_cluster_status]
```

A complete job definition using selective collection looks like this:

```yaml
- job_name: weka_alerting
  scheme: https
  authorization:
    credentials: <your-token>
  metrics_path: <base-url>
  params:
    collect[]: [cluster_health]
  static_configs:
    - targets: ['<observe-host>']
```

You can define multiple jobs targeting the same endpoint with different `collect[]` parameters, for example, one job for alerting and one for dashboards. All jobs can coexist in the same `prometheus.yaml`.

### Grafana dashboards

Grafana dashboards are available from the Grafana Dashboards section of the Observe **Settings** page. Each dashboard provides a default panel set and imports directly into your Grafana instance.
