# Detailed deployment tutorial: WEKA on GCP using Terraform

## Introduction

### **Purpose**

This guide is designed to assist customers, partners, and WEKA teams with the step-by-step deployment of the WEKA data platform on the Google Cloud Platform (GCP) using Terraform.

### **Document premise**

Deploying WEKA on GCP requires proficiency in several technologies, including GCP, Terraform[^1], basic Linux operations, and the WEKA software itself. Recognizing that not all individuals responsible for this deployment are experts in each of these areas, this document aims to provide comprehensive, end-to-end instructions. This ensures that readers with minimal prior knowledge can successfully deploy a functional WEKA cluster on GCP.

### **Document scope**

This document specifically addresses the deployment of WEKA in a GCP environment using Terraform, applicable for both proof-of-concept (POC) and production settings. While no pre-existing GCP elements are necessary beyond an appropriate user account, the guide demonstrates the use of some pre-existing components, as many environments already have these in place.

The reader is guided through:

1. General GCP requirements.
2. Networking requirements to support WEKA.
3. Deployment of WEKA using Terraform.
4. Verification of a successful WEKA deployment.

{% hint style="info" %}
Images embedded in this document can be enlarged with a single click for ease of viewing and a clearer and more detailed examination.
{% endhint %}

## Terraform preparation and installation

HashiCorp Terraform is a powerful tool that allows you to define, provision, and manage infrastructure as code. You can specify your infrastructure setup in a configuration file using a declarative configuration language, HashiCorp Configuration Language (HCL), or JSON. Terraform then uses this file to automatically create, modify, or delete resources, ensuring consistent and predictable deployment of your infrastructure components such as servers, databases, and networks.

This document outlines the process for automating the deployment of the WEKA Data Platform on Google Cloud Platform (GCP) using Terraform. Terraform's widespread adoption and prominence in the Infrastructure as Code (IaC) domain drive its choice. Organizations of all sizes globally leverage Terraform to deploy persistent infrastructure both on-premises and across public clouds like AWS, Azure, and Google Cloud Platform.

