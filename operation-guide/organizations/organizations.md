---
description: Explore how to manage organizations using the GUI.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/operation-guide/organizations/organizations
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
   * **Set Organization Total Quota**: Turn on the switch and set the total capacity limitation for the organization (SSD and object store bucket).
4. Select **Save**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_create_org.png" alt="Create an organization" width="268"></div>

## View organizations

As a Cluster Admin, you can view all organizations in the cluster.

As an Organization Admin, you can view only the organization you are assigned to.

**Procedure**

1. From the menu, select **Configure > Organizations**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_view_organizations.png" alt="View organization by a Cluster Admin"></div>

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_view_by_org_admin.png" alt="View organization by an Organization Admin"></div>

## Edit an organization

You can modify an organization's SSD and total quota to meet the capacity demand changes.

**Procedure**

1. From the menu, select **Configure > Organizations**.
2. On the Organizations tab, select the three dots of the organization to edit and select **Edit**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_edit_org_button.png" alt="Edit organization"></div>

3\. In the Edit Organization dialog, set the following properties:

* **Set Organization SSD Quota**: Turn on the switch and set the SSD capacity limitation for the organization.
* **Set Organization Total Quota**: Turn on the switch and set the total capacity limitation for the organization (SSD and object store bucket).

4\. Select **Save**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_edit_org.png" alt="Edit organization dialog" width="266"></div>

## Delete an organization

If an organization is no longer required, you can remove it. You cannot remove the root organization.

{% hint style="danger" %}
Deleting an organization is irreversibl&#x65;**.** It removes all entities related to the organization, such as filesystems, object stores, and users.
{% endhint %}

**Procedure**

1. From the menu, select **Configure > Organizations**.
2. On the Organizations tab, select the three dots of the organization to edit and select **Remove**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_remove_org.png" alt="Remove an organization"></div>

3\. In the confirmation message, select **Yes**.
