---
description: >-
  Configure NFS networking, authentication, and client permissions using the
  GUI.
---

# Manage NFS networking using the GUI

## Configure the NFS global settings

NFS global settings consist of parameters that enable you to customize various aspects of the NFS service, including the support of the NFS protocol versions, the types of Kerberos authentication to use, and the port for mount requests and NFS locking.

By tailoring these settings, you can ensure that the NFS service meets your needs and requirements, such as supporting NFS V3 and V4 for compatibility with different client systems.

{% hint style="info" %}
The possible Kerberos authentication types are available only after configuring the Kerberos integration.
{% endhint %}

**Before you begin**

To support NFS file-locking, ensure the system meets the prerequisites outlined in [#nfs-file-locking-support](./#nfs-file-locking-support "mention").

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. On the left pane, select **NFS**.
3. Select the **Settings** tab.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_settings.png" alt=""><figcaption><p>NFS Settings tab</p></figcaption></figure></div>

4. In the Global settings section, select **Update.**

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_cfg_default_global_set.png" alt="" width="563"><figcaption><p>Configure global NFS settings dialog</p></figcaption></figure></div>

5. Set the following:
   * **Config FS**: Select the cluster-wide configuration filesystem that maintains the NFS and Kerberos configurations.
   * **Supported Versions**: Select the NFS versions you want to support based on your needs. Options include V3, V4, or both.
   * **ACL**: Sets the ACL to ON (default) or OFF.
   * **ACL Type**: Defines the default access control method for the share. Options are:
     * **None:** No ACL enforcement or updates, regardless of existing POSIX ACLs.
     * **POSIX** (default): Enforces POSIX ACLs, compatible across protocols, but loses NFSv4's finer granularity.
     * **NFSv4**: Enforces NFSv4 ACLs directly, retaining full granularity, but lacks interoperability with other protocols. (The **NFSv4** flavor is experimental and is not recommended to be used in production environments.)
     * **Hybrid**: Combines both POSIX and NFSv4 ACLs to support interoperability. NFS ensures consistency between the two ACL flavors, and if any inconsistency arises, POSIX ACL is used for enforcement.
   * **Multi-Tenancy:** Enable NFS multi-tenancy so each tenant gets isolated client groups, exports, and floating IP addresses. Requires an NFS container restart to take effect. Several NFS features become available only in the root organization once this is on. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").\
     This toggle is disabled while LDAP or Kerberos authentication is configured. Reset them first.
   *   **Authentication Type**: Enable the authentication types that can be used when setting the NFS client permissions. Possible values:

       * **NONE:** No authentication.
       * **SYS:** System authentication.
       * **KRB5:** Basic Kerberos authentication.
       * **KRB5i:** Kerberos authentication with data integrity.
       * **KRB5p:** Kerberos authentication with data integrity and privacy.

       The Kerberos authentication types are visible only if Kerberos is configured.\
       Example: KRB5 KRB5i KRB5p.\
       The default values depend on Kerberos configuration:

       * If not configured: **SYS**
       * If configured: **KRB5**

* **Mount Port:** Set the port that the mountd service binds to.
* **Lock Manager Port**: Set the port for the network lock manager’s registration.
* **Status Monitor Port:** Set the port for the network status monitor’s registration.
* **Notification Port:** Set the port for the notification’s registration.

{% hint style="success" %}
These ports are only relevant for NFSv3. The default value of 0 indicates using the default published ports.
{% endhint %}

5.  Select **Submit** to apply the settings.

    If you changed **Multi-Tenancy**, the **Restart NFS Containers** dialog opens. Select **Confirm** to restart the NFS containers and apply the change. The restart temporarily interrupts IO for connected NFS clients.

## **Configure the NFS cluster level** <a href="#create-interface-groups" id="create-interface-groups"></a>

Configuring the NFS cluster level involves creating an interface group and assigning at least one server with its corresponding port.

{% hint style="info" %}
When NFS multi-tenancy is enabled, an interface group also serves the floating IP addresses of the tenants assigned to it. Use **Assign Tenant** on the interface group's detail view to assign or move a tenant, and the **Tenant** column on the namespaces table to see and remove existing assignments. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

**INTERNAL, remove before publication. TBD (Docs):** captures needed for the multi-tenancy screens on this page: the Restart NFS Containers dialog, the Assign Tenant dialog on the interface-group detail view, and the namespaces table showing the Tenant column with its per-row Remove action.

### Create an interface group <a href="#create-interface-groups" id="create-interface-groups"></a>

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From Protocols, select **NFS**.
3. In the Configuration tab, select **Configure**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_conf_fsg_button.png" alt="Add an NFS interface group"></div>

4. In the Create Interface Group dialog, set the following properties:
   * **Name**: A unique interface group name (maximum 11 characters).
   * **Gateway**: A valid IP address of the gateway.
   * **Subnet mask**: The subnet mask in CIDR (Classless Inter-Domain Routing) format. For example, a value of 16 equals 255.255.0.0.
5. Select **Create**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_create_interface_group.png" alt="Create interface group dialog"></div>

### Set interface group ports

After creating an interface group, set the ports for this group to establish the NFS cluster. You can only set these ports on frontend containers. To ensure system resiliency, have at least two NFS servers in place.

Repeat this port setting process for each server participating in the NFS cluster.

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group Ports table, select **Add**.
3. In the Add Port dialog, set the following properties:
   * **Hostname**: Select the server on which the port resides.
   * **Port:** Select the port from the list.
4. Select **Submit**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_add_port.png" alt="Add port dialog"></div>

**Example**

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_cluster_servers_example.png" alt=""><figcaption><p>Example: Three servers participate in the NFS cluster</p></figcaption></figure></div>

### Remove an interface group port

You might need to remove an interface group due to a change in network configuration, for efficiency, for troubleshooting, during network reorganization, or to replace it with a more suitable group. Always check that the group isn’t in use before you remove it to avoid disruptions.

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group Ports table, select the three dots, then **Remove**.

### **Set interface group IPs**

{% hint style="info" %}
Floating IPs are not supported in WEKA installations on Azure and GCP.
{% endhint %}

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group IPs table, select **Add**.
3. In the Add Range IP dialog, set the relevant IP range.
4. Select **Submit**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_add_group_IPs.png" alt="Add range IP dialog"></div>

### Remove an interface group IP range

**Procedure**

1. In the Configuration tab, select the interface group.
2. In the Group IPs table, select the three dots, then **Remove**.

## Integrate the NFS and Kerberos service

Integrating the NFS and Kerberos service is critical to setting up a secure network communication process. This procedure involves defining the Key Distribution Center (KDC) details, administrative credentials, and other parameters to ensure a robust and secure authentication process.

**Before you begin**

* Ensure a configuration filesystem is set. See [#configure-the-nfs-global-settings](nfs-support.md#configure-the-nfs-global-settings "mention").
* Ensure the NFS cluster is configured and running. See [#create-interface-groups](nfs-support.md#create-interface-groups "mention").
* For Active Directory (AD) integration, obtain the required information from the AD administrator. (WEKA handles the generation of the keytab file.)
* For MIT integration, obtain the required information from the MIT KDC and OpenLDAP administrators, and a pre-generated keytab file stored in an accessible location is required.

{% hint style="info" %}
In all KDC and LDAP parameters, use the FQDN format. The hostname part of the FQDN is restricted to a maximum of 20 characters.
{% endhint %}

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. Select **NFS** from **Protocols**.
3. Select the **Settings** tab.
4. In the Kerberos Authentication section, select **Configure**.

{% hint style="info" %}
Configuring the NFS-Kerberos service integration automatically restarts the NFS containers, leading to a temporary disruption in the IO service for connected NFS clients.
{% endhint %}

5. Choose the tab that matches your authentication method and follow its instructions.

{% tabs %}
{% tab title="Configure Kerberos service with AD" %}
1) From the Kerberos Authentication Type, select Active Directory (AD).
2) Set the following parameters to configure the Kerberos with AD KDC servers:
   * **KDC Realm Name**: Specifies the realm (domain) used by Kerberos.
   * **KDC Primary Server**: Identifies the server hosting the primary Key Distribution Center service.
   * **KDC Secondary Server**: Identifies the server hosting the secondary Key Distribution Center service.
   * **KDC Admin Server**: Identifies the server hosting the administrative Key Distribution Center service.
3) Set the following parameters to register the Kerberos service:
   * **NFS Service Name**: This refers to the complete domain name for a specific NFS server.
   * **KDC Realm Admin Name**: The username of an administrator who has access to the LDAP directory. This user manages the KDC within a realm.
   * **KDC Realm Admin Password**: The password of the administrative user who manages the KDC within a realm.
   * **Base OU:** The LDAP organizational unit where the NFS server's computer account is created in Active Directory, in distinguished-name form. For example, `OU=Weka,OU=Servers`. Default: `CN=Computers`.
