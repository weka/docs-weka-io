---
description: >-
  This page describes how to set up external monitoring using Prometheus and
  Grafana
---

# External Monitoring

## Overview

The Weka GUI allows monitoring basic information of the CPUs, Network, Drives, IOPS/Throughput, and more advanced information via the statistics.

It is sometimes useful to use external tools like Prometheus and Grafana for monitoring. It could be that you already have them in the environment and would like to correlate with other products and see all information on the same dashboard.

In this guide, we will learn how to easily set-up a nice Grafana dashboard to monitor Weka. We will use a custom Prometheus client that presents weka statistics. 

It is advisable to set-up a machine \(or a VM\) to run the external services used if you do not already have those running in the environment. 

We will go over the following steps:

1. Install the Weka agent, if needed
2. Install and run the Weka Prometheus client
3. Set-up Prometheus:
   1. Install a Prometheus server
   2. Configure Prometheus to collect information from the Weka Prometheus client
   3. Run the Prometheus server
4. Install and run a Grafana server
5. Set-up a basic Weka dashboard in Grafana
   1. Add a Prometheus data source to Grafana
   2. Import pre-built Weka dashboards to Grafana

{% hint style="info" %}
 **Note:** It is advisable to follow the best practices for security and high availability of these servers and set them up to run on startup/as a service.
{% endhint %}

## Step 1: Install the Weka agent

Run the following commands to install the Weka agent:

```text
# download from a backend server and install
curl http://<backend-wekaserver>:14000/dist/v1/install | sh

```

{% hint style="info" %}
**Note:** This step is required if you do not plan on running the Weka Prometheus client on a Weka server or client \(a member of the cluster\). If you install the Weka Prometheus Client on a server that only has an agent, you must use the `-H` or `--HOST` option, as described below. In this case, if the Weka cluster is upgraded, you might need to re-install the Weka agent.
{% endhint %}

## Step 2: Install the Weka Prometheus Client

Prometheus works by "scraping" data from websites.  This data is expected to be in a particular format.   The Weka Prometheus Client presents Weka statistics on a "web page" that Prometheus understands, so Prometheus can ingest the data.

### Step 2.1: Download and Install the Weka Prometheus Client

Run the following commands to install the prerequisites for the Weka Prometheus Client:

```text
# install pip
yum -y install python2-pip

# install pyyaml
pip install pyyaml

# install prometheus_client
pip install prometheus_client

```

Run the following commands to install the Weka Prometheus Client:

```bash
# download
curl -LO https://weka-install-scripts.s3.amazonaws.com/weka_prometheus-1.2.2.tgz

# extract
tar xvf weka_prometheus-1.2.2.tgz

```

### Step 2.2: Configure the Weka Prometheus Client

The Weka Prometheus Client is configurable to run in many environments. The `weka_prom.yml` configuration file defines what statistics will be monitored \(follow the directions inside the file to customize\). The defaults given are sufficient for populating the example Grafana Dashboards included with the Client.

### Step 2.3: Run the Weka Prometheus Client

The Client takes several optional parameters:

```text
# run the client in the background (it is advisable to set it up to run at startup, as a service)
nohup ./weka_prom_client.py -a -H [WEKA_HOST] &

```

| Parameter | Description | Default |
| :--- | :--- | :--- |
| `-h|--help` | displays the above help |  |
| `-c|--configfile` | specifies a different config file | `weka_prom.yml` |
| `-p|--port` | specifies what tcp port the client will listen on | 8000 |
| `-a|--autohost` | distributes the load of collecting the statistics among the weka servers automatically |  |
| `-v|--verbose` | displays actions of the client |  |
| `-H|--HOST` | The target Weka host to use to execute the queries. Mandatory if the Weka Prometheus client is not running on a Weka client/server. |  |

{% hint style="info" %}
**Note:** It is suggested to use `nohup` to execute the client. It is advisable to set it up as a Service.
{% endhint %}

To verify the client exposes the data to scrap:

```text
curl -L [WEKA_PROMETHEUS_CLIENT_HOST]:8000
```

You should see the collected data in the Prometheus format, e.g.:

