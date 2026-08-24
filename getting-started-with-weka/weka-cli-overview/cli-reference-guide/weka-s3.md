---
description: Manage the WEKA S3 service.
---

# weka s3

Manage the WEKA S3 service.

```sh
weka s3
```

## weka s3 bucket

Manage S3 cluster buckets.

```sh
weka s3 bucket
```

### weka s3 bucket add

Add an S3 bucket.

```sh
weka s3 bucket add <name> [--existing-path <string>] [--force] [--fs-id <fs-id>] [--fs-name <string>] [--hard-quota <capacity>] [--object-locking-on] [--policy <bucket-policy>] [--policy-json <string>]
```

| Parameter                   | Description                                                                                         |
| --------------------------- | --------------------------------------------------------------------------------------------------- |
| `name`\*                    | Name of the bucket to create.                                                                       |
| `--existing-path` \<string> | Existing path to use for the bucket.                                                                |
| `-f`, `--force`             | Force when existing path has quota.                                                                 |
| `--fs-id` \<fs-id>          | Filesystem ID for the bucket.                                                                       |
| `--fs-name` \<string>       | Filesystem name for the bucket.                                                                     |
| `--hard-quota` \<capacity>  | Hard limit for the directory.                                                                       |
| `--object-locking-on`       | Enable S3 Object Lock on the bucket (creation-time only; requires cluster-wide versioning support). |
| `--policy` \<bucket-policy> | Existing S3 IAM policy to assign to the bucket.                                                     |
| `--policy-json` \<string>   | Path to policy file. File must contain JSON definition of policy.                                   |

### weka s3 bucket checksum

Configure S3 bucket checksums.

```sh
weka s3 bucket checksum
```

#### weka s3 bucket checksum get

Get the checksum mode of a bucket.

```sh
weka s3 bucket checksum get <name>
```

| Parameter | Description         |
| --------- | ------------------- |
| `name`\*  | Name of the bucket. |

#### weka s3 bucket checksum reset

Reset the checksum mode for a bucket to the default (MD5).

```sh
weka s3 bucket checksum reset <name>
```

| Parameter | Description         |
| --------- | ------------------- |
| `name`\*  | Name of the bucket. |

#### weka s3 bucket checksum set

Set the checksum mode for a bucket.

```sh
weka s3 bucket checksum set <name> <checksum>
```

| Parameter    | Description                          |
| ------------ | ------------------------------------ |
| `name`\*     | Name of the bucket.                  |
| `checksum`\* | Checksum mode to set for the bucket. |

### weka s3 bucket etag-alg

Manage ETag algorithm for a specific S3 performance bucket.

```sh
weka s3 bucket etag-alg
```

#### weka s3 bucket etag-alg reset

Reset the ETag algorithm for a performance bucket to inherit the cluster default.

```sh
weka s3 bucket etag-alg reset <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

#### weka s3 bucket etag-alg set

Set the ETag algorithm for a performance bucket.

```sh
weka s3 bucket etag-alg set <name> <algorithm> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `algorithm`\*   | ETag algorithm to set for the bucket.                           |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 bucket integrity-mode

Manage integrity handling for a specific S3 performance bucket.

```sh
weka s3 bucket integrity-mode
```

#### weka s3 bucket integrity-mode reset

Reset the integrity mode for a performance bucket to inherit the cluster default.

```sh
weka s3 bucket integrity-mode reset <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

#### weka s3 bucket integrity-mode set

Set the integrity mode for a performance bucket.

```sh
weka s3 bucket integrity-mode set <name> <mode> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `mode`\*        | Integrity mode to set for the bucket.                           |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 bucket lifecycle-rule

Manage S3 bucket lifecycle rules.

```sh
weka s3 bucket lifecycle-rule
```

#### weka s3 bucket lifecycle-rule add

Add a lifecycle rule to an S3 bucket.

```sh
weka s3 bucket lifecycle-rule add <name> <expiry-days> [--noncurrent] [--prefix <string>] [--tags <string>]
```