4) Select **Configure** to apply the changes.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_conf_kerb_auth_AD.png" alt=""><figcaption><p>Configure Kerberos authentication over AD dialog</p></figcaption></figure></div>
{% endtab %}

{% tab title="Configure Kerberos service with MIT" %}
1. In From the Kerberos Authentication Type, select MIT.
2. Set the following parameters to the MIT KDC servers:
   1. **KDC Realm Name**: Specifies the realm (domain) used by Kerberos.
   2. **KDC Primary Server**: Identifies the server hosting the primary Key Distribution Center service.
   3. **KDC Secondary Server**: Identifies the server hosting the secondary Key Distribution Center service.
   4. **KDC Admin Server**: Identifies the server hosting the administrative Key Distribution Center service.
3. Set the following parameters to register the Kerberos with LDAP service and uploaded keytab file:
   * **NFS Service Name**: This refers to the complete domain name for a specific NFS server.
   * **Upload keytab file**: Use the **Browse** option to upload the pre-generated keytab file. This file contains the keys for the NFS service’s unique identity, known as a principal, in Kerberos.
   * **LDAP Server**: Specifies the server hosting the Lightweight Directory Access Protocol service.
   * **LDAP Domain**: Defines the domain that the Lightweight Directory Access Protocol service will access.
   * **LDAP Reader User Name**: The username of an administrative user, used to generate the keytab file.
   * **LDAP Reader User Password**: The password of the administrative user.
   * **LDAP Base DN**: The base Distinguished Name (DN) for the Lightweight Directory Access Protocol directory tree.
   * **LDAP Port**: The port number on which the Lightweight Directory Access Protocol server listens.
