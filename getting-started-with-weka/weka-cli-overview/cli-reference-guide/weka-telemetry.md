# weka telemetry

Manage telemetry exports.

```sh
weka telemetry
```

## weka telemetry exports

Manage telemetry export destinations.

```sh
weka telemetry exports
```

### weka telemetry exports add

Add a new telemetry export destination.

```sh
weka telemetry exports add
```

#### weka telemetry exports add kafka

Add a new Kafka telemetry export destination.

```sh
weka telemetry exports add kafka <name> [--allow-unverified-certificate] [--ca-cert <string>] [--disabled] [--key-field <string>] [--sasl-mechanism <kafka-sasl-mechanism>] [--sasl-password <string>] [--sasl-username <string>] [--sources <source-type>…] [--target <string>] [--topic <string>] [--use-sasl] [--verify-with-cluster-cacert] [--without-sources]
```

| Parameter                                  | Description                                                                                                                                               |
| ------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                                   | Name for the new export.                                                                                                                                  |
| `--allow-unverified-certificate`           | Allow connecting to the export's target without verifying its TLS certificate.                                                                            |
| `--ca-cert` \<string>                      | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                |
| `--disabled`                               | Create the export in a disabled state.                                                                                                                    |
| `--key-field` \<string>                    | Message field to use as the Kafka record key.                                                                                                             |
| `--sasl-mechanism` \<kafka-sasl-mechanism> | SASL mechanism: plain, scram-sha-256, or scram-sha-512.                                                                                                   |
| `--sasl-password` \<string>                | SASL password.                                                                                                                                            |
| `--sasl-username` \<string>                | SASL username.                                                                                                                                            |
| `--sources` \<source-type>…                | Telemetry source to attach to this export. Repeat to attach multiple. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>                       | Destination target (host:port or URL) for the export.                                                                                                     |
| `--topic` \<string>                        | Kafka topic to publish telemetry to.                                                                                                                      |
| `--use-sasl`                               | Authenticate to the Kafka brokers using SASL.                                                                                                             |
| `--verify-with-cluster-cacert`             | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                             |
| `--without-sources`                        | Create the export with no sources attached, without being prompted for --sources.                                                                         |

#### weka telemetry exports add s3

Add a new S3 telemetry export destination.

```sh
weka telemetry exports add s3 <name> [--access-key-id <string>] [--allow-unverified-certificate] [--bucket-name <string>] [--ca-cert <string>] [--disabled] [--region <string>] [--secret-key <string>] [--sources <source-type>…] [--target <string>] [--verify-with-cluster-cacert] [--without-sources]
```

| Parameter                        | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                         | Name for the new export.                                                                                                                                  |
| `--access-key-id` \<string>      | S3 access key ID.                                                                                                                                         |
| `--allow-unverified-certificate` | Allow connecting to the export's target without verifying its TLS certificate.                                                                            |
| `--bucket-name` \<string>        | Name of the S3 bucket to export telemetry to.                                                                                                             |
| `--ca-cert` \<string>            | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                |
| `--disabled`                     | Create the export in a disabled state.                                                                                                                    |
| `--region` \<string>             | S3 bucket region.                                                                                                                                         |
| `--secret-key` \<string>         | S3 secret access key.                                                                                                                                     |
| `--sources` \<source-type>…      | Telemetry source to attach to this export. Repeat to attach multiple. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>             | Destination target (host:port or URL) for the export.                                                                                                     |
| `--verify-with-cluster-cacert`   | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                             |
| `--without-sources`              | Create the export with no sources attached, without being prompted for --sources.                                                                         |

#### weka telemetry exports add splunk

Add a new Splunk telemetry export destination.

```sh
weka telemetry exports add splunk <name> [--allow-unverified-certificate] [--auth-token <string>] [--ca-cert <string>] [--disabled] [--sources <source-type>…] [--target <string>] [--verify-with-cluster-cacert] [--without-sources]
```

| Parameter                        | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                         | Name for the new export.                                                                                                                                  |
| `--allow-unverified-certificate` | Allow connecting to the export's target without verifying its TLS certificate.                                                                            |
| `--auth-token` \<string>         | Splunk HTTP Event Collector authentication token.                                                                                                         |
| `--ca-cert` \<string>            | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                |
| `--disabled`                     | Create the export in a disabled state.                                                                                                                    |
| `--sources` \<source-type>…      | Telemetry source to attach to this export. Repeat to attach multiple. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>             | Destination target (host:port or URL) for the export.                                                                                                     |
| `--verify-with-cluster-cacert`   | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                             |
| `--without-sources`              | Create the export with no sources attached, without being prompted for --sources.                                                                         |

#### weka telemetry exports add syslog

Add a new Syslog telemetry export destination.

