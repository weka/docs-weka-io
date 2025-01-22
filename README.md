---
cover: .gitbook/assets/doc_banner.png
coverY: 93
layout:
  cover:
    visible: true
    size: hero
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# WEKA v4.4 documentation

Welcome to the WEKA documentation portal, your guide to the latest WEKA version. Whether you're a newcomer or a seasoned user, explore topics from system fundamentals to advanced optimization strategies. Choose your WEKA version from the top menu for version-specific documentation.

<figure><img src=".gitbook/assets/4.4_version_selector.gif" alt=""><figcaption><p>WEKA version selector</p></figcaption></figure>

{% hint style="warning" %}
**Important:** This documentation applies to the WEKA system's **latest minor version** (4.4.**X**). For information on new features and supported prerequisites released with each minor version, refer to the relevant release notes available at [get.weka.io](https://get.weka.io/).

Check the release notes for details about any updates or changes accompanying the latest releases.
{% endhint %}

### Find answers in WEKA documentation with Sevii

Sevii, your AI chat companion, makes finding answers in WEKA documentation fast and easy. Just type your question and click ![](.gitbook/assets/sevii_submit.png) to get started. Sevii is ready to help—whether you're exploring a topic or need a specific answer.

For the best results, ask clear, context-rich questions. If unsure, start with related keywords, and Sevii will guide you.

{% @sevii-ai/sevii-gitbook-test %}

### About WEKA documentation

This portal encompasses all documentation essential for comprehending and operating the WEKA system. It covers a range of topics:

**WEKA system overview:** Delve into the fundamental components, principles, and entities constituting the WEKA system.

**Planning and installation:** Discover prerequisites, compatibility details, and installation procedures for WEKA clusters on bare metal, AWS, GCP, and Azure environments.

**Getting started with WEKA:** Initiate your WEKA journey by learning the basics of managing a WEKA filesystem through the GUI and CLI, executing initial IOs, and exploring the WEKA REST API.

**Performance:** Explore the results of FIO performance tests on the WEKA filesystem, ensuring optimal system performance.

**WEKA filesystems & object stores:** Understand the role and management of filesystems, object stores, filesystem groups, and key-management systems within WEKA configurations.

**Additional protocols:** Learn about the supported protocols—NFS, SMB, and S3—for accessing data stored in a WEKA filesystem.

**Operation guide:** Navigate through various WEKA system operations, including events, statistics, user management, upgrades, expansion, and more.

**Licensing:** Gain insights into WEKA system licensing options.

**Monitor the WEKA cluster:** Deploy the WEKA Management Server (WMS) alongside tools like Local WEKA Home, WEKAmon, and SnapTool to effectively monitor your WEKA cluster.

**Support:** Find guidance on obtaining support for the WEKA system and effectively managing diagnostics.

**Best practice guides:** Explore our carefully selected guides, starting with WEKA and Slurm integration, to discover expert-recommended strategies and insights for optimizing your WEKA system and achieving peak performance in various scenarios.

**AWS solutions**: The AWS solutions guide shows how to integrate WEKA with SageMaker HyperPod for training large language and foundation models. Learn how to leverage high-performance storage for distributed machine learning at scale.

**WEKApod:** Explore the WEKApod Data Platform Appliance Guide for step-by-step instructions on setting up and configuring the WEKApod™. This turnkey solution, designed for NVIDIA DGX SuperPOD, features pre-configured storage and software for quick deployment and faster value.

**Kubernetes**: The Kubernetes guides cover deploying and managing the WEKA Data Platform. Learn how to use the WEKA Operator for high-performance storage deployment and handle day-2 operations including scaling, hardware management, and performance optimization.

**Appendices:** Explore the Appendices for various topics, including the WEKA CSI Plugin, which connects Kubernetes worker nodes to the WEKA data platform, and other tools and procedures that can enhance your work with WEKA.

{% hint style="info" %}
For maintenance and troubleshooting articles, search the WEKA Knowledge Base in the [WEKA support portal](https://support.weka.io/s/) or contact the [Customer Success Team](support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
{% endhint %}

### Conventions

* The documentation marks the CLI mandatory parameters with an asterisk (\*).
* New additions are marked with two asterisks (\*\*) in the [weka-rest-api-and-equivalent-cli-commands.md](getting-started-with-weka/weka-rest-api-and-equivalent-cli-commands.md "mention") and [weka-cli-hierarchy.md](getting-started-with-weka/manage-the-system-using-weka-cli/weka-cli-hierarchy.md "mention") topics.

### Documentation feedback

We are committed to delivering top-notch documentation and value your feedback. If you have comments or suggestions, email us at [documentation@weka.io](mailto:documentation@weka.io). When providing feedback, include the document version, topic title, and your suggestions for improvement. For technical questions, contact our [Customer Success Team](support/getting-support-for-your-weka-system.md).
