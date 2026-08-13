---
description: >-
  Configure and control secure, real-time access for WEKA Customer Success Team
  to troubleshoot cluster issues using homecli on K3s deployment.
---

# Manage remote debugging sessions on K3s

## Overview

Collaborate with the WEKA Customer Success Team (CST) by establishing secure debugging sessions using the `homecli` utility. The `homecli remote-access` command group allows you to grant WEKA CST controlled access to your environment to troubleshoot issues in real time.

#### Support session workflow

When a technical issue requires advanced diagnostics, the Customer Success Team may request a tmate[^1] session. This creates a shared terminal environment for both you and the WEKA CST to view and execute commands in real-time.

* **Remote session:** Establishes a secure tunnel connecting your cluster to a shared support terminal via `homecli`.
* **Encrypted connection:** All data transmitted is safeguarded with SSH encryption.
* **Audit capability:** Support team actions are recorded as `.cast` files and stored in a Persistent Volume Claim (PVC), allowing for complete review.

{% hint style="info" %}
The `homecli` tool is included in the Local WEKA Home deployment for K3s. For K8s, it is managed entirely through Helm charts. The `homecli remote-access` command group is supported in version **4.4.0** and later of LWH.
{% endhint %}

### Available commands

The remote-access command group provides the following subcommands:

| Command | Description |
| --- | --- |
| `start` | Start a new remote-access tmate session |
| `stop` | Stop running remote session(s) |
| `list` | List active remote sessions |
| `list-recordings` | List available session recordings |
| `copy-recording` | Copy recording files from PVC to local filesystem |

***

## Start a session

Use the `start` command to launch a new remote-access tmate session. This establishes a secure connection between your cluster and the shared support terminal. The following flags are required to initiate a session.

**Syntax**

```bash
homecli remote-access start [flags]
```

**Required flags**

| Flag | Type | Description |
| --- | --- | --- |
| `--cluster-id` | `string` | Cluster GUID (must be a valid UUID). |
| `--cluster-name` | `string` | Human-readable cluster name. Max 63 characters; alphanumeric with dashes, underscores, or dots. |
| `--ssh-keys-path` | `string` | Host path to an existing SSH keys directory, mounted as a HostPath volume. |

**Optional flags**

| Flag | Type | Default | Description |
| --- | --- | --- | --- |
| `--cloud-url` | `string` | From config | Cloud Weka Home URL |
| `--host-name` | `string` | System hostname | Override hostname |
| `--terminal-cols` | `int` | `158` | Terminal width |
| `--terminal-lines` | `int` | `35` | Terminal height |
| `--debug` | `bool` | `false` | Enable debug logging in the tmate container |

**Custom tmate server flags**

When connecting to a custom tmate server, all of the following flags must be provided together.

| Flag | Type | Description |
| --- | --- | --- |
| `--tmate-server-host` | `string` | Override tmate SSH server hostname |
| `--tmate-server-port` | `string` | Override tmate SSH server port |
| `--tmate-server-rsa-fingerprint` | `string` | Override RSA fingerprint |
| `--tmate-server-ed25519-fingerprint` | `string` | Override Ed25519 fingerprint |
| `--tmate-server-ecdsa-fingerprint` | `string` | Override ECDSA fingerprint |

**Validation rules**

* **`--cluster-id`:** Must be a valid UUID format.
* **`--cluster-name`:** Max 63 characters. Must start and end with an alphanumeric character. May contain alphanumerics, dashes, underscores, or dots.
* **`--ssh-keys-path`:** Must point to an existing directory on the host.

**Examples**

* Start a session using the cloud URL from the existing config:

```bash
homecli remote-access start \
  --cluster-id "550e8400-e29b-41d4-a716-446655440000" \
  --cluster-name "prod-cluster" \
  --ssh-keys-path "/root/.ssh"
```

* Start a session with a custom tmate server:

```bash
homecli remote-access start \
  --cluster-id "550e8400-e29b-41d4-a716-446655440000" \
  --cluster-name "prod-cluster" \
  --ssh-keys-path "/root/.ssh" \
  --tmate-server-host "tmate.example.com" \
  --tmate-server-port "22" \
  --tmate-server-rsa-fingerprint "SHA256:abc123..." \
  --tmate-server-ed25519-fingerprint "SHA256:def456..." \
  --tmate-server-ecdsa-fingerprint "SHA256:ghi789..."
```

* Start a session with a custom terminal size and debug mode enabled:

```bash
homecli remote-access start \
  --cluster-id "550e8400-e29b-41d4-a716-446655440000" \
  --cluster-name "dev" \
  --ssh-keys-path "/home/user/.ssh" \
  --terminal-cols 200 \
  --terminal-lines 50 \
  --debug
```

