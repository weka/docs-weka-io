---
description: >-
  Harden the security of a WEKA deployment. This guide covers Linux best
  practices, architectural requirements, port configurations, and auditing
  capabilities.
---

# Security hardening

## Operating system and filesystem configuration

Proper partitioning and filesystem constraints isolate critical data and prevent resource exhaustion. While standard hardening scripts often disable unused filesystems, WEKA has specific operational requirements that must be preserved.

### Partitioning

* **Mandatory WEKA Partition:** You **must** create a separate filesystem on a separate partition for the WEKA installation directory, set to `/opt/weka`
* **Standard Isolation:** Create separate partitions for the following to prevent root volume exhaustion:
  * `/var`
  * `/var/tmp`
  * `/var/log`
  * `/var/log/audit`
  * `/home`

### Filesystem modules

Reduce the kernel attack surface by disabling unused filesystem modules.

* **Disable:** `cramfs`, `freevxfs`, `jffs2`, `hfs`, `hfsplus`, and `udf`.
* **Critical Exception:** Do **not** disable `squashfs`. Squashfs is required for WEKA operations.

### Mount options

Apply restrictive mount options to temporary and shared memory partitions to prevent unauthorized execution or device creation:

* **`/tmp`**: Set `nodev`, `nosuid`.
* **`/var/tmp`**: Set `nodev`, `nosuid`, `noexec`.
* **`/dev/shm`**: Set `nodev`, `nosuid`, `noexec`.
* **`/home`**: Set `nodev`.
* **Removable Media**: Set `nodev`, `nosuid`, `noexec`.

## Network security and firewall

Hardening the network involves a "default deny" policy while explicitly allowing WEKA's required high-performance communication ports.

### Protocol hardening

* **Disable Unused Protocols:** Disable DCCP, SCTP, RDS, and TIPC.
* **IPv6:** Disable IPv6 if not explicitly required for the cluster deployment.
* **Wireless:** Ensure wireless interfaces are disabled.
* **Packet handling:** Disable packet redirect sending and IP forwarding, except where required, such as for Kubernetes CNI networking.
* **SYN flood:** Enable TCP SYN cookies to mitigate SYN flood attacks.

### Firewall port requirements

