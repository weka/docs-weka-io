---
title: Hyperpod-Slurm-Deploy-Weka
---

## Deploy WEKA Cluster using Terraform

You can deploy a WEKA cluster using Terraform by choosing one of the following methods:

* Refer to the comprehensive documentation provided in [weka-installation-on-aws-using-terraform](../../planning-and-installation/aws/weka-installation-on-aws-using-terraform/ "mention").\
  This option is ideal if you are new to the process and require detailed guidance, including explanations of the concepts involved.
* Follow the concise step-by-step instructions provided below.\
  This option assumes you are already familiar with the subject and are looking for a quick reference.

**Step 1: Set up the Terraform working directory**

1. Create a directory to use as your Terraform working directory.
2. Inside this directory, create a file named `main.tf` and paste the following configuration:provider "aws" {

<pre class="language-hcl"><code class="lang-hcl">provider "aws" {
    region = "&#x3C;AWS region>"
}

<strong>module "deploy_weka" {
</strong>  source                        = "weka/weka/aws"
  weka_version                  = "&#x3C;WEKA SW Version>"
  get_weka_io_token             = "&#x3C;get weka token>"
  key_pair_name                 = "&#x3C;key pair>"
  prefix                        = "&#x3C;cluster prefix>"
  cluster_name                  = "&#x3C;cluster name>"
  cluster_size                  = 6
  instance_type                 = "i3en.6xlarge"
  sg_ids                        = ["sg-xxxxxxxxxxxxxxxxx"]
  subnet_ids                    = ["subnet-xxxxxxxxxxxxxxxxx"]
  vpc_id                        = "vpc-xxxxxxxxxxxxxxxxx"
  alb_additional_subnet_id      = "subnet-yyyyyyyyyyyyyyyyyy"
  use_placement_group           = false
  assign_public_ip              = false
  set_dedicated_fe_container    = false
  secretmanager_create_vpc_endpoint = true
  tiering_enable_obs_integration = true
}

output "deploy_weka_output" {
  value = module.deploy_weka
}
</code></pre>

**Step 2: Update the Terraform configuration file**

Update the following variables in the `main.tf` file with the required values:

| Variable                   | Description                                                                                                                                                                                                                                         | Example/Options                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| AWS region                 | AWS region to deploy WEKA                                                                                                                                                                                                                           | Example: eu-west-1                                                                            |
| `weka_version`             | WEKA software version to deploy. Must be version `4.2.15` or later. Available at [https://get.weka.io/](https://get.weka.io/).                                                                                                                      | Example: `4.4.2`                                                                              |
| `get_weka_io_token`        | Token retrieved from [https://get.weka.io/](https://get.weka.io/).                                                                                                                                                                                  | Example: `H5BPF1ssQrstCVz@get.weka.io`                                                        |
| `key_pair_name`            | Name of an existing EC2 key pair for SSH access.                                                                                                                                                                                                    |                                                                                               |
| `prefix`                   | <p>A prefix used for naming cluster resources.</p><p>The prefix and <code>cluster_name</code> are concatenated with a hyphen (<code>-</code>) to form the names of resources created by the WEKA Terraform module.</p>                              | Example: `weka`                                                                               |
| `cluster_name`             | Suffix for cluster resource names.                                                                                                                                                                                                                  | Example: `cluster`                                                                            |
| `cluster_size`             | <p>Number of instances for the WEKA cluster backends.</p><p>Minimum: <code>6</code>.</p>                                                                                                                                                            | Example: `6`                                                                                  |
| `instance_type`            | Instance type for WEKA cluster backends.                                                                                                                                                                                                            | Options: `i3en.2xlarge`, `i3en.3xlarge`, `i3en.6xlarge`, `i3en.12xlarge`, or `i3en.24xlarge`. |
| `sg_ids`                   | <p>A list of security group IDs for the cluster. These IDs are typically generated based on the CloudFormation stack name.<br>By default, the naming convention follows the format: <code>sagemaker-hyperpod-SecurityGroup-xxxxxxxxxxxxx</code></p> | Example: `["sg-1d2esy4uf63ps5", "sg-5s2fsgyhug3tps9"]`                                        |
| `subnet_ids`               | <p>A list of private subnet IDs where the SageMaker HyperPod cluster will be deployed.</p><p>These subnets must exist within the same VPC as the cluster and be configured for private communication.</p>                                           | Example: `["subnet-0a1b2c3d4e5f6g7h8", "subnet-1a2b3c4d5e6f7g8h9"]`                           |
| `vpc_id`                   | <p>The ID of the Virtual Private Cloud (VPC) where the SageMaker HyperPod cluster will be deployed.</p><p>The VPC must accommodate subnets, security groups, and other related resources.</p>                                                       | Example: `vpc-123abc456def`                                                                   |
| `alb_additional_subnet_id` | Private subnet ID in a different availability zone for load balancing.                                                                                                                                                                              | Example: `[subnet-9a8b7c6d5e4f3g2h1]`                                                         |

**Step 3: Deploy the WEKA cluster**

1.  Initialize Terraform:

    ```bash
    terraform init
    ```
2.  Plan the deployment:

    ```bash
    terraform plan
    ```
3.  Apply the configuration to deploy the WEKA cluster:

    <pre class="language-bash"><code class="lang-bash"><strong>terraform apply
    </strong></code></pre>

    Confirm the deployment when prompted.

**Step 4: Verify deployment**

Ensure the WEKA cluster is fully deployed before proceeding. It may take several minutes for the configuration to complete after Terraform finishes executing.
