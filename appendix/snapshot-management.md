---
description: This page describes how to set up automatic snapshot mangement
---

# Snapshot Management

## Overview

Weka's SnapTool will create and optionally upload snapshots for your cluster automatically.

## Features

* Schedule snapshots to be taken hourly, daily, weekly, monthly for each filesystem
* Set a specific number of each type of snapshot to keep
* Expired snapshots are automatically deleted
* Optionally upload snapshots to Object Store automatically.

A default snapshot schedule is automatically defined with the following parameters:

```text
Monthly, 1st of the month at midnight, retain 6 snaps

Weekly, Sunday at 00:00 (midnight Sat), retain 8 snaps

Daily, Monday-Saturday at 00:00 (midnight), retain 14 snaps

Hourly, Monday-Friday, 9am-5pm taken at top of the hour, retain 10 snaps
```

## Caveats

`snaptool` is an external tool that asks that snapshots be taken, deleted, and/or uploaded via the Weka API. Errors are logged but otherwise ignored. The tool will not attempt to re-try if an error occurs when it attempts to take a snapshot beyond the typical API retry.

Please monitor the cluster and/or syslog to ensure snapshots are being created.

## Configuration

The user may define a custom Schedule in the YAML configuration file, `snaptool.yml`

Filesystems are listed in the YAML file and define which Schedule they will use there.

If you want to define several custom schedules, be sure to copy the entire stanza. To indicate that a particular sub-schedule \(ie: monthly, weekly\) should not run, set the `retain` to 0.

Using the example configuration file \(YAML file\), define your filesystems and which schedule they should use. Also define custom schedules in the YAML file.

It is suggested to run the utility via `systemd` with an auto-restart set, or use a Docker container.

This example `snaptool.yml` shows 2 filesystems \(`default` and `wekatester-fs`\), both using the `custom1` snapshot schedule, which is defined under `schedules`. The `custom2` schedule is provided here to show how more than one custom schedule may be defined. To use the above `default` snapshot schedule, use the `default` keyword for the `schedule:` instead of the `custom1` schedule in the example.

