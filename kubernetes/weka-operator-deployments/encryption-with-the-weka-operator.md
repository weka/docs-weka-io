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

<table><thead><tr><th width="106">Mode</th><th width="313">Key storage</th><th>Use case</th></tr></thead><tbody><tr><td>Internal</td><td>Encryption key stored in the WEKA cluster configuration.</td><td>Evaluating encrypted filesystem performance. Not recommended for production.</td></tr><tr><td>Vault</td><td>Encryption key managed by HashiCorp Vault via Kubernetes authentication.</td><td>Production environments requiring an external KMS.</td></tr></tbody></table>

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

<table><thead><tr><th width="162">Field</th><th>Description</th></tr></thead><tbody><tr><td><code>address</code>*</td><td>Vault server address, for example <code>https://vault.example.com:8200</code>.</td></tr><tr><td><code>role</code>*</td><td>The Vault role to authenticate as. Must have a policy permitting access to the WEKA encryption key.</td></tr><tr><td><code>method</code>*</td><td>Vault authentication method. Only <code>kubernetes</code> is supported for Operator-managed deployments.</td></tr></tbody></table>

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
