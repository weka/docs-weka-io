---
description: >-
  This page describes the process for adding clients to an already-installed
  WekaIO system cluster.
---

# Adding Clients

## Introduction

When launching a WekaIO system cluster, either through the [Self-Service Portal](self-service-portal.md) or via a [CloudFormation template](cloudformation.md), it is also possible to launch client instances as part of the cluster. However, sometimes it may be required to add more clients after the cluster has been installed. To add more clients as separate instances, follow the instructions below.

## Adding Clients as Separate Instances

### Step 1: Launch the New Instances {#step-1-launch-new-instances}

{% hint style="info" %}
**Note:** Any new client instances must be of one of the types appearing in [Supported EC2 Instance Types](supported-ec2-instance-types.md).
{% endhint %}

When launching new clients, ensure the following concerning networking and root volume:

#### **Networking**

* The new clients must be in the **same subnet** as the backend instances.
* They must use the same **security group** as the backends they will connect to, or alternatively use a **security group** which allows them to connect to the backend instances.
* **Enhanced networking** is enabled as described in [https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html).
* The OS **network manager** must be disabled.

#### IAM Instance Profile

When adding a client, the `aws-add-client` script requires permissions for the following AWS APIs to discover and optionally add a network interface to the instance \(see below\):

* `ec2:Describe*`
* `ec2:AttachNetworkInterface`
* `ec2:CreateNetworkInterface`
* `ec2:ModifyNetworkInterfaceAttribute`

These permissions are automatically created in an instance profile as part of the CloudFormation stack. It is possible to use the same instance profile as one of the backend instances to ensure that the same credentials are given to the new client.

The network interface permissions are required to create and attach a network interface to the new client. A separate NIC is required to allow the WekaIO system client to preallocate the network resource for fastest performance.

If the client is not to be provided with these permissions, it is possible to only provide `ec2:Describe*` and create an additional NIC in the same security group and subnet as described above.

#### Root Volume

The clients **root volume** must be at least 48 GiB in size and either `GP2` or `IO1` type.

The WekaIO software is installed under `/opt/weka`. If it is not possible to change the size of the root volume, an additional EBS volume can be created, formatted and mounted under `/opt/weka`. Make sure that the new volume is either `GP2` or `IO1` type.

### Step 2: Install the WekaIO Software {#step-2-install-wekaio-software}

To download the WekaIO software, go to [https://get.weka.io ](https://get.weka.io/) and select the software version to be downloaded. After selecting the version, select the operating system it is to be installed on and run the download command line as `root`on all the new client instances.

When the download is complete, untar the downloaded package and run the `install.sh` command in the package directory. 

{% hint style="warning" %}
**For Example:** If you downloaded version 3.1.7, run`cd weka-3.1.7` and then run `./install.sh`.
{% endhint %}

{% hint style="info" %}
**Note: ENA Driver Notice**

When installing on an AWS instance with Elastic Network Adapter \(ENA\) and a non-up-to-date kernel, it may be necessary to install the ENA drivers or upgrade to a more recent operating system version. The ENA driver is automatically available on recent operating systems, such as RedHat/Centos 7.4, Ubuntu 16 and Amazon Linux 2017.09.
{% endhint %}

### Step 3: Add Clients to the Cluster {#step-3-add-clients-to-cluster}

Once the WekaIO software is installed, the clients are ready to join the cluster. To add the clients, run the following command line on each of the client instances:

```text
weka local run -e WEKA_HOST=<backend-ip> aws-add-client <client-instance-id>
```

where `<backend-ip>` is the IP address or hostname of one of the backend instances.

On most shells the following would get the client instance ID and add it to the cluster:

```text
weka local run -e WEKA_HOST=<backend-ip> aws-add-client `curl -s http://169.254.169.254/latest/meta-data/instance-id`
```

If successful, running the`aws-add-client` command will display the following line:

```text
Client has joined the cluster
```

{% hint style="info" %}
**Note: Dedicated Client Resources**

Once the `aws-add-client` command is complete, one core and 6.3 GB of RAM are allocated for the WekaIO system on the client instance. This is performed as part of the WekaIO system preallocation of resources, ensuring that variance in client activity does not result in the allocation of resources that may affect the programs running on the client host. For more information, see [Memory Resource Planning](../bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
{% endhint %}

### Step 4: Mount Filesystems on the Clients {#step-4-mount-filesystem-on-clients}

It is now possible to mount the filesystems on the client instances.

{% hint style="warning" %}
**For Example:** Using the`mkdir -p /mnt/weka && mount -t wekafs default /mnt/weka`  command will mount the `default`filesystem under `/mnt/weka.`
{% endhint %}

{% hint style="info" %}
**Note:** For more information about available mount options, see [Mounting Filesystems](../../fs/mounting-filesystems.md).
{% endhint %}

