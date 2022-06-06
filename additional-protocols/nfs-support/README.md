---
description: >-
  This page describes how the Weka system enables file access through the NFS
  protocol, instead of the Weka client. The Weka system supports NFSv3.
---

# NFS

The NFS protocol enables client hosts to access the Weka filesystem. You can deploy the NFS service in one of the following options:

* **With a Weka client software**: Deploy the NFS service from the Weka cluster by installing a Weka client software. This option provides high performance. The steps for this option are provided on this page.
* **Without a Weka client software**: Deploy by following the standard NFS implementation of the client host operating system. This option provides standard performance.

## Workflow: Deploy NFS service with a Weka client software

| **Step**                                                                                                    | **Implementation method**                                                 |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Define a set of hosts that provide the NFS service. It can be the whole cluster or a subset of the cluster. | Define an interface group.                                                |
| Define Ethernet ports on each of the defined hosts that are used to provide the NFS service.                | Define an interface group.                                                |
| Allocate a pool of IP addresses that are used by the Weka software to provide the NFS service.              | Define an interface group.                                                |
| Define a round-robin DNS name that resolves to the floating IPs.                                            | On the local DNS service configuration; does not involve Weka management. |
| Define the list of client hosts that have access permissions to the NFS filesystems.                        | Create a client permission group.                                         |
| Configure the client hosts and the filesystems that they can access.                                        | Create a client permission group.                                         |
| Mount the file systems on the client hosts using the NFS mount operating system support.                    | On the client operating system; does not involve Weka management.         |

### Define the NFS networking configuration (interface groups)

You can add only a single port to an interface group. Therefore, to support High Availability (HA) in NFS, create two interface groups. On each interface group, assign the host ports. In addition, to ensure that a single point of failure is not created in the switch, consider the network topology (switches) when assigning the other host ports to these interface groups.

## Implement NFS service from a Weka cluster

To define the NFS service, one or more interface groups must be defined. An interface group consists of the following:

* A collection of Weka hosts with an Ethernet port for each host, where all the ports must be associated with the same layer 2 subnets.
* A collection of floating IPs that serve the NFS protocol on the hosts and ports. All IP addresses must be associated with the layer 2 subnet above.
* A routing configuration for the IPs. The IP addresses must comply with the IP network configuration.

You can define up to 10 different Interface groups. Use multiple interface groups if the cluster needs to connect to multiple layer 2 subnets. You can define up to 50 hosts in each interface group.

The Weka system automatically distributes the IP addresses evenly on each host and port. If a  host failure occurs, the Weka system redistributes the IP addresses that are associated with the failed host to other hosts. To minimize the effect of any host failures, it is recommended to define sufficient floating IPs so that the Weka system can assign four floating IPs per host.

{% hint style="info" %}
**Note:** The Weka system configures the host IP networking for the NFS service on the host operating system. The user must not perform this action.
{% endhint %}

### Configure the round-robin DNS server

To ensure that the various NFS clients balance the load on the various Weka hosts serving NFS, it is recommended to define a [round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS) entry that resolves to the list of floating IPs, ensuring that client loads are equally distributed across all hosts.

{% hint style="info" %}
**Note:** Make sure to set the TTL (Time to Live) for all A records assigned to the NFS servers to 0 (Zero). This action ensures that the IP is not cached by the client or the DNS server.
{% endhint %}

### Define NFS access control (client access groups)

To control the access mapping between the hosts and the filesystems, the NFS client permission groups must be defined. Each NFS client permission group contains:

* A list of filters for IP addresses or DNS names of clients that can be connected to the Weka system by NFS.
* A collection of rules that control access to specific filesystems.

### Configure NFS on the client

Configure the NFS mount on the client host by the standard NFS stack operating system. The NFS server IP address must point to the round-robin DNS name as defined [above](./#configure-the-round-robin-dns-server).

## NFS service load balancing and resiliency&#x20;

The Weka NFS service is a scalable, fully load-balanced, and resilient service that provides continuous service through failures of any kind.

Scalability is implemented by defining many hosts that serve the NFS protocol, thereby enabling the scaling of performance by adding more hosts to the interface group.

Load balancing is implemented by floating IPs. By default, the floating IPs are evenly distributed over all the interface group hosts/ports. When different clients resolve the DNS name into an IP service, each of them receives a different IP address, thereby ensuring that different clients access different hosts. This allows the Weka system to scale and service thousands of clients.

The same mechanism ensures the resiliency of the service. On a host failure, all IP addresses associated with the failed host are reassigned to other hosts (using the GARP network messages) and the clients reconnect to the new hosts without any reconfiguration or service interruption.

## User groups resolution

The NFS protocol, using AUTH\_SYS protocol, has a limitation of 16 security groups users can be part of. The protocol truncates the group list to 16 if a user is part of more than 16 groups, and a permissions check can fail for authorized users.

As in many cases, a user can be part of more than 16 security groups. It is possible to configure the Weka system to ignore the groups passed by the NFS protocol and resolve the user's groups external to the protocol. For that, several steps should be taken:

1. Define an interface group that supports external group-IDs resolution (`allow-manage-gids` option).
2. Define the NFS client permissions to use external group-IDs resolution (`manage-gids` option).
3. Set up the relevant hosts to retrieve the user's group-IDs information.

### Set up the hosts to retrieve user's group-IDs information

For the hosts that are part of the interface group, you can set the host to retrieve the user's group-IDs information in any method that is part of the environment.

You can also set the group resolution by joining the AD domain, the Kerberos domain, or using LDAP with a read-only user.

Configure the `sssd` on the host to serve as a group IDs provider. For example, you can configure the `sssd` directly using LDAP, or as a proxy to a different `nss` group IDs provider.

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

If you use another method than the `sssd`, but with a different provider, configure an `sssd proxy` on each relevant host. The proxy is used for the Weka container to resolve the groups by any method defined on the host.

To configure `sssd proxy` on a host, use the following:

```
# install sssd
yum install sssd

# set up a proxy for weka in /etc/sssd/sssd.conf
[sssd]
services = nss
config_file_version = 2
domains = proxy_for_weka

[nss]
[domain/proxy_for_weka]
id_provider = proxy
auth_provider = none
 
# the name of the nss lib to be proxied, e.g. ldap, nis, winbind, vas4, etc.
proxy_lib_name = ldap
```

{% hint style="info" %}
**Note:** All users must be present and resolved in the method used in the `sssd` for the groups resolution. In the above example, using an LDAP-only provider, local users (such as a local root) that are not present in LDAP do not receive their groups resolved and they are denied. For such users or applications, add the LDAP user.
{% endhint %}

****

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
You can change the following mount options. These values are commonly used with the Weka system.
{% endhint %}

* `rw`
* `hard`
* `rsize=524288`
* `wsize=524288`
* `namlen=255`
* `timeo=600`
* `retrans=2`

#### Fixed-mount options

{% hint style="danger" %}
**Note:** Make sure to set these values on the mount command, because different values are not supported.
{% endhint %}

* `nolock`

{% hint style="info" %}
**Note:** The following options must have fixed values, but usually are either the NFS mount defaults or are negotiated to these values by the protocol.
{% endhint %}

* `sec=sys`
* `vers=3`
* `mountvers=3`
* `proto=tcp`
* `mountproto=tcp`

``

**Related topics**

****[nfs-support.md](nfs-support.md "mention")****

****[nfs-support-1.md](nfs-support-1.md "mention")****
