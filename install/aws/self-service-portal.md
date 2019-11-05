---
description: >-
  This page presents working with the WekaIO Self-Service Portal when installing
  the WekaIO system in AWS.
---

# Self-Service Portal

## Overview

The WekaIO Self-Service Portal is a planning tool for WekaIO clusters to meet storage requirements when installing in AWS.

It is possible to start by just entering the capacity required, configuring advanced parameters such as required performance and even provision of a multi-AZ cluster for added reliability.

Each configuration can be immediately deployed as a CloudFormation stack by redirecting to the AWS console. 

{% hint style="info" %}
**Note:** CloudFormation should only be used for initial deployment. To expand cluster resources, refer to [Expanding & Shrinking Cluster Resources](../../usage/expanding-and-shrinking-cluster-resources/).
{% endhint %}

## Planning a Cluster

The Self-Service Portal is available at [https://start.weka.io](https://start.weka.io/). Its main screen is divided into two panes: the left pane, which is used for inputting requirements, and the right pane which displays possible configurations for the defined requirements.

![Self-Service Portal Main Screen](../../.gitbook/assets/01-calculator-overview.png)

As shown in the screen above, configuration options include the total capacity, the desired deployment model and additional performance requirements. For more information about deployment types, refer to [Deployment Types](deployment-types.md).

## Deploying a Cluster

Once the configuration to be deployed has been found, click the Deploy to AWS button next to the desired configuration. At this point, it is possible to specify additional options for the deployment, such as adding client instances or selecting the WekaIO system version to be deployed.

![Additional Deployment Options Dialog Box](../../.gitbook/assets/02-deploy-cluster.png)

Once everything is ready to deploy the cluster, click the Deploy Cluster button. This will display the AWS CloudFormation screen with a template containing the configured cluster. **Before deploying the configruation,** check that your AWS account limits allow for the deployment of your selected configuration \(it is possible to check your limits under the Limits tab in the EC2 console\).

## CloudFormation Screen

After clicking the Deploy Cluster button, the AWS CloudFormation screen is displayed, requiring the creation of stacks. 

![AWS Create Stack Screen](../../.gitbook/assets/03-cloudformation-create-stack.png)

In the Create Stack screen, define the options which are specific to your AWS account:

* **Stack name** is the name that will be given to your stack in  theCloudFormation. This name has to be unique in your account.
* **KeyName** is the SSH-key that you will use to connect to the instances.
* **VpcId** and **SubnetId** are used to select the VPC and subnet in which the WekaIO system cluster will be deployed.

{% hint style="info" %}
**Important Note Concerning Internet Connectivity:** Only public subnets are currently supported by the WekaIO system. Make sure to select a subnet that has the Enable Auto-Assign Public IPv4 Address setting turned on, or select a subnet that has Internet connectivity.
{% endhint %}

Once all required parameters have been filled-in, make sure to check the "I acknowledge that AWS CloudFormation might create IAM resources” checkbox at the bottom and click the Create button:

![AWS Check Box and Creation Dialog Box](../../.gitbook/assets/04-cloudformation-iam-creds.png)

## Cluster Deployment Process

The cluster deployment process takes about 10 minutes. During this time, the following occurs:

1. The AWS resources required for the cluster are provisioned.
2. The WekaIO system is installed on each of the instances provisioned for the cluster.
3. A cluster is created using all backend instances.
4. All client instances join the cluster once the cluster has been created..
5. A filesystem is created using all the available capacity and is mounted on all backend and client instances.This shared filesystem is mounted on `/mnt/weka` in each of the cluster instances.

Once the deployment is complete, the stack status will be updated to `CREATE_COMPLETE`. At this point, it is possible to access the WekaIO system cluster GUI by going to the Outputs tab of the CloudFormation stack and clicking the GUI link. 

Visit [Managing the WekaIO System ](../../getting-started-with-wekaio/managing-wekaio-system.md)for getting started with WekaIO CLI and GUI, and, [Performing the First IO](../../getting-started-with-wekaio/performing-the-first-io.md) to quickly get familiar with creating, mounting and writing to a WekaFS filesystem.

{% hint style="info" %}
**Note:** If the deployment is unsuccessful, see [Troubleshooting](troubleshooting.md) for how to resolve common deployment issues.
{% endhint %}



