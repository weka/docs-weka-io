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
* The **Compute Engine** and **Workflows API** services must be enabled.
* The service account used for the deployment must have the following roles:
  * secretmanager.admin
  * secretmanager.secretAccessor
  * compute.serviceAgent
  * compute.admin
  * compute.networkAdmin
  * networkmanagement.admin
  * cloudfunctions.admin
  * cloudfunctions.serviceAgent
  * workflows.admin
  * storage.admin
  * iam.serviceAccountAdmin
  * iam.securityAdmin
  * vpcaccess.admin
  * vpcaccess.serviceAgent
  * cloudscheduler.admin
  * cloudscheduler.serviceAgent
  * dns.admin
  * pubsub.editor

{% hint style="info" %}
To create a service account using the Terraform package, the iam.serviceAccountAdmin role is required.
{% endhint %}

## **Installation**

1. According to the required deployment, go to the relevant directory in the examples directory.  Customize the Terraform variables file (`terraform.tfvars`).
2. To validate the configuration, run `terraform plan`.
3. Once the configuration validation is successful, run `terraform apply`.&#x20;

Terraform applies the configuration on the specified GCP project.



**Related topics**

[gcp-terraform-package-description.md](gcp-terraform-package-description.md "mention")



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
