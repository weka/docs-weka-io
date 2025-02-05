# Manage account lockout threshold policy

To prevent brute force attacks, if several sign-in attempts fail (default: 5), the user account is locked for several minutes (default: 2 minutes).

You can control these default values using the GUI or the CLI.

## Manage account lockout threshold policy using GUI

Using the GUI, you can set the number of failed attempts until the account is locked and the lockout duration. You can also reset the account lockout threshold policy properties to the default values.

<figure><img src="../.gitbook/assets/wmng_account_lockout.png" alt=""><figcaption><p>Account Lockout Threshold policy</p></figcaption></figure>

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the Account Lockout Threshold Policy section, select **Set Account Lockout Policy**.
4. In the Set Lockout Policy dialog, do the following:
   * **Failed Attempts Until Lockout:** Set the number of sign-in attempts to lockout between 2 to 50.
   * **Lockout Duration:** Set the lockout duration between 30 seconds to 60 minutes.
5. Select **Save**.

<figure><img src="../.gitbook/assets/wmng_set_lockout_policy.png" alt=""><figcaption><p>Set Lockout Policy</p></figcaption></figure>

6. To reset the account lockout threshold policy properties to the default values, select **Reset account lockout policy**. In the confirmation message, select **Yes**.

## Manage account lockout threshold policy using CLI

To control the default values, use the following CLI commands:

`weka security lockout-config set|show|reset`

**Commands options:**

`set`: Sets the number of failed attempts until the account is locked (`--failed-attempts`) and the lockout duration (`--lockout-duration`).&#x20;

`reset`:  Resets the number of failed attempts until the account is locked and the lockout duration to their default values.

`show`: Shows the number of failed attempts until the account is locked and the lockout duration.
