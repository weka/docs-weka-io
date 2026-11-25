---
description: >-
  Explore wekactl capabilities, supported connection models, and links to
  administration, migration, and command reference topics.
---

# New WEKA CLI (formerly wekactl) overview

Explore wekactl, the modern WEKA command-line interface for cluster administration. It supports most legacy `weka` CLI operations and runs on Linux, macOS, and Windows.

In WEKA 5.1, the legacy WEKA CLI remains the default. Starting with WEKA 5.1.33, you can opt in to wekactl on a WEKA server. After you opt in, running `weka` on the server invokes wekactl. See [Opt in to wekactl on a cluster server](manage-weka-with-new-cli.md#opt-in-to-wekactl-on-a-cluster-server).

{% hint style="info" %}
This section describes the wekactl that ships with WEKA 5.1.50. Earlier 5.1 patch releases ship an earlier wekactl with fewer commands. Run `weka --help` to list the commands available on your server.
{% endhint %}

Use wekactl from a workstation for day-to-day remote administration. Run it locally on a WEKA server when a command requires the local agent.

## Key capabilities

* **Cross-platform administration:** Manage clusters directly from supported Linux, macOS, and Windows workstations.
* **Version independence:** Use one binary to manage clusters across supported WEKA versions.
* **Flexible output:** Use human-readable tables or machine-readable formats for automation.
* **Secure connectivity:** Use TLS for network connections and isolated connection profiles.
* **Remote access:** Connect directly, through an SSH bastion, or through a WEKA Operator deployment.

## Considerations

* **Local-agent commands:** Commands that use the local agent require a WEKA server. These include `local`, `agent`, `diags`, `version`, `mount`, `umount`, and most `driver` commands. Running wekactl from a workstation gives you 24 command groups. Running it on a cluster server adds the `agent`, `diags`, `driver`, `local`, and `version` groups.
* **Remote quota management:** Directory-based quota management requires enabled data services. Otherwise, run the commands on a WEKA server.
* **Profile compatibility:** wekactl profiles do not work with legacy CLI profiles.

## Continue with the CLI

Choose the topic that matches your goal:

* [Manage WEKA with new CLI](manage-weka-with-new-cli.md): Install and use wekactl. Configure profiles, output, TLS, and remote connections.
* [Migrate from legacy WEKA CLI](migrate-from-legacy-weka-cli.md): Update scripts and automation for CLI behavior changes.
* [Manage the system using the WEKA CLI](../manage-the-system-using-weka-cli/): Use the legacy WEKA CLI, which remains the default in WEKA 5.1.
* [CLI reference guide](cli-reference-guide/): Look up commands, subcommands, flags, and environment variables.
