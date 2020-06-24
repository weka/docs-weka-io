---
description: This page describes how to add clients to a bare metal cluster.
---

# Adding Clients

## About Client Hosts

Client hosts are used to run applications which need to access the WekaIO filesystems. They are similar to backend hosts, except that they do not contribute CPUs or drives to the cluster. Consequently, they are only connected to the cluster to use its filesystems.

To add client hosts to the WekaIO system configuration, use the stages described below.

{% hint style="info" %}
**Note:** The steps described below represent the traditional approach for mounting a filesystem. However, filesystems can also be mounted using the Stateless Clients feature, which simplifies and improves the management of clients in the cluster and eliminates the process described below. For more information, refer to [Mounting Filesystems Using the Stateless Clients Feature](../../fs/mounting-filesystems.md#mounting-filesystems-using-stateless-clients).
{% endhint %}

## Stage 1: Install the Software

Verify that the WekaIO software is installed on the client host according to the installation instructions. For further information, see [Obtaining the WekaIO Install File](obtaining-the-weka-install-file.md) and [Stage 1 in WekaIO System Installation Process.](using-cli.md#stage-1-installation-of-the-wekaio-software-on-each-host)

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
| `backend-hostname` | String | IP/host name of one of the existing backend instances in the cluster | Valid host name \(FQDN or IP\) | Yes |  |
| `client-hostname` | String | IP/host name of the client currently being added |  Valid host name \(FQDN or IP\) | Yes |  |

{% hint style="info" %}
**Note:** On completion of this stage, the host-ID of the newly added host will be received. Make a note of it for the next steps.
{% endhint %}

## Stage 3: Configuring the Host as Client

**Command:** `weka cluster host cores`

To configure the new host as a client, run the following command:

```text
weka cluster host cores <host-id> 1 --frontend-dedicated-cores=1
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | String | Identifier of host to be added to the cluster | Must be a valid host identifier | Yes |  |

## Stage 4: Configuring Client Networking

**Command:** `weka cluster host net add`

{% hint style="info" %}
**Note:** If the new client is to communicate with the WekaIO system cluster over the kernel UDP stack, it is not necessary to run this command.
{% endhint %}

If a high-performance client is required and the appropriate network NIC is available, use the following command to configure the networking interface used by the client to communicate with the WekaIO system cluster hosts:

`weka cluster host net add <host-id> --device=<net-device> --ips=<ip-address> --netmask=<netmask> --gateway=<gateway>`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>host-id</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Identifier of host to be added to the cluster</td>
      <td style="text-align:left">Must be a valid host identifier</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>net-device</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Network interface device name e.g., <code>eth1</code>
      </td>
      <td style="text-align:left">Must be a valid network device name</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>ip-address</code>
      </td>
      <td style="text-align:left">IP address</td>
      <td style="text-align:left">IP address of the new interface</td>
      <td style="text-align:left">Must be a valid IP address</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>gateway</code>
      </td>
      <td style="text-align:left">IP address</td>
      <td style="text-align:left">IP address of the default routing gateway</td>
      <td style="text-align:left">
        <p>Gateway must reside within the same IP network of <code>ip-address</code> (as
          described by <code>netmask</code>).</p>
        <p>Not relevant for IB / L2 non-routable networks.</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>netmask</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Number of bits in the net mask, e.g., the net mask of <code>255.255.0.0</code> has <code>16</code> netmask
        bits</td>
      <td style="text-align:left">Describes the number of bits that identify a network ID (also known as
        CIDR).</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

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
weka cluster host activate <host-id>
```

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | Comma-separated string | Identifier of host to be added to the cluster | Must be a valid host identifier | Yes |  |



