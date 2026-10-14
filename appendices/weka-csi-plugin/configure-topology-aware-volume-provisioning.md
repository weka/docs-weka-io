---
description: >-
  Learn how to use the Kubernetes Container Storage Interface (CSI) topology
  feature to control where volumes are provisioned based on availability zones.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/appendices/weka-csi-plugin/configure-topology-aware-volume-provisioning
---

# Configure topology-aware volume provisioning

In multi-zone cloud environments, this feature enhances fault tolerance and performance by limiting volume access to specific nodes within a designated region or zone. Topology-aware provisioning uses the `waitForFirstConsumer` volume binding mode, which delays volume creation until Kubernetes schedules the workload. This ensures the volume is provisioned in the correct location relative to the pod that consumes it.

#### Prerequisites

* Kubernetes v1.17 or a later version.
* Topology labels on Kubernetes nodes. Most Kubernetes distributions create these labels by default during installation.
* WEKA Operator v1.7.0 or a later version.

#### 1. Confirm topology labels on Kubernetes nodes

Verify that your Kubernetes nodes have the required topology labels. The following command checks for `topology.kubernetes.io/region` and `topology.kubernetes.io/zone` labels on all nodes in the cluster.

```bash
$ kubectl get nodes -Ltopology.kubernetes.io/region -Ltopology.kubernetes.io/zone
```

Example output

```bash
NAME             STATUS   ROLES                       AGE   VERSION        REGION      ZONE
54.160.132.190   Ready    control-plane,etcd,master   46m   v1.33.4+k3s1   us-east-1   us-east-1a
54.161.26.50     Ready    worker                      45m   v1.33.4+k3s1   us-east-1   us-east-1b
54.162.121.142   Ready    worker                      45m   v1.33.4+k3s1   us-east-1   us-east-1b
54.167.56.31     Ready    control-plane,etcd,master   46m   v1.33.4+k3s1   us-east-1   us-east-1a
54.235.34.153    Ready    worker                      45m   v1.33.4+k3s1   us-east-1   us-east-1b
54.89.113.136    Ready    control-plane,etcd,master   46m   v1.33.4+k3s1   us-east-1   us-east-1a
```

In this example, the cluster has six nodes distributed across two availability zones: `us-east-1a` and `us-east-1b`.

#### 2. Create a StorageClass with WaitForFirstConsumer

A StorageClass `volumeBindingMode` can be set to `Immediate` or `WaitForFirstConsumer`. For topology-aware provisioning, you must use `WaitForFirstConsumer` to delay volume creation until the consuming workload is scheduled.

{% hint style="info" %}
For more advanced control, you can add the `allowedTopologies` parameter to the `StorageClass` manifest. This parameter restricts volume provisioning to a specific list of zones, ensuring that volumes are only created in those predefined locations.
{% endhint %}

The following manifest defines a StorageClass named `weka-topology-aware` with the correct binding mode.

```bash
$ cat sc.yaml

allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: weka-topology-aware
parameters:
  capacityEnforcement: HARD
  csi.storage.k8s.io/controller-expand-secret-name: weka-csi-cluster
  csi.storage.k8s.io/controller-expand-secret-namespace: weka
  csi.storage.k8s.io/controller-publish-secret-name: weka-csi-cluster
  csi.storage.k8s.io/controller-publish-secret-namespace: weka
  csi.storage.k8s.io/node-publish-secret-name: weka-csi-cluster
  csi.storage.k8s.io/node-publish-secret-namespace: weka
  csi.storage.k8s.io/node-stage-secret-name: weka-csi-cluster
  csi.storage.k8s.io/node-stage-secret-namespace: weka
  csi.storage.k8s.io/provisioner-secret-name: weka-csi-cluster
  csi.storage.k8s.io/provisioner-secret-namespace: weka
  filesystemName: default
  volumeType: dir/v1
provisioner: csi.weka.io
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

Create the StorageClass.

```bash
$ kubectl create -f sc.yaml

storageclass.storage.k8s.io/weka-topology-aware created
```

#### 3. Create a PersistentVolumeClaim (PVC)

To demonstrate the delayed binding, create a PVC without a corresponding workload.

```yaml
$ cat pvc.yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
  name: weka-pvc
  namespace: weka
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
  storageClassName: weka-topology-aware
  volumeMode: Filesystem
```

Create the PVC.

```bash
$ kubectl create -f pvc.yaml

persistentvolumeclaim/weka-pvc created
```

Examine the PVC status.

```bash
$ kubectl get pvc -n weka

NAME       STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS          VOLUMEATTRIBUTESCLASS   AGE
weka-pvc   Pending                                      weka-topology-aware   <unset>                 5s
```

Observe that the PVC status is `Pending`. The `persistentvolume-controller` waits for a workload to consume the PVC before provisioning and binding the volume.

Example description of the pending PVC

```bash
$ kubectl describe pvc -n weka

Name:          weka-pvc
Namespace:     weka
StorageClass:  weka-topology-aware
Status:        Pending
...
Events:
  Type    Reason                Age   From                         Message
  ----    ------                ----  ----                         -------
  Normal  WaitForFirstConsumer  12s   persistentvolume-controller  waiting for first consumer to be created before binding
```

***

#### 4. Define and create a workload

To trigger volume provisioning, define a workload that consumes the PVC. The following Pod manifest uses `spec.affinity` to specify its preferred deployment location, ensuring it is scheduled in the correct zone.

```yaml
$ cat pod.yaml

apiVersion: v1
kind: Pod
metadata:
  name: busybox-weka
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: topology.kubernetes.io/region
            operator: In
            values:
            - us-east-1
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: topology.kubernetes.io/zone
            operator: In
            values:
            - us-east-1a
            - us-east-1b
  volumes:
  - name: vol1
    persistentVolumeClaim:
      claimName: weka-pvc
  containers:
  - name: busybox
    image: busybox
    command: [ "sh", "-c", "sleep 1h" ]
    volumeMounts:
    - name: vol1
      mountPath: /data/demo
```

Create the Pod and then check the status of both the Pod and the PVC.

```bash
$ kubectl create -f pod.yaml -n weka
pod/busybox-weka created

$ kubectl get pod,pvc -n weka -o wide
NAME               READY   STATUS    RESTARTS   AGE   IP          NODE            NOMINATED NODE   READINESS GATES
pod/busybox-weka   1/1     Running   0          18s   10.32.1.9   54.89.113.136   <none>           <none>

NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS          VOLUMEATTRIBUTESCLASS   AGE   VOLUMEMODE
persistentvolumeclaim/weka-pvc   Bound    pvc-1c6fa6b1-e561-4d98-a127-2bbbb9352b87   5Gi        RWX            weka-topology-aware   <unset>                 14m   Filesystem
```

After the Pod is scheduled and running, the PVC status changes to `Bound`, indicating that the volume has been provisioned and is accessible to the Pod.
