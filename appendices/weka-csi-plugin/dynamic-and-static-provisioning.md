---
description: Provision WEKA storage dynamically or statically with the CSI Plugin.
---

# Dynamic and static provisioning

The section provides some examples of dynamic and static provisioning. For more examples, see [https://github.com/weka/csi-wekafs/tree/main/examples](https://github.com/weka/csi-wekafs/tree/main/examples).

## Dynamic provisioning

Dynamic provisioning means defining a persistent volume claim (PVC) for the pods using a storage class similar to the storage class described in the [Storage class configuration](storage-class-configurations.md) section.

**Procedure**

1. Create a PVC yaml file (see the following example).

<details>

<summary>Example: pvc-wekafs-dir.yaml</summary>

{% code title="csi-wekafs/examples/dynamic/pvc-wekafs-dir.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-wekafs-dir
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: storageclass-wekafs-dir-api
  volumeMode: Filesystem
  resources:
    requests:
      storage: 1Gi
```
{% endcode %}

</details>

2. Apply the PVC yaml file and validate it is created successfully.

<details>

<summary>Apply the pvc .yaml file</summary>

```
# apply the pvc .yaml file
$ kubectl apply -f pvc-wekafs-dir.yaml
persistentvolumeclaim/pvc-wekafs-dir created

# check the pvc resource has been created
$ kubectl get pvc
NAME                  STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                       AGE
pvc-wekafs-dir        Bound    pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380   1Gi        RWX            storageclass-wekafs-dir-api        2m10s
```

</details>

#### Persistent volume claim **parameters**

| Parameter                         | Description                                                                                                                                               |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `spec.accessModes`                | The volume access mode.Possible values: `ReadWriteMany`, `ReadWriteOnce`, `ReadOnlyMany`                                                                  |
| `spec.storageClassName`           | The storage class to use to create the PVC.The storage class must exist.                                                                                  |
| `spec.resources.requests.storage` | The required capacity for the volume.The capacity quota is not enforced but is stored on the filesystem directory extended and attributed for future use. |

The directory is created in the filesystem under the `csi-volumes` directory starting with the volume name.

## Static provisioning

The Kubernetes admin can prepare persistent volumes in advance to be used by pods. The persistent volume must be an existing directory, and can contain pre-populated data used by the PODs.

The persistent volume can be a directory previously provisioned by the CSI or a an existing directory in the WEKA filesystem.

To expose an existing directory in the WEKA filesystem through the CSI, define a persistent volume, and bind the persistent volume claim to this persistent volume.

{% hint style="info" %}
You can use a storage class from dynamic provisioning for static provisioning. In static provisioning, the `volumeHandle` in the PV determines the `filesystemName`, `filesystemGroupName`, and `volumeType`, overriding any values set in the storage class. The `storageClassName` must be identical in both the PV and the PVC.
{% endhint %}

**Procedure**

1. Create a PV yaml file (see the following example).

<details>

<summary>Example: PV YAML file</summary>

{% code title="examples/static_volume/static_filesystem/pv-wekafs-fs-static-api.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-wekafs-fs-static-api
spec:
  storageClassName: storageclass-wekafs-fs-static-api
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
  capacity:
    storage: 1Gi
  csi:
    driver: csi.weka.io
    # volumeHandle must be formatted as follows:
    # dir/v1/<FILE_SYSTEM_NAME>/<INNER_PATH_IN_FILESYSTEM>
    # The path must exist, otherwise the publish request fails
    volumeHandle: dir/v1/testfs/testdir
    nodePublishSecretRef:
      name: csi-wekafs-api-secret
      namespace: csi-wekafs
    controllerExpandSecretRef:
      name: csi-wekafs-api-secret
      namespace: csi-wekafs
```
{% endcode %}

</details>

2. Apply the PV YAML file.

<details>

<summary>Apply the PV YAML file</summary>

```bash
# Apply the PV YAML file.
$ kubectl apply -f examples/static_volume/static_filesystem/pv-wekafs-fs-static-api.yaml
persistentvolume/pv-wekafs-fs-static-api created
```

</details>

#### Persistent volume **parameters**

<table><thead><tr><th width="227.33333333333331">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>spec.accessModes</code></td><td>The volume access mode.<br>Possible values: <code>ReadWriteMany</code>, <code>ReadWriteOnce</code>, <code>ReadOnlyMany</code></td></tr><tr><td><code>spec.storageClassName</code></td><td>The storage class to use to create the PV.<br>The storage class must exist.</td></tr><tr><td><code>spec.capacity.storage</code></td><td>A required capacity for the volume.<br>The capacity quota is not enforced but is stored on the filesystem directory extended and attributed for future use.</td></tr><tr><td><code>spec.csi.volumeHandle</code></td><td><p>The path previously created.<br>A string containing the <code>volumeType</code> (<code>dir/v1</code>) filesystem name, and the directory path.<br>Example: <code>dir/v1/podsFilesystem/my-dir</code></p><p>The filesystem and path must exist in the WEKA cluster.</p></td></tr></tbody></table>

3. Create a PVC that binds to the PV. Set `spec.volumeName` to the PV name.

<details>

<summary>Example: persistent volume claim for static provisioning</summary>

{% code title="examples/static_volume/static_filesystem/pvc-wekafs-fs-static-api.yaml" %}
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-wekafs-fs-static-api
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: storageclass-wekafs-fs-static-api
  volumeName: pv-wekafs-fs-static-api
  volumeMode: Filesystem
  resources:
    requests:
      storage: 1Gi
```
{% endcode %}

</details>

#### Persistent volume claim for static provisioning

| Parameter                         | Description                                                                                                                                               |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `spec.accessModes`                | The volume access mode.Possible values: `ReadWriteMany`, `ReadWriteOnce`, `ReadOnlyMany`                                                                  |
| `spec.storageClassName`           | The storage class to use to create the PVC.It must be the same storage class as the PV requested to bind in `spec.volumeName`.                            |
| `spec.resources.requests.storage` | The required capacity for the volume.The capacity quota is not enforced but is stored on the filesystem directory extended and attributed for future use. |
| `spec.volumeName`                 | The name of a pre-configured persistent volume.The persistent volume name must exist.                                                                     |

4. Apply the PVC YAML file.

<details>

<summary>Apply the PVC YAML file</summary>

```bash
# Apply the PVC YAML file.
$ kubectl apply -f examples/static_volume/static_filesystem/pvc-wekafs-fs-static-api.yaml
persistentvolumeclaim/pvc-wekafs-fs-static-api created
```

</details>

5. Validate that the PVC binds to the PV.

<details>

<summary>Validate the PVC binding</summary>

```bash
# Check that the PVC binds to the PV.
$ kubectl get pvc
NAME                         STATUS   VOLUME                     CAPACITY   ACCESS MODES   STORAGECLASS                              AGE
pvc-wekafs-fs-static-api     Bound    pv-wekafs-fs-static-api    1Gi        RWX            storageclass-wekafs-fs-static-api         6m30s

# Check that the PV binds to the PVC.
$ kubectl get pv
NAME                      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                  STORAGECLASS                              REASON   AGE
pv-wekafs-fs-static-api   1Gi        RWX            Retain           Bound    default/pvc-wekafs-fs-static-api      storageclass-wekafs-fs-static-api                  6m30s
```

</details>
