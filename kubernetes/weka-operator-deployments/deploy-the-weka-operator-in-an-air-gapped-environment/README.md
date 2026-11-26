---
description: >-
  Install the WEKA Operator and the embedded CSI plugin in a site without
  internet access by mirroring images to an internal registry and building
  drivers in the cluster.
---

# Deploy the WEKA Operator in an air-gapped environment

In a connected deployment, the Kubernetes nodes pull container images from `quay.io` and `registry.k8s.io`, and the operator downloads pre-built drivers from `drivers.weka.io`. In an air-gapped environment, such as a dark site or a regulated network, you prepare all artifacts on a connected server, transfer them into the site, and serve them from inside it. The nodes pull images from an internal container registry, Helm installs the operator from a local copy of the chart, and the operator builds the WEKA drivers in the cluster using the locally built drivers mode.

{% hint style="info" %}
If the site has no internal registry, you can import the image archive into the container runtime of every node instead (for example, `ctr -n k8s.io images import`). You must repeat the import on each new node and for each upgrade. An internal registry is the recommended approach.
{% endhint %}

### Before you begin

* A connected server with internet access, Docker, and Helm 3.
* Quay.io credentials (`QUAY_USERNAME` and `QUAY_PASSWORD`) from WEKA Customer Success.
* The target operator version and the `weka-in-container` image tag from get.weka.io.
* An internal OCI container registry, such as Harbor, Artifactory, or Nexus, that all Kubernetes nodes can reach. If the registry requires authentication, have its credentials ready.
* An approved method to transfer files into the air-gapped site.
* Kubernetes nodes prepared according to the [WEKA Operator full deployment workflow](../weka-operator-full-deployment-workflow.md), including HugePages and the kubelet CPU manager configuration.
* Locally built drivers prerequisites: persistent storage for Drivers-Dist, port 60002 open between the operator components, and kernel headers on the nodes if the OS requires them. For details, see [WEKA Operator driver management](../weka-operator-driver-management.md).

### Procedure

1. On the connected server, prepare the images:
   1.  Set the version variables.

       ```bash
       export OPERATOR_VERSION=<operator-version>      # for example, v1.16.3
       export WEKA_VERSION=<weka-in-container-tag>     # from get.weka.io
       ```
   2.  Download the operator Helm chart, and build the list of required images.

       ```bash
       helm pull oci://quay.io/weka.io/helm/weka-operator --version $OPERATOR_VERSION --untar

       grep -oE '(quay\.io|registry\.k8s\.io|docker\.io)/[^"[:space:]]+' weka-operator/values.yaml \
         | sort -u > images.txt
       echo "quay.io/weka.io/weka-in-container:${WEKA_VERSION}" >> images.txt
       ```
   3.  Edit `images.txt`: add the tag to any entry that has none, and keep only the driver builder images that match the OS of your nodes.

       For example, the operator image entry has no tag because the chart sets it separately in `image.tag`, which defaults to the chart version. Unless you deploy on Red Hat OpenShift, also remove the Driver Toolkit entry (`quay.io/openshift-release-dev/...`). For the purpose of each image, see [WEKA Operator container images](weka-operator-container-images.md).
   4.  Sign in to Quay.io, and pull all images.

       ```bash
       echo "$QUAY_PASSWORD" | docker login quay.io -u "$QUAY_USERNAME" --password-stdin
       xargs -n1 docker pull --platform=linux/amd64 < images.txt
       ```
   5.  Export the images to a single archive.

       ```bash
       docker save -o weka-operator-images.tar $(cat images.txt)
       ```
2. Transfer `weka-operator-images.tar`, `images.txt`, and the `weka-operator` chart directory into the air-gapped site.
3.  In the air-gapped site, load the images, and push them to the internal registry.

    ```bash
    export REGISTRY=<registry-host>/<project>      # for example, registry.example.local/weka

    docker load -i weka-operator-images.tar
    docker login ${REGISTRY%%/*}

    while read -r src; do
      dst="${REGISTRY}/${src#*/}"
      docker tag "$src" "$dst"
      docker push "$dst"
    done < images.txt
    ```

    The loop keeps the original image path and replaces only the registry host. For example, `quay.io/weka.io/weka-operator:v1.16.3` becomes `registry.example.local/weka/weka.io/weka-operator:v1.16.3`.
