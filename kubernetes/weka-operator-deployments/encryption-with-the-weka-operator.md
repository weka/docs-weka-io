---
description: >-
  Configure encryption at rest for WEKA filesystems on Kubernetes by using
  internal encryption for evaluation or HashiCorp Vault for production.
---

# Encryption with the WEKA Operator

{% hint style="info" %}
Encryption configuration applies to filesystems, not to WEKA management traffic or Kubernetes secrets. For secret and credential management, see [WEKA Operator secrets management](weka-operator-secrets-management.md).
{% endhint %}

## Encryption modes

| Mode | Key storage | Use case |
| --- | --- | --- |
| Internal | Encryption key stored in the WEKA cluster configuration. | Evaluating encrypted filesystem performance. Not recommended for production. |
| Vault | Encryption key managed by HashiCorp Vault via Kubernetes authentication. | Production environments requiring an external KMS. |

### Configure internal encryption

Internal encryption stores the encryption key in the WEKA cluster configuration. Use this mode to evaluate the performance impact of encryption before deploying a production KMS.

{% hint style="info" %}
Do not use internal encryption in production environments. If the WekaCluster CR is deleted, the encryption key is lost and encrypted data becomes unrecoverable.
{% endhint %}

Add the `encryption.internal` block to the WekaCluster spec:

```yaml
spec:
  encryption:
    internal:
      enabled: true
```

### Configure Vault encryption

Vault encryption uses HashiCorp Vault as an external KMS. The operator authenticates with Vault using the Kubernetes auth method, which allows WEKA pods to authenticate using their Kubernetes service account tokens without managing Vault tokens directly.

**Before you begin**

* Ensure HashiCorp Vault is deployed and reachable from the Kubernetes cluster.
* Configure the [Kubernetes auth method](https://developer.hashicorp.com/vault/docs/auth/kubernetes) in Vault.
* Create a Vault role with a policy that permits the WEKA service account to access the encryption key.

**Procedure**

1. Add the `encryption.vault` block to the WekaCluster spec:

```yaml
spec:
  encryption:
    vault:
      address: "https://vault.example.com:8200"
      role: "<vault-role-name>"
      method: kubernetes
```

| Field | Description |
| --- | --- |
| `address`* | Vault server address, for example `https://vault.example.com:8200`. |
| `role`* | The Vault role to authenticate as. Must have a policy permitting access to the WEKA encryption key. |
| `method`* | Vault authentication method. Only `kubernetes` is supported for Operator-managed deployments. |

2. Apply the updated configuration:

```bash
kubectl apply -f weka-cluster.yaml
```

3. Verify the WekaCluster reaches `Ready` state and that no encryption-related errors appear in the operator logs:

```bash
kubectl get wekacluster <cluster-name>
kubectl logs -n weka-operator-system deployment/weka-operator-controller-manager | grep -i encrypt
```

**Related topics**

[WEKA Operator secrets management](weka-operator-secrets-management.md)

[WEKA Operator full deployment workflow](weka-operator-full-deployment-workflow.md)

[WEKA CRD API Reference](https://weka.github.io/weka-k8s-api/)
