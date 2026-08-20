---
description: >-
  Identify the behavior changes that affect existing scripts, monitoring probes,
  and automation when a cluster upgrades to WEKA 6.0.0 and wekactl becomes the
  default CLI.
---

# Migrate from legacy WEKA CLI

Starting with WEKA 6.0.0, the weka command on a cluster server invokes wekactl. The switch happens automatically on upgrade. For everyday interactive use, the two CLIs are largely compatible and familiar. Deliberate differences in terminology, output, flags, and packaging can affect long-time users, and especially existing shell scripts, as described in this topic.

Automation that uses the REST API is not affected by this change.

## Revert to the legacy CLI temporarily

To run the legacy CLI, set the following environment variable:

```
export WEKA_CLI_LEGACY=1
```

Use this as a fast mitigation while migrating scripts, not as a long-term configuration. The legacy CLI receives no new features and is planned for removal in a future release.

{% hint style="danger" %}
INTERNAL, remove before publication. TBD (Engineering, blocking): Confirm the exact variable name (`WEKA_CLI_LEGACY` or `WEKACTL_CLI_LEGACY`) and its scope against a shipping build before publication.
{% endhint %}

## Write robust scripts

Follow these principles to make a migrated script robust against future changes:

1. Parse machine formats, not human tables. Prefer `--json` or `--tsv`. TSV has no in-cell tab characters, so column splitting is safe. The default human table layout is allowed to change over time.
2. Select fields by name, not position. Column order and headers can differ between the CLIs. With JSON, key off field names. With TSV, use the header row rather than fixed column indexes.
3. Check the short flags you rely on. Most carry over unchanged, but `-f` and `-C` changed meaning, which is more dangerous than a flag that disappears. See Short flags that changed meaning.
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

| Legacy term                         | New term                                  | Compatibility                                                                                                                     |
| ----------------------------------- | ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Host (`--host`)                     | Container (`--container`)                 | Legacy flag generally kept as a hidden alias                                                                                      |
| Node (`--node-ids`, Node ID column) | Process (`--process-ids`, Process column) | Legacy flag kept as a hidden alias; the node tag is often retained for column selection with `-o`                                 |
| org / organization (`weka org`)     | tenant (`weka tenant`)                    | `org`, `orgs`, and `tenants` are aliases for the tenant group; the `--org` flag is a hidden alias for `--tenant` where it appears |

The verb changes beneath the tenant group are breaking. See Breaking changes by command group.

### Verb standardization: create becomes add, delete becomes remove

wekactl uses add and remove consistently. No create or delete alias exists, so these renames are breaking:

* `fs create` becomes `fs add`; `fs delete` becomes `fs remove`
* `fs group create` becomes `fs group add`; `fs group delete` becomes `fs group remove`
* `cluster create` becomes `cluster add`
* `user delete` becomes `user remove`
* `tenant create` becomes `tenant add`; `tenant delete` becomes `tenant remove`
* `nfs ... delete` becomes `nfs ... remove`
* `s3 bucket create` becomes `s3 bucket add`; `s3 bucket destroy` becomes `s3 bucket remove`

Known exceptions: `version rm` keeps `delete` as an alias, and `diags rm` accepts `destroy`, `delete`, and `remove`.

Three commands run against this convention in 6.0. Do not assume add and remove are correct everywhere:

* `smb cluster add` becomes `smb cluster create`
* `smb cluster remove` becomes `smb cluster destroy`
* `catalog metadata remove` becomes `catalog metadata delete`

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Engineering):** Two questions on this section.

First, a complete sweep of every command group for surviving create and delete aliases is pending (open item 4 in the engineering draft).

Second, and new: the 5.1.31 CLI reference generated by `weka --gitbook` documents `fs add`, `fs remove`, `fs group add`, `fs snapshot add`, `s3 bucket add`, `user remove`, `security policy remove`, and `dataservice` already. None of the create or delete spellings in the list above appears anywhere in the 5.1.31 generated reference. So either both spellings worked in 5.1.31 and only the add form was documented, or this list describes a baseline older than 5.1.31. This matters for scope: if the add form already worked, a script written against the documented 5.1.31 spelling is not affected by these rows, and only scripts using the undocumented create form break. Confirm which, then scope this section accordingly.

