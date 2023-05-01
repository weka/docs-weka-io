---
description: >-
  This page describes Pay-As-You-Go (PAYG) licenses which allow cluster payment
  on an hourly basis, as part of your AWS bill.
---

# Pay-As-You-Go license

## Subscribe to AWS marketplace

To enable PAYG, subscribe to [WekaFS distributed scalable file system ](https://aws.amazon.com/marketplace/pp/B07W8V4PN9?ref\_=srh\_res\_product\_title)in the AWS Marketplace as follows:

1. Go to the [AWS Marketplace subscription](https://aws.amazon.com/marketplace/pp/B07W8V4PN9?ref\_=srh\_res\_product\_title) page.
2. Review the pricing on the AWS Marketplace subscription page (for more details, see below [How Does Hourly Pricing Work?](pay-as-you-go.md#how-does-hourly-pricing-work)).
3. Select **Continue** and then select **Subscribe** to confirm. Wait a few seconds for the popup to display.
4. Select **Set Up Your Account**.\
   You are redirected to the WEKA Portal.
5. In the WEKA Portal, do one of the following:
   * **If you already have a WEKA account:** Enter your email address and account password. Your WEKA account will be linked to your AWS Marketplace subscription.
   * **If you do not have a WEKA account:** Enter your email address and choose a password for your new account. A new WEKA account will be created, and it will be linked to your AWS Marketplace subscription.

Your WEKA account is now linked to the AWS Marketplace.

## Enable PAYG In your WEKA system

After subscribing to the AWS Marketplace, create a PAYG plan in your WEKA account. A PAYG plan is a plan ID and a secret key pair connected to a payment method, which is your AWS Marketplace.

You can change the payment method at any point without reconfiguring the WEKA system because the plan ID and secret key pair do not expire unless you delete them yourself.

This method also allows the connection of multiple WEKA system clusters to the same PAYG plan.

**Procedure**

1. Go to the **PAYG Plans** page and select the **Create PAYG Plan** button.
2. Select the **AWS Marketplace** as the payment method.
3. Select the **Create PAYG Plan** to complete the creation of the plan.
4. Enable the PAYG plan in the WEKA system cluster:
   * Open a terminal and connect to one of your cluster servers.
   * Copy and paste the `<plan-id>` and `<secret-key>` from the PAYG plan you created above to the following CLI command: \
     `$ weka cluster license payg <plan-id> <secret-key>`

## What happens when PAYG is enabled?

After enabling PAYG, you can verify that it is active by running the `weka status` command:

```
$ weka status
Weka v4.0.1 (CLI build 4.0.1)
...
  License: PAYG (Last renew successful at 2017-09-15, 13:55 local time)
...
```

If something is wrong, the WEKA status shows an error indicating the issue. For example:

```
$ weka status
Weka Weka v4.0.1 (CLI build 4.0.1)
...
  License: PAYG (Last renew unsuccessful, error: Invalid PAYG plan or secret)
...
```

You can reset the licensing status to return to an unlicensed mode anytime. Resetting a license enables the entry of new PAYG plan details or switching to other licensing methods that might be available in the future.

&#x20;To reset the license, run the following command:

```
$ weka cluster license reset
```

{% hint style="info" %}
**Note:** Momentary disabling and re-enabling of licensing does not affect the operation of the WEKA system cluster and is completely safe.
{% endhint %}

## How does hourly pricing work?

WEKA charges your AWS account hourly, according to the pricing details published in the AWS Marketplace subscription. However, some cases are worth explaining in more detail.

### Client instances are free

Pricing in the AWS Marketplace only includes r3 and i3 instances. At the same time, you can install the WEKA system on many other types of instances (for a complete list, see [Supported EC2 Instance Types](../install/aws/supported-ec2-instance-types.md)). The reason is that WEKA only charges for **backend instances**, which store the data in the cluster. Client instances that include r3 instances when installing as clients are free of charge.

### Duplicate charge protection

When enabling PAYG, the WEKA system cluster sends a usage report to the WEKA Portal. This usage report contains the information necessary for correctly charging your AWS account. If PAYG is enabled and disabled multiple times in the same hour, multiple usage reports will be sent, which may cause duplicate charges.

The WEKA Portal protects against such duplicate charges by ensuring that a cluster is never billed more than once per hour. You can view a detailed list of usage reports in your WEKA Portal account, with duplicate usage reports marked separately from the other reports.

### Billing multiple clusters

You can use the same PAYG plan or multiple PAYG plans assigned to the same AWS Marketplace subscription with more than one WEKA system cluster. In such situations, the accumulated charges appear in your AWS bill because the AWS Marketplace receives aggregated charges for each hour. You can view the usage for each cluster separately under the usage reports screen in your WEKA account.

## Unsubscribe a license

When unsubscribing, make sure to cancel your subscription from your AWS account. The subscription cancelation takes up to 1 hour. After the subscription cancelation, you can re-subscribe and update your PAYG plans to charge the new subscription.

When unsubscribing, any existing clusters become unlicensed. Similar to resetting the license status through the CLI.
