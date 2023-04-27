# Deployment on Azure using Terraform

The Azure-WEKA Terraform package contains modules and examples to customize according to your deployment needs. The installation is based on applying the customized Terraform variables file to a predefined Azure subscription.&#x20;

Applying the Terraform variables file performs the following:

* Creates resources in a predefined resource group, such as virtual machines, network interfaces, function apps, load balancer, and more.
* Deploys Azure virtual machines.
* Installs the WEKA software.
* Configures the WEKA cluster**.**

The total deployment time is about 30 minutes. Half the time is for resource deployment. The second is for the WEKA cluster installation and configuration.

## Prerequisites

Before installing the WEKA software on Azure, the following prerequisites must be met:

* The following must be installed on the workstation used for the deployment:
  * [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
  * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* For an M1-based Mac workstation, see specific instructions below.
* Obtain the Azure-WEKA Terraform package from [https://github.com/weka/terraform-azr-weka](https://github.com/weka/terraform-azr-weka)[ ](https://github.com/weka/terraform-azr-weka)and save it to a local directory. To access the package, a git account is required, and it must be associated with the WEKA git organization.&#x20;
* Initialize the Azure-WEKA Terraform package using `terraform init` from the local directory. This command initializes a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, and more.
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

1. Run `brew install tfenv`
2. Run `TFENV_ARCH=amd64 tfenv install 1.3.7`
3. Run `tfenv use 1.3.7`
4. Run `brew install kreuzwerker/taps/m1-terraform-provider-helper`

</details>

## Deploy WEKA on Azure using Terraform

1. You can use one of the provided examples as a template for the required deployment. \
   Go to the relevant directory in the examples directory and customize the Terraform variables file: `vars.auto.tfvars`.\
   Ensure the `prefix` and `cluster_name` variables are unique across the Azure environment.

{% hint style="info" %}
**Note:** The example templates are simplified and have the minimum variable inputs to customize. For additional variable inputs to customize, you can modify their default values in the main **`variables.tf`** file, or add them to the Terraform variables file. See the README in the Azure-WEKA Terraform package for the full list of variable inputs.
{% endhint %}

2. To validate the configuration, run `terraform plan`.
3. Once the configuration validation is successful, run `terraform apply`.\
   Terraform applies the configuration on the specified Azure subscription and displays the cluster help commands.

### Cluster help commands

The system displays the cluster help commands enabling you to perform the following:

* Get the clusterization status
* Get the cluster status
* Fetch the WEKA cluster password
* View the path to ssh keys
* View the virtual machine IP addresses
* Resize the cluster

<details>

<summary>Cluster help commands output example</summary>

In the following example, the prefix is `v41`, and the cluster name is `jack`.&#x20;

```
get-cluster-helpers-commands = <<EOT
########################################## Get clusterization status #####################################################################
function_key=$(az functionapp keys list --name v41-jack-function-app --resource-group jackm-rg --subscription d2f248b9-d054-477f-b7e8-413921532c2a --query functionKeys -o tsv)
curl --fail  -H "Content-Type:application/json" -d '{"type": "progress"}'

########################################## Get cluster status ############################################################################
function_key=$(az functionapp keys list --name v41-jack-function-app --resource-group jackm-rg --subscription d2f248b9-d054-477f-b7e8-413921532c2a --query functionKeys -o tsv)
curl --fail 

######################################### Fetch weka cluster password ####################################################################
az keyvault secret show --vault-name v41-jack-key-vault --name weka-password | jq .value

########################################## Download ssh keys command from blob ###########################################################
 az keyvault secret download --file private.pem --encoding utf-8 --vault-name  v41-jack-key-vault --name private-key --query "value"
 az keyvault secret download --file public.pub --encoding utf-8 --vault-name  v41-jack-key-vault --name public-key --query "value"

############################################## Path to ssh keys  ##########################################################################
/tmp/v41-jack-public-key.pub
 /tmp/v41-jack-private-key.pem

################################################ Vms ips ##################################################################################
az vmss list-instance-public-ips -g jackm-rg --name v41-jack-vmss --subscription <azure subscription id> --query "[].ipAddress"


########################################## Resize cluster #################################################################################
function_key=$(az functionapp keys list --name v41-jack-function-app --resource-group jackm-rg --subscription <azure subscription id> --query functionKeys -o tsv)
curl --fail  -H "Content-Type:application/json" -d '{"value":ENTER_NEW_VALUE_HERE}'

EOT
```

</details>

**Related topic**

[azure-weka-terraform-package-description.md](azure-weka-terraform-package-description.md "mention")

[troubleshooting.md](troubleshooting.md "mention")

## Check the deployment progress

Once Terraform applies the configuration and deploys all the required resources, you can use the cluster help commands to check the progress of the cluster deployment.

The following is the command syntax for checking the cluster status during the deployment progress:

`curl --fail https://<prefix>-<cluster name>-function-app.azurewebsites.net/api/status?code=$function_key`

### Example

Explore the following phases to check the deployment progress:

<details>

<summary>Preparation</summary>

Once the VM starts, it prepares all the required objects, such as setting the partition to `/opt/weka`, downloading the Weka release, and deploying the container drives.

You can track the progress of the preparation, which can take about 10 minutes.

1. Get your function key by running the command:

```
function_key=$(az functionapp keys list --name v41-jack-function-app --resource-group jackm-rg --subscription <your Azure subscription id> --query functionKeys -o tsv)

```

2. Track the preparation progress by running the command:

```
curl --fail https://v41-jack-function-app.azurewebsites.net/api/status?code=$function_key -H "Content-Type:application/json" -d '{"type": "progress"}'

```

Response example:

```
{
  "ready_for_clusterization": [],
  "progress": {
    "v41-jack-backend000001": [
      "10:02:55 UTC: Running init script",
      "10:03:17 UTC: Installing weka"
    ],
    "v41-jack-backend000002": [
      "10:02:56 UTC: Running init script",
      "10:03:18 UTC: Installing weka"
    ],
    "v41-jack-backend000003": [
      "10:02:54 UTC: Running init script",
      "10:03:16 UTC: Installing weka",
      "10:08:32 UTC: Weka installation completed",
      "10:08:34 UTC: Setting deletion protection authorization error, going to sleep for 2M"
    ],
    "v41-jack-backend000004": [
      "10:02:57 UTC: Running init script",
      "10:03:27 UTC: Installing weka",
      "10:09:07 UTC: Weka installation completed",
      "10:09:09 UTC: Setting deletion protection authorization error, going to sleep for 2M"
    ],
    "v41-jack-backend000005": [
      "10:02:55 UTC: Running init script",
      "10:03:17 UTC: Installing weka"
    ],
    "v41-jack-backend000006": [
      "10:02:54 UTC: Running init script",
      "10:03:24 UTC: Installing weka"
    ]
  },
  "errors": null
}
```



</details>

<details>

<summary>C<strong>luster formation status update</strong></summary>

Once the preparation phase completes, the list of requested virtual machines appears. The number of servers ready for clusterization depends on the required cluster size.

Run the following command to track the clusterization status:

```
curl --fail https://v41-jack-function-app.azurewebsites.net/api/status?code=$function_key -H "Content-Type:application/json" -d '{"type": "progress"}'

```

The `"ready for clusterization"` section provides the list of virtual machines to be clusterized. In the following response example, the last backend `v41-jack-vmss_3` runs the cluster formation:

```
{
  "ready_for_clusterization": [
    "v41-jack-vmss_4:v41-jack-backend000004:20.228.235.225",
    "v41-jack-vmss_6:v41-jack-backend000006:20.228.234.98",
    "v41-jack-vmss_1:v41-jack-backend000001:20.228.234.225",
    "v41-jack-vmss_5:v41-jack-backend000005:20.228.236.6",
    "v41-jack-vmss_2:v41-jack-backend000002:20.228.235.126",
    "v41-jack-vmss_3:v41-jack-backend000003:20.228.235.38"
  ],
  "progress": {
    "v41-jack-backend000001": [
      "10:02:55 UTC: Running init script",
      "10:03:17 UTC: Installing weka",
      "10:09:43 UTC: Weka installation completed",
      "10:09:46 UTC: Setting deletion protection authorization error, going to sleep for 2M",
      "10:11:47 UTC: Deletion protection was set successfully"
    ],
    
    .
    .
    .
    
    "v41-jack-backend000006": [
      "10:02:54 UTC: Running init script",
      "10:03:24 UTC: Installing weka",
      "10:09:20 UTC: Weka installation completed",
      "10:09:23 UTC: Setting deletion protection authorization error, going to sleep for 2M",
      "10:11:23 UTC: Deletion protection was set successfully"
    ]
  },
  "errors": null
  
```

</details>

<details>

<summary><strong>Cluster formation</strong></summary>

Run the following command to check the cluster status:

```
$ curl https://v41-jack-function-app.azurewebsites.net/api/status?code=$function_key

```

In the following response example, the cluster formation is completed as shown in the third line `"clusterized": true`:

```
{
  "initial_size": 6,
  "desired_size": 6,
  "clusterized": true,
  "weka_status": {
    "hot_spare": 1,
    "io_status": "STARTED",
    "drives": {
      "active": 6,
      "total": 6
    },
    "name": "jack",
    "io_status_changed_time": "2023-04-16T10:15:53.35355Z",
    "io_nodes": {
      "active": 18,
      "total": 18
    },
    "cloud": {
      "enabled": true,
      "healthy": true,
      "proxy": "",
      "url": "https://api.home.weka.io"
    },
    "release_hash": "9756a1524e629d6c02c91bfb63d8239a2b4cce5f",
    "hosts": {
      "active_count": 18,
      "backends": {
        "active": 18,
        "total": 18
      },
      "clients": {
        "active": 0,
        "total": 0
      },
      "total_count": 18
    },
    "stripe_data_drives": 3,
    "release": "4.1.0.71",
    "active_alerts_count": 2,
    "capacity": {
      "total_bytes": 5182871000000,
      "hot_spare_bytes": 1036429300000,
      "unprovisioned_bytes": 0
    },
    "is_cluster": true,
    "status": "OK",
    "stripe_protection_drives": 2,
    "guid": "d4363615-bbae-416b-92f8-2d7304904996",
    "nodes": {
      "black_listed": 0,
      "total": 36
    },
    "licensing": {
      "io_start_eligibility": true,
      "usage": {
        "drive_capacity_gb": 11522,
        "usable_capacity_gb": 5182,
        "obs_capacity_gb": 0
      },
      "mode": "Unlicensed"
    }
  }

```

</details>

{% hint style="success" %}
**Note:** You can also track the cluster formation progress on the last backend (in this example, `v41-jack-vmss_3`) by opening the `/tmp/cluster_creation.log` file.
{% endhint %}

## **Validate the deployment**

Once the deployment is completed, access the WEKA cluster GUI using the URL: `http://<backend server DNS name or IP address>:14000` and get started with the WEKA cluster.

**Related topics**

[manage-the-system-using-weka-gui.md](../../getting-started-with-weka/manage-the-system-using-weka-gui.md "mention")

[manage-the-system-using-weka-cli.md](../../getting-started-with-weka/manage-the-system-using-weka-cli.md "mention")

[performing-the-first-io.md](../../getting-started-with-weka/performing-the-first-io.md "mention")

## **Clean up the** deployment

If the WEKA cluster is no longer required on Azure or you need to clean up the deployment, use the `terraform destroy` action (a token from [get.weka.io](https://get.weka.io/) is required). The object storage and storage account are not deleted.

{% hint style="warning" %}
If the Terraform deployment fails for any reason, such as dependencies not being present and Azure resource starvation, the `destroy` command does not work properly. Manually remove any resources created at the beginning of the Terraform script using the Azure console or Azure CLI before re-running the Terraform script.&#x20;
{% endhint %}

{% hint style="info" %}
If you need to preserve your data, create a snapshot using [snap-to-object](../../fs/snap-to-obj/).
{% endhint %}