| Parameter            | Description                                                             |
| -------------------- | ----------------------------------------------------------------------- |
| `name`\*             | Name of the S3 bucket.                                                  |
| `expiry-days`\*      | Number of days after which objects expire.                              |
| `--noncurrent`       | Apply expiry to noncurrent object versions only (not current versions). |
| `--prefix` \<string> | Object key prefix to which the rule applies.                            |
| `--tags` \<string>   | Object tags to which the rule applies.                                  |

#### weka s3 bucket lifecycle-rule list

List all lifecycle rules of an S3 bucket.

```sh
weka s3 bucket lifecycle-rule list <name>
```

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\*  | Name of the S3 bucket. |

**Columns:** `uid`, `id`, `expires`, `expiry_date`, `prefix`, `tags`, `noncurrent`

#### weka s3 bucket lifecycle-rule remove

Remove a lifecycle rule from an S3 bucket.

```sh
weka s3 bucket lifecycle-rule remove <name> <rule>
```

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\*  | Name of the S3 bucket. |
| `rule`\*  | Rule ID to remove.     |

#### weka s3 bucket lifecycle-rule reset

Reset all lifecycle rules of an S3 bucket.

```sh
weka s3 bucket lifecycle-rule reset <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 bucket list

Show all the buckets on the S3 cluster.

```sh
weka s3 bucket list
```

**Columns:** `name`, `hard`, `used`, `path`, `fs`, `versioning`, `object-lock`

### weka s3 bucket notification

Manage bucket notification configurations.

```sh
weka s3 bucket notification
```

#### weka s3 bucket notification add

Add a notification for a bucket.

```sh
weka s3 bucket notification add <name> --target-name <string> --target-type <target-type> [--events <string>] [--filter-prefix <string>] [--filter-suffix <string>]
```

| Parameter                        | Description                            |
| -------------------------------- | -------------------------------------- |
| `name`\*                         | Name of the bucket.                    |
| `--target-name` \<string>\*      | S3 bucket notification target name.    |
| `--target-type` \<target-type>\* | S3 bucket notification target type.    |
| `--events` \<string>             | Comma-separated list of events.        |
| `--filter-prefix` \<string>      | Filter prefix for notification events. |
| `--filter-suffix` \<string>      | Filter suffix for notification events. |

#### weka s3 bucket notification list

List notifications for a bucket.

```sh
weka s3 bucket notification list <name>
```

| Parameter | Description         |
| --------- | ------------------- |
| `name`\*  | Name of the bucket. |

**Columns:** `target_type`, `target_name`, `events`, `filter_prefix`, `filter_suffix`

#### weka s3 bucket notification remove

Remove a notification for a bucket.

```sh
weka s3 bucket notification remove <name> --target-name <string> --target-type <target-type> [--events <string>] [--filter-prefix <string>] [--filter-suffix <string>]
```

| Parameter                        | Description                            |
| -------------------------------- | -------------------------------------- |
| `name`\*                         | Name of the bucket.                    |
| `--target-name` \<string>\*      | S3 bucket notification target name.    |
| `--target-type` \<target-type>\* | S3 bucket notification target type.    |
| `--events` \<string>             | Comma-separated list of events.        |
| `--filter-prefix` \<string>      | Filter prefix for notification events. |
| `--filter-suffix` \<string>      | Filter suffix for notification events. |

### weka s3 bucket policy

Manage the policy for an S3 bucket.

```sh
weka s3 bucket policy
```

#### weka s3 bucket policy get

Get S3 policy for a bucket.

```sh
weka s3 bucket policy get <bucket-name>
```

| Parameter       | Description         |
| --------------- | ------------------- |
| `bucket-name`\* | Name of the bucket. |

#### weka s3 bucket policy get-json

Get S3 policy for a bucket in expanded JSON.

```sh
weka s3 bucket policy get-json <bucket-name>
```

| Parameter       | Description         |
| --------------- | ------------------- |
| `bucket-name`\* | Name of the bucket. |

#### weka s3 bucket policy reset

Reset the configured S3 policy for a bucket.

```sh
weka s3 bucket policy reset <bucket-name>
```

| Parameter       | Description         |
| --------------- | ------------------- |
| `bucket-name`\* | Name of the bucket. |

#### weka s3 bucket policy set

Set S3 policy for a bucket.

```sh
weka s3 bucket policy set <bucket-name> <bucket-policy>
```

| Parameter         | Description                            |
| ----------------- | -------------------------------------- |
| `bucket-name`\*   | Name of the bucket.                    |
| `bucket-policy`\* | S3 IAM policy to assign to the bucket. |

#### weka s3 bucket policy set-custom

Set a custom S3 policy for a bucket.

```sh
weka s3 bucket policy set-custom <bucket-name> <policy-file>
```

| Parameter       | Description                                 |
| --------------- | ------------------------------------------- |
| `bucket-name`\* | Name of the bucket.                         |
| `policy-file`\* | Path to file containing custom JSON policy. |

### weka s3 bucket quota

Manage the S3 bucket hard limit (quota) on space.

```sh
weka s3 bucket quota
```

#### weka s3 bucket quota reset

Reset the hard limit on bucket disk usage.

```sh
weka s3 bucket quota reset <name>
```

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\*  | Name of the S3 bucket. |

#### weka s3 bucket quota set

Set the hard limit of bucket disk usage.

```sh
weka s3 bucket quota set <name> <hard-quota>
```

| Parameter      | Description                          |
| -------------- | ------------------------------------ |
| `name`\*       | Name of the S3 bucket.               |
| `hard-quota`\* | Hard limit for directory disk usage. |

### weka s3 bucket remove

Remove an S3 bucket.

```sh
weka s3 bucket remove <name> [--force] [--unlink]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the bucket to remove.                                   |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--unlink`      | Leave the data directory in place after removal.                |

### weka s3 bucket sorting

Manage LIST operation sorting for a specific S3 performance bucket.

```sh
weka s3 bucket sorting
```

#### weka s3 bucket sorting reset

Reset the LIST sorting mode for a performance bucket to inherit the cluster default.

```sh
weka s3 bucket sorting reset <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

