---
description: >-
  This section provides the detailed instructions on how to install a Weka
  filesystem in AWS.
---

# AWS Installation

## Before You Begin

If you already have an AWS account and are familiar with AWS's basic concept and services you can skip this section.

To deploy a Weka cluster in AWS, you will need to [create an AWS account](https://aws.amazon.com/account/).

You should be familiar with the following concepts and services that will be used as part of the Weka cluster deployment:

* [IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html) - Identity and access management
* [VPCs](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html), [subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html) and [security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
* [EC2](https://aws.amazon.com/documentation/ec2/) instances and [ssh keys](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* [S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html) - Object storage \(to be used for tiering data\) 
* [Cloud Formation](https://aws.amazon.com/documentation/cloudformation/)

## SSH Keys Rotation

For security reasons, it is advisable to rotate the SSH keys used for the EC2 instances. 

To rotate the SSH keys, follow these steps \(as described [here](https://aws.amazon.com/blogs/security/how-to-rotate-access-keys-for-iam-users/)\):

1. Create a second access key in addition to the one in use.
2. Update all your applications to use the new access key and validate that the applications are working.
3. Change the state of the previous access key to inactive.
4. Validate that your applications are still working as expected.
5. Delete the inactive access key.



