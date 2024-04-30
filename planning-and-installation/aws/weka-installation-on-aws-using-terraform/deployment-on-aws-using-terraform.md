# Deployment on AWS using Terraform

This step-by-step procedure ensures a seamless configuration of your network, customization of Terraform configurations, and successful deployment of the WEKA cluster on AWS.

Begin by creating a `main.tf` file, tailoring it to your deployment specifics on AWS. Once the `main.tf` is configured to your satisfaction, apply the changes.

## Create a main.tf file

#### Before you begin

The [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) must be installed on the workstation used for the deployment. Check the minimum required Terraform version specified the [**Requirements**](https://registry.terraform.io/modules/weka/weka/aws/latest#requirements) section of the Terraform-AWS-WEKA module.

#### Procedure

1. Review the [Terraform-AWS-WEKA example](https://registry.terraform.io/modules/weka/weka/aws/latest/examples/public\_network) and use it as a reference for creating the `main.tf` according to your deployment specifics on AWS.
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

4. Add WEKA POSIX clients (optional)**:** If needed, add [WEKA POSIX clients](../../../weka-system-overview/weka-client-and-mount-modes.md) to support your workload by incorporating the specified variables into the `main.tf` file:

```makefile
clients_number = 2
client_instance_type = "c5.2xlarge"
```

## Apply the main.tf file

Once you complete the main.tf settings, apply it: Run `terraform apply`