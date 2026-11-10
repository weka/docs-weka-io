---
description: >-
  Install the WEKA software on each bare metal server after the operating system
  is installed, for both installation paths.
---

# Install the WEKA software

Install the WEKA software on each bare metal server, after the operating system is installed.

The procedure is the same for both installation paths. Once completed, the WEKA software runs on each server in STEM mode, with no cluster attached.

**Before you begin**

* [Install the operating system](../install-the-operating-system.md) on each server, either with WPA or manually with a supported operating system and the required packages.
* Download the WEKA software tarball from get.weka.io.

**Procedure**

1. Copy the WEKA software tarball to the server, and extract it.
2. Run the installation command, following the instructions in the **Install** tab of [get.weka.io](https://get.weka.io/ui/dashboard).
3. Optional: Enable safe shutdown.\
   Safe shutdown protects data integrity during server reboots and shutdowns, and is highly recommended for converged servers. For details, see [safe-server-shutdown.md](safe-server-shutdown.md "mention").
4. Repeat the procedure on each server.

{% hint style="info" %}
If a failure occurs during the WEKA software installation process, an error message prompts detailing the source of the failure. Review the details and try to resolve the failure. If required, contact the Customer Success Team.
{% endhint %}

## What to do next?

Go to [Prepare the system](../prepare-the-system/).