The terminology table above has the same problem and needs the same answer. `--host` and `--node-ids` return no matches in the 5.1.31 reference, and `weka org` is not a documented command group there; 5.1.31 already ships `weka tenant` with 17 commands. So either those legacy spellings were undocumented aliases, or the table predates 5.1.31.
{% endhint %}

### Output format flags are long-form only

| Format          | wekactl flag                         | Legacy equivalent                                                              |
| --------------- | ------------------------------------ | ------------------------------------------------------------------------------ |
| JSON            | `--json` / `-J`                      | `-J` (unchanged)                                                               |
| Raw units       | `--raw-units` / `-R`                 | `-R` (unchanged)                                                               |
| CSV             | `--csv` (no short form)              | `--format csv` (`-f csv`)                                                      |
| TSV             | `--tsv` (new)                        | Did not exist                                                                  |
| Markdown        | `--markdown` (no short form)         | `--format markdown` (`-f markdown`)                                            |
| HTML            | `--html` (new)                       | Did not exist                                                                  |
| No header row   | `--no-header` (no short form)        | `--no-header` (no short form; unchanged)                                       |
| Style selection | `--pretty` / `--plain` / `--classic` | `--format view` and `--format oldview`; `--plain` and `--pretty` did not exist |

The legacy CLI had no `--csv`, `--markdown`, `--tsv`, or `--html` flag. It selected a format with a single option, `-f` / `--format`, taking one of `view`, `csv`, `markdown`, `json`, or `oldview`. That option does not exist in wekactl. Replace it with the matching format flag from the table above; `--format oldview` maps to `--classic`.

### Short flags that changed meaning

Seven one-letter output flags carry over unchanged: `-J` (`--json`), `-R` (`--raw-units`), `-U` (`--UTC`), `-o` (`--output`), `-s` (`--sort`), `-F` (`--filter`), and `-v` (`--verbose`). Among the output flags, only `-f` (`--format`) was lost. Connection short flags carry over as well, including `-H`, `-P`, and `-T`.

Two changed meaning. These are more dangerous than a flag that disappears, because the command still runs:

| Short flag | Legacy CLI                                                                                                                                                              | wekactl                                                   |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| `-f`       | `--format` on 82 commands, `--force` on 69                                                                                                                              | `--force` only                                            |
| `-C`       | `--CONNECT-TIMEOUT` on every command that connects to a cluster, `--container` on `weka local` commands and on `upgrade backends`, `version current`, and `version set` | `--container` only; `--CONNECT-TIMEOUT` has no short form |

{% hint style="warning" %}
A script passing `-f csv` no longer selects a format. In wekactl, `-f` is `--force`, which takes no value and suppresses confirmation prompts, so the command can proceed without asking. Audit every `-f` in existing scripts.

A script passing a duration to `-C` supplies a container name in wekactl, and the connect timeout silently reverts to the default.
{% endhint %}

`-S` is new in wekactl and is the short form of `--CONTAINER`, for selecting a local container to connect to.

### The -v flag is context-dependent

At the root, `-v` means `--version`. On most subcommands, `-v` means `--verbose`. On `driver ready`, `-v` means `--version` and takes a value, so it consumes the next token. Prefer the long forms in scripts.

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

## Positional arguments that were removed

These commands take fewer arguments than the legacy CLI documented. A legacy command line supplies one argument too many. The values still bind to the remaining slots in order, so the command either misreads an argument or reports an unexpected one.

| Command                   | Legacy CLI                                  | wekactl                                                              |
| ------------------------- | ------------------------------------------- | -------------------------------------------------------------------- |
| `fs add`                  | `<name> <group-name> <total-capacity>`      | `<name> <total-capacity>`, with the group supplied by `--fs-group`   |
| `nfs interface-group add` | `<name> <type>`                             | `<name>`                                                             |
| `driver sign`             | `<key> <passwd>`, with an optional `<cert>` | `<key-file> [<cert-file>]`, with the password supplied by `--passwd` |

