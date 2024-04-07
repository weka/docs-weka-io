# Deployment on AWS using Terraform

This guide outlines the customization process for Terraform configurations to deploy the WEKA cluster on AWS. It is designed for system engineers with expertise in AWS and Terraform. Start by creating a `main.tf` file and adapting it to your AWS deployment requirements. Once configured to your preferences, proceed to apply the changes.

{% hint style="info" %}
If you are new to AWS and Terraform, refer to the[detailed-deployment-tutorial-weka-on-aws-using-terraform.md](detailed-deployment-tutorial-weka-on-aws-using-terraform.md "mention").
{% endhint %}

## Create a main.tf file

#### Before you begin

The [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) must be installed on the workstation used for the deployment. Check the minimum required Terraform version specified in the [Terraform-AWS-WEKA](https://registry.terraform.io/modules/weka/weka/aws/latest?tab=dependencies) module under the **Requirements** section).

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

4. Add WEKA POSIX clients (optional)**:** If needed, add [WEKA POSIX clients](../../../overview/weka-client-and-mount-modes.md) to support your workload by incorporating the specified variables into the `main.tf` file:

```makefile
clients_number = 2
client_instance_type = "c5.2xlarge"
```

## Apply the main.tf file

Once you complete the main.tf settings, apply it: Run `terraform apply`

## **Create a dedicated** Cluster Admin username and password

When deploying a WEKA cluster on the cloud using Terraform, a default username (admin) is automatically generated, and Terraform creates the password. Both the username and password are stored in the AWS Secrets Manager. This user facilitates communication between the cloud and the WEKA cluster, particularly during scale-up and scale-down operations.

As a best practice, it’s recommended to create a dedicated local user in the WEKA cluster with the Cluster Admin role. This user will serve as a service account for cloud-cluster communications.

**Procedure**

1. Create a local user with the Cluster Admin role in the WEKA cluster.
2. In the **AWS Secrets Manager**, navigate to **Secretes**.
3. Update the `weka_username` and `weka_password` services with the username and password of the newly created local user.
4. Validate the changes by checking the [AWS Step Functions](#user-content-fn-1)[^1] execution results and ensuring they pass successfully.

{% hint style="info" %}
If you change the password for the default username in the WEKA cluster, ensure to update the password in the `weka_password` service within AWS Secrets Manager.
{% endhint %}

**Related topic**

[user-management.md](../../../usage/user-management/user-management.md "mention")

[^1]: AWS Step Functions makes it easy to coordinate the components of distributed applications as a series of steps in a visual workflow. You can quickly build and run state machines to execute the steps of your application in a reliable and scalable fashion.\
    For details, see [https://docs.aws.amazon.com/step-functions/](https://docs.aws.amazon.com/step-functions/).
