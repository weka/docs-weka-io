---
description: This page describes how to install Weka on AWS Outposts
---

# AWS Outposts Deployment

## Overview

AWS Outposts is a fully managed service that extends AWS infrastructure, AWS services, APIs, and tools to virtually any data center, co-location space, or on-premises facility for a truly consistent hybrid experience. AWS Outposts is ideal for workloads that require low latency access to on-premises systems, local data processing, or local data storage.

## Deploying a Weka Cluster in AWS Outposts

A Weka cluster deployment in AWS Outposts follows the same guidelines as described in the [Deployment Types](deployment-types.md) section.

To deploy a Weka cluster in AWS Outposts, use a CloudFormation template, which can be obtained as described in the [CloudFormation template Generator](cloudformation.md) section.

{% hint style="warning" %}
**Note:** AWS Outposts do not currently support placement groups, so the placement group from the template should be removed.
{% endhint %}

This template can be edited to your needs. For further assistance, please contact the Weka Support Team.



