---
description: >-
  Create, update, assign, and remove custom RBAC roles using the CLI, and list
  the actions a role can grant.
---

# Manage custom roles using the CLI

Create custom roles that grant specific actions, assign them to users, and keep them up to date.

**Before you begin**

Log in as a Cluster Admin, or as a Tenant Admin to manage the custom roles of your own tenant.

## List the available actions

List the actions that a custom role can be composed from.

**Procedure**

1. List all actions:

```sh
weka rbac actions list
```

2. Optional: filter by category or scope.

```sh
weka rbac actions list --category <category> --scope <scope>
```

The output shows the action name, scope, category, description, resource, and verb. Without `--scope`, a user in a tenant sees the actions at tenant scope, and other users see every scope.

## Create a custom role

**Procedure**

1. Create the role and name the actions it grants.

```sh
weka rbac role add <name> --actions <action-names>
```

| Parameter   | Description                                                                                                                                               |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*    | Name of the new role.                                                                                                                                     |
| `--actions` | Actions the role grants, in `resource.verb` form (or with an underscore in place of the dot). Separate several actions with commas, or repeat the option. |
| `--shared`  | Share the role with every tenant. Only a role owned by the root tenant can be shared, and sharing requires the `rbac.share` action.                       |
| `--tenant`  | Tenant (name or ID) in which to create the role. Default: your own tenant.                                                                                |

**Example**

```sh
weka rbac role add quota-operator --actions filesystem.view,quota.manage
```

2. Verify the role:

```sh
weka rbac role show quota-operator
```

## View roles

```sh
weka rbac role list [--include-tenants] [--tenant <tenant>]
weka rbac role show <roles> [--composed]
```

* `weka rbac role list` shows the predefined and custom roles. Use `--include-tenants` to include the roles of every tenant. This requires a cross-tenant permission.
* `weka rbac role show` shows the actions each role grants. Use `--composed` to show the actions that you set on the role, without the actions the system adds.

{% hint style="info" %}
For a predefined role, the list shows only the actions that can be composed into a custom role. Some operations of a predefined role have no matching action and do not appear.
{% endhint %}

## Update a custom role

**Procedure**

1. Update the role. Use one of the following forms:

```sh
weka rbac role update <role> --actions <action-names>
weka rbac role update <role> --actions-to-clear <action-names>
weka rbac role update <role> --override <action-names>
weka rbac role update <role> --new-name <name>
```

| Parameter            | Description                                                                                                                                                                   |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--actions`          | Adds these actions to the role.                                                                                                                                               |
| `--actions-to-clear` | Removes these actions. Naming an action that the role does not hold is not an error.                                                                                          |
| `--override`         | Replaces the actions of the role with exactly these actions. Pass `--override=` with no value to remove all actions. Do not combine with `--actions` or `--actions-to-clear`. |
| `--new-name`         | Renames the role.                                                                                                                                                             |
| `--tenant`           | Tenant (name or ID) of the role. Default: your own tenant.                                                                                                                    |

Changes apply to users on their next request. Users do not need to sign in again.

## Assign custom roles to a user

**Procedure**

1. Create the user with a custom role, a predefined role, or a comma-separated mix.

```sh
weka user add <username> <role> [<password>]
```

**Example**

```sh
weka user add jsmith quota-operator
weka user add pjones readonly,quota-operator
```

2. Optional: change the roles of an existing user.

```sh
weka user update <username> --role <roles>
```

The new roles replace the custom roles of the user. If you name only a predefined role, the user loses every custom role. If you name only custom roles, the predefined role of the user stays unchanged.

3. Verify the roles of the user:

```sh
weka user
```

The **Role** column lists the custom roles of each user after the built-in role. With --verbose, the output also includes a separate **customRoles** column.

## Remove a custom role

**Procedure**

1. Remove the role.

```sh
weka rbac role remove <role> [--force]
```

{% hint style="warning" %}
Removing a role deletes its details permanently. The command asks for confirmation unless you use `--force`.
{% endhint %}

The command is refused while any user holds the role. Remove the role from those users first.

**Related topics**

[.](./ "mention")

[user-management-1.md](user-management-1.md "mention")
