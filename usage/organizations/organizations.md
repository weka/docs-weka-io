---
description: This page describes how to manage organizations using the GUI.
---

# Manage organizations using the GUI

Using the GUI, you can:

* [Create an organization](organizations.md#create-an-organization)
* [View organizations](organizations.md#view-organizations)
* [Edit an organization](organizations.md#edit-an-organization)
* [Delete an organization](organizations.md#delete-an-organization)

## Create an organization

Only a Cluster Admin can create an organization.

**Procedure**

1. From the menu, select **Configure > Organizations**.
2. On the Organizations page, select **+Create**.
3. In the Create Organization dialog, set the following properties:
   * **Organization Name:** A name for the organization.
   * **Org. Admin Username**: The user with an Organization Admin role created for the organization.
   * **Org. Admin Password**: The password of the user with an Organization Admin role created for the organization.
   * **Confirm Password**: The same password as set in the Org. Admin Password.
   * **Set Organization SSD Quota**: Turn on the switch and set the SSD capacity limitation for the organization.
   * **Set Organization Total Quota**: Turn on the switch and set the total capacity limitation for the organization (SSD and object store bucket). &#x20;
4. Select **Save**.

![Create an organization](../../.gitbook/assets/wmng\_create\_org.png)

## View organizations

As a Cluster Admin, you can view all organizations in the cluster.&#x20;

As an Organization Admin, you can view only the organization you are assigned to.

**Procedure**

1. From the menu, select **Configure > Organizations**.

![View organization by a Cluster Admin](../../.gitbook/assets/wmng\_view\_organizations.png)

![View organization by an Organization Admin](../../.gitbook/assets/wmng\_view\_by\_org\_admin.png)

## Edit an organization

You can modify an organization's SSD and total quota to meet the capacity demand changes.

**Procedure**

1. From the menu, select **Configure > Organizations**.
2. On the Organizations tab, select the three dots of the organization to edit and select **Edit**.

![Edit organization](../../.gitbook/assets/wmng\_edit\_org\_button.png)

3\. In the Edit Organization dialog, set the following properties:

* **Set Organization SSD Quota**: Turn on the switch and set the SSD capacity limitation for the organization.
* **Set Organization Total Quota**: Turn on the switch and set the total capacity limitation for the organization (SSD and object store bucket). &#x20;

4\. Select **Save**.

![Edit organization dialog](../../.gitbook/assets/wmng\_edit\_org.png)

## Delete an organization

If an organization is no longer required, you can remove it. You cannot remove the root organization.

{% hint style="danger" %}
**Warning:** Deleting an organization is irreversible**.** It removes all entities related to the organization, such as filesystems, object stores, and users.
{% endhint %}

**Procedure**

1. From the menu, select **Configure > Organizations**.
2. On the Organizations tab, select the three dots of the organization to edit and select **Remove**.

![Remove an organization](../../.gitbook/assets/wmng\_remove\_org.png)

3\. In the confirmation message, select **Yes**.