#### weka s3 bucket sorting set

Set the LIST sorting mode for a performance bucket.

```sh
weka s3 bucket sorting set <name> <mode> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Name of the S3 bucket.                                          |
| `mode`\*        | Sorting mode to set for the bucket.                             |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 bucket versioning

Manage S3 bucket versioning.

```sh
weka s3 bucket versioning
```

#### weka s3 bucket versioning enable

Enable versioning for an S3 bucket.

```sh
weka s3 bucket versioning enable <name>
```

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\*  | Name of the S3 bucket. |

#### weka s3 bucket versioning get

Get the versioning mode of an S3 bucket.

```sh
weka s3 bucket versioning get <name>
```

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\*  | Name of the S3 bucket. |

#### weka s3 bucket versioning suspend

Suspend versioning for an S3 bucket.

```sh
weka s3 bucket versioning suspend <name>
```

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\*  | Name of the S3 bucket. |

## weka s3 cluster

Manage S3 cluster configuration.

```sh
weka s3 cluster
```

### weka s3 cluster add

Create an S3 cluster backed by WEKA.

```sh
weka s3 cluster add <config-fs-name>… [--all-servers] [--allow-versioning] [--anonymous-posix-gid <uint>] [--anonymous-posix-uid <uint>] [--container <container-ids>…] [--default-fs-name <string>] [--domain <strings>…] [--force] [--max-buckets-limit <uint>] [--port <uint16>]
```

| Parameter                       | Description                                                                                                                 |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `config-fs-name`\*…             | Filesystem name for S3 configuration storage.                                                                               |
| `--all-servers`                 | Install S3 on all servers.                                                                                                  |
| `--allow-versioning`            | Enable S3 versioning (default off, cannot be disabled once enabled).                                                        |
| `--anonymous-posix-gid` \<uint> | POSIX GID for anonymous users.                                                                                              |
| `--anonymous-posix-uid` \<uint> | POSIX UID for anonymous users.                                                                                              |
| `--container` \<container-ids>… | Containers that will serve S3 protocol. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--default-fs-name` \<string>   | Default filesystem name for S3 buckets.                                                                                     |
| `--domain` \<strings>…          | Virtual host-style domains. Multiple values may be supplied separated by commas, or the option may be repeated.             |
| `-f`, `--force`                 | Force action. Perform this action without further confirmation.                                                             |
| `--max-buckets-limit` \<uint>   | Maximum buckets that can be created.                                                                                        |
| `--port` \<uint16>              | S3 service port.                                                                                                            |

