---
description: >-
  Look up the permission letters, inheritance flags, principals, and limits that
  a Rich ACL entry accepts.
---

# Rich ACL permission reference

Use these values when you write an entry for the `weka fs acl` commands.

{% hint style="warning" %}
Rich ACLs use the NFSv4 letter assignments. The Linux richacl tools assign some of the same letters to different permissions, for example, `d` and `D`. Entries written in the richacl convention are not detected: a shared letter is read with its NFSv4 meaning. Convert such entries before you use them.
{% endhint %}

## Permissions

| Letter | Permission                                           | Applies to         | Enforced |
| ------ | ---------------------------------------------------- | ------------------ | -------- |
| `r`    | Read data, or list a directory                       | Files, directories | Yes      |
| `w`    | Write data, or create files in a directory           | Files, directories | Yes      |
| `a`    | Append data, or create subdirectories in a directory | Files, directories | Yes      |
| `x`    | Execute a file, or traverse a directory              | Files, directories | Yes      |
| `d`    | Delete the object itself                             | Files, directories | Yes      |
| `D`    | Delete a child of the directory                      | Directories        | Yes      |
| `t`    | Read attributes                                      | Files, directories | No       |
| `T`    | Write attributes, such as timestamps                 | Files, directories | Yes      |
| `n`    | Read named attributes (extended attributes)          | Files, directories | Yes      |
| `N`    | Write named attributes (extended attributes)         | Files, directories | Yes      |
| `c`    | Read the ACL                                         | Files, directories | No       |
| `C`    | Write the ACL                                        | Files, directories | Yes      |
| `o`    | Change the owner                                     | Files, directories | Yes      |
| `y`    | Synchronize                                          | Files, directories | No       |

Permissions marked **No** are accepted and stored but are not consulted when an operation is authorized.

## Common permission sets

| Purpose                                   | Permissions      |
| ----------------------------------------- | ---------------- |
| Full control                              | `rwaxdDtTnNcCoy` |
| Read only                                 | `rxt`            |
| Read and write, no delete                 | `rwaxtTnN`       |
| Append only, for example, a log file      | `atT`            |
| Manage the ACL without access to the data | `cC`             |

The `o` permission lets a principal transfer ownership of the object. Grant it only to principals that need full control.

## Inheritance flags

| Flag | Meaning                                                                                   |
| ---- | ----------------------------------------------------------------------------------------- |
| `f`  | New files under the directory inherit the entry.                                          |
| `d`  | New subdirectories under the directory inherit the entry.                                 |
| `n`  | Only immediate children inherit the entry. It does not propagate further.                 |
| `i`  | The entry applies to new children only, not to the directory itself.                      |
| `I`  | Marks an inherited entry. The system adds it when a file or directory inherits the entry. |

## Principals

| Principal   | Meaning                                              |
| ----------- | ---------------------------------------------------- |
| `OWNER@`    | The owner of the file or directory                   |
| `GROUP@`    | The owning group                                     |
| `EVERYONE@` | All users, including the owner and the owning group  |
| `u<uid>`    | The user with the numeric UID, for example, `u1042`  |
| `g<gid>`    | The group with the numeric GID, for example, `g6001` |

## Limits

| Item                                   | Value             |
| -------------------------------------- | ----------------- |
| Maximum entries per file or directory  | 1024              |
| Extended attribute that stores the ACL | `system.weka_acl` |

**Related topics**

[Rich ACLs on the WEKA client](./)

[Manage Rich ACLs on the WEKA client](manage-rich-acls-on-the-weka-client.md)
