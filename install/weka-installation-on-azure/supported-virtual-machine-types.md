# Supported virtual machine types

On Azure, WEKA is deployed in a multiple containers architecture using the Lsv3-series of Azure Virtual Machines (Azure VMs), which features high throughput, low latency, and directly mapped local NVMe storage.

Each virtual machine size has a specific number of NICs, but only one is used for UDP mode connection for all traffic through the management interface.&#x20;

The following table provides the virtual machine sizes that are applied by the Terraform package with their specifications:

<table><thead><tr><th>VM size</th><th>vCPU</th><th>Memory (GiB)</th><th>NVMe disks</th><th>Max NICs</th><th data-type="number">BW (Mbps)</th></tr></thead><tbody><tr><td>Standard_L8s_v3</td><td>8</td><td>64</td><td>1x1.92 TB</td><td>4</td><td>12500</td></tr><tr><td>Standard_L16s_v3</td><td>16</td><td>128</td><td>2x1.92 TB</td><td>8</td><td>12500</td></tr><tr><td>Standard_L32s_v3</td><td>32</td><td>256</td><td>4x1.92 TB</td><td>8</td><td>16000</td></tr><tr><td>Standard_L48s_v3</td><td>48</td><td>384</td><td>6x1.92 TB</td><td>8</td><td>24000</td></tr><tr><td>Standard_L64s_v3</td><td>64</td><td>512</td><td>8x1.92 TB</td><td>8</td><td>30000</td></tr></tbody></table>

{% hint style="info" %}
**Note:** Using the Azure Console, the client instances can have different virtual machine types provisioned separately from the WEKA cluster.
{% endhint %}

**Related information**

[Lsv3-series](https://learn.microsoft.com/en-us/azure/virtual-machines/lsv3-series) (Azure learning site)

## Mapped cores to processes

In each virtual machine size, the cores are mapped to a specific number of the compute, drive, and frontend processes. For example, in the Standard\_L16s\_v3 size, the cores are mapped to the following processes:

* Compute: 4
* Drive: 2
* Frontend: 1

<figure><img src="../../.gitbook/assets/azure_lvs16.png" alt=""><figcaption><p>Mapped WEKA processes for a standard_L16s_v3</p></figcaption></figure>

| VM size            | # of compute cores | # of drive cores | # of frontend cores |
| ------------------ | ------------------ | ---------------- | ------------------- |
| Standard\_L8s\_v3  | 1                  | 1                | 1                   |
| Standard\_L16s\_v3 | 4                  | 2                | 1                   |
| Standard\_L32s\_v3 | 4                  | 2                | 1                   |
| Standard\_L48s\_v3 | 3                  | 3                | 1                   |
| Standard\_L64s\_v3 | 4                  | 2                | 1                   |