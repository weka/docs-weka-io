# Deployment on GCP using Terraform

WEKA provides a GCP-Terraform package that contains Terraform modules and variables file examples that you can customize according to your deployment needs. The installation is based on applying the customized Terraform variables file to a predefined GCP project.&#x20;

Applying the GCP-Terraform variables file performs the following:

* Creates VPC networks and subnets on the GCP project.
* Deploys GCP instances.
* Installs the WEKA software.
* Configures the WEKA cluster**.**
* Additional GCP objects.

## Prerequisites

Before installing the WEKA software on GCP, the following prerequisites must be met:

* [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install) (it is pre-installed if you use the Cloud Shell).
* [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (it is pre-installed if you use the Cloud Shell).
* Obtain the latest release of the WEKA GCP-Terraform package from [https://github.com/weka/terraform-gcp-weka/releases](https://github.com/weka/terraform-gcp-weka/releases) and unpack it in your workstation.&#x20;
* Initialize the GCP-Terraform package using `terraform init` from the local directory. This command initializes a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, and more.
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
* If the customer does not provide the service account email, the user running the Terraform package requires the `iam.serviceAccountAdmin` role.&#x20;
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


    *   To create a new bucket (state and obs):

        ```jsx
        "roles/storage.admin"
        ```


    *   To use an existing bucket (state and obs):

        ```jsx
        "roles/storage.objectAdmin"
        ```

## **Installation**

1. In the WEKA GCP-Terraform unpacked package, go to the **examples** directory and locate the required deployment type example.
2. Select the Terraform variables file (`terraform.tfvars`) and customize it (see the related topic below).

<figure><img src="../../.gitbook/assets/gcp_tfvars_example (1).png" alt=""><figcaption><p>Location of the terraform.tfvars file in one of the provided examples</p></figcaption></figure>

3. To validate the configuration, run `terraform plan`.
4. Once the configuration validation is successful, run `terraform apply`.&#x20;

Terraform applies the configuration on the specified GCP project.



**Related topic**

[gcp-terraform-package-description.md](gcp-terraform-package-description.md "mention")

## **Upgrade the WEKA version**

Upgrading the WEKA version on the cloud is similar to the standard WEKA upgrade process. However, in a cloud configured with auto-scaling, the new instances created by the scale-up must be configured with the new WEKA version.

**Before you begin**

Ensure the cluster does not undergo a scale-up or scale-down process before and during the WEKA version upgrade.

**Procedure**

1. Perform the upgrade process. See [upgrading-weka-versions.md](../../usage/upgrading-weka-versions.md "mention").
2. Update the `weka_version` variable in the Terraform deployment file (`terraform.tfvars`).
3. Run `terraform apply`.

## Rollback

If a rollback is required or the Weka cluster is no longer required on GCP, you must prepare the Weka cluster for termination first and only then use the `terraform destroy` action.

The preparation for the Weka cluster for termination can also be used if you need to retain the GCP resources (to save time) and deploy a new Weka cluster. &#x20;

{% hint style="info" %}
If you need to preserve your data, create a snapshot using [snap-to-object](../../fs/snap-to-obj/).
{% endhint %}

To prepare the Weka cluster for termination, run the following command line (replace `Cluster_Name` with the actual cluster name):

```
curl -m 70 -X POST ${google_cloudfunctions_function.terminate_cluster_function.https_trigger_url} \
-H "Authorization:bearer $(gcloud auth print-identity-token)" \
-H "Content-Type:application/json" \
-d '{"name":"Cluster_Name"}'
```

Once the Weka cluster is prepared for termination, you can deploy a new Weka cluster or run the `terraform destroy` action.
