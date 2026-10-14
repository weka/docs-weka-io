---
description: >-
  A centralized service that delivers pre-built WEKA kernel drivers for
  supported Linux distributions, eliminating manual compilation while ensuring
  consistent deployment across environments.
---

# Drivers distribution service

## Overview

The Drivers Distribution Service (DDS) streamlines WEKA deployment by providing pre-built kernel drivers for supported Linux distributions. It automatically delivers appropriate drivers during installation of WEKA clusters and clients, eliminating the need for manual compilation or configuration.

By ensuring consistent driver availability across supported environments, DDS enables cluster and client pods to initialize and operate correctly with minimal administrative overhead.

### Specifications

* **Available drivers:**&#x20;
  * weka-driver
  * driver-igb-uio
  * driver-mpin-user
* **Supported operating systems**:
  * Amazon Linux 2 (for EKS)
  * Amazon Linux 2023
  * Oracle Linux 8
  * Rocky Linux 8
  * Red Hat Enterprise Linux 9 (for OpenShift)

### Accessing the service

Configure your WEKA clusters and clients to automatically download drivers from: [https://drivers.weka.io](https://drivers.weka.io).

For a configuration example, see [deploy-the-weka-client-on-amazon-eks.md](kubernetes/weka-operator-deployments/deploy-the-weka-client-on-amazon-eks.md "mention").
