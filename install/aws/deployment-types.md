---
description: >-
  This page describes the types of cluster deployments in AWS, which depend on
  the instance types being used and their configuration.
---

# Deployment Types

## Prerequisites for Deployment

* Deploying a WekaIO cluster in AWS requires at least 6 EC2 instances with SSD/NVMe drives \(a.k.a instance store\), and potentially additional instances that may connect as clients.
* WekaIO must have access to instance metadata 
  * Only IMDSv1 is supported if using the Instance Metadata service.

{% hint style="warning" %}
**Note:** It is possible to set client hosts with IMDSv2, but, they would not benefit from seamless cloud configuration and should be manually managed similarly to [Adding Clients](../bare-metal/adding-clients-bare-metal.md) in bare-metal installations.
{% endhint %}

Depending on the instance types being used and how they’re configured, there are two deployment types:

* [Client backend deployment](deployment-types.md#client-backend-deployment)
* [Converged deployment](deployment-types.md#converged-deployment)

## Client Backend Deployment

In a client backend deployment, two different types of instances are launched:

* **Backend Instances**: Instances that contribute their drives and all possible CPU and network resources.
* **Client Instances**: Instances that connect to the cluster created by the backend instances and run an application using one or more shared filesystems.

In client backend deployments, it is possible to add or remove clients according to the resources required by the application at any given moment.

Backend instances can be added to increase the cluster capacity or performance. They can also be removed, provided that they are deactivated to safely allow for data migration. 

{% hint style="danger" %}
**Note:** Stopping or terminating backend instances causes a loss of all data of the instance store. Refer to [Amazon EC2 Instance Store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html) for more information.
{% endhint %}

## Converged Deployment

Converged deployments are more generic deployments in which every instance is configured to contribute resources of some kind — drives, CPUs and/or network interfaces - to the cluster.

The deployment of a converged cluster is typically selected in the following cases:

* When using very small applications that require a high-performance filesystem but do not require many resources themselves, in which case they can use resources in the same instances storing the data.
* When cloud-bursting an application to AWS, in which case you seek to utilize as many resources as possible for the application but also seek to provide as many resources as possible to the WekaIO system cluster, in order to achieve maximum performance.

