---
description: This page describes how to manually force-fetching tiered data back to SSDs.
---

# Pre-Fetching from Object Store

## Pre-Fetching API for Data Lifecycle Management

### Fetching Files from an Object Store

Tiered files are always accessible and should generally be treated as regular files. Moreover, while files may be tiered, their metadata is always maintained on the SSDs. This allows traversing files and directories without worrying how such operations may affect performance.

Sometimes, it may be necessary to access previously-tiered files quickly. In such situations, it is possible to request the WekaIO system to fetch the files back to the SSD without accessing them directly. This is performed using the prefetch command, which can be issued via the`weka fs tier fetch`command, as follows:

```text
weka fs tier fetch
----------------------
Description:
    Fetch object-stored files to SSD store

Arguments:
    path                                A file or directory path to fetch to SSD store

Usage:
    weka fs tier fetch <path> [options]

Options:
     --glob=<glob>                      Glob expression to filter files by. Only matching files will be fetched
     --dont-recurse                     Do not recurse into subdirectories
     -L, --dereference                  Follow symbolic links
     -h, --help                         Display help
     --help-syntax                      Display help on the syntax of the switches
     -H=<hostname>, --host=<hostname>   Specify the host. Alternatively, use the $WEKA_HOST env variable
     -J, --json                         Format output as JSON
```

### Fetching a Directory Containing Many Files

In order to fetch a directory that contains a large number of files, it is recommended to use the `xargs` command in a similar manner, as follows:

```bash
find -L <directory path> -type f | xargs -r -n512 -P64 weka fs tier fetch -v
```

{% hint style="info" %}
**Note:** The pre-fetching of files does not guarantee that they will reside on the SSD until they are accessed.
{% endhint %}

In order to ensure that the fetch is effective, the following must be taken into account:

* **Free SSD Capacity**: There has to be sufficient free SSD capacity to retain the filesystems that are to be fetched.
* **Tiering Policy**: The tiering policy may release some of the files back to the object store after they have been fetched, or even during the fetch, if it takes longer than expected. The policy should be long enough to allow for the fetch to complete and the data to be accessed before it is released again.

