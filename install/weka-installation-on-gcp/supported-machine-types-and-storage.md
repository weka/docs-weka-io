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

{% hint style="info" %}
Support for WEKA client over UDP mode is extended to any Intel or AMD CPU-based virtual machine (VM) type using gVNIC or VirtIO, provided that the VM type meets the resource requirements specified in the[prerequisites-and-compatibility.md](../../support/prerequisites-and-compatibility.md "mention") topic.
{% endhint %}

The following table provides the machine types supported for WEKA clients over VirtIO in DPDK mode.

<table><thead><tr><th width="169">Machine series</th><th>Machine type</th></tr></thead><tbody><tr><td>A2</td><td>a2-highgpu-1g, a2-highgpu-2g, a2-highgpu-4g, a2-highgpu-8g, <br>a2-megagpu-16g, a2-ultragpu-1g</td></tr><tr><td>C2</td><td>c2-standard-8, c2-standard-16</td></tr><tr><td>C2D</td><td>c2d-standard-4, c2d-standard-8, c2d-standard-16, c2d-standard-32, c2d-standard-56, c2d-standard-112, c2d-highmem-56</td></tr><tr><td>E2</td><td>e2-standard-4, e2-standard-8, e2-standard-16, e2-highmem-4, e2-highcpu-8</td></tr><tr><td>N2</td><td>n2-standard-4, n2-standard-8, n2-standard-16, n2-standard-32, <br>n2-standard-48, n2-standard-96, n2-standard-128</td></tr><tr><td>N2D</td><td>n2d-standard-32, n2d-standard-64, n2d-highmem-32, n2d-highmem-64, n2-highmem-32</td></tr></tbody></table>

**Related information**

[Machine families resource and comparison guide](https://cloud.google.com/compute/docs/machine-resource)
