---
description: >-
  Manage snapshot policies using the CLI, ensuring efficient data protection and
  disaster recovery.
---

# Manage snapshot policies using the CLI

## Overview

Creating policies using the CLI involves leveraging policy templates for efficient and consistent policy management that align with organizational requirements.

**Process overview:**

1. **Export an existing policy to a template**:\
   The first step in creating a policy template is exporting an existing policy. If this is your first time, you can use the `sys-default` policy (json file), a predefined system policy that serves as a baseline. The `sys-default` policy is not editable, so it is ideal for use as an initial template.
2. **Edit the exported policy template**:\
   After exporting the `sys-default` policy, you can modify the exported json file to suit your specific requirements. This customization allows you to create tailored templates for different groups of policies, streamlining policy creation for various scenarios.
3. **Create a policy from a policy template**:\
   Create a new policy from the desired policy template and customize it further as needed to address specific use cases. This approach provides flexibility while ensuring consistency across policies derived from the same template.
4. **Attach filesystems to a snapshot policy**:\
   Attach the relevant filesystems to the snapshot policy to ensure that the policy governs the creation, management, and retention of snapshots for these specific filesystems. This step links the policy to the filesystems, enabling consistent enforcement of snapshot rules and schedules.

After understanding the workflow for creating policies using the CLI, you can use the following commands to manage snapshot policies:

* List snapshot policies
* Show snapshot policy details
* Export snapshot policy
* Create snapshot policy
* Attach filesystems to a snapshot policy
* Detach filesystems from a snapshot policy
* Update snapshot policy
* Delete snapshot policy

## List snapshot policies

**Command:** `weka fs protection snapshot-policy list`

This command displays a list of all existing snapshot policies in the system. The output includes details such as the policy ID, name, enabled status, description, and any filesystems the policy is attached to.

```sh
weka fs protection snapshot-policy list
```

<details>

<summary>Example: List snapshot policies</summary>

```bash
$ weka fs protection snapshot-policy list
SNAPSHOT POLICY ID  NAME         IS ENABLED  DESCRIPTION                                                                                         ATTACHED FILESYSTEMS
0                   sys-default  True        This snapshot policy is a fixed example configuration, it can be used as-is but cannot be modified
1                   weekly       True        Create a snapshot weekly on Saturdays                                                               fs1
2                   Policy1      True        Schedule daily snapshots                                                                            fs1, default
```

</details>

## Show snapshot policy details

**Command:** `weka fs protection snapshot-policy show`

This command displays the configuration of a snapshot policy in JSON format. It provides a detailed representation of the policy, including schedules (hourly, daily, weekly, monthly, and periodic), retention settings, associated filesystems, and whether specific features are enabled.

**JSON overview**

* **Schedules**: Defines hourly, daily, weekly, monthly, and periodic snapshot schedules, including time, days, and upload settings.
* **Retention**: Specifies the number of snapshots to retain for each schedule type.
* **Filesystems**: Lists the filesystems attached to the policy.
* **General settings**: Includes the policy name, description, and enable/disable status.

```sh
weka fs protection snapshot-policy show <name>
```

**Parameters**

<table><thead><tr><th width="272">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Policy name</td></tr></tbody></table>

<details>

<summary>Example: Show snapshot policy details</summary>

```
$ weka fs protection snapshot-policy show Policy1
{
    "daily": {
        "days": "monday, wednesday, friday",
        "enable": true,
        "retention": 7,
        "time": "22:05",
        "upload": "local"
    },
    "description": "Policy description",
    "enabled": true,
    "filesystems": [
        "fs1",
        "default"
    ],
    "hourly": {
        "days": "monday, tuesday, wednesday, thursday, friday",
        "enable": false,
        "hours": "09, 10, 11, 12, 13, 14, 15, 16, 17, 18",
        "minuteOffset": 10,
        "retention": 10,
        "upload": "none"
    },
    "monthly": {
        "days": "07",
        "enable": false,
        "months": "all",
        "retention": 12,
        "time": "00:05",
        "upload": "local"
    },
    "name": "Policy1",
    "periodic": {
        "days": "monday, tuesday, wednesday, thursday, friday",
        "enable": false,
        "end_time": "18:00",
        "interval": 30,
        "retention": 4,
        "start_time": "09:00",
        "upload": "none"
    },
    "weekly": {
        "days": "saturday",
        "enable": false,
        "retention": 4,
        "time": "23:05",
        "upload": "local"
    }
}
```

