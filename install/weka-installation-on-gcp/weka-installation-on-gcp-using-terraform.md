# Weka installation on GCP using Terraform

Weka provides a GCP-Terraform package that contains Terraform modules and variable file examples that you can customize according to your deployment needs. The installation is based on applying the customized Terraform variable files to a predefined GCP project.&#x20;

Applying the GCP-Terraform files performs the following:

* Creates VPC networks and subnets on the GCP project.
* Deploys GCP instances.
* Installs the Weka software.
* Configures the Weka cluster**.**
* Additional GCP objects.

### Prerequisites

Before installing the Weka software on GCP, the following prerequisites must be met:

* [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install).&#x20;
* [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (if you are not using the Terraform already installed on the GCP Console).
* Obtain the Weka GCP-Terraform package and save it to a local directory. Users who already have access can clone the package from [https://github.com/weka/gcp-tf](https://github.com/weka/gcp-tf). Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to obtain the GCP-Terraform package.&#x20;
* Initialize the GCP-Terraform package using `terraform init` from the local directory. This command initializes a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, and more.

### **Install**

1. According to the required deployment, go to the relevant directory in the examples directory.  Customize the Terraform variable file (`tf.tfvars`).
2. To validate the configuration, run\
   `terraform plan -var-file=tf.tfvars.`
3. Once the configuration validation is successful, run\
   `terraform apply -var-file=tf.tfvars`.&#x20;

Terraform applies the configuration on the specified GCP project.

**Related topics**

[weka-gcp-terraform-package-description.md](weka-gcp-terraform-package-description.md "mention")

For WEKA management topics, such as Manage filesystems and Manage object stores, see the topics in the WEKAFS FILESYSTEMS & OBJECT STORES section.
