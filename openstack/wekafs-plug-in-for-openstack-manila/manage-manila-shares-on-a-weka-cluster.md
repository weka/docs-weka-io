---
description: >-
  Create, access, mount, resize, snapshot, and delete WEKA-backed Manila shares
  using the OpenStack CLI.
---

# Manage Manila shares on a WEKA cluster

After the WEKA backend is registered, manage shares with the OpenStack CLI.

### Before you begin

* [configure-the-wekafs-plug-in-for-manila.md](configure-the-wekafs-plug-in-for-manila.md "mention")

### Create a share

1. Create a share type that directs the Manila scheduler to the WEKA backend:

```bash
   openstack share type create weka-default false \
     --extra-specs share_backend_name=weka
```

2. Create a share. The following example creates a 10 GiB WekaFS share:

```bash
   openstack share create --name my-first-share \
     --share-type weka-default --size 10 WEKAFS
```

To create an NFS share, specify `NFS` as the protocol.

3. Check the share status:

```bash
   openstack share show my-first-share
```

The status changes to `available`, usually within 10 to 30 seconds.

The plug-in creates a dedicated WEKA filesystem named `manila_<share-uuid>` with the requested capacity. For a WekaFS share, the filesystem is created inside the WEKA organization that maps to the OpenStack project.

{% hint style="info" %}
If share creation fails with insufficient capacity, the filesystem group does not have enough free SSD capacity for the requested size. Free capacity or reduce the share size, and then retry.
{% endhint %}

### Grant access to a share

1. Create an IP-based access rule with the required access level. This works on both protocols.

```bash
   openstack share access create my-first-share ip 192.168.10.0/24 --access-level rw
```

2. Confirm that the rule is in the `active` state:

```bash
   openstack share access list my-first-share
```

For WekaFS shares, you can also assign a policy group defined by the storage administrator.

3. Optional: Delete an access rule to revoke access:

```bash
   openstack share access delete my-first-share <access-rule-id>
```

The plug-in removes the client group and permission from the cluster.

{% hint style="info" %}
`access_type=user` is not supported on either protocol, and the rule enters the `error` state.
{% endhint %}

### Mount a share

1. Retrieve the export path:

```bash
   openstack share show my-first-share -c export_locations
```

2. On a client covered by an access rule, mount the share.
   * WekaFS share (the client requires the WekaFS client):

```bash
     mkdir -p /mnt/my-first-share
     mount -t wekafs <export-path> /mnt/my-first-share
```

* NFS share:

```bash
     mkdir -p /mnt/my-nfs-share
     mount -t nfs <nfs-export-path> /mnt/my-nfs-share
```

3. Optional: To mount the share at boot, add an entry to `/etc/fstab` on the client:

```
   # WekaFS
   <export-path>       /mnt/my-first-share  wekafs  defaults,num_cores=1  0 0

   # NFS
   <nfs-export-path>   /mnt/my-nfs-share    nfs     defaults,_netdev      0 0
```

### Resize a share

1. Resize the share to the new size in GiB:

```bash
   openstack share resize my-first-share 100
```

The plug-in updates the filesystem capacity on the cluster. If you shrink a share that holds more data than the target size, the operation fails safely with `ShareShrinkingPossibleDataLoss`. Free space on the share, and then retry.

### Create and use snapshots

Snapshot operations use native WEKA snapshots and require the snapshot feature flags in `manila.conf`.

1. Create a snapshot:

```bash
   openstack share snapshot create --name snap1 my-first-share
```

2. Optional: Revert the share to the snapshot in place:

```bash
   openstack share revert snap1
```

3. Optional: Create a share from the snapshot:

```bash
   openstack share create --name restored --share-type weka-default \
     --size 10 --snapshot snap1 WEKAFS
```

The plug-in copies the snapshot data into a new filesystem over NFS. Copy time scales with the amount of data.

{% hint style="warning" %}
Reverting a share to a snapshot overwrites the current share data with the snapshot contents.
{% endhint %}

### Delete a share

{% hint style="danger" %}
Deleting a share deletes the backing WEKA filesystem and all its data.
{% endhint %}

1. Delete the share:

```bash
   openstack share delete my-first-share
```

### Related topics

[.](./ "mention")

[troubleshoot-the-wekafs-plug-in.md](troubleshoot-the-wekafs-plug-in.md "mention")

[snapshots](../../weka-filesystems-and-object-stores/snapshots/ "mention")
