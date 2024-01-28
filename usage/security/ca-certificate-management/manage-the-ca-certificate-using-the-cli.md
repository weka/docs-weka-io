# Manage the CA certificate using the CLI

The system uses well-known CA certificates to establish trust with external services. For example, when using a KMS. If a different CA certificate is required for WEKA servers to establish trust, set this custom CA certificate on the WEKA servers.

Use the CLI command:

`weka security ca-cert set [--cert-file cert-file]`

**Parameters**

<table><thead><tr><th width="179">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>cert-file</code></td><td>Path to the certificate file.</td></tr></tbody></table>
