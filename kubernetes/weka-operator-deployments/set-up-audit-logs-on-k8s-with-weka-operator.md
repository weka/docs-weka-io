---
description: >-
  Configure audit log exports to external destinations using the WEKA Kubernetes
  operator.
---

# Set up audit logs on K8s with WEKA Operator

## Set up audit logs

To configure audit log exports to external destinations using the WEKA Kubernetes Operator, the operator manages audit functionalities by co-scheduling a telemetry container with each compute process.

When an export is defined in the WekaCluster resource, it automatically enables the audit cluster, activates filesystem auditing, and registers the export destination.

#### Before you begin

* Ensure the WEKA Operator is deployed and running.
* Verify that a WekaCluster resource exists.
* Obtain a Splunk HEC token for the export destination.
* Ensure the Kubernetes cluster has sufficient resources for the telemetry containers: 1 CPU (request) / 4 CPU (limit) and 4 GiB RAM (request) / 32 GiB RAM (limit).
* Confirm Splunk HEC endpoint reachability from the Kubernetes cluster (DNS, firewall, proxy). Otherwise the setup “works” but exports fail.

#### Procedure

1.  **Create the Splunk token secret:** Create a Kubernetes Secret in the same namespace as the WekaCluster to store the HEC token:

    ```bash
    kubectl create secret generic splunk-secret \
    --from-literal=hec-token=<YOUR_SPLUNK_HEC_TOKEN> \
    --namespace <namespace>
    ```
2.  **Add the telemetry specification:** Open the WekaCluster YAML configuration and add the `spec.telemetry` section.

    ```yaml
    spec:
      telemetry:
        exports:
          - name: audit-to-splunk
            sources:
              - audit
            splunk:
              authTokenSecretRef: "splunk-secret.hec-token" # <secretName>.<keyName>
              endpoint: "https://splunk.example.com:8088/services/collector"
              caCertSecretRef: "splunk-ca-secret.ca.pem" #Optional
    ```
3.  **Apply the configuration:** Update the cluster with the new telemetry settings:

    ```bash
    kubectl apply -f <cluster-config>.yaml
    ```
4. **Verify the setup:**
   1.  Confirm the telemetry containers are running:

       ```bash
       kubectl get wekacontainers -n <namespace> | grep telemetry
       ```
   2.  Verify the operator registered the export:

       ```bash
       kubectl exec -n <namespace> <any-weka-pod> -- weka telemetry exports list
       ```
   3.  Confirm audit is enabled:

       ```bash
       kubectl exec -n <namespace> <any-weka-pod> -- weka audit cluster status
       ```

#### Audit parameters reference

Use these parameters in the `spec.telemetry` section to manage audit exports.

<table><thead><tr><th width="394.9090576171875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>exports[].name</code></td><td>The export name. The operator internally prefixes this with <code>operator-</code>.<br>Data type: String.</td></tr><tr><td><code>exports[].sources</code></td><td>Data sources to export. Use <code>["audit"]</code> for audit logs.<br>Data type: List of strings.</td></tr><tr><td><code>exports[].splunk.authTokenSecretRef</code></td><td>Reference to the Kubernetes Secret containing the HEC token using the <code>secretName.keyName</code> format.<br>Data type: String.</td></tr><tr><td><code>exports[].splunk.endpoint</code></td><td>The Splunk HEC URL destination.<br>Data type: String.</td></tr><tr><td><code>exports[].splunk.caCertSecretRef</code></td><td>Optional. Reference to a custom CA certificate secret (<code>secretName.keyName</code>). Mutually exclusive with <code>verifyWithClusterCACert</code>.<br>Data type: String.</td></tr><tr><td><code>exports[].splunk.allowUnverifiedCertificate</code></td><td>Optional. Skips TLS verification when set to true. For testing purposes only.<br>Data type: Boolean.</td></tr><tr><td><code>exports[].splunk.verifyWithClusterCACert</code></td><td>Optional. Uses the cluster's own CA for verification. It cannot be used simultaneously with <code>caCertSecretRef</code>.<br>Data type: Boolean.</td></tr></tbody></table>

#### Disable auditing

To disable auditing and remove the telemetry containers, remove all entries from the `exports` list or remove the `telemetry` key entirely from the specification.

```yaml
spec:
  telemetry:
    exports: []
```

**Related topic**

[audit-and-forwarding-management](../../operation-guide/audit-and-forwarding-management/ "mention")
