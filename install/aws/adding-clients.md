# Adding Clients

When launching a WekaIO cluster, either through the [self-service portal](self-service-portal.md) or via a [CloudFormation template](cloudformation.md), you may also launch client instances as part of the cluster.

However, sometimes you may want to add more clients after the cluster has been installed.

To add more clients as separate instances, follow the instructions below:

### Step 1: Launch New Instances {#step-1-launch-new-instances}

New client instances have to be of one of the types in [Supported EC2 Instance Types](supported-ec2-instance-types.md).

There are a few things to ensure when launching new clients:

#### **Networking**

The new clients must be in the **same subnet** as the backend instances.

The new clients must either:

* Use the same **security group** as the backends they will connect to.
* Use a **security group** which allows the clients to connect to the backend instances.

When adding a client, the `aws-add-client` script needs permissions for the following AWS APIs to discover and optionally add a network interface to the instance \(see below\):

* `ec2:Describe*`
* `ec2:AttachNetworkInterface`
* `ec2:CreateNetworkInterface`
* `ec2:ModifyNetworkInterfaceAttribute`

These permissions are automatically created in an instance profile as part of the CloudFormation stack. You can either use the same instance profile as one of the backend instances to ensure these credentials are given to the new client.

The network interface permissions are required to create and attach a network interface to the new client. A separate NIC is required to allow the Weka client to preallocate the network resource for fastest performance.

If you don't want to provide the client with these permissions, you can only provide `ec2:Describe*` and create an additional NIC yourself in the same security group and subnet as described above.

#### Root Volume

The clients **root volume** has to be at least 48GiB in size and of either `GP2` or `IO1` types.

Weka installs its software under `/opt/weka`. If you can't change the size of your root volume, you can create an additional EBS volume, format it and mount under `/opt/weka`. Make sure that the new volume is of either `GP2` or `IO1` types

### Step 2: Install WekaIO Software {#step-2-install-wekaio-software}

To download the WekaIO software, go to [https://get.weka.io ](https://get.weka.io/) and select the version you want to download.

After selecting the version, select the operating system you’re installing on and run the download command-line as `root`on all your new client instances.

When download is complete, untar the downloaded package and run the `install.sh` within the package directory. For example, if you downloaded the 3.1.7 version, run `cd weka-3.1.7` and then run `./install.sh`.

{% hint style="info" %}
**ENA Driver Notice**

If you're installing on an AWS instance with Elastic Network Adapter \(ENA\) but your kernel is not up-to-date, you may need to install the ENA drivers yourself or upgrade to a more recent operating-system version.

The ENA driver is automatically available on recent operating-systems such as RedHat/Centos 7.4, Ubuntu 16 and Amazon Linux 2017.09.
{% endhint %}

### Step 3: Add Clients To Cluster {#step-3-add-clients-to-cluster}

Now that the WekaIO software is installed, the clients are ready to join the cluster.

To add the clients, run the following command on each of the client instances:

```text
weka local run -e WEKA_HOST=<backend-ip> aws-add-client <client-instance-id>
```

where `<backend-ip>` is the IP addresses or hostname of one of the backend instances.

If all goes well, `aws-add-client` prints the following line:

```text
Client has joined the cluster
```

{% hint style="info" %}
**Dedicated Client Resources**

Once `aws-add-client` is done running, one core and 6.3GB of RAM are allocated for WekaIO on the client instance.

This is done as part of WekaIO's pre-allocation of resources, ensuring that variance in client activity doesn't result in allocation of resources that might affect the programs running on the client host.

For more information, see the [Memory Resource Planning](../bare-metal/planning-a-weka-system-installation.md#memory-resource-planning) section of the installation guide.
{% endhint %}

### Step 4: Mount Filesystem On Clients {#step-4-mount-filesystem-on-clients}

You can now mount the filesystems on the clients instances. For example, this command would mount the `default`filesystem under `/mnt/weka`:

```text
mkdir -p /mnt/weka && mount -t wekafs default /mnt/weka
```

To learn about all available mount options, please see the [Mounting Filesystems](../../fs/mounting-filesystems.md) page.

