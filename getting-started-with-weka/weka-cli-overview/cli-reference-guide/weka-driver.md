---
description: Build, install, and manage WEKA drivers.
---

# weka driver

Manage WEKA drivers.

```sh
weka driver
```

## weka driver build

Compile drivers for the machine where this is executed.

```sh
weka driver build [--version <string>]
```

| Parameter                   | Description                   |
| --------------------------- | ----------------------------- |
| `-V`, `--version` \<string> | Software version for drivers. |

## weka driver download

Download drivers from a distribution server.

```sh
weka driver download [--from <server>…] [--insecure] [--kernel-signature <string>] [--version <string>]
```

| Parameter                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--from` \<server>…                  | Download from this distribution server (can be given multiple times). Accepts https:// (and http://) URLs as well as file:// for a local on-disk tree (e.g. file:///opt/weka-mirror laid out as \<root>/dist/{release,image,drivers}/...). Otherwise distribution servers are taken from the $WEKA\_DIST\_SERVERS environment variable, the /etc/wekaio/dist-servers file, or /etc/wekaio/service.conf in that order of precedence. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-k`, `--insecure`                   | Disable TLS verification of the distribution server. Should only be used if the network is trusted.                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `-K`, `--kernel-signature` \<string> | Kernel signature for drivers.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `-V`, `--version` \<string>          | Software version for drivers.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

## weka driver export

Export drivers from this machine to an archive.

```sh
weka driver export <path> [--kernel-signature <string>] [--version <string>]
```

| Parameter                            | Description                                         |
| ------------------------------------ | --------------------------------------------------- |
| `path`\*                             | Path of the output archive, will be in .zip format. |
| `-K`, `--kernel-signature` \<string> | Kernel signature for drivers.                       |
| `-V`, `--version` \<string>          | Software version for drivers.                       |

## weka driver import

Import drivers from a previously exported archive to this machine.

```sh
weka driver import <path> [--overwrite]
```

| Parameter     | Description                         |
| ------------- | ----------------------------------- |
| `path`\*      | Path of the importing archive file. |
| `--overwrite` | Overwrite existing drivers.         |

## weka driver install

Install drivers on the machine where this is executed.

```sh
weka driver install [--version <string>]
```

| Parameter                   | Description                   |
| --------------------------- | ----------------------------- |
| `-V`, `--version` \<string> | Software version for drivers. |

## weka driver kernel

Show the kernel signature of the system. This signature is used to identify the specific kernel.

```sh
weka driver kernel
```

## weka driver pack

Create a driver package that can be used on other systems.

```sh
weka driver pack [--environment <strings>…] [--kernel-signature <string>] [--version <string>]
```

| Parameter                            | Description                                                                                                                                                   |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-e`, `--environment` \<strings>…    | Additional environment variable to pass to the build script (repeatable). Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-K`, `--kernel-signature` \<string> | Kernel signature for drivers.                                                                                                                                 |
| `-V`, `--version` \<string>          | Software version for drivers.                                                                                                                                 |

## weka driver ready

Check that drivers needed for WEKA are present in the running kernel.

```sh
weka driver ready [--quiet] [--version <string>]
```

| Parameter                   | Description                                                     |
| --------------------------- | --------------------------------------------------------------- |
| `-q`, `--quiet`             | Check quietly. Exit status 0 if drivers are ready, 1 otherwise. |
| `-V`, `--version` \<string> | Version to check for.                                           |

## weka driver sign

Sign drivers with a private key.

```sh
weka driver sign <key-file> [<cert-file>] [--hash <string>] [--kernel-signature <string>] [--pack] [--passwd <string>] [--version <string>]
```

| Parameter                            | Description                                                          |
| ------------------------------------ | -------------------------------------------------------------------- |
| `key-file`\*                         | Path to the private key file (PEM or PKCS#12).                       |
| `cert-file`                          | Path to the certificate file (PEM or DER). Uses key file if omitted. |
| `--hash` \<string>                   | Hash algorithm (sha256, sha384, sha512).                             |
| `-K`, `--kernel-signature` \<string> | Kernel signature for drivers.                                        |
| `--pack`                             | Sign driver package instead of build.                                |
| `--passwd` \<string>                 | Password for encrypted private key.                                  |
| `-V`, `--version` \<string>          | Software version for drivers.                                        |
