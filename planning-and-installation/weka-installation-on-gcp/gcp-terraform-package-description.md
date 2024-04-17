# GCP-WEKA deployment Terraform package description

WEKA provides a ready-to-deploy [GCP-WEKA deployment Terraform package](https://registry.terraform.io/modules/weka/weka/gcp/latest) you can customize to install the WEKA cluster on GCP.

The Terraform package contains the following modules:

* **setup\_network**: includes vpcs, subnets, peering, firewall, and health check.
* **service\_account**: includes the service account used for deployment with all necessary permissions.
* **deploy\_weka**: includes the actual WEKA deployment, instance template, cloud functions, workflows, job schedulers, secret manager, buckets, and health check.
* **shared\_vpcs** (_optional_): includes VPC sharing the WEKA deployment network with another hosting project. For example, when deploying a private network.

Refer to the [terraform-gcp-weka](https://github.com/weka/terraform-gcp-weka) module for more details.

## GCP-WEKA deployment Terraform package supported types

The Terraform package supports the following deployment types:

* **Public cloud deployments:** Require passing the `get.weka.io` token to Terraform for downloading the WEKA release from the public [get.weka.io](https://get.weka.io) service. The following examples are provided:
  * Public VPC
  * Public VPC with creating a worker pool
  * Public VPC with an existing public network
  * Public VPC with multiple clusters
  * Public VPC with a shared VPC
  * Public VPC with an existing worker pool and VPC
* **Private cloud deployments:** Require uploading the WEKA release tar file into the yum repository (instances can download the WEKA release from this yum repository). The following examples are provided:
  * Private VPC with creating a worker pool
  * Private VPC with an existing network
  * Private VPC with an existing worker pool and VPC
  * Private VPC with multiple clusters
  * Private VPC with a shared VPC

## Terraform example

The following is a basic example in which you provide the minimum detail of your cluster, and the Terraform module completes the remaining required resources, such as cluster size, machine type, and networking parameters.

You can use this example as a reference to create the `main.tf` file. &#x20;

```hcl
provider "google" {
  region  = "europe-west1"
  project = "PROJECT_ID"
}

module "weka_deployment" {
  source                         = "weka/weka/gcp"
  version                        = "4.0.0"
  cluster_name                   = "my_cluster_name"
  project_id                     = "PROJECT_ID"
  prefix                         = "my_prefix"
  region                         = "europe-west1"
  zone                           = "europe-west1-b"
  cluster_size                   = 7
  nvmes_number                   = 2
  get_weka_io_token              = "getwekatoken"
  machine_type                   = "c2-standard-8"
  subnets_range                  = ["10.222.0.0/24", "10.223.0.0/24", "10.224.0.0/24", "10.225.0.0/24"]
  allow_ssh_cidrs                = ["0.0.0.0/0"]
  allow_weka_api_cidrs           = ["0.0.0.0/0"]

}
output "weka_cluster" {
  value = module.weka_deployment
}
```

{% hint style="info" %}
For the descriptions of the parameters, refer to the [GCP-WEKA deployment Terraform package](https://registry.terraform.io/modules/weka/weka/gcp/latest).
{% endhint %}

## Private network considerations

To deploy a private network, the parameter `private_network = true` on the `setup_network` and `deploy_weka` modules level.

Depending on the required network topology, the following parameters are optional for private networking:

* To download the WEKA release from a local bucket, set the local bucket location in the  `install_url` parameter on the `deploy_weka` module level.&#x20;
* For Centos7 only, a distributive repository is required to download kernel headers and additional build software. To auto-configure yum to use a distributive repository, run `yum_repo_server`.&#x20;
* If a custom image is required, use `weka_image_id`.

## Object store integration

The Terraform package can automate the addition of a Google Cloud Storage bucket for use as object storage.

**Procedure**

1. In the `main.tf` file, add the following fields:
   * `tiering_enable_obs_integration:` Set the value to `true`.
   * `tiering_obs_name:` Match the value to an existing bucket in Google Cloud Storage.
   * `tiering_ssd_percent:` Set the percentage to your desired value.

Example:

```hcl
tiering_enable_obs_integration=true 
tiering_obs_name="myBucketName"
tiering_ssd_percent=20
```

{% hint style="info" %}
If you do not specify the name of an existing bucket using `tiering_obs_name` but specify `tiering_enable_obs_integration=true` then a new Cloud Storage bucket is created automatically.\
The name format of the new bucket is: \
`<project_id>-<prefix>-<cluster_name>-obs`
{% endhint %}
