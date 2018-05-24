# User Management

Access to a WekaIO cluster is controlled by creating, modifying and deleting users. A WekaIO cluster can store up to 128 users.

Each user is identified by a _username_ and has to provide a _password_ to authenticate in the UI or CLI.

In addition, each user has a _role_ which can be one of:

* **User**: An ordinary user
* **Admin**: A user with additional privileges to an ordinary user, as we’ll see below

When opening the UI you will be prompted for username and password.

To pass username and password to the CLI, use the `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables.

If the `WEKA_USERNAME`/`WEKA_PASSWORD` environment variables are not specified, the CLI assumes the usename and password are `admin`/`admin`.

### First User {#first-user}

When a WekaIO cluster is created, a first user with a username of `admin` and a password of `admin` is created by default. This user has an Admin role, which allows it to run all commands.

The first `admin` user is created because a WekaIO cluster needs to have at least one user defined. However, there is nothing special about this user and you may create a user with a different name and delete `admin` if you wish.

### Creating Users {#creating-users}

To create a user, run the `weka user add` CLI:

```text
$ weka user add user1 S3cret user
```

The last command line creates a user with a username of `user1`, a password of `S3cret` and a role of User. We’ll cover user roles in a bit.

We can now get the list of users and see that the user was created:

```text
$ weka user
| Username | Role  
+----------+-------
| user1    | User  
| admin    | Admin 
```

To use the new user credentials, we’ll use the `WEKA_USERNAME` and `WEKA_PASSWORD` environment variables:

```text
$ WEKA_USERNAME=user1 WEKA_PASSWORD=S3cret weka user whoami
username: user1
role: User
```

As you can see, the `weka user whoami` command returns information about the current user running the command.

### Changing a User’s Password {#changing-a-users-password}

To change a user password, use the `weka user passwd` command. We’ll assume `user1` still exists from the previous section:

```text
$ WEKA_USERNAME=user1 WEKA_PASSWORD=S3cret weka user passwd user1 s3cret
```

The last command changed the password of `user1`. The user had to specify its current username and password in order to change its password.

It’s also possible for an Admin to change a user’s password. Let’s have the `admin` user change `user`’s password:

```text
$ weka user passwd user1 BackToS3cret
```

_Note that we didn’t specify `WEKA_USERNAME` or `WEKA_PASSWORD` as those are `admin`/`admin` by default_

### Admin Role Privileges {#admin-role-privileges}

As we saw in the last example, a user with an Admin role has some privileges that a regular user \(with User role\) doesn’t. Those are:

* Create new users
* Delete existing users
* Change a user’s password
* Set a user’s role

Some restrictions apply to avoid a situation where an Admin loses access to a WekaIO cluster:

* An Admin can’t delete itself
* An Admin can’t change its role to an ordinary User role

### Deleting Users {#deleting-users}

To delete a user, run the `user-delete` command:

```text
$ weka user delete user1
```

Let’s run `weka user` to see that the user was deleted:

```text
$ weka user list
| Username | Role  
+----------+-------
| admin    | Admin 
```

