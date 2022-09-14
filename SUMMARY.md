# Table of contents

* [Weka documentation](README.md)

## Weka System Overview <a href="#overview" id="overview"></a>

* [About the Weka system](overview/about.md)
* [SSD capacity management](overview/ssd-capacity-management.md)
* [Filesystems, object stores, and filesystem groups](overview/filesystems.md)
* [Weka networking](overview/networking-in-wekaio.md)
* [Data lifecycle management](overview/data-storage.md)
* [Weka client and mount modes](overview/weka-client-and-mount-modes.md)
* [Glossary](overview/glossary.md)

## Getting Started with Weka

* [Quick installation guide](getting-started-with-weka/quick-install-guide.md)
* [Manage the system using the Weka CLI](getting-started-with-weka/manage-the-system-using-weka-cli.md)
* [Manage the system using the Weka GUI](getting-started-with-weka/manage-the-system-using-weka-gui.md)
* [Run first IOs with WekaFS](getting-started-with-weka/performing-the-first-io.md)
* [Getting started with Weka REST API](getting-started-with-weka/getting-started-with-weka-rest-api.md)

## Planning & Installation <a href="#install" id="install"></a>

* [Prerequisites for installation](install/prerequisites-for-installation-of-weka-dedicated-hosts.md)
* [Weka installation on bare metal](install/bare-metal/README.md)
  * [Planning a Weka System Installation](install/bare-metal/planning-a-weka-system-installation.md)
  * [Prepare the system for Weka installation](install/bare-metal/setting-up-the-hosts/README.md)
    * [SR-IOV enablement](install/bare-metal/setting-up-the-hosts/sr-iov-enablement.md)
  * [Obtain the Weka software installation package](install/bare-metal/obtaining-the-weka-install-file.md)
  * [Weka system installation process using the CLI](install/bare-metal/using-cli.md)
  * [Add clients](install/bare-metal/adding-clients-bare-metal.md)
* [Weka installation on AWS](install/aws/README.md)
  * [Self-service portal](install/aws/self-service-portal.md)
  * [CloudFormation template generator](install/aws/cloudformation.md)
  * [Deployment types](install/aws/deployment-types.md)
  * [AWS outposts deployment](install/aws/aws-outposts-deployment.md)
  * [Supported EC2 instance types](install/aws/supported-ec2-instance-types.md)
  * [Add clients](install/aws/adding-clients.md)
  * [Auto scaling group](install/aws/auto-scaling-group.md)
  * [Troubleshooting](install/aws/troubleshooting.md)

## Performance <a href="#testing-and-troubleshooting" id="testing-and-troubleshooting"></a>

* [Weka performance tests](testing-and-troubleshooting/testing-weka-system-performance/README.md)
  * [Test environment details](testing-and-troubleshooting/testing-weka-system-performance/test-environment-details.md)

## WekaFS Filesystems & Object Stores <a href="#fs" id="fs"></a>

* [Manage object stores](fs/managing-object-stores/README.md)
  * [Manage object stores using the GUI](fs/managing-object-stores/managing-object-stores.md)
  * [Manage object stores using the CLI](fs/managing-object-stores/managing-object-stores-1.md)
* [Manage filesystem groups](fs/managing-filesystem-groups/README.md)
  * [Manage filesystem groups using the GUI](fs/managing-filesystem-groups/managing-filesystem-groups.md)
  * [Manage filesystem groups using the CLI](fs/managing-filesystem-groups/manage-filesystem-groups-using-the-cli.md)
* [Manage filesystems](fs/managing-filesystems/README.md)
  * [Manage filesystems using the GUI](fs/managing-filesystems/managing-filesystems.md)
  * [Manage filesystems using the CLI](fs/managing-filesystems/managing-filesystems-1.md)
* [Attach or detach object store buckets](fs/attaching-detaching-object-stores-to-from-filesystems/README.md)
  * [Attach or detach object store bucket using the GUI](fs/attaching-detaching-object-stores-to-from-filesystems/attaching-detaching-object-stores-to-from-filesystems.md)
  * [Attach or detach object store buckets using the CLI](fs/attaching-detaching-object-stores-to-from-filesystems/attaching-detaching-object-stores-to-from-filesystems-1.md)
* [Advanced data lifecycle management](fs/tiering/README.md)
  * [Advanced time-based policies for data storage location](fs/tiering/advanced-time-based-policies-for-data-storage-location.md)
  * [Data management in tiered filesystems](fs/tiering/data-management-in-tiered-filesystems.md)
  * [Transition between tiered and SSD-only filesystems](fs/tiering/transition-between-tiered-and-ssd-only-filesystems.md)
  * [Manual fetch and release of data](fs/tiering/pre-fetching-from-object-store.md)
* [Mount filesystems](fs/mounting-filesystems.md)
* [Snapshots](fs/snapshots/README.md)
  * [Manage snapshots using the GUI](fs/snapshots/snapshots.md)
  * [Manage snapshots using the CLI](fs/snapshots/snapshots-1.md)
* [Snap-To-Object](fs/snap-to-obj/README.md)
  * [Manage Snap-To-Object using the GUI](fs/snap-to-obj/snap-to-obj.md)
  * [Manage Snap-To-Object using the CLI](fs/snap-to-obj/snap-to-obj-1.md)
* [Quota management](fs/quota-management.md)

## Additional Protocols

