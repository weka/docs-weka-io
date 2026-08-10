---
description: >-
  Deploy the WEKA operator on a cloud-managed Kubernetes service to mount WEKA
  filesystems from application pods running in a managed cluster.
---

# Deploy WEKA on cloud-managed Kubernetes services

## Supported configurations

The following table describes the support levels for different cloud services:

<table><thead><tr><th width="120">Cloud service</th><th width="110">Instance type</th><th width="133">WekaCluster (backends)</th><th width="127">WekaClient: UDP</th><th width="137">WekaClient: DPDK</th><th width="140">NIC provisioning for DPDK</th></tr></thead><tbody><tr><td>Amazon EKS</td><td>VM</td><td>Supported</td><td>Supported</td><td>Supported</td><td>Operator creates and attaches NICs automatically</td></tr><tr><td>Oracle OKE</td><td>Bare metal</td><td>Supported</td><td>Supported</td><td>Supported</td><td>Manual</td></tr><tr><td>Oracle OKE</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Supported</td><td>Operator verifies required number of NICs</td></tr><tr><td>Google GKE</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Not Supported</td><td></td></tr><tr><td>Azure AKS</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Not Supported</td><td></td></tr></tbody></table>

## Prerequisites

Ensure the following conditions are met for all supported cloud environments:

* A WEKA cluster is deployed and reachable from the managed Kubernetes nodes if deploying only `WekaClient`.
* Network access to `https://drivers.weka.io` is available from all Kubernetes nodes.
* Quay.io credentials (`QUAY_USERNAME` and `QUAY_PASSWORD`) are obtained from WEKA Customer Success.
* Security groups and network ACLs align with the WEKA operator deployment requirements.

## Node configuration

Enable static CPU allocation and reserve core 0 on each client node. Reserve 1.5 GiB using hugepages for the client core.

For the full CPU isolation rationale, HyperThreading sibling guidance, and Kubernetes version-specific reservation options, see [WEKA Operator best practices](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/kubernetes/weka-operator-deployments/weka-operator-best-practices).

For HugePages set up, follow the HugePages procedure in [WEKA Operator deployments](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/kubernetes/weka-operator-deployments) under **Prepare Kubernetes environment**.

Use [Plan system hardware requirements](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/planning-and-installation/bare-metal/planning-a-weka-system-installation) to calculate the required HugePages allocation for your client nodes.

## Cloud-specific configuration

### Amazon EKS

Configure IAM roles and node-level resources before deploying the operator.

Cluster IAM role policies:

* AmazonEKSBlockStoragePolicy
* AmazonEKSClusterPolicy
* AmazonEKSComputePolicy
* AmazonEKSLoadBalancingPolicy
* AmazonEKSNetworkingPolicy

Node group IAM role policies:

* AmazonEC2ContainerRegistryPullOnly
* AmazonEKSWorkerNodeMinimalPolicy
* AmazonEKS\_CNI\_Policy

Use the same subnets and security groups as the WEKA cluster when configuring the Amazon EKS node group.

#### WekaCluster on EKS

When deploying a WEKA cluster on EKS, grant the following additional permissions:

* autoscaling:DescribeAutoScalingInstances
* autoscaling:DescribeAutoScalingGroups
* autoscaling:RecordLifecycleActionHeartbeat
* autoscaling:CompleteLifecycleAction
* autoscaling:PutLifecycleHook

### Oracle OKE

Bare metal instances are recommended for WekaCluster (backend) deployments and for production DPDK workloads. To provision the Oracle OKE cluster infrastructure, use the `terraform-oci-oke` Terraform module.

### Google GKE

After you create the `weka-operator-system` namespace, create a `gcloud-credentials` Kubernetes secret to grant the operator access to GCP APIs. The operator mounts this secret into the driver-builder pod at `/var/secrets/google` and sets `GOOGLE_APPLICATION_CREDENTIALS=/var/secrets/google/service-account.json`.

1.  Create a GCP service account key:

    ```bash
    gcloud iam service-accounts keys create service-account.json \
      --iam-account=<SA_NAME>@<PROJECT_ID>.iam.gserviceaccount.com
    ```
2.  Create the Kubernetes secret:

    Ensure the key inside the secret is named `service-account.json`.

    ```bash
    kubectl create secret generic gcloud-credentials \
      --from-file=service-account.json=./service-account.json \
      --namespace=weka-operator-system
    ```

Currently only UDP mode is supported

### Azure AKS

Azure AKS supports WekaClient in UDP mode.

## Install the WEKA Operator

#### 1. Create namespaces and configure authentication

Create the required namespace and Quay.io image pull secrets for the system and default namespaces:

```bash
kubectl create namespace weka-operator-system

kubectl create secret docker-registry quay-io-robot-secret \
  --docker-server=quay.io \
  --docker-username=$QUAY_USERNAME \
  --docker-password=$QUAY_PASSWORD \
  --docker-email=$QUAY_USERNAME \
  --namespace=weka-operator-system

kubectl create secret docker-registry quay-io-robot-secret \
  --docker-server=quay.io \
  --docker-username=$QUAY_USERNAME \
  --docker-password=$QUAY_PASSWORD \
  --docker-email=$QUAY_USERNAME \
  --namespace=default
```

