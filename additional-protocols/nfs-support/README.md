---
description: >-
  The WEKA system enables file access through the NFS protocol instead of the
  WEKA client.
---

# Manage the NFS protocol

NFS (Network File System) is a protocol that allows clients to access the WEKA filesystem without installing WEKA’s client software using the standard NFS implementation of the client operating system.

WEKA’s default NFS implementation is NFS**-**W. NFS-W allows overcoming the inherent limitation in the NFS protocol of up to 16 security groups a user can be part of. It supports the NFSv3, NFSv4.0, and NFSv4.1 protocols.&#x20;

In addition, the legacy NFS stack is also available for backward compatibility. The legacy NFS supports only the NFSv3 protocol, and up to 16 security groups a user can be part of.

## NFS service deployment guidelines and requirements

Adhere to the following guidelines and requirements when deploying the NFS service.

### **Global configuration filesystem**

NFSv4.0/4.1 requires a persistent cluster-wide configuration filesystem. The S3 and SMB-W services also share this filesystem.

### **Interface groups**

Interface groups define the servers and ports that provide the NFS service. The NFS service requires one or more interface groups. An interface group consists of the following:

* A collection of WEKA servers with a network port for each server, where all the ports must be associated with the same subnets.
* A collection of floating IPs that serve the NFS protocol on the servers and ports. All IP addresses must be associated with the same subnet.
* A routing configuration for the IPs. The IP addresses must comply with the IP network configuration.

An interface group can have only a single port. Therefore, two interface groups are required to support High Availability (HA) in NFS. Consider the network topology when assigning the other server ports to these interface groups to ensure no single point of failure exists in the switch.

You can define up to 10 different Interface groups. Use multiple interface groups if the cluster connects to multiple subnets. You can set up to 50 servers in each interface group.

The WEKA system automatically distributes the IP addresses evenly on each server and port. If a  server fails, the WEKA system redistributes the IP addresses associated with the failed server to other servers.

{% hint style="warning" %}
The WEKA system configures the server IP networking for the NFS service on the server operating system. Do not configure the server IP networking manually.
{% endhint %}

### Round-robin DNS server configuration

To ensure load balancing between the NFS clients on the different WEKA servers serving NFS, it is recommended to configure a round-robin DNS entry that resolves to the list of floating IPs.

{% hint style="info" %}
Set the TTL (Time to Live) for all records assigned to the NFS servers to 0 (Zero). This action ensures that the client or the DNS server does not cache the IP.
{% endhint %}

**Related information**

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS)

### NFS client mount&#x20;

The NFS client mount is configured using the standard NFS stack operating system. The NFS server IP address must point to the round-robin DNS name.

### NFS access control (client access groups)

The NFS client permission groups are defined to control the access mapping between the servers and the filesystems. Each NFS client permission group contains the following:

* A list of filters for IP addresses or DNS names of clients that can be connected to the WEKA system by NFS.
* A collection of rules that control access to specific filesystems.

### Scalability, load balancing, and resiliency&#x20;

To allow for performance scalability, add as many servers as possible to the interface group.

To achieve load balancing, implement floating IPs, which are evenly distributed over all the interface group servers and ports by default. When different clients resolve the DNS name into an IP service, each receives a different IP address, ensuring that other clients access different servers. This allows the WEKA system to scale and service thousands of clients.

To ensure the resilience of the service if a server fails, all IP addresses associated with the failed server are reassigned to other servers (using the GARP network messages), and the clients reconnect to the new servers without any reconfiguration or service interruption.

## NFS service deployment high-level workflow

<figure><img src="../../.gitbook/assets/NFS_deploy_workflow.png" alt=""><figcaption><p>NFS service deployment workflow</p></figcaption></figure>

For detailed procedures, see the related topics.

**Related topics**

[nfs-support.md](nfs-support.md "mention")

[nfs-support-1.md](nfs-support-1.md "mention")
