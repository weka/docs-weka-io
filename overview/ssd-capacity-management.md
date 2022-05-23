---
description: >-
  Understand the key terminologies relating to Weka system capacity management
  and the formula for calculating the Weka system net data storage capacity.
---

# SSD capacity management

## Raw capacity

Raw capacity is the total capacity on all the SSDs assigned to a Weka system cluster, e.g., 10 SSDs of 1 terabyte each have a total raw capacity of 10 terabytes. This is the total capacity available for the Weka system. This will change automatically if more hosts or SSDs are added to the system.

## Net capacity

Net capacity is the amount of space available for user data on the SSDs in a configured Weka system. It is based on the raw capacity minus the Weka filesystem overheads for redundancy protection and other needs. This will change automatically if more hosts or SSDs are added to the system.

## Stripe width

The stripe width is the number of blocks that share a common protection set, which can range from 3 to 16. The Weka system has distributed any-to-any protection. Consequently, in a system with a stripe width of 8, many groups of 8 data units spread on various hosts protect each other (rather than a group of 8 hosts forming a protection group). The stripe width is set during the cluster formation and cannot be changed. Stripe width choice impacts performance and space.

{% hint style="info" %}
**Note:** If not configured, the stripe width is set automatically to #Failure Domains - Protection Level
{% endhint %}

## Protection level

The protection level is the number of additional protection blocks added to each stripe, which can be either 2 or 4. A system with a protection level of 2 can survive 2 concurrent failures, while system data with a protection level of 4 is protected against any concurrent 4 host/disk failures, and its availability is protected against any 4 concurrent disk failures or 2 concurrent host failures. A large protection level has space and performance implications. The protection level is set during the cluster formation and cannot be changed.

{% hint style="info" %}
**Note:** If not configured, the data protection drives in the cluster stripes are automatically set to 2.
{% endhint %}

## Failure domains (optional)

A failure domain is a group of Weka hosts, all of which can fail concurrently due to a single root cause, such as a power circuit or network switch failure. A cluster can be configured with explicit or implicit failure domains. For a system with explicit failure domains, each group of blocks that protect each other is spread on different failure domains. For a system with implicit failure domains, the group of blocks is spread on different hosts and each host is a failure domain. Additional failure domains can be added, and new hosts can be added to any existing or new failure domain.

{% hint style="info" %}
**Note:** This documentation relates to a homogeneous Weka system deployment, i.e., the same number of hosts per failure domain (if any), and the same SSD capacity per host. For information about heterogeneous Weka system configurations, contact the Weka Support Team.
{% endhint %}

## Hot spare

A hot spare is the number of failure domains that the system can lose, undergo a complete rebuild of data, and still maintain the same net capacity. All failure domains are always participating in storing the data, and the hot spare capacity is evenly spread within all failure domains.

The higher the hot spare count, the more hardware required to obtain the same net capacity. On the other hand, the higher the hot spare count, the more relaxed the IT maintenance schedule for replacements. The hot spare is defined during cluster formation and can be reconfigured at any time.

{% hint style="info" %}
**Note:** If not configured, the hot spare is automatically set to 1.
{% endhint %}

## Weka filesystem overhead

After deducting the capacity for the protection and hot spares, only 90% of the remaining capacity can be used as net user capacity, with the other 10% of capacity reserved for the Weka filesystems. This is a fixed formula that cannot be configured.

## Provisioned capacity

The provisioned capacity is the total capacity assigned to filesystems. This includes both SSD and object store capacity.

## Available capacity

The available capacity is the total capacity that can be used for the allocation of new filesystems, which is net capacity minus provisioned capacity.

## Deductions from raw capacity to obtain net storage capacity

The net capacity of the Weka system is obtained after the following three deductions performed during configuration:

1. Level of protection required, i.e., the amount of storage capacity to be dedicated to system protection.
2. Hot spare(s), i.e., the amount of storage capacity to be set aside for redundancy and to allow for rebuilding following a component failure.
3. Weka filesystem overhead, in order to improve overall performance.     &#x20;

## The formula for calculating SSD net storage capacity

![](<../.gitbook/assets/Formula with Failure Domains.jpg>)

**For Example:**

{% hint style="success" %}
**Scenario 1:** A homogeneous system of 10 hosts, each with 1 terabyte of Raw SSD Capacity, 1 hot spare, and a protection scheme of 6+2.
{% endhint %}

$$
SSD Net Capacity = 10 TB * (10-1) / 10 * 6/(6+2) * 0.9 = 6.075 TB
$$

{% hint style="success" %}
**Scenario 2:** A homogeneous system of 20 hosts, each with 1 terabyte of Raw SSD Capacity, 2 hot spares, and a protection scheme of 16+2.
{% endhint %}

$$
SSD Net Capacity = 20 TB * (20-2) / 20 * 16/(16+2) * 0.9 = 14.4 TB
$$
