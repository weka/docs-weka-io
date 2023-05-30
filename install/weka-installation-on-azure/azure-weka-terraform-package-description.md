# Azure-WEKA Terraform package description

The [Azure-WEKA Terraform package](https://github.com/weka/terraform-azure-weka) contains modules and examples to customize the WEKA cluster installation on Azure. The default protocol deployed using the Terraform package is POSIX. The Azure-WEKA Terraform package supports the following deployment types:

* **Public cloud deployments:** Require passing the `get.weka.io` token to Terraform for downloading the WEKArelease from the public [get.weka.io](https://get.weka.io) service. The following examples are provided:
  * Public network.
  * Public network with an existing network.
  * Public network with multiple clusters.
  * Public network with existing object stores.
* **Private cloud deployments:** Require uploading the WEKA release tar file into an Azure blob container from which the virtual machines can download the WEKA release. The following examples are provided:
  * Private network with an existing network.
  * Private network with multiple clusters.
  * Private network with peering.

## Terraform variables file

Each deployment type includes a variables file `vars.auto.tfvars` that contains only the variables required for the relevant deployment type.

The following is an example of a public network with an existing network variables file.

### Public network with an existing network: `vars.auto.tfvars` example&#x20;

The public network with an existing network, in which the network-related resources are already provisioned.

As part of the deployment, you customize the values according to your deployment.

```
prefix                = "mySystemPrefix"
rg_name               = "myResourceGroup"
vnet_name             = "myVnet"
subnet_name_list      = ["mySubnet-0"]
cluster_name          = "myCluster"
instance_type         = "Standard_L8s_v3"
set_obs_integration   = true
tiering_ssd_percent   = 20
cluster_size          = 6

```

{% hint style="info" %}
**Note**: This is just one example of the variables files. The other examples may include more variables according to the deployment type.
{% endhint %}

**Variable descriptions**

<table><thead><tr><th width="249">Variable</th><th width="514.3333333333333">Description</th></tr></thead><tbody><tr><td><code>prefix</code></td><td>The prefix for all the resource names. For example, the prefix for your system name.</td></tr><tr><td><code>rg_name</code></td><td>A predefined resource group in the Azure subscription.</td></tr><tr><td><code>vnet_name</code></td><td>The virtual network name.</td></tr><tr><td><code>subnets_name_list</code></td><td>The subnet name list.</td></tr><tr><td><code>cluster_name</code></td><td>The cluster name.</td></tr><tr><td><code>instance_type</code></td><td><p>The virtual machine type to deploy.</p><p>See <a href="supported-virtual-machine-types.md">Supported virtual machine types</a>.</p></td></tr><tr><td><code>set_obs_integration</code></td><td>Determines whether to enable object stores on the WEKA cluster.</td></tr><tr><td><code>tiering_ssd_percent</code></td><td>When <code>set_obs_integration</code> is set to <code>true</code>, this variable sets the capacity percentage of the filesystem that resides on SSD.<br>For example, for an SSD with a total capacity of 20GB, and the tiering_ssd_percent is set to 20, the total available capacity is 100GB.</td></tr><tr><td><code>cluster_size</code></td><td>The number of virtual machines to deploy. <br>The minimum value is 6.</td></tr></tbody></table>

{% hint style="info" %}
Name values must be in lowercase and without special characters.\
The total number of characters of the `prefix`+ `rg_name` + `cluster_name`, must not exceed 24 characters.
{% endhint %}

**Related information**

[Azure-Weka Terraform package](https://github.com/weka/terraform-azr-weka)