To install Terraform, we recommend following the [official installation guides](https://developer.hashicorp.com/terraform/install) provided by HashiCorp. Additionally, Terraform can be run directly from the GCP Cloud Terminal, which comes with Terraform pre-installed, as illustrated in this guide.

### GCP account

It is essential for the customer to understand their subscription structure for deployments within a WEKA customer environment. If you are deploying internally at WEKA and cannot locate an Account ID or have not been added to the appropriate account, contact the relevant cloud team for assistance.

### User account privileges

Ensure that the GCP IAM user has the permissions outlined in [Appendix A](https://app.gitbook.com/o/-L7Tp-Uy9BMSCSCx0MlK/s/lGKb8DZItQx3Jy6unw5f/\~/changes/193/planning-and-installation/weka-installation-on-gcp/detailed-deployment-tutorial-weka-on-gcp-using-terraform#appendix-a-required-permissions-that-terraform-needs) to perform the necessary operations for a successful WEKA deployment on GCP using Terraform. The IAM user must be able to create, modify, and delete GCP resources as specified by the Terraform configuration files used in the WEKA deployment.

If the current IAM user lacks the permissions detailed in [Appendix A](https://app.gitbook.com/o/-L7Tp-Uy9BMSCSCx0MlK/s/lGKb8DZItQx3Jy6unw5f/\~/changes/193/planning-and-installation/weka-installation-on-gcp/detailed-deployment-tutorial-weka-on-gcp-using-terraform#appendix-a-required-permissions-that-terraform-needs), either update the user's permissions or create a new IAM user with the required privileges.

**Verify GCP IAM user permissions**

1. Navigate to the GCP Management Console.
2. Log in using the account intended for the WEKA deployment.
3. In the GCP Console, go to the Services menu and select **IAM** to access the Identity and Access Management dashboard.

<figure><img src="../../.gitbook/assets/image (185).png" alt=""><figcaption></figcaption></figure>

4. Within the IAM dashboard, locate the relevant IAM user by searching for their account.

<figure><img src="../../.gitbook/assets/image (186).png" alt=""><figcaption></figcaption></figure>

5. Click on the user's **Security insights** to review their permissions.
6. Ensure that the user possesses the permissions listed in [Appendix A](https://app.gitbook.com/o/-L7Tp-Uy9BMSCSCx0MlK/s/lGKb8DZItQx3Jy6unw5f/\~/changes/193/planning-and-installation/weka-installation-on-gcp/detailed-deployment-tutorial-weka-on-gcp-using-terraform#appendix-a-required-permissions-that-terraform-needs), which are necessary for managing GCP resources through Terraform.

<figure><img src="../../.gitbook/assets/image (187).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (188).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
While this user has full administrative access to enable Terraform to deploy WEKA, it is recommended to follow the principle of [applying the least-privilege permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#grant-least-privilege). Grant only the specific permissions outlined in Appendix A to ensure security best practices.
{% endhint %}

### GCP quotas

For a successful WEKA deployment on GCP using Terraform, ensure your GCP project has the necessary quotas for the required resources. When setting up compute instances, such as the c2 type for the WEKA backend cluster, manage quotas based on the CPU count for each compute instance type or family.

Before deploying WEKA, confirm that your compute instance's CPU sizing requirements (determined in partnership with WEKA) can be met within the existing quota limits. If not, increase the quotas in your GCP project before executing the Terraform commands detailed later in this document.

The required minimum quota is the total CPU count for all instances (for example, deploying 10 c2.standard-8 instances requires 80 CPUs just for the cluster). Ensuring sufficient quotas prevents failures during the execution of Terraform commands, as discussed in subsequent sections.

#### Set service quotas

1. Navigate to the [GCP Console](https://console.cloud.google.com/) and search for the service **Quotas & System Limits**.

<figure><img src="../../.gitbook/assets/image (189).png" alt=""><figcaption></figcaption></figure>

2. On the Quotas page, search for **CPU** and select the compute instance type family, in this case, **c2**.

<figure><img src="../../.gitbook/assets/image (190).png" alt=""><figcaption></figcaption></figure>

3. Locate the region where you intend to deploy WEKA and confirm that there are sufficient available CPUs of the specified family type. If not, adjust the quota accordingly.

<figure><img src="../../.gitbook/assets/image (191).png" alt=""><figcaption></figcaption></figure>

## GCP Resource Prerequisites

The WEKA deployment incorporates several GCP components, including VPCs, Subnets, Security Groups, Endpoints, and others. These elements can be either generated by the WEKA Terraform modules or exist beforehand if manually creating components to use.

Four VPCs (Virtual Private Clouds), each with at least one Subnet and a Security Group, are required at minimum. This guide assumes that Terraform generates these items for WEKA within the environment.

### Networking requirements

The Terraform deployment can automatically establish VPC peering connections from the new VPCs to your current VPC, which is utilized by the application servers consuming WEKA storage. Considering how GCP handles compute instances with multiple vNICs, it is advisable to allow Terraform to create the required networking for WEKA.

This guide assumes an already deployed VPC and the necessity of adding four WEKA-specific VPCs. This requirement arises from GCP networking constraints, where each VM instance can only have one vNIC per VPC. However, WEKA mandates a minimum of four vNICs per instance. Ensure that you have the CIDR information for the four subnets created in the new VPCs to prevent conflicts.

<figure><img src="../../.gitbook/assets/image (192).png" alt=""><figcaption></figcaption></figure>

## Deploy WEKA in GCP using Terraform

The WEKA Terraform modules establish peering connections between the newly created VPCs for WEKA and an existing VPC within the environment. Therefore, the initial networking step involves identifying the VPC to peer with.

**VPC**

<figure><img src="../../.gitbook/assets/image (193).png" alt=""><figcaption></figcaption></figure>

**Subnet (in VPC)**

<figure><img src="../../.gitbook/assets/image (194).png" alt=""><figcaption></figcaption></figure>

### Locate the WEKA user token

The WEKA user token provides access to the WEKA binaries and is used to access get.weka.io during installation.

1. In a web browser, navigate to [get.weka.io](https://get.weka.io/).
2. Select the user's name located in the upper right-hand corner of the page.

<figure><img src="../../.gitbook/assets/image (195).png" alt=""><figcaption></figcaption></figure>

2. From the column on the left-hand side of the page, select **API Tokens**. The user’s API token is displayed. Note it for using it later in the installation process.

<figure><img src="../../.gitbook/assets/image (196).png" alt=""><figcaption></figcaption></figure>

### Deploy WEKA in GCP with Terraform: private VPCs example

The following demonstrates deploying WEKA into Virtual Private Clouds (VPCs) and Subnets without exposing the instances to Internet access.

The [Terraform module package](https://registry.terraform.io/modules/weka/weka/gcp/latest) is designed for deploying various GCP resources essential for WEKA deployment on GCP, including Compute instances, cloud functions, and VPCs.

#### Description of sub-modules in the module package

* **IAM roles, networks, and security groups:** These modules create the necessary IAM roles, networks, and security groups for WEKA deployment. If specific IDs for security groups or subnets are not provided, the modules generate them automatically.
* **Service account:** This module automatically creates a service account that the WEKA deployment functions and services use.
* **Network:** To deploy a private network with Network Address Translation (NAT), certain variables need to be set, such as create\_nat\_gateway to true and providing a private CIDR range. To prevent instances from obtaining public IPs, set assign\_public\_ip to false.
* **Shared\_VPCs and VPC\_Peering:** These modules handle the peering of VPCs to each other and existing VPCs if provided.
* **Clients (optional):** This module automatically mounts clients to the WEKA cluster. Users can specify the number of clients to create along with optional variables such as instance type, number of network interfaces (NICs), and AMI ID.
* **Protocol\_Gateways NFS/SMB (optional):** Similar to the client's module, this module allows users to specify the number of protocol gateways per protocol. Additional configuration details, such as instance type and disk size, can also be provided.
* **Worker\_Pool:** This module creates a private pool to build GCP cloud functions.

#### Prepare the main.tf file

1. Sign in to Google Cloud Platform and access the **Cloud Shell**.

<figure><img src="../../.gitbook/assets/image (197).png" alt=""><figcaption></figcaption></figure>

2. If the Terminal is not associated with the project intended for WEKA deployment, close it, switch to the correct project, and reopen it.

<figure><img src="../../.gitbook/assets/image (198).png" alt=""><figcaption></figcaption></figure>

#### Organize the structure of the Terraform configuration files

1. Create a directory specifically for the Terraform configuration files. \
   To maintain state information, it's essential to keep each Terraform deployment separate.\
   Other deployments can be executed by duplicating these instructions and naming the directory appropriately, such as **deploy1** or another unique identifier.

```bash
mkdir deploy
```

2. Navigate to the created directory.

```bash
cd deploy
```

3. To display accessible output data on the screen during the process, create an **output.tf** file in the deploy directory, and insert the following content:

```json
output "weka_deployment_output" {
  value = module.weka_deployment
}
```

4. Save the **output.tf** file.
5. Define the Terraform options by creating the main.tf file using your preferred text editor. Use the following template and replace the placeholders `< >` with the values specific to your deployment environment:

```json
provider "google" {
  project     = "<your_project>"
  region      = "<your_region>"
  zone        = "<your_zone>"
}
module "weka_deployment" {
  source                   = "weka/weka/gcp"
  version                  = "4.0.6"
  cluster_name             = "<name_for_the_cluster>"
  project_id               = "<your_project_id>"
  region                   = "<your_region>"
  zone                     = "<your_zone>"
  cluster_size             = 7
  nvmes_number             = 2
  get_weka_io_token        = "<your_wekaio_token>"
  private_dns_name         = "weka.private.net."
  tiering_enable_obs_integration = true
  assign_public_ip               = false
  create_nat_gateway       = true
  vpcs_to_peer_to_deployment_vpc = ["<your_existing_vpc"]
  subnets_range            = ["<CIDR_for_subnet_for_wekavpc1>", "<CIDR_for_subnet_for_wekavpc2>", "<CIDR_for_subnet_for_wekavpc3>", "<CIDR_for_subnet_for_wekavpc4>"]
```

<details>

<summary>Main.tf file with example values</summary>

This Main.tf file includes example values. Do not copy and paste it directly for your deployment.

```jsx
provider "google" {
  project     = "wekaio-public"
  region      = "us-east1"
  zone        = "us-east1-b"
}
module "weka_deployment" {
  source                   = "weka/weka/gcp"
  version                  = "4.0.6"
  cluster_name             = "gcp-weka"
  project_id               = "wekaio-public"
  region                   = "us-east1"
  zone                     = "us-east1-b"
  cluster_size             = 7
  nvmes_number             = 2
  weka_version             = "4.3.0"
  get_weka_io_token        = "LB9ciQ7aDpHihJXc"
  private_dns_name         = "weka.private.net."
  tiering_enable_obs_integration = true
  assign_public_ip               = false
  create_nat_gateway       = true
  vpcs_to_peer_to_deployment_vpc = ["default-POC"]
  subnets_range            = ["10.100.0.0/24", "10.101.0.0/24", "10.102.0.0/24", "10.103.0.0/24"]
```

</details>

{% hint style="info" %}
Authentication is managed through the Google Cloud Terminal.
{% endhint %}

6. After creating and saving the main.tf file, execute the following command in the same directory. This ensures that the required Terraform resource files from GCP are downloaded and accessible to the system.

```json
terraform init
```

7. Before applying or destroying a Terraform configuration file, it's recommended to run the following:

```json
terraform plan
```

If GCP requires authentication, grant permission accordingly.

8. To initiate the deployment of WEKA in GCP, run the following command:

```json
terraform apply
```

This command initiates the creation of GCP resources essential for WEKA. When prompted, confirm the deployment of resources by typing **yes**.

Upon completing the Terraform GCP resource deployment process, a summary of the outcome is displayed. In the event of an unsuccessful deployment, an error message indicating failure is shown instead.

```json
Outputs:

weka_deployment_output = {
  "client_ips" = []
  "cluster_helper_commands" = <<-EOT
  ########################################## get cluster status ##########################################
  curl -m 70 -X POST "https://weka-gcp-weka-status-t6p6clcama-ue.a.run.app" \
  -H "Authorization:bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type:application/json" -d '{"type":"progress"}'
  # for fetching cluster status pass: -d '{"type":"status"}'
  
  ########################################## resize cluster command ##########################################
  curl -m 70 -X POST "https://weka-gcp-weka-weka-functions-t6p6clcama-ue.a.run.app?action=resize" \
  -H "Authorization:bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type:application/json" \
  -d '{"value":ENTER_NEW_VALUE_HERE}'
  
  
  ########################################## pre-terraform destroy, cluster terminate function ################
  
  # replace CLUSTER_NAME with the actual cluster name, as a confirmation of the destructive action
  # this function needs to be executed before terraform destroy
  curl -m 70 -X POST "https://weka-gcp-weka-weka-functions-t6p6clcama-ue.a.run.app?action=terminate_cluster" \
  -H "Authorization:bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type:application/json" \
  -d '{"name":"CLUSTER_NAME"}'
  
  
  ################################# get weka password secret login ############################################
  
  gcloud secrets versions access 1 --secret=weka-gcp-weka-password  --project wekaio-public --format='get(payload.data)' | base64 -d
  
  ############################################## get backend ips ##############################################
  
  gcloud compute instances list --filter="labels.weka_cluster_name=gcp-weka" --format "get(networkInterfaces[0].networkIP)" --project wekaio-public
  
  
  EOT
  "cluster_name" = "gcp-weka"
  "functions_url" = {
    "destroy" = {
      "body" = {
        "name" = "gcp-weka"
      }
      "url" = "https://weka-gcp-weka-weka-functions-t6p6clcama-ue.a.run.app?action=terminate_cluster"
    }
    "progressing_status" = {
      "body" = {
        "type" = "progress"
      }
      "url" = "https://weka-gcp-weka-status-t6p6clcama-ue.a.run.app"
    }
    "resize" = {
      "body" = {
        "value" = 7
      }
      "url" = "https://weka-gcp-weka-weka-functions-t6p6clcama-ue.a.run.app?action=resize"
    }
    "status" = {
      "body" = {
        "type" = "status"
      }
      "url" = "https://weka-gcp-weka-status-t6p6clcama-ue.a.run.app"
    }
  }
  "get_cluster_status_uri" = "https://weka-gcp-weka-status-t6p6clcama-ue.a.run.app"
  "lb_url" = "gcp-weka.weka.private.net"
  "nfs_protocol_gateways_ips" = tostring(null)
  "private_ssh_key" = "/tmp/weka-gcp-weka-private-key.pem"
  "project_id" = "wekaio-public"
  "resize_cluster_uri" = "https://weka-gcp-weka-weka-functions-t6p6clcama-ue.a.run.app?action=resize"
  "smb_protocol_gateways_ips" = tostring(null)
  "terminate_cluster_uri" = "https://weka-gcp-weka-weka-functions-t6p6clcama-ue.a.run.app?action=terminate_cluster"
  "vm_username" = "weka"
  "weka_cluster_password_secret_id" = "weka-gcp-weka-password"
}
```

{% hint style="info" %}
Refer to the `Get WEKA Password Secret Login` section for future reference. This section contains the necessary information to retrieve the WEKA password.
{% endhint %}

#### Additional commands in the output

The output includes several other commands to allow you to view information or modify the deployment, in addition to a command to look up the WEKA admin password.

* Get cluster status
* Resize cluster command
* Pre-terraform destroy, cluster terminate function
* Get backend ips

Run the `get cluster status` command to verify the state of the WEKA deployment.

```jsx
  curl -m 70 -X POST "https://weka-gcp-weka-status-t6p6clcama-ue.a.run.app" \
  -H "Authorization:bearer $(gcloud auth print-identity-token)" \
  -H "Content-Type:application/json" -d '{"type":"status"}'
```

Here is the output from the example

{% code overflow="wrap" %}
```jsx

{"initial_size":7,"desired_size":8,"clusterized":true,"weka_status":{"hot_spare":1,**"io_status":"STARTED"**,"drives":{"active":16,"total":16},"name":"gcp-weka","io_status_changed_time":"2024-05-13T13:43:50.740546Z","io_nodes":{"active":24,"total":24},"cloud":{"enabled":true,"healthy":true,"proxy":"","url":"https://api.home.weka.io"},"release_hash":"f94d361cf0e465a4f04214064b5f019b9149baf3","hosts":{"active_count":24,"backends":{"active":24,"total":24},"clients":{"active":0,"total":0},"total_count":24},"stripe_data_drives":4,"release":"4.3.0","active_alerts_count":2,"capacity":{"total_bytes":3376488600000,"hot_spare_bytes":482217460000,"unprovisioned_bytes":482217460000},"is_cluster":true,"status":"OK","stripe_protection_drives":2,"guid":"603d3b67-03ce-49af-8833-4f2e6a985b1e","nodes":{"black_listed":0,"total":48},"licensing":{"io_start_eligibility":true,"usage":{"drive_capacity_gb":6442,"usable_capacity_gb":3376,"obs_capacity_gb":0},"mode":"Unlicensed"}}}
```
{% endcode %}

The section **`"io_status":"STARTED"`** shows that the cluster is fully up and running and ready for access.

### Deploy protocol nodes (NFS and SMB)

The Terraform deployment simplifies the process of deploying additional compute instances to serve as protocol nodes for NFS or SMB. These protocol nodes are separate from the instances designated for the WEKA backend cluster.

To deploy protocol nodes, add more information to the `main.tf` file.

The simplest approach is to specify the number of protocol nodes for each type (NFS and SMB) and use default settings for the other parameters. If you plan to distribute your NFS or SMB connections across multiple protocol nodes manually, you can adjust these numbers according to your needs. For instance, if you have three projects, each requiring its own bandwidth for NFS, you can deploy three protocol gateways. Assign each project the IP address or DNS entry of its respective gateway to use as the NFS server.

Add the following before the last `‘}’` of the main.tf file.

```bash
## Protocol Nodes ##

## For deploying NFS protocol nodes ##
nfs_protocol_gateways_number = 2 # A minimum of two is required

## For deploying SMB protocol nodes ##
smb_protocol_gateways_number = 3 # A minimum of three is required 
```

## Collect login access information about the WEKA cluster

### **Obtain the WEKA cluster IP addresses**

To obtain the IP addresses of your WEKA cluster, follow these steps:

1. Visit the GCP Compute Engine VM instances dashboard.

<figure><img src="../../.gitbook/assets/image (199).png" alt=""><figcaption></figcaption></figure>

2. Identify the WEKA backend servers. The instance names follow the format: `<cluster_name>-<Timestamp>`, where `<cluster_name>` corresponds to the value specified in the `main.tf` file.

<figure><img src="../../.gitbook/assets/image (200).png" alt=""><figcaption></figcaption></figure>

3. Select any WEKA backend instance and note the IP address of `nic0`.

This IP address is used if your subnet assigns a public IP address to the instance (that is if the VM instance is configured accordingly). WEKA uses only private IPv4 addresses for all interface IP addresses for communication.

#### Retrieve the **WEKA cluster access password**

The WEKA cluster password is securely stored in the Google Cloud Platform (GCP) Secret Manager. You can retrieve it using the `gcloud` command from the Terraform output or through the GCP console. Follow these steps to access the password through the GCP console:

1. Open the GCP console and search for **Secret Manager**.

<figure><img src="../../.gitbook/assets/image (201).png" alt=""><figcaption></figcaption></figure>

2. Navigate to the **Secrets** section within the Secret Manager.

<figure><img src="../../.gitbook/assets/image (202).png" alt=""><figcaption></figcaption></figure>

3. Locate and select the secret named `weka_<cluster_name>_password` corresponding to your deployment.
4. Select the Actions option and select **View secret value**.

<figure><img src="../../.gitbook/assets/image (203).png" alt=""><figcaption></figcaption></figure>

The system displays the randomly generated password assigned to the WEKA user admin.

<figure><img src="../../.gitbook/assets/image (204).png" alt=""><figcaption></figcaption></figure>

### Access the WEKA cluster backends

You can access the WEKA cluster backend instances through SSH directly from the GCP browser window. This method allows you to run WEKA CLI commands and gather logs as needed.

Follow these steps to connect to the backend instances:

1. Open the GCP console.
2. Navigate to the Compute Engine section.
3. Select the instance you wish to access.
4. Select the SSH button to open a browser-based SSH session.

<figure><img src="../../.gitbook/assets/image (205).png" alt=""><figcaption></figcaption></figure>

## Access and review the WEKA GUI

To access the WEKA GUI, use a jump host with a GUI deployed within the same VPC and subnet as the WEKA cluster.

### Access the WEKA GUI

In the following examples, a Windows 10 instance with a public IP address is deployed in the same VPC, subnet, and security group as the WEKA cluster. The network security group rules are added to allow RDP explicit access to the Windows 10 system.

1. Open a browser in the Windows 10 jump box.
2. Visit https://\<cluster-backend-ip>:14000. The WEKA GUI sign-in screen appears.
3. Sign in as user **admin** and use the password retrieved earlier ( see [#retrieve-the-weka-cluster-access-password](detailed-deployment-tutorial-weka-on-gcp-using-terraform.md#retrieve-the-weka-cluster-access-password "mention")).

{% hint style="info" %}
The provided examples are for reference. The values shown below may differ from those of your cluster.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (206).png" alt=""><figcaption></figcaption></figure>

### Review the WEKA GUI

1. View the cluster GUI home screen.

<figure><img src="../../.gitbook/assets/image (207).png" alt=""><figcaption></figcaption></figure>

2. Review the cluster backends. Check the status and details of the backend instances.

<figure><img src="../../.gitbook/assets/image (208).png" alt=""><figcaption></figcaption></figure>

3. Review the clients, if any, attached to the cluster.

<figure><img src="../../.gitbook/assets/image (209).png" alt=""><figcaption></figcaption></figure>

4. Review the filesystems.

<figure><img src="../../.gitbook/assets/image (210).png" alt=""><figcaption></figcaption></figure>

## Automated scale-out and scale-in of the WEKA backend cluster

The WEKA backend cluster can be scaled out and scaled in using an API call through the GCP Cloud terminal.

The WEKA backend cluster can be dynamically scaled out and scaled in using API calls through the GCP Cloud terminal. The process is managed by Terraform-created functions that automatically trigger when a new instance is initiated or retired. These functions execute the necessary automation processes to adjust the cluster's computing resources.

To scale out from the initial deployment, use the CLI command provided in the Terraform output.

<figure><img src="../../.gitbook/assets/image (211).png" alt=""><figcaption><p>Example: Scale-out from 7 backends to 8</p></figcaption></figure>

### Benefits of auto-scaling

* **Replace unhealthy instances:**
  * Auto Scaling automatically initiates the replacement of instances that fail health checks. It launches new instances and incorporates them into the WEKA cluster, ensuring continuous availability and responsiveness.
  * This process mitigates the impact of instance failures by promptly integrating the new instance into the cluster and service.
* **Graceful scaling:**
  * Auto-scaling configurations can be adjusted to perform scaling actions gradually. This prevents sudden spikes in traffic and minimizes application disruptions.
  * This measured approach maintains a balanced and stable environment, effectively adapting to changes in demand without causing abrupt changes.

## **Test WEKA cluster self-healing functionality (optional)**

To validate the self-healing functionality of the WEKA cluster, you can decommission an old instance and allow the Auto Heal feature to launch a new one. Follow this brief guide:

1. **Identify the old instance:** Locate the GCP VM instance you want to decommission. This can be based on factors such as age, outdated configurations, or other criteria.
2. **Terminate the old instance:** Manually terminate the identified GCP VM instance using the GCP Management Console, gcloud CLI, or SDKs. This action triggers the Auto Heal process.
3. **Verify the new instance:** Ensure the new instance is successfully launched, passes the health checks, and joins the cluster. Confirm that the cluster's overall capacity remains unchanged.
4. **Document and monitor:** Record the decommissioning process and monitor the cluster to ensure it continues to operate smoothly with the new instance in place.

## APPENDICES

### Appendix A: Required permissions that Terraform needs

The **Compute Engine** and **Workflows API** services must be enabled to allow the following services:

* artifactregistry.googleapis.com
* cloudbuild.googleapis.com
* cloudfunctions.googleapis.com
* cloudresourcemanager.googleapis.com
* cloudscheduler.googleapis.com
* compute.googleapis.com
* dns.googleapis.com
* eventarc.googleapis.com
* iam.googleapis.com
* secretmanager.googleapis.com
* servicenetworking.googleapis.com
* serviceusage.googleapis.com
* vpcaccess.googleapis.com
* workflows.googleapis.com

The user running the Terraform module requires the following roles to run the `terraform apply`:

* roles/cloudfunctions.admin
* roles/cloudscheduler.admin
* roles/compute.admin
* roles/compute.networkAdmin
* roles/compute.serviceAgent
* roles/dns.admin
* roles/iam.serviceAccountAdmin
* roles/iam.serviceAccountUser
* roles/pubsub.editor
* roles/resourcemanager.projectIamAdmin
* roles/secretmanager.admin
* roles/servicenetworking.networksAdmin
* roles/storage.admin
* roles/vpcaccess.adminroles/workflows.admin

[^1]: Terraform is an infrastructure-as-code tool for provisioning and managing cloud infrastructure
