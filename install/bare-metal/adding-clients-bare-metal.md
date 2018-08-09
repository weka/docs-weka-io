---
description: This page describes how to add clients to a bare metal cluster.
---

# Adding Clients

## About Client Hosts

Client hosts are used to run applications which need to access the WekaIO filesystems. They are similar to backend hosts, except that they do not contribute CPUs or drives to the cluster. Consequently, they are only connected to the cluster to use its filesystems.

To add client hosts to the WekaIO system configuration, use the stages described below.

## Stage 1: Install the Software

Verify that the WekaIO software is installed on the client host according to the installation instructions. For further information, see [Obtaining the WekaIO Install File](obtaining-the-weka-install-file.md) and [Stage 1 in WekaIO System Installation Process](adding-clients-bare-metal.md#stage-1-install-the-software).

{% hint style="info" %}
**Note:** All hosts, clients and backends in a WekaIO system cluster must use the same software version. If attempts are made to mix multiple versions, the new hosts will fail to join the cluster.
{% endhint %}

## Stage 2: Joining the Cluster

**Command:** `cluster host add`

Once the client host is in the stem mode \(this is the mode defined immediately after running the `install.sh`command\), use the following command line on the client host to add it to the cluster:

```text
weka -H <backend-hostname> cluster host add <client-hostname>
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `backend-hostname` | String | IP/host name of one of the existing backend instances in the cluster | Valid host name \(DNS or IP\) | Yes |  |
| `client-hostname` | String | IP/host name of the client currently being added |  Valid host name \(DNS or IP\) | Yes |  |

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host will be received. Make a note of it for the next steps.
{% endhint %}

## Stage 3: Configuring the Host as Client

**Command:** `weka cluster host cores`

To configure the new host as a client, run the following command:

```text
weka cluster host cores <host-id> --frontend-dedicated-cores=1
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host to be added to the cluster | Must be a valid host identifier | Yes |  |
| cores | Number | Number of cores | Must be 1 for this version | Yes |  |

## Stage 4: Configuring Client Networking

**Command:** `weka cluster host net add`

{% hint style="info" %}
**Note:** If the new client is to communicate with the WekaIO system cluster over the kernel UDP stack, it is not necessary to run this command.
{% endhint %}

If a high-performance client is required and the appropriate network NIC is available, use the following command to configure the networking interface used by the client to communicate with the WekaIO system cluster hosts:

```text
weka cluster host net add <host-id> --device=<net-device> \
                  --ips=<ip-address> --netmask=<netmask-bits> --gateway=<gateway>
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host to be added to the cluster | Must be a valid host identifier | Yes |  |
| `net-device` | String | Network interface device name e.g., `eth1` | Must be a valid network device name | Yes |  |
| `ip-address` | IP address | IP address of the new interface | Must be valid IP address | Yes |  |
| `gateway` | IP address | IP address of the default routing gateway | IP address and gateway may only be different on the last N bits, where N is the net mask. Not allowed for IB | No |  |
| `netmask-bits` | Number | Number of bits in the net mask, e.g., the net mask of `255.255.0.0` has `16` netmask bits | IP address and gateway may only be different on the last N bits, where N is the net mask. Not allowed for IB | No |  |

{% hint style="info" %}
**Note:** When configuring an InfiniBand client, do not pass the `--ips`, `--netmask` and `--gateway` parameters.
{% endhint %}

{% hint style="info" %}
**Note:**  InfiniBand clients can only join a cluster with InfiniBand backends. It is not possible to mix InfiniBand and Ethernet clients/backends.
{% endhint %}

## Stage 5: Activating the Host

**Command:**  `weka cluster host activate`

After successfully configuring the host and its network device, run the following command to finalize the configuration by activating the host:

```text
weka cluster host activate --host-ids=<host-id>
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | Comma-separated string | Identifier of host to be added to the cluster | Must be a valid host identifier | Yes |  |



