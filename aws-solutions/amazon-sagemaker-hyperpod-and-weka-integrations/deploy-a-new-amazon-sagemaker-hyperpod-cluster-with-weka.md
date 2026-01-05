---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/aws-solutions/amazon-sagemaker-hyperpod-and-weka-integrations/deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka
---

# Deploy a new Amazon SageMaker HyperPod cluster with WEKA

## Deployment workflow for new Amazon SageMaker Hyperpod cluster

1. [Prepare the environment for deployment](deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka.md#prepare-the-environment-for-deployment).
2. [Deploy WEKA cluster using Terraform](deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka.md#deploy-weka-cluster-using-terraform).
3. [Create Amazon SageMaker HyperPod cluster](deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka.md#create-amazon-sagemaker-hyperpod-cluster).

### Prepare the environment for deployment

1. Deploy AWS CloudFormation template (or an equivalent) to create the prerequisites for the Amazon SageMaker HyperPod cluster.
   1. The AWS CloudFormation template can be found at: [Amazon SageMaker HyperPod > 0. Prerequisites > 2. Own Account](https://catalog.workshops.aws/sagemaker-hyperpod/en-US/00-setup/02-own-account#in-your-own-account).
   2. Ensure the optional parameter **"Availability zone ID to deploy the backup private subnet"** is configured with a valid entry. If the AWS CloudFormation template has already been deployed, update the existing stack using the existing template.
2. Retrieve the token[^1] required for the WEKA package installation by accessing the WEKA download command at: [https://get.weka.io/](https://get.weka.io/).
3.  Edit the **sagemaker-hyperpod-SecurityGroup** rule created by the AWS CloudFormation template. Add the following inbound rules to allow access from your management workstation's CIDR range:

    * **TCP port 22** (SSH)
    * **TCP port 14000** (WEKA UI)

    This ensures that your management workstation can connect securely to the cluster.

### Deploy WEKA cluster using Terraform

You can deploy a WEKA cluster using Terraform by choosing one of the following methods:

* Refer to the comprehensive documentation provided in [aws](../../planning-and-installation/aws/ "mention").\
  This option is ideal if you are new to the process and require detailed guidance, including explanations of the concepts involved.
* Follow the concise step-by-step instructions provided below.\
  This option assumes you are already familiar with the subject and are looking for a quick reference.

**Step 1: Set up the Terraform working directory**

1. Create a directory to use as your Terraform working directory.
2. Inside this directory, create a file named `main.tf` and paste the following configuration:

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

|                            |                                                                                                                                                                                                                                |                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- |
| AWS region                 | AWS region to deploy WEKA                                                                                                                                                                                                      | Example: eu-west-1                                                                            |
| `weka_version`             | WEKA software version to deploy. Must be version `4.2.15` or later. Available at [https://get.weka.io/](https://get.weka.io/).                                                                                                 | Example: `4.4.2`                                                                              |
| `get_weka_io_token`        | Token retrieved from [https://get.weka.io/](https://get.weka.io/).                                                                                                                                                             | Example: `H5BPF1ssQrstCVz@get.weka.io`                                                        |
| `key_pair_name`            | Name of an existing EC2 key pair for SSH access.                                                                                                                                                                               | ​                                                                                             |
| `prefix`                   | A prefix used for naming cluster resources.The prefix and `cluster_name` are concatenated with a hyphen (`-`) to form the names of resources created by the WEKA Terraform module.                                             | Example: `weka`                                                                               |
| `cluster_name`             | Suffix for cluster resource names.                                                                                                                                                                                             | Example: `cluster`                                                                            |
| `cluster_size`             | Number of instances for the WEKA cluster backends.Minimum: `6`.                                                                                                                                                                | Example: `6`                                                                                  |
| `instance_type`            | Instance type for WEKA cluster backends.                                                                                                                                                                                       | Options: `i3en.2xlarge`, `i3en.3xlarge`, `i3en.6xlarge`, `i3en.12xlarge`, or `i3en.24xlarge`. |
| `sg_ids`                   | A list of security group IDs for the cluster. These IDs are typically generated based on the CloudFormation stack name. By default, the naming convention follows the format: `sagemaker-hyperpod-SecurityGroup-xxxxxxxxxxxxx` | Example: `["sg-1d2esy4uf63ps5", "sg-5s2fsgyhug3tps9"]`                                        |
| `subnet_ids`               | A list of private subnet IDs where the SageMaker HyperPod cluster will be deployed.These subnets must exist within the same VPC as the cluster and be configured for private communication.                                    | Example: `["subnet-0a1b2c3d4e5f6g7h8", "subnet-1a2b3c4d5e6f7g8h9"]`                           |
| `vpc_id`                   | The ID of the Virtual Private Cloud (VPC) where the SageMaker HyperPod cluster will be deployed.The VPC must accommodate subnets, security groups, and other related resources.                                                | Example: `vpc-123abc456def`                                                                   |
| `alb_additional_subnet_id` | Private subnet ID in a different availability zone for load balancing.                                                                                                                                                         | Example: `[subnet-9a8b7c6d5e4f3g2h1]`                                                         |



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

### Create Amazon SageMaker HyperPod cluster

1.  **Clone the WEKA cloud solutions repository**\
    Download the repository from GitHub:

    ```bash
    git clone https://github.com/weka/cloud-solutions/
    ```
2.  **Navigate to the SageMaker HyperPod directory**\
    Change to the relevant directory:

    ```bash
    cd cloud-solutions/aws/sagemaker-hyperpod
    ```
3. **Verify AWS cli region configuration**

```
aws configure list
```

Verify the region listed is the desired region for the SageMaker Hyperpod cluster. If it is not correct, set the AWS\_REGION environment variable to the correct region.

```
export AWS_REGION=<desired region>
```

4. **Set Cluster Configuration**\
   Run the script to set environment variables that defines the SageMaker Hyperpod cluster.

```
./set_env_vars.sh <Cloud_Formation_Stack>
```

* `Cloud_Formation_Stack`: Name of the existing CloudFormation stack.

4. **Source environment variables**

```
source env_vars
```

5. **Create the cluster**\
   Run the deploy script:

```bash
./deploy.sh <ALB_NAME> <WEKA_FS_NAME>
```

* `ALB_NAME`: Obtain this from the AWS Console or Terraform output. It is a DNS name.
* `WEKA_FS_NAME`: Obtain this from the WEKA UI. The default filesystem name is default.

6. **Monitor cluster creation**\
   Track the cluster creation process:

```bash
aws sagemaker list-clusters --output table
```

7. **Continue setup**\
   Proceed with the setup by following Section 1, Step E of the [Amazon SageMaker HyperPod workshop.](https://catalog.workshops.aws/sagemaker-hyperpod/en-US/01-cluster/04-consolehttps://catalog.workshops.aws/sagemaker-hyperpod/en-US/01-cluster/04-console)\
   The WEKA filesystem is mounted at `/mnt/weka` on all SageMaker HyperPod nodes.

[^1]: **Token structure**\
    `<access key>@get.weka.io`
