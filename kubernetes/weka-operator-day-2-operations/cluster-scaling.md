---
description: Scale WEKA Operator deployments by adding or removing resources.
---

# Cluster scaling

Adjusting the size of a WEKA cluster ensures optimal performance and cost efficiency. Expand to meet growing workloads or shrink to reduce resources as demand decreases.

## Expand a cluster

Cluster expansion enhances system resources and storage capacity while maintaining cluster stability. This procedure describes how to expand a WEKA cluster by increasing the number of compute and drive containers.

{% hint style="info" %}
This procedure exemplifies an expansion of a cluster with 6 compute and 6 drive containers to a cluster with 7 compute and 7 drive containers. Each driveContainer has one driveCore.
{% endhint %}

#### Before you begin

Verify the following:

* Ensure sufficient resources are available.
* Ensure valid Quay.io credentials for WEKA container images.
* Ensure access to the WEKA operator namespace.
* Check the number of available Kubernetes nodes using `kubectl get nodes`.
* Ensure all existing WEKA containers are in Running state.
* Confirm your cluster is healthy with `weka status`.

#### Procedure

1. Update the cluster configuration by increasing container value from previous value in your YAML file:

{% code title="cluster.yaml" %}
```yaml
spec:
  template: dynamic
  dynamicTemplate:
    computeContainers: 7  # Increase from previous value
    driveContainers: 7    # Increase from previous value
    computeCores: 1
    driveCores: 1
    numDrives: 1
```
{% endcode %}

2. Apply the updated configuration:

```bash
kubectl apply -f cluster.yaml
```

<details>

<summary>Example</summary>

```
wekacontainer.weka.weka.io/weka-driver-dist unchanged
service/weka-driver-dist unchanged
wekacluster.weka.weka.io/cluster-dev configured
wekacontainer.weka.weka.io/weka-drivers-builder unchanged
```

</details>

