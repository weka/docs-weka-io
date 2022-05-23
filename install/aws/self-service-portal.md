---
description: >-
  This page presents working with the Weka Self-Service Portal when installing
  the Weka system in AWS.
---

# Self-service portal

## Overview

The Weka Self-Service Portal is a planning tool for Weka clusters to meet storage requirements when installing in AWS.

It is possible to start by just entering the capacity required, configuring advanced parameters such as required performance and even provision of a multi-AZ cluster for added reliability.

Each configuration can be immediately deployed as a CloudFormation stack by redirecting to the AWS console.

{% hint style="info" %}
**Note:** CloudFormation should only be used for initial deployment. To expand cluster resources, refer to [Expanding & Shrinking Cluster Resources](../../usage/expanding-and-shrinking-cluster-resources/).
{% endhint %}

Once the cluster is deployed:

1. Refer to [Managing the Weka System ](broken-reference)for getting started with Weka CLI and GUI.
2. Refer to [Performing the First IO](../../getting-started-with-weka/performing-the-first-io.md) to quickly get familiar with creating, mounting, and writing to a WekaFS filesystem.

## Plan a cluster

The Self-Service Portal is available at [https://start.weka.io](https://start.weka.io/). Its main screen is divided into two panes: the left pane, which is used for input requirements, and the right pane which displays possible configurations for the defined requirements.

![Self-Service Portal Main Screen](../../.gitbook/assets/01-calculator-overview.png)

As shown in the screen above, configuration options include the total capacity, the desired deployment model, and additional performance requirements. For more information about deployment types, refer to [Deployment Types](deployment-types.md).

## Deploy a cluster

Once the configuration to be deployed has been found, click the Deploy to AWS button next to the desired configuration. At this point, it is possible to specify additional options for the deployment, such as adding client instances or selecting the Weka system version to be deployed.

![Additional Deployment Options Dialog Box](<../../.gitbook/assets/start.weka.io Deploy.png>)

Once everything is ready to deploy the cluster, click the Deploy to AWS button. This will display the AWS CloudFormation screen with a template containing the configured cluster.

{% hint style="info" %}
**Note:** Before deploying the configuration**,** please refer to the [Prerequisites for Deployment](deployment-types.md#prerequisites-for-deployment) section.
{% endhint %}

## CloudFormation screen

After clicking the Deploy to AWS button, the AWS CloudFormation screen is displayed, requiring the creation of stacks.

![AWS Create Stack Screen](../../.gitbook/assets/CF\_3\_13.png)

In the Create Stack screen, define the parameters which are specific to your AWS account.

### Cluster CloudFormation stack

| **Parameter** | **Description**                                                                                        |
| ------------- | ------------------------------------------------------------------------------------------------------ |
| `Stack name`  | The name that will be given to the stack in CloudFormation. This name has to be unique in the account. |
| `SSH Key`     | The SSH-key for the `ec2-user` that will be used to connect to the instances.                          |
| `VPC`         | The VPC in which the Weka cluster will be deployed.                                                    |
| `Subnet`      | The subnet in which the Weka cluster will be deployed.                                                 |

Define the parameters for Weka cluster configuration:

| **Parameter**      | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Network Topology` | <p>Network topology of the environment:</p><ul><li><code>Public Subnet</code></li><li><code>Private subnet with NAT internet routing</code> </li><li><code>Private subnet using Weka VPC endpoint</code> - requires to create a <a href="self-service-portal.md#prerequisites-cloudformation-stack">prerequisites stack</a> (once per VPC) that creates the required resources.</li><li><code>Private subnet using custom proxy</code> - requires to create a <a href="self-service-portal.md#prerequisites-cloudformation-stack">prerequisites stack</a> (once per VPC) that creates the required resources.</li></ul> |
| `Custom Proxy`     | A custom proxy for private network internet access. Only relevant when `Private network using custom proxy` is selected as the `Network Topology` parameter.                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `WekaVolumeType`   | Volume type for the Weka partition. `GP3` is not yet available in all zones/regions (e.g., not available in local zones). In such a case, you must select the `GP2` volume type. When available, using `GP3` is preferred.                                                                                                                                                                                                                                                                                                                                                                                              |
| `API Token`        | The API token for Weka's distribution site. This can be obtained at [https://get.weka.io/ui/account/api-tokens](https://get.weka.io/ui/account/api-tokens).                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `Admin Password`   | Sets the admin password after the cluster has been created. If no value is provided, the password is set to `admin.`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

Define the following optional parameters if tiering to S3 is desired:

| **Parameter**         | **Description**                                                                                                                                                                                                                  |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `New S3 Bucket`       | The new S3 bucket name to create and attach to the filesystem created by the template. The bucket will not be deleted when the stack is destroyed.                                                                               |
| `Existing S3 Bucket`  | The existing S3 bucket name to attach to the filesystem created by the template. The bucket has to be in the same region where the cluster is deployed. If this parameter is provided, the `New S3 Bucket` parameter is ignored. |
| `Tiering SSD Percent` | Sets how much of the filesystem capacity (in percent) should reside on SSD. This parameter is applicable only if `New S3 Bucket` or `Existing S3 Bucket` parameters have been defined.                                           |

{% hint style="info" %}
**Note:** For public subnets, make sure to select a subnet that has the Enable Auto-Assign Public IPv4 Address setting turned on, or select a subnet that has Internet connectivity.
{% endhint %}

Once all required parameters have been filled, make sure to check the "I acknowledge that AWS CloudFormation might create IAM resources” checkbox at the bottom and click the Create Stack button:

![AWS Check Box and Creation Dialog Box](<../../.gitbook/assets/3.6 CF IAM Ack.png>)

## Deploying in a Private Network

When deploying in a private network, without a NAT (using a Weka proxy or a custom proxy), some resources should be created (once) per VPC (such as Weka VPC endpoint, S3 gateway, or EC2 endpoint).&#x20;

Copy the link under the Network Topology parameter, and run it in a new browser tab. The AWS CloudFormation screen is displayed, requiring the creation of the prerequisites stack.

In the Create Stack screen, define the parameters which are specific to your AWS account.

### Prerequisites CloudFormation stack

{% hint style="info" %}
**Note:** To run this stack, `enableDnsHostnames`  and `enableDnsSupport` [DNS attributes](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html#vpc-dns-support) should be enabled for the VPC.
{% endhint %}

![AWS Create Prerequisites Stack Screen](../../.gitbook/assets/CF\_pre\_3\_13.png)

| **Parameter**      | **Description**                                                                                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Stack name`       | The name that will be given to the stack in CloudFormation. This name has to be unique in the account.                                                                         |
| `VPC`              | The VPC in which the prerequisites resources (and Weka cluster) will be deployed.                                                                                              |
| `Subnet`           | The subnet in which the prerequisites resources (and Weka cluster) will be deployed.                                                                                           |
| `RouteTable`       | Route table ID of the chosen subnet for S3 gateway creation.                                                                                                                   |
| `Network Topology` | <p></p><p>Network topology of the environment:</p><ul><li><code>Private subnet using Weka VPC endpoint</code></li><li><code>Private subnet using custom proxy</code></li></ul> |
| `S3 Gateway`       | Only choose to create an S3 Gateway if non already exist for the VPC                                                                                                           |
| `Ec2 Endpoint`     | Only choose to create an EC2 Endpoint if non already exist for the VPC                                                                                                         |

## Cluster deployment process

The cluster deployment process takes about 10 minutes. During this time, the following occurs:

1. The AWS resources required for the cluster are provisioned.
2. The Weka system is installed on each of the instances provisioned for the cluster.
3. A cluster is created using all backend instances.
4. All client instances are created.
5. A filesystem is created using all the available capacity and is mounted on all client instances. This shared filesystem is mounted on `/mnt/weka` in each of the cluster instances.

Once the deployment is complete, the CloudFormation stack status will be updated to `CREATE_COMPLETE`. At this point, it is possible to access the Weka system cluster GUI by going to the Outputs tab of the CloudFormation stack and clicking the GUI link (or by [http://\<backend-host>:14000](http://\<backend-host>:14000)).

Visit [Managing the Weka System ](broken-reference)for getting started with Weka CLI and GUI, and [Performing the First IO](../../getting-started-with-weka/performing-the-first-io.md) to quickly get familiar with creating, mounting, and writing to a WekaFS filesystem.

{% hint style="info" %}
**Note:** If the deployment is unsuccessful, see [Troubleshooting](troubleshooting.md) for how to resolve common deployment issues.
{% endhint %}
