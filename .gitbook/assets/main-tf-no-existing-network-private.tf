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
  source             = "../../"
  prefix             = "CLUSTER_PREFIX"
  cluster_name       = "CLUSTER_NAME"
  allow_ssh_cidrs    = ["ALLOWABLE_WAN_SSH_CIDR_RANGE"]
  get_weka_io_token                 = "GET_WEKA_TOKEN"
  instance_type                     = "i3en.2xlarge"
  cluster_size                      = 6
  assign_public_ip                  = true
}
