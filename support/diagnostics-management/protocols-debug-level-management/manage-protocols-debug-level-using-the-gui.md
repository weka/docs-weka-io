# Manage protocols debug level using the GUI

The Protocols Debug Level section displays the debug level for the S3 and NFS protocols only (the SMB debug level is not shown). You can change the debug level only for the configured protocols.

![Protocols debug level](../../../.gitbook/assets/wmng\_protocols\_debug\_level.png)

Using the GUI, you can:

* [Update S3 debug level](manage-protocols-debug-level-using-the-gui.md#update-s3-debug-level)
* [Update NFS debug level](manage-protocols-debug-level-using-the-gui.md#update-nfs-debug-level)
* [Update SMB debug level](manage-protocols-debug-level-using-the-gui.md#update-smb-debug-level)

{% hint style="info" %}
Once the container is restarted, the log verbosity level reverts to its default.
{% endhint %}

## Update S3 debug level <a href="#update-s3-debug-level" id="update-s3-debug-level"></a>

If the S3 protocol is configured, you can change the debug level for all hosts or specified hosts.

The available debug levels are:

* 0 - CRITICAL
* 1 - ERROR
* 2 - WARNING
* 3 - INFO
* 4 - DEBUG
* 5 - TRACE

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Support**.
3. On the Protocols Debug Level section, select **Change S3 debug level**.
4. On the Update S3 Debug Level dialog, set the following properties:
   * **Level:** Select the debug level.
   * **All members:** If you want to apply the update on all the hosts, switch to **On**. If you want to apply the update on specific hosts, switch to **Off** and select the required hosts.

![Update S3 Debug Level](../../../.gitbook/assets/wmng\_update\_S3\_debug\_level.png)

## Update NFS debug level <a href="#update-nfs-debug-level" id="update-nfs-debug-level"></a>

If the NFS protocol is configured, you can change the debug level for all hosts or specified hosts.

The available debug levels are:

* 1 - EVENT
* 2 - INFO
* 3 - DEBUG
* 4 - MID DEBUG
* 5 - FULL DEBUG

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Support**.
3. On the Protocols Debug Level section, select **Change NFS debug level**.
4. On the Update NFS Debug Level dialog, set the following properties:
   * **Level:** Select the debug level.
   * **All members:** If you want to apply the update on all the hosts, switch to **On**. If you want to apply the update on specific hosts, switch to **Off** and select the required hosts.

![Update NFS Debug Level](../../../.gitbook/assets/wmng\_update\_NFS\_debug\_level.png)

## Update SMB debug level <a href="#update-smb-debug-level" id="update-smb-debug-level"></a>

If the SMB protocol is configured, you can change the debug level for all hosts or specified hosts.

The available debug levels are:

* 0 - NO DEBUG
* 5 - MID DEBUG
* 10 - FULL DEBUG

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Support**.
3. On the Protocols Debug Level section, select **Change SMB debug level**.
4. On the Update SMB Debug Level dialog, set the following properties:
   * **Level:** Select the debug level.
   * **All members:** If you want to apply the update on all the hosts, switch to **On**. If you want to apply the update on specific hosts, switch to **Off** and select the required hosts.

![Update SMB Debug Level](../../../.gitbook/assets/wmng\_update\_smb\_debug\_level.png)
