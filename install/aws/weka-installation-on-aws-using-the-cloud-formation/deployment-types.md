---
description: >-
  Learn about the cluster deployment types in AWS, which are defined by the
  instance types and their configuration.
---

# Deployment types

## Deployment prerequisites&#x20;

* Check that your AWS account limits allow for the deployment of your selected configuration. You can check your limits under the Limits tab in the EC2 console.
* Deploying a WEKA cluster in AWS requires at least six EC2 instances with SSD or NVMe drives, also known as an instance store, and potentially additional instances that connect as clients.
* Ensure that WEKA has access to instance metadata. The system uses Instance Metadata Service Version 2 (IMDSv2) by default for enhanced security.
* If you deploy in AWS without using the CloudFormation template, or if you add capabilities such as tiering after deployment, provide permissions to several AWS APIs. For details, refer to the [#iam-role-created-in-the-template](cloudformation.md#iam-role-created-in-the-template "mention").
* Ensure the selected subnet has enough available IP addresses. Each core allocated to the WEKA system requires an Elastic Network Interface (ENI).

## AWS deployment types

The selection and configuration of instance types determine the two deployment types:

* [Client backend deployment](deployment-types.md#client-backend-deployment)
* [Converged deployment](deployment-types.md#converged-deployment)

## Client backend deployment

A client backend deployment uses two different instance types:

* **Backend instances:** Instances that contribute their drives and all possible CPU and network resources to the cluster.
* **Client instances:** Instances that connect to the cluster created by the backend instances and run an application using one or more shared filesystems.

In client backend deployments, you can add or remove clients according to the application's resource requirements.

You can also add backend instances to increase cluster capacity or performance. To remove backend instances, you must first deactivate them to allow for safe data migration.

{% hint style="danger" %}
Stopping or terminating backend instances causes a loss of all data of the instance store. For more information, refer to [Amazon EC2 Instance Store](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html).
{% endhint %}

## Converged deployment

In a converged deployment, every instance contributes its resources, such as drives, CPUs, and network interfaces, to the cluster.

A converged deployment is suitable for the following scenarios:

* **Small applications:** For applications with low resource requirements that need a high-performance filesystem. The application can run on the same instances that store the data.
* **Cloud-bursting:** For cloud-bursting workloads where you need to maximize resource allocation to both the application and the WEKA cluster to achieve peak performance.
