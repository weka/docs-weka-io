# Terraform-Azure-WEKA module description

The [Terraform-Azure-WEKA](https://github.com/weka/terraform-azure-weka) module contains customizable modules for deploying the WEKA cluster on Azure. The default protocol deployed using the module is POSIX. The module supports the following deployment types:

* **Public cloud deployments:** Require passing the `get.weka.io` token to Terraform for downloading the WEKA release from the public [get.weka.io](https://get.weka.io) service. The following examples are provided:
  * Public network.
  * Public network with existing object store.
* **Private cloud deployments:** Require uploading the WEKA release tar file into an Azure blob container from which the virtual machines can download the WEKA release. The following examples are provided:
  * Existing private network.
  * Existing private network with peering.

{% hint style="info" %}
WEKA deployment on Azure only supports Ethernet networking.&#x20;
{% endhint %}

## Terraform-Azure-WEKA example

The following is a basic example in which you provide the minimum detail of your cluster, and the Terraform module completes the remaining required resources, such as VPC, subnets, security group, placement group, DNS zone, and IAM roles.

You can use this example as a reference to create the `main.tf` file.

```hcl
provider "azurerm" {
  subscription_id = var.subscription_id
  partner_id      = "f13589d1-f10d-4c3b-ae42-3b1a8337eaf1"
  features {
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }
  required_version = ">= 1.3.7"
}


variable "get_weka_io_token" {}

variable "subscription_id" {}

module "weka_deployment" {
  source                         = "weka/weka/azure"
  version                         = "4.2.7.64"
  prefix                         = "my_prefix"
  rg_name                        = "example"

  
  subnet_prefix="10.3.2.0/24"
  address_space="10.3.0.0/16"
  logic_app_subnet_delegation_cidr="10.3.3.0/25"
  function_app_subnet_delegation_cidr="10.3.4.0/25"

  get_weka_io_token              = var.get_weka_io_token
  subscription_id                = var.subscription_id
  cluster_name                   = "my_cluster_name"
  tiering_enable_obs_integration = true
  cluster_size                   = 6
  allow_ssh_cidrs                = ["0.0.0.0/0"]
  allow_weka_api_cidrs           = ["0.0.0.0/0"]

}

output "weka_deployment_output" {
  value = module.weka_deployment
}
```

{% hint style="info" %}
For the parameters' descriptions, refer to the [terraform-azure-weka](https://github.com/weka/terraform-azure-weka) module.
{% endhint %}