**Example output:**

```bash
Remote session started successfully
  Session ID: a1b2c3
```

***

## Stop a session

Use the `stop` command to terminate one or more active remote sessions. At least one filter flag must be provided.

**Syntax**

```bash
homecli remote-access stop [flags]
```

**Flags**

| Flag | Type | Description |
| --- | --- | --- |
| `--session-id` | `string` | Stop a specific session by its 6-character hex ID (example, `a1b2c3`) |
| `--cluster-id` | `string` | Stop all active sessions for a specific cluster (must be a valid UUID) |
| `--all` | `bool` | Stop all active sessions |

**Validation rules**

* **`--session-id`:** Must be exactly 6 hexadecimal characters.
* **`--cluster-id`:** Must be a valid UUID format.
* At least one of `--session-id`, `--cluster-id`, or `--all` must be specified.

**Examples**

* Stop a specific session by ID:

```bash
homecli remote-access stop --session-id a1b2c3
```

* Stop all sessions for a given cluster:

```bash
homecli remote-access stop --cluster-id 550e8400-e29b-41d4-a716-446655440000
```

* Stop all active sessions:

```bash
homecli remote-access stop --all
```

**Example output:**

```bash
Stopped session: a1b2c3 (pod: remote-session-a1b2c3)
Stopped session: d4e5f6 (pod: remote-session-d4e5f6)
Note: Stopped 2 session(s)
```

***

## List active sessions

Use the `list` command to view all currently active remote sessions. Output can be formatted as a table (default), JSON, or YAML.

**Syntax**

```bash
homecli remote-access list [flags]
```

**Flags**

| Flag | Short | Type | Default | Description |
| --- | --- | --- | --- | --- |
| `--output` | `-o` | `string` | `table` | Output format: `table`, `json`, or `yaml` |

#### **Examples**

List sessions in the default table format:

```bash
homecli remote-access list
```

List sessions in JSON format:

```bash
homecli remote-access list --output json
```

List sessions in YAML format:

```bash
homecli remote-access list -o yaml
```

**Example table output:**

```bash
SESSION   CLUSTER ID                             CLUSTER NAME   DURATION
a1b2c3    550e8400-e29b-41d4-a716-446655440000   prod-cluster   2h15m
d4e5f6    661f9500-f30c-52e5-b827-557766551111   dev-cluster    45m
a7f8b9    772a0600-a41d-63f6-c938-668877662222   staging        3d5h
```

**Example JSON output:**

```json
[
  {
    "sessionId": "a1b2c3",
    "clusterId": "550e8400-e29b-41d4-a716-446655440000",
    "clusterName": "prod-cluster",
    "duration": "2h15m"
  },
  {
    "sessionId": "d4e5f6",
    "clusterId": "661f9500-f30c-52e5-b827-557766551111",
    "clusterName": "dev-cluster",
    "duration": "45m"
  }
]
```

**Example YAML output:**

```yaml
- sessionId: a1b2c3
  clusterId: 550e8400-e29b-41d4-a716-446655440000
  clusterName: prod-cluster
  duration: 2h15m
- sessionId: d4e5f6
  clusterId: 661f9500-f30c-52e5-b827-557766551111
  clusterName: dev-cluster
  duration: 45m
```

***

## List session recordings

Use the `list-recordings` command to view available session recordings stored in the recordings PVC. Recordings are saved as asciinema[^2] `.cast` files and can be filtered by cluster.

{% hint style="info" %}
The default PVC capacity for remote session client recordings is set to 10 GiB. To increase this capacity, modify the `/opt/wekahome/current/config.json` file, and then update the deployment settings accordingly.

