---
description: >-
  Configure mandatory and recommended NFS client mount options with WEKA based
  on real-world testing and validation for optimal performance and reliability.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/nfs-support/supported-nfs-client-mount-options
---

# Supported NFS client mount parameters

To ensure optimal performance and reliability when using NFS clients with WEKA, it is essential to configure specific mandatory and recommended mount parameters. These parameters have been tested and validated in various real-world scenarios.

## **Mandatory parameters**

The following parameters **must** be included alongside the client's default mount options:

* **NFSv3** and **NFSv4**: `proto=tcp`

## Recommended parameters

For enhanced performance and stability, include the following parameters in addition to the mandatory ones:

* **NFSv3**:
  * `hard`
  * `vers=3`
* **NFSv4**:
  * `hard`
  * `vers=4`

## Additional information

* **Specifying NFS Client Version:** Always explicitly define the NFS client version (`vers=3` or `vers=4`) to prevent unexpected protocol negotiation during server configuration changes.
* **Resiliency to network interruptions:** Use the `hard` option to ensure the client retries operations during temporary network interruptions, maintaining data integrity and operation continuity.
* **Improving NFS performance:** For the latest WEKA versions, consider setting the `nconnect` parameter to a value greater than `1` to optimize NFS performance by enabling multiple TCP connections.
* **Default NFS client options:** Beyond the parameters listed above, the default options negotiated by the NFS client at mount time are suitable for most use cases. For advanced configurations or additional NFS client options, refer to the documentation provided by your operating system.

**Related topic**

[mounting-filesystems](../../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")
