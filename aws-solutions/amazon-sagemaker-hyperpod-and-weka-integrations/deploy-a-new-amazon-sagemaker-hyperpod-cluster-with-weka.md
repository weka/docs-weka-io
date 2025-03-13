# Deploy a new Amazon SageMaker HyperPod cluster with WEKA

## Deployment workflow for new Amazon SageMaker Hyperpod cluster

1. [Prepare the environment for deployment](deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka.md#prepare-the-environment-for-deployment).
2. [Deploy WEKA cluster using Terraform](deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka.md#deploy-weka-cluster-using-terraform).&#x20;
3. [Create Amazon SageMaker HyperPod cluster](deploy-a-new-amazon-sagemaker-hyperpod-cluster-with-weka.md#create-amazon-sagemaker-hyperpod-cluster).&#x20;

### Prepare the environment for deployment

1. Deploy AWS CloudFormation template (or an equivalent) to create the prerequisites for the Amazon SageMaker HyperPod cluster.
   1. TheAWS CloudFormation template can be found at: [Amazon SageMaker HyperPod > 0. Prerequisites > 2. Own Account](https://catalog.workshops.aws/sagemaker-hyperpod/en-US/00-setup/02-own-account#in-your-own-account).
   2. Ensure the optional parameter **"Availability zone ID to deploy the backup private subnet"** is configured with a valid entry. If the AWS CloudFormation template has already been deployed, update the existing stack using the existing template.
2. Retrieve the token[^1] required for the WEKA package installation by accessing the WEKA download command at: [https://get.weka.io/](https://get.weka.io/).
3.  Edit the **sagemaker-hyperpod-SecurityGroup** rule created by the AWS CloudFormation template. Add the following inbound rules to allow access from your management workstation's CIDR range:

    * **TCP port 22** (SSH)
    * **TCP port 14000** (WEKA UI)

    This ensures that your management workstation can connect securely to the cluster.

### Deploy WEKA cluster using Terraform

{% include "../../.gitbook/includes/hyperpod-slurm-deploy-weka.md" %}

### Create Amazon SageMaker HyperPod cluster

1.  **Clone the WEKA cloud solutions repository**\
    Download the repository from GitHub:

    ```bash
    git clone https://github.com/weka/cloud-solutions/
    ```
2.  **Navigate to the SageMaker HyperPod directory**\
    Change to the relevant directory:

    ```bash
    cd cloud-solutions/aws/sagemaker-hyperpod
    ```
3. **Verify AWS cli region configuration**

```
aws configure list
```

Verify the region listed is the desired region for the SageMaker Hyperpod cluster. If it is not correct, set the AWS\_REGION environment variable to the correct region.

```
export AWS_REGION=<desired region>
```

4. **Set Cluster Configuration**\
   Run the script to set environment variables that defines the SageMaker Hyperpod cluster. &#x20;

```
./set_env_vars.sh <Cloud_Formation_Stack>
```

* `Cloud_Formation_Stack`: Name of the existing CloudFormation stack.

4. **Source environment variables**

```
source env_vars
```

5. **Create the cluster**\
   Run the deploy script:

```bash
./deploy.sh <ALB_NAME> <WEKA_FS_NAME>
```

* `ALB_NAME`: Obtain this from the AWS Console or Terraform output. It is a DNS name.&#x20;
* `WEKA_FS_NAME`: Obtain this from the WEKA UI. The default filesystem name is default.

6. **Monitor cluster creation**\
   Track the cluster creation process:

```bash
aws sagemaker list-clusters --output table
```

7. **Continue setup**\
   Proceed with the setup by following Section 1, Step E of the [Amazon SageMaker HyperPod workshop.](https://catalog.workshops.aws/sagemaker-hyperpod/en-US/01-cluster/04-consolehttps://catalog.workshops.aws/sagemaker-hyperpod/en-US/01-cluster/04-console)\
   The WEKA filesystem is mounted at `/mnt/weka` on all SageMaker HyperPod nodes.

[^1]: **Token structure**\
    `<access key>@get.weka.io`
