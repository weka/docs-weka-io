---
description: >-
  Learn how to create point-in-time snapshots of WEKA Kubernetes volumes using
  the CSI snapshot capability.
---

# Create a Volume Snapshot

Create point-in-time, application-consistent snapshots of WEKA persistent volumes using the Container Storage Interface (CSI) snapshot capability. Snapshots enable zero-copy cloning and rapid rollbacks without downtime.

For example manifests of dynamic snapshot, see the [csi-wekafs repository](https://github.com/weka/csi-wekafs/tree/main/examples/dynamic_snapshot).

{% hint style="info" %}
Snapshot functionality is not available for Directory-backed volumes by default. A snapshot of a Directory-backed volume creates a snapshot of the entire filesystem on which the directory resides.
{% endhint %}

### Procedure overview

<table><thead><tr><th width="88">Step</th><th width="345">Action</th><th>Responsibility</th></tr></thead><tbody><tr><td>1</td><td>Confirm the snapshot controller is running</td><td>Kubernetes orchestrator (Kubeadm, GKE, OpenShift)</td></tr><tr><td>2</td><td>Confirm snapshot CRDs exist</td><td>Kubernetes orchestrator (Kubeadm, GKE, OpenShift)</td></tr><tr><td>3</td><td>Create a VolumeSnapshotClass</td><td>WEKA admin</td></tr><tr><td>4</td><td>Provision a volume and workload</td><td>WEKA admin</td></tr><tr><td>5</td><td>Create a snapshot</td><td>WEKA admin</td></tr><tr><td>6</td><td>Create a new volume from the snapshot</td><td>WEKA admin</td></tr></tbody></table>

### Before you begin

Confirm the following prerequisites are in place:

* Kubernetes v1.20 or newer.
* [CSI external-snapshot controller](https://github.com/kubernetes-csi/external-snapshotter/tree/master) and [Volume snapshot Custom Resource Definitions (CRDs)](https://github.com/kubernetes-csi/external-snapshotter/tree/master/client/config/crd) are deployed on the Kubernetes cluster. Your Kubernetes orchestrator manages these components.
* A StorageClass for a Filesystem-backed volume or a Snapshot-backed volume. For sample manifests, see [Filesystem-backed storageClass](https://github.com/weka/csi-wekafs/blob/main/examples/dynamic_filesystem/storageclass-wekafs-fs-api.yaml) and [Snapshot-backed storageClass](https://github.com/weka/csi-wekafs/blob/main/examples/dynamic_snapshot/storageclass-wekafs-snap-api.yaml).

### Procedure

#### 1. Confirm the snapshot controller is running

Verify that at least one `snapshot-controller` deployment is in `Running` state. It is typically deployed in the `kube-system` or `csi-snapshotter` namespace.

```bash
kubectl get pods -n kube-system -l app.kubernetes.io/name=snapshot-controller
```

Example output:

```bash
NAME                                   READY   STATUS    RESTARTS   AGE
snapshot-controller-7bc747dd4d-kcflb   1/1     Running   0          119s
snapshot-controller-7bc747dd4d-xwnfp   1/1     Running   0          119s
```

If the command returns no results, deploy the external snapshot controller. For instructions, see [external-snapshotter usage](https://github.com/kubernetes-csi/external-snapshotter/tree/master#usage).

#### 2. Confirm snapshot CRDs exist

Verify that the required volume snapshot CRDs exist in your Kubernetes cluster.

```bash
kubectl get crd | grep volumesnapshot
```

Example output:

```bash
volumesnapshotclasses.snapshot.storage.k8s.io              2026-05-28T17:17:47Z
volumesnapshotcontents.snapshot.storage.k8s.io             2026-05-28T17:17:47Z
volumesnapshots.snapshot.storage.k8s.io                    2026-05-28T17:17:47Z
```

If the command returns no results, create the CRDs. For instructions, see [external-snapshotter usage](https://github.com/kubernetes-csi/external-snapshotter/tree/master#usage).

#### 3. Create a VolumeSnapshotClass

A VolumeSnapshotClass is required before you can create snapshots.

1.  Check whether a WEKA VolumeSnapshotClass already exists:

    ```bash
    kubectl get volumesnapshotclasses
    ```
2.  If no resources are found, create one using the following manifest. For a ready-made example, see [snapshotclass-csi-wekafs.yaml](https://github.com/weka/csi-wekafs/blob/main/examples/common/snapshotclass-csi-wekafs.yaml).

    <pre class="language-yaml" data-title="volumesnapshotclass.yaml"><code class="lang-yaml">apiVersion: snapshot.storage.k8s.io/v1
    kind: VolumeSnapshotClass
    metadata:
      name: weka
    driver: csi.weka.io
    deletionPolicy: Delete
    parameters:
      csi.storage.k8s.io/snapshotter-secret-name: weka-csi-cluster-dev
      csi.storage.k8s.io/snapshotter-secret-namespace: weka-operator-system
    </code></pre>
3.  Apply the manifest:

    ```bash
    kubectl apply -f vsc.yaml
    ```

    Example output:

    ```bash
    volumesnapshotclass.snapshot.storage.k8s.io/weka created
    ```

#### 4. Provision a volume and workload

Create a filesystem-backed persistent volume and write data to it.

1.  Apply the following manifest to create a Pod that writes a timestamp to the volume every 10 seconds:

    <pre class="language-yaml" data-title="timestamp-app.yaml"><code class="lang-yaml">kind: Pod
    apiVersion: v1
    metadata:
      name: timestamp-app
    spec:
      containers:
        - name: frontend
          image: busybox
          volumeMounts:
          - mountPath: "/data"
            name: weka-volume
          command: ["/bin/sh"]
          args: ["-c", "while true; do echo The time is `date` >> /data/temp.txt; sleep 10;done"]
      volumes:
        - name: weka-volume
          persistentVolumeClaim:
            claimName: pvc-weka-fs
    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: pvc-weka-fs
    spec:
      accessModes:
        - ReadWriteMany
      storageClassName: storageclass-wekafs-fs-api
      volumeMode: Filesystem
      resources:
        requests:
          storage: 1Gi
    </code></pre>

    ```bash
    kubectl apply -f timestamp-app.yaml
    ```
2.  Confirm that the Pod is writing data to the volume:

    ```bash
    kubectl exec timestamp-app -- /bin/sh "-c" "cat /data/temp.txt"
    ```

    Example output:

    ```bash
    The time is Fri May 29 16:25:34 UTC 2026
    The time is Fri May 29 16:26:34 UTC 2026
    ```

#### 5. Create a snapshot

Create a VolumeSnapshot for the persistent volume claim.

1.  Apply the following manifest:

    <pre class="language-yaml" data-title="snapshot.yaml"><code class="lang-yaml">apiVersion: snapshot.storage.k8s.io/v1
    kind: VolumeSnapshot
    metadata:
      name: snapshot-pvc-weka-fs
    spec:
      volumeSnapshotClassName: weka        # Set to the name of the VolumeSnapshotClass created in step 3
      source:
        persistentVolumeClaimName: pvc-weka-fs   # Set to the name of the PVC created in step 4
    </code></pre>

    ```bash
    kubectl apply -f snapshot.yaml
    ```
2.  Confirm the snapshot is available and ready to use:

    ```bash
    kubectl get volumesnapshot
    ```

    Example output:

    ```bash
    NAME                   READYTOUSE   SOURCEPVC     SOURCESNAPSHOTCONTENT   RESTORESIZE   SNAPSHOTCLASS   SNAPSHOTCONTENT                                    CREATIONTIME   AGE
    snapshot-pvc-weka-fs   true         pvc-weka-fs                                         weka            snapcontent-9c5c6887-9660-42b6-a425-700a938580ab   7s             10s
    ```

#### 6. Create a new volume from the snapshot

Restore data from the snapshot by provisioning a new persistent volume with the snapshot as its data source.

1.  Apply the following manifest:

    <pre class="language-yaml" data-title="volume-from-snapshot.yaml"><code class="lang-yaml">kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: pvc-weka-fs-from-snap
    spec:
      accessModes:
        - ReadWriteMany
      storageClassName: storageclass-wekafs-fs-api
      volumeMode: Filesystem
      resources:
        requests:
          storage: 1Gi
      dataSource:
        kind: VolumeSnapshot
        name: snapshot-pvc-weka-fs
        apiGroup: snapshot.storage.k8s.io
    </code></pre>

    <pre class="language-bash"><code class="lang-bash"><strong>kubectl create -f volume-from-snapshot.yaml
    </strong></code></pre>
2.  Attach a Pod to the new volume:

    <pre class="language-yaml" data-title="pod-read-from-new-volume.yaml"><code class="lang-yaml">kind: Pod
    apiVersion: v1
    metadata:
      name: read-from-snap-vol
    spec:
      containers:
        - name: frontend
          image: busybox
          volumeMounts:
          - mountPath: "/data"
            name: weka-volume
          command: ["/bin/sh"]
          args: ["-c", "while true; sleep 60; done"]
      volumes:
        - name: weka-volume
          persistentVolumeClaim:
            claimName: pvc-weka-fs-from-snap
    </code></pre>

    ```bash
    kubectl create -f pod-read-from-new-volume.yaml
    ```
3.  Confirm the new volume contains the data captured at snapshot time:

    ```bash
    kubectl exec read-from-snap-vol -- /bin/sh "-c" "cat /data/temp.txt"
    ```

    Example output:

    ```bash
    The time is Fri May 29 16:25:34 UTC 2026
    The time is Fri May 29 16:26:34 UTC 2026
    ```

    The source volume contains additional entries written after the snapshot was taken:

    ```bash
    kubectl exec timestamp-app -- /bin/sh "-c" "cat /data/temp.txt"
    ```

    Example output:

    ```bash
    The time is Fri May 29 16:25:34 UTC 2026
    The time is Fri May 29 16:26:34 UTC 2026
    The time is Fri May 29 16:27:34 UTC 2026
    The time is Fri May 29 16:28:34 UTC 2026
    The time is Fri May 29 16:29:34 UTC 2026
    The time is Fri May 29 16:30:34 UTC 2026
    The time is Fri May 29 16:31:34 UTC 2026
    ```
