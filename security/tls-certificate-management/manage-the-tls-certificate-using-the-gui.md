---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/security/tls-certificate-management/manage-the-tls-certificate-using-the-gui
---

# Manage TLS certificates using GUI

## Set and download TLS certificate

Upon system installation, the cluster's TLS certificate is activated with an auto-generated self-signed certificate, enabling access to the GUI, CLI, and API via HTTPS. If you have a custom TLS certificate, you may replace the auto-generated self-signed certificate with your own. Additionally, you can download the existing TLS certificate for integration with other applications that require communication with the cluster, such as Local WEKA Home.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_tls_certificate.png" alt="TLS Certificate"></div>

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the TLS Certificate section, select **Set TLS certificate**.
4. In the Set Custom TLS Certificate dialog, do one of the following:
   * Select **Upload TLS certificate files**, and upload the TLS certificate and private key files.
   * Select **Paste the custom certificate content**, and paste the content of the TLS certificate and private key.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_set_custome_tls_certificate.png" alt="Set Custom TLS Certificate"></div>

5. To download the existing TLS certificate, select **Download TLS certificate**.\
   In the dialog, set a name for the certificate and select **Download**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_download_tls_certificate.png" alt="Download a TLS certificate"></div>

## Set custom CA certificate <a href="#set-custom-ca-certificate" id="set-custom-ca-certificate"></a>

The system uses well-known CA certificates to establish trust with external services. For example, when using a KMS. If a different CA certificate is required for Weka servers to establish trust, set this custom CA certificate on the Weka servers.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_custom_certificate.png" alt="Set custom CA certificate"></div>

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the TLS Certificate section, select **Set custom CA certificate**.
4. In the Set Custom CA Certificate dialog, do one of the following:
   * Select **Upload CA certificate file**, and upload the custom CA certificate file.
   * Select **Paste the custom certificate content**, and paste the content of the custom CA certificate.
5. Select **Save**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_set_custom_CA_certificate.png" alt="Set Custom CA certificate"></div>

## Manage the custom CA certificate <a href="#manage-the-custom-ca-certificate" id="manage-the-custom-ca-certificate"></a>

Once a CA certificate is set, you can:

* Replace the CA certificate with a new one according to the deployment needs.
* Remove (reset) the custom CA certificate settings.
* Download the existing CA certificate for later use.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_custom_certificate_set.png" alt="Custom Certificate"></div>

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the TLS Certificate section, select **Replace custom CA certificate**.
4. In the Set Custom CA Certificate dialog, do one of the following:
   * Select **Upload CA certificate file**, and upload the custom CA certificate file.
   * Select **Paste the custom certificate content**, and paste the content of the custom CA certificate.
5. Select **Save**.
6. If required to remove the custom CA certificate, select **Reset custom CA certificate settings**. In the confirmation message, select **Yes**.
7. To download the existing CA certificate, select **Download custom CA certificate**. In the dialog, set a name for the certificate and select **Download**.

<div data-with-frame="true"><img src="../../.gitbook/assets/wmng_download_custom_CA_certificate.png" alt="Download Custom CA Certificate"></div>

**Related topic**

[local-weka-home-deployment](../../monitor-the-weka-cluster/the-wekaio-support-cloud/local-weka-home-deployment/ "mention")

[deploy-local-weka-home-v2.x.md](../../monitor-the-weka-cluster/the-wekaio-support-cloud/deploy-local-weka-home-v2.x.md "mention")
