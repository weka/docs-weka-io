---
description: Select supported Amazon EC2 instance types for WEKA Terraform deployments.
---

# Supported EC2 instance types using Terraform

## Backend EC2 instances

The following EC2 instance models can operate as **backend**, **client,** or **converged** instances. The default EC2 instance model for backends is **i3en.2xlarge**.

| EC2 instance type | Supported instances                                                                                  |
| ----------------- | ---------------------------------------------------------------------------------------------------- |
| i8ge              | i8ge.2xlarge, i8ge.3xlarge, i8ge.6xlarge, i8ge.12xlarge, i8ge.18xlarge, i8ge.24xlarge, i8ge.48xlarge |
| I3en              | i3en.2xlarge, i3en.3xlarge, i3en.6xlarge, i3en.12xlarge, i3en.24xlarge                               |

{% hint style="info" %}
Deployment on i8ge instance types supports POSIX and S3 protocols. In cloud deployments, SMB and NFS do not run on backend instances. Deploy them on dedicated protocol gateways, as described below. For requirements, see [additional-protocols-overview.md](../../additional-protocols/additional-protocols-overview.md "mention").
{% endhint %}

### Protocol gateway EC2 instances

The Terraform module deploys protocol gateways as separate instances from the backend cluster. The default EC2 instance model for NFS, SMB, and S3 protocol gateways is `c5n.2xlarge`. To use a different model, set the relevant variable in the `main.tf` file.

<table><thead><tr><th width="262.28125">Protocol</th><th>Terraform variable</th></tr></thead><tbody><tr><td>NFS</td><td><code>nfs_protocol_gateway_instance_type</code></td></tr><tr><td>SMB</td><td><code>smb_protocol_gateway_instance_type</code></td></tr><tr><td>S3</td><td><code>s3_protocol_gateway_instance_type</code></td></tr></tbody></table>

## Client EC2 instances

The following EC2 instance models can operate as **client** instances. The default EC2 instance model for clients is **c5.2xlarge**.

{% hint style="info" %}
* Support for WEKA client over UDP mode is extended to any Intel or AMD CPU-based instance type, provided that the VM type meets the resource requirements specified in the [prerequisites-and-compatibility.md](../prerequisites-and-compatibility.md "mention") topic.
* Any backend instance can also be a client instance.
{% endhint %}

### General purpose <a href="#general_purpose" id="general_purpose"></a>

| EC2 instance type | Supported instances                                                                                                                                                                             |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| M5                | m5.xlarge, m5.2xlarge, m5.4xlarge, m5.8xlarge, m5.12xlarge, m5.16xlarge, m5.24xlarge                                                                                                            |
| M5n               | m5n.xlarge, m5n.2xlarge, m5n.4xlarge, m5n.8xlarge, m5n.12xlarge, m5n.16xlarge, m5n.24xlarge, m5dn.xlarge, m5dn.2xlarge, m5dn.4xlarge, m5dn.8xlarge, m5dn.12xlarge, m5dn.16xlarge, m5dn.24xlarge |
| M6a               | m6a.xlarge, m6a.2xlarge, m6a.4xlarge, m6a.8xlarge, m6a.12xlarge, m6a.16xlarge, m6a24xlarge, m6a.32xlarge, m6a.48xlarge                                                                          |
| M6g               | m6g.xlarge, m6g.2xlarge, m6g.4xlarge, m6g.8xlarge, m6g.12xlarge, m6g.16xlarge                                                                                                                   |
| M6gd              | m6gd.xlarge, m6gd.2xlarge, m6gd.4xlarge, m6gd.8xlarge, 1m6gd.2xlarge, m6gd.16xlarge                                                                                                             |
| M6i               | m6i.xlarge, m6i.2xlarge, m6i.4xlarge, m6i.8xlarge, m6i.12xlarge, m6i.16xlarge, m6i.24xlarge, m6i.32xlarge                                                                                       |
| M6id              | m6id.xlarge, m6id.2xlarge, m6id.4xlarge, m6id.8xlarge, m6id.12xlarge, m6id.16xlarge, m6id.24xlarge, m6id.32xlarge                                                                               |
| M6idn             | m6idn.xlarge, m6idn.2xlarge, m6idn.4xlarge, m6idn.8xlarge, m6idn.12xlarge, m6idn.16xlarge, m6idn.24xlarge, m6idn.32xlarge                                                                       |
| M6in              | m6in.xlarge , m6in.2xlarge , m6in.4xlarge , m6in.8xlarge, m6in.12xlarge , m6in.16xlarge , m6in.24xlarge                                                                                         |
| M7a               | m7a.xlarge , m7a.2xlarge, m7a.4xlarge, m7a.8xlarge, m7a.12xlarge, m7a.16xlarge, m7a.24xlarge, m7a.32xlarge, m7a.48xlarge                                                                        |
| M7i               | m7i.xlarge, m7i.2xlarge, m7i.4xlarge, m7i.8xlarge, m7i.12xlarge, m7i.16xlarge, m7i.24xlarge, m7i.48xlarge                                                                                       |
| M7g               | m7g.xlarge, m7g.2xlarge, m7g.4xlarge, m7g.8xlarge, m7g.12xlarge, m7g.16xlarge                                                                                                                   |
| M7gd              | m7gd.xlarge, m7gd.2xlarge, m7gd.4xlarge, m7gd.8xlarge, m7gd.12xlarge, m7gd.16xlarge                                                                                                             |