{% hint style="warning" %}
`fs add` is the most damaging of these, because the old command line stays syntactically valid. `weka fs add myfs default 10TB` supplied a name, a group, and a capacity in the legacy CLI. In wekactl the same line supplies a name and a capacity, so `default` is read as the total capacity and `10TB` is an unexpected extra argument. Filesystem group membership is optional in 6.0 and is set with `--fs-group`.
{% endhint %}

## Options renamed on commands that kept their name

A command name search does not surface these. The option changed instead.

| Command                                  | Legacy option            | wekactl option                  |
| ---------------------------------------- | ------------------------ | ------------------------------- |
| `cluster container add`                  | `--host-fqdn`            | `--fqdn`                        |
| `cluster default-net set` and `update`   | `--netmask-bits`         | `--netmask`                     |
| `cluster network-space add` and `update` | `--netmask-bits`         | `--netmask`                     |
| `events`                                 | `--category-list`        | `--category`                    |
| `events`                                 | `--type-list`            | `--type`                        |
| `events`                                 | `--exclude-type-list`    | `--exclude-type`                |
| `fs group add` and `update`              | `--target-ssd-retention` | `--ssd-retention`               |
| `fs snapshot add`                        | `--is-writable`          | `--writable`                    |
| `local setup client`                     | `--nvidia-vf-single-ip`  | `--disable-nvidia-vf-single-ip` |

Both spellings of the netmask option take a length in bits, so only the name changes.

{% hint style="warning" %}
`--nvidia-vf-single-ip` and `--disable-nvidia-vf-single-ip` are opposites, not synonyms. A script that renames the option in place gets the opposite behavior. Remove the option to keep the legacy behavior.
{% endhint %}

## Options no longer available

The `--capacities` option is removed from `weka fs`. These options are also gone from commands that still exist:

`--agent` on `weka`, `--cloud-stats` on `cloud enable`, `--overwrite_resource_ips` on `cluster add`, `--allow-unavailable` on `cluster container deactivate`, `--skip-resource-validation` on `fs download`, `--force` on `local resources auto-remove-timeout`, `--custom-options` on `nfs permission update`, `--ip` on `nfs rules add dns`, `--type` on `s3 bucket add`, `--verify` on `s3 cluster audit-webhook enable`, `--queue-dir` on `s3 cluster notification-target add` and `update`, `--claim-name` and `--groups-claim-name` on `s3 cluster oidc add` and `update`, and `--show-total` on `stats realtime`.

`--custom-options` on `nfs permission update` corresponds to the new `nfs custom-options` group.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Engineering):** Confirm each option in this list is removed from the CLI rather than only absent from generated help. An option missing from `--gitbook` output is not proof of removal. This is open item 5 in the reviewer notes.
{% endhint %}

## Breaking changes by command group

The following table lists the changes that fail outright and require a script update. Renames where the old spelling is kept as a hidden alias are not listed. The general changes above apply to every group and are not repeated.

