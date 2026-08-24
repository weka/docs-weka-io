---
description: >-
  Maintain WEKA Software Appliance security and functionality in connected and
  dark sites.
---

# Update the WSA

## Before you begin

Before updating the WSA, ensure the following:

* You have root access to each WSA server.
* You understand the maintenance impact of rebooting servers.
* You have access to a connected Linux server if the site is isolated.

## Update the WSA for sites with Internet access

1. Log in to each WSA server.
2. Run the update command:

```bash
dnf update
```

3. Reboot the servers after major operating system updates.
4. Verify that the update completed successfully.
5. Repeat this process regularly on all WSA servers.

## Update the WSA in dark sites

Use a local repository when the WSA servers do not have Internet access.

### Before you begin

Ensure the following:

* You have a Linux server with Internet access.
* You understand `dnf` package management.
* The WSA ISO version is below `2.0.0`.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/wsa-wms_iso_versions.png" alt=""><figcaption><p>WSA ISO file version example</p></figcaption></figure></div>

Check the current WSA version:

```bash
cat /.version
```

{% hint style="info" %}
You can also check the version from the login message.
{% endhint %}

### Procedure

1. Copy `/etc/yum.repos.d/ciq.repo` from a WSA server to a Linux server with Internet access.
2. Download the repository contents:

```bash
reposync --destdir=./reposdir --download-metadata --repoid=lts-8.6-hashed-ciq_lts_86 --download-path ./weka-patches --norepopath
```

3. Transfer the `weka-patches` directory to the dark site.
4. Update `/etc/yum.repos.d/ciq.repo` on the WSA server to point to the local repository. For example:

```bash
baseurl=file:///root/weka-patches
```

5. Run the update:

```bash
dnf --disablerepo=* --enablerepo=lts-8.6-hashed-ciq_lts_86 update
```

6. Reboot the servers after major operating system updates.
