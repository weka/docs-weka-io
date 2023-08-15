# Supported NFS client mount options

### Non-coherent mount options

* `ac`
* `async`
* `noatime`
* `lookupcache=all`

### Coherent mount options

* `noac`
* `sync`
* `atime`
* `lookupcache=none`

### Common mount options

{% hint style="info" %}
You can change the following mount options. These values are commonly used with the WEKA system.
{% endhint %}

* `rw`
* `hard`
* `rsize=524288`
* `wsize=524288`
* `namlen=255`
* `timeo=600`
* `retrans=2`
* `nconnect=1` (only supported in NFS-W)&#x20;

### Fixed-mount options

{% hint style="danger" %}
**Note:** Set these values on the mount command because different values are not supported.
{% endhint %}

* `nolock`

{% hint style="info" %}
**Note:** The following options must have fixed values, but usually are either the NFS mount defaults or are negotiated to these values by the protocol.
{% endhint %}

* `sec=sys`
* `proto=tcp`
* `mountproto=tcp`
