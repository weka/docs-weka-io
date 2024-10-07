---
description: >-
  This tool simplifies managing BIOS settings across multiple servers, ensuring
  consistency and reducing manual configuration efforts.
---

# BIOS tool

## BIOS tool overview

The `bios_tool` is a command-line utility designed to manage BIOS settings on WEKA servers. It lets administrators view, set, and correct BIOS configurations across multiple servers. This tool is crucial for ensuring that servers in a cluster are properly configured and compliant with desired BIOS settings, using pre-defined configuration files or command-line inputs.

You can find the BIOS tool on GitHub at: [https://github.com/weka/tools/tree/master/bios\_tool](https://github.com/weka/tools/tree/master/bios\_tool).

### Features

* **View and set BIOS settings**: Inspect and apply BIOS settings across multiple servers.
* **BMC configuration**: Configure BMC (Baseboard Management Controller) to allow RedFish and IPMI Over LAN access.
* **Fix BIOS settings**: Correct any BIOS settings that deviate from specified configurations.
* **Reboot control**: Optionally reboot servers after applying BIOS changes.
* **Compare settings**: Diff the BIOS configurations between two servers to identify mismatches.
* **Support for multiple manufacturers**: Compatible with servers from manufacturers like Dell, HPE, Lenovo, and Supermicro.

## Usage

The `bios_tool` offers several command-line options to customize its behavior:

{% code overflow="wrap" %}
```bash
bios_tool [-h] [-c [HOSTCONFIGFILE]] [-b [BIOS]] [--bmc_config] [--fix] [--reboot] [--dump] [--reset_bios] [--diff DIFF DIFF] [--bmc_ips [BMC_IPS ...]] [--bmc_username BMC_USERNAME] [--bmc_password BMC_PASSWORD] [-v] [--version]
```
{% endcode %}

#### Parameters

<table><thead><tr><th width="301">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>-h, --help</code></td><td>Displays the help message.</td></tr><tr><td><code>-c, --hostconfigfile [HOSTCONFIGFILE]</code></td><td>Specify the host configuration file (YAML/CSV) containing server details.</td></tr><tr><td><code>-b, --bios [BIOS]</code></td><td>Specify the BIOS settings configuration file (YAML).</td></tr><tr><td><code>--bmc_config</code></td><td>Enables RedFish and IPMI Over LAN on all servers.</td></tr><tr><td><code>--fix</code></td><td>Corrects BIOS settings based on the configuration file.</td></tr><tr><td><code>--reboot</code></td><td>Reboots the server after applying any changes to the BIOS settings. Only a server with modifications will be rebooted.</td></tr><tr><td><code>--dump</code></td><td>Displays BIOS settings without making changes.</td></tr><tr><td><code>--reset_bios</code></td><td>Resets BIOS to default settings. Use <code>--reboot</code> for automatic reboot after resetting.</td></tr><tr><td><code>--diff DIFF DIFF</code></td><td>Compares BIOS settings between two servers.</td></tr><tr><td><code>--bmc_ips [BMC_IPS ...]</code></td><td>List of BMC IP addresses (space-separated) to configure servers without a config file. <br>For example, <code>--bmc_ips 192.168.1.1 192.168.1.2</code>. <br>Combined with <code>--bmc_username</code> and <code>--bmc_password</code>, this option enables quick configuration of multiple servers with identical credentials, eliminating the need for a configuration file.</td></tr><tr><td><code>--bmc_username</code><br><code>--bmc_password</code></td><td>Credentials for BMC access.</td></tr><tr><td><code>-v, --verbose</code></td><td>Provides verbose output.</td></tr><tr><td><code>--version</code></td><td>Displays the current version of BIOS tool.</td></tr></tbody></table>

## Getting started

The **bios\_tool** requires two configuration files:

* **Host configuration file** (`host_config.yml` or `host_config.csv`)
* **BIOS settings configuration file** (`bios_config.yml`)

You can use the default filenames or specify custom ones using the command-line options `-c/--hostconfigfile` for the host configuration file and `-b/--bios` or `--bmc_ips` for BIOS settings.

**Host configuration (`host_config.yml` or `.csv`)**

The host configuration file defines the servers (hosts) and their corresponding BMC credentials (IPMI, iLO, iDRAC). You can use either YAML or CSV format, indicated by the file extension (`.yml` or `.csv`).

The default format is CSV, which can be easily edited in spreadsheet tools like Excel. Example CSV format:

```plaintext
name,user,password
172.29.3.164,ADMIN,_PASSWORD_1!
172.29.3.1,Administrator,Administrator
172.29.1.74,root,Administrator
172.29.1.75,root,Administrator
```

Alternatively, you can use YAML for more structured data:

```yaml
hosts:
  - name: 172.29.3.1
    user: Administrator
    password: Administrator
  - name: 172.29.3.2
    user: Administrator
    password: Administrator
```

Define all the servers you plan to manage in this file.&#x20;

**BIOS configuration (`bios_config.yml` and others)**

The BIOS settings configuration file (`bios_config.yml`) specifies the BIOS configurations you want applied to the servers listed in the host configuration file.

There are additional preset files available, such as `Dell-Genoa-bios.yml` for Dell servers with Genoa AMD processors, and `WEKApod.yml` for WEKApod servers (which come pre-configured but can be applied to similar servers).

The BIOS configuration file follows standard YAML format. Example:

```yaml
server-manufacturer:
  architecture:
    setting: value
    setting: value
  architecture2:
    setting: value
    setting: value
```

The `server-manufacturer` corresponds to the `Oem` field in RedFish data, allowing compatibility with most RedFish-supported manufacturers. Supported manufacturers include Dell, HPE, Lenovo, and Supermicro, and defaults for these are included in the sample file.

The `architecture` can be either `AMD` or `Intel`(no other architectures are supported).

For a detailed example, refer to the provided `bios_config.yml`. Here’s a sample snippet:

```yaml
Dell:
  AMD:
    LogicalProc: Disabled
    NumaNodesPerSocket: "1"
    PcieAspmL1: Disabled
    ProcCStates: Disabled
    ProcPwrPerf: MaxPerf
```

### Default mode

When run without command-line options, **bios\_tool** operates in a read-only mode, scanning the hosts listed in the `host_config.csv` and comparing their current BIOS settings with those specified in the `bios_settings.yml` file. No changes are applied to the servers during this process.

Example output:

```plaintext
Fetching BIOS settings of host 172.29.3.1
Fetching BIOS settings of host 172.29.3.2
Fetching BIOS settings of host 172.29.3.3
[...snip...]
No changes are needed on 172.29.3.1
No changes are needed on 172.29.3.2
No changes are needed on 172.29.3.3
[...snip...]
172.29.3.4: BIOS setting ApplicationPowerBoost is Enabled, but should be Disabled
172.29.3.4: BIOS setting CStateEfficiencyMode is Enabled, but should be Disabled
172.29.3.4: BIOS setting DataFabricCStateEnable is Auto, but should be Disabled
172.29.3.4: BIOS setting DeterminismControl is DeterminismCtrlAuto, but should be DeterminismCtrlManual
[...snip...]
```

In this mode, the tool provides a detailed report on any discrepancies between the current BIOS configurations and the desired settings, allowing you to review changes without affecting the servers.

### Optional modes

**BMC configuration mode**

Using the `--bmc_config` option, **bios\_tool** will SSH into each server to enable both RedFish and IPMI Over LAN. RedFish is **required** for the tool’s operation, while IPMI Over LAN is necessary for WMS deployment, so it is automatically enabled.

**Fix mode**

The `--fix` option allows **bios\_tool** to apply the BIOS settings specified in the `bios_settings.yml` file. The tool does not reboot the servers unless the `--reboot` option is also specified.

**Reboot mode**

When used with the `--fix` option, `--reboot` will instruct **bios\_tool** to reboot the servers after applying any BIOS changes. Only servers that have been modified will be rebooted, ensuring the changes take effect.

**Dump mode**

The `--dump` option provides a read-only output of all current BIOS settings for each server. No changes are made to the servers in this mode.

**Diff mode**

Using `--diff` compares BIOS settings between two servers and highlights any discrepancies.

Example diff output:

```plaintext
Fetching BIOS settings of host 172.29.3.1
Fetching BIOS settings of host 172.29.3.6

Settings that are different between the servers:
Setting                     172.29.3.1                 172.29.3.6
--------------------------  -------------------------  ----------------------------
ApplicationPowerBoost       Disabled                   Enabled
CStateEfficiencyMode        Disabled                   Enabled
DataFabricCStateEnable      Disabled                   Auto
DeterminismControl          DeterminismCtrlManual      DeterminismCtrlAuto
InfinityFabricPstate        P0                         Auto
MinProcIdlePower            NoCStates                  C6
NumaGroupSizeOpt            Clustered                  Flat
NumaMemoryDomainsPerSocket  TwoMemoryDomainsPerSocket  Auto
PerformanceDeterminism      PerformanceDeterministic   PowerDeterministic
PowerRegulator              StaticHighPerf             OsControl
ProcAmdIoVt                 Disabled                   Enabled
ProcSMT                     Disabled                   Enabled
SerialNumber                MXQ2201FNK                 MXQ2201FND
Sriov                       Disabled                   Enabled
ThermalConfig               IncreasedCooling           OptimalCooling
WorkloadProfile             I/OThroughput              GeneralPowerEfficientCompute
```
