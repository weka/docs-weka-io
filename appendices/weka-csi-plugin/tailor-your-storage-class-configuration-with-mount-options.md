---
description: >-
  Configure the WEKA CSI Plugin to use specific mount options for tailored
  storage control.
---

# Configure storage class mount options

## **Overview**

The CSI Plugin exposes mount options that control how WEKA volumes are presented to pods. These options provide fine-grained control over storage behavior, enabling performance tuning and predictable data management for containerized workloads.

Mount options are `key–value` pairs and flags specified at volume mount time. They override default filesystem behavior and affect caching, data integrity, and filesystem limits.

Use mount options to:

* **Optimize performance:** Adjust caching and access semantics for read-heavy or write-intensive workloads (for example, `noatime`, `readcache`).
* **Enforce data integrity:** Apply stricter consistency and reliability guarantees (for example, `sync`).
* **Resolve issues:** Tune mount behavior to address performance bottlenecks or compatibility constraints.

#### Supported mount options

The CSI Plugin supports standard mount options except for the read-only (ro) option. Use the following table to identify appropriate settings for your workload.

| Name | Description | Use case |
| --- | --- | --- |
| `sync` | Forces data writes to disk before the mount completes. | Databases requiring high integrity. |
| `noatime` | Disables access timestamp updates. | Reduces write amplification. |
| `nodev` | Prevents the use of device nodes. | Security-sensitive environments. |
| `noexec` | Disallows program execution on the volume. | Security-focused deployments. |
| `atime` | Enables access time recording. | Monitoring file access patterns. |
| `diratime` | Enables directory access time recording. | Tracking directory access. |
| `relatime` | Updates access times relative to modification times. | Improved performance. |
| `data=ordered` | Ensures sequential writes flush to disk immediately. | Strict write ordering. |

## Apply custom mount options using the CSI Plugin

Define and apply custom mount options to optimize storage behavior for specific applications.

**Before you begin**

* Ensure the Kubernetes environment is accessible.
* Install and configure the kubectl command-line tool.

**Procedure**

1. Create the StorageClass:
   * Create a YAML file named `storageclass-wekafs-mountoptions.yaml`.
   *   Add the following configuration:

       ```yaml
       apiVersion: storage.k8s.io/v1
       kind: StorageClass
       metadata:
         name: storageclass-wekafs-mountoptions
       provisioner: csi.weka.io
       parameters:
         mountOptions: "rw,relatime,readcache,noatime,readahead_kb=32768,dentry_max_age_positive=1000,dentry_max_age_negative=0"
       ```
   *   Apply the StorageClass:

       ```bash
       kubectl apply -f storageclass-wekafs-mountoptions.yaml
       ```
2. Create the CSI secret:
   *   Apply the secret to provide credentials for the CSI Plugin (example: [../common/csi-wekafs-api-secret.yaml](https://github.com/weka/csi-wekafs/blob/main/examples/common/csi-wekafs-api-secret.yaml)):

       ```bash
       kubectl apply -f ../common/csi-wekafs-api-secret.yaml
       ```
3. Provision a new volume:
   *   Apply your Persistent Volume Claim (PVC) manifest that references the new StorageClass:

       ```bash
       kubectl apply -f <FILE>.yaml
       ```
4. Deploy the application:
   * Create a deployment manifest file named `csi-app-fs-mountoptions.yaml`.
   *   Define the container and reference the PVC:

       ```yaml
       apiVersion: apps/v1
       kind: Deployment
       metadata:
         name: csi-app-fs-mountoptions
       spec:
         replicas: 1
         selector:
           matchLabels:
             app: csi-app-fs-mountoptions
         template:
           metadata:
             labels:
               app: csi-app-fs-mountoptions
           spec:
             containers:
             - name: csi-app-fs-mountoptions
               image: <YOUR_IMAGE>
               volumeMounts:
               - mountPath: "/data"
                 name: wekafs-volume
             volumes:
             - name: wekafs-volume
               persistentVolumeClaim:
                 claimName: pvc-wekafs-fs-mountoptions
       ```
   *   Deploy the application:

       ```bash
       kubectl apply -f csi-app-fs-mountoptions.yaml
       ```
5. Validate the mount settings:
   *   Access the application pod to check the mount status:

       ```bash
       kubectl exec csi-app-fs-mountoptions -- mount -t wekafs
       ```
   *   Verify the output displays the configured options:

       ```bash
       csivol-pvc-15a45f20-Z72GJXDCEWQ5 on /data type wekafs (rw,relatime,readcache,noatime,readahead_kb=32768,dentry_max_age_positive=1000,dentry_max_age_negative=0)
       ```
