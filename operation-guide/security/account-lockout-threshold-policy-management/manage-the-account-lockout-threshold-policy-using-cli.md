# Manage the account lockout threshold policy using CLI

To control the default values, use the following CLI commands:

`weka security lockout-config set|show|reset`

**Commands options:**

`set`: Sets the number of failed attempts until the account is locked (`--failed-attempts`) and the lockout duration (`--lockout-duration`).&#x20;

`reset`:  Resets the number of failed attempts until the account is locked and the lockout duration to their default values.

`show`: Shows the number of failed attempts until the account is locked and the lockout duration.

