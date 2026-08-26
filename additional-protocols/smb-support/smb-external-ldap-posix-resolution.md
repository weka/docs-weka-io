---
description: Resolve SMB POSIX user and group attributes from an external LDAP directory.
---

# SMB external LDAP POSIX resolution

## Overview

Configure WEKA SMB-W to resolve POSIX user and group attributes (`uidNumber`, `gidNumber`) from an external LDAP directory instead of from the joined Active Directory. This supports environments where an identity bridge such as Delinea Server Suite (formerly Centrify), or a standalone OpenLDAP-compatible directory, holds the POSIX attributes that AD does not.

By default, SMB-W maps SMB users to POSIX identities through the joined Active Directory, using the ID mapping backend selected with `--idmap-backend` (`rid`, `rfc2307`, and so on). When POSIX attributes are not present in AD, this mapping cannot succeed and SMB access fails.

Switching the cluster to NSS POSIX-resolution mode changes where those attributes come from:

1. The SMB-W server is configured with `userdb_idmap = nss`, so it delegates every POSIX lookup to the operating system's Name Service Switch instead of querying AD.
2. Inside the SMB-W container, NSS is wired to SSSD (`passwd: compat sss`, `group: compat sss`) through `libnss_sss`.
3. SSSD queries the configured external LDAP directories and returns the UID/GID to the SMB-W server.

Authentication and authorization are unchanged. Users still authenticate against Active Directory, and only POSIX attribute resolution moves to LDAP.

### POSIX resolution modes

Select a mode that determines where SMB-W resolves POSIX UID and GID attributes.

* `ad`: Default. Resolves POSIX UID and GID attributes through the joined Active Directory. Uses the ID mapping backend set with `--idmap-backend`.
* `nss`: Resolves POSIX UID and GID attributes through NSS and SSSD against configured external LDAP domains. `--idmap-backend` does not apply and cannot be combined with this mode.

### Configuration storage and application

LDAP domain definitions are held in the WEKA cluster configuration. Each SMB-W container generates `sssd.conf` from that configuration into the SMB-W config filesystem (`.smbw/sssd/sssd.conf`), writes it into the container, and restarts SSSD to apply the change. As a result:

* The configuration survives container restarts, server reboots, and WEKA upgrades.
* Bind passwords are never stored in cleartext in `sssd.conf`. WEKA keeps them in a separate per-domain credential file and injects them in obfuscated form when SSSD starts.

SSSD runs only when it is needed. If no LDAP domain is configured, no `sssd.conf` is generated, the SSSD starter exits without starting the daemon, and clusters in `ad` mode are unaffected.

When NSS mode is active and an `sssd.conf` exists, SMB-W startup waits up to 60 seconds for the SSSD NSS socket before serving, so the first lookups do not race an unready daemon. The wait is skipped in `ad` mode.

### Domain names and name qualification

In NSS mode, the SMB-W server passes fully qualified names (`DOMAIN\user`) to NSS, and SSSD is configured with `use_fully_qualified_names`. The SSSD domain label is therefore not arbitrary: it must match the domain name that clients present, which is the AD domain name. Any other label prevents SSSD from routing the lookup to the right LDAP source.

Domain labels may contain letters, digits, `.`, `_`, and `-`. They must be unique, and uniqueness is enforced case-insensitively.

### Users without POSIX attributes

Users that have no `uidNumber`/`gidNumber` in the configured LDAP directories are not assigned an identity automatically. Their lookups fail and access is denied. NSS mode has no fallback to an auto-generated UID range.

## Configure external LDAP POSIX resolution

Define one or more LDAP domains, switch the cluster to NSS mode, and verify that lookups resolve.

### Before you begin

* Verify that the cluster is an SMB-W cluster. This feature does not apply to the legacy SMB cluster type.
* Obtain cluster admin credentials.
* Collect the LDAP URI, search base, bind DN, and bind password. For encrypted connections, also obtain the CA certificate PEM file of the issuing CA.
* Confirm that the LDAP directory exposes POSIX attributes under the search base you intend to use.

### Add an LDAP domain

```bash
weka smb ldap-domain add <domain> \
  --ldap-uri ldap://ldap.example.com:389 \
  --ldap-search-base "DC=example,DC=com" \
  --ldap-bind-dn "CN=svc_weka,OU=Users,DC=example,DC=com" \
  --ldap-bind-password <password> \
  --ldap-schema rfc2307bis \
  --start-tls \
  --ca-cert /path/to/ca.pem \
  --validate-before-commit
```

