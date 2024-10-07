# Manage protocols debug level using the CLI

Using the CLI, you can:

* [Show S3 debug level](manage-protocols-debug-level-using-the-cli.md#show-s3-debug-level)
* [Manage NFS debug level](manage-protocols-debug-level-using-the-cli.md#update-nfs-debug-level)
* [Set SMB debug level](manage-protocols-debug-level-using-the-cli.md#update-smb-debug-level)

## Show S3 debug level <a href="#show-s3-debug-level" id="show-s3-debug-level"></a>

**Command:** `weka s3 log-level get`

## Manage NFS debug level <a href="#manage-nfs-debug-level" id="manage-nfs-debug-level"></a>

**Command:** `weka nfs debug-level show|set`

**Command options:**

`show:` Shows debug level for the NFS servers.

`set:` Sets the debug level for the NFS servers. When you complete debugging, return the debug level to default (creates an event).

## Set SMB debug level <a href="#set-smb-debug-level" id="set-smb-debug-level"></a>

**Command:**  `weka smb cluster debug`

**Parameter:**

`level:` The debug level (format: 0..10).
