---
description: >-
  Identify the container images that the WEKA Operator and its embedded CSI
  plugin use, and the Helm values key that sets the location of each image.
---

# WEKA Operator container images

The WEKA Operator Helm chart pins the tag of each image in `values.yaml`. Tags change between operator versions, so always read them from the chart of the version you deploy. Use this list when you mirror images to an internal registry.

### WEKA images

| Image                                       | Helm values key                                                | Required when                       |
| ------------------------------------------- | -------------------------------------------------------------- | ----------------------------------- |
| `quay.io/weka.io/weka-operator`             | <p><code>image.repository</code><br><code>image.tag</code></p> | Always                              |
| `quay.io/weka.io/weka-in-container`         | None                                                           | Always                              |
| `quay.io/weka.io/weka-drivers-build-images` | `builderImages.*`                                              | Locally built drivers mode          |
| `quay.io/weka.io/weka-sign-tool`            | `signDrivesImage`                                              | Drive signing for a WekaCluster     |
| `quay.io/weka.io/busybox`                   | `maintenanceImage`                                             | Always                              |
| `quay.io/weka.io/taskmon`                   | `taskmon.defaultImage`                                         | Always                              |
| `quay.io/weka.io/csi-wekafs`                | `csi.image`                                                    | `csi.installationEnabled` is `true` |

* The `weka-in-container` image has no Helm values key. Set it in the `image` field of the WekaCluster, WekaClient, and WekaPolicy resources, and take the tag from get.weka.io.
* The chart lists one driver builder image for each supported node OS, for example `builder-ubuntu22-v1` in `builderImages.default` and `builder-ubuntu24-v1` in `builderImages.ubuntu24`. Mirror only the images that match the OS of your nodes.

### Third-party images

| Image                                                                | Helm values key          | Required when                                  |
| -------------------------------------------------------------------- | ------------------------ | ---------------------------------------------- |
| `quay.io/brancz/kube-rbac-proxy`                                     | `kubeProxyImage`         | Always                                         |
| `docker.io/envoyproxy/envoy`                                         | `envoyImage`             | Always                                         |
| `docker.io/library/nginx`                                            | `metrics.clusters.image` | `metrics.clusters.enabled` is `true` (default) |
| `registry.k8s.io/sig-storage/csi-attacher`                           | `csi.attacherImage`      | `csi.installationEnabled` is `true`            |
| `registry.k8s.io/sig-storage/csi-provisioner`                        | `csi.provisionerImage`   | `csi.installationEnabled` is `true`            |
| `registry.k8s.io/sig-storage/csi-node-driver-registrar`              | `csi.registrarImage`     | `csi.installationEnabled` is `true`            |
| `registry.k8s.io/sig-storage/csi-resizer`                            | `csi.resizerImage`       | `csi.installationEnabled` is `true`            |
| `registry.k8s.io/sig-storage/csi-snapshotter`                        | `csi.snapshotterImage`   | `csi.installationEnabled` is `true`            |
| `registry.k8s.io/sig-storage/livenessprobe`                          | `csi.livenessProbeImage` | `csi.installationEnabled` is `true`            |
| `registry.k8s.io/sig-storage/csi-external-health-monitor-controller` | Listed in `values.yaml`  | `csi.installationEnabled` is `true`            |

### Red Hat OpenShift images

| Image                          | Helm values key                                                                                                         | Required when                |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| OpenShift Driver Toolkit image | <p><code>ocpCompatibility.driverToolkitImageBaseUrl</code><br><code>ocpCompatibility.driverToolkitSecretName</code></p> | OpenShift Container Platform |

{% hint style="success" %}
To list every image reference in a downloaded chart, run:

```bash
grep -oE '(quay\.io|registry\.k8s\.io|docker\.io)/[^"[:space:]]+' weka-operator/values.yaml | sort -u
```
{% endhint %}

### Related topics

[Deploy the WEKA Operator in an air-gapped environment](./)

[WEKA Operator driver management](../weka-operator-driver-management.md)
