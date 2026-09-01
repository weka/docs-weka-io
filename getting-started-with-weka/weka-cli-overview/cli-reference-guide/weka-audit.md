---
description: Manage WEKA filesystem and cluster auditing.
---

# weka audit

Manage filesystem and cluster audit services.

```sh
weka audit
```

## weka audit cluster

Manage cluster-wide audit settings.

```sh
weka audit cluster
```

### weka audit cluster decrypt-filename

Manage decryption of filenames in audit traces.

```sh
weka audit cluster decrypt-filename
```

### weka audit cluster decrypt-fullpath

Manage decryption of full file paths in audit traces.

```sh
weka audit cluster decrypt-fullpath
```

### weka audit cluster disable

Disable audit logging cluster-wide. Audit is telemetry's only consumer, so this also disables cluster-wide telemetry.

```sh
weka audit cluster disable
```

### weka audit cluster enable

Enable audit logging cluster-wide. Audit is telemetry's only consumer, so this also enables cluster-wide telemetry.

```sh
weka audit cluster enable
```

### weka audit cluster enhancer

Manage audit logging enhancement.

```sh
weka audit cluster enhancer
```

### weka audit cluster resolve-paths

Manage resolution of full file paths in audit traces.

```sh
weka audit cluster resolve-paths
```

#### weka audit cluster resolve-paths disable

Disable resolving full file paths in audit traces.

```sh
weka audit cluster resolve-paths disable
```

#### weka audit cluster resolve-paths enable

Enable resolving full file paths in audit traces.

```sh
weka audit cluster resolve-paths enable
```

### weka audit cluster set-global-operations

Set which operations are audited cluster-wide. This replaces the operations set before.

```sh
weka audit cluster set-global-operations <operations>…
```

| Parameter       | Description                                                                                                                                               |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `operations`\*… | Operations to audit, or 'All', or 'None' to audit nothing. Valid values: open, create, read, modify, delete, rename, close, sessionmanagement, all, none. |

### weka audit cluster stats

Show cluster-wide audit statistics.

```sh
weka audit cluster stats
```

### weka audit cluster status

Show the cluster-wide audit configuration.

```sh
weka audit cluster status
```

**Columns:** `enabled`, `audit_traces_enabled`, `operations`, `resolve_full_file_paths`, `audit_enhancement_enabled`, `decrypt_fullpath`, `decrypt_filename`

## weka audit fs

Manage per-filesystem audit settings.

```sh
weka audit fs
```
