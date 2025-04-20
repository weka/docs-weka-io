---
description: >-
  Overview of WEKA's container-based architecture, where interconnected
  processes within server-hosted containers provide scalable and resilient
  storage services in a cluster.
---

# WEKA containers architecture overview

## Cluster architecture basics

In the WEKA system, servers operate as members of a cluster, with each server hosting multiple containers. These containers run software instances, referred to as processes, that collaborate and communicate within the cluster to deliver robust and efficient storage services. This architecture ensures scalability and fault tolerance by distributing storage functionality across interconnected containers.

### Process types and core requirements

The WEKA system uses different types of processes, each dedicated to specific functions:

* **Drive processes**: Manage SSD drives and handle IO operations to drives. These processes are fundamental to storage operations and each requires a dedicated core to ensure optimal performance.
* **Compute processes:** Handle filesystems, cluster-level functions, and IO from clients. The dedicated core requirement for each compute process ensures consistent processing power for these critical operations.
* **Frontend processes**: Also known as client processes, manage POSIX client access and coordinate IO operations with compute and drive processes. Each frontend process needs a dedicated core to maintain responsive client interactions.
* **Management processes**: Oversee the overall cluster operations. Unlike other process types, management processes can share cores as they have lower resource demands.

{% hint style="info" %}
Drive, compute, and management processes are considered backend processes, while frontend processes handle client interactions.
{% endhint %}

## Multi-Container Backend architecture (MCB)

In the WEKA cluster, each server implements a multi-container backend architecture where containers are specialized by process type (drive, compute, or frontend).

<figure><img src="../.gitbook/assets/MCB_architecture.png" alt=""><figcaption><p>Multi-container backend architecture (MCB)</p></figcaption></figure>

## Benefits of MCB architecture

* **Non-Disruptive Upgrade (NDU) capabilities:**
  * Enables true non-disruptive upgrades where containers can run different software versions independently without system interruption
  * Supports individual container rollback without impacting cluster operations
  * Maintains continuous network control plane access throughout the upgrade process, ensuring uninterrupted client service
* **Optimized hardware utilization:**
  * Supports up to 64 WEKA cores per server
  * Multiple containers per process type
  * Flexible core allocation across containers
  * Up to 19 cores per container
* **Improved maintenance operations:**
  * Selective process management
  * Ability to maintain drive processes while stopping compute and frontend processes

## System limitations and specifications

**Process limits**

* Total processes per cluster: 40,000 (includes all process types: management, drive, compute, and frontend)
* Maximum backend processes: 4096 (excludes frontend processes)
* Maximum management processes: 20,000
* Maximum drive processes: 38,000

**Server and container limits**

* Maximum WEKA cores per server: 64
* Maximum cores per container: 19