</details>

## Export snapshot policy

**Command:** `weka fs protection snapshot-policy export`

This command exports the configuration of an existing snapshot policy to a template file. Use the `sys-default` policy to export the cluster's default configuration as a baseline for creating customized policy templates.

```sh
weka fs protection snapshot-policy export <name> <path>
```

**Parameters**

<table><thead><tr><th width="208">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The snapshot policy to export.</td></tr><tr><td><code>path</code>*</td><td>The path to the directory to save the export policy file.</td></tr></tbody></table>

<details>

<summary>Example: Export snapshot policy</summary>

```
$ weka fs protection snapshot-policy export sys-default /tmp/policy_template
Exported snapshot policy to /tmp/policy_template
```

</details>

### Customize the policy template

To customize a policy template, follow these steps:

1. **Open the exported template**:\
   Use a text editor, such as `vi`, to open the policy template file that you exported from the `sys-default` template or an existing snapshot policy.
2. **Modify configuration details**:\
   Edit the template to customize the policy's configuration, such as schedules, retention rules, or other relevant settings, to meet your specific requirements.
3. **Reuse the customized template**:\
   Save your changes. The modified template can now be used to create new policies tailored to your needs.

<details>

<summary>Example: Customize the policy template</summary>

In this example, the daily schedule is set for Monday, Wednesday, and Friday. The remaining schedules are disabled (`"enable"=false,`).

```
$ vi /tmp/policy_template

{
    "daily": {
        "days": "monday, wednesday, friday",
        "enable": true,
        "retention": 7,
        "time": "12:10",
        "upload": "local"
    },
    "hourly": {
        "days": "monday, tuesday, wednesday, thursday, friday",
        "enable": false,
        "hours": "09, 10, 11, 12, 13, 14, 15, 16, 17, 18",
        "minuteOffset": 5,
        "retention": 10,
        "upload": "none"
    },
    "monthly": {
        "days": "07",
        "enable": false,
        "months": "all",
        "retention": 12,
        "time": "00:05",
        "upload": "local"
    },
    "periodic": {
        "days": "monday, tuesday, wednesday, thursday, friday",
        "enable": false,
        "end_time": "18:00",
        "interval": 30,
        "retention": 4,
        "start_time": "09:00",
        "upload": "none"
    },
    "weekly": {
        "days": "saturday",
        "enable": false,
        "retention": 4,
        "time": "23:05",
        "upload": "local"
    }
}
-- INSERT --
```

</details>

## Create snapshot policy

**Command:** `weka fs protection snapshot-policy create`

This command creates a new snapshot policy based on a specified template file. Provide the policy name, template file path, and optional parameters such as a description or enabled status.

