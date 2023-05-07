---
description: >-
  This page describes the management of users licensed to work with the WEKA
  system.
---

# Manage users using the GUI

Using the GUI, you can:

* [Manage local users](user-management.md#manage-local-users)
* [Manage user directory](user-management.md#manage-user-directory)

## Manage local users

Local users are created in the local system as opposed to domain users that are managed by the organization's User Directory. You can create up to 1152 local users to work with a WEKA system cluster.

![User Management: Local Users page](../../.gitbook/assets/wmng\_local\_users.png)

### Create a local user

**Procedure**

1. From the menu, select **Configure > User Management**.
2. In the Local Users tab, select **+Create**.
3. In the Create New User dialog, set the following properties:
   * **Username:** Set the user name for the local user.
   * **Password:** Set a password according to the requirements. The password must contain at least 8 characters, an uppercase letter, a lowercase letter, and a number or a special character.
   * **Confirm Password:** Type the same password again.
   * **Role:** Select the role for the local user. If you select an S3 user role, you can select the relevant S3 policy, POSIX UID, and POSIX GID.
4. Select **Save**.

![Create new user dialog](../../.gitbook/assets/wmng\_local\_users\_add.png)

### Edit a local user

You can modify the role of a local user, but not your own role (the signed-in user). For an S3 user, you can only modify the S3 policy, POSIX UID, and POSIX GID.

**Procedure**

1. In the Local Users tab, select the three dots of the local user you want to edit, then select **Edit User**.
2. From the Role property, select the required role. If you modify the role to S3, you can set the S3 policy, POSIX UID, and POSIX GID.
3. Select **Save**.

![Edit a local user](../../.gitbook/assets/wmng\_local\_users\_edit.png)

### Change a local user password

As a Cluster Admin or Organization Admin, you can change the password of a local user and revoke the user's tokens.

**Procedure**

1. In the Local Users tab, select the three dots of the local user you want to change the password for, then select **Change Password**.
2. In the Change Password for a user dialog, set the following properties:
   * **Old password:** Set the old password.
   * **Password:** Set a new password according to the requirements.
   * **Confirm Password:** Type the same new password again.
   * **Revoke Tokens:** If the user's existing tokens are compromised, you can revoke all the user's tokens along with changing the user's password. To re-access the system, the user re-authenticates with the new password, or the user needs to obtain new tokens using the API.
3. Select **Save**.

![Change password for a local user](../../.gitbook/assets/wmng\_local\_users\_change\_psw.png)

### Change your own password

You can change your own password at any time.

**Procedure**

1. From the top bar, select the signed-in user, then select **Change Password**.

![Change your own password (signed-in user)](../../.gitbook/assets/wmng\_change\_your\_password.png)

2\. In the Change Password dialog set the properties as described in the [Change a local user password](user-management.md#change-a-local-user-password) topic.

3\. Select **Save**.

### Revoke local user tokens

If the user's existing tokens are compromised, you can revoke all the user's tokens, regardless of changing the user's password. To re-access the system, the user re-authenticates with the new password, or the user needs to obtain new tokens using the API.

**Procedure**

1. In the Local Users tab, select the three dots of the local user you want to revoke the user tokens, then select **Revoke User Tokens**.

![Revoke a local user tokens](../../.gitbook/assets/wmng\_revoke\_user\_tokens\_menu.png)

2\. In the confirmation message, select **Revoke Tokens**.

### Remove a local user

You can remove a local user that is no longer required.

**Procedure**

1. In the Local Users tab, select the three dots of the local user to remove, then select **Remove User**.

![Remove a local user](../../.gitbook/assets/wmng\_remove\_user\_menu.png)

2\. In the confirmation message, select **Yes**.

## Manage user directory

You can set user access to the Weka system from the organization user directory, either by LDAP directory or Active Directory.

![User directory tab](../../.gitbook/assets/user\_directory\_tab\_no\_conf.png)

### Configure LDAP

To use LDAP directory for authenticating users, you need to configure the corresponding values in the LDAP Configuration dialog.

**Procedure**

1. From the menu, select **Configure > User Management**.
2. Select the User Directory tab.
3. Select **Configure LDAP**.
4. Set all properties according to the organization's LDAP details.
5. Select **Save**.

![Configure LDAP](../../.gitbook/assets/wmng\_configure\_ldap.png)

Once the LDAP configuration completes, the User Directory tab displays the details. You can disable the LDAP configuration, update the configuration, or reset the configuration values.

![LDAP configuration](<../../.gitbook/assets/wmng\_ldap\_configuration\_result (1).png>)

### Configure Active Directory

To use Active Directory for authenticating users, you configure the corresponding values in the Active Directory Configuration dialog.

**Procedure**

1. From the menu, select **Configure > User Management**.
2. Select the User Directory tab.
3. Select **Configure Active Directory**.
4. Set all properties according to the organization's Active Directory details.
5. Select **Save**.

![Configure Active Directory dialog](../../.gitbook/assets/wmng\_configure\_active\_directory.png)

Once the Active Directory configuration completes, the User Directory tab displays the details. You can disable the Active Directory configuration, update the configuration, or reset the configuration values.

![Active Directory configuration](../../.gitbook/assets/wmng\_active\_directory\_dialog.png)
