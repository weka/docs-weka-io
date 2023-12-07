# Deployment on AWS using Terraform

This step-by-step procedure ensures a seamless configuration of your network, customization of Terraform configurations, and successful deployment of the WEKA cluster on AWS.

Begin by creating a `main.tf` file, tailoring it to your deployment specifics on AWS. Once the `main.tf` is configured to your satisfaction, apply the changes.

## Create a main.tf file

#### Before you begin

* Obtain the latest release of the ATerraform-AWS-WEKA package from [https://github.com/weka/terraform-aws-weka/releases](https://github.com/weka/terraform-aws-weka/releases) and unpack it in your workstation.
* The [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) must be installed on the workstation used for the deployment. Check the minimum required Terraform version specified in [https://github.com/weka/terraform-aws-weka](https://github.com/weka/terraform-aws-weka).

#### Procedure

1. Review the [Terraform-AWS-WEKA example](aws-weka-terraform-deployment-module-description.md#terraform-aws-weka-example) and use it as a reference for creating the `main.tf` according to your deployment specifics on AWS.
2. Decide whether to use an existing AWS network or create a new one, including a Virtual Private Cloud (VPC) and subnet. Your choice dictates the subsequent network configuration steps:
   * **IAM role setup:** Create IAM roles for essential AWS services, including EC2 Instances, Lambda, Step Functions, and CloudWatch event rules. The Terraform module generates these roles if not explicitly provided.
   * **Security group:** Optionally, provide the security group ID or let the Terraform module create one for you.
   * **Endpoint configuration:**
     * Configure a secret manager endpoint to safeguard the WEKA password. If not configured, the Terraform module allows you to set it up.
     * In environments without Internet connections, configure EC2, proxy, and S3 gateway endpoints. The Terraform module facilitates this configuration if needed.
3. Tailor the `main.tf` file to create SMB-W or NFS protocol clusters by adding the relevant code snippet. Adjust parameters like the number of gateways, instance types, domain name, and share naming:

* **SMB-W**

```makefile
smb_protocol_gateways_number = 3
smb_protocol_gateway_instance_type = c5.2xlarge 
smbw_enabled = true
smb_domain_name = "CUSTOMER_DOMAIN"
smb_share_name = "SPECIFY_SMB_SHARE_NAMING"
smb_setup_protocol = true
```

* **NFS**

```makefile
nfs_protocol_gateways_number = 1
nfs_protocol_gateway_instance_type = c5.2xlarge
nfs_setup_protocol = true
```

4. Add WEKA POSIX clients (optional)**:** If needed, add [WEKA POSIX clients](../../../overview/weka-client-and-mount-modes.md) to support your workload by incorporating the specified variables into the `main.tf` file:

```makefile
clients_number = 2
client_instance_type = c5.2xlarge
```

## Apply the main.tf file

Once you complete the main.tf settings, apply it: Run `terraform apply`
