# Supported virtual machine types

## Supported VM sizes for backends

On Azure, WEKA is deployed in a multi-container architecture using the storage-optimized Lsv3-series and Lasv3-series Azure Virtual Machines (Azure VMs). These VMs feature high throughput, low latency, and directly mapped local NVMe storage.

Each VM size has a specific number of NICs, but only one is used for all traffic in UDP mode through the management interface.

The following table lists the VM sizes applied by the Terraform package on the backends:

| VM size | vCPU | Memory (GiB) | NVMe disks | Max NICs | BW (Mbps) |
| --- | --- | --- | --- | --- | --- |
| Standard_L8s_v3 | 8 | 64 | 1x1.92 TB | 4 | 12500 |
| Standard_L16s_v3 | 16 | 128 | 2x1.92 TB | 8 | 12500 |
| Standard_L32s_v3 | 32 | 256 | 4x1.92 TB | 8 | 16000 |
| Standard_L48s_v3 | 48 | 384 | 6x1.92 TB | 8 | 24000 |
| Standard_L64s_v3 | 64 | 512 | 8x1.92 TB | 8 | 30000 |
| Standard_L80s_v3 | 80 | 640 | 10x1.92 TB | 8 | 32000 |
| Standard_L8as_v3 | 8 | 64 | 1x1.92 TB | 4 | 12500 |
| Standard_L16as_v3 | 16 | 128 | 2x1.92 TB | 8 | 12500 |
| Standard_L32as_v3 | 32 | 256 | 4x1.92 TB | 8 | 16000 |
| Standard_L48as_v3 | 48 | 384 | 6x1.92 TB | 8 | 24000 |
| Standard_L64as_v3 | 64 | 512 | 8x1.92 TB | 8 | 32000 |
| Standard_L80as_v3 | 80 | 640 | 10x1.92 TB | 8 | 32000 |

{% hint style="info" %}
Using the Azure Console, the client instances can have different virtual machine types provisioned separately from the WEKA cluster.
{% endhint %}

**Related information**

[Lsv3-series](https://learn.microsoft.com/en-us/azure/virtual-machines/lsv3-series) and [Lasv3-series](https://learn.microsoft.com/en-us/azure/virtual-machines/lasv3-series) (Azure learning site)

### Mapped cores to processes

In each virtual machine size, the cores are mapped to a specific number of the compute, drive, and frontend processes. For example, in the Standard\_L16s\_v3 size, the cores are mapped to the following processes:

* Compute: 4
* Drive: 2
* Frontend: 1

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/azure_lvs16.png" alt="" width="563"><figcaption><p>Mapped WEKA processes for a standard_L16s_v3</p></figcaption></figure></div>

| VM size | # of compute cores | # of drive cores | # of frontend cores |
| --- | --- | --- | --- |
| Standard_L8s_v3 | 1 | 1 | 1 |
| Standard_L16s_v3 | 4 | 2 | 1 |
| Standard_L32s_v3 | 4 | 2 | 1 |
| Standard_L48s_v3 | 3 | 3 | 1 |
| Standard_L64s_v3 | 4 | 2 | 1 |
| Standard_L80s_v3 | 4 | 2 | 1 |
| Standard_L8as_v3 | 1 | 1 | 1 |
| Standard_L16as_v3 | 4 | 2 | 1 |
| Standard_L32as_v3 | 4 | 2 | 1 |
| Standard_L48as_v3 | 3 | 3 | 1 |
| Standard_L64as_v3 | 4 | 2 | 1 |
| Standard_L80as_v3 | 4 | 2 | 1 |

## Supported VM sizes for clients

### General purpose virtual machine sizes <a href="#general-purpose-virtual-machine-sizes" id="general-purpose-virtual-machine-sizes"></a>

| VM series | VM size |
| --- | --- |
| Dsv3 | Standard_D4s_v3, Standard_D8s_v3, Standard_D16s_v3 |
| Dasv4 | Standard_D2as_v4, Standard_D4as_v4, Standard_D8as_v4 |
| Ddsv4 | Standard_D16ds_v4 |
| Dasv4 | Standard_D4as_v4, Standard_D16as_v4, Standard_D32as_v4, Standard_D96as_v4 |
| Dv5 | Standard_D8_v5 |
| Dsv5 | Standard_D4s_v5 ,Standard_D16s_v5, Standard_D48s_v5 , Standard_D64s_v5 |
| Dadsv5 | Standard_D4ads_v5, Standard_D16ads_v5, Standard_D48ads_v5, Standard_D96ads_v5 |
| Dcsv2 | Standard_DC4s_v2 (UDP only) |
| Dasv5 | Standard_D2as_v5, Standard_D8as_v5 |
| Dpldsv5 | Standard_D8plds_v5, Standard_D32plds_v5, Standard_D64plds_v5 |
| Dpsv5 | Standard_D4ps_v5, Standard_D8ps_v5, Standard_D16ps_v5, Standard_D32ps_v5, Standard_D48ps_v5, Standard_D64ps_v5 |

### Memory optimized virtual machine sizes

| VM series | VM size |
| --- | --- |
| Edsv4 | Standard_E16ds_v4, Standard_E16-8ds_v4, Standard_E32ds_v4, |
| Easv4 | Standard_E32-16as_v4 |
| Easv5 | Standard_E32-16as_v5 |
| Edsv4 | Standard_E32-16ds_v4, Standard_E48ds_v4 |
| Eadsv5 | Standard_E96ads_v5 |
| Mdmsv2 | Standard_M64dms_v2 |
| Msv2 | Standard_M208s_v2 |
| Mmsv2 | Standard_M208ms_v2, Standard_M416ms_v2 |
| Epsv5 | Standard_E4ps_v5, Standard_E8ps_v5, Standard_E16ps_v5, Standard_E20ps_v5, Standard_E32ps_v5 |

### Compute optimized virtual machine sizes

| VM series | VM size |
| --- | --- |
| FXmds | Standard_FX48mds |
| Fsv2 | Standard_F8s_v2, Standard_F32s_v2, Standard_F64s_v2, Standard_F72s_v2 |

### Storage optimized virtual machine sizes

| VM series | VM size |
| --- | --- |
| Lsv3 | Standard_L8s_v3, Standard_L16s_v3, Standard_L32s_v3, Standard_L48s_v3, Standard_L64s_v3, Standard_L80s_v3 |

### High performance optimized

| VM series | VM size |
| --- | --- |
| HBv4 | Standard_HB176rs_v4, Standard_HB176-24rs_v4, Standard_HB176-96rs_v4 |
| HBv3 | Standard_HB120rs_v3 |

### GPU - accelerated compute

| VM series | VM size |
| --- | --- |
| NGads V620 | Standard_NG8ads_V620_v1, Standard_NG16ads_V620_v1, Standard_NG32ads_V620_v1 |
| NVadsA10 | Standard_NVadsA10_v5 |

**Related information**

[Sizes for virtual machines in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes) (Azure site)