<table><thead><tr><th width="268.5546875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>&#x3C;domain></code></td><td>SSSD domain label. Must be unique and must match the domain name clients present. Letters, digits, <code>.</code>, <code>_</code>, <code>-</code> only.</td></tr><tr><td><code>--ldap-uri</code></td><td>LDAP server URI, for example <code>ldap://host:389</code> or <code>ldaps://host:636</code>. Mandatory. One URI per domain.</td></tr><tr><td><code>--ldap-search-base</code></td><td>LDAP search base for POSIX lookups, for example <code>DC=example,DC=com</code>. Mandatory.</td></tr><tr><td><code>--ldap-bind-dn</code></td><td>Service account DN used for an authenticated bind. Omit for an anonymous bind.</td></tr><tr><td><code>--ldap-bind-password</code></td><td>Password for the bind DN. If omitted, the CLI prompts for it without echoing. Set both the bind DN and the password (authenticated bind), or leave both empty (anonymous bind).</td></tr><tr><td><code>--ldap-schema</code></td><td>LDAP schema used for POSIX attribute resolution, for example <code>rfc2307</code> or <code>rfc2307bis</code>. Default: <code>rfc2307bis</code>.</td></tr><tr><td><code>--case-sensitive</code></td><td>Make POSIX name lookups case-sensitive. Default: omitted, which means case-insensitive. Keep the default when AD and the LDAP directory differ in username case.</td></tr><tr><td><code>--start-tls</code></td><td>Secure the LDAP connection with StartTLS (sets SSSD <code>ldap_id_use_start_tls</code>).</td></tr><tr><td><code>--ca-cert</code></td><td>Path to the CA certificate PEM file used to verify the LDAP server certificate. When supplied, SSSD is configured with <code>ldap_tls_reqcert = demand</code>. Maximum size 16 KiB.</td></tr><tr><td><code>--validate-before-commit</code></td><td>Probe the LDAP server (bind plus a POSIX attribute lookup) before writing the configuration. The domain is not added if the probe fails.</td></tr></tbody></table>

{% hint style="info" %}
Passwords are passed through to LDAP verbatim, including shell metacharacters. To avoid quoting problems with complex passwords, omit `--ldap-bind-password` and enter the password at the prompt.
{% endhint %}

### Switch the cluster to NSS mode

Adding a domain does not by itself change how POSIX attributes are resolved. Switch the cluster mode once at least one domain is configured:

```bash
weka smb cluster update --posix-resolution-mode nss
```

{% hint style="warning" %}
Flipping the POSIX resolution mode bounces the SMB-W cluster, because the SMB-W server must restart to pick up the new `userdb_idmap` setting. SMB clients lose their sessions during the restart. Perform the change in a maintenance window.
{% endhint %}

The mode switch is rejected if no LDAP domain is configured, and `--posix-resolution-mode nss` cannot be combined with `--idmap-backend`.

Create a new cluster directly in NSS mode with a single LDAP domain:

```bash
weka smb cluster create <netbios-name> <domain> <config-fs> ... \
  --posix-resolution-mode nss \
  --ldap-domain example.com \
  --ldap-uri ldap://ldap.example.com:389 \
  --ldap-search-base "DC=example,DC=com" \
  --ldap-bind-dn "CN=svc_weka,OU=Users,DC=example,DC=com" \
  --prompt-ldap-bind-password
```

Cluster creation accepts one LDAP domain and does not accept TLS parameters. Add StartTLS, a CA certificate, or further domains afterwards with `weka smb ldap-domain add` and `weka smb ldap-domain update`.

### Verify the configuration

1.  Check the cluster-level SSSD health.

    ```bash
    weka smb cluster
    ```

    The output includes `SSSD Health`, and `SSSD Last Error` when health is `failed`. For the meaning of each value, see Monitor SSSD health.
2.  Test an individual domain end to end.

    ```bash
    weka smb ldap-domain test <domain>
    ```

    The command performs a bind and a `uidNumber` lookup against the stored parameters and changes nothing:

    ```
    bind: OK
    posix attributes (uidNumber): found
    ```

### View configured LDAP domains

```bash
weka smb ldap-domain show            # list all domains
weka smb ldap-domain show <domain>   # show one domain
```

The table reports the domain label, LDAP URI, search base, bind DN, whether an authenticated bind is configured (`Auth Bind`), and a live per-domain connectivity `Status`.

