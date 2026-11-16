---
description: >-
  Enable Rich ACL enforcement on a filesystem, and set, edit, and remove Rich
  ACLs on files and directories using the CLI.
---

# Manage Rich ACLs on the WEKA client

Manage Rich ACLs with the `weka fs acl` commands, which operate on a path in a mounted filesystem. Enforcement is set per filesystem with `weka fs update`.

## Before you begin

* Upgrade all backends and clients in the cluster to version 6.1 or later. Enabling enforcement fails while any client in the cluster runs an earlier version, and earlier clients cannot mount the filesystem.
* Mount the filesystem with the `acl` option on every client from which you manage ACLs: `mount -t wekafs -o acl <fs-name> <mount-point>`. Enforcement applies to all mounts. The `acl` option only controls whether the client can read and write the ACL.
* Clear POSIX ACLs from files that you intend to manage with Rich ACLs. For the reason, see the POSIX ACLs entry in [Considerations](./#considerations).

## Enable Rich ACL enforcement on a filesystem

1.  Enable enforcement:

    ```bash
    weka fs update <fs-name> --rich-acl-enforcement on
    ```

    To enable enforcement when you create a filesystem, add `--rich-acl-enforcement on` to `weka fs add`.
2.  Verify the setting:

    ```bash
    weka fs --name <fs-name> -v
    ```

    The Rich ACL Enforcement column shows the setting.

## Set a Rich ACL

Replace the entire ACL of a file or directory with the entries you specify. Enforcement must be on: while it is off, attempts to set an ACL are rejected.

1.  Resolve the user and group names to UIDs and GIDs:

    ```bash
    id -u <user-name>
    getent group <group-name>
    ```
2.  Set the ACL:

    ```bash
    weka fs acl set <path> "<ace>[,<ace>...]"
    ```

    For the permission letters, inheritance flags, and principals, see [Rich ACL permission reference](rich-acl-permission-reference.md).

    **Example:** give the owner full control of a new project directory and give project members read access. New files and subdirectories inherit both entries:

    ```bash
    weka fs acl set /mnt/weka/projects/study-43 \
      "A:fd:OWNER@:rwaxdDtTnNcCoy,A:fd:g7002:rxt"
    ```
3.  Read the ACL back:

    ```bash
    weka fs acl get <path>
    ```

    The output starts with a `# mode:` line, followed by one entry per line.

## Edit individual entries

Add, change, or remove a single entry without rewriting the whole ACL. An existing entry is matched by its type and principal. If `modify` finds no matching entry, it adds the entry.

1. Run the command for the change:
   *   To add an entry:

       ```bash
       weka fs acl add <path> "<ace>"
       ```
   *   To change the flags or permissions of an existing entry:

       ```bash
       weka fs acl modify <path> "<ace>"
       ```
   *   To remove an entry:

       ```bash
       weka fs acl remove <path> "<ace>"
       ```
2.  Read the ACL back:

    ```bash
    weka fs acl get <path>
    ```

## Apply an ACL to an existing tree

Inheritance applies only to files and directories created after the ACL is set. To change a tree that already exists, add `-R` to `set`, `add`, `modify`, `remove`, or `clear`.

1.  Run the command with `-R`:

    ```bash
    weka fs acl set -R <path> "<ace>[,<ace>...]"
    ```

    The client walks the tree and applies the change to each object. The time it takes is proportional to the number of objects.

    **Example:** freeze an existing dataset. The data management group (6001) keeps control, project members (7002) can read, and nobody else can write or delete:

    ```bash
    weka fs acl set -R /mnt/weka/projects/study-42 \
      "A:fd:g6001:rxdDtcCo,A:fd:g7002:rxt,D:fd:EVERYONE@:wadD"
    ```

    Because the group 6001 entry comes before the `EVERYONE@` deny entry, members of group 6001 can still delete. Root also bypasses the ACL.
2.  Read the ACL of an object inside the tree to confirm the change:

    ```bash
    weka fs acl get <path>/<object>
    ```

## Remove a Rich ACL

Remove the Rich ACL from a file or directory and return it to mode bits only. Enforcement must be on: while it is off, `weka fs acl clear` fails.

1.  Remove the ACL:

    ```bash
    weka fs acl clear <path>
    ```

    To clear a whole tree, add `-R`.
2.  If the object also carries a POSIX ACL, re-set the POSIX ACL.

    Removing a Rich ACL stamps the widened mode bits onto the POSIX ACL mask and other entries.

## Disable Rich ACL enforcement

{% hint style="warning" %}
Disabling enforcement leaves files that carried a Rich ACL with widened mode bits, and those mode bits become the only control. For details, see [Enforcement scope](./#enforcement-scope).
{% endhint %}

1.  Disable enforcement:

    ```bash
    weka fs update <fs-name> --rich-acl-enforcement off
    ```
2.  Confirm the prompt.

    To skip the prompt in a script, add `--force`.
3. Review the mode bits of files that carried a Rich ACL, and narrow them with `chmod` where needed.

**Related topics**

[Manage POSIX ACLs on the WEKA client](../posix-acls-on-the-weka-client/manage-posix-acls-weka-client.md)

[Manage filesystems using the CLI](../managing-filesystems/managing-filesystems-1.md)
