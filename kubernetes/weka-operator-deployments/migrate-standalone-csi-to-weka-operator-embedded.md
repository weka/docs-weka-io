---
description: >-
  Migrate the CSI plugin to the WEKA Operator to centralize cluster management
  and streamline future updates.
---

# Migrate standalone CSI to WEKA Operator-embedded

## Unified CSI management

The legacy WEKA CSI plugin functions as a standalone Helm chart deployment. In this model, the plugin lifecycle, including updates and configuration changes, requires independent management of the Helm release.

Transitioning to an Operator-embedded deployment provides a unified management model. The WEKA Operator assumes control of the CSI lifecycle, which simplifies maintenance. During this transition, the Operator takes over the CSI plugin management without affecting existing PersistentVolumes (PVs) or PersistentVolumeClaims (PVCs).

### Operational impact

The migration process affects cluster operations as follows:

* **Volume integrity:** Existing PVCs and PVs remain intact. Uninstalling the standalone plugin only prevents new volume provisioning and mounting until the migration completes.
* **Management availability:** CSI operations, such as creating or deleting PVCs and gathering metrics, are blocked until the embedded CSI is active.

### Migration limitations

Identify specific environment constraints that affect the migration process.

* **Mixed mount environments:** Kubernetes clusters that combine stateless client mounts outside CSI with CSI mounts and Operator-managed clients do not support non-disruptive upgrades. Use reboot-based upgrades, or manually unmount and remount volumes during the client provisioning cycle.
* **Agent removal:** The WEKA agent cannot be removed from a server while active mounts are present. Plan agent removal only after unmounting all volumes or during a coordinated maintenance window.

{% hint style="warning" %}
Avoid direct mounts on Kubernetes servers outside the CSI plugin. Direct mounts can cause issues during upgrades and server reboots.
{% endhint %}

## Migrate the CSI plugin

Back up existing Helm values for both the Operator and the CSI plugin.

**Before you begin**

Before starting the migration, ensure the environment meets these criteria:

* **Operator version:** The WEKA Operator version is 1.7.0 or later.
* **Original installation:** The standalone CSI plugin was installed using the `csi-wekafs` Helm chart.
* **Maintenance window:** A maintenance window is scheduled to account for a potential IO stall during CSI cutover.
* **Backups:** Back up existing Helm values for both the Operator and the CSI plugin.

**Procedure**

1. **Upgrade the Operator:** Upgrade the WEKA Operator to version 1.7.0 or later. The embedded CSI plugin remains disabled by default after the upgrade to prevent interference with the standalone installation.
2.  **Uninstall the standalone CSI:** Remove the Helm-based CSI installation.

    ```bash
    helm uninstall csi-wekafs -n <namespace>
    ```
3.  **Configure the CSI group name:** Set the `csiGroup` parameter in the WekaClient specification. This maintains compatibility with the `csi.weka.io` driver name and ensures existing StorageClasses and PVs function without modification.

    ```yaml
    spec:
      csiConfig:
        csiGroup: csi
    ```
4. **Enable the embedded CSI:** Update the Operator configuration to enable the embedded CSI plugin.
   1.  Retrieve existing flags:

       ```bash
       helm get values weka-operator
       ```
   2.  Run the helm upgrade with the retrieved flags:

       ```bash
       helm upgrade weka-operator <chart> --set csi.installationEnabled=true [other existing flags]
       ```
5. **Verify the deployment:** Validate the status of the migration and all components.

| Component | Validation command |
| --- | --- |
| Deployment status | `kubectl get wekaclient &#x3C;client-name> -n &#x3C;namespace> -o jsonpath='{.status.csiDeployed}'` |
| Storage classes | `kubectl get storageclass` |
| Controller status | `kubectl get deployment -n` |
| Node pods | `kubectl get pods -n &#x3C;csi-namespace> -l component=csi-weka-csi-node` |

**Related topic**

[weka-csi-plugin](../../appendices/weka-csi-plugin/ "mention")