See the [Configuration File Reference](snapshot-management.md#configuration-file-reference) section for more details.

```text
---
filesystems:
  default:
    schedule: custom1
  wekatester-fs:
    schedule: custom1
schedules:
  custom1:
    monthly:
      date: 2
      retain: 12
      time: 1100
      upload: false
    weekly:
      retain: 4
      time: 0
      weekday: 6
      upload: false
    daily:
      retain: 7
      start_day: 0
      stop_day: 5
      time: 1900
      upload: false
    hourly:
      retain: 10
      start_day: 0
      start_time: 800
      stop_day: 6
      stop_time: 2100
      snap_minute: 0
      upload: true
  custom2:
    monthly:
      retain: 3
```

## Snapshot Naming

The format of the snapshot names is `Schedule.YYYY-MM-DD_HHMM`, with the access point `@GMT-YYYY.MM.DD-HH.MM.SS`. For example, a snapshot might be named `hourly.2021-03-10_1700` and have the access point `@GMT-2021.03.10-17.00.00`. The snapshot name will be in the local timezone and the access point in GMT \(in this example, the server timezone is set to GMT time\).

The reason for naming them as such is that the snapshot name is more human-readable, and the access point is more machine-readable, and in particular, is compatible with Windows "previous versions" functionality, for those with Windows clients using Weka's SMB service.

For deletion, the snapshots are sorted according to the creation date, and the oldest snapshots are deleted until there are `retain` snapshots left for the particular Schedule.

{% hint style="warning" %}
**Note:** we are unable to distinguish between user-created and snapshot manager-created snapshots, other than by the name, so when creating user-created snapshots, you should use a different naming format; if the same naming format is used, the user-created snapshots may be selected for deletion automatically.
{% endhint %}

## Deploying the Snapshot Management Tool 

### Step 1: Installing the SnapTool package

You can choose between various packaging options - Docker container, pre-compiled binary, and Python sources.

Use either step 1a, 1b, or 1c to install the package.

#### Step 1a: Getting the container

Get and run the container:

```
docker pull wekasolutions/snaptool

```

#### Step 1b: Getting the binary version

Go to [https://github.com/weka/snaptool/releases](https://github.com/weka/snaptool/releases) and download the tarball from the latest release. As of time of this last doc update, the current version is 0.9.1, so download the `snaptool-0.9.1.tar` file from the Version-0.9.1 release. Copy this file to your management server or VM, and unpack it:

```
tar xvf snaptool-0.9.1.tar
cd snaptool

```

### Step 1c: Getting the sources

You can either `git clone https://github.com/weka/snaptool` or go to [https://github.com/weka/snaptool/releases](https://github.com/weka/export/releases) and download the source tarball.

After cloning or unpacking the tarball, you will need to `pip3 install -r requirements.txt` to install all the required python modules.

## Step 2: Running SnapTool

The first thing you need to do, regardless of the manner you wish to run the SnapTool, is to edit the configuration file, `snaptool.yml` and configure it for what filesystems you wish to manage. See the above [Configuration](snapshot-management.md#configuration) section for details.

Secondly, you'll need your `CLUSTER_SPEC` as described in the [ClusterSpecs](clusterspecs.md) section.

### Step 2a: Running with Docker

The `snaptool` is run in much the same way as other Weka Docker containers:

```
docker run -d --network=host \
    --mount type=bind,source=/root/.weka/,target=/weka/.weka/ \
    --mount type=bind,source=/dev/log,target=/dev/log \
    --mount type=bind,source=/etc/hosts,target=/etc/hosts \
    --mount type=bind,source=$PWD/snaptool.yml,target=/weka/snaptool.yml \
    wekasolutions/snaptool weka01,weka02,weka09:~/.weka/myauthfile 
    
```

### Step 2b: Running the binary version or Python script

We suggest that you run the `snaptool` via a `systemd` startup script or similar, but from the command-line you can run it as such:

```
./snaptool -vvv weka01,weka02,weka09:~/.weka/myauthfile

```

The syntax for running either the python script or binary version is the same.

## Configuration File Reference

The configuration file is in 2 sections - filesystems and schedules, providing significant flexibility in defining when your snapshots should be taken. The configuration file is in a standard YAML format.

### Filesystems

The filesystems specification is simply noting which filesystems are to follow which schedule. Each filesystem can have only one schedule.

```text
filesystems:           # start of the filesystems section
  default:             # filesystem named 'default'
    schedule: custom1  # default follows the 'custom1' schedule 
  prod_data:           # filesystem named 'prod_data'
    schedule: custom1  # prod_data also follows 'custom1' schedule 
```

### Snapshot Schedules

There is one pre-defined schedule, called `default`. You can define as many custom schedules as you like.

Snapshot schedules have common attributes.

* `retain:` the number of snapshots of this type to retain. If there are ever more than this number of snapshots of this type, the oldest snapshots are deleted.
* `date:` Day of the month \(1-31\)
* `time:` 24-hour clock time \(0-2359\) without leading zeros. For example, 0900 hours, or 9am is noted as `900`.  Midnight \(00:00, 12:00am\) is `0` 
* `weekday:` The day of the week -  Monday=0, Tuesday=1, Wednesday=2. Thursday=3, Friday=4, Saturday=5, Sunday=6
* `start_day:` The day number that the schedule starts on \(see `weekday`, above\)
* `stop_day:` The day number that the schedule stops on \(see `weekday`, above\)
* `start_time`: The time that snapshots will begin to be taken \(see `time`, above\)
* `end_time:` The time that snapshots will stop being taken \(see time above\)
* `snap_minute:`  The number of minutes within the hour when a snap should be taken. 0 = top of the hour, 30 = 30 mins after the hour, 15 = quarter after the hour, 45 = quarter of the next hour
* `upload:` Should the snapshot be uploaded to the object store \(if any\).  Boolean \(true/false\)

Here is an example annotated Schedule:

```text
schedules:  
  custom1:
    monthly:           # monthly schedule
      date: 1            # first day of the month
      retain: 12         # keep 12 snaps (12 months)
      time: 1100         # take snap at 11am
      upload: false      # do not upload to obj store
    weekly:            # weekly schedule
      retain: 4          # retain 4 snaps (1 month's worth)
      time: 0            # take snap at midnight
      weekday: 6         # ...on Saturday
      upload: false      # do not upload to obj store
    daily:             # daily schedule
      retain: 7          # keep a week of them
      start_day: 0       # start taking snaps on Monday 
      stop_day: 5        # stop taking snaps on Saturday
      time: 1900         # snap at 7pm
      upload: false      # do not upload to obj store
    hourly:            # hourly schedule
      retain: 10         # keep 10 snaps
      start_day: 0       # start on Monday 
      start_time: 800    # start snapping at 8am   
      stop_day: 6        # end on Sunday
      stop_time: 2100    # stop snapping at 9pm 
      snap_minute: 0     # snap at top of hour   
      upload: true       # upload the snap to the obj store 
```



