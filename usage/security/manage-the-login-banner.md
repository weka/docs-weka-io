---
description: This page describes how to set a login banner displayed on the sign-in page.
---

# Manage the login banner

## Manage the login banner using the GUI

You can set a login banner containing a security statement or a legal message displayed on the sign-in page. You can also disable, edit, or reset the login banner.

![Sign in page with a banner example](../../.gitbook/assets/wmng\_login\_banner\_sign-in-page.png)

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the Cluster Settings pane, select **Security**.
3. On the Security page, select **Login Banner**.

![Login Banner](../../.gitbook/assets/wmng\_login\_banner\_set.png)

3\. Select **Edit Banner**.

![Write the login banner statement](../../.gitbook/assets/wmng\_login\_banner\_edit.png)

4\. In the Edit Login Banner, write your organization statement in the banner text box.

5\. Select **Save**.

6\. To prevent displaying the login banner, select **Disable Login Banner**.

7\. To clear the banner text, select **Clear Login Banner Message.**

## Manage the login banner using the CLI

To manage the login banner, use the following CLI command:

`weka security login-banner set|show|reset|enable|disable`

**Command options:**

`set:` Sets the login banner text.

`show`: Displays the login banner text.

`reset`: Clears the login banner text.

`enable`: Displays the login banner when accessing the cluster.

`disable:` Prevents displaying the login banner when accessing the cluster.
