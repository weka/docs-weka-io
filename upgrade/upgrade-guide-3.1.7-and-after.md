# Upgrade Guide: 3.1.7 And After

## Preparing For The Upgrade

Before upgrading your cluster:

1. All backend hosts have to be online
2. Any rebuild should have finished

{% hint style="info" %}
During the upgrade process your client IOs will hang for about one minute
{% endhint %}

## Downloading The New Release

On one of your backend hosts, download the new release:

1. SSH into one of the backend hosts of your cluster.
2. Go to [https://get.weka.io](https://get.weka.io) and navigate to the release to which you want to upgrade.
3. Run the `curl`/`wget` command line on the backend host.
4. Un-TAR the downloaded package.
5. Run the `install.sh` script of the new release.

## Running The Upgrade Command

At this point you should have an installed release on one of your backend hosts.

To upgrade your cluster to the new release, run the following command on the backend host:

```text
weka local run --in <new-version> upgrade --mode=one-shot
```

`<new-version>` is the name of the new version you have downloaded from get.weka.io \(e.g. `3.1.7.2`\).

Before switching the cluster to the new release, the upgrade command will distribute the new release to all cluster hosts and make any necessary preparations such as compiling the new `wekafs` driver.

In anything goes wrong during preparations \(e.g. a host disconnected, or a driver couldn't be built\) the upgrade process stops and prints an error indicating the problematic host.

If all is as expected, the upgrade will stop the cluster IO service, switch all hosts to the new release and turn the IO service back on. This takes about one minute depending on the size of your cluster.

## After The Upgrade

Once the upgrade has finished, you should see that your cluster is in the new version by running the `weka status` command \(in this example we have upgraded to `3.1.7.2`\):

```text
# weka status 
WekaIO v3.1.7.2 (CLI build 2.5.2)
...
```

### Disconnected Clients During Upgrade

In some cases you may have clients which are not connected to the cluster while its being upgraded.

As of 3.1.7, clients automatically upgrade themselves when they detect their version is out of date.



