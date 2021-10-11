---
description: This page describes how to set up automatic snapshot mangement
---

# Snapshot Management

## Overview

Weka's SnapTool allows for the creation of scheduled snapshots for your cluster automatically and optionally uploads them to a tiered object-store.

## Features

* Schedule snapshots monthly, daily, or at multiple (minute granularity) intervals during a daily schedule.
* Retention specification - each schedule controls the number of snapshot copies to retain.
* Expired snapshots are automatically deleted.
* Optionally upload snapshots to an Object Store automatically.
* Background uploads and deletes

{% hint style="warning" %}
**Note:** Configuration files from releases before 1.0.0 are not compatible with 1.0.0 and above. They will need to be modified to use the new syntax.
{% endhint %}

## Where to run

`snaptool` can be run on any Linux system or VM and does not need to be on a host running the Weka protocol. All communication with the Weka Cluster is via the Weka API and needs only IP connectivity to a Weka host.  If `snaptool` is not running on a host with Weka installed, a valid `auth-token.json` file for the weka cluster will need to be copied to the running host, typically into `~/.weka`.

## Installation

`snaptool` is typically installed as a `systemd` service or in a Docker container; however, you will need to customize the configuration (`snaptool.yml`) file prior to starting the `snaptool`.   See [Deploying the Snapshot Management Tool with Systemd](snapshot-management.md#deploying-the-snapshot-management-tool-with-systemd) or [Deploying the Snapshot Management Tool in Docker](snapshot-management.md#deploying-the-snapshot-management-tool-in-docker) sections for details on each installation type.

## Configuration

A YAML file provides configuration information. The default configuration file name is `snaptool.yml`, and a sample `snaptool.yml` is included. There are three top-level sections, all of which are required:

```
cluster:  
filesystems: 
schedules:
```

#### Cluster Syntax

Cluster information is in the `cluster:` section. A host list is required. Other entries in this section are optional but are recommended for clarity. See the example `snaptool.yml` below for valid syntax. 

{% hint style="warning" %}
**Note:** It is not necessary to list all weka hosts/servers in the cluster, but more than one is recommended.
{% endhint %}

Entries allowed are:

```
cluster:
    auth_token_file: 
    hosts: 
    force_https: 
    verify_cert: 
```

#### Filesystems Syntax

Filesystems are in the `filesystems:` section, and these entries define which snapshot schedule(s) will run for the listed filesystems. Each filesystem line looks like this:

```
<fsname>:  <schedule1>,<schedule2>...
```

#### Schedule Syntax

Schedules Syntax is below. Schedules that are within a schedule group cannot be assigned separately from the group, and the group name must be used.

Using the example configuration file (YAML file), define your filesystems and which schedule(s) they should use. Also, define custom schedules in the YAML file. Schedule keywords and syntax are shown below.

To indicate that a particular schedule (i.e.,: monthly, weekly) should not run on a filesystem, set the `retain:` to `0`, or remove it from the filesystem's schedule list.

`snaptool` checks to see if the YAML configuration file has changed approximately every 30-60 seconds and reloads it if it has. Snapshot schedules are then recalculated before creating new snapshots.

Each schedule has the following syntax:

```yaml
<optional schedulegroupname>:  

    <schedulename>:

        every: (required) 'month' | 'day' | list of months | list of days
            'day' or list of days 
                - takes a snap at time specified by at: on the specified day(s)
                - 'day' is equivalent to specifying all 7 days of the week
                - list of days can be 3 character day abbreviation, or full day names.  For example:
                    Mon,Tue
                    Monday,Tuesday,Wednesday,Thursday,Friday
                - see also 'interval:' <number of minutes> and 'until:'
            'month' or list of months 
                - takes a snap on <day:> (integer 1..31) of the month, at time specified by <at:>  
                - 'month' is equivalent to specifying all 12 months
                - day: defaults to 1, first day of the month
                - if day > last day of a month (example: day is 31 and the month is April), 
                    then the snap is taken on the last day of the month
                - list of months can be 3 character mon abbreviations, or full month names.  For eample:
                    "Jan,Jul"
                    "January,April,Aug,Oct"

        at: time - defaults to '0000' (midnight)
            - format accepts times like "9am", "9:15am" "2300" etc.  Some valid examples:
                at: 9am
                at: 0900
                at: 9:05pm

        interval: <number of minutes>
            - number of minutes between snapshots
            - only applicable for schedules by day, not month ('day' or list of days)
            - if 'interval:' is not provided, a single snapshot per day is taken at "at:"
            - if 'interval:' is provided - 'at:' and 'until:' provide the start and end times for the snaps taken
            - first snap is taken at 'at:' time, then every <interval:> minutes thereafter until 'until:' is reached
                    Interval will only attempt snaps within a day, between times specified by 'at:' and 'until:'.  
                    So this value, added to 'at:' time, should always yield a time less than 'until:', otherwise it is ignored.

        until: defaults to '2359'
            - the latest time that an interval-based snapshot can be created

        retain: defaults to 4.  This is the number of snapshots kept. 0 disables the schedule. 

        upload: defaults to no/False - yes/True uploads the snapshot to the object store associated with the filesystem
```

Example `snaptool.yml`:

```yaml
cluster:
    auth_token_file: auth-token.json
    hosts: vweka1,vweka2,vweka3
    force_https: True   # only 3.10+ clusters support https
    verify_cert: False  # default cert cannot be verified

filesystems:
    fs01: default
    fs02: Weekdays-6pm, Weekends-noon

schedules:
    default:
        monthly:
            every: month
            retain: 6
            # day: 1   (this is default)
            # at: 0000 (this is default)
        weekly:
            every: Sunday
            retain: 8
            # at: 0000 (this is default)
        daily:
            every: Mon,Tue,Wed,Thu,Fri,Sat
            retain: 14
            # at: 0000 (this is default)
        hourly:
            every: Mon,Tue,Wed,Thu,Fri
            retain: 10
            interval: 60
            at: 9:00am
            until: 5pm
    Weekdays-6pm:
        every: Mon,Tue,Wed,Thu,Fri
        at: 6pm
        retain: 4
    Weekends-noon:
        every: Sat,Sun
        at: 1200
        retain: 4
        
```

{% hint style="warning" %}
**Note:** You may use the above example as a template for the `snaptool.yml` file or start with a copy from the GitHub repo ([https://github.com/weka/snaptool](https://github.com/weka/snaptool)) or the release tarball.
{% endhint %}

## Snapshot Naming

The format of the snapshot names is `<schedulename>.YYMMDDHHMM`, with the access point `@GMT-YYYY.MM.DD-HH.MM.SS`. For example, a snapshot might be named `Weekends-noon.2103101200` and have the access point `@GMT-2021.03.10-12.00.00`. The snapshot name will be in the local timezone and the access point in GMT (In this example, the server timezone is set to GMT).

For grouped snapshots, the name will be `<schedulegroupname>_<schedulename>.YYMMDDHHMM`. The full name before the '.' can't be longer than 18 characters. For example, `default` schedule group with an `hourly` schedule in it might be named `default_hourly.YYMMDDHHMM`.

When deleting snapshots automatically, based on the `retain:` keyword, snapshots for a schedule and filesystem are sorted by creation time, and the oldest snapshots will be deleted until there are `retain:` snapshots left for the applicable Schedule and filesystem.

{% hint style="warning" %}
**Note:** `snaptool` is unable to distinguish between user-created and snapshot manager-created snapshots, other than by the name, so when creating user-created snapshots, name collisions with scheduled snapshot names must be avoided.  If the same naming format is used, the user-created snapshots may be selected for deletion automatically.
{% endhint %}

## Deploying the Snapshot Management Tool with Systemd

In a web browser, please visit [https://github.com/weka/snaptool/releases](https://github.com/weka/snaptool/releases) to view the latest release.  The `snaptool-<release>.tar` file in the release is a binary version and is the recommended download.

* download and extract the tarball
* edit the `snaptool.yml` configuration file (if one doesn't exist in the destination directory already).  Default destination is /opt/weka/snaptool.
*   run the install script `install.sh`



An easy way if getting the tarball onto your system is via `wget` or `curl` of the tarball directly from GitHub. Right-click on the filename on the releases webpage and select Copy Link Address, then paste into a command line, like this:

```
wget https://github.com/weka/snaptool/releases/download/1.0.0/snaptool-1.0.0.tar
tar xvf snaptool-1.0.0.tar
cd snaptool

```

You can also download the tarball with any browser and copy it to the destination system.

If this is the first time `snaptool` is installed on a system, edit the `snaptool.yml` configuration file (see above). Then run the included `install.sh` to install the unit file into `systemd` and start the service: 

```
./install.sh

```

{% hint style="warning" %}
**Note**: the installer will check for a valid cluster connection using the hosts in the `snaptool.yml` file. The installer will not proceed if the cluster connection test fails.   Therefore, if this is the first time `snaptool` is installed, you **must** edit the `snaptool.yml` file to point to a valid weka cluster before running the installer.
{% endhint %}

If the service is already running locally, the installer will stop it, and preserve the existing `snaptool.yml` file before restarting the service.

## Deploying the Snapshot Management Tool in Docker

The `snaptool` container is run in much the same way as other Weka Docker containers. The docker image can be downloaded from docker hub using `docker pull wekasolutions/snaptool:latest`. Then, edit/create the `snaptool.yml` configuration file in the current directory and run the container. Please see the `docker_run.sh` file in the tarball release[ ](https://github.com/weka/snaptool/releases/latest)for a sample docker run file that sets the required mounts and parameters for the docker image to run properly. The tarball release can be downloaded from:

[https://github.com/weka/snaptool/releases/latest](https://github.com/weka/snaptool/releases/latest)

The `docker_run.sh` file looks like this:

```
#!/bin/bash
# sample file for running snaptool as a docker container
# the wekasolutions/snaptool docker image can be downloaded from docker hub
#
# the config_file is expected to be in the current directory when running within docker.
# logs will be created in a 'logs' directory in the current directory.
#
config_file=snaptool.yml
time_zone=US/Eastern
auth_dir=$HOME/.weka

mkdir -p logs ; chown 472 logs

if [[ ! -f $config_file ]]; then echo "Config file '$config_file' missing.  Exiting."; exit 1; fi

# some OS variants may not have this syslog option; if it doesn't exist, don't set it up
if [[ -e /dev/log ]]; then syslog_mount='--mount type=bind,source=/dev/log,target=/dev/log'; fi

docker run --network='host' --restart always -e TZ=$time_zone -d \
    $syslog_mount \
    --mount type=bind,source=$PWD,target=/weka \
    --mount type=bind,source=$auth_dir,target=/weka/.weka,readonly \
    --mount type=bind,source=/etc/hosts,target=/etc/hosts,readonly \
    --name weka_snaptool \
    wekasolutions/snaptool -vv -c $config_file

    
```

When running in docker, the `snaptool.yml` file should be in the current working directory.  A logs directory will be created in the current working directory for logging and snapshot journaling files.

