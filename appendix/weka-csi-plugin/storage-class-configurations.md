# Storage class configurations

The Weka CSI Plugin supports the following persistent volume types:

* **Dynamic:** Persistent Volume Claim (PVC).
* **Static:** Persistent Volume (PV).

The Weka CSI Plugin communicates with the WEKA cluster using REST API, leveraging this integration to provide extended capabilities, such as strictly enforcing volume capacity usage through integration with filesystem directory quota functionality. For details, see [Quota management](../../fs/quota-management/).

Starting from CSI Plugin **v2.0,** three StorageClass configurations are available:

* Directory-backed StorageClass&#x20;
* Snapshot-backed StorageClass
* Filesystem-backed StorageClass

## API-based communication model

In the API-based model, the API endpoint addresses and authentication credentials must be provided to the WEKA CSI Plugin to establish a REST API connection with the WEKA cluster and perform configuration tasks.

The information is stored securely in [Kubernetes secret](https://kubernetes.io/docs/concepts/configuration/secret/), referred to by the Storage Class.

Adhere to the following:

* The configuration described in this section applies to WEKA CSI Plugin version **0.8.4** and higher. To get all features, WEKA CSI Plugin version **2.0** is required.
* Directory quota integration requires WEKA cluster version **3.13.0** and higher.
* Snapshot quota integration requires WEKA cluster version **4.2** and higher.
* Authenticated mounts for filesystems set with `auth-required=true`, and filesystems in the non-root organization, require WEKA cluster version **3.14.0** and higher.

{% hint style="info" %}
The legacy communication model is deprecated and will be removed in the next release. If you are using the legacy communication model, replacing it with the API-based one is recommended.
{% endhint %}

## Prerequisites

* To provision any persistent volume type, a Storage Class must exist in Kubernetes deployment that matches the secret name and namespace in the WEKA cluster configuration.
* For directory-backed and snapshot-backed storage class configurations, a filesystem must be pre-created on the WEKA cluster to create PVCs.
* For the filesystem-backed StorageClass configuration, the filesystem name is generated automatically based on the PVC name, but the filesystem group name must be declared in the Storage Class configuration.

{% hint style="info" %}
Multiple WEKA cluster connections from the same Kubernetes node are not supported in the current release of WEKA software.&#x20;

However, you can connect different Kubernetes nodes within the same cluster to different WEKA clusters, such as in different regions or availability zones, provided that the WEKA CSI Plugin can access the WEKA cluster REST API. A single CSI Plugin instance can orchestrate persistent volume provisioning on multiple clusters.
{% endhint %}

## Configure secret data

1. Create a secret data file (see the following example).

<details>

<summary>Example: csi-wekafs-api-secret.yaml file</summary>

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

</details>

2. Apply the secret data and validate it is created successfully.

<details>

<summary>Apply the yaml file</summary>

```
# apply the secret .yaml file
$ kubectl apply -f csi-wekafs-api-secret.yaml

# Check the secret was successfully created
$ kubectl get secret csi-wekafs-api-secret -n csi-wekafs
NAME                    TYPE     DATA   AGE
csi-wekafs-api-secret   Opaque   5      7m
```

</details>

{% hint style="info" %}
To provision CSI volumes on filesystems residing in non-root organizations or filesystems, set with `auth-required=true`. A CSI Plugin of version **0.8.4** and higher and WEKA cluster version **3.14** and higher are required.
{% endhint %}

#### Secret data parameters

All values in the secret data file must be in base64-encoded format.

<table><thead><tr><th width="177">Key</th><th>Description</th><th>Comments</th></tr></thead><tbody><tr><td><code>username</code></td><td>The user name for API access to the WEKA cluster.</td><td>Must have at least read-write permissions in the organization. Creating a separate user with admin privileges for the CSI Plugin is recommended.</td></tr><tr><td><code>password</code></td><td>The user password for API access to the Weka cluster.</td><td></td></tr><tr><td><code>organization</code></td><td>The WEKA organization name for the user.<br>For a single organization, use <code>Root</code>.</td><td>You can use multiple secrets to access multiple organizations, which are specified in different storage classes.</td></tr><tr><td><code>scheme</code></td><td>The URL scheme that is used for communicating with the Weka cluster API.</td><td><code>http</code> or <code>https</code> can be used. The user must ensure that the Weka cluster was configured to use the same connection scheme.</td></tr><tr><td><code>endpoints</code></td><td><p>Comma-separated list of endpoints consisting of IP address and port. For example, </p><p><code>172.31.15.113:14000,172.31.12.91:14000</code></p></td><td>For redundancy, specify the management IP addresses of at least 2 backend servers.</td></tr></tbody></table>

## Configure directory-backed StorageClass

1. Create a directory-backed storage class yaml file (see the following example).

<details>

<summary>Example: storageclass-wekafs-dir-api.yaml</summary>

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



</details>

2. Apply the director-backed storage class and validate it is created successfully.

<details>

<summary>Apply the yaml file</summary>

```
# apply the storageclass .yaml file
$ kubectl apply -f storageclass-wekafs-dir.yaml
storageclass.storage.k8s.io/storageclass-wekafs-dir created

# check the storageclass resource has been created successfully 
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-dir        csi.weka.io         Delete          Immediate           true                   75s
```

</details>

Adhere to the following:

* You can define multiple storage classes with different filesystems.&#x20;
* You can use the same secret for multiple storage classes, as long as the credentials are valid to access the filesystem.
* You can use several secret data files for different organizations on the same WEKA cluster, or for different WEKA clusters spanning across the same Kubernetes cluster.

#### Directory-backed  StorageClass **parameters**

<table><thead><tr><th width="293">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>filesystemName</code></td><td><p>The name of the WEKA filesystem to create directories as Kubernetes volumes.</p><p>The filesystem must exist on the WEKA cluster.</p><p>The filesystem may not be defined as authenticated.</p></td></tr><tr><td><code>capacityEnforcement</code></td><td><p>Possible values: <code>HARD</code> or <code>SOFT</code>.</p><ul><li><code>HARD</code>: Strictly enforce quota and deny any write operation to the persistent volume consumer until space is freed.</li><li><code>SOFT</code>: Do not strictly enforce the quota. If the quota is reached, create an alert on the WEKA cluster.</li></ul></td></tr><tr><td><code>ownerUid</code></td><td>Effective User ID of the owner user for the provisioned CSI volume. Might be required for application deployments running under non-root accounts.<br>Defaults to <code>0 CSI plugin v2.0 adds fsgroup features so this is optional</code><strong>.</strong></td></tr><tr><td><code>ownerGid</code></td><td>Effective Group ID of the owner user for the provisioned CSI volume. Might be required for application deployments running under non-root accounts.<br>Defaults to <code>0 CSI plugin v2.0 adds fsgroup features so this is optional</code>.</td></tr><tr><td><code>permissions</code></td><td>Unix permissions for the provisioned volume root directory in octal format. It must be set in quotes. Defaults to <code>0775</code></td></tr><tr><td><code>csi.storage.k8s.io/provisioner-secret-name</code></td><td><p>Name of the K8s secret. For example, <code>csi-wekafs-api-secret</code>.</p><p>It is recommended to use a trust anchor definition to avoid mistakes because the same value (<code>&#x26;secretName</code>) must be specified in the additional parameters according to the CSI specifications.<br>Format: see <em>Example: storageclass-wekafs-dir-api.yaml</em> above (the additional parameters appear at the end of the example).</p></td></tr><tr><td><code>csi.storage.k8s.io/provisioner-secret-namespace</code></td><td><p>The namespace the secret is located in. </p><p>The secret must be located in a different namespace than the installed CSI Plugin.</p><p>It is recommended to use a trust anchor definition to avoid mistakes because the same value (<code>&#x26;secretNamespace</code>) must be specified in the additional parameters according to the CSI specifications.<br>Format: see <em>Example: storageclass-wekafs-dir-api.yaml</em> above (the additional parameters appear at the end of the example).</p></td></tr></tbody></table>

## Configure snapshot-backed StorageClass

1. Create a snapshot-backed StorageClass yaml file (see the following example).

<details>

<summary>Example: storageclass-wekafs-snap-api.yaml</summary>

{% code title="csi-wekafs/examples/dynamic_snapshot/storageclass-wekafs-snap-api.yaml" %}
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storageclass-wekafs-snap-api
provisioner: csi.weka.io
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
parameters:
  volumeType: weka/v2  # this line can be ommitted completely

  # name of an EMPTY filesystem to provision volumes on
  filesystemName: default

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
  csi.storage.k8s.io/node-publish-secret-namespace: *secretNamespacem
```
{% endcode %}

</details>

2. Apply the snapshot-backed StorageClass and validate it is created successfully.

<details>

<summary>Apply the yaml file</summary>

```
# apply the storageclass.yaml file
$ kubectl apply -f storageclass-wekafs-snap-api.yaml
storageclass.storage.k8s.io/storageclass-wekafs-snap-api created

# check the storageclass resource has been created successfully 
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-snap-api   csi.weka.io         Delete          Immediate           true                   75s
```

</details>

Adhere to the following:

* You can define multiple storage classes with different filesystems.&#x20;
* You can use the same secret for multiple storage classes, as long as the credentials are valid to access the filesystem.
* You can use several secret data files for different organizations on the same WEKA cluster, or for different WEKA clusters spanning across the same Kubernetes cluster.

#### &#x20;snapshot-backed StorageClass parameters

<table><thead><tr><th width="257">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>volumeType</code></td><td><p>The CSI Plugin volume type.</p><p>For snapshot-backed StorageClass configurations, use <code>weka/v2</code>.</p></td></tr><tr><td><code>filesystemName</code></td><td><p>The name of the WEKA filesystem to create snapshots as Kubernetes volumes.</p><p>The filesystem must exist on the WEKA cluster and be empty.</p></td></tr><tr><td><code>csi.storage.k8s.io/provisioner-secret-name</code></td><td><p>Name of the K8s secret. For example, <code>csi-wekafs-api-secret</code>.</p><p>It is recommended to use a trust anchor definition to avoid mistakes because the same value must be specified in the additional parameters according to the CSI specifications.<br>Format: see <em>Example: storageclass-wekafs-snap-api.yaml</em> above (the additional parameters appear at the end of the example).</p></td></tr><tr><td><code>csi.storage.k8s.io/provisioner-secret-namespace</code></td><td><p>The namespace the secret is located in. </p><p>The secret must be located in a different namespace than the installed CSI Plugin.</p><p>It is recommended to use a trust anchor definition to avoid mistakes because the same value must be specified in the additional parameters according to the CSI specifications.<br>Format: see <em>Example: storageclass-wekafs-snap-api.yaml</em> above (the additional parameters appear at the end of the example).</p></td></tr></tbody></table>

## Configure filesystem-backed StorageClass

1. Create a filesystem-backed StorageClass yaml file (see the following example).

<details>

<summary>Example: storageclass-wekafs-fs-api.yaml </summary>

{% code title="csi-wekafs/examples/dynamic_filesystem/storageclass-wekafs-fs-api.yaml" %}
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storageclass-wekafs-fs-api
provisioner: csi.weka.io
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
parameters:
  volumeType: weka/v2  # this line can be ommitted completely

  # name of the filesystem group to create FS in.
  filesystemGroupName: default
  # minimum size of filesystem to create (preallocate space for snapshots and derived volumes)
  initialFilesystemSizeGB: "100"

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

</details>

2. Apply the filesystem-backed StorageClass and validate it is created successfully.

<details>

<summary>Apply the yaml file</summary>

```
# apply the storageclass.yaml file
$ kubectl apply -f storageclass-wekafs-fs-api.yaml
storageclass.storage.k8s.io/storageclass-wekafs-fs-api created

# check the storageclass resource has been created successfully 
$ kubectl get sc
NAME                           PROVISIONER         RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
storageclass-wekafs-fs-api     csi.weka.io         Delete          Immediate           true                   75s
```

</details>

Adhere to the following:

* You can define multiple storage classes with different filesystems.&#x20;
* You can use the same secret for multiple storage classes, as long as the credentials are valid to access the filesystem.
* You can use several secret data files for different organizations on the same WEKA cluster, or for different WEKA clusters spanning across the same Kubernetes cluster.

#### filesystem-backed StorageClass **parameters**

<table><thead><tr><th width="282">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>volumeType</code></td><td><p>The CSI Plugin volume type.</p><p>For filesystem-backed StorageClass configurations, use <code>weka/v2</code>.</p></td></tr><tr><td><code>filesystemGroupName</code></td><td>The name of the WEKA filesystem to create filesystems as Kubernetes volumes.<br>The filesystem group must exist on the WEKA cluster.</td></tr><tr><td><code>initialFilesystemSizeGB</code></td><td><p>The default size to create new filesystems.<br>Set this parameter in the following cases:</p><ul><li>When the PVC requested size is smaller than the specified value.</li><li>For additional space required by snapshots of a volume or snapshot-backed volumes derived from this filesystem.</li></ul></td></tr><tr><td><code>csi.storage.k8s.io/provisioner-secret-name</code></td><td><p>Name of the K8s secret. For example, <code>csi-wekafs-api-secret</code>.</p><p>It is recommended to use a trust anchor definition to avoid mistakes because the same value must be specified in the additional parameters below, according to the CSI specifications.<br>Format: see <em>Example: storageclass-wekafs-snap-api.yaml</em> above (the additional parameters appear at the end of the example).</p></td></tr><tr><td><code>csi.storage.k8s.io/provisioner-secret-namespace</code></td><td><p>The namespace the secret is located in. </p><p>The secret must be located in a different namespace than the installed CSI Plugin.</p><p>It is recommended to use a trust anchor definition to avoid mistakes because the same value must be specified in the additional parameters according to the CSI specifications.<br>Format: see <em>Example: storageclass-wekafs-fs-api.yaml</em> above (the additional parameters appear at the end of the example).</p></td></tr></tbody></table>
