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

| **Name**      | T**ype** | **Value**                                                           | **Limitations**        | **Mandatory** | **Default**     |
| ------------- | -------- | ------------------------------------------------------------------- | ---------------------- | ------------- | --------------- |
| `name`        | String   | Organization name                                                   | Must be a valid name   | Yes           |                 |
| `username`    | String   | Username of the created Organization Admin                          | Must be a valid name   | Yes           |                 |
| `password`    | String   | Password of the created Organization Admin                          |                        | Yes           |                 |
| `ssd-quota`   | Number   | Allowed quota out of the system SSDs to be used by the organization | Must be a valid number | No            | 0 (not limited) |
| `total-quota` | Number   | Total allowed quota for the organization (SSD and object store)     | Must be a valid number | No            | 0 (not limited) |

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

| **Name**   | **Type**       | **Value**                       | **Limitations** | **Mandatory** | **Default** |
| ---------- | -------------- | ------------------------------- | --------------- | ------------- | ----------- |
| `org`      | String/Integer | Current organization name or ID |                 | Yes           |             |
| `new-name` | String         | New organization name           |                 | Yes           |             |

## Update the quota of an organization

**Command:** `weka org set-quota`

Use the following command line to update an organization's quota:

`weka org set-quota <org> [--ssd-quota ssd-quota] [--total-quota total-quota]`

**Parameters**

| **Name**      | **Type**       | **Value**                                                           | **Limitations**                                      | **Mandatory** | **Default** |
| ------------- | -------------- | ------------------------------------------------------------------- | ---------------------------------------------------- | ------------- | ----------- |
| `org`         | String/Integer | Organization name or ID                                             | The root organization (org ID = 0 cannot be limited) | Yes           |             |
| `ssd-quota`   | Number         | Allowed quota out of the system SSDs to be used by the organization | Must be a valid number                               | No            |             |
| `total-quota` | Number         | Total allowed quota for the organization (SSD and object store)     | Must be a valid number                               | No            |             |

## Delete an organization

**Command:** `weka org delete`

Use the following command line to delete an organization:

`weka org delete <org>`

{% hint style="danger" %}
**Warning:** Deleting an organization is irreversible. It removes all entities related to the organization, such as filesystems, object stores, and users.
{% endhint %}

**Parameters**

| **Name** | **Type**       | **Value**               | **Limitations** | **Mandatory** | **Default** |
| -------- | -------------- | ----------------------- | --------------- | ------------- | ----------- |
| `org`    | String/Integer | Organization name or ID |                 | Yes           |             |



**Related topics**

[organizations-2.md](organizations-2.md "mention")
