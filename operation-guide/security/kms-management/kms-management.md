---
description: >-
  Explore procedures for managing Key Management System (KMS) integration with
  the WEKA system using the GUI.
---

# Manage KMS using the GUI

Using the GUI, you can:

* [Configure a KMS](kms-management.md#configure-a-kms)
* [View the KMS configuration](kms-management.md#view-the-kms-configuration)
* [Update the KMS configuration](kms-management.md#update-the-kms-configuration)
* [Remove the KMS configuration](kms-management.md#remove-the-kms-configuration)

## Configure a KMS

Configure the KMS of either HashiCorp Vault or KMIP within the WEKA system to encrypt filesystem keys securely.

**Before you begin**

Ensure the KMS is preconfigured, and the key and a valid token are readily available.

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. On the **Security** page, select **Configure KMS**.
4. On the **Configure KMS** dialog, select the KMS type to deploy: **HashiCorp Vault** or **KMIP**.
5. Set the connection properties according to the selected KMS type. Select the relevant tab for details:

{% tabs %}
{% tab title="Hashicorp Vault" %}
For the **HashiCorp Vault** type, set the following:

* **Address**: The KMS address.
* **Key Identifier**: Key name to secure the filesystem keys (encryption-as-a-service).
* **Role Id:** Role ID for KMS access with per-filesystem encryption. Required if KMS Namespace is defined. Provided by Vault administrator in HashiCorp environments.
* **Secret ID:** Secret ID for KMS access. Required if KMS Namespace is defined. Can also be set with WEKA\_KMS\_SECRET\_ID. Provided by Vault administrator in HashiCorp environments.
* **Namespace:** The namespace name that identifies the logical partition within the vault. It is used to organize and isolate data, policies, and configurations. Namespace names must not end with "/", avoid spaces, and refrain from using reserved names like `root`, `sys`, `audit`, `auth`, `cubbyhole`, and `identity`.

{% hint style="info" %}
The **Token** parameter is deprecated. Set the **Role Id** and **Secret ID** instead.
{% endhint %}

<div align="left"><img src="../../../.gitbook/assets/4.4.2_configure_KMS_Hashicorp.png" alt="HashiCorp Vault type configuration"></div>
{% endtab %}

{% tab title="KMIP " %}
For the **KMIP** type, set the following:

* **Address**: The address of the KMS in hostname:port format.
* **KMS Identifier**: Key UID to secure the filesystem keys (encryption-as-a-service).
* **Client Certificate:** The client certificate content of the PEM file.
* **Client Key**: The client key content of the PEM file.
* **CA Certificate**: (Optional) The CA certificate content of the PEM file.

<figure><img src="../../../.gitbook/assets/wmng_configure_KMIP.png" alt=""><figcaption><p>KMIP type configuration </p></figcaption></figure>
{% endtab %}
{% endtabs %}

6. Select **Save**.



**Related topics**

[Obtain an API token from the vault](kms-management-1.md#obtain-an-api-token-from-the-vault)

[Obtain a certificate for a KMIP-based KMS](kms-management-1.md#obtain-a-certificate-for-a-kmip-based-kms)

## View the KMS configuration

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.\
   The **Security** page displays the configured KMS.

![View the configured KMS](../../../.gitbook/assets/wmng_view_kms_settings.png)

## Update the KMS configuration

Update the KMS configuration in the WEKA system when changes occur in the KMS server details or cryptographic keys, ensuring seamless integration and continued secure filesystem key encryption.

{% hint style="info" %}
If your system is upgraded to version 4.4.2 or higher, the **Update KMS Configuration** screen displays a configuration with the Token parameter. Reset the KMS configuration and configure it using the new **Role ID** and **Secret ID** parameters.
{% endhint %}

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. The **Security** page displays the configured KMS.
4. Select **Update KMS**, and update the settings. For the parameter descriptions, see [#configure-a-kms](kms-management.md#configure-a-kms "mention").
5. Select **Save**.

## Reset the KMS configuration

Reseting a KMS configuration is possible only if no encrypted filesystems exist.

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the left pane, select **Security**.
3. The **Security** page displays the configured KMS.
4. Select **Reset KMS.**
5. In the message that appears, select **Yes** to confirm the KMS configuration reset.