* Configure the firewall (e.g., `firewalld`, `nftables`, or `ufw`) with a default deny policy.
* For exact ports and more details refer to [Prerequisites and compatibility](/broken/pages/a4d5c19fdab6ee7d239463f51277b869afa22ca8#required-ports) section.

### CIDR-based access policies

Implement CIDR-based security policies to strictly regulate access to cluster management and POSIX data services based on client IP addresses. These policies operate at the network level, providing a critical layer of defense that complements user authentication.

* **Enforce explicit deny:** By default, WEKA allows access to clients that do not match any specific policy. To effectively harden the system, you **must** configure specific "Allow" rules for authorized networks (such as backend subnets and administrative workstations) and append a final "Deny All" policy to block all other traffic.
* **Order matters:** Policies are evaluated in the order they are attached. Ensure specific allow rules are listed _before_ the generic deny rule, as the first matching rule takes precedence.
* **Active session persistence:** Note that applying or modifying security policies does not terminate existing client connections. Changes apply only to new connection attempts, so you must manually disconnect unauthorized clients if necessary.

## Access control and authentication

### User management

* **Directory integration:** Join the WEKA cluster to Active Directory (`weka user ldap setup-ad`) or LDAP (`weka user ldap setup`) to manage roles centrally.
  * **Local users:** Reset the default `admin` password immediately upon installation.
* **Password policy:** Enforce a minimum of 8 characters, requiring at least one uppercase, lowercase, and number/special character.
* **Lockout policy:** Configure accounts to lock after 5 failed attempts for 2 minutes to prevent brute-force attacks (`weka security lockout-config set`).

### SSH and root security

* **Sudo:** Ensure `sudo` is installed and restricted to authorized users.
* **SSH configuration:**
  * Disable `X11Forwarding` unless required for other tooling.
  * Set `MaxAuthTries` to 4 or less.
  * Disable `HostbasedAuthentication`.
  * Disable `PermitEmptyPasswords`.
  * Ensure SSH warning banners are configured.

### Cluster integrity

* **Join secret:** Use Join Secret to ensure only authorized backends can join the cluster. This prevents malicious nodes from infiltrating the storage grid.
* **Join IP filtering:** In addition to secrets, members can be filtered by IP address. Define a list of authorized IPs using `weka security policy join` and apply it to the join process (e.g., `weka security policy join set --backend <policy>`). This ensures that even if a secret is compromised, a node cannot join from an unauthorized network.

## Data encryption

### Encryption at rest

* **Enable encryption:** WEKA encrypts data on drives using XTS-AES-256.
* **Mandatory external KMS:** You **must** integrate with an external **Key Management Service (KMS)** (e.g., HashiCorp Vault, KMIP) to manage master keys.
* **Critical warning:** Operating encrypted filesystems without an external KMS lowers security to a nonexistent due to:
  * **Cluster storage:** Without a KMS, filesystem keys are wrapped with a key that is available in **plaintext** in the configuration and serialized to the local disk on all backend servers.
  * **Snap-to-object:** Snapshots offloaded to object stores are wrapped using a **constant, non-customizable generic key**. This renders security nonexistent for these snapshots, as the key is not unique to the environment.

### Encryption in Transit

* **RPC (inter-node):** The cluster utilizes a secure RPC mechanism for sensitive internal communication between all cluster members, clients, and servers (e.g., transmitting file keys or handling the edges of unaligned reads/writes). This traffic is secured using **X25519+BLAKE2B-512** for key exchange and the **IETF variant of ChaCha20-Poly1305** for symmetric encryption.
* **POSIX:** The WEKA client is part of the cluster and accesses data as a local filesystem. Therefore, data is not encrypted with a specific in-transit network protocol (like TLS). Instead, security relies on the **filesystem encryption**: if the filesystem is encrypted, the data accessed and transmitted by the POSIX client is encrypted. Some parts of the data, such as unaligned prefixes or suffixes in reads and writes, are encrypted using our RPC encryption rather than XTS-AES. At present, this is the IETF variant of ChaCha20-Poly1305.
* **S3:** Use TLS 1.2 or 1.3 for all S3 traffic.
* **OBS (tiering):** Traffic exchanged with the Object Store (OBS) for tiering or Snap-to-Object is encrypted using TLS, but **only** if the target bucket was explicitly configured using the **HTTPS** protocol. If the bucket was added using HTTP, this traffic will be unencrypted.
* **SMB:** Configure the cluster to encrypt outgoing SMB traffic. WEKA supports SMB encryption and message signing (HMAC-SHA256 for SMB2 and AES-CMAC for SMB3).
* **NFS:** Use Kerberos **krb5p** mode to encrypt all NFS RPC traffic.

### Certificates and TLS configuration

* **Replace default certificates:** Do not rely on default or self-signed certificates in production. While WEKA supports TLS for securing data in transit, using the default "Container Certificate" for services or telemetry does not establish a verifiable chain of trust.
* **Custom CA-signed certificates:** Use the **manage TLS certificates** feature to import custom certificates signed by a trusted Certificate Authority (CA). This ensures strictly validated identity for the GUI, REST API, and data protocols, preventing Man-in-the-Middle (MITM) attacks.

## Auditing and logging

A robust auditing strategy combines OS-level tracking (auditd) with WEKA's internal telemetry.

### Operating system auditing (`auditd`)

Ensure `auditd` is installed and active. Configure rules to capture the following:

* **System changes:** Events modifying date/time (`time-change`), user/group information (`identity`), and network environment (`system-locale`).
* **Privileged actions:** Use of privileged commands (`sudo`) and system administrator actions.
* **Permissions:** Audit `chmod`, `fchmod`, `fchmodat`, `chown`, `fchown`, `fchownat`, `setxattr`, `lsetxattr`, `fsetxattr`, and `removexattr` system calls.

### WEKA cluster auditing

* **Enable cluster auditing:** Run `weka audit cluster enable` to activate telemetry containers.
* **Export destinations:** Configure WEKA to forward audit logs to external systems for retention and analysis.
* **WEKA cluster auditing to S3:** Export logs to a secured S3 bucket.
* **S3 Bucket notifications to Kafka:** Stream S3 events to a Kafka topic using SASL authentication.
* **Splunk for S3 protocol auditing:** Use the HTTP Event Collector (HEC).
  * **S3 protocol auditing:** WEKA logs S3 operations (e.g., `PutObject`, `GetObject`). Logs include the `remotehost` (client IP), `userAgent`, and `bucket` name for tracking unauthorized access.

## Mandatory Access Control (MAC)

* **SELinux:** WEKA explicitly supports running **SELinux** on clients in `Enforcing` mode. This is the recommended MAC solution.

## Maintenance

* **Software updates:** Ensure updates and patches are installed.
* **Compatibility check:** Before applying OS updates (Kernel, OS, OFED packages), explicitly verify they remain compatible with the installed version of WEKA.
