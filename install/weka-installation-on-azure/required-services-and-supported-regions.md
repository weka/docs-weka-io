# Required services and supported regions

The region must support the services used in WekaFS on Azure. The following sections list these services and the current regions that support them. See the related information below for updates.

## Required services used in Weka on Azure

* [Lsv3-series](https://learn.microsoft.com/en-us/azure/virtual-machines/lsv3-series) (VM type)
* [Functions](https://learn.microsoft.com/en-us/azure/azure-functions/)
* [Virtual Machine Scale Sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/) (VMSS)
* [Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/)
* [Zone-redundant storage](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy#zone-redundant-storage) (ZRS) Blobs
* [Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/)
* [Load Balancer](https://learn.microsoft.com/en-us/azure/load-balancer/) (LB)

## Supported regions

* **Americas**
  * Brazil South
  * Canada Central
  * Central US
  * East US
  * East US 2
  * North Central US
  * South Central US
  * West US
  * West US 2
  * West US 3
* **Europe**
  * France Central
  * Germany West Central
  * North Europe
  * West Europe
  * UK South
  * Sweden Central
* **Middle East**
  * Qatar Central
* **Asia**
  * Australia East
  * Australia Southeast
  * Central India
  * China North 3
  * Japan East
  * East Asia
  * Southeast Asia

{% hint style="info" %}
**Note:** Australia Southeast, Canada East, and North Central US do not include the Zone-redundant storage (ZRS) blob. If the snap-to-object feature is required, use a bucket from a different region or a lower durability blob such as the Locally-redundant storage (LRS) blob.
{% endhint %}

****

**Related information**

[Azure Products available by region](https://azure.microsoft.com/en-us/explore/global-infrastructure/products-by-region/?products=storage)

[Azure regions with availability zone support](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-service-support#azure-regions-with-availability-zone-support)
