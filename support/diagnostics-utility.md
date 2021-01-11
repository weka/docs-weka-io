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

## Collecting Diags

**Command:** `weka diags collect`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Weka Support team:

`weka diags collect [--id id] [--timeout timeout] [--output-dir output-dir] [--core-limit core-limit] [--clients] [--tar]`

If the command is run with the `local` keyword, information is collected only from the host on which the command is executed. Otherwise, information is collected from the whole cluster. 

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>id</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Specified ID for this dump</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">Auto-generated</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>timeout</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">How long to wait when downloading diags from all hosts</td>
      <td style="text-align:left">
        <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w</p>
        <p>0 is infinite</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">10 minutes</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>output-dir</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Directory to save the dump to</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"><code>/opt/weka/diags</code>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>core-limit</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Limit to processing this number of core dumps, if found</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">1</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>clients</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Collect from client hosts as well</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>tar</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Create a TAR of all collected diags</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">No</td>
    </tr>
  </tbody>
</table>

{% hint style="info" %}
**Note:** In the following situations the `local` option should be used: no functioning management process in the originating host or the hosts being addressed, no connectivity between the management process and the cluster leader, the cluster has no leader, the local container is down, the host cannot reach the leader or a remote host fails to respond to the `weka diags` remote command.
{% endhint %}

## Uploading Diags to Weka Home

**Command:** `weka diags upload`

Use the following command to create diagnostics information about the Weka software and save it for further analysis by the Weka Support team:

`weka diags upload [--timeout timeout] [--core-limit core-limit] [--dump-id dump-id] [--host-id host-id]... [--clients]`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>timeout</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">How long to wait for diags to upload</td>
      <td style="text-align:left">
        <p>format: 3s, 2h, 4m, 1d, 1d5h, 1w</p>
        <p>0 is infinite</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">10 minutes</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>core-limit</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Limit to processing this number of core dumps, if found</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">1</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>dump-id</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">ID of an existing dump to upload</td>
      <td style="text-align:left">This dump ID has to exist on this local machine</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">If an ID is not specified, a new dump is created</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>host-id</code>
      </td>
      <td style="text-align:left">Comma-separated list of numbers</td>
      <td style="text-align:left">Host IDs to collect diags from</td>
      <td style="text-align:left">This flag causes <code>--clients</code> to be ignored</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">All hosts</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>clients</code>
      </td>
      <td style="text-align:left">Boolean</td>
      <td style="text-align:left">Collect from client hosts as well</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">No</td>
    </tr>
  </tbody>
</table>

When running the command with the `upload` option, the information is uploaded to a Weka-owned S3 bucket, and an access identifier is provided as an output. This access identifier should be sent to the Weka Support Team, which will retrieve the information from the S3 bucket.

{% hint style="info" %}
**Note:** The `upload` command requires Internet connectivity which allows HTTPS access to AWS S3 endpoints.
{% endhint %}

{% hint style="info" %}
**Note:** The upload process is asynchronous. Therefore connectivity failures will be reflected in failure events on the event log, while the command will still exit successfully.
{% endhint %}

