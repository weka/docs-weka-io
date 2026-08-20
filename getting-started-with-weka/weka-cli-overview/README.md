---
description: >-
  Explore wekactl capabilities, supported connection models, and links to
  administration, migration, and command reference topics.
---

# New WEKA CLI (formerly wekactl) overview

Explore wekactl, the modern WEKA command-line interface for cluster administration. It supports most legacy `weka` CLI operations and runs on Linux, macOS, and Windows.

Starting with WEKA 6.0.0, wekactl is the default CLI. Running `weka` on a WEKA server invokes wekactl.

Use wekactl from a workstation for day-to-day remote administration. Run it locally on a WEKA server when a command requires the local agent.

## Key capabilities

* **Cross-platform administration:** Manage clusters directly from supported Linux, macOS, and Windows workstations.
* **Version independence:** Use one binary to manage clusters across supported WEKA versions.
* **Flexible output:** Use human-readable tables or machine-readable formats for automation.
* **Secure connectivity:** Use TLS for network connections and isolated connection profiles.
* **Remote access:** Connect directly, through an SSH bastion, or through a WEKA Operator deployment.

## Considerations

* **Local-agent commands:** Commands that use the local agent require a WEKA server. These include `local`, `agent`, `diags`, `version`, `mount`, `umount`, and most `driver` commands. Running wekactl from a workstation gives you 20 command groups. Running it on a cluster server gives you all 28.
* **Remote quota management:** Directory-based quota management requires enabled data services. Otherwise, run the commands on a WEKA server.
* **Profile compatibility:** wekactl profiles do not work with legacy CLI profiles.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Engineering):** Confirm whether `audit` should be named at all, given it has no subcommands in 6.0. The `smb` question is answered: it no longer requires a WEKA server.
{% endhint %}

## Continue with the CLI

Choose the topic that matches your goal:

* [Manage WEKA with new CLI](manage-weka-with-new-cli.md): Install and use wekactl. Configure profiles, output, TLS, and remote connections.
* [Migrate from legacy WEKA CLI](migrate-from-legacy-weka-cli.md): Update scripts and automation for CLI behavior changes.
* [CLI reference guide](cli-reference-guide/): Look up commands, subcommands, flags, and environment variables.
