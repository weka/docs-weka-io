---
description: >-
  Explore Rich ACLs, which add NFSv4-style access control to filesystems mounted
  with the native client (wekafs).
---

# Rich ACLs on the WEKA client

Rich ACLs add ordered allow and deny entries, named users and groups, fine-grained permissions such as delete and append, and inheritance flags to wekafs mounts. Use them when standard mode bits and POSIX ACLs cannot express the access policy you need, for example, to freeze a dataset so that only a designated group can change or delete it.

{% hint style="warning" %}
Rich ACLs apply to wekafs mounts only. The NFS, SMB, and S3 protocol services do not evaluate Rich ACLs, so protocol clients are not bound by them. For details, see [Considerations](./#considerations).
{% endhint %}

## Rich ACLs and the other permission models

Every file and directory carries standard mode bits. A filesystem can also carry POSIX ACLs and Rich ACLs. Each model is evaluated independently:

* **Mode bits** are evaluated by the Linux kernel on the client.
* **POSIX ACLs** are evaluated by the Linux kernel on the client. For background, see [POSIX ACLs on the WEKA client](../posix-acls-on-the-weka-client/).
* **Rich ACLs** are evaluated by the filesystem, not by the client kernel.

When a file carries a Rich ACL, the system rewrites its mode bits to a widened form of the ACL. The client kernel still checks the mode bits and any POSIX ACL, and the filesystem checks the Rich ACL, so in practice the Rich ACL and the POSIX ACL decide access together. Execute permission on files is the exception: the mode bits alone decide it. For details, see [Interaction with mode bits](./#interaction-with-mode-bits).

The following table summarizes the differences.

| Capability                                              | Mode bits      | POSIX ACLs                                    | Rich ACLs  |
| ------------------------------------------------------- | -------------- | --------------------------------------------- | ---------- |
| Named users and groups                                  | No             | Yes                                           | Yes        |
| Deny entries                                            | No             | No                                            | Yes        |
| Ordered evaluation                                      | No             | No                                            | Yes        |
| Separate delete, append, and ACL-management permissions | No             | No                                            | Yes        |
| Inheritance flags                                       | No             | Default ACL only                              | Yes        |
| Maximum entries per object                              | Not applicable | Limited by the 1 KB extended attribute budget | 1024       |
| Enforced by                                             | Client kernel  | Client kernel                                 | Filesystem |

## Access control entries

A Rich ACL is an ordered list of access control entries (ACEs). Each ACE has four fields:

```
type:flags:principal:permissions
```

| Field           | Values                                                                            |
| --------------- | --------------------------------------------------------------------------------- |
| **type**        | `A` (allow) or `D` (deny)                                                         |
| **flags**       | Inheritance flags. Leave empty for no inheritance.                                |
| **principal**   | `OWNER@`, `GROUP@`, `EVERYONE@`, or a numeric user (`u<uid>`) or group (`g<gid>`) |
| **permissions** | One or more permission letters                                                    |

The permission letters, inheritance flags, and principals are listed in [Rich ACL permission reference](rich-acl-permission-reference.md).

**Example:** `A::OWNER@:rwaxtTcCoy,D::g6001:x` grants the owner full access and denies execute to group 6001.

Principals are numeric. Resolve user and group names to UIDs and GIDs before you write an ACL.

### Inheritance

When a user creates a file or directory, it inherits the ACEs of its parent directory that carry an inheritance flag. The flags control whether new files, new subdirectories, or both inherit an entry, whether the entry propagates beyond the immediate children, and whether it applies to the parent directory itself.

Inheritance happens at creation time only. Changing the ACL of a directory does not change the ACLs of files and directories that already exist under it. To apply an ACL to an existing tree, use the recursive option of the `weka fs acl` commands.

When a file or directory inherits an entry, the system adds the `I` flag to it.

## Permission evaluation

A Rich ACL is evaluated when a file is opened. When you tighten an ACL, the change applies to subsequent opens. Already-open file handles keep their granted access until they close.

### Evaluation order

ACEs are evaluated in order, from first to last. For each permission that the operation requires, the first ACE whose principal matches the requesting user and that mentions the permission decides: an allow entry grants it, and a deny entry refuses it. Place deny entries before the allow entries they override.

If no ACE mentions a permission that the operation requires, access is denied.

### Root

The root user (UID 0) bypasses Rich ACLs, including deny entries, in the same way that root bypasses mode bits. Use root to repair an ACL that locks out its owner.

### Delete

Deleting or renaming a file requires either the `D` (delete child) permission on the parent directory or the `d` (delete) permission on the file itself. The operation is refused only when one side denies the permission and neither side allows it. A file or directory without a Rich ACL neither grants nor denies, so the mode bits govern as before. This matches the NFSv4 and Windows rules.

### Owner and ACL management

A Rich ACL has no implicit baseline for the owner. An owner who needs to keep changing the ACL must hold the `C` (write ACL) permission explicitly, and the `o` (change owner) permission to transfer ownership. An owner can save an ACL that removes their own ability to manage it. Root can always repair such an ACL.

### Interaction with mode bits

While a file carries a Rich ACL, the mode bits reported to the client are wider than the ACL, so that the client kernel forwards requests to the filesystem for the precise decision. An explicit `chmod` rewrites the `OWNER@`, `GROUP@`, and `EVERYONE@` entries of the ACL and leaves named user and group entries unchanged.

{% hint style="warning" %}
Tools that read the mode and write it back, such as `cp -p`, `rsync -p`, and symbolic `chmod` (for example, `g+w`), apply the widened mode bits and therefore widen the ACL.
{% endhint %}

## Enforcement scope

Rich ACL enforcement is a per-filesystem setting. When it is on:

* Rich ACLs are evaluated for every access from a wekafs mount, whether or not the client mounted with the `acl` option.
* New files and directories inherit ACEs from their parents.
* Clients that run a version earlier than 6.1 cannot mount the filesystem.
* Async delete (`--enable-weka-delete`) remains available. Only root and the configured async delete user or group can move a directory to async delete, and the removal does not check Rich ACLs.

When it is off, stored Rich ACLs stay on the files but are not evaluated, cannot be modified, and are not inherited. Remove Rich ACLs before you turn enforcement off: while it is off, the `weka fs acl clear` command fails.

{% hint style="warning" %}
Turning enforcement off does not restore the previous access. Files that carried a Rich ACL keep the widened mode bits reported while the ACL was in force, and those mode bits become the only control. Turning enforcement back on does not reconcile the mode bits with the ACL.
{% endhint %}

## Performance considerations

A Rich ACL can hold up to 1024 entries. A large ACL is stored separately from the file metadata and takes an extra read to load.

Clients do not cache Rich ACLs by default. Each access check reads the ACL from the backend, so a change made on one client takes effect on other clients at their next access.

## Auditing

Rich ACL changes are recorded in the data access audit log as SETXATTR and RMXATTR records.

## Considerations

{% hint style="warning" %}
A file in a directory that the client has already cached can be found, and its metadata read, through a path that the Rich ACL denies. The file data stays protected.
{% endhint %}

| Consideration                     | Effect                                                                                                                                                                                                                                                |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NFS and SMB services              | Authorize using the reported mode bits, which are wider than the Rich ACL. Do not export a Rich ACL-enforced filesystem over NFS or SMB if the protocol clients must be bound by the Rich ACL. \[VERIFY: wording agreed with the protocol team]       |
| S3 service                        | Runs with root privileges and does not evaluate mode bits, POSIX ACLs, or Rich ACLs.                                                                                                                                                                  |
| Permission queries                | `access(2)`, NFSv4 `ACCESS`, and SMB maximal access are answered from the mode bits. They can report that an operation is allowed when the Rich ACL denies it. The operation itself fails.                                                            |
| Execute without read              | An ACL that grants `x` and denies `r` on a file has no effect. The client kernel opens a file for execution with a read request, so a user who can execute a file can also read it.                                                                   |
| Permissions that are not enforced | The `t` (read attributes), `c` (read ACL), and `y` (synchronize) permissions are stored but not enforced.                                                                                                                                             |
| Symbolic links                    | A symbolic link does not inherit ACEs, and the `weka fs acl` commands act on the target of a link. Access through a link is governed by the ACL of the target.                                                                                        |
| POSIX ACLs on the same file       | Removing a Rich ACL from a file that also carries a POSIX ACL stamps the widened mode bits onto the POSIX ACL mask and other entries. Re-set the POSIX ACL after you remove the Rich ACL, or clear POSIX ACLs before you enable enforcement.          |
| umask on mounts without `acl`     | The client kernel applies the umask before the filesystem receives the requested mode, so a file that inherits ACEs gets a narrower baseline than on an `acl` mount. Mount with the `acl` option on clients that create files under inheritable ACLs. |
| Mode-equivalent ACLs              | A Rich ACL that only expresses what the mode bits already express is stored as mode bits. Reading it back reports no ACL.                                                                                                                             |
| Entry types and flags             | `AUDIT` and `ALARM` entries are stored but do not affect access decisions. Reserved ACL-wide flags of the NFSv4 model, such as `AUTO_INHERIT` and `PROTECTED`, are rejected. Strip them before you migrate ACLs from another system.                  |

**Related topics**

[Manage Rich ACLs on the WEKA client](manage-rich-acls-on-the-weka-client.md)

[Rich ACL permission reference](rich-acl-permission-reference.md)

[Mount filesystems](../mounting-filesystems/)

[Audit and forwarding management](../../operation-guide/audit-and-forwarding-management/)
