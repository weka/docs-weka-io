---
description: >-
  Local Weka Home is a private instance of Weka Home deployed with a Weka
  cluster in a private network or VPC.
---

# Local Weka Home deployment

Suppose a customer does not have connectivity to the public instance of Weka Home, such as when the Weka cluster is deployed on a dark site or VPC. In that case, Weka provides an option to deploy a Local Weka Home, a private instance of Weka Home.

<figure><img src="../../.gitbook/assets/weka-home-local.png" alt=""><figcaption><p>Local Weka Home deployment</p></figcaption></figure>

## Local Weka Home main features

The Local Weka Home provides the following main features (partial list):

* Receive events from the Weka cluster and store them.
* Enable the query of the events.
* Trigger specific alerts according to predefined rules through an integrated delivery method: Email, SNMP, or PagerDuty.
* Receive diagnostics (support files) from the Weka cluster and record them.
* Receive statistics from the Weka cluster, record them, view them, and query them.

## Before you begin

A dedicated management server (or VM) for the installation is required.

### Server minimum requirements for up to 1000 Weka containers

* 4 cores
* 32 GiB RAM
* 500 GiB disk space in /opt/local-path-provisioner (local storage of the collected data)
* 1 Gbps network
* Docker version 20 or higher.

{% hint style="success" %}
To scale up the Local Weka Home server, for each additional 1000 Weka containers, add the following:

* 4 cores
* 10 GiB RAM
* 150 GiB disk space in /opt/local-path-provisioner (for every 14 days of data retention).&#x20;
{% endhint %}

### Supported operating systems

* Centos 7.9
* Amazon Linux 2
* Rocky 8.6
* RHEL 8.2+

