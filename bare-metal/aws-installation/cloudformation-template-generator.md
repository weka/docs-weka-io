---
description: >-
  This page shows how to create CloudFormation templates using an API call. The
  same API calls are used by the self-service portal to generate the
  CloudFormation template before redirecting to AWS.
---

# CloudFormation Template Generator

### API Overview {#api-overview}

To generate a template we first need to decide which WekaIO version to install. To do this, we’ll call the `https://get.weka.io/v` API which returns a list of all available versions:

```text
$ curl https://get.weka.io/v
[
   {
      "name": "3.1.0",
      "oss": [
         "centos72",
         "aws1709",
         "suse114",
         "centos67",
         "centos68",
         "ubuntu16",
         "centos73",
         "ubuntu14",
         "aws1703"
      ],
      "final": true,
      "timestamp": 1511292368
   },
   ...
]
```

This returns a JSON array sorted from the latest to the earliest version. The key we’ll use is the `name` attribute of the version.

To generate a CloudFormation template, we’ll make a `POST` request to the `https://get.weka.io/aws/cfn/<version>`API:

```text
$ spec='
{
  "cluster": [
    {
      "role": "backend",
      "instance_type": "i3.xlarge",
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
$ curl -X POST -H 'Content-Type: application/json' -d "$spec" https://get.weka.io/aws/cfn/3.1.0
{"url": "https://s3.amazonaws.com/wekaio-cfn-templates-prod/4ta4hnrcsednvpzcs9h17mgl6.json"}
```

In the example above we generated a template for a cluster with 10 i3.xlarge backend instances and 2 r3.xlarge client instances. You can learn more about in the [deployment types](deployment-types.md) page and see all supported instance types in [supported EC2 instance types](supported-ec2-instance-types.md).

### Request Body {#request-body}

The `https://get.weka.io/aws/cfn/<version>` API gets a JSON object with a `cluster` property. `cluster` is a list of instance types, roles and counts:

| Property | Description |
| --- | --- | --- | --- | --- | --- |
| `role` | Either `backend` or `client`, see [deployment types](deployment-types.md) for more information. |
| `instance_type` | One of the supported instance types according to the `role` and supported instances in [supported EC2 instance types](supported-ec2-instance-types.md). |
| `count` | How many instances of this type to include in the template. |
| `ami_id` | When `role` is `client` you can specify a custom AMI-ID. See _Custom Client AMI_ below to learn more. |
| `net` | Either `dedicated` or `shared`, in `client` role only. See _Dedicated vs. Shared Client Networking_ below. |

You can specify multiple groups of instances by adding more `role`/`instance_type`/`count` objects to the `cluster`array, as long as there are at least 6 backend instances as this is the minimum requirement to deploy a cluster.

#### Custom Client AMI {#custom-client-ami}

When specifying an `ami_id` in `client` groups, the specified AMI will be used when launching the client instances. WekaIO will be installed on top of this AMI in a separate EBS volume.

When `ami_id` is not specified, the client instances are launched with the latest Amazon Linux supported by the WekaIO version you chose to install.

Note the following when using a custom AMI-ID:

* AMIs are stored per-region. Make sure to specify an AMI-ID matching the region in which you’re deploying the CloudFormation template.
* The operating system of the AMI has to be one of the supported operating-systems listed in the `oss` attribute of the version you’re installing. If you provide an AMI with an unsupported or an outdated operating-system, installation might fail and the CloudFormation stack won’t be created successfully.

#### Dedicated vs. Shared Client Networking {#dedicated-vs-shared-client-networking}

Both client and backend instances are launched in dedicated networking mode by default. Although this cannot be changed for backends, you can control this behavior in client instances.

Dedicated networking means that an ENI is created for internal cluster traffic in the client instances. This allows WekaIO to bypass the kernel and provide throughput that’s only limited by the instance network.

In shared networking, the client shares the instance’s network interface with all traffic passing through the kernel. Although slower, this mode might sometimes be desired when an ENI cannot be allocated or due to operating-system limitations not allowing for more than one NIC.

### Returned Result {#returned-result}

The generated template is returned as a URL to an object in S3 containing the template, as shown in the example above. This is useful if you want to obtain a template and immediately create a stack with it.

_Note: templates are saved for up to one week._

You can also get the template directly from the API call without saving it into a bucket. To do this, pass a `type=template`query parameter:

```text
$ spec='...'  # same as above
$ curl -X POST -H 'Content-Type: application/json' -d "$spec" https://get.weka.io/aws/cfn/3.1.0?type=template
{"AWSTemplateFormatVersion": "2010-09-09", ...
```

### CloudFormation Template Parameters {#cloudformation-template-parameters}

The CloudFormation template has the following parameters:

| Parameter | Description |
| --- | --- | --- | --- |
| `KeyName` | SSH key for the `ec2-user` user on the instances |
| `VpcId` | The VPC to create the cluster in |
| `SubnetId` | The subnet to create the cluster in |

Note: `SubnetId` has to be a public subnet or a subnet that is routable to the Internet, as deployment is based on downloading WekaIO and various packages from the Internet.

### IAM Role Created In The Template {#iam-role-created-in-the-template}

The CloudFormation template contains an instance role that allows the WekaIO instances to call several AWS APIs such as `DescribeInstances` and `CreateNetworkInterface`.

These API calls are only required during installation and you can safely remove these credentials from the instance role once the CloudFormation reaches the CREATE\_COMPLETE state.

### What’s Next? {#whats-next}

After you’ve generated a CloudFormation template you can create a stack from it using the AWS console or the AWS CLI.

When the deployment is complete, the stack status will update to `CREATE_COMPLETE` and you can access the WekaIO cluster UI by going to the Outputs tab of the CloudFormation stack and clicking the link named UI.

As part of the deployment, a filesystem is created and mounted on all instances. This shared filesystem is mounted on `/mnt/weka` in each of the cluster instances.

If deployment wasn’t successful, please see [Troubleshooting](troubleshooting.md) for how to resolve common deployment issues.

