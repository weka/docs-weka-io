# Deployment

You can deploy the WEKA CSI Plugin using the helm chart from the official [WEKA ArtifactHub repository](https://artifacthub.io/packages/helm/csi-wekafs/csi-wekafsplugin).

## Before you begin

Ensure the following prerequisites are met:

* The privileged mode must be allowed on the Kubernetes cluster.
* The following Kubernetes feature gates must be enabled: DevicePlugins, CSINodeInfo, CSIDriverRegistry, and ExpandCSIVolumes (all these gates are enabled by default).
* A WEKA cluster is installed and accessible from the Kubernetes worker nodes.
* For snapshot and directory backing, filesystems must be pre-defined on the WEKA cluster.
* Your workstation has a valid connection to the Kubernetes worker nodes.
* The WEKA client is installed on the Kubernetes worker nodes. Adhere to the following:
  * A WEKA client part of the cluster is recommended rather than a stateless client. See [Add clients](../../install/bare-metal/adding-clients-bare-metal.md).
  * If the Kubernetes worker nodes are part of the WEKA cluster (converged mode on the WEKA servers), ensure the WEKA processes are up before the `kubelet` process.

{% hint style="info" %}
**Note:** Using stateless clients is deprecated and will not be supported on the next WEKA CSI Plugin version.
{% endhint %}

## Installation

1. On your workstation, add the `csi-wekafs` repository:

```
helm repo add csi-wekafs https://weka.github.io/csi-wekafs

```

2. Install the WEKA CSI Plugin. Run the following command:

```
helm install csi-wekafs csi-wekafs/csi-wekafsplugin --namespace csi-wekafs --create-namespace

```

<details>

<summary>Installation output example</summary>

Once the installation completes successfully, the following output is displayed:

```
NAME: csi-wekafsplugin-nutktxdmzg
LAST DEPLOYED: Mon May 29 08:36:19 2023
NAMESPACE: csi-wekafsplugin-nutktxdmzg
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Thank you for installing csi-wekafsplugin.

Your release is named csi-wekafsplugin-nutktxdmzg.
The release is installed in namespace csi-wekafsplugin-nutktxdmzg

To learn more about the release, try:

  $ helm status -n csi-wekafsplugin-nutktxdmzg csi-wekafsplugin-nutktxdmzg
  $ helm get all -n csi-wekafsplugin-nutktxdmzg csi-wekafsplugin-nutktxdmzg

Official Weka CSI Plugin documentation can be found here: https://docs.weka.io/appendix/weka-csi-plugin

Examples on how to configure a storage class and start using the driver are here:
https://github.com/weka/csi-wekafs/tree/master/examples

-------------------------------------------------- NOTICE --------------------------------------------------
| THIS VERSION INTRODUCES SUPPORT FOR ADDITIONAL VOLUME TYPES, AS WELL AS SNAPSHOT AND VOLUME CLONING CAPS |
| TO BETTER UNDERSTAND DIFFERENT TYPES OF VOLUMES AND THEIR IMPLICATIONS, REFER TO THE DOCUMENTATION ABOVE |
| ALSO, IT IS RECOMMENDED TO CAREFULLY GO OVER NEW CONFIGURATION PARAMETERS AND ITS MEANINGS, AS BEHAVIOR  |
| OF THE PLUGIN AND ITS REPORTED CAPABILITIES LARGELY DEPEND ON THE CONFIGURATION AND WEKA CLUSTER VERSION |
------------------------------------------------------------------------------------------------------------

-------------------------------------------------- WARNING -------------------------------------------------
|  SUPPORT OF LEGACY VOLUMES WITHOUT API BINDING WILL BE REMOVED IN NEXT MAJOR RELEASE OF WEKA CSI PLUGIN. |
|  NEW FEATURES RELY ON API CONNECTIVITY TO WEKA CLUSTER AND WILL NOT BE SUPPORTED ON API-UNBOUND VOLUMES. |
|  PLEASE MAKE SURE TO MIGRATE ALL EXISTING VOLUMES TO API-BASED SCHEME PRIOR TO NEXT VERSION UPGRADE.     |
------------------------------------------------------------------------------------------------------------

```

</details>

## Upgrade

Perform one of the following upgrade procedures depending on the installation method of the existing WEKA CSI Plugin.

{% hint style="danger" %}
**Note:** If you plan to upgrade the existing WEKA CSI Plugin and enable directory quota enforcement for already existing volumes, see the [Bind legacy volumes to API](upgrade-legacy-persistent-volumes-for-capacity-enforcement.md#bind-legacy-volumes-to-api) section.
{% endhint %}

### Upgrade: if `deploy.sh` was used&#x20;

If the existing installation was done using the `deploy.sh` command, perform the following:

1. Uninstall the existing CSI Plugin using the `cleanup.sh` script (which is located only in the previous version).\
   Run the following script:

```
$REPO_ROOT/deploy/kubernetes-latest/cleanup.sh
```

2. Install WEKA CSI Plugin. See the [Installation](deployment.md#installation) section.

### Upgrade: if `helm install` was used &#x20;

If the existing installation was done using the `helm install` command, perform the following:

{% hint style="warning" %}
**Note:** In WEKA CSI Plugin v2.0, the CSIDriver object has changed. The installed release cannot be upgraded in place because the CSIDriver objects are immutable, so first, uninstall the existing WEKA CSI Plugin. \
Run the following command:\
`helm uninstall csi-wekafs --namespace csi-wekafs`
{% endhint %}

1. Download the `csi-wekafs` git repository.

```
git clone https://github.com/weka/csi-wekafs.git --branch v0.6.6 --single-branch
```

2. Upgrade the existing helm release as follows:
   * Ensure the Helm repository is installed. See the [Installation](deployment.md#installation) section.
   * Run the following command line:

```
helm upgrade --install csi-wekafs --namespace csi-wekafs csi-wekafs/csi-wekafsplugin

```

<details>

<summary>Upgrade output example</summary>

Once the upgrade completes successfully, the following output is displayed:

```
Release "csi-wekafs" has been upgraded. Happy Helming!
NAME: csi-wekafs
LAST DEPLOYED: Tue Nov  2 15:39:01 2021
NAMESPACE: csi-wekafs
STATUS: deployed
REVISION: 10
TEST SUITE: None
NOTES:
Thank you for installing csi-wekafsplugin.

Your release is named csi-wekafs.

To learn more about the release, try:

  $ helm status csi-wekafs
  $ helm get all csi-wekafs

Official Weka CSI Plugin documentation can be found here: https://docs.weka.io/appendix/weka-csi-plugin

```

</details>

3. Elevate OpenShift privileges.\
   If the Kubernetes worker nodes run on RHEL and use OpenShift, elevate the OpenShift privileges for the WEKA CSI Plugin. (RHCoreOS on Kubernetes worker nodes is not supported.)\
   To elevate the OpenShift privileges, run the following command lines:

```
oc create namespace csi-wekafs
oc adm policy add-scc-to-user privileged system:serviceaccount:csi-wekafs:csi-wekafs-node
oc adm policy add-scc-to-user privileged system:serviceaccount:csi-wekafs:csi-wekafs-controller

```
