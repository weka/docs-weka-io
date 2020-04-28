# Table of contents

* [Weka Documentation](README.md)

## Weka System Overview <a id="overview"></a>

* [About the Weka System](overview/about.md)
* [SSD Capacity Management](overview/ssd-capacity-management.md)
* [Filesystems, Object Stores & Filesystem Groups](overview/filesystems.md)
* [Weka Networking](overview/networking-in-wekaio.md)
* [Data Lifecycle Management](overview/data-storage.md)
* [Weka Client & Mount Modes](overview/weka-client-and-mount-modes.md)
* [Glossary](overview/glossary.md)

## Planning & Installation <a id="install"></a>

* [Bare Metal Installation](install/bare-metal/README.md)
  * [Planning a Weka System Installation](install/bare-metal/planning-a-weka-system-installation.md)
  * [Prerequisites for Installation](install/bare-metal/prerequisites-for-installation-of-weka-dedicated-hosts.md)
  * [Setting Up the Hosts](install/bare-metal/setting-up-the-hosts/README.md)
    * [SR-IOV Enablement](install/bare-metal/setting-up-the-hosts/sr-iov-enablement.md)
  * [Obtaining the Weka Install File](install/bare-metal/obtaining-the-weka-install-file.md)
  * [Weka System Installation Process Using the CLI](install/bare-metal/using-cli.md)
  * [Adding Clients](install/bare-metal/adding-clients-bare-metal.md)
* [AWS Installation](install/aws/README.md)
  * [Self-Service Portal](install/aws/self-service-portal.md)
  * [CloudFormation Template Generator](install/aws/cloudformation.md)
  * [Deployment Types](install/aws/deployment-types.md)
  * [Supported EC2 Instance Types](install/aws/supported-ec2-instance-types.md)
  * [Adding Clients](install/aws/adding-clients.md)
  * [Troubleshooting](install/aws/troubleshooting.md)

## Getting Started with Weka

* [Managing the Weka System](getting-started-with-weka/managing-wekaio-system.md)
* [CLI Overview](getting-started-with-weka/cli-overview.md)
* [GUI Overview](getting-started-with-weka/gui.md)
* [Serving IOs with WekaFS](getting-started-with-weka/performing-the-first-io.md)

## Performance <a id="testing-and-troubleshooting"></a>

* [Testing Weka Performance](testing-and-troubleshooting/testing-weka-system-performance.md)

## WekaFS Filesystems <a id="fs"></a>

* [Managing Filesystems, Object Stores & Filesystem Groups](fs/managing-filesystems/README.md)
  * [Managing Object Stores](fs/managing-filesystems/managing-object-stores.md)
  * [Managing Filesystem Groups](fs/managing-filesystems/managing-filesystem-groups.md)
  * [Managing Filesystems](fs/managing-filesystems/managing-filesystems.md)
  * [Attaching/Detaching Object Stores to/from Filesystems](fs/managing-filesystems/attaching-detaching-object-stores-to-from-filesystems.md)
  * [KMS Management](fs/managing-filesystems/kms-management.md)
* [Advanced Data Lifecycle Management](fs/tiering/README.md)
  * [Advanced Time-based Policies for Data Storage Location](fs/tiering/advanced-time-based-policies-for-data-storage-location.md)
  * [Data Management in Tiered Filesystems](fs/tiering/data-management-in-tiered-filesystems.md)
  * [Transition Between Tiered and SSD-Only Filesystems](fs/tiering/transition-between-tiered-and-ssd-only-filesystems.md)
  * [Pre-Fetching from Object Store](fs/tiering/pre-fetching-from-object-store.md)
* [Mounting Filesystems](fs/mounting-filesystems.md)
* [Snapshots](fs/snapshots.md)
* [Snap-To-Object](fs/snap-to-obj.md)

## Additional Protocols

* [NFS Support](additional-protocols/nfs-support.md)
* [SMB Support](additional-protocols/smb-support/README.md)
  * [SMB Management Using CLIs](additional-protocols/smb-support/smb-management-using-the-cli.md)
  * [SMB Management Using the GUI](additional-protocols/smb-support/smb-management-using-the-gui.md)

## Operation Guide <a id="usage"></a>

* [Alerts](usage/alerts/README.md)
  * [List of Alerts](usage/alerts/list-of-alerts.md)
* [Events](usage/events/README.md)
  * [List of Events](usage/events/list-of-events.md)
* [Statistics](usage/statistics/README.md)
  * [List of Statistics](usage/statistics/list-of-statistics.md)
* [System Congestion](usage/system-congestion.md)
* [User Management](usage/user-management.md)
* [Organizations](usage/organizations.md)
* [Expanding & Shrinking Cluster Resources](usage/expanding-and-shrinking-cluster-resources/README.md)
  * [Expand & Shrink Overview](usage/expanding-and-shrinking-cluster-resources/expand-and-shrink-overview.md)
  * [Stages in Adding a Backend Host](usage/expanding-and-shrinking-cluster-resources/stages-in-adding-a-backend-host.md)
  * [Expansion of Specific Resources](usage/expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md)
  * [Shrinking a Cluster](usage/expanding-and-shrinking-cluster-resources/shrinking-a-cluster.md)
* [Background Tasks](usage/background-tasks.md)
* [Upgrading Weka Versions](usage/upgrading-weka-versions.md)

## Billing & Licensing <a id="licensing"></a>

* [Overview](licensing/overview.md)
* [Classic License](licensing/classic-licensing.md)
* [Pay-As-You-Go License](licensing/pay-as-you-go.md)

## Support

* [Getting Support for Your Weka System](support/getting-support-for-your-weka-system.md)
* [The Weka Support Cloud](support/the-wekaio-support-cloud.md)
* [Diagnostics CLI Command](support/diagnostics-utility.md)

