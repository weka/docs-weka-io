# Supported NFS client mount parameters

For optimal NFS client performance with WEKA, adhere to mandatory and recommended parameters. These parameters are tested and supported in various scenarios, reflecting real-world usage.

## **Mandatory** parameters

It is imperative to include the following parameters with the client's default mount options:

* **NFSv3:**&#x20;
  * `nolock`
  * `sec=sys`
  * `proto=tcp`
* **NFSv4:**
  * `sec=sys`
  * `proto=tcp`

## Recommended parameters

In addition to the mandatory parameters, consider the following recommendations to enhance performance and stability:

* **NFSv3:**
  * `hard`
  * `vers=3`
* **NFSv4:**
  * `hard`
  * `vers=4`

## Additional information

* **File locking:** In WEKA Version 4.2.X, WEKA NFS does not support file locking. Any file lock requests from the client are either ignored or result in an error. To enable file locking, use the WEKA client (POSIX) or upgrade to WEKA Version 4.3.3 or higher, where NFS locking is fully supported for NFS protocol versions 3 and 4 and can be configured through global parameters.
* **NFS client version:** Specify the NFS client version as `vers=3` or `vers=4` to prevent unexpected negotiations during server configuration changes.
* **Resiliency:** Explicitly set `hard` for resilience to temporary network interruptions.
* **NFS performance:** For users of the latest WEKA versions, consider setting `nconnect` to a value greater than 1 for potential NFS performance improvement.

{% hint style="info" %}
This page discusses client options specifically supported for clients of WEKA NFS. Beyond these, the default NFS client options negotiated at mount time are appropriate for most use cases. For guidance on other NFS client options, consult the client's operating system documentation.
{% endhint %}

**Related topic**

[mounting-filesystems](../../fs/mounting-filesystems/ "mention")
