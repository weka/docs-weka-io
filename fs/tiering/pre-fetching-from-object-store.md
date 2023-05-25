---
description: >-
  This page describes how to manually force-fetching tiered data back to SSDs,
  and force-releasing SSD data to object-store
---

# Manual fetch and release of data

## Pre-fetching API for data lifecycle management

### Fetch files from an object store

Tiered files are always accessible and should generally be treated like regular files. Moreover, while files may be tiered, their metadata is always maintained on the SSDs. This allows traversing files and directories without worrying about how such operations may affect performance.

Sometimes, it's necessary to access previously-tiered files quickly. In such situations, it is possible to request the WEKA system to fetch the files back to the SSD without accessing them directly. This is performed using the prefetch command, which can be issued via the `weka fs tier fetch` command, as follows:

**Command:** `weka fs tier fetch`

Use the following command to release files:

`weka fs tier fetch <path> [-v]`

**Parameters**

<table><thead><tr><th>Name</th><th width="333.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>A comma-separated list of file paths.</td><td>​</td></tr><tr><td><code>-v, --verbose</code></td><td>Showing fetch requests as they are submitted</td><td>Off</td></tr></tbody></table>

### Fetch a directory containing many files

To fetch a directory that contains a large number of files, it is recommended to use the `xargs` command in a similar manner as follows:

```bash
find -L <directory path> -type f | xargs -r -n512 -P64 weka fs tier fetch -v
```

{% hint style="info" %}
**Note:** The pre-fetching of files does not guarantee that they will reside on the SSD until they are accessed.
{% endhint %}

In order to ensure that the fetch is effective, the following must be taken into account:

* **Free SSD capacity**: There has to be sufficient free SSD capacity to retain the filesystems that are to be fetched.
* **Tiering policy**: The tiering policy may release some of the files back to the object store after they have been fetched, or even during the fetch if it takes longer than expected. The policy should be long enough to allow for the fetch to complete and the data to be accessed before it is released again.

## Release API for data lifecycle management

### Release files from SSD to an object store

Using the manual release command, it is possible to clear SSD space in advance (e.g., for shrinking one filesystem SSD capacity for a different filesystem without releasing important data, or for a job that needs more SSDs space from different files). The metadata will still remain on SSD for fast traversal over files and directories but the data will be marked for release and will be released to the object store as soon as possible, and before any other files are scheduled to release due to other lifecycle policies.

**Command:** `weka fs tier release [-v]`

Use the following command to release files:

`weka fs tier release <path>`

**Parameters**

| Name            | Value                                          | Default |
| --------------- | ---------------------------------------------- | ------- |
| `path`\*        | A comma-separated list of file paths.          | ​       |
| `-v, --verbose` | Showing release requests as they are submitted | Off     |

### Release a directory containing many files

In order to release a directory that contains a large number of files, it is recommended to use the `xargs` command in a similar manner, as follows:

```bash
# directory
find -L <directory path> -type f | xargs -r -n512 -P64 weka fs tier release
 
# similarly, a file containing a list of paths can be used
cat file-list | xargs -P32 -n200 weka fs tier release
```
