---
description: >-
  Explore the options of the [weka] backend section in manila.conf, with their
  types and default values.
---

# WekaFS plug-in configuration options

| Option                     | Type            | Default     | Description                                                |
| -------------------------- | --------------- | ----------- | ---------------------------------------------------------- |
| `weka_api_server`          | HostAddress     | Required    | Hostname or IP address of the cluster management endpoint. |
| `weka_api_port`            | Port            | `14000`     | TCP port of the REST API.                                  |
| `weka_ssl_verify`          | Bool            | `true`      | Verify the cluster TLS certificate.                        |
| `weka_username`            | String          | `admin`     | API username.                                              |
| `weka_password`            | String (secret) | Required    | API password.                                              |
| `weka_organization`        | String          | `Root`      | Organization to authenticate against.                      |
| `weka_filesystem_group`    | String          | `default`   | Filesystem group for new shares.                           |
| `weka_mount_point_base`    | String          | `/mnt/weka` | Base directory for WekaFS mounts on the Manila server.     |
| `weka_num_cores`           | Int (1–19)      | `1`         | CPU cores for the WekaFS client.                           |
| `weka_net_device`          | String          | None        | NIC for DPDK mode, for example `eth0`.                     |
| `weka_posix_mount_timeout` | Int             | `60`        | Time to wait for a WekaFS mount, in seconds.               |
| `weka_api_timeout`         | Int             | `30`        | HTTP timeout for API requests, in seconds.                 |
| `weka_max_api_retries`     | Int             | `3`         | Maximum retries on transient API errors.                   |
| `weka_share_name_prefix`   | String          | `manila_`   | Prefix for WEKA filesystem names.                          |

### Related topics

[configure-the-wekafs-plug-in-for-manila.md](configure-the-wekafs-plug-in-for-manila.md "mention")

[manage-manila-shares-on-a-weka-cluster.md](manage-manila-shares-on-a-weka-cluster.md "mention")

[troubleshoot-the-wekafs-plug-in.md](troubleshoot-the-wekafs-plug-in.md "mention")
