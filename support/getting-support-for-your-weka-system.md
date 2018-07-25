---
description: >-
  This page describes WekaIO policy and approach for responsive and proactive
  technical support, together with some recommended helpful steps when starting
  to work with WekaIO.
---

# Getting Support for Your Weka System

## Contacting WekaIO Technical Support Team

WekaIO's technical support policy is based on the type and urgency of the inquiry, as described in the following table:  

| Type/Urgency | Method of Contact | Comments |
| --- | --- | --- | --- | --- | --- |
| Critical | Call WekaIO support number +1 \(855\) 969-4030 | WekaIO provides a 24/7 technical suppport service and calls are directed to the active support personnel. Such requests for technical support should only be used for urgent issues in production systems. |
| Critical/Major/Minor | Open a ticket in the Support Portal \([support.weka.io](http://support.weka.io/)\) | To open a ticket, you need to first sign-up as a user in our Support Portal. Tickets can be tracked and notifications and updates are provided on changes in tickets. When opening a ticket in the Support Portal, it is possible to specify if it is a critical production system issue, in which case the WekaIO support team will be alerted accordingly. |
| Major/Minor | Email [support@weka.io](mailto:support@weka.io) | Sending an email also opens a ticket in the Support Portal. Note that it is first necessary to sign-up as a user in the Support Portal. Notification of problems by email are not considered as critical. |
| Major/Minor | Write to WekaIO on a shared Slack channel | This form of contact should not be used for critical issues. Responses will be provided in a timely manner. To create a Slack channel. speak with your Weka point of contact or email [support@weka.io](mailto:support@weka.io). |
| Product Questions | Write to WekaIO using the customer chat icon at [www.weka.io](http://www.weka.io/) or in the product UI | Only use this form of contact for product questions, and not for failures or errors. |

## Uploading Events to the WekaIO Support Cloud

It is highly recommended to enable the system to upload events to the WekaIO support cloud. This will enable the provision of proactive support if any irregularities are recognized in system behavior. Additionally, in cases of troubleshooting, this enables the provision of better and quicker response from WekaIO. 

To enable the upload of events to the WekaIO support cloud, perform the following:

1. Enable [cloud events](../install/bare-metal/untitled.md#stage-4-enabling-cloud-event-notifications-optional).
2. Make sure that your network allows the system to report events to WekaIO by allowing https connections from all Weka nodes \(both clients and backends\) management IP interfaces to `cloud.weka.io`, `*.s3.amazonaws.com` and `*.s3-*.amazonaws.com`
3. [Install a valid commercial or evaluation license](../licensing/overview.md). Contact the Weka sales or support team if an evaluation license is required.

## Recommended Actions to Save Time

In order to save time when you require support from WekaIO, it is recommended to perform the following:

1. Open a shared Slack channel with WekaIO. Ask your WekaIO point of contact to arrange this or email [support@weka.io](mailto:support@weka.io).
2. Sign-up as a Weka system user at [http://support.weka.io](http://support.weka.io/).



