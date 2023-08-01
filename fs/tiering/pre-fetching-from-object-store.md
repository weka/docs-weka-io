---
description: >-
  How to manually force fetching tiered data back to the SSDs, and force
  releasing SSD data to object-store regardless of the retention policy. Also,
  how to find the location of the data.
---

# Manual fetch and release of data

## Pre-fetching API for data lifecycle management

### Fetch files from an object store

Tiered files are always accessible and are generally treated like regular files. Moreover, while files may be tiered, their metadata is always maintained on the SSDs. This allows traversing files and directories without worrying about how such operations may affect performance.

Sometimes, it's necessary to access previously-tiered files quickly. In such situations, you can request the WEKA system to fetch the files back to the SSD without accessing them directly.

**Command:** `weka fs tier fetch`

Use the following command to fetch files:

`weka fs tier fetch <path> [-v]`

**Parameters**

<table><thead><tr><th>Name</th><th width="333.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>A comma-separated list of file paths.</td><td>​</td></tr><tr><td><code>-v, --verbose</code></td><td>Showing fetch requests as they are submitted.</td><td>Off</td></tr></tbody></table>

### Fetch a directory containing many files

To fetch a directory that contains a large number of files, it is recommended to use the `xargs` command in a similar manner as follows:

```bash
find -L <directory path> -type f | xargs -r -n512 -P64 weka fs tier fetch -v
```

{% hint style="info" %}
The pre-fetching of files does not guarantee that they will reside on the SSD until they are accessed.
{% endhint %}

To ensure effective fetch, adhere to the following:

* **Free SSD capacity**: The SSD has sufficient free capacity to retain the fetched filesystems.
* **Tiering policy**: The tiering policy may release some of the files back to the object store after they have been fetched, or during the fetch if it takes longer than expected. The tiering policy must be long enough to allow for the fetch to complete and the data to be accessed before it is released again.

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

To release a directory that contains a large number of files, it is recommended to use the `xargs` command in a similar manner, as follows:

```bash
# directory
find -L <directory path> -type f | xargs -r -n512 -P64 weka fs tier release
 
# similarly, a file containing a list of paths can be used
cat file-list | xargs -P32 -n200 weka fs tier release
```

## Find the location of tiered files

Depending on the retention period in the tiering policy, files can be found on the object store or the SSD or both locations as follows:

* Before the file is tired to the object store, it is found in the SSD.
* During data tiering, the tiered data is on the SSD (read cache) and the object store.
* Once the entire file data is tiered and the retention period has past, the complete file is found in the object store only.

Use this command to find the file location during the data lifecycle operations.&#x20;

**Command:** `weka fs tier location`

Use the following command to find files:

`weka fs tier location <path>`

For multiple paths, use the following command:

`weka fs tier location <paths>`

To find all files in a single directory, use the following command:

`weka fs tier location *`

**Parameters**

<table><thead><tr><th>Name</th><th width="359.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>A path to get information about.</td><td>​</td></tr><tr><td><code>paths</code></td><td>Space-separated list of paths to get information about.</td><td></td></tr></tbody></table>

#### Examples of a tiered file location during the data lifecycle management

1. Before the file named `image` is tired to the object store, it is found in the SSD (WRITE-CACHE).

```
[root@kenny-0 weka] 2023-07-13 14:57:11 $ weka fs tier location image
PATH   FILE TYPE  FILE SIZE  CAPACITY IN SSD (WRITE-CACHE)  CAPACITY IN SSD (READ-CACHE)  CAPACITY IN OBJECT STORAGE  CAPACITY IN REMOTE STORAGE
image  regular    102.39 MB  102.39 MB                      0 B                           0 B                         0 B

```

2. The file is tiered and the retention period has not past yet, so the file is found in the SSD (READ-CACHE) and the object store.

```
[root@kenny-0 weka] 2023-07-13 14:58:14 $ weka fs tier location image
PATH   FILE TYPE  FILE SIZE  CAPACITY IN SSD (WRITE-CACHE)  CAPACITY IN SSD (READ-CACHE)  CAPACITY IN OBJECT STORAGE  CAPACITY IN REMOTE STORAGE
image  regular    102.39 MB  0 B                            102.39 MB                     102.39 MB                   0 B

```

3. The file is tiered and the retention period past, so the file is found in the object store only.

```
[root@kenny-0 weka] 2023-07-13 14:59:14 $ weka fs tier location image
PATH   FILE TYPE  FILE SIZE  CAPACITY IN SSD (WRITE-CACHE)  CAPACITY IN SSD (READ-CACHE)  CAPACITY IN OBJECT STORAGE  CAPACITY IN REMOTE STORAGE
image  regular    102.39 MB  0 B                            0 B                     102.39 MB                   0 B

```
