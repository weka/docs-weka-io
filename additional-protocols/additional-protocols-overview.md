# Create dedicated protocol containers in a WEKA cluster

## **WEKA cluster protocol containers overview**&#x20;

In a WEKA cluster, the frontend container provides the default POSIX protocol, serving as the primary access point for the distributed filesystem. Users can create additional protocol containers, including NFS, SMB, and S3, to enhance the cluster's capabilities and address diverse use cases. Each server in the cluster can host one of these additional protocol containers alongside the existing frontend container.

These protocol containers operate as stateful clients, serving as complete and permanent members of the WEKA cluster. They run essential processes to access WEKA filesystems and incorporate switches to support respective protocol services. This strategic allocation streamlines resource management, facilitating seamless protocol support expansion.

Dedicated protocol containers offer the following advantages:

* **Optimized performance:** Leverage dedicated CPU resources for tailored and efficient performance, optimizing overall resource usage.
* **Independent protocol scaling:** Scale specific protocols independently, mitigating resource contention and ensuring consistent performance across the cluster.

A dedicated filesystem is required to store protocol persistent configuration and to coordinate coherent simultaneous access to files from multiple servers.

<figure><img src="../.gitbook/assets/Additional_protocols_overview.png" alt=""><figcaption><p>Additional protocols to POSIX: NFS, SMB, and S3 </p></figcaption></figure>

## **Implement protocol containers**

1. **Install the WEKA software on the protocol containers:** Do one of the following:
   * Follow the default method as specified in [manually-install-os-and-weka-on-servers.md](../install/bare-metal/manually-install-os-and-weka-on-servers.md "mention").
   *   Use the WEKA agent to install from a working backend. The following commands  demonstrate this method:

       ```bash
       curl http://<EXISTING-BACKEND-IP>:14000/dist/v1/install | sudo sh   # Install the agent
       sudo weka version get 4.2.7                                         # Get the full software
       sudo weka version set 4.2.7                                         # Set a default version
       ```
2.  **Create the WEKA container for running protocols:** Protocol containers must be flagged as permanent members of the WEKA cluster that can execute protocols. Although a backend typically fulfills this role, you can create client containers on protocol nodes with specified options using the following command example:\


    {% code overflow="wrap" %}
    ```bash
    sudo weka local setup container --name frontend0 --only-frontend-cores --cores 1 --join-ips <EXISTING-BACKEND-IP>
    ```
    {% endcode %}

<details>

<summary><strong>Configure protocol containers for optimal performance</strong></summary>

The execution of the `setup` command results in creating a local container named `frontend0`, providing access to the WEKA filesystems. Similar to setting up a backend container, this command necessitates specifying parameters such as `cores` and `net` options. While the example above illustrates the use of in-kernel UDP networking for simplicity, it's essential to note that dedicated (DPDK) networking is strongly recommended for enhanced performance.

Specify DPDK networking using a flag similar to `--net=eth1/192.168.114.XXX/24`. Importantly, as with other DPDK interfaces in WEKA, an interface specified here is claimed by WEKA's DPDK implementation, making it unavailable to the Linux kernel for communication.

Ensure an adequate number of network interfaces are available on your protocol containers, particularly if you intend to dedicate NICs to WEKA. This precaution ensures a smooth and optimized configuration aligning with WEKA's performance recommendations.

</details>

3.  **Check the protocol containers in the WEKA cluster:** The protocol containers join the cluster and can be verified using the command:

    ```bash
    sudo weka cluster containers
    #Expected response example
    CONTAINER ID  HOSTNAME        CONTAINER  IPS              STATUS  RELEASE  FAILURE DOMAIN  CORES  MEMORY   LAST FAILURE  UPTIME
    42            protocol-node1  frontend0  192.168.114.31   UP      4.2.7    AUTO            1      1.47 GB                0:09:54h
    43            protocol-node2  frontend0  192.168.114.115  UP      4.2.7    AUTO            1      1.47 GB                0:09:08h
    44            protocol-node3  frontend0  192.168.114.13   UP      4.2.7    AUTO            1      1.47 GB                0:04:46h
    ```
4.  **Verify protocol container running as a client:** before being configured to run protocols, the newly configured container is listed as a CLIENT, much like any other POSIX WEKA client.

    ```bash
    sudo weka local resources | grep ^Mode
    #Expected response example
    Mode                    CLIENT
    ```
5. **Create a dedicated filesystem for protocol configurations:** The NFSv4, SMB, and S3 protocols require a persistent cluster-wide configuration filesystem to support simultaneous open files. The minimum size to support 100,000 open files is 10 GiB. If the workload exceeds this, consider increasing the filesystem’s size to 100 GiB to support up to 1 million open files.\
   The recommended name for the configuration filesystem is `.config_fs`. See [#create-a-filesystem](../fs/managing-filesystems/managing-filesystems-1.md#create-a-filesystem "mention").

With the protocol containers in place, the next step is to manage individual protocols using the container IDs of the `frontend0` containers you created. The subsequent topics guide you through the configuration for each protocol:

* [nfs-support](nfs-support/ "mention")
* [s3](s3/ "mention")
* [smb-support](smb-support/ "mention")

Continue with the relevant sections based on your requirements to effectively configure and manage the desired protocols within your WEKA cluster.

After configuring the protocol containers to host a service, the protocol container resources change to reflect that it is a permanent member of the WEKA cluster:

```shell
sudo weka local resources | grep ^Mode
#Expected response example from a protocol node
Mode                    BACKEND
```
