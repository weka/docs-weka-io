---
description: >-
  This page describes how to deploy and replace the TLS certificate using the
  CLI.
---

# Manage the TLS certificate using the CLI

### Set the TLS certificate

You can set your TLS certificates using the CLI command: `weka security tls set`.

The command receives an unencrypted private key.

{% hint style="success" %}
**Example:**

This command is similar to the OpenSSL command that WEKA Sales or Support uses to generate the self-signed certificate: `openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`
{% endhint %}

### Replace the TLS certificate

To replace the TLS certificate with a new one, use the CLI command: `weka security tls set`.

Once you issue a TLS certificate, it is used for connecting to the cluster (for the time it is issued), while the revocation is handled by the CA and propagating its revocation lists into the various clients.

### Unset the TLS certificate

You can unset your TLS certificates using the CLI command: `weka security tls unset`.

### Download the TLS certificate

To download the TLS certificate, use the CLI command: `weka security tls download`.

### View the TLS certificate status

To view the cluster TLS status and certificate, use the CLI command: `weka security tls status`.
