---
description: View, pause, resume, abort, and monitor background tasks in the GUI.
---

# Manage background tasks using the GUI

Monitor active and pending background tasks from the GUI. Review each task's duration, state, phase, and progress.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/wmng_bkg_tasks.gif" alt=""><figcaption><p>Background Tasks</p></figcaption></figure></div>

**Procedure**

1. Select **Monitor** > **Background Tasks**.
2. Review active tasks and their status details.
3. Select **Pause** to pause a task. The button changes to **Resume**.
4. Select **Resume** to continue a paused task.
5. Select **Abort** to stop a supported task.
6. Enable **Show Waiting Tasks** to view pending tasks.

{% hint style="warning" %}
**Abort** supports selected tasks, including metadata integrity checks. It does not stop filesystem or snapshot downloads, filesystem squashing, or object-storage detachment. Delete the associated entity to stop those tasks.
{% endhint %}
