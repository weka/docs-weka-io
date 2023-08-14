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

### Public VPC terraform file example&#x20;

The following is the content of the `terraform.tfvars` file for the public VPC example. As part of the **write** phase, you customize the values according to your deployment.

```
project_id               = "myProjectID"
region                   = "europe-west1"
zone                     = "europe-west1-b"
subnets_cidr_range       = ["10.0.0.0/24", "10.1.0.0/24", "10.2.0.0/24", "10.3.0.0/24"]
cluster_size             = 7
nvmes_number             = 2
vpc_connector_range      = "10.8.0.0/28"
cluster_name             = "myClusterName"
```

**Variable descriptions**

<table><thead><tr><th width="293">Variable</th><th width="259">Description</th><th>Limitations</th></tr></thead><tbody><tr><td><code>project_id</code></td><td>Your GCP project name.</td><td></td></tr><tr><td><code>region</code></td><td>Wide geographic region.<br>See <a href="required-services-and-supported-regions.md">Required services and supported regions</a>.<br></td><td>The region must support the required services.</td></tr><tr><td><code>zone</code></td><td>Specific zone in the region.</td><td></td></tr><tr><td><code>subnets_cidr_range</code></td><td>IP addresses within your range. Provide one IP address per NIC.</td><td></td></tr><tr><td><code>cluster_size</code></td><td>The number of instances to create.</td><td>The minimum cluster size is 7.</td></tr><tr><td><code>nvmes_number</code></td><td><code>1</code>, <code>2</code>, <code>4</code>, or <code>8</code>.<br>Each NVME size is 375 GB.</td><td></td></tr><tr><td><code>vpc_connector_range</code></td><td>It must be within your IP space.</td><td></td></tr><tr><td><code>cluster_name</code></td><td>The name for the cluster as you choose. It must be in lowercase and without special characters.</td><td></td></tr></tbody></table>

## Private network considerations

To deploy a private network, the parameter `private_network = true` on the `setup_network` and `deploy_weka` modules level.

Depending on the required network topology, the following parameters are optional for private networking:

* To download the WEKA release from a local bucket, set the local bucket location in the  `install_url` parameter on the `deploy_weka` module level.&#x20;
* For Centos7 only, a distributive repository is required to download kernel headers and additional build software. To auto-configure yum to use a distributive repository, run `yum_repo_server`.&#x20;
* If a custom image is required, use `weka_image_id`.

## Object store integration

The WEKA Terraform package can automate the addition of a Google Cloud Storage bucket for use as object storage.

**Procedure**

1. In the `main.tf` file, add the following fields:
   * `set_obs_integration`: Set the value to `true`.
   * `obs_name`:  Match the value to an existing bucket in Google Cloud Storage.
   * `tiering_ssd_percent:` Set the percentage to your desired value.

Example:

```
set_obs_integration=true 
obs_name="myBucketName"
tiering_ssd_percent = 20
```

{% hint style="info" %}
If you do not specify the name of an existing bucket using `obs_name`, but specify `set_obs_integration=true` then a new Cloud Storage bucket is created automatically.\
The name format of the new bucket is: \
`<project_id>-<prefix>-<cluster_name>-obs`
{% endhint %}
