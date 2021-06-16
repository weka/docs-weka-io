---
description: This page describes what a Weka Clusterspec is.
---

# ClusterSpecs

A ClusterSpec \(aka, Cluster Spec, clustercpec, cluster spec, or cluster specification\) is how we denote a cluster on your network for the purposes of monitoring and management.

The ClusterSpec is a string that tells the tool how to contact the cluster. The ClusterSpec consists of two parts, a comma-separated list of weka hosts and an optional auth file.

The general syntax of the ClusterSpec is `<wekaserver>[,<wekaserver>][:<authfile>]`

The list of hosts will look like this: `weka1,weka2,weka3`

Any number of hosts can be specified, but we recommend at least 2-3. You do NOT have to list ALL the hosts in the cluster. This is very similar to the host list when you mount a filesystem and is used the same way.

The auth file is the output of the `weka user login` command.  By default, the `weka user login` command creates a file, `~/.weka/auth-token.json` but you can change the name with the `-p` parameter to the login command. This is useful if you have more than one cluster, for example, production and test clusters. You can use `weka user login -p ~/.weka/prod` to create the auth file for the production cluster, and `weka user login -p ~/.weka/test` to create the auth for the test cluster.

To use an auth file, just append it to the host list after a colon, like this: `weka1,weka2,weka3:~/.weka/prod`

If you do not specify an auth file, all weka tools will automatically attempt to use the default user/password of admin/admin.   If you have changed the password of the cluster \(most likely\) you will need to provide the auth file.

Note that you do not need to have the weka command installed to run weka tools, such as `export` or `snaptool`, but you do need the auth file. You can generate the auth file on any server connected to weka \(for example, one that has a filesystem mounted, or from one of the weka servers\), and then copy the auth file to your management server/VM.

Below are some examples of valid ClusterSpecs:

`weka1,weka2,weka3:~/.weka/auth-token.json`

`prod1,prod2:~/.weka/prodauth`

`server1` \# just a single server is valid, if you're using the default password

`wekaserver1:~/.weka/myauth.json`



