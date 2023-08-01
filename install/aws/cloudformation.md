---
description: >-
  This page shows how to create CloudFormation templates using an API call. The
  same API calls are used by the Self-Service Portal to generate the
  CloudFormation template before redirecting to AWS.
---

# CloudFormation template generator

## Before you begin

The APIs described here require an API token which can be obtained at [https://get.weka.io/ui/account/api-tokens](https://get.weka.io/ui/account/api-tokens). Obtaining this token requires registration if you do not have an account.

## API overview

To generate a CloudFormation template, it is first necessary to decide which WEKA system version is to be installed. This is performed using the `https://<token>@get.weka.io/dist/v1/release` API which provides a list of all available versions:

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
**Note:** Usually, a request for more results is not necessary, since the first page contains the most recent releases.
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

In the example above, a template is generated for a cluster with 10 `i3en.2xlarge` backend instances and 2 `r3.xlarge` client instances. For details, see the [Deployment Types](deployment-types.md) and  [Supported EC2 instance types](supported-ec2-instance-types.md) sections.

## Request body

The `https://<token>@get.weka.io/dist/v1/aws/cfn/<version>` API provides a JSON object with a `cluster` property. `cluster` is a list of instance types, roles, and counts:

<table data-header-hidden><thead><tr><th width="202">Property</th><th>Description</th></tr></thead><tbody><tr><td><strong>Property</strong></td><td><strong>Description</strong></td></tr><tr><td><code>role</code></td><td>Either <code>backend</code> or <code>client</code>.<br>See the <a href="deployment-types.md">Deployment Types</a> section.</td></tr><tr><td><code>instance_type</code></td><td>One of the supported instance types, according to the <code>role</code> and supported instances.<br>See the <a href="supported-ec2-instance-types.md">Supported EC2 Instance Types</a> section.</td></tr><tr><td><code>count</code></td><td>The number of instances of this type to include in the template.</td></tr><tr><td><code>ami_id</code></td><td>When <code>role</code> is <code>client,</code> it is possible to specify a custom AMI-ID. <br>For details, see the <a href="cloudformation.md#custom-client-ami">Custom Client AMI</a> section.</td></tr><tr><td><code>net</code></td><td>Either <code>dedicated</code> or <code>shared</code>, in <code>client</code> role only. <br>For details, see the <a href="cloudformation.md#dedicated-vs.-shared-client-networking">Dedicated vs. shared client networking</a> section.</td></tr></tbody></table>

It is possible to specify multiple groups of instances by adding more `role`/`instance_type`/`count` objects to the `cluster`array, as long as there are at least 6 backend instances (the minimum number of backend instances required to deploy a cluster).

### Custom client AMI

When specifying an `ami_id` in `client` groups, the specified AMI will be used when launching the client instances. The Weka system will be installed on top of this AMI in a separate EBS volume.

When `ami_id` is not specified, the client instances are launched with the latest Amazon Linux supported by the Weka system version selected to be installed.

Note the following when using a custom AMI-ID:

* AMIs are stored per region. Make sure to specify an AMI-ID that matches the region in which the CloudFormation template is deployed.
* The AMI operating system must be one of the supported operating systems listed in the [Prerequisites and compatibility](../../support/prerequisites-and-compatibility.md#operating-system) section of the version installed. If the AMI defined is not supported or has an unsupported operating system, the installation may fail, and the CloudFormation stack will not be created successfully.

### Dedicated vs. shared client networking

By default, both client and backend instances are launched in the dedicated networking mode. Although this cannot be changed for backends, it can be controlled for client instances.

Dedicated networking means an ENI is created for internal cluster traffic in the client instances. This allows the WEKA system to bypass the kernel and provide throughput only limited by the instance network.

In shared networking, the client shares the instance’s network interface with all traffic passing through the kernel. Although slower, this mode is sometimes desirable when an ENI cannot be allocated or if the operating system does not allow more than one NIC.

## Returned result

The returned result is a JSON object with two properties: `url` and `quick_create_stack`.

The `url` property is a URL to an S3 object containing the generated template.

To deploy the CloudFormation template through the AWS console, a `quick_create_stack` property contains links to the console for each public AWS region. These links are pre-filled with your API token as a parameter to the template.

{% hint style="info" %}
**Note:** CloudFormation template URLs are valid for up to 1 week.
{% endhint %}

It is also possible to receive the template directly from the API call without saving it in a bucket. To do this, use a `?type=template`query parameter:

```bash
$ spec='...'  # same as above
$ curl -X POST -H 'Content-Type: application/json' -d "$spec" https://<token>@get.weka.io/dist/v1/aws/cfn/3.6.1?type=template
{"AWSTemplateFormatVersion": "2010-09-09", ...
```

## CloudFormation template parameters

The  CloudFormation stack parameters are described in the [Cluster CloudFormation Stack](self-service-portal.md#cluster-cloudformation-stack) section.

## IAM role created in the template

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
* `s3:ListBucket`

## Additional operations

Once a CloudFormation template has been generated, it is possible to create a stack using the AWS console or the AWS CLI.

When the deployment is complete, the stack status will update to `CREATE_COMPLETE,` and it is possible to access the Weka system cluster GUI by going to the Outputs tab of the CloudFormation stack and clicking the GUI link.

{% hint style="info" %}
If there is a valid entitlement or PAYG plan in [get.weka.io](https://get.weka.io), the stack attempts to create a license, deploy it to the cluster, and start IO automatically.&#x20;

With that, a filesystem is created and mounted on all instances. This shared filesystem is mounted on `/mnt/weka` in each cluster instance.
{% endhint %}

If the deployment was unsuccessful, see [Troubleshooting](troubleshooting.md) for the resolution of common deployment issues.
