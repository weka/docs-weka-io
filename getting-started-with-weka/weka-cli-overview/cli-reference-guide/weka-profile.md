---
description: Manage WEKA CLI connection and display profiles.
---

# weka profile

Manage profile settings. Profiles are used to configure connection, authentication, and display preferences.

```sh
weka profile
```

## weka profile add

Create a new profile. Profiles are used to provide default connection, authentication, and display preferences.

```sh
weka profile add <profile> [--accent-color <string>] [--activate] [--auto-accept-cert] [--binary-units] [--brand-color <string>] [--color <color-mode>] [--container <string>] [--current] [--history-size <int>] [--host <string>] [--insecure] [--jump-host <string>] [--kube-context <string>] [--kube-namespace <string>] [--kube-weka-cluster <string>] [--kubeconfig <string>] [--kubectl-path <string>] [--no-dynamic-completions] [--no-icons] [--no-update-check] [--port <uint16>] [--prefix-match-only] [--prompt <template>] [--ssh-opts <string>] [--ssh-path <string>] [--tab-to-complete] [--tenant <string>] [--theme <theme>] [--username <string>] [--viewer-mouse] [--viewer-theme <theme>]
```

| Parameter                       | Description                                                                                                                                                                                                                                          |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `profile`\*                     | Name for the new profile. May contain alphanumerics, dashes, or underscores only.                                                                                                                                                                    |
| `--accent-color` \<string>      | Color to use for accents and titles. Hex code (#FF0000), name ('red'), or a palette index (0-255).                                                                                                                                                   |
| `--activate`                    | Activate the profile, making it the default for further commands.                                                                                                                                                                                    |
| `--auto-accept-cert`            | Automatically accept TLS certificates when presented on first connection to new host.                                                                                                                                                                |
| `--binary-units`                | Show storage values in base-2 units (KiB, MiB, GiB) instead of base-10 units (KB, MB, GB).                                                                                                                                                           |
| `--brand-color` \<string>       | Color to use for branding and decorative elements. Hex code (#FF0000), name ('red'), or a palette index (0-255).                                                                                                                                     |
| `--color` \<color-mode>         | Whether to use color in output. Valid values: auto, disabled, enabled.                                                                                                                                                                               |
| `--container` \<string>         | Name of a local container to use when connecting to cluster.                                                                                                                                                                                         |
| `--current`                     | Seed the new profile from the connection currently in effect, so it can be reused later. Combine with -H, -P, -S, or --jump to capture a specific connection.                                                                                        |
| `--history-size` \<int>         | Number of lines to keep in interactive mode history. Use -1 for unlimited. Default is 500.                                                                                                                                                           |
| `--host` \<string>              | Default hostname to use when connecting to cluster.                                                                                                                                                                                                  |
| `--insecure`                    | Skip peer validation for TLS connections. This is insecure!                                                                                                                                                                                          |
| `--jump-host` \<string>         | SSH bastion to tunnel the connection through, e.g. user@bastion. Uses the system ssh and your existing ~/.ssh/config, known\_hosts, and agent.                                                                                                       |
| `--kube-context` \<string>      | kubeconfig context for reaching an operator-managed cluster via kubectl port-forward. Defaults to the current context.                                                                                                                               |
| `--kube-namespace` \<string>    | Kubernetes namespace of the WEKA port-forward target.                                                                                                                                                                                                |
| `--kube-weka-cluster` \<string> | WEKA cluster name to reach via kubectl port-forward; the operator's management service is resolved by label. Enables Kubernetes mode.                                                                                                                |
| `--kubeconfig` \<string>        | Path to the kubeconfig file used for kubectl port-forward. Defaults to kubectl's own resolution (KUBECONFIG / ~/.kube/config).                                                                                                                       |
| `--kubectl-path` \<string>      | Path to the kubectl binary used for port-forward. Defaults to kubectl on PATH; the WEKA\_KUBECTL environment variable takes precedence.                                                                                                              |
| `--no-dynamic-completions`      | Suppress completions and help example values that require an active query to the cluster. Completion menus fall back to the static hint; help output omits the example values.                                                                       |
| `--no-icons`                    | Suppress use of icons for status.                                                                                                                                                                                                                    |
| `--no-update-check`             | Stop checking once a day whether a newer CLI has been released. The check never blocks a command; this suppresses it entirely.                                                                                                                       |
| `--port` \<uint16>              | Default TCP port to use when connecting to cluster.                                                                                                                                                                                                  |
| `--prefix-match-only`           | Match interactive completions only as a prefix instead of anywhere in the candidate.                                                                                                                                                                 |
| `--prompt` \<template>          | Template for the interactive-mode prompt. Supports variable placeholders like {profile}, {user}, {tenant}, {host}, {cluster}, {version}, {role}, {#}, and style verbs like {fg blue}, {bold}, {reset}. An empty value restores the built-in default. |
| `--ssh-opts` \<string>          | Extra arguments passed to ssh for the jump host, e.g. -i /path/to/id. The WEKA\_SSH\_OPTS environment variable takes precedence.                                                                                                                     |
| `--ssh-path` \<string>          | Path to the ssh binary used for the jump host. Defaults to ssh on PATH; the WEKA\_SSH environment variable takes precedence.                                                                                                                         |
| `--tab-to-complete`             | Show completion in interactive mode only after pressing TAB.                                                                                                                                                                                         |
| `--tenant` \<string>            | Tenant name or ID to use when authenticating.                                                                                                                                                                                                        |
| `--theme` \<theme>              | Select the default theme to use, which controls the appearance command results. Valid values: default, pretty, plain, classic.                                                                                                                       |
| `--username` \<string>          | Default username to use when authenticating.                                                                                                                                                                                                         |
| `--viewer-mouse`                | Capture the mouse in the `debug viewer` (click selects a line, wheel scrolls). Off by default so the terminal keeps drag-to-select for copying text; toggle live with M.                                                                             |
| `--viewer-theme` \<theme>       | Default color theme for the `debug viewer` trace viewer. Valid values: dark, light, classic, mono.                                                                                                                                                   |

## weka profile deselect

Deactivate the current active profile. The contents of the profile itself is unchanged.

```sh
weka profile deselect
```

## weka profile duplicate

Create a new profile by copying from an old one

```sh
weka profile duplicate <profile> <new-profile> [--accent-color <string>] [--activate] [--auto-accept-cert] [--binary-units] [--brand-color <string>] [--color <color-mode>] [--container <string>] [--history-size <int>] [--host <string>] [--insecure] [--jump-host <string>] [--kube-context <string>] [--kube-namespace <string>] [--kube-weka-cluster <string>] [--kubeconfig <string>] [--kubectl-path <string>] [--no-dynamic-completions] [--no-icons] [--no-update-check] [--port <uint16>] [--prefix-match-only] [--prompt <template>] [--ssh-opts <string>] [--ssh-path <string>] [--tab-to-complete] [--tenant <string>] [--theme <theme>] [--username <string>] [--viewer-mouse] [--viewer-theme <theme>]
```

| Parameter                       | Description                                                                                                                                                                                                                                          |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `profile`\*                     | Profile to duplicate.                                                                                                                                                                                                                                |
| `new-profile`\*                 | Name for the new profile. May contain alphanumerics, dashes, or underscores only.                                                                                                                                                                    |
| `--accent-color` \<string>      | Color to use for accents and titles. Hex code (#FF0000), name ('red'), or a palette index (0-255).                                                                                                                                                   |
| `--activate`                    | Activate the profile, making it the default for further commands.                                                                                                                                                                                    |
| `--auto-accept-cert`            | Automatically accept TLS certificates when presented on first connection to new host.                                                                                                                                                                |
| `--binary-units`                | Show storage values in base-2 units (KiB, MiB, GiB) instead of base-10 units (KB, MB, GB).                                                                                                                                                           |
| `--brand-color` \<string>       | Color to use for branding and decorative elements. Hex code (#FF0000), name ('red'), or a palette index (0-255).                                                                                                                                     |
| `--color` \<color-mode>         | Whether to use color in output. Valid values: auto, disabled, enabled.                                                                                                                                                                               |
| `--container` \<string>         | Name of a local container to use when connecting to cluster.                                                                                                                                                                                         |
| `--history-size` \<int>         | Number of lines to keep in interactive mode history. Use -1 for unlimited. Default is 500.                                                                                                                                                           |
| `--host` \<string>              | Default hostname to use when connecting to cluster.                                                                                                                                                                                                  |
| `--insecure`                    | Skip peer validation for TLS connections. This is insecure!                                                                                                                                                                                          |
| `--jump-host` \<string>         | SSH bastion to tunnel the connection through, e.g. user@bastion. Uses the system ssh and your existing ~/.ssh/config, known\_hosts, and agent.                                                                                                       |
| `--kube-context` \<string>      | kubeconfig context for reaching an operator-managed cluster via kubectl port-forward. Defaults to the current context.                                                                                                                               |
| `--kube-namespace` \<string>    | Kubernetes namespace of the WEKA port-forward target.                                                                                                                                                                                                |
| `--kube-weka-cluster` \<string> | WEKA cluster name to reach via kubectl port-forward; the operator's management service is resolved by label. Enables Kubernetes mode.                                                                                                                |
| `--kubeconfig` \<string>        | Path to the kubeconfig file used for kubectl port-forward. Defaults to kubectl's own resolution (KUBECONFIG / ~/.kube/config).                                                                                                                       |
| `--kubectl-path` \<string>      | Path to the kubectl binary used for port-forward. Defaults to kubectl on PATH; the WEKA\_KUBECTL environment variable takes precedence.                                                                                                              |
| `--no-dynamic-completions`      | Suppress completions and help example values that require an active query to the cluster. Completion menus fall back to the static hint; help output omits the example values.                                                                       |
| `--no-icons`                    | Suppress use of icons for status.                                                                                                                                                                                                                    |
| `--no-update-check`             | Stop checking once a day whether a newer CLI has been released. The check never blocks a command; this suppresses it entirely.                                                                                                                       |
| `--port` \<uint16>              | Default TCP port to use when connecting to cluster.                                                                                                                                                                                                  |
| `--prefix-match-only`           | Match interactive completions only as a prefix instead of anywhere in the candidate.                                                                                                                                                                 |
| `--prompt` \<template>          | Template for the interactive-mode prompt. Supports variable placeholders like {profile}, {user}, {tenant}, {host}, {cluster}, {version}, {role}, {#}, and style verbs like {fg blue}, {bold}, {reset}. An empty value restores the built-in default. |
| `--ssh-opts` \<string>          | Extra arguments passed to ssh for the jump host, e.g. -i /path/to/id. The WEKA\_SSH\_OPTS environment variable takes precedence.                                                                                                                     |
| `--ssh-path` \<string>          | Path to the ssh binary used for the jump host. Defaults to ssh on PATH; the WEKA\_SSH environment variable takes precedence.                                                                                                                         |
| `--tab-to-complete`             | Show completion in interactive mode only after pressing TAB.                                                                                                                                                                                         |
| `--tenant` \<string>            | Tenant name or ID to use when authenticating.                                                                                                                                                                                                        |
| `--theme` \<theme>              | Select the default theme to use, which controls the appearance command results. Valid values: default, pretty, plain, classic.                                                                                                                       |
| `--username` \<string>          | Default username to use when authenticating.                                                                                                                                                                                                         |
| `--viewer-mouse`                | Capture the mouse in the `debug viewer` (click selects a line, wheel scrolls). Off by default so the terminal keeps drag-to-select for copying text; toggle live with M.                                                                             |
| `--viewer-theme` \<theme>       | Default color theme for the `debug viewer` trace viewer. Valid values: dark, light, classic, mono.                                                                                                                                                   |

## weka profile list

List profiles, including which is active and which is default.

```sh
weka profile list
```

**Columns:** `profile`, `default`, `active`

## weka profile logout

Log the profile out of any cluster, deleting any tokens stored in the profile.

```sh
weka profile logout [<profile>]
```

| Parameter | Description                             |
| --------- | --------------------------------------- |
| `profile` | Name of the profile for this operation. |

## weka profile purge

Remove saved data from a profile: TLS certificates, cached completion data, command history, or all of them. Each profile keeps its own cache, so purging one profile leaves the others untouched.

```sh
weka profile purge
```

### weka profile purge all

Remove the profile's certificates, cached completion data, and command history.

```sh
weka profile purge all [<profile>]
```

| Parameter | Description                             |
| --------- | --------------------------------------- |
| `profile` | Name of the profile to purge data from. |

### weka profile purge cache

Remove the profile's cached completion data (filesystem, tenant, user names, and similar). The data is re-fetched on demand.

```sh
weka profile purge cache [<profile>]
```

| Parameter | Description                             |
| --------- | --------------------------------------- |
| `profile` | Name of the profile to purge data from. |

### weka profile purge certs

Remove all saved TLS certificates from the profile. Use this when cluster certificates have been administratively changed.

```sh
weka profile purge certs [<profile>]
```

| Parameter | Description                             |
| --------- | --------------------------------------- |
| `profile` | Name of the profile to purge data from. |

### weka profile purge history

Remove the profile's saved command history.

```sh
weka profile purge history [<profile>]
```

| Parameter | Description                             |
| --------- | --------------------------------------- |
| `profile` | Name of the profile to purge data from. |

## weka profile remove

Remove profile, including settings, authentication tokens, and saved certificates.

```sh
weka profile remove [<profile>] [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `profile`       | Name of the profile for this operation.                         |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## weka profile select

Set the active profile to use. The profile may also be selected for a single command invocation with '--profile'.

```sh
weka profile select <profile>
```

| Parameter   | Description                  |
| ----------- | ---------------------------- |
| `profile`\* | Name of profile to activate. |

## weka profile setup

Interactively create or update a connection profile. Prompts for profile name, connection settings, and credentials.

```sh
weka profile setup
```

## weka profile show

Show profile settings.

```sh
weka profile show [<profile>]
```

| Parameter | Description      |
| --------- | ---------------- |
| `profile` | Profile to show. |

**Columns:** `name`, `WEKA_HOST`, `WEKA_PORT`, `WEKA_CONTAINER`, `WEKA_JUMP_HOST`, `WEKA_SSH`, `WEKA_SSH_OPTS`, `WEKA_KUBE_CLUSTER`, `WEKA_KUBE_CONTEXT`, `WEKA_KUBE_NAMESPACE`, `WEKA_KUBECONFIG`, `WEKA_KUBECTL`, `WEKA_INSECURE`, `WEKA_AUTO_ACCEPT_CERT`, `WEKA_CERTS_DIR`, `WEKA_ORG`, `WEKA_USERNAME`, `WEKA_THEME`, `WEKA_VIEWER_THEME`, `WEKA_VIEWER_MOUSE`, `WEKA_CONNECT_TIMEOUT`, `WEKA_RESPONSE_TIMEOUT`, `WEKA_BRAND_COLOR`, `WEKA_ACCENT_COLOR`, `WEKA_COLOR_MODE`, `WEKA_DEBUG`, `WEKA_API_VERSION`, `WEKA_REST_URL`, `WEKA_NO_CLIP`, `WEKA_TOKEN`, `WEKA_NO_ICONS`, `WEKA_BINARY_UNITS`, `WEKA_TAB_COMPLETION`, `WEKA_PREFIX_MATCH_ONLY`, `WEKA_NO_DYNAMIC_COMPLETIONS`, `WEKA_NO_UPDATE_CHECK`, `WEKA_HISTORY_SIZE`, `WEKA_PROMPT`, `WEKA_ACTIVITY_LOG`, `WEKA_ACTIVITY_LOG_SIZE`

## weka profile update

Update profile settings.

```sh
weka profile update [<profile>] [--accent-color <string>] [--activate] [--auto-accept-cert] [--binary-units] [--brand-color <string>] [--color <color-mode>] [--container <string>] [--history-size <int>] [--host <string>] [--insecure] [--jump-host <string>] [--kube-context <string>] [--kube-namespace <string>] [--kube-weka-cluster <string>] [--kubeconfig <string>] [--kubectl-path <string>] [--no-dynamic-completions] [--no-icons] [--no-update-check] [--port <uint16>] [--prefix-match-only] [--prompt <template>] [--ssh-opts <string>] [--ssh-path <string>] [--tab-to-complete] [--tenant <string>] [--theme <theme>] [--username <string>] [--viewer-mouse] [--viewer-theme <theme>]
```

| Parameter                       | Description                                                                                                                                                                                                                                          |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `profile`                       | Name of the profile for this operation.                                                                                                                                                                                                              |
| `--accent-color` \<string>      | Color to use for accents and titles. Hex code (#FF0000), name ('red'), or a palette index (0-255).                                                                                                                                                   |
| `--activate`                    | Activate the profile, making it the default for further commands.                                                                                                                                                                                    |
| `--auto-accept-cert`            | Automatically accept TLS certificates when presented on first connection to new host.                                                                                                                                                                |
| `--binary-units`                | Show storage values in base-2 units (KiB, MiB, GiB) instead of base-10 units (KB, MB, GB).                                                                                                                                                           |
| `--brand-color` \<string>       | Color to use for branding and decorative elements. Hex code (#FF0000), name ('red'), or a palette index (0-255).                                                                                                                                     |
| `--color` \<color-mode>         | Whether to use color in output. Valid values: auto, disabled, enabled.                                                                                                                                                                               |
| `--container` \<string>         | Name of a local container to use when connecting to cluster.                                                                                                                                                                                         |
| `--history-size` \<int>         | Number of lines to keep in interactive mode history. Use -1 for unlimited. Default is 500.                                                                                                                                                           |
| `--host` \<string>              | Default hostname to use when connecting to cluster.                                                                                                                                                                                                  |
| `--insecure`                    | Skip peer validation for TLS connections. This is insecure!                                                                                                                                                                                          |
| `--jump-host` \<string>         | SSH bastion to tunnel the connection through, e.g. user@bastion. Uses the system ssh and your existing ~/.ssh/config, known\_hosts, and agent.                                                                                                       |
| `--kube-context` \<string>      | kubeconfig context for reaching an operator-managed cluster via kubectl port-forward. Defaults to the current context.                                                                                                                               |
| `--kube-namespace` \<string>    | Kubernetes namespace of the WEKA port-forward target.                                                                                                                                                                                                |
| `--kube-weka-cluster` \<string> | WEKA cluster name to reach via kubectl port-forward; the operator's management service is resolved by label. Enables Kubernetes mode.                                                                                                                |
| `--kubeconfig` \<string>        | Path to the kubeconfig file used for kubectl port-forward. Defaults to kubectl's own resolution (KUBECONFIG / ~/.kube/config).                                                                                                                       |
| `--kubectl-path` \<string>      | Path to the kubectl binary used for port-forward. Defaults to kubectl on PATH; the WEKA\_KUBECTL environment variable takes precedence.                                                                                                              |
| `--no-dynamic-completions`      | Suppress completions and help example values that require an active query to the cluster. Completion menus fall back to the static hint; help output omits the example values.                                                                       |
| `--no-icons`                    | Suppress use of icons for status.                                                                                                                                                                                                                    |
| `--no-update-check`             | Stop checking once a day whether a newer CLI has been released. The check never blocks a command; this suppresses it entirely.                                                                                                                       |
| `--port` \<uint16>              | Default TCP port to use when connecting to cluster.                                                                                                                                                                                                  |
| `--prefix-match-only`           | Match interactive completions only as a prefix instead of anywhere in the candidate.                                                                                                                                                                 |
| `--prompt` \<template>          | Template for the interactive-mode prompt. Supports variable placeholders like {profile}, {user}, {tenant}, {host}, {cluster}, {version}, {role}, {#}, and style verbs like {fg blue}, {bold}, {reset}. An empty value restores the built-in default. |
| `--ssh-opts` \<string>          | Extra arguments passed to ssh for the jump host, e.g. -i /path/to/id. The WEKA\_SSH\_OPTS environment variable takes precedence.                                                                                                                     |
| `--ssh-path` \<string>          | Path to the ssh binary used for the jump host. Defaults to ssh on PATH; the WEKA\_SSH environment variable takes precedence.                                                                                                                         |
| `--tab-to-complete`             | Show completion in interactive mode only after pressing TAB.                                                                                                                                                                                         |
| `--tenant` \<string>            | Tenant name or ID to use when authenticating.                                                                                                                                                                                                        |
| `--theme` \<theme>              | Select the default theme to use, which controls the appearance command results. Valid values: default, pretty, plain, classic.                                                                                                                       |
| `--username` \<string>          | Default username to use when authenticating.                                                                                                                                                                                                         |
| `--viewer-mouse`                | Capture the mouse in the `debug viewer` (click selects a line, wheel scrolls). Off by default so the terminal keeps drag-to-select for copying text; toggle live with M.                                                                             |
| `--viewer-theme` \<theme>       | Default color theme for the `debug viewer` trace viewer. Valid values: dark, light, classic, mono.                                                                                                                                                   |