{% code overflow="wrap" %}
```sh
weka fs protection snapshot-policy create <name> <path> [--description description] [--enabled enabled]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="170">Parameter</th><th width="483">Description</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The snapshot policy name. Up to 12 alphanumeric characters, hyphens (-), underscores (_), and periods (.)</td><td></td></tr><tr><td><code>path</code>*</td><td>The path to the snapshot policy file. It must be in JSON format.</td><td></td></tr><tr><td><code>description</code></td><td>Policy description. Up to 128 characters.</td><td></td></tr><tr><td><code>enabled</code></td><td>Set snapshot policy status.<br>Possible values: <code>true</code> or <code>false</code></td><td><code>true</code></td></tr></tbody></table>

<details>

<summary>Example: Create a snapshot policy from a policy template</summary>

In this example, a new snapshot policy named `policy2` is created using the template file located at `/tmp/policy_template`. The system returns the newly created policy's ID.

```
$ weka fs protection snapshot-policy create policy2 /tmp/policy_template
SnapPolicyId: 3
```

</details>

## Attach filesystems to a snapshot policy&#x20;

**Command:** **weka fs protection snapshot-policy attach**

This command attaches existing filesystems to a snapshot policy. Before proceeding, ensure each  filesystem is attached to an object store.

```sh
weka fs protection snapshot-policy attach <name> [<filesystems>]...
```

**Parameters**

| Parameter           | Description                                             |
| ------------------- | ------------------------------------------------------- |
| `name`\*            | The snapshot policy name.                               |
| `filesystems`... \* | A list of filesystems you want to attach to the policy. |

<details>

<summary>Example: </summary>

This command attaches the snapshot policy `policy1` to the filesystems `fs1` and `default`.

```
$ weka fs protection snapshot-policy attach policy1 fs1 default
$ weka fs protection snapshot-policy list
SNAPSHOT POLICY ID  NAME         IS ENABLED  DESCRIPTION                     ATTACHED FILESYSTEMS
0                   sys-default  True        Cluster default configuration  
1                   policy1      False       Schedule daily snapshots        fs1, default
```

</details>

## Detach filesystems from a snapshot policy&#x20;

**Command:** `weka fs protection snapshot-policy detach`

This command detaches the specified filesystems from the snapshot policy. To remove waiting tasks associated with the filesystems, add the `--remove-waiting-tasks`  option.

<pre data-overflow="wrap"><code><strong>weka fs protection snapshot-policy detach &#x3C;name> [--remove-waiting-tasks] [&#x3C;filesystems>]...
</strong></code></pre>

**Parameters**

<table><thead><tr><th width="289">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The snapshot policy name.</td></tr><tr><td><code>filesystems</code>... *</td><td>A list of filesystems you want to detach from the policy.</td></tr><tr><td><code>remove-waiting-tasks</code></td><td>Allow to delete all waiting tasks corresponding to the filesystems.</td></tr></tbody></table>

<details>

<summary>Example: Detach a snapshot policy from filesystems</summary>

```
$ weka fs protection snapshot-policy detach pol1 fs1

Warning: You are about to detach filesystems. This action detach existing filesystem from the snapshot policy and cannot be undone.
Are you sure you want to continue (yes/no)? yes
Filesystems detached successfully
```

</details>

## Update a snapshot policy

**Command:** `weka fs protection snapshot-policy update`

This command updates an existing snapshot policy. You can modify its name, description, policy parameters or enabled status.

{% code overflow="wrap" %}
```sh
weka fs protection snapshot-policy update <name> [--new-name new-name] [--description description] [--path path] [--enabled enabled]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="266">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Existing snapshot policy name.</td></tr><tr><td><code>new-name</code></td><td>New policy name. Up to 12 alphanumeric characters, hyphens (-), underscores (_), and periods (.).</td></tr><tr><td><code>description</code></td><td>New policy description. Up to 128 characters.</td></tr><tr><td><code>path</code></td><td>The path to the new or modified snapshot policy file. It must be in JSON format.</td></tr><tr><td><code>enabled</code></td><td>Set snapshot policy status.<br>Possible values: <code>true</code> or <code>false</code></td></tr></tbody></table>

## Delete a snapshot policy

**Command:** `weka fs protection snapshot-policy delete <name>`

This command deletes the specified snapshot policy from the system. Ensure that no filesystems are attached to the policy before proceeding with the deletion.

```
weka fs protection snapshot-policy delete <name>
```

**Parameters**

<table><thead><tr><th width="223">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Existing snapshot policy name.</td></tr></tbody></table>

<details>

<summary>Example: Delete a snapshot policy</summary>

```
$ weka fs protection snapshot-policy delete policy2
Warning: You are about to delete a snapshot policy. This action deletes the snapshot policy and cannot be undone.

Are you sure you want to continue (yes/no)? yes
```

</details>
