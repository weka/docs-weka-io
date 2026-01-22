---
title: Supported KMS types
---

**Supported KMS types:**

* [**KMIP-compliant KMS**](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html)**:** Supports protocol versions 1.2+ and 2.x. Only TTLV[^1] is supported as the messaging protocol. Supports commercial solutions such as Thales CipherTrust Manager.
* [**HashiCorp Vault**](https://www.hashicorp.com/products/vault/)**:** Supports versions 1.1.5 to 1.x.

[^1]: **TTLV (Tag-Length-Value)** is a binary encoding format used in KMIP for structured and efficient messaging between a KMS and its clients. It consists of a tag (data type), length (size), and value (data).
