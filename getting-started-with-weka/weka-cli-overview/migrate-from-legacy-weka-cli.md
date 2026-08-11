---
description: >-
  Identify the behavior changes that affect existing scripts, monitoring probes,
  and automation when a cluster upgrades to WEKA 6.0.0 and wekactl becomes the
  default CLI.
---

# Migrate from legacy WEKA CLI

Starting with WEKA 6.0.0, the `weka` command on a cluster server invokes wekactl. The switch happens automatically on upgrade. For everyday interactive use, the two CLIs are largely compatible and familiar. Deliberate differences in terminology, output, flags, and packaging can affect long-time users, and especially existing shell scripts, as described in this topic.

Automation that uses the REST API is not affected by this change.

## Revert to the legacy CLI temporarily

To run the legacy CLI, set the following environment variable:

```
export WEKA_CLI_LEGACY=1
```

Use this as a fast mitigation while migrating scripts, not as a long-term configuration. The legacy CLI receives no new features and is planned for removal in a future release.

> **INTERNAL, remove before publication. TBD (Engineering, blocking):** Confirm the exact variable name (`WEKA_CLI_LEGACY` or `WEKACTL_CLI_LEGACY`) and its scope against a shipping build before publication.

## Write robust scripts

Follow these principles to make a migrated script robust against future changes:

1. Parse machine formats, not human tables. Prefer `--json` or `--tsv`. TSV has no in-cell tab characters, so column splitting is safe. The default human table layout is allowed to change over time.
2. Select fields by name, not position. Column order and headers can differ between the CLIs. With JSON, key off field names. With TSV, use the header row rather than fixed column indexes.
3. Use long flag names. Most legacy one-letter output flags do not exist in wekactl. Only `-J` (JSON) and `-R` (raw units) are preserved.
4. Rely on exit codes for success or failure, not on the presence or absence of output.
5. If a script must parse human output, set `WEKA_CLI_STYLE=plain` (or pass `--plain`) and `NO_COLOR=1` to guarantee stable, uncolored text. wekactl already defaults to plain, uncolored output when standard output is not a terminal.

## Changes that apply to every command

### Typed identifiers are plain numbers

The legacy CLI wraps identifiers in output as `HostId<3>`, `NodeId<15>`, `DiskId<5>`, and similar. wekactl prints the bare integer, and JSON carries a number, not a string. Update any parsing that expects the `XxxId<N>` form.

### Units follow industry conventions

* Throughput and storage capacities: decimal units (KB, MB, GB, TB, PB, EB).
* Memory (RAM): binary units (KiB, MiB, GiB, TiB, PiB, EiB).

This differs from the legacy CLI unit handling. Scripts that apply arithmetic or thresholds to sizes must recheck their assumptions. Do not parse scaled units. Use `--raw-units` (`-R`) for unscaled numbers, `--binary-units` to force binary units, or `--json`, whose values are raw numbers.

### Terminology changes in commands and headers

The user-facing vocabulary changed, and this appears in both command names and column headers:

| Legacy term                           | New term                                    | Compatibility                                                                                                                       |
| ------------------------------------- | ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Host (`--host`)                       | Container (`--container`)                   | Legacy flag generally kept as a hidden alias                                                                                        |
| Node (`--node-ids`, `Node ID` column) | Process (`--process-ids`, `Process` column) | Legacy flag kept as a hidden alias; the `node` tag is often retained for column selection with `-o`                                 |
| org / organization (`weka org`)       | tenant (`weka tenant`)                      | `org`, `orgs`, and `tenants` are aliases for the `tenant` group; the `--org` flag is a hidden alias for `--tenant` where it appears |