### Compute optimized <a href="#compute_optimized" id="compute_optimized"></a>

| EC2 instance type | Supported instances                                                                                         |
| ----------------- | ----------------------------------------------------------------------------------------------------------- |
| C5                | c5.2xlarge, c5.4xlarge, c5.9xlarge, c5.12xlarge, c5.18xlarge, c5.24xlarge                                   |
| C5a               | c5a.2xlarge , c5a.4xlarge, c5a.8xlarge, c5a.12xlarge, c5a.16xlarge, c5a.24xlarge                            |
| C5ad              | c5ad.2xlarge , c5ad.4xlarge, c5ad.8xlarge, c5ad.12xlarge, c5ad.16xlarge, c5ad.24xlarge                      |
| C5n               | c5n.2xlarge, c5n.4xlarge, c5n.9xlarge, c5n.18xlarge                                                         |
| C6a               | c6a.2xlarge, c6a.4xlarge, c6a.8xlarge, c6a.12xlarge, c6a.16xlarge, c6a.32xlarge, c6a.48xlarge               |
| C6g               | c6g.2xlarge, c6g.4xlarge, c6g.8xlarge, c6g.12xlarge, c6g.16xlarge                                           |
| C6gd              | c6gd.2xlarge, c6gd.4xlarge, c6gd.8xlarge, c6gd.12xlarge, c6gd.16xlarge                                      |
| C6gn              | c6gn.2xlarge, c6gn.4xlarge, c6gn.8xlarge, c6gn.12xlarge, c6gn.16xlarge                                      |
| C6in              | c6in.2xlarge, c6in.4xlarge, c6in.8xlarge, c6in.12xlarge, c6in.16xlarge, c6in.24xlarge, c6in.32xlarge        |
| C7a               | c7a.2xlarge, c7a.4xlarge, c7a.8xlarge, c7a.12xlarge, c7a.16xlarge, c7a.24xlarge, c7a.32xlarge, c7a.48xlarge |
| C7g               | c7g.2xlarge, c7g.4xlarge, c7g.8xlarge, c7g.12xlarge, c7g.16xlarge                                           |
| C7gd              | c7gd.2xlarge, c7gd.4xlarge, c7gd.8xlarge, c7gd.12xlarge, c7gd.16xlarge                                      |
| C7i               | c7i.2xlarge, c7i.4xlarge, c7i.8xlarge, c7i.12xlarge, c7i.16xlarge, c7i.24xlarge, cC7i.48xlarge              |

### Memory optimized <a href="#memory_optimized" id="memory_optimized"></a>

