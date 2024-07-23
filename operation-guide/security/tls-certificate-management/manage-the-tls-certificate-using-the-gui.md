---
description: Set and download the TLS certificate using the GUI.
---

# Manage the TLS certificate using the GUI

Upon system installation, the cluster's TLS certificate is activated with an auto-generated self-signed certificate, enabling access to the GUI, CLI, and API via HTTPS. If you have a custom TLS certificate, you may replace the auto-generated self-signed certificate with your own. Additionally, you can download the existing TLS certificate for integration with other applications that require communication with the cluster, such as Local WEKA Home.



![TLS Certificate](../../../.gitbook/assets/wmng\_tls\_certificate.png)

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the TLS Certificate section, select **Set TLS certificate**.
4. In the Set Custom TLS Certificate dialog, do one of the following:
   * Select **Upload TLS certificate files**, and upload the TLS certificate and private key files.
   * Select **Paste the custom certificate content**, and paste the content of the TLS certificate and private key.

![Set Custom TLS Certificate](../../../.gitbook/assets/wmng\_set\_custome\_tls\_certificate.png)

5. To download the existing TLS certificate, select **Download TLS certificate**. \
   &#x20;In the dialog, set a name for the certificate and select **Download**.

![Download a TLS certificate](../../../.gitbook/assets/wmng\_download\_tls\_certificate.png)

**Related topic**

[local-weka-home-deployment.md](../../../monitor-the-weka-cluster/the-wekaio-support-cloud/local-weka-home-deployment.md "mention")

[deploy-local-weka-home-v2.x.md](../../../monitor-the-weka-cluster/the-wekaio-support-cloud/deploy-local-weka-home-v2.x.md "mention")
