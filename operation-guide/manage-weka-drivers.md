---
description: >-
  Learn how to manage WEKA drivers to ensure they are properly built, installed,
  signed, and distributed for the appropriate kernel version.
---

# Manage WEKA drivers

## Overview

Updating WEKA drivers ensures compatibility with new kernels, improves performance, resolves bugs, applies security patches, and introduces new features, helping maintain system stability and security. WEKA's driver management process simplifies the distribution of driver packages across environments. You can sign, build, or import drivers on to the backend and use it as a distribution server for other cluster members, streamlining the management and deployment of drivers.

**Key features**

* **Simplification**: The WEKA agent manages downloading, signing, and handling archives, while driver scripts focus on core tasks.
* **Support for requirements**: Includes local builds, driver signing, and archive distribution for different kernels and architectures.
* **Consistency and flexibility**: Ensures consistent archives and kernel signatures across systems, streamlining version management.

#### WEKA driver directory structure

The WEKA driver directory structure is organized to help you manage driver packages and files efficiently. Here's an overview of the key directories and their contents:

* `/opt/weka/dist/driver`: Stores driver packages by name, version, and kernel signature.
* `/opt/weka/data/driver`: Parent directory for all driver-related files.
* `/opt/weka/data/driver/*driver-package*/stage`: Contains staged drivers and kernel object files (`.ko` files ).

### weka driver subcommands

* `weka driver build`:  Builds drivers without installing.
* `weka driver install`: Builds and installs drivers.
* `weka driver sign`: Signs drivers for installation or archiving.
* `weka driver pack`: Builds and packages drivers for distribution.
* `weka driver export`: Exports driver packages into an archive.
* `weka driver import`: Imports driver archives.
* `weka driver kernel`: Shows the kernel signature of the system.
* `weka driver ready`: Checks if drivers are loaded.

## Manage WEKA drivers

Follow these steps to build and manage WEKA drivers for a specific OS and WEKA kernel version on a system running the **target OS kernel version**. This system, which can be a virtual machine (VM), **must** have the exact kernel version that you intend to use for distribution across the WEKA cluster.

{% hint style="info" %}
The `weka driver` commands described in this section provide a high-level overview. For a complete list of arguments and options, refer to the CLI reference guide in the [manage-the-system-using-weka-cli](../getting-started-with-weka/manage-the-system-using-weka-cli/ "mention") section.
{% endhint %}

1.  **Install the WEKA agent:**\
    Run the following command to install the WEKA agent on the VM:

    ```bash
    curl http://<backend IP>:14000/dist/v1/install | sh
    ```
2.  **Retrieve the agent version and driver source code:**\
    Use the following command to download only the source code packages needed to build the drivers:

    ```bash
    weka version get <version> --driver-only
    ```

    This allows you to compile the required drivers without installing the full WEKA software.
3.  **Create a driver package:**\
    Build the necessary drivers by running:

    ```bash
    weka driver pack --version <version>
    ```

    This command packages the drivers for the specified OS and WEKA kernel versions into an archive, which can be deployed across the cluster.&#x20;

    The `--version` option is required only if a full WEKA installation is not present or the version is not set. If both are available, the command defaults to the version reported by the installed WEKA software.
4.  **Sign drivers (optional):**\
    To enable secure boot, sign the drivers by running:

    ```bash
    weka driver sign <key> --pack
    ```

    This signs the drivers or the entire distribution package, replacing any existing signatures, making the package secure for deployment.
5.  **Export the driver archive:**\
    Run the following command to export the driver package:

    ```bash
    weka driver export <path>
    ```

    Copy the exported archive to all backends in the WEKA cluster.
6.  **Import the driver package:**\
    On each backend, import the driver package from the location where it was copied by running:

    ```bash
    weka driver import <path>
    ```
7.  **Install the imported driver**:

    Install the driver on each backend using the following command:

    ```bash
    weka driver install
    ```

    This command builds and installs the driver for the current kernel, ensuring it is ready for use by the system.

<details>

<summary>Example: Import and installation flow on a client</summary>

1. Copy the exported driver archive to the client: \
   `scp <driver-package>.tar.gz user@<client>:/tmp/`
2. SSH into the client: `ssh user@<client>`
3. Import the driver archive: `weka driver import /tmp/<driver-package>.tar.gz`
4. Install the imported driver: `weka driver install`
5. After running weka driver install, the driver is built and loaded for the kernel running on the client. Use the following command to verify the driver status: \
   `weka driver ready`

</details>
