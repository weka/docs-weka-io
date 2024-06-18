# Supported machine types and storage

## Supported machine types for backends

The following table provides the supported machine types (VM instance) for backends (and clients) applied by the Terraform package:

<table><thead><tr><th width="183">Machine series</th><th>Machine types</th></tr></thead><tbody><tr><td>C2</td><td>c2-standard-8, c2-standard-16</td></tr></tbody></table>

{% hint style="info" %}
* Each machine type supports 1, 2, 4, or 8 local SSD drives. Each drive has 375 GB (maximum 3 TB per instance). These drives are not individual SSDs but partitions locally to the physical server.
* The data in a WEKA cluster is protected with N+2 or N+4. However, use snap-to-object if the data needs further protection from multiple server failures.
* The C2 series may not be available in your chosen [GCP region](https://cloud.google.com/compute/docs/regions-zones).&#x20;
{% endhint %}

## Supported machine types for clients

Explore the two key technologies in network virtualization: **VirtIO in DPDK mode** and **gVNIC in UDP mode**. VirtIO in DPDK mode offers high-performance network interfaces in virtual machines, while gVNIC in UDP mode provides reliable, high-speed network connectivity.

### Supported machine types for clients over VirtIO in DPDK mode

<table><thead><tr><th width="169">Machine series</th><th>Machine type</th></tr></thead><tbody><tr><td>A2</td><td>a2-highgpu-1g, a2-highgpu-2g, a2-highgpu-4g, a2-highgpu-8g, <br>a2-megagpu-16g, a2-ultragpu-1g</td></tr><tr><td>C2</td><td>c2-standard-8, c2-standard-16</td></tr><tr><td>C2D</td><td>c2d-standard-4, c2d-standard-8, c2d-standard-16, c2d-standard-32, c2d-standard-56, c2d-standard-112, c2d-highmem-56</td></tr><tr><td>E2</td><td>e2-standard-4, e2-standard-8, e2-standard-16, e2-highmem-4, e2-highcpu-8</td></tr><tr><td>N2</td><td>n2-standard-4, n2-standard-8, n2-standard-16, n2-standard-32, <br>n2-standard-48, n2-standard-96, n2-standard-128, n2-highmem-32</td></tr><tr><td>N2D</td><td>n2d-standard-32, n2d-standard-64, n2d-highmem-32, n2d-highmem-64</td></tr></tbody></table>

### Supported machine types for clients over gVNIC in UDP mode

<table><thead><tr><th width="167">Machine series</th><th>Machine type</th></tr></thead><tbody><tr><td>A2</td><td><p>a2-highgpu-1g, a2-highgpu-2g, a2-highgpu-4g, a2-highgpu-8g, </p><p>a2-megagpu-16g, a2-ultragpu-1g</p></td></tr><tr><td>A3</td><td>a3-highgpu-8g</td></tr><tr><td>C2</td><td>c2-standard-8, c2-standard-16, c2-standard-30, c2-standard-60</td></tr><tr><td>C2D</td><td>c2d-standard-4, c2d-standard-8, c2d-standard-16, c2d-standard-32, c2d-standard-56, c2d-standard-112, c2d-highmem-56</td></tr><tr><td>C3</td><td>c3-standard-4, c3-standard-8, c3-standard-22, c3-standard-44, c3-standard-88, c3-standard-176, c3-highcpu-4, c3-highcpu-8, c3-highcpu-22, c3-highcpu-44, c3-highcpu-88, c3-highcpu-176, c3-highmem-4, c3-highmem-8, c3-highmem-22, c3-highmem-44, c3-highmem-88, c3-highmem-176, c3-standard-4-lssd, c3-standard-8-lssd, c3-standard-22-lssd, c3-standard-44-lssd, c3-standard-88-lssd, c3-standard-176-lssd</td></tr><tr><td>C3D</td><td>c3d-standard-4, c3d-standard-8, c3d-standard-16, c3d-standard-30, c3d-standard-60, c3d-standard-90, c3d-standard-180, c3d-standard-360, c3d-highcpu-4, c3d-highcpu-8, c3d-highcpu-16, c3d-highcpu-30, c3d-highcpu-60, c3d-highcpu-90, c3d-highcpu-180, c3d-highcpu-360, c3d-highmem-4, c3d-highmem-8, c3d-highmem-16, c3d-highmem-30, c3d-highmem-60, c3d-highmem-90, c3d-highmem-180, c3d-highmem-360, c3d-standard-8-lssd, c3d-standard-16-lssd, c3d-standard-30-lssd, c3d-standard-60-lssd, c3d-standard-90-lssd, c3d-standard-180-lssd, c3d-standard-360-lssd, c3d-highmem-8-lssd, c3d-highmem-16-lssd, c3d-highmem-30-lssd, c3d-highmem-60-lssd, c3d-highmem-90-lssd, c3d-highmem-180-lssd, c3d-highmem-360-lssd</td></tr><tr><td>G2</td><td>g2-standard-4, g2-standard-8, g2-standard-12, g2-standard-16, g2-standard-24, g2-standard-32, g2-standard-48, g2-standard-96</td></tr><tr><td>M3</td><td>m3-ultramem-32, m3-ultramem-64, m3-ultramem-128, m3-megamem-64, m3-megamem-128</td></tr><tr><td>N2</td><td>n2-standard-4, n2-standard-8, n2-standard-16, n2-standard-32, n2-standard-48, n2-standard-64, n2-standard-80, n2-standard-96, n2-standard-128, n2-highmem-4, n2-highmem-8, n2-highmem-16, n2-highmem-32, n2-highmem-48, n2-highmem-64, n2-highmem-80, n2-highmem-96, n2-highmem-128, n2-highcpu-8, n2-highcpu-16, n2-highcpu-32, n2-highcpu-48, n2-highcpu-64, n2-highcpu-80, n2-highcpu-96</td></tr><tr><td>N2D</td><td>n2d-standard-4, n2d-standard-8, n2d-standard-16, n2d-standard-32, n2d-standard-48, n2d-standard-64, n2d-standard-80, n2d-standard-96, n2d-standard-224, n2d-highmem-4, n2d-highmem-8, n2d-highmem-16, n2d-highmem-32, n2d-highmem-48, n2d-highmem-64, n2d-highmem-80, n2d-highmem-96, n2d-highcpu-8, n2d-highcpu-16, n2d-highcpu-32, n2d-highcpu-48, n2d-highcpu-64, n2d-highcpu-80, n2d-highcpu-96, n2d-highcpu-128, n2d-highcpu-224</td></tr><tr><td>N4</td><td>n4-standard-4, n4-standard-8, n4-standard-16, n4-standard-32, n4-standard-48, n4-standard-64, n4-standard-80, n4-highcpu-4, n4-highcpu-8, n4-highcpu-16, n4-highcpu-32, n4-highcpu-48, n4-highcpu-64, n4-highcpu-80, n4-highmem-4, n4-highmem-8, n4-highmem-16, n4-highmem-32, n4-highmem-48, n4-highmem-64, n4-highmem-80</td></tr></tbody></table>

**Related information**

[Machine families resource and comparison guide](https://cloud.google.com/compute/docs/machine-resource)
