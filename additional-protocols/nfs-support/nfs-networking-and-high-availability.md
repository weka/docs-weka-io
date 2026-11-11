---
description: >-
  Plan the interface groups, floating IPs, and round-robin DNS that provide NFS
  load balancing and failover.
---

# NFS networking and high availability

NFS clients reach the NFS service through floating IP addresses that belong to interface groups. The cluster distributes the floating IPs across the servers of each interface group and moves them to healthy servers when a server fails. Plan the interface groups and DNS before you deploy NFS, because they determine how clients spread across the servers and how they fail over.

## Interface groups

An interface group provides resilience and high availability for NFS services by enabling transparent failover between NFS servers.

* **Resilience:** An interface group requires a minimum of two servers to ensure continuous NFS availability. If a server becomes unavailable, its floating IPs automatically migrate to a healthy server in the group.
* **Server membership:** An interface group consists of a set of servers, each with a designated network port. All ports must be associated with the same subnet.
* **Floating IP management:** The group includes one or more floating IP addresses used by the NFS service. All floating IPs must reside in the same subnet, and each server must already have a static IP configured on the corresponding network interface.
* **Routing configuration:** Floating IPs must comply with the network routing configuration to ensure proper reachability and failover behavior.

{% hint style="info" %}
Floating IPs are supported on AWS but not on Azure, GCP, and OCI cloud environments.
{% endhint %}

An interface group can have only a single port. Therefore, two interface groups are required to support High Availability (HA) in NFS. When assigning the other server ports to these interface groups, consider the network topology to ensure no single point of failure exists in the switch.

Use multiple interface groups if the cluster connects to multiple subnets.

The system automatically distributes the IP addresses evenly across the servers and ports. If a server fails, its IP addresses are redistributed to the remaining servers.

{% hint style="warning" %}
Floating IP addresses used by the NFS service are configured automatically on the appropriate server. Refrain from manually configuring or using the floating IP.
{% endhint %}

### Maximums

| Object | Maximum |
| --- | --- |
| Interface groups | 10 |
| Servers in an interface group | 50 |
| Floating IPs in the cluster | 200 |

{% hint style="info" %}
**Multi-tenancy:** These limits apply to the root organization. A tenant network space supports a maximum of 8 floating IP addresses, and a tenant is assigned to an interface group rather than owning one. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

## Round-robin DNS server configuration

A round-robin DNS name spreads the NFS clients across the servers that serve NFS, without configuring each client with a different address. Resolve a round-robin DNS entry to the list of floating IPs.

{% hint style="info" %}
Set the TTL (Time to Live) for all records assigned to the NFS servers to 0 (Zero). This action ensures that the client or the DNS server does not cache the IP.
{% endhint %}

NFS clients mount with the standard NFS stack of their operating system. The NFS server address in the mount command is the round-robin DNS name. See [supported-nfs-client-mount-parameters.md](supported-nfs-client-mount-parameters.md "mention").

## Scalability, load balancing, and resiliency

The NFS service scales with the number of servers in the interface group, and keeps serving clients when a server fails. For performance scalability, add as many servers as possible to the interface group.

The cluster distributes the floating IPs evenly across all interface group servers and ports to facilitate load balancing. In systems with more NFS interfaces than the floating IP maximum, not every interface will have a dedicated floating IP.

When different clients resolve the DNS name into an IP service, each receives a different IP address, ensuring that other clients access different servers. This design allows the system to scale and serve thousands of clients.

To ensure service resilience, if a server fails, the system reassigns all IP addresses associated with the failed server to other servers using GARP[^1] network messages. The clients then reconnect to the new servers without any reconfiguration or service interruption.

{% hint style="info" %}
During a floating IP takeover, two servers can briefly answer for the same address. A 30-second grace window suppresses duplicate-address detection for that period, so `ArpServerDuplicateIPDetected` is not raised for a normal failover. The event still fires for a genuine address conflict.
{% endhint %}

To send clients to the NFS containers through an external load balancer instead of floating IPs, see [nfs-external-load-balancer-integration.md](nfs-external-load-balancer-integration.md "mention").

**Related topics**

[#configure-the-nfs-cluster-level](manage-nfs-using-the-gui.md#configure-the-nfs-cluster-level "mention") (GUI)

[#configure-the-nfs-cluster-level](manage-nfs-using-the-cli.md#configure-the-nfs-cluster-level "mention") (CLI)

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin_DNS) (external)

[^1]: **GARP (Gratuitous Address Resolution Protocol)**: Network protocol used for IP address reassignment.
