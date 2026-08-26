---
description: >-
  Manage POSIX ACLs on a WEKA filesystem that is mounted with the native client
  to grant fine-grained access to specific users and groups. For the background
  on how WEKA applies POSIX ACLs.
---

# Manage POSIX ACLs WEKA client

## Before you begin

* Mount the filesystem with ACL support enabled by adding the `acl` mount option. This option enables POSIX ACL handling and enforcement on the WEKA filesystem mount.
* Install the standard `acl` package on the client server .
* Review the metadata cost in [POSIX ACLs on the WEKA client](file:///) before you enable ACL support on a production mount.

## View mode bits and ACL entries

1.  List the mode bits:

    ```bash
    ls -l <path>
    ```

    A `+` after the mode bits indicates an ACL, for example `-rw-r-----+`.
2.  List the ACL entries:

    ```bash
    getfacl <path>
    ```

    Example output:

    ```bash
    # file: data.txt
    # owner: bob
    # group: research
    user::rw-
    user:alice:r--
    group::r--
    mask::r--
    other::---
    ```

    The `user::` and `group::` lines correspond to the owner and the owning group. Named entries such as `user:alice:` form the extended part of the ACL. The `mask::` line limits the effective permissions of named users and groups.

## Grant a user access on a directory

1.  Grant the user read, write, and conditional execute:

    ```bash
    setfacl -m u:alice:rwX /mnt/weka/projectA
    ```

    Capital `X` sets execute only where execute already applies, such as directories or files that already carry execute. For a directory, execute means traverse or search.
2.  Verify the change:

    ```bash
    getfacl /mnt/weka/projectA
    ```

## Remove a user ACL entry

1.  Remove the entry:

    ```bash
    setfacl -x u:alice /mnt/weka/projectA
    ```
2.  Verify the change:

    ```bash
    getfacl /mnt/weka/projectA
    ```

## Set a default ACL for inheritance

1.  Grant the user access on new items created under the directory:

    ```bash
    setfacl -m d:u:alice:rwX /mnt/weka/projectA
    ```
2.  Verify that the output includes `default:` lines:

    ```bash
    getfacl /mnt/weka/projectA
    ```

## Apply ACLs recursively

1.  Apply the ACL to all existing files and subdirectories:

    ```bash
    setfacl -R -m u:alice:rwX /mnt/weka/projectA
    ```
2.  Set a default ACL so new children inherit the same entries:

    ```bash
    setfacl -m d:u:alice:rwX /mnt/weka/projectA
    ```

## Back up and restore ACLs

1.  Back up the ACLs before large-scale changes:

    ```bash
    getfacl -R /mnt/weka/projectA > /tmp/projectA.acl.backup
    ```
2.  Restore the ACLs from the backup:

    ```bash
    setfacl --restore=/tmp/projectA.acl.backup
    ```

**Related topics**

[POSIX ACLs on the WEKA client](file:///)

[Mount filesystems](/broken/pages/ba91a874ba5566d72c9de29f6f644c9284f488a2)

[Manage the NFS protocol](/broken/pages/3c45e126a594ccb42deac8473a32000506b8d9ed)
