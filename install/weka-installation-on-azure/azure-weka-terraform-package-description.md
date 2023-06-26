# Azure-WEKA Terraform package description

[Azure-WEKA Terraform package](https://github.com/weka/terraform-azure-weka) contains modules and examples to customize the WEKA cluster installation on Azure. The default protocol deployed using the Terraform package is POSIX. The Azure-WEKA Terraform package supports the following deployment types:

* **Public cloud deployments:** Require passing the `get.weka.io` token to Terraform for downloading the WEKA release from the public [get.weka.io](https://get.weka.io) service. The following examples are provided:
  * Public network.
  * Public network with existing object store.
* **Private cloud deployments:** Require uploading the WEKA release tar file into an Azure blob container from which the virtual machines can download the WEKA release. The following examples are provided:
  * Existing private network.
  * Existing private network with peering.

## Terraform variables file

Each deployment type includes a variables file `vars.auto.tfvars` that contains only the variables required for the relevant deployment type.

Select an example to see the related variables:

{% tabs %}
{% tab title="Public network" %}
```go
prefix              = "weka"
rg_name             = "weka-rg"
address_space       = "10.0.0.0/16"
subnet_prefixes     = "10.0.2.0/24"
subnet_delegation   = "10.0.1.0/25"
cluster_name        = "poc"
instance_type       = "Standard_L8s_v3"
set_obs_integration = true
tiering_ssd_percent = 20
cluster_size        = 6
```
{% endtab %}

{% tab title="public network with existing OBS" %}
```go
prefix              = "weka"
rg_name             = "weka-rg"
address_space       = "10.0.0.0/16"
subnet_prefixes     = "10.0.1.0/24"
subnet_delegation   = "10.0.2.0/25"
cluster_name        = "poc"
instance_type       = "Standard_L8s_v3"
set_obs_integration = true
obs_name            = "obs-blob"
obs_container_name  = "obs-container"
blob_obs_access_key = ""
tiering_ssd_percent = 20
cluster_size        = 6
```
{% endtab %}

{% tab title="Existing private network" %}
```go
prefix              = "weka"
rg_name             = "weka-rg"
vnet_name           = "weka-vnet"
subnet_name         = "weka-subnet-0"
subnet_delegation   = "10.0.2.0/25"
cluster_name        = "poc"
private_network     = true
install_weka_url    = "https://wekadeploytars.blob.core.windows.net/tars/weka-4.1.0.71.tar"
instance_type       = "Standard_L8s_v3"
set_obs_integration = true
tiering_ssd_percent = 20
cluster_size        = 6
```
{% endtab %}

{% tab title="Existing private network with peering" %}
```go
prefix              = "weka"
rg_name             = "weka-rg"
vnet_name           = "weka-vnet"
subnet_name         = "weka-subnet-0"
subnet_delegation   = "10.0.2.0/25"
cluster_name        = "poc"
private_network     = true
set_obs_integration = true
tiering_ssd_percent = 20
cluster_size        = 6
instance_type       = "Standard_L8s_v3"
apt_repo_url        = "http://11.0.0.4/ubuntu/mirror/archive.ubuntu.com/ubuntu/"
install_weka_url    = "https://wekadeploytars.blob.core.windows.net/tars/weka-4.1.0.71.tar"
vnet_to_peering = [{
  vnet = "ubuntu20-apt-repo-vnet"
  rg   = "ubuntu20-apt-repo-rg"
 }
]
```
{% endtab %}
{% endtabs %}



**Main variable descriptions**

<table><thead><tr><th width="269">Variable</th><th>Description</th></tr></thead><tbody><tr><td><code>prefix</code></td><td>The prefix for all the resource names. For example, the prefix for your system name.</td></tr><tr><td><code>rg_name</code></td><td>A predefined resource group in the Azure subscription.</td></tr><tr><td><code>address_space</code></td><td>IP address/mask determining the range of overall IP addresses used for the VNet.<br>For example, if you set the <code>address_space</code> parameter to <code>10.0.0.0/16</code>, it means the VNet has an IP address range from <code>10.0.0.0</code> to <code>10.0.255.255</code>, allowing for a total of 65,536 available IP addresses.</td></tr><tr><td><code>subnet_prefixes</code></td><td>IP address/mask determining the range of IP addresses to allocate to subnets within the VNet.<br>For example, if you specify <code>10.0.2.0/24</code> as a subnet prefix, it means the subnet has an IP address range from <code>10.0.2.0</code> to <code>10.0.2.255</code>, allowing for 256 available IP addresses.</td></tr><tr><td><code>subnet_delegation</code></td><td>IP address/mask determining the range of the delegated subnet enabling the the auto-scale function app to control the Azure resources.<br>For example, if you specify <code>10.0.1.0/25</code> as a subnet prefix, it means the subnet has an IP address range from <code>10.0.1.0</code> to <code>10.0.1.127</code>, allowing for 128 available IP addresses.</td></tr><tr><td><code>cluster_name</code></td><td>The cluster name.</td></tr><tr><td><code>instance_type</code></td><td><p>The virtual machine type to deploy.</p><p>See <a href="supported-virtual-machine-types.md">Supported virtual machine types</a>.</p></td></tr><tr><td><code>set_obs_integration</code></td><td>Determines whether to enable object stores on the WEKA cluster.</td></tr><tr><td><code>tiering_ssd_percent</code></td><td>When <code>set_obs_integration</code> is set to <code>true</code>, this variable sets the capacity percentage of the filesystem that resides on SSD.<br>For example, for an SSD with a total capacity of 20 GB, and the tiering_ssd_percent is set to 20, the total available capacity is 100 GB.</td></tr><tr><td><code>cluster_size</code></td><td>The number of virtual machines to deploy. <br>The minimum value is 6.</td></tr><tr><td><code>obs_name</code></td><td>Object store name.</td></tr><tr><td><code>obs_container_name</code></td><td>Object store container name.</td></tr><tr><td><code>blob_obs_access_key</code></td><td>Object store access key.</td></tr><tr><td><code>private_network</code></td><td>For a private network, set the value as <code>true</code>.</td></tr><tr><td><code>vnet_name</code></td><td>The existing VNet name.</td></tr><tr><td><code>subnet_name</code></td><td>Subnet name.</td></tr><tr><td><code>apt_repo_url</code></td><td>The URL to access the Advanced Package Tool (APT) package repository.</td></tr><tr><td><code>install_weka_url</code></td><td>WEKA installation files URL.</td></tr><tr><td><code>vnet_to_peering</code></td><td>List of VNet name and resource group to peer.</td></tr></tbody></table>

{% hint style="danger" %}
Name values must be in lowercase and without special characters.\
The total number of characters of the `prefix`+ `rg_name` + `cluster_name`, must not exceed 24 characters.
{% endhint %}

**Related information**

[Azure-Weka Terraform package](https://github.com/weka/terraform-azr-weka)
