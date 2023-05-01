# Manage the CA certificate using the GUI

Using the GUI, you can:

* [Set custom CA certificate](manage-the-ca-certificate-using-the-gui.md#set-custom-ca-certificate)
* [Manage the custom CA certificate](manage-the-ca-certificate-using-the-gui.md#manage-the-custom-ca-certificate):
  * Replace the custom CA certificate
  * Reset the custom CA certificate settings
  * Download the custom CA certificate

## Set custom CA certificate <a href="#set-custom-ca-certificate" id="set-custom-ca-certificate"></a>

The system uses well-known CA certificates to establish trust with external services. For example, when using a KMS. If a different CA certificate is required for Weka servers to establish trust, set this custom CA certificate on the Weka servers.

![Set custom CA certificate](../../../.gitbook/assets/wmng\_custom\_certificate.png)

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. In the TLS Certificate section, select **Set custom CA certificate**.
4. In the Set Custom CA Certificate dialog, do one of the following:
   * Select **Upload CA certificate file**, and upload the custom CA certificate file.
   * Select **Paste the custom certificate content**, and paste the content of the custom CA certificate.
5. Select **Save**.

![Set Custom CA certificate](../../../.gitbook/assets/wmng\_set\_custom\_CA\_certificate.png)

## Manage the custom CA certificate <a href="#manage-the-custom-ca-certificate" id="manage-the-custom-ca-certificate"></a>

Once a CA certificate is set, you can:

* Replace the CA certificate with a new one according to the deployment needs.
* Remove (reset) the custom CA certificate settings.
* Download the existing CA certificate for later use.

![Custom Certificate](../../../.gitbook/assets/wmng\_custom\_certificate\_set.png)

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

![Download Custom CA Certificate](../../../.gitbook/assets/wmng\_download\_custom\_CA\_certificate.png)
