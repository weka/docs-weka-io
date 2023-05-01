# GCP Terraform package description

WEKA provides a ready-to-deploy [GCP Terraform package](https://github.com/weka/gcp-tf) you can customize for installing the WEKA cluster on GCP.

The GCP Terraform package contains the following modules:

* **setup\_network**: includes vpcs, subnets, peering, firewall, and health check.
* **service\_account**: includes the service account used for deployment with all necessary permissions.
* **deploy\_weka**: includes the actual WEKA deployment, instance template, cloud functions, workflows, job schedulers, secret manager, buckets, and health check.
* **shared\_vpcs** (_optional_): includes VPC sharing the WEKA deployment network with another hosting project. For example, when deploying a private network.

See the README files in the GCP-Terraform package for more details about the modules and their properties.

## GCP Terraform package supported deployment types

The GCP-Terraform package supports the following deployment types:

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

## Terraform variables file

Each deployment type includes a variables file `terraform.tfvars` that contains only the variables required for the relevant deployment type. The following is an example of the public VPC variables file. See the README files in the GCP-Terraform package for the other variables files.

### `tf.tfvars` example: Public VPC

The following is the content of the `terraform.tfvars` file for the public VPC example. As part of the **write** phase, you customize the values according to your deployment.

```
project                  = "gcp1"
region                   = "europe-west1"
zone                     = "europe-west1-b"
prefix                   = "weka"
subnets_cidr_range       = ["10.0.0.0/24", "10.1.0.0/24", "10.2.0.0/24", "10.3.0.0/24"]
nics_number              = 4
cluster_size             = 8
machine_type             = "c2-standard-8"
nvmes_number             = 2
weka_version             = "4.1.0"
internal_bucket_location = "EU"
vpc_connector_range      = "10.8.0.0/28"
sa_name                  = "deploy-sa"
cluster_name             = "hpc1"
sg_public_ssh_cidr_range = ["0.0.0.0/0"]
private_network          = false
```

**Variable descriptions**

| Variable                   | Description                                                                                                                                 | Limitations                                             |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `project`                  | Your GCP project name.                                                                                                                      |                                                         |
| `region`                   | <p>Wide geographic region.<br>See <a href="required-services-and-supported-regions.md">Required services and supported regions</a>.<br></p> | The region must support the required services.          |
| `zone`                     | Specific zone in the region.                                                                                                                |                                                         |
| `prefix`                   | The prefix for your system name as you choose.                                                                                              | It must be in lowercase and without special characters. |
| `subnets_cidr_range`       | IP addresses within your range. Provide one IP address per NIC.                                                                             |                                                         |
| `nics_number`              | <p><code>4</code> for c2-standard-8, or<br><code>7</code> for c2-standard-16</p>                                                            |                                                         |
| `cluster_size`             | The number of instances to create.                                                                                                          | The minimum cluster size is 7.                          |
| `machine_type`             | <p><code>c2-standard-8</code>, or<br><code>c2-standard-16</code>.</p>                                                                       |                                                         |
| `nvmes_number`             | <p><code>1</code>, <code>2</code>, <code>4</code>, or <code>8</code>.<br>Each NVME size is 375 GB.</p>                                      |                                                         |
| `weka_version`             | The WEKA version from V4.1.0.                                                                                                               |                                                         |
| `internal_bucket_location` | The internal bucket location must be local to your region.                                                                                  |                                                         |
| `vpc_connector_range`      | It must be within your IP space.                                                                                                            |                                                         |
| `sa_name`                  | Leave it as is unless the environment requires a service account naming convention.                                                         |                                                         |
| `cluster_name`             | The name for the cluster as you choose. It must be in lowercase and without special characters.                                             |                                                         |
| `sg_public_ssh_cidr_range` | If the cluster is public, leave the default.                                                                                                |                                                         |
| `private_network`          | <p><code>false</code> for a public network.<br><code>true</code> for a private network (isolated network). </p>                             |                                                         |

## Private network considerations

To deploy a private network, the parameter `private_network = true` on the `setup_network` and `deploy_weka` modules level.

Depending on the required network topology, the following parameters are optional for private networking:

* To download the WEKA release from a local bucket, set the local bucket location in the  `install_url` parameter on the `deploy_weka` module level.&#x20;
* For Centos7 only, a distributive repository is required to download kernel headers and additional build software. To auto-configure yum to use a distributive repository, run `yum_repo_server`.&#x20;
* If a custom image is required, use `weka_image_id`.
