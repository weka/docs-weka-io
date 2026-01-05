---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/operation-guide/audit-and-forwarding-management/manage-audit-and-forwarding-using-the-cli
---

# Manage audit and forwarding using the CLI

You can use the `weka audit` commands to configure and manage the audit and forwarding feature. The commands are organized into the following groups:

* `weka audit cluster`: Manage audit settings at the cluster level.
* `weka audit fs`: Manage audit settings for specific filesystems.

## Manage cluster-level auditing

Use the `weka audit cluster` commands to control the audit feature for the entire cluster.

### **Enable or disable cluster-wide auditing**

The auditing functionality is disabled by default. Enable it at the cluster level before you can configure auditing for specific filesystems. This initial enablement sets up the necessary infrastructure and components required for the audit system to function.

*   To enable:

    ```
    weka audit cluster enable
    ```
*   To disable:

    ```
    weka audit cluster disable
    ```

### **View cluster audit status**

View the current cluster-wide status of the audit feature.

```
weka audit cluster status
```

### **View cluster audit statistics**

View detailed statistics about the audit logs for the entire cluster.

```
weka audit cluster stats
```

### **Set the global audit operations**

Defines the global default policy for which categories of operations are audited across the cluster. This policy applies to all filesystems but can be overridden by settings on an individual filesystem. You can choose to audit `all` categories or specify a subset (for example, `read`, `delete`).

```
weka audit cluster set-global-operations [<operations>]...
```

**Parameter**

<table><thead><tr><th width="155.77734375">Name</th><th>Description</th></tr></thead><tbody><tr><td><code>operations</code>*</td><td><p>A space-separated list of operation categories to audit. Providing a new list replaces any previously set global operations.</p><p>Values: <code>all</code>, <code>none</code>, <code>open</code>, <code>create</code>, <code>read</code>, <code>modify</code>, <code>delete</code>, <code>rename</code>, <code>close</code>, <code>sessionmanagement</code>.</p></td></tr></tbody></table>

### **Manage full path resolution**

Use the following commands to control the asynchronous process that adds full file paths to audit events. Including full paths provides valuable context for each operation but may introduce a performance impact. Disabling this feature can increase event throughput if the path information is not required for your use case.

*   To enable resolution of full file paths in forwarded audit events:

    ```
    weka audit cluster resolve-paths enable
    ```
*   To disable the resolution of full file paths in forwarded audit events.:

    ```
    weka audit cluster resolve-paths disable
    ```

## Manage filesystem-level auditing

Use the `weka audit fs` commands to control audit settings for individual filesystems.

### **View filesystem audit status**

List the audit status for all filesystems or a specific filesystem.

```
weka audit fs status [--name name]
```

**Parameter**

<table><thead><tr><th width="181.84765625">Name</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code></td><td>The name of a specific filesystem to view.</td></tr></tbody></table>

### **Enable or disable auditing for a filesystem**

Enable or disable auditing on a specific filesystem.

*   To enable:

    ```
    weka audit fs enable <name>
    ```
*   To disable:

    ```
    weka audit fs disable <name>
    ```

**Parameter**

<table><thead><tr><th width="168.8671875">Name</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The name of the filesystem on which to enable or disable auditing.</td></tr></tbody></table>

**Related topics**

[managing-filesystems.md](../../weka-filesystems-and-object-stores/managing-filesystems/managing-filesystems.md "mention")

[managing-filesystems-1.md](../../weka-filesystems-and-object-stores/managing-filesystems/managing-filesystems-1.md "mention")

### **Set audit operations for a specific filesystem**

Override the global audit settings and define a specific set of operations to audit for an individual filesystem.

```
weka audit fs set-operations <name> [<operations>]...
```

**Parameters**

<table><thead><tr><th width="175.796875">Name</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The name of the filesystem to configure.</td></tr><tr><td><code>operations</code>*</td><td><p>A space-separated list of operation categories to audit. This list replaces any previously set operations for this filesystem.</p><p>Possible values: <code>all</code>, <code>none</code>, <code>open</code>, <code>create</code>, <code>read</code>, <code>modify</code>, <code>delete</code>, <code>rename</code>, <code>close</code>, <code>sessionmanagement</code>.</p></td></tr></tbody></table>
