---
description: >-
  This page describes the Weka CSI Plugin prerequisites, capabilities,
  deployment, and usage.
---

# Weka CSI Plugin

## Overview

The [Container Storage Interface](https://github.com/container-storage-interface/spec/blob/master/spec.md) \(CSI\) is a standard for exposing arbitrary block and file storage systems to containerized workloads on Container Orchestration Systems \(COs\) like Kubernetes.

The Weka CSI Plugin provides the creation and configuration of persistent storage external to Kubernetes. CSI replaces plugins developed earlier in the Kubernetes evolution. It replaces the `hostPath` method to expose WekaFS mounts as Kubernetes volumes. 

### Interoperability

* CSI protocol: 1.0-1.2
* Kubernetes: 1.18
* OS \(of Kubernetes worker nodes\): ubuntu 16.04, 18.04
* WekaFS: 3.8 and up

{% hint style="info" %}
**Note:** For additional Kubernetes/OS versions support contact the Weka support team
{% endhint %}

### Prerequisites

* Privileged mode must be allowed on the Kubernetes cluster
* The following Kubernetes feature gates must be enabled: DevicePlugins, CSINodeInfo, CSIDriverRegistry, ExpandCSIVolumes \(if not changed, they should be enabled by default\)
* A Weka cluster is installed and accessible from the Kubernetes worker nodes
* The Weka client is installed on the Kubernetes worker nodes
  * It is recommended to use a [Weka client which is part of the cluster](../install/bare-metal/adding-clients-bare-metal.md#adding-clients-which-are-always-part-of-the-cluster) rather than a [stateless client](../install/bare-metal/adding-clients-bare-metal.md#adding-stateless-clients)
  * If the Kubernetes nodes are part of the Weka cluster \(converged mode on the Weka servers\), make sure the Weka processes come up before `kubelet`
* Filesystems are pre-configured on the Weka system

### Capabilities

#### Supported capabilities

* Static and dynamic volumes provisioning
* Mounting a volume as a WekaFS filesystem directory
* All volume access modes are supported: ReadWriteMany, ReadWriteOnce, and ReadOnlyMany
* Volume expansion

#### Unsupported capabilities

* Snapshots

## Deployment

The Weka CSI Plugin deployment is performed via a daemon set.

### Download

Download the Weka CSI Plugin from [GitHub](https://github.com/weka/csi-wekafs) to a master node in the Kubernetes cluster. 

```text
$ git clone https://github.com/weka/csi-wekafs.git
```

### Installation

From the downloaded location in the Kubernetes master node, run the following command to deploy the Weka CSI Plugin as a DeamonsSet:

```text
$ ./deploy/kubernetes-latest/deploy.sh
```

On successful deployment, you will see the following output:

```text
creating wekafsplugin namespace
namespace/csi-wekafsplugin created
deploying wekafs components
   ./deploy/kubernetes-latest/wekafs/csi-wekafs-plugin.yaml
        using           image: quay.io/k8scsi/csi-node-driver-registrar:v1.3.0
        using           image: quay.io/weka.io/csi-wekafs:v0.0.2-25-g7d18b61
        using           image: quay.io/k8scsi/livenessprobe:v1.1.0
        using           image: quay.io/k8scsi/csi-provisioner:v1.6.0
        using           image: quay.io/k8scsi/csi-attacher:v3.0.0-rc1
        using           image: quay.io/k8scsi/csi-resizer:v0.5.0
namespace/csi-wekafsplugin configured
csidriver.storage.k8s.io/wekafs.csi.k8s.io created
serviceaccount/csi-wekafsplugin created
clusterrole.rbac.authorization.k8s.io/csi-wekafsplugin-cluster-role created
clusterrolebinding.rbac.authorization.k8s.io/csi-wekafsplugin-cluster-role-binding created
role.rbac.authorization.k8s.io/csi-wekafsplugin-role created
rolebinding.rbac.authorization.k8s.io/csi-wekafsplugin-role-binding created
daemonset.apps/csi-wekafsplugin created
12:04:54 deployment completed successfully
12:04:54 2 plugin pods are running:
csi-wekafsplugin-dvdh2   6/6     Running   0          3h1m
csi-wekafsplugin-xh182   6/6     Running   0          3h1m
```

The number of running pods should be the same as the number of Kubernetes worker nodes. This can be inspected by running:

```text
$ kubectl get pods -n csi-wekafsplugin
NAME                     READY   STATUS    RESTARTS   AGE
csi-wekafsplugin-dvdh2   6/6     Running   0          3h2m
csi-wekafsplugin-xh182   6/6     Running   0          3h2m
```

## Provision Usage

The Weka CSI Plugin supports both dynamic \(persistent volume claim\) and static \(persistent volume\) volume provisioning.

It is first required to define a storage class to use the Weka CSI Plugin.

#### Storage Class Example

{% code title="csi-wekafs/examples/dir/storageclass-wekafs-dir.yaml" %}
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

#### **Storage Class Parameters**

| **Parameter** | Description | Limitation |
| :--- | :--- | :--- |
| `filesystemName` | The name of the Weka filesystem to create directories in as Kubernetes volumes  | The filesystem should exist in the Weka cluster |

Apply the StorageClass and check it has been created successfully:

```text
# apply the storageclass .yaml file
$ kubectl apply -f storageclass-wekafs-dir.yaml
storageclass.storage.k8s.io/storageclass-wekafs-dir created

# check the storageclass resource has been created
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-dir        csi.weka.io         Delete          Immediate           true                   75s
```

It is possible to define multiple storage classes with different filesystems.

### Dynamic Provisioning

Using a similar storage class to the above, it is possible to define a persistent volume claim \(PVC\) for the pods.

#### Persistent Volume Claim Example

{% code title="csi-wekafs/examples/dir/pvc-wekafs-dir.yaml" %}
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

#### Persistent Volume Claim **Parameters**

| **Parameter** | Description | Limitation |
| :--- | :--- | :--- |
| `spec.accessModes` | The volume access mode | `ReadWriteMany`, `ReadWriteOnce`, or `ReadOnlyMany` |
| `spec.storageClassName` | The storage class to use to create the PVC | Must be an existing storage class |
| `spec.resources.requests.storage` | A desired capacity for the volume | The capacity quota is not enforced but is stored on the filesystem directory extended attributed for future use |

Apply the PersistentVolumeClaim and check it has been created successfully:

```text
# apply the pvc .yaml file
$ kubectl apply -f pvc-wekafs-dir.yaml
persistentvolumeclaim/pvc-wekafs-dir created

# check the pvc resource has been created
$ kubectl get pvc
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
pvc-wekafs-dir        Bound    pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380   1Gi        RWX            storageclass-wekafs-dir        2m10s
```

### Static Provisioning

The Kubernetes admin can prepare some persistent volumes in advance to be used by pods.

#### Persistent Volume Example

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-wekafs-dir
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: storageclass-wekafs-dir
  volumeMode: Filesystem
  capacity:
    storage: 1Gi
  csi:
    driver: csi.weka.io
    volumeHandle: dir/v1/podsFilesystem/ad29bb9dc47fb2cbc34f2719f0bc7eb274d26394-my-dir
```

#### Persistent Volume **Parameters**

| **Parameter** | Description | Limitation |
| :--- | :--- | :--- |
| `spec.accessModes` | The volume access mode | `ReadWriteMany`, `ReadWriteOnce`, or `ReadOnlyMany` |
| `spec.storageClassName` | The storage class to use to create the PV | Must be an existing storage class |
| `spec.capacity.storage` | A desired capacity for the volume | The capacity quota is not enforced but is stored on the filesystem directory extended attributed for future use |
| `spec.csi.volumeHandle` | A string specifying a previously created volume  | A string containing the volumeType \(`dir/v1`\) filesystem name, lowercase SHA1 of the directory path, and the directory path. E.g. `dir/v1/default/ad29bb9dc47fb2cbc34f2719f0bc7eb274d26394-my-dir` note, this will work for volumes created by the CSI plugin or with a similar convention; usually, for a PV, it sufficient to use the easier configuration as described in [Provisioning of Volumes from a Pre-existing Directory](weka-csi-plugin.md#provisioning-of-volumes-from-a-pre-existing-directory) |

Apply the PersistentVolume and check it has been created successfully:

```text
# apply the pv .yaml file
$ kubectl apply -f pv-wekafs-dir.yaml
persistentvolume/pv-wekafs-dir created

# check the pv resource has been created
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                         STORAGECLASS                   REASON   AGE
pv-wekafs-dir                              1Gi        RWX            Retain           Available                                 storageclass-wekafs-dir                 3m33s
```

### **Provisioning of Volumes from a Pre-existing Directory** 

Many times, it is useful to use a pre-existing directory with pre-populated data in the POD. It can be a directory previously provisioned by the CSI or a pre-existing directory in WekaFS. To expose an existing directory in WekaFS via CSI, define a new storage class, a persistent volume, and link a persistent volume claim to this persistent volume.

#### Storage Class Example

{% code title="csi-wekafs/examples/path/storageclass-wekafs-path.yaml" %}
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storageclass-wekafs-path
provisioner: csi.weka.io
reclaimPolicy: Retain
volumeBindingMode: Immediate
allowVolumeExpansion: true
parameters:
  volumeType: path/v1
  allowNonExistentPath: "false"
```
{% endcode %}

Apply the StorageClass and check it has been created successfully:

```text
# apply the storageclass .yaml file
$ kubectl apply -f storageclass-wekafs-path.yaml
storageclass.storage.k8s.io/storageclass-wekafs-path created

# check the storageclass resource has been created
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-path       csi.weka.io         Retain          Immediate           true                   93s
```

#### Persistent Volume Example

{% code title="csi-wekafs/examples/path/pv-wekafs-path.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-wekafs-path
spec:
  storageClassName: storageclass-wekafs-path
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
  capacity:
    storage: 1Gi
  csi:
    driver: csi.weka.io
    volumeHandle: path/v1/podsFilesystem/my-dir
```
{% endcode %}

#### Persistent Volume **Parameters**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Parameter</b>
      </th>
      <th style="text-align:left">Description</th>
      <th style="text-align:left">Limitation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>spec.accessModes</code>
      </td>
      <td style="text-align:left">The volume access mode</td>
      <td style="text-align:left"><code>ReadWriteMany</code>, <code>ReadWriteOnce</code>, or <code>ReadOnlyMany</code>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>spec.storageClassName</code>
      </td>
      <td style="text-align:left">The storage class to use to create the PV</td>
      <td style="text-align:left">Must be an existing storage class</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>spec.capacity.storage</code>
      </td>
      <td style="text-align:left">A desired capacity for the volume</td>
      <td style="text-align:left">The capacity quota is not enforced but is stored on the filesystem directory
        extended attributed for future use</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>spec.csi.volumeHandle</code>
      </td>
      <td style="text-align:left">A string specifying a previously created path</td>
      <td style="text-align:left">
        <p>A string containing the volumeType (<code>path/v1</code>) filesystem name,
          and the directory path. E.g. <code>path/v1/podsFilesystem/my-dir</code> 
        </p>
        <p>Must be an existing filesystem and path</p>
      </td>
    </tr>
  </tbody>
</table>

Apply the PersistentVolume and check it has been created successfully:

```text
# apply the pv .yaml file
$ kubectl apply -f pv-wekafs-path.yaml
persistentvolume/pv-wekafs-path created

# check the pv resource has been created
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                         STORAGECLASS                   REASON   AGE
pv-wekafs-path                             1Gi        RWX            Retain           Available                                 storageclass-wekafs-path                4m24s
```

Now,  bind a PVC to this specific PV, use the volumeName parameter under the PVC spec and provide it with the specific PV name.

#### Persistent Volume Claim Example

{% code title="csi-wekafs/examples/path/pvc-wekafs-path.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-wekafs-path
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: storageclass-wekafs-path
  volumeName: pv-wekafs-path
  volumeMode: Filesystem
  resources:
    requests:
      storage: 1Gi
```
{% endcode %}

#### Persistent Volume Claim **Parameters**

| **Parameter** | Description | Limitation |
| :--- | :--- | :--- |
| `spec.accessModes` | The volume access mode | `ReadWriteMany`, `ReadWriteOnce`, or `ReadOnlyMany` |
| `spec.storageClassName` | The storage class to use to create the PVC | Must be an existing storage class |
| `spec.resources.requests.storage` | A desired capacity for the volume | The capacity quota is not enforced but is stored on the filesystem directory extended attributed for future use |
| `spec.volumeName` | A name of a pre-configured persistent volume  | Must be an existing PV name |

Apply the PersistentVolumeClaim and check it has been created successfully:

```text
# apply the pvc .yaml file
$ kubectl apply -f pvc-wekafs-path.yaml
persistentvolumeclaim/pvc-wekafs-path created

# check the pvc resource has been created
$ kubectl get pvc
NAME                  STATUS   VOLUME             CAPACITY   ACCESS MODES   STORAGECLASS                   AGE
pvc-wekafs-path       Bound    pv-wekafs-path     1Gi        RWX            storageclass-wekafs-dir        3m41s
```

The PV will change the status to `Bound` and state the relevant claim it is bounded to:

```text
# check the pv resource has been created
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                         STORAGECLASS                   REASON   AGE
pv-wekafs-path                             1Gi        RWX            Retain           Bound       default/pvc-wekafs-path       storageclass-wekafs-path                6m30s
```

### Launching an Application using Weka as the POD's Storage

Now that we have a storage class and a PVC \(or PV\) in place, we can configure the Kubernetes pods to provision volumes via the Weka system.

We'll take an example application echos the current timestamp every 10 seconds, and provide it with the previously created `pvc-wekafs-dir`  PVC. 

Note that multiple pods can share a volume produced by the same PVC as long as the `accessModes` parameter is set to `ReadWriteMany`.

{% code title="csi-app-on-dir.yaml" %}
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

Now we will apply that pod:

```yaml
$ kubectl apply -f csi-app-on-dir.yaml
pod/my-csi-app created
```

Kubernetes will allocate a  persistent volume and attach it to the pod, it will use a directory within the WekaFS filesystem as defined in the storage class mentioned in the persistent volume claim. The pod will be in `Running` status, and the `temp.txt` file will get updated with occasional `date` information.

```text
$ kubectl get pod my-csi-app
NAME                      READY   STATUS              RESTARTS   AGE
my-csi-app                1/1     Running             0          85s

# if we go to a wekafs mount of this filesystem we can see a directory has been created
$ ls -l /mnt/weka/podsFilesystem/
drwxr-x--- 1 root root 0 Jul 19 12:18 a1659c8a7ded3c3c05d6facffd69cbf79b95604c-pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380

# inside that directory, the temp.txt file from the running pod can be found
 $ cat /mnt/weka/podsFilesystem/a1659c8a7ded3c3c05d6facffd69cbf79b95604c-pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380/temp.txt
Sun Jul 19 12:50:25 IDT 2020
```

## Troubleshooting

### Useful Commands

Here are some useful basic commands to check the status and debug the service:

```text
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

### Known Issues

#### Mixed Hugepages Size Issue

Due to a Kubernetes v1.18 issue with allocating mixed hugepages sizes \([https://github.com/kubernetes/kubernetes/pull/80831](https://github.com/kubernetes/kubernetes/pull/80831)\) is required that the Weka system will not try to allocate mixed sizes of hugepages on the Kubernetes nodes.

To workaround the Kubernetes issue:

* If the Weka client is installed on the K8s nodes via a manual stateless client mount, set the `reserve_1g_hugepages` mount option to `false` in the mount command.
* If this is a Weka server or a Weka client, which is part of the Weka cluster, contact the Weka customer support team.

