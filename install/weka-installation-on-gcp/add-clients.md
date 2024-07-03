# Add clients

WEKA supports client instances with at least two NICs, one for management and one for the frontend data. It is possible to add more NICs for redundancy and higher performance.

A client with the same VPC networks and subnets as the cluster can connect without additional configuration. If a client is on another VPC network, peering is required between the VPC networks.

The client instance must be in the same region as the WEKA cluster on GCP.

## Mount the filesystem

1. Create a mount point (only once):&#x20;

```
mkdir /mnt/weka
```

2. Install the WEKA agent (only once):

```bash
curl <backend server http address>:14000/dist/v1/install | sh
```

Example:

```bash
curl http://10.20.0.2:14000/dist/v1/install | sh
```

3. Mount a stateless client on the filesystem. In the mount command, specify all the NICs of the client.

* **DPDK mount with four NICs:**

{% code overflow="wrap" %}
```bash
mount -t wekafs -o net=eth1/IP -o net=eth2/IP -o net=eth3/IP -o mgmt_ip=<management IP (eth0)> <backend server IP address>/<filesystem name> /mnt/weka
```
{% endcode %}

Example:

{% code overflow="wrap" %}
```bash
mount -t wekafs -o net=eth1/10.20.30.101 -o net=eth2/10.20.30.102 -o net=eth3/10.20.30.103 -o mgmt_ip=10.20.30.100 10.20.30.40/fs1 /mnt/weka
```
{% endcode %}

* **UDP mount:**&#x20;

{% code overflow="wrap" %}
```bash
mount -t wekafs -o net=udp -o num_cores=0 -o mgmt_ip=<management IP (eth0)> <backend server IP address>/<filesystem name> /mnt/weka
```
{% endcode %}

Example:

{% code overflow="wrap" %}
```bash
mount -t wekafs -o net=udp -o num_cores=0 -o mgmt_ip=10.20.30.100 10.20.30.40/fs1 /mnt/weka
```
{% endcode %}

**Related topics**

[mounting-filesystems](../../fs/mounting-filesystems/ "mention")
