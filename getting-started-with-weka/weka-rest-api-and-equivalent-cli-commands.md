---
description: >-
  Explore the tasks you can program using the WEKA REST API, equivalent CLI
  commands, and the related information to learn the theory. (REST APIs marked
  with asterisks * are new additions in V4.3.)
---

# WEKA REST API and equivalent CLI commands

To maximize your success with the REST API, it's essential to familiarize yourself with the comprehensive documentation. This valuable resource provides in-depth insights into the subject matter. Moreover, each REST API method corresponds to a CLI command. Additionally, many parameters accessible through the CLI are equally accessible when using the REST API. Run the CLI command help for details. This ensures a smooth and consistent experience across both interfaces.

## Access Groups

Related information: [#nfs-access-control-client-access-groups](../additional-protocols/nfs-support/#nfs-access-control-client-access-groups "mention")

| Task                                                                                                                | REST API                                                                                                                                                                                                      | CLI                         |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| **Show access group status:** This shows the NFS client permission group status, whether it is enabled or disabled. | [GET](http://datasphere.wekalab.io:14000/api/v2/docs/#/Access%20Groups/getAccessGroupStatus)[​/accessGroups](http://datasphere.wekalab.io:14000/api/v2/docs/#/Access%20Groups/getAccessGroupStatus)\*         | `weka access-group status`  |
| **Enable access group**                                                                                             | [POST](http://datasphere.wekalab.io:14000/api/v2/docs/#/Access%20Groups/enableAccessGroups)[​/accessGroups​/enable](http://datasphere.wekalab.io:14000/api/v2/docs/#/Access%20Groups/enableAccessGroups)\*    | `weka access-group enable`  |
| **Disable access group**                                                                                            | [POST](http://datasphere.wekalab.io:14000/api/v2/docs/#/Access%20Groups/disableAccessGroups)[​/accessGroups​/disable](http://datasphere.wekalab.io:14000/api/v2/docs/#/Access%20Groups/disableAccessGroups)\* | `weka access-group disable` |

## Active Directory

Related information: [user-management](../operation-guide/user-management/ "mention")

| Task                                                                                                                               | REST API                                                                                         | CLI                       |
| ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ | ------------------------- |
| **Update Active Directory:** Change the cluster's configuration to use a different Active Directory server or modify its settings. | [PUT ​/activeDirectory](https://api.docs.weka.io/#/Active%20directory/updateLdapActiveDirectory) | `weka user ldap setup-ad` |

## Alerts

Related information: [alerts](../operation-guide/alerts/ "mention")

| Task                                                                                                       | REST API                                                                                   | CLI                                        |
| ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------ |
| **View all alerts:** Get a complete list of active alerts, including silenced ones.                        | [GET ​/alerts](https://api.docs.weka.io/#/Alerts/getAlerts)                                | `weka alerts`                              |
| **List possible alerts:** See all types of alerts the cluster can generate.                                | [GET ​/alerts​/types](https://api.docs.weka.io/#/Alerts/getAlertsTypes)                    | `weka alerts types`                        |
| **List alert types with actions:** View different alert types and their recommended troubleshooting steps. | [GET ​/alerts​/description](https://api.docs.weka.io/#/Alerts/getAlertDescription)         | `weka alerts describe`                     |
| **Mute alerts by type:** Silence specific types of alerts.                                                 | [PUT ​/alerts​/{alert\_type}​/mute](https://api.docs.weka.io/#/Alerts/muteAlertByType)     | `weka alerts mute <alert-type> <duration>` |
| **Unmute alerts by type:** Reactivate specific types of alerts.                                            | [PUT ​/alerts​/{alert\_type}​/unmute](https://api.docs.weka.io/#/Alerts/unmuteAlertByType) | `weka alerts unmute <alert-type>`          |

## WEKA Home

Related information: [the-wekaio-support-cloud](../monitor-the-weka-cluster/the-wekaio-support-cloud/ "mention")

| Task                                                                                               | REST API                                                                                   | CLI                                                            |
| -------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | -------------------------------------------------------------- |
| **View cloud WEKA Home configuration:** See the existing settings for the cloud WEKA Home service. | [GET ​/wekaHome](https://api.docs.weka.io/#/Weka%20home/getCloud)                          | `weka cloud status`                                            |
| **View cloud WEKA Home proxy URL:** Get the existing URL to access cloud services.                 | [GET ​/wekaHome​/proxy](https://api.docs.weka.io/#/Weka%20home/getCloudProxy)              | `weka cloud proxy`                                             |
| **Set cloud WEKA Home proxy URL:** Change the URL used to access cloud services.                   | [POST ​/wekaHome​/proxy](https://api.docs.weka.io/#/Weka%20home/setCloudProxy)             | `weka cloud proxy --set <proxy_url>`                           |
| **View cloud WEKA Home upload rate:** See the existing data upload speed to the cloud service.     | [GET ​/wekaHome​/uploadRate](https://api.docs.weka.io/#/Weka%20home/getCloudUploadRate)    | `weka cloud upload-rate`                                       |
| **Set cloud WEKA Home upload rate:** Define the preferred data upload speed to the cloud service.  | [PUT ​/wekaHome​/uploadRate](https://api.docs.weka.io/#/Weka%20home/updateCloudUploadRate) | `weka cloud upload-rate set --bytes-per-second <bps>`          |
| **View cloud WEKA Home URL:** Get the URL for accessing the cloud WEKA Home service.               | [GET ​/wekaHome​/url](https://api.docs.weka.io/#/Weka%20home/getCloudUrl)                  | `weka cloud status`                                            |
| **Enable cloud WEKA Home:** Start using the cloud WEKA Home service.                               | [POST ​/wekaHome​/enable](https://api.docs.weka.io/#/Weka%20home/enableCloud)              | `weka cloud enable --cloud-url <cloud> --cloud-stats <on/off>` |
| **Disable cloud WEKA Home:** Stop using the cloud WEKA Home service.                               | [POST ​/wekaHome​/disable](https://api.docs.weka.io/#/Weka%20home/disableCloud)            | `weka cloud disable`                                           |

## Cluster

Related information: [bare-metal](../planning-and-installation/bare-metal/ "mention")

| Task                                                                              | REST API                                                             | CLI                                    |
| --------------------------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------- |
| **Create a cluster:** Start a new cluster with chosen configurations.             | [POST ​/cluster](https://api.docs.weka.io/#/Cluster/createCluster)   | `weka cluster create <host-hostnames>` |
| **Update cluster configuration:** Modify settings for an existing cluster.        | [PUT ​/cluster](https://api.docs.weka.io/#/Cluster/updateCluster)    | `weka cluster update`                  |
| **View cluster status:** Check the overall health and performance of the cluster. | [GET ​/cluster](https://api.docs.weka.io/#/Cluster/getClusterStatus) | `weka status --jason`                  |

## Containers

Related information: [expanding-and-shrinking-cluster-resources](../operation-guide/expanding-and-shrinking-cluster-resources/ "mention")

| Task                                                                                                                                                                      | REST API                                                                                                                       | CLI                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------- |
| **List containers:** See all containers running in the cluster.                                                                                                           | [GET ​/containers](https://api.docs.weka.io/#/Containers/getContainers)                                                        | `weka cluster container`                              |
| **Add a container:** Introduce a new container to the cluster (apply afterward to activate).                                                                              | [POST ​/containers](https://api.docs.weka.io/#/Containers/addContainer)                                                        | `weka cluster container add <hostname>`               |
| **View container details:** Get information about a specific container (resources, state).                                                                                | [GET ​/containers​/{uid}](https://api.docs.weka.io/#/Containers/getSingleContainer)                                            | `weka cluster container <container-ids>`              |
| **Update container configuration:** Change settings for a container (cores, memory).                                                                                      | [PUT ​/containers​/{uid}](https://api.docs.weka.io/#/Containers/updateContainer)                                               | `weka cluster container <container-ids> <subcommand>` |
| **Manage protocol containers:** Restart the containers.                                                                                                                   | [POST​/containers​/manageProtoContainers](http://datasphere.wekalab.io:14000/api/v2/docs/#/Containers/manageProtoContainers)\* | `weka local restart <container>`                      |
| **Remove a container:** Stop and delete a container from the cluster.                                                                                                     | [DELETE ​/containers​/{uid}](https://api.docs.weka.io/#/Containers/removeContainer)                                            | `weka cluster container remove <container-ids>`       |
| **Apply configuration updates:** Implement changes to all containers.                                                                                                     | [POST ​/containers​/apply](https://api.docs.weka.io/#/Containers/applyContainers)                                              | `weka cluster container apply`                        |
| **Apply configuration updates:** Implement changes to specific containers.                                                                                                | [POST ​/containers​/{uid}​/apply](https://api.docs.weka.io/#/Containers/applyContainer)                                        | `weka cluster container apply <container-ids>`        |
| **Clear container failure:** Reset the error record for a container.                                                                                                      | [DELETE ​/containers​/lastFailureReason​/{uid}](https://api.docs.weka.io/#/Containers/clearContainerFailure)                   | `weka cluster container clear-failure<container-ids>` |
| **Monitor container resources:** Track resource usage (CPU, memory) for containers.                                                                                       | [GET ​/containers​/{uid}​/resources](https://api.docs.weka.io/#/Containers/getContainersResources)                             | `weka cluster container resources <container-ids>`    |
| **Start all containers:** Bring all inactive containers online and running.                                                                                               | [POST ​/containers​/activate](https://api.docs.weka.io/#/Containers/activateContainers)                                        | `weka cluster container activate`                     |
| **Start a specific container:** Activate an individual container by name or identifier.                                                                                   | [POST ​/containers​/{uid}​/activate](https://api.docs.weka.io/#/Containers/activateContainer)                                  | `weka cluster container activate <container-ids>`     |
| **Stop all containers:** Gracefully shut down all running containers.                                                                                                     | [POST ​/containers​/deactivate](https://api.docs.weka.io/#/Containers/deactivateContainers)                                    | `weka cluster container deactivate`                   |
| **Stop a specific container:** Deactivate an individual container by name or identifier.                                                                                  | [POST ​/containers​/{uid}​/deactivate](https://api.docs.weka.io/#/Containers/deactivateContainer)                              | `weka cluster container deactivate <container-ids>`   |
| **View network details for all containers:** See the network configuration and connectivity information for each container within the cluster.                            | [GET ​/containers​/netdevs](https://api.docs.weka.io/#/Containers/getAllContainersNetwork)                                     | `weka cluster container net`                          |
| **View network details for a specific container:** See the network configuration and connectivity information for a single container specified by its name or identifier. | [GET ​/containers​/{uid}​/netdevs](https://api.docs.weka.io/#/Containers/getContainerNetwork)                                  | `weka cluster container net <container-ids>`          |
| **Assign dedicated network:** Give a container its network device (apply afterward to activate).                                                                          | [POST ​/containers​/{uid}​/netdevs](https://api.docs.weka.io/#/Containers/createContainerNetwork)                              | `weka cluster container net add <container-ids>`      |
| **Remove dedicated network:** Take away a container's dedicated network device (apply afterward to activate).                                                             | [DELETE ​/containers​/{uid}​/netdevs​/{netdev\_uid}](https://api.docs.weka.io/#/Containers/removeContainerNetwork)             | `weka cluster container net remove <container-ids>`   |
| **View container hardware:** See hardware details (IP addresses) for containers.                                                                                          | [POST ​/containers​/infos](https://api.docs.weka.io/#/Containers/getContainersInfo)                                            | `weka cluster container info-hw`                      |

## Default network

Related information: [#id-6.-configure-default-data-networking-optional](../planning-and-installation/bare-metal/perform-post-configuration-procedures.md#id-6.-configure-default-data-networking-optional "mention")

| Task                                                                                                                                                | REST API                                                                                | CLI                               |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | --------------------------------- |
| **Check default network setup:** Review the predefined network properties for container deployments.                                                | [GET ​/defaultNet](https://api.docs.weka.io/#/Default%20network/getDefaultNetwork)      | `weka cluster default-net`        |
| **Define new network defaults:** Define the IP address range, gateway address, and subnet mask to be used for future container network assignments. | [POST ​/defaultNet](https://api.docs.weka.io/#/Default%20network/setDefaultNetwork)     | `weka cluster default-net set`    |
| **Modify existing network defaults:** Change the parameters like IP range, gateway, or subnet mask used for future container network assignments.   | [PUT ​/defaultNet](https://api.docs.weka.io/#/Default%20network/updateDefaultNetwork)   | `weka cluster default-net update` |
| **Clear custom network defaults:** Remove any modifications to the standard network settings and return to the initial baseline.                    | [DELETE ​/defaultNet](https://api.docs.weka.io/#/Default%20network/resetDefaultNetwork) | `weka cluster default-net reset`  |

## Drive

Related information: [expanding-and-shrinking-cluster-resources](../operation-guide/expanding-and-shrinking-cluster-resources/ "mention")

| Task                                                                                                                                                               | REST API                                                                        | CLI                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------- | ------------------------------------------------------ |
| **View a list of all SSD drives in the cluster:** Get information about all available SSD drives within the cluster, including size, UUID, status, and more. drive | [GET ​/drives](https://api.docs.weka.io/#/Drive/getDrives)                      | `weka cluster drive`                                   |
| **Add a new SSD drive to a container:** Attach an additional SSD drive to a specific container within the cluster to expand its available resources.               | [POST ​/drives](https://api.docs.weka.io/#/Drive/provisionDrives)               | `weka cluster drive add <container-id> <device-paths>` |
| **View a specific SSD drive in the cluster:** Get detailed information about a particular SSD drive in the cluster.                                                | [GET ​/drives​/{uid}](https://api.docs.weka.io/#/Drive/getSingleDrive)          | `weka cluster drive <uuids>`                           |
| **Remove an SSD drive from the cluster:** Detach an SSD drive from the cluster, making it unavailable for further use.                                             | [DELETE ​/drives​/{uid}](https://api.docs.weka.io/#/Drive/deleteDrive)          | `weka cluster drive remove <uuids>`                    |
| **Activate SSD drives in the cluster:** Bring one or more SSD drives online and make them available for use in the cluster.                                        | [POST ​/drives​/activate](https://api.docs.weka.io/#/Drive/activateDrives)      | `weka cluster drive activate <uuids>`                  |
| **Deactivate SSD drives in the cluster:** Temporarily take one or more SSD drives offline, preventing their use in the cluster while preserving the stored data.   | [POST ​/drives​/deactivate](https://api.docs.weka.io/#/Drive/deactivatesDrives) | `weka cluster drive deactivate <uuids>`                |

## Events

Related information: [events](../operation-guide/events/ "mention")

| **Filter and explore events:** Find specific events in the cluster by applying filters based on criteria like severity, category, and time range. | [GET ​/events](https://api.docs.weka.io/#/Events/getEvents)                      | `weka events`                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| **Get event details:** View a detailed description of a specific event type, including its meaning and potential causes.                          | [GET ​/events​/describe](https://api.docs.weka.io/#/Events/getEventsDescription) | `weka events list-types`                                            |
| **Analyze event trends:** See how events occur over time by aggregating them within a specific time interval.                                     | [GET ​/events​/aggregate](https://api.docs.weka.io/#/Events/getAggregateEvents)  | `weka events --start-time <start> --end-time <end> --show-internal` |
| **Trace events by server:** Focus on events generated by a specific server in the cluster for deeper troubleshooting.                             | [GET ​/events​/local](https://api.docs.weka.io/#/Events/getLocalEvents)          | `weka events list-local`                                            |
| **Create custom events:** Trigger and record your custom events with additional user-defined parameters for enhanced monitoring and logging.      | [POST /events/custom](https://api.docs.weka.io/#/Events/triggerCustomEvent)      | `weka events trigger-event`                                         |

## Failure domains

Related information: [ssd-capacity-management.md](../weka-system-overview/ssd-capacity-management.md "mention")

| Task                                                                                                                                | REST API                                                                                           | CLI                                      |
| ----------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| **View all failure domains:** Get a list of all available failure domains within the cluster.                                       | [GET ​/failureDomains](https://api.docs.weka.io/#/Failure%20domains/getFailureDomains)             | `weka cluster failure-domain`            |
| **View details of a specific failure domain:** See information about a single failure domain, including its resources and capacity. | [GET ​/failureDomains​/{uid}](https://api.docs.weka.io/#/Failure%20domains/getSingleFailureDomain) | `weka cluster container <container-ids>` |

## Filesystem

Related information:

* [filesystems.md](../weka-system-overview/filesystems.md "mention")
* [managing-filesystems](../weka-filesystems-and-object-stores/managing-filesystems/ "mention")
* [attaching-detaching-object-stores-to-from-filesystems](../weka-filesystems-and-object-stores/attaching-detaching-object-stores-to-from-filesystems/ "mention")

| Task                                                                                                                                                        | REST API                                                                                                                              | CLI                                           |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| **List all filesystems:** Get a complete list of all defined filesystems in the cluster.                                                                    | [GET ​/fileSystems](https://api.docs.weka.io/#/Filesystem/getFileSystems)                                                             | `weka fs`                                     |
| **Create a new filesystem:** Configure and establish a new filesystem within the cluster.                                                                   | [POST ​/fileSystems](https://api.docs.weka.io/#/Filesystem/createFileSystem)                                                          | `weka fs create`                              |
| **View details of a specific filesystem:** Obtain specific information about a specified filesystem, like its size, quota, and usage.                       | [GET ​/fileSystems​/{uid}](https://api.docs.weka.io/#/Filesystem/getFileSystem)                                                       | `weka fs --name <name>`                       |
| **Modify a filesystem:** Change the settings or properties of an existing filesystem.                                                                       | [PUT ​/fileSystems​/{uid}](https://api.docs.weka.io/#/Filesystem/updateFileSystem)                                                    | `weka fs update <name>`                       |
| **Delete a filesystem:** Remove a chosen filesystem and its data from the cluster.                                                                          | [DELETE ​/fileSystems​/{uid}](https://api.docs.weka.io/#/Filesystem/deleteFileSystem)                                                 | `weka fs delete <name>`                       |
| **Attach an object store bucket:** Link an object store bucket to a filesystem, allowing data access from both locations.                                   | [POST ​/fileSystems​/{uid}​/objectStoreBuckets](https://api.docs.weka.io/#/Filesystem/attachObsBucketToFs)                            | `weka fs tier s3 attach <fs-name>`            |
| **Detach an object store bucket:** Disconnect an object store bucket from a filesystem, separating their data access.                                       | [DELETE ​/fileSystems​/{uid}​/objectStoreBuckets​/{obs\_uid}](https://api.docs.weka.io/#/Filesystem/detachObsBucketFromFS)            | `weka fs tier s3 detach <fs-name> <obs-name>` |
| **Restore a filesystem from a snapshot:** Create a new filesystem based on a saved snapshot stored in an object store bucket.                               | [POST ​/fileSystems​/download](https://api.docs.weka.io/#/Filesystem/downloadFS)                                                      | `weka fs download`                            |
| **View thin-provisioning status:** Check the existing allocated thin-provisioning space reserved for your organization within the cluster.                  | [GET ​/fileSystems​/thinProvisionReserve](https://api.docs.weka.io/#/Filesystem/getFileSystemsThinProvisionReserveStatus)             | `weka fs reserve status`                      |
| **Reserve guaranteed SSD for your organization:** Set the thin-provisioning space for your organization's filesystems.                                      | [PUT ​/fileSystems​/thinProvisionReserve​/{org\_uid}](https://api.docs.weka.io/#/Filesystem/setFileSystemsThinProvisionReserve)       | `weka fs reserve set <ssd-capacity>`          |
| **Release dedicated SSD space for your organization:** Remove the existing reserved thin-provisioning space allocated for your organization's filesystems.  | [DELETE ​/fileSystems​/thinProvisionReserve​/{org\_uid}](https://api.docs.weka.io/#/Filesystem/deleteFileSystemsThinProvisionReserve) | `weka fs reserve unset --org <org>`           |
| **Get metadata for a specific file or directory:** See detailed information about a specific file or directory using its unique identifier "inode context". | [GET ​/fileSystems​/{inode\_context}​/resolve](https://api.docs.weka.io/#/File%20system/filesystemResolveInode)                       | `weka debug fs resolve-inode`                 |

## Quota

Related information: [quota-management](../weka-filesystems-and-object-stores/quota-management/ "mention")

| Task                                                                                                                                                | REST API                                                                                                 | CLI                                                                                    |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| **View quotas:** See a list of the existing quota settings for all directories within the filesystem.                                               | [GET ​/fileSystems​/{uid}​/quota](https://api.docs.weka.io/#/Quota/listQuotas)                           | `weka fs quota list <fs-name>`                                                         |
| **View default quotas:** Check the default quota configuration applied to new directories.                                                          | [GET ​/fileSystems​/{uid}​/quota​/default](https://api.docs.weka.io/#/Quota/listDefaultQuotas)           | `weka fs quota list-default`                                                           |
| **View/list the parameters of a specific directory quota**                                                                                          | [GET ​/fileSystems​/{uid}​/quota​/{inode\_id}](https://api.docs.weka.io/#/Quota/getQuota)                | `weka fs quota list <fs-name> --path <path>`                                           |
| **Set/update a directory quota (empty only):** Specify disk space limits for an individual directory (requires a directory with no existing files). | [PUT ​/fileSystems​/{uid}​/quota​/{inode\_id}](https://api.docs.weka.io/#/Quota/putQuota)                | `weka fs quota set <path>`                                                             |
| **Update directory quota parameters:** Modify specific settings (like grace period) for an existing directory quota.                                | [PATCH ​/fileSystems​/{uid}​/quota​/{inode\_id}](https://api.docs.weka.io/#/Quota/patchQuota)            | `weka fs quota set <path> --soft <soft> --hard <hard> --grace <grace> --owner <owner>` |
| **Remove a directory quota (empty only):** Disable the quota restrictions for a directory (requires a directory with no existing files).            | [DELETE ​/fileSystems​/{uid}​/quota​/{inode\_id}](https://api.docs.weka.io/#/Quota/deleteQuota)          | `weka fs quota unset <path>`                                                           |
| **Set/update default quota:** Establish or change the default quota applied to all newly created directories.                                       | [PUT ​/fileSystems​/quota​/{inode\_context}](https://api.docs.weka.io/#/Quota/putDefaultQuota)           | `weka fs quota set-default <path>`                                                     |
| **Unset a default directory quota:** Disable the pre-defined quota restrictions automatically applied to new directories within the filesystem.     | [DELETE ​/fileSystems​/quota​/{inode\_id}​/default](https://api.docs.weka.io/#/Quota/deleteDefaultQuota) | `weka fs quota unset-default <path>`                                                   |

## Filesystem group

Related information: [managing-filesystem-groups](../weka-filesystems-and-object-stores/managing-filesystem-groups/ "mention")

| Task                                                                                                                 | REST API                                                                                                | CLI                           |
| -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ----------------------------- |
| **View filesystem groups:** See a list of all existing filesystem groups.                                            | [GET ​/fileSystemGroups](https://api.docs.weka.io/#/Filesystem%20group/getFileSystemGroups)             | `weka fs group`               |
| **Create/add a filesystem group:** Establish a new group to share and manage access control for certain filesystems. | [POST ​/fileSystemGroups](https://api.docs.weka.io/#/Filesystem%20group/createFileSystemGroup)          | `weka fs group create`        |
| **View filesystem group details:** Get specific information about a particular filesystem group.                     | [GET ​/fileSystemGroups​/{uid}](https://api.docs.weka.io/#/Filesystem%20group/getFileSystemGroup)       | N/A                           |
| **Update a filesystem group:** Modify the properties of an existing filesystem group.                                | [PUT ​/fileSystemGroups​/{uid}](https://api.docs.weka.io/#/Filesystem%20group/updateFileSystemGroup)    | `weka fs group update <name>` |
| **Delete a filesystem group:** Remove a filesystem group and its associated permissions.                             | [DELETE ​/fileSystemGroups​/{uid}](https://api.docs.weka.io/#/Filesystem%20group/deleteFileSystemGroup) | `weka fs group delete <name>` |

## Health

Related information: [#cluster-protection-and-availability-widget](manage-the-system-using-weka-gui.md#cluster-protection-and-availability-widget "mention")

| Task                                                                                                                               | REST API                                                               | CLI |
| ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | --- |
| **Check REST API status:** Verify the existing functionality and availability of the REST API used for programmatic system access. | [GET ​/healthcheck](https://api.docs.weka.io/#/Health/getApiHealth)    | N/A |
| **Check GUI status:** Confirm the proper operation and responsiveness of the graphical user interface.                             | [GET ​/ui​/healthcheck](https://api.docs.weka.io/#/Health/getUIHealth) | N/A |

## Interface Group

Related information: [nfs-support](../additional-protocols/nfs-support/ "mention")

| Task                                                                                                                                            | REST API                                                                                                                                      | CLI                                                                                                              |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **View interface groups:** See a list of all interface groups configured in the system.                                                         | [GET ​/interfaceGroups](https://api.docs.weka.io/#/Interface%20group/getInterfaceGroups)                                                      | `weka nfs interface-group`                                                                                       |
| **Create/add an interface group:** Set up a new interface group to manage network configuration for specific P addresses and ports.             | [POST ​/interfaceGroups](https://api.docs.weka.io/#/Interface%20group/createInterfaceGroup)                                                   | `weka nfs interface-group add`                                                                                   |
| **View interface group details:** See specific information about a particular interface group.                                                  | [GET ​/interfaceGroups​/{uid}](https://api.docs.weka.io/#/Interface%20group/getInterfaceGroup)                                                | `weka nfs interface-group --name <name>`                                                                         |
| **Delete an interface group:** Remove an interface group and its associated network definitions.                                                | [DELETE ​/interfaceGroups​/{uid}](https://api.docs.weka.io/#/Interface%20group/deleteInterfaceGroup)                                          | `weka nfs interface-group delete <name>`                                                                         |
| **Update an interface group:** Modify the settings of an existing interface group.                                                              | [PUT ​/interfaceGroups​/{uid}](https://api.docs.weka.io/#/Interface%20group/updateInterfaceGroup)                                             | `weka nfs interface-group update <name>`                                                                         |
| **Add an IP range to an interface group:** Define a specific range of IP addresses within the existing interface group for network access.      | [POST ​/interfaceGroups​/{uid}​/ips](https://api.docs.weka.io/#/Interface%20group/crateInterfaceGroupIp)                                      | `weka nfs interface-group ip-range add <name> <ips>`                                                             |
| **Add a port to an interface group:** Assign a specific port number to the interface group, making it accessible through that port.             | [POST ​/interfaceGroups​/{uid}​/ports​/{container\_uid}](https://api.docs.weka.io/#/Interface%20group/addPortToInterfaceGroup)                | `weka nfs interface-group port add <name> <server-id> <port>`                                                    |
| **Remove an IP range from an interface group:** Delete a previously defined IP range from the interface group, disabling its access.            | [DELETE ​/interfaceGroups​/{uid}​/ports​/{container\_uid}​/{port}](https://api.docs.weka.io/#/Interface%20group/deletePortFromInterfaceGroup) | `weka nfs interface-group port delete <name> <port>`                                                             |
| **Remove a port from an interface group:** Unassign a specific port from the interface group, making it no longer accessible through that port. | [DELETE ​/interfaceGroups​/{uid}​/ips​/{ips}](https://api.docs.weka.io/#/Interface%20group/deleteIpRangeFromInterfaceGroup)                   | `weka nfs interface-group ip-range delete <name> <ips>`                                                          |
| **View floating IPs:** See a list of all allocated floating IPs and their existing assignments.                                                 | [GET ​/interfaceGroups​/listAssignment](https://api.docs.weka.io/#/Interface%20group/getInterfaceGroupsListAssignment)                        | `weka nfs interface-group assignment`                                                                            |
| **Add port for all interface groups:** Assign a port to be accessible by the specified interface group.                                         | [POST ​/interfaceGroups​/port](https://api.docs.weka.io/#/Interface%20group/interfaceGroupAddPort)                                            | <p><code>weka nfs interface-group port add &#x3C;name></code> <br> <code>&#x3C;server-id> &#x3C;port></code></p> |

## KMS

Related information: [security](../operation-guide/security/ "mention")

| Task                                                                                                                    | REST API                                                          | CLI                                                       |
| ----------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------------------------------------------- |
| **View KMS configuration:** See the existing Key Management Service (KMS) settings for encrypting filesystems.          | [GET ​/kms](https://api.docs.weka.io/#/KMS/getKms)                | `weka security kms`                                       |
| **Set configuration (new KMS):** Establish a new KMS configuration with details like type, address, and key identifier. | [POST ​/kms](https://api.docs.weka.io/#/KMS/setKms)               | `weka security kms set <type> <address> <key-identifier>` |
| **Delete configuration (unused only):** Remove the KMS configuration if no encrypted filesystems rely on it.            | [DELETE ​/kms](https://api.docs.weka.io/#/KMS/deleteKms)          | `weka security kms unset`                                 |
| **View existing KMS type:** Find out whether HashiCorp Vault or KMIP is used for KMS.                                   | [GET ​/kms​/type](https://api.docs.weka.io/#/KMS/getKmsType)      | `weka security kms`                                       |
| **Re-encrypt filesystems:** Update the encryption keys for existing filesystems using the new KMS master key.           | [POST ​/kms​/rewrap](https://api.docs.weka.io/#/KMS/rewrapKmsKey) | `weka security kms rewrap`                                |

## LDAP

Related information: [user-management](../operation-guide/user-management/ "mention")

| Task                                                                                                                                                                                                                 | REST API                                                    | CLI                      |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------ |
| **View LDAP configuration:** Get detailed information about the configured settings for connecting to your LDAP server. This includes information like the server address, port, base DN, and authentication method. | [GET ​/ldap](https://api.docs.weka.io/#/LDAP/getLdap)       | `weka user ldap`         |
| **Update LDAP configuration:** Modify the existing settings used for connecting to your LDAP server. This may involve changing the server details, authentication credentials, or other relevant parameters.         | [PUT ​/ldap](https://api.docs.weka.io/#/LDAP/updateLdap)    | `weka user ldap setup`   |
| **Disable LDAP:** Deactivate the integration with your LDAP server for user authentication.                                                                                                                          | [DELETE ​/ldap](https://api.docs.weka.io/#/LDAP/deleteLdap) | `weka user ldap disable` |

## License

Related information: [overview.md](../billing-and-licensing/overview.md "mention")

| Task                                                                                                                   | REST API                                                            | CLI                                  |
| ---------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------ |
| **View license details:** Get information about the configured cluster license, including resource usage and validity. | [GET ​/license](https://api.docs.weka.io/#/License/getLicense)      | `weka cluster license`               |
| **Set license:** Install a new cluster license for continued operation.                                                | [POST ​/license](https://api.docs.weka.io/#/License/setLicense)     | `weka cluster license set <license>` |
| **Remove license:** Deactivate the existing license and return the cluster to unlicensed mode.                         | [DELETE ​/license](https://api.docs.weka.io/#/License/resetLicense) | `weka cluster license reset`         |

## Lockout policy

Related information: [account-lockout-threshold-policy-management](../operation-guide/security/account-lockout-threshold-policy-management/ "mention")

| Task                                                                                                        | REST API                                                                                 | CLI                                  |
| ----------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------ |
| **View policy:** See the configured settings for the lockout policy, including attempt limits and duration. | [GET ​/lockoutPolicy](https://api.docs.weka.io/#/Lockout%20policy/getLockoutPolicy)      | `weka security lockout-config show`  |
| **Update policy:** Modify the parameters of the lockout policy to adjust login security.                    | [PUT ​/lockoutPolicy](https://api.docs.weka.io/#/Lockout%20policy/setLockoutPolicy)      | `weka security lockout-config set`   |
| **Reset lockout:** Clear the failed login attempts counter and unlock any currently locked accounts.        | [DELETE ​/lockoutPolicy](https://api.docs.weka.io/#/Lockout%20policy/resetLockoutPolicy) | `weka security lockout-config reset` |

## Login

Related information: [obtain-authentication-tokens.md](../operation-guide/security/obtain-authentication-tokens.md "mention")

| Task                                                                                                                                                                                                                                                  | REST API                                                               | CLI               |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | ----------------- |
| **Log in to the cluster:** Authenticate and grant access to the cluster using valid credentials. Securely save user credentials in the user's home directory upon successful login.                                                                   | [POST ​/login](https://api.docs.weka.io/#/Login/login)                 | `weka user login` |
| **Retrieve access token:** Obtain a new access token using an existing refresh token. The system creates an authentication token file and saves it in `~/.weka/auth-token.json`. The token file contains both the access token and the refresh token. | [POST ​/login​/refresh](https://api.docs.weka.io/#/Login/refreshToken) | `weka user login` |

## Mounts Defaults

Related information:

* [mounting-filesystems](../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")
* [#set-mount-option-default-values](../weka-filesystems-and-object-stores/mounting-filesystems/#set-mount-option-default-values "mention")

| Task                                                                                                                       | REST API                                                                                  | CLI                                 |
| -------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------- |
| **View cluster-wide mount options:** See the configured mount options applied to all filesystems across the cluster.       | [GET ​/mountDefaults](https://api.docs.weka.io/#/Mounts%20Defaults/getMountDefaults)      | `weka cluster mount-defaults show`  |
| **Set cluster-wide mount options:** Configure default options for mounting filesystems across the cluster.                 | [PUT ​/mountDefaults](https://api.docs.weka.io/#/Mounts%20Defaults/setMountDefaults)      | `weka cluster mount-defaults set`   |
| **Reset cluster-wide mount options:** Revert default mount options to initial settings for all filesystems in the cluster. | [DELETE ​/mountDefaults](https://api.docs.weka.io/#/Mounts%20Defaults/resetMountDefaults) | `weka cluster mount-defaults reset` |

## NFS

Related information: [nfs-support](../additional-protocols/nfs-support/ "mention")

| Task                                                                                                                                                                                      | REST API                                                                                                                           | CLI                                                        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **View NFS permissions:** See a list of the existing access controls for client groups accessing filesystems through NFS.                                                                 | [GET ​/nfs​/permissions](https://api.docs.weka.io/#/NFS/getNfsPermissions)                                                         | `weka nfs permission`                                      |
| **Grant NFS permissions:** Assign permissions for a specific client group to access a designated NFS-mounted filesystem.                                                                  | [POST ​/nfs​/permissions](https://api.docs.weka.io/#/NFS/addNfsPermission)                                                         | `weka nfs permission add <fs_name> <client-group-name>`    |
| **View NFS permissions of a specific filesystem:** See existing access controls for client groups accessing a specific filesystem through NFS.                                            | [GET ​/nfs​/permissions​/{uid}](https://api.docs.weka.io/#/NFS/getNfsPermission)                                                   | `weka nfs permission --filesystem <fs_name>`               |
| **Modify NFS permissions:** Update existing access controls for client groups using an NFS-mounted filesystem.                                                                            | [PUT ​/nfs​/permissions​/{uid}](https://api.docs.weka.io/#/NFS/updateNfsPermission)                                                | `weka nfs permission update <fs_name> <client-group-name>` |
| **Revoke access:** Remove permissions for client groups to access a designated NFS-mounted filesystem.                                                                                    | [DELETE ​/nfs​/permissions​/{uid}](https://api.docs.weka.io/#/NFS/deleteNfsPermission)                                             | `weka nfs permission delete <fs_name> <client-group-name>` |
| **View NFS client groups:** See a list of all defined client groups for managing NFS access control.                                                                                      | [GET ​/nfs​/clientGroups](https://api.docs.weka.io/#/NFS/getClientGroups)                                                          | `weka nfs client-group`                                    |
| **Create/add NFS client group:** Establish a new group to manage access controls for NFS mounts.                                                                                          | [POST ​/nfs​/clientGroups](https://api.docs.weka.io/#/NFS/createClientGroup)                                                       | `weka nfs client-group add <group-name>`                   |
| **View a specific NFS client group:** See a specific NFS client group for managing NFS access control.                                                                                    | [GET ​/nfs​/clientGroups​/{uid}](https://api.docs.weka.io/#/NFS/getClientGroup)                                                    | `weka nfs client-group --name <client-group-name>`         |
| **Delete an NFS client group:** Remove an existing NFS client group.                                                                                                                      | [DELETE ​/nfs​/clientGroups​/{uid}](https://api.docs.weka.io/#/NFS/deleteClientGroup)                                              | `weka nfs client-group delete <client-group-name>`         |
| **Add a DNS rule:** Assign a DNS rule to an NFS client group for access control.                                                                                                          | [POST ​/nfs​/clientGroups​/{uid}​/rules](https://api.docs.weka.io/#/NFS/addClientGroupRule)                                        | `weka nfs rules add dns <client-group-name> <dns-rule>`    |
| **Remove a DNS rule:** Delete a DNS rule associated with an NFS client group.                                                                                                             | [DELETE ​/nfs​/clientGroups​/{uid}​/rules​/{rule\_uid}](https://api.docs.weka.io/#/NFS/deleteClientGroupRule)                      | `weka nfs rules delete dns <client-group-name> <dns-rule>` |
| **Configure cluster-wide NFS settings:** Manage global parameters for NFS operations, including the mountd service port, configuration filesystem for NFSv4, and supported NFS versions.  | [PUT ​/nfs​/globalConfig](https://api.docs.weka.io/#/NFS/updateNfsGlobalConfig)                                                    | `weka nfs global-config set`                               |
| **View cluster-wide NFS configuration:** Get the global parameters for NFS operations, including the mountd service port, configuration filesystem for NFSv4, and supported NFS versions. | [GET ​/nfs​/globalConfig](https://api.docs.weka.io/#/NFS/getNfsGlobalConfig)                                                       | `weka nfs global-config show`                              |
| **View logging verbosity:** Check the existing logging level for container processes involved in the NFS cluster.                                                                         | [GET ​/nfs​/debug](https://api.docs.weka.io/#/NFS/getNFSDebugLevel)                                                                | `weka nfs debug-level show`                                |
| **Set logging verbosity:** Adjust the logging level for container processes involved in the NFS cluster.                                                                                  | [POST ​/nfs​/debug](https://api.docs.weka.io/#/NFS/setNFSDebugLevel)                                                               | `weka nfs debug-level set <debug-level>`                   |
| **Integrate NFS and Kerberos service:** This involves setting up secure network communication by defining KDC details, admin credentials, and other parameters for robust authentication. | [PUT​/nfs​/kerberosService](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/setupNfsKerberosService)\*                        | `weka nfs kerberos service setup`                          |
| **View NFS-Kerberos service configuration**                                                                                                                                               | [GET​/nfs​/kerberosService](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/getNfsKerberosService)\*                          | `weka nfs kerberos service show`                           |
| **Register NFS with MIT Kerberos**                                                                                                                                                        | [PUT​/nfs​/kerberosMitRegistration](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/setNfsKerberosRegistration)\*             | `weka nfs kerberos registration setup-mit`                 |
| **Register NFS with AD Kerberos**                                                                                                                                                         | [PUT​/nfs​/kerberosActiveDirectoryRegistration](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/setNfsKerberosRegistration)\* | `weka nfs kerberos registration setup-ad`                  |
| **Get NFS Kerberos registration configuration**                                                                                                                                           | [GET​/nfs​/kerberosRegistration](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/getNfsKerberosRegistration)\*                | `weka nfs kerberos registration show`                      |
| **Reset Kerberos configuration for NFS**                                                                                                                                                  | [PUT​/nfs​/kerberosReset](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/resetNfsKerberosConfiguration)\*                    | `weka nfs kerberos reset`                                  |
| **Set OpenLDAP configuration for NFS:**                                                                                                                                                   | [PUT​/nfs​/openLdapService](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/setNfsLdapConfiguration)\*                        | `weka nfs ldap setup-openldap`                             |
| **Set AD configuration for NFS:**                                                                                                                                                         | [PUT​/nfs​/activeDirectoryLdapService](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/setNfsLdapConfiguration)\*             | `weka nfs ldap setup-ad`                                   |
| **Get LDAP configuration for NFS:**                                                                                                                                                       | [GET​/nfs​/ldapService](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/getNfsLdapService)\*                                  | `weka nfs ldap show`                                       |
| **Reset LDAP configuration for NFS:**                                                                                                                                                     | [PUT​/nfs​/ldapReset](http://datasphere.wekalab.io:14000/api/v2/docs/#/NFS/resetNfsLdapConfiguration)\*                            | `weka nfs ldap reset`                                      |

## Object store

Related information: [managing-object-stores](../weka-filesystems-and-object-stores/managing-object-stores/ "mention")

| Task                                                                                        | REST API                                                                         | CLI                                  |
| ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------------------ |
| **Update object store connection:** Update details for an existing object store connection. | [PUT ​/objectStores​/{uid}](https://api.docs.weka.io/#/Object%20store/updateObs) | `weka fs tier obs update <obs-name>` |

## Object store bucket

Related information: [managing-object-stores](../weka-filesystems-and-object-stores/managing-object-stores/ "mention")

| Task                                                                                                          | REST API                                                                                                           | CLI                                                          |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------ |
| **View S3 configurations:** See a list of connection and status details for all S3 object store buckets.      | [GET ​/objectStoreBuckets](https://api.docs.weka.io/#/Object%20store%20bucket/getAllObsBuckets)                    | `weka fs tier s3`                                            |
| **Create an S3 connection:** Establish a new S3 object store bucket connection.                               | [POST ​/objectStoreBuckets](https://api.docs.weka.io/#/Object%20store%20bucket/createObsBucket)                    | `weka fs tier s3 add <obs-name>`                             |
| **View an S3 connection:** See a list of connection and status details for a specific S3 object store bucket. | [GET ​/objectStoreBuckets​/{uid}](https://api.docs.weka.io/#/Object%20store%20bucket/getObsBuckets)                | `weka fs tier s3 --obs-name <obs-name> --name <bucket-name>` |
| **Delete an S3 connection:** Remove an existing S3 object store connection.                                   | [DELETE ​/objectStoreBuckets​/{uid}](https://api.docs.weka.io/#/Object%20store%20bucket/deleteObsBucket)           | `weka fs tier s3 delete <obs-name>`                          |
| **Update an S3 connection:** Modify an existing S3 object store bucket connection.                            | [PUT ​/objectStoreBuckets​/{uid}](https://api.docs.weka.io/#/Object%20store%20bucket/updateObsBucket)              | `weka fs tier s3 update <bucket-name>`                       |
| **View snapshots:** List and view details about uploaded snapshots within an object store.                    | [GET ​/objectStoreBuckets​/{uid}​/operations](https://api.docs.weka.io/#/Object%20store%20bucket/getObsOperations) | `weka fs tier s3 snapshot list <bucket-name>`                |

## Organization

Related information: [organizations](../operation-guide/organizations/ "mention")

| Task                                                                                             | REST API                                                                                              | CLI                                               |
| ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| **Check for multiple organizations:** Verify if multiple organizations exist within the cluster. | [GET ​/organizations​/multipleOrgsExist](https://api.docs.weka.io/#/Organization/getMultipleOrgExist) | `weka org`                                        |
| **View organizations:** See a list of all organizations defined in the cluster.                  | [GET ​/organizations](https://api.docs.weka.io/#/Organization/getOrganizations)                       | `weka org`                                        |
| **Add organization:** Create a new organization within the cluster.                              | [POST ​/organizations](https://api.docs.weka.io/#/Organization/createOrganization)                    | `weka org create`                                 |
| **View organization details:** See information about an existing organization.                   | [GET ​/organizations​/{uid}](https://api.docs.weka.io/#/Organization/getOrganization)                 | `weka org <org name or ID>`                       |
| **Delete organization:** Remove an organization from the cluster.                                | [DELETE ​/organizations​/{uid}](https://api.docs.weka.io/#/Organization/deleteOrganization)           | `weka org delete <org name or ID>`                |
| **Update organization name:** Change the name of an existing organization.                       | [PUT ​/organizations​/{uid}](https://api.docs.weka.io/#/Organization/updateOrganization)              | `weka org rename <org name or ID> <new-org-name>` |
| **Set organization quotas:** Define SSD and total storage quotas for an organization.            | [PUT ​/organizations​/{uid}​/limits](https://api.docs.weka.io/#/Organization/setOrganizationLimit)    | `weka org set-quota <org name or ID>`             |

## Processes

Related information: [weka-containers-architecture-overview.md](../weka-system-overview/weka-containers-architecture-overview.md "mention")

| Task                                                                                             | REST API                                                                  | CLI                                    |
| ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------- | -------------------------------------- |
| **View all processes' details:** See information about all running processes within the cluster. | [GET ​/processes](https://api.docs.weka.io/#/Processes/getProcesses)      | `weka cluster processes`               |
| **View process details:** See information about a specific process based on its ID.              | [GET ​/processes​/{uid}](https://api.docs.weka.io/#/Processes/getProcess) | `weka cluster processes <process-ids>` |

## S3

Related information: [s3](../additional-protocols/s3/ "mention")

| Task                                                                                               | REST API                                                                                                        | CLI                                                              |
| -------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| **View S3 cluster information:** See details about the S3 cluster managed by WEKA.                 | [GET ​/s3](https://api.docs.weka.io/#/S3/getS3Cluster)                                                          | `weka s3 cluster`                                                |
| **Create an S3 cluster:** Establish a new S3 cluster.                                              | [POST ​/s3](https://api.docs.weka.io/#/S3/createS3Cluster)                                                      | `weka s3 cluster create`                                         |
| **Update an S3 cluster:** Modify the configuration of an existing S3 cluster.                      | [PUT ​/s3](https://api.docs.weka.io/#/S3/updateS3Cluster)                                                       | `weka s3 cluster update`                                         |
| **Delete an S3 cluster:** Remove an S3 cluster.                                                    | [DELETE ​/s3](https://api.docs.weka.io/#/S3/deleteS3Cluster)                                                    | `weka s3 cluster destroy`                                        |
| **View buckets:** See a list of all buckets within an S3 cluster.                                  | [GET ​/s3​/buckets](https://api.docs.weka.io/#/S3/getS3Buckets)                                                 | `weka s3 bucket list`                                            |
| **Create an S3 bucke**t: Establish a new bucket within an S3 cluster.                              | [POST ​/s3​/buckets](https://api.docs.weka.io/#/S3/createS3Bucket)                                              | `weka s3 bucket create`                                          |
| **View S3 user policies:** See a list of S3 user policies.                                         | [GET ​/s3​/userPolicies](https://api.docs.weka.io/#/S3/getuserPolicies)                                         | `weka s3 bucket policy`                                          |
| **Delete an S3 bucket:** Delete a specified S3 bucket.                                             | [DELETE ​/s3​/buckets​/{bucket}](https://api.docs.weka.io/#/S3/destroyS3Bucket)                                 | `weka s3 bucket delete <bucket-name>`                            |
| **View S3 IAM policies:** See a list of S3 IAM policies.                                           | [GET ​/s3​/policies](https://api.docs.weka.io/#/S3/getS3Policies)                                               | `weka s3 policy list`                                            |
| **Add an S3 IAM policy:** Create a new S3 IAM policy.                                              | [POST ​/s3​/policies](https://api.docs.weka.io/#/S3/createS3Policy)                                             | `weka s3 policy add`                                             |
| **View S3 IAM policy details:** See details about a specific S3 IAM policy.                        | [GET ​/s3​/policies​/{policy}](https://api.docs.weka.io/#/S3/getS3Policy)                                       | `weka s3 policy show <policy-name>`                              |
| **Remove an S3 IAM policy:** Delete an S3 IAM policy.                                              | [DELETE ​/s3​/policies​/{policy}](https://api.docs.weka.io/#/S3/deleteS3Policy)                                 | `weka s3 policy remove <policy-name>`                            |
| **Attach an S3 IAM policy to a user:** Assign an S3 IAM policy to a user.                          | [POST ​/s3​/policies​/attach](https://api.docs.weka.io/#/S3/attachS3Policy)                                     | `weka s3 policy attach <policy> <user>‌`                         |
| **Detach an S3 IAM policy from a user:** Remove an S3 IAM policy from a user.                      | [POST ​/s3​/policies​/detach](https://api.docs.weka.io/#/S3/detachS3Policy)                                     | `weka s3 policy detach <user>‌‌`                                 |
| **View service accounts:** See a list of S3 service accounts.                                      | [GET ​/s3​/serviceAccounts](https://api.docs.weka.io/#/S3/getS3ServiceAccounts)                                 | `weka s3 service-account list`                                   |
| **Create an S3 service account:** Establish a new S3 service account.                              | [POST ​/s3​/serviceAccounts](https://api.docs.weka.io/#/S3/createS3ServiceAccount)                              | `weka s3 service-account add <policy-file>`                      |
| **View service account details:** See details about a specific S3 service account.                 | [GET ​/s3​/serviceAccounts​/{access\_key}](https://api.docs.weka.io/#/S3/getServiceAccount)                     | `weka s3 service-account show <access-key>`                      |
| **Delete an S3 service account:** Remove an S3 service account.                                    | [DELETE ​/s3​/serviceAccounts​/{access\_key}](https://api.docs.weka.io/#/S3/deleteS3ServiceAccount)             | `weka s3 service-account remove <access-key>`                    |
| **Create an S3 STS token:** Create an S3 STS token with an assumed role.                           | [POST ​/s3​/sts](https://api.docs.weka.io/#/S3/s3StsCreate)                                                     | `weka s3 sts assume-role`                                        |
| **Add lifecycle rule:** Create a new lifecycle rule for an S3 bucket.                              | [POST ​/s3​/buckets​/{bucket}​/lifecycle​/rules](https://api.docs.weka.io/#/S3/s3CreateLifecycleRule)           | `weka s3 bucket lifecycle-rule add <bucket-name>`                |
| **Reset lifecycle rules:** Reset all lifecycle rules for an S3 bucket to their default settings.   | [DELETE ​/s3​/buckets​/{bucket}​/lifecycle​/rules](https://api.docs.weka.io/#/S3/s3DeleteAllLifecycleRules)     | `weka s3 bucket lifecycle-rule reset <bucket-name>`              |
| **View lifecycle rules:** See a list of all lifecycle rules for an S3 bucket.                      | [GET ​/s3​/buckets​/{bucket}​/lifecycle​/rules](https://api.docs.weka.io/#/S3/s3ListAllLifecycleRules)          | `weka s3 bucket lifecycle-rule list <bucket-name>`               |
| **Delete lifecycle rule:** Remove a lifecycle rule from an S3 bucket.                              | [DELETE ​/s3​/buckets​/{bucket}​/lifecycle​/rules​/{rule}](https://api.docs.weka.io/#/S3/s3DeleteLifecycleRule) | `weka s3 bucket lifecycle-rule remove <bucket-name> <rule-name>` |
| **View S3 bucket policy:** See the policy attached to an S3 bucket.                                | [GET ​/s3​/buckets​/{bucket}​/policy](https://api.docs.weka.io/#/S3/getS3BucketPolicy)                          | `weka s3 bucket policy get <bucket-name>`                        |
| **Set S3 bucket policy:** Assign a policy to an S3 bucket.                                         | [PUT ​/s3​/buckets​/{bucket}​/policy](https://api.docs.weka.io/#/S3/setS3BucketPolicy)                          | `weka s3 bucket policy set <bucket-name> <bucket-policy>`        |
| **View S3 bucket policy (JSON):** See the bucket policy in JSON format.                            | [GET ​/s3​/buckets​/{bucket}​/policyJson](https://api.docs.weka.io/#/S3/getS3BucketPolicyJson)                  | `weka s3 bucket policy get-json <bucket-name>`                   |
| **Set S3 bucket policy (JSON):** Set the bucket policy using a JSON file.                          | [PUT ​/s3​/buckets​/{bucket}​/policyJson](https://api.docs.weka.io/#/S3/setS3BucketPolicyJson)                  | `weka s3 bucket policy set-custom <bucket-name> <policy-file>`   |
| **Set S3 bucket quota:** Define a storage quota for an S3 bucket.                                  | [PUT ​/s3​/buckets​/{bucket}​/quota](https://api.docs.weka.io/#/S3/setS3BucketQuota)                            | `weka s3 bucket quota set <bucket-name> <hard-quota>`            |
| **Unset S3 bucket quota:** Remove a storage quota from an S3 bucket.                               | [DELETE ​/s3​/buckets​/{bucket}​/quota](https://api.docs.weka.io/#/S3/unsetS3BucketQuota)                       | `weka s3 bucket quota unset <bucket-name>`                       |
| **View container readiness:** Check the readiness status of containers within the S3 cluster.      | [GET ​/s3​/containersAreReady](https://api.docs.weka.io/#/S3/gets3ContainersAreReady)                           | `weka s3 cluster status`                                         |
| **Add container to S3 cluster:** Add a container to the S3 cluster.                                | [POST ​/s3​/containers](https://api.docs.weka.io/#/S3/addS3Containers)                                          | `weka s3 cluster containers add <container-ids>`                 |
| **Remove containers:** Remove containers from the S3 cluster.                                      | [DELETE ​/s3​/containers](https://api.docs.weka.io/#/S3/deleteS3Containers)                                     | `weka s3 cluster containers remove <container-ids>`              |
| **View logging verbosity:** See the logging level for container processes within the S3 cluster.   | [GET ​/s3​/debug](https://api.docs.weka.io/#/S3/gets3DebugLevel)                                                | `weka s3 log-level get`                                          |
| **Set logging verbosity:** Adjust the logging level for container processes within the S3 cluster. | [POST ​/s3​/debug](https://api.docs.weka.io/#/S3/sets3DebugLevel)                                               | `weka s3 log-level set <log-level>`                              |
| **Enable S3 audit webhook:** Activate the S3 audit webhook.                                        | [POST ​/s3​/auditWebhook​/enable](https://api.docs.weka.io/#/S3/enableS3AuditWebhook)                           | `weka s3 cluster audit-webhook enable`                           |
| **Disable S3 audit webhook:** Deactivate the S3 audit webhook.                                     | [POST ​/s3​/auditWebhook​/disable](https://api.docs.weka.io/#/S3/disableS3AuditWebhook)                         | `weka s3 cluster audit-webhook disable`                          |
| **View S3 audit webhook configuration:** See details about the S3 audit webhook configuration.     | [GET ​/s3​/auditWebhook](https://api.docs.weka.io/#/S3/getS3AuditWebhook)                                       | `weka s3 cluster audit-webhook show`                             |

## SMB

Related information: [smb-support](../additional-protocols/smb-support/ "mention")

| Task                                                                                                                      | REST API                                                                                                  | CLI                                                                       |
| ------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| **View SMB cluster configuration:** See details about the existing SMB cluster configuration.                             | [GET ​/smb](https://api.docs.weka.io/#/SMB/getSamba)                                                      | `weka smb cluster`                                                        |
| **Create SMB cluster:** Establish a new SMB cluster managed by WEKA.                                                      | [POST ​/smb](https://api.docs.weka.io/#/SMB/setSamba)                                                     | `weka smb cluster create <netbios-name> <domain> <config-fs-name>`        |
| **Update SMB cluster configuration:** Modify the existing configuration of an SMB cluster.                                | [PUT ​/smb](https://api.docs.weka.io/#/SMB/updateSamba)                                                   | `weka smb cluster update`                                                 |
| **Remove SMB cluster configuration:** Disable SMB access to data without affecting the data itself.                       | [DELETE ​/smb](https://api.docs.weka.io/#/SMB/clearSamba)                                                 | `weka smb cluster destroy`                                                |
| **View trusted domains (SMB):** See a list of trusted domains recognized by the SMB cluster (not yet supported on SMB-W). | [GET ​/smb​/domains](https://api.docs.weka.io/#/SMB/setSambaDomains)                                      | `weka smb cluster trusted-domains`                                        |
| **Add trusted domain (SMB):** Add a new trusted domain to the SMB cluster (not yet supported on SMB-W).                   | [POST ​/smb​/domains](https://api.docs.weka.io/#/SMB/addSambaDomain)                                      | `weka smb cluster trusted-domains add`                                    |
| **View SMB mount options:** See a list of mount options used by the existing SMB cluster.                                 | [GET ​/smb​/mount](https://api.docs.weka.io/#/SMB/setSambaMountOptions)                                   | N/A                                                                       |
| **View SMB shares:** See a list of all shares available within the SMB cluster.                                           | [GET ​/smb​/shares](https://api.docs.weka.io/#/SMB/setSambaShares)                                        | `weka smb share`                                                          |
| **Add SMB share:** Create a new share within the SMB cluster.                                                             | [POST ​/smb​/shares](https://api.docs.weka.io/#/SMB/addShareToSamba)                                      | `weka smb share add <share-name> <fs-name>`                               |
| **Join Active Directory:** Integrate the SMB cluster with an Active Directory domain.                                     | [POST ​/smb​/activeDirectory](https://api.docs.weka.io/#/SMB/setSambaActiveDirectory)                     | `weka smb domain join <username> <password>`                              |
| **Leave Active Directory:** Disconnect the SMB cluster from the Active Directory domain.                                  | [PUT ​/smb​/activeDirectory](https://api.docs.weka.io/#/SMB/deleteSambaActiveDirectory)                   | `weka smb domain leave <username>`                                        |
| **Set SMB container logging verbosity:** Adjust the logging level for container processes in the SMB cluster.             | [POST ​/smb​/debug](https://api.docs.weka.io/#/SMB/setSambaDebug)                                         | `weka smb cluster debug <level>`                                          |
| **Update SMB share:** Modify the configuration of an existing SMB share.                                                  | [PUT ​/smb​/shares​/{uid}](https://api.docs.weka.io/#/SMB/updateSambaShare)                               | `weka smb share update <share-id>`                                        |
| **Delete SMB share:** Remove an SMB share from the cluster.                                                               | [DELETE ​/smb​/shares​/{uid}](https://api.docs.weka.io/#/SMB/deleteSambaShare)                            | `weka smb share remove <share-id>`                                        |
| **Remove trusted domain (SMB):** Remove a trusted domain from the SMB cluster.                                            | [DELETE ​/smb​/domains​/{uid}](https://api.docs.weka.io/#/SMB/deleteSambaDomain)                          | `weka smb cluster trusted-domains remove`                                 |
| **Add SMB share users:** Add users associated with a specific SMB share.                                                  | [POST ​/smb​/users​/{share\_uid}​/{user\_type}](https://api.docs.weka.io/#/SMB/addUserToSamba)            | `weka smb share lists add <share-id> <user-list-type> --users <users>`    |
| **Remove SMB share users:** Remove users associated with a specific SMB share.                                            | [DELETE ​/smb​/users​/reset​/{share\_uid}​/{user\_type}](https://api.docs.weka.io/#/SMB/resetSambaUsers)  | `weka smb share lists reset <share-id> <user-list-type>`                  |
| **Remove specific SMB share users:** Remove specific users associated with a specific SMB share.                          | [DELETE ​/smb​/users​/{share\_uid}​/{user\_type}​/{user}](https://api.docs.weka.io/#/SMB/deleteSambaUser) | `weka smb share lists remove <share-id> <user-list-type> --users <users>` |
| **View SMB container status:** Check the status of containers participating in the SMB cluster.                           | [GET ​/smb​/containersAreReady](https://api.docs.weka.io/#/SMB/getSambaContainersAreReady)                | `weka smb cluster status`                                                 |
| **Add SMB cluster containers:** Add containers to the SMB cluster.                                                        | [PUT ​/smb​/servers](https://api.docs.weka.io/#/SMB/addSambaServers)                                      | `weka smb cluster containers add --containers-id <containers-id>`         |
| **Remove SMB cluster containers:** Remove containers from the SMB cluster.                                                | [DELETE ​/smb​/servers](https://api.docs.weka.io/#/SMB/deleteSambaServers)                                | `weka smb cluster containers remove --containers-id <containers-id>`      |

## Security

Related information: [security](../operation-guide/security/ "mention")

| Task                                                                                                                                                                  | REST API                                                                                   | CLI                                             |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | ----------------------------------------------- |
| **View token expiry:** See the default expiry time for tokens.                                                                                                        | [GET ​/security​/defaultTokensExpiry](https://api.docs.weka.io/#/Security/getTokensExpiry) | N/A                                             |
| **View login banner:** See the existing login banner displayed on the sign-in page.                                                                                   | [GET ​/security​/banner](https://api.docs.weka.io/#/Security/getLoginBanner)               | `weka security login-banner show`               |
| **Set login banner:** Create or modify the login banner containing a security statement or legal message.                                                             | [PUT ​/security​/banner](https://api.docs.weka.io/#/Security/setLoginBanner)               | `weka security login-banner set <login-banner>` |
| **Show login banner:** Show the login banner on the sign-in page.                                                                                                     | [POST ​/security​/banner​/enable](https://api.docs.weka.io/#/Security/enableLoginBanner)   | `weka security login-banner enable`             |
| **Hide login banner:** Hide the login banner from the sign-in page.                                                                                                   | [POST ​/security​/banner​/disable](https://api.docs.weka.io/#/Security/disableLoginBanner) | `weka security login-banner disable`            |
| **Add or update custom CA certificate:** Upload a custom CA certificate to be used for authentication. If a certificate is already present, this command replaces it. | [PUT ​/security​/caCert](https://api.docs.weka.io/#/Security/setCaCert)                    | `weka security ca-cert set`                     |
| **Delete custom CA certificate:** Remove the currently configured custom CA certificate from the cluster.                                                             | [DELETE ​/security​/caCert](https://api.docs.weka.io/#/Security/unsetCaCert)               | `weka security ca-cert unset`                   |
| **View cluster CA certificate:** See the status and details of the cluster's CA certificate.                                                                          | [GET ​/security​/caCert](https://api.docs.weka.io/#/Security/showCaCert)                   | `weka security ca-cert status`                  |

## Servers

Related information: [expanding-and-shrinking-cluster-resources](../operation-guide/expanding-and-shrinking-cluster-resources/ "mention")

| Task                                                                                           | REST API                                                                   | CLI                         |
| ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | --------------------------- |
| **View cluster servers:** See a list of all servers within the cluster.                        | [GET ​/servers](https://api.docs.weka.io/#/Servers/getServers)             | `weka cluster servers list` |
| **View server details:** See specific information about an individual server based on its UID. | [GET ​/servers​/{uid}](https://api.docs.weka.io/#/Servers/getSingleServer) | `weka cluster servers show` |

## Snapshots

Related information:

* [snapshots](../weka-filesystems-and-object-stores/snapshots/ "mention")
* [snap-to-obj](../weka-filesystems-and-object-stores/snap-to-obj/ "mention")

| Task                                                                                            | REST API                                                                                                          | CLI                                                                    |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| **View snapshots:** See a list of all snapshots currently available.                            | [GET ​/snapshots](https://api.docs.weka.io/#/Snapshots/getSnapshots)                                              | `weka fs snapshot`                                                     |
| **Create snapshot:** Establish a new snapshot of a filesystem.                                  | [POST ​/snapshots](https://api.docs.weka.io/#/Snapshots/createSnapshot)                                           | `weka fs snapshot create <file-system> <snapshot-name>`                |
| **View snapshot details:** See specific information about an existing snapshot.                 | [GET ​/snapshots​/{uid}](https://api.docs.weka.io/#/Snapshots/getSnapshot)                                        | `weka fs snapshot --name <snapshot-name>`                              |
| **Update snapshot:** Modify the configuration of an existing snapshot.                          | [PUT ​/snapshots​/{uid}](https://api.docs.weka.io/#/Snapshots/updateSnapshot)                                     | `weka fs snapshot update <file-system> <snapshot-name>`                |
| **Delete snapshot:** Remove a snapshot from the system.                                         | [DELETE ​/snapshots​/{uid}](https://api.docs.weka.io/#/Snapshots/deleteSnapshot)                                  | `weka fs snapshot delete <file-system> <snapshot-name>`                |
| **Copy snapshot:** Copy a snapshot from the same filesystem to a different location.            | [POST ​/snapshots​/{uid}​/copy](https://api.docs.weka.io/#/Snapshots/copySnapshot)                                | `weka fs snapshot copy <file-system> <source-name> <destination-name>` |
| **Upload snapshot to object store:** Transfer a snapshot to an object storage.                  | [POST ​/snapshots​/{uid}​/upload](https://api.docs.weka.io/#/Snapshots/uploadSnapshot)                            | `weka fs snapshot upload <file-system> <snapshot-name>`                |
| **Download snapshot:** Download a snapshot from an object storage system.                       | [POST ​/snapshots​/download](https://api.docs.weka.io/#/Snapshots/downloadSnapshot)                               | `weka fs snapshot download`                                            |
| **Restore filesystem from snapshot**: Restore a filesystem using a previously created snapshot. | [POST ​/snapshots​/{fs\_uid}​/{uid}​/restore](https://api.docs.weka.io/#/Snapshots/restoreFileSystemFromSnapshot) | `weka fs snapshot download <file-system> <snapshot-locator>`           |

## Stats

Related information: [statistics](../operation-guide/statistics/ "mention")

| Task                                                                                                                    | REST API                                                                         | CLI                                             |
| ----------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ----------------------------------------------- |
| **View stats:** See a list of various statistics related to the cluster's performance and resource usage.               | [GET ​/stats](https://api.docs.weka.io/#/Stats/getStats)                         | `weka stats`                                    |
| **View stats description:** Get detailed explanations of the available statistics.                                      | [GET ​/stats​/description](https://api.docs.weka.io/#/Stats/getStatsDescription) | `weka stats list-types`                         |
| **View real-time stats:** Monitor live statistics for the cluster.                                                      | [GET ​/stats​/realtime](https://api.docs.weka.io/#/Stats/getRealTimeStats)       | `weka stats realtime`                           |
| **View stats retention and disk usage:** See how long statistics are retained and estimate disk space used for storage. | [GET ​/stats​/retention](https://api.docs.weka.io/#/Stats/getStatsDiskUsage)     | `weka stats retention status`                   |
| **Set stats retention:** Define the duration for which statistics are stored.                                           | [POST ​/stats​/retention](https://api.docs.weka.io/#/Stats/getStatsRetention)    | `weka stats retention set --days <num-of-days>` |

## System IO

Related information: [perform-post-configuration-procedures.md](../planning-and-installation/bare-metal/perform-post-configuration-procedures.md "mention")

| Task                                                                | REST API                                                           | CLI                     |
| ------------------------------------------------------------------- | ------------------------------------------------------------------ | ----------------------- |
| **Start cluster IO services:** Enable the cluster-wide IO services. | [POST ​/io​/start](https://api.docs.weka.io/#/System%20IO/startIO) | `weka cluster start-io` |
| **Stop cluster IO services:** Disable the cluster-wide IO services. | [POST ​/io​/stop](https://api.docs.weka.io/#/System%20IO/stopIO)   | `weka cluster stop-io`  |

## Tasks

Related information: [background-tasks](../operation-guide/background-tasks/ "mention")

| Task                                                                                                                                                                                                                             | REST API                                                                   | CLI                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------------ |
| **View background tasks:** See a list of all currently running background tasks within the cluster.                                                                                                                              | [GET ​/tasks](https://api.docs.weka.io/#/Tasks/getTasks)                   | `weka cluster task‌`                 |
| **Resume a background task:** Re-initiate a paused background task, allowing execution to continue.                                                                                                                              | [POST ​/tasks​/{uid}​/resume](https://api.docs.weka.io/#/Tasks/resumeTask) | `weka cluster task resume <task-id>` |
| **Pause a background task:** Temporarily halt the execution of a running background task. The task can be resumed later.                                                                                                         | [POST ​/tasks​/{uid}​/pause](https://api.docs.weka.io/#/Tasks/pauseTasks)  | `weka cluster task pause <task-id>`  |
| **Abort a background task:** Terminate a running background task, permanently stopping its execution. Any unfinished work associated with the task will be discarded.                                                            | [POST ​/tasks​/{uid}​/abort](https://api.docs.weka.io/#/Tasks/abortTasks)  | `weka cluster task abort <task-id>`  |
| **View background task limits:** See the existing limitations on the number of background tasks running concurrently within the system. This information helps you understand the capacity for handling background processes.    | [GET ​/tasks​/limits](https://api.docs.weka.io/#/Tasks/getTasksLimit)      | `weka cluster task limits`           |
| **Set background task limits:** Adjust the maximum number of background tasks allowed to run simultaneously. This allows you to control the system's resource allocation and potential performance impact from concurrent tasks. | [PUT ​/tasks​/limits](https://api.docs.weka.io/#/Tasks/setTasksLimit)      | `weka cluster task limits set`       |

## TLS

Related information: [tls-certificate-management](../operation-guide/security/tls-certificate-management/ "mention")

| Task                                                                                                   | REST API                                                                   | CLI                          |
| ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------- | ---------------------------- |
| **View cluster TLS status:** Check the status and details of the cluster's TLS certificate.            | [GET ​/tls](https://api.docs.weka.io/#/TLS/getTls)                         | `weka security tls status`   |
| **Configure Nginx with TLS:** Enable TLS for the UI and set or update the private key and certificate. | [POST ​/tls](https://api.docs.weka.io/#/TLS/enableTls)                     | `weka security tls set`      |
| **Configure Nginx without TLS:** Disable TLS for the UI.                                               | [DELETE ​/tls](https://api.docs.weka.io/#/TLS/disableTls)                  | `weka security tls unset`    |
| **Download TLS certificate:** Download the cluster's TLS certificate.                                  | [GET ​/tls​/certificate](https://api.docs.weka.io/#/TLS/getTlsCertificate) | `weka security tls download` |

## Traces

Related information: [traces-management](../support/diagnostics-management/traces-management/ "mention")

| Task                                                                                                                                                                                                   | REST API                                                                       | CLI                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | -------------------------------- |
| **View traces configuration:** See the current configuration settings for trace collection.                                                                                                            | [GET ​/traces](https://api.docs.weka.io/#/Traces/getTracesStatus)              | `weka debug traces status`       |
| **Start trace collection:** Initiate the collection of trace data.                                                                                                                                     | [PUT ​/traces](https://api.docs.weka.io/#/Traces/updateTracesConfigure)        | `weka debug traces start`        |
| **Stop trace collection**: Stop the collection of trace data.                                                                                                                                          | [DELETE ​/traces](https://api.docs.weka.io/#/Traces/restoreTracesDefaults)     | `weka debug traces stop`         |
| **View trace freeze period:** See the duration for which trace data is preserved for investigation.                                                                                                    | [GET ​/traces​/freeze](https://api.docs.weka.io/#/Traces/getTracesFreeze)      | `weka debug traces freeze show`  |
| **Set trace freeze period:** Set the duration for which trace data is preserved for investigation.                                                                                                     | [PUT ​/traces​/freeze](https://api.docs.weka.io/#/Traces/updateTracesFreeze)   | `weka debug traces freeze set`   |
| **Clear frozen traces:** Remove all existing frozen traces and reset the freeze period to zero.                                                                                                        | [DELETE ​/traces​/freeze](https://api.docs.weka.io/#/Traces/resetTracesFreeze) | `weka debug traces freeze reset` |
| **Set trace verbosity level:** Modify the level of detail captured in trace logs. Low captures essential information for basic troubleshooting. High captures extensive details for in-depth analysis. | [PUT ​/traces​/level](https://api.docs.weka.io/#/Traces/updateTracesLevel)     | `weka debug traces level set`    |

## User

Related information: [user-management](../operation-guide/user-management/ "mention")

| Task                                                                                                                                                                                                                 | REST API                                                                        | CLI                                          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | -------------------------------------------- |
| **View local users:** See a list of all local users on the system.                                                                                                                                                   | [GET ​/users](https://api.docs.weka.io/#/User/getUsers)                         | `weka user`                                  |
| **Create a local user:** Add a new local user account.                                                                                                                                                               | [POST ​/users](https://api.docs.weka.io/#/User/createUser)                      | `weka user add <username> <role> <password>` |
| **Update a local user:** Modify the details of an existing local user.                                                                                                                                               | [PUT ​/users​/{uid}](https://api.docs.weka.io/#/User/updateUser)                | `weka user update <username>`                |
| **Delete a local user:** Remove a local user account from the system.                                                                                                                                                | [DELETE ​/users​/{uid}](https://api.docs.weka.io/#/User/deleteUser)             | `weka user delete <username>`                |
| **Set a local user password:** Assign a password to a local user.                                                                                                                                                    | [PUT ​/users​/password](https://api.docs.weka.io/#/User/updateUserPassword)     | `weka user passwd`                           |
| **Update a local user password:** For any user, change your own password or the password of another user if you have the necessary permissions. For admins, change the password of any user within the organization. | [PUT ​/users​/{uid}​/password](https://api.docs.weka.io/#/User/setUserPassword) | `weka user passwd <username>`                |
| **View the logged-in user:** Get information about the currently logged-in user.                                                                                                                                     | [GET ​/users​/whoami](https://api.docs.weka.io/#/User/whoAmI)                   | `weka user whoami`                           |
| **Invalidate user sessions:** Immediately terminate all active login sessions associated with a specific internal user. This action prevents further access to the system using those tokens.                        | [DELETE ​/users​/{uid}​/revoke](https://api.docs.weka.io/#/User/revokeUser)     | `weka user revoke-tokens`                    |

**Related information**

[REST API Reference Guide](https://api.docs.weka.io/)
