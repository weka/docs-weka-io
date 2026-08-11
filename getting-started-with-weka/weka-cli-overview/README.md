---
description: >-
  Manage WEKA clusters from any supported platform using wekactl, a modern
  command-line interface and Go API.
---

# New WEKA CLI (formerly wekactl) overview

wekactl provides a comprehensive administrative interface for WEKA clusters and supports most cluster management operations available in the legacy weka CLI. Unlike the legacy CLI, wekactl runs directly on Linux, macOS, and Windows systems, eliminating the need to log in to a cluster server for day-to-day administration.

Starting with WEKA 6.0.0, wekactl is the default CLI. Running the `weka` command on a cluster server invokes wekactl. The command examples in this documentation use `weka`.

> **INTERNAL, remove before publication. TBD (Engineering/PM):** Confirm the invocation convention for standalone installations on a workstation (macOS, Windows, or a non-cluster Linux server). Is the binary invoked as `wekactl`, `weka`, or both? All command examples in this topic set follow the answer.

If you upgrade from an earlier version and rely on scripts that parse legacy CLI output, review [Migrate from the legacy weka CLI to wekactl](./#) before switching.

## Key capabilities

### Cross-platform and remote management

wekactl is a single self-contained binary that connects to a cluster over the network, or over a UNIX domain socket when it runs on a WEKA server. Administrators can issue cluster management commands directly from a Linux, macOS, or Windows workstation without connecting to a cluster server first.

Commands that proxy through the local agent remain available only when wekactl runs locally on a WEKA server. For the list of these commands, see [Considerations](./#considerations).

### Version independence

A single wekactl binary manages clusters across multiple WEKA versions. This differs from the legacy CLI, whose behavior is tied to the installed cluster version.

> **INTERNAL, remove before publication. TBD (Engineering):** Confirm the minimum manageable cluster version. The migration guide draft states WEKA 4.2 and later. An earlier draft states WEKA 5.0.2 and later, or 4.4.8 and later (LTS). One statement must win.

### Output customization

Control output appearance using environment variables:

| Variable                   | Description                                             |
| -------------------------- | ------------------------------------------------------- |
| `WEKA_CLI_STYLE`           | Output style: `pretty`, `plain`, or `classic`           |
| `WEKA_CLI_BRAND_COLOR`     | Custom brand color in CSS hex format                    |
| `WEKA_CLI_ACCENT_COLOR`    | Custom accent color in CSS hex format                   |
| `WEKA_CLI_PAGER`           | Pager command used by `--pager` (default: `less -S -R`) |
| `WEKA_CLI_NO_INTERACTIVE`  | Any non-empty value suppresses interactive mode         |
| `NO_COLOR` / `FORCE_COLOR` | Standard color control conventions, honored             |

> **INTERNAL, remove before publication. TBD (Engineering):** Verify the color-related names and values. The PM draft lists `WEKA_BRAND_COLOR` (no `CLI`) and a `WEKA_CLI_COLOR` variable with values `auto`, `always`, `never`. The migration guide draft lists `WEKA_CLI_BRAND_COLOR`, `WEKA_CLI_ACCENT_COLOR`, and a `--color=auto|enabled|disabled` flag instead of a color variable. Confirm the shipping names and value sets.

Supported output formats: pretty, plain, classic, JSON, CSV, TSV, HTML, and Markdown. TSV is recommended for shell scripting and automation workflows because tab characters never appear in cell content.

The three display styles behave as follows:

* `pretty`: Default when output goes to a terminal. Includes colors, box drawing, and terminal-width awareness.
* `plain`: Default when output does not go to a terminal, such as a pipe or a file. The safe choice for scripts.
* `classic`: Mimics the legacy weka CLI layout, without terminal-width awareness.

### Visual histograms

Statistics output supports inline visual histograms in both terminal and HTML views.

Use `-o +histogram` with `stats` commands, or specify a named statistic directly, such as `-o +reactor.step_cycles.histogram`. This converts raw numeric distributions into bar charts rendered in the terminal.

### Explicit feedback

Commands that change state return an explicit success or failure message. Operations such as `start-io` and `stop-io` display in-place progress spinners, and `version get` displays per-component download progress bars. Progress indicators are suppressed automatically when output does not go to a terminal, so scripts and logs stay clean.

Commands that generate a secret, such as `weka user generate-token`, write the secret to the system clipboard instead of displaying it on screen, but only when they run on an interactive terminal. When the command runs in a script or its output is piped or captured, the secret prints to standard output as before.

> **INTERNAL, remove before publication. TBD (Engineering):** Confirm the command name. The PM draft references `security generate-token`; the migration guide draft references `user generate-token`. Also confirm the interactive behavior when no clipboard is available (the migration guide draft states the command errors rather than printing).

### Terminal-aware display

Output tables adjust to the current terminal width. Columns wrap or clip automatically to keep the view readable.

Use `--browser` to render the output as a responsive HTML page in the default browser. Add `--watch <interval>` to refresh the view automatically. For large terminal tables, use `--pager` to open the output in a pager.

### Granular output control

Column selection, row filtering, and table labels can all be applied in a single command:

* Add, remove, or reorder columns: `-o +<column>,-<column>`
* Include rows by field value: `--filter <field>=<value>`
* Exclude rows by field value: `--filter <field>=~<value>`
* Filter rows by color, for example all non-nominal rows: `--filter-color=~green`
* Label tables for multi-window monitoring: `--title`, `--custom-title`, `--caption`

### Multi-cluster profile management and TLS security

Profiles let administrators manage independent connection contexts for separate clusters, each with its own authentication token, TLS certificates, connection settings, and color preferences.

Profiles are stored as editable JSON files in the platform-specific user configuration directory, and every profile setting can be overridden with an environment variable. TLS certificates are saved per profile. Each profile is fully isolated.

Profiles created with wekactl are not compatible with legacy weka CLI profiles and do not share its tokens. However, on Linux, when no custom profile is selected and a token created by the legacy weka CLI already exists, wekactl reuses that token.

wekactl enforces TLS for all network communication. There is no plaintext fallback. When connecting to a local container, wekactl uses UNIX domain sockets and TLS is not involved.

Certificate trust follows a trust-on-first-use model:

* On the first interactive connection to a server whose certificate is not already trusted, wekactl displays the certificate fingerprint, issuer, and expiry, and prompts for confirmation. Accepted certificates are saved to the active profile automatically.
* When wekactl runs non-interactively, such as in a script, a service, or a first-boot mount, it accepts and saves the certificate automatically on first use, so automation is never blocked on a prompt. To enforce stricter validation in non-interactive contexts, set the `WEKA_TLS_STRICTNESS` environment variable.
* If the cluster uses a certificate signed by a trusted authority already installed in the system certificate store, no prompt or automatic acceptance is involved.

> **INTERNAL, remove before publication. TBD (Engineering):** Document the accepted values of `WEKA_TLS_STRICTNESS`.

### Connect through bastions and Kubernetes

Reach clusters that are not directly routable from the workstation:

* SSH jump server: `--jump user@bastion` (or the `WEKA_JUMP_HOST` environment variable, or a profile setting) tunnels the connection through the system `ssh`, inheriting the local SSH configuration, agent, and MFA prompts.
* Kubernetes operator: `--kube-weka-cluster <name>` reaches a cluster managed by the WEKA Operator by tunneling through `kubectl port-forward`, using the current kubeconfig and credentials.

### Interactive mode and shell completions

Launching the CLI without arguments on a terminal opens an interactive shell with command-line completion and profile switching. The active profile appears in the prompt. Shell completions are also available for Bash, Zsh, Fish, and PowerShell for use outside interactive mode.

## Standardized units

wekactl aligns unit reporting with industry conventions:

| Measurement            | Units                                |
| ---------------------- | ------------------------------------ |
| Memory (RAM)           | Binary: KiB, MiB, GiB, TiB, PiB, EiB |
| Storage and throughput | Decimal: KB, MB, GB, TB, PB, EB      |

This differs from the legacy CLI unit handling. Scripts must not parse scaled units. Use `--raw-units` (`-R`) or `--json`, whose values are raw numbers, and scale in the script.

## Comparison with the legacy weka CLI

Compare the legacy weka CLI and wekactl to identify the main operational advantages of wekactl.

| Dimension           | Legacy weka CLI                   | wekactl                                                    |
| ------------------- | --------------------------------- | ---------------------------------------------------------- |
| Binary size         | \~130 MB                          | Less than 20 MB; Deb/RPM packages less than 5 MB           |
| Platform support    | Linux cluster servers only        | Linux, macOS, Windows                                      |
| Output formats      | Plain text                        | JSON, TSV, CSV, HTML, Markdown, table                      |
| Success feedback    | Silent on success                 | Explicit success and failure messages                      |
| TLS                 | Optional                          | Always enforced                                            |
| Histograms          | Not available                     | Terminal and HTML                                          |
| Interactive mode    | Not available                     | Full interactive shell with completions                    |
| Profile isolation   | Shared token store                | Per-profile tokens, certificates, and settings             |
| Version coupling    | Tied to installed cluster version | One binary manages multiple cluster versions               |
| Remote connectivity | Requires SSH to a cluster server  | Direct, plus SSH bastion and Kubernetes operator tunneling |

## Considerations

* **Local-only commands:** Commands that proxy through the local agent, including `local`, `agent`, `smb`, `audit`, `mount`, `umount`, most `debug` commands, most `driver` commands, and the server-side `version` operations (`set`, `reset`, `prepare`, `current`, `rm`), are available only when running locally on a server running WEKA. `version get` runs from anywhere without an agent; only `version get --set-current` requires the server.
* **Remote management limits:** Managing directory-based quotas remotely requires data services to be enabled on the cluster. Otherwise, run quota management commands on a WEKA server.
* **Profile compatibility:** wekactl profiles are not compatible with legacy weka CLI profiles. See [Multi-cluster profile management and TLS security](./#multi-cluster-profile-management-and-tls-security) for the Linux token reuse exception.
* **Legacy CLI fallback:** After upgrading to WEKA 6.0.0, revert to the legacy CLI temporarily by setting an environment variable. See [Migrate from the legacy weka CLI to wekactl](./#).

> **INTERNAL, remove before publication. TBD (Engineering):** The "remote management limits" statement about directory-based quotas comes from product documentation and is not visibly enforced in CLI help. Confirm with engineering.
