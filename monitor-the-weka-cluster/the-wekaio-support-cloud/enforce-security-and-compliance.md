# Enforce security and compliance

## Cluster administration and audit

The Admin page provides a comprehensive set of administrative and audit features, all conveniently located in one place:

**Admin section:**

* **Mute Cluster:** Temporarily prevent the cluster from sending alerts or events to Local WEKA Home. Useful for mitigating alert overload during maintenance activities.
* **Delete Cluster:** Remove a legacy WEKA cluster from Local WEKA Home (without deleting the cluster itself).
* **Maintenance Window:** Set a specific time window when alert and event notifications (including email, SNMP, and PagerDuty alerts) won't be sent.

**Cluster Audit section:**

* **Cluster Audit:** Keep track of audited activities, including cluster muting/unmuting and maintenance window changes. Get a detailed history of when these actions were taken.

<figure><img src="../../.gitbook/assets/cluster-admin.png" alt=""><figcaption><p>Admin and cluster audit page</p></figcaption></figure>

## Users management

The Users page presents the current list of users who have login access to Local WEKA Home and provides the option to add new users. Authentication for access is done using a local username and password.

To open the Users page, from the menu, select **Manage > Users**.

<figure><img src="../../.gitbook/assets/manage-users (1).png" alt=""><figcaption><p>Users page</p></figcaption></figure>

## Groups management

The Groups page provides a comprehensive overview of all the groups, their members, and the scopes (roles) that each group is granted access to or can view within Local WEKA Home.

To open the Groups page, from the menu, select **Manage > Groups**.

<figure><img src="../../.gitbook/assets/manage-groups.png" alt=""><figcaption><p>Groups page</p></figcaption></figure>

### Create a new group

You can create new groups as needed, customizing role-based access control (RBAC) scoping for each group.

<figure><img src="../../.gitbook/assets/manage-groups-create.png" alt=""><figcaption><p>Group Creator</p></figcaption></figure>
