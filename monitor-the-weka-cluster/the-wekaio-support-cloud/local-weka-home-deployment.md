---
description: >-
  Explore procedures for deploying the Local WEKA Home v3.0 or higher,
  upgrading, modifying the configuration, and troubleshooting.
---

# Deploy Local WEKA Home v3.0 or higher

This Local WEKA Home implementation runs on K3s, a lightweight Kubernetes installed on a single node cluster. Customize the deployment by specifying configuration parameters in the `config.json` file.

{% hint style="info" %}
It is possible to install the Local WEKA Home within the customer's Kubernetes infrastructure using Helm Charts. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md) to schedule this installation.
{% endhint %}

<figure><img src="../../.gitbook/assets/LWH_on_K3s.png" alt=""><figcaption><p>Local WEKA Home v3.0 or higher deployment</p></figcaption></figure>

## Workflow: Local WEKA Home deployment

If you have deployed the WMS, follow the procedure:[deploy-monitoring-tools-using-the-weka-management-station-wms.md](../deploy-monitoring-tools-using-the-weka-management-station-wms.md "mention"). Otherwise, perform the following workflow:

1. [Verify prerequisites](local-weka-home-deployment.md#id-1.-verify-prerequisites)
2. [Prepare the physical server (or VM)](local-weka-home-deployment.md#id-2.-prepare-the-physical-server-or-vm)
3. [Download the Local WEKA Home bundle](local-weka-home-deployment.md#id-3.-download-the-local-weka-home-bundle)
4. [Install and configure the Local WEKA Home](local-weka-home-deployment.md#id-4.-install-and-configure-local-weka-home)
5. [Access the Local WEKA Home portal and Grafana](local-weka-home-deployment.md#id-5.-access-the-local-weka-home-portal-and-grafana)
6. [Enable the WEKA cluster to send data to the Local WEKA Home](local-weka-home-deployment.md#id-6.-enable-the-weka-cluster-to-send-information-to-the-local-weka-home)
7. [Test the deployment](local-weka-home-deployment.md#id-7.-test-the-deployment)

### 1.  Verify prerequisites

Verify that the following requirements are met:

* A dedicated physical server (or VM) for the installation with `systemd`.&#x20;
* The user account for installing the LWH must have root privileges.
* Server minimum CPU and RAM requirements:
  * Minimum 8 CPUs and 20 GiB RAM for up to 1000 total processes.
    * Total processes are equal to the cores used on the cluster **backends** for Management/Frontend/Compute/Drives roles and the cores used on **clients** for Management/Frontend roles.
  *   Sizing for additional processes:

      * The total number of processes determines the number of CPU and RAM required.
      * For every additional 1000 processes or less, add 1 CPU and 8 GiB RAM.

      Example: 20 backends with 10 processes each = 200 processes; 500 clients with 2 processes each = 1000 processes. The total is 1200 processes. This deployment requires 9 CPUs and 28 GiB.
* SSD-backed storage requirements:
  * Minimum 500 GiB for locally collected data in `/opt/wekahome/data`
* 1 Gbps network

{% hint style="success" %}
For using other operating systems, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### 2. Prepare the physical server (or VM)

1. It's recommended to disable the _SELinux_.
2.  If enabled, it is required to disable nm-cloud-setup and reboot the node:

    ```
    systemctl disable nm-cloud-setup.service nm-cloud-setup.timer
    reboot
    ```
3.  Ensure the following ports are open and not used by any other process. Each port is used for the process specified in the brackets. `homecli` adds firewall rules automatically during installation for supported systems `(firewalld`, `ufw)`. For any other setup, check the following ports:

    `6443`   (kube-apiserver)

    `10259` (kube-scheduler)

    `10257` (kube-controller-manager)

    `10250` (kubelet)

    `80`        (Local WEKA Home, WEKA cluster, and web browser)

    `443`      (Local WEKA Home, WEKA cluster, and web browser)
4. Ensure the following networks are trusted:
   1. `10.42.0.0/16` (pods)
   2. `10.43.0.0/16` (services)

{% hint style="info" %}
If you forward data from the Local WEKA Home to the Cloud WEKA Home, ensure the outbound traffic on port 443 is open.
{% endhint %}

### 3. Download the Local WEKA Home bundle

Download the latest [Local WEKA Home bundle](https://get.weka.io/ui/lwh/download) (v3.0 or above) to the dedicated server or VM.

### 4. Install and configure Local WEKA Home

1. Run the Local WEKA Home setup bundle as a root user (where `*` is wekahome version):\
   `bash wekahome-*.bundle`
2. To update the environment, do one of the following:
   * Re-login to the server.
   * Run the following command: `source /etc/profile`
3. To customize the configuration, create the`config.json` file based on the following examples:

<details>

<summary>config.json template</summary>

```json
{
 "host": "some.domain.com",
 "smtp":{
    "sender": "Weka Home",
    "host": "smtp.gmail.com",
    "port": 587,
    "user": "username@your-domain.com",
    "password": "your_password",
    "senderEmail": "weka-home-noreply@your-domain.com",
    "insecure": false
 },
 "retentionDays": {
   "diagnostics": 10,
   "events": 20
 },
 "forwarding": {
    "enabled": false,
    "url": "https://api.home.weka.io",
    "enableEvents": true,
    "enableUsageReports": true,
    "enableAnalytics": true,
    "enableDiagnostics": true,
    "enableStats": true,
    "enableClusterRegistration": true
 }
}
```

</details>

<details>

<summary>Domain</summary>

Set the domain for URL accessing the Local Weka Home portal either by the organization domain FQDN (DNS-based) or IP address (IP-based).

The URL to access the Local Weka Home does not accept aliases of the DNS name.&#x20;

Only the name configured in the `config.json` or passed via CLI argument `--host some.domain.com` during setup can be used for accessing the Local Weka Home.

DNS-based domain setting:\
In the **host** section at the top of the file, set the domain FQDN as shown in the following example:

```json
{
  "host": "some.domain.com"
}
```

IP-based domain setting:\
In the **host** section (at the top of the file) set the IP address of the domain as shown in the following example:

```json
{
  "host": "52.20.26.14"
}
```

If the host section is not set - the first IP address from the provided network interface will be used.

</details>

<details>

<summary>SMTP</summary>

To enable the Local Weka Home to send emails, set the SMTP details in the **smtp** section as shown in the following example:

```json
{
  "smtp":{
    "sender": "Weka Home",
    "host": "smtp.gmail.com",
    "port": 587,
    "user": "username@your-domain.com",
    "password": "your_password",
    "senderEmail": "weka-home-noreply@your-domain.com",
    "insecure": false,
   }
}
```

If your SMTP server uses a self-signed certificate, set the line `"insecure":` to `true`.

Ensure to enable the SMTP relay service in your SMTP service.&#x20;

The Google SMTP server requires an [app password](https://support.google.com/mail/answer/185833?hl=en).

Once the Local Weka Home is deployed, you can set it to send alerts by email, SNMP, or PagerDuty. See the [Set the Local Weka Home to send alerts](broken-reference) topic.

</details>

<details>

<summary>TLS certificates</summary>

To enforce HTTPS connection, you can pass TLS certificates to `config.json` or use CLI arguments with a certificate and key filenames `--tls-cert cert.pem --tls-key key.pem` during the next setup step.

Example of passing TLS settings in JSON:

```json
{
  "tls":{
    "cert":"-----BEGIN CERTIFICATE-----\n-----END CERTIFICATE-----\n",
    "key":"-----BEGIN PRIVATE KEY-----\n-----END PRIVATE KEY-----\n"
  }
}
```

To use an IP address as a hostname and to have a valid certificate, make sure you pass SAN during creation. A SAN or subject alternative name is a structured way to indicate all domain names and IP addresses secured by the certificate.

You can generate a self-signed certificate using the following example:\
`openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`

</details>

<details>

<summary>Events retention period</summary>

The default number of days to keep events in the Local WEKA Home is 30. To reduce the consumption of disk space, specify the max number of days in the **retentionDays** section, as shown in the following example:

```json
{
  "retentionDays": {
   "diagnostics": 10,
   "events": 20
  }
}
```

</details>

<details>

<summary>Forward data from the Local WEKA Home to the Cloud WEKA Home</summary>

In the **forwarding** section, set the forwarding parameters to **true**, as shown in the following sample. This is the default setting starting in Local WEKA Home v2.10.

To turn off forwarding metrics to Cloud WEKA Home from Local WEKA Home, set `enabled: false` below.

```json
{
  "forwarding": {
    "enabled": true,
    "url": "https://api.home.weka.io",
    "enableEvents": true,
    "enableUsageReports": true,
    "enableAnalytics": true,
    "enableDiagnostics": true,
    "enableStats": true,
    "enableClusterRegistration": true
  }
}
```

</details>

4. To initialize the setup, run the following command from the root user: `homecli local setup -c config.json`\
   \
   For a fresh installation, expect approximately 5 minutes for completion.\
   \
   **Options:**
   * You can use the default configuration by running: \
     `homecli local setup`
   * Specify the network interface or bind address for the cluster using:\
     `homecli local setup --iface <interface> --ip <IP address>`
   * Set your domain name or external IP as the host with:\
     `homecli local setup --host <host.domain.com>`&#x20;
   * Enable HTTPS by providing a certificate and key directly to the command instead of using the  `config.json`:\
     `homecli local setup --iface <interface> --tls-cert <cert.pem> --tls-key <key.pem>`

<details>

<summary>Response example of a successful Local WEKA Home installation</summary>

```
helm status wekahome -n home-weka-io
NAME: wekahome
LAST DEPLOYED: Thu Jan  5 09:30:42 2023
NAMESPACE: home-weka-io
STATUS: deployed
REVISION: 3
TEST SUITE: None
NOTES:
Thank you for installing home-weka-io.
Your release is named homewekaio
To learn more about the release, try:

  $ helm status homewekaio -n home-weka-io
  $ helm get all homewekaio -n home-weka-io

------------------------------------------------------------------------
Weka Home Frontend:
------------------------------------------------------------------------
URL:
https://172.31.46.11
Username:
admin
To obtain password, run:
kubectl get secret -n home-weka-io weka-home-admin-credentials -o jsonpath='{.data.admin_password}' | base64 -d

------------------------------------------------------------------------
Weka Home REST API:
------------------------------------------------------------------------
URL:
https://172.31.46.11/api/

------------------------------------------------------------------------
Weka Home Statistics (Grafana):
------------------------------------------------------------------------
URL:
https://172.31.46.11/stats/
Username:
admin
To obtain password, run:
kubectl get secret -n home-weka-io weka-home-grafana-credentials  -o jsonpath='{.data.password}' | base64 -d

------------------------------------------------------------------------
Weka Home Encryption Secret Key
------------------------------------------------------------------------
To obtain secretkey, run:
kubectl get secret -n home-weka-io weka-home-encryption  -o jsonpath='{.data.encryption_secret_key}' | base64 -d

------------------------------------------------------------------------
Technical information
------------------------------------------------------------------------
Number of event store databases: 1
Easy wekahoming!

```

</details>

### 5. Access the Local WEKA Home portal and Grafana

* **URLs:**
  * **LWH portal:** `https://<your_domain>`
  * **Grafana:** `https://<your_domain>/stats/`
  * **WEKA Home REST API:** `https://<your_domain>/api/`
* **Username:** `admin` (for accessing all portals).
* **Passwords to access the URLs:**
  * **Obtain the LWH portal password:** Run the command:\
    `kubectl get secret -n home-weka-io wekahome-admin-credentials -o jsonpath='{.data.adminPassword}' | base64 -d`
  * **Obtain the Grafana portal password:** Run the command:\
    `kubectl get secret -n home-weka-io wekahome-grafana-credentials  -o jsonpath='{.data.password}' | base64 -d`
  * **Obtain the WEKA Home secret key:** Run the command:\
    `kubectl get secret -n home-weka-io wekahome-encryption-key -o jsonpath='{.data.encryptionKey}' | base64 -d`

### 6. Enable the WEKA cluster to send information to the Local WEKA Home

By default, the WEKA cluster is set to send information to the public instance of WEKA Home. To get the information in the Local WEKA Home, connect to the WEKA cluster and run one of the following commands depending on the configuration:

* Standard configuration:

```
weka cloud enable --cloud-url http://<ip or hostname of the Local WEKA Home server>
```

* Secure configuration with valid TLS certificates:

```
weka cloud enable --cloud-url https://<ip or hostname of the Local WEKA Home server> 
```

### 7. Test the deployment

The WEKA cluster uploads data to the Local WEKA Home periodically and on-demand according to its information type (see the Which information is uploaded to the WEKA Home section).&#x20;

Access the WEKA Home portal and verify that the test data appears.

To trigger a test event, run `weka events trigger-event test` and verify the test event is received in the Local WEKA Home portal under the **Events** section.

If required, go to `/var/log/wekahome` and review the relevant log according to the timestamp (for example, `wekahome-install-03-08-2023_16-29.log`).

## Upgrade the Local WEKA Home

The upgrade process takes up to 5 minutes. It is recommended to perform the upgrade during a maintenance window.

{% hint style="info" %}
Upgrading from `minikube` or WMS to the new Local WEKA Home 3.0 bundle (based on `K3s`) is not supported. To upgrade, install the new Local WEKA Home bundle to the new server and add API forwarding from the `minikube` cluster to the new `K3s` cluster.&#x20;
{% endhint %}

**Procedure**

1. Download the latest [Local WEKA Home bundle](https://get.weka.io/ui/lwh/download) to the dedicated physical server (or VM).
2. Run `bash wekahome-*.bundle`
3. To modify the existing configuration, open the `/opt/wekahome/config/config.json` file and modify the settings. See [Install and configure Local WEKA Home](local-weka-home-deployment.md#id-4.-install-and-configure-local-weka-home).
4. Run `homecli local upgrade`. For an upgrade, it takes about 2 minutes.
5. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods' statuses, run `watch kubectl get pods`.)
6. Verify the Local WEKA Home is upgraded successfully. Run the following command line:\
   `helm status wekahome -n home-weka-io`

## Modify the Local WEKA Home configuration

If there is a change in the TLS certificates, SMTP server in your environment, or any other settings in the Local WEKA Home configuration, you can modify the existing `config.json` with your new settings and apply them.

**Procedure**

1. Open the `/opt/wekahome/config/config.json` file and modify the settings. See [Install and configure Local WEKA Home](local-weka-home-deployment.md#5.-install-and-configure-local-weka-home).
2. Run `homecli local upgrade`
3. Run `kubectl get pods -n home-weka-io` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods' statuses, run `watch kubectl get pods`.)
4. Verify the Local WEKA Home is updated successfully. Run the following command line:\
   `helm status wekahome -n home-weka-io`

## Troubleshoot the Local WEKA Home deployment

### Symptom: browsing to the Local WEKA Home returns an error

The probable cause can be, for example, a communication problem.

#### Resolution

1. Check the firewall and node IP settings. If you didn't set up a firewall (see [#id-2.-prepare-the-management-server](local-weka-home-deployment.md#id-2.-prepare-the-management-server "mention")), set valid rules and run:

```
k3s-killall.sh
homecli local upgrade
```

2. Retrieve the ingress pod (controller) of the Local WEKA Home.

```
kubectl get pods -n kube-system -o name -l app.kubernetes.io/name=traefik
```

3. Retrieve the logs and look for the error.

```
kubectl logs <pod name from previous command> -n kube-system > traefik.out
```

### Symptom: when executing any command on the Local WEKA Home, the error “no space left” is displayed&#x20;

The probable cause for this issue is that the containers dir (`/var/lib/rancher/k3s`) consumes disk space.

#### Resolution

Do one of the following:

* Try to clean unused images with `homecli local cleanup images`
* Resize the disk and reinstall the Local WEKA Home.
* Relocate the K3s root directory path to a new path on a larger device (if it exists) and copy the content from the old path to the new path.

### Symptom: when testing the integration, the email is not received

The probable cause can be issues related to the SMTP server, such as wrong credentials or recipient email address.

#### Resolution

1. On the **Integration** page, select **Test Integration**.\
   Wait until an error appears.
2. Retrieve the logs and search for the error. On the Local WEKA Home terminal, run the following command:\
   ``for dep in `kubectl get deployment -n home-weka-io -o name`; do echo -----$dep-----; kubectl logs $dep --all-containers=true --timestamps=true --since=5m ; done``

## Collect LWH deployment diagnostics

The LWH provides a script that collects various resource details from the LWH deployed on the Kubernetes cluster and generates an archive. This information helps the Customer Success Team and R\&D to analyze and provide support when troubleshooting is needed.

The LWH deployment diagnostics provide the following information:

* Pods status
* Logs of all pods
* K3s settings
* Free disk space
* CPU and memory usage
* Name resolutions
* LWH version
* Syslogs

**Procedure**

1. Run the following command:

{% code overflow="wrap" %}
```bash
homecli local collect-debug-info [archive] [--include-sensitive] [--full-disk-scan] [--verbose]
```
{% endcode %}

2. Once you generate the LWH deployment diagnostics archive file, send it to the Customer Success Team for analysis.

**Parameters**

<table><thead><tr><th width="242">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>archive</code>*</td><td>The path and output archive file name. <br>For example: <code>/path/diag/lwh_diagnostics.tar.gz</code></td></tr><tr><td><code>include-sensitive</code></td><td>Include sensitive data in the archive. For example, value overrides.<br>Use this parameter only if required by the Customer Success Team.</td></tr><tr><td><code>full-disk-scan</code></td><td>Perform a higher level of disk scan.<br>Use this parameter only if required by the Customer Success Team.</td></tr><tr><td><code>verbose</code></td><td>Provide a higher verbosity level of the debug information.</td></tr></tbody></table>
