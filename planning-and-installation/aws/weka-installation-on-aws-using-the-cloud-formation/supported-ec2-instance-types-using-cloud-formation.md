---
description: >-
  This page lists all instance types available in the Cloud Formation template
  generator.
---

# Supported EC2 instance types using Cloud Formation

## Storage EC2 instances

The following EC2 instance types can operate as **backend**, **client,** or **converged** instances:

<table><thead><tr><th width="237">EC2 instance type</th><th>Supported models</th></tr></thead><tbody><tr><td>I3en</td><td>i3en.2xlarge, i3en.3xlarge, i3en.6xlarge, i3en.12xlarge, i3en.24xlarge</td></tr></tbody></table>

## Client EC2 instances

The following EC2 instance types can operate as **client** instances.

{% hint style="info" %}
Any backend instance can also be a client instance.
{% endhint %}

<table><thead><tr><th width="235">EC2 instance type</th><th>Supported models</th></tr></thead><tbody><tr><td>C5</td><td>c5.2xlarge, c5.4xlarge, c5.9xlarge, c5.12xlarge, c5.18xlarge, c5.24xlarge</td></tr><tr><td>C5n</td><td>c5n.2xlarge, c5n.4xlarge, c5n.9xlarge, c5n.18xlarge</td></tr><tr><td>C6a</td><td>c6a.2xlarge, c6a.4xlarge, c6a.8xlarge, c6a.12xlarge, c6a.16xlarge, c6a.32xlarge, c6a.48xlarge</td></tr><tr><td>C6in</td><td>c6in.2xlarge, c6in.4xlarge, c6in.8xlarge, c6in.12xlarge, c6in.16xlarge, c6in.24xlarge, c6in.32xlarge</td></tr><tr><td>C7i</td><td>c7i.2xlarge, c7i.4xlarge, c7i.8xlarge, c7i.12xlarge, c7i.16xlarge, c7i.24xlarge, cC7i.48xlarge</td></tr><tr><td>G3</td><td>g3.4xlarge, g3.8xlarge, g3.16xlarge</td></tr><tr><td>G4</td><td>g4dn.2xlarge, g4dn.4xlarge, g4dn.8xlarge, g4dn.12xlarge, g4dn.16xlarge</td></tr><tr><td>G5</td><td>g5.xlarge, g5.2xlarge, g5.4xlarge, g5.8xlarge, g5.12xlarge, g5.16xlarge, g5.32xlarge</td></tr><tr><td>HPc7a</td><td>hpc7a.2xlarge, hpc7a.48xlarge, hpc7a.96xlarge</td></tr><tr><td>I3</td><td>i3.xlarge, i3.2xlarge, i3.4xlarge, i3.8xlarge, i3.16xlarge</td></tr><tr><td>I3en</td><td>i3en.xlarge, i3en.2xlarge, i3en.3xlarge, i3en.6xlarge, i3en.12xlarge, i3en.24xlarge</td></tr><tr><td>Inf1</td><td>inf1.2xlarge, inf1.6xlarge, inf1.24xlarge</td></tr><tr><td>Inf2</td><td>inf2.xlarge, inf2.8xlarge, inf2.24xlarge, inf2.48xlarge</td></tr><tr><td>M5</td><td>m5.xlarge, m5.2xlarge, m5.4xlarge, m5.8xlarge, m5.12xlarge, m5.16xlarge, m5.24xlarge</td></tr><tr><td>M5n</td><td>m5n.xlarge, m5n.2xlarge, m5n.4xlarge, m5n.8xlarge, m5n.12xlarge, m5n.16xlarge, m5n.24xlarge, m5dn.xlarge, m5dn.2xlarge, m5dn.4xlarge, m5dn.8xlarge, m5dn.12xlarge, m5dn.16xlarge, m5dn.24xlarge</td></tr><tr><td>M6a</td><td>m6a.xlarge, m6a.2xlarge, m6a.4xlarge, m6a.8xlarge, m6a.12xlarge, m6a.16xlarge, m6a24xlarge, m6a.32xlarge, m6a.48xlarge</td></tr><tr><td>M6i</td><td>m6i.xlarge, m6i.2xlarge, m6i.4xlarge, m6i.8xlarge, m6i.12xlarge, m6i.16xlarge, m6i.24xlarge, m6i.32xlarge</td></tr><tr><td>M6id</td><td>m6id.xlarge, m6id.2xlarge, m6id.4xlarge, m6id.8xlarge, m6id.12xlarge, m6id.16xlarge, m6id.24xlarge, m6id.32xlarge</td></tr><tr><td>M6idn</td><td>m6idn.xlarge, m6idn.2xlarge, m6idn.4xlarge, m6idn.8xlarge, m6idn.12xlarge, m6idn.16xlarge, m6idn.24xlarge, m6idn.32xlarge</td></tr><tr><td>P2</td><td>p2.xlarge, p2.8xlarge, p2.16xlarge</td></tr><tr><td>P3</td><td>p3.2xlarge, p3.8xlarge, p3.16xlarge</td></tr><tr><td>P4</td><td>p4d.24xlarge, p4de.24xlarge</td></tr><tr><td>R5</td><td>r5.xlarge, r5.2xlarge, r5.4xlarge, r5.8xlarge, r5.12xlarge, r5.16xlarge, r5.24xlarge</td></tr><tr><td>R5n</td><td>r5n.xlarge, r5n.2xlarge, r5n.4xlarge, r5n.8xlarge, r5n.12xlarge, r5n.16xlarge, r5n.24xlarge</td></tr><tr><td>R6a</td><td>r6a.xlarge, r6a.2xlarge, r6a.4xlarge, r6a.8xlarge, r6a.12xlarge, r6a.16xlarge, r6a.32xlarge, r6a.48xlarge</td></tr><tr><td>R6i</td><td>r6i.xlarge, r6i.2xlarge, r6i.4xlarge, r6i.8xlarge, r6i.12xlarge, r6i.16xlarge, r6i.24xlarge, r6i.32xlarge</td></tr><tr><td>R6id</td><td>r6id.xlarge, r6id.2xlarge, r6id.4xlarge, r6id.8xlarge, r6id.12xlarge, r6id.16xlarge, r6id.24xlarge, r6id.32xlarge</td></tr><tr><td>R6idn</td><td>r6idn.xlarge, r6idn.2xlarge, r6idn.4xlarge, r6idn.8xlarge, r6idn.12xlarge, r6idn.16xlarge, r6idn.24xlarge, r6idn.32xlarge</td></tr><tr><td>R6in</td><td>r6in.xlarge, r6in.2xlarge, r6in.4xlarge, r6in.8xlarge, r6in.12xlarge, r6in.16xlarge, r6in.24xlarge, r6in.32xlarge</td></tr><tr><td>X1</td><td>x1.16xlarge, x1.32xlarge</td></tr><tr><td>X1e</td><td>x1e.16xlarge, x1e.32xlarge</td></tr></tbody></table>

**Related topics**

[deployment-types.md](deployment-types.md "mention")

[prerequisites-and-compatibility](../../prerequisites-and-compatibility/ "mention")



**Related information**

[AWS instance types](https://aws.amazon.com/ec2/instance-types/)
