# Deployment on Azure using Terraform

The Azure-Weka Terraform package contains modules and examples you can customize according to your deployment needs. The installation is based on applying the customized Terraform variables file to a predefined Azure subscription.&#x20;

Applying the Terraform variables file performs the following:

* Creates resources in a predefined resource group, such as virtual machines, network interfaces, function apps, load balancer, and more.
* Deploys Azure virtual machines.
* Installs the Weka software.
* Configures the Weka cluster**.**

The total deployment time is about 30 minutes. Half of the time is for resource deployment, and the second half is for the Weka cluster installation and configuration.

## Prerequisites

Before installing the Weka software on Azure, the following prerequisites must be met:

* The following must be installed on the workstation (Linux or Intel-based Mac only) used for the deployment (see specific steps for M1-based Mac below):
  * [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
  * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
  * [Go](https://go.dev/doc/install)
* Obtain the Weka-Azure Terraform package from [https://github.com/weka/terraform-azr-weka](https://github.com/weka/terraform-azr-weka)[ ](https://github.com/weka/terraform-azr-weka)and save it to a local directory. To access the package, a git account is required, and it must be associated with the Weka git organization.&#x20;
* Initialize the Weka-Azure Terraform package using `terraform init` from the local directory. This command initializes a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, and more.
* Required permissions on Azure:
  * Privileged Role Administrator
  * Storage Blob Data Owner
  * Storage Account Contributor
  * Key Vault Administrator
* To login to the Azure account using Azure CLI, use the **az login** command.
* An Azure resource group is created within your subscription. The resource group also includes the Azure region.

<details>

<summary>M1-based Mac workstation additional requirements</summary>

Follow these additional requirements to get Terraform working on an M1-based Mac:

1. Ensure `golang 1.19` or higher is installed.
2. Run `brew install tfenv`
3. Run `TFENV_ARCH=amd64 tfenv install 1.3.7`
4. Run `tfenv use 1.3.7`
5. Run `brew install kreuzwerker/taps/m1-terraform-provider-helper`

</details>

## Deploy Weka on Azure using Terraform

1. You can use one of the provided examples as a template for the required deployment. \
   Go to the relevant directory in the examples directory and customize the Terraform variables file: `vars.auto.tfvars`.\
   Ensure the `prefix` and `cluster_name` variables are unique across the Azure environment.

{% hint style="info" %}
**Note:** The example templates are simplified and have the minimum variable inputs to customize. For additional variable inputs to customize, you can modify their default values in the main **`variables.tf`** file, or add them to the Terraform variables file. See the README in the Weka-Azure Terraform package for the full list of variable inputs.
{% endhint %}

2. To validate the configuration, run `terraform plan`.
3. Once the configuration validation is successful, run `terraform apply`.\
   Terraform applies the configuration on the specified Azure subscription.

**Related topic**

[azure-weka-terraform-package-description.md](azure-weka-terraform-package-description.md "mention")

[troubleshooting.md](troubleshooting.md "mention")

## Check the deployment progress

Once Terraform applies the configuration and deploys all the required resources, the following URL is provided, enabling you to check the progress of the cluster deployment:

`curl https://<prefix>-<cluster name>-function-app.azurewebsites.net/api/status?code=$function_key`

In the following example, the prefix is `v41`, and the cluster name is `jack`.

The deployment progress has the following major phases:

<details>

<summary>Preparation</summary>

Once the VM starts up, it prepares all the required objects, such as installing the OFED driver, setting the partition to `/opt/weka`, downloading the Weka release, and deploying the container drives.

This phase takes about 15 to 20 minutes.

In this phase, the number of virtual machines (instances) is empty, as shown in the following response:

```

$ curl https://v41-jack-function-app.azurewebsites.net/api/status?code=$function_key
{
  "initial_size": 6,
  "desired_size": 6,
  "instances": [],
  "clusterized": false
}

```

</details>

<details>

<summary>C<strong>luster formation status update</strong></summary>

Once the preparation phase completes, the list of virtual machines appears, and the cluster formation status is still false, as shown in the following response:

```

$ curl https://v41-jack-function-app.azurewebsites.net/api/status?code=$function_key
{
  "initial_size": 6,
  "desired_size": 6,
  "instances": [
    "v41-jack-backend-4",
    "v41-jack-backend-3",
    "v41-jack-backend-5",
    "v41-jack-backend-1",
    "v41-jack-backend-2",
    "v41-jack-backend-0"
  ],
  "clusterized": false
  
```

</details>

<details>

<summary><strong>Cluster formation</strong></summary>

In this phase, the last backend (backend-0) runs the cluster formation. Once it is completed, the cluster status (`clusterized`) is set to `true`, as shown in the following response:

```

$ curl https://v41-jack-function-app.azurewebsites.net/api/status?code=$function_key
{
  "initial_size": 6,
  "desired_size": 6,
  "instances": [
    "v41-jack-backend-4",
    "v41-jack-backend-3",
    "v41-jack-backend-5",
    "v41-jack-backend-1",
    "v41-jack-backend-2",
    "v41-jack-backend-0"
  ],
  "clusterized": true
}

```

</details>

{% hint style="success" %}
**Note:** You can also track the cluster formation progress on the last backend (in this example, `backend-0`) by opening the `/tmp/cluster_creation.log` file.
{% endhint %}

## **Validate the deployment**

Once the deployment is completed, access the Weka cluster GUI using the URL: `http://<backend server DNS name or IP address>:14000` and get started with the Weka cluster.

**Related topics**

[manage-the-system-using-weka-gui.md](../../getting-started-with-weka/manage-the-system-using-weka-gui.md "mention")

[manage-the-system-using-weka-cli.md](../../getting-started-with-weka/manage-the-system-using-weka-cli.md "mention")

[performing-the-first-io.md](../../getting-started-with-weka/performing-the-first-io.md "mention")

## **Clean up the** deployment

If the Weka cluster is no longer required on Azure or you need to clean up the deployment, use the `terraform destroy` action (a token from [get.weka.io](https://get.weka.io/) is required). The object storage and storage account are not deleted.

{% hint style="warning" %}
If the Terraform deployment fails for any reason, such as dependencies not being present and Azure resource starvation, the `destroy` command does not work properly. Manually remove any resources created at the beginning of the Terraform script using the Azure console or Azure CLI before re-running the Terraform script.&#x20;
{% endhint %}

{% hint style="info" %}
If you need to preserve your data, create a snapshot using [snap-to-object](../../fs/snap-to-obj/).
{% endhint %}
