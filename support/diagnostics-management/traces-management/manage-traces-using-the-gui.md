# Manage traces using the GUI

Using the GUI, you can:

* [Configure traces](manage-traces-using-the-gui.md#configure-traces)
* [Freeze traces](manage-traces-using-the-gui.md#freeze-traces)
* [Change traces verbosity level](manage-traces-using-the-gui.md#change-traces-verbosity-level)
* [Restore traces default settings](manage-traces-using-the-gui.md#restore-traces-default-settings)

<figure><img src="../../../.gitbook/assets/wmng_traces.png" alt=""><figcaption><p>Manage traces</p></figcaption></figure>

## Configure traces <a href="#configure-traces" id="configure-traces"></a>

The tracking tool collects the traces on the backends and clients and retains them on their disks. You can limit the capacity used by the traces by ensuring minimum free capacity and by setting the maximum capacity that traces can use.

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Support**.
3. On the Traces section, select **Configure traces**.
4. On the Configure Traces dialog set the following properties:
   * The minimum free capacity to preserve on the backends.
   * The minimum free capacity to preserve on the clients.
   * The maximum capacity traces can use on backends.
   * The maximum capacity traces can use on clients.
5. Select **Save**.

<figure><img src="../../../.gitbook/assets/wmng_configure_traces.png" alt=""><figcaption><p>Configure traces</p></figcaption></figure>

## Freeze traces <a href="#freeze-traces" id="freeze-traces"></a>

Sometimes you may need to investigate an issue that occurred during a certain period. You can retain the tracing data of that period using the freeze traces action.

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Support**.
3. On the Traces section, select **Freeze traces**.
4. On the Freeze Traces dialog set the following properties:
   * **Start:** The start date and time of the period to freeze (mandatory).
   * **End:** The end date and time of the period to freeze.
   * **Retention:** The time to retain the tracing data. After this time, the tracking tool may purge the tracing data according to its purging cycle.
   * **Override:** If a freezing period is already set, you can override it by setting the **Override** button to **On**.
5. Select **Save**.

<figure><img src="../../../.gitbook/assets/wmng_freeze_traces.png" alt=""><figcaption><p>Freeze traces</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/wmng_freeze_traces_result.png" alt=""><figcaption><p>Example of a freeze period</p></figcaption></figure>

6\. To clear the freeze period, select **Reset traces freeze**. Then, in the confirmation message, \
&#x20;   select **Yes**.

## Change traces verbosity level <a href="#change-traces-verbosity-level" id="change-traces-verbosity-level"></a>

The verbosity level determines the amount of information in the tracing data. Switching the verbosity level to high provides more troubleshooting details but may use more space on the disk.

**Procedure**

1. In the Traces section, depending on the current verbosity level (low or high), select **Change traces level to high** or **Change traces level to low**.

<figure><img src="../../../.gitbook/assets/wmng_change_verbosity_level.png" alt=""><figcaption><p>Change verbosity level</p></figcaption></figure>

## Restore traces default settings <a href="#restore-traces-default-settings" id="restore-traces-default-settings"></a>

You can restore the traces configuration to its default settings as shown in the following image.

<figure><img src="../../../.gitbook/assets/wmng_traces_default_settings.png" alt=""><figcaption><p>Traces default settings</p></figcaption></figure>

{% hint style="info" %}
The default maximum capacity per IO-node is 50 GB and the minimum for all IO-nodes is 100 GB. The minimum free capacity is 3.22 GB
{% endhint %}

**Procedure**

1. In the Traces section,  select **Restore traces default settings**. Then, in the confirmation message, select **Yes**.
