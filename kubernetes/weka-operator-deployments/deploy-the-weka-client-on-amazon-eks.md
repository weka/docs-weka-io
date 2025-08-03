---
description: >-
  Deploy the WEKA client on an existing Amazon EKS cluster to enable Kubernetes
  workloads to access the WEKA filesystem.
---

# Deploy the WEKA client on Amazon EKS

The WEKA client enables Kubernetes workloads on Amazon EKS to connect to and access a WEKA cluster deployed in AWS. Client pods are managed using Kubernetes custom resources and require coordination with the WEKA Operator for installation and lifecycle management.

#### Prerequisites

1. **Verify network access to the WEKA driver distribution service:** Ensure that the deployment environment has network access to `https://drivers.weka.io`. The WEKA client pods automatically download the required driver components from this public distribution service to interface with the WEKA filesystem. For more information, see [drivers-distribution-service.md](../../drivers-distribution-service.md "mention").
2. **Verify security groups and** [**NACL**](#user-content-fn-1)[^1] **configuration:** The WEKA client requires the ports specified in the following topics:
   * [#required-ports](../../planning-and-installation/prerequisites-and-compatibility.md#required-ports "mention") (in the **WEKA Prerequisites and compatibility** topic).
   * [#kubernetes-port-requirements](./#kubernetes-port-requirements "mention") (in the **WEKA Operator deployment** topic).
3. **Obtain setup information:** Contact the [WEKA Customer Success Team](../../support/getting-support-for-your-weka-system.md) to obtain the necessary setup information. You need the following credentials to proceed with the deployment:
   * Container repository (quay.io)
     * Image pull secrets and Docker:
       * `QUAY_USERNAME`: `example_user`
       * `QUAY_PASSWORD`: `example_password`
   *   WEKA Operator version and image version tag

       * For the most current operator and image versions, refer to the WEKA Operator page at [https://get.weka.io/ui/operator](https://get.weka.io/ui/operator). From there, you can obtain the latest `WEKA_OPERATOR_VERSION` and `WEKA_IMAGE_VERSION_TAG`.

       Gathering this information in advance provides all the required values to complete the deployment workflow efficiently. Use these values to replace the placeholders in the setup files.
4. **A deployed WEKA cluster is required:** Use the same subnets and security groups from the WEKA cluster when configuring the EKS environment for client deployment. For guidance on deploying the WEKA cluster with Terraform, see [weka-installation-on-aws-using-terraform](../../planning-and-installation/aws/weka-installation-on-aws-using-terraform/ "mention").
5. **EKS deployment prerequisites:** Configure the EKS cluster with the following global settings:
   * **IAM Role and policy configuration:** Configure the appropriate IAM roles and policies for both the EKS cluster and its worker nodes:
   *   **Cluster IAM role**

       Attach the IAM role associated with the EKS cluster:

       * AmazonEKSBlockStoragePolicy
       * AmazonEKSClusterPolicy
       * AmazonEKSComputePolicy
       * AmazonEKSLoadBalancingPolicy
       * AmazonEKSNetworkingPolicy

       (These policies are included when using the recommended IAM role: **EKS - Auto Cluster**.)
   *   **Node group IAM role**\
       Attach the IAM role for the managed node groups, which host the worker nodes running the WEKA operator:

       * AmazonEC2ContainerRegistryPullOnly
       * AmazonEKSWorkerNodeMinimalPolicy

       Additionally, to ensure proper networking functionality, attach the following policy:

       * AmazonEKS\_CNI\_Policy

       (These policies are included in the recommended IAM role: **EKS - Auto Node**.)
   * **CPU allocation**
     * Enable the Static CPU allocation.
     * Reserve Core 0.
   * **Hugepages allocation**
     * Reserve 1.5 GiB for the client core.

<details>

<summary>Example: How to set up CPU allocation and hugepages </summary>

Add to the worker nodes launch template the following sections:

{% code overflow="wrap" %}
```bash
#Set up core alloaction
CONFIG_PATH="/etc/kubernetes/kubelet/kubelet-config.json"
cat <<< $(jq '.systemReserved.cpu = "1"' "$CONFIG_PATH") > "$CONFIG_PATH"
cat <<< $(jq '.cpuManagerPolicy = "static"' "$CONFIG_PATH") > "$CONFIG_PATH"

#Set up hupepages
if [ $(cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages) == "` + hugepagesStr + `" ]; then
 echo hugepages already set
else
cat <<EOF > /etc/systemd/system/hugepages.service

[Unit]
Description=Hugepages

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo "` + hugepagesStr + `" > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages;'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable hugepages
systemctl restart hugepages
fi
```
{% endcode %}

</details>

#### Procedure

1. **Label the EKS nodes:** Label EKS worker nodes intended for WEKA client deployment. Apply the label to each node designated to host WEKA client pods.

```bash
kubectl label nodes <node-name> weka.io/supports-clients=true
```

2. **Create namespaces and configure Quay authentication**: Set up the required Kubernetes namespaces (`weka-operator-system` and `default`), and create a Docker registry secret to authenticate access to WEKA container images hosted on Quay:

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

3. **Install the WEKA Operator:** Install the WEKA Operator using the official Helm chart:

```bash
helm upgrade \
  --install weka-operator oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --version v1.6.2 \
  --set imagePullSecret=quay-io-robot-secret
```

4. **Configure NICs:** Create the `ensure-nics.yaml` manifest to enable multi-NIC support on selected nodes:

{% code title="ensure-nics.yaml" %}
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
        support-client: "true"
      dataNICsNumber: 2
```
{% endcode %}

Apply the manifest:

```
kubectl apply -f ensure-nics.yaml
```

5. **Deploy the WEKA client resource:**  Define the WEKA client custom resource. Replace the `joinIpPorts` value with a valid IP or ALB DNS of the deployed WEKA cluster:

{% code title="weka-client.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaClient
metadata:
  name: cluster-dev-clients
  namespace: default
spec:
  image: quay.io/weka.io/weka-in-container:4.4.5.118-k8s.4
  imagePullSecret: "quay-io-robot-secret"
  driversDistService: "https://drivers.weka.io"
  portRange:
    basePort: 46000
  nodeSelector:
    weka.io/supports-clients: "true"
  joinIpPorts: ["10.0.76.143:14000"]
  coresNum: 4
```
{% endcode %}

Apply the manifest:

```
kubectl apply -f weka-client.yaml
```

6. **Install a CSI plugin:** Follow the procedures in [weka-csi-plugin](../../appendices/weka-csi-plugin/ "mention").

[^1]: Network Access Control List