* [NFS](additional-protocols/nfs-support/README.md)
  * [Manage NFS networking using the GUI](additional-protocols/nfs-support/nfs-support.md)
  * [Manage NFS networking using the CLI](additional-protocols/nfs-support/nfs-support-1.md)
* [SMB](additional-protocols/smb-support/README.md)
  * [Manage SMB using the GUI](additional-protocols/smb-support/smb-management-using-the-gui.md)
  * [Manage SMB using the CLI](additional-protocols/smb-support/smb-management-using-the-cli.md)
* [S3](additional-protocols/s3/README.md)
  * [S3 cluster management](additional-protocols/s3/s3-cluster-management/README.md)
    * [Manage the S3 service using the GUI](additional-protocols/s3/s3-cluster-management/s3-cluster-management.md)
    * [Manage the S3 service using the CLI](additional-protocols/s3/s3-cluster-management/s3-cluster-management-1.md)
  * [S3 buckets management](additional-protocols/s3/s3-buckets-management/README.md)
    * [Manage S3 buckets using the GUI](additional-protocols/s3/s3-buckets-management/s3-buckets-management.md)
    * [Manage S3 buckets using the CLI](additional-protocols/s3/s3-buckets-management/s3-buckets-management-1.md)
  * [S3 users and authentication](additional-protocols/s3/s3-users-and-authentication/README.md)
    * [Manage S3 users and authentication using the CLI](additional-protocols/s3/s3-users-and-authentication/s3-users-and-authentication.md)
    * [Manage S3 service accounts using the CLI](additional-protocols/s3/s3-users-and-authentication/s3-users-and-authentication-1.md)
  * [S3 rules information lifecycle management (ILM)](additional-protocols/s3/s3-information-lifecycle-management/README.md)
    * [Manage S3 rules using the CLI](additional-protocols/s3/s3-information-lifecycle-management/s3-information-lifecycle-management.md)
  * [Audit S3 APIs](additional-protocols/s3/audit-s3-apis/README.md)
    * [Manage S3 audit in Weka using the CLI](additional-protocols/s3/audit-s3-apis/audit-s3-apis.md)
    * [Example: How to use Splunk to audit S3](additional-protocols/s3/audit-s3-apis/audit-s3-apis-1.md)
  * [S3 supported APIs and limitations](additional-protocols/s3/s3-limitations.md)
  * [S3 examples using boto3](additional-protocols/s3/s3-examples-using-boto3.md)

## Operation Guide <a href="#usage" id="usage"></a>

* [Alerts](usage/alerts/README.md)
  * [Manage alerts using the GUI](usage/alerts/alerts.md)
  * [Manage alerts using the CLI](usage/alerts/alerts-1.md)
  * [List of alerts and corrective actions](usage/alerts/list-of-alerts.md)
* [Events](usage/events/README.md)
  * [Manage events using the GUI](usage/events/events.md)
  * [Manage events using the CLI](usage/events/events-1.md)
  * [List of events](usage/events/list-of-events.md)
* [Statistics](usage/statistics/README.md)
  * [Manage statistics using the GUI](usage/statistics/statistics.md)
  * [Manage statistics using the CLI](usage/statistics/statistics-1.md)
  * [List of statistics](usage/statistics/list-of-statistics.md)
* [System congestion](usage/system-congestion.md)
* [Security management](usage/security/README.md)
  * [KMS management](usage/security/kms-management/README.md)
    * [Manage KMS using the GUI](usage/security/kms-management/kms-management.md)
    * [Manage KMS using the CLI](usage/security/kms-management/kms-management-1.md)
  * [Manage the login banner](usage/security/manage-the-login-banner.md)
* [User management](usage/user-management/README.md)
  * [Manage users using the GUI](usage/user-management/user-management.md)
  * [Manage users using the CLI](usage/user-management/user-management-1.md)
* [Organizations management](usage/organizations/README.md)
  * [Manage organizations using the GUI](usage/organizations/organizations.md)
  * [Manage organizations using the CLI](usage/organizations/organizations-1.md)
  * [Mount authentication for organization filesystems](usage/organizations/organizations-2.md)
* [Expand and shrink cluster resources](usage/expanding-and-shrinking-cluster-resources/README.md)
  * [Expand and shrink overview](usage/expanding-and-shrinking-cluster-resources/expand-and-shrink-overview.md)
  * [Workflow: Add a backend host](usage/expanding-and-shrinking-cluster-resources/stages-in-adding-a-backend-host.md)
  * [Expansion of specific resources](usage/expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md)
  * [Shrink a Cluster](usage/expanding-and-shrinking-cluster-resources/shrinking-a-cluster.md)
* [Background tasks](usage/background-tasks.md)
* [Upgrade Weka versions](usage/upgrading-weka-versions.md)

## Billing & Licensing <a href="#licensing" id="licensing"></a>

* [License overview](licensing/overview.md)
* [Classic license](licensing/classic-licensing.md)
* [Pay-As-You-Go license](licensing/pay-as-you-go.md)

## Support

* [Prerequisites and compatibility](support/prerequisites-and-compatibility.md)
* [Get support for your Weka system](support/getting-support-for-your-weka-system.md)
* [The Weka support cloud](support/the-wekaio-support-cloud.md)
* [Diagnostics CLI command](support/diagnostics-utility.md)

## Appendix

* [Weka CSI Plugin](appendix/weka-csi-plugin.md)
* [Monitor using external tools](appendix/external-monitoring.md)
* [Snapshot management](appendix/snapshot-management.md)

***

* [REST API Reference Guide](https://api.docs.weka.io)
