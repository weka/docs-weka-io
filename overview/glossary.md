# Glossary

## B

### Backend Host

A host that runs the WekaIO software and can also be installed with SSD drives dedicated to the WekaIO system, providing services to client hosts.

## C

### Cluster

A collection of WekaIO backends, together with WekaIO clients installed on the application servers, forming one sharable, distributed and scalable file storage system.

## D

### Data Retention Period 

The target period of time to maintain data on an SSD, before tiering to an object store.

### Data Stripe Width 

The number of data blocks in each logical data protection group.

### Dedicated WekaIO Deployment 

Basic WekaIO configuration involving the creation of a cluster by dedicating complete servers to WekaIO backends, as opposed to hyper-converged deployment.

## F

### Failure Domain

A collection of hardware components that can fail together due to a single root cause.

### Filesystem Group

A collection of filesystems which share a common connectivity to an object store system.

## H

### Hot Data

Frequently-used data \(as opposed to warm data\).

### Hyper-Converged Deployment

The configuration of WekaIO backends running on the same host with other applications.

## N

### Net Capacity

Amount of space available for user data on SSDs in a configured WekaIO system.

## P

### Provisioned Capacity

The total capacity assigned to filesystems. This includes both SSD and object store capacity.

### Prefetch

The WekaIO process of rehydrating data from an object store to an SSD, based on a prediction of future data access.

## R

### Raw Capacity

Total SSD capacity owned by the user.

### Retention Period

Target time for data to be stored on SSDs before release from the SSDs to an object store.

### Releasing

The deletion of the SSD copy of data which has been tiered to the object store.

### Rehydrating

The creation of an SSD copy of data stored on object store only.

## S

### Stem Mode

A mode of the WekaIO software which has been installed and is running, but has not been attached to a cluster.

### Snap-To-Object

A WekaIO feature for uploading snapshots to object stores.

## T

### Tiered WekaIO Configuration

WekaIO configuration consisting of SSDs and object stores for data storage.

### Tiering

Copying of data to an object store, while it still remains on the SSD.

### Tiering Cue

The minimum time to wait before considering data for tiering from an SSD to an object store.

## U

### Unprovisioned Capacity

The storage capacity available for new filesystems.

## W

### Warm Data

Infrequently-used data \(as opposed 

