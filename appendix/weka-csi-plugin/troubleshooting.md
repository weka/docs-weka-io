# Troubleshooting

you can use the following basic commands to check the status and debug the service:

```
# get all resources
kubectl get all --all-namespaces

# get all pods
kubectl get pods --all-namespaces -o wide

# get all k8s nodes
kubectl get nodes

# get storage classes
$ kubectl get sc

# get persistent volume claims 
$ kubectl get pvc

# get persistent volumes
$ kubectl get pv

# kubectl describe pod/<pod-name> -n <namespace> 
kubectl describe pod/csi-wekafsplugin-dvdh2 -n csi-wekafsplugin

# get logs from a pod
kubectl logs <pod name> <container name>

# get logs from the weka csi plugin
# container (-c) can be one of: [node-driver-registrar wekafs liveness-probe csi-provisioner csi-attacher csi-resizer]
kubectl logs pods/csi-wekafsplugin-<ID> --namespace csi-wekafsplugin -c wekafs
```

## Known issues

### Mixed hugepages size issue in Kubernetes v1.18 and below

Due to a [Kubernetes v1.18 issue with allocating mixed hugepages sizes](https://github.com/kubernetes/kubernetes/pull/80831), the WEKA cluster must not allocate mixed sizes of hugepages on the Kubernetes nodes.&#x20;

#### Workaround

Only if the default memory for the client is increased, do one of the following:

* If the WEKA client is installed on the K8s nodes by a manual stateless client mount, set the `reserve_1g_hugepages` mount option to `false` in the mount command.
* If this is a WEKA server or a WEKA client part of the WEKA cluster, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

Advanced examples and detailed instructions are also available at [www.github.com/weka/csi-wekafs](http://localhost:5000/s/wsv77VATX9FPfXGq2501/).
