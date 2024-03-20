# Create a client image

When a stateless client first mounts or connects to a WEKA cluster, it downloads containers and builds drivers, taking 30 seconds to several minutes, based on the environment. For conventional machines, this is acceptable, occurring only once.

However, in scenarios with frequent client re-imaging or launching new cloud instances, the operation duration may become impractical, raising concerns about delays in downloading containers and building drivers.

This client image creation procedure is effective in on-premises environments, using the Bright Cluster Manager tool, and is also used to prepare templates for cloud-based instances (AWS AMIs).&#x20;

{% hint style="info" %}
* After a major WEKA cluster release upgrade, this procedure must be repeated using the new release.
* Considerations for diskless clients are not addressed in this procedure.
{% endhint %}

**Procedure**

1. Provision a standard and unmodified (vanilla) instance or container.
2. Install a WEKA client. \
   Perform one of the following options:

<details>

<summary>Option 1: Install WEKA client using the tarball</summary>

1. Download and untar the WEKA tarball (same as used for backend installation).
2. Open the `install.sh` and comment out the `weka local start` command.
3. Run `./install.sh`
4. Remove the default client container:\
   `weka local rm default --force`

</details>

<details>

<summary>Option 2: Install WEKA client using curl and container preparation commands</summary>

1. Install a WEKA client: \
   `curl http://<backendserverip>:14000/dist/v1/install | sh`
2. Download and set the current version of WEKA from the backend:\
   `weka version get <current version>`\
   `weka version set <current version>`
3. Setup the client and prepare the drivers: \
   `weka local setup container --name <client name> --no-start`\
   `weka version prepare <current version>`

</details>

3. Remove the machine identifier file:\
   `rm /opt/weka/data/agent/machine-identifier`
4. Stop the weka-agent service:\
   `service weka-agent stop`
5. Optional: If you used the tarball, remove it and the unzipped directory.
6. Create the image of the WEKA client using the method that is preferred for your environment.
   * If you use the Bright Cluster Manager's `grabimage` command, exclude `/opt/weka/*` from the `imageupdate` command.
   * In AWS, create an AMI from Amazon EC2 instance.

**Related information**

[Bright Cluster Manager Administrator Guide](https://docs.nvidia.com/bright-cluster-manager/archives/6.0-admin-manual.pdf)

[Create an AMI from an Amazon EC2 Instance](https://docs.aws.amazon.com/toolkit-for-visual-studio/latest/user-guide/tkv-create-ami-from-instance.html)



**Related topics**

[obtaining-the-weka-install-file.md](../planning-and-installation/bare-metal/obtaining-the-weka-install-file.md "mention")
