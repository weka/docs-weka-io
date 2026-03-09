---
description: >-
  Manage the Kubernetes secrets created by the Weka operator to store
  credentials and connection information required for cluster interaction. The
  operator automatically handles the lifecycle of these s
---

# Weka Operator secrets management

## Secret types and purposes

The operator creates four distinct secrets for each WekaCluster to facilitate different access requirements:

| **Secret Type**   | **Name Format**               | **Purpose**                                         |
| ----------------- | ----------------------------- | --------------------------------------------------- |
| Operator Secret   | `weka-operator-<cluster-uid>` | Used by the operator for administrative operations. |
| User Admin Secret | `weka-cluster-<cluster-name>` | Provides administrative access for users.           |
| Client Secret     | `weka-client-<cluster-name>`  | Used by Weka clients to connect to the cluster.     |
| CSI Secret        | `weka-csi-<cluster-name>`     | Used by the CSI plugin for storage provisioning.    |

***

#### Operator Secret configuration

The operator uses this secret to authenticate with the Weka cluster. It contains the following data:

* username: The operator-specific admin user.
* password: The password for the operator user.
* org: The organization name, typically Root.
* join-secret: The token required for containers to join the cluster.

Manual creation command:

Bash

```
kubectl create secret generic weka-operator-<cluster-uid> \
  --from-literal=username=weka-operator-<cluster-uid-short> \
  --from-literal=password=<password> \
  --from-literal=org=Root \
  --from-literal=join-secret=<join-token>
```

***

#### User Admin Secret configuration

This secret stores credentials for general administrative tasks performed by users.

Manual creation command:

Bash

```
kubectl create secret generic weka-cluster-<cluster-name> \
  --from-literal=username=weka<cluster-uid-short> \
  --from-literal=password=<password> \
  --from-literal=org=Root
```

***

#### Client Secret configuration

Weka clients utilize this secret to establish connections to the cluster.

Manual creation command:

Bash

```
kubectl create secret generic weka-client-<cluster-name> \
  --from-literal=username=wekaclient<cluster-uid-short> \
  --from-literal=password=<password> \
  --from-literal=org=Root \
  --from-literal=join-secret=<join-token>
```

***

#### CSI Secret configuration

The CSI plugin requires this secret to manage and provision storage resources. It includes backend connection details:

* endpoints: A comma-separated list of Weka API endpoints in `<ip>:<port>` format.
* scheme: The API access scheme, such as https.
* nfsTargetIps: The IP addresses for NFS targets.

Manual creation command:

Bash

```
kubectl create secret generic weka-csi-<cluster-name> \
  --from-literal=username=wekacsi<cluster-uid-short> \
  --from-literal=password=<password> \
  --from-literal=organization=Root \
  --from-literal=endpoints=<ip1>:35000,<ip2>:35100 \
  --from-literal=scheme=https \
  --from-literal=nfsTargetIps=<ip>
```

***

#### Usage in WekaClient resources

The method for connecting a WekaClient Custom Resource depends on how the cluster is provisioned:

1. Operator-provisioned clusters: The WekaClient automatically uses the client secret created by the operator when you specify the `targetCluster`.
2. Manual connection to non-operator clusters: When specifying direct IPs instead of a `targetCluster`, you must create the CSI secret manually. Ensure the secret includes a `join-secret` if the cluster requires it.

