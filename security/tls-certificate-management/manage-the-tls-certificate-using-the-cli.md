---
description: >-
  Manage TLS and CA certificates, including certificate status and downloads,
  using the CLI.
---

# Manage TLS certificates using the CLI

## Set the TLS certificate

Installs a TLS certificate and private key for the cluster's management interfaces.

**Command:** `weka security tls set`

```sh
weka security tls set --certificate <string> --private-key <string>
```

**Parameters**

| Parameter                   | Description                       |
| --- | --- |
| `--certificate` \<string>\* | Path to TLS certificate PEM file. |
| `--private-key` \<string>\* | Path to TLS private key PEM file. |

{% hint style="success" %}
**Example:**

This command is similar to the WEKA's OpenSSL command to generate the self-signed certificate: `openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days <days> -nodes`
{% endhint %}

## Replace the TLS certificate

Replaces the installed certificate with a new one. The new certificate takes effect for subsequent connections; revocation of the old one is handled by your CA.

**Command:** `weka security tls set`

```sh
weka security tls set --certificate <string> --private-key <string>
```

**Parameters**

| Parameter                   | Description                       |
| --- | --- |
| `--certificate` \<string>\* | Path to TLS certificate PEM file. |
| `--private-key` \<string>\* | Path to TLS private key PEM file. |

## Unset the TLS certificate

Removes the installed TLS certificate, returning the cluster to its self-signed certificate.

**Command:** `weka security tls reset`

```sh
weka security tls reset
```

## Download the TLS certificate

Downloads the cluster's current TLS certificate to a local file.

**Command:** `weka security tls download`

```sh
weka security tls download [<destination-path>]
```

**Parameters**

| Parameter          | Description                              |
| --- | --- |
| `destination-path` | Path to save the downloaded certificate. |

## View the TLS certificate status

Shows whether a user-supplied certificate is installed, and its details.

**Command:** `weka security tls status`

```sh
weka security tls status
```

## Set CA certificate

Installs a CA certificate so the cluster can trust an external service, such as a KMS, whose certificate is not signed by a well-known authority.

**Command:** `weka security ca-cert set`

```sh
weka security ca-cert set --cert-file <string>
```

**Parameters**

| Parameter                 | Description               |
| --- | --- |
| `--cert-file` \<string>\* | Path to certificate file. |
