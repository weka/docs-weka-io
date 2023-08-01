---
description: >-
  This requirement only applies when manually preparing and installing the WEKA
  cluster on bare metal servers.
---

# Manually install OS and WEKA on servers

If you are not using the WMS or WSA's automated tools for installing a WEKA cluster, manually install a supported OS on the bare metal server.

**Procedure**

1. Follow the relevant Linux documentation to install the OS.
2. Install the WEKA software.
   * Once the WEKA software tarball is downloaded from [get.weka.io](https://get.weka.io), run the untar command.
   * Run the `install.sh` command on each server, according to the instructions in the **Install** tab.

Once completed, the WEKA software is installed on all the allocated servers and runs in stem mode (no cluster is attached).

{% hint style="info" %}
If a failure occurs during the WEKA software installation process, an error message prompts detailing the source of the failure. Review the details and try to resolve the failure. If required, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

**Related topic**

[#operating-system](../prerequisites-and-compatibility.md#operating-system "mention") (on the Prerequisites and compatibility topic)



## What to do next?

If you can use the WEKA Configurator, go to:

[weka-system-installation-with-multiple-containers-using-the-cli.md](weka-system-installation-with-multiple-containers-using-the-cli.md "mention")

Otherwise, go to:

[weka-system-installation-with-multiple-containers-using-the-cli-1.md](weka-system-installation-with-multiple-containers-using-the-cli-1.md "mention")
