---
description: This page describes how to install WEKA on AWS Outposts
---

# AWS outposts deployment

## Overview

[AWS Outposts](https://aws.amazon.com/outposts/) is a fully managed service that extends AWS infrastructure, AWS services, APIs, and tools to virtually any data center, co-location space, or on-premises facility for a consistent hybrid experience. AWS Outposts is ideal for workloads that require low latency access to on-premises systems, local data processing, or local data storage.

## Deployment of a WEKA cluster in AWS outposts

A WEKA cluster deployment in AWS Outposts follows the guidelines described in the [Deployment types](deployment-types.md) section.

To deploy a WEKA cluster in AWS Outposts, use a CloudFormation template, which can be obtained as described in the [CloudFormation template Generator](cloudformation.md) section.

{% hint style="warning" %}
**Note:** AWS Outposts do not currently support placement groups, so the placement group from the template should be removed.
{% endhint %}

This template can be customized. For further assistance, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

