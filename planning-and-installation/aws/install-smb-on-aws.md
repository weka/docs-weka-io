---
description: >-
  Set up SMB in AWS for secure and efficient file sharing and access control,
  integrating seamlessly with your cloud resources.
---

# Install SMB on AWS

## Prerequisites: Install AWS Managed Microsoft AD

Set up AWS Managed Microsoft AD for centralized user and resource management in your AWS environment.

**Procedure**

1.  **Access the AWS console:**

    1. Go to the **Directory Service** page.
    2. Click **Set up directory**.

    <figure><img src="../../.gitbook/assets/image (238).png" alt=""><figcaption></figcaption></figure>
2.  **Select directory type:**

    1. Ensure AWS Managed Microsoft AD is selected.
    2. Click **Next**.

    <figure><img src="../../.gitbook/assets/image (239).png" alt=""><figcaption></figcaption></figure>
3.  **Configure directory:**

    1. Select **Standard Edition**.
    2. Enter the **Directory DNS Name** and **Admin password**.
    3. Click **Next**.

    <figure><img src="../../.gitbook/assets/image (240).png" alt=""><figcaption></figcaption></figure>
4.  **Select VPC and subnets:**

    1. Select the appropriate **VPC** and **Subnets**.
    2. Click **Next**.

    <figure><img src="../../.gitbook/assets/image (241).png" alt=""><figcaption></figcaption></figure>
5.  **Create directory:**

    1. Click **Create directory**.\
       The AD environment creation process takes approximately 20 to 40 minutes.

    <figure><img src="../../.gitbook/assets/image (242).png" alt=""><figcaption></figcaption></figure>
