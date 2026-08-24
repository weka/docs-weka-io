---
description: Configure WEKA cloud connectivity and telemetry.
---

# weka cloud

Manage observability via cloud services.

```sh
weka cloud
```

## weka cloud disable

Turn cloud features off.

```sh
weka cloud disable
```

## weka cloud enable

Turn cloud features on.

```sh
weka cloud enable [--cloud-url <string>]
```

| Parameter               | Description                    |
| ----------------------- | ------------------------------ |
| `--cloud-url` \<string> | Base URL of the cloud service. |

## weka cloud proxy

Manage proxy settings used when connecting to the cloud.

```sh
weka cloud proxy
```

### weka cloud proxy reset

Reset the HTTP proxy used when connecting to the cloud. Direct HTTP connections will be used.

```sh
weka cloud proxy reset
```

### weka cloud proxy set

Set the HTTP proxy used when connecting to the cloud.

```sh
weka cloud proxy set <proxy>
```

| Parameter | Description           |
| --------- | --------------------- |
| `proxy`\* | The proxy URL to set. |

## weka cloud quota-analytics

Manage quota analytics reporting.

```sh
weka cloud quota-analytics
```

### weka cloud quota-analytics disable

Turn quota analytics reporting off.

```sh
weka cloud quota-analytics disable
```

### weka cloud quota-analytics enable

Turn quota analytics reporting on.

```sh
weka cloud quota-analytics enable
```

### weka cloud quota-analytics redact-paths

Manage quota analytics path redaction.

```sh
weka cloud quota-analytics redact-paths
```

#### weka cloud quota-analytics redact-paths off

Turn quota analytics path redaction off.

```sh
weka cloud quota-analytics redact-paths off
```

#### weka cloud quota-analytics redact-paths on

Turn quota analytics path redaction on.

```sh
weka cloud quota-analytics redact-paths on
```

### weka cloud quota-analytics status

Show quota analytics reporting and path redaction configuration.

```sh
weka cloud quota-analytics status
```

## weka cloud status

Show cloud connectivity status.

```sh
weka cloud status
```

**Columns:** `container`, `health`, `size`, `lastException`, `error`, `lastUpload`

## weka cloud upload-rate

Get the cloud upload rate.

```sh
weka cloud upload-rate
```

### weka cloud upload-rate set

Set the cloud upload rate.

```sh
weka cloud upload-rate set --bytes-per-second <rate>
```

| Parameter                      | Description                              |
| ------------------------------ | ---------------------------------------- |
| `--bytes-per-second` \<rate>\* | Maximum upload rate in bytes per second. |
