# Feature-Specific Upgrade Procedures

## Upgrading to Version 3.1.8: Max-Files Handling

When upgrading from version 3.1.7 \(which does not enforce a limitation on the maximum number of files\) to version 3.1.8 \(which has the capability to enforce the limit\), the following procedure must be followed. Enforcement is not enabled automatically in order to prevent a situation where the creation of new files  is not allowed after an upgrade.

1. With the upgrade, the system will calculate an estimated max-files limitation per filesystem based on its SSD size. **However, this will not be implemented until enforcement is turned on.**
2. Review the max-files related alerts [below](feature-specific-upgrade-procedures.md#max-files-related-alerts) and ensure that no filesystem breaches the current configured max-files.
3. Review the max-files parameter for all filesystems using the`weka fs list` command and adjust accordingly using either the`weka fs update <fs-name> --max-files=<value>` command or alternatively by  re-configuring the system to have more RAM and thereby support more files.
4. Enable max-files validation using the following command:  `weka local run wapi enable-filesystems-resource-validation.`

### Max-Files Related Alerts

The following two alerts, viewable with the `weka alerts` command,  have been added to the system. They may occur after an upgrade from version 3.1.7 to version 3.1.8:

* The`NotEnoughConfiguredMemoryForFilesystems` alert will be emitted in cases of misconfigurations \(should only happen after an upgrade\), when the number of `max-files` for the filesystems in the cluster are not correctly configured to quantities that can be supported by the total amount of RAM configured for the backends in the cluster. 
* The`NotEnoughAvailableMemoryForFilesystems` alert will be emitted if the filesystems in the cluster are not correctly configured as described above, or if the filesystems are correctly configured but enough compute nodes are down so that there is insufficient RAM in the live compute nodes in the cluster to support the configured filesystems. If this alert appears without the `NotEnoughConfiguredMemoryForFilesystems` alert, determine the source of the problem with the nodes in the cluster \(since some of them are probably down for some reason\).