#### 2. Apply the WEKA Operator CRDs

Replace `<weka-operator-version>` with the target WEKA Operator version. Verify the version before deployment.

```bash
helm pull oci://quay.io/weka.io/helm/weka-operator \
  --untar \
  --version <weka-operator-version>

kubectl apply -f weka-operator/crds
```

#### 3. Install the WEKA Operator

Use the Helm command for the cloud environment.

For Amazon EKS, Oracle OKE, and Azure AKS:

```bash
helm upgrade --create-namespace \
  --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version <weka-operator-version> \
  --set csi.installationEnabled=true \
  --set imagePullSecret=quay-io-robot-secret \
  --set cleanupRemovedNodes=true
```

{% hint style="info" %}
**`cleanupRemovedNodes`**

When enabled, the WEKA Operator automatically deletes backend WekaContainers whose target node is no longer part of the Kubernetes cluster. This prevents stale container resources from accumulating when nodes are scaled down or replaced, which occurs frequently in cloud environments. For cloud deployments, this value defaults to `true`.
{% endhint %}

For Google GKE:

{% hint style="warning" %}
Setting `gkeCompatibility.disableDriverSigning=true` immediately reboots all GKE nodes. Perform this step only during planned downtime or before you deploy critical workloads on the cluster.
{% endhint %}

```bash
helm upgrade --create-namespace \
  --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version <weka-operator-version> \
  --set csi.installationEnabled=true \
  --set imagePullSecret=quay-io-robot-secret \
  --set "nodeAgent.persistencePaths=/mnt/stateful_partition/k8s-weka" \
  --set "gkeCompatibility.gkeServiceAccountSecret=gcloud-credentials" \
  --set "gkeCompatibility.disableDriverSigning=true"
```

GKE-specific notes:

* `gkeCompatibility.disableDriverSigning=true` is required because GKE does not currently support signing WEKA kernel drivers with trusted keys. Enforcement of signed kernel drivers is enabled by default on GKE compute node images and disabled by default on GPU node images.
* `nodeAgent.persistencePaths=/mnt/stateful_partition/k8s-weka` is required because `/opt` is read-only on GKE nodes. WEKA persistent data must use a writable partition.

## Deploy the WEKA client

#### 1. Label Kubernetes nodes

Apply the WEKA client support label to each worker node that runs WEKA client pods:

```bash
kubectl label nodes <node-name> weka.io/supports-clients=true
```

#### 2. Configure network interfaces

The `ensure-nics` WekaPolicy configures additional network interfaces for DPDK mode. Skip this step for UDP-only deployments.

On Amazon EKS, the operator creates and attaches NICs automatically. On Oracle OKE, the operator verifies that the required NICs are available. For Google GKE and Azure AKS, pre-create the NICs on the nodes before applying the policy.

1.  Create the `ensure-nics.yaml` manifest:

    ```yaml
    apiVersion: weka.weka.io/v1alpha1
    kind: WekaPolicy
    metadata:
      name: ensure-nics-policy
      namespace: weka-operator-system
    spec:
      type: "ensure-nics"
      image: quay.io/weka.io/weka-in-container:4.4.5.118-k8s.4
      imagePullSecret: "quay-io-robot-secret"
      payload:
        ensureNICsPayload:
          type: aws
          nodeSelector:
            weka.io/supports-clients: "true"
          dataNICsNumber: 2
    ```
2.  Apply the manifest:

    ```bash
    kubectl apply -f ensure-nics.yaml
    ```

#### 3. Deploy the WEKA client

1.  Create the `weka-client.yaml` manifest:

    Replace `<weka-cluster-ip>` with the IP address or load balancer DNS name of the WEKA cluster.

    ```yaml
    apiVersion: weka.weka.io/v1alpha1
    kind: WekaClient
    metadata:
      name: cluster-clients
      namespace: default
    spec:
      image: quay.io/weka.io/weka-in-container:4.4.5.118-k8s.4
      imagePullSecret: "quay-io-robot-secret"
      driversDistService: "https://drivers.weka.io"
      portRange:
        basePort: 46000
      nodeSelector:
        weka.io/supports-clients: "true"
      joinIpPorts: ["<weka-cluster-ip>:14000"]
      coresNum: 4
    ```
2.  Apply the manifest:

    ```bash
    kubectl apply -f weka-client.yaml
    ```

#### 4. Install the CSI plugin

If embedded CSI is not enabled, complete the deployment by installing the WEKA CSI plugin. For details, see the [WEKA CSI Plugin](../../appendices/weka-csi-plugin/) topic.

## Deploy WekaCluster on Oracle OKE

Oracle OKE with bare metal instances supports full WekaCluster deployment in addition to\
WekaClient. The WEKA Operator manages the full lifecycle of both backend and client pods on Oracle OKE.

You can use the [terraform-oci-oke](https://github.com/weka/terraform-oci-oke) module to provision\
the Oracle OKE cluster before installing the WEKA Operator.
