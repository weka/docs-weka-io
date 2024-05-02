# Detailed deployment tutorial: WEKA on AWS using Terraform

## Introduction

#### Document Purpose

To guide customers, partners, WEKA teams (sales, customer success, etc.) through the step by step process of deploying the WEKA data platform in AWS using Terraform.

#### Document Premise

Deploying WEKA in AWS requires knowledge of several technologies, specifically AWS, Terraform (infrastructure-as-code provisioning manager), basic Linux operations, and WEKA software. Understanding that not everyone tasked with deploying WEKA in AWS will have experience in each required domain, this document seeks to provide an end-to-end instruction set that allows its reader to successfully deploy a working WEKA cluster in AWS with minimal knowledge or prerequisites.

#### Document Scope

This document focuses on deploying WEKA in an AWS environment using Terraform for a POC or Production environment. While no pre-created AWS elements are needed beyond an appropriate user account, this guide will showcase using some pre-created elements in the deployment.

The reader will be guided through general AWS requirements, the AWS networking requirements needed to support WEKA, using Terraform to deploy WEKA, and verifying a successful WEKA deployment.

{% hint style="info" %}
The images embedded in this document can appear small when viewed in-line with the document. Clicking on the image will enlarge it to its original size for easier viewing.
{% endhint %}

## Terraform Preparation and Installation

HashiCorp Terraform is a tool that allows you to define, provision, and manage infrastructure as code. Instead of manually setting up servers, databases, networks, and other infrastructure components, you describe what you want in a configuration file using a declarative configuration language, HashiCorp Configuration Language (HCL), or optionally JSON. Once the desired infrastructure configuration is described in this file, Terraform can automatically create, modify, or delete resources to match the file specifications. This ensures that the infrastructure is consistently and predictably deployed.

This document describes the WEKA Data Platform automated deployment in AWS using Terraform. Our choice of Terraform was influenced by its widespread consumer adoption and ubiquity in the Infrastructure as Code (IaC) space. It is commonly embraced by organizations globally, large and small, to deploy stateful infrastructure on-premises and in public clouds such as AWS, Azure, or Google Cloud Platform.

