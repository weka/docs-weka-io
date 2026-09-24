---
description: >-
  Configure a WEKA cluster as a Manila backend so that OpenStack can provision
  WEKA-backed shares.
---

# Configure the WekaFS plug-in for Manila

Prepare the Manila server and add the WEKA backend to the Manila configuration. The Manila server is the Linux server that runs the `manila-share` service. It is not a WEKA storage server.

### Before you begin

* OpenStack Hibiscus (2026.2) or later is running.
* A WEKA cluster is running.
* The Manila server runs RHEL 8 or later, or Ubuntu 20.04 or later, with Python 3.9 or later.
* The Manila server can reach the cluster on TCP port 14000 (REST API) and on the WEKA data network.
* For WekaFS shares, the Manila server kernel is earlier than 6.17.

### Verify network connectivity

1. On the Manila server, confirm that the cluster REST API responds. Replace `<weka-ip>` with the cluster management IP address.

```bash
   curl -k https://<weka-ip>:14000/api/v2/status
```

The response returns the cluster status as JSON. If the command reports a connection error, open TCP port 14000 between the Manila server and the cluster, and then retry. Do not continue until this command succeeds.

### Install the WekaFS client (WekaFS shares only)

Skip this procedure if you use only the NFS protocol.

1. Download and install the client package from the cluster, so the client version matches the cluster version:

```bash
   curl -k -o weka-client.tar https://<weka-ip>:14000/dist/v1/install/<weka-version>
   tar xf weka-client.tar
   sudo ./install.sh
```

2. Load the kernel module, and confirm that it is loaded:

```bash
   sudo modprobe wekafsio
   lsmod | grep wekafsio
```

3. Persist the module across reboots:

```bash
   echo "wekafsio" | sudo tee /etc/modules-load.d/wekafs.conf
```

{% hint style="warning" %}
The WekaFS kernel module does not compile on Linux kernel 6.17 or later. Check the kernel version with `uname -r`. On kernel 6.17 or later, pin the kernel to an earlier version or use the NFS protocol.
{% endhint %}

### Create a dedicated API user

Create a dedicated WEKA user for Manila instead of using the admin account. This limits exposure if the credentials leak.

1. Create the user:

```bash
   weka user login admin "<weka-admin-password>" --hostname "<weka-ip>"
   weka user add manila-driver --password "<manila-user-password>" --role OrgAdmin
```

The `OrgAdmin` role grants permission to create and manage filesystems and organizations.

2. Confirm that the new credentials work:

```bash
   curl -k -X POST https://<weka-ip>:14000/api/v2/login \
     -H 'Content-Type: application/json' \
     -d '{"username":"manila-driver","password":"<manila-user-password>","org":"Root"}'
```

The response contains an `access_token`.

### Configure the backend

1. Create the base directory for WekaFS mounts. Assign ownership to the user that runs the Manila share service:

```bash
   sudo mkdir -p /mnt/weka
   sudo chown manila:manila /mnt/weka
```

2. In `/etc/manila/manila.conf`, add `weka` to `enabled_share_backends` in the `[DEFAULT]` section, and then add the `[weka]` backend section:

{% code title="ini" %}
```ini
   [DEFAULT]
   enabled_share_backends = weka
   enabled_share_protocols = NFS,WEKAFS

   [weka]
   share_driver = manila.share.drivers.weka.driver.WekaShareDriver
   share_backend_name = weka
   driver_handles_share_servers = false

   # Feature flags
   snapshot_support = true
   create_share_from_snapshot_support = true
   revert_to_snapshot_support = true

   # Connection
   weka_api_server = <weka-ip>
   weka_api_port = 14000
   weka_ssl_verify = true

   # Authentication
   weka_username = manila-driver
   weka_password = <manila-user-password>
   weka_organization = Root

   # Filesystem settings
   weka_filesystem_group = default
   weka_share_name_prefix = manila_

   # WekaFS client on the Manila server
   weka_mount_point_base = /mnt/weka
   weka_num_cores = 1

   # NFS gateway (required for NFS shares and create share from snapshot)
   weka_nfs_server = <weka-nfs-interface-group-ip>
```
{% endcode %}

Set `weka_nfs_server` to the NFS interface group IP address, not the API server IP address. To find it, run `weka nfs interface-group`.

3. Restart the Manila share service, and confirm that it is running:

```bash
   sudo systemctl restart openstack-manila-share
   sudo systemctl status openstack-manila-share
```

4. Confirm that the backend is registered:

```bash
   openstack share pool list --detail
   openstack share service list
```

The WEKA backend appears in the pool list, and the `manila-share` service shows `State: up`. If the backend does not appear within two minutes, check the share service log.

### What to do next

[manage-manila-shares-on-a-weka-cluster.md](manage-manila-shares-on-a-weka-cluster.md "mention")

### Related topics

[.](./ "mention")

[wekafs-plug-in-configuration-options.md](wekafs-plug-in-configuration-options.md "mention")

[troubleshoot-the-wekafs-plug-in.md](troubleshoot-the-wekafs-plug-in.md "mention")
