---
description: >-
  This page describes the S3, NFS, and SMB protocols debug level management. A
  higher debug level provides more details for investigating issues.
---

# Protocols debug level management

The cluster enables changing the log debug level (verbosity level) for each protocol and member host in the cluster. While investigating issues, you can increase the verbosity level.

{% hint style="warning" %}
Do not change protocols debug level without specific instructions from the [Customer Success Team](../../getting-support-for-your-weka-system.md#contact-customer-success-team). Changing the protocols debug level reduces the amount of troubleshooting information about the system and may affect the SLA if an issue occurs.
{% endhint %}

{% hint style="info" %}
Once the container is restarted, the log verbosity level reverts to its default.
{% endhint %}



**Related topics**

[manage-protocols-debug-level-using-the-gui.md](manage-protocols-debug-level-using-the-gui.md "mention")

[manage-protocols-debug-level-using-the-cli.md](manage-protocols-debug-level-using-the-cli.md "mention")