<table><thead><tr><th width="138.82421875">Group</th><th>Old</th><th>New</th></tr></thead><tbody><tr><td>audit</td><td><code>audit cluster ...</code> and <code>audit fs ...</code> (23 commands)</td><td>No replacement. <code>weka audit</code> takes no subcommands. Enable filesystem auditing with <code>--audit-enabled</code> on <code>fs add</code>, <code>fs update</code>, or <code>fs download</code></td></tr><tr><td>catalog</td><td><code>catalog metadata remove</code></td><td><code>catalog metadata delete</code></td></tr><tr><td>cluster</td><td><code>cluster create</code></td><td><code>cluster add</code></td></tr><tr><td>cluster</td><td><code>cluster remote-cluster {add,update,remove}</code></td><td><code>cluster peer {add,update,remove}</code> (old path errors with a pointer to the new one)</td></tr><tr><td>cluster</td><td><code>cluster update</code> with no options (no-op)</td><td>Requires at least one option; a no-op now errors</td></tr><tr><td>cluster</td><td><code>cluster servers ...</code></td><td><code>cluster server ...</code> (singular)</td></tr><tr><td>events</td><td><code>events list-local</code></td><td><code>events local</code></td></tr><tr><td>events</td><td><code>events list-types</code></td><td><code>events types</code></td></tr><tr><td>events</td><td><code>events trigger-event</code></td><td><code>events trigger</code></td></tr><tr><td>fs</td><td><code>fs create</code> / <code>fs delete</code></td><td><code>fs add</code> / <code>fs remove</code></td></tr><tr><td>fs</td><td><code>fs group create</code> / <code>fs group delete</code></td><td><code>fs group add</code> / <code>fs group remove</code></td></tr><tr><td>fs</td><td><code>fs reserve unset</code></td><td><code>fs reserve reset</code></td></tr><tr><td>fs</td><td><code>fs quota unset</code></td><td><code>fs quota reset</code> (but <code>fs quota set-default</code> / <code>unset-default</code> keep the <code>unset</code> spelling; do not blanket search-and-replace)</td></tr><tr><td>fs</td><td><code>fs snapshot create</code> / <code>fs snapshot delete</code></td><td><code>fs snapshot add</code> / <code>fs snapshot remove</code></td></tr><tr><td>fs</td><td><code>fs protection snapshot-policy create</code> / <code>delete</code></td><td><code>... add</code> / <code>... remove</code></td></tr><tr><td>fs</td><td><code>fs tier s3 delete</code> / <code>fs tier obs delete</code></td><td><code>fs tier s3 remove</code> / <code>fs tier obs remove</code></td></tr><tr><td>interface group</td><td><code>interface-group ...</code> (11 commands at the top level)</td><td><code>nfs interface-group ...</code>. The <code>nfs</code> path is documented in 5.1.31 as well; only the top-level path is dropped</td></tr><tr><td>local</td><td><code>local install-agent</code></td><td><code>agent install-agent</code> (documented in 5.1.31 as well)</td></tr><tr><td>local</td><td><code>local setup weka</code></td><td><code>local setup container</code>. Role-specific containers are also available with <code>local setup compute</code> and <code>local setup drives</code></td></tr><tr><td>nfs</td><td><code>nfs ... delete ...</code></td><td><code>nfs ... remove ...</code></td></tr><tr><td>nfs</td><td><code>nfs rules add dns &#x3C;NAME> &#x3C;DNS> --ip ...</code></td><td><code>--ip</code> on <code>rules add dns</code> errors; use <code>nfs rules add ip</code></td></tr><tr><td>s3</td><td><code>s3 bucket create</code> / <code>s3 bucket destroy</code></td><td><code>s3 bucket add</code> / <code>s3 bucket remove</code></td></tr><tr><td>s3</td><td><code>s3 cluster create</code> / <code>s3 cluster destroy</code></td><td><code>s3 cluster add</code> / <code>s3 cluster remove</code></td></tr><tr><td>s3</td><td>Creation-time bucket flags (<code>--etag-alg</code>, <code>--quota</code>, <code>--versioning</code>, and similar on <code>s3 bucket create</code>)</td><td>Configure after creation with subcommands: <code>s3 bucket checksum set</code>, <code>etag-alg set</code>, <code>integrity-mode set</code>, <code>quota set</code>, <code>sorting set</code>, <code>versioning enable</code>, <code>policy set</code>, <code>lifecycle-rule add</code></td></tr><tr><td>security</td><td><code>security policy delete</code></td><td><code>security policy remove</code></td></tr><tr><td>security</td><td><code>security cors-trusted-sites remove-all</code></td><td><code>security cors-trusted-sites reset</code></td></tr><tr><td>security</td><td><code>security gui-idle-timeout restore-defaults</code></td><td><code>security gui-idle-timeout reset</code></td></tr><tr><td>smb</td><td><code>smb cluster add</code> / <code>smb cluster remove</code></td><td><code>smb cluster create</code> / <code>smb cluster destroy</code></td></tr><tr><td>smb</td><td><code>smb cluster container ...</code></td><td><code>smb cluster containers ...</code> (plural)</td></tr><tr><td>smb</td><td><code>smb share list ...</code></td><td><code>smb share lists ...</code> (plural)</td></tr><tr><td>smb</td><td>Parsing <code>smb cluster status</code> text lines (<code>hostname: Ready</code>)</td><td>Output is a formatted table (<code>Container</code>, <code>Status</code>)</td></tr><tr><td>stats</td><td><code>stats list-types</code></td><td><code>stats types</code></td></tr><tr><td>stats</td><td><code>stats retention restore-default</code></td><td><code>stats retention reset</code></td></tr><tr><td>status</td><td>Parsing <code>status reduction</code> free-text lines</td><td>Output is a table (<code>Reduction Ratio</code>, <code>Saved Bytes</code>)</td></tr><tr><td>status</td><td>Parsing specific lines or labels from the main <code>status</code> output</td><td>The layout was fully redesigned; re-verify any parsing</td></tr><tr><td>user / tenant</td><td><code>user delete</code></td><td><code>user remove</code></td></tr><tr><td>user / tenant</td><td><code>user change-role</code></td><td><code>user update --role</code> (stub points to the replacement)</td></tr><tr><td>user / tenant</td><td><code>org create</code> / <code>org delete</code> (<code>tenant create</code> / <code>delete</code>)</td><td><code>tenant add</code> / <code>tenant remove</code></td></tr><tr><td>cloud</td><td><code>cloud proxy --set &#x3C;URL></code> / <code>cloud proxy --unset</code></td><td><code>cloud proxy set &#x3C;URL></code> / <code>cloud proxy reset</code> (flag form no longer exists)</td></tr><tr><td>dataservice</td><td><code>data-service ...</code></td><td><code>dataservice ...</code> (no hyphen; no hyphenated alias found)</td></tr></tbody></table>

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Engineering):** The following items in this table are marked "verify" in the engineering draft and must be confirmed against a shipping build: the dataservice alias absence, the `stats retention reset` alias absence, whether `--unlink` carried over to `s3 bucket remove`, and the full legacy-to-new security command mapping (open items 4, 7, 10).

