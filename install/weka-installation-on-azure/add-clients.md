# Add clients

When deploying a WEKA cluster, it is possible to create clients using Terraform. After completing this step, you can expand the number of clients in your WEKA system by performing the following procedure.

## Before you begin

* Create a client VM in one of the following methods:
  * **Using the Azure Console:**  Create the client VM that meets the following requirements:
    * The _Accelerated Networking_ feature must be enabled in _t_he NICs.
    * The NICs must be configured to operate with MTU 3900.
    * Ensure a supported OFED is installed.
    * Remove the secondary default gateway from the routing table.
  * **Using a custom image of a WEKA client:**&#x20;
    * In the Azure console, search for the community image named **weka** with ID `WekaIO-d7d3f308-d5a1-4c45-8e8a-818aed57375a`. The **weka** custom image includes ubuntu 20.04 with kernel 5.4 and ofed 5.8-1.1.2.1.
    * Enable the _Accelerated Networking_ feature in the NICs.
    * Configure the NICs to operate with MTU 3900.
* Ensure the client has enough available IP addresses in the selected subnet. Each core allocated to WEKA requires a NIC (and IP address).

## Mount the filesystem

1. Create a mount point (only once):\
   `mkdir /mnt/weka`
2. Install the WEKA agent on your client machine (only once):\
   `curl <backend server http address>:14000/dist/v1/install | sh`\
   \
   Example:\
   `curl http://10.20.0.2:14000/dist/v1/install | sh`
3. Detect the existing network configuration. Run the command: `ip a`.

Once the WEKA cluster runs, you can add clients to your WEKA system to run your workflows.

{% hint style="info" %}
Using the Azure Console, the client instances are provisioned separately from the WEKA cluster.
{% endhint %}

## Mount the filesystem

1. Create a mount point (only once):\
   `mkdir /mnt/weka`
2. Install the WEKA agent on your client machine (only once):\
   `curl <backend server http address>:14000/dist/v1/install | sh`\
   Example:\
   `curl http://10.20.0.2:14000/dist/v1/install | sh`
3. You can mount a stateless or stateful client on the filesystem.\
   Example:\
   `mount -t wekafs -o <Load balancer DNS name or IP address>/<filesystem name> /mnt/weka`\
   \
   Example:\
   `mount -t wekafs -o 10.20.30.40/fs1 /mnt/weka`



**Related topics**

[mounting-filesystems.md](../../fs/mounting-filesystems.md "mention")
