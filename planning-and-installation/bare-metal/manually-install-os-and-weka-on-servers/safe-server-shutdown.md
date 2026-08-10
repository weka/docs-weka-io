---
description: >-
  Explore the systemd-based mechanism that allows a server to shut down safely.
  This feature is particularly valuable for converged servers that users might
  terminate abruptly.
---

# Safe server shutdown

## How safe shutdown works

The **weka-agent** service installs a systemd shutdown hook. When the operating system receives a reboot or power-off signal, the hook triggers the agent’s **requested-action** workflow. This workflow stops the cluster containers in the correct order to ensure data integrity.

The systemd process waits until every container exits cleanly. If a container cannot shut down safely, the overall shutdown process stalls.

## Enable safe shutdown

You can enable the safe shutdown feature either during the initial software installation or on an existing system.

**During installation**

Enable the safe shutdown feature by adding the `WEKA_SYSTEMD_GRACEFUL_SHUTDOWN=true` flag to the installation command.

Example:

{% code overflow="wrap" %}
```
curl https://<token>@get.weka.io/dist/v1/install/5.0.4/5.0.4. | WEKA_SYSTEMD_GRACEFUL_SHUTDOWN=true sh
```
{% endcode %}

**After installation**

If WEKA is already installed, you can enable the feature on each server.

**Procedure**

1.  Edit the `/etc/wekaio/service.conf` file and change the `graceful_shutdown` parameter to `true`.

    ```
    [systemd]
    graceful_shutdown=true
    ```
2.  Restart the agent to apply the setting.

    ```
    weka agent restart
    ```

To check the safe shutdown status, run the following:

```
$ weka local status
...
Graceful shutdown via systemd: enabled
...
```

## Cloud provider considerations

Some cloud vendors replace or override default systemd shutdown hooks with a hard-kill process after a fixed timeout.

If you require fully safe shutdowns, disable those hooks or extend the timeout. Ensure your operations teams are aware of this behavior. For example, Oracle Cloud Infrastructure (OCI) is a cloud provider that might override default shutdown hooks.

**Related topics**

[#graceful-container-management-ensuring-safe-actions](../../../operation-guide/expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md#graceful-container-management-ensuring-safe-actions "mention") (requested-action workflow)

[background-tasks](../../../operation-guide/background-tasks/ "mention")

[upgrading-weka-versions.md](../../../operation-guide/upgrading-weka-versions.md "mention")
