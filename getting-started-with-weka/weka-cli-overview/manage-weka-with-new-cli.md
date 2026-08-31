---
description: >-
  Use wekactl to install WEKA, manage profiles, control output formatting,
  filter and inspect data, and configure TLS certificate handling.
---

# Manage WEKA with new CLI

Starting with WEKA 6.0.0, wekactl is the default CLI, and the `weka` command on a cluster server invokes it. The examples in this topic use `weka`.

## Before you begin

* On a cluster server, no installation is required. wekactl ships inside the product.
* To manage clusters from a workstation that is not a cluster server, install the standalone binary. See [Install wekactl on a workstation](manage-weka-with-new-cli.md#install-wekactl-on-a-workstation).
* To install a WEKA version using the CLI, a get.weka.io token is required.

{% hint style="info" %}
wekactl detects the API version each cluster offers and falls back automatically, so a single binary manages any cluster in a supported Release Line. See [Release support and commitments](../../support/release-support-and-commitments.md).
{% endhint %}

## Access wekactl on a cluster server

On any server running WEKA 6.0.0, the `weka` command invokes wekactl. The binary is also available directly at:

```
/opt/weka/bin/wekactl
```

The legacy CLI binary remains available at `/opt/weka/bin/weka` alongside wekactl.

To revert to the legacy CLI temporarily, set the following environment variable:

```
export WEKA_CLI_LEGACY=1
```

The legacy CLI is a migration aid only. It receives no new features and is planned for removal in a future release. For details on behavior differences that affect existing scripts, see [Migrate from the legacy weka CLI to wekactl](manage-weka-with-new-cli.md).

## Install wekactl on a workstation

1. Go to get.weka.io and open the **CLI** tab.
2. Select your platform from the left: **RPM**, **DEB**, **macOS**, or **Windows**, then follow the steps shown.

Each platform offers a package manager setup and a direct package download. The standalone build is version-independent and can manage clusters running earlier WEKA versions.

To install a specific WEKA version on a server:

```bash
weka version get <version> --set-current
```

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (PM/Engineering):** Confirm the get.weka.io delivery channels listed above match what ships for 6.0.0 (open item 1 in the migration guide draft).
{% endhint %}

## Connect for the first time

Run wekactl with no arguments. With no profile saved, it prompts for a profile name, cluster hostname, port, username, and password, then presents the cluster TLS certificate fingerprint for you to trust. It saves and activates the profile, then opens the interactive shell.

```bash
wekactl
```

Verify the SHA256 fingerprint against the cluster before accepting it. Accepting saves the certificate for all WEKA hosts used by this profile.

Type `exit` to leave the shell and run commands directly. To add more clusters, see [Manage profiles](manage-weka-with-new-cli.md#manage-profiles).

## Bootstrap a stateless client

After installing the standalone `rpm` or `deb` package, run the standard mount command:

```bash
mount -t wekafs <backend>/<filesystem> <mount-point>
```

On the first connection, the CLI establishes trust in the cluster TLS certificate. In non-interactive contexts, such as a scripted or first-boot mount, the certificate is accepted and saved automatically, so the mount is not blocked on a prompt. See [Manage TLS certificates](manage-weka-with-new-cli.md#manage-tls-certificates).

## Manage profiles

| Operation                 | Command                                      |
| ------------------------- | -------------------------------------------- |
| Create a profile          | `weka profile add &#x3C;profile_name>`       |
| List profiles             | `weka profile list`                          |
| Show a profile            | `weka profile show &#x3C;profile_name>`      |
| Select the active profile | `weka profile select &#x3C;profile_name>`    |
| Update a profile          | `weka profile update &#x3C;profile_name>`    |
| Duplicate a profile       | `weka profile duplicate &#x3C;profile_name> &#x3C;new_profile_name>` |
| Delete a profile          | `weka profile remove &#x3C;profile_name>`    |
| Log out of a profile      | `weka profile logout &#x3C;profile_name>`    |
| Purge a profile's saved data | `weka profile purge {certs \| cache \| history \| all} [&#x3C;profile_name>]` |

Profile settings are stored as editable JSON files and can be overridden using environment variables. On Linux, when no custom profile is selected, wekactl reuses an existing token created by the legacy weka CLI.

## Control output format and style

Each output format has its own flag:

```bash
weka <command> --<format>
```

<table><thead><tr><th width="228.3046875">Format</th><th>Flag</th></tr></thead><tbody><tr><td>JSON</td><td><code>--json</code> or <code>-J</code></td></tr><tr><td>CSV</td><td><code>--csv</code></td></tr><tr><td>TSV</td><td><code>--tsv</code></td></tr><tr><td>Markdown</td><td><code>--markdown</code></td></tr><tr><td>HTML</td><td><code>--html</code></td></tr></tbody></table>

{% hint style="info" %}
Output style is separate from format. `--pretty` is the default on a terminal, and `--plain` is the default when output is redirected. Use `--classic` for output compatible with earlier WEKA versions.

To show unscaled values, add `--raw-units` (`-R`) to any of the above. It changes how values are rendered, not the format.
{% endhint %}

To add, remove, or reorder columns selectively:

```bash
weka <command> -o +<column_name>,-<column_name>
```

To disable terminal word-wrapping and clipping:

```bash
weka <command> --clip=false
```

To pipe output to a pager:

```bash
weka <command> --pager
```

The default pager is `less -S -R`. To use a different pager, set `WEKA_CLI_PAGER`.

To render output as an HTML page in the default browser:

```bash
weka <command> --browser
```

To refresh output at a fixed interval:

```bash
weka <command> --watch <interval>
```

To label a table:

```bash
weka <command> --title "<title>"
weka <command> --custom-title "<title>"
weka <command> --caption "<caption>"
```

## Trim output with head and tail

To display only the first or last N records:

```bash
weka <command> --head <n>
weka <command> --tail <n>
```

`--head` and `--tail` operate on records, not lines, and also work with JSON output. Use both together to see the spread between the top and bottom records. Use negative values to exclude outliers.

## Filter rows

To include only rows matching a field value:

```bash
weka <command> --filter <field>=<value>
```

To exclude rows matching a field value, prefix the value with `~`:

```bash
weka <command> --filter <field>=~<value>
```

To filter by row color, for example to show only non-nominal rows:

```bash
weka <command> --filter-color=~green
```

## View statistics and histograms

The `stats show` subcommand merges multiple statistics on a single line and supports column reordering and sorting by a chosen statistic.

To display a visual histogram:

```bash
weka stats --output +histogram
```

To display a histogram for a specific statistic:

```bash
weka stats show --output +<stat_name>.histogram
```

For example:

```bash
weka stats show --output +reactor.step_cycles.histogram
```

## Manage TLS certificates

All network communication uses TLS. Certificate trust follows a trust-on-first-use model:

* On the first interactive connection to a server, the CLI displays the certificate fingerprint, issuer, and expiry, and prompts for confirmation. Accepted certificates are saved to the active profile automatically.
* In non-interactive contexts, the certificate is accepted and saved automatically on first use. To enforce stricter validation, set `WEKA_TLS_STRICTNESS`.
* If the cluster uses a certificate signed by a trusted authority already installed in the system certificate store, no prompt appears.

To bypass certificate validation:

```bash
weka <command> --insecure
weka <command> -k
```

Bypassing certificate validation skips the certificate check only. The connection remains TLS-encrypted. Bypassing certificate validation is not recommended in production environments.

## Connect through a bastion or Kubernetes

To tunnel the connection through an SSH jump server:

```bash
weka <command> --jump <user>@<bastion>
```

Alternatively, set the `WEKA_JUMP_HOST` environment variable or configure the jump server in the profile. The tunnel uses the system `ssh` and inherits the local SSH configuration, agent, and MFA prompts.

To reach a cluster managed by the WEKA Operator:

```bash
weka <command> --kube-weka-cluster <name>
```

The connection tunnels through `kubectl port-forward` using the current kubeconfig and credentials. Related flags: `--kube-namespace`, `--kube-context`, `--kubeconfig`.

## Use interactive mode

To enter interactive mode, launch the CLI without arguments:

```bash
weka
```

To disable interactive mode and print help instead:

```bash
export WEKA_CLI_NO_INTERACTIVE=1
```

For shell completion setup outside interactive mode, run:

```bash
weka completion <bash|zsh|fish|powershell>
```
