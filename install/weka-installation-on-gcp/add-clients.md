# Add clients

Weka supports any client (instance) type. The client must connect with the same VPC network and subnet as the GCP.

## Mount the filesystem

1. Create a mount point (only once):\
   `mkdir /mnt/weka`
2. Install the Weka **** agent (only once):\
   `curl <backend server http address>:14000/dist/v1/install | sh`\
   Example:\
   `curl http://10.20.0.2:14000/dist/v1/install | sh`
3. Mount a stateless client on **** the filesystem:
   * **DPDK mount:**\
     `mount -t wekafs -o net=eth1/”IP Address” <backend server IP address>/default /mnt/weka`\
     Example:\
     `mount -t wekafs -o net=eth1/”IP Address” 10.20.0.2/default /mnt/weka`
   * **UDP mount:**\
     `mount -t wekafs -o net=udp <backend server IP address>/default /mnt/weka`\
     Example:\
     `mount -t wekafs -o net=udp 10.20.0.2/default /mnt/weka`

****

**Related topics**

[mounting-filesystems.md](../../fs/mounting-filesystems.md "mention")
