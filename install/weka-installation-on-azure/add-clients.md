# Add clients

Once the WEKA cluster runs, you can add clients using UDP to your WEKA system to run your workflows.

{% hint style="info" %}
**Note:** Using the Azure Console, the client instances are provisioned separately from the WEKA cluster.
{% endhint %}

## Mount the filesystem

1. Create a mount point (only once):\
   `mkdir /mnt/weka`
2. Install the WEKA agent on your client machine (only once):\
   `curl <backend server http address>:14000/dist/v1/install | sh`\
   Example:\
   `curl http://10.20.0.2:14000/dist/v1/install | sh`
3. You can mount a stateless or stateful client on the filesystem using UDP. The following is an example of mounting a stateless client: \
   `mount -t wekafs -o net=udp <Load balancer DNS name or IP address>/<filesystem name> /mnt/weka`\
   \
   Example:\
   `mount -t wekafs -o net=udp 10.20.30.40/fs1 /mnt/weka`



**Related topics**

[mounting-filesystems.md](../../fs/mounting-filesystems.md "mention")