{% hint style="info" %}
Bind passwords are never returned by the CLI or the API, in any output format. There is no option to reveal a stored password.
{% endhint %}

### Update an LDAP domain

Only the parameters you supply are changed. Everything else is left as is.

```bash
weka smb ldap-domain update <domain> \
  [--ldap-uri <uri>] \
  [--ldap-search-base <base>] \
  [--ldap-bind-dn <dn>] \
  [--ldap-bind-password <password>] \
  [--ldap-schema <schema>] \
  [--case-sensitive true|false] \
  [--start-tls true|false] \
  [--ca-cert <path>] \
  [--validate-before-commit]
```

Passing an empty `--ldap-schema` resets the domain to the `rfc2307bis` default. With `--validate-before-commit`, WEKA probes the merged configuration and applies the update only if the probe succeeds.

### Rotate the bind password

```bash
weka smb ldap-domain rotate-password <domain> [<new-password>]
```

If `<new-password>` is omitted, the CLI prompts for it without echoing it. The stored credential is replaced, the per-domain obfuscated credential file is regenerated, and SSSD is reloaded. The old password is not written to any log.

### Rotate or replace a CA certificate

```bash
weka smb ldap-domain update <domain> --ca-cert /path/to/new-ca.pem
```

The new PEM replaces the stored certificate for that domain and SSSD is reloaded.

### Remove an LDAP domain

```bash
weka smb ldap-domain remove <domain>
```

This stops POSIX resolution from that domain. When the last domain is removed, the generated `sssd.conf` and all per-domain credential and certificate files are deleted, and SSSD stops.

{% hint style="warning" %}
Removing the last LDAP domain while the cluster is still in `nss` mode leaves SMB-W with no POSIX source. LDAP users resolve to `nobody` and access fails. Switch back to `ad` mode, or add a replacement domain.
{% endhint %}

### Return to AD-based resolution

```bash
weka smb cluster update --posix-resolution-mode ad --idmap-backend <rid|rfc2307|...>
```

The cluster bounces, the SMB-W server returns to AD-based ID mapping, and any configured LDAP domains are retained but no longer consulted.

## Secure the LDAP connection

Two independent controls apply. Use both in regulated environments:

* `--start-tls` upgrades a plain `ldap://` connection on port 389 to TLS.
* `--ca-cert` supplies the CA that must have issued the LDAP server certificate. When it is set, SSSD requires a verifiable server certificate (`ldap_tls_reqcert = demand`).

{% hint style="warning" %}
Neither control is applied implicitly. A domain added without `--start-tls` and without `--ca-cert` binds in cleartext, and an `ldaps://` URI without `--ca-cert` is not validated against a cluster-wide trust store. Always pass both when the directory holds credentials or is reached over an untrusted network.
{% endhint %}

## Monitor and troubleshoot

### Monitor SSSD health

`weka smb cluster` reports one of the following values:

<table data-header-hidden><thead><tr><th width="172.11328125"></th><th></th></tr></thead><tbody><tr><td><code>SSSD Health</code></td><td>Meaning</td></tr><tr><td><code>not-configured</code></td><td>The cluster is not in <code>nss</code> mode, or no LDAP domain is configured. SSSD is intentionally not running.</td></tr><tr><td><code>running</code></td><td>SSSD is running and its NSS responder socket is ready on all SMB-W servers.</td></tr><tr><td><code>failed</code></td><td>SSSD is not running, or its NSS socket is not ready, on at least one SMB-W server. <code>SSSD Last Error</code> carries the most recent error text.</td></tr></tbody></table>

### Log files

Inside the SMB-W container, under the host-backed `/data/log/` directory:

<table><thead><tr><th width="209.75">File</th><th>Contents</th></tr></thead><tbody><tr><td><code>sssd_starter.log</code></td><td>Starter activity: config filesystem wait, start/skip/restart decisions, credential-obfuscation errors.</td></tr><tr><td><code>sssd.log</code></td><td>SSSD daemon output.</td></tr><tr><td><code>sssd_redacted.conf</code></td><td>Snapshot of the active <code>sssd.conf</code> with bind tokens stripped, for diagnostics.</td></tr></tbody></table>

The generated `sssd.conf` is marked `#DO NOT EDIT (managed by Weka)` and is overwritten whenever the cluster configuration changes. Edit the configuration through the CLI only.

### Troubleshoot common failures

