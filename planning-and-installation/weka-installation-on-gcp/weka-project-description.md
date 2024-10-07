# WEKA project description

The WEKA project uses internal GCP resources. A basic WEKA project includes a cluster with multiple virtual private clouds (VPCs), virtual machines (VMs), a load balancer, DNS, cloud storage, a secret manager, and other components for managing cluster resizing. Peering between all virtual networks enables functions to run across them, with each VPC connected to every other VPC in a full mesh.

<figure><img src="../../.gitbook/assets/GCP_puplic_network.png" alt="" width="563"><figcaption><p>WEKA project on the GCP</p></figcaption></figure>

### Resize cloud function operation

A resize cloud function in vpc-0 and a workload listener are deployed for auto-scale instances in GCP. Once a user sends a [request for resizing](auto-scale-instances-in-gcp.md) the number of instances in the cluster, the workload listener checks the _cluster state_ file in the cloud storage and triggers the resize cloud function if a resize is required. The cluster state file is an essential part of the resizing decision. It indicates states such as:

* Readiness of the cluster.
* The number of existing instances.
* The number of requested instances.

The secret manager retains the user name (usually _admin_) and the Terraform-generated password. The resize cloud function uses the user name and password to operate on the cluster instances.

## GCP internet connectivity

During WEKA deployment, the instances require access to a YUM repository and the WEKA software. This can be achieved through one of the following methods:

* **External IPs:** Allow an external IP address in VPC0 for each instance. This enables direct connection to public internet resources such as a YUM repository and get.weka.io.
* **NAT gateway:** Add a NAT Gateway to VPC0 to allow the instances to connect to the public internet resources through the gateway.
* **Private YUM repository:** If connecting to an external YUM repository and get.weka.io is impossible, specify an internal YUM repository and a private download link for the WEKA software.
