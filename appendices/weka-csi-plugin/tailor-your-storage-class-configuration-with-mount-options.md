---
description: Leverage mount options for tailored storage control with the CSI Plugin.
---

# Tailor your storage class configuration with mount options

## **Overview**

The CSI Plugin empowers you with **mount options**, allowing you to customize how WekaFS volumes are presented to pods. This enables granular control over storage behavior, optimizing performance and data management for containerized workloads.

Mount options are key-value pairs specified during volume mounting that modify the default filesystem or storage provider behavior. These settings influence caching, data integrity, filesystem limits, and more.

**When to use mount options:**

* **Tailor performance:** Optimize caching strategies for read-heavy or write-intensive workloads (`noatime`, `readcache`).
* **Enhance data integrity:** Enforce data consistency and reliability (example: `sync`).
* **Customize behavior:** Adjust settings like filesystem size limits for specific use cases (example: `fstype`).
* **Troubleshoot issues:** Fine-tune settings to resolve performance bottlenecks or compatibility problems.

### **Standard mount options and use cases**

The CSI Plugin supports all standard mount options except the read-only (`ro`) option. The following table briefly lists the supported mount options for convenience.

| Option         | Description                                                | Use cases                                           |
| -------------- | ---------------------------------------------------------- | --------------------------------------------------- |
| `sync`         | Ensure data is written to disk before mount                | Database workloads requiring high data integrity    |
| `noatime`      | Disable write timestamp updates                            | Reduce write amplification, improve performance     |
| `nodev`        | Disallow device nodes                                      | Security-sensitive environments                     |
| `noexec`       | Disallow program execution                                 | Security-focused deployments                        |
| `atime`        | Enable access time recording                               | Monitor file access patterns                        |
| `diratime`     | Enable directory access time recording                     | Track directory access time                         |
| `relatime`     | Update access and modification times relative to stat time | Reduce write amplification, improve performance     |
| `data=ordered` | Ensure sequential writes are flushed to disk immediately   | Databases requiring strict write ordering           |
| `fstype`       | Specify the filesystem type                                | Use case-specific filesystems (examples: XFS, ext4) |

## **Set custom mount options with CSI Plugin**

This example procedure demonstrates how to set custom mount options using the WEKA CSI Plugin.

#### **Prerequisites:**

* The Kubernetes environment is set up and accessible.
* The kubectl command-line tool is installed and configured.

#### **Procedure:**

1.  **Create StorageClass:**

    a. Open or create a YAML file for your StorageClass definition (for example, `storageclass-wekafs-mountoptions.yaml`).

    b. Add the following content to define the StorageClass with custom mount options:

    {% code overflow="wrap" %}
    ```yaml
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: storageclass-wekafs-mountoptions
    provisioner: csi.weka.io
    parameters:
      mountOptions: "rw,relatime,readcache,noatime,readahead_kb=32768,dentry_max_age_positive=1000,dentry_max_age_negative=0"
    ```
    {% endcode %}



    c. Apply the StorageClass using the following command:

    ```bash
    kubectl apply -f storageclass-wekafs-mountoptions.yaml
    ```
2.  **Create CSI secret:**\
    a. Execute the following command to create a CSI secret named `csi-wekafs-api-secret` (located in [../common/csi-wekafs-api-secret.yaml](https://github.com/weka/csi-wekafs/blob/main/examples/common/csi-wekafs-api-secret.yaml)):

    ```bash
    kubectl apply -f ../common/csi-wekafs-api-secret.yaml
    ```

    This step ensures that the necessary credentials are available for the CSI Plugin.
3.  **Provision a new volume:**

    Apply the StorageClass to provision a new volume. Use the following command:

    ```bash
    kubectl apply -f <FILE>.yaml
    ```

    * Replace `<FILE>` with the path to your YAML file containing the Persistent Volume Claim (PVC) definition.
4.  **Create application:**

    a. Create an application manifest file (for example, `csi-app-fs-mountoptions.yaml`) or use an existing one.

    b. In the manifest, specify the PVC with the custom mount options:

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

    * Replace `<YOUR_IMAGE>` with the desired container image.

    c. Deploy the application:

    ```bash
    kubectl apply -f csi-app-fs-mountoptions.yaml
    ```
5.  **Attach and validate:**

    Attach to the application pod:

    ```bash
    kubectl exec csi-app-fs-mountoptions -- mount -t wekafs
    ```

    b. Verify that the output resembles to the following example:

    ```bash
    csivol-pvc-15a45f20-Z72GJXDCEWQ5 on /data type wekafs (rw,relatime,readcache,noatime,readahead_kb=32768,dentry_max_age_positive=1000,dentry_max_age_negative=0)

    ```
