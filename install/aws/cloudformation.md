---
description: >-
  This page shows how to create CloudFormation templates using an API call. The
  same API calls are used by the Self-Service Portal to generate the
  CloudFormation template before redirecting to AWS.
---

# CloudFormation Template Generator

## Before Starting

The APIs described here require an API token which can be obtained at [https://get.weka.io/ui/account/api-tokens](https://get.weka.io/ui/account/api-tokens). Obtaining this token requires registration if you do not have an account.

## API Overview

To generate a CloudFormation template, it is first necessary to decide which Weka system version is to be installed. This is performed using the `https://<token>@get.weka.io/dist/v1/release` API which provides a list of all available versions:

```bash
$ curl https://<token>@get.weka.io/dist/v1/release
{
   "num_results" : 8,
   "page" : 1,
   "page_size" : 50,
   "num_pages" : 1,
   "objects" : [
      {
         "id" : "3.6.1",
         "public" : true,
         "final" : true,
         "trunk_id" : "",
         "s3_path" : "releases/3.6.1"
         .
         .
         .
      },
      ...
   ]
}
```

This list of releases available for installation is sorted backward from the most recent release. By default, 50 results are provided per page. To receive more results, use the `page=N` query parameter to receive the `Nth` page.

{% hint style="info" %}
**Note:** Usually, a request from more results is not necessary, since the first page contains the most recent releases.
{% endhint %}

Each release contains an ID field that identifies the release. In the examples below, version 3.6.1 has been used.

To generate a CloudFormation template, make a `POST` request to the `https://<token>@get.weka.io/dist/v1/aws/cfn/<version>`API:

```bash
$ spec='
{
  "cluster": [
    {
      "role": "backend",
      "instance_type": "i3en.2xlarge",
      "count": 10
    },
    {
      "role": "client",
      "instance_type": "r3.xlarge",
      "count": 2
    }
  ]
}
'
$ curl -X POST -H 'Content-Type: application/json' -d "$spec" https://<token>@get.weka.io/dist/v1/aws/cfn/3.6.1
{
   "url" : "https://wekaio-cfn-templates-prod.s3.amazonaws.com/cjibjp7ps000001o9pncqywv6.json",
   "quick_create_stack" : {
      "ap-southeast-2" : "...",
      ...
   }
}
```

In the example above, a template was generated for a cluster with 10 `i3en.2xlarge` backend instances and 2 `r3.xlarge` client instances. Refer to the [Deployment Types](deployment-types.md) page to learn more, and see all supported instance types in [Supported EC2 Instance Types](supported-ec2-instance-types.md).

## Request Body

The `https://<token>@get.weka.io/dist/v1/aws/cfn/<version>` API provides a JSON object with a `cluster` property. `cluster` is a list of instance types, roles, and counts:

| **Property**    | **Description**                                                                                                                                                     |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `role`          | Either `backend` or `client;`see [Deployment Types](deployment-types.md) for more information.                                                                      |
| `instance_type` | One of the supported instance types according to the `role` and supported instances in [Supported EC2 Instance Types](supported-ec2-instance-types.md).             |
| `count`         | The number of instances of this type to be included in the template.                                                                                                |
| `ami_id`        | When `role` is `client,` it is possible to specify a custom AMI-ID. See [Custom Client AMI](cloudformation.md#custom-client-ami) below to learn more.               |
| `net`           | Either `dedicated` or `shared`, in `client` role only. See [Dedicated vs. Shared Client Networking](cloudformation.md#dedicated-vs-shared-client-networking) below. |

It is possible to specify multiple groups of instances by adding more `role`/`instance_type`/`count` objects to the `cluster`array, as long as there are at least 6 backend instances (the minimum number of backend instances required to deploy a cluster).

### Custom Client AMI

When specifying an `ami_id` in `client` groups, the specified AMI will be used when launching the client instances. The Weka system will be installed on top of this AMI in a separate EBS volume.

When `ami_id` is not specified, the client instances are launched with the latest Amazon Linux supported by the Weka system version selected to be installed.

Note the following when using a custom AMI-ID:

* AMIs are stored per region. Make sure to specify an AMI-ID that matches the region in which the CloudFormation template is being deployed.
* The AMI operating system must be one of the supported operating systems listed in the [prerequisites](../prerequisites-for-installation-of-weka-dedicated-hosts.md#operating-system) page of the version being installed. If the AMI defined is not supported or has an unsupported operating system, the installation may fail and the CloudFormation stack will not be created successfully.

### Dedicated vs. Shared Client Networking

By default, both client and backend instances are launched in the dedicated networking mode. Although this cannot be changed for backends, it can be controlled for client instances.

Dedicated networking means that an ENI is created for internal cluster traffic in the client instances. This allows the Weka system to bypass the kernel and provide throughput that is only limited by the instance network.

In shared networking, the client shares the instance’s network interface with all traffic passing through the kernel. Although slower, this mode is sometimes desirable when an ENI cannot be allocated or if the operating system does not allow more than one NIC.

## Returned Result

The returned result is a JSON object with two properties: `url` and `quick_create_stack`.

The `url` property is a URL to an S3 object containing the generated template.

To deploy the CloudFormation template through the AWS console, a `quick_create_stack` property contains links to the console for each public AWS region. These links are pre-filled with your API token as a parameter to the template.

{% hint style="info" %}
**Note:** CloudFormation template URLs are valid for up to 1 week.
{% endhint %}

It is also possible to receive the template directly from the API call, without saving it in a bucket. To do this, use a `?type=template`query parameter:

```bash
$ spec='...'  # same as above
$ curl -X POST -H 'Content-Type: application/json' -d "$spec" https://<token>@get.weka.io/dist/v1/aws/cfn/3.6.1?type=template
{"AWSTemplateFormatVersion": "2010-09-09", ...
```

## CloudFormation Template Parameters

The  CloudFormation stacks parameters are described in the [Cluster CloudFormation Stack](self-service-portal.md#cluster-cloudformation-stack) section.

## IAM Role Created in the Template

The CloudFormation template contains an instance role that allows the Weka system instances to call the following AWS APIs:

* `ec2:DescribeInstances`
* `ec2:DescribeNetworkInterfaces`
* `ec2:AttachNetworkInterface`
* `ec2:CreateNetworkInterface`
* `ec2:ModifyNetworkInterfaceAttribute`
* `ec2:DeleteNetworkInterface`

In case tiering is configured, additional AWS APIs permissions are given:

* `s3:DeleteObject`
* `s3:GetObject`
* `s3:PutObject`
* `s3:HeadBucket`
* `s3:ListBucket`

## Additional Operations

Once a CloudFormation template has been generated, it is possible to create a stack from it using the AWS console or the AWS CLI.

When the deployment is complete, the stack status will update to `CREATE_COMPLETE` and it is possible to access the Weka system cluster GUI by going to the Outputs tab of the CloudFormation stack and clicking the GUI link.

{% hint style="info" %}
**Notes:**

As part of the deployment, a filesystem is created and mounted on all instances. This shared filesystem is mounted on `/mnt/weka` in each of the cluster instances.

If the deployment was unsuccessful, see [Troubleshooting](troubleshooting.md) for the resolution of common deployment issues.
{% endhint %}
