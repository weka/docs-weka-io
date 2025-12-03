---
description: >-
  Use the WEKA Operator for WEKA CSI in Kubernetes. If using stateless clients,
  follow practices to reserve CPU, prevent contention, and ensure stable IO.
---

# Best practices for WEKA stateless client and Kubernetes

WEKA recommends using the WEKA Operator (WekaClient Custom Resource) to run clients for WEKA CSI. This is the go-forward strategy for all Kubernetes-based workloads.

While stateless clients are supported, they are not recommended. Contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md) to develop a migration plan from stateless clients to the WEKA Operator.

If you must use stateless clients, follow these high-priority practices to reserve CPU resources for the WEKA client and the system. This prevents resource contention from Kubernetes pods, ensuring stable IO performance and correct resource accounting.

#### Reserve system and WEKA client CPUs

This is a high-priority setting. Explicitly reserving physical cores in the `kubelet` configuration ensures Kubernetes calculates the "node allocatable" capacity correctly and prevents pods from using CPUs dedicated to the WEKA client and the OS.

Without this reservation, you may experience:

* **WEKA IO impact:** Pod workloads can consume CPU time needed by the WEKA client, degrading IO performance.
* **OS instability:** Pods can impact critical OS processes, including WEKA management functions.
* **Incorrect K8s accounting:** The "node allocatable" capacity reported by Kubernetes will be larger than the actual CPU resources available to pods (as defined by cgroups). This can result in lower-than-expected performance for pod workloads.

{% hint style="info" %}
To protect these reserved cores from _all_ pod QoS classes (including `Burstable` and `Best Effort`), you must also use Kubernetes v1.32+ and enable the `strict-cpu-reservation=true` option, which is detailed in the next section (Enable strict CPU reservation).
{% endhint %}

**Procedure**

1. Open the `kubelet.conf` file on the worker node.
2. Set the `cpuManagerPolicy` to `static`.
3. Set `reservedSystemCPUs` to reserve cores for the OS (at least one physical core) and the WEKA client.
4. On hyperthreaded systems, you must also reserve the sibling cores. On larger or busier systems, allocate additional cores for the OS.

**Example**

The following example reserves cores 0 and 24 for the OS. It also reserves cores 20-23 and their sibling cores 44-47 for the WEKA client:

```
cpuManagerPolicy: static
reservedSystemCPUs: 0,20-24,44-47
```

#### Enable strict CPU reservation

This is a high-priority setting, requiring Kubernetes v1.32 or later. By default, the `reservedSystemCPUs` setting only protects cores from `Guaranteed` pods. Enabling `strict-cpu-reservation` extends this protection to `Burstable` and `Best Effort` pods, preventing them from using reserved system and WEKA client CPUs.

Without this option, `Burstable` and `Best Effort` pods can be scheduled on WEKA and system CPUs, which can lower IO throughput and create inconsistent performance.

**Procedure**

In `kubelet.conf`, add the following configuration:

```
featureGates:
  CPUManagerPolicyOptions: "true"
  CPUManagerPolicyAlphaOptions: "true"
cpuManagerPolicyOptions:
  strict-cpu-reservation: "true"
```

**Related information**

[Kubernetes v1.32 Adds A New CPU Manager Static Policy Option For Strict CPU Reservation](https://kubernetes.io/blog/2024/12/16/cpumanager-strict-cpu-reservation/#understanding-the-feature)

#### Disable WEKA agent cgroup isolation

This is a high-priority setting. You must configure the WEKA agent to avoid modifying Kubernetes cgroup settings. This allows Kubernetes to manage its own cgroups without interference.

**Procedure**

1. Open the `/etc/wekaio/service.conf` file.
2. Set the `isolate_cpusets` parameter to `FALSE`.
3. Restart the WEKA agent service to apply the change.

#### Use cgroups v2

This is a medium-priority setting. WEKA recommends using cgroups v2. It correctly restricts the pod `cpuset` to exclude the WEKA IO cores, even if you are not using strict CPU reservation policies. This also future-proofs your configuration, as Kubernetes is deprecating cgroups v1.

**Procedure**

To use cgroups v2, modify the OS and container runtime configuration. Kubernetes automatically uses cgroups v2 when it is enabled on the system.

#### Ensure correct service boot order

The WEKA client must start _before_ the `kubelet` process. This ensures Kubernetes establishes the correct cgroups when it initializes.

This is a low-priority setting if you follow the other best practices (especially `strict-cpu-reservation`). However, it becomes high-priority if you are not using strict CPU reservation, as Kubernetes might otherwise add WEKA's cores to the list of cores allowed for pods.

**Procedure**

Modify the system's boot sequence (for example, using systemd) to make the `kubelet` process dependent on the WEKA client service.
