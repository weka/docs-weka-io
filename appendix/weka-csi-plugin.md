---
description: >-
  This page describes the Weka CSI Plugin prerequisites, capabilities,
  deployment, and usage.
---

# Weka CSI Plugin

The [Container Storage Interface](https://github.com/container-storage-interface/spec/blob/master/spec.md) (CSI) is a standard for exposing arbitrary block and file storage systems to containerized workloads on Container Orchestration Systems (COs) like Kubernetes.

The Weka CSI Plugin provides the creation and configuration of persistent storage external to Kubernetes. CSI replaces plugins developed earlier in the Kubernetes evolution. It replaces the `hostPath` method to expose WekaFS mounts as Kubernetes volumes.

### Interoperability

* CSI protocol: 1.0-1.2
* Kubernetes: 1.18 - 1.2
* WekaFS: 3.8 and up
* AppArmor is not supported yet

{% hint style="info" %}
**Note:** Quota enforcement on persistent volumes requires WekaFS version 3.13 and up
{% endhint %}

### Prerequisites

* The privileged mode must be allowed on the Kubernetes cluster
* The following Kubernetes feature gates must be enabled: DevicePlugins, CSINodeInfo, CSIDriverRegistry, ExpandCSIVolumes (if not changed, they should be enabled by default)
* A Weka cluster is installed and accessible from the Kubernetes worker nodes
* The Weka client is installed on the Kubernetes worker nodes
  * It is recommended to use a [Weka client which is part of the cluster](../install/bare-metal/adding-clients-bare-metal.md#adding-clients-which-are-always-part-of-the-cluster) rather than a [stateless client](../install/bare-metal/adding-clients-bare-metal.md#adding-stateless-clients)
  * If the Kubernetes nodes are part of the Weka cluster (converged mode on the Weka servers), make sure the Weka processes come up before `kubelet`
* Filesystems are pre-configured on the Weka system

### Capabilities

#### Supported capabilities

* Static and dynamic volumes provisioning
* Mounting a volume as a WekaFS filesystem directory
* All volume access modes are supported: ReadWriteMany, ReadWriteOnce, and ReadOnlyMany
* Volume expansion
* Quota enforcement on persistent volumes

{% hint style="info" %}
**Note:** Quota enforcement on persistent volumes requires WekaFS version 3.13 and up. For additional information about enforcing quotas on existing persistent volumes, see the  [Upgrading Legacy Persistent Volumes for Capacity Enforcement](weka-csi-plugin.md#upgrading-legacy-persistent-volumes-for-capacity-enforcement) section.
{% endhint %}

#### Unsupported capabilities

* Snapshots

## Deployment

The Weka CSI Plugin deployment can be performed with a [Helm chart](https://artifacthub.io/packages/helm/csi-wekafs/csi-wekafsplugin) from the official Weka ArtifactHub repository.

### Installation

On your workstation (assuming connectivity to Kubernetes cluster), add the `csi-wekafs` repository:

```
helm repo add csi-wekafs https://weka.github.io/csi-wekafs
```

Install the plugin by issuing the following command:

```
helm install csi-wekafs csi-wekafs/csi-wekafsplugin --namespace csi-wekafs --create-namespace
```

On successful installation the following output is provided:

```
Release "csi-wekafs" has been installed. Happy Helming!
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

### Upgrade

#### Clean up a direct deployment of CSI driver

{% hint style="warning" %}
**Note:** Upgrading a plugin deployed directly (via `deploy.sh` script) is not supported. This section describes the procedure to clean up the existing CSI plugin components. After cleanup, proceed to the [Installation](weka-csi-plugin.md#installation) section.

If the previous version was installed using Helm, you can safely skip this section.
{% endhint %}

Download the `csi-wekafs` git repository

```
git clone https://github.com/weka/csi-wekafs.git --branch v0.6.6 --single-branch
```

Assuming connectivity to the Kubernetes cluster is valid, run the following script to remove the CSI driver components:

```
$REPO_ROOT/deploy/kubernetes-latest/cleanup.sh
```

#### Upgrade an existing helm release

{% hint style="danger" %}
**Note:** If you plan to upgrade existing Weka CSI Plugin deployment and enable directory quota enforcement for already existing volumes, please refer to the [Binding Legacy Volumes to API](weka-csi-plugin.md#binding-legacy-volumes-to-api) section.
{% endhint %}

If not yet configured, add the Helm repository as defined in the [Installation](weka-csi-plugin.md#installation) section.

Execute the following command:

```
helm upgrade --install csi-wekafs --namespace csi-wekafs csi-wekafs/csi-wekafsplugin
```

A successful upgrade provides the following output:

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

### CSI plugin and WekaFS cluster software upgrade

The CSI Plugin fetches the WekaFS cluster capabilities during the first login to the API endpoint and caches it throughout the login refresh token validity period, to improve the efficiency and performance of the plugin.

However, the WekaFS cluster upgrade might come unnoticed if performed during this time window, continuing to provision new volumes in legacy mode.

To expedite the update of the Weka cluster capabilities, it is recommended to delete all the CSI Plugin pods, to invalidate the cache. The pods will then be restarted.

```
kubectl delete pod -n csi-wekafs -lapp=csi-wekafs-controller
kubectl delete pod -n csi-wekafs -lapp=csi-wekafs-node
```

## Storage class configuration

The Weka CSI Plugin supports both dynamic (persistent volume claim) and static (persistent volume) volume provisioning. For provisioning either type of a persistent volume, a Storage Class must exist in Kubernetes deployment that matches the Weka cluster configuration.

In the [Legacy communication model](weka-csi-plugin.md#legacy-deployment-model), the Weka CSI Plugin does not communicate with the Weka cluster via API and solely relies on in-band communication via the data plane. This configuration does not provide extended configuration abilities.

In the [API-Based communication model](weka-csi-plugin.md#api-based-deployment-model), the Weka CSI Plugin communicates with the Weka cluster using REST API, leveraging this integration to provide extended abilities, such as strict enforcement of volume capacity usage via integration with WekaFS [directory quota](../fs/quota-management.md#directory-quotas) functionality.&#x20;

{% hint style="info" %}
**Note:** Only the API-Based communication model is maintained and enhanced with new capabilities. If you are running the legacy CSI plugin, it is advisable to replace it with the API-Based one.
{% endhint %}

### Legacy communication model

This model assumes no API connectivity to the Weka cluster. As a result, the functionality provided by the Weka CSI Plugin is limited.

{% hint style="info" %}
**Note:** This section refers to the configuration of the CSI plugin prior to version v0.7.0

Although this configuration is supported in version 0.7.0 and up, the user is encouraged to upgrade any existing deployment of the Weka CSI Plugin to the API-based model
{% endhint %}

It is first required to define a storage class to use the Weka CSI Plugin.

#### Storage class example

{% code title="csi-wekafs/examples/dynamic/storageclass-wekafs-dir.yaml" %}
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storageclass-wekafs-dir
provisioner: csi.weka.io
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
parameters:
  volumeType: dir/v1
  filesystemName: podsFilesystem
```
{% endcode %}

#### **Storage class parameters**

| **Parameter**    | **Description**                                                                | **Limitations**                                 |
| ---------------- | ------------------------------------------------------------------------------ | ----------------------------------------------- |
| `filesystemName` | The name of the Weka filesystem to create directories in as Kubernetes volumes | The filesystem should exist in the Weka cluster |

Apply the StorageClass and check it has been created successfully:

```
# apply the storageclass .yaml file
$ kubectl apply -f storageclass-wekafs-dir.yaml
storageclass.storage.k8s.io/storageclass-wekafs-dir created

# check the storageclass resource has been created
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-dir        csi.weka.io         Delete          Immediate           true                   75s
```

It is possible to define multiple storage classes with different filesystems.

### API-based communication model

In the API-based model, the API endpoint addresses and authentication credentials must be provided to the Weka CSI Plugin in order to establish a REST API connection with the Weka cluster and perform configuration tasks on it.

The information is stored securely in [Kubernetes secret](https://kubernetes.io/docs/concepts/configuration/secret/), which is, in turn, referred to by the  Storage Class.

{% hint style="info" %}
**Note:** This section refers to the configuration of CSI plugin version **v0.7.0** and up.
{% endhint %}

{% hint style="info" %}
**Note:** Directory quota integration requires WekaFS software version **v3.13.0** and up.
{% endhint %}

{% hint style="info" %}
**Note:** Authenticated mounts for filesystems set with `auth-required=true`, and filesystems in the non-root organization, require WekaFS software version **v3.14.0** and up.
{% endhint %}

{% hint style="warning" %}
**Note:** It is recommended to deploy the CSI plugin in API-Based communication model even if the Weka cluster is below version **v3.13.0**

Volumes provisioned using the API-Based model on older Weka clusters, do not support capacity enforcement, and are still considered "Legacy". However, they can be easily upgraded to capacity enforcement capabilities after the Weka cluster upgrade.
{% endhint %}

#### Secret data example

{% code title="csi-wekafs/examples/dynamic_api/csi-wekafs-api-secret.yaml" %}
```
apiVersion: v1
kind: Secret
metadata:
  name: csi-wekafs-api-secret
  namespace: csi-wekafs
type: Opaque
data:
  username: Y3Np
  password: TXlBd2Vzb21lUGFzc3dvcmQ=
  organization: Um9vdA==
  endpoints: MTcyLjMxLjE1LjExMzoxNDAwMCwxNzIuMzEuMTIuOTE6MTQwMDA=
  scheme: aHR0cA==
```
{% endcode %}

#### Secret data parameters

{% hint style="info" %}
**Note:** Make sure that all data is base64-encoded when creating a secret.
{% endhint %}

| **Key**        | **Description**                                                                                                                             | **Notes**                                                                                                                                           |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `username`     | The user name for API access to the Weka cluster, in base64 encoding.                                                                       | Must have at least read-write permissions in the organization. It is recommended to create a separate user with admin privileges for the CSI plugin |
| `password`     | The user password for API access to the Weka cluster, in base64 encoding.                                                                   |                                                                                                                                                     |
| `organization` | The Weka organization name for the user, in base64 encoding (use `Root` if you only have one organization).                                 | Multiple secrets may be used to provide access to multiple organizations, which in turn will be specified in different storage classes              |
| `scheme`       | The URL scheme used to commnicate with the Weka cluster API.                                                                                | `http` or `https` can be used. The user must ensure that the Weka cluster was configured to use the same connection scheme.                         |
| `endpoints`    | <p>Comma-separated list of endpoints consisting of IP address and port, e.g. </p><p><code>172.31.15.113:14000,172.31.12.91:14000</code></p> | The management IP addresses of at least 2 backend hosts should be provided for redundancy.                                                          |

Apply the Secret and check it has been created successfully:

```
# apply the secret .yaml file
$ kubectl apply -f csi-wekafs-api-secret.yaml

# Check the secret was successfully created
$ kubectl get secret csi-wekafs-api-secret -n csi-wekafs
NAME                    TYPE     DATA   AGE
csi-wekafs-api-secret   Opaque   5      7m
```

{% hint style="info" %}
**Note:** To provision CSI volumes on filesystem residing in non-root organizations, or filesystems set with `auth-required=true,` CSI plugin of version **0.7.4** or higher is required, as well as Weka software of version **3.14** or higher
{% endhint %}

#### Storage class example

{% code title="csi-wekafs/examples/dynamic_api/storageclass-wekafs-dir-api.yaml" %}
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storageclass-wekafs-dir-api
provisioner: csi.weka.io
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
parameters:
  volumeType: dir/v1
  filesystemName: default
  capacityEnforcement: HARD
  # optional parameters setting UID, GID and permissions on volume
  # UID of the volume owner, default 0 (root)
  #ownerUid: "1000"
  # GID of the volume owner, default 0 (root)
  #ownerGid: "1000"
  # permissions in Unix octal format, default "0750"
  #permissions: "0775"
  # name of the secret that stores API credentials for a cluster
  # change the name of secret to match secret of a particular cluster (if you have several Weka clusters)
  csi.storage.k8s.io/provisioner-secret-name: &secretName csi-wekafs-api-secret
  # change the name of the namespace in which the cluster API credentials
  csi.storage.k8s.io/provisioner-secret-namespace: &secretNamespace csi-wekafs
  # do not change anything below this line, or set to same parameters as above
  csi.storage.k8s.io/controller-publish-secret-name: *secretName
  csi.storage.k8s.io/controller-publish-secret-namespace: *secretNamespace
  csi.storage.k8s.io/controller-expand-secret-name: *secretName
  csi.storage.k8s.io/controller-expand-secret-namespace: *secretNamespace
  csi.storage.k8s.io/node-stage-secret-name: *secretName
  csi.storage.k8s.io/node-stage-secret-namespace: *secretNamespace
  csi.storage.k8s.io/node-publish-secret-name: *secretName
  csi.storage.k8s.io/node-publish-secret-namespace: *secretNamespace

```
{% endcode %}

#### **Storage class parameters**

| **Parameter**                                     | **Description**                                                                                                                                                                                                                                                                                                                                                                              |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `filesystemName`                                  | <p>The name of the Weka filesystem to create directories in as Kubernetes volumes. </p><ul><li>The filesystem must exist on the Weka cluster</li><li>The filesystem may not be defined as "authenticated"</li></ul>                                                                                                                                                                          |
| `capacityEnforcement`                             | <p>Can be <code>HARD</code> or <code>SOFT</code></p><ul><li><code>HARD</code>: strictly enforce quota and deny any write operation to the persistent volume consumer until space is freed up</li><li><code>SOFT</code>: do not strictly enforce the quota, but create an alert on the Weka cluster</li></ul>                                                                                 |
| `ownerUid`                                        | Effective User ID of the owner user for the provisioned CSI volume. Might be required for application deployments running under non-root accounts. Defaults to `0`                                                                                                                                                                                                                           |
| `ownerGid`                                        | Effective Group ID of the owner user for the provisioned CSI volume. Might be required for application deployments running under non-root accounts. Defaults to `0`                                                                                                                                                                                                                          |
| `permissions`                                     | Unix permissions for the provisioned volume root directory, in octal format. Must be set in quotes. Defaults to `"0775"`                                                                                                                                                                                                                                                                     |
| `csi.storage.k8s.io/provisioner-secret-name`      | <p>Name of the K8s secret, e.g. <code>csi-wekafs-api-secret</code></p><p>It is recommended to use an anchor definition in order to avoid mistakes since the same value has to be entered in additional fields below, according to the CSI spec definitions. Refer to the example above for exact formatting.</p>                                                                             |
| `csi.storage.k8s.io/provisioner-secret-namespace` | <p>The namespace the secret is located in. </p><p>The secret does not have to be located in the same namespace as the CSI plugin is installed.</p><p>It is recommended using an anchor definition in order to avoid mistakes since the same value has to be entered in additional fields below, accordings to the CSI spec definitions. Refer to the example above for exact formatting.</p> |

Apply the StorageClass and check it has been created successfully:

```
# apply the storageclass .yaml file
$ kubectl apply -f storageclass-wekafs-dir.yaml
storageclass.storage.k8s.io/storageclass-wekafs-dir created

# check the storageclass resource has been created successfully 
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-dir        csi.weka.io         Delete          Immediate           true                   75s
```

* It is possible to define multiple storage classes with different filesystems.&#x20;
* The same secret may be reused for multiple storage classes, as long as credentials are valid to access the filesystem
* Several secrets may be used, e.g., for different organizations on the same Weka cluster, or for different Weka clusters spanning across the same Kubernetes cluster

{% hint style="info" %}
**Note:** Multiple weka cluster connections from the same Kubernetes node are not supported in the current release of Weka software.&#x20;

However, different Kubernetes nodes within the same cluster (e.g., in different regions or availability zones) can be connected to different Weka clusters. In such a case, provided that the Weka CSI plugin can access the Weka cluster REST API, a single CSI plugin instance can orchestrate persistent volume provisioning on multiple clusters.
{% endhint %}

## Provision usage

### Dynamic provisioning

Using a similar storage class to the above, it is possible to define a persistent volume claim (PVC) for the pods.

#### Persistent volume claim example

{% code title="csi-wekafs/examples/dynamic/pvc-wekafs-dir.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-wekafs-dir
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: storageclass-wekafs-dir
  volumeMode: Filesystem
  resources:
    requests:
      storage: 1Gi
```
{% endcode %}

#### Persistent volume claim **parameters**

| **Parameter**                     | **Description**                            | **Limitations**                                                                                                 |
| --------------------------------- | ------------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| `spec.accessModes`                | The volume access mode                     | `ReadWriteMany`, `ReadWriteOnce`, or `ReadOnlyMany`                                                             |
| `spec.storageClassName`           | The storage class to use to create the PVC | Must be an existing storage class                                                                               |
| `spec.resources.requests.storage` | A desired capacity for the volume          | The capacity quota is not enforced but is stored on the filesystem directory extended attributed for future use |

Apply the PersistentVolumeClaim and check it has been created successfully:

```
# apply the pvc .yaml file
$ kubectl apply -f pvc-wekafs-dir.yaml
persistentvolumeclaim/pvc-wekafs-dir created

# check the pvc resource has been created
$ kubectl get pvc
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
pvc-wekafs-dir        Bound    pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380   1Gi        RWX            storageclass-wekafs-dir        2m10s
```

{% hint style="info" %}
**Note:** The directory will be created inside the filesystem under `csi-volumes` directory, starting with the volume name.
{% endhint %}

### Static provisioning

The Kubernetes admin can prepare some persistent volumes in advance to be used by pods, they should be an existing directory, and can contain pre-populated data to be used by the PODs.

It can be a directory previously provisioned by the CSI or a pre-existing directory in WekaFS. To expose an existing directory in WekaFS via CSI, define a persistent volume, and link a persistent volume claim to this persistent volume.

#### Persistent volume example

{% code title="csi-wekafs/examples/static/pv-wekafs-dir-static.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-wekafs-dir-static
spec:
  storageClassName: storageclass-wekafs-dir
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
  capacity:
    storage: 1Gi
  csi:
    driver: csi.weka.io
    # volumeHandle must be formatted as following:
    # dir/v1/<FILE_SYSTEM_NAME>/<INNER_PATH_IN_FILESYSTEM>
    # The path must exist, otherwise publish request will fail
    volumeHandle: dir/v1/podsFilesystem/my-dir
```
{% endcode %}

#### Persistent volume **parameters**

| **Parameter**           | **Description**                               | **Limitations**                                                                                                                                                                                       |
| ----------------------- | --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `spec.accessModes`      | The volume access mode                        | `ReadWriteMany`, `ReadWriteOnce`, or `ReadOnlyMany`                                                                                                                                                   |
| `spec.storageClassName` | The storage class to use to create the PV     | Must be an existing storage class                                                                                                                                                                     |
| `spec.capacity.storage` | A desired capacity for the volume             | The capacity quota is not enforced but is stored on the filesystem directory extended attributed for future use                                                                                       |
| `spec.csi.volumeHandle` | A string specifying a previously created path | <p>A string containing the volumeType (<code>dir/v1</code>) filesystem name, and the directory path. E.g. <code>dir/v1/podsFilesystem/my-dir</code></p><p>Must be an existing filesystem and path</p> |

Apply the PersistentVolume and check it has been created successfully:

```
# apply the pv .yaml file
$ kubectl apply -f pv-wekafs-dir-static.yaml
persistentvolume/pv-wekafs-dir-static created

# check the pv resource has been created
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                         STORAGECLASS                   REASON   AGE
pv-wekafs-dir-static                       1Gi        RWX            Retain           Available                                 storageclass-wekafs-dir                 3m33s
```

Now, bind a PVC to this specific PV, use the `volumeName` parameter under the PVC `spec` and provide it with the specific PV name.

#### Persistent volume claim for static provisioning example

{% code title="csi-wekafs/examples/static/pvc-wekafs-dir-static.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-wekafs-dir-static
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: storageclass-wekafs-dir
  volumeName: pv-wekafs-dir-static
  volumeMode: Filesystem
  resources:
    requests:
      storage: 1Gi
```
{% endcode %}

#### Persistent volume claim for static provisioning example

| **Parameter**                     | **Description**                              | **Limitations**                                                                                                 |
| --------------------------------- | -------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `spec.accessModes`                | The volume access mode                       | `ReadWriteMany`, `ReadWriteOnce`, or `ReadOnlyMany`                                                             |
| `spec.storageClassName`           | The storage class to use to create the PVC   | Must be the same storage class as the PV requested to bind in `spec.volumeName`                                 |
| `spec.resources.requests.storage` | A desired capacity for the volume            | The capacity quota is not enforced but is stored on the filesystem directory extended attributed for future use |
| `spec.volumeName`                 | A name of a pre-configured persistent volume | Must be an existing PV name                                                                                     |

Apply the PersistentVolumeClaim and check it has been created successfully:

```
# apply the pvc .yaml file
$ kubectl apply -f pvc-wekafs-dir-static.yaml
persistentvolumeclaim/pvc-wekafs-dir-static created

# check the pvc resource has been created
$ kubectl get pvc
NAME                    STATUS   VOLUME                CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
pvc-wekafs-dir-static   Bound    pv-wekafs-dir-static  1Gi        RWX            storageclass-wekafs-dir        3m41s
```

The PV will change the status to `Bound` and state the relevant claim it is bounded to:

```
# check the pv resource has been created
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                           STORAGECLASS                   REASON   AGE
pv-wekafs-dir-static                       1Gi        RWX            Retain           Bound       default/pvc-wekafs-dir-static   storageclass-wekafs-dir                 6m30s
```

### Launch an application using Weka as the POD's storage

Now that we have a storage class and a PVC in place, we can configure the Kubernetes pods to provision volumes via the Weka system.

We'll take an example application that echos the current timestamp every 10 seconds, and provide it with the previously created `pvc-wekafs-dir` PVC.

Note that multiple pods can share a volume produced by the same PVC as long as the `accessModes` parameter is set to `ReadWriteMany`.

{% code title="csi-wekafs/examples/dynamic/csi-app-on-dir.yaml" %}
```yaml
kind: Pod
apiVersion: v1
metadata:
  name: my-csi-app
spec:
  containers:
    - name: my-frontend
      image: busybox
      volumeMounts:
      - mountPath: "/data"
        name: my-csi-volume
      command: ["/bin/sh"]
      args: ["-c", "while true; do echo `date` >> /data/temp.txt; sleep 10;done"]
  volumes:
    - name: my-csi-volume
      persistentVolumeClaim:
        claimName: pvc-wekafs-dir # defined in pvc-wekafs-dir.yaml
```
{% endcode %}

Apply that pod:

```yaml
$ kubectl apply -f csi-app-on-dir.yaml
pod/my-csi-app created
```

Kubernetes will allocate a persistent volume and attach it to the pod, it will use a directory within the WekaFS filesystem as defined in the storage class mentioned in the persistent volume claim. The pod will be in `Running` status, and the `temp.txt` file will get updated with occasional `date` information.

```
$ kubectl get pod my-csi-app
NAME                      READY   STATUS              RESTARTS   AGE
my-csi-app                1/1     Running             0          85s

# if we go to a wekafs mount of this filesystem we can see a directory has been created
$ ls -l /mnt/weka/podsFilesystem/csi-volumes
drwxr-x--- 1 root root 0 Jul 19 12:18 pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380-a1659c8a7ded3c3c05d6facffd69cbf79b95604c

# inside that directory, the temp.txt file from the running pod can be found
 $ cat /mnt/weka/podsFilesystem/csi-volumes/pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380-a1659c8a7ded3c3c05d6facffd69cbf79b95604c/temp.txt
Sun Jul 19 12:50:25 IDT 2020
Sun Jul 19 12:50:35 IDT 2020
Sun Jul 19 12:50:45 IDT 2020
```

## SELinux support

When installing the Weka CSI Plugin on the SELinux-enabled Kubernetes cluster, pods might be denied access to the persistent volumes provisioned on top of the Weka filesystem. The reason is a lack of permissions for containers to access objects stored on the Weka cluster.

A custom SELinux policy is provided with all the necessary security configurations to enable pod access to WekaFS-based persistent volumes. Apply the customized SELinux policy on each Kubernetes worker node that is intended to serve the WekaFS-based persistent volumes.

The provided policy allows processes with `container_t` seclabel to access objects having a `wekafs_t` label, which is set for all files and directories of mounted CSI volumes.

The policy is provided both as a **Type Enforcement** file (`csi-wekafs.te`) and a **Precompiled Policy** package (`csi-wekafs.pp`), found in [https://github.com/weka/csi-wekafs/tree/master/selinux](https://github.com/weka/csi-wekafs/tree/master/selinux).

To use the Weka CSI Plugin with SELinux enforcement, perform the following:

1. [Install a custom SELinux policy](weka-csi-plugin.md#install-a-custom-selinux-policy)
2. [Install and configure the Weka CSI Plugin](weka-csi-plugin.md#install-and-configure-the-weka-csi-plugin)
3. [Test the Weka CSI Plugin operation](weka-csi-plugin.md#test-the-weka-csi-plugin-operation)

### Install a custom SELinux policy <a href="#install-a-custom-selink-p" id="install-a-custom-selink-p"></a>

1. Distribute the SELinux policy package to all Kubernetes nodes using one of the following options:
   *   Clone Weka CSI Plugin Github repository:

       ```
       git clone https://github.com/weka/csi-wekafs.git
       ```
   * Copy the content of `selinux` directory directly to Kubernetes nodes
2.  Apply the policy package directly:

    ```
    $ semodule -i csi-wekafs.pp
    ```

    Verify that the policy is applied correctly:

    ```
    $ getsebool -a | grep wekafs
    container_use_wekafs --> off
    ```

    If the output matches mentioned above, skip to step 4. Otherwise, proceed to step 3 to build the policy from the sources.
3.  In certain circumstances, the pre-compiled policy installation could fail. For example, in a different Kernel version or Linux distribution. In this case, build the policy and install it from the source using the following steps:

    ```
    $ checkmodule -M -m -o csi-wekafs.mod csi-wekafs.te
    $ semodule_package -o csi-wekafs.pp -m csi-wekafs.mod
    $ make -f /usr/share/selinux/devel/Makefile csi-wekafs.pp
    $ semodule -i csi-wekafs.pp
    ```

    > **NOTE**: For this purpose, the `policycoreutils-devel` package (or its alternative in case of Linux distribution different from the RedHat family) is required.

    Verify that the policy is applied correctly:

    ```
    $ getsebool -a | grep wekafs
    container_use_wekafs --> off
    ```
4.  The policy provides a boolean setting that allows on-demand enablement of relevant permissions. To enable WekaFS CSI volumes access from pods, run the command:

    ```
    $ setsebool container_use_wekafs=on
    ```

    To disable access, perform the command:

    ```
    $ setsebool container_use_wekafs=off
    ```

    The configuration changes are applied immediately.

### Install and configure the Weka CSI Plugin <a href="#install-config-csi-plugin" id="install-config-csi-plugin"></a>

1. To label volumes correctly, install the Weka CSI Plugin in an SELinux-compatible mode. To do that, set the `selinuxSupport` value to `"enforced"` or `"mixed”` by editing the file `values.yaml` or passing the parameter directly in the `helm` installation command.

Example:

```
$ helm install --upgrade csi-wekafsplugin csi-wekafs/csi-wekafsplugin --namespace csi-wekafsplugin --create-namespace --set selinuxSupport=enforced
```

Follow these considerations:

* Weka CSI pluging supports both the `enforced` and `mixed` modes of `selinuxSupport`. The installation depends on the following mode settings:
  * When `selinuxSupport` is set to `enforced`, only SELinux-enabled CSI plugin node components are installed.
  * When `selinuxSupport` is set to `mixed`, both non-SELinux and SELinux-enabled components are installed.
  * When `selinuxSupport` is set to `off`, only non-SELinux CSI plugin node components are installed.
*   The SELinux status cannot be known from within the CSI plugin pod. Therefore, a way of distinguishing between SELinux-enabled and non-SELinux nodes is required. Weka CSI plugin relies on the node affinity mechanism by matching the value of a certain node label, in a mutually exclusive way. That is, only when the label exists and is set to `"true"`, an SELinux-enabled node component will start on that node, otherwise non-SELinux node component will start.

    To ensure that the plugin starts in compatibility mode, set the following label on each SELinux-enabled Kubernetes node:&#x20;

```
csi.weka.io/selinux_enabled="true"
```

*   If another label stating SELinux support is already maintained on nodes, you can modify the expected label name in the `selinuxNodeLabel` parameter by editing the file `values.yaml` or by setting it directly during the Weka CSI Plugin installation.

    Example:

```
$ helm install --upgrade csi-wekafsplugin csi-wekafs/csi-wekafsplugin --namespace csi-wekafsplugin --create-namespace --set selinuxSupport=mixed --set selinuxNodeLabel="selinux_enabled"
```

* If a node label is modified after installing the Weka CSI Plugin node component on that node, terminate the csi-wekafs-node-XXXX component on the affected node. As a result, a replacement pod is automatically scheduled on the node but with the correct SELinux configuration.

### Test the Weka CSI plugin operation <a href="#test-csi-plugin" id="test-csi-plugin"></a>

1. Make sure you have configured a valid CSI API [`secret`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api/csi-wekafs-api-secret.yaml). Create a valid Weka CSI Plugin [`storageClass`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api).
2. Provision a [`PersistentVolumeClaim`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api/pvc-wekafs-dir-api.yaml).
3. Provision a [`DaemonSet`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api/csi-daemonset.app-on-dir-api.yaml), to enable access of all pods on all nodes.
4.  Monitor the pod logs using the following command (expect no printing in the log files):

    ```
    $ kubectl logs -f -lapp=csi-daemonset-app-on-dir-api
    ```

    If the command returns a repeating message like the following one, it is most likely that the node on which the relevant pod is running is misconfigured:

    ```
    /bin/sh: can't create /data/csi-wekafs-test-api-gldmk.txt: Permission denied
    ```
5.  Obtain the node name from the pod:

    ```
    $ kubectl get pod csi-wekafs-test-api-gldmk -o wide
    NAME                        READY   STATUS    RESTARTS   AGE   IP            NODE         NOMINATED NODE   READINESS GATES
    csi-wekafs-test-api-gldmk   1/1     Running   0          98m   10.244.15.2   don-kube-8   <none>           <none>
    ```
6.  Connect to the relevant node and check if the Weka CSI SELinux policy is installed and enabled:

    ```
    $ getsebool -a | grep wekafs
    container_use_wekafs --> on
    ```

    * If the result matches the example, proceed to the next step.
    * If no result, the policy is not installed. Perform the [Install a custom SELinux policy](weka-csi-plugin.md#install-a-custom-selinux-policy) procedure.
    *   If the policy is off, enable it and check the pod output again by running:

        ```
        $ setsebool container_use_wekafs=on
        ```
7.  Check if the node is labeled with plugin is operating in SELinux-compatible mode by running the following command:

    ```
    $ kubectl describe node don-kube-8 | grep csi.weka.io/selinux_enabled
                 csi.weka.io/selinux_enabled=true
    ```

    *   If the output is empty, proceed to [Install and configure the Weka CSI Plugin](weka-csi-plugin.md#install-and-configure-the-weka-csi-plugin).

        > **NOTE:** If the label was missing and added by you during troubleshooting, the CSI node server component must be restarted on the node.\
        > Perform the following command to terminate the relevant pod and another instance will start automatically:
        >
        > ```
        > $ POD=$(kubectl get pod -n csi-wekafs -lcomponent=csi-wekafs-node -o wide | grep -w don-kube-8 | cut -d" " -f1)
        > $ kubectl delete pod -n csi-wekafs $POD
        > ```
    * If the output matches example, proceed to next step
8.  Collect CSI node server logs from the matching Kubernetes nodes and contact Weka Customer Success Team:

    ```
    $ POD=$(kubectl get pod -n csi-wekafs -lcomponent=csi-wekafs-node -o wide | grep -w don-kube-8 | cut -d" " -f1)
    $ kubectl logs -n csi-wekafs -c wekafs $POD > log.txt  
    ```

## Upgrade legacy persistent volumes for capacity enforcement

### Bind legacy volumes to API

Capacity enforcement and integration with WekaFS directory quotas require several prerequisites:

1. Weka CSI plugin version **0.7.0** and up
2. WekaFS software version **v3.13.0** and up
3. Weka CSI plugin ability to communicate with WekaFS using REST API, and correlate between a certain persistent volume and the WekaFS cluster serving this volume.

In the [API-Based communication](weka-csi-plugin.md#api-based-communication-model) model, Kubernetes StorageClass refers to a secret that describes all the required parameters for API calls to the Weka cluster. However, this is not the situation in the [legacy communication model](weka-csi-plugin.md#legacy-communication-model), where the storage class doesn't specify the API credentials.&#x20;

Kubernetes does not allow modification of StorageClass parameters, hence every volume created with the legacy-model storage class will never report its credentials.

Weka CSI Plugin **0.7.0** provides a special configuration mode in which legacy volumes can be bound to a single secret, in turn referring to a single WekaFS cluster API connection parameters. In this configuration mode, every request to serve (create, delete, expand...) a legacy Persistent Volume (or Persistent Volume Claim) that originates from a Legacy Storage Class (without reference to an API secret) will be communicated to that cluster.

{% hint style="info" %}
**Note:** Volumes provisioned by the CSI Plugin of version **0.7.0** in the API-Based communication model, but on older versions of the Weka cluster (below version **3.13.0**), are still provisioned in legacy mode.

However, since the storage class already contains the secret reference, specifying the `legacyVolumeSecretName` parameter is unnecessary, and you can safely skip to the next chapter.
{% endhint %}

This configuration can be applied following these two steps:

1. Create a Kubernetes secret that describes the API communication parameters for legacy volumes.&#x20;
   1. The format of the secret is identical to the secret defined in the [API-Based Communication Model](weka-csi-plugin.md#api-based-communication-model) section
   2. This secret must be located in the same Kubernetes namespace of the Weka CSI Plugin
2.  Set the `legacyVolumeSecretName` parameter to match the name of secret above during plugin upgrade or installation

    This can be done by directly modifying the  `values.yaml` or by explicitly setting the parameter during the Helm upgrade:

```
helm upgrade csi-wekafs --namespace csi-wekafs csi-wekafs/csi-wekafsplugin \
 --set legacyVolumeSecretName="csi-wekafs-api-secret"

```

{% hint style="warning" %}
**Note:** The Kubernetes secret must be created before executing the helm upgrade. Otherwise, the CSI Plugin components will remain in a `Pending` state after the upgrade.
{% endhint %}

### Upgrade legacy volumes

Once the volume to API binding configuration described in the previous section is performed, the volumes may be migrated by binding a new WekaFS directory quota object to an existing persistent volume.&#x20;

Weka provides a migration script that automates the process.

{% hint style="info" %}
**Note:** This procedure must be performed only once, and can be performed from any Linux host that is connected to the same WekaFS cluster. **** Additional runs of the script will migrate only those volumes that were created in legacy mode after the migration process. It is safe to execute the migration script multiple times, although usually this should not be required.
{% endhint %}

{% hint style="info" %}
**Note**: The migration process might take significant time to complete and depends on a number of persistent volumes and their actual capacity. The migration process is performed transparently and does not require downtime.
{% endhint %}

Check out the `csi-wekafs` repository from any host that is connected to WekaFS cluster:

```
git clone https://github.com/weka/csi-wekafs.git
```

Execute the migration script by issuing the following command, where `<filesystem_name>` states the filesystem name on which the  CSI volumes are located, and optional `<csi_volumes_dir>` parameter states the directory inside the filesystem where CSI volumes are stored (only if the directory differs from default values)

```
$ sudo migration/migrate-legacy-csi-volumes.sh <filesystem_name> [--csi-volumes-dir <csi_volumes_dir>] [--endpoint-address BACKEND_IP_ADDRESS:BACKEND_PORT]
```

{% hint style="info" %}
**Note:** On a stateless client, the `--endpoint-address` must be specified in order to successfully mount a filesystem, while on a host which is part of the Weka cluster (either client or backend) this is not necessary.
{% endhint %}

{% hint style="info" %}
**Note:** If multiple filesystems are used, the script must be executed for each filesystem
{% endhint %}

For example:

```
$ ./migrate-legacy-csi-volumes.sh default
Weka CSI Volume migration utility. Copyright 2021 Weka
[2021-11-04 14:33:04] NOTICE     Initializing volume migration for filesystem default
[2021-11-04 14:33:04] NOTICE     Successfully mounted filesystem default
[2021-11-04 14:33:04] NOTICE     Starting Persistent Volume migration
[2021-11-04 14:33:04] INFO       Processing directory 'pvc-e5379b17-4612-4fa3-aa57-64d5b37d7f57-1025f14ca92d2e18dd92a05efadf15a4972675f0'
[2021-11-04 14:33:04] INFO       Creating quota of 1073741824 bytes for directory pvc-e5379b17-4612-4fa3-aa57-64d5b37d7f57-1025f14ca92d2e18dd92a05efadf15a4972675f0
[2021-11-04 14:33:05] INFO       Quota was successfully set for directory pvc-e5379b17-4612-4fa3-aa57-64d5b37d7f57-1025f14ca92d2e18dd92a05efadf15a4972675f0
[2021-11-04 14:33:05] NOTICE     Migration process complete!
[2021-11-04 14:33:05] NOTICE     1 directories migrated successfully
[2021-11-04 14:33:05] NOTICE     0 directories skipped
```

{% hint style="info" %}
**Note:** The migration script requires several dependencies, which must be installed in advance: `jq`, `xattr`, `getfattr`, `setfattr`

Refer to the specific OS package management documentation to install the necessary packages.
{% endhint %}

## Troubleshooting

### Useful commands

Here are some useful basic commands to check the status and debug the service:

```
# get all resources
kubectl get all --all-namespaces

# get all pods
kubectl get pods --all-namespaces -o wide

# get all k8s nodes
kubectl get nodes

# get storage classes
$ kubectl get sc

# get persistent volume claims 
$ kubectl get pvc

# get persistent volumes
$ kubectl get pv

# kubectl describe pod/<pod-name> -n <namespace> 
kubectl describe pod/csi-wekafsplugin-dvdh2 -n csi-wekafsplugin

# get logs from a pod
kubectl logs <pod name> <container name>

# get logs from the weka csi plugin
# container (-c) can be one of: [node-driver-registrar wekafs liveness-probe csi-provisioner csi-attacher csi-resizer]
kubectl logs pods/csi-wekafsplugin-<ID> --namespace csi-wekafsplugin -c wekafs
```

### Known issues

#### Mixed hugepages size issue

Due to a Kubernetes v1.18 issue with allocating mixed hugepages sizes ([https://github.com/kubernetes/kubernetes/pull/80831](https://github.com/kubernetes/kubernetes/pull/80831)) is required that the Weka system will not try to allocate mixed sizes of hugepages on the Kubernetes nodes.

To workaround the Kubernetes issue (required only if the default memory for the client has been increased):

* If the Weka client is installed on the K8s nodes via a manual stateless client mount, set the `reserve_1g_hugepages` mount option to `false` in the mount command.
* If this is a Weka server or a Weka client, which is part of the Weka cluster, contact the Weka customer support team.
