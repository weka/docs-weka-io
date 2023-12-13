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

* Obtain the latest release of the terraform-gcp-weka module from [https://github.com/weka/terraform-gcp-weka/releases](https://github.com/weka/terraform-gcp-weka/releases) and unpack it in your workstation.&#x20;
* [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install): It is pre-installed if you use the Cloud Shell.
* [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli): It is pre-installed if you use the Cloud Shell. Check the minimum required Terraform version specified in the [terraform-gcp-weka](ttps://github.com/weka/terraform-gcp-weka) repository.
* Initialize the Terraform module using `terraform init` from the local directory. This command initializes a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, and more.
*   The **Compute Engine** and **Workflows API** services must be enabled to allow the following services:

    ```
    cloudfunctions.googleapis.com
    cloudbuild.googleapis.com
    artifactregistry.googleapis.com
    serviceusage.googleapis.com
    cloudscheduler.googleapis.com
    compute.googleapis.com
    secretmanager.googleapis.com
    servicenetworking.googleapis.com
    vpcaccess.googleapis.com
    cloudresourcemanager.googleapis.com
    vpcaccess.googleapis.com
    iam.googleapis.com
    dns.googleapis.com
    workflows.googleapis.com
    eventarc.googleapis.com
    ```
* If the customer does not provide the service account email, the user running the Terraform module requires the `iam.serviceAccountAdmin` role.&#x20;
*   The service account used for the deployment must have the following roles:

    ```
    "roles/secretmanager.secretAccessor",
    "roles/compute.serviceAgent",
    "roles/cloudfunctions.developer",
    "roles/workflows.invoker",
    "roles/vpcaccess.serviceAgent",
    "roles/pubsub.subscriber"
    ```



    The Terraform adds the following roles to the services accounts per to the following resources:

    *   Worker pool roles:

        ```
        "roles/compute.networkAdmin"
        "roles/servicenetworking.networksAdmin"
        "roles/cloudbuild.workerPoolOwner"
        ```


    *   To create a new bucket (for Terraform state and WEKA OBS):

        ```jsx
        "roles/storage.admin"
        ```


    *   To use an existing bucket (for Terraform state and WEKA OBS):

        ```jsx
        "roles/storage.objectAdmin"
        ```

## **Create a main.tf file**

1. Review the [Terraform-GCP-WEKA example](gcp-terraform-package-description.md#terraform-gcp-weka-example) and use it as a reference for creating the `main.tf` according to your deployment specifics on GCP.
2. Decide whether to use an existing GCP network or create a new one, including a Virtual Private Cloud (VPC) and subnet. Your choice dictates the subsequent network configuration steps:
   * **IAM role setup:** Create IAM roles for essential GCP services. The Terraform module generates these roles if not explicitly provided.
   * **Security group:** Optionally, provide the security group ID or let the Terraform module create one for you.
   * **Endpoint configuration:**
     * Configure a secret manager endpoint to safeguard the WEKA password. If not configured, the Terraform module allows you to set it up.
     * In environments without Internet connections, configure the machine, proxy, and S3 gateway endpoints. The Terraform module facilitates this configuration if needed.
3. Tailor the `main.tf` file to create SMB-W or NFS protocol clusters by adding the relevant code snippet. Adjust parameters like the number of gateways, instance types, domain name, and share naming:

* **SMB-W**

<pre><code><strong>smb_protocol_gateways_number = 3
</strong>smb_protocol_gateway_instance_type = c2-standard-8 
smbw_enabled = true
smb_domain_name = "CUSTOMER_DOMAIN"
smb_share_name = "SPECIFY_SMB_SHARE_NAMING"
smb_setup_protocol = true
</code></pre>

* **NFS**

```
nfs_protocol_gateways_number = 1
nfs_protocol_gateway_instance_type = c2-standard-8
nfs_setup_protocol = true
```

4. Add WEKA POSIX clients (optional)**:** If needed, add [WEKA POSIX clients](../../overview/weka-client-and-mount-modes.md) to support your workload by incorporating the specified variables into the `main.tf` file:

```makefile
clients_number = 2
client_instance_type = c2-standard-8
```

## Apply the main.tf file

Once you complete the main.tf settings, apply it: Run `terraform apply`

## **Upgrade the WEKA version**

Upgrading the WEKA version on the cloud is similar to the standard WEKA upgrade process. However, in a cloud configured with auto-scaling, the new instances created by the scale-up must be configured with the new WEKA version.

**Before you begin**

Ensure the cluster does not undergo a scale-up or scale-down process before and during the WEKA version upgrade.

**Procedure**

1. Perform the upgrade process. See [upgrading-weka-versions.md](../../usage/upgrading-weka-versions.md "mention").
2. Update the `weka_version` parameter in the `main.tf` file.
3. Run `terraform apply`.

## Removal or rollback of the WEKA cluster

If a rollback is required or the WEKA cluster is no longer required on GCP, first terminate the WEKA cluster and then use the `terraform destroy` action.

The termination of the WEKA cluster can also be used if you need to retain the GCP resources (such as VPCs and cloud functions to save time on the next deployment) and then deploy a new WEKA cluster when you are ready. &#x20;

{% hint style="info" %}
If you need to preserve your data, first create a snapshot using [snap-to-object](../../fs/snap-to-obj/).
{% endhint %}

To terminate the WEKA cluster, run the following command (replace the `trigger_url` with the actual trigger URL and `Cluster_Name` with the actual cluster name):

```bash
curl -m 70 -X POST ${google_cloudfunctions_function.terminate_cluster_function.https_trigger_url} \
-H "Authorization:bearer $(gcloud auth print-identity-token)" \
-H "Content-Type:application/json" \
-d '{"name":"Cluster_Name"}'
```

If you do not know the trigger URL or cluster name, run the `terraform output`command to display them.

Once the WEKA cluster is terminated, you can deploy a new WEKA cluster or run the `terraform destroy` action.
