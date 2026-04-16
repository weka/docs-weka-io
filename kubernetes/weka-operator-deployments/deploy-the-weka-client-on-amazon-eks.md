---
description: >-
  Deploy the WEKA operator on a cloud-managed Kubernetes service to mount WEKA
  filesystems from application pods running in a managed cluster.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/kubernetes/weka-operator-deployments/deploy-the-weka-client-on-amazon-eks
---

# Deploy WEKA on managed Kubernetes services

## Supported configurations

The following table describes the support levels for different cloud services:

<table><thead><tr><th width="120">Cloud service</th><th width="110">Instance type</th><th width="133">WekaCluster (backends)</th><th width="127">WekaClient: UDP</th><th width="117">WekaClient: DPDK</th><th width="140">NIC provisioning for DPDK</th></tr></thead><tbody><tr><td>Amazon EKS</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Supported</td><td>Operator creates and attaches NICs automatically</td></tr><tr><td>Oracle OKE</td><td>Bare metal</td><td>Supported</td><td>Supported</td><td>Supported</td><td>Manual</td></tr><tr><td>Oracle OKE</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Supported</td><td>Operator verifies required number of NICs</td></tr><tr><td>Google GKE</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Not Supported</td><td></td></tr><tr><td>Azure AKS</td><td>VM</td><td>Not supported</td><td>Supported</td><td>Not Supported</td><td> </td></tr></tbody></table>

## Prerequisites

Ensure the following conditions are met for all supported cloud environments:

* A WEKA cluster is deployed and reachable from the managed Kubernetes nodes if deploying only `WekaClient`.
* Network access to `https://drivers.weka.io` is available from all Kubernetes nodes.
* Quay.io credentials (`QUAY_USERNAME` and `QUAY_PASSWORD`) are obtained from WEKA Customer Success.
* Security groups and network ACLs align with the WEKA operator deployment requirements.

## Node configuration

Enable static CPU allocation and reserve core 0 on each client node. Reserve 1.5 GiB using hugepages for the client core.

1.  Configure the Kubelet:

    ```bash
    CONFIG_PATH="/etc/kubernetes/kubelet/kubelet-config.json"
    cat <<< $(jq '.systemReserved.cpu = "1"' "$CONFIG_PATH") > "$CONFIG_PATH"
    cat <<< $(jq '.cpuManagerPolicy = "static"' "$CONFIG_PATH") > "$CONFIG_PATH"
    ```
2.  Restart the Kubelet:

    ```bash
    sudo systemctl restart kubelet
    ```
3.  Set up Hugepages:

    ```bash
    cat <<EOF > /etc/systemd/system/hugepages.service
    [Unit]
    Description=Hugepages

    [Service]
    Type=oneshot
    ExecStart=/bin/sh -c 'echo "hugepagesStr" > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages;'
    RemainAfterExit=yes

    [Install]
    WantedBy=multi-user.target
    EOF
    systemctl daemon-reload
    systemctl enable hugepages
    systemctl restart hugepages
    ```

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

### Oracle OKE

Bare metal instances are recommended for WekaCluster (backend) deployments and for production DPDK workloads. To provision the Oracle OKE cluster infrastructure, use the `terraform-oci-oke` Terraform module.

### Google GKE

Create a `gcloud-credentials` Kubernetes secret to grant the operator access to GCP APIs. The operator mounts this secret into the driver-builder pod at `/var/secrets/google` and sets `GOOGLE_APPLICATION_CREDENTIALS=/var/secrets/google/service-account.json`.

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

Azure AKS supports WekaClient in UDP mode.&#x20;

## Deploy the WEKA client

#### 1. Label Kubernetes nodes

Apply the WEKA client support label to each worker node that runs WEKA client pods:

```bash
kubectl label nodes <node-name> weka.io/supports-clients=true
```

#### 2. Create namespaces and configure authentication

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

#### 3. Install the WEKA Operator

Use the Helm command appropriate for the cloud environment.

For Amazon EKS, Oracle OKE, and Azure AKS:

```bash
helm upgrade \
  --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version v1.10.5 \
  --set imagePullSecret=quay-io-robot-secret
```

For Google GKE:

```bash
helm upgrade \
  --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version v1.10.5 \
  --set imagePullSecret=quay-io-robot-secret \
  --set "nodeAgent.persistencePaths=/mnt/stateful_partition/k8s-weka" \
  --set "gkeCompatibility.gkeServiceAccountSecret=gcloud-credentials" \
  --set "gkeCompatibility.disableDriverSigning=true"
```

#### 4. Configure network interfaces

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

#### 5. Deploy the WEKA client

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

#### 6. Install the CSI plugin

Complete the deployment by installing the WEKA CSI plugin. Refer to the CSI plugin installation instructions for detailed steps.

## Deploy WekaCluster on Oracle OKE

Oracle OKE with bare metal instances supports full WekaCluster deployment in addition to\
WekaClient. The WEKA Operator manages the full lifecycle of both backend and client pods on Oracle OKE.

You can use the [terraform-oci-oke](https://github.com/weka/terraform-oci-oke) module to provision\
the Oracle OKE cluster before installing the WEKA Operator.
