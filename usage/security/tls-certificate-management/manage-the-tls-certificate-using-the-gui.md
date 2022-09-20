---
description: >-
  This page describes how to deploy and replace the TLS certificate using the
  GUI.
---

# Manage the TLS certificate using the GUI

Once the system installation is completed, the cluster TLS certificate is enabled with an auto-generated self-signed certificate to access the GUI, CLI, and API through HTTPS. If you have a custom TLS certificate, you can set it instead of the auto-generated self-signed certificate.

You can also download the existing TLS certificate for later use if you want to use the self-signed certificate.



![TLS Certificate](../../../.gitbook/assets/wmng\_tls\_certificate.png)

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the TLS Certificate section, select **Set TLS certificate**.
4. In the Set Custom TLS Certificate dialog, do one of the following:
   * Select **Upload TLS certificate files**, and upload the TLS certificate and private key files.
   * Select **Paste the custom certificate content**, and paste the content of the TLS certificate and private key.

![Set Custom TLS Certificate](../../../.gitbook/assets/wmng\_set\_custome\_tls\_certificate.png)

5\. To download the existing TLS certificate, select **Download TLS certificate**. \
&#x20;    In the dialog, set a name for the certificate and select **Download**.

![Download a TLS certificate](../../../.gitbook/assets/wmng\_download\_tls\_certificate.png)