4.  Copy `weka-operator/values.yaml` to `values-airgap.yaml`, and change every image reference to the internal registry path.

    ```yaml
    imagePullSecret: internal-registry-secret     # omit if the registry allows anonymous pulls

    image:
      repository: registry.example.local/weka/weka.io/weka-operator
      tag: "v1.16.3"

    builderImages:
      default: registry.example.local/weka/weka.io/weka-drivers-build-images:<builder-tag>
    signDrivesImage: registry.example.local/weka/weka.io/weka-sign-tool:<tag>
    kubeProxyImage: registry.example.local/weka/brancz/kube-rbac-proxy:<tag>
    envoyImage: registry.example.local/weka/envoyproxy/envoy:<tag>
    maintenanceImage: registry.example.local/weka/weka.io/busybox:<tag>
    taskmon:
      defaultImage: registry.example.local/weka/weka.io/taskmon:<tag>

    metrics:
      clusters:
        image: registry.example.local/weka/library/nginx:<tag>

    csi:
      installationEnabled: true
      image: registry.example.local/weka/weka.io/csi-wekafs:<tag>
      attacherImage: registry.example.local/weka/sig-storage/csi-attacher:<tag>
      provisionerImage: registry.example.local/weka/sig-storage/csi-provisioner:<tag>
      registrarImage: registry.example.local/weka/sig-storage/csi-node-driver-registrar:<tag>
      resizerImage: registry.example.local/weka/sig-storage/csi-resizer:<tag>
      snapshotterImage: registry.example.local/weka/sig-storage/csi-snapshotter:<tag>
      livenessProbeImage: registry.example.local/weka/sig-storage/livenessprobe:<tag>
    ```

    * Keep the tags exactly as they appear in the chart `values.yaml`.
    * Set the `builderImages` keys of the driver builder images that you kept in `images.txt`.
    * On Red Hat OpenShift, also set `ocpCompatibility.driverToolkitImageBaseUrl` to the internal registry that hosts the Driver Toolkit image.
5.  Create the operator namespace.

    ```bash
    kubectl create namespace weka-operator-system
    ```
6.  If the registry requires authentication, create the registry secret in the operator namespace and in every namespace where a WekaCluster or WekaClient runs.

    ```bash
    kubectl create secret docker-registry internal-registry-secret \
      --namespace <namespace> \
      --docker-server=<registry-host> \
      --docker-username=<username> \
      --docker-password=<password>
    ```
7.  Install the operator from the local chart.

    ```bash
    helm upgrade --install weka-operator ./weka-operator \
      --namespace weka-operator-system \
      -f values-airgap.yaml

    kubectl get pods -n weka-operator-system
    ```

    The `weka-operator-controller-manager` pod reaches `Running`.
8. Set the `image` and `imagePullSecret` fields of each WekaPolicy to the internal registry, and apply the policies:
   1. If you deploy a WekaCluster, apply the sign-drives WekaPolicy described in [WEKA Operator full deployment workflow](../weka-operator-full-deployment-workflow.md).
   2.  Apply the local drivers distribution WekaPolicy.\
       The operator builds the drivers in the cluster instead of downloading them from `drivers.weka.io`.

       ```yaml
       apiVersion: weka.weka.io/v1alpha1
       kind: WekaPolicy
       metadata:
         name: weka-drivers
         namespace: weka-operator-system
       spec:
         type: "enable-local-drivers-distribution"
         image: registry.example.local/weka/weka.io/weka-in-container:<weka-in-container-tag>
         imagePullSecret: internal-registry-secret
         payload:
           interval: "1m"
           driverDistPayload:
             distNodeSelector:
               weka.io/supports-clients: "true"
       ```
9.  Deploy the WekaCluster or WekaClient with the internal image and the local Drivers-Dist service.

    ```yaml
        payload:
          interval: "1m"
          driverDistPayload:
            distNodeSelector:                 # optional
              weka.io/drivers-dist: "true"    # example label; use any label on the node that hosts Drivers-Dist
    ```



`distNodeSelector` places the single Drivers-Dist container. Label the node that has the persistent storage for Drivers-Dist, for example `kubectl label node <node-name> weka.io/drivers-dist=true`. If you omit `distNodeSelector`, the operator schedules Drivers-Dist on any available node.

For the remaining fields, such as `joinIpPorts`, `nodeSelector`, `coresNum`, and `network`, use the same values as in a connected deployment.

10. Verify the deployment.

```bash
kubectl get pods -n weka-operator-system
kubectl get wekacontainer -A
```

The Drivers-Builder, Drivers-Dist, and CSI pods are running, and all WekaContainers reach `Running` or `Completed`. The CSI plugin pods become ready only after the WekaClient is running, which requires the driver build to complete first.

{% hint style="info" %}
To upgrade the operator or the WEKA version, prepare, transfer, and push the images of the new versions, and update `values-airgap.yaml`. Then follow the [WEKA Operator upgrade and migration](../weka-operator-upgrade-and-migration.md) procedure with the internal image paths.
{% endhint %}

### Related topics

[WEKA Operator container images](weka-operator-container-images.md)

[Weka Operator secrets management](../weka-operator-secrets-management.md)

[WEKA Operator upgrade and migration](../weka-operator-upgrade-and-migration.md)

[Troubleshoot WEKA Operator deployments](../troubleshoot-weka-operator-deployments.md)
