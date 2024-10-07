---
description: >-
  This page describes the types of cluster deployments in AWS, which depend on
  the instance types being used and their configuration.
---

# Deployment types

## Deployment prerequisites&#x20;

* Check that your AWS account limits allow for the deployment of your selected configuration (it is possible to check your limits under the Limits tab in the EC2 console).
* Deploying a WEKA cluster in AWS requires at least 6 EC2 instances with SSD/NVMe drives (a.k.a instance store) and potentially additional instances that may connect as clients.
* WEKA must have access to instance metadata&#x20;
  * Only IMDSv1 is supported if using the Instance Metadata service.

{% hint style="warning" %}
It is possible to set clients with IMDSv2, but they would not benefit from seamless cloud configuration and should be manually managed similarly to [Adding Clients](../../bare-metal/adding-clients-bare-metal.md) in bare-metal installations.
{% endhint %}

* When deploying in AWS not using the CloudFormation template or when additional capabilities are added after deployment (e.g., tiering), it is required to provide permissions to several AWS APIs. For details, see the [IAM role created in the template](cloudformation.md#iam-role-created-in-the-template) section.
* Ensure the client has enough available IP addresses in the selected subnet. Each core allocated to WEKA requires an ENI.

Depending on the instance types being used and how they’re configured, there are two deployment types:

* [Client backend deployment](deployment-types.md#client-backend-deployment)
* [Converged deployment](deployment-types.md#converged-deployment)

## Client backend deployment

In a client backend deployment, two different types of instances are launched:

* **Backend Instances**: Instances that contribute to their drives and all possible CPU and network resources.
* **Client Instances**: Instances that connect to the cluster created by the backend instances and run an application using one or more shared filesystems.

In client backend deployments, it is possible to add or remove clients according to the resources required by the application at any given moment.

Backend instances can be added to increase the cluster capacity or performance. They can also be removed, provided that they are deactivated to safely allow for data migration.

{% hint style="danger" %}
Stopping or terminating backend instances causes a loss of all data of the instance store. Refer to [Amazon EC2 Instance Store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html) for more information.
{% endhint %}

## Converged deployment

Converged deployments are generic deployments in which every instance is configured to contribute resources — drives, CPUs, and/or network interfaces - to the cluster.

The deployment of a converged cluster is typically selected in the following cases:

* When using very small applications that require a high-performance filesystem but do not require many resources themselves, in which case they can use resources in the same instances storing the data.
* When cloud-bursting an application to AWS, you seek to use as many resources as possible for the application and provide as many resources as possible to the WEKA cluster to achieve maximum performance.
