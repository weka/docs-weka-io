---
description: >-
  Manage the Kubernetes secrets created by the WEKA operator to store
  credentials and connection information required for cluster interaction. The
  operator automatically handles the lifecycle states.
---

# Weka Operator secrets management

## Secret types and purposes

The operator creates four distinct secrets for each WekaCluster to facilitate different access requirements:

<table><thead><tr><th width="173">Secret type</th><th width="270">Format</th><th>Purpose</th></tr></thead><tbody><tr><td>Operator Secret</td><td><code>weka-operator-&#x3C;cluster-uid></code></td><td>Used by the operator for administrative operations.</td></tr><tr><td>User Admin Secret</td><td><code>weka-cluster-&#x3C;cluster-name></code></td><td>Provides access for the weka cluster with admin rights</td></tr><tr><td>Client Secret</td><td><code>weka-client-&#x3C;cluster-name></code></td><td>Used by WEKA clients to connect to the cluster with the minimum privileges required to join as a client.</td></tr><tr><td>CSI Secret</td><td><code>weka-csi-&#x3C;cluster-name></code></td><td>Used by the CSI plugin for storage provisioning.</td></tr></tbody></table>

### Configure Client Secret

WEKA clients use this secret to connect to the cluster. Use this procedure when the client and WEKA cluster run on different Kubernetes clusters.

Manual creation command:

```bash
kubectl create secret generic weka-client-<cluster-name> \
  --from-literal=username=wekaclient<cluster-uid-short> \
  --from-literal=password=<password> \
  --from-literal=org=Root \
  --from-literal=join-secret=<join-token>
```

### Configure CSI Secret

The CSI plugin requires this secret to manage and provision storage resources. It includes backend connection details:

* `endpoints`: A comma-separated list of Weka API endpoints in `<ip>:<port>` format.
* `scheme`: The API access scheme, such as https.
* `nfsTargetIps`: The IP addresses for NFS targets.

Manual creation command:

```bash
kubectl create secret generic weka-csi-<cluster-name> \
  --from-literal=username=wekacsi<cluster-uid-short> \
  --from-literal=password=<password> \
  --from-literal=organization=Root \
  --from-literal=endpoints=<ip1>:35000,<ip2>:35100 \
  --from-literal=scheme=https \
  --from-literal=nfsTargetIps=<ip>
```

***

## Usage in WekaClient resources

The method for connecting a WekaClient Custom Resource depends on how the cluster is provisioned:

1. Operator-provisioned clusters: The WekaClient automatically uses the client secret created by the operator when you specify the `targetCluster`.
2. Manual connection to non-operator clusters: When specifying `targetIPs` instead of a `targetCluster`, you must create the CSI secret manually. Ensure the secret includes a `join-secret` if the cluster requires it.
