# Azure-WEKA Terraform package description

The [Azure-WEKA Terraform package](https://github.com/weka/terraform-azure-weka) contains modules and examples to customize the WEKA cluster installation on Azure. The default protocol deployed using the Terraform package is POSIX. The Azure-WEKA Terraform package supports the following deployment types:

* **Public cloud deployments:** Require passing the `get.weka.io` token to Terraform for downloading the WEKA release from the public [get.weka.io](https://get.weka.io) service. The following examples are provided:
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

| Variable              | Description                                                                                                                                                                                                                                                                                            |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `prefix`              | The prefix for all the resource names. For example, the prefix for your system name.                                                                                                                                                                                                                   |
| `rg_name`             | A predefined resource group in the Azure subscription.                                                                                                                                                                                                                                                 |
| `vnet_name`           | The virtual network name.                                                                                                                                                                                                                                                                              |
| `subnets_name_list`   | The subnet name list.                                                                                                                                                                                                                                                                                  |
| `cluster_name`        | The cluster name.                                                                                                                                                                                                                                                                                      |
| `instance_type`       | <p>The virtual machine type to deploy.</p><p>See <a href="supported-virtual-machine-types.md">Supported virtual machine types</a>.</p>                                                                                                                                                                 |
| `set_obs_integration` | Determines whether to enable object stores on the WEKA cluster.                                                                                                                                                                                                                                        |
| `tiering_ssd_percent` | <p>When <code>set_obs_integration</code> is set to <code>true</code>, this variable sets the capacity percentage of the filesystem that resides on SSD.<br>For example, for an SSD with a total capacity of 20GB, and the tiering_ssd_percent is set to 20, the total available capacity is 100GB.</p> |
| `cluster_size`        | <p>The number of virtual machines to deploy. <br>The minimum value is 6.</p>                                                                                                                                                                                                                           |

{% hint style="info" %}
Name values must be in lowercase and without special characters.\
The total number of characters of the `prefix`+ `rg_name` + `cluster_name`, must not exceed 24 characters.
{% endhint %}

**Related information**

[Azure-Weka Terraform package](https://github.com/weka/terraform-azr-weka)
