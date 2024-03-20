# Troubleshooting



During the deployment process, errors may occur. You can use the Azure Console tools to verify the resource status and the Azure quota limitations.

For additional Terraform logs during the WEKA cluster deployment, you can run the Terraform with the option `TF_LOG variable=ERROR`.

The following is a partial list of errors and the corrective actions that may occur during the deployment:

### Error when creating virtual machines

When deploying the WEKA cluster, an error indicates that more virtual machines have been requested than the quota limit in your Azure subscription.

**Resolution:**

Submit a quota increase to Microsoft Azure using the URL specified in the error message.

For more details, see [Increase VM-family vCPU quotas](https://learn.microsoft.com/en-us/azure/quotas/per-vm-quota-requests) on the Microsoft site.

### The storage account name is already taken

Creating a storage account name must be unique across the Azure environment.

**Resolution:**

In the Terraform variables file, ensure the `prefix` and `cluster_name` variables are unique.&#x20;



The specified resource group in the Terraform variables file was not found because it was not created (as part of the prerequisites).

**Resolution:**

Create the Azure resource group before applying the Terraform file using the Azure console or Azure CLI.

In Azure CLI, use the following command:

`az group create --name <myResourceGroup> --location <region>`

Example:

`az group create --name weka-jack-rg --location eastus`



**Related topics**

[#prerequisites](deployment-on-azure-using-terraform.md#prerequisites "mention")
