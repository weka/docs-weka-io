---
description: >-
  WEKA implements a comprehensive security framework with multiple controls to
  ensure secure communication and protect user data in the WEKA cluster.
---

# WEKA security overview

WEKA implements a comprehensive security framework designed to protect sensitive data, ensure secure communication, and prevent unauthorized access in the WEKA cluster. By integrating robust authentication, encryption, access controls, and monitoring, WEKA provides enterprise-grade security while maintaining high performance and scalability.

<figure><img src="../.gitbook/assets/weka_security_overview.png" alt=""><figcaption><p>WEKA security overview</p></figcaption></figure>

The following is an overview of WEKA’s key security features and management practices:

### **Authentication and access control**

* **Authentication tokens**: WEKA employs a dual-token system for secure access management:
  * **Access tokens:** Short-lived (5-minute validity) for API access and filesystem mounting.
  * **Refresh tokens:** Long-lived (configurable, default 1 month) for obtaining new access tokens.
* **Role-Based Access Control (RBAC) and ACLs**: Enables fine-grained permissions, ensuring users have access only to authorized data.

**Related topics**:

[obtain-authentication-tokens.md](obtain-authentication-tokens.md "mention")

[#access-control-lists-acls](../additional-protocols/smb-support/#access-control-lists-acls "mention") (in SMB)

[#access-control-list-acl-in-nfs](../additional-protocols/nfs-support/#access-control-list-acl-in-nfs "mention")

***

### **Account protection**

* **Brute force prevention**: WEKA implements account lockout policies to prevent unauthorized login attempts:
  * Default threshold: 5 failed attempts.
  * Default lockout duration: 2 minutes.

**Related topic**:

[account-lockout-threshold-policy-management.md](account-lockout-threshold-policy-management.md "mention")

***

### **Encryption and key management**

* **Data encryption**: Protects data at rest and in transit using:
  * TLS (1.2+) with 128-bit+ ciphers for secure communication.
  * KMIP-compliant KMS and HashiCorp Vault for encrypted filesystem management.
* **Encryption options**:
  * **Cluster-wide encryption key:** Single key securing the entire WEKA cluster.
  * **Per-filesystem encryption keys:** Available with HashiCorp Vault for **tenant isolation**.
* **KMS considerations**:
  * Required for secure key storage and management.
  * Essential for disaster recovery and snapshots.
  * Must be highly available for uninterrupted operations.

**Related topic**:

[kms-management](kms-management/ "mention")

***

### **Communication security**

* **TLS certificate management**: Ensures secure HTTPS access (port 14000) with options for:
  * Default self-signed certificates for cluster communication.
  * Custom certificates for enhanced security.
* **Cross-Origin Resource Sharing (CORS)**: Implements secure cross-domain access controls to prevent unauthorized API access.

**Related topics**:&#x20;

[tls-certificate-management](tls-certificate-management/ "mention")

[manage-cross-origin-resource-sharing.md](manage-cross-origin-resource-sharing.md "mention")

***

### **Network-level security**

* **CIDR-based security policies**: Enables network-level access control by allowing or denying connections based on IP address ranges.
* **Network segmentation and firewalls**:
  * Isolates critical systems from unauthorized access.
  * Uses firewalls and network ACLs to restrict communication.
  * Supports Intrusion Detection and Prevention Systems (IDS/IPS).

**Related topic**:&#x20;

[manage-cidr-based-security-policies.md](manage-cidr-based-security-policies.md "mention")

***

### **Auditing and monitoring**

* **Real-time monitoring and intrusion detection**: Tracks system activities to detect suspicious behavior.
* **Logging and forensic analysis**: Logs all file access, modifications, and permission changes for accountability.

**Related topics**:

[manage-alerts-and-integrations.md](../monitor-the-weka-cluster/the-wekaio-support-cloud/manage-alerts-and-integrations.md "mention") (Local WEKA Home)

[audit-s3-apis](../additional-protocols/s3/audit-s3-apis/ "mention")

[diagnostics-management](../support/diagnostics-management/ "mention")

***

### **User interface security**

* **Login banner**:
  * Customizable security statement or legal message on the GUI login page.
  * Warns against unauthorized access and outlines acceptable use policies.
* **Session management**:
  * Automatic logout after 30 minutes of inactivity to prevent unauthorized access.

**Related topic**:

[manage-the-login-banner.md](manage-the-login-banner.md "mention")

***

### **Security best practices**

To maintain optimal security, WEKA recommends:

* Regularly reviewing and updating security policies.
* Implementing strong disaster recovery strategies for KMS.
* Ensuring high availability of security services.
* Monitoring access logs and security events continuously.
* Rotating authentication tokens periodically.
* Educating users and administrators on security best practices.
