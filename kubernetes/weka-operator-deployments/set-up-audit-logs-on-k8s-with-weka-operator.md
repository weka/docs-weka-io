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

| Parameter | Description |
| --- | --- |
| `exports[].name` | The export name. The operator internally prefixes this with `operator-`.Data type: String. |
| `exports[].sources` | Data sources to export. Use `["audit"]` for audit logs.Data type: List of strings. |
| `exports[].splunk.authTokenSecretRef` | Reference to the Kubernetes Secret containing the HEC token using the `secretName.keyName` format.Data type: String. |
| `exports[].splunk.endpoint` | The Splunk HEC URL destination.Data type: String. |
| `exports[].splunk.caCertSecretRef` | Optional. Reference to a custom CA certificate secret (`secretName.keyName`). Mutually exclusive with `verifyWithClusterCACert`.Data type: String. |
| `exports[].splunk.allowUnverifiedCertificate` | Optional. Skips TLS verification when set to true. For testing purposes only.Data type: Boolean. |
| `exports[].splunk.verifyWithClusterCACert` | Optional. Uses the cluster's own CA for verification. It cannot be used simultaneously with `caCertSecretRef`.Data type: Boolean. |

#### Disable auditing

To disable auditing and remove the telemetry containers, remove all entries from the `exports` list or remove the `telemetry` key entirely from the specification.

```yaml
spec:
  telemetry:
    exports: []
```

**Related topic**

[audit-and-forwarding-management](../../operation-guide/audit-and-forwarding-management/ "mention")
