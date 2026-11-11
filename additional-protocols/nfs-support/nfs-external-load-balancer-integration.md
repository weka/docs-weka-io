---
description: >-
  Use the NFS health API to let an external layer 4 load balancer send clients
  only to serving NFS containers.
---

# External load balancer integration

When NFS clients reach the NFS containers through an external layer 4 (passthrough) load balancer instead of floating IPs, the load balancer needs to know which NFS containers are serving. The cluster reports a serving verdict for each NFS container and interface group, and a cluster-wide indicator of correlated failures. The load balancer uses them to send new connections only to serving NFS containers.

## Health API

The health API gives the load balancer the serving status of the NFS containers, so it can remove a failed container from rotation and return it when it recovers. The API has two endpoints:

* **`GET /nfs/health/self`:** The status of one NFS container, read from that container's management port (14000). The `lb_healthy` field is `true` while the container serves.
* **`GET /nfs/health`:** The cluster-wide report of all NFS containers, read from any management address.

Use the v3 health endpoints for new integrations. The v2 endpoint, `/api/v2/nfs/health`, is deprecated and remains available for existing integrations. Some field names differ between the versions. For example, `hosts` and `canary_eligible_hosts` in v2 are `containers` and `canary_eligible_containers` in v3. For the endpoints, fields, and errors, see the REST API reference at [api.docs.weka.io](https://api.docs.weka.io).

## Verdicts

The verdict tells the load balancer whether an NFS container can take new connections on an interface group, and if not, why. Use it to decide whether to keep the container in rotation, and to find the cause of a failure.

`OK` is the only serving verdict. Treat every other value as not serving, including a value that is not in this table. The cluster evaluates the verdicts in this order and reports the first that applies:

| Verdict | Meaning |
| --- | --- |
| `UNREACHABLE` | No process can be resolved for the container and interface group, or the process is down. |
| `NODE_NOT_SERVING` | The process is known but does not carry traffic, for example, while it joins or is removed. |
| `LINK_DOWN` | The network interface of the port reports link down. |
| `NFS_SERVER_DOWN` | The link is up, but the NFS server process or its container is not running. |
| `FAILED` | Removing a floating IP from this port failed. Applies to floating IP deployments only. |
| `MISCONFIGURED` | Assigning a floating IP failed, or the container has no port in the interface group. |
| `CANARY_FAILED` | All other checks pass, but the serving probe failed three consecutive times. |
| `OK` | Serving. |

The report lists interface groups, including an interface group assigned to a tenant, which appears without a tenant label. Tenant network spaces are not in the report.

## NFS server health probe

An NFS server can run and have a working network link, yet stop answering clients. The serving probe detects this case, so the load balancer stops sending clients to a server that does not answer.

Each NFS container checks its own NFS server every 5 seconds with an NFSv3 mount and a filesystem status request, with a 3-second timeout. After three consecutive failures, the verdict is `CANARY_FAILED`. The serving probe does not move floating IPs and does not change the port status of the interface group.

With the default settings, a server that hangs or stays down is typically reported as `CANARY_FAILED` within about 20 seconds, and as `NFS_SERVER_DOWN` within about 50 seconds. A server that crashes and restarts automatically within a few seconds might not be reported.

The serving probe reaches the NFS frontend. Faults in the backend data path affect all containers together, and the cluster alerts report them. Authentication and identity services are not part of the serving probe.

## Correlated failures

A fault that affects many NFS containers at once, such as a backend problem, must not empty the load balancer pool. The cluster detects this case and keeps the containers in rotation.

When at least half of the probed NFS containers fail at the same time, with a minimum of two, the cluster reports a cluster-wide degraded condition and raises the `NfsCanaryClusterDegraded` alert. The verdict of each container stays as it is. While the cluster is degraded, `lb_healthy` stays `true`, so the load balancer keeps all containers in rotation instead of removing most of them at once.

## Configure the load balancer

Configure the load balancer to check the health API and send new NFS connections only to serving NFS containers.

**Before you begin**

* Create a cluster user with the Read Only role for the load balancer or the monitor program. On a multi-tenant cluster, create the user in the root tenant, because only users of the root tenant can read the report.
* Make sure the load balancer can reach the management port (14000) on every NFS server. The health check target is this port, not the NFS serving address.

**Procedure**

1. Set up the health check, using one of the following methods:
   * **Health check on each container:** On the load balancer, configure a health check that reads `GET /nfs/health/self` on each NFS container's management port (14000), and treats the container as healthy while `lb_healthy` is `true`.
   * **Monitor program:** Run a program that reads the cluster-wide report, `GET /nfs/health`, from any management address, and updates the load balancer.
2. Add a TCP check on port 2049 of each serving address, from the load balancer. The cluster reports only the faults it can observe on its own containers, and the TCP check covers the path from the load balancer.
3. Configure damping on the load balancer or the monitor program, such as how many failed reads remove a container from rotation.

{% hint style="info" %}
When the load balancer moves a client to another NFS container, the client's NFSv4 state and NLM locks stay with the original container. Configure client retries and application recovery for this case.
{% endhint %}
