# Enable the SR-IOV

Many hardware vendors ship their products with the SR-IOV feature disabled. The feature must be enabled on such platforms before installing the Weka system. Enabling the SR-IOV applies to the server BIOS.

If the SR-IOV is already enabled, it is recommended to verify the current state before proceeding with the installation of the Weka system.

## Before you begin

Verify that the NIC drivers are installed and loaded successfully. If it still needs to be done, perform the [Install NIC drivers](./#install-nic-drivers) procedure.

## Enable SR-IOV in the server BIOS

The following procedure is a vendor-specific example and is provided as a courtesy. Depending on the vendor, the same settings may appear differently or be located elsewhere. Therefore, refer to your hardware platform and NIC vendor documentation for the latest information and updates.

{% tabs %}
{% tab title="1. Reboot server" %}
Reboot the server and enter the BIOS Setup.

<figure><img src="../../../.gitbook/assets/sr-iov_setup_1.png" alt=""><figcaption><p>Main screen</p></figcaption></figure>
{% endtab %}

{% tab title="2. Select PCIe Configuration" %}
From the Advanced menu, select the PCIe Configuration to display its properties.

<figure><img src="../../../.gitbook/assets/sr-iov_setup_2.png" alt=""><figcaption><p>Advanced screen</p></figcaption></figure>
{% endtab %}

{% tab title="3. Enable SR-IOV" %}
Select the SR-IOV support and enable it.

<figure><img src="../../../.gitbook/assets/sr-iov_setup_3.png" alt=""><figcaption><p>Enable SR-IOV</p></figcaption></figure>
{% endtab %}

{% tab title="4. Save and exit" %}
Save the configuration changes and exit.

<figure><img src="../../../.gitbook/assets/sr-iov_setup_4.png" alt=""><figcaption><p>Save and Exit</p></figcaption></figure>
{% endtab %}
{% endtabs %}
