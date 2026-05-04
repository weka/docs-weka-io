---
description: >-
  Manage isolated storage, users, and security within a specific tenant
  boundary.
---

# Multi-tenancy tenant-level administration

After a Cluster Admin creates a tenant and assigns a Tenant Admin, that administrator is responsible for managing the isolated resources within their specific isolated space.&#x20;

The following procedures describe how the Tenant Admin (or a Cluster Admin for the Root tenant) manages isolated storage, users, and security within a specific tenant boundary.

## Manage tenant filesystems

Tenant Admins are responsible for the lifecycle of storage volumes and their associated policies within their tenant container.

* **Create and manage filesystems:** Define and configure storage volumes that are strictly tenant-owned.
* **Set filesystem-level policies:** Manage snapshots, data protection, and tiered storage settings for tenant-owned data.

For additional guidance on related topics, consult the standard procedures. These also pertain to a tenant context, including:

[managing-filesystems](../../weka-filesystems-and-object-stores/managing-filesystems/ "mention")

[manage-cidr-based-security-policies.md](../../security/manage-cidr-based-security-policies.md "mention")

[snapshots](../../weka-filesystems-and-object-stores/snapshots/ "mention")

## Manage tenant users and access

Administrators maintain control over identity providers and user credentials to ensure secure access to tenant resources.

* **Configure LDAP or Active Directory:** As Tenant Admin, you can configure and reset LDAP/AD at the tenant scope.
* **Local user management:** Create, update, and delete regular users belonging to the tenant.
* **Credential management:** Manage API tokens and passwords for the tenant's users.

For additional guidance on related topics, consult the standard procedures. These also apply in a tenant-specific context, including:

[user-management](../user-management/ "mention")

## Mount authentication for tenant filesystems

The authentication process guarantees that only authorized users from a particular tenant can access their data. This approach enforces strict separation, blocking users from other tenants and even the Cluster Admin from accessing the filesystems of a specific tenant.

**Key requirements for tenant mounts:**

* **Stateless clients:** Mounting tenant filesystems (other than in the Root tenant) is only supported using stateless clients.
* **Authentication tokens:** Users must obtain a mount token and include it in the mount command.
* **Login requirement:** A login prompt appears during the mount command if the user is not already logged in.

### Authenticate and mount a filesystem

To securely mount a tenant filesystem, users must first authenticate to generate a token.

**Procedure**

1.  **Log in to the WEKA system:** Use the CLI to create an authentication token, which the system saves on the client (default: `~/.weka/auth-token.json`).

    ```bash
    weka user login <username> <password> --tenant <tenant> --HOST <backend-host>
    ```
2.  **Mount the filesystem:** Once authenticated, the mount command automatically uses the token from the default location.

    ```bash
    mount -t wekafs <backend-host>/<filesystem_name> /mnt/weka/<mount_point>
    ```

### Advanced token management

In environments where multiple filesystems for different users or tenants must be mounted on the same server, specify custom token paths using the `auth_token_path` mount option or the `WEKA_TOKEN` environment variable.

{% code overflow="wrap" %}
```bash
mount -t wekafs <backend-host>/<fs_name> /mnt/weka/<mount_point> -o auth_token_path=<path_to_token>
```
{% endcode %}

### Enforce tenant security

Administrators can proactively manage security by revoking access or attaching security guardrails.

#### Revoke user access

Revoking access is a critical security measure when a user leaves the tenant or when a token is suspected of being compromised. This results in:

* **Session termination:** The user is immediately logged out of the tenant.
* **Mount prevention:** Previously saved authentication tokens are no longer valid for new mounts.
* **Data integrity:** Ensures only active, authorized users interact with tenant data.

**Procedure**

1. Identify the user whose access must be revoked within the tenant.
2.  Run the following command to revoke all API tokens for that user:

    ```bash
    weka user revoke-tokens <username> --force
    ```
