---
description: Manage custom roles and the actions they grant.
---

# weka rbac

Compose custom RBAC roles from a catalog of named actions.

```sh
weka rbac
```

## weka rbac actions

Browse the catalog of actions an RBAC custom role may be composed from.

```sh
weka rbac actions
```

### weka rbac actions list

Show the catalog of actions a custom role may be composed from.

```sh
weka rbac actions list [--category <category>] [--scope <scope>]
```

| Parameter | Description |
| --------- | ----------- |
| `--category` &lt;category&gt; | Only show actions in this category. |
| `--scope` &lt;scope&gt; | Only show actions at this scope. Defaults to tenant when the caller is seated in a tenant, otherwise shows every scope. |

**Columns:** `name`, `action_scope`, `category`, `description`, `resource`, `verb`

## weka rbac role

Manage RBAC custom roles, composed from a catalog of named actions.

```sh
weka rbac role
```

### weka rbac role add

Add a new custom RBAC role.

```sh
weka rbac role add <name> [--actions <action-names>…] [--shared] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `name`* | Name for the new role. |
| `--actions` &lt;action-names&gt;… | Action names the role grants, in dot (resource.verb) or underscore form. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--shared` | Share the new role across every tenant instead of scoping it to one. Only a role owned by the root tenant may be shared, and sharing one requires the rbac.share action. |
| `--tenant` &lt;tenant&gt; | Tenant (name or id) to act in; defaults to the caller's own. |

### weka rbac role list

Show the list of custom and predefined RBAC roles.

```sh
weka rbac role list [--include-tenants] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `--include-tenants` | Include roles from every tenant. Requires cross-tenant permission; a caller without it sees only their own tenant's roles. May not be combined with --tenant. |
| `--tenant` &lt;tenant&gt; | Tenant (name or id) to act in; defaults to the caller's own. |

**Columns:** `kind`, `name`, `id`, `uid`, `tenant`, `is_shared`, `effective_actions`, `composed_actions`

### weka rbac role remove

Removes an existing custom RBAC role.

```sh
weka rbac role remove <role> [--force] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `role`* | Name or id of the role to remove. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--tenant` &lt;tenant&gt; | Tenant (name or id) to act in; defaults to the caller's own. |

### weka rbac role show

Displays information about a specific RBAC role.

```sh
weka rbac role show <roles>… [--composed] [--include-tenants] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `roles`*… | Names or ids of the roles to show, comma-separated or repeated. |
| `--composed` | Show the role's raw composed action set instead of its effective (post-closure) actions. |
| `--include-tenants` | Include roles from every tenant. Requires cross-tenant permission; a caller without it sees only their own tenant's roles. May not be combined with --tenant. |
| `--tenant` &lt;tenant&gt; | Tenant (name or id) to act in; defaults to the caller's own. |

**Columns:** `kind`, `name`, `id`, `uid`, `tenant`, `is_shared`, `effective_actions`, `composed_actions`

### weka rbac role update

Updates the name or actions of an existing RBAC role.

```sh
weka rbac role update <role> [--actions <action-names>…] [--actions-to-clear <action-names>…] [--new-name <string>] [--override <action-names>…] [--tenant <tenant>]
```

| Parameter | Description |
| --------- | ----------- |
| `role`* | Name or id of the role to update. |
| `--actions` &lt;action-names&gt;… | Append these actions to the role's action set. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--actions-to-clear` &lt;action-names&gt;… | Remove these actions from the role's action set. Naming an action the role does not hold is not an error. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--new-name` &lt;string&gt; | New name for the role. |
| `--override` &lt;action-names&gt;… | Replace the role's action set with exactly these actions. To clear all actions, pass --override= (empty). May not be combined with --actions or --actions-to-clear. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--tenant` &lt;tenant&gt; | Tenant (name or id) to act in; defaults to the caller's own. |
