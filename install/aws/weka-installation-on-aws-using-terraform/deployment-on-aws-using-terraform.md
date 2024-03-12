# Deployment on AWS using Terraform

This guide outlines the customization process for Terraform configurations to deploy the WEKA cluster on AWS. It is designed for system engineers with expertise in AWS and Terraform. Start by creating a `main.tf` file and adapting it to your AWS deployment requirements. Once configured to your preferences, proceed to apply the changes.

{% hint style="info" %}
If you are new to AWS and Terraform, refer to the[detailed-deployment-tutorial-weka-on-aws-using-terraform.md](detailed-deployment-tutorial-weka-on-aws-using-terraform.md "mention").
{% endhint %}

## Create a main.tf file

#### Before you begin

The [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) must be installed on the workstation used for the deployment. Check the minimum required Terraform version specified in the [Terraform-AWS-WEKA](https://github.com/weka/terraform-aws-weka) module under the **Requirements** section).

#### Procedure

1. Review the [Terraform-AWS-WEKA example](aws-weka-terraform-deployment-module-description.md#terraform-aws-weka-example) and use it as a reference for creating the `main.tf` according to your deployment specifics on AWS.
2. Tailor the `main.tf` file to create SMB-W or NFS protocol clusters by adding the relevant code snippet. Adjust parameters like the number of gateways, instance types, domain name, and share naming:

* **SMB-W**

```makefile
smb_protocol_gateways_number = 3
smb_protocol_gateway_instance_type = "c5.2xlarge" 
smbw_enabled = true
smb_domain_name = "CUSTOMER_DOMAIN"
smb_share_name = "SPECIFY_SMB_SHARE_NAMING"
smb_setup_protocol = true
```

* **NFS**

```makefile
nfs_protocol_gateways_number = 1
nfs_protocol_gateway_instance_type = "c5.2xlarge"
nfs_setup_protocol = true
```

4. Add WEKA POSIX clients (optional)**:** If needed, add [WEKA POSIX clients](../../../overview/weka-client-and-mount-modes.md) to support your workload by incorporating the specified variables into the `main.tf` file:

```makefile
clients_number = 2
client_instance_type = "c5.2xlarge"
```

## Apply the main.tf file

Once you complete the main.tf settings, apply it: Run `terraform apply`