```text
# HELP weka_stats WekaFS statistics. For more info refer to: https://docs.weka.io/usage/statistics/list-of-statistics
# TYPE weka_stats gauge
weka_stats{category="cpu",cluster="weka",host_name="weka-3",host_role="server",node_id="NodeId<61>",node_role="FRONTEND",stat="CPU_UTILIZATION",unit="percent"} 8.150054737510423
weka_stats{category="cpu",cluster="weka",host_name="weka-0",host_role="server",node_id="NodeId<1>",node_role="DRIVES",stat="CPU_UTILIZATION",unit="percent"} 8.054864171897242
weka_stats{category="cpu",cluster="weka",host_name="weka-1",host_role="server",node_id="NodeId<21>",node_role="FRONTEND",stat="CPU_UTILIZATION",unit="percent"} 8.508178547624517
...
...
...
```

## Step 3: Set-up Prometheus

### Step 3.1: Install a Prometheus server

Prometheus can be installed on the same server as the Weka Prometheus Client, but is not required to be on the same server.  You may have Prometheus already running in your environment.

Run the following commands to obtain and install the Prometheus server:

```text
# download
wget https://github.com/prometheus/prometheus/releases/download/v2.19.0/prometheus-2.19.0.linux-amd64.tar.gz

# extract
tar -zxvf prometheus-2.19.0.linux-amd64.tar.gz

```

### Step 3.2: Configure Prometheus to collect information from the Weka Prometheus Client

Edit the `prometheus.yml`configuration file with the Weka Prometheus Client exporter target. 

```text
# edit the prometheus.yml file in the prometheus directory to contain the Weka Prometheus Client target
vi prometheus.yml

```

`weka` should be added as another job under the scrape\_configs:

```text
  - job_name: 'weka'
    scrape_interval:     60s
    static_configs:
    - targets: ['localhost:8000']
```

Don't forget to change the `localhost` to the name or ip address of the Weka Prometheus Client's machine, if the Prometheus server is not running on the same one. Change the `8000` if you changed the port number on the Weka Prometheus Client with `-p` or `--port`.

### **Step 3.3:** Run the Prometheus server

Run the Prometheus server:

```text
# run the server in the background (it is advisable to set it up ro run on startup)
./prometheus &

```

{% hint style="info" %}
**Note:** The Prometheus server is available on port 9090: http://\[HOSTNAME\]:9090
{% endhint %}

For more information, refer to [Prometheus documentation](https://prometheus.io/docs/introduction/first_steps/).

## Step 4: Install and run a Grafana server

Run the following commands to obtain and install the Grafana server:

```text
# download
wget https://dl.grafana.com/oss/release/grafana-7.0.3-1.x86_64.rpm

# install
sudo yum install grafana-7.0.3-1.x86_64.rpm

```

Run the following commands to run the Grafana server:

```text
# run
sudo systemctl daemon-reload
sudo systemctl start grafana-server

# check status
sudo systemctl status grafana-server

```

{% hint style="info" %}
**Note:** The Grafana server is available on port 3000 http://\[HOSTNAME\]:3000 and the initial user/password is admin/admin.
{% endhint %}

{% hint style="info" %}
**Note:** Some of the examples above contain OS-specific \(example given for CentOS/RHEL\) and version-specific information. Since the software is updated frequently, the commands or package versions may differ from those presented here.
{% endhint %}

For more information, refer to [Grafana documentation](https://grafana.com/docs/grafana/latest/installation/debian/#install-from-binary-tar-gz-file).

## Step 5: Set-up a basic Weka dashboard in Grafana

### Step 5.1: Add a Prometheus data source to Grafana

From the Grafana WebUI, go to Add Data Source and enter the details of your Prometheus server, as described in [Prometheus documentation -  Creating a Prometheus data source for Grafana section](https://prometheus.io/docs/visualization/grafana/#creating-a-prometheus-data-source).

### Step 5.2: Import pre-built Weka dashboards to Grafana

From the Grafana WebUI, follow the instruction described in [Grafana documentation - Importing a dashboard section](https://grafana.com/docs/grafana/latest/reference/export_import/#importing-a-dashboard) to import the Weka-Grafana-Dashboard files that were included in the Weka Prometheus Client tarball.

{% hint style="info" %}
**Note:** Several dashboard files are included \(cluster overview, server/client details\), make sure to import both of them. It also includes a dashboard to self-monitor the Weka Prometheus Client.
{% endhint %}

