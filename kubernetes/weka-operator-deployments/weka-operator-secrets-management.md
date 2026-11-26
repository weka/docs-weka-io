---
description: >-
  Manage the Kubernetes secrets created by the WEKA operator to store
  credentials and connection information required for cluster interaction. The
  operator automatically handles the lifecycle states.
---

# Weka Operator secrets management

## Secret types and purposes

The operator creates four distinct secrets for each WekaCluster to facilitate different access requirements:

| Secret type       | Format                        | Purpose                                                                                                                                                                                                                                                  |
| ----------------- | ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Operator Secret   | `weka-operator-<cluster-uid>` | Used by the operator for administrative operations.                                                                                                                                                                                                      |
| User Admin Secret | `weka-cluster-<cluster-name>` | Provides admin access to the cluster. If `spec.adminCredentialsSecretRef` is set, the operator uses that Secret instead. See [Use a custom Secret for admin credentials](weka-operator-secrets-management.md#use-a-custom-secret-for-admin-credentials). |
| Client Secret     | `weka-client-<cluster-name>`  | Used by WEKA clients to connect to the cluster with the minimum privileges required to join as a client.                                                                                                                                                 |
| CSI Secret        | `weka-csi-<cluster-name>`     | Used by the CSI plugin for storage provisioning.                                                                                                                                                                                                         |

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

The CSI plugin requires this Secret to manage and provision storage resources. It includes backend connection details:

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

### Manage the WEKA license with a Kubernetes Secret

Store the WEKA license in a Kubernetes Secret so that the operator applies it to the cluster and re-applies it when the Secret changes. The operator applies the license from an active backend container after the cluster forms, and checks the Secret once a minute.

**Before you begin**

* WEKA Operator v1.17.0 or later.
* A license key from get.weka.io for the cluster GUID.

**Procedure**

1.  Create the Secret in the WekaCluster namespace, with the license under the key `license`:

    ```bash
    kubectl create secret generic weka-license \
      --from-literal=license=<license-key> \
      -n <namespace>
    ```
2.  Reference the Secret in the WekaCluster:

    ```yaml
    spec:
      licenseSecret: weka-license
    ```
3.  Apply the configuration:

    ```bash
    kubectl apply -f weka-cluster.yaml
    ```
4.  Verify that the `LicenseApplied` condition of the WekaCluster is `True`:

    ```bash
    kubectl describe wekacluster <cluster-name> -n <namespace>
    ```

    If the license fails to apply, the condition is `False` with reason `ApplyFailed`, and the operator emits a `LicenseApplyFailed` warning event.

To renew the license, update the Secret with the new license key. The operator re-applies the license within a minute.

{% hint style="info" %}
Clearing `spec.licenseSecret` does not remove the license from the cluster.
{% endhint %}

### Use a custom Secret for admin credentials

Provide your own Kubernetes Secret for the cluster admin user instead of the Secret that the operator generates.

{% hint style="warning" %}
Set `adminCredentialsSecretRef` when you create the WekaCluster. The field is immutable: you cannot add, remove, or change it after the WekaCluster is created.
{% endhint %}

**Before you begin**

* WEKA Operator v1.17.0 or later.
* An admin username that is not `admin` and not an operator-managed user, and a Secret name that differs from the operator-managed Secret names.

**Procedure**

1.  Create the Secret in the WekaCluster namespace, with non-empty `username` and `password` keys:

    ```bash
    kubectl create secret generic my-weka-admin \
      --from-literal=username=<admin-user> \
      --from-literal=password=<password> \
      -n <namespace>
    ```

    Use `--from-literal`. A trailing newline in the password is not trimmed and becomes part of the WEKA password.
2.  Reference the Secret in the WekaCluster manifest:

    ```yaml
    spec:
      adminCredentialsSecretRef:
        name: my-weka-admin
    ```
3.  Create the WekaCluster:

    ```bash
    kubectl apply -f weka-cluster.yaml
    ```
4.  Verify that the WekaCluster reaches the `Ready` state:

    ```bash
    kubectl get wekacluster <cluster-name> -n <namespace>
    ```

***

## Usage in WekaClient resources

The method for connecting a WekaClient Custom Resource depends on how the cluster is provisioned:

1. Operator-provisioned clusters: The WekaClient automatically uses the client secret created by the operator when you specify the `targetCluster`.
2. Manual connection to non-operator clusters: When specifying `targetIPs` instead of a `targetCluster`, you must create the CSI secret manually. Ensure the secret includes a `join-secret` if the cluster requires it.

### Related topics

[WEKA Operator full deployment workflow](weka-operator-full-deployment-workflow.md)

[Cluster maintenance](../weka-operator-day-2-operations/cluster-maintenance.md)

[Troubleshoot WEKA Operator deployments](troubleshoot-weka-operator-deployments.md)