```sh
weka telemetry exports add syslog <name> [--allow-unverified-certificate] [--ca-cert <string>] [--disabled] [--facility <syslog-facility>] [--mode <syslog-mode>] [--rfc <syslog-rfc>] [--sources <source-type>…] [--target <string>] [--verify-with-cluster-cacert] [--without-sources]
```

| Parameter                        | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                         | Name for the new export.                                                                                                                                  |
| `--allow-unverified-certificate` | Allow connecting to the export's target without verifying its TLS certificate.                                                                            |
| `--ca-cert` \<string>            | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                |
| `--disabled`                     | Create the export in a disabled state.                                                                                                                    |
| `--facility` \<syslog-facility>  | Syslog facility: local0 through local7 (default local0).                                                                                                  |
| `--mode` \<syslog-mode>          | Syslog transport mode: tcp or udp (default tcp).                                                                                                          |
| `--rfc` \<syslog-rfc>            | Syslog message framing: rfc5424 or rfc3164 (default rfc5424).                                                                                             |
| `--sources` \<source-type>…      | Telemetry source to attach to this export. Repeat to attach multiple. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>             | Destination target (host:port or URL) for the export.                                                                                                     |
| `--verify-with-cluster-cacert`   | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                             |
| `--without-sources`              | Create the export with no sources attached, without being prompted for --sources.                                                                         |

### weka telemetry exports attach

Attach sources to a telemetry export.

```sh
weka telemetry exports attach <export-id> <sources>…
```

| Parameter     | Description                     |
| ------------- | ------------------------------- |
| `export-id`\* | Export ID to attach sources to. |
| `sources`\*…  | Sources to attach.              |

### weka telemetry exports detach

Detach sources from a telemetry export.

```sh
weka telemetry exports detach <export-id> <sources>… [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `export-id`\*   | Export ID to detach sources from.                               |
| `sources`\*…    | Sources to detach.                                              |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka telemetry exports disable

Disable a telemetry export.

```sh
weka telemetry exports disable <export-id>
```

| Parameter     | Description           |
| ------------- | --------------------- |
| `export-id`\* | Export ID to disable. |

### weka telemetry exports enable

Enable a telemetry export.

```sh
weka telemetry exports enable <export-id>
```

| Parameter     | Description          |
| ------------- | -------------------- |
| `export-id`\* | Export ID to enable. |

### weka telemetry exports list

List configured telemetry export destinations.

```sh
weka telemetry exports list [--name <string>] [--type <export-type>]
```

| Parameter               | Description                                                   |
| ----------------------- | ------------------------------------------------------------- |
| `--name` \<string>      | Show only the export with this exact name (case-insensitive). |
| `--type` \<export-type> | Show only exports of this type.                               |

**Columns:** `id`, `name`, `enabled`, `export_type`, `target`, `sources`

### weka telemetry exports remove

Remove a telemetry export.

```sh
weka telemetry exports remove <export-id> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `export-id`\*   | Export ID to remove.                                            |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka telemetry exports status

Show the current status of every telemetry export.

```sh
weka telemetry exports status
```

**Columns:** `export_id`, `name`, `state`, `servers`, `containers_reporting`

### weka telemetry exports update

Update an existing telemetry export's configuration.

```sh
weka telemetry exports update
```

#### weka telemetry exports update kafka

Update an existing Kafka telemetry export's configuration.

```sh
weka telemetry exports update kafka <export-id> [--allow-unverified-certificate] [--ca-cert <string>] [--clear-tls-settings] [--key-field <string>] [--name <string>] [--sasl-mechanism <kafka-sasl-mechanism>] [--sasl-password <string>] [--sasl-username <string>] [--sources <source-type>…] [--target <string>] [--topic <string>] [--use-sasl] [--verify-with-cluster-cacert]
```

| Parameter                                  | Description                                                                                                                                                                                  |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `export-id`\*                              | Export ID to update.                                                                                                                                                                         |
| `--allow-unverified-certificate`           | Allow connecting to the export's target without verifying its TLS certificate.                                                                                                               |
| `--ca-cert` \<string>                      | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                                                   |
| `--clear-tls-settings`                     | Clear the export's TLS settings, reverting it to the default (unverified) certificate handling.                                                                                              |
| `--key-field` \<string>                    | New message field to use as the Kafka record key.                                                                                                                                            |
| `--name` \<string>                         | New name for the export.                                                                                                                                                                     |
| `--sasl-mechanism` \<kafka-sasl-mechanism> | New SASL mechanism: plain, scram-sha-256, or scram-sha-512.                                                                                                                                  |
| `--sasl-password` \<string>                | New SASL password.                                                                                                                                                                           |
| `--sasl-username` \<string>                | New SASL username.                                                                                                                                                                           |
| `--sources` \<source-type>…                | Attach this source to the export. Repeat to attach multiple. Sources cannot be removed here; use detach. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>                       | New destination target (host:port or URL) for the export.                                                                                                                                    |
| `--topic` \<string>                        | New Kafka topic to publish telemetry to.                                                                                                                                                     |
| `--use-sasl`                               | Enable or disable SASL authentication to the Kafka brokers.                                                                                                                                  |
| `--verify-with-cluster-cacert`             | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                                                                |

