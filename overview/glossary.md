# Glossary

## A

### Agent

The Weka agent is software installed on user application servers that need access to the Weka file services. When using the Stateless Client feature, the agent is responsible for ensuring that the correct client software version is installed (depending on the cluster version) and that the client connects to the correct cluster.

## B

### Backend server

A server that runs the Weka software and is installed with SSD drives dedicated to the Weka system, providing services to the clients. A group of backend servers forms a storage cluster.

## C

### Client

The Weka client is software installed on user application servers that need access to Weka file services. The Weka client implements a kernel-based filesystem driver and the logic and networking stack to connect to the Weka backend servers and be part of a cluster. In general industry terms, "client" may also refer to an NFS, SMB, or S3 client that uses those protocols to access the Weka filesystem. For NFS, SMB, and S3 the Weka client is not required to be installed in conjunction with those protocols.

### Cluster

A collection of Weka backend servers, together with Weka clients installed on the application servers, forming one shareable, distributed, and scalable file storage system.

### Container

Weka uses Linux containers (LXC) as the mechanism for holding one process or keeping multiple processes together. Containers can have different processes within them. They can have frontend processes and associated DPDK libraries within the container, compute processes, drive processes, a management process, and DPDK libraries, or can have NFS, SMB, or S3 services running within them. A server can have multiple containers running on it at any time.

### Converged deployment

A Weka configuration in which Weka backend containers run on the same server with applications.

## D

### Data Retention Period

The target period of time for tiered data to be retained on an SSD.

### Data Stripe Width

The number of data blocks in each logical data protection group.

### Dedicated Deployment

A Weka configuration that dedicates complete servers and all of their allocated resources to Weka backends, as opposed to a converged deployment.

## F

### Failure Domain

A collection of hardware components that can fail together due to a single root cause.

### Filesystem Group

A collection of filesystems that share a common tiering policy to object-store.

### Frontend

Is the collection of Weka software that runs on a client and accesses storage services and IO from the Weka storage cluster. The frontend consists of a frontend node that delivers IO to the Weka driver, a DPDK library, and the Weka POSIX driver.

## H

### Host

The term node is deprecated. See [Container](glossary.md#container).

### Hot Data

Frequently used data (as opposed to warm data), usually residing on SSDs.

## M

### Machine

The term node is deprecated. See [Server](glossary.md#server).

## N

### Net Capacity

Amount of space available for user data on SSDs in a configured Weka system.

### Node

The term node is deprecated. See [Process](glossary.md#process).

## P

### **POSIX**

The Portable Operating System Interface (POSIX) is a family of **** standards specified by the [I](https://en.wikipedia.org/wiki/IEEE\_Computer\_Society)EEE Computer Society for maintaining compatibility between operating systems. The WekaFS client is POSIX compliant, which means that it presents data to the OS on which it is installed in a manner that conforms to the POSIX standard. The WekaFS client is sometimes informally referred to as the POSIX client or POSIX driver when describing the overall storage system architecture.

### Process

A software instance that Weka uses to run and manage WekaFS. Processes are dedicated to managing different functions such as (1) NVMe Drives and IO to the drives, (2) compute processes for filesystems and cluster-level functions and IO from clients, (3) frontend processes for POSIX client access and sending IO to the compute process and (4) management processes for managing the overall cluster.

### Provisioned Capacity

The total capacity that is assigned to filesystems. This includes both SSD and object store capacity.

### Prefetch

The Weka process of rehydrating data from an object store to an SSD, based on a prediction of future data access.

## R

### Raw Capacity

Total SSD capacity owned by the user.

### Retention Period

The target time for data to be stored on SSDs before releasing from the SSDs to an object-store.

### Releasing

The deletion of the SSD copy of data that has been tiered to the object-store.

### Rehydrating

The creation of an SSD copy of data stored only on the object-store.

## S

### Server

A physical or virtual server that has hardware resources allocated to it and software running on it that provides compute or storage services. Weka uses backend servers in conjunction with clients to deliver storage services. In general industry terms, in a cluster of servers, sometimes the term node is used instead.

### Stem Mode

A mode of the Weka software that has been installed and is running, but has not been attached to a cluster.

### Snap-To-Object

A Weka feature for uploading snapshots to object stores.

## T

### Tiered Weka Configuration

Weka configuration consisting of SSDs and object stores for data storage.

### Tiering

Copying of data to an object store, while it still remains on the SSD.

### Tiering Cue

The minimum time to wait before considering data for tiering from an SSD to an object-store.

## U

### Unprovisioned Capacity

The storage capacity that is available for new filesystems.

## V

### VF

Virtual Function

## W

### Warm Data

Less frequently-used data (as opposed to hot data), usually residing on an object-store.