<details>

<summary>Lookups return <code>nobody</code>/<code>nogroup</code> for LDAP users</summary>

**Cause:** The cluster is in `ad` mode, no LDAP domain is configured, or the SSSD domain label does not match the domain name clients present.

**Resolution:**

1.  Confirm the POSIX resolution mode and the SSSD health.

    ```bash
    weka smb cluster
    ```
2.  List the configured domains and compare each label with the AD domain name clients send.

    ```bash
    weka smb ldap-domain show
    ```
3. Correct the mismatch. Switch the cluster to `nss` mode, add the missing domain, or remove the mislabeled domain and add it again with the correct label. A label cannot be renamed in place.

</details>

<details>

<summary><code>weka smb ldap-domain test</code> reports <code>bind: FAILED</code></summary>

**Cause:** The bind DN or password is wrong, or the TLS handshake fails because the server certificate of a StartTLS or `ldaps://` connection cannot be verified with the supplied CA.

**Resolution:**

1.  Verify the bind DN.

    ```bash
    weka smb ldap-domain show <domain>
    ```
2.  Set the password again if it may be stale.

    ```bash
    weka smb ldap-domain rotate-password <domain>
    ```

    Omit `--new-password` so the CLI prompts for it, which avoids shell quoting problems with complex passwords.
3.  Supply the correct CA certificate when the connection uses StartTLS or `ldaps://`.

    ```bash
    weka smb ldap-domain update <domain> --ca-cert /path/to/ca.pem --validate-before-commit
    ```

</details>

<details>

<summary><code>weka smb ldap-domain test</code> reports <code>posix attributes (uidNumber): NOT found</code></summary>

**Cause:** The bind succeeds, but the search base or the schema is wrong, or the user has no POSIX attributes in the directory.

**Resolution:**

1. Confirm that the user carries `uidNumber` and `gidNumber` in the directory. Users without POSIX attributes are denied access, and NSS mode has no automatic UID assignment.
2.  Widen or correct the search base so it covers the container that holds the POSIX entries.

    ```bash
    weka smb ldap-domain update <domain> --ldap-search-base "DC=example,DC=com" --validate-before-commit
    ```
3.  Switch the schema if the directory publishes group membership in the other format.

    ```bash
    weka smb ldap-domain update <domain> --ldap-schema rfc2307 --validate-before-commit
    ```

</details>

<details>

<summary><code>SSSD Health: failed</code> immediately after an SMB-W container restart</summary>

**Cause:** SSSD is still waiting for the SMB-W config filesystem to mount, which takes up to about 3 minutes, or it is restarting to pick up a configuration change.

**Resolution:**

1.  Wait about 3 minutes and check the health again.

    ```bash
    weka smb cluster
    ```
2. Review `sssd_starter.log` and `sssd.log` under `/data/log/` in the SMB-W container if the health stays `failed`.

</details>

## System specifications

| Item                                                       | Value                                                                                                          |
| ---------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Maximum LDAP domains per SMB-W cluster                     | 64                                                                                                             |
| LDAP domains accepted at cluster creation                  | 1                                                                                                              |
| LDAP URIs per domain                                       | 1. There is no multi-server failover within a single domain. Define separate domains for separate directories. |
| Maximum CA certificate size                                | 16 KiB                                                                                                         |
| Maximum LDAP URI length                                    | 256 characters                                                                                                 |
| Maximum search base length                                 | 128 characters                                                                                                 |
| Maximum bind DN length                                     | 256 characters                                                                                                 |
| Maximum domain label length                                | 64 characters                                                                                                  |
| SMB-W startup wait for the SSSD NSS socket (NSS mode only) | 60 seconds, non-fatal                                                                                          |
| Bind authentication                                        | Anonymous and simple authenticated binds only. Kerberos/GSSAPI bind is not supported.                          |
| Raw `sssd.conf` upload                                     | Not supported. The generated configuration cannot be replaced or extended with arbitrary SSSD options.         |
| Configuration interface                                    | CLI only. The feature is not exposed in the WEKA GUI.                                                          |
| Automatic UID assignment                                   | Not supported. Users without POSIX attributes in LDAP are denied access.                                       |
| SSSD cache tuning                                          | Not exposed. SSSD's built-in caching applies with WEKA-selected timeouts.                                      |
| NFS LDAP configuration                                     | Independent. NFS-W has its own `weka nfs ldap` commands with a different configuration model.                  |
