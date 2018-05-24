# Managing Filesystems

A WekaIO filesystem is similar to a regular on-disk filesystem you may already be familiar with, with the key difference that it’s distributed across all the hosts in the cluster.

In addition, each filesystem belongs to a filesystem-group, which allows for compound management operations across multiple filesystems in a single operation.

A WekaIO cluster can contain up to 1024 filesystems and up to 8 filesystem-groups.

### Listing Filesystems {#listing-filesystems}

The `weka fs` CLI command prints the list of filesystems currently defined in the cluster:

```text
$ weka fs
| Name    | Group   | SSD Budget | Total Budget | Ready | Creating | Removing
+---------+---------+------------+--------------+-------+----------+----------
| default | default | 57 GiB     | 57 GiB       | True  | False    | False
```

Let’s go over the columns in the returned table:

| Name | The name you provide when creating the filesystem |
| --- | --- | --- | --- | --- |
| Group | The name of the filesystem-group containing the filesystem |
| SSD Budget | The SSD capacity allocated to this filesystem |
| Total Budget | The total capacity provisioned for this filesystem |
| Ready, Creating, Removing | These columns represent the status of the filesystem creation or deletion, as those might take some time to complete |

As we’ll later in [Tiering](tiering.md), the total budget of a filesystem may be larger than its SSD budget.

### Creating a Filesystem {#creating-a-filesystem}

Filesystems can be created using the `weka fs create` CLI command:

```text
weka fs create <name> <group-name> <total-capacity> [--ssd-capacity=<ssd>]
```

Before creating a filesystem you first have to check how much SSD storage is available. To do this, run the `weka status`command:

```text
$ weka status
  ...
  ssd storage: 57 GiB total, 57 GiB free
  ...
```

This cluster has 57 GiB of free SSD storage, so let’s create a 10 GiB filesystem. We’ll assume a filesystem-group named `default` already exists \(filesystem-groups will be covered in the next sections\):

```text
$ weka fs create demo default 10GiB 
```

Now running `weka status` should show that 10GiB were taken from the SSD storage:

```text
$ weka status
  ...
  ssd storage: 57 GiB total, 47 GiB free
  ...
```

And running `weka fs` should show the newly created filesystem:

```text
$ weka fs
| Name | Group   | SSD Budget | Total Budget | Ready | Creating | Removing 
+------+---------+------------+--------------+-------+----------+----------
| demo | default | 10 GiB     | 10 GiB       | True  | False    | False       
```

### Updating a Filesystem {#updating-a-filesystem}

The `weka fs update` CLI command allows you to make changes to existing filesystems:

```text
weka fs update <name> [--new-name=<new-name>] [--total-capacity=<total>] [--ssd-capacity=<ssd>]
```

{% hint style="info" %}
The SSD-capacity and total-capacity are identical for non-tiered filesystems. As a result, you can't update the SSD-capacity of a non-tiered filesystem.
{% endhint %}

For example, let’s increase the total capacity of the `demo` filesystem from the previous sections to 15GiB.

_In this example we would assume the filesystem is already mounted. We’ll learn how to mount filesystems in the next page._

We’ll start by checking the current size by using the `dh` command:

```text
$ df -h /mnt/weka/demo/
Filesystem      Size  Used Avail Use% Mounted on
demo             10G  4.0K   10G   1% /mnt/weka/demo
```

Now let’s run `weka fs update`:

```text
$ weka fs update demo --total-capacity=15GiB
```

Checking `df` again would show the size has indeed increased:

```text
$ df -h /mnt/weka/demo/
Filesystem      Size  Used Avail Use% Mounted on
demo             15G  4.0K   15G   1% /mnt/weka/demo
```

As you can see from the usage of `weka fs update`, you can also update the filesystem name. Any existing mounts are not affected by this, but when running `mount` to create new mounts after renaming a filesystem you’d have to use the new filesystem name.

### Filesystem Groups {#filesystem-groups}

As mentioned above, filesystem-groups combine common parameters for a group of filesystems. Each filesystem must belong to one filesystem-group.

To see a list of all filesystem-groups, run the `weka fs group` CLI command:

```text
$ weka fs group
| Name    | Is Tiered? | Object Store | Target SSD Retention | Start Demote 
+---------+------------+--------------+----------------------+--------------
| default | False      |              | 0                    | 0            
```

The columns returned by this command are:

| Is Tiered? | Whether or not the file system is tiered to an object store |
| --- | --- | --- | --- |
| Object Store | When tiered, the object store to which the file system is connected to |
| Target SSD Retention | The retention time, in seconds, of files on the filesystems in this group |
| Start Demote | The demote time, in seconds, after which files can start being moved to object-store |

Filesystem-groups can be tiered or local. Tiered filesystem-groups must connect to an object store, and specify where it tiers and its tiering policy. We’ll learn more about [Tiering](https://docs.weka.io/3.1/docs/fs/tiering.html) later.

Filesystem-groups which are not tiered are sometimes referred to as local groups. Data of Local groups reside on SSD only.

### Creating Filesystem Groups {#creating-filesystem-groups}

To create a new filesystem-group, use the `weka fs group create` CLI command. For example, let’s create a new filesystem-group named `some-group`:

```text
$ weka fs group create some-group
$ weka fs group
| Name       | Is Tiered? | Object Store | Target SSD Retention | Start Demote 
+------------+------------+--------------+----------------------+--------------
| default    | False      |              | 0                    | 0            
| some-group | False      |              | 0                    | 0            
```

In [Tiering](https://docs.weka.io/3.1/docs/fs/tiering.html) we’ll see how to define a tiered filesystem-group.

### Renaming Filesystem Groups {#renaming-filesystem-groups}

You can rename a filesystem-group by using the `weka fs group rename` CLI command.

For example, let’s rename the `some-group` from the previous section to `group2`:

```text
$ weka fs group rename some-group group2
$ weka fs group
| Name    | Is Tiered? | Object Store | Target SSD Retention | Start Demote 
+---------+------------+--------------+----------------------+--------------
| default | False      |              | 0                    | 0            
| group2  | False      |              | 0                    | 0
```

### Deleting Filesystem Groups {#deleting-filesystem-groups}

You can delete filesystem-groups as long as they don’t have any filesystems assigned to them.

For example, to delete the `group2` filesystem-group from the previous section, we’ll run

```text
$ weka fs group delete group2
```

### What’s Next? {#whats-next}

Now that you’ve learned about filesystems and filesystem-groups, keep on reading [Mounting Filesystems](mounting-filesystems.md) to mount and use your filesystems.

