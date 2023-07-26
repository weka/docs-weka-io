---
description: >-
  This page describes how the WEKA system enables file access through the NFS
  protocol instead of the WEKA client.
---

# NFS

NFS (Network File System) is a protocol that allows clients to access the WEKA filesystem without installing WEKA’s client software using the standard NFS implementation of the client operating system.

WEKA’s default NFS implementation is NFS**-**W. NFS-W allows overcoming the inherent limitation in the NFS protocol of up to 16 security groups a user can be part of. It supports the NFSv3, NFSv4.0, and NFSv4.1 protocols.&#x20;

In addition, a legacy NFS stack is also available for backward compatibility. The legacy NFS supports only the NFSv3 protocol and up to 16 security groups a user can be part of.

## Workflow: Deploy NFS service with a WEKA client software

<table data-header-hidden><thead><tr><th width="476.8152042902094">Step</th><th>Implementation method</th></tr></thead><tbody><tr><td><strong>Step</strong></td><td><strong>Implementation method</strong></td></tr><tr><td>Define a set of servers that provide the NFS service. It can be the whole cluster or a subset of the cluster.</td><td>Define an interface group.</td></tr><tr><td>Define Ethernet ports on each defined server that provides the NFS service.</td><td>Define an interface group.</td></tr><tr><td>Allocate a pool of IP addresses used by the WEKA software to provide the NFS service.</td><td>Define an interface group.</td></tr><tr><td>Define a round-robin DNS name that resolves to the floating IPs.</td><td>On the local DNS service configuration. It does not involve WEKA management.</td></tr><tr><td>Define the list of clients that have access permissions to the NFS filesystems.</td><td>Create a client permission group.</td></tr><tr><td>Configure the clients and the filesystems that they can access.</td><td>Create a client permission group.</td></tr><tr><td>Mount the file systems on the clients using the NFS mount operating system support.</td><td>On the client operating system. It does not involve WEKA management.</td></tr></tbody></table>

### Define the NFS networking configuration (interface groups)

You can add only a single port to an interface group. Therefore, to support High Availability (HA) in NFS, create two interface groups. On each interface group, assign the server ports. In addition, to ensure that a single point of failure is not created in the switch, consider the network topology (switches) when assigning the other server ports to these interface groups.

## Implement NFS service from a WEKA cluster

To define the NFS service, one or more interface groups must be set. An interface group consists of the following:

* A collection of WEKA servers with an Ethernet port for each server, where all the ports must be associated with the same layer-2 subnets.
* A collection of floating IPs that serve the NFS protocol on the servers and ports. All IP addresses must be associated with the layer-2 subnet above.
* A routing configuration for the IPs. The IP addresses must comply with the IP network configuration.

You can define up to 10 different Interface groups. Use multiple interface groups if the cluster needs to connect to multiple layer 2 -subnets. You can set up to 50 servers in each interface group.

The WEKA system automatically distributes the IP addresses evenly on each server and port. If a  server fails, the WEKA system redistributes the IP addresses associated with the failed server to other servers. To minimize the effect of server failures, it is recommended to define sufficient floating IPs so that the Weka system can assign four floating IPs per server.

{% hint style="info" %}
The WEKA system configures the server IP networking for the NFS service on the server operating system. The user must not perform this action.
{% endhint %}

### Configure the round-robin DNS server

To ensure that the various NFS clients balance the load on the different WEKA servers serving NFS, it is recommended to define a [round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS) entry that resolves to the list of floating IPs, ensuring that client loads are equally distributed across all servers.

{% hint style="info" %}
Set the TTL (Time to Live) for all A records assigned to the NFS servers to 0 (Zero). This action ensures that the client or the DNS server does not cache the IP.
{% endhint %}

### Define NFS access control (client access groups)

The NFS client permission groups must be defined to control the access mapping between the servers and the filesystems. Each NFS client permission group contains the following:

* A list of filters for IP addresses or DNS names of clients that can be connected to the WEKA system by NFS.
* A collection of rules that control access to specific filesystems.

### Configure NFS on the client

