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

<table><thead><tr><th width="288">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>spec.accessModes</code></td><td>The volume access mode.<br>Possible values: <code>ReadWriteMany</code>, <code>ReadWriteOnce</code>, <code>ReadOnlyMany</code></td></tr><tr><td><code>spec.storageClassName</code></td><td>The storage class to use to create the PVC.<br>The storage class must exist.</td></tr><tr><td><code>spec.resources.requests.storage</code></td><td>The required capacity for the volume.<br>The capacity quota is not enforced but is stored on the filesystem directory extended and attributed for future use.</td></tr></tbody></table>

The directory is created in the filesystem under the `csi-volumes` directory starting with the volume name.

## Static provisioning

The Kubernetes admin can prepare persistent volumes in advance to be used by pods. The persistent volume must be an existing directory, and can contain pre-populated data used by the PODs.

The persistent volume can be a directory previously provisioned by the CSI or a an existing directory in the WEKA filesystem.

To expose an existing directory in the WEKA filesystem through the CSI, define a persistent volume, and bind the persistent volume claim to this persistent volume.

{% hint style="info" %}
You can use an existing storage class from dynamic provisioning for static provisioning. However, the Persistent Volume parameters (`filesystemName`, `filesystemGroupName`, and `volumeType`) will override those in the storage class.
{% endhint %}

**Procedure**

1. Create a static filesystem-backed persistent volume (PV) YAML file.

<details>

<summary>Example: pv-wekafs-fs-static-api.yaml</summary>

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
    # volumeHandle must be formatted as following:
    # dir/v1/<FILE_SYSTEM_NAME>/<INNER_PATH_IN_FILESYSTEM>
    # The path must exist, otherwise publish request will fail
    volumeHandle: dir/v1/podsFilesystem/my-dir
```
{% endcode %}

</details>

2. Apply the PV YAML file and validate that it is created successfully.

<details>

<summary>Apply the PV YAML file</summary>

```
# Apply the PV YAML file.
$ kubectl apply -f examples/static_volume/static_filesystem/pv-wekafs-fs-static-api.yaml
persistentvolume/pv-wekafs-fs-static-api created

# Check that the PV resource was created.
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                         STORAGECLASS                       REASON   AGE
pv-wekafs-fs-static-api                    1Gi        RWX            Retain           Available                                 storageclass-wekafs-fs-static-api           3m33s
```

</details>

#### Persistent volume **parameters**

<table><thead><tr><th width="263.3333333333333">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>spec.accessModes</code></td><td>The volume access mode.<br>Possible values: <code>ReadWriteMany</code>, <code>ReadWriteOnce</code>, <code>ReadOnlyMany</code></td></tr><tr><td><code>spec.storageClassName</code></td><td>The storage class to use to create the PV.<br>The storage class must exist.</td></tr><tr><td><code>spec.capacity.storage</code></td><td>A required capacity for the volume.<br>The capacity quota is not enforced but is stored on the filesystem directory extended and attributed for future use.</td></tr><tr><td><code>spec.csi.volumeHandle</code></td><td><p>The path previously created.<br>A string containing the <code>volumeType</code> (<code>dir/v1</code>) filesystem name, and the directory path.<br>Example: <code>dir/v1/podsFilesystem/my-dir</code></p><p>The filesystem and path must exist in the WEKA cluster.</p></td></tr></tbody></table>

3. Bind a PVC to this specific PV using the `volumeName` parameter under the PVC `spec` and provide it with the specific PV name.

<details>

<summary>Example: pvc-wekafs-fs-static-api.yaml</summary>

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

<table><thead><tr><th width="263">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>spec.accessModes</code></td><td>The volume access mode.<br>Possible values: <code>ReadWriteMany</code>, <code>ReadWriteOnce</code>, <code>ReadOnlyMany</code></td></tr><tr><td><code>spec.storageClassName</code></td><td>The storage class to use to create the PVC.<br>It must be the same storage class as the PV requested to bind in <code>spec.volumeName</code>.</td></tr><tr><td><code>spec.resources.requests.storage</code></td><td>The required capacity for the volume.<br>The capacity quota is not enforced but is stored on the filesystem directory extended and attributed for future use.</td></tr><tr><td><code>spec.volumeName</code></td><td>The name of a pre-configured persistent volume.<br>The persistent volume name must exist.</td></tr></tbody></table>

4. Validate that the PVC resource is created and successfully bounded (the status is `Bound`).

<details>

<summary>Validate the PVC resource is created</summary>

```
# Apply the PVC YAML file.
$ kubectl apply -f examples/static_volume/static_filesystem/pvc-wekafs-fs-static-api.yaml
persistentvolumeclaim/pvc-wekafs-fs-static-api created

# Check that the PVC bound to the PV.
$ kubectl get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                           STORAGECLASS                       REASON   AGE
pv-wekafs-fs-static-api                    1Gi        RWX            Retain           Bound       default/pvc-wekafs-fs-static-api storageclass-wekafs-fs-static-api           6m30s
```

</details>
