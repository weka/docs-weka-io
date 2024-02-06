---
description: Explore how to manage organizations using the CLI.
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

<table><thead><tr><th width="202">Name</th><th>Value</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Value</strong></td><td><strong>Default</strong></td></tr><tr><td><code>name</code>*</td><td>Valid organization name.</td><td></td></tr><tr><td><code>username</code>*</td><td>Valid username of the created Organization Admin.</td><td></td></tr><tr><td><code>password</code>*</td><td>Password of the created Organization Admin.</td><td></td></tr><tr><td><code>ssd-quota</code></td><td>Allowed quota out of the system SSDs to be used by the organization.</td><td>0 (not limited)</td></tr><tr><td><code>total-quota</code></td><td>Total allowed quota for the organization (SSD and object store).</td><td>0 (not limited)</td></tr></tbody></table>

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

<table><thead><tr><th width="245">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Current organization name or ID.</td></tr><tr><td><code>new-name</code>*</td><td>New organization name.</td></tr></tbody></table>

## Update the quota of an organization

**Command:** `weka org set-quota`

Use the following command line to update an organization's quota:

`weka org set-quota <org> [--ssd-quota ssd-quota] [--total-quota total-quota]`

**Parameters**

<table><thead><tr><th width="215">Name</th><th>Value</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Value</strong></td></tr><tr><td><code>org</code>*</td><td>Organization name or ID.<br>The root organization (org ID = 0 cannot be limited)</td></tr><tr><td><code>ssd-quota</code></td><td>Allowed quota out of the system SSDs to be used by the organization</td></tr><tr><td><code>total-quota</code></td><td>Total allowed quota for the organization (SSD and object store)</td></tr></tbody></table>

## Delete an organization

**Command:** `weka org delete`

Use the following command line to delete an organization:

`weka org delete <org>`

{% hint style="danger" %}
Deleting an organization is irreversible. It removes all entities related to the organization, such as filesystems, object stores, and users.
{% endhint %}

**Parameters**

<table><thead><tr><th width="221">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Organization name or ID.</td></tr></tbody></table>



**Related topics**

[organizations-2.md](organizations-2.md "mention")
