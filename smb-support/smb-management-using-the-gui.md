---
description: >-
  This page details SMB management - setting up an SMB cluster over WekaIO
  filesystems and managing the cluster itself - using the GUI.
---

# SMB Management Using the GUI

{% hint style="info" %}
**Note:** For activating GUI control of Samba, contact the WekaIO Support Team.
{% endhint %}

## **Configuring a Samba Cluster**

To configure a Samba cluster, first access the SMB Service view.

![SMB Service Overview Screen](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTHvibQhAt6mOZPuEix%2Fimage.png?alt=media&token=cff1d83c-7558-4d67-a72b-a5cac8a0e2a7)

To configure the Samba cluster, click the Configure button. The following Configure Cluster window will be displayed:

![Configure SMB Cluster Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTI99ejJJTKHIWL3s63%2Fimage.png?alt=media&token=76b938f0-de2e-4e06-a61d-f17fd6fc4010)

Enter the workgroup name, choose between 3 to 8 hosts and enter the IPs \(make sure to provide IPs equal to or 3 times greater than the number of hosts selected\). Then click the Configure button.

{% hint style="info" %}
**Note:** in order to add an IP range, it is possible to use`a.b.c.x-y` notation.
{% endhint %}

The following Samba Cluster Configuration window will be displayed:

![Samba Cluster Configuration Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTIAdMwedoG9jlIcDK4%2Fimage.png?alt=media&token=f1b510d5-aa44-4e1c-9778-ef15f23f3ffa)

{% hint style="info" %}
**Note:** The status of the hosts will change from not-ready to ready.
{% endhint %}

## Deleting a Samba Cluster

To delete a configured Samba cluster, click the Reset button in the Configure Samba Cluster window. The following window will be displayed:

![Samba Cluster Reset Confirmation](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTIBT97FiPHaaztFlHj%2Fimage.png?alt=media&token=eb11e80b-624c-44f0-b587-305caccd63ee)

Confirm the deletion by clicking the Reset button.

## **Listing SMB Users**

To access the list of SMB users, click the Authentication tab in the SMB Service Overview screen. A list of all authenticated users will be displayed**:**

![SMB Authenticated Users List](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI-14rs2vp46wOPQ3k%2Fimage.png?alt=media&token=3984a6a2-1fe2-497c-8123-10ec8bbc9090)

## Adding SMB Users

To add a new user, click Create User at the top right-hand corner of the table. The following Create User window will be displayed:

![Create SMB User Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI-SApeR0rM8xcfAHP%2Fimage.png?alt=media&token=3ddb12d9-dab6-410a-9582-27c967aa0601)

Enter the username, UID \(must be unique\), GID, password and confirm the password by re-typing it. Then click the Create button. The newly-created user now appears in the SMB Authenticated Users list.

## Removing SMB Users

To remove an SMB user, click on a trash icon in the SMB Authenticated Users list. The following Samba User Deletion window is displayed:

![SMB User Deletion Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI0ukQHCzZC8H4RMyk%2Fimage.png?alt=media&token=5beb397b-fdf3-4c7e-ae09-2915408ff7ae)

Click the Yes button to confirm deletion of the user. The deleted user will no longer appear in the SMB Authenticated Users list.

## **Listing SMB Shares**

To access SMB shares**,** click the SMB Shares tab in the SMB Service Overview screen. A list of all SMB shares will be displayed**:**

![SMB Shares List](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI3bjjcEJCiHJXlhRT%2Fimage.png?alt=media&token=3f65387b-e362-43c1-873a-ae40853aaa6c)

{% hint style="info" %}
**Note:** It is possible to filter this list using any column in the table.
{% endhint %}

## Adding an SMB Share

To add a new SMB share, click Create Share at the top right-hand corner of the table. The following Create Share window will be displayed:

![Create SMB Share Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTI8oSd__LxcJu3S1Uz%2F-LTICCwBp8DJ-2POLbLa%2Fimage.png?alt=media&token=082ece86-984f-4905-99a6-8d2b54eb46cd)

Enter the new share name and description, select a filesystem, enter the path and select the mount mode. Then click the Create button.

## Removing an SMB Share

To remove an SMB share, click anywhere on the row to be removed and then click the Delete button.

![Removing an SMB Share](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI5UZ-eCnsqvaLKX9s%2Fimage.png?alt=media&token=f97b446e-750c-42f4-8946-a0ecf16b396a)

The Samba Share Deletion window will be displayed**:**

![Samba Share Deletion Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI5Bt6q5vavn9uS_hS%2Fimage.png?alt=media&token=15b7f458-c61a-470c-b79a-430a2cb81dd6)

Click the Yes button to confirm deletion of the share. The deleted share will no longer appear in the SMB Shares list.

## Changing an SMB Share Owner

To change an SMB share owner, click anywhere on the relevant share row and then click the Chown button. The following Chown Share window will be displayed**:**

![Chown Share Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI63Ba2Xp6_8dhNJvv%2Fimage.png?alt=media&token=1ef3268a-efc6-470e-8b25-3139cb0398f8)

Select the owner to be changed by selecting the UID and GID of the relevant user\(s\). Then click the Chown button.

In order to check the current owner\(s\) of a share, click the Show Owner button in the SMB Shares window. A window detailing the current owner\(s\) will be displayed. Click the OK button to exit this window.

![Current SMB Share Owner Window](https://blobscdn.gitbook.com/v0/b/gitbook-28427.appspot.com/o/assets%2F-LQnJwJhPXcMK56H0INC%2F-LTHtR0Dlva51U4IZHoC%2F-LTI6qDMwjD2L2rx_cLp%2Fimage.png?alt=media&token=c7c62edd-165f-4fe0-8b8d-c6e3bcc43257)

## ​ <a id="undefined"></a>



