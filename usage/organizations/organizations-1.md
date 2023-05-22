---
description: This page describes how to manage organizations using the CLI.
---

# Manage organizations using the CLI

Using the CLI, you can:

* [Create an organization](organizations-1.md#create-an-organization)
* [View organizations](organizations-1.md#view-organizations)
* [Rename an organization](organizations-1.md#rename-an-organization)
* [Update the quota of an organization](organizations-1.md#update-the-quota-of-an-organization)
* [Delete an organization](organizations-1.md#delete-an-organization)

## Create an organization

**Command:** `weka org create`

Use the following command line to create an organization:

`weka org create <name> <username> <password> [--ssd-quota ssd-quota] [--total-quota total-quota]`

**Parameters**

| Name          | Value                                                                | Default         |
| ------------- | -------------------------------------------------------------------- | --------------- |
| **Name**      | **Value**                                                            | **Default**     |
| `name`\*      | Valid organization name.                                             |                 |
| `username`\*  | Valid username of the created Organization Admin.                    |                 |
| `password`\*  | Password of the created Organization Admin.                          |                 |
| `ssd-quota`   | Allowed quota out of the system SSDs to be used by the organization. | 0 (not limited) |
| `total-quota` | Total allowed quota for the organization (SSD and object store).     | 0 (not limited) |

## View organizations

**Command:** `weka org`

```
# weka org

ID | Name       | Allocated SSD | SSD Quota | Allocated Total | Total Quota
---+------------+---------------+-----------+-----------------+-------------
0  | Root       | 0 B           | 0 B       | 0 B             | 0 B
1  | Local IT   | 500.00 GB     | 500.00 GB | 500.00 GB       | 0 B
2  | CUSTOMER_1 | 100.00 GB     | 300.00 GB | 200.00 GB       | 900.00 GB
```

## **Rename an organization**

**Command:** `weka org rename`

Use the following command line to rename an organization:

`weka org rename <org> <new-name>`

**Parameters**

| Name         | Value                            |
| ------------ | -------------------------------- |
| `org`\*      | Current organization name or ID. |
| `new-name`\* | New organization name.           |

## Update the quota of an organization

**Command:** `weka org set-quota`

Use the following command line to update an organization's quota:

`weka org set-quota <org> [--ssd-quota ssd-quota] [--total-quota total-quota]`

**Parameters**

| Name          | Value                                                                                   |
| ------------- | --------------------------------------------------------------------------------------- |
| **Name**      | **Value**                                                                               |
| `org`\*       | <p>Organization name or ID.<br>The root organization (org ID = 0 cannot be limited)</p> |
| `ssd-quota`   | Allowed quota out of the system SSDs to be used by the organization                     |
| `total-quota` | Total allowed quota for the organization (SSD and object store)                         |

## Delete an organization

**Command:** `weka org delete`

Use the following command line to delete an organization:

`weka org delete <org>`

{% hint style="danger" %}
**Warning:** Deleting an organization is irreversible. It removes all entities related to the organization, such as filesystems, object stores, and users.
{% endhint %}

**Parameters**

| Name    | Value                    |
| ------- | ------------------------ |
| `org`\* | Organization name or ID. |



**Related topics**

[organizations-2.md](organizations-2.md "mention")
