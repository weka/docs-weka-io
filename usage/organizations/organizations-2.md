---
description: >-
  This page describes how uses that mount the organization filesystems are
  authenticated.
---

# Mount authentication for organization filesystems

Once the Cluster Admin has created an organization and the Organization Admin has created filesystems, users, or configured the LDAP for the organization, regular organization users can mount filesystems.

The purpose of organizations is to provide separation and security for organization data, which requires authentication of the Weka system filesystem mounts. This authentication of mounts prevents users of other organizations and even the Cluster Admin from accessing organization filesystems.

Mounting filesystems in an organization (other than the Root organization) is only supported using a stateless client. A login prompt appears as part of the mount command if the user is not logged into the system.

## Mount a filesystem

To securely mount a filesystem, first log into the Weka system:

```
weka user login my_user my_password --org my_org -H backend-host-0
```

Then mount the filesystem:

```
mount -t wekafs backend-host-0/my_fs /mnt/weka/my_fs
```

For all mount options, see [Mount Command Options](../../fs/mounting-filesystems.md#mount-command-options).

## Authentication‌

Authentication is achieved by obtaining a mount token and including it in the mount command. Logging into the Weka system using the CLI (the `weka user login` command) creates an authentication token and saves it in the client (default to `~/.weka/auth-token.json,` which can be changed using the`--path`attribute).

The Weka system assigns the token that relates to a specific organization. Only mounts that pass the path to a correct token can successfully access the filesystems of the organization.

Once the system authenticates a user, the mount command uses the default location of the authentication token. It is possible to change the token location/name and pass it as a parameter in the mount command using the `auth_token_path` mount option, or the`WEKA_TOKEN` environment variable.

```
mount -t wekafs backend-host-0/my_fs /mnt/weka/my_fs -o auth_token_path=<path>
```

This option is useful when mounting several filesystems for several users/organizations on the same host or when using Autofs.

When a token is compromised or no longer required, such as when a user leaves the organization, the Organization Admin can prevent using that token for new mounts by revoking the user access.



**Related topics**

[user-management](../user-management/ "mention")
