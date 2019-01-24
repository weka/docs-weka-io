---
description: >-
  This page describes the management of users licensed to work with the WekaIO
  system.
---

# User Management

## Types of Users

Access to a WekaIO system cluster is controlled by creating, modifying and deleting users. Up to 128 users can be defined to work with a WekaIO system cluster. Each user is identified by a username and must provide a password for authentication to work with the WekaIO system GUI or CLI.

Every user of the WekaIO system has one of the following defined roles:

* **User**: An ordinary user.
* **Admin**: A user with additional privileges, as described in [Admin Role Privileges](user-management.md#admin-role-privileges) below.

When users open the GUI, they are prompted to provide their username and password. To pass username and password to the CLI, use the `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables. 

{% hint style="info" %}
**Note:** If the`WEKA_USERNAME`/`WEKA_PASSWORD` environment variables are not specified, the CLI assumes the username and password are `admin`/`admin`.
{% endhint %}

## First User

By default, when a WekaIO cluster is created, a first user with a username of `admin` and a password of `admin` is created. This user has an Admin role, which allows the running of all commands.

The first Admin user is created because a WekaIO system cluster must have at least one admin user defined. However, you can create a user with a different name and delete the default admin user, if required.

## Creating Users

To create a user, run the `weka user add` command:

```text
$ weka user add user1 S3cret user
```

This command line creates a user with a username of `user1`, a password of `S3cret` and a role of User. It is then possible to get a list of users and verify that the user was created:

```text
$ weka user
| Username | Role  
+----------+-------
| user1    | User  
| admin    | Admin 
```

To use the new user credentials, use the`WEKA_USERNAME` and `WEKA_PASSWORD`environment variables:

```text
$ WEKA_USERNAME=user1 WEKA_PASSWORD=S3cret weka user whoami
username: user1
role: User
```

As you can see, the `weka user whoami` command returns information about the current user running the command.

## Changing a User’s Password

To change a user password, use the `weka user passwd` command. Assuming `user1` still exists from the previous section, run the following command to the change the password of`user1`:

```text
$ WEKA_USERNAME=user1 WEKA_PASSWORD=S3cret weka user passwd user1 s3cret
```

As can be seen, this command requires the user to specify the current username and password in order to change the password.

It is also possible for an Admin user to change a user’s password. This is performed as follows:

```text
$ weka user passwd user1 BackToS3cret
```

{% hint style="info" %}
**Note:** `WEKA_USERNAME` or `WEKA_PASSWORD` are not specified because by default, they are `admin`/`admin.`
{% endhint %}

## Admin Role Privileges

As shown in the example above, Admin users have some additional privileges over regular users. These include the ability to:

* Create new users
* Delete existing users
* Change a user’s password
* Set a user’s role

Additionally, the following restrictions are implemented for Admin users, in order to avoid a situation where an Admin loses access to a WekaIO system cluster:

* Admins cannot delete themselves.
* Admins cannot change their role to an ordinary user role.

## Deleting Users

To delete a user, run the `user-delete` command:

```text
$ weka user delete user1
```

Then run the`weka user` command to verify that the user was deleted:

```text
$ weka user
| Username | Role  
+----------+-------
| admin    | Admin 
```