### weka s3 cluster audit-webhook

Manage the webhook used for auditing S3 activity.

```sh
weka s3 cluster audit-webhook
```

#### weka s3 cluster audit-webhook batch-config

Configure batch settings for the audit webhook without restart.

```sh
weka s3 cluster audit-webhook batch-config [--batch-count <uint>] [--batch-mode <string>] [--batch-size <uint>] [--batch-time <string>]
```

| Parameter                | Description                        |
| ------------------------ | ---------------------------------- |
| `--batch-count` \<uint>  | Batch event count threshold.       |
| `--batch-mode` \<string> | Batch mode for audit logging.      |
| `--batch-size` \<uint>   | Batch size threshold in bytes.     |
| `--batch-time` \<string> | Batch time threshold (e.g. 500ms). |

#### weka s3 cluster audit-webhook disable

Disable the S3 audit webhook.

```sh
weka s3 cluster audit-webhook disable
```

#### weka s3 cluster audit-webhook enable

Enable the S3 audit webhook on the S3 cluster.

```sh
weka s3 cluster audit-webhook enable --auth-token <string> --endpoint <string>
```

| Parameter                  | Description                   |
| -------------------------- | ----------------------------- |
| `--auth-token` \<string>\* | Webhook authentication token. |
| `--endpoint` \<string>\*   | Webhook endpoint URL.         |

#### weka s3 cluster audit-webhook show

Show the S3 audit webhook configuration.

```sh
weka s3 cluster audit-webhook show
```

**Columns:** `enabled`, `endpoint`, `auth_token`

### weka s3 cluster container

Manage containers used in the S3 cluster.

```sh
weka s3 cluster container
```

#### weka s3 cluster container add

Add containers to the S3 cluster.

```sh
weka s3 cluster container add <container-id>…
```

| Parameter         | Description                          |
| ----------------- | ------------------------------------ |
| `container-id`\*… | Containers to add to the S3 cluster. |

#### weka s3 cluster container list

List containers in the S3 cluster.

```sh
weka s3 cluster container list
```

**Columns:** `container`

#### weka s3 cluster container remove

Remove containers from the S3 cluster.

```sh
weka s3 cluster container remove <container-id>…
```

| Parameter         | Description                               |
| ----------------- | ----------------------------------------- |
| `container-id`\*… | Containers to remove from the S3 cluster. |

### weka s3 cluster etag-alg

Manage ETag algorithm for all S3 Performance Buckets.

```sh
weka s3 cluster etag-alg
```

#### weka s3 cluster etag-alg reset

Reset the ETag algorithm for all S3 Performance Buckets, forcing them to inherit the cluster's global default.