New and blocking: the audit row. Two independent checks confirm the command takes no subcommands, so the 23 legacy audit commands are genuinely gone. `weka audit --help-all` on a 6.0 cluster server returns connection and output options only, and `audit` does not appear in the command list of a standalone wekactl running on a workstation. Filesystem auditing survives as `--audit-enabled`, but the cluster-level controls have no documented replacement: `decrypt-filename`, `decrypt-fullpath`, the audit enhancer, `resolve-paths`, `set-global-operations`, `audit cluster stats`, `audit cluster status`, and `audit fs set-operations`. `weka fs` still reports `audit` and `auditOpenClose` columns, so something still sets which operations are audited. Confirm what replaces these before publication, because the row as written tells a customer their audit configuration has nowhere to go.

The mount row is removed, and the question is answered. `weka mount` and `weka umount` are absent from the 6.0 generated reference, so this pass initially had them listed as removed with no replacement. Two pages in this change request contradict that: the overview page lists `mount` and `umount` among the local-agent commands, and Manage WEKA with new CLI documents `mount -t wekafs <backend>/<filesystem> <mount-point>` as the supported path for a stateless client. So they exist, the generated reference does not document them, and the migration topic does not need a row. Nothing further to confirm.

One row is unverifiable: `fs tier obs delete` becoming `fs tier obs remove`. Neither spelling appears in either CLI reference. `fs tier obs` has only `update` in both 5.1.31 and 6.0. The `fs tier s3 delete` half of the same row is fine. Confirm whether `fs tier obs delete` ever existed, and drop it if not.
{% endhint %}

## Column and header changes

Column renames affect scripts that parse table or TSV output by header name. Key renames:

* `cluster process`: `Process ID` becomes `Process`, `Slot In Host` becomes `Slot`, `Failure Domain ID` becomes `Failure Domain`, `Blacklist Reason` and `Blacklist Time` become `Denied Reason` and `Denied Time` (JSON tags unchanged).
* `cluster container`: `Container ID` becomes `ID`, `Failure Domain Name` becomes `Failure Domain`, `Platform` becomes `OS Name`, plus new columns.
* `cluster drive`: `Disk ID` becomes `ID`, `Host ID` becomes `Container`, `Node ID` becomes `Process`, `Device Path` becomes `Path`, `Serial Number` becomes `Serial`.
* `cloud status`: `Host` becomes `Container`, `Is Healthy` becomes `Healthy`.
* NFS interface group: `Subnet Mask` becomes `Netmask` (the JSON field also changes). NFS permission `Squashing` becomes `Squash`, and `AnonUid` and `AnonGid` render as empty instead of `0` when zero.

