---
description: >-
  This page describes how to obtain a classic Weka license (payment for a
  predetermined period of time) and apply it to the Weka system cluster.
---

# Classic License

A classic license is a text element entered in the cluster using the GUI or the CLI. The following is an example:

```
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ZjQ4M2YxZi1jNGJhLTRkZDAtYTExNC04MTBmMzk0NGQ1MTUiLCJpc3MiOiJodHRwczovL2dldC53ZWthLmlvIiwibmJmIjoxNTMwNDM4NjI2LCJleHAiOjE1MzMwMzA2MjYsInctZ3VpZCI6IjZjZDI2ZTdlLWZmNDYtNGZmMC1iOGU2LTUzNmE0MzIwZTkyYyIsInctdHlwZSI6IkNsYXNzaWMiLCJ3LWNyZWRpdHMiOnsiZHJpdmVfY2FwYWNpdHlfZ2IiOjE2MSwib2JzX2NhcGFjaXR5X2diIjowfSwiaWF0IjoxNTMwNDM4NjQyfQ.oi1Vfp7nkJBN1jENfWTAxFyKkcKNKqmWR23ZlnPdvWHa78KnDvA2tgC8VXjVHPh6NM5s0nSfZLUv5HESjdnTG98hGxMSfTDhGLmK-jn6Kuk382p0sT5YSrWr7zyJu3AtGxSPCf0CMbXBsfvv3ivycTLx5ACpw9CSGl2CWvEhA5kDHi45EjM_Teo43z7AHvzog1HOEJDl6jZiEAMw0NLf6ZJ2Y6XCFgqxCIrmD0irGUI04GtHKsMPRSABUeakHshIFoy-TnaW1vMGS1GYNetYjyeQKyy74Baaos_SCzMHuLHMEjGXWJZjAN780KKSQN9DYEBC6HxZGpx4sEEqtyx_kg
```

## Creating a get.weka.io Account

Follow the instructions to create a get.weka.io account appearing in the [log-in instructions](../install/bare-metal/obtaining-the-weka-install-file.md#step-1-log-in).

{% hint style="info" %}
**Note:** This step can be skipped if you already have created a Weka account.
{% endhint %}

## Obtaining an Entitlement

After creating an account in get.weka.io, an entitlement will be applied to the account by a Weka sales or support person. Outstanding entitlements can be viewed in the account dashboard.

![Account Dashboard](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.15.56.png>)

## Creating a License

Start by running the `weka cluster license` command, which will output all the information required for creating your license. The following is an example output:

```
# weka cluster license 
Licensing status: Unlicensed

Your cluster is currently unlicensed. Please go to https://get.weka.io/ to get a license
or enroll in a subscription.

When asked, you'll need the following details to create your license:

    Cluster GUID          : bbb6639d-3eaa-483b-b532-31a560d5859d
    Raw Drive Capacity    : 5699 GB
    Usable Capacity       : 0 GB
    Object-store Capacity : 0 GB

If you already have a license, please enter it by running

    weka cluster license set <license-key>
```

Click Create a license in the Outstanding Entitlements pane in the Account dashboard. In the subsequent pane, select the line containing the entitlement for which a license is to be created (there is probably only one line) and then click the green Create a license button:

![Create a License Pane](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.33.03.png>)

The Create License dialog box will be displayed. Enter the details obtained from the `weka cluster license` command.

![Create License Dialog Box](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.35.31.png>)

Fill-in the cluster GUID and capacities. Then click the Create License button to confirm.

{% hint style="info" %}
**Note:** If cluster expansion is planned for the future, it is possible to fill-in capacities larger than those appearing in the Weka cluster license.

The capacities in the license represent the limits to which it is possible to expand the cluster and do not have to match actual usage.
{% endhint %}

## Applying the License to the Cluster

After creating the license, the page showing licenses is displayed. it is always possible to return to this page to get previously-created licenses.

![Example of Licenses Page](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.39.46.png>)

To apply the license to the cluster, click the three dots to the right of the license details and then select Show License Text.

![Applying a License to a Cluster Pane](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.41.36.png>)

The following dialog box with information on the new license is displayed.

![License Text Dialog Box](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.42.24.png>)

Copy the license key or click copy to clipboard. Then run the following command on the cluster:

```
weka cluster license set <license-key>
```

where \<license-key> is the license copied to the clipboard.

The cluster now has a license assigned to it.

## Getting the License Usage

To see the details of the current license and the current cluster usage, run the `weka cluster license` command again. The following is an example of the output obtained:

```
# weka cluster license 
Licensing status: Classic

Current usage: 161 GB raw drive capacity
               0 GB object-store capacity

Installed license: Valid from 2018-07-01T10:39:42Z
                   Expires at 2019-07-01T10:39:42Z
                   1024 GB raw drive capacity
                   2048 GB object-store capacity
```

## Reinstalling a Cluster

Every newly-installed cluster is assigned a new GUID. It is possible to use an existing license for a cluster that has been reinstalled by selecting the Change Cluster GUID in the Applying a License to a Cluster pane.

![Applying a License to a Cluster Pane](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.55.15.png>)

![Change Cluster GUID Dialog Box](<../.gitbook/assets/Screen Shot 2018-07-01 at 13.56.06.png>)

After entering a new cluster GUID, click the Save Changes button and repeat the steps above for creating and applying the license key to your cluster.
