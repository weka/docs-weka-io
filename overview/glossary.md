# Glossary

## A

### Agent

The Weka agent is software installed on user application servers that need access to the Weka file services. When using the Stateless Client feature, the agent is responsible for ensuring that the correct client software version is installed \(depending on the cluster version\) and that the client connects to the correct cluster.

## B

### Backend Host

A host that runs the Weka software and can also be installed with SSD drives dedicated to the Weka system, providing services to client hosts.

## C

### Client

The Weka client is software installed on user application servers that need access to the Weka file services. The Weka client implements a kernel-based filesystem driver and the logic and networking stack to connect to the Weka backend hosts and be part of a cluster.

### Cluster

A collection of Weka backends, together with Weka clients installed on the application servers, forming one sharable, distributed, and scalable file storage system.

### Converged Deployment

The configuration of Weka backends running on the same host with other applications.

## D

### Data Retention Period

The target period of time for tiered data to be retained on an SSD.

### Data Stripe Width

The number of data blocks in each logical data protection group.

### Dedicated Weka Deployment

Basic Weka configuration involving the creation of a cluster by dedicating complete servers to Weka backends, as opposed to converged deployment.

## F

### Failure Domain

A collection of hardware components that can fail together due to a single root cause.

### Filesystem Group

A collection of filesystems which share a common tiering policy to object-store.

## H

### Hot Data

Frequently-used data \(as opposed to warm data\), usually residing on SSDs.

## N

### Net Capacity

Amount of space available for user data on SSDs in a configured Weka system.

## P

### Provisioned Capacity

The total capacity assigned to filesystems. This includes both SSD and object store capacity.

### Prefetch

The Weka process of rehydrating data from an object store to an SSD, based on a prediction of future data access.

## R

### Raw Capacity

Total SSD capacity owned by the user.

### Retention Period

The target time for data to be stored on SSDs before releasing from the SSDs to an object-store.

### Releasing

The deletion of the SSD copy of data which has been tiered to the object-store.

### Rehydrating

The creation of an SSD copy of data stored only on the object-store.

## S

### Stem Mode

A mode of the Weka software which has been installed and is running, but has not been attached to a cluster.

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

The storage capacity available for new filesystems.

## V

### VF

Virtual Function

## W

### Warm Data

Less frequently-used data \(as opposed to hot data\), usually residing on an object-store.

