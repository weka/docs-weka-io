---
description: >-
  Explore procedures for deploying the Local WEKA Home v2.x, upgrading,
  modifying the configuration, and troubleshooting.
---

# Deploy Local WEKA Home v2.x

This Local WEKA Home v2.x runs on Minikube (a lightweight Kubernetes implementation) installed on a single Docker container. You specify the configuration parameters in the config.yaml file as part of the deployment workflow.

{% hint style="info" %}
It is possible to install the Local WEKA Home within the customer's Kubernetes infrastructure using Helm Charts. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to schedule this installation.
{% endhint %}

<figure><img src="../../.gitbook/assets/LWH_on_Minikube.png" alt=""><figcaption><p>Local WEKA Home v2.x deployment</p></figcaption></figure>

## Workflow: Local WEKA Home deployment

If you have deployed the WMS, follow the procedure:. Otherwise, perform the following workflow:

1. [Verify prerequisites](deploy-local-weka-home-v2.x.md#id-1.-verify-prerequisites)
2. [Prepare the physical server (or VM)](deploy-local-weka-home-v2.x.md#id-2.-prepare-the-physical-server-or-vm)
3. [Download the Local WEKA Home and Minikube packages](deploy-local-weka-home-v2.x.md#id-3.-download-the-local-weka-home-and-minikube-packages)
4. [Install the Minikube](deploy-local-weka-home-v2.x.md#id-4.-install-the-minikube)
5. [Install and configure the Local WEKA Home](deploy-local-weka-home-v2.x.md#id-5.-install-and-configure-the-local-weka-home)
6. [Access the Local WEKA Home portal and Grafana](deploy-local-weka-home-v2.x.md#id-6.-access-the-local-weka-home-portal-and-grafana)
7. [Enable the Local WEKA cluster to send data to the Cloud WEKA Home](deploy-local-weka-home-v2.x.md#id-7.-enable-the-local-weka-cluster-to-send-data-to-the-cloud-weka-home)
8. [Test the deployment](deploy-local-weka-home-v2.x.md#id-8.-test-the-deployment)

### 1. Verify prerequisites

Verify that the following requirements are met:

* A dedicated physical server (or VM) for the installation.
* The user account for installing the LWH must have root privileges.
* Server minimum CPU and RAM requirements:
  * Minimum 8 CPUs and 20 GiB RAM for up to 1000 total processes.
    * Total processes are equal to the cores used on the cluster **backends** for Management/Frontend/Compute/Drives roles and the cores used on **clients** for Management/Frontend roles.
  *   Sizing for additional processes:

      * The total number of processes determines the number of CPU and RAM required.
      * For every additional 1000 processes or less, add 1 CPU and 8 GiB RAM.

      Example: 20 backends with 10 processes each = 200 processes; 500 clients with 2 processes each = 1000 processes. The total is 1200 processes. This deployment requires 9 CPUs and 28 GiB.
* SSD-backed storage requirements:
  * Minimum 500 GiB for locally collected data in `/opt/local-path-provisioner`
  * Minimum 10 GiB for `/tmp/host-path-provisioner`.
* Docker version 20 or higher.
* 1 Gbps network

{% hint style="success" %}
For using other operating systems, contact the Customer Success Team.
{% endhint %}

### 2. Prepare the physical server (or VM)

1. Disable the _SELinux_.
2. Disable the _iptables_, _UFW_, or _firewalld_.
3.  Ensure the following ports are open and not used by any other process. Each port is used for the process specified in the brackets.

    `6443` (kube-apiserver)

    `10259` (kube-scheduler)

    `10257` (kube-controller-manager)

    `10250` (kubelet)

    `2379` (etcd)

    `2380` (etcd)

    `80` (Local WEKA Home, WEKA cluster, and web browser)

    `443` (Local WEKA Home, WEKA cluster, and web browser)

{% hint style="info" %}
If you forward data from the Local WEKA Home to the Cloud WEKA Home, ensure the outbound traffic on port 443 is open.
{% endhint %}

4. Install the Docker Engine version 20 or higher on the physical server according to the Docker documentation.\
   To install the Docker on RHEL, see [Install Docker Engine on Centos](https://docs.docker.com/engine/install/centos/) (the instructions in _Install Docker Engine on RHEL_ do not work).
5. Run the following to verify that the required docker version is installed:\
   `docker --version.`
6. Run the following to start the docker and enable it:\
   `systemctl start docker && systemctl enable docker`
7. Run the following to set the iptables and pre-load it:\
   `echo net.bridge.bridge-nf-call-iptables=1 >> /etc/sysctl.conf; sysctl -p`
8. Run the following to install the rule tables manager, connection tracking, and multi-purpose relay tool:\
   `yum install -y ebtables conntrack socat`
9.  Run the following to install the Traffic Control tool (`tc`):\
    `yum install -y tc`

    (Depending on the Linux distribution, `tc` may already be installed. Or it is called `iproute-tc`. If it is, run: `yum install -y iproute-tc`.)
10. Verify that the HugePages is disabled (`HugePages_Total: 0`).\
    Run the following command:\
    `grep HugePages_Total /proc/meminfo`\
    If the returned value of the HugePages\_Total is higher than 0, run the following to disable the HugePages:\
    `echo 0 > /proc/sys/vm/nr_hugepages`

### 3. Download the Local WEKA Home and Minikube packages

Download the latest packages of the following to the dedicated physical server (or VM):

* **Local WEKA Home v2.x:** [https://get.weka.io/ui/lwh/download](https://get.weka.io/ui/lwh/download).
* **Minikube for Local WEKA Home:** `curl -OL https://home-weka-io-offline-packages-dev.s3.eu-west-1.amazonaws.com/weka_minikube.tar.gz`

### 4. Install the Minikube

1. Unpack the Minikube package:\
   `tar xvf <file name>`
2. From the `minikube_offline` directory, run the install script:\
   `./minikube-offline_install.sh`\
   The installation takes about 3 minutes.
3. Verify the minikube is installed successfully:\
   `minikube status`

<details>

<summary>Response example of a successful minikube installation</summary>

```
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

</details>

{% hint style="info" %}
If the minikube installation fails, do one of the following:

* Go to `/var/log/wekahome` and review the relevant log according to the timestamp (for example, `minikube-install-03-08-2023_16-29.log`).
* Run the command `minikube logs`. A log file is created in `/tmp` directory. Open the log file and search for the reason.
{% endhint %}

### 5. Install and configure the Local WEKA Home

1. Unpack the Local WEKA Home package:\
   `tar xvf <file name>`
2. From the `wekahome_offline` directory, run:\
   `./update_config.sh`
3. Open the `/root/.config/wekahome/config.yaml` file and set the following:

<details>

<summary>Domain</summary>

Set the domain for URL accessing the Local Weka Home portal either by the organization domain FQDN (DNS-based) or IP address (IP-based).

The URL to access the Local Weka Home does not accept aliases of the DNS name. Only the name configured in the `config.yaml` can be used for accessing the Local Weka Home.

DNS-based domain setting:\
In the **domain** section at the top of the file, set the domain FQDN after **@DOMAIN** as shown in the following example:

```
# TOP of file
domain: &DOMAIN "some.domain.com"
```

IP-based domain setting:\
In the **domain** section (at the top of the file) and the **alertdispatcher** section (at the end of the file), set the IP address of the domain as shown in the following example:

```
# TOP of file
domain: &DOMAIN "52.20.26.14"

# End of file
alertdispatcher:
  email_link_domain_name: "52.20.26.14"
```

</details>

<details>

<summary>SMTP</summary>

To enable the Local Weka Home to send emails, set the SMTP details in the **smtp\_user\_data** section as shown in the following example:

<pre><code>smtp_user_data:
  sender_email_name: "Weka Home"
  sender_email: "weka-home-noreply@your-domain.com"
  smtp_host: "smtp.gmail.com"
  smtp_port: "587"
  smtp_username: "username@your-domain.com"
  smtp_password: "heslbgtrjhzfpdci"
  smtp_insecure_tls: false
<strong>  # false is the default. Change to true if a non-trusted SSL certificate is used
</strong></code></pre>

Ensure to enable the SMTP relay service in your SMTP service.

Once the Local Weka Home is deployed, you can set it to send alerts by email, SNMP, or PagerDuty. See the Set the Local Weka Home to send alerts topic.

</details>

<details>

<summary>TLS certificates</summary>

To enforce HTTPS connection, change the value of `enabled:` to `true`, set the common name (CN, also known as FQDN), certificate data, and private key in the **tls** section (under the **nginx** section) as shown in the following section:

```
nginx:
  tls:
     enabled: true
     # Must set to the CN of the certificate or wildcard
     cn: "server.example.com"
     cert: |
     -----BEGIN CERTIFICATE-----
     KJDDLJDLjdkm1718dljkdsljdh92edkjdjdjdkjddjsgsglgLQKSJDKDSKLKSf
        .... Example of a truncated PEM encoded certificate   ..... 
     DDSHJkadsjkjask7U782CHDF8HD0ihjx8iwciw8wJHDSKDHIO
     -----END CERTIFICATE-----
     key: |
     -----BEGIN PRIVATE KEY-----
     MIIBOgIBAAJBAKj34GkxFhD90vcNLYLInFEX6Ppy1tPf9Cnzj4p4WGeKLs1Pt8
          ..... Example of a truncated private key  ..... 
     n5OiPgoTdSy7bcF9IGpSE8ZgGKzgYQVZeN97YE00
     -----END PRIVATE KEY-----
     
```

You can generate a self-signed certificate using the following example:\
`openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`

</details>

<details>

<summary>Events retention period</summary>

The default number of days to keep events in the Local Weka Home is 30 days. To reduce the consumption of disk space, you can specify the max\_age in the **events** section (under the **garbage collection** section), as shown in the following example:

```
garbage_collection:
 support_files:
  # max 365 days
  max_age: 365d
 events:
  # max 30 days
  max_age: 30d
```

</details>

<details>

<summary>Listen on all interfaces</summary>

If the Local Weka Home requires listening to all interfaces (for example, 0.0.0.0), in the **global** section, under **ingress**, leave the domain empty as shown in the following example:

```yaml
# Domain name for notifications and alerts
domain: &DOMAIN "local.weka.home"

global:
  ingress:
    # The interface address the LWH listens to. Leave empty to listen to all
    domain: ""
```

</details>

<details>

<summary>Forward data from the Local WEKA Home to the Cloud WEKA Home</summary>

In the **apiforwarding** section, set the forwarding parameters to **true** (except the forwarding\_bulk\_size), as shown in the following sample. This is the default setting starting in Local WEKA Home v2.10. To disable forwarding metrics to Cloud WEKA Home from Local WEKA Home, set `enabled: false` below.

```
apiforwarding:
  enabled: true
  api_forwarding_url: "https://api.home.weka.io"
  replica_count: 1
  resources:
    requests:
      memory: "100Mi"
      cpu: 10m
    limits:
      memory: "200Mi"
      cpu: 300m
  nodeSelector: { }
  priorityClassName: ""
  forwarding_cluster_registration_enabled: true
  forwarding_events_enabled: true
  forwarding_usage_report_enabled: true
  forwarding_analytics_enabled: true
  forwarding_diagnostics_enabled: true
  forwarding_stats_enabled: true
  forwarding_bulk_size: 50
```

</details>

4. Run `./wekahome-install.sh`.\
   For new installation, it takes about 5 minutes.
5. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods statuses, run `watch kubectl get pods`.)
6. Verify the Local WEKA Home is installed successfully. Run the following command line:\
   `helm status homewekaio -n home-weka-io`

<details>

<summary>Response example of a successful Local WEKA Home installation</summary>

```
helm status homewekaio -n home-weka-io
NAME: homewekaio
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

### 6. Access the Local WEKA Home portal and Grafana

* The Local WEKA Home URL is `https://<your_domain>`
* The Grafana URL of the Local WEKA Home is `https://<your_domain>/stats/`
* The WEKA Home REST API URL is `https://<your_domain>/api/`
* The user name for accessing the portals is `admin`.
* To obtain the password for accessing the Local WEKA Home portal, run the following command:\
  `kubectl get secret -n home-weka-io weka-home-admin-credentials -o jsonpath='{.data.admin_password}' | base64 -d`
* To obtain the password for accessing the Local Weka Home grafana portal, run the following command:\
  `kubectl get secret -n home-weka-io weka-home-grafana-credentials -o jsonpath='{.data.password}' | base64 -d`
* To obtain the secret key of the Local WEKA Home portal, run the following command:\
  `kubectl get secret -n home-weka-io weka-home-encryption -o jsonpath='{.data.encryption_secret_key}' | base64 -d`

### 7. Enable the Local WEKA cluster to send data to the Cloud WEKA Home

By default, the WEKA cluster is set to send information to the public instance of WEKA Home. To get the information in the Local WEKA Home, set the URL of the Local WEKA Home in the WEKA cluster.

Connect to the WEKA cluster and run the following command:\
`weka cloud enable --cloud-url https://<ip or hostname of the Local Weka Home server>`

### 8. Test the deployment

The WEKA cluster uploads data to the Local WEKA Home periodically and on-demand according to its information type (see the Which information is uploaded to the WEKA Home section).

Access the WEKA Home portal and verify that the test data appears.

To trigger a test event, run `weka events trigger-event test` and verify the test event is received in the Local WEKA Home portal under the **Events** section.

If required, go to `/var/log/wekahome` and review the relevant log according to the timestamp (for example, `wekahome-install-03-08-2023_16-29.log`).

## Set local Certificate Authorities

To support dark site customers and other users with local Certificate Authorities (CAs) for configuring secure connectivity to the Local WEKA Home.

**Procedure**

1.  Create a secret using the same method as described in the nginx documentation. For example, you can use the following command:

    ```
    kubectl create secret generic ca-secret --from-file=ca.crt=ca.crt
    ```

    Optionally, you can specify a name for the secret (in this command, it's named `ca-secret`) and a namespace for it using the `-n` option.
2.  Add an Ingress annotation that references this CA certificate by extending the `global.ingress.annotations` with the following field:

    ```
    nginx.ingress.kubernetes.io/auth-tls-secret: "default/ca-secret"
    ```

    In this annotation, replace `default` with the namespace you've specified (or leave it as "default"), and replace `ca-secret` with the actual name of the secret.
3. After making these changes, proceed to the general upgrade instructions.

## Upgrade the Local WEKA Home

The Local WEKA Home upgrade workflow is similar to the deployment workflow (without reinstalling the Minikube). The upgrade process takes about 5 minutes, and the LWH is unavailable during this time. It is recommended to perform the upgrade during a maintenance window.

**Before you begin**

1. If your initial Local WEKA Home (LWH) installation was done using the WMS, change the directory to `/opt/local-weka-home`. Otherwise, change the directory to the location where LWH was initially installed.

Here's an example of how to change the directory to `/opt/local-weka-home` when the WMS was used:

* Log into the WMS:
  *   As root user:

      ```
      ssh root@my_wms
      # Enter password (default: WekaService)
      ```
  *   Or as the weka user:

      ```
      ssh weka@my_wms
      # Enter password (default: weka.io123)
      ```
*   Switch to root user (if not already):

    ```
    sudo bash
    ```
*   Change to the local-weka-home directory:

    ```
    cd /opt/local-weka-home
    ```

2. Check the version.

```
curl http://localhost/api/v3/status
```

3. If the source LWH version is lower than 2.11.0, run the following commands to prepare the source LWH for upgrade:

```
kubectl delete statefulset -l app.kubernetes.io/name=nats -n home-weka-io
kubectl delete pvc -l app.kubernetes.io/name=nats -n home-weka-io
```

**Procedure**

1. Download the latest Local WEKA Home package (_wekahome-vm-docker-images_). See the location in Download the Local Weka Home and Minikube packages_._
2. Unpack the Local Weka Home package to the same directory used for installing the LWH. `tar xvf <file name> -C <path>`
3. From the `wekahome_offline` sub-directory, run `./update_config.sh`
4. If you want to modify the existing configuration, open the `/root/.config/wekahome/config.yaml` file and do the following:
   * Modify the settings. See Install and configure Local WEKA Home.
   * If you update the following sections: **TLS certificates**, **admin credentials**, and **Grafana**, add the line `force_update: true` to the end of the updated section in the `config.yaml` file. For example:

<details>

<summary>Update the TLS certificates</summary>

```
nginx:
  tls:
     enabled: true
     # Must set to the CN of the certificate or wildcard
     cn: "server.example.com"
     cert: |
     -----BEGIN CERTIFICATE-----
     KJDDLJDLjdkm1718dljkdsljdh92edkjdjdjdkjddjsgsglgLQKSJDKDSKLKSf
        .... Example of a truncated PEM encoded certificate   ..... 
     DDSHJkadsjkjask7U782CHDF8HD0ihjx8iwciw8wJHDSKDHIO
     -----END CERTIFICATE-----
     key: |
     -----BEGIN PRIVATE KEY-----
     MIIBOgIBAAJBAKj34GkxFhD90vcNLYLInFEX6Ppy1tPf9Cnzj4p4WGeKLs1Pt8
          ..... Example of a truncated private key  ..... 
     n5OiPgoTdSy7bcF9IGpSE8ZgGKzgYQVZeN97YE00
     -----END PRIVATE KEY-----
     force_update: true
```

</details>

5. Run `./wekahome-install.sh`. For an upgrade, it takes about 2 minutes.
6. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods statuses, run `watch kubectl get pods`.)
7. Verify the Local WEKA Home is upgraded successfully. Run the following command line:\
   `helm status homewekaio -n home-weka-io`
8. If any changes made to the _config.yaml_ required setting `force_update: true`, change it back to `false`.

## Modify the Local WEKA Home configuration

Suppose there is a change in the TLS certificates, SMTP server in your environment, or any other settings in the Local WEKA Home configuration, you can modify the existing `config.yaml` with your new settings and apply them.

**Procedure**

1. Open the `/root/.config/wekahome/config.yaml` file and do the following:
   * Modify the settings. See Install and configure Local WEKA Home.
   * If you update the following sections: **TLS certificates**, **admin credentials**, and **Grafana**, add the line `force_update: true` to the end of the updated section in the `config.yaml` file. For example:

<details>

<summary>Update the TLS certificates</summary>

```
nginx:
  tls:
     enabled: true
     # Must set to the CN of the certificate or wildcard
     cn: "server.example.com"
     cert: |
     -----BEGIN CERTIFICATE-----
     KJDDLJDLjdkm1718dljkdsljdh92edkjdjdjdkjddjsgsglgLQKSJDKDSKLKSf
        .... Example of a truncated PEM encoded certificate   ..... 
     DDSHJkadsjkjask7U782CHDF8HD0ihjx8iwciw8wJHDSKDHIO
     -----END CERTIFICATE-----
     key: |
     -----BEGIN PRIVATE KEY-----
     MIIBOgIBAAJBAKj34GkxFhD90vcNLYLInFEX6Ppy1tPf9Cnzj4p4WGeKLs1Pt8
          ..... Example of a truncated private key  ..... 
     n5OiPgoTdSy7bcF9IGpSE8ZgGKzgYQVZeN97YE00
     -----END PRIVATE KEY-----
     force_update: true
```

</details>

2. Run `./wekahome-install.sh`
3. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods statuses, run `watch kubectl get pods`.)
4. Verify the Local WEKA Home is updated successfully. Run the following command line:\
   `helm status homewekaio -n home-weka-io`
5. If any changes made to the _config.yaml_ required setting `force_update: true`, change it back to `false`.

## Troubleshoot the Local WEKA Home deployment

### Symptom: browsing to the Local WEKA Home returns an error

The probable cause can be, for example, a communication problem.

#### Resolution

1. Retrieve the ingress pod (controller) of the Local WEKA Home.\
   `kubectl get pods -n ingress-nginx -o name|grep controller`
2. Retrieve the logs and look for the error.\
   `kubectl logs <pod name from previous command> -n ingress-nginx > nginx.out`

### Symptom: when executing any command on the Local WEKA Home, the error “no space left” is displayed

The probable cause for this issue is that the docker root dir (/var/lib/docker) consumes disk space.

#### Resolution

Do one of the following:

* Resize the disk and reinstall the Local WEKA Home.
* Relocate the docker root directory path to a new path on a larger device (if it exists) and copy the content from the old path to the new path.

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
* Minikube settings
* Free disk space
* CPU and memory usage
* Name resolutions
* LWH version
* Syslogs

**Procedure**

1. Obtain the `dump.sh` script from the LWH installation package.
2. Run the following command:

```
dump.sh [archive] [--include-sensitive] [--full-disk-scan] [--verbose]
```

Once you generate the LWH deployment diagnostics archive file, send it to the Customer Success Team for analysis.

**Parameters**

<table><thead><tr><th width="242">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>archive</code>*</td><td>The path and output archive file name.<br>For example: <code>/path/diag/lwh_diagnostics.tar.gz</code></td></tr><tr><td><code>include-sensitive</code></td><td>Include sensitive data in the archive. For example, value overrides.<br>Use this parameter only if required by the Customer Success Team.</td></tr><tr><td><code>full-disk-scan</code></td><td>Perform a higher level of disk scan.<br>Use this parameter only if required by the Customer Success Team.</td></tr><tr><td><code>verbose</code></td><td>Provide a higher verbosity level of the debug information.</td></tr></tbody></table>