4. Select **Configure** to apply the changes.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_conf_kerb_auth_MIT.png" alt=""><figcaption><p>Configure Kerberos authentication over MIT dialog</p></figcaption></figure></div>
{% endtab %}
{% endtabs %}

{% hint style="info" %}
After completing the kerberos integration settings, the enabled authentication type is **KRB5**. If you want to modify the enabled authentication types, in the Configure NFS Global Settings, select **Update**, and set the authentication types. See [#configure-the-nfs-global-settings](nfs-support.md#configure-the-nfs-global-settings "mention").
{% endhint %}

### **Reset the** Kerberos configuration <a href="#create-interface-groups" id="create-interface-groups"></a>

Resetting the Kerberos configuration is necessary when you need to completely remove the Kerberos service configuration data. Once the data is removed, you can set up a new Kerberos service integration.

Upon resetting the Kerberos configuration, it triggers the following two actions:

* The NFS containers are restarted, leading to a temporary disruption in the I/O service for connected NFS clients.
* The authentication types in the NFS Global Settings are reset to their default values.

{% hint style="info" %}
These actions may impact your system’s performance and functionality. Proceed with caution.
{% endhint %}

## Configure the LDAP service

Configure the LDAP service for NFS to manage user access and permissions efficiently. You can set up the configuration to use Active Directory (AD) LDAP for Access Control Lists (ACLs) when Kerberos is not in use, or configure it for OpenLDAP.

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. Select **NFS** from **Protocols**.
3. Select the **Settings** tab.
4. In the **LDAP Service** section, select **Configure**.

{% hint style="warning" %}
When you configure the LDAP settings, it restarts the NFS containers, temporarily interrupting the IO service for connected NFS clients.
{% endhint %}

5. Select the **LDAP type** that corresponds to your environment and follow the relevant steps below.

{% tabs %}
{% tab title="Configure for Active Directory" %}
Use this option when Active Directory provides LDAP-based ACL support and Kerberos is not configured.

1. **LDAP Type:** Select Active Directory.
2. Set the following parameters:
   * **LDAP Server:** The Fully Qualified Domain Name (FQDN) of the AD server. Example: `myldapserver.example.com`
   * **LDAP Domain:** The AD domain name. Example: `myldapdomain.example.com`
   * **LDAP FQDN Service Name:** The FQDN of the NFS service. Example: `nfs-service-name.test.domain.com`
   * **LDAP Admin Name:** The administrative username for accessing the LDAP directory. Specify the account name only. Example: `orgadmin`
   * **LDAP Admin Password:** The password for the administrative user.
3. Select **Configure**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS-conf-ldap.png" alt=""><figcaption></figcaption></figure></div>
{% endtab %}

{% tab title="Configure for OpenLDAP" %}
Use this option when an OpenLDAP server provides the directory service for NFS.

1. LDAP Type: Select **Open LDAP**.
2. Set the following parameters:
   * **LDAP Server:** The server hosting the LDAP service. Example: `myldapserver.example.com`
   * **LDAP Domain:** The domain the LDAP service will access. Example: `myldapdomain.example.com`
   * **LDAP Reader User Name:** The username of the administrative user. Example: `orgadmin`
   * **LDAP Reader User Password:** The password for the administrative user.
   * **LDAP Base DN:** The base Distinguished Name (DN) for the LDAP directory tree. Example: `dc=test,dc=example,dc=com`
   * **LDAP Port:** The port number the LDAP server listens on. Default: `389`
3. Select **Configure**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS-conf-openldap.png" alt=""><figcaption></figcaption></figure></div>
{% endtab %}

{% tab title="On Host LDAP" %}
Use this option when the LDAP service runs locally on the NFS server.

1. LDAP Type: Select **On Host LDAP**.
2. In LDAP Domain, select the server hosting the LDAP service.\
   Example: `myldapserver.example.com`

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_conf_on_host_ldap.png" alt=""><figcaption></figcaption></figure></div>
{% endtab %}
{% endtabs %}

## Configure the NFS export level (permissions)

### Create client access groups <a href="#define-client-access-groups" id="define-client-access-groups"></a>

Creating additional client groups helps in better organization, customization of settings, and enhanced security by segregating access levels.

**Procedure**

1. In the Permissions tab, select the **+** sign near the Client Groups title.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_add_client_group_button.png" alt="5Add a client group"></div>

2. In the Create Client Group dialog, set **Client Group Name**. This user-defined logical label groups client servers so you can apply common NFS export permissions to them as a unit.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_client_group_dialog.png" alt="Create client group dialog"></div>

3. Select **Create**.

### Assign a DNS and IP to a client group

Assigning a DNS and IP to a client group facilitates network communication and resource access. This step is crucial for the group’s operational functionality.

**Procedure**

1. In the NFS configuration, select the **Permissions** tab.
2. In the Permissions tab, select **Add DNS** for the relevant Client Group.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_client_group_dns-ip-buttons.png" alt="Manage client access groups"></div>

3. In the Create Client Group DNS Rule dialog, set the DNS server name. Then, select **Create**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_client_group_dns_rule.png" alt="Create client group DNS rule dialog" width="375"></div>

4. In the Permissions tab, select **Add IP** for the relevant Client Group.
5. In the Create Client Group IP Rule dialog, set the IP address and bitmask. These values define the client IP range allowed to connect through NFS.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_client_group_ip.png" alt="Create client group IP rule dialog" width="375"></div>

### Remove the DNS or IP of a client group

Remove a DNS or IP rule when a client server is decommissioned, moves networks, or no longer requires NFS access through this client group.

**Procedure**

1. In the Permissions tab, hover on the IP or DNS for the relevant Client Group, and select **Delete Rule.**

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_group_ip_remove.png" alt="Remove the DNS or IP of a client group" width="375"></div>

### Create NFS client permission <a href="#create-nfs-client-permission" id="create-nfs-client-permission"></a>

Creating NFS permissions for a client group enhances access control and efficiency. It allows system administrators to manage access to files, protecting sensitive data and simplifying permission management.

NFS permissions also provide flexibility and foster collaboration. They can be adjusted as needed, especially when a team needs to work on the same files. However, they work best in trusted environments.

**Before you begin**

If you create an NFS v4 client permission, verify that a global configuration filesystem is already set in the system. See [#configure-the-nfs-global-settings](nfs-support.md#configure-the-nfs-global-settings "mention").

**Procedure**

1. In the Permissions table, select **Create**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_add_client_permissions.png" alt="Permissions table"></div>

2. In the Create NFS Permission dialog, set the following properties:
   * **Client Group**: The client group to which the permissions are applied.
   * **Filesystem**: The filesystem to which the permissions are applied. A filesystem with Required Authentication set to ON cannot be used for NFS client permissions.
   * **Path**: The shared directory path (root share).
   * **Type**: The access type: RO (read-only) or RW (read/write).
   * **Priority:** Permissions are processed in ascending priority order during access evaluation, beginning with the lowest number. If a client matches multiple permission entries, the entry with the highest priority number determines the effective permission. Using a numbering system in tens (10, 20, 100) is advisable to facilitate the addition of priorities between existing ones.
   * **Supported Versions:** The supported NFS versions (V3, V4, or both).
   * **User Squash**: The system enforces squash mode with the client's permission.
   * **Authentication Types:** The method of authentication. The enabled authentication types in the NFS global settings determine the possible options and the default.\
     Examples:
     * Enabled types: NONE, SYS, KRB5, KRB5i, KRB5p. Default: KRB5.
     * Enabled types: NONE, SYS. Default: SYS.
     * Enabled types: NONE, SYS, KRB5i, KRB5p. Default: KRB5i.
   * **Anon. UID**: Anonymous user ID. Only relevant for Root and All user squashing.
   * **Anon. GID:** Anonymous group ID. Only relevant for Root and All user squashing.
3. Select **Submit**.

<div data-with-frame="true"><img src="../../.gitbook/assets/NFS_create_permissions_dialog.png" alt="Create NFS permission"></div>

### Edit NFS client permission <a href="#edit-nfs-client-permission" id="edit-nfs-client-permission"></a>

You can edit the existing NFS permission settings for a client group. You can also move the priority to the top or bottom priority (related to other client group priorities). If the client group permission setting is no longer required, you can remove it.

**Procedure**

1. In the Permissions table, select the three dots of the client group to edit, and select **Edit**.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_edit_permissions.png" alt=""><figcaption><p>Edit a client group permissions</p></figcaption></figure></div>

2. Set the relevant properties: Type, Priority, Supported Versions, Squash Root, Authentication Type, Anon. UID, and Anon. GID. Then, select **Submit**.
3. To move the priority of a client group setting to the top or bottom priority, select **Move to top priority** or **Move to bottom priority**.
4. To remove the client group permission setting, select **Remove**.

**Related topics**

[supported-nfs-client-mount-options.md](supported-nfs-client-mount-options.md "mention")
