# Glossary

## A

## **Access Time (atime)**

Access time, often called "atime," is a file system metadata attribute that tracks the most recent instance when a file was accessed or read. This attribute is essential for monitoring and managing file usage, as it records when a file was last opened or viewed by a user or an application.

In the WEKA filesystem, atime updates occur differently. In WEKA, when a user reads a file, the atime is updated locally on the container where the read operation took place, and this update is subsequently propagated to the cluster after the user closes the file. This update process doesn't occur immediately and may take a few minutes to reflect the actual access time.

Furthermore, there is a "relatime" mount option available, which can influence the atime update mechanism. When "relatime" is in use, access times are updated only if they are older than the file's modification time or creation time, reducing the frequency of atime updates and minimizing the impact on system performance.

### Agent

The WEKA agent is software installed on user application servers that need access to the WEKA file services. When using the Stateless Client feature, the agent ensures that the correct client software version is installed (depending on the cluster version) and that the client connects to the correct cluster.

## B

### Backend server

A backend server in the context of WEKA is a server equipped with SSD drives and running the WEKA software. These servers are dedicated to the WEKA system, offering services to clients. A storage cluster is formed by a group of such backend servers, collectively providing storage and processing capabilities within the WEKA infrastructure.

## C

### Client

The WEKA client is software installed on user application servers that need access to WEKA file services. The WEKA client implements a kernel-based filesystem driver and the logic and networking stack to connect to the WEKA backend servers and be part of a cluster. In general industry terms, "client" may also refer to an NFS, SMB, or S3 client that uses those protocols to access the WEKA filesystem. For NFS, SMB, and S3, the WEKA client is not required to be installed in conjunction with those protocols.

### Cluster

A collection of WEKA backend servers, together with WEKA clients installed on the application servers, forming one shareable, distributed, and scalable file storage system.

### Container

WEKA uses Linux containers (LXC) as the mechanism for holding one process or keeping multiple processes together. Containers can have different processes within them. They can have frontend processes and associated DPDK libraries within the container, compute processes, drive processes, a management process, and DPDK libraries, or NFS, SMB, or S3 services running within them. A server can have multiple containers running on it at any time.

### Converged deployment

A WEKA configuration in which WEKA backend containers run on the same server with applications.

## D

### Data Retention Period

The target period of time for tiered data to be retained on an SSD.

### Data Stripe Width

The number of data blocks in each logical data protection group.

### Dedicated Deployment

A WEKA configuration that dedicates complete servers and all of their allocated resources to WEKA backends, as opposed to a converged deployment.

## F

### Failure Domain

A collection of hardware components that can fail together due to a single root cause.

### Filesystem Group

A collection of filesystems that share a common tiering policy to object-store.

### Frontend

It is the collection of WEKA software that runs on a client and accesses storage services and IO from the WEKA storage cluster. The frontend consists of a process that delivers IO to the WEKA driver, a DPDK library, and the WEKA POSIX driver.

## H

### Host

