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

* **File locking:** WEKA NFS does not support file locking in 4.2. File lock requests by the client will be ignored or result in an error. For file locking, use the WekaFS client.
* **NFS client version:** Specify the NFS client version as `vers=3` or `vers=4` to prevent unexpected negotiations during server configuration changes.
* **Resiliency:** Explicitly set `hard` for resilience to temporary network interruptions.
* **NFS performance:** For users of the latest WEKA versions, consider setting `nconnect` to a value greater than 1 for potential NFS performance improvement.

{% hint style="info" %}
This page discusses client options specifically supported for clients of WEKA NFS. Beyond these, the default NFS client options negotiated at mount time are appropriate for most use cases. For guidance on other NFS client options, consult the client's operating system documentation.
{% endhint %}

**Related topic**

[mounting-filesystems](../../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")