```sh
weka s3 cluster etag-alg reset [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 cluster integrity-mode

Manage integrity handling for all S3 Performance Buckets.

```sh
weka s3 cluster integrity-mode
```

#### weka s3 cluster integrity-mode reset

Reset the integrity handling for all S3 Performance Buckets, forcing them to inherit the cluster's global default.

```sh
weka s3 cluster integrity-mode reset [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 cluster notification-target

Manage notification targets for S3.

```sh
weka s3 cluster notification-target
```

#### weka s3 cluster notification-target add

Add a new bucket notification target.

```sh
weka s3 cluster notification-target add --brokers <strings>… --name <string> --topic <string> --type <target-type> [--kafka-version <string>] [--sasl] [--sasl-mechanism <sasl-mechanism>] [--sasl-password <string>] [--sasl-username <string>] [--tls] [--tls-cert <string>] [--tls-skip-verify]
```

| Parameter                            | Description                                                                                                                             |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| `--brokers` \<strings>\*…            | Kafka brokers to which events will be sent (max 8). Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--name` \<string>\*                 | Notification target name.                                                                                                               |
| `--topic` \<string>\*                | Kafka topic for generated messages.                                                                                                     |
| `--type` \<target-type>\*            | Notification target type.                                                                                                               |
| `--kafka-version` \<string>          | Kafka version.                                                                                                                          |
| `--sasl`                             | Enable SASL authentication.                                                                                                             |
| `--sasl-mechanism` \<sasl-mechanism> | SASL mechanism.                                                                                                                         |
| `--sasl-password` \<string>          | SASL password.                                                                                                                          |
| `--sasl-username` \<string>          | SASL username.                                                                                                                          |
| `--tls`                              | Enable or disable TLS. TLS is enabled by default.                                                                                       |
| `--tls-cert` \<string>               | Certificate object name for TLS.                                                                                                        |
| `--tls-skip-verify`                  | Enable or disable TLS skip verification (default: disabled).                                                                            |

#### weka s3 cluster notification-target cert

Manage notification target certificates.

```sh
weka s3 cluster notification-target cert
```

**weka s3 cluster notification-target cert add**

Add a new certificate for a bucket notification target.

```sh
weka s3 cluster notification-target cert add <cert-name> --client-tls-cert <string> --client-tls-key <string> --target-type <target-type> [--cert-name <string>]
```

| Parameter                        | Description                             |
| -------------------------------- | --------------------------------------- |
| `cert-name`\*                    | Certificate name.                       |
| `--client-tls-cert` \<string>\*  | File containing the client certificate. |
| `--client-tls-key` \<string>\*   | File containing the client private key. |
| `--target-type` \<target-type>\* | Notification target type.               |
| `--cert-name` \<string>          | Certificate object name.                |

**weka s3 cluster notification-target cert list**

List all certificates for a bucket notification target.

```sh
weka s3 cluster notification-target cert list --target-type <target-type>
```

| Parameter                        | Description               |
| -------------------------------- | ------------------------- |
| `--target-type` \<target-type>\* | Notification target type. |

**Columns:** `name`

**weka s3 cluster notification-target cert remove**

Remove an existing certificate for a bucket notification target.

```sh
weka s3 cluster notification-target cert remove <cert-name> --target-type <target-type>
```

| Parameter                        | Description                 |
| -------------------------------- | --------------------------- |
| `cert-name`\*                    | Certificate name to remove. |
| `--target-type` \<target-type>\* | Notification target type.   |

#### weka s3 cluster notification-target list

List all bucket notification targets for the cluster.

```sh
weka s3 cluster notification-target list
```

**Columns:** `name`, `topic`, `brokers`

#### weka s3 cluster notification-target remove

Remove an existing bucket notification target.

```sh
weka s3 cluster notification-target remove --name <string> --type <target-type> [--force]
```

| Parameter                 | Description                                                     |
| ------------------------- | --------------------------------------------------------------- |
| `--name` \<string>\*      | Notification target name.                                       |
| `--type` \<target-type>\* | Notification target type.                                       |
| `-f`, `--force`           | Force action. Perform this action without further confirmation. |

#### weka s3 cluster notification-target show

Show details of a bucket notification target.

```sh
weka s3 cluster notification-target show --name <string> --type <target-type>
```

| Parameter                 | Description               |
| ------------------------- | ------------------------- |
| `--name` \<string>\*      | Notification target name. |
| `--type` \<target-type>\* | Notification target type. |

**Columns:** `name`, `topic`, `brokers`, `tls`, `tls_skip_verify`, `sasl`, `sasl_user`, `sasl_password`, `sasl_mechanism`, `queue_limit`, `queue_dir`

#### weka s3 cluster notification-target status

Show status of all bucket notification targets per target for the cluster.

```sh
weka s3 cluster notification-target status
```

**Columns:** `container_id`, `name`, `topic`, `queue_percentage`, `kafka_lost_events`, `kafka_failures_events`

#### weka s3 cluster notification-target update

Update an existing bucket notification target.

```sh
weka s3 cluster notification-target update --name <string> --type <target-type> [--brokers <strings>…] [--kafka-version <string>] [--sasl] [--sasl-mechanism <sasl-mechanism>] [--sasl-password <string>] [--sasl-username <string>] [--tls] [--tls-cert <string>] [--tls-skip-verify] [--topic <string>]
```

| Parameter                            | Description                                                                                                                             |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| `--name` \<string>\*                 | Notification target name.                                                                                                               |
| `--type` \<target-type>\*            | Notification target type.                                                                                                               |
| `--brokers` \<strings>…              | Kafka brokers to which events will be sent (max 8). Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--kafka-version` \<string>          | Kafka version.                                                                                                                          |
| `--sasl`                             | Enable or disable SASL authentication.                                                                                                  |
| `--sasl-mechanism` \<sasl-mechanism> | SASL mechanism.                                                                                                                         |
| `--sasl-password` \<string>          | SASL password.                                                                                                                          |
| `--sasl-username` \<string>          | SASL username.                                                                                                                          |
| `--tls`                              | Enable or disable TLS. TLS is enabled by default.                                                                                       |
| `--tls-cert` \<string>               | Certificate object name for TLS.                                                                                                        |
| `--tls-skip-verify`                  | Enable or disable TLS skip verification (default: disabled).                                                                            |
| `--topic` \<string>                  | Kafka topic for generated messages.                                                                                                     |

### weka s3 cluster oidc

Manage OIDC (OpenID Connect) configuration for S3 authentication (e.g., Entra ID).

```sh
weka s3 cluster oidc
```

#### weka s3 cluster oidc add

Configure OIDC authentication for S3, enabling integration with identity providers like Microsoft Entra ID or Keycloak.

```sh
weka s3 cluster oidc add --config-url <string> --type <oidc-type> [--client-id <string>] [--client-secret <string>]
```

| Parameter                   | Description                                  |
| --------------------------- | -------------------------------------------- |
| `--config-url` \<string>\*  | OIDC configuration URL.                      |
| `--type` \<oidc-type>\*     | Identity provider type.                      |
| `--client-id` \<string>     | OIDC client ID.                              |
| `--client-secret` \<string> | Client secret (required when type is azure). |

#### weka s3 cluster oidc remove

Remove OIDC configuration from the S3 cluster.

```sh
weka s3 cluster oidc remove
```

#### weka s3 cluster oidc show

Display the OIDC configuration.

```sh
weka s3 cluster oidc show
```

**Columns:** `ConfigURL`, `Type`, `ClaimName`, `ClientID`, `ClientSecret`, `GroupsClaimName`

#### weka s3 cluster oidc update

Update existing OIDC configuration.

```sh
weka s3 cluster oidc update [--client-id <string>] [--client-secret <string>] [--config-url <string>] [--type <oidc-type>]
```

| Parameter                   | Description                                  |
| --------------------------- | -------------------------------------------- |
| `--client-id` \<string>     | OIDC client ID.                              |
| `--client-secret` \<string> | Client secret (required when type is azure). |
| `--config-url` \<string>    | OIDC configuration URL.                      |
| `--type` \<oidc-type>       | Identity provider type.                      |

### weka s3 cluster performance-bucket

Display existing global settings for WEKA S3 performance buckets.

```sh
weka s3 cluster performance-bucket
```

### weka s3 cluster remove

Destroy the S3 cluster.

```sh
weka s3 cluster remove [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 cluster setup

Manage S3 cluster setup.

```sh
weka s3 cluster setup
```

#### weka s3 cluster setup show

Show the current S3 cluster setup configuration.

```sh
weka s3 cluster setup show
```

**Columns:** `FilesystemName`, `AnonymousPosixUid`, `AnonymousPosixGid`

#### weka s3 cluster setup update

Update S3 cluster setup configuration.

```sh
weka s3 cluster setup update [--anonymous-posix-gid <uint>] [--anonymous-posix-uid <uint>] [--clear-default-fs] [--default-fs-name <string>]
```

| Parameter                       | Description                                   |
| ------------------------------- | --------------------------------------------- |
| `--anonymous-posix-gid` \<uint> | POSIX GID for anonymous users.                |
| `--anonymous-posix-uid` \<uint> | POSIX UID for anonymous users.                |
| `--clear-default-fs`            | Clear the default filesystem for this tenant. |
| `--default-fs-name` \<string>   | S3 default filesystem name.                   |

### weka s3 cluster sorting

Manage LIST operation sorting for all S3 Performance Buckets.

```sh
weka s3 cluster sorting
```

#### weka s3 cluster sorting reset

Reset the sorting preference for all S3 Performance Buckets, forcing them to inherit the cluster's global default.

```sh
weka s3 cluster sorting reset [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka s3 cluster status

Show which of the S3 containers are ready.

```sh
weka s3 cluster status
```

**Columns:** `id`, `hostname`, `statusTitle`, `ip`, `port`, `version`, `uptime`, `requests`, `lastError`, `failureTime`, `serviceStatus`

### weka s3 cluster update

Update S3 cluster configuration.

```sh
weka s3 cluster update [--all-servers] [--allow-versioning] [--anonymous-posix-gid <uint>] [--anonymous-posix-uid <uint>] [--container <container-ids>…] [--domain <strings>…] [--force] [--port <uint16>]
```

| Parameter                       | Description                                                                                                                 |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `--all-servers`                 | Install S3 on all servers.                                                                                                  |
| `--allow-versioning`            | Enable S3 versioning (default off, cannot be disabled once enabled).                                                        |
| `--anonymous-posix-gid` \<uint> | POSIX GID for anonymous users.                                                                                              |
| `--anonymous-posix-uid` \<uint> | POSIX UID for anonymous users.                                                                                              |
| `--container` \<container-ids>… | Containers that will serve S3 protocol. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--domain` \<strings>…          | Virtual host-style domains. Multiple values may be supplied separated by commas, or the option may be repeated.             |
| `-f`, `--force`                 | Force action. Perform this action without further confirmation.                                                             |
| `--port` \<uint16>              | S3 service port.                                                                                                            |

#### weka s3 cluster update performance-bucket

Set the default performance settings for all S3 Performance Buckets.

```sh
weka s3 cluster update performance-bucket [--etag-alg <etag-algorithm>] [--force] [--integrity-mode <integrity-mode>] [--sorting <sorting>]
```

| Parameter                            | Description                                                     |
| ------------------------------------ | --------------------------------------------------------------- |
| `--etag-alg` \<etag-algorithm>       | Default ETag algorithm.                                         |
| `-f`, `--force`                      | Force action. Perform this action without further confirmation. |
| `--integrity-mode` \<integrity-mode> | Default integrity mode.                                         |
| `--sorting` \<sorting>               | Default LIST sorting.                                           |

## weka s3 group

Manage S3 IAM groups.

```sh
weka s3 group
```

### weka s3 group add

Add an S3 IAM group.

```sh
weka s3 group add <name>
```

| Parameter | Description             |
| --------- | ----------------------- |
| `name`\*  | Name for the new group. |

### weka s3 group list

Print a list of the existing S3 IAM groups.

```sh
weka s3 group list
```

**Columns:** `name`, `policy`

### weka s3 group remove

Remove an S3 IAM group.

```sh
weka s3 group remove <name>
```

| Parameter | Description                  |
| --------- | ---------------------------- |
| `name`\*  | Name of the group to remove. |

## weka s3 policy

Manage S3 IAM policies.

```sh
weka s3 policy
```

### weka s3 policy add

Add an S3 IAM policy.

```sh
weka s3 policy add <policy-name> <policy-file>
```

| Parameter       | Description                     |
| --------------- | ------------------------------- |
| `policy-name`\* | Name for the new policy.        |
| `policy-file`\* | File containing policy content. |

### weka s3 policy attach

Attach an S3 IAM policy to a user or group.

```sh
weka s3 policy attach <policy-name> [<user>] [--group <string>] [--user <string>]
```

| Parameter           | Description                                                                 |
| ------------------- | --------------------------------------------------------------------------- |
| `policy-name`\*     | Name of the policy to attach.                                               |
| `user`              | User name to attach the policy to (alternative to --user).                  |
| `--group` \<string> | Group name to attach the policy to (mutually exclusive with --user).        |
| `--user` \<string>  | User name to attach the policy to (alternative to the positional argument). |

### weka s3 policy detach

Detach an S3 IAM policy from a user or group.

```sh
weka s3 policy detach [<user>] [--group <string>] [--user <string>]
```

| Parameter           | Description                                                                   |
| ------------------- | ----------------------------------------------------------------------------- |
| `user`              | User name to detach the policy from (alternative to --user).                  |
| `--group` \<string> | Group name to detach the policy from (mutually exclusive with --user).        |
| `--user` \<string>  | User name to detach the policy from (alternative to the positional argument). |

### weka s3 policy list

Print a list of the existing S3 IAM policies.

```sh
weka s3 policy list
```

**Columns:** `name`

### weka s3 policy remove

Remove an S3 IAM policy.

```sh
weka s3 policy remove <policy-name>
```

| Parameter       | Description                   |
| --------------- | ----------------------------- |
| `policy-name`\* | Name of the policy to remove. |

### weka s3 policy show

Show a single S3 IAM policy, including its content.

```sh
weka s3 policy show <policy-name>
```

| Parameter       | Description                 |
| --------------- | --------------------------- |
| `policy-name`\* | Name of the policy to show. |

**Columns:** `name`, `content`

## weka s3 service-account

S3 service account commands. Should be run only with an S3 user role.

```sh
weka s3 service-account
```

### weka s3 service-account add

Add a new S3 service account.

```sh
weka s3 service-account add [--policy-file <string>]
```

| Parameter                 | Description                          |
| ------------------------- | ------------------------------------ |
| `--policy-file` \<string> | File containing JSON policy content. |

**Columns:** `access_key`, `secret_key`

### weka s3 service-account list

List the service accounts for the current user.

```sh
weka s3 service-account list
```

**Columns:** `key`

### weka s3 service-account remove

Remove an S3 service account.

```sh
weka s3 service-account remove <access-key>
```

| Parameter      | Description                                  |
| -------------- | -------------------------------------------- |
| `access-key`\* | Access key of the service account to remove. |

### weka s3 service-account show

Show the details of an S3 service account.

```sh
weka s3 service-account show <access-key>
```

| Parameter      | Description                                |
| -------------- | ------------------------------------------ |
| `access-key`\* | Access key of the service account to show. |

**Columns:** `access_key`, `parent_user`, `implied_policy`, `policy_content`

## weka s3 sts

Manage S3 security tokens.

```sh
weka s3 sts
```

### weka s3 sts assume-role

Generate a temporary security token with an assumed role using existing user credentials.

```sh
weka s3 sts assume-role --access-key <string> --duration <duration> [--policy-file <string>] [--secret-key <string>]
```

| Parameter                  | Description                                                                             |
| -------------------------- | --------------------------------------------------------------------------------------- |
| `--access-key` \<string>\* | Access key. Essentially an S3 user name.                                                |
| `--duration` \<duration>\* | Duration of the security token.                                                         |
| `--policy-file` \<string>  | File containing JSON policy content.                                                    |
| `--secret-key` \<string>   | Secret key for assumed role. Essentially an S3 user password. Prompted if not supplied. |

**Columns:** `access_key_id`, `secret_access_key`, `session_token`

## weka s3 user

Manage S3 users.

```sh
weka s3 user
```

### weka s3 user decode-key

Extract the tenant ID encoded in a 128-character S3 API access key.

```sh
weka s3 user decode-key <access-key> [--validate-exists]
```

| Parameter           | Description                                        |
| ------------------- | -------------------------------------------------- |
| `access-key`\*      | S3 API access key (128 characters).                |
| `--validate-exists` | Validate that the access key exists in the system. |

### weka s3 user keys-generate

Generate or rotate an S3 API access/secret key pair. If --user is specified, generates keys for that user (requires Tenant Admin role); otherwise generates keys for the calling user.

```sh
weka s3 user keys-generate [--user <string>]
```

| Parameter          | Description                                                                                         |
| ------------------ | --------------------------------------------------------------------------------------------------- |
| `--user` \<string> | Target S3 username for credential generation/rotation. Requires Tenant Admin or Cluster Admin role. |

**Columns:** `access_key`, `secret_key`
