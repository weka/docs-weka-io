# Add clients to a WEKA cluster on AWS

## Introduction

When launching a WEKA cluster, either through the [Self-service portal](self-service-portal.md) or via a [CloudFormation template](cloudformation.md), it is also possible to launch client instances. However, sometimes it may be required to add more clients after the cluster has been installed. To add more clients as separate instances, follow the instructions below.

{% hint style="info" %}
It is advisable to turn off auto kernel updates so it will not get upgraded to a yet unsupported version.
{% endhint %}

## Add clients as separate instances

### Step 1: Launch the new instances <a href="#step-1-launch-new-instances" id="step-1-launch-new-instances"></a>

{% hint style="info" %}
New client instances must be one of the types specified in the [Supported EC2 instance types](../weka-installation-on-aws-using-terraform/supported-ec2-instance-types.md) section.
{% endhint %}

When launching new clients, ensure the following concerning networking and root volume:

#### **Networking**

* For best performance, it is recommended that the new clients will be in the **same subnet** as the backend instances. Alternatively, they can be in a routable subnet to the backend instances in the same AZ (note that cross-AZ traffic also incurs expensive network charges).&#x20;
* They must use the same **security group** as the backends they will connect to, or alternatively, use a **security group** that allows them to connect to the backend instances.
* **Enhanced networking** is enabled as specified in [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html).

#### IAM instance profile

When adding a client, it is required to provide permissions to several AWS APIs, as described in [IAM role created in the template](cloudformation.md#iam-role-created-in-the-template).

These permissions are automatically created in an instance profile as part of the CloudFormation stack. It is possible to use the same instance profile as one of the backend instances to ensure the same credentials are given to the new client.

The network interface permissions are required to create and attach a network interface to the new client. A separate NIC is required to allow the WEKA client to preallocate the network resource for the fastest performance.

If the client is not provided with these permissions, it can only provide `ec2:*` and create an additional NIC in the same security group and subnet described above when mounting a second cluster from a single client (see [Mount filesystems from multiple clusters on a single client](../../../weka-filesystems-and-object-stores/mounting-filesystems/mount-filesystems-from-multiple-clusters-on-a-single-client.md)).

#### Root volume

The client's **root volume** must be at least 48 GiB in size and either `GP2` or `IO1` type.

The WEKA software is installed under `/opt/weka`. If it is not possible to change the size of the root volume, an additional EBS volume can be created, formatted, and mounted under `/opt/weka`. Make sure that the new volume is either `GP2` or `IO1` type.

### Step 2: Mount the filesystems

{% hint style="info" %}
The clients created using the Self-Service Portal are stateless. The mount command automatically installs the software version, and there is no need to join the client to the cluster.
{% endhint %}

To mount a filesystem in this manner, first install the WEKA agent from one of the backend instances and then mount the filesystem. For example:

```
# Agent Installation (one time)
curl http://Backend-1:14000/dist/v1/install | sh

# Creating a mount point (one time)
mkdir -p /mnt/weka

# Mounting a filesystem
mount -t wekafs Backend-1/my_fs /mnt/weka
```

For the first mount, this will install the WEKA software and automatically configure the client. For more information on mount and configuration options, see the [Mount filesystems using the stateless clients feature](../../../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-stateless-clients) section.

It is possible to configure the client OS to mount the filesystem at boot time automatically. For more information, see the [Mount filesystems using fstab](../../../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-fstab) or [Mount filesystems using autofs](../../../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-autofs) sections.

## Add clients that are always part of the cluster

{% hint style="info" %}
It is possible to add instances that do not contribute resources to the cluster but are used for mounting filesystems. It is recommended to use the previously described method for adding client instances for mounting purposes. However, in some cases, it could be useful to permanently add them to the cluster, e.g., to use these instances as NFS/SMB servers which are always expected to be up.
{% endhint %}

### Step 1: [Launch the new instances](adding-clients.md#step-1-launch-new-instances)

This is the same step as in the previous method of adding a client.

### Step 2: Install the WEKA software <a href="#step-2-install-wekaio-software" id="step-2-install-wekaio-software"></a>

To download the WEKA software, go to [https://get.weka.io ](https://get.weka.io/) and select the software version. After selecting the version, select the operating system to install and run the download command line as `root` on all the new client instances.

When the download is complete, untar the downloaded package and run the `install.sh` command in the package directory.

{% hint style="success" %}
**Example:**

If you downloaded version 3.6.1, run `cd weka-3.6.1` and then run `./install.sh`.
{% endhint %}

{% hint style="info" %}
**ENA Driver Notice**

When installing on an AWS instance with Elastic Network Adapter (ENA) and a non-up-to-date kernel, it may be necessary to install the ENA drivers or upgrade to a more recent operating system version. The ENA driver is automatically available on operating systems starting with Red Hat/CentOS 7.4, Ubuntu 16, and Amazon Linux 2017.09.
{% endhint %}

### Step 3: Add clients to the cluster <a href="#step-3-add-clients-to-cluster" id="step-3-add-clients-to-cluster"></a>

Once the WEKA software is installed, the clients are ready to join the cluster. To add the clients, run the following command line on each of the client instances:

```
weka local run -e WEKA_HOST=<backend-ip> aws-add-client <client-instance-id>

```

where `<backend-ip>` is the IP address or hostname of one of the backend instances.

On most shells the following would get the client instance ID and add it to the cluster:

```
weka local run -e WEKA_HOST=<backend-ip> aws-add-client $(curl -s http://169.254.169.254/latest/meta-data/instance-id)

```

If successful, running the`aws-add-client` command will display the following line:

```
Client has joined the cluster

```

{% hint style="info" %}
**Dedicated client resources**

Once the `aws-add-client` command is complete, one core and 6.3 GB of RAM are allocated for the WEKA system on the client instance. This is performed as part of the WEKA system preallocating resources, ensuring that variance in client activity does not result in allocating resources that may affect the programs running on the client. For more information, see [Memory resource planning](../../bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
{% endhint %}

### Step 4: Mount filesystems on the clients <a href="#step-4-mount-filesystem-on-clients" id="step-4-mount-filesystem-on-clients"></a>

It is now possible to mount the filesystems on the client instances.

{% hint style="success" %}
**Example:**

Using the `mkdir -p /mnt/weka && mount -t wekafs default /mnt/weka` command will mount the `default` filesystem under `/mnt/weka.`
{% endhint %}

{% hint style="info" %}
For more information about available mount options, see [Mount filesystems](../../../weka-filesystems-and-object-stores/mounting-filesystems/).
{% endhint %}
