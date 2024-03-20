# Deployment on GCP using Terraform

WEKA provides a Terraform-GCP-WEKA module with a `main.tf` file you create according to your deployment needs.&#x20;

Applying the created `main.tf` file performs the following:

* Creates VPC networks and subnets on the GCP project.
* Deploys GCP instances.
* Installs the WEKA software.
* Configures the WEKA cluster**.**
* Additional GCP objects.

## Prerequisites

Before installing the WEKA software on GCP, the following prerequisites must be met:

* [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install): It is pre-installed if you use the Cloud Shell.
* [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli): It is pre-installed if you use the Cloud Shell. Ensure the Terraform version meets the minimum required version specified in the [Terraform-GCP-WEKA](https://github.com/weka/terraform-gcp-weka) module under the **Requirements** section.
* Initialize the Terraform module using `terraform init` from the local directory. This command initializes a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, and more.
*   The **Compute Engine** and **Workflows API** services must be enabled to allow the following services:

    ```
    artifactregistry.googleapis.com
    cloudbuild.googleapis.com
    cloudfunctions.googleapis.com
    cloudresourcemanager.googleapis.com
    cloudscheduler.googleapis.com
    compute.googleapis.com
    dns.googleapis.com
    eventarc.googleapis.com
    iam.googleapis.com
    secretmanager.googleapis.com
    servicenetworking.googleapis.com
    serviceusage.googleapis.com
    vpcaccess.googleapis.com
    workflows.googleapis.com
    ```
*   The user running the Terraform module requires the following roles to run the `terraform apply`:

    ```
    roles/cloudfunctions.admin
    roles/cloudscheduler.admin
    roles/compute.admin
    roles/compute.networkAdmin
    roles/compute.serviceAgent
    roles/dns.admin
    roles/iam.serviceAccountAdmin
    roles/iam.serviceAccountUser
    roles/pubsub.editor
    roles/resourcemanager.projectIamAdmin 
    roles/secretmanager.admin
    roles/servicenetworking.networksAdmin
    roles/storage.admin 
    roles/vpcaccess.admin
    roles/workflows.admin
    ```

## **Create a main.tf file**

1. Review the [Terraform-GCP-WEKA example](gcp-terraform-package-description.md#terraform-gcp-weka-example) and use it as a reference for creating the `main.tf` according to your deployment specifics on GCP.
2. Tailor the `main.tf` file to create SMB-W or NFS protocol clusters by adding the relevant code snippet. Adjust parameters like the number of gateways, instance types, domain name, and share naming:

* **SMB-W**

<pre><code><strong>smb_protocol_gateways_number = 3
</strong>smb_protocol_gateway_instance_type = "c2-standard-8" 
smbw_enabled = true
smb_domain_name = "CUSTOMER_DOMAIN"
smb_share_name = "SPECIFY_SMB_SHARE_NAMING"
smb_setup_protocol = true
</code></pre>

* **NFS**

```
nfs_protocol_gateways_number = 2
nfs_protocol_gateway_instance_type = "c2-standard-8"
nfs_setup_protocol = true
```

4. Add WEKA POSIX clients (optional)**:** If needed, add [WEKA POSIX clients](../../weka-system-overview/weka-client-and-mount-modes.md) to support your workload by incorporating the specified variables into the `main.tf` file:

```makefile
clients_number = 2
client_instance_type = "c2-standard-8"
```

## Apply the main.tf file

Once you complete the `main.tf` settings, apply it: Run `terraform apply`.

### **Additional configuration post-Terraform** apply

After applying  the `main.tf`, the Terraform module updates the configuration as follows:

1. **Service account creation:**\
   Format of the service account name: `<prefix>-deployment@<project name>.iam.gserviceaccount.com`\
   Assigned roles:

```
roles/cloudfunctions.developer
roles/compute.serviceAgent
roles/compute.loadBalancerServiceUser
roles/pubsub.subscriber
roles/secretmanager.secretAccessor
roles/vpcaccess.serviceAgent
roles/workflows.invoker
```

2. **Additional roles can be assigned to the created service account (if working with relevant resources):**

*   To create a worker pool:

    ```
    roles/compute.networkAdmin
    roles/servicenetworking.networksAdmin
    roles/cloudbuild.workerPoolOwner
    ```
*   To create a new bucket (for Terraform state and WEKA OBS):

    ```jsx
    roles/storage.admin
    ```
*   To use an existing bucket (for Terraform state and WEKA OBS):

    ```jsx
    roles/storage.objectAdmin
    ```

## **Upgrade the WEKA version**

Upgrading the WEKA version on the cloud is similar to the standard WEKA upgrade process. However, in a cloud configured with auto-scaling, the new instances created by the scale-up must be configured with the new WEKA version.

**Before you begin**

Ensure the cluster does not undergo a scale-up or scale-down process before and during the WEKA version upgrade.

**Procedure**

1. Perform the upgrade process. See [upgrading-weka-versions.md](../../operation-guide/upgrading-weka-versions.md "mention").
2. Update the `weka_version` parameter in the `main.tf` file.
3. Run `terraform apply`.

## Removal or rollback of the WEKA cluster

If a rollback is required or the WEKA cluster is no longer required on GCP, first terminate the WEKA cluster and then use the `terraform destroy` action.

The termination of the WEKA cluster can also be used if you need to retain the GCP resources (such as VPCs and cloud functions to save time on the next deployment) and then deploy a new WEKA cluster when you are ready. &#x20;

{% hint style="info" %}
If you need to preserve your data, first create a snapshot using [snap-to-object](../../weka-filesystems-and-object-stores/snap-to-obj/).
{% endhint %}

To terminate the WEKA cluster, run the following command (replace the `trigger_url` with the actual trigger URL and `Cluster_Name` with the actual cluster name):

{% code overflow="wrap" %}
```bash
curl -m 70 -X POST ${google_cloudfunctions_function.terminate_cluster_function.https_trigger_url} \
-H "Authorization:bearer $(gcloud auth print-identity-token)" \
-H "Content-Type:application/json" \
-d '{"name":"Cluster_Name"}'
```
{% endcode %}

If you do not know the trigger URL or cluster name, run the `terraform output`command to display them.

Once the WEKA cluster is terminated, you can deploy a new WEKA cluster or run the `terraform destroy` action.
