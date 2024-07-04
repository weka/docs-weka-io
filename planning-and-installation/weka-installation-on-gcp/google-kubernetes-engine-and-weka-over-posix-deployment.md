---
description: >-
  A step-by-step guide to setting up Google Kubernetes Engine (GKE) with WEKA on
  Google Cloud Platform (GCP), enhancing storage and scalability for demanding
  Kubernetes workloads.
---

# Google Kubernetes Engine and WEKA over POSIX deployment

## Introduction

Google Kubernetes Engine (GKE) is a managed Kubernetes service for deploying, managing, and scaling containerized applications. WEKA is a high-performance, scalable storage platform that integrates seamlessly with Kubernetes clusters to provide persistent storage for demanding containerized applications and workflows.

Combining GKE and WEKA results in an easily automated and managed Kubernetes environment, delivering best-in-class performance at scale.

## Requirements for WEKA over POSIX with GKE

* GKE must be deployed in [Standard mode](https://cloud.google.com/kubernetes-engine/docs/concepts/choose-cluster-mode#why-standard).
* GKE Worker nodes must be configured with Ubuntu OS.

{% hint style="info" %}
If [GPUDirect-TCPX](https://cloud.google.com/compute/docs/gpus/gpudirect) (supported on GKE only with Google Container Optimized OS) is required, configure WEKA over NFS. For details, see [nfs-support](../../additional-protocols/nfs-support/ "mention").
{% endhint %}

## Workflow

1. Deploy GKE in Standard mode with Ubuntu OS.
2. Set up WEKA client on existing GKE worker nodes.
3. Configure automated WEKA setup client on worker nodes.
4. Install and configure the WEKA CSI plugin.
5. Set up WEKA storage for GKE pods.

### 1. Deploy GKE in Standard mode with Ubuntu OS

Follow these steps to deploy GKE in Standard mode with Ubuntu OS for the worker nodes. For complete GKE documentation, visit the [GCP documentation](https://cloud.google.com/kubernetes-engine/docs).

**Procedure:**

1. Go to the GCP menu, select **Kubernetes Engine**, and then **Clusters**.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXe7js2-Za8ecCfalw-w36aPDcOhr0hYENsQqgUSppY_F7Pe9or1s4f1v66IIiwubpUticNNcYa_Tmg6CyWD_4RvOoDzzT_9LQKaPgly-ZRGf6PxtKYc4MGHLsFh2Fdt-WEyVLn3vDATLtXCNftjPy114YmK7pzHsCaC2OE42Q?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

2. Click **CREATE** to create a new cluster.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXeWrY0z7zDdleUBG99xAOsY3l-cUgE21EWBxc1dnzumZL_vM0EzG0KJ3Br7KQYKri89UPX4-SAlT6Le48jCsXrBrdjhRNwheoug6LdqwE-Gmp8Od853-Wi2ntIcwfPTJ_Mt4E_dyrbr6_mRVevEdW1vdL3BY-rv9_lBnZ_-IQ?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

3. If prompted, click **SWITCH TO STANDARD CLUSTER.** This mode also enables SSH access to worker nodes, which is necessary for installing the WEKA POSIX clients.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXdl3dWZ_WebOkRZtf0POFi5hXdG2x9HuBCNs65FcGPO65iIE1xvS6GqrqR8a8ANamnog77o-LrSWxBew7I6DHfHjTipsPMzO27DfeqsUlp1SWneMQtF-V1f65u8yNX8vxnH0cvMYtj3z2RxqEgqQXEJfDT2ZBnGPR77tqdo?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXdiqiPkERPHqtfvdnG-0Rc4CO81EKFALcIxkq14TSSBNZZJKsrMWWrdygnag4VArNi2D9sKYuRsYPoB5dEbAndQwNMIO4MW7uNUnSSrr511U9WAXzZtB2Ywe5yB4wbiTus7SOEsjUcT8ly9soro9WIUoTyDk6D0SL3ZaMP6qQ?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

4. Change from a regional to a zonal setup. Select the zone where the WEKA Cluster management IPs are located to ensure optimal communication and performance. This step ensures seamless communication between GKE and the WEKA cluster.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXdWO4qd8vt3kllEoS8tNKUe205TcI0eE_hCSKtrhCx_aS4H5yKUY_vDlioa4P_1vZrBjRjyEuyTCYbR1E9Rc1QTqmIztZcy-gVBwEqAtSJ74mK0itx3PWWBj7OFE1-sjKf_HOfYIvbKtsHAe6goKNvCngssARLIYQ_Vxz7pfA?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

5. Adjust the node pool settings: Go to **Nodes** within the **default-pool** under **NODE POOLS** in the GKE console, and change the **Image type** to **Ubuntu with containerd (ubuntu\_containerd)**.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXfYSvYN_gCungoz6cPuIxzppBGbC9RSvMlrgr3fbtCKMKplWi6hZLmEGNWzV1qBCJGB9JF-WekXnz4xRlQxiDoeDdvmB-jmbUjNQZaQRfnsbCZKzb66IK99WE0NmDxkUWIMvM1l-vq6fzqJZqp5vgso58hH8x5-pe6MIdSxNA?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

6. Ensure worker nodes meet a minimum configuration of 8 vCPUs and 32 GB RAM. The WEKA client requires a minimum of 2 vCPUs and 5 GB of RAM.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXcjUHQIwEBPTZABA5tgX7d8XV53-88z5b8epKIc_fX9Q9qZuRcLPpiKLsKAoCrPZmE3Hj9Se5-VNLQvFWgrb6hATRyV9UikVxUn8gfqtWZ-CLdy3CdaFQDVpAJ8q7w1OZp6MVGUDIuTr2RlnLDFOAZELVqx2nOZvlG8u5qw?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

7. If the GKE cluster was set up in advance, deploy the WEKA cluster to the same networking VPC and subnet. Otherwise, ensure that the GKE cluster networking is configured within the same VPC and subnet as the WEKA management IPs. Aligning networking elements per the recommendation will ensure optimal performance.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXc5P1eisd6vPHVpzOSOaqtDPiZ9PxkOgozRt0oDCkKB-TXCusX3_gQQcIwHNYkU6ag-G0BaDGpPhCQZAsVEUzHYON0wfu7RIQXpiJpaBW_PKxWtcCz9_MkPgtIXpqrlAtYazbfP-pnEMlAGROKPEM_XG_iDUtVwQ3tpKfQV5Q?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXfaaCA6140795DaNo8a0WRhUPIuVQk_hHDd1GZ8UHYlxGubV9rSC2YMYSmvA7I8RuxJA_4grBFyRldoeWv5_XJ_pT2ncMbGiRUNrXazd0gP54FK2hMLJrS5PgR1JSfA2YFU5uJ32RmJ8X5pZOh9czYvZ7X1UiBKtX2DCmt13Q?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

8. Click **CREATE** to create the cluster.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXed4i-476nzMh0I-oJuiijDuDO4i7TguldIN-boK_Y2piO2y5coz8h4yzYJg_rPA8Z1K57ksz7IeIuTvya6x-0yuJRdSknbcazfrWSNa95FLpLCSwGO0DOsmT4Gv82mvH1l-ipYgL3WVdXlZucIFCpIeVmN9wYqtsiSyu9h7g?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

8. Wait for the cluster status to indicate **Ready** or **Green** before proceeding with further configuration or deployment tasks.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXdVazQ4v1lXR7yEZAKt9Rqdt8YsPuBzOfjb0WAqW6H4U3AK-oJveh1wkOoHoLQwFl4E1UyRt1O_S4PcOwwY2S4_g_Llo1alkSPZvg37jAVt3m3I5uF8eAM2nGJ6lZ_E1tSx_iRYtV2_xwaDOAbaEMYBHuYdo7VWMELChHNEXQ?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

### 2. Set up WEKA client on existing GKE worker nodes

Perform this procedure for each GKE worker node individually.

{% hint style="info" %}
Any new GKE worker nodes added later will require these steps for WEKA client installation unless the following automation steps are implemented.
{% endhint %}

**Before You Begin**

Ensure SSH access to the GKE worker nodes is available to install the WEKA client.

**Procedure:**

1. Identify the names of the GKE worker nodes where the WEKA client will be installed.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXf3Aik8MJkbu4UFVBH-Mfcc4YAUm-OFES2z5UHuDkv0KbWOn3mC7K5V0CaBw_BoSwWYhot70uiOQPuHSUb7KPGnkEc6mwbwQWXG6YGYWEsJ4uABlvtAnMt1KRXXoK7xe4gxXbKIICcwVXgTWEPNVQpOpumzH4FW36iOkTWo?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

2. Go to **Google Cloud Platform > Compute Engine > VM Instance** console. Locate the identified GKE worker node, select **SSH connect** from the dropdown menu, and choose **Open in browser window** to initiate the SSH connection.

<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXfaFLru7kgPoKpFe9FplHvpt-yQs4oWT0FlnD8zwt6U7kRx9Krn1ezVpn7H6yWmiQkn8BqEQWsUPGyzbWF8LeW5XMnLh9R3Y2Uw5x4hJMYqdyfjQ-IRaw2cutTjJCJsJj7J8hxw-wAf27wa0U_yyrtevScRS8aJN84zEvcueQ?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>

3. To avoid CPU pinning conflicts with GKE, start the WEKA client using a stateless client mount. Authorize the SSH connection, then add the WEKA client from the existing WEKA cluster. For details, see the [adding-clients-bare-metal.md](../bare-metal/adding-clients-bare-metal.md "mention") procedure.

{% tabs %}
{% tab title="Transferring SSH keys to the VM" %}
<figure><img src="../../.gitbook/assets/image (228).png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Authorize" %}
<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXdOp0Ga1pI1vr5uFQNTGoRd-Vxc2Kig6p-AMKetPUs_oYktzIXZnwQwxyotjie0sYL5SYS0umYQ1OUeZzVSjJSZVV755o8bFCTFeavWJQwsdIkwug3lPgIzFO1Dng--jJENpgTn053f5CzNgJZt8heLv5TCy_nw6eU3Kndo?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Install a WEKA client" %}
<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXdI8lv7DFfl-Y3ouYTikT3NHuvjSze6uWaG9pyUvEYGwAEenqVuxK2TN5P2senW4pUPMnlrp88pDFCFwGQ6ni2BohKU-AxaSFWFPrl46Hfju3Vx3QPuHRXYE5ZrTDzAciwaduSpazZgSYYRda_VAKmbQ15MXYgH1nVIRCIrQg?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Make directory and mount" %}
<figure><img src="https://lh7-us.googleusercontent.com/docsz/AD_4nXd4h1rADicmGaJrhqe50gVcvmSoNxYeI_takFqIVELuqJ8oVB8p-PuNTgIBwIJPu-EFOoN9E89xJkfQs-Hy2237Gqf9vZKeZyw7JHZpdMrpZKnuqZDrkKWA-VZqm134DEmC3VqizjvG1f0_YH3i4IcJMiqVurUKR44TOuZv?key=pmcWhfRW5GQA1x-KXJSIuA" alt=""><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

### 3.  Configure automated WEKA setup client on worker nodes

Google Cloud Platform (GCP) allows the addition of startup scripts at the project level, ensuring each new instance runs the script. By using metadata lookups, the WEKA client installation you can restrict to GKE cluster systems.

With auto-scaling enabled, GKE automatically adds and sets up the WEKA client on each new worker node.

**Procedure:**

1. In the GCP **Compute Engine** console, scroll to the bottom of the left-side menu.
2. Select **Metadata** under the **Settings** section.
3. Click **EDIT**, then select **+ ADD ITEM**.
4. Set the key name to **startup-script** (no spaces), and paste the following GKE WEKA client install script into the **Value** field. Replace the following input values according to your environment:
   * WEKA\_FS (line 11)
   * WEKA\_HOSTS (line 17)
   * GKE\_CLUSTER\_NAME (line 99)

<details>

<summary>GKE WEKA client install script</summary>

{% code lineNumbers="true" %}
```bash
curl -sS -H 'Metadata-Flavor: Google' 'http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true&alt=json' | jq '.attributes."cluster-name"' -r

(
    #!/usr/bin/env bash

    set -euo pipefail

    DEBIAN_FRONTEND=noninteractive
    ROOT_MOUNT_DIR="${ROOT_MOUNT_DIR:-/root}"
    
    export WEKA_FS="default"

    # Mount point for weka filesystem
    export WEKA_MOUNT="/mnt/gkeclient"
    
    # Its good to add 2-3 servers in case one is not available 
    export WEKA_HOSTS="10.0.0.8,10.0.0.9,10.0.0.10"
    
    # Timeout for how long the client is inaccessible before being removed from the cluster
    
    # Default is 86400 (24hrs) in a more dynamic environment it can be lower. 
    export WEKA_CLIENTTIMEOUNT="3600"
    
    # Number of cores to add to WEKA FrontEnd.
    export WEKA_FRONTENDCORES=2
    
    # First IP taken from WEKA_HOSTS list to download the client from.
    export WEKA_DOWNLOADIP=$(echo "$WEKA_HOSTS" | cut -d',' -f1)
  
  
    echo "Installing dependencies"
    apt-get update
    apt-get install -y apt-transport-https curl gnupg lsb-release jq

    echo "Installing gcloud SDK"
    snap install google-cloud-sdk --classic

    echo "Getting node metadata"
    ALL_METADATA="$(curl -sS -H 'Metadata-Flavor: Google' 'http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true&alt=json')"
    NODE_NAME="$(curl -sS http://metadata.google.internal/computeMetadata/v1/instance/name -H 'Metadata-Flavor: Google')"
    ZONE="$(curl -sS http://metadata.google.internal/computeMetadata/v1/instance/zone -H 'Metadata-Flavor: Google' | awk -F  "/" '{print $4}')"

    echo "Setting up disks"
    DISK_NAME="$NODE_NAME-wekadir"

    if ! gcloud compute disks list --filter="name:$DISK_NAME" | grep "$DISK_NAME" > /dev/null; then
        echo "Creating $DISK_NAME"
        gcloud compute disks create "$DISK_NAME" --size=$(( 1024*20 )) --zone="$ZONE"
    else
        echo "$DISK_NAME already exists"
    fi

    if ! gcloud compute instances describe "$NODE_NAME" --zone "$ZONE" --format '(disks[].source)' | grep "$DISK_NAME" > /dev/null; then
        echo "Attaching $DISK_NAME to $NODE_NAME"
        gcloud compute instances attach-disk "$NODE_NAME" --device-name=sdb --disk "$DISK_NAME" --zone "$ZONE"
    else
        echo "$DISK_NAME is already attached to $NODE_NAME"
    fi
    function create_wekaio_partition() {
        echo "--------------------------------------------"
        echo " Creating local filesystem on WekaIO volume "
        echo "--------------------------------------------"

        wekaiosw_device="/dev/sdb"
        if mount | grep -w $wekaiosw_device | grep -w /opt/weka; then
          echo "Weka volume is already mounted"
        else
          echo "Formatting and mounting Weka trace volume"
          mkfs.ext4 -L wekaiosw ${wekaiosw_device} || return 1
          mkdir -p /opt/weka || return 1
          mount $wekaiosw_device /opt/weka || return 1
          echo "LABEL=wekaiosw /opt/weka ext4 defaults 0 2" >>/etc/fstab
        fi
    }
    function prepare_weka_env() {
        echo "--------------- ENV ---------------"
        env
        echo "--------------- ENV ---------------"
        create_wekaio_partition || logger -s -t weka.install "Failed creating wekaio partition"
    }

    function start_weka_client() {
        prepare_weka_env
        if ! which weka; then
          echo "Installing agent from ${WEKA_DOWNLOADIP}"
          curl --fail --max-time 10 "http://${WEKA_DOWNLOADIP}:14000/dist/v1/install" | sh || logger -s -t weka.install "Failed installing agent from the first backend"
        else
          echo "Weka seems already installed, skipping agent install"
        fi
        mkdir -p ${WEKA_MOUNT}
        if mount | grep -w ${WEKA_MOUNT}; then
          echo "Weka filesystem seems already mounted on endpoint, skipping mount"
        else          
          mount -t wekafs ${WEKA_HOSTS}/${WEKA_FS} ${WEKA_MOUNT} -o remove_after_secs=${WEKA_CLIENTTIMEOUNT},num_cores=${WEKA_FRONTENDCORES},net=udp || logger -s -t weka.install "Error mounting filesystem"
        fi
    }

## Update to the name of the GKE cluster
GKE_CLUSTER_NAME=my-gke-cloud-name
GKE_METADATA_CLUSTER_NAME=$(curl -sS -H 'Metadata-Flavor: Google' 'http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true&alt=json' | jq '.attributes."cluster-name"' -r)

if [ "$GKE_CLUSTER_NAME" != "GKE_METADATA_CLUSTER_NAME" ]; then
    echo "Instance does not belong to GKE cluster $GKE_CLUSTER_NAME. Skipping installation"
else
    echo "Instance belongs to GKE cluster, initializing Weka client installation"
    start_weka_client
fi

) >/root/startup.out 2>/root/startup.err
```
{% endcode %}



</details>

5. After adding the startup script, click **SAVE** at the bottom of the page.
6. Test the script:
   * Increase the Node Pools node count.
   * Check the client list in WEKA UI to verify that the new clients have been added.

### 4. Install and configure the WEKA CSI plugin

To install and configure the WEKA CSI plugin, follow the procedures in the [weka-csi-plugin](../../appendices/weka-csi-plugin/ "mention") section.

{% hint style="info" %}
You may need to adjust the steps according to your specific setup and requirements.
{% endhint %}

### 5. Set up WEKA storage for GKE pods

To set up WEKA storage for use by GKE pods, follow the procedures in the[dynamic-and-static-provisioning.md](../../appendices/weka-csi-plugin/dynamic-and-static-provisioning.md "mention") section, in the CSI Plugin section.