3. [#perform-the-standard-verification-steps](cluster-scaling.md#perform-the-standard-verification-steps "mention").

#### Expected results

* Total of 14 backend containers (7 compute + 7 drive).
* All new containers show status as UP.
* Weka status shows increased storage capacity.
* Protection status remains Fully protected.

#### Troubleshooting

* If containers remain in Pending state, verify available node capacity.
* Check for sufficient resources across Kubernetes nodes.
* Review WEKA operator logs for expansion-related issues.

#### Considerations

* The number of containers cannot exceed available Kubernetes nodes.
* Pending containers indicate resource constraints or node availability issues.
* Each expansion requires sufficient system resources across the cluster.

{% hint style="info" %}
If your cluster has resource constraints or insufficient nodes, container creation may remain in a pending state until additional nodes become available.
{% endhint %}

***

## Scale up by adding drives

Add drives to an existing drive container by increasing its drive count and triggering a pod rotation. Use this procedure when you expand cluster capacity and need the operator to apply the new drive count to a running drive container.

The operator does not apply a changed drive count to a running pod on its own. To put the new count into effect, you increase `numDrives` and then change the `podConfigVersion` Helm value. Changing `podConfigVersion` triggers a controlled pod rotation, which recreates the drive containers with the updated configuration.

### Before you begin

* Confirm the target servers have the additional NVMe drives installed and available. make sure WekaPolicy is in place to sign drives.
* Confirm the cluster is healthy and is not running an upgrade or another rotation.
* Check the current helm value of `podConfigVersion`. The default value is `1`. Record the current value so you set the next value correctly.
* Confirm you have adequate amount hugepages configured on each Linux machine. For details, see [#configure-hugepages-for-kubernetes-worker-nodes](../weka-operator-deployments/weka-operator-full-deployment-workflow.md#configure-hugepages-for-kubernetes-worker-nodes "mention").

### Procedure

1. Edit WekaCluster configuration to change the drive count assigned to each drive container.

<pre class="language-bash"><code class="lang-bash"><strong>kubectl patch wekacluster weka-cluster-2 -n weka-operator-system
</strong>--type='merge'
-p='{"spec":{"dynamicTemplate":{"numDrives":}}}'
</code></pre>

2. Trigger pod rotation by changing helm value

```bash
helm upgrade weka-operator -n weka-operator-system --reuse-values
--set podConfigVersion=2
```

## Expand an S3 cluster

Expanding an S3 cluster is necessary when additional storage or improved performance is required. Follow the steps below to expand the cluster while maintaining data availability and integrity.

#### Procedure

1.  **Update cluster YAML:** Increase the number of S3 containers in the cluster YAML file and re-deploy the configuration.\
    Example YAML update:

    ```yaml
    spec:
      template: dynamic
      dynamicTemplate:
        computeContainers: 6 
        driveContainers: 6
        computeCores: 1
        driveCores: 1
        numDrives: 1
        s3Containers: 4  #  Icrease from previous value 
    ```

    Apply the changes:

    ```bash
    kubectl apply -f cluster.yaml
    ```

<details>

<summary>Example</summary>

```
$ kubectl apply -f cluster3.yaml 
wekacontainer.weka.weka.io/weka-driver-dist unchanged
service/weka-driver-dist unchanged
wekacluster.weka.weka.io/cluster-dev configured
wekacontainer.weka.weka.io/weka-drivers-builder unchanged
```

</details>

2. **Verify new pods:** Confirm that additional S3 and Envoy pods are created and running. Use the following command to list all pods:

```bash
kubectl get pods --all-namespaces
```

Ensure two new S3 and Envoy pods appear in the output and are in the `Running` state.

<details>

<summary>Example</summary>

```
$ kubectl get pods --all-namespaces
NAMESPACE              NAME                                                       READY   STATUS      RESTARTS   AGE
kube-system            coredns-7b98449c4-l2dlt                                    1/1     Running     0          26m
kube-system            helm-install-traefik-8p668                                 0/1     Completed   1          26m
kube-system            helm-install-traefik-crd-hz9dx                             0/1     Completed   0          26m
kube-system            local-path-provisioner-595dcfc56f-55vmx                    1/1     Running     0          26m
kube-system            metrics-server-cdcc87586-2wmfd                             1/1     Running     0          26m
kube-system            traefik-d7c9c5778-pf2k7                                    1/1     Running     0          25m
weka-operator-system   cluster-dev-compute-05a6a09a-432d-42fe-9df4-c129780aa410   1/1     Running     0          9m41s
weka-operator-system   cluster-dev-compute-6d9f3d37-b8e7-4db6-9df1-5aa2a82e423e   1/1     Running     0          9m23s
weka-operator-system   cluster-dev-compute-723230f4-6ed1-4ff3-94df-e8c7ebcede75   1/1     Running     0          9m33s
weka-operator-system   cluster-dev-compute-e6269c4e-b392-4951-b41b-a401a59fb11a   1/1     Running     0          9m34s
weka-operator-system   cluster-dev-compute-f25ee328-7ea6-4d83-9e53-113996c91a78   1/1     Running     0          9m31s
weka-operator-system   cluster-dev-compute-f3df3e56-aad6-4d29-b303-fdc60132f870   1/1     Running     0          9m34s
weka-operator-system   cluster-dev-drive-65376aa9-24f0-4eb2-9dfe-d72e408916e0     1/1     Running     0          9m23s
weka-operator-system   cluster-dev-drive-79df7254-cee6-4411-b78a-1e503e331e9f     1/1     Running     0          9m33s
weka-operator-system   cluster-dev-drive-ac3824ee-cb66-469e-bca9-f2c7274db4ec     1/1     Running     0          9m33s
weka-operator-system   cluster-dev-drive-af464a29-7180-445a-869d-64e274b47993     1/1     Running     0          9m23s
weka-operator-system   cluster-dev-drive-d7414597-3a96-459e-99a0-7965345c3fa0     1/1     Running     0          9m12s
weka-operator-system   cluster-dev-drive-dad14164-f118-4cfd-9401-6e061f44209d     1/1     Running     0          9m34s
weka-operator-system   cluster-dev-envoy-05de77da-8399-45bc-b904-cb62f8e9ff35     1/1     Running     0          65s
weka-operator-system   cluster-dev-envoy-a22e14cc-7fb7-488c-a7cd-3ef8ee3afc86     1/1     Running     0          65s
weka-operator-system   cluster-dev-envoy-d0249bce-f506-409a-9b54-bc5596900884     1/1     Running     0          9m30s
weka-operator-system   cluster-dev-envoy-e05fe514-e2cb-4f6b-b9c6-8e0c3784f938     1/1     Running     0          9m29s
weka-operator-system   cluster-dev-s3-1ffc8818-e647-4e5c-bbb3-95dcd8ca96f8        1/1     Running     0          65s
weka-operator-system   cluster-dev-s3-75aaeac7-da47-44bb-82d3-c3c273575bd3        1/1     Running     0          65s
weka-operator-system   cluster-dev-s3-78a7332f-1a54-429c-a34e-aa96fbbff216        1/1     Running     0          9m31s
weka-operator-system   cluster-dev-s3-ce450ceb-58c9-4049-986a-75327fa0d76a        1/1     Running     0     
```

</details>

3. **Validate expansion:** Verify the S3 cluster has expanded to include the updated number of containers. Check the cluster status and ensure no errors are present.\
   Use these commands for validation:

```bash
kubectl describe wekacluster -n weka-operator-system
```

Confirm the updated configuration reflects four S3 containers and all components are operational.

<details>

<summary>Example</summary>

```
$ kubectl describe wekacluster -n weka-operator-system
Name:         cluster-dev
Namespace:    weka-operator-system
Labels:       <none>
Annotations:  <none>
API Version:  weka.weka.io/v1alpha1
Kind:         WekaCluster
Metadata:
  Creation Timestamp:  2024-11-16T11:13:19Z
  Finalizers:
    weka.weka.io/finalizer
  Generation:        3
  Resource Version:  10445
  UID:               844cec7a-f41d-45cd-9c59-9810bbd199fe
Spec:
  Additional Memory:
    Compute:             500
    Drive:               1000
    s3:                  200
  Cpu Policy:            auto
  Drivers Dist Service:  https://weka-driver-dist.weka-operator-system.svc.cluster.local:60002
  Dynamic Template:
    Compute Containers:       6
    Compute Cores:            1
    Drive Containers:         6
    Drive Cores:              1
    Num Drives:               1
    s3Containers:             4
  Graceful Destroy Duration:  24h0m0s
  Hot Spare:                  0
  Image:                      quay.io/weka.io/weka-in-container:4.4.1
  Image Pull Secret:          quay-io-robot-secret
  Network:
  Node Selector:
    weka.io/supports-backends:  true
  Ports:
  Role Node Selector:
  Template:  dynamic
Status:
  Cluster ID:  cd596d28-be9a-4864-b34b-dbe45e8914cc
  Conditions:
    Last Transition Time:  2024-11-16T11:13:19Z
    Message:               Cluster secrets are created
    Reason:                Init
    Status:                True
    Type:                  ClusterSecretsCreated
    Last Transition Time:  2024-11-16T11:13:21Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  PodsCreated
    Last Transition Time:  2024-11-16T11:22:41Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ContainerResourcesAllocated
    Last Transition Time:  2024-11-16T11:19:06Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  PodsReady
    Last Transition Time:  2024-11-16T11:19:29Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterCreated
    Last Transition Time:  2024-11-16T11:19:29Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  JoinedCluster
    Last Transition Time:  2024-11-16T11:19:30Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  DrivesAdded
    Last Transition Time:  2024-11-16T11:20:11Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  IoStarted
    Last Transition Time:  2024-11-16T11:20:12Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterSecretsApplied
    Last Transition Time:  2024-11-16T11:20:14Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  CondDefaultFsCreated
    Last Transition Time:  2024-11-16T11:20:14Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  CondS3ClusterCreated
    Last Transition Time:  2024-11-16T11:20:15Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterClientsSecretsCreated
    Last Transition Time:  2024-11-16T11:20:15Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterClientsSecretsApplied
    Last Transition Time:  2024-11-16T11:20:15Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterCSIsSecretsCreated
    Last Transition Time:  2024-11-16T11:20:16Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterCSIsSecretsApplied
    Last Transition Time:  2024-11-16T11:20:16Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  WekaHomeConfigured
    Last Transition Time:  2024-11-16T11:20:16Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterIsReady
  Last Applied Image:      quay.io/weka.io/weka-in-container:4.4.1
  Last Applied Spec:       571bbabc250fb7cfb19ed709bc40b8cb752931a7b3080e300e1b58db8c9559ee
  Ports:
    Base Port:      15000
    Lb Admin Port:  15301
    Lb Port:        15300
    Port Range:     500
    s3Port:         15302
  Status:           Ready
  Throughput:       
Events:             <none>
$ kubectl exec -it cluster-dev-compute-05a6a09a-432d-42fe-9df4-c129780aa410 -n weka-operator-system -- /bin/bash
root@ip-10-0-93-212:/# weka status
WekaIO v4.4.1 (CLI build 4.4.1)

       cluster: cluster-dev (cd596d28-be9a-4864-b34b-dbe45e8914cc)
        status: OK (16 backend containers UP, 6 drives UP)
    protection: 3+2 (Fully protected)
     hot spare: 0 failure domains
 drive storage: 22.09 TiB total, 21.86 TiB unprovisioned
         cloud: connected
       license: Unlicensed

     io status: STARTED 5 minutes ago (16 io-nodes UP, 138 Buckets UP)
    link layer: Ethernet
       clients: 0 connected
         reads: 0 B/s (0 IO/s)
        writes: 0 B/s (0 IO/s)
    operations: 12 ops/s
        alerts: 31 active alerts, use `weka alerts` to list them

root@ip-10-0-93-212:/# weka cluster host
HOST ID  HOSTNAME        CONTAINER                                     IPS          STATUS  REQUESTED ACTION  RELEASE  FAILURE DOMAIN  CORES  MEMORY   UPTIME    LAST FAILURE  REQUESTED ACTION FAILURE
0        ip-10-0-124-65  drivexac3824eexcb66x469exbca9xf2c7274db4ec    10.0.124.65  UP      NONE              4.4.1    AUTO            1      1.54 GB  0:06:42h
1        ip-10-0-102-61  computex723230f4x6ed1x4ff3x94dfxe8c7ebcede75  10.0.102.61  UP      NONE              4.4.1    AUTO            1      2.94 GB  0:06:40h
2        ip-10-0-93-212  computex05a6a09ax432dx42fex9df4xc129780aa410  10.0.93.212  UP      NONE              4.4.1    AUTO            1      2.94 GB  0:06:26h
3        ip-10-0-79-87   s3xce450cebx58c9x4049x986ax75327fa0d76a       10.0.79.87   UP      NONE              4.4.1    AUTO            1      1.26 GB  0:06:36h
4        ip-10-0-113-26  drivex65376aa9x24f0x4eb2x9dfexd72e408916e0    10.0.113.26  UP      NONE              4.4.1    AUTO            1      1.54 GB  0:06:33h
5        ip-10-0-64-53   computexf3df3e56xaad6x4d29xb303xfdc60132f870  10.0.64.53   UP      NONE              4.4.1    AUTO            1      2.94 GB  0:06:35h
6        ip-10-0-107-12  s3x78a7332fx1a54x429cxa34exaa96fbbff216       10.0.107.12  UP      NONE              4.4.1    AUTO            1      1.26 GB  0:06:43h
7        ip-10-0-93-212  drivexd7414597x3a96x459ex99a0x7965345c3fa0    10.0.93.212  UP      NONE              4.4.1    AUTO            1      1.54 GB  0:06:26h
8        ip-10-0-124-65  computexe6269c4exb392x4951xb41bxa401a59fb11a  10.0.124.65  UP      NONE              4.4.1    AUTO            1      2.94 GB  0:06:42h
9        ip-10-0-113-26  computexf25ee328x7ea6x4d83x9e53x113996c91a78  10.0.113.26  UP      NONE              4.4.1    AUTO            1      2.94 GB  0:06:33h
10       ip-10-0-64-53   drivexdad14164xf118x4cfdx9401x6e061f44209d    10.0.64.53   UP      NONE              4.4.1    AUTO            1      1.54 GB  0:06:35h
11       ip-10-0-79-87   drivexaf464a29x7180x445ax869dx64e274b47993    10.0.79.87   UP      NONE              4.4.1    AUTO            1      1.54 GB  0:06:36h
12       ip-10-0-102-61  drivex79df7254xcee6x4411xb78ax1e503e331e9f    10.0.102.61  UP      NONE              4.4.1    AUTO            1      1.54 GB  0:06:39h
13       ip-10-0-107-12  computex6d9f3d37xb8e7x4db6x9df1x5aa2a82e423e  10.0.107.12  UP      NONE              4.4.1    AUTO            1      2.94 GB  0:06:43h
14       ip-10-0-124-65  s3x75aaeac7xda47x44bbx82d3xc3c273575bd3       10.0.124.65  UP      NONE              4.4.1    AUTO            1      1.26 GB  0:02:34h
15       ip-10-0-102-61  s3x1ffc8818xe647x4e5cxbbb3x95dcd8ca96f8       10.0.102.61  UP      NONE              4.4.1    AUTO            1      1.26 GB  0:02:34h

The command 'weka cluster host' is deprecated. Please use 'weka cluster container' instead.
{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Docs):** The captured session on this page predates 6.0: it shows legacy typed identifiers (`HostId<14>`, `HostId<3>`) where 6.0 prints bare integers, and it uses the deprecated `weka cluster host` spelling — the transcript even includes the deprecation warning. Recapture against a 6.0 cluster using `weka cluster container`.
{% endhint %}

root@ip-10-0-93-212:/# weka s3 cluster
S3 Cluster Info
        Status: Online
     All Hosts: off
          Port: 15300
    Filesystem: default
      S3 Hosts: HostId<14>, HostId<3>, HostId<6>, HostId<15>

root@ip-10-0-93-212:/# weka s3 cluster -v
S3 Cluster Info
        Status: Online
     All Hosts: off
          Port: 15300
    Filesystem: default
     Config FS: .config_fs
      S3 Hosts: HostId<14>, HostId<3>, HostId<6>, HostId<15>
 Mount Options: rw,relatime,readcache,readahead_kb=32768,dentry_max_age_positive=1000,dentry_max_age_negative=0,container_name=s3xce450cebx58c9x4049x986ax75327fa0d76a
           TLS: on
           ILM: on
 Creator Owner: off
Max Buckets Limit: 10000
MPU Background: on
     ILM Hosts: HostId<3>
Anonymous Posix UID/GID: 65534/65534
 Internal Port: 15302
SLB Admin Port: 15301
SLB Max Connections: 1024
SLB Max Pending Requests: 1024
SLB Max Requests: 1024

root@ip-10-0-93-212:/# weka s3 cluster status
ID  HOSTNAME        S3 STATUS  IP           PORT   VERSION  UPTIME    ACTIVE REQUESTS  LAST FAILURE
14  ip-10-0-124-65  Ready      10.0.124.65  15300  4.4.1    0:02:33h  0
15  ip-10-0-102-61  Ready      10.0.102.61  15300  4.4.1    0:02:31h  0
3   ip-10-0-79-87   Ready      10.0.79.87   15300  4.4.1    0:05:26h  0
6   ip-10-0-107-12  Ready      10.0.107.12  15300  4.4.1    0:05:26h  0
```

</details>

***

## Shrink a cluster

A WEKA cluster shrink operation reduces compute and drive containers to optimize resources and system footprint. Shrinking may free resources, lower costs, align capacity with demand, or decommission infrastructure. Perform carefully to ensure data integrity and service availability.

#### Before you begin

Verify the following:

* Cluster is in a healthy state before beginning.
* The WEKA cluster is operational and with sufficient redundancy.
* At least one hot spare configured for safe container removal.

#### Procedure

1. Modify the cluster configuration:

{% code title="cluster.yaml" %}
```yaml
spec:
  template: dynamic
  dynamicTemplate:
    computeContainers: 6    # Reduce from previous value
    driveContainers: 6      # Reduce from previous value
    computeCores: 1
    driveCores: 1
    numDrives: 1
```
{% endcode %}

2. Apply the updated configuration:

```bash
kubectl apply -f cluster.yaml
```

<details>

<summary>Example</summary>

```
wekacontainer.weka.weka.io/weka-driver-dist unchanged
service/weka-driver-dist unchanged
wekacluster.weka.weka.io/cluster-dev configured
wekacontainer.weka.weka.io/weka-drivers-builder unchanged
```

</details>

3. Verify the desired state change:

```bash
kubectl describe wekacluster <cluster-name> -n weka-operator-system
```

Replace `<cluster-name>` with your specific value.

<details>

<summary>Example</summary>

```
Name:         cluster-dev
Namespace:    weka-operator-system
Labels:       <none>
Annotations:  <none>
API Version:  weka.weka.io/v1alpha1
Kind:         WekaCluster
Metadata:
  Creation Timestamp:  2024-12-09T07:29:45Z
  Finalizers:
    weka.weka.io/finalizer
  Generation:        3
  Resource Version:  49974
  UID:               2406dc3d-05bb-4b96-b4b9-b72bd1f9f993
Spec:
  Additional Memory:
  Cpu Policy:            auto
  Drivers Dist Service:  https://weka-driver-dist.weka-operator-system.svc.cluster.local:60002
  Dynamic Template:
    Compute Containers:       6
    Compute Cores:            1
    Drive Containers:         6
    Drive Cores:              1
    Num Drives:               1
    s3Containers:             2
  Graceful Destroy Duration:  24h0m0s
  Hot Spare:                  1
  Image:                      quay.io/weka.io/weka-in-container:4.4.1.92-k8s
  Image Pull Secret:          quay-io-robot-secret
  Network:
  Node Selector:
    weka.io/supports-backends:  true
  Ports:
  Role Node Selector:
  Template:  dynamic
Status:
  Cluster ID:  665ebdea-96b6-4556-bba4-a38dcbff44b6
  Conditions:
    Last Transition Time:  2024-12-09T07:29:45Z
    Message:               Cluster secrets are created
    Reason:                Init
    Status:                True
    Type:                  ClusterSecretsCreated
    Last Transition Time:  2024-12-09T07:29:50Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  PodsCreated
    Last Transition Time:  2024-12-09T07:29:56Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ContainerResourcesAllocated
    Last Transition Time:  2024-12-09T07:33:29Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  PodsReady
    Last Transition Time:  2024-12-09T07:33:40Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterCreated
    Last Transition Time:  2024-12-09T07:33:42Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  JoinedCluster
    Last Transition Time:  2024-12-09T07:33:43Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  DrivesAdded
    Last Transition Time:  2024-12-09T07:34:25Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  IoStarted
    Last Transition Time:  2024-12-09T07:34:26Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterSecretsApplied
    Last Transition Time:  2024-12-09T07:34:28Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  CondDefaultFsCreated
    Last Transition Time:  2024-12-09T07:34:28Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  CondS3ClusterCreated
    Last Transition Time:  2024-12-09T07:34:29Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterClientsSecretsCreated
    Last Transition Time:  2024-12-09T07:34:29Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterClientsSecretsApplied
    Last Transition Time:  2024-12-09T07:34:29Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterCSIsSecretsCreated
    Last Transition Time:  2024-12-09T07:34:30Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterCSIsSecretsApplied
    Last Transition Time:  2024-12-09T07:34:37Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  WekaHomeConfigured
    Last Transition Time:  2024-12-09T07:34:37Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  ClusterIsReady
    Last Transition Time:  2024-12-09T07:39:27Z
    Message:               Completed successfully
    Reason:                Init
    Status:                True
    Type:                  CondAdminUserDeleted
  Last Applied Image:      quay.io/weka.io/weka-in-container:4.4.1.92-k8s
  Last Applied Spec:       002d59c371c0f3b820a4936d88449d5ec102acdbcb306b981089c5c472f513dc
  Ports:
    Base Port:      15000
    Lb Admin Port:  15301
    Lb Port:        15300
    Port Range:     500
    s3Port:         15302
  Printer:
    Compute Containers:  7/7/6
    Drive Containers:    7/7/6
    Drives:              7/7/6
    Iops:                --/--/--
    Throughput:          --/--
  Stats:
    Containers:
      Compute:
        Cpu Utilization:  14.29
        Num Containers:
          Active:   7
          Created:  7
          Desired:  6
        Processes:
          Active:   7
          Created:  7
          Desired:  6
      Drive:
        Cpu Utilization:  10.55
        Num Containers:
          Active:   7
          Created:  7
          Desired:  6
        Processes:
          Active:   7
          Created:  7
          Desired:  6
      s3:
        Cpu Utilization:  0.27
        Num Containers:
          Active:   2
          Desired:  2
        Processes:
    Drives:
      Counters:
        Active:   7
        Created:  7
        Desired:  6
    Io Stats:
      Iops:
        Metadata:  0
        Read:      0
        Total:     0
        Write:     0
      Throughput:
        Read:     0
        Write:    0
    Last Update:  2024-12-09T09:06:23Z
  Status:         Ready
Events:           <none>
```

</details>

4.  Remove specific containers:

    * Identify containers to remove
    * Delete the compute container:

    ```bash
    kubectl delete wekacontainer <compute-container-name> -n weka-operator-system
    ```

    * Delete the drive container:

    ```bash
    kubectl delete wekacontainer <drive-container-name> -n weka-operator-system
    ```
5. Verify cluster stability:
   * Check container status.
   * Monitor cluster health.
   * Verify data protection status.

#### Expected results

* Reduced number of active containers and related pod.
* Cluster status shows Running.
* All remaining containers running properly.
* Data protection maintained.
* No service disruption.

#### Troubleshooting

* If cluster shows degraded status, verify hot spare availability.
* Check operator logs for potential issues.
* Ensure proper container termination.
* Verify resource redistribution.

#### Limitations

* Manual container removal required.
* Must maintain minimum required containers for protection level.
* Hot spare needed for safe removal.
* Cannot remove containers below protection requirement.

#### Related topics

[expanding-and-shrinking-cluster-resources](../../operation-guide/expanding-and-shrinking-cluster-resources/ "mention")

***

## Increase client cores

When system demands increase, you may need to add more processing power by increasing the number of client cores. This procedure shows how to increase client cores from 1 to 2 cores to improve system performance while maintaining stability.

#### Prerequisites

Sufficient hugepage memory (1500MiB per core).

#### Procedure

1. Update the WekaClient object configuration in your client YAML file:

```yaml
coresNum: 2 #increase num of cores
```

{% hint style="info" %}
AWS DPDK on EKS is not supported for this configuration.
{% endhint %}

2. Apply the updated client configuration:

```
kubectl apply -f client.yaml
```

<details>

<summary>Example</summary>

```
$ kubectl apply -f exclient.yaml 
wekaclient.weka.weka.io/cluster-dev-clientsnew configured
wekacontainer.weka.weka.io/weka-driver-builder unchanged
service/weka-driver-builder unchanged
```

</details>

3. Verify the new client core is added:

```bash
kubectl get wekaclient -n weka-operator-system
kubectl describe wekaclient <cluster-name> -n weka-operator-system
```

Replace `<cluster-name>` with your specific value.

<details>

<summary>Example</summary>

```bash
$ kubectl get wekaclient -n weka-operator-system
NAME                     STATUS   TARGET CLUSTER   CORES
cluster-dev-clientsnew                             2

$ kubectl describe wekaclient cluster-dev-clientsnew -n weka-operator-system
Name:         cluster-dev-clientsnew
Namespace:    weka-operator-system
Labels:       <none>
Annotations:  <none>
API Version:  weka.weka.io/v1alpha1
Kind:         WekaClient
Metadata:
  Creation Timestamp:  2025-01-20T17:07:07Z
  Finalizers:
    weka.weka.io/finalizer
  Generation:        3
  Resource Version:  100867
  UID:               155dfaa0-b72c-428f-a6f7-c138a41e8d33
Spec:
  Agent Port:            45000
  Cores Num:             2
  Cpu Policy:            auto
  Drivers Dist Service:  https://weka-driver-builder.weka-operator-system.svc.cluster.local:60002
  Image:                 quay.io/weka.io/weka-in-container:4.4.2.144-k8s
  Image Pull Secret:     quay-io-robot-secret
  Join Ip Ports:
    10.0.98.109:15100
  Network:
  Node Selector:
    weka.io/supports-clients:  true
  Port:                        45001
  Target Cluster:
    Name:       
    Namespace:  
  Upgrade Policy:
    Type:  all-at-once
  Weka Home Config:
  Weka Secret Ref:  weka-client-cluster-dev1
Status:
  Last Applied Spec:  a76d4c891dad0036de6d099ec587808c07c3304d4fd6407a324b155c80f31c17
Events:               <none>
```

</details>

3. Delete all client container pods to trigger the reconfiguration:

{% code overflow="wrap" %}
```bash
kubectl delete wekacontainer <client-name>-<ip-address> -n weka-operator-system --force --grace-period=0
```
{% endcode %}

{% hint style="warning" %}
Never force-delete WEKA pods. Force deletion removes the pod from the orchestration layer only, while the underlying container continues running untracked. See [#deletion-behavior](../weka-operator-deployments/wekacluster-and-wekacontainer-lifecycle.md#deletion-behavior "mention").
{% endhint %}

Replace `<client-name>` and `<ip-address>` with your specific values.

<details>

<summary>Example for one node</summary>

{% code overflow="wrap" %}
```bash
kubectl delete wekacontainer cluster-dev-clientsnew-18.201.248.101 -n weka-operator-system --force --grace-period=0
```
{% endcode %}

</details>

4. Verify the client containers have restarted and rejoined the cluster:

```bash
kubectl get pods --all-namespaces
```

Look for pods with your client name prefix to confirm they are in Running state.

<details>

<summary>Example</summary>

```bash
$ kubectl get pods --all-namespaces
NAMESPACE              NAME                                                READY   STATUS      RESTARTS   AGE
kube-system            coredns-ccb96694c-864p2                             1/1     Running     0          5h43m
kube-system            helm-install-traefik-89stn                          0/1     Completed   1          5h43m
kube-system            helm-install-traefik-crd-gth7z                      0/1     Completed   0          5h43m
kube-system            local-path-provisioner-5cf85fd84d-fsqv5             1/1     Running     0          5h43m
kube-system            metrics-server-5985cbc9d7-p9tbb                     1/1     Running     0          5h43m
kube-system            traefik-57b79cf995-2xf9g                            1/1     Running     0          5h43m
weka-operator-system   cluster-dev-clientsnew-18.201.248.101               1/1     Running     0          7m26s
weka-operator-system   cluster-dev-clientsnew-3.250.62.27                  1/1     Running     0          7m23s
weka-operator-system   cluster-dev-clientsnew-3.253.126.106                1/1     Running     0          7m25s
weka-operator-system   cluster-dev-clientsnew-3.253.243.104                1/1     Running     0          7m28s
weka-operator-system   cluster-dev-clientsnew-3.254.188.51                 1/1     Running     0          7m32s
weka-operator-system   cluster-dev-clientsnew-54.220.104.9                 1/1     Running     0          7m23s
weka-operator-system   weka-driver-builder                                 1/1     Running     0          10m
weka-operator-system   weka-operator-controller-manager-7468644bc9-4hz7w   2/2     Running     0          5h41m
weka-operator-system   weka-operator-node-agent-cmd7l                      1/1     Running     0          5h41m
weka-operator-system   weka-operator-node-agent-n48jq                      1/1     Running     0          5h41m
weka-operator-system   weka-operator-node-agent-sdbph                      1/1     Running     0          5h41m
weka-operator-system   weka-operator-node-agent-tlvbh                      1/1     Running     0          5h41m
weka-operator-system   weka-operator-node-agent-w8xlh                      1/1     Running     0          5h41m
weka-operator-system   weka-operator-node-agent-zgz5w                      1/1     Running     0          5h41m
```

</details>

5. Confirm the core increase in the WEKA cluster using the following commands :

```bash
weka cluster container
weka cluster process
weka status
```

<details>

<summary>Example</summary>

```bash
root@ip-10-0-98-109:/# weka cluster container
HOST ID  HOSTNAME         CONTAINER                                     IPS           STATUS  REQUESTED ACTION  RELEASE        FAILURE DOMAIN  CORES  MEMORY   UPTIME    LAST FAILURE  REQUESTED ACTION FAILURE
0        ip-10-0-83-118   drivex92d620e9xffc0x4d14x823ex6444a0d2a823    10.0.83.118   UP      NONE              4.4.2.144-k8s  AUTO            1      1.54 GB  2:17:27h
1        ip-10-0-83-118   s3x58e05049x0c4ex44b8x9b99xccff4dc364db       10.0.83.118   UP      NONE              4.4.2.144-k8s  AUTO            1      1.26 GB  2:17:25h
2        ip-10-0-125-187  drivex3cc5580dx303ex4c15xba6cx82ccc04a898d    10.0.125.187  UP      NONE              4.4.2.144-k8s  AUTO            1      1.54 GB  2:17:25h
3        ip-10-0-65-133   drivex4cca8165xfcaax438dx9a75xf372efc7a497    10.0.65.133   UP      NONE              4.4.2.144-k8s  AUTO            1      1.54 GB  2:17:28h
4        ip-10-0-65-133   computex133b97bcx5bf6x4612x8f2axd09fc42bb573  10.0.65.133   UP      NONE              4.4.2.144-k8s  AUTO            1      2.94 GB  2:17:25h
5        ip-10-0-110-144  computexc0ac9647xf6a5x4d77x909ax07e865469af1  10.0.110.144  UP      NONE              4.4.2.144-k8s  AUTO            1      2.94 GB  2:17:24h
6        ip-10-0-107-84   computex1b0db083x8986x45e0x96e3xe739b58808ee  10.0.107.84   UP      NONE              4.4.2.144-k8s  AUTO            1      2.94 GB  2:17:27h
7        ip-10-0-98-109   computex1d5f9c03x5b35x401exa71ex3786135e7a66  10.0.98.109   UP      NONE              4.4.2.144-k8s  AUTO            1      2.94 GB  2:17:23h
8        ip-10-0-110-144  drivex3cdd7cd0xecbbx4240x9f85xb5881b2f276c    10.0.110.144  UP      NONE              4.4.2.144-k8s  AUTO            1      1.54 GB  2:17:24h
9        ip-10-0-125-187  computexcc4c114exb720x49a7xa964xb050041220d1  10.0.125.187  UP      NONE              4.4.2.144-k8s  AUTO            1      2.94 GB  2:17:26h
10       ip-10-0-83-118   computexac9ca615x9425x48eexaafex756ee3e8e8aa  10.0.83.118   UP      NONE              4.4.2.144-k8s  AUTO            1      2.94 GB  2:17:24h
11       ip-10-0-65-133   s3xea3f0926x5063x4a8dx956cx9d8828f31232       10.0.65.133   UP      NONE              4.4.2.144-k8s  AUTO            1      1.26 GB  2:17:28h
12       ip-10-0-107-84   drivexfbc81c00xa6dex442fxb5b3x3ed4dd433741    10.0.107.84   UP      NONE              4.4.2.144-k8s  AUTO            1      1.54 GB  2:17:24h
13       ip-10-0-98-109   drivex07ddd04bx85cdx43acxbea0xb0f2c339f335    10.0.98.109   UP      NONE              4.4.2.144-k8s  AUTO            1      1.54 GB  2:17:23h
14       ip-10-0-103-75   c138a41e8d33client                            10.0.103.75   UP      NONE              4.4.2.144-k8s                  2      2.94 GB  0:01:13h
15       ip-10-0-113-108  c138a41e8d33client                            10.0.113.108  UP      NONE              4.4.2.144-k8s                  2      2.94 GB  0:01:19h
16       ip-10-0-96-250   c138a41e8d33client                            10.0.96.250   UP      NONE              4.4.2.144-k8s                  2      2.94 GB  0:01:20h
17       ip-10-0-66-16    c138a41e8d33client                            10.0.66.16    UP      NONE              4.4.2.144-k8s                  2      2.94 GB  0:01:28h
18       ip-10-0-94-223   c138a41e8d33client                            10.0.94.223   UP      NONE              4.4.2.144-k8s                  2      2.94 GB  0:01:03h
19       ip-10-0-79-235   c138a41e8d33client                            10.0.79.235   UP      NONE              4.4.2.144-k8s                  2      2.94 GB  0:01:23h

root@ip-10-0-98-109:/# weka cluster process
PROCESS ID  CONTAINER ID  SLOT IN HOST  HOSTNAME         CONTAINER                                     IPS           STATUS  RELEASE        ROLES       NETWORK  CPU  MEMORY   UPTIME    LAST FAILURE
0           0             0             ip-10-0-83-118   drivex92d620e9xffc0x4d14x823ex6444a0d2a823    10.0.83.118   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:15h
1           0             1             ip-10-0-83-118   drivex92d620e9xffc0x4d14x823ex6444a0d2a823    10.0.83.118   UP      4.4.2.144-k8s  DRIVES      UDP      6    1.54 GB  2:17:09h
20          1             0             ip-10-0-83-118   s3x58e05049x0c4ex44b8x9b99xccff4dc364db       10.0.83.118   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
21          1             1             ip-10-0-83-118   s3x58e05049x0c4ex44b8x9b99xccff4dc364db       10.0.83.118   UP      4.4.2.144-k8s  FRONTEND    UDP      3    1.26 GB  2:17:09h
40          2             0             ip-10-0-125-187  drivex3cc5580dx303ex4c15xba6cx82ccc04a898d    10.0.125.187  UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
41          2             1             ip-10-0-125-187  drivex3cc5580dx303ex4c15xba6cx82ccc04a898d    10.0.125.187  UP      4.4.2.144-k8s  DRIVES      UDP      3    1.54 GB  2:17:08h
60          3             0             ip-10-0-65-133   drivex4cca8165xfcaax438dx9a75xf372efc7a497    10.0.65.133   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
61          3             1             ip-10-0-65-133   drivex4cca8165xfcaax438dx9a75xf372efc7a497    10.0.65.133   UP      4.4.2.144-k8s  DRIVES      UDP      6    1.54 GB  2:17:09h
80          4             0             ip-10-0-65-133   computex133b97bcx5bf6x4612x8f2axd09fc42bb573  10.0.65.133   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
81          4             1             ip-10-0-65-133   computex133b97bcx5bf6x4612x8f2axd09fc42bb573  10.0.65.133   UP      4.4.2.144-k8s  COMPUTE     UDP      2    2.94 GB  2:17:07h
100         5             0             ip-10-0-110-144  computexc0ac9647xf6a5x4d77x909ax07e865469af1  10.0.110.144  UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:13h  Host joined a new cluster (2 hours ago)
101         5             1             ip-10-0-110-144  computexc0ac9647xf6a5x4d77x909ax07e865469af1  10.0.110.144  UP      4.4.2.144-k8s  COMPUTE     UDP      1    2.94 GB  2:17:07h
120         6             0             ip-10-0-107-84   computex1b0db083x8986x45e0x96e3xe739b58808ee  10.0.107.84   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:13h  Host joined a new cluster (2 hours ago)
121         6             1             ip-10-0-107-84   computex1b0db083x8986x45e0x96e3xe739b58808ee  10.0.107.84   UP      4.4.2.144-k8s  COMPUTE     UDP      1    2.94 GB  2:17:07h
140         7             0             ip-10-0-98-109   computex1d5f9c03x5b35x401exa71ex3786135e7a66  10.0.98.109   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:13h  Host joined a new cluster (2 hours ago)
141         7             1             ip-10-0-98-109   computex1d5f9c03x5b35x401exa71ex3786135e7a66  10.0.98.109   UP      4.4.2.144-k8s  COMPUTE     UDP      1    2.94 GB  2:17:07h
160         8             0             ip-10-0-110-144  drivex3cdd7cd0xecbbx4240x9f85xb5881b2f276c    10.0.110.144  UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:13h  Host joined a new cluster (2 hours ago)
161         8             1             ip-10-0-110-144  drivex3cdd7cd0xecbbx4240x9f85xb5881b2f276c    10.0.110.144  UP      4.4.2.144-k8s  DRIVES      UDP      3    1.54 GB  2:17:07h
180         9             0             ip-10-0-125-187  computexcc4c114exb720x49a7xa964xb050041220d1  10.0.125.187  UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
181         9             1             ip-10-0-125-187  computexcc4c114exb720x49a7xa964xb050041220d1  10.0.125.187  UP      4.4.2.144-k8s  COMPUTE     UDP      1    2.94 GB  2:17:07h
200         10            0             ip-10-0-83-118   computexac9ca615x9425x48eexaafex756ee3e8e8aa  10.0.83.118   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
201         10            1             ip-10-0-83-118   computexac9ca615x9425x48eexaafex756ee3e8e8aa  10.0.83.118   UP      4.4.2.144-k8s  COMPUTE     UDP      2    2.94 GB  2:17:08h
220         11            0             ip-10-0-65-133   s3xea3f0926x5063x4a8dx956cx9d8828f31232       10.0.65.133   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:13h  Host joined a new cluster (2 hours ago)
221         11            1             ip-10-0-65-133   s3xea3f0926x5063x4a8dx956cx9d8828f31232       10.0.65.133   UP      4.4.2.144-k8s  FRONTEND    UDP      3    1.26 GB  2:17:09h
240         12            0             ip-10-0-107-84   drivexfbc81c00xa6dex442fxb5b3x3ed4dd433741    10.0.107.84   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:13h  Host joined a new cluster (2 hours ago)
241         12            1             ip-10-0-107-84   drivexfbc81c00xa6dex442fxb5b3x3ed4dd433741    10.0.107.84   UP      4.4.2.144-k8s  DRIVES      UDP      3    1.54 GB  2:17:07h
260         13            0             ip-10-0-98-109   drivex07ddd04bx85cdx43acxbea0xb0f2c339f335    10.0.98.109   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      2:17:14h  Host joined a new cluster (2 hours ago)
261         13            1             ip-10-0-98-109   drivex07ddd04bx85cdx43acxbea0xb0f2c339f335    10.0.98.109   UP      4.4.2.144-k8s  DRIVES      UDP      3    1.54 GB  2:17:08h
280         14            0             ip-10-0-103-75   c138a41e8d33client                            10.0.103.75   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      0:01:09h  Configuration snapshot pulled (1 minute ago)
281         14            1             ip-10-0-103-75   c138a41e8d33client                            10.0.103.75   UP      4.4.2.144-k8s  FRONTEND    UDP      1    1.47 GB  0:01:03h
282         14            2             ip-10-0-103-75   c138a41e8d33client                            10.0.103.75   UP      4.4.2.144-k8s  FRONTEND    UDP      2    1.47 GB  0:01:03h
300         15            0             ip-10-0-113-108  c138a41e8d33client                            10.0.113.108  UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      0:01:14h  Configuration snapshot pulled (1 minute ago)
301         15            1             ip-10-0-113-108  c138a41e8d33client                            10.0.113.108  UP      4.4.2.144-k8s  FRONTEND    UDP      1    1.47 GB  0:01:10h
302         15            2             ip-10-0-113-108  c138a41e8d33client                            10.0.113.108  UP      4.4.2.144-k8s  FRONTEND    UDP      2    1.47 GB  0:01:10h
320         16            0             ip-10-0-96-250   c138a41e8d33client                            10.0.96.250   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      0:01:18h  Configuration snapshot pulled (1 minute ago)
321         16            1             ip-10-0-96-250   c138a41e8d33client                            10.0.96.250   UP      4.4.2.144-k8s  FRONTEND    UDP      1    1.47 GB  0:01:13h
322         16            2             ip-10-0-96-250   c138a41e8d33client                            10.0.96.250   UP      4.4.2.144-k8s  FRONTEND    UDP      2    1.47 GB  0:01:13h
340         17            0             ip-10-0-66-16    c138a41e8d33client                            10.0.66.16    UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      0:01:22h  Configuration snapshot pulled (1 minute ago)
341         17            1             ip-10-0-66-16    c138a41e8d33client                            10.0.66.16    UP      4.4.2.144-k8s  FRONTEND    UDP      1    1.47 GB  0:01:19h
342         17            2             ip-10-0-66-16    c138a41e8d33client                            10.0.66.16    UP      4.4.2.144-k8s  FRONTEND    UDP      2    1.47 GB  0:01:19h
360         18            0             ip-10-0-94-223   c138a41e8d33client                            10.0.94.223   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      57.13s    Configuration snapshot pulled (1 minute ago)
361         18            1             ip-10-0-94-223   c138a41e8d33client                            10.0.94.223   UP      4.4.2.144-k8s  FRONTEND    UDP      1    1.47 GB  54.63s
362         18            2             ip-10-0-94-223   c138a41e8d33client                            10.0.94.223   UP      4.4.2.144-k8s  FRONTEND    UDP      2    1.47 GB  54.13s
380         19            0             ip-10-0-79-235   c138a41e8d33client                            10.0.79.235   UP      4.4.2.144-k8s  MANAGEMENT  UDP           N/A      0:01:18h  Configuration snapshot pulled (1 minute ago)
381         19            1             ip-10-0-79-235   c138a41e8d33client                            10.0.79.235   UP      4.4.2.144-k8s  FRONTEND    UDP      1    1.47 GB  0:01:13h
382         19            2             ip-10-0-79-235   c138a41e8d33client                            10.0.79.235   UP      4.4.2.144-k8s  FRONTEND    UDP      2    1.47 GB  0:01:13h

root@ip-10-0-98-109:/# weka status
WekaIO v4.4.2.144-k8s (CLI build 4.4.2.144-k8s)

       cluster: cluster-dev (10d5d634-0aa2-4858-8fef-409254bdf74f)
        status: OK (14 backend containers UP, 6 drives UP)
    protection: 3+2 (Fully protected)
     hot spare: 0 failure domains
 drive storage: 22.09 TiB total, 21.86 TiB unprovisioned
         cloud: connected
       license: Unlicensed

     io status: STARTED 2 hours ago (14 io-nodes UP, 78 Buckets UP)
    link layer: Ethernet
       clients: 6 connected
         reads: 0 B/s (0 IO/s)
        writes: 0 B/s (0 IO/s)
    operations: 0 ops/s
        alerts: 35 active alerts, use `weka alerts` to list them
```

</details>

#### Verification

After completing these steps, verify that:

* All client pods are in Running state.
* The CORES value shows 2 for client containers.
* The clients have successfully rejoined the cluster.
* The system status shows no errors using `weka status`.

#### Troubleshooting

If clients fail to restart:

* Ensure sufficient hugepage memory is available.
* Check pod events for specific error messages.
* Verify the client configuration in the YAML file is correct.

***

## Increase backend cores

Increase the number of cores allocated to compute and drive containers to improve processing capacity for intensive workloads.

The following procedure exemplifies increase of the computeCores and driveCores from 1 to 2 cores.

#### **Procedure**

1. Modify the cluster YAML configuration to update core allocation:

```yaml
template: dynamic
dynamicTemplate:
  computeContainers: 6
  driveContainers: 6
  computeCores: 2    # Increased from 1
  driveCores: 2      # Increased from 1
  numDrives: 1
  s3Containers: 2
  s3Cores: 1
  envoyCores: 1
```

2. Apply the updated configuration:

```bash
kubectl apply -f <cluster-yaml-file>
```

<details>

<summary>Example</summary>

```
$ kubectl apply -f cluster3.yaml
wekacontainer.weka.weka.io/weka-driver-dist unchanged
service/weka-driver-dist unchanged
wekacluster.weka.weka.io/cluster-dev configured
wekacontainer.weka.weka.io/weka-drivers-builder unchanged
```

</details>

3. Verify the changes are applied to the cluster configuration:

```bash
kubectl get wekacluster cluster-dev -n weka-operator-system -o yaml
```

<details>

<summary>Example</summary>

```
$ kubectl get wekacluster cluster-dev -n weka-operator-system -o yaml
apiVersion: weka.weka.io/v1alpha1
kind: WekaCluster
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"weka.weka.io/v1alpha1","kind":"WekaCluster","metadata":{"annotations":{},"name":"cluster-dev","namespace":"weka-operator-system"},"spec":{"driversDistService":"https://weka-driver-dist.weka-operator-system.svc.cluster.local:60002","dynamicTemplate":{"computeContainers":6,"computeCores":2,"driveContainers":6,"driveCores":2,"envoyCores":1,"numDrives":1,"s3Containers":2,"s3Cores":1},"image":"quay.io/weka.io/weka-in-container:4.4.1","imagePullSecret":"quay-io-robot-secret","nodeSelector":{"weka.io/supports-backends":"true"},"template":"dynamic"}}
  creationTimestamp: "2024-11-12T08:56:37Z"
  finalizers:
  - weka.weka.io/finalizer
  generation: 3
  name: cluster-dev
  namespace: weka-operator-system
  resourceVersion: "47005"
  uid: 7817f6ca-7c38-4582-b5d7-fcf837d246e9
spec:
  additionalMemory: {}
  cpuPolicy: auto
  driversDistService:https://weka-driver-dist.weka-operator-system.svc.cluster.local:60002
  dynamicTemplate:
    computeContainers: 6
    computeCores: 2
    driveContainers: 6
    driveCores: 2
    envoyCores: 1
    numDrives: 1
    s3Containers: 2
    s3Cores: 1
  gracefulDestroyDuration: 24h0m0s
  hotSpare: 0
  image: quay.io/weka.io/weka-in-container:4.4.1
  imagePullSecret: quay-io-robot-secret
  network: {}
  nodeSelector:
    weka.io/supports-backends: "true"
  ports: {}
  roleNodeSelector: {}
  template: dynamic
status:
  clusterID: b74532a1-bf80-4857-b187-187dd322b25a
  conditions:
  - lastTransitionTime: "2024-11-12T08:56:38Z"
    message: Cluster secrets are created
    reason: Init
    status: "True"
    type: ClusterSecretsCreated
  - lastTransitionTime: "2024-11-12T08:56:41Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: PodsCreated
  - lastTransitionTime: "2024-11-12T08:56:53Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ContainerResourcesAllocated
  - lastTransitionTime: "2024-11-12T08:57:14Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: PodsReady
  - lastTransitionTime: "2024-11-12T08:57:28Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterCreated
  - lastTransitionTime: "2024-11-12T08:57:28Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: JoinedCluster
  - lastTransitionTime: "2024-11-12T08:57:36Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: DrivesAdded
  - lastTransitionTime: "2024-11-12T08:58:41Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: IoStarted
  - lastTransitionTime: "2024-11-12T08:58:42Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterSecretsApplied
  - lastTransitionTime: "2024-11-12T08:58:43Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: CondDefaultFsCreated
  - lastTransitionTime: "2024-11-12T08:58:44Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: CondS3ClusterCreated
  - lastTransitionTime: "2024-11-12T08:58:44Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterClientsSecretsCreated
  - lastTransitionTime: "2024-11-12T08:58:44Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterClientsSecretsApplied
  - lastTransitionTime: "2024-11-12T08:58:44Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterCSIsSecretsCreated
  - lastTransitionTime: "2024-11-12T08:58:45Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterCSIsSecretsApplied
  - lastTransitionTime: "2024-11-12T08:58:45Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: WekaHomeConfigured
  - lastTransitionTime: "2024-11-12T08:58:45Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: ClusterIsReady
  - lastTransitionTime: "2024-11-12T09:03:46Z"
    message: Completed successfully
    reason: Init
    status: "True"
    type: CondAdminUserDeleted
  lastAppliedImage: quay.io/weka.io/weka-in-container:4.4.1
  lastAppliedSpec: ceab3ec15455912eab20aa62b4457f7ad4c4a626f0313633feff02dfddcda03a
  ports:
    basePort: 15000
    lbAdminPort: 15301
    lbPort: 15300
    portRange: 500
    s3Port: 15302
  status: Ready
  throughput: ""
```

</details>

#### Troubleshooting

If core values are not updated after applying changes:

1. Verify the YAML syntax is correct.
2. Ensure the cluster configuration was successfully applied.
3. Verify the HugePages configuration can accommodate the additional cores.
4. Check for any error messages in the cluster events:

```bash
kubectl describe wekacluster cluster-dev -n weka-operator-system
```

{% hint style="info" %}
* Core allocation changes may require additional steps for full implementation.
* Monitor cluster performance after making changes.
* Consider testing in a non-production environment first.
* Contact support if core values persist at previous settings after applying changes.
{% endhint %}
