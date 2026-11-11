---
description: >-
  Learn how NFS byte-range advisory locking works and what NFSv3 locking
  requires on the servers and clients.
---

# NFS file locking

NFS byte-range advisory locking[^1] is supported for NFS versions 3, 4, and 4.1. This mechanism ensures synchronized access to files in a networked environment by allowing multiple processes to coordinate access to shared files. It helps maintain data integrity and consistency by preventing concurrent modifications that could lead to data corruption. The implementation is interoperable with POSIX byte-range advisory locks, enabling compatibility and coordination between NFS clients and the filesystem.

{% hint style="warning" %}
**Multi-tenancy:** NFSv3 locking (NLM) is not offered on tenant floating IP addresses. Clients that mount a tenant export with NFSv3 cannot take locks. NFSv4.1 locking is available to tenants. Plan client compatibility accordingly. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

## NFS file-locking prerequisites for NFSv3

* **Port prerequisites:** Ports used by the `nlockmgr` and `status` services must be open on the clients and the servers. Use **one** of the following methods to meet this requirement:
  *   Disable and stop `firewalld` using the commands:

      ```
      systemctl stop firewalld.service
      systemctl disable firewalld.service
      ```
  *   Set fixed ports and open them:
      * On the servers, set the lock manager and status monitor ports. For example:

        ```
        weka nfs global-config set --lockmgr-port 47000 --statmon-port 46999
        ```
      * On the clients, set fixed ports for the status monitor and lock manager by using the NFS configuration of the client's operating system, and open them.
* **NFS client prerequisite:** To use NFSv3 with locking on an NFS client, ensure the `rpc.statd` service runs in the NFS client. This enables clients to mount NFSv3 shares.

## Considerations

* Inspecting active file locks is not exposed as a supported operation. If you need to identify which client holds a lock on a file, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).

[^1]: **Advisory locking**

    A file locking mechanism where processes voluntarily check for and honor locks set by others. It requires all cooperating processes to follow the locking protocol, as the operating system does not enforce it automatically.
