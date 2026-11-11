---
description: >-
  Use the NFS health API to let an external layer 4 load balancer send clients
  only to serving NFS containers.
---

# External load balancer integration

When NFS clients reach the NFS containers through an external layer 4 (passthrough) load balancer instead of floating IPs, the load balancer needs to know which NFS containers are serving. The cluster reports a serving verdict for each NFS container and interface group, and a cluster-wide indicator of correlated failures. The load balancer uses them to send new connections only to serving NFS containers.

## How a load balancer uses the health API

A load balancer reads the health API in one of two ways:

* **Health check on each container:** The load balancer reads `GET /nfs/health/self` on each NFS container's management port (14000) and checks that `lb_healthy` is `true`. While the cluster is degraded, `lb_healthy` stays `true`, so the load balancer keeps all containers in rotation instead of removing most of them at once.
* **Monitor program:** A program reads the cluster-wide report, `GET /nfs/health`, from any management address, and updates the load balancer.

The health check target is the management port (14000) of each NFS container's server, not the NFS serving address. Make sure the load balancer can reach port 14000 on every NFS server.

The user that reads the health API needs the Read Only role. On a multi-tenant cluster, only users of the root tenant can read the report.

Use the v3 health endpoints for new integrations. The v2 endpoint, `/api/v2/nfs/health`, is deprecated and remains available for existing integrations. Some field names differ between the versions. For example, `hosts` and `canary_eligible_hosts` in v2 are `containers` and `canary_eligible_containers` in v3. For the endpoints, fields, and errors, see the REST API reference at [api.docs.weka.io](https://api.docs.weka.io).

## Verdicts

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

## Serving probe

Each NFS container checks its own NFS server every 5 seconds with an NFSv3 mount and a filesystem status request, with a 3-second timeout. After three consecutive failures, the verdict is `CANARY_FAILED`. The serving probe does not move floating IPs and does not change the port status of the interface group.

With the default settings, a server that hangs or stays down is typically reported as `CANARY_FAILED` within about 20 seconds, and as `NFS_SERVER_DOWN` within about 50 seconds. A server that crashes and restarts automatically within a few seconds might not be reported.

The serving probe reaches the NFS frontend. Faults in the backend data path affect all containers together, and the cluster alerts report them. Authentication and identity services are not part of the serving probe.

## Correlated failures

When at least half of the probed NFS containers fail at the same time, with a minimum of two, the cluster reports a cluster-wide degraded condition and raises the `NfsCanaryClusterDegraded` alert. The verdict of each container stays as it is.

## Considerations

* The cluster reports the faults it can observe on its own containers. Pair the health API with a TCP check on port 2049 of each serving address, from the load balancer.
* Damping, such as how many failed reads remove a container from rotation, is configured on the load balancer or the monitor program.
* When the load balancer moves a client to another NFS container, the client's NFSv4 state and NLM locks stay with the original container. Configure client retries and application recovery for this case.