For details, see [#id-5.-install-and-configure-local-weka-home](./#id-5.-install-and-configure-local-weka-home "mention").
{% endhint %}

**Syntax**

```bash
homecli remote-access list-recordings [flags]
```

**Flags**

| Flag | Type | Description |
| --- | --- | --- |
| `--cluster-id` | `string` | Filter recordings by cluster ID (must be a valid UUID) |
| `--output` / `-o` | `string` | Output format: `table` (default), `json`, or `yaml` |

#### **Examples**

* List all available recordings:

```bash
homecli remote-access list-recordings
```

* Filter recordings for a specific cluster:

```bash
homecli remote-access list-recordings --cluster-id 550e8400-e29b-41d4-a716-446655440000
```

* Output in JSON format:

```bash
homecli remote-access list-recordings --output json
```

* Combine a cluster filter with YAML output:

```bash
homecli remote-access list-recordings --cluster-id 550e8400-e29b-41d4-a716-446655440000 -o yaml
```

**Example table output:**

```bash
FILENAME                              SIZE      MODIFIED           CLUSTER ID
2024-01-15T10:30:00-a1b2c3.cast       1.2 MB    2024-01-15 10:45   550e8400-e29b-41d4-a716-446655440000
2024-01-14T09:00:00-d4e5f6.cast       856.3 KB  2024-01-14 09:30   661f9500-f30c-52e5-b827-557766551111
session-recording.cast                245 B     2024-01-10 14:22   -
```

**Example JSON output:**

```json
[
  {
    "filename": "2024-01-15T10:30:00-a1b2c3.cast",
    "clusterId": "550e8400-e29b-41d4-a716-446655440000",
    "size": 1258291,
    "modTime": 1705315500
  },
  {
    "filename": "2024-01-14T09:00:00-d4e5f6.cast",
    "clusterId": "661f9500-f30c-52e5-b827-557766551111",
    "size": 876851,
    "modTime": 1705225800
  }
]
```

**Example YAML output:**

```yaml
- filename: 2024-01-15T10:30:00-a1b2c3.cast
  clusterId: 550e8400-e29b-41d4-a716-446655440000
  size: 1258291
  modTime: 1705315500
- filename: 2024-01-14T09:00:00-d4e5f6.cast
  clusterId: 661f9500-f30c-52e5-b827-557766551111
  size: 876851
  modTime: 1705225800
```

#### **Size format**

| Size range | Format example |
| --- | --- |
| Less than 1 KB | `245 B` |
| Less than 1 MB | `856.3 KB` |
| Less than 1 GB | `1.2 MB` |
| 1 GB or more | `2.5 GB` |

***

## Copy recordings

Use the `copy-recording` command to download session recording files from the recordings PVC to a local directory. At least one filter flag is required to specify which recordings to copy.

**Syntax**

```bash
homecli remote-access copy-recording [flags]
```

**Required flag**

| Flag | Type | Description |
| --- | --- | --- |
| `--output` / `-o` | `string` | Local destination directory. The directory is created if it does not already exist. |

**Filter flags**

At least one of the following filter flags must be provided:

| Flag | Type | Description |
| --- | --- | --- |
| `--recording` | `string` | Specific recording filename to copy. Must be a `.cast` file with safe characters (alphanumeric, underscore, dash, colon, dot). |
| `--cluster-id` | `string` | Copy all recordings associated with a cluster (must be a valid UUID). |
| `--all` | `bool` | Copy all available recordings. |

**Validation rules**

* **`--recording`:** Must be a `.cast` file using only safe characters: alphanumeric, underscore, dash, colon, or dot.
* **`--cluster-id`:** Must be a valid UUID format.
* **`--output`:** Required. The specified directory is created automatically if it does not exist.

#### **Examples**

* Copy a single recording to a local directory:

```bash
homecli remote-access copy-recording \
  --recording "2024-01-15T10:30:00-a1b2c3.cast" \
  --output /tmp/recordings/
```

* Copy a single recording for a specific cluster:

```bash
homecli remote-access copy-recording \
  --recording "2024-01-15T10:30:00-a1b2c3.cast" \
  --cluster-id "550e8400-e29b-41d4-a716-446655440000" \
  --output /tmp/recordings/
```

* Copy all recordings for a specific cluster:

```bash
homecli remote-access copy-recording \
  --cluster-id "550e8400-e29b-41d4-a716-446655440000" \
  --output /tmp/recordings/
```

* Copy all available recordings:

```bash
homecli remote-access copy-recording --all --output /tmp/recordings/
```

**Example output:**

```bash
Copying 3 recording(s) to /tmp/recordings/
  Copied: 2024-01-15T10:30:00-a1b2c3.cast
  Copied: 2024-01-14T09:00:00-d4e5f6.cast
  Copied: 2024-01-10T14:22:00-a7f8b9.cast
Note: Successfully copied 3/3 recording(s)
```

**Partial success output:**

```bash
Copying 3 recording(s) to /tmp/recordings/
  Copied: 2024-01-15T10:30:00-a1b2c3.cast
Warning: Failed to copy 2024-01-14T09:00:00-d4e5f6.cast: file not accessible
  Copied: 2024-01-10T14:22:00-a7f8b9.cast
Note: Successfully copied 2/3 recording(s)
```

[^1]: A terminal multiplexer that facilitates secure, instant terminal sharing by way of an SSH connection to a remote relay server.

[^2]: Asciinema is a free, open-source command-line tool designed to record terminal sessions, capturing text output rather than video, resulting in lightweight, shareable files. It enables users to record, replay locally, or share terminal activity.
