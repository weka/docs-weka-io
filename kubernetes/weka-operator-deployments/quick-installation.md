---
description: >-
  Use this quick start procedure to deploy the WEKA Operator and provision a
  minimal WEKA cluster on Kubernetes in five steps.
---

# Quick installation

#### **Before you begin**

* Access the [WEKA Operator page](https://get.weka.io/ui/operator) to obtain the target `WEKA_OPERATOR_VERSION` and `WEKA_IMAGE_VERSION_TAG`.
* To obtain your `QUAY_USERNAME`, `QUAY_PASSWORD`, and target version tags, ensure you can access `get.weka.io`. See [Obtain the installation packages](../../planning-and-installation/bare-metal/obtaining-the-weka-install-file.md).
* Ensure `helm`, `kubectl`, and Docker are installed. Log in to `quay.io` before pulling the Helm chart.
* Verify all nodes meet the hardware and software requirements described in Prepare Kubernetes environment.

#### **Procedure**

**1. Install the WEKA Operator**

Apply the Custom Resource Definitions (CRDs) so the Kubernetes API can recognize WEKA resources, then deploy the operator controller.

```bash
helm upgrade --install weka-operator \
  oci://quay.io/weka.io/helm/weka-operator \
  --namespace weka-operator-system \
  --create-namespace \
  --version v1.13.0 \
  --set csi.installationEnabled=true
```

**2. Configure image pull secrets**

Create the Kubernetes image pull secrets that allow the operator and WEKA resources to pull container images. In this example, create the secret in `weka-operator-system` and `default`.

Replace the credentials with your values, or copy the generated command from `get.weka.io`. If additional namespaces require WEKA resources, run the same command for each namespace with the relevant namespace value.

<details>

<summary>get.weka.io: WEKA Operator image pull secrets example</summary>

<figure><img src="../../.gitbook/assets/get-weka-io_weka_operator_example (1).png" alt=""><figcaption></figcaption></figure>

</details>

```bash
export QUAY_USERNAME=<your_username>
export QUAY_PASSWORD=<your_password>

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

{% hint style="info" %}
Quick installation uses `https://drivers.weka.io` by default. Configure local driver distribution for example, air-gapped environments or custom kernels. See [Driver management with the WEKA Operator](/broken/spaces/ZW262oqYA8pNNfGvXjHa/pages/CnmsppNCO6Z9dfmCPGL1).
{% endhint %}

**3. Sign drives**

Identify and prepare the physical storage devices before provisioning the cluster. Apply a `WekaPolicy` to automate drive discovery and signing.

Create `sign-drives.yaml`:

{% code title="sign-drives.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaPolicy
metadata:
  name: sign-drives
  namespace: weka-operator-system
spec:
  type: sign-drives
  payload:
    signDrivesPayload:
      type: "all-not-root"
```
{% endcode %}

Apply the manifest:

```bash
kubectl apply -f sign-drives.yaml
```

**4. Deploy the WekaCluster**

Provision the backend storage by applying the `WekaCluster` custom resource. This resource defines the compute and drive containers, networking, and the driver distribution endpoint.

Create `weka-cluster.yaml`:

{% code title="weka-cluster.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  name: weka-cluster-dev
  namespace: default
spec:
  template: dynamic
  dynamicTemplate:
    computeContainers: 6
    driveContainers: 6
    numDrives: 1 #upated according to the available drives on each node
  image: quay.io/weka.io/weka-in-container:5.1.0
  nodeSelector:
    weka.io/supports-backends: "true"
  imagePullSecret: "quay-io-robot-secret"
```
{% endcode %}

Apply the manifest:

```bash
kubectl apply -f weka-cluster.yaml
```

{% hint style="info" %}
`containerCapacity` is required for WEKA 5.1.0 and later when drive sharing is enabled. For earlier versions, use `numDrives` instead.
{% endhint %}

**5. Deploy the WekaClient**

Deploy the `WekaClient` custom resource to manage the client processes that mount WEKA filesystems to application pods. Use the `targetCluster` field to reference the `WekaCluster` deployed in the previous step.

Create `weka-client.yaml`:

{% code title="weka-client.yaml" %}
```yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaClient
metadata:
  name: cluster-dev-clients
  namespace: default
spec:
  image: quay.io/weka.io/weka-in-container:5.1.0
  imagePullSecret: "quay-io-robot-secret"
  driversDistService: "https://drivers.weka.io"
  nodeSelector:
    weka.io/supports-clients: "true"
  targetCluster:
    name: weka-cluster-dev
    namespace: default
```
{% endcode %}

Apply the manifest:

```bash
kubectl apply -f weka-client.yaml
```

**What to do next**

Verify deployment health: `kubectl get wekaclusters` and `kubectl get wekaclients`