JSON field naming can differ between the CLIs. Re-verify any `--json` parsing against the documented field names.

{% hint style="info" %}
INTERNAL, remove before publication. TBD (Engineering): Exact new column labels for `cluster server`, `cluster bucket`, `cluster failure-domain`, `cluster task`, `s3 bucket list`, and `s3 cluster status` are pending (open items 5, 9 in the engineering draft).
{% endhint %}

## New capabilities with no legacy equivalent

* `fs replication` (`add`, `update`, `pause`, `resume`, `remove`, `fetch`): persistent replication-pair management, distinct from the one-shot `fs replicate`.
* `cluster peer` (`add`, `init`, `update`, `remove`): cluster peering, which replication pairs are built on.
* `profile` (16 commands): named connection, authentication, and display profiles, with `purge` subcommands for certificates, cached completion data, and command history.
* `completion` (14 commands): shell completion for Bash, Zsh, fish, and PowerShell, replacing `agent autocomplete`.
* `prompt` and `gui bridge`: an interactive command prompt, and a local endpoint that forwards to the cluster web GUI over the CLI connection.
* `stats table` and `stats categories`; `events categories` and `events --proxy` / `--no-proxy`.
* `status meta` and `cluster status meta`: version, build, tenant mode, and revision details. The `cluster status` group is new, but `cluster status rebuild` and `cluster status reduction` duplicate `status rebuild` and `status reduction`, which exist in both CLIs and still work in 6.0.
* `smb ldap-domain` (7 commands).
* `security tls trust`, `untrust`, and `purge`; `security kms scope`.
* `tenant chown` and `upgrade pause` / `upgrade resume`.
* `version get <version> [--set-current]`: download and stage any WEKA version locally with parallel progress bars, without a running agent. The command exists in 5.1.31; the parallel progress bars and agent-free operation are what is new.
* Connection through SSH bastions (`--jump`) and the WEKA Operator (`--kube-weka-cluster`).
* `s3 bucket checksum` (4 commands) and `s3 user decode-key`.

## Deprecated forms that still work

These forms continue to work but warn or are hidden. Plan to update them:

* `fs set-qos` is a deprecated shim for `fs update --max-throughput` / `--max-iops`. `tenant set-qos` and `tenant set-quota` are deprecated in the same way, in favor of `tenant update`.
* `stats show` is a deprecated alias for `stats table`.
* Container resource settings are deprecated on the cluster commands in favor of `local resources`: `cluster container bandwidth`, `cores`, `dedicate`, `failure-domain`, `management-ips`, `memory`, `net add`, and `net remove`.
* `fs tier` is deprecated in favor of `fs tier s3`.
* NFS interface group `--subnet <dotted-mask>` is a hidden, deprecated alias for `--netmask <bits>`; dotted netmask syntax in IP rules warns in favor of CIDR.
* Relocated s3 forms: `s3 local` becomes `s3 cluster local`, `s3 cluster kv` becomes `s3 kv`, `s3 cluster group` becomes `s3 group`, `s3 profile` becomes `debug s3 profile`, `s3 log-level` becomes `debug s3 log-level`.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (PM):** The last two relocations point customers to the debug command group, which is not documented on docs.weka.io. Decide whether to keep these two items in the customer-facing topic or drop them.

TBD (Engineering), new: `fs set-qos`, `tenant set-qos`, `tenant set-quota`, and `stats show` do not exist in 5.1.31 and ship deprecated in 6.0. Confirm whether they should appear in the CLI reference at all. Three of them, `fs set-qos`, `tenant set-qos`, and `tenant set-quota`, also name the replacement binary as `wekactl` rather than `weka`. The other ten notices, including the one on `stats show`, say `weka`. Confirm which is correct and make those three consistent.
{% endhint %}
