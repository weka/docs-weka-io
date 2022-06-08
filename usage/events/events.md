---
description: This page describes how to manage events using the GUI.
---

# Manage events using the GUI

With the GUI, you can:

* [View events](events.md#view-events)
* [Filter events](events.md#filter-events)

## View events

The events enable you to investigate issues that occur in the system.

The System Events page provides the following details:

* **Severity**: The severity of the event. The options are Info (lowest), Warning, Minor, Major, and Critical (highest).
* **Timestamp**: The date and time the event occurred. You can switch the display time between local and system time through the top bar.
* **Origin**: The originator of the event. For example, when a user creates a filesystem, the username appears as the event's originator.
* **Category**: The category options include Alerts, Cloud, Clustering, Drive, Events, Filesystem, IO, InterfaceGroup, Licensing, NFS, Network, Node, ObjectStorage, Raid, Statistics, System, Upgrade, and User.
* **Name**: The name of the event.
* **Description**: The description of the event.

{% hint style="info" %}
You can select the Advanced switch to display internal events. This option is helpful for experts investigating internal issues.
{% endhint %}

&#x20;**Procedure**

1. From the menu, select **Investigate > Events**.

![System events](../../.gitbook/assets/wmng\_events\_view.png)

## Filter events

You can filter the events according to the event severity, timestamp, category, or event name. You can also filter events by multiple categories and multiple event names.

![Example: view all minor events (and higher severity events) related to clustering](../../.gitbook/assets/wmng\_events\_filter\_example.gif)

**Procedure**

1.  To display events of a specific minimum severity:

    * Select the filter icon of the **Severity** column.
    * Select the required minimum severity.

    For example, if you select the Major severity, also the Critical events are displayed.

![Minimum serverity filter](../../.gitbook/assets/wmng\_events\_filter\_severity.png)

1. To display events that occur during a specific period:
   * Select the filter icon of the **Timestamp** column.
   * In the **From** field, select the timestamp of the beginning of the period to display.
   * In the **To** field, select the timestamp of the end of the period to display, or select **Now**.
   * Select **Filter**.

![Timestamp filter](../../.gitbook/assets/wmng\_events\_filter\_timestamp.png)

3\. To display events of specific categories:

* Select the filter icon of the **Category** column.
* In the **Filter Categories**, select the category you want to display. You can select multiple categories.
* Select **Filter**.

![Category filter example: filter by Clustering and Drive](../../.gitbook/assets/wmng\_events\_filter\_category.png)

4\. To display events with specific event names:

* Select the filter icon of the **Event** column.
* In the **Events Filter**, select the event name you want to display. You can select multiple event names.
* Select **Filter**.

![Event filter example: filter by AlertMuted and DirectoryQuataSet](../../.gitbook/assets/wmng\_events\_filter\_event.png)

****

**Related topics**

****[list-of-events.md](list-of-events.md "mention")****

**Switch the display time**
