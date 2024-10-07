# Add clients to a WEKA cluster on Azure

When deploying a WEKA cluster, it is possible to create clients using Terraform. After completing this step, you can expand the number of clients in your WEKA system by performing the following procedure.

## Before you begin

* Create a client VM using one of the following methods:
  * **Using the Azure Console:**  Create the client VM that meets the following requirements:
    * The _Accelerated Networking_ feature must be enabled in _t_he NICs.
    * The NICs must be configured with at least MTU 3900.
    * Ensure a supported OFED is installed.
    * Remove the secondary default gateway from the routing table.
    * If working with a different security type than the standard, for example, trusted launch virtual machines, clear the **Enable secure boot** option in the **Configure security features**.
  * **Using a custom image of a WEKA client:**&#x20;
    * In the Azure console, search for the community image named **weka** with ID `WekaIO-d7d3f308-d5a1-4c45-8e8a-818aed57375a`. The **weka** custom image includes ubuntu 20.04 with kernel 5.4 and ofed 5.8-1.1.2.1.
    * Enable the _Accelerated Networking_ feature in the NICs.
    * Configure the NICs to operate with at least MTU 3900.
* Ensure the client has enough available IP addresses in the selected subnet. Each core allocated to WEKA requires a NIC (and IP address).

## Mount the filesystem

1. Create a mount point (only once):

```
mkdir /mnt/weka
```

1. Install the WEKA agent on your client machine (only once):

```bash
curl <backend server IP address>:14000/dist/v1/install | sh
```

Example:

```bash
curl http://10.0.0.7:14000/dist/v1/install | sh
```

2. Detect the existing network configuration. Run the command: `ip a`.

<details>

<summary><code>ip a</code> command output example</summary>

<pre class="language-bash" data-overflow="wrap"><code class="lang-bash"><strong>root@jack:~# ip a
</strong>1: lo: &#x3C;LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: &#x3C;BROADCAST,MULTICAST,UP,LOWER_UP> mtu 3900 qdisc mq state UP group default qlen 1000
    link/ether 00:0d:3a:8e:3a:67 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.30/24 brd 10.0.0.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::20d:3aff:fe8e:3a67/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: &#x3C;BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4038 qdisc mq state UP group default qlen 1000
    link/ether 00:0d:3a:8b:d9:bd brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.31/24 brd 10.0.0.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::20d:3aff:fe8b:d9bd/64 scope link
       valid_lft forever preferred_lft forever
4: enP18334s1np0: &#x3C;BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 3900 qdisc mq master eth0 state UP group default qlen 1000
    link/ether 00:0d:3a:8e:3a:67 brd ff:ff:ff:ff:ff:ff
5: enP39539s2np0: &#x3C;BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 4038 qdisc mq master eth1 state UP group default qlen 1000
    link/ether 00:0d:3a:8b:d9:bd brd ff:ff:ff:ff:ff:ff
6: dtap0: &#x3C;BROADCAST,MULTICAST,UP,LOWER_UP> mtu 4038 qdisc multiq state UNKNOWN group default qlen 1000
    link/ether 00:0d:3a:8b:d9:bd brd ff:ff:ff:ff:ff:ff
    inet6 fe80::20d:3aff:fe8b:d9bd/64 scope link
       valid_lft forever preferred_lft forever
</code></pre>

</details>

3. Once the WEKA cluster runs, you can mount clients to the filesystem using the following command:

{% code overflow="wrap" %}
```bash
mount -t wekafs <backend-server-IP-address>/<filesystem-name> -o net=<VF interface>/<synthetic network interface IP address>/mask -o mgmt_ip=<Management-IP> /mnt/weka
```
{% endcode %}

Where:

* `<VF interface>/<synthetic network interface IP address>/mask`: The VF interface and synthetic network interface are automatically paired and act as a single interface in most aspects used by applications. The synthetic interface always has a name in the form `eth\<n\>`.\
  You can identify the VF interface and synthetic network interface pair by their common MAC address. In the example above,  the VF interface is `enP39539s2np0` (item 5), and the synthetic network interface is `eth1` (item 3), which has the  IP address and mask 10.0.0.31/24.
* `<Management-IP>`: In the example above, it the `eth0` management IP `10.0.0.30`.

Example:

{% code overflow="wrap" fullWidth="false" %}
```bash
mount -t wekafs 10.0.0.7/default -o net=enP39539s2np0/10.0.0.31/24 -o mgmt_ip=10.0.0.30 /mnt/weka

```
{% endcode %}

{% hint style="info" %}
Using the Azure Console, the client instances are provisioned separately from the WEKA cluster.
{% endhint %}



**Related topics**

[mounting-filesystems](../../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")
