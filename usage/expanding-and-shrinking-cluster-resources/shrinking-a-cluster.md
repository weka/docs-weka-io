# Shrink a cluster

Shrinking a cluster may be required to save the cluster's costs, and the performance degradation does not affect your business.

You can shrink the cluster by performing one of the following:

* Remove only some drives from the cluster.
* Remove containers with their allocated drives.

Removing drives or containers requires deactivating the drives you want to remove. But, if the deactivation leads to insufficient SSD capacity of the currently-provisioned filesystems, the WEKA system does not deactivate the drives, and shrinking the cluster is not allowed.

### Before you begin

Run the following command to display a list of all the drives in the cluster with their details, such as UUID and status:

`weka cluster drive`

<details>

<summary>Example</summary>

```
root@void-new-1:~# weka cluster drive
DISK ID  UUID                                  HOSTNAME     NODE ID  SIZE      STATUS    LIFETIME % USED  ATTACHMENT  DRIVE STATUS
37       84c4574d-5a46-4644-91aa-df1ceef27ff1  void-new-10  1921     1.09 TiB  ACTIVE    0                OK          OK
45       ecd05959-629c-4319-9d24-f69497c499e3  void-new-19  2401     1.09 TiB  ACTIVE    0                OK          OK
46       4c8af0fa-894b-4096-adb6-17fe98a3a690  void-new-17  2281     1.09 TiB  ACTIVE    0                OK          OK
47       49f684d0-9f2e-4b0a-9153-9aa3570067bd  void-new-18  2341     1.09 TiB  ACTIVE    0                OK          OK
57       7202db57-1f4e-4332-a132-33a47a729d46  void-new-0   1141     1.09 TiB  INACTIVE  0                OK
58       6c2ad35b-a1ff-4b30-9882-0ed3ec166747  void-new-1   1321     1.09 TiB  ACTIVE    0                OK          OK
59       ae8dd40a-9d3d-4154-a26d-3e9643f59e6f  void-new-2   1381     1.09 TiB  ACTIVE    0                OK          OK
60       b96e3c32-3a29-436a-ac35-2e8cf6808e9a  void-new-3   1441     1.09 TiB  ACTIVE    0                OK          OK
61       63ab4d5d-82ed-4248-9ce1-817ce5d7e106  void-new-4   1501     1.09 TiB  ACTIVE    0                OK          OK
62       0f303d2c-5fd0-47e6-9150-0da4afcc454b  void-new-5   1561     1.09 TiB  ACTIVE    0                OK          OK
63       d21f4b3b-1458-4402-8592-06e7ca426d9c  void-new-6   1621     1.09 TiB  ACTIVE    0                OK          OK
64       0c3de49c-b123-4b0b-bd64-e7a90454b41d  void-new-7   1681     1.09 TiB  ACTIVE    0                OK          OK
65       c519e608-ae1d-402e-9f10-da69b227d2c8  void-new-8   1741     1.09 TiB  ACTIVE    0                OK          OK
66       80d53c1d-206e-4021-848b-e52b47bf32fa  void-new-9   1801     1.09 TiB  ACTIVE    0                OK          OK
68       3d669d70-6db2-4a7d-a13b-47ad531f43dd  void-new-11  1861     1.09 TiB  ACTIVE    0                OK          OK
69       ded74ec1-d208-41a9-af2d-eb1c1e81e613  void-new-12  1981     1.09 TiB  ACTIVE    0                OK          OK
70       4451db18-8417-4d4f-b5d0-02bad359b9ff  void-new-13  2041     1.09 TiB  ACTIVE    0                OK          OK
71       019f2b88-c284-4cf4-b384-0a0fde6ea128  void-new-14  2101     1.09 TiB  ACTIVE    0                OK          OK
72       7a315ea8-9f12-4143-b67b-213f2f3f6748  void-new-15  2161     1.09 TiB  ACTIVE    0                OK          OK
73       dce3f522-5672-4964-8db8-383774c11569  void-new-16  2221     1.09 TiB  ACTIVE    0                OK          OK
```

</details>

## Remove only some drives from the cluster

Perform the following:

1. [Deactivate drives](shrinking-a-cluster.md#deactivate-drives).
2. [Remove drives from the cluster](shrinking-a-cluster.md#remove-drives-from-the-cluster).

### Deactivate drives

Drive deactivation starts an asynchronous process known as phasing out. It is a gradual redistribution of the data between the remaining drives in the system. On completion, the phased-out drives are in an inactive state. The WEKA cluster does not use inactive drives, but they still appear in the drives list.&#x20;

To deactivate a drive, run the following command:

`weka cluster drive deactivate <uuids>`

**Parameters**

| Name      | Value                              |
| --------- | ---------------------------------- |
| `uuids`\* | Comma-separated drive identifiers. |

{% hint style="info" %}
**Note:** Running the `weka cluster drive` command is displayed whether the redistribution is still being performed.
{% endhint %}

### Remove drives from the cluster

Once you remove a drive from the cluster, the drive is not recoverable.

To remove a drive, run the following command:

`weka cluster drive remove <uuids>`

**Parameters**

| Name      | Value                              |
| --------- | ---------------------------------- |
| **Name**  | **Value**                          |
| `uuids`\* | Comma-separated drive identifiers. |

## Remove containers with their allocated drives

Perform the following:

1. [Deactivate containers](shrinking-a-cluster.md#deactivate-containers).
2. [Remove containers from the cluster](shrinking-a-cluster.md#remove-containers-from-the-cluster).

### Deactivate containers

To deactivate containers with their drives, run the following command:

`weka cluster container deactivate <container-ids> [--allow-unavailable]`

**Parameters**

| Name                | Value                                                                                                                                              | Default |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `container-ids`\*   | Space-separated container identifiers                                                                                                              |         |
| `allow-unavailable` | <p>Allow deactivation of an unavailable container.<br>If the <code>container-id</code> value returns, it joins the cluster in an active state.</p> | No      |

### Remove containers from the cluster

Removing containers from the cluster switches them to a stem mode (not part of a cluster), so they can be reallocated to another cluster or purpose.

To remove the container from the cluster, run the following command:

`weka cluster container remove <container-id>`

**Parameters**

<table><thead><tr><th>Name</th><th>Value</th><th data-hidden>Default</th></tr></thead><tbody><tr><td><code>container-id</code>*</td><td>Comma-separated container identifiers.</td><td></td></tr></tbody></table>