| EC2 instance type | Supported instances                                                                                                       |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------- |
| R5                | r5.xlarge, r5.2xlarge, r5.4xlarge, r5.8xlarge, r5.12xlarge, r5.16xlarge, r5.24xlarge                                      |
| R5n               | r5n.xlarge, r5n.2xlarge, r5n.4xlarge, r5n.8xlarge, r5n.12xlarge, r5n.16xlarge, r5n.24xlarge                               |
| R6a               | r6a.xlarge, r6a.2xlarge, r6a.4xlarge, r6a.8xlarge, r6a.12xlarge, r6a.16xlarge, r6a.32xlarge, r6a.48xlarge                 |
| R6i               | r6i.xlarge, r6i.2xlarge, r6i.4xlarge, r6i.8xlarge, r6i.12xlarge, r6i.16xlarge, r6i.24xlarge, r6i.32xlarge                 |
| R6id              | r6id.xlarge, r6id.2xlarge, r6id.4xlarge, r6id.8xlarge, r6id.12xlarge, r6id.16xlarge, r6id.24xlarge, r6id.32xlarge         |
| R6idn             | r6idn.xlarge, r6idn.2xlarge, r6idn.4xlarge, r6idn.8xlarge, r6idn.12xlarge, r6idn.16xlarge, r6idn.24xlarge, r6idn.32xlarge |
| R6in              | r6in.xlarge, r6in.2xlarge, r6in.4xlarge, r6in.8xlarge, r6in.12xlarge, r6in.16xlarge, r6in.24xlarge, r6in.32xlarge         |
| R6g               | r6g.xlarge, r6g.2xlarge, r6g.4xlarge, r6g.8xlarge, r6g.12xlarge, r6g.16xlarge                                             |
| R6gd              | r6gd.xlarge, r6gd.2xlarge, r6gd.4xlarge, r6gd.8xlarge, r6gd.12xlarge, r6gd.16xlarge                                       |
| R7a               | r7a.xlarge, r7a.2xlarge, r7a.4xlarge, r7a.8xlarge, r7a.12xlarge, r7a.16xlarge, r7a.24xlarge, r7a.32xlarge, r7a.48xlarge   |
| R7iz              | r7iz.xlarge, r7iz.2xlarge, r7iz.4xlarge, r7iz.8xlarge, r7iz.12xlarge, r7iz.16xlarge, r7iz.32xlarge                        |
| R7g               | r7g.xlarge, r7g.2xlarge, r7g.4xlarge, r7g.8xlarge, r7g.12xlarge, r7g.16xlarge                                             |
| R7gd              | r7gd.xlarge, r7gd.2xlarge, r7gd.4xlarge, r7gd.8xlarge, r7gd.12xlarge, r7gd.16xlarge                                       |
| X1                | x1.16xlarge, x1.32xlarge                                                                                                  |
| X1e               | x1e.16xlarge, x1e.32xlarge                                                                                                |
| X2idn             | x2idn.16xlarge, x2idn.24xlarge, x2idn.32xlarge                                                                            |
| X2iedn            | x2iedn.xlarge, x2iedn.2xlarge, x2iedn.4xlarge, x2iedn.8xlarge, x2iedn.16xlarge, x2iedn.24xlarge                           |
| Z1d               | z1d.xlarge, z1d.2xlarge, z1d.3xlarge, z1d.6xlarge, z1d.12xlarge                                                           |

### Accelerated computing <a href="#accelerated_computing" id="accelerated_computing"></a>

| EC2 instance type | Supported instances                                                                               |
| ----------------- | ------------------------------------------------------------------------------------------------- |
| F1                | f1.2xlarge, f1.4xlarge, f1.16xlarge                                                               |
| G3                | g3.4xlarge, g3.8xlarge, g3.16xlarge                                                               |
| G4dn              | g4dn.2xlarge, g4dn.4xlarge, g4dn.8xlarge, g4dn.12xlarge, g4dn.16xlarge                            |
| G5                | g5.xlarge, g5.2xlarge, g5.4xlarge, g5.8xlarge, g5.12xlarge, g5.16xlarge                           |
| G5g               | g5g.2xlarge, g5g.4xlarge, g5g.8xlarge, g5g.16xlarge                                               |
| G6                | g6.xlarge, g6.2xlarge, g6.4xlarge, g6.8xlarge, g6.12xlarge, g6.16xlarge, g6.24xlarge, g6.48xlarge |
| GR6               | gr6.4xlarge, gr6.8xlarge                                                                          |
| Inf1              | inf1.2xlarge, inf1.6xlarge, inf1.24xlarge                                                         |
| Inf2              | inf2.xlarge, inf2.8xlarge, inf2.24xlarge, inf2.48xlarge                                           |
| P2                | p2.xlarge, p2.8xlarge, p2.16xlarge                                                                |
| P3                | p3.2xlarge, p3.8xlarge, p3.16xlarge                                                               |
| P4                | p4d.24xlarge, p4de.24xlarge                                                                       |
| P5                | p5.48xlarge                                                                                       |
| Trn1              | trn1.2xlarge, trn1.32xlarge , trn1n.32xlarge                                                      |

### Storage optimized

| EC2 instance type | Supported instances                                                                 |
| ----------------- | ----------------------------------------------------------------------------------- |
| I3en              | i3en.xlarge, i3en.2xlarge, i3en.3xlarge, i3en.6xlarge, i3en.12xlarge, i3en.24xlarge |

### HPC optimized <a href="#hpc_optimized" id="hpc_optimized"></a>

| EC2 instance type | Supported instances                            |
| ----------------- | ---------------------------------------------- |
| HPc6              | hpc6.48xlarge                                  |
| HPc6a             | hpc6a.48xlarge                                 |
| HPc7a             | hpc7a.12xlarge, hpc7a.48xlarge, hpc7a.96xlarge |

**Related information**

[AWS instance types](https://aws.amazon.com/ec2/instance-types/)