_Please note that_ [_WEKA can also be deployed in AWS using AWS CloudFormation_](https://start.weka.io/)_, allowing customers to select their preferred deployment method._

To install Terraform, we recommend following the [official guides](https://developer.hashicorp.com/terraform/install) published by HashiCorp.

#### AWS Account

Proceed with the following steps to locate the appropriate AWS Account.

Navigate to the AWS Management Console. In the top right corner, search for “Account ID.”

<figure><img src="../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
If deploying into a WEKA customer environment, the customer should understand their subscription structure. If deploying internally at WEKA and you do not see an Account ID or have not been added to the correct Account, please reach out to the customer appropriate cloud teams for assistance.
{% endhint %}

### User Account Privileges

To carry out the necessary operations for a successful WEKA deployment in AWS using Terraform, you must ensure that an [AWS IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id\_users.html) has the appropriate permissions listed in **Appendix B** below (i.e., the Appendices section). The IAM user must be permitted to create, modify, and delete AWS resources as dictated by Terraform Configuration Files used for WEKA deployment.

If the current IAM user does not have these permissions, it is advisable to either update the permissions or create a new IAM user with the required privileges.

Follow the steps below to verify IAM user privileges.

#### Confirming AWS IAM User Permissions

* Navigate to the AWS Management Console.
* Log in using the account that will be used for the entirety of the WEKA deployment.
* In the AWS Management Console, go to the Services menu and select “IAM” to access the Identity and Access Management dashboard.

<figure><img src="../../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

* Within the IAM dashboard, search for the IAM user in question or navigate to the “Users” section.

<figure><img src="../../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

Click on the user's name to view their permissions. You will need to verify that the user has policies attached that grant the necessary permissions for managing AWS resources via Terraform.

<figure><img src="../../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
This user has full administrative access to allow Terraform to deploy WEKA. However, it is recommended to grant the \[least privileged permission]\(https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege) by using the information from Appendix B below.
{% endhint %}

### AWS Quotas

For successful WEKA deployment in AWS using Terraform, it is essential to ensure your AWS account has the appropriate quotas for the needed AWS resources. Specifically, when setting up EC2 instances like the i3en for the WEKA backend cluster, AWS requires you to manage quotas based on the vCPU count for each EC2 instance type or family.

Before WEKA deployment, please confirm if your EC2 VM’s vCPU sizing requirements can be met within the limits of existing quota. If not, please increase the quotas in your AWS account before executing Terraform commands (outlined later in the document). The required minimum quota is the cumulative vCPU count for all instances (for example, 10 i3en.6xlarge are each 24 vCPUs, so 240 vCPU count would be needed just for the cluster alone.) that will be deployed. This will prevent failures during the execution of terraform commands, which are discussed in subsequent sections.

#### Setting Service Quotas

Navigate to the AWS Management Console ([https://us-east-1.console.aws.amazon.com/servicequotas/home/dashboard](https://us-east-1.console.aws.amazon.com/servicequotas/home/dashboard)) and use the search bar to find the AWS Service called "Service Quotas."

<figure><img src="../../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

Once on the Service Quotas page, choose "Amazon EC2."

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

WEKA currently only supports i3en instance types for backend cluster nodes. There are instance types of Spot, OnDemand, and Dedicated. Be sure you are adjusting the proper one.

<figure><img src="../../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>

Select the “Standard (A,C,D,H,I,M,R,T,Z)” instance type, then click on "Request quota increase."

<figure><img src="../../../.gitbook/assets/image (8).png" alt=""><figcaption></figcaption></figure>

Fill out the form in the "Request quota increase" section by specifying the number of vCPUs you require. For example, if you need 150 vCPUs for the i3en instance family, enter this number and submit your request.

Quota increase requests are often processed immediately. If the request involves a substantial number of vCPUs or a specialized instance type, manual review by AWS support may be required.

Ensure that you have requested and confirmed the necessary quotas for all instance types that will be used for the WEKA backend servers deployment, and any associated application servers running the WEKA client software. As indicated in the [WEKA documentation](https://docs.weka.io/install/aws/supported-ec2-instance-types), WEKA supports the i3en series instances for WEKA backend servers. Check the documentation for details on the available sizes, and corresponding vCPU requirements for these instances found here - [https://docs.weka.io/install/aws/supported-ec2-instance-types](https://docs.weka.io/install/aws/supported-ec2-instance-types).

## AWS Resource Prerequisites

The WEKA deployment uses various aspects of AWS, including, but not limited to, VPCs, Subnets, Security Groups, End Points, and more. These items can either be created by the Terraform process or can be pre-existing if creating elements to use manually. The minimum will be a VPC(Virtual Private Cloud), two Subnets each in a different AZ(Availability Zone), and a Security Group.

### Networking requirements

If you don’t have the Terraform deployment auto-create networking components, The recommended VPC will have two subnets (either private or public) in separate AZs with the subnet for WEKA to have access to the internet, either via an IGW with an EIP, NAT, proxy or an egress VPC. While WEKA deployment is not multi-AZ, it is still required to spin up a minimum of two subnets in different AZs for the ALB.

#### Network Access Lists

An AWS Network Access Lists (ACL’s) function as basic firewalls, governing inbound and outbound network traffic based on security rules. They apply to network interfaces (NICs), EC2 instances, and subnets.

Every ACL starts with default rules that ensure basic connectivity. For example, there's a default rule that allows outbound communication from all AWS resources and another default rule that denies all inbound traffic from the internet. These rules have high priority numbers, so custom rules can easily override them. Most restrictions and allowances are handled by Security Groups, which will be set up in the next step.

You can see your Network Access Lists for the VPC by selecting the “Main network ACL” from the VPC details page for your VPC.

<figure><img src="../../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>

From the ACL page you can view the Inbound and Outbound rules.

<figure><img src="../../../.gitbook/assets/image (10).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>

#### Creating a Security Group

To manually create security groups, please refer to **Appendix A – Security Groups / Network ACL** Ports on the Appendices section and ensure you have defined all the relevant ports.

## Deploying WEKA in AWS using Terraform

If using existing elements gather their AWS IDs as exampled below.

<figure><img src="../../../.gitbook/assets/image (12).png" alt=""><figcaption><p>VPC</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (13).png" alt=""><figcaption><p><strong>Subnet (in VPC)</strong></p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (14).png" alt=""><figcaption><p><strong>Security Group (in EC2)</strong></p></figcaption></figure>

### Modules

These are modules for creating IAM roles, networks, and security groups necessary for Weka deployment. If you don't provide specific IDs for security groups or subnets, the modules will create them for you. The **availability\_zones** variable is required when creating a network and is currently limited to a single subnet. The following will be auto created if not supplied.

1. **Private Network Deployment**: To deploy a private network with NAT, you need to set certain variables, such as **subnet\_autocreate\_as\_private** to **true** and provide a private CIDR range. To ensure instances do not get public IPs, set **assign\_public\_ip** to **false**.
2. **SSH Keys**: For SSH access, use the username **ec2-user**. You can either provide an existing key pair name or a public SSH key. If you don't provide either, the system will create a key pair and store the private key locally.
3. **Application Load Balancer (ALB)**: If you want to create an ALB for the backend UI and WEKA client connections, you must set **create\_alb** to **true** and provide additional required variables. To integrate the ALB DNS with your DNS zone, additional variables for Route 53 zone ID and alias name are required.
4. **Object Storage (OBS)**: To integrate with S3 for tiered storage, set **tiering\_enable\_obs\_integration** to **true** and provide the name of the S3 bucket. You can also specify the SSD cache percentage.
5. **Clients (optional)**: For automatically mounting clients to the WEKA cluster, provide the number of clients you want to create. Optional variables include instance type, number of network interfaces (NICs), and AMI ID.
6. **NFS Protocol Gateways (optional)**: Similar to clients, specify the number of NFS protocol gateways you want. You can also provide additional configuration details like instance type and disk size.
7. **SMB Protocol Gateways (optional)**: For SMB protocol gateways, you must create at least three instances. Additional configuration details are similar to NFS gateways.
8. **Secret Manager**: This is used to store sensitive information like usernames and passwords. If you cannot provide a secret manager endpoint, you can disable it by setting **secretmanager\_use\_vpc\_endpoint** to **false**.
9. **VPC Endpoints**: If you need VPC endpoints for services like EC2, S3, or a proxy, you can enable them by setting the respective variables to **true**.
10. **Terraform Output**: The output from running the Terraform module will include details such as the SSH username and WEKA password secret ID. It will also provide helper commands to learn about the clusterization process.

### Locate the User’s [get.weka.io](http://get.weka.io/) Token

The WEKA user token provides access to the WEKA binaries, and is used to access https://[get.weka.io](http://get.weka.io/) during the installation process.

To find the user’s [get.weka.io](http://get.weka.io/) token, follow the instructions below.

In a web browser, navigate to [get.weka.io](http://get.weka.io/) and select the user’s name in the upper righthand corner of the page.

<figure><img src="../../../.gitbook/assets/image (15).png" alt=""><figcaption></figcaption></figure>

From the column on the lefthand side of the page, select “API Tokens.” The user’s API token is presented on the screen. The API token will be used later in the install process.

<figure><img src="../../../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>

### Deploying WEKA in AWS with Terraform - public\_network example

The module is for deploying various AWS resources, including EC2 instances, DynamoDB tables, Lambda functions, State Machines, etc., for WEKA deployment on AWS.

#### Preparing the main.tf file

Here's how you would structure the Terraform files:

Create a directory for the Terraform configuration files.

{% hint style="info" %}
All Terraform deployments have to be separated into their own directories in order to save state information. By creating a directory specific for this deployment, other deployments can be done by duplicating these instructions and simply naming the directory deploy1 or something else unique.
{% endhint %}

```bash
mkdir deploy
```

Navigate to the directory.

```bash
cd deploy
```

Including an [output.tf](http://output.tf) file in the deploy directory will allow the easy output to screen of data generated during the process.

Create a `[output.tf](http://output.tf)` file and paste the following as its contents

```json
output "weka_deployment_output" {
  value = module.weka_deployment
}
```

Save the file.

A [main.tf](http://main.tf) file is needed to define the Terraform options. Create the main.tf file with your prefered editor

Open the **main.tf** in your preferred editor.

Create the contents of the [main.tf](http://main.tf) with the following:

```json
# Terraform configuration for deploying resources in AWS
terraform {
  required_version = ">= 1.4.6"  # Minimum Terraform version required

  # Define required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"  # AWS provider source
      version = ">= 5.5.0"       # Minimum AWS provider version required
    }
  }
}

# AWS provider configuration
provider "aws" {
  region     = "us-east-1"       # Desired AWS region
  access_key = "xxxxxxxxxxxx"    # AWS CLI access key
  secret_key = "xxxxxxxxx"       # AWS CLI secret key
}

# Module for WEKA deployment
module "weka_deployment" {
  source             = "weka/weka/aws"               # Source registry for the module
  version            = "1.0.1"                       # Version of registry to use
  prefix             = "WEKA"                        # Prefix used for naming all AWS elements
  cluster_name       = "Prod"                        # Name of the cluster
  availability_zones = ["us-east-1a"]                # Availability zones for deployment
  allow_ssh_cidrs    = ["0.0.0.0/0"]                 # CIDR blocks allowed for SSH access
  get_weka_io_token  = "<Your WEKA IO token>"        # Token for WEKA IO authentication
  clients_number     = 2                             # Number of client instances to deploy
  # Required environment variables for deploying in an existing environment.  Comment out if you want Terraform to create everything
  vpc_id                      = "YOUR_VPC_ID"                     # ID of the VPC to be used
  subnet_ids                  = ["YOUR_SUBNET_ID"]                # List of subnet IDs (primary subnet to deploy WEKA into)
  create_alb                  = "false"                           # Flag to determine ALB creation
  alb_additional_subnet_id    = "YOUR_ADDITIONAL_ALB_SUBNET_ID"   # Additional subnet ID for ALB (Secondary subnet in second AZ)

  # Uncomment the following to manually specify additional options for the existing enviornment (optional)
  # sg_ids                   = ["YOUR_SECURITY_GROUP_ID"]        # Existing security group IDs
  # instance_iam_profile_arn = "YOUR_INSTANCE_IAM_PROFILE_ARN"   # IAM role for EC2 instances
  # lambda_iam_role_arn      = "YOUR_LAMBDA_IAM_ROLE_ARN"        # IAM role for Lambda functions
  # sfn_iam_role_arn         = "YOUR_STATE_MACHINE_IAM_ROLE_ARN" # IAM role for state machines
  # event_iam_role_arn       = "YOUR_EVENT_IAM_ROLE_ARN"         # IAM role for event management
}
```

Authentication is handled in the “provider” section. You will need either the “**Access key ID**” and the “**Secret access key**” for the AWS account’s IAM user that will be authenticated in AWS for WEKA deployment or have AWS CLI configured which still requires the Access key ID and the Secret access key, but only to authenticate once. If the AWS IAM user doesn’t already have both the “Access key ID” and “Secret access key”, instructions on how to create both can be found here. [https://docs.aws.amazon.com/IAM/latest/UserGuide/id\_credentials\_access-keys.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/id\_credentials\_access-keys.html)

Authentication can be accomplished by editing the provider section to one of the following.

{% hint style="info" %}
Be sure to update the region with the region WEKA will be deployed to.
{% endhint %}

Option 1 is to hard code your access and secret key as seen here.

```json
...
provider "aws" {
  region	= "us-east-1"
  access_key	= "<your access key ID here>"
  secret_key	= "<your access secret key here>"
}
...
```

Option 2 is to only have to provide the region you will authenticate into and use the AWS CLI for authentication

```json
...
provider "aws" {
        region = "us-east-1"
}
...
```

To authenticate AWS CLI you use the following command

```bash
aws configure
```

Fill in the required information and hit enter.

<figure><img src="../../../.gitbook/assets/image (17).png" alt=""><figcaption></figcaption></figure>

Once the authentication method is decided uncomment and fill in any extra information you will use.

{% hint style="info" %}
Make sure to replace placeholders like \*\*YOUR\_WEKA\_IO\_TOKEN.\*\* Also replace all other variables like, \*\*YOUR\_SECURITY\_GROUP\_ID\*\*, etc., with the actual values for your environment if you don’t want those resources created by the process.
{% endhint %}

**Initialize the Terraform directory**:

After creating and saving the [**main.tf**](http://main.tf) file, in the same directory as the main.tf file run the following command.

```json
terraform init
```

This will ensure that the proper Terraform resource files for AWS are downloaded and available for the system.

**Run Terraform Plan & Apply**:

Best practice before applying or destroying a Terraform configuration file is to run a plan using following command.

```json
terraform plan
```

Initiate the deployment of WEKA in AWS by running the following command.

```json
terraform apply
```

This command executes the creation of AWS resources necessary to run WEKA. Confirm deployment of resources by typing **yes** at the prompt.

When the Terraform AWS resource deployment process successfully completes, an output similar to below will be shown. If it is unsuccessful a failed error message would instead be shown.

```json
Outputs:

weka_deployment = {
  "alb_alias_record" = null
  "alb_dns_name" = "internal-WEKA-Prod-lb-697001983.us-east-1.elb.amazonaws.com"
  "asg_name" = "WEKA-Prod-autoscaling-group"
  "client_ips" = null
  "cluster_helper_commands" = <<-EOT
  aws ec2 describe-instances --instance-ids $(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name WEKA-Prod-autoscaling-group --query "AutoScalingGroups[].Instances[].InstanceId" --output text) --query 'Reservations[].Instances[].PublicIpAddress' --output json
  aws lambda invoke --function-name WEKA-Prod-status-lambda --payload '{"type": "progress"}' --cli-binary-format raw-in-base64-out /dev/stdout
  aws secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:us-east-1:459693375476:secret:weka/WEKA-Prod/weka-password-g9bH-T2og7D --query SecretString --output text
  
  EOT
  "cluster_name" = "Prod"
  "ips_type" = "PublicIpAddress"
  "lambda_status_name" = "WEKA-Prod-status-lambda"
  "local_ssh_private_key" = "/tmp/WEKA-Prod-private-key.pem"
  "nfs_protocol_gateways_ips" = tostring(null)
  "smb_protocol_gateways_ips" = tostring(null)
  "ssh_user" = "ec2-user"
  "weka_cluster_password_secret_id" = "arn:aws:secretsmanager:us-east-1:459693375476:secret:weka/WEKA-Prod/weka-password-g9bH-T2og7D"
}
weka_deployment_output = {
  "alb_alias_record" = null
  **"alb_dns_name" = "internal-WEKA-Prod-lb-697001983.us-east-1.elb.amazonaws.com"**
  "asg_name" = "WEKA-Prod-autoscaling-group"
  "client_ips" = null
  "cluster_helper_commands" = <<-EOT
  **aws ec2 describe-instances --instance-ids $(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name WEKA-Prod-autoscaling-group --query "AutoScalingGroups[].Instances[].InstanceId" --output text) --query 'Reservations[].Instances[].PublicIpAddress' --output json
  aws lambda invoke --function-name WEKA-Prod-status-lambda --payload '{"type": "progress"}' --cli-binary-format raw-in-base64-out /dev/stdout
  aws secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:us-east-1:459693375476:secret:weka/WEKA-Prod/weka-password-g9bH-T2og7D --query SecretString --output text**
  
  EOT
  "cluster_name" = "Prod"
  "ips_type" = "PublicIpAddress"
  "lambda_status_name" = "WEKA-Prod-status-lambda"
  **"local_ssh_private_key" = "/tmp/WEKA-Prod-private-key.pem"**
  "nfs_protocol_gateways_ips" = tostring(null)
  "smb_protocol_gateways_ips" = tostring(null)
  **"ssh_user" = "ec2-user"**
  "weka_cluster_password_secret_id" = "arn:aws:secretsmanager:us-east-1:459693375476:secret:weka/WEKA-Prod/weka-password-g9bH-T2og7D"
}
```

Please take note of “alb\_dns\_name”, “local\_ssh\_private\_key” and “ssh\_user” so that you would be able to use it later while connecting through SSH to the machine.

There are also three AWS CLI commands that can return useful information.

### Core Resources Created:

* **Database**: DynamoDB table for storing Weka cluster state.
* **EC2**: Launch templates for auto-scaling groups and individual instances.
* **Networking**: Placement Group, Auto Scaling Group, and optional ALB for UI and Backends.
* **CloudWatch**: Triggering the state machine every minute.
* **IAM**: Roles and policies required for various WEKA components.
* **Secret Manager**: Safely stores Weka credentials and tokens.

#### Lambda Functions:

* **deploy:** Provides installation scripts for new machines.
* **clusterize:** Provides the script for clusterization.
* **clusterize-finalization:** Updates the cluster state upon the completion of clusterization.
* **report:** Updates the state on clusterization and machine installation progress.
* **status:** Offers information on cluster progress status.
* **State Machine Functions:** Manages various stages like fetching cluster information, scaling down, terminating, etc.
* **fetch:** Retrieves cluster or autoscaling group details and forwards them to the subsequent stage.
* **scale-down:** Utilizes the information fetched to operate on the Weka cluster, such as deactivating drives or hosts. The function will error out if a non-supported target is provided, like scaling down to only two backend instances.
* **terminate:** Ends the operations of the deactivated hosts.
* **transient:** Manages and reports transient errors. For instance, it might report if certain hosts couldn't be deactivated, yet some were, and the entire operation continued.

### Deploying Protocol Nodes

The Terraform deployment also makes it easy to deploy additional instances to act as protocol nodes for NFS or SMB. These instances are in addition to the number of instances defined for the the WEKA backend cluster count. e

To deploy protocol nodes, additional information needs to be added to the main.tf

The simplest method is to just define how many protocol nodes of each type to deploy and allow the defaults to be used for everything else.

Add the following to the before the last ‘}’ of the [main.tf](http://main.tf) file.

```bash
## Protocol Nodes ##

## For deploying NFS protocol nodes ##
nfs_protocol_gateways_number = 2 # A minimum of two is required

## For deploying SMB protocol nodes ##
smb_protocol_gateways_number = 3 # A minimum of three is required 
```

## Gather access information about WEKA cluster

### **Determine WEKA cluster IP address(es)**

To gather your WEKA cluster IPs, go to the EC2 page in AWS and select “Instances (running)”

<figure><img src="../../../.gitbook/assets/image (18).png" alt=""><figcaption></figcaption></figure>

The instances for the WEKA backend servers will be called -\<cluster\_name>-instance-backend.

<figure><img src="../../../.gitbook/assets/image (19).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
“prefix” and “cluster\_name” here are the \*\*prefix\*\* and \*\*cluster\_name\*\* values filled out in the main.tf file.
{% endhint %}

<figure><img src="../../../.gitbook/assets/image (20).png" alt=""><figcaption></figcaption></figure>

To access and manage WEKA cluster, select any of the WEKA backend instance and note the IP address as shown below.

<figure><img src="../../../.gitbook/assets/image (21).png" alt=""><figcaption></figcaption></figure>

If your subnet provided a public IP address for the instance (If the EC2 was configured as so), that will be listed. All the interface IP addresses that WEKA will use for communication will all be “private IPv4 addresses”. You can get the primary private address by looking at the “Hostname type” and noting the IP address from there.

#### **Obtain WEKA cluster access password**

The password for the WEKA cluster will be in the AWS Secret Manager. You can either run the AWS Secretmanager command from the Terraform output to gather the cluster password, or use the AWS console.

From the AWS console search for “secret manager” and then select “Secrets” from the “Secrets Manager” section.

Click on the secret that contains the **prefix** and **cluster\_name** of the deployment along with the word **password**.

Click on “Retrieve secret value”.

The randomly generated password that was assigned to WEKA user ‘admin’ will be displayed.

### Accessing the WEKA cluster backends.

The WEKA cluster backend instances can be accessed via SSH. If the WEKA backend instances do not have public IP addresses, a system that can reach the subnet they are in will be needed.

To access an instance from the system that ran the terraform deployment, use the IP address collected in step 4.5 and the ssh key path in the output of step 4.4.

```json
ssh -l ec2-user -i /tmp/WEKA-Prod-private-key.pem 3.91.150.250
```

## **WEKA GUI Login and Review**

Using a jump box with a GUI deployed into the same VPC and subnet as the WEKA cluster, the WEKA GUI can be accessed via a web browser.

In the examples below, a Windows 10 instance with a public IP address was deployed in the same VPC, subnet, and security group as the WEKA cluster. Network security group rules were added to allow RDP access explicitly to the Windows 10 system.

Open a browser in the Windows 10 jump box and visit https://:14000. The WEKA GUI login screen should appear. Login as user ‘admin’ and the password gathered in 4.5.

<figure><img src="../../../.gitbook/assets/image (22).png" alt=""><figcaption></figcaption></figure>

View the cluster GUI home screen.

<figure><img src="../../../.gitbook/assets/image (23).png" alt=""><figcaption></figcaption></figure>

Review the cluster backends.

<figure><img src="../../../.gitbook/assets/image (24).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The Server names on the deployed environment will differ from this example.
{% endhint %}

Review the clients, if any, attached to the cluster.

<figure><img src="../../../.gitbook/assets/image (25).png" alt=""><figcaption></figcaption></figure>

Review the file systems.

<figure><img src="../../../.gitbook/assets/image (26).png" alt=""><figcaption></figcaption></figure>

## **Scaling (out and in) of a WEKA backend cluster with automated workflows**

Scaling (both out and in) the WEKA backend cluster can be easily done through the AWS AutoScaling Group Policy created by Terraform.

The Terraform-created lambda functions will be activated when a new instance is initiated or retired. These functions will then execute the required automation processes to add more computing resources (i.e., a new backend) to the cluster.

To scale out from the minimum of 6 nodes, go to the AutoScaling Group page in the AWS console and change the desired capacity from its current number to the desired cluster size (e.g. 10 servers) by choosing “Edit”:

<figure><img src="../../../.gitbook/assets/image (28).png" alt=""><figcaption></figcaption></figure>

And changing the desired capacity (in our example below, we’ve set it to “10”):

<figure><img src="../../../.gitbook/assets/image (29).png" alt=""><figcaption></figcaption></figure>

Additionally, the auto-scaling provides the following advantages:

1. **Integration with ALB:**
   * Auto Scaling Groups seamlessly integrate with an Application Load Balancer (ALB) for efficient traffic distribution among multiple instances.
   * The ALB automatically identifies and routes traffic exclusively to healthy instances, relying on health check results from the associated Auto Scaling Group.
2. **Replacing Unhealthy Instances:**
   * In the event of an instance failing a health check, Auto Scaling promptly initiates the replacement process by launching a new instance to the WEKA cluster.
   * The new instance is incorporated into the service and added to the ALB's target group only after successfully passing health checks.
   * This systematic approach ensures uninterrupted availability and responsiveness of WEKA, mitigating the impact of instance failures.
3. **Graceful Scaling:**
   * Auto Scaling configurations can be fine-tuned to execute scaling actions gradually, preventing abrupt spikes in traffic or disruptions to the application.
   * This measured scaling approach aims to maintain a balanced and stable environment while effectively adapting to fluctuations in demand.

## **Testing WEKA cluster self-healing functionality by terminating an existing instance running WEKA (Optional)**

Decommissioning an old instance and allowing the Auto Scaling Group (ASG) to launch a new one involves terminating the existing instance and letting the ASG automatically replace it. Here's a brief guide:

1. **Identify the Old Instance:**
   * Identify the EC2 instance that you want to decommission. This could be based on age, outdated configurations, or other criteria.
2. **Verify Auto Scaling Configuration:**
   * Ensure your Auto Scaling Group is configured with at least 7 instances or more. Confirm that the desired capacity of the ASG is set to maintain the desired number of instances in the cluster.
3. **Terminate the Old Instance:**
   * Manually terminate the old EC2 instance using the AWS Management Console, AWS CLI, or SDKs. This action triggers the Auto Scaling Group to take corrective measures.
4. **Monitor Auto Scaling Activities:**
   * Observe the Auto Scaling Group's activities in the AWS Console or use AWS CloudWatch to monitor events. Verify that the ASG detects the terminated instance and initiates the launch of a new instance.
5. **Verify New Instance:**
   * Once the new instance is launched, ensure that it passes the health checks and successfully joins the cluster. Confirm that the overall capacity of the cluster is maintained.
6. **Check Load Balancer:**
   * If your setup involves a load balancer, ensure it detects and registers the new instance. This step is crucial for maintaining proper load distribution across the cluster.
7. **Review Auto Scaling Logs:**
   * Check CloudWatch logs or Auto Scaling events for any issues or error messages related to the termination of the old instance and the launch of the new one.
8. **Document and Monitor:**
   * Document the decommissioning process and monitor the cluster to ensure it continues to operate smoothly with the new instance.

## APPENDICES

### Appendix A – Security Groups / Network ACL Ports

See [#required-ports](../../prerequisites-and-compatibility.md#required-ports "mention")

### Appendix B - **Terraform’s r**equired permissions

This section provides examples of the permissions required to deploy WEKA using Terraform.

The minimum IAM policies needed are based on the assumption that the network, including VPC, subnets, VPC Endpoints, and Security Groups, is created by the end user. If IAM roles or policies are pre-established, some permissions may be omitted.

{% hint style="info" %}
The policy exceeds the 6144 character limit for IAM policies, necessitating its division into two separate policies.
{% endhint %}

In each policy, replace the placeholders, such as `account-number`, `prefix`, and `cluster-name`, with the corresponding actual values.

<details>

<summary>IAM Policy 1</summary>

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::weka-tf-aws-releases*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DeletePlacementGroup"
            ],
            "Resource": "arn:aws:ec2:us-east-1:account-number:placement-group/prefix-cluster-name*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribePlacementGroups"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceTypes"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateLaunchTemplate",
                "ec2:CreateLaunchTemplateVersion",
                "ec2:DeleteLaunchTemplate",
                "ec2:DeleteLaunchTemplateVersions",
                "ec2:ModifyLaunchTemplate",
                "ec2:GetLaunchTemplateData"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeScalingActivities"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:CreateAutoScalingGroup",
                "autoscaling:DeleteAutoScalingGroup",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:SetInstanceProtection",
                "autoscaling:SuspendProcesses",
                "autoscaling:AttachLoadBalancerTargetGroups",
                "autoscaling:DetachLoadBalancerTargetGroups"
            ],
            "Resource": [
                "arn:aws:autoscaling:*:account-number:autoScalingGroup:*:autoScalingGroupName/prefix-cluster-name-autoscaling-group"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction",
                "lambda:DeleteFunction",
                "lambda:GetFunction",
                "lambda:ListFunctions",
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "lambda:ListVersionsByFunction",
                "lambda:GetFunctionCodeSigningConfig",
                "lambda:GetFunctionUrlConfig",
                "lambda:CreateFunctionUrlConfig",
                "lambda:DeleteFunctionUrlConfig",
                "lambda:AddPermission",
                "lambda:GetPolicy",
                "lambda:RemovePermission"
            ],
            "Resource": "arn:aws:lambda:*:account-number:function:prefix-cluster-name-*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "lambda:CreateEventSourceMapping",
                "lambda:DeleteEventSourceMapping",
                "lambda:GetEventSourceMapping",
                "lambda:ListEventSourceMappings"
            ],
            "Resource": "arn:aws:lambda:*:account-number:event-source-mapping:prefix-cluster-name-*"
        },
        {
            "Sid": "ReadAMIData",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeImages",
                "ec2:DescribeImageAttribute",
                "ec2:CopyImage"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:ImportKeyPair",
                "ec2:CreateKeyPair",
                "ec2:DeleteKeyPair",
                "ec2:DescribeKeyPairs"
            ],
            "Resource": "*"
        },
        {
            "Action": [
                "ec2:MonitorInstances",
                "ec2:UnmonitorInstances",
                "ec2:ModifyInstanceAttribute",
                "ec2:RunInstances",
                "ec2:CreateTags"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "DescribeSubnets",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeSubnets"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "DescribeALB",
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeListeners"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreatePlacementGroup"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:CreateTargetGroup",
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "elasticloadbalancing:ModifyTargetGroupAttributes",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:DeleteTargetGroup",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DeleteListener"
            ],
            "Resource": [
                "arn:aws:elasticloadbalancing:us-east-1:account-number:loadbalancer/app/prefix-cluster-name*",
                "arn:aws:elasticloadbalancing:us-east-1:account-number:targetgroup/prefix-cluster-name*",
                "arn:aws:elasticloadbalancing:us-east-1:account-number:listener/app/prefix-cluster-name*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "elasticloadbalancing:DescribeTags"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeVpcs",
                "ec2:DescribeLaunchTemplates",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:DescribeInstances",
                "ec2:DescribeTags",
                "ec2:DescribeInstanceAttribute",
                "ec2:DescribeVolumes"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": [
                "states:Creacluster-nameateMachine",
                "states:Delecluster-nameateMachine",
                "states:TagResource",
                "states:DescribeStateMachine",
                "states:ListStateMachineVersions",
                "states:ListStateMachines",
                "states:ListTagsForResource"
            ],
            "Resource": [
                "arn:aws:states:us-east-1:account-number:stateMachine:prefix-cluster-name*"
            ]
        },
        {
            "Sid": "Statement2",
            "Effect": "Allow",
            "Action": [
                "ec2:TerminateInstances"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

</details>

<details>

<summary>IAM Policy 2</summary>

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:CreateSecret",
                "secretsmanager:DeleteSecret",
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecrets",
                "secretsmanager:UpdateSecret",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:ListSecretVersionIds",
                "secretsmanager:PutSecretValue"
            ],
            "Resource": [
                "arn:aws:secretsmanager:*:account-number:secret:weka/prefix-cluster-name/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:UpdateItem"
            ],
            "Resource": "arn:aws:dynamodb:*:account-number:table/prefix-cluster-name*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:DeletePolicy",
                "iam:GetPolicy",
                "iam:GetRole",
                "iam:GetPolicyVersion",
                "iam:ListRolePolicies",
                "iam:ListInstanceProfilesForRole",
                "iam:PassRole",
                "iam:ListPolicyVersions",
                "iam:ListAttachedRolePolicies",
                "iam:ListAttachedGroupPolicies",
                "iam:ListAttachedUserPolicies"
            ],
            "Resource": [
                "arn:aws:iam::account-number:policy/prefix-cluster-name-*",
                "arn:aws:iam::account-number:role/prefix-cluster-name-*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:AttachRolePolicy",
                "iam:AttachGroupPolicy",
                "iam:AttachUserPolicy",
                "iam:DetachRolePolicy",
                "iam:DetachGroupPolicy",
                "iam:DetachUserPolicy"
            ],
            "Resource": [
                "arn:aws:iam::account-number:policy/prefix-cluster-name-*",
                "arn:aws:iam::account-number:role/prefix-cluster-name-*",
                "arn:aws:iam::account-number:role/ck-cluster-name-weka-iam-role"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetPolicy",
                "iam:ListEntitiesForPolicy"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetInstanceProfile",
                "iam:CreateInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:AddRoleToInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile"
            ],
            "Resource": "arn:aws:iam::*:instance-profile/prefix-cluster-name-*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:PutRetentionPolicy",
                "logs:DeleteLogGroup"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:account-number:log-group:/aws/lambda/prefix-cluster-name*",
                "arn:aws:logs:us-east-1:account-number:log-group:/aws/vendedlogs/states/prefix-cluster-name*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "events:TagResource",
                "events:PutRule",
                "events:DescribeRule",
                "events:ListTagsForResource",
                "events:DeleteRule",
                "events:PutTargets",
                "events:ListTargetsByRule",
                "events:RemoveTargets"
            ],
            "Resource": [
                "arn:aws:events:us-east-1:account-number:rule/prefix-cluster-name*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "dynamodb:DescribeTable",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:ListTagsOfResource",
                "dynamodb:DeleteTable"
            ],
            "Resource": [
                "arn:aws:dynamodb:us-east-1:account-number:table/prefix-cluster-name*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:DescribeLogGroups",
                "logs:ListTagsLogGroup"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

</details>

**Parameters:**

* **DynamoDB**: Full access is granted as your setup requires creating and managing DynamoDB tables.
* **Lambda**: Full access is needed for managing various Lambda functions mentioned.
* **State Machine (AWS Step Functions)**: Full access is given for managing state machines.
* **Auto Scaling Group & EC2 Instances**: Permissions for managing Auto Scaling groups and EC2 instances.
* **Application Load Balancer (ALB)**: Required for operations related to load balancing.
* **CloudWatch**: Necessary for monitoring and managing CloudWatch rules and metrics.
* **Secrets Manager**: Access for managing secrets in AWS Secrets Manager.
* **IAM**: **`PassRole`** and **`GetRole`** are essential for allowing resources to assume specific roles.
* **KMS**: Permissions for Key Management Service, assuming you use KMS for encryption.

Customization:

1. **Resource Names and ARNs**: Replace **`"Resource": "*"`** with specific ARNs for your resources to tighten security. Use specific ARNs for KMS keys as well.
2. **Region and Account ID**: Replace **`region`** and **`account-id`** with your AWS region and account ID.
3. **Key ID**: Replace **`key-id`** with the ID of the KMS key used in your setup.

**Important Notes:**

* This is a broad policy for demonstration. It's recommended to refine it based on your actual resource usage and access patterns.
* You may need to add or remove permissions based on specific requirements of your Terraform module and AWS environment.
* Testing the policy in a controlled environment before applying it to production is advisable to ensure it meets your needs without overly restricting or exposing your resources.

### Appendix C - IAM Policies required by WEKA

The policies below are required for all the components to function on AWS. Terraform will create these policies as part of the automation. However, it is also important to note that you could create them by yourself and define them in your Terraform modules.

<details>

<summary><strong>EC2 policies (Required for the backends that are part of the WEKA cluster)</strong></summary>

```json
{
"Statement": [
{
"Action": [
"ec2:DescribeNetworkInterfaces",
"ec2:AttachNetworkInterface",
"ec2:CreateNetworkInterface",
"ec2:ModifyNetworkInterfaceAttribute",
"ec2:DeleteNetworkInterface"
],
"Effect": "Allow",
"Resource": "*"
},
{
"Action": [
"lambda:InvokeFunction"
],
"Effect": "Allow",
"Resource": [
"arn:aws:lambda:*:*:function:prefix-cluster_name*"
]
},
{
"Action": [
"s3:DeleteObject",
"s3:GetObject",
"s3:ListBucket",
"s3:PutObject"
],
"Effect": "Allow",
"Resource": [
"arn:aws:s3:::prefix-cluster_name-obs/*"
]
},
{
"Action": [
"logs:CreateLogGroup",
"logs:CreateLogStream",
"logs:PutLogEvents",
"logs:DescribeLogStreams",
"logs:PutRetentionPolicy"
],
"Effect": "Allow",
"Resource": [
"arn:aws:logs:*:*:log-group:/wekaio/prefix-cluster_name*"
]
}
],
"Version": "2012-10-17"
}
```

</details>

<details>

<summary><strong>Lambda IAM Policy</strong></summary>

```json
{
"Statement": [
{
"Action": [
"s3:CreateBucket"
],
"Effect": "Allow",
"Resource": [
"arn:aws:s3:::prefix-cluster_name-obs"
]
},
{
"Action": [
"logs:CreateLogGroup",
"logs:CreateLogStream",
"logs:PutLogEvents"
],
"Effect": "Allow",
"Resource": [
"arn:aws:logs:*:*:log-group:/aws/lambda/prefix-cluster_name*:*"
]
},
{
"Action": [
"ec2:CreateNetworkInterface",
"ec2:DescribeNetworkInterfaces",
"ec2:DeleteNetworkInterface",
"ec2:ModifyInstanceAttribute",
"ec2:TerminateInstances",
"ec2:DescribeInstances"
],
"Effect": "Allow",
"Resource": [
"*"
]
},
{
"Action": [
"dynamodb:GetItem",
"dynamodb:UpdateItem"
],
"Effect": "Allow",
"Resource": [
"arn:aws:dynamodb:*:*:table/prefix-cluster_name-weka-deployment"
]
},
{
"Action": [
"secretsmanager:GetSecretValue"
],
"Effect": "Allow",
"Resource": [
"arn:aws:secretsmanager:*:*:secret:weka/prefix-cluster_name/*"
]
},
{
"Action": [
"autoscaling:DetachInstances",
"autoscaling:DescribeAutoScalingGroups",
"autoscaling:SetInstanceProtection"
],
"Effect": "Allow",
"Resource": [
"*"
]
}
],
"Version": "2012-10-17"
}
```

</details>

<details>

<summary><strong>State Machine IAM Policy</strong></summary>

```json
{
"Statement": [
{
"Action": [
"lambda:InvokeFunction"
],
"Effect": "Allow",
"Resource": [
"arn:aws:lambda:*:*:function:prefix-cluster_name-*-lambda"
]
},
{
"Action": [
"logs:CreateLogDelivery",
"logs:GetLogDelivery",
"logs:UpdateLogDelivery",
"logs:DeleteLogDelivery",
"logs:ListLogDeliveries",
"logs:PutLogEvents",
"logs:PutResourcePolicy",
"logs:DescribeResourcePolicies",
"logs:DescribeLogGroups"
],
"Effect": "Allow",
"Resource": [
"*"
]
}
],
"Version": "2012-10-17"
}
```

</details>

<details>

<summary><strong>CloudWatch IAM Policy</strong></summary>

```
{
"Statement": [
{
"Action": [
"states:StartExecution"
],
"Effect": "Allow",
"Resource": [
"arn:aws:states:*:*:stateMachine:prefix-cluster_name-scale-down-state-machine"
]
}
],
"Version": "2012-10-17"
}
```

</details>
