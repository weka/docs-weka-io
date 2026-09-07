---
description: Replace a failed storage drive and restore cluster redundancy and capacity.
---

# Replace a failed drive

Replace a failed storage drive to restore cluster redundancy and capacity. This procedure does not apply to operating system drives.

### Before you begin

* Obtain a compatible replacement drive.
* Access the cluster CLI with permissions to manage drives.
* Schedule a maintenance window if your server does not support hot swapping.

{% hint style="warning" %}
When rebuild capacity is unavailable, a failed drive reduces data redundancy and protection.
{% endhint %}

### Replace the drive

1.  Identify the failed drive and record its UUID and host ID.

    ```bash
    weka cluster drive -F node=invalid -o id,uuid,host,hostname,node,status
    ```

    If the command does not show the failed drive, run:

    ```bash
    weka cluster drive -F status=inactive -o id,uuid,host,hostname,node,status
    ```

    A failed drive displays an invalid node ID and an `INACTIVE` status.
2.  Deactivate the failed drive.

    ```bash
    weka cluster drive deactivate <drive-uuid>
    ```
3.  Remove the drive from the cluster.

    ```bash
    weka cluster drive remove <drive-uuid>
    ```
4. Replace the physical drive. Follow the server vendor's service procedure.
5.  Confirm that the operating system detects the replacement drive.

    ```bash
    lsblk
    ```

    The output shows the new device and devices not used by the data path.
6.  Add the replacement drive to the cluster. Use the failed drive's host ID from Step 1.

    ```bash
    weka cluster drive add <host-id> <device-path>
    ```

    For example:

    ```bash
    weka cluster drive add 1 /dev/nvme1n1
    ```
7.  Confirm that the drive joins the cluster and monitor recovery.

    ```bash
    weka status
    ```

    When the rebuild completes, the replacement drive becomes `ACTIVE`.

**Related information**

See [Shrink a cluster](expanding-and-shrinking-cluster-resources/shrinking-a-cluster.md) for drive deactivation and removal details.
