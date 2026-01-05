---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/audit-s3-apis/configure-audit-webhook-using-the-gui
---

# Configure audit webhook using the GUI

The audit webhook sends S3 APIs audit events to a remote system (for example, Splunk). These events provide a better understanding of the traffic nature.

When creating an S3 cluster, the audit webhook is default enabled but not configured.

**Before you begin**

[#create-an-s3-cluster](../s3-cluster-management/s3-cluster-management.md#create-an-s3-cluster "mention")

**Procedure**

1. From the menu, select **Manage > Protocols**.
2. From the Protocols pane, select **S3**.
3. On the S3 Cluster Configuration, select the **Configure audit webhook** icon.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/wmng_audit_webhook_button.png" alt=""><figcaption><p><strong>Configure audit webhook</strong></p></figcaption></figure></div>

4. On the Audit Webhook Configuration dialog, set the following:
   * **Endpoint:** The webhook endpoint URL that receives the events stream.
   * **Auth Token:** The webhook authentication token.
5. Select **Save**.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/wmng_audit_webhook_configuration.png" alt=""><figcaption><p>Audit Webhook Configuration</p></figcaption></figure></div>
