---
description: >-
  This topic provides procedures for deploying the Local Weka Home on a Minikube
  infrastructure, upgrading, modifying the configuration, and troubleshooting.
---

# Local Weka Home deployment

This implementation runs on Minikube (a lightweight Kubernetes implementation) installed on a single Docker container. You specify the configuration parameters in the config.yaml file as part of the deployment workflow.

{% hint style="info" %}
**Note:** It is possible to install the Local Weka Home within the customer's Kubernetes infrastructure using Helm Charts. Contact the [Customer Success Team](../getting-support-for-your-weka-system.md) to schedule this installation.
{% endhint %}

<figure><img src="../../.gitbook/assets/weka-home-local.png" alt=""><figcaption><p>Local Weka Home deployment</p></figcaption></figure>

## Workflow: Local Weka Home deployment

1. [Verify prerequisites](<local-weka-home-deployment (1).md#1.-verify-prerequisites>).
2. [Prepare the management server](<local-weka-home-deployment (1).md#2.-prepare-the-management-server>).
3. [Download the Weka Home and Minikube packages](<local-weka-home-deployment (1).md#3.-download-the-local-weka-home-and-minikube-packages>).
4. [Install the Minikube](<local-weka-home-deployment (1).md#3.-download-the-local-weka-home-and-minikube-packages>).
5. [Install and configure the Weka Home](<local-weka-home-deployment (1).md#5.-install-and-configure-local-weka-home>).
6. [Access the Weka Home portal and Grafana](<local-weka-home-deployment (1).md#6.-access-the-local-weka-home-portal-and-grafana>).
7. [Enable the Weka cluster to send data to Weka Home](<local-weka-home-deployment (1).md#7.-enable-the-weka-cluster-to-send-information-to-the-local-weka-home>).
8. [Test the deployment](<local-weka-home-deployment (1).md#8.-test-the-deployment>).

### 1.  Verify prerequisites

Verify that the following requirement are met:

* A dedicated management server (or VM) for the installation.
* The user account used for the installation has root privileges. Ensure that the `sudoers` file includes the root user.
* Server minimum requirements for up to 1000 Weka containers:
  * 4 cores
  * 32 GiB RAM
  * 500 GiB disk space in /opt/local-path-provisioner (local storage of the collected data)
  * 1 Gbps network
  * Docker version 20 or higher.

{% hint style="success" %}
To scale up the Local Weka Home server, for each additional 1000 Weka containers, add the following:

* 4 cores
* 10 GiB RAM
* 150 GiB disk space in /opt/local-path-provisioner (for every 14 days of data retention).
{% endhint %}

* Supported operating systems:
  * Centos 7.9
  * Amazon Linux 2
  * Rocky 8.6
  * RHEL 8.2+

{% hint style="success" %}
For using other operating systems, contact the [Customer Success Team](../getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### 2. Prepare the management server

1. Disable the _SELinux_.
2. Disable the _iptables_, _UFW_, or _firewalld_.
3.  Ensure the following ports are open and not used by any other process. Each port will be used for the process specified in the brackets.

    `6443`   (kube-apiserver)

    `10259` (kube-scheduler)

    `10257` (kube-controller-manager)

    `10250` (kubelet)

    `2379`   (etcd)

    `2380`   (etcd)

    `80`       (wekahome)

    `443`     (wekahome)
4. Install the Docker Engine version 20 or higher on the management server according to the Docker documentation.\
   To install the Docker on RHEL, see [Install Docker Engine on Centos](https://docs.docker.com/engine/install/centos/) (the instructions in _Install Docker Engine on RHEL_ do not work).
5. Run the following to verify that the required docker version is installed:\
   `docker --version.`
6. Run the following to start the docker and enable it:\
   `systemctl start docker && systemctl enable docker`
7. Run the following to set the iptables and pre-load it:\
   `echo net.bridge.bridge-nf-call-iptables=1 >> /etc/sysctl.conf; sysctl -p`
8. Run the following to install the rule tables manager, connection tracking, and multi-purpose relay tool:\
   `yum install -y ebtables conntrack socat`
9.  Run the following to install the Traffic Control tool (tc):\
    `yum install -y tc`

    (Depending on the Linux distribution, `tc` may already be installed. Or it is called iproute-tc. If it is, run: `yum install -y iproute-tc`.)
10. Verify that the HugePages is disabled (`HugePages_Total: 0`).\
    Run the following command:\
    `grep HugePages_Total /proc/meminfo`\
    If the returned value of the HugePages\_Total is higher than 0, run the following to disable the HugePages:\
    `echo 0 > /proc/sys/vm/nr_hugepages`

### 3. Download the Local Weka Home and Minikube packages

Download the latest _wekahome-vm-docker-images_ and _weka\_minikube_  packages to the dedicated management server.

* Minikube for Local Weka Home download current location and version:\
  `curl -OL https://home-weka-io-offline-packages-dev.s3.eu-west-1.amazonaws.com/weka_minikube_v1.25.1.8.tar.gz`
* Local Weka Home download current location and version:\
  `curl -OL https://home-weka-io-offline-packages-dev.s3.eu-west-1.amazonaws.com/wekahome-vm-docker-images_v.2.7.1.tar.gz`

### 4. Install the Minikube

1. Unpack the Minikube package:\
   `tar xvf <file name>`
2. From the `minikube_offline` directory, run the install script: \
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
If the minikube installation fails, run the command `minikube logs`. A log file is created in `/tmp` directory. Open the log file and search for the reason.&#x20;
{% endhint %}

### 5. Install and configure Local Weka Home

1. Unpack the Local Weka Home package:\
   `tar xvf <file name>`
2. From the `wekahome_offline` directory, run:\
   `./update_config.sh`
3. Open the `/root/.config/wekahome/config.yaml` file and set the following:

#### Domain&#x20;

Set the domain for URL accessing the Local Weka Home portal either by the organization domain FQDN (DNS-based) **** or IP address (IP-based).

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

#### SMTP

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

{% hint style="warning" %}
Ensure to enable the SMTP relay service in your SMTP service.

Once the Local Weka Home is deployed, you can set it to send alerts by email, SNMP, or PagerDuty. See the [Set the Local Weka Home to send alerts](broken-reference) topic.
{% endhint %}

#### Enforce HTTPS

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

{% hint style="info" %}
You can generate a self-signed certificate using the following example:\
`openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`
{% endhint %}

#### Events retention period

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

5. Run `./wekahome-install.sh`.\
   For new installation, it takes about 5 minutes.
6. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods statuses, run `watch kubectl get pods`.)
7. Verify the Local Weka Home is installed successfully. Run the following command line:\
   &#x20;   `helm status homewekaio -n home-weka-io`

<details>

<summary>Response example of a successful Local Weka Home installation</summary>

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

### 6. Access the Local Weka Home portal and Grafana

* The Local Weka Home URL is `https://<your_domain>`
* The Grafana URL of the Local Weka Home is `https://<your_domain>/stats/`
* The Weka Home REST API URL is `https://<your_domain>/api/`
* The user name for accessing the portals is `admin`.
* To obtain the password for accessing the Local Weka Home portal, run the following command:\
  `kubectl get secret -n home-weka-io weka-home-admin-credentials  -o jsonpath='{.data.admin_password}' | base64 -d`
* To obtain the password for accessing the Local Weka Home grafana portal, run the following command:\
  `kubectl get secret -n home-weka-io weka-home-grafana-credentials  -o jsonpath='{.data.password}' | base64 -d`
* To obtain the secret key of the Local Weka Home portal, run the following command:\
  `kubectl get secret -n home-weka-io weka-home-encryption  -o jsonpath='{.data.encryption_secret_key}' | base64 -d`

### 7. Enable the Weka cluster to send information to the Local Weka Home

By default, the Weka cluster is set to send information to the public instance of Weka Home. To get the information in the Local Weka Home, set in the Weka cluster the URL of the Local Weka Home.&#x20;

Connect to the Weka cluster and run the following command:\
`weka cloud enable --cloud-url https://<ip or hostname of the Local Weka Home server>`

### 8. Test the deployment

The Weka cluster uploads data to the Local Weka Home periodically and on-demand according to its information type (see the [Which information is uploaded to the Weka Home](./#which-information-is-uploaded-to-the-weka-home) section).&#x20;

Access the Weka Home portal and verify that the test data appears.

To trigger a test event, run `weka events trigger-event test` and verify the test event is received in the Local Weka Home portal under the **Events** section.

## Upgrade the Local Weka Home

The Local Weka Home upgrade workflow is similar to the deployment workflow (but without reinstalling the Minikube).

**Procedure:**

1. Download the latest Local Weka Home package (_wekahome-vm-docker-images_). See the location in [Download the Local Weka Home and Minikube packages](<local-weka-home-deployment (1).md#2.-download-the-local-weka-home-and-minikube-packages>)_._
2. Unpack the Local Weka Home package to the same directory used for installing the LWH. `tar xvf <file name> -C <path>`
3. From the `wekahome_offline` directory, run `./update_config.sh`
4. If you want to modify the existing configuration, open the `/root/.config/wekahome/config.yaml` file and modify the settings (as described in [Install and configure Local Weka Home](<local-weka-home-deployment (1).md#4.-install-and-configure-local-weka-home>)).
5. Run `./wekahome-install.sh`. For an upgrade, it takes about 2 minutes.
6. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods statuses, run `watch kubectl get pods`.)
7. Verify the Local Weka Home is upgraded successfully. Run the following command line:\
   `helm status homewekaio -n home-weka-io`

## Modify the Local Weka Home configuration

Suppose there is a change in the SMTP server in your environment, or you need to change the events retention period or any other settings in the Local Weka Home configuration, you can modify the existing `config.yaml` with your new settings and apply them.

**Procedure:**

1. Open the `/root/.config/wekahome/config.yaml` file and modify the settings (as described in [Install and configure Local Weka Home](<local-weka-home-deployment (1).md#4.-install-and-configure-local-weka-home>)).
2. Run `./wekahome-install.sh`
3. Run `kubectl get pods` and verify in the results that all pods have the status **Running** or **Completed**. (To wait for the pods statuses, run `watch kubectl get pods`.)
4. Verify the Local Weka Home is updated successfully. Run the following command line:\
   `helm status homewekaio -n home-weka-io`

## Troubleshoot the Local Weka Home deployment

### Symptom: browsing to the Local Weka Home returns an error

The probable cause can be, for example, a communication problem.

#### Resolution

1. Retrieve the ingress pod (controller) of the Local Weka Home.\
   `kubectl get pods -n ingress-nginx -o name|grep controller`
2. Retrieve the logs and look for the error.\
   `kubectl logs <pod name from previous command> -n ingress-nginx > nginx.out`

### Symptom: when executing any command on the Local Weka Home, the error “no space left” is displayed&#x20;

The probable cause for this issue is that the docker root dir (/var/lib/docker) consumes disk space.

#### Resolution

Do one of the following:

* Resize the disk and reinstall the Local Weka Home.
* Relocate the docker root directory path to a new path on a larger device (if it exists) and copy the content from the old path to the new path.

### Symptom: when testing the integration, the email is not received

The probable cause can be issues related to the SMTP server, such as wrong credentials or recipient email address.

#### Resolution

1. On the **Integration** page, select **Test Integration**.\
   Wait until an error appears.
2. Retrieve the logs and search for the error. On the Local Weka Home terminal, run the following command:\
   ``for dep in `kubectl get deployment -n home-weka-io -o name`; do echo -----$dep-----; kubectl logs $dep --all-containers=true --timestamps=true --since=5m ; done``
