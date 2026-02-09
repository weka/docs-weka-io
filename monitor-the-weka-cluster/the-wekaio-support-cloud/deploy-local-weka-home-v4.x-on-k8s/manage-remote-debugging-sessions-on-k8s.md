---
description: >-
  Configure and control secure, real-time access for WEKA Customer Success Team
  to troubleshoot cluster issues using charts/wekahome/values.yaml on K8s
  deployment.
---

# Manage remote debugging sessions on K8s

### Overview

Collaborate with the WEKA Customer Success Team (CST) by establishing secure debugging sessions. When deploying the Local WEKA Home (LWH) on Kubernetes, you enable remote access  by overriding chart values to define one deployment per session within the `remoteSessionClient.sessions` block. This configuration allows you to grant WEKA CST controlled access to your environment to troubleshoot issues in real time through SSH (tmate[^1]) sessions.

## Configure remote access sessions

Configure the LWH Helm chart to enable and define remote session clients for Kubernetes clusters.

**Before you begin**

* Ensure the LWH Helm chart is available.
* Generate an SSH RSA key pair (`id_rsa` and `id_rsa.pub`).
* Identify the Cluster UUID from LWH for each cluster requiring access.

**Procedure**

1.  **Create the SSH keys secret:** Create a Kubernetes secret in the same namespace as the LWH release. The client mounts this secret at `/root/.ssh`.

    ```bash
    kubectl create secret generic remote-session-ssh-keys \
      --from-file=id_rsa=/path/to/id_rsa \
      --from-file=id_rsa.pub=/path/to/id_rsa.pub \
      -n <wekahome-namespace>
    ```
2.  **Define session parameters in the values file:** Update your `values.yaml` overrides to enable the client and define at least one session.

    ```yaml
    remoteSessionClient:
      enabled: true
      recordings:
        size: 10Gi
        accessMode: ReadWriteMany
      sessions:
        - name: "prod-cluster-1"
          clusterID: "550e8400-e29b-41d4-a716-446655440001"
          clusterName: "prod-cluster-1"
          sshKeysSecretName: "remote-session-ssh-keys"
    ```
3. **Apply the configuration:** Deploy the changes using your preferred method (for example, `helm upgrade`, ArgoCD sync, or Flux reconciliation).

## Remote session client configuration reference

The following table details the parameters available for the `remoteSessionClient` configuration in the `values.yaml` file.

{% hint style="info" %}
Required parameters are marked with an asterisk (\*); all other parameters are optional.
{% endhint %}

<table><thead><tr><th width="452">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>remoteSessionClient.sessions[].name</code>*</td><td>Unique session name used in the Process name.</td></tr><tr><td><code>remoteSessionClient.sessions[].clusterID</code>*</td><td>The UUID of the cluster.</td></tr><tr><td><code>remoteSessionClient.sessions[].clusterName</code>*</td><td>Human-readable name. Maximum 63 characters.</td></tr><tr><td><code>remoteSessionClient.sessions[].sshKeysSecretName</code>*</td><td>Name of the secret containing the SSH keys.</td></tr><tr><td><code>remoteSessionClient.enabled</code></td><td><p>When set to <code>true</code>, the recording PVC is created even if no remote sessions are defined.<br>Defining sessions is optional. If the session list is empty, no recordings occur.</p><p>If all sessions are removed while this option remains enabled, the recording PVC is retained.<br>Default: <code>false</code></p></td></tr><tr><td><code>remoteSessionClient.recordings.storageClass</code></td><td>Storage class for recordings PVC.<br>Default: <code>""</code></td></tr><tr><td><code>remoteSessionClient.recordings.size</code></td><td>Size of the recordings PVC.<br>Default: <code>10Gi</code></td></tr><tr><td><code>remoteSessionClient.recordings.accessMode</code></td><td><p>Access mode for recordings. Use <code>ReadWriteMany</code> for multi-server deployments.</p><p>Default: <code>ReadWriteMany</code></p></td></tr><tr><td><code>remoteSessionClient.sessions</code></td><td><p>List of session objects. At least one is required if enabled.</p><p>Default: <code>[]</code></p></td></tr><tr><td><code>remoteSessionClient.sessions[].hostName</code></td><td>Overrides the default container hostname.</td></tr><tr><td><code>remoteSessionClient.sessions[].terminalCols</code></td><td>Terminal width in columns.<br>Default: <code>158</code></td></tr><tr><td><code>remoteSessionClient.sessions[].terminalLines</code></td><td>Terminal height in lines.<br>Default: <code>35</code></td></tr><tr><td><code>remoteSessionClient.sessions[].debug</code></td><td>Set to true to enable debug logging for the session.<br>Default: <code>false</code></td></tr><tr><td><code>remoteSessionClient.sessions[].tmateServer</code></td><td>Custom tmate server configuration object.</td></tr><tr><td><code>remoteSessionClient.cloudURL</code></td><td>The LWH API endpoint.<br>Default: <code>https://api.home.weka.io</code></td></tr></tbody></table>

**Related information**

[charts/wekahome/values.yaml](https://github.com/weka/gohome/blob/v4.4.0/charts/wekahome/values.yaml)

### Multiple session configuration example

Define multiple sessions by adding entries to the `sessions` list. Each session creates a dedicated Process to manage the connection for a specific cluster.

Example:

```yaml
remoteSessionClient:
  enabled: true
  sessions:
    - name: "prod-cluster-1"
      clusterID: "550e8400-e29b-41d4-a716-446655440001"
      clusterName: "prod-cluster-1"
      sshKeysSecretName: "remote-session-ssh-keys"
    - name: "prod-cluster-2"
      clusterID: "550e8400-e29b-41d4-a716-446655440002"
      clusterName: "prod-cluster-2"
      sshKeysSecretName: "remote-session-ssh-keys"
      debug: true
      terminalCols: 158
      terminalLines: 35
```

#### Custom tmate server configuration

If the deployment requires a private tmate server instead of the default, define the `tmateServer` object. All sub-fields are required when this object is used.

Example:

<pre class="language-yaml"><code class="lang-yaml"><strong>- name: "my-cluster-session"
</strong>      clusterID: "550e8400-e29b-41d4-a716-446655440000"
      clusterName: "my-weka-cluster"
      sshKeysSecretName: "remote-session-ssh-keys"
      tmateServer:  # Custom tmate server (all sub-fields required if set)
        host: "tmate.example.com" 
        port: 22
        rsaFingerprint: "SHA256:..."
        ed25519Fingerprint: "SHA256:..."
        ecdsaFingerprint: "SHA256:..."
</code></pre>

<table><thead><tr><th width="272">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>host</code></td><td>Hostname of the custom tmate server.</td></tr><tr><td><code>port</code></td><td>Connection port (typically 22).</td></tr><tr><td><code>rsaFingerprint</code></td><td>RSA fingerprint of the server.</td></tr><tr><td><code>ed25519Fingerprint</code></td><td>Ed25519 fingerprint of the server.</td></tr><tr><td><code>ecdsaFingerprint</code></td><td>ECDSA fingerprint of the server.</td></tr></tbody></table>

[^1]: A terminal multiplexer that facilitates secure, instant terminal sharing by way of an SSH connection to a remote relay server.
