---
description: >-
  This page describes the diagnostics CLI command which is used for running
  cluster diagnostics.
---

# Diagnostics CLI Command

## Overview

The diagnostics CLI command is used for collecting and uploading diagnostic data about clusters and hosts for analysis by the Weka Support and R&D Teams in order to help with troubleshooting. There are two relevant commands:

* `weka diags,` used for cluster-wide diagnostics from any host in the cluster.
* `weka local diags,` used for running diagnostics on a specific host, which should be used if the host cannot connect to the cluster.

## Command Syntax

```text
weka [local] diags <--collect|--upload> [--pack-to dir]
```

This command creates diagnostics information about the Weka software and saves it for further analysis by the Weka Support team.

Information collection can be configured as follows:

If the command is run with the `local` keyword, information is collected only from the host on which the command is executed. Otherwise, information is collected from the whole cluster. Additionally, when `weka local diags` receives a directory using the `-o` option, the diagnostics dump of the host is moved to that directory on completion of the collection process.

{% hint style="info" %}
**Note:** The only reason to run the command with the `local` option is when there are cluster connectivity issues.
{% endhint %}

When running the command with the `--collect` option, the information is saved to local files, and a list of the output files is provided. These files should be sent to the Weka Support Team for analysis. When running the command with the `--upload` option, the information is uploaded to a Weka-owned S3 bucket, and an access identifier is provided as an output. This access identifier should be sent to the Weka Support Team, which will retrieve the information from the S3 bucket.

When using the -`-pack-to` option, a single file is generated to the provided directory, as opposed to the default of creating a file per cluster host.

{% hint style="info" %}
**Note:** The `--upload` option requires Internet connectivity which allows https access to AWS S3 endpoints.
{% endhint %}

{% hint style="info" %}
**Note:** The upload process is asynchronous. Therefore connectivity failures will be reflected in failure events on the event log, while the command will still exit successfully.
{% endhint %}

{% hint style="info" %}
**Note:** In the following situations the `local` option should be used: no functioning manager in the originating host or the hosts being addressed, no connectivity between the manager and the cluster leader, the cluster has no leader, the local container is down, the host cannot reach the leader or a remote host fails to respond to the `weka diags` remote command.
{% endhint %}