6.  **Record the IP addresses:**

    1. After creating the directory, select the Directory ID, select the **Networking & security** tab, and note the IP addresses under **DNS address**. (You'll need these for configuring the Amazon Route 53 Resolver in the next section.)

    <figure><img src="../../.gitbook/assets/image (243).png" alt=""><figcaption></figcaption></figure>

## **Workflow**

1. Configure Amazon Route 53 Resolver.
2. Deploy WEKA cluster using Terraform.
3. Deploy Windows client on EC2.
4. Configure SMB.

### 1. Configure Amazon Route 53 Resolver

Amazon Route 53 Resolver responds recursively to DNS queries from AWS resources for public records, Amazon VPC-specific DNS names, and Amazon Route 53 private hosted zones, and is available by default in all VPCs.

**Procedure**

1. **Create a security group:**
   1.  In the AWS Console and go to the **VPC** service page.<br>

       <figure><img src="../../.gitbook/assets/image (265).png" alt=""><figcaption></figcaption></figure>
   2. Select **Security Groups** and click **Create security group**.
   3. Provide a **Security group name** and **description**. Select the appropriate **VPC**.
   4. Create two inbound rules:
      * Rule 1: Allow DNS (TCP) traffic.
      * Rule 2: Allow DNS (UDP) traffic.
   5. Set the **CIDR of the VPC** as the custom source for both rules.
   6.  Click **Create security group**.<br>

       <figure><img src="../../.gitbook/assets/image (266).png" alt=""><figcaption></figcaption></figure>
2. **Access Route 53 Resolver:**
   1. In the AWS Console, go to the **Route 53 Resolver** page.
   2.  Click **Configure endpoints**.<br>

       <figure><img src="../../.gitbook/assets/image (267).png" alt=""><figcaption></figcaption></figure>
3. **Set up outbound endpoint:**
   1. Select **Outbound only**.
   2.  Click **Next**.<br>

       <figure><img src="../../.gitbook/assets/image (268).png" alt=""><figcaption></figcaption></figure>
   3. Enter an **Endpoint name**.
   4. Select the appropriate **VPC** and **Security group** (click the arrow to refresh if needed).
   5.  Set **Endpoint Type** to **IPv4** and **Protocols** to **Do53**.<br>

       <figure><img src="../../.gitbook/assets/image (269).png" alt=""><figcaption></figcaption></figure>
   6. Select the **Availability Zone** and **Subnet**. Opt for **Use an IPv4 address that is selected automatically**.
   7.  Click **Next**.<br>

       <figure><img src="../../.gitbook/assets/image (270).png" alt=""><figcaption></figcaption></figure>
4. **Create forwarding rule:**
   1. Enter a **Name** for the rule.
   2. Set **Rule type** to **forward**.
   3. Input the **Domain name** of the Active Directory.
   4. Select the **VPC** and specify the **Target IP addresses** for both domain controllers that you noted from the Domain controller creation in step **6 Record the IP addresses**, of [#id-1.-install-aws-managed-microsoft-a-d](install-smb-on-aws.md#id-1.-install-aws-managed-microsoft-a-d "mention").
   5.  Click **Next**.<br>

       <figure><img src="../../.gitbook/assets/image (271).png" alt=""><figcaption></figcaption></figure>
5. **Review and submit:**
   1. Review the entries.
   2. Click **Submit** to finalize the configuration.

**Related information** (AWS documentation)

[Resolving DNS queries between VPCs and your network in AWS](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-overview-DSN-queries-to-vpc.html)

### 2. Deploy WEKA cluster using Terraform

Automating the deployment with Terraform ensures consistent and efficient setup, allowing you to quickly provision and manage your WEKA infrastructure within AWS.

**Procedure**

1. Deploy WEKA using Terraform. For details, see [weka-installation-on-aws-using-terraform](weka-installation-on-aws-using-terraform/ "mention").

#### Sample template

This template deploys a cluster with SMB gateways. Customize the AWS account-specific fields to suit your environment.

```markup
provider "aws" {
}

module "deploy_weka" {
  source                                     = "weka/weka/aws"
  get_weka_io_token                          = "<redacted>"
  key_pair_name                              = "support_id_rsa"
  prefix                                     = "weka"
  cluster_name                               = "smb"
  cluster_size                               = 6
  instance_type                              = "i3en.3xlarge"
  sg_ids                                     = ["sg-08dc1e5a81c60cc91"]
  subnet_ids                                 = ["subnet-039f34922f4c68144"]
  vpc_id                                     = "vpc-070a0caa470a438bd"
  alb_additional_subnet_id                   = "subnet-0000ec8d70e9582d0"
  assign_public_ip                           = true
  set_dedicated_fe_container                 = false
  secretmanager_create_vpc_endpoint          = true
  tiering_obs_name                           = false
  smb_protocol_gateway_fe_cores_num          = 2
  smb_protocol_gateway_instance_type         = "c5n.9xlarge"
  smb_protocol_gateway_secondary_ips_per_nic = 1
  smb_protocol_gateways_number               = 3
  smb_setup_protocol                         = true
  smb_domain_name                            = "weka.local"
  smb_cluster_name                           = "smb"
}
output "deploy_weka_output" {
  value = module.deploy_weka
}
```

2. Note the cluster's placement group name from the Terraform output.

<figure><img src="../../.gitbook/assets/image (246).png" alt=""><figcaption></figcaption></figure>

### 3. Deploy Windows client on EC2

By setting up a Windows client in your AWS environment, you can manage and interact with your domain services directly within the cloud, streamlining administration and enhancing your infrastructure's flexibility.

**Procedure**

1.  **Launch the Windows instance:**

    1. Go to the **EC2** service page in the **AWS Management Console**.
    2. Click **Launch Instances**.
    3. Configure the following:
       * **Name**: Enter a descriptive name for the instance.
       * **AMI**: Select **Microsoft Windows Server 2019 Base**.
       * **Instance type**: Select an appropriate instance type. Example: **c5n.9xlarge**.
       * **Key pair**: Select an existing key pair or create a new one.
    4. **Network settings**:
       * Click **Edit**.
       * Select the appropriate **VPC**, **Subnet**, and **Security Group**. Ensure the instance is accessible through RDP.
       * Select the same **Availability Zone** used for the WEKA cluster.
    5. Expand **Advanced Details** and select the **Placement Group** that matches the WEKA cluster.
    6. Click **Launch Instance**.

    <figure><img src="../../.gitbook/assets/image (247).png" alt=""><figcaption></figcaption></figure>

    <figure><img src="../../.gitbook/assets/image (248).png" alt=""><figcaption></figcaption></figure>
2. **Connect to the Windows instance:**
   1. On the **Instances** page, click on the link for your newly created instance.\
      ![](<../../.gitbook/assets/image (272).png>)
   2.  Select the checkbox next to the instance and click **Connect**.

       <figure><img src="../../.gitbook/assets/image (250).png" alt=""><figcaption></figcaption></figure>
   3.  Select the **RDP** tab and click **Get Password**.

       <figure><img src="../../.gitbook/assets/image (252).png" alt=""><figcaption></figcaption></figure>
   4.  Upload or paste your private key into the provided text box, then click **Decrypt Password**. The instance password will be displayed.

       <figure><img src="../../.gitbook/assets/image (251).png" alt=""><figcaption></figcaption></figure>
3. **Log in to the Windows client:**
   1. Use the RDP client to log into the Windows instance using the RPD credentials.
4. **Install required features:**
   1.  Open **Windows PowerShell** and execute the following commands to install necessary features:

       ```powershell
       Install-WindowsFeature RSAT-ADDS
       Install-WindowsFeature RSAT-DNS-Server
       ```
5. **Join the domain:**
   1. Select the **Start** menu and open **Control Panel**.
   2.  Select **System and Security** > **System** > **See the name of this computer**.<br>

       <figure><img src="../../.gitbook/assets/image (273).png" alt=""><figcaption></figcaption></figure>
   3.  Click **Change Settings**.<br>

       <figure><img src="../../.gitbook/assets/image (274).png" alt=""><figcaption></figcaption></figure>
   4.  In the **Computer Name** tab, click **Change…**.\
       <br>

       <div align="left"><figure><img src="../../.gitbook/assets/image (275).png" alt="" width="375"><figcaption></figcaption></figure></div>
   5.  In the **Member of** section, select **Domain** and and enter your domain name. Example: `weka.local`.<br>

       <div align="left"><figure><img src="../../.gitbook/assets/image (276).png" alt="" width="320"><figcaption></figcaption></figure></div>
   6. Click **OK** and enter the domain credentials:
      * **Username**: The user name defined during the creation of the AWS Managed Active Directory service.
      * **Password**: The password used during the creation of the AWS Managed AD.\
        ![](<../../.gitbook/assets/image (277).png>)
   7. Click **OK** to join the domain.\
      ![](<../../.gitbook/assets/image (278).png>)
6. **Restart the instance:**
   1. Go to the **Start** menu and select **Restart** to apply the changes.

### 4. Configure SMB

Configure a WEKA SMB cluster to enable file sharing between WEKA and Windows clients, ensuring proper integration and secure access.

You can configure the SMB cluster using one of the following approaches according to your preferences:

* [#configure-smb-using-rfc2307](install-smb-on-aws.md#configure-smb-using-rfc2307 "mention"): Use this approach when you need consistent UID/GID mappings across UNIX/Linux and Windows systems, managed through Active Directory.
* [#configure-smb-using-rid-mapping](install-smb-on-aws.md#configure-smb-using-rid-mapping "mention"): Use this approach for automatic UID/GID generation in simpler environments with minimal UNIX/Linux integration.

#### Configure SMB using RFC2307

1. **Create DNS records:**
   1. **Log in to the Windows client**: Use RDP to connect, logging in with `admin@weka.local` and the corresponding password.
   2. **Open DNS management**: Go to **Start → Windows Administrative Tools → DNS**.
   3. **Connect to the Domain Controller**: Select **The following computer**, enter the IP address of the domain controller, and click **OK**.
   4. **Configure DNS**:
      1. In the **weka.local Forward Lookup Zone**, click **View → Advanced**.
      2. Select **Action → New Host (A or AAAA)**.
      3. Enter the name (matching the WEKA SMB Cluster name), IP address, and set TTL to 0. Click **Add Host**. Ensure the hostname is 15 characters or fewer.
   5. **Add DNS records**: Repeat the process for all three SMB protocol gateways.
   6. **Validate DNS configuration**:
      1. Ping `smbtest.weka.local` to confirm connectivity.
      2. If ping fails, verify the security group configuration:
         * Ensure the Windows client and WEKA backend are in the same security group or have appropriate inbound rules for ping and SMB protocols.
         * Simplify by adding an **All Traffic** rule from the security group containing the Windows client to the WEKA backend security group.
2. **Join the WEKA SMB cluster to Active Directory:**
   1. Retrieve the WEKA password from Secrets Manager using the AWS CLI command listed in the Terraform output, or access it through the AWS Console.
   2. In the WEKA GUI, select **Manage > Protocols**.
   3. Select SMB from the left menu.
   4. Select the Configurations tab.\
      The SMB Cluster configuration dialog opens. It includes the details about the AD Domain you have just set up.
   5. Click **Join**.
   6. Enter the username and password used when you created the AD Domain.
   7. Click **Join**.
3. **Create an SMB share in WEKA:**
   1. In the WEKA GUI, go to the **Shares** tab, then click **Create**.
   2. Set **Name** to `test`, **Filesystem** to `default`, **Path** to `/`, and enable **ACLs**. Click **Save**.
4. **Set UID and GID for the Admin user:**
   1. In the Windows Client RDP session:
      1. Select **Start → Windows Administrative Tools → Active Directory Users and Computers**.
      2. Click **View → Advanced Features**.
      3. Select the **Users** folder under the `weka` OU. Right-click the **Admin** user and select **Properties**.
      4. On the **Attribute Editor** tab, set `uidNumber` and `gidNumber` to `0`, then click **OK**.
5. **Connect and configure the SMB share:**
   1. **Connect to the SMB share**: Use File Explorer to connect to `smb://weka.local/`.
6. **Configure share permissions**:
   1. Right-click the `Test` share, select **Properties**, then go to the **Security** tab.
   2. Click **Edit** to modify permissions. In this example, give **Everyone** full control by checking **Allow** for **Full Control**. Click **OK**, then **Yes** on the confirmation prompt.
7. **Test the share**:&#x20;
   1. Access the share and create a new folder or copy a file to verify functionality.

#### Configure SMB using RID mapping

1. **Configure WEKA SMB Cluster:**
   1. Log in via SSH to a protocol gateway.
   2. Run `weka user login`.
   3. Identify the container IDs of the protocol gateway frontend containers using `weka cluster container -F container=frontend0`.
   4.  Execute the following command, replacing placeholders with your environment specifics:

       ```bash
       weka smb cluster create wekasmb weka.local .config_fs --encryption enabled --container-ids 12,13,14 --idmap-backend rid
       ```
   5. Wait until the status indicators turn green.
2. **Create DNS Records:**
   1. Log in to the Windows Client via RDP using `admin@weka.local` and the corresponding password.
   2. Go to **Start → Windows Administrative Tools → DNS**.
      1. Select **The following computer**, enter the IP address of a domain controller, and click **OK**.
   3. In **weka.local Forward Lookup Zone**, click **View → Advanced**.
   4. Select **Action → New Host (A or AAAA)**.
   5. Enter the name (matching the WEKA SMB cluster name), IP address, and set TTL to 0. Click **Add Host** (hostname must be 15 characters or fewer).
   6. Repeat for all three SMB protocol gateways.
   7. Validate by pinging `smbtest.weka.local`. If ping fails, check the security group configuration to allow ping and SMB protocols.
3. **Join WEKA SMB Cluster to Active Directory:**
   1. In the WEKA GUI, click **Join**.
   2. Enter `Admin` as the username and the AD password, then click **Join**.
4. **Create an SMB Share in the WEKA Cluster:**
   1. In the WEKA GUI, go to the **Shares** tab and click **Create**.
   2. Set **Name** to `test`, **Filesystem** to `default`, **Path** to `/`, and enable **ACLs**. Click **Save**.
5. **Set Initial SMB Share Permissions**
   1. SSH to one of the protocol gateways.
   2.  Mount the default filesystem:

       ```bash
       sudo mkdir -p /mnt/weka
       sudo mount -t wekafs default /mnt/weka
       sudo chmod 777 /mnt/weka
       ```
6. **Connect and Configure SMB Share**
   1. Use File Explorer to connect to `smb://weka.local/`.
   2. Right-click the `Test` share, select **Properties**, and go to the **Security** tab.
   3. Click **Edit** to modify permissions, granting **Everyone** full control. Click **OK**, then confirm with **Yes**.
   4. Access the share and create a new folder or copy a file to verify the configuration.
