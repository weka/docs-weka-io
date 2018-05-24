# Pre-Fetch API for Data Lifecycle Management

## Fetching Files From Object Store Tier

Tiered files are always accessible and should generally be treated as regular files. Moreover, while files may be tiered, their meta-data is always kept on the SSD tier. This allows traversing files and directories without worrying about the performance of such operations.

In some cases, files that were previously tiered need to be accessed quickly. Therefore it’s possible to ask WekaIO to fetch the files back to the SSD tier without accessing them directly.

Prefetch can be issued via the `weka fs tier fetch` CLI:

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

In order to fetch a directory that contains a large number of files, it is recommended to use `xargs` in a parallel manner like so:

```bash
find -L <directory path> -type f | xargs -r -n512 -P64 weka fs tier fetch -v
```

Note that prefetching the files doesn’t guarantee they will reside in the SSD tier until they are accessed.

In order to ensure the fetch will be effective, consider the following:

* **Free SSD capacity**: The filesystem should have enough free SSD capacity to retain the files you want to have fetched.
* **Tiering policy**: The policy might demote some of the files back to the OBS tier after they have been fetched, or even during the fetch if it takes longer than expected. The policy should be long enough to allow for the fetch to complete and the data to be accessed before it’s demoted again.

