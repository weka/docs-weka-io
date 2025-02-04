# Add WEKA to an existing SageMaker HyperPod cluster

## Deployment workflow for existing SageMaker Hyperpod cluster

1. [Deploy WEKA Cluster using Terraform](add-weka-to-an-existing-sagemaker-hyperpod-cluster.md#deploy-weka-cluster-using-terraform).&#x20;
2. [Deploy WEKA clients in SageMaker Hyperpod](add-weka-to-an-existing-sagemaker-hyperpod-cluster.md#deploy-weka-clients-in-sagemaker-hyperpod)

{% include "../../.gitbook/includes/hyperpod-slurm-deploy-weka.md" %}

## Deploy WEKA clients in SageMaker Hyperpod

#### Step 1: Download integration scripts from GitHub

1. Clone the GitHub repository:&#x20;

```
git clone https://github.com/weka/cloud-solutions.git
```

2. Enter the sagemaker-hyperpod directory:

```
cd cloud-solutions/aws/sagemaker-hyperpod/
```

#### Step 2: Verify region configuration

1. Verify AWS CLI region configuration:

```
aws configure list
```

Verify the region listed is the desired region for the SageMaker Hyperpod cluster. If it is not correct set the AWS\_REGION environment variable to the correct region.

```
export AWS_REGION=<desired region>
```

#### Step 3: Verifying VPC configuration

1. Ensure the optional parameter **"Availability zone ID to deploy the backup private subnet"** is configured with a valid entry.  If the CloudFormation template has already been deployed, update the existing stack using the existing template.
2. Edit the **sagemaker-hyperpod-SecurityGroup** rule created by the CloudFormation template. Add the following inbound rules to allow access from your management workstation's CIDR range:

* **TCP port 22** (SSH)
* **TCP port 14000** (WEKA UI)

This ensures that your management workstation can connect securely to the cluster.

#### Step 3: Configure environment variables

1. Run `set_env_vars.sh`:

```
./set_env_vars.sh <stack_name> && source env_vars
```

* `Cloud_Formation_Stack`: Name of the existing CloudFormation stack.

#### Step 4: Deploy WEKA clients to existing cluster

1. Run `deploy_weka_into_existing_cluster.sh` replacing `<weka_backend_ip>` with either a WEKA backend IP or Application Load Balancer DNS name and `<FS Name>` with the name of the WEKA filesystem you wish to mount.

```
./deploy_weka_into_existing_cluster.sh <ALB_NAME> <FS name>
```

* `ALB_NAME`: Obtain this from the AWS Console or Terraform output. It is a DNS name.&#x20;
* `WEKA_FS_NAME`: Obtain this from the WEKA UI. The default filesystem name is default.

#### Step 5: Verify WEKA clients are mounted&#x20;

1. Login to one of the cluster nodes using SSH or SSM.
2. Verify mount using `df:`

```
df -h
```

The WEKA filesystem is mounted at `/mnt/weka` on all SageMaker HyperPod nodes.
