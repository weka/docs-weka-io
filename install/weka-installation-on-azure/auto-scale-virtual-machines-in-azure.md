# Auto-scale virtual machines in Azure

WEKA provides a resize API to scale up or down the cluster. You must use only this API to resize the cluster. Do not use any other option for resizing.

{% hint style="info" %}
The cluster name prefix, resource group name, and Azure subscription id appear in the `Resize cluster` section of the [Cluster help commands](deployment-on-azure-using-terraform.md#cluster-help-commands) output.
{% endhint %}

**Procedure:**

1. Get the resize API (function-app).\
   Run the command:

```
function_key=$(az functionapp keys list --name <cluster name prefix>-function-app --resource-group <resource group name> --subscription <Azure subscription id> --query functionKeys -o tsv)

```

2. Resize the cluster.\
   Enter the value of the required number of virtual machines instead of `ENTER_NEW_VALUE_HERE` (the minimum value is `6`), and run the command:

```
curl --fail https://<cluster name prefix>-function-app.azurewebsites.net/api/resize?code=$function_key -H "Content-Type:application/json" -d '{"value":ENTER_NEW_VALUE_HERE}'

```

3. Track the resize progress using the commands provided in the [Check the deployment progress](deployment-on-azure-using-terraform.md#check-the-deployment-progress) section.
