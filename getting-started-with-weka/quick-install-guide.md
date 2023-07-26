# Quick installation guide

This is a quick installation guide. For a complete installation, refer to the following pages:

[bare-metal](../install/bare-metal/ "mention")

[aws](../install/aws/ "mention")

## Prerequisites

1. [OFED is installed](../install/bare-metal/setting-up-the-hosts/#mellanox-ofed-installation)
2. [NIC devices are configured properly](../install/bare-metal/setting-up-the-hosts/#network-configuration)
3. [NTP is set up](../install/bare-metal/setting-up-the-hosts/#clock-synchronization)

For a complete prerequisite list, refer to the [Prerequisites for Installation](../install/prerequisites-for-installation-of-weka-dedicated-hosts.md) section.&#x20;

In the following examples, the deployment includes 8 identical servers. To simplify the installation commands, Mellanox or Intel E810 NICs are used. For example, only a single IP for data is required, no need to expose VFs, identification of the interface netmask, and default routing gateway.&#x20;

If the architecture is different, the installation commands are slightly different.

Once the WEKA system is installed, learn how to view, manage and operate it using either the GUI or the CLI, and perform the first IO to a WEKA filesystem.

The WEKA system supports a RESTful API for automating the interaction with the Weka system,  integrating it into your workflows and monitoring systems.

## Quick installation for a multi-container backend architecture

It is assumed that the servers are ready for the WEKA software installation. In the following example, there are 8 servers. Each server has over 20 cores, 6 NVME drives, and a single Mellanox NIC.

To run the commands on all containers in parallel, we use `pdsh` as an example only.

### Install the WEKA software

1. Install WEKA software on all servers:

```bash
pdsh -R ssh -w "weka0-[0-7]" "curl https://[GET.WEKA.IO-TOKEN]@get.weka.io/dist/v1/install/4.2.0/4.2.0 | sudo sh"

```

To get the download link with the token, see the [Obtain the Weka software installation package](../install/bare-metal/obtaining-the-weka-install-file.md) topic.

### Remove the default container

1. Remove the single default container created on each server in the cluster:

```
pdsh -R ssh -w "weka0-[0-7]" 'weka local stop default && weka local rm -f default'

```

### Generate resource files

1. Get the resource generator to your local server:

```
wget 
https://raw.githubusercontent.com/weka/tools/master/install/resources_generator.py
```

1. Copy the resource generator from your local server to all servers in the cluster:

```
for i in {0..7}; do scp resources_generator.py weka0-$i:/tmp/resources_generator.py; done

```

3\. To enable execution, change the mode of the resource generator on all servers in the cluster:

```
pdsh -R ssh -w "weka0-[0-7]" 'chmod +x /tmp/resources_generator.py'

```

4\. Run resource generator on all servers in the cluster:

```
pdsh -R ssh -w "weka0-[0-7]" '/tmp/resources_generator.py  --path /tmp --net ens{5..7}'

```

On each server, the resource generator generates three resource files in the `/tmp` directory: `drives0.json`, `compute0.json`, and `frontend0.json`.

For more details about the resource generator, see the [#3.-generate-the-resource-files](../install/bare-metal/weka-system-installation-with-multiple-containers-using-the-cli/#3.-generate-the-resource-files "mention") procedure in the _WEKA multi-container backend installation_ topic.

### Configuration

#### 1. Create the drive containers

Create the drive containers from the resource generator output file `drives0.json`. Run the following command on all servers in the cluster:

```
pdsh -R ssh -w "weka0-[0-7]" 'weka local setup container --resources-path /tmp/drives0.json'

```

#### 2. Create a cluster

Connect to one of the servers, create the cluster, and set the cluster name.\
Using bash, you can provide a compact list of containers `cluster-name{n..m}`. Otherwise, specify the full list of all containers. For example: `weka cluster create weka0-0 weka0-1 weka0-2 weka0-3 weka0-7`.\
It is assumed that the DNS is set up. Otherwise, specify the explicit IPs in the `weka cluster create` command.

```bash
ssh weka0-1
weka cluster create weka0-{0..7}
weka cluster update --cluster-name=WekaProd

```

#### 3. Add a drive to the cluster

Add a drive to each server in the cluster. Run the following command from one of the servers:

```
for i in {0..7} ; do weka cluster drive add $i /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1 ; done

```

#### 4. Create compute containers

Create the compute containers from the resource generator output file `compute0.json`. Run the following command on all servers in the cluster:

```
pdsh -R ssh -w "weka0-[0-7]" 'weka local setup container --resources-path /tmp/compute0.json --join-ips $(hostname -i)'

```

#### 5. Name the cluster and enable event notifications to the cloud

Enable event notifications to the cloud for support purposes. From one of the servers, run the following command:

```
weka cluster update --cluster-name=WekaProd
weka cloud enable

```

#### 6. Set the license

Obtain a classic or PAYG license from [get.weka.io](https://get.weka.io/) and set it.

From one of the servers, run the following command:

```
weka cluster license set LICENSE_TEXT_OBTAINED_FROM_GET_WEKA_IO

```

#### 7. Start the cluster IO service

Start the cluster IO service. From one of the servers, run the following command:

```
weka cluster start-io

```

#### 8. Create frontend containers

Create the frontend containers from the resource generator output file `frontend0.json`. This step is required for mounting from the server or setting one of the additional protocols on the server, which requires a frontend process. Run the following command on all servers in the cluster:

```
 pdsh -R ssh -w "weka0-[0-7]" 'weka local setup container --resources-path /tmp/frontend0.json --join-ips  $(hostname -i)'

```

### Post configuration: check the cluster configuration

1. Check the resources per server (such as NICs and cores), drives, and configuration status:

```bash
do
    weka cluster container resources $i
done

weka cluster drive

weka status

```

Output example for a **multiple container** architecture:

```bash
WekaIO v4.2.0 (CLI build 4.2.0)

       cluster: WekaProd (00569cef-5679-4e1d-afe5-7e82748887de)
        status: OK (8 backends UP, 6 drives UP)
    protection: 6+2
     hot spare: 1 failure domains
 drive storage: 82.94 TiB total, 82.94 TiB unprovisioned
         cloud: connected
       license: Unlicensed

     io status: STARTED 7 seconds ago (96 io-nodes UP, 750 buckets UP)
    link layer: Ethernet
       clients: 0 connected
         reads: 0 B/s (0 IO/s)
        writes: 0 B/s (0 IO/s)
    operations: 0 ops/s
        alerts: 1 active alert, use `weka alerts` to list it

```

2\. Change the default admin password and ensure no other alerts exist.



**Related topics**

[bare-metal](../install/bare-metal/ "mention")

[manage-the-system-using-weka-cli.md](manage-the-system-using-weka-cli.md "mention")

[manage-the-system-using-weka-gui.md](manage-the-system-using-weka-gui.md "mention")

[performing-the-first-io.md](performing-the-first-io.md "mention")

[getting-started-with-weka-rest-api.md](getting-started-with-weka-rest-api.md "mention")
