---
description: >-
  Deploy Prometheus and Grafana to monitor the health and performance of WEKA
  clusters in Kubernetes.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/monitor-the-weka-cluster/monitor-weka-clusters-in-kubernetes-with-prometheus-and-grafana
---

# Monitor WEKA clusters in Kubernetes with Prometheus and Grafana

Use Prometheus and Grafana to monitor the health and performance of WEKA clusters deployed in Kubernetes, including metrics such as throughput, CPU utilization, IOPS, and API requests. Starting with version **v1.7.0**, the WEKA Operator exposes these metrics by default, allowing Prometheus to scrape them and Grafana to visualize them. No additional installation flags or service monitor configurations are required.

**Related topic**

[weka-operator-day-2-operations.md](../kubernetes/weka-operator-day-2-operations.md "mention")

### Before you begin

* You have `helm` and `kubectl` command-line tools installed and configured to interact with your Kubernetes cluster.
* (Optional) WEKA `storageClasses` are configured to provide persistent storage for Prometheus and Grafana.

**Related information**

[WEKA Operator v1.7.0 release notes](https://get.weka.io/ui/operator/1.7.0/notes)

[Prometheus GitHub repository](https://github.com/prometheus/prometheus)

[Installing Grafana using Helm](https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/)

### Workflow

[#step-1-install-prometheus-and-grafana](monitor-weka-clusters-in-kubernetes-with-prometheus-and-grafana.md#step-1-install-prometheus-and-grafana "mention")

[#step-2-install-or-upgrade-the-weka-operator](monitor-weka-clusters-in-kubernetes-with-prometheus-and-grafana.md#step-2-install-or-upgrade-the-weka-operator "mention")

[#step-3-access-prometheus-server](monitor-weka-clusters-in-kubernetes-with-prometheus-and-grafana.md#step-3-access-prometheus-server "mention")

[#step-4-access-grafana-landing-page](monitor-weka-clusters-in-kubernetes-with-prometheus-and-grafana.md#step-4-access-grafana-landing-page "mention")

#### Step 1: Install Prometheus and Grafana

Use Helm to install Prometheus and Grafana in your Kubernetes cluster.

1.  Create separate namespaces for Prometheus and Grafana.

    ```bash
    $ kubectl create ns prometheus && kubectl create ns grafana
    ```
2.  Add and update the Helm repositories for Prometheus and Grafana.

    ```bash
    # Add Helm repositories
    $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    $ helm repo add grafana https://grafana.github.io/helm-charts

    # Update repositories
    $ helm repo update
    ```
3.  Install Prometheus.\
    To configure persistent storage, add the flag:

    `--set server.persistentVolume.storageClass=<your-storage-class>`.

    ```bash
    $ helm upgrade --install prometheus prometheus-community/prometheus \
    --namespace prometheus

    # Example with the persistent storage flag
    $ helm upgrade --install prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set server.persistentVolume.storageClass=weka-sc
    ```

**Sample output of Prometheus Helm installation**

```bash
$ helm upgrade --install prometheus prometheus-community/prometheus --namespace prometheus --set server.persistentVolume.storageClass=storageclass-wekafs-dir-api

Release "prometheus" does not exist. Installing it now.
NAME: prometheus
LAST DEPLOYED: Mon Aug 25 15:19:18 2025
NAMESPACE: prometheus
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-server.prometheus.svc.cluster.local
```

4. Install Grafana.\
   To configure persistent storage, add the flag:\
   `--set persistence.enabled=true,persistence.storageClassName=<your-storage-class>`.

<pre class="language-bash"><code class="lang-bash"><strong>$ helm upgrade --install grafana grafana/grafana \
</strong>--namespace grafana

# Example with the persistent storage flag
$ helm upgrade --install grafana grafana/grafana \
--namespace grafana \
--set persistence.enabled=true,persistence.size=8Gi,persistence.storageClassName=weka-sc
</code></pre>

**Sample output of Grafana Helm installation**

```bash
$ helm upgrade --install grafana grafana/grafana --namespace grafana --set persistence.enabled=true,persistence.size=8Gi,persistence.storageClassName=weka-sc

Release "grafana" does not exist. Installing it now.
NAME: grafana
LAST DEPLOYED: Mon Aug 25 15:07:33 2025
NAMESPACE: grafana
STATUS: deployed
REVISION: 1
```

#### Step 2: Install or upgrade the WEKA Operator

Install the WEKA Operator Helm chart, or upgrade to version **v1.7.0** or later if already installed.

This ensures proper configuration of **podMonitors**, which is a custom resource defined by the Prometheus for scraping WEKA statistics. The WEKA Operator can only deploy podMonitors if the Prometheus is installed beforehand. When the CRD is available, the WEKA Operator Helm chart installs the podMonitors automatically.

**Related topic**

[weka-operator-deployments](../kubernetes/weka-operator-deployments/ "mention")

#### Step 3: Access Prometheus server

After installation, access the Prometheus web UI to verify that it is scraping metrics from the WEKA Operator.

1.  Port-forward to the Prometheus server to access its web UI from your local machine.

    <pre class="language-bash"><code class="lang-bash"><strong>$ export POD_NAME=$(kubectl get pods --namespace prometheus -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}") [cite: 1259]
    </strong>$ kubectl --namespace prometheus port-forward $POD_NAME 9090 
    </code></pre>
2.  In a web browser, navigate to

    `http://localhost:9090`.
3. Verify that WEKA metrics are available.
   * In the query field, type `weka_`. All WEKA metrics follow this naming convention.

#### Step 4: Access Grafana landing page

Access the Grafana UI to configure the Prometheus data source and import the pre-built WEKA dashboard.

1.  Retrieve the admin password for Grafana.

    ```bash
    $ kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
    ```
2.  Get the URL to access the Grafana UI.

    ```bash
    $ export NODE_PORT=$(kubectl get --namespace grafana -o jsonpath="{.spec.ports[0].nodePort}" services grafana) 
    $ export NODE_IP=$(kubectl get nodes --namespace grafana -o jsonpath="{.items[0].status.addresses[0].address}")
    $ echo http://$NODE_IP:$NODE_PORT
    ```
3.  In a web browser, navigate to the Grafana URL and log in. Use the username

    `admin` and the password retrieved in the previous step.
4. Add Prometheus as a data source in Grafana.
   1. On Grafana, select **Data sources**.
   2. Select **prometheus**.
   3.  In the **Connection** setting, add the URL

       `http://prometheus-server.prometheus.svc.cluster.local`.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/Prom datasource.gif" alt=""><figcaption></figcaption></figure></div>

5. Import the WEKA dashboard.
   1. Navigate to the [WEKA GitHub repository](https://raw.githubusercontent.com/balaramesh2/weka-metrics/refs/heads/main/weka-dashboard.json) and copy the `weka-dashboard.json` content.
   2. On Grafana, select **Dashboards**.
   3. Select **WEKA**.
   4. Select **New > Import**.
   5. Paste the `weka-dashboard.json` content to the import box, and select **Load.**
   6. Select **Import**.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/Grafboard (1).gif" alt=""><figcaption></figcaption></figure></div>
