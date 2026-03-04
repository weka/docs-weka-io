---
description: >-
  Size and tune LWH stats components for high throughput by configuring resource
  allocations based on stats. This prevents stats stream saturation, processing
  delays, and NATS backpressure.
---

# LWH stats: sizing and performance optimization

## Stats workload principles

Statistical data volume in large clusters can exceed default configurations. When stats workers fail to process incoming data quickly, the stats stream reaches its 3 GiB capacity, causing NATS to reject new messages.

Effective sizing requires a clear understanding of the primary components:

* **`api.stats`:** Manages the ingestion and exposure of statistical data.
* **`workers.stats`:** Performs heavy processing of statistics. This component is typically the primary bottleneck in large environments.
* **`workers.forwarding`:** Handles the transmission of processed data. These processes require fewer CPU resources but still scale with the cluster size.

Load scales linearly based on the number of unique (`host_id`, `node_id`) metric pairs.

### `workers.stats` capacity references

Use these values to determine the necessary CPU resources for a cluster.

<table><thead><tr><th width="191.72723388671875">Metric</th><th width="279.272705078125">Theoretical maximum</th><th>Recommended safe value</th></tr></thead><tbody><tr><td>Pairs per 1 CPU core</td><td>750</td><td>550</td></tr><tr><td>Target utilization</td><td>100%</td><td>70%</td></tr></tbody></table>

### **Sizing by cluster scale**

<table><thead><tr><th width="134.27276611328125">Cluster size</th><th width="167.6363525390625">Unique pairs</th><th width="191.181884765625">Estimated CPU</th><th>Recommended number of pods</th></tr></thead><tbody><tr><td>Small</td><td>Up to 1,500</td><td>2 cores</td><td>1</td></tr><tr><td>Medium</td><td>1,500 to 5,000</td><td>2 to 8 cores</td><td>1 to 2</td></tr><tr><td>Large</td><td>5,000 to 10,000</td><td>8 to 14 cores</td><td>2+</td></tr></tbody></table>

### Calculate required replicas

Determine the required number of pod replicas in a specific environment using the following formulas.

**Prerequisites**

* Identify the total number of unique (`host_id`, `node_id`) pairs in the cluster.
* Define the CPU limit per pod.

**Procedure**

1. Calculate the required CPU cores.

$$
Required\_CPU = \frac{Number\_of\_pairs}{Pairs\_per\_1\_CPU\_core}
$$

2. Calculate the required replicas based on the pod CPU limit.

$$
Required\_replicas = \frac{Required\_CPU}{CPU\_limit\_per\_pod}
$$

**Example**

For a cluster with 10,000 unique pairs and a limit of 16 CPU cores per pod:

1. Required CPU cores: 10,000 / 750 = 13.4 cores.
2. Required replicas = 13.4 / 16 =\~ 1 (maximum utilization).

To ensure safe usage at 70%, round up to 2 replicas.

## Configure resource overrides for high stats throughput

Modify the Helm configuration for either Kubernetes (K8s) or K3s to support high stats throughput by defining resource requests, limits, and autoscaling parameters.

* **K8s Helm values:** Manage performance tuning in K8s environments through a `values.yaml` file. Define overrides within the `api` and  `workers` sections to govern resources for the entire cluster. Use the Helm CLI to apply these settings and update the deployment state.
* **K3s configuration JSON:** Manage performance tuning in K3s environments, typically running on a WEKA Management Station (WMS) or a dedicated server. Define overrides within the `helmOverrides` block of the `/opt/wekahome/config/config.json` file. The `homecli local upgrade` command ingests this JSON to apply the specified CPU and memory limits to the local containers.

<details>

<summary>Example for K8s: <code>api and workers</code> sections with default values</summary>

```yaml
api:
  stats:
    replicas: 1
    resources:
      requests:
        memory: 200Mi
        cpu: 200m
      limits:
        memory: 1000Mi
        cpu: 1000m
    autoscaling:
      enabled: true
      minReplicas: 1
      maxReplicas: 10

workers:
  stats:
    enabled: true
    replicas: 1
    resources:
      requests:
        memory: 200Mi
        cpu: 1000m
      limits:
        memory: 1000Mi
        cpu: 2000m
    autoscaling:
      enabled: true
      minReplicas: 1
      maxReplicas: 300
  forwarding:
    replicas: 1
    resources:
      requests:
        memory: "200Mi"
        cpu: 100m
      limits:
        memory: "400Mi"
        cpu: 500m
    autoscaling:
      enabled: true
      minReplicas: 1
      maxReplicas: 10
```

</details>

<details>

<summary>Example for K3s: <code>helmOverrides</code> section with default values</summary>

```json
{
  "helmOverrides": {
    "api": {
      "stats": {
        "replicas": 1,
        "resources": {
          "requests": {
            "memory": "200Mi",
            "cpu": "200m"
          },
          "limits": {
            "memory": "400Mi",
            "cpu": "400m"
          }
        },
        "autoscaling": {
          "enabled": true,
          "minReplicas": 1,
          "maxReplicas": 10
        }
      }
    },
    "workers": {
      "stats": {
        "replicas": 1,
        "resources": {
          "requests": {
            "memory": "200Mi",
            "cpu": "1000m"
          },
          "limits": {
            "memory": "1000Mi",
            "cpu": "2000m"
          }
        },
        "autoscaling": {
          "enabled": true,
          "minReplicas": 2,
          "maxReplicas": 30
        }
      },
      "forwarding": {
        "replicas": 1,
        "resources": {
          "requests": {
            "memory": "200Mi",
            "cpu": "100m"
          },
          "limits": {
            "memory": "400Mi",
            "cpu": "500m"
          }
        },
        "autoscaling": {
          "enabled": true,
          "minReplicas": 1,
          "maxReplicas": 10
        }
      }
    }
  }
}
```

</details>

**Before you begin**

* Calculate the required resources based on the sizing formulas provided in the [#calculate-required-replicas](lwh-stats-sizing-and-performance-optimization.md#calculate-required-replicas "mention") section.
* Ensure the Helm CLI is configured with the correct cluster context and namespace permissions.

**Procedure**

1. Open the configuration file depending on your LWH environment:
   * **K8s:** Update the `api` and `workers` sections in the `values.yaml` file.
   * **K3s:** Update the `helmOverrides` section in the `config.json` file.
2. Define the resources and autoscaling blocks for `api.stats`, `workers.stats`, and `workers.forwarding`.
3. Set the `minReplicas` to a baseline value that ensures stability and the `maxReplicas` to a level that accounts for traffic bursts.
4. Apply the configuration:
   * **K8s:** Run the `helm upgrade` command specifying your values file.
   * **K3s:** Run `homecli local upgrade`.

**Related topics**

[#upgrade-local-weka-home](deploy-local-weka-home-v4.x-on-k8s/#upgrade-local-weka-home "mention")

[#upgrade-the-local-weka-home](local-weka-home-deployment/#upgrade-the-local-weka-home "mention")

## Operational maintenance

Monitor the environment to ensure performance remains within expected limits:

* Track stats worker CPU usage and queue depth.
* Monitor the stats stream size and message backlog.
* Increase replicas before increasing memory if CPU saturation occurs.
* Verify Horizontal Pod Autoscaler (HPA) behavior during peak load periods.
