# AWS-WEKA Terraform deployment module description

AWS-WEKA Terraform package is an open-source repository located on [GitHub](https://github.com/weka/terraform-aws-weka/tree/main). It contains modules and examples to customize the WEKA cluster installation on AWS. The default protocol deployed using the Terraform package is POSIX.

The AWS-WEKA Terraform package supports public and private cloud deployments. All deployment types require passing the `get.weka.io` token to Terraform for downloading the WEKA release from the public [get.weka.io](https://get.weka.io) service.

{% hint style="info" %}
The WEKA release can only be downloaded over the internet if the private cloud network has NAT Gateway associated.
{% endhint %}

## AWS-WEKA Terraform package components

The AWS-WEKA Terraform package consists of the following components:

* **Required module:**
  * WEKA Root Module located in the main Terraform package.
* **Optional sub-modules:**
  * **protocol\_gateways:** Enables creating dedicated WEKA Frontend servers for protocol access (NFS, SMB, or SMB-W).
  * **clients:** Enables creating stateless WEKA clients that automatically join the WEKA cluster during cluster creation. The WEKA clients host applications or workloads.
  * **endpoints:** Creates private network VPC endpoints, including EC2 VPC endpoints, S3 gateway, Lambda VPC endpoint, WEKA proxy VPC endpoint, and a security group to open port 1080 for the WEKA proxy VPC endpoint.
  * **IAM:** Creates IAM roles for EC2 instances, CloudWatch events, WEKA Lambda functions, and Step Function. IAM roles can be created in advance, or if module variables are unspecified, WEKA automatically creates them.
  * **network:** Creates VPC, Internet Gateway/NAT, public/private subnets, and so on if pre-existing network variables are not supplied in advance.
  * **security\_group:** Automatically creates the required security group if not provided in advance.

### Terraform example

The following is a basic example in which you provide the minimum detail of your cluster, and the Terraform module completes the remaining required resources, such as VPC, subnets, security group, placement group, DNS zone, and IAM roles.

You can use this example as a reference to set the `main.tf` file.

```
terraform {
  required_version = ">= 1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.5.0"
    }
  }
}

provider "aws" {
}

module "weka_deployment" {
  source             = "weka/weka/aws"
  version            = "1.0.1"  
  prefix             = "weka-tf"
  cluster_name       = "poc"
  availability_zones = ["eu-west-1c"]
  allow_ssh_cidrs    = ["0.0.0.0/0"]
  get_weka_io_token  = "Your get.weka.io token"
}

output "weka_deployment_output" {
  value = module.weka_deployment
}
```