Configure the NFS mount on the client by the standard NFS stack operating system. The NFS server IP address must point to the round-robin DNS name (as described [above](./#configure-the-round-robin-dns-server)).

## NFS service load balancing and resiliency&#x20;

The WEKA NFS service is a scalable, fully load-balanced, and resilient service that provides continuous service through failures of any kind.

Scalability is implemented by defining many servers that serve the NFS protocol, thereby enabling performance scaling by adding more servers to the interface group.

Floating IPs implement load balancing. By default, the floating IPs are evenly distributed over all the interface group servers/ports. When different clients resolve the DNS name into an IP service, each receives a different IP address, ensuring that other clients access different servers. This allows the WEKA system to scale and service thousands of clients.

The exact mechanism ensures the resiliency of the service. On a server failure, all IP addresses associated with the failed server are reassigned to other servers (using the GARP network messages), and the clients reconnect to the new servers without any reconfiguration or service interruption.

## User groups resolution

The NFS protocol, using AUTH\_SYS protocol, has a limitation of 16 security groups that users can be part of. The protocol truncates the group list to 16 if a user is part of more than 16 groups, and a permissions check can fail for authorized users.

As in many cases, a user can be part of more than 16 security groups. It is possible to configure the WEKA system to ignore the groups passed by the NFS protocol and resolve the user's groups external to the protocol. For that, several steps should be taken:

1. Define an interface group that supports the external group-IDs resolution. Verify that the `allow-manage-gids` option is set to `on`.
2. Define the NFS client permissions for external group-IDs resolution (`manage-gids` option).
3. Set up the relevant servers to retrieve the user's group-IDs information.

### Set up the servers to retrieve user's group-IDs information

For the servers part of the interface group, you can set the server to retrieve the user's group-IDs information in any method that is part of the environment.

You can also set the group resolution by joining the AD domain, the Kerberos domain, or using LDAP with a read-only user.

Configure the `sssd` on the server to serve as a group IDs provider. For example, you can configure the `sssd` directly using LDAP or as a proxy to a different `nss` group IDs provider.

**Example: set `sssd` directly for `nss` services using LDAP with a read-only user**

```
[sssd]
services = nss
config_file_version = 2
domains = LDAP

[domain/LDAP]
id_provider = ldap
ldap_uri = ldap://ldap.example.com
ldap_search_base = dc=example,dc=com

# The DN used to search the ldap directory with. 
ldap_default_bind_dn = cn=ro_admin,ou=groups,dc=example,dc=com

# The password of the bind DN.
ldap_default_authtok = password

```

If you use another method than the `sssd` but with a different provider, configure an `sssd proxy` on each relevant server. The proxy is used for the WEKA container to resolve the groups by any method defined on the server.

To configure `sssd proxy` on a server, use the following:

```
# install sssd
yum install sssd

# set up a proxy for WEKA in /etc/sssd/sssd.conf
[sssd]
services = nss
config_file_version = 2
domains = proxy_for_weka

[nss]
[domain/proxy_for_weka]
id_provider = proxy
auth_provider = none
 
# the name of the nss lib to be proxied, e.g., ldap, nis, winbind, vas4, etc.
proxy_lib_name = ldap
```

{% hint style="info" %}
**Note:** All users must be present and resolved in the method used in the `sssd` for the group's resolution. In the above example, using an LDAP-only provider, local users (such as a local root) who are not present in LDAP do not receive their groups resolved and are denied. For such users or applications, add the LDAP user.
{% endhint %}

## Supported NFS client mount options&#x20;

#### Non-coherent mount options

* `ac`
* `async`
* `noatime`
* `lookupcache=all`

#### Coherent mount options

* `noac`
* `sync`
* `atime`
* `lookupcache=none`

#### Common mount options

{% hint style="info" %}
You can change the following mount options. These values are commonly used with the WEKA system.
{% endhint %}

* `rw`
* `hard`
* `rsize=524288`
* `wsize=524288`
* `namlen=255`
* `timeo=600`
* `retrans=2`
* `nconnect=1` (only supported in NFS-W)&#x20;

#### Fixed-mount options

{% hint style="danger" %}
Set these values on the mount command because different values are not supported.
{% endhint %}

* `nolock`

{% hint style="info" %}
The following options must have fixed values, but usually are either the NFS mount defaults or are negotiated to these values by the protocol.
{% endhint %}

* `sec=sys`
* `proto=tcp`
* `mountproto=tcp`



**Related topics**

[nfs-support.md](nfs-support.md "mention")

[nfs-support-1.md](nfs-support-1.md "mention")
