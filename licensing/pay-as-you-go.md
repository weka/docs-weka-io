# Pay-As-You-Go License

Pay-As-You-Go \(PAYG\) allows you to pay for your cluster, on an hourly basis, as part of your AWS bill.

To enable PAYG you first have subscribe to [WekaIO Matrix distributed scalable file system ](https://aws.amazon.com/marketplace/pp/B074XFQH6F) in the AWS Marketplace:

### AWS Marketplace Subscription {#aws-marketplace-subscription}

Follow these steps to subscribe to WekaIO in the AWS Marketplace:

1. [Click here ](https://aws.amazon.com/marketplace/pp/B074XFQH6F) to go to the AWS Marketplace subscription page.
2. Review the pricing \(see “How Does Hourly Pricing Work” below for more details\).
3. Click the **Continue** button, then confirm by clicking **Subscribe**.
4. A few seconds later a popup will show up, click the **Set Up Your Account** button.

After clicking **Set Up Your Account** you will be redirected to the WekaIO Portal:

* If you already have a WekaIO account:
  1. Enter your email address and password of your existing account.
  2. Your WekaIO account will be linked to your AWS Marketplace subscription.
* If you don’t have a WekaIO account yet:
  1. Enter your email and choose a password for your new account.
  2. A new account will be created for you.
  3. Your new WekaIO account will be linked to your AWS Marketplace subscription.

Your WekaIO account is now connected to the AWS Marketplace,

### Enabling PAYG In Your WekaIO Cluster {#enabling-payg-in-your-wekaio-cluster}

After you’ve subscribed to the AWS Marketplace, you’d have to create a PAYG plan in your WekaIO account.

1. To do this, go to the **PAYG Plans** page.
2. Click **Create PAYG Plan** button
3. Select the **AWS Marketplace** as the payment method
4. Click the **Create PAYG Plan** to finish creating the plan

A PAYG plan is simply an ID+secret which are connected to a payment method, in this case, your AWS Marketplace. You can replace the payment method at any point without having to reconfigure your WekaIO cluster, as the ID+secret pair don’t expire unless you delete them yourself.

This method also allows you to connect multiple WekaIO clusters using the same PAYG plan.

Once a PAYG plan has been created, the final step is to enable the PAYG plan in the WekaIO cluster:

1. Open a terminal and connect to one of your cluster hosts
2. Copy and paste the `<plan-id>` and `<secret-key>` from the PAYG plan you created above to the CLI command below
3. Enter the following CLI command:

   ```text
    $ weka cluster license payg <plan-id> <secret-key>
   ```

### What Happens When PAYG Is Enabled? {#what-happens-when-payg-is-enabled}

After enabling PAYG, you can check that it’s active by running the `weka status` command:

```text
$ weka status
Weka v3.1.0 (CLI build 7f993d3)
...
  License: PAYG (Last renew successful at 2017-09-15, 13:55 local time)
...
```

In case something went wrong, weka status shows an error indicating the issue:

```text
$ weka status
Weka v3.1.0 (CLI build 7f993d3)
...
  License: PAYG (Last renew unsuccessful, error: Invalid PAYG plan or secret)
...
```

At any time, you can reset the licensing status to return to an unlicensed mode:

```text
$ weka cluster license reset
```

Resetting your license allows you to enter new PAYG plan details or switch to other licensing methods that might be available in the future.

Momentarily disabling and re-enabling licensing does not affect the WekaIO cluster operation and is completely safe.

### How Does Hourly Pricing Work {#how-does-hourly-pricing-work}

WekaIO charges your AWS account on an hourly basis according to the pricing details published in the AWS Marketplace subscription. There are however some cases worth explaining in more detail:

#### Client Instances Are Free {#client-instances-are-free}

As you may have noticed, the pricing in the AWS Marketplace only includes r3 and i3 instances while you can install WekaIO on many other instance types \(see [Supported EC2 Instance Types](https://docs.weka.io/3.1/docs/aws/instance-types.html) for a complete list.\)

The reason for this is that WekaIO only charges for **backend instances**, which are the instances storing the data in the cluster. Client instances are free of charge, which also includes r3 instances when installing as clients.

#### Duplicate Charge Protection {#duplicate-charge-protection}

When you enable PAYG, the WekaIO cluster sends a usage report to the WekaIO Portal. This usage report contains the necessary information to correctly charge your AWS account.

If you enable and disable PAYG multiple times in the same hour, it causes multiple usage reports to be sent, which may cause duplicate charges.

The WekaIO Portal protects against duplicate charges by making sure to never bill the same cluster more than once in each given hour. You can see a detailed list of your usage reports in your WekaIO Portal account. Duplicate usage reports will be marked separately from the other reports.

#### Billing Multiple Clusters {#billing-multiple-clusters}

You may use the same PAYG plan, or multiple PAYG plans assigned to the same AWS Marketplace subscription, with more than one WekaIO cluster.

In this case, you will see the accumulated charges in your AWS bill, as the AWS Marketplace receives aggregated charges for each hour. You can see the usage for each cluster separately under the usage reports screen in your WekaIO account.

### What Happens If I Unsubscribe? {#what-happens-if-i-unsubscribe}

If you decide to unsubscribe, please make sure to cancel your subscription from your AWS account.

Subscriptions take up to one hour to be canceled, after which you can re-subscribe and update your PAYG plans to charge the new subscription.

Any existing clusters you may have will become unlicensed, just as if you’ve reset their licensing status through CLI.

