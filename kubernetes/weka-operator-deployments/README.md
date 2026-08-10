---
description: >-
  Deploy WEKA on Kubernetes with the WEKA Operator. Choose the deployment model
  that fits your environment, verify version support, and continue to the right
  workflow.
---

# WEKA Operator deployments

## WEKA Operator capabilities

The WEKA Operator automates the deployment and lifecycle management of WEKA storage on Kubernetes. It manages the full stack through Kubernetes-native custom resources, removing the need for manual coordination across cluster components.

The Operator handles the following:

* **Resource provisioning:** Deploys and manages WekaCluster and WekaClient custom resources as Kubernetes-native objects.
* **Driver lifecycle:** Distributes pre-built drivers and supports local driver build workflows for custom or restricted environments.
* **CSI management:** Embeds and manages the WEKA CSI Plugin lifecycle as part of the WekaClient resource.
* **Observability and monitoring:** Exposes WEKA health and performance metrics to Kubernetes monitoring stacks.
* **Protocol gateways:** Manages protocol containers, including S3, NFS, SMB, and audit, from the WekaCluster resource.
* **Drive sharing and composable backends:** Supports drive sharing configuration, drive type ratios, and capacity-based backend layouts.
* **Upgrade management:** Supports rolling, manual, and all-at-once upgrade policies for client pods.
* **Cluster maintenance controls:** Supports CSI migration, cluster pause and resume, and cluster deletion cancellation.

{% hint style="info" %}
The WEKA Operator is updated frequently. For the latest feature additions and changes, always refer to the release notes for your target Operator version before deployment or upgrade. For example: [WEKA Operator 1.14.0 release notes](https://get.weka.io/ui/operator/1.14.0/notes).
{% endhint %}

## Deployment models

Choose the model that matches your infrastructure and operating boundary.

**Full deployment on Kubernetes:** Run WEKA backend and client processes in Kubernetes. Use this model when Kubernetes hosts both the WEKA data plane and application workloads.

**Client-only deployment:** Run WEKA clients in Kubernetes and connect them to a WEKA cluster running outside Kubernetes. Use this model when the storage cluster already runs on dedicated servers.

**Managed Kubernetes services:** Run supported WEKA components on Amazon EKS, Oracle OKE, Google GKE, or Azure AKS. Platform support and deployment limits vary by provider and instance type.

## Version compatibility

Verify minimum version requirements before deployment or upgrade.

<table><thead><tr><th width="205">Feature</th><th width="140">Operator (min. version)</th><th width="139">WEKA Cluster (min. version)</th><th>Notes</th></tr></thead><tbody><tr><td>S3</td><td>1.7</td><td>4.4</td><td>Supported.</td></tr><tr><td>NFS</td><td>1.10</td><td>5.1.0</td><td>Supported.</td></tr><tr><td>Audit</td><td>1.10</td><td>5.1.0</td><td>Supported.</td></tr><tr><td>SMB-W</td><td>1.11</td><td>5.1.20</td><td>Supported.</td></tr><tr><td>Data Services</td><td>1.13</td><td>5.1.20</td><td>Supported for <a data-footnote-ref href="#user-content-fn-1">quota coloring</a>.<br>Not supported for Data Catalog.</td></tr><tr><td>ssdproxy</td><td>1.12</td><td>5.1.30</td><td>Supported.<br>Share NVMe drives across multiple clusters.</td></tr><tr><td>AlloyFlash</td><td>1.14</td><td>5.1.30</td><td>Supported.<br>Enable mixed TLC and QLC drive deployments.</td></tr><tr><td>Cluster capacity sizing</td><td>1.14.2</td><td>5.1.0</td><td>Supported.<br>Size the cluster by target usable capacity with <code>dynamicTemplate.clusterCapacity</code>.</td></tr></tbody></table>

## How to use this guide

Use this guide to choose the right starting point for deployment and operations tasks.

**Concept topics and references:**

[WEKA Operator architecture overview](weka-operator-architecture-overview.md)

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)

[WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md)

Kubernetes deployment types

**Start a new deployment:**

| Task                                                                                    | Topic                                                                                                          |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Generate deployment artifacts with a guided wizard (recommended for common deployments) | [Cloud Deployment Manager  Kubernetes deployment types](cloud-deployment-manager-kubernetes-deployment-types/) |
| Minimal working cluster in five steps                                                   | [Quick installation](quick-installation.md)                                                                    |
| Full deployment workflow end-to-end                                                     | [WEKA Operator full deployment workflow](weka-operator-full-deployment-workflow.md)                            |
| Deploy on a cloud-managed Kubernetes service                                            | [Deploy WEKA on cloud-managed Kubernetes services](deploy-the-weka-client-on-amazon-eks.md)                    |

**Go to a specific task:** Use these topics for focused configuration and migration work.

<table data-search="false"><thead><tr><th>Task</th><th>Topic</th></tr></thead><tbody><tr><td>Manage drivers</td><td><a href="weka-operator-driver-management.md">WEKA Operator driver management</a></td></tr><tr><td>Configure networking</td><td><a href="networking-with-the-weka-operator.md">Networking with the WEKA Operator</a></td></tr><tr><td>Configure encryption at rest</td><td><a href="encryption-with-the-weka-operator.md">Encryption with the WEKA Operator</a></td></tr><tr><td>Configure protocols</td><td><a href="set-up-protocols-on-k8s-with-weka-operator.md">Set up protocols on K8s with WEKA Operator</a></td></tr><tr><td>Configure audit log export</td><td><a href="set-up-audit-logs-on-k8s-with-weka-operator.md">Set up audit logs on K8s with WEKA Operator</a></td></tr><tr><td>Manage credentials</td><td><a href="weka-operator-secrets-management.md">Weka Operator secrets management</a></td></tr><tr><td>Migrate from standalone CSI</td><td><a href="migrate-standalone-csi-to-weka-operator-embedded.md">Migrate standalone CSI to WEKA Operator-embedded</a></td></tr></tbody></table>

**Operate and maintain after deployment:** Use these topics to upgrade, optimize, and troubleshoot the environment.

| Task                                     | Topic                                                                                                   |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Monitor, scale, and maintain the cluster | [Monitor, scale, and maintain the cluster](../weka-operator-day-2-operations/)                          |
| Plan a WEKA version upgrade              | [WEKA Operator upgrade and migration](weka-operator-upgrade-and-migration.md)                           |
| Upgrade protocol containers              | [Upgrade protocol containers on the WEKA Operator](upgrade-protocol-containers-on-the-weka-operator.md) |
| Production guidance                      | [WEKA Operator best practices](weka-operator-best-practices.md)                                         |
| Diagnose issues                          | [Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md)                     |

[^1]: **What is quota coloring?**

    During the procedure of setting or unsetting a directory quota, the Data Services container creates a background task referred to as `QUOTA_COLORING`. This task scans the entire directory tree and assigns the quota ID to each file and directory within the tree.
