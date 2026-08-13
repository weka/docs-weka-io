---
description: >-
  Size and tune LWH stats components for high throughput by configuring resource
  allocations based on stats. This prevents stats stream saturation, processing
  delays, and NATS backpressure.
---

# LWH stats: sizing and performance optimization

## Stats workload principles

Statistical data volume in large clusters can exceed default configurations. When stats workers cannot process incoming data quickly, the FSQ-backed stats queue grows and delays downstream processing.

Effective sizing requires a clear understanding of the primary components:

* **`api.stats`:** Ingests statistics into the queue and exposes statistics data.
* **`workers.stats`:** Consumes and processes queued statistics. This component is typically the primary bottleneck.
* **`workers.forwarding`:** Transmits processed data. It needs less CPU but scales with cluster size.

Load scales linearly based on the total process count in the cluster. This count equals the number of unique (`host_id`, `node_id`) metric pairs, where one container (`host_id`) can hold many processes (`node_id`).

### `workers.stats` capacity references

Use these values to determine the necessary CPU resources for a cluster.

| Metric | Theoretical maximum | Recommended safe value |
| --- | --- | --- |
| Processes per 1 CPU core | 750 | 550 |
| Target utilization | 100% | 70% |

### Size `workers.stats` on Kubernetes

Use the safe capacity value of 550 processes per CPU core. The replica counts assume a `workers.stats` CPU limit of 2 cores.

| Cluster size | Process count   | Required CPU   | `workers.stats` replicas | Memory limit per replica |
| ------------ | --------------- | -------------- | ------------------------ | ------------------------ |
| Small        | Up to 1,500     | Up to 3 cores  | 2                        | 1 GiB                    |
| Medium       | 1,501 to 5,000  | 3 to 10 cores  | 2 to 5                   | 1 GiB                    |
| Large        | 5,001 to 10,000 | 10 to 19 cores | 5 to 10                  | 1 GiB                    |

### Kubernetes component scaling

Use the following defaults for the FSQ-based statistics components.

| Component            | Scaling behavior                | CPU request and limit | Memory request and limit |
| -------------------- | ------------------------------- | --------------------- | ------------------------ |
| `api.stats`          | Autoscaling. 1 to 10 replicas.  | 200m / 1 core         | 200 MiB / 1 GiB          |
| `workers.stats`      | Autoscaling. 1 to 300 replicas. | 1 core / 2 cores      | 200 MiB / 1 GiB          |
| `workers.forwarding` | Autoscaling. 1 to 10 replicas.  | 100m / 500m           | 200 MiB / 400 MiB        |

### Calculate required replicas

Determine the required number of pod replicas in a specific environment using the following formulas.

**Before you begin**

* Identify the total process count in the cluster.
* Confirm that the process count equals the number of unique (`host_id`, `node_id`) metric pairs.
* Define the CPU limit per pod.

**Procedure**

1. Calculate the required CPU cores.

$$
Required\ CPU = \frac{Number\ of\ processes}{Processes\ per\ 1 \ CPU\ core}
$$

2. Calculate the required `workers.stats` replicas based on the CPU limit.

$$
Required\ replicas = \frac{Required\ CPU}{CPU\ limit\ per\ pod}
$$

**Example**

For a cluster with 10,000 processes and a limit of 16 CPU cores per pod:

1. Required CPU cores: 10,000 / 750 = 13.4 cores.
2. Required replicas = 13.4 / 16 =\~ 1 (maximum utilization).

To ensure safe usage at 70%, round up to 2 replicas.

## Configure resource overrides for high stats throughput

Modify the Helm configuration for either Kubernetes (K8s) or K3s to support high stats throughput by defining resource requests, limits, and autoscaling parameters.

* **K8s Helm values:** Manage performance tuning in K8s environments through a `values.yaml` file. Define overrides within the `api` and `workers` sections to govern resources for the entire cluster. Use the Helm CLI to apply these settings and update the deployment state.
* **K3s configuration JSON:** Manage performance tuning in K3s environments, typically running on a WEKA Management Station (WMS) or a dedicated server. Define overrides within the `helmOverrides` block of the `/opt/wekahome/config/config.json` file. The `homecli local upgrade` command ingests this JSON to apply the specified CPU and memory limits to the local containers.

<details>

<summary>Example for K8s: <code>api</code> and <code>workers</code> sections with default values</summary>

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

[https://github.com/weka/docs-weka-io/blob/5.1/monitor-the-weka-cluster/the-wekaio-support-cloud/deploy-local-weka-home-v4.x-on-k8s#upgrade-local-weka-home](https://github.com/weka/docs-weka-io/blob/5.1/monitor-the-weka-cluster/the-wekaio-support-cloud/deploy-local-weka-home-v4.x-on-k8s#upgrade-local-weka-home "mention")

[#upgrade-the-local-weka-home](deploy-local-weka-home-on-k3s/#upgrade-the-local-weka-home "mention")

## Operational maintenance

Monitor the environment to ensure performance remains within expected limits:

* Track stats worker CPU usage and queue depth.
* Monitor the stats stream size and message backlog.
* Increase replicas before increasing memory if CPU saturation occurs.
* Verify Horizontal Pod Autoscaler (HPA) behavior during peak load periods.
