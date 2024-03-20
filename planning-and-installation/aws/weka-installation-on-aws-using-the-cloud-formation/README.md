# WEKA installation on AWS using the Cloud Formation

During the deployment of the WEKA system, the EC2 instances require access to the internet to download the WEKA software. For this reason, you need to deploy the WEKA system in one of the following deployment types in AWS:

* **Public subnet:** Use a public subnet within your VPC with an internet gateway, and allow public IP addresses for your instances.
* **Private subnet with NAT Gateway:** Create a private subnet with a route to a NAT gateway with an elastic IP in the public subnet.
* **Private subnet using WEKA VPC endpoint:** Requires the creation of a [Cluster CloudFormation stack](self-service-portal.md#cluster-cloudformation-stack) (once per VPC) that creates the necessary resources.
* **Private subnet using custom proxy:** Requires the creation of a [Cluster CloudFormation stack](self-service-portal.md#cluster-cloudformation-stack) (once per VPC) that creates the necessary resources.

The following diagrams illustrate the components of the _public subnet_ and _private subnet with NAT gateway deployment_ types in AWS.

![AWS subnet options for WEKA deployment](../../../.gitbook/assets/aws\_vpc\_layout1.png)

## Update the number of vCPU limits in EC2

By default, AWS does not provide enough vCPUs to install a WEKA system. Use the Limits Calculator for your region from the AWS EC2 dashboard.

**Procedure**

1. On the AWS EC2 dashboard, select the **Limits** option from the left menu.

![EC2 Limits location](../../../.gitbook/assets/wmng\_ec2\_limits.png)

2\. In the Limits Calculator, do the following:

* In the **Current Limit**, set the number of vCPUs you currently have for a region.
* In the **vCPUs needed**, set the required number of vCPUs for your specific deployment.

Select the **Request on-demand limit increase** link to get more vCPUs.

{% hint style="info" %}
vCPU increase is not an instant action and can take minutes to days for AWS to evaluate and approve your request.
{% endhint %}

The following example shows the required vCPUs for a six servers cluster with two clients of type i3en.2xlarge. This example is the smallest type of instance for a WEKA system deployment.

![Limits Calculator](../../../.gitbook/assets/wmng\_limit\_calc.png)

## After the installation on AWS best practices&#x20;

### Backup and recovery

#### Resiliency

The Weka system is a distributed cluster protected from 2 or 4 failure domain failures, providing fast rebuild times. For details, see the [About the WEKA system](../../../weka-system-overview/about/) section.

#### Instance failure

If an instance failure occurs, the Weka system rebuilds the data. Add a new instance to the cluster to regain the reduced compute and storage due to the instance failure.

#### Upload snapshots to S3

It is advisable to use periodic (incremental) snapshots to back up the data and protect it from multiple EC2 instances failures.

The recovery point objective (RPO) is determined by the cadence in which the snapshots are taken and uploaded to S3. The RPO changes between the type of data, regulations, and company policies, but it is advisable to upload at least daily snapshots of the critical filesystems. For details, see the [Snap-To-Object](../../../weka-filesystems-and-object-stores/snap-to-obj/) section.

If a failure occurs and it is required to recover from a backup, spin up a cluster using the [Self-Service Portal](self-service-portal.md) or [CloudFormation](cloudformation.md), and create filesystems from those snapshots. You do not need to wait for the data to reach the EC2 volumes. It is instantly accessible through S3. The recovery time objective (RTO) for this operation mainly depends on the time it takes to deploy the [Cluster CloudFormation stack](self-service-portal.md#cluster-cloudformation-stack) and is typically below 30 min.

#### Cross AZ failure

See the [Data protection against cloud availability zone failures](../../../weka-filesystems-and-object-stores/snap-to-obj/#data-protection-against-cloud-availability-zone-failures) section.&#x20;

#### Region failure

Using Weka snapshots uploaded to S3 combined with S3 cross-region replication enables protection from an AWS region failure.

### SSH keys rotation

For security reasons, it is advisable to rotate the SSH keys used for the EC2 instances.&#x20;

To rotate the SSH keys, follow these steps:&#x20;

* [Adding or replacing a key pair for your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#replacing-key-pair), and
* [How to use AWS Secrets Manager to securely store and rotate SSH key pairs](https://aws.amazon.com/blogs/security/how-to-use-aws-secrets-manager-securely-store-rotate-ssh-key-pairs/).



**Related topic**

[supported-ec2-instance-types.md](../supported-ec2-instance-types.md "mention")
