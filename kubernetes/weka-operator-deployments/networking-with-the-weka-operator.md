---
description: >-
  Configure network device selection, data-path mode, port allocation, and
  management interface binding for WekaCluster and WekaClient deployments.
---

# Networking with the WEKA Operator

## How WEKA uses the network

WEKA data-plane processes require direct access to network interfaces for high-performance I/O. The operator configures network interfaces on each container based on the fields in the `network` block of the WekaCluster or WekaClient CR.

WEKA supports two data-path modes:

| Mode | Description | When to use |
| --- | --- | --- |
| DPDK mode (default) | WEKA uses DPDK for data-path traffic and bypasses the kernel networking stack for lower latency and higher throughput. | Use when the servers, NICs, and Kubernetes network configuration support DPDK. |
| UDP mode | WEKA sends data-path traffic through the kernel networking stack over UDP. | Use when DPDK is not supported or when the network environment requires UDP transport. |

The WEKA Operator is CNI-agnostic. WEKA containers run with `hostNetwork: true`, so they use the Kubernetes node network instead of the pod overlay. Any conformant CNI, including Calico, Cilium, Flannel, and Multus, is supported. Interfaces used for WEKA storage traffic do not need CNI management, but they must have assigned IP addresses.

{% hint style="info" %}
On Amazon EKS, attach the `AmazonEKS_CNI_Policy` to the worker node IAM role.
{% endhint %}

## Configure network device selection

Specify which network interface WEKA uses for data-path traffic on backend and client containers. The following fields apply to both WekaCluster and WekaClient `spec.network`.

### **Single NIC**

Use `ethDevice` when all nodes in the cluster use one dedicated NIC for the data path:

```yaml
spec:
  network:
    ethDevice: eth1
```

If `ethDevice` is left empty, the system automatically uses the node's interface associated with the first subnet defined in `deviceSubnets`.

### **Multiple NICs**

Use `ethDevices` when backend containers have multiple dedicated NICs. The order of interfaces maps directly to the `ethSlots` index: the first interface maps to slot-0, the second to slot-1, and so on. Ensure every interface listed exists on all nodes that are part of the cluster:

```yaml
spec:
  network:
    ethDevices:
      - mlnx0
      - mlnx1
```

{% hint style="info" %}
You cannot use `ethDevice` and `ethDevices` together. Use one or the other.
{% endhint %}

### **Device subnets**

Specify backend subnets in CIDR notation. The operator assigns IP addresses from these subnets to backend containers for their data-path network:

```yaml
spec:
  network:
    deviceSubnets:
      - 192.168.10.0/24
      - 192.168.11.0/24
```

### **Gateway**

Specify the default gateway IPv4 address for the backend containers' data-path network. This is only required when backend subnets need to communicate with destinations outside their local network segment. For flat, non-routed backend networks, leave this field empty:

```yaml
spec:
  network:
    gateway: 192.168.10.1
```

## Enable UDP mode

Enable UDP mode when DPDK mode is not available — for example, when the NICs or their drivers do not support DPDK, or SR-IOV cannot be enabled. In UDP mode, WEKA processes data-path traffic through the kernel networking stack instead of bypassing the kernel with DPDK. Both modes use UDP as the transport protocol; UDP mode trades lower performance for broader hardware compatibility and no dedicated CPU core requirements.

```yaml
spec:
  network:
    udpMode: true
```

{% hint style="info" %}
UDP mode introduces additional encapsulation overhead compared to raw Ethernet mode. Use it only when required by your network environment.
{% endhint %}

## Configure per-role network selectors

On a WekaCluster, assign different network devices to different container roles using `roleNetworkSelector`. This overrides the global `network` setting for the specified role:

```yaml
spec:
  roleNetworkSelector:
    compute:
      ethDevice: mlnx0
    drive:
      ethDevice: mlnx1
    s3:
      ethDevice: eth0
    nfs:
      ethDevice: eth0
    smbw:
      ethDevice: eth0
```

Supported roles: `compute`, `drive`, `s3`, `nfs`, `smbw`, `dataServices`.

## Configure management interface binding

By default, WEKA containers use `restrict_listen` mode. This limits binding to localhost only and blocks access to the WEKA management API from external hosts. To allow containers to listen on all interfaces:

```yaml
spec:
  network:
    bindManagementAll: true
```

Use `bindManagementAll: true` only when your network topology requires external access to the WEKA management API, or when users must access the NeuralMesh GUI by using a server IP address. Keep the default `false` setting in production. It is more secure.

## Enable IPv6

Enable IPv6 for WEKA cluster networking on WekaCluster:

```yaml
spec:
  ipv6: true
```

IPv6 support requires UDP mode, single-stack IPv6 networking, and network interface selection by device name. Mixed IPv4 and IPv6 addressing is not supported. Dual-stack is not supported. An IPv4-only CNI is still supported.

## Configure port allocation

The operator auto-selects a free port range if `ports` is not set. To pin the port range explicitly on a WekaCluster, configure the `ports` field:

```yaml
spec:
  ports:
    basePort: 35000
```

View currently allocated ports:

```bash
kubectl get wekacluster <cluster-name> -o jsonpath='{.status.ports}'
```

For WekaClient, use `portRange` to define the base port for automatic allocation:

```yaml
spec:
  portRange:
    basePort: 45000
```

For the full port allocation reference including range sizes per Operator and WEKA version, see [Kubernetes port requirements](weka-operator-full-deployment-workflow.md#kubernetes-port-requirements) in WEKA Operator full deployment workflow.

#### NVIDIA Virtual Function single-IP mode

On nodes with NVIDIA virtual functions (VFs), multiple WEKA processes can share the same VF using single-IP mode. This setting defaults to `false`:

```yaml
spec:
  network:
    nvidiaVfSingleIp: true
```

{% hint style="info" %}
Auto-discovery of VF capabilities is planned for a future release. When implemented, unset may translate to `true` on supported configurations.
{% endhint %}

#### Network policies

> Configure Kubernetes NetworkPolicy resources and node-level firewall rules to allow WEKA traffic in environments that enforce a default-deny policy.
>
> WEKA data-path containers run with `hostNetwork: true`. Kubernetes NetworkPolicy resources do not govern host-network traffic, so control traffic to and from WEKA containers with node-level firewalls or cloud security groups. NetworkPolicy resources apply to the WEKA components that run on the pod network: the operator controller manager and, by default, the CSI pods.
>
> Allow the following flows:<br>

| Source                       | Destination                    | Port and protocol                                                                                                                                  | Purpose                                                                         |
| ---------------------------- | ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| Operator controller manager  | Kubernetes API server          | TCP 6443 (or the platform API port)                                                                                                                | Reconcile WEKA custom resources                                                 |
| CSI controller and node pods | WEKA management API            | TCP 14000                                                                                                                                          | Login, provisioning, quota, and snapshot API calls                              |
| WEKA containers              | Driver distribution service    | TCP 443 to `drivers.weka.io`, or TCP 60002 to the local Drivers-Dist service                                                                       | Driver download                                                                 |
| WEKA containers on each node | WEKA containers on other nodes | Base port 35000, 260 ports per cluster (Operator v1.10 and later with WEKA 5.1 and later; 500 ports on earlier versions). Clients: base port 45000 | Data-path and control traffic. Enforce with node-level rules, not NetworkPolicy |

**Related topics**

[WEKA Operator full deployment workflow](weka-operator-full-deployment-workflow.md)

[WekaCluster and WekaContainer lifecycle](wekacluster-and-wekacontainer-lifecycle.md)

[Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md)

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)
