---
description: >-
  Deploy and manage WEKA backends and clients on Kubernetes with the WEKA
  Operator, which releases on its own schedule, independent of WEKA versions.
---

# WEKA Operator deployment

The WEKA Operator deploys and manages WEKA backends and clients on Kubernetes through custom resources such as WekaCluster and WekaClient. The Operator has its own version line, and each Operator version supports a range of WEKA versions.

The WEKA Operator documentation covers all supported WEKA versions in one place. Its version compatibility table lists the minimum Operator version and the minimum WEKA version for each feature.

To deploy or operate the WEKA Operator on a cluster running WEKA 4.4, see [WEKA Operator deployments](https://docs.weka.io/kubernetes/weka-operator-deployments).

{% hint style="info" %}
Before you deploy or upgrade, check the version compatibility table and the release notes for your target Operator version.
{% endhint %}