#### weka telemetry exports update s3

Update an existing S3 telemetry export's configuration.

```sh
weka telemetry exports update s3 <export-id> [--access-key-id <string>] [--allow-unverified-certificate] [--bucket-name <string>] [--ca-cert <string>] [--clear-tls-settings] [--name <string>] [--region <string>] [--secret-key <string>] [--sources <source-type>…] [--target <string>] [--verify-with-cluster-cacert]
```

| Parameter                        | Description                                                                                                                                                                                  |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `export-id`\*                    | Export ID to update.                                                                                                                                                                         |
| `--access-key-id` \<string>      | New S3 access key ID.                                                                                                                                                                        |
| `--allow-unverified-certificate` | Allow connecting to the export's target without verifying its TLS certificate.                                                                                                               |
| `--bucket-name` \<string>        | New name of the S3 bucket to export telemetry to.                                                                                                                                            |
| `--ca-cert` \<string>            | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                                                   |
| `--clear-tls-settings`           | Clear the export's TLS settings, reverting it to the default (unverified) certificate handling.                                                                                              |
| `--name` \<string>               | New name for the export.                                                                                                                                                                     |
| `--region` \<string>             | New S3 bucket region.                                                                                                                                                                        |
| `--secret-key` \<string>         | New S3 secret access key.                                                                                                                                                                    |
| `--sources` \<source-type>…      | Attach this source to the export. Repeat to attach multiple. Sources cannot be removed here; use detach. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>             | New destination target (host:port or URL) for the export.                                                                                                                                    |
| `--verify-with-cluster-cacert`   | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                                                                |

#### weka telemetry exports update splunk

Update an existing Splunk telemetry export's configuration.

```sh
weka telemetry exports update splunk <export-id> [--allow-unverified-certificate] [--auth-token <string>] [--ca-cert <string>] [--clear-tls-settings] [--name <string>] [--sources <source-type>…] [--target <string>] [--verify-with-cluster-cacert]
```

| Parameter                        | Description                                                                                                                                                                                  |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `export-id`\*                    | Export ID to update.                                                                                                                                                                         |
| `--allow-unverified-certificate` | Allow connecting to the export's target without verifying its TLS certificate.                                                                                                               |
| `--auth-token` \<string>         | New Splunk HTTP Event Collector authentication token.                                                                                                                                        |
| `--ca-cert` \<string>            | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                                                   |
| `--clear-tls-settings`           | Clear the export's TLS settings, reverting it to the default (unverified) certificate handling.                                                                                              |
| `--name` \<string>               | New name for the export.                                                                                                                                                                     |
| `--sources` \<source-type>…      | Attach this source to the export. Repeat to attach multiple. Sources cannot be removed here; use detach. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>             | New destination target (host:port or URL) for the export.                                                                                                                                    |
| `--verify-with-cluster-cacert`   | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                                                                |

#### weka telemetry exports update syslog

Update an existing Syslog telemetry export's configuration.

```sh
weka telemetry exports update syslog <export-id> [--allow-unverified-certificate] [--ca-cert <string>] [--clear-tls-settings] [--facility <syslog-facility>] [--mode <syslog-mode>] [--name <string>] [--rfc <syslog-rfc>] [--sources <source-type>…] [--target <string>] [--verify-with-cluster-cacert]
```

| Parameter                        | Description                                                                                                                                                                                  |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `export-id`\*                    | Export ID to update.                                                                                                                                                                         |
| `--allow-unverified-certificate` | Allow connecting to the export's target without verifying its TLS certificate.                                                                                                               |
| `--ca-cert` \<string>            | Path to a PEM-encoded CA certificate file to verify the export's TLS connection against (max 16384 bytes).                                                                                   |
| `--clear-tls-settings`           | Clear the export's TLS settings, reverting it to the default (unverified) certificate handling.                                                                                              |
| `--facility` \<syslog-facility>  | New Syslog facility: local0 through local7.                                                                                                                                                  |
| `--mode` \<syslog-mode>          | New Syslog transport mode: tcp or udp.                                                                                                                                                       |
| `--name` \<string>               | New name for the export.                                                                                                                                                                     |
| `--rfc` \<syslog-rfc>            | New Syslog message framing: rfc5424 or rfc3164.                                                                                                                                              |
| `--sources` \<source-type>…      | Attach this source to the export. Repeat to attach multiple. Sources cannot be removed here; use detach. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--target` \<string>             | New destination target (host:port or URL) for the export.                                                                                                                                    |
| `--verify-with-cluster-cacert`   | Verify the export's TLS certificate against the cluster's own CA certificate.                                                                                                                |