The verb changes beneath the `tenant` group are breaking. See [Breaking changes by command group](migrate-from-legacy-weka-cli.md#breaking-changes-by-command-group).

### Verb standardization: create becomes add, delete becomes remove

wekactl uses `add` and `remove` consistently. No `create` or `delete` alias exists, so these renames are breaking:

* `fs create` becomes `fs add`; `fs delete` becomes `fs remove`
* `fs group create` becomes `fs group add`; `fs group delete` becomes `fs group remove`
* `cluster create` becomes `cluster add`
* `user delete` becomes `user remove`
* `tenant create` becomes `tenant add`; `tenant delete` becomes `tenant remove`
* `nfs ... delete` becomes `nfs ... remove`
* `s3 bucket create` becomes `s3 bucket add`; `s3 bucket destroy` becomes `s3 bucket remove`

Known exceptions: `version rm` keeps `delete` as an alias, and `diags rm` accepts `destroy`, `delete`, and `remove`.

> **INTERNAL, remove before publication. TBD (Engineering):** A complete sweep of every command group for surviving `create` and `delete` aliases is pending (open item 4 in the engineering draft).

### Output format flags are long-form only

<table><thead><tr><th width="172.53125">Format</th><th>wekactl flag</th><th>Legacy short form</th></tr></thead><tbody><tr><td>JSON</td><td><code>--json</code> / <code>-J</code></td><td><code>-J</code> (unchanged)</td></tr><tr><td>Raw units</td><td><code>--raw-units</code> / <code>-R</code></td><td><code>-R</code> (unchanged)</td></tr><tr><td>CSV</td><td><code>--csv</code> (no short form)</td><td>TBD</td></tr><tr><td>TSV</td><td><code>--tsv</code> (new)</td><td>Did not exist</td></tr><tr><td>Markdown</td><td><code>--markdown</code> (no short form)</td><td>TBD</td></tr><tr><td>HTML</td><td><code>--html</code> (new)</td><td>Did not exist</td></tr><tr><td>No header row</td><td><code>--no-header</code> (no short form)</td><td>TBD</td></tr><tr><td>Style selection</td><td><code>--pretty</code> / <code>--plain</code> / <code>--classic</code></td><td>Did not exist</td></tr></tbody></table>

If a script used a one-letter flag for CSV, Markdown, or no-header output, switch it to the long form.

> **INTERNAL, remove before publication. TBD (Engineering):** Enumerate exactly which one-letter output flags the legacy CLI defined, so this table can state precisely which short forms disappeared (open item 2 in the engineering draft).

### The -v flag is context-dependent

At the root, `-v` means `--version`. On some subcommands, `-v` means `--verbose`. On `driver ready`, `-v` specifies a version to check. Prefer the long forms in scripts.

### Glob patterns in type and statistic filters

Filter-style options that take type or statistic names, such as `events --type` and `stats --stat`, accept glob metacharacters (`*`, `?`, `[]`). A script that passes a literal string containing these characters can now match unintended entries. Quote and review such arguments.

### Success messages and progress indication

Every command that changes state emits an explicit success or failure message. Scripts that treat empty output as success still work, because the exit code is authoritative, but standard output now carries a confirmation line.

Long-running operations show an in-place progress spinner on a terminal. Progress indicators are suppressed when output is not a terminal.

### Secrets and the clipboard

Commands that produce a secret, such as `weka user generate-token`, write it to the system clipboard when run on an interactive terminal. When run in a script, with output piped or captured, the secret prints to standard output as before, so `TOKEN=$(weka user generate-token)` keeps working. Use `--plain` to force console output, or `--json` for the raw token. Do not rely on the interactive clipboard path in automation.

### Interactive mode when invoked with no arguments

Running the CLI with no arguments on a terminal enters an interactive shell instead of printing help. A wrapper that invokes the binary with no arguments expecting help output must either pass an explicit subcommand or set `WEKA_CLI_NO_INTERACTIVE=1`.

### TLS trust on first use

All network communication uses TLS, with no plaintext fallback. On the first interactive connection, the CLI prompts to accept the certificate fingerprint. In non-interactive contexts, the certificate is accepted and saved automatically, so automation is never blocked on a prompt. Set `WEKA_TLS_STRICTNESS` to enforce stricter validation. Certificates signed by a CA in the system trust store involve no prompt or automatic acceptance.

## Breaking changes by command group

The following table lists the changes that fail outright and require a script update. Renames where the old spelling is kept as a hidden alias are not listed. The general changes above apply to every group and are not repeated.

<table><thead><tr><th width="140.50390625">Group</th><th width="292.20703125">Old</th><th>New</th></tr></thead><tbody><tr><td>cluster</td><td><code>cluster create</code></td><td><code>cluster add</code></td></tr><tr><td>cluster</td><td><code>cluster remote-cluster {add,update,remove}</code></td><td><code>cluster peer {add,update,remove}</code> (old path errors with a pointer to the new one)</td></tr><tr><td>cluster</td><td><code>cluster update</code> with no options (no-op)</td><td>Requires at least one option; a no-op now errors</td></tr><tr><td>fs</td><td><code>fs create</code> / <code>fs delete</code></td><td><code>fs add</code> / <code>fs remove</code></td></tr><tr><td>fs</td><td><code>fs group create</code> / <code>fs group delete</code></td><td><code>fs group add</code> / <code>fs group remove</code></td></tr><tr><td>fs</td><td><code>fs reserve unset</code></td><td><code>fs reserve reset</code></td></tr><tr><td>fs</td><td><code>fs quota unset</code></td><td><code>fs quota reset</code> (but <code>fs quota set-default</code> / <code>unset-default</code> keep the <code>unset</code> spelling; do not blanket search-and-replace)</td></tr><tr><td>fs</td><td><code>fs snapshot create</code> / <code>fs snapshot delete</code></td><td><code>fs snapshot add</code> / <code>fs snapshot remove</code></td></tr><tr><td>fs</td><td><code>fs protection snapshot-policy create</code> / <code>delete</code></td><td><code>... add</code> / <code>... remove</code></td></tr><tr><td>fs</td><td><code>fs tier s3 delete</code> / <code>fs tier obs delete</code></td><td><code>fs tier s3 remove</code> / <code>fs tier obs remove</code></td></tr><tr><td>nfs</td><td><code>nfs ... delete ...</code></td><td><code>nfs ... remove ...</code></td></tr><tr><td>nfs</td><td><code>nfs rules add dns &#x3C;NAME> &#x3C;DNS> --ip ...</code></td><td><code>--ip</code> on <code>rules add dns</code> errors; use <code>nfs rules add ip</code></td></tr><tr><td>s3</td><td><code>s3 bucket create</code> / <code>s3 bucket destroy</code></td><td><code>s3 bucket add</code> / <code>s3 bucket remove</code></td></tr><tr><td>s3</td><td><code>s3 cluster create</code> / <code>s3 cluster destroy</code></td><td><code>s3 cluster add</code> / <code>s3 cluster remove</code></td></tr><tr><td>s3</td><td>Creation-time bucket flags (<code>--etag-alg</code>, <code>--quota</code>, <code>--versioning</code>, and similar on <code>s3 bucket create</code>)</td><td>Configure after creation with subcommands: <code>s3 bucket checksum set</code>, <code>etag-alg set</code>, <code>integrity-mode set</code>, <code>quota set</code>, <code>sorting set</code>, <code>versioning enable</code>, <code>policy set</code>, <code>lifecycle-rule add</code></td></tr><tr><td>user / tenant</td><td><code>user delete</code></td><td><code>user remove</code></td></tr><tr><td>user / tenant</td><td><code>user change-role</code></td><td><code>user update --role</code> (stub points to the replacement)</td></tr><tr><td>user / tenant</td><td><code>org create</code> / <code>org delete</code> (<code>tenant create</code> / <code>delete</code>)</td><td><code>tenant add</code> / <code>tenant remove</code></td></tr><tr><td>security</td><td><code>security policy delete</code></td><td><code>security policy remove</code></td></tr><tr><td>stats</td><td><code>stats retention restore-default</code></td><td><code>stats retention reset</code></td></tr><tr><td>cloud</td><td><code>cloud proxy --set &#x3C;URL></code> / <code>cloud proxy --unset</code></td><td><code>cloud proxy set &#x3C;URL></code> / <code>cloud proxy reset</code> (flag form no longer exists)</td></tr><tr><td>dataservice</td><td><code>data-service ...</code></td><td><code>dataservice ...</code> (no hyphen; no hyphenated alias found)</td></tr><tr><td>smb</td><td>Parsing <code>smb cluster status</code> text lines (<code>hostname: Ready</code>)</td><td>Output is a formatted table (<code>Container</code>, <code>Status</code>)</td></tr><tr><td>status</td><td>Parsing <code>status reduction</code> free-text lines</td><td>Output is a table (<code>Reduction Ratio</code>, <code>Saved Bytes</code>)</td></tr><tr><td>status</td><td>Parsing specific lines or labels from the main <code>status</code> output</td><td>The layout was fully redesigned; re-verify any parsing</td></tr></tbody></table>

> **INTERNAL, remove before publication. TBD (Engineering):** The following items in this table are marked "verify" in the engineering draft and must be confirmed against a shipping build: the `dataservice` alias absence, the `stats retention reset` alias absence, whether `--unlink` carried over to `s3 bucket remove`, and the full legacy-to-new `security` command mapping (open items 4, 7, 10).

## Column and header changes

Column renames affect scripts that parse table or TSV output by header name. Key renames:

* **`cluster process`:** `Process ID` becomes `Process`, `Slot In Host` becomes `Slot`, `Failure Domain ID` becomes `Failure Domain`, `Blacklist Reason` and `Blacklist Time` become `Denied Reason` and `Denied Time` (JSON tags unchanged).
* **`cluster container`:** `Container ID` becomes `ID`, `Failure Domain Name` becomes `Failure Domain`, `Platform` becomes `OS Name`, plus new columns.
* **`cluster drive`:** `Disk ID` becomes `ID`, `Host ID` becomes `Container`, `Node ID` becomes `Process`, `Device Path` becomes `Path`, `Serial Number` becomes `Serial`.
* **`cloud status`:** `Host` becomes `Container`, `Is Healthy` becomes `Healthy`.
* **NFS interface group:** `Subnet Mask` becomes `Netmask` (the JSON field also changes). NFS permission `Squashing` becomes `Squash`, and `AnonUid` and `AnonGid` render as empty instead of `0` when zero.

JSON field naming can differ between the CLIs. Re-verify any `--json` parsing against the documented field names.

> **INTERNAL, remove before publication. TBD (Engineering):** Exact new column labels for `cluster server`, `cluster bucket`, `cluster failure-domain`, `cluster task`, `s3 bucket list`, and `s3 cluster status` are pending (open items 5, 9 in the engineering draft).

## New capabilities with no legacy equivalent

* `fs replication` (`add`, `update`, `pause`, `resume`, `remove`, `fetch`): persistent replication-pair management, distinct from the one-shot `fs replicate`.
* `stats show` and `stats categories`; `events categories` and `events --proxy` / `--no-proxy`.
* `status meta`: version, build, tenant mode, and revision details.
* `version get <version> [--set-current]`: download and stage any WEKA version locally with parallel progress bars, without a running agent.
* Connection through SSH bastions (`--jump`) and the WEKA Operator (`--kube-weka-cluster`).
* `s3 service-account`, `s3 sts`, `s3 group`, and `s3 policy` groups.

## Deprecated forms that still work

These forms continue to work but warn or are hidden. Plan to update them:

* `fs set-qos` is a deprecated shim for `fs update --max-throughput / --max-iops`.
* NFS interface group `--subnet <dotted-mask>` is a hidden, deprecated alias for `--netmask <bits>`; dotted netmask syntax in IP rules warns in favor of CIDR.
* Relocated s3 forms: `s3 local` becomes `s3 cluster local`, `s3 cluster kv` becomes `s3 kv`, `s3 cluster group` becomes `s3 group`, `s3 profile` becomes `debug s3 profile`, `s3 log-level` becomes `debug s3 log-level`.

> **INTERNAL, remove before publication. TBD (PM):** The last two relocations point customers to the `debug` command group, which is not documented on docs.weka.io. Decide whether to keep these two items in the customer-facing topic or drop them.
