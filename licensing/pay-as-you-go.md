---
description: >-
  This page describes Pay-As-You-Go (PAYG) licenses which allow cluster payment
  on an hourly basis, as part of your AWS bill.
---

# Pay-As-You-Go License

## Subscribing to AWS Marketplace

To enable PAYG, it is first necessary to subscribe to [WekaIO Matrix distributed scalable file system ](https://aws.amazon.com/marketplace/pp/B074XFQH6F)in the AWS Marketplace. This is performed using the following steps:

1. [Click here ](https://aws.amazon.com/marketplace/pp/B074XFQH6F) to go to the AWS Marketplace subscription page.
2. Review the pricing \(see [How Does Hourly Pricing Work?](pay-as-you-go.md#how-does-hourly-pricing-work) below for more details\).
3. Click the **Continue** button and then confirm by clicking **Subscribe**. A few seconds later a popup will be displayed.
4. Click the **Set Up Your Account** button.

After clicking the **Set Up Your Account** button, you will be redirected to the WekaIO Portal:

* **If you already have a WekaIO account:** Enter your email address and account password. Your WekaIO account will be linked to your AWS Marketplace subscription.
* **If you do not have a WekaIO account:** Enter your email address and choose a password for your new account. A new WekaIO account will be created and it will be linked to your AWS Marketplace subscription.

Your WekaIO account is now connected to the AWS Marketplace.

## Enabling PAYG In Your WekaIO System Cluster

After subscribing to the AWS Marketplace, a PAYG plan must be created in your WekaIO account. To do this, go to the **PAYG Plans** page and click the **Create PAYG Plan** button. Select the **AWS Marketplace** as the payment method and click the **Create PAYG Plan** to complete creation of the plan.

A PAYG plan is simply an ID+secret connected to a payment method, which in this case is your AWS Marketplace. The payment method can be changed at any point without having to reconfigure the WekaIO system cluster, since the ID+secret pair does not expire unless you delete them yourself.

This method also allows the connection of multiple WekaIO system clusters to the same PAYG plan.

Once a PAYG plan has been created, the final step is to enable the PAYG plan in the WekaIO system cluster. This is performed as follows:

1. Open a terminal and connect to one of your cluster hosts.
2. Copy and paste the `<plan-id>` and `<secret-key>` from the PAYG plan you created above to the following CLI command: `$ weka cluster license payg <plan-id> <secret-key>`

## What Happens When PAYG Is Enabled?

After enabling PAYG, it is possible to verify that it is active by running the `weka status` command:

```text
$ weka status
Weka v3.1.0 (CLI build 7f993d3)
...
  License: PAYG (Last renew successful at 2017-09-15, 13:55 local time)
...
```

If something has gone wrong, the WekaIO status shows an error indicating the issue. For example:

```text
$ weka status
Weka v3.1.0 (CLI build 7f993d3)
...
  License: PAYG (Last renew unsuccessful, error: Invalid PAYG plan or secret)
...
```

At any time, it is possible to reset the licensing status to return to an unlicensed mode, using the follwoing command:

```text
$ weka cluster license reset
```

Resetting a license enables the entry of new PAYG plan details or switching to other licensing methods that might be available in the future.

{% hint style="info" %}
**Note:** Momentary disabling and re-enabling of licensing does not affect operation of the WekaIO system cluster and is completely safe.
{% endhint %}

## How Does Hourly Pricing Work?

WekaIO charges your AWS account on an hourly basis, according to the pricing details published in the AWS Marketplace subscription. However, some cases are worth explaining in more detail.

### Client Instances Are Free

Pricing in the AWS Marketplace only includes r3 and i3 instances, while it is possible to install the WekaIO system on many other types of instances \(see [Supported EC2 Instance Types](../install/aws/supported-ec2-instance-types.md) for a complete list\). This is because WekaIO only charges for **backend instances**, which are the instances storing the data in the cluster. Client instances, which also includes r3 instances when installing as clients, are free of charge.

### Duplicate Charge Protection

When enabling PAYG, the WekaIO system cluster sends a usage report to the WekaIO Portal. This usage report contains the information necessary for correctly charging your AWS account. If PAYG is enabled and disabled multiple times in the same hour, multiple usage reports will be sent, which may cause duplicate charges.

The WekaIO Portal protects against such duplicate charges by ensuring that a cluster is never billed more than once in each given hour. It is possible to view a detailed list of usage reports in your WekaIO Portal account, with duplicate usage reports marked separately from the other reports.

### Billing Multiple Clusters

It is possible to use the same PAYG plan, or multiple PAYG plans assigned to the same AWS Marketplace subscription, with more than one WekaIO system cluster. In such situations, the accumulated charges will appear in your AWS bill, as the AWS Marketplace receives aggregated charges for each hour. it is possible to see the usage for each cluster separately under the usage reports screen in your WekaIO account.

## Unsubscribing

When unsubscribing, make sure to cancel your subscription from your AWS account. Subscriptions take up to 1 hour to be canceled, after which it is possible to re-subscribe and update your PAYG plans to charge the new subscription.

When unsubscribing, any existing clusters will become unlicensed, just as if their licensing status has been reset through the CLI.