The term "host" is deprecated. See [#container](glossary.md#container "mention").

### Hot Data

Frequently used data (as opposed to warm data), usually residing on SSDs.

## L

### Leader

In distributed systems, a leader is a process that assumes a special role, often responsible for coordination, synchronization, and making decisions on behalf of the cluster. The leader plays a crucial role in maintaining consistency and order among the distributed processes or nodes in the system. If the leader fails or is replaced, a new leader is typically elected to ensure the continued operation of the distributed system.

Within the context of WEKA, at the cluster's core resides the cluster leader, serving as the singular WEKA management process within the cluster. This unique role grants the cluster leader the exclusive capability to initiate and disseminate configuration changes throughout the entire cluster.

## M

### Machine

The term "machine" is deprecated. See [#server](glossary.md#server "mention").

## N

### Net Capacity

Amount of space available for user data on SSDs in a configured WEKA system.

### Node

The term "node" is deprecated. See [#process](glossary.md#process "mention").

## O

### **OBS**

Object Storage. WEKA uses object storage buckets to extend the WEKA filesystem and to store uploaded file system snapshots.

## P

### **POSIX**

POSIX (Portable Operating System Interface) is a set of standards established by the IEEE Computer Society to ensure compatibility across diverse operating systems. The WEKA client adheres to the POSIX specifications, ensuring that it interacts with the underlying operating system following the defined POSIX standard. This compliance ensures seamless interoperability and consistent behavior, making the WEKA client often referred to as the POSIX client or POSIX driver when discussing the broader storage system architecture.

### Process

A software instance that WEKA uses to run and manage the filesystem. Processes are dedicated to managing different functions such as (1) NVMe Drives and IO to the drives, (2) compute processes for filesystems and cluster-level functions and IO from clients, (3) frontend processes for POSIX client access and sending IO to the compute process and (4) management processes for managing the overall cluster.

### Provisioned Capacity

The total capacity that is assigned to filesystems. This includes both SSD and object store capacity.

### Prefetch

Prefetch in WEKA involves proactively promoting data from an object store to an SSD based on predictions of future data access. This process anticipates and preloads data onto faster storage, optimizing performance by ensuring that relevant information is readily available when needed.

### Promoting

Promoting refers to the action of moving data from a lower-tier storage, typically an object store, to a more accessible storage medium, such as an SSD, when the data is required for active use. This process aims to enhance performance by ensuring that frequently accessed or critical data is readily available on a faster storage tier.

## R

### Raw Capacity

Total SSD capacity owned by the user.

### Rehydrating

See [#promoting](glossary.md#promoting "mention").

### Retention Period

The designated time duration for data to be stored on SSDs before releasing from the SSDs to an object store.

### Releasing

Releasing, in the context of data tiering, refers to deleting the SSD copy of data that has been migrated to the object store.

## S

### Server

A physical or virtual server that has hardware resources allocated to it and software running on it that provides compute or storage services. WEKA uses backend servers in conjunction with clients to deliver storage services. In general industry terms, in a cluster of servers, sometimes the term node is used instead.

### SR-IOV

SR-IOV (Single Root I/O Virtualization) is a technology that enables a single physical resource to be leveraged as multiple virtual resources. In essence, SR-IOV facilitates the partitioning of a single hardware component into distinct virtual functions, each operating independently. Correspondingly, the term Virtual Function (VF) aligns with SR-IOV, referring to these individualized virtualized entities. This technology is particularly valuable in optimizing resource utilization and enhancing the efficiency of virtualized environments.

### Stem Mode

Stem Mode in WEKA refers to the installed and running software that has not yet been attached to a cluster.

### Snap-To-Object

Snap-To-Object is a WEKA feature facilitating the uploading of snapshots to object stores.

## T

### Tiered WEKA Configuration

A tiered WEKA configuration combines SSDs and object stores for data storage.

### Tiering

Tiering is the dynamic process of copying data from an SSD to an object store while retaining the original copy on the SSD. This optimization strategy balances performance and cost considerations by keeping frequently accessed data on the high-performance SSD and moving less accessed data to a more economical object store.

### Tiering Cue

Tiering Cue refers to the minimum duration that must elapse before considering data migration from an SSD to an object store. This time threshold is crucial in the context of data tiering strategies, where the decision to move data between different storage tiers is based on factors such as access frequency, performance requirements, and cost considerations. The Tiering Cue helps establish a timeframe for evaluating whether data should be transitioned from the faster but potentially more expensive SSD storage to the object store, which may offer more cost-effective, albeit slower, storage.

## U

### Unprovisioned Capacity

Unprovisioned capacity refers to the storage space that is currently unused and available for the creation of new filesystems or data storage allocations. This term indicates the portion of storage resources that have not been assigned or allocated to any specific purpose, making it ready and waiting to be provisioned for new file systems or data storage needs.

## V

### VF

Virtual Function (VF) in the context of WEKA typically denotes the creation of multiple virtual instances of a physical network adapter. This involves leveraging SR-IOV (Single Root I/O Virtualization) technology, where a single physical resource can be partitioned into distinct virtual functions, each capable of independent operation. In essence, both Virtual Function and SR-IOV are terms integral to WEKA's approach to optimizing resource allocation and enhancing the efficiency of virtualized network environments by enabling the creation of multiple independent virtual instances from a single physical network adapter.

## W

### Warm Data

Warm data is less frequently accessed or utilized data, unlike hot data, and is typically stored in an object store. This term is used to describe information that is accessed less regularly but remains relevant for specific use cases. Storing warm data on an object store allows for efficient management of data resources, providing a balance between accessibility and storage costs.
