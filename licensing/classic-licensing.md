# Classic Licensing

A classic license is a text element entered in the cluster UI or CLI, for example:

```text
eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0ZjQ4M2YxZi1jNGJhLTRkZDAtYTExNC04MTBmMzk0NGQ1MTUiLCJpc3MiOiJodHRwczovL2dldC53ZWthLmlvIiwibmJmIjoxNTMwNDM4NjI2LCJleHAiOjE1MzMwMzA2MjYsInctZ3VpZCI6IjZjZDI2ZTdlLWZmNDYtNGZmMC1iOGU2LTUzNmE0MzIwZTkyYyIsInctdHlwZSI6IkNsYXNzaWMiLCJ3LWNyZWRpdHMiOnsiZHJpdmVfY2FwYWNpdHlfZ2IiOjE2MSwib2JzX2NhcGFjaXR5X2diIjowfSwiaWF0IjoxNTMwNDM4NjQyfQ.oi1Vfp7nkJBN1jENfWTAxFyKkcKNKqmWR23ZlnPdvWHa78KnDvA2tgC8VXjVHPh6NM5s0nSfZLUv5HESjdnTG98hGxMSfTDhGLmK-jn6Kuk382p0sT5YSrWr7zyJu3AtGxSPCf0CMbXBsfvv3ivycTLx5ACpw9CSGl2CWvEhA5kDHi45EjM_Teo43z7AHvzog1HOEJDl6jZiEAMw0NLf6ZJ2Y6XCFgqxCIrmD0irGUI04GtHKsMPRSABUeakHshIFoy-TnaW1vMGS1GYNetYjyeQKyy74Baaos_SCzMHuLHMEjGXWJZjAN780KKSQN9DYEBC6HxZGpx4sEEqtyx_kg
```

In this page we'll describe how to get your license and how to apply it to your WekaIO cluster.

## Create a get.weka.io Account

Follow the instructions in the following page to create your get.weka.io account.

{% hint style="info" %}
You can skip this step if you already have created an account
{% endhint %}

{% page-ref page="../install/bare-metal/obtaining-the-weka-install-file.md" %}

## Get an Entitlement

After creating an account in get.weka.io, an entitlement will be applied to your new account by a WekaIO sales or support person.

You can see your outstanding entitlements in your account dashboard:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.15.56.png)

##  Create a License

Start by running the `weka cluster license` command. This command outputs all the information required for creating your license. An example output is:

```text
# weka cluster license 
Licensing status: Unlicensed

Your cluster is currently unlicensed. Please go to https://get.weka.io/ to get a license
or enroll in a subscription.

When asked, you'll need the following details to create your license:

    Cluster GUID          : bbb6639d-3eaa-483b-b532-31a560d5859d
    Drive Capacity        : 161 GB
    Object-store Capacity : 0 GB

If you already have a license, please enter it by running

    weka cluster license set <license-key>

```

Then, click the "Create a license" action in the "Outstanding Entitlements" pane.

In the "Create a license" page select the line containing the entitlement from which you want to create a license \(you will most likely have only one line\), then click the green "Create a license" button:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.33.03.png)

This will open up a dialog in which you'll have to enter the details obtained from the `weka cluster license` command:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.35.31%20%281%29.png)

Fill-in the cluster GUID and capacities, then click the "Create a License" button to confirm.

{% hint style="info" %}
You can fill-in capacities larger than what weka cluster license has printed out in case you plan to expand your cluster in the future.

The capacities in your license represent the limits up to which you can expand your cluster, they do not have to match your actual usage.
{% endhint %}

## Applying the License to Your Cluster

After creating your license, you are taken to the page showing your licenses. You can always return to this page to get your previously created licenses:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.39.46.png)

To apply the license to your cluster, click the three dots to the right of the license details, then select "Show License Text:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.41.36.png)

This opens the following dialog with your new license:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.42.24.png)

Copy the license key, or click the "copy to clipboard" action, then run the following command on your cluster:

```text
weka cluster license set <license-key>
```

where &lt;license-key&gt; is the license you copied to your clipboard.

You cluster now has a license assigned to it.

## Getting the License Usage

To see the details of your current license and the current cluster usage, run the `weka cluster license` command again. An example output is:

```text
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

Every newly installed cluster is assigned a new GUID.

You can use an existing license for a cluster that has been reinstalled by selecting the "Change Cluster GUID" action of an existing license:

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.55.15.png)

![](../.gitbook/assets/screen-shot-2018-07-01-at-13.56.06.png)

After entering a new cluster GUID, click the "Save Changes" button and repeat the steps above for getting and applying the license key to your cluster.