{% hint style="success" %}
Using other operating systems. To check the options, contact the [Customer Success Team](../getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### User account requirements

Perform the installation and configuration with a user with root privileges.

Ensure that the `sudoers` file includes the root user.&#x20;

## Workflow: Local Weka Home deployment

1. [Prepare the management server](local-weka-home-deployment.md#1.-prepare-the-management-server).
2. [Download the Weka Home and Minikube packages](local-weka-home-deployment.md#2.-download-the-weka-home-and-minikube-packages).
3. [Install the Minikube](local-weka-home-deployment.md#3.-install-the-minikube).
4. [Install and configure the Weka Home](local-weka-home-deployment.md#4.-install-and-configure-weka-home).
5. [Access the Weka Home portal and Grafana](local-weka-home-deployment.md#5.-access-the-weka-home-portal-and-grafana).
6. [Enable the Weka cluster to send data to Weka Home](local-weka-home-deployment.md#6.-enable-the-weka-cluster-to-send-information-to-the-local-weka-home).
7. [Test the deployment](local-weka-home-deployment.md#7.-test-the-deployment).

### 1. Prepare the management server

1. Disable the _SELinux_.
2. Disable the _iptables_, _UFW_, or _firewalld_.
3. Install the Docker Engine version 20 or higher on the management server according to the Docker documentation.\
   To install the Docker on RHEL, see [Install Docker Engine on Centos](https://docs.docker.com/engine/install/centos/) (the instructions in _Install Docker Engine on RHEL_ do not work).
4. Run the following to verify that the required docker version is installed:\
   `docker --version.`
5. Run the following to start the docker and enable it:\
   `systemctl start docker && systemctl enable docker`
6. Run the following to set the iptables and pre-load it:\
   `echo net.bridge.bridge-nf-call-iptables=1 >> /etc/sysctl.conf; sysctl -p`
7. Run the following to install the rule tables manager, connection tracking, and multi-purpose relay tool:\
   `yum install -y ebtables conntrack socat`
8.  Run the following to install the Traffic Control tool (tc):\
    `yum install -y tc`

    (Depending on the Linux distribution, `tc` may already be installed. Or it is called iproute-tc. If it is, run: `yum install -y iproute-tc`.)
9. Verify that the HugePages is disabled (`HugePages_Total: 0`).\
   Run the following command:\
   `grep HugePages_Total /proc/meminfo`\
   If the returned value of the HugePages\_Total is higher than 0, run the following to disable the HugePages:\
   `echo 0 > /proc/sys/vm/nr_hugepages`

### 2. Download the Local Weka Home and Minikube packages

Download the latest _wekahome-vm-docker-images_ and _weka\_minikube_  packages to the dedicated management server.

* Minikube for Local Weka Home download current location and version:\
  `curl -OL https://home-weka-io-offline-packages-dev.s3.eu-west-1.amazonaws.com/weka_minikube_v1.25.1.8.tar.gz`
* Local Weka Home download current location and version:\
  `curl -OL https://home-weka-io-offline-packages-dev.s3.eu-west-1.amazonaws.com/wekahome-vm-docker-images_v.2.5.0.tar.gz`

### 3. Install the Minikube

1. Unpack the Minikube package.\
   `tar xvf <file name>`
2. From the `minikube_offline` directory, run the install script `./minikube-offline_install.sh`.

The installation takes about 3 minutes.

### 4. Install and configure Local Weka Home

1. Unpack the Local Weka Home package.\
   `tar xvf <file name>`
2. From the `wekahome_offline` directory, run `./update_config.sh`.
3. Open the `root/.config/wekahome/config.yaml` file and set the following (the values are just for example):

#### Domain&#x20;

Set the domain for URL accessing the Local Weka Home portal either by the domain FQDN (DNS-based) **** or IP address (IP-based).&#x20;

DNS-based domain setting:\
In the domain section, set the domain FQDN as shown in the following example:

```yaml
# TOP of file
domain: &DOMAIN "some.domain.com"
```

IP-based domain setting:\
In the domain and the alertdispatcher sections, set the IP address of the domain as shown in the following example:

```yaml
# TOP of file
domain: &DOMAIN "52.20.26.14"

# End of file
alertdispatcher:
  email_link_domain_name: "52.20.26.14"
```

#### SMTP

To enable the Local Weka Home to send emails, set the SMTP details in the following section:

<pre class="language-yaml"><code class="lang-yaml">smtp_user_data:
  sender_email_name: "Weka Home"
  sender_email: "weka-home-noreply@your-domain.com"
  smtp_host: "smtp.gmail.com"
  smtp_port: "587"
  smtp_username: "username@your-domain.com"
  smtp_password: "heslbgtrjhzfpdci"
  smtp_insecure_tls: false
<strong>  # false is the default. Change to true if a non-trusted SSL certificate is used
</strong></code></pre>

{% hint style="warning" %}
Ensure to enable the SMTP relay service in your SMTP service.

Once the Local Weka Home is deployed, you can set it to send alerts or events by PagerDuty, Email, or SNMP Trap. See the [Set the Local Weka Home to send alerts](local-weka-home-deployment.md#set-the-local-weka-home-to-send-alerts) section.
{% endhint %}

#### Enforce HTTPS

To enforce HTTPS connection, set the common name (CN, also known as FQDN), certificate data, and private key in the following section:

```yaml
nginx:
  tls:
     enabled: false
     # Must set to the CN of the certificate or wildcard
     cn: "server.example.com"
     cert: |
     -----BEGIN CERTIFICATE-----
     <cert-data-comes-here>
     -----END CERTIFICATE-----
     key: |
     -----BEGIN PRIVATE KEY-----
     <private-key-data-comes-here>
     -----END PRIVATE KEY-----
```

{% hint style="info" %}
Additional settings in the YAML configuration file may be required for a Local Weka Home that serves more than 1000 Weka clusters. Contact the Customer Success Team.
{% endhint %}

5\. Run `./wekahome-install.sh`.\
&#x20;   For new installation, it takes about 5 minutes. For updates, it takes about 2 minutes.

6\. Run `kubectl get pods` and verify in the results that all pods have the status **Running** \
&#x20;   or **Completed**.

### 5. Access the Local Weka Home portal and Grafana

* The Local Weka Home portal is `http://<your_domain>`
* The Grafana portal of the Local Weka Home is `http://<your_domain>/stats/`
* The user name for accessing both portals is `admin`.
* To obtain the password for accessing the Local Weka Home portal, run the following command:

```yaml
kubectl get secret -n home-weka-io weka-home-admin-credentials  -o jsonpath='{.data.admin_password}' | base64 -d
```

* To obtain the password for accessing the Local Weka Home grafana portal, run the following command:

```
kubectl get secret -n home-weka-io weka-home-grafana-credentials  -o jsonpath='{.data.password}' | base64 -d
```

### 6. Enable the Weka cluster to send information to the Local Weka Home

By default, the Weka cluster is set to send information to the public instance of Weka Home. To get the information in the Local Weka Home, set in the Weka cluster the URL of the Local Weka Home.&#x20;

Connect to the Weka cluster and run the following command:\
`weka cloud enable --cloud-url http://<ip or hostname of the Local Weka Home server>`

### 7. Test the deployment

The Weka cluster uploads data to the Local Weka Home periodically and on-demand according to its information type (see the [Which information is uploaded to the Weka Home](./#which-information-is-uploaded-to-the-weka-home) section).&#x20;

Access the Weka Home portal and verify that the test data appears.

To trigger a test event, run `weka events trigger-event test` and verify the test event is received in the Local Weka Home portal under the **Events** section.

## Set the Local Weka Home to send alerts or events

Once the Local Weka Home is deployed, you can set it to send alerts or events by PagerDuty, Email, or SNMP Trap.

In short, set the delivery method and destination on the **Integration** page, then on the **Rules** page, set the rule conditions to trigger the alert and assign the rule to the integration.

**Procedure:**

1. Access the Local Weka Home portal with an admin account and the password obtained, as shown [above](local-weka-home-deployment.md#5.-access-the-local-weka-home-portal-and-grafana).
2. On the **Integration** page, select **New**.

<figure><img src="../../.gitbook/assets/wmng_integrations_new.png" alt=""><figcaption><p>Integrations page</p></figcaption></figure>

3\. On the **Create Integration** page, do one of the following according to the integration type you\
&#x20;    select (delivery method):

* **PagerDuty:** Enter a meaningful name for the integration, select the PageDuty type, and set the routing key to the destination.
* **Email:** Enter a meaningful name for the integration, select the Email type, and set the destination email address.
* **SNMP Trap:** Enter a meaningful name for the integration, select the SNMP Trap type, and set the details of the destination SNMP server (version, hostname, and community).

4\. Verify that the integration is enabled (the arrow is green), and select **Save Integration**.

<figure><img src="../../.gitbook/assets/wmng_integrations_email_example.png" alt=""><figcaption><p>Example of an Email integration</p></figcaption></figure>

5\. On the **Rules** page, select **New**.

<figure><img src="../../.gitbook/assets/wmng_rules_new.png" alt=""><figcaption><p>Rules page</p></figcaption></figure>

6\. On the **Create Rule** page, do the following:

* Enter a meaningful name to the rule.
* Select the event or alert type from **Rule Type** and set the conditions for the selected rule type. (the conditions depend on the selected rule type).
* Select **View integrations** and then select the required integration from the list.
* Select **Save Rule**.

<figure><img src="../../.gitbook/assets/wmng_rule_alert_example.png" alt=""><figcaption><p>Example of an alert rule</p></figcaption></figure>
