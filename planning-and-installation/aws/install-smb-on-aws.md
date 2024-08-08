---
description: >-
  A step-by-step guide for configuring SMB on AWS, including the Active
  Directory, AWS DNS resolution, and WEKA cluster and client.
---

# Install SMB on AWS

## SMB installation in AWS workflow overview

Set up SMB in AWS for secure and efficient file sharing and access control, integrating seamlessly with your cloud resources.

**Workflow**

[#install-aws-managed-microsoft-a-d](install-smb-on-aws.md#install-aws-managed-microsoft-a-d "mention")

[#configure-amazon-route-53-resolver](install-smb-on-aws.md#configure-amazon-route-53-resolver "mention")

[#deploy-weka-cluster-using-terraform](install-smb-on-aws.md#deploy-weka-cluster-using-terraform "mention")

[#deploy-windows-client-on-ec2](install-smb-on-aws.md#deploy-windows-client-on-ec2 "mention")

[#configure-smb](install-smb-on-aws.md#configure-smb "mention")

[#clean-up](install-smb-on-aws.md#clean-up "mention")

## 1. Install AWS Managed Microsoft AD

Set up AWS Managed Microsoft AD for centralized user and resource management in your AWS environment.

**Procedure**

1.  **Access the AWS console:**

    * Navigate to the **Directory Service** page.
    * Click **Set up directory**.

    <figure><img src="../../.gitbook/assets/image (8).png" alt=""><figcaption></figcaption></figure>
2.  **Select directory type:**

    * Ensure AWS Managed Microsoft AD is selected.
    * Click **Next**.

    <figure><img src="../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>
3.  **Configure directory:**

    * Choose **Standard Edition**.
    * Enter the **Directory DNS Name** and **Admin password**.
    * Click **Next**.

    <figure><img src="../../.gitbook/assets/image (10).png" alt=""><figcaption></figcaption></figure>
4.  **Choose VPC and subnets:**

    * Choose the appropriate **VPC** and **Subnets**.
    * Click **Next**.

    <figure><img src="../../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>
5.  **Create directory:**

    * Click **Create directory**.\
      The AD environment creation process takes approximately 20 to 40 minutes.

    <figure><img src="../../.gitbook/assets/image (12).png" alt=""><figcaption></figcaption></figure>
6.  **Record the IP addresses:**

    * Once the directory creation is completed, record the IP addresses of the domain controllers for later use in configuring the Route 53 Resolver.

    <figure><img src="../../.gitbook/assets/image (13).png" alt=""><figcaption></figcaption></figure>

## 2. Configure Amazon Route 53 Resolver

Amazon Route 53 Resolver responds recursively to DNS queries from AWS resources for public records, Amazon VPC-specific DNS names, and Amazon Route 53 private hosted zones, and is available by default in all VPCs.

**Procedure**

1.  **Access Route 53 Resolver:**

    * In the AWS Console, navigate to the **Route 53 Resolver** page.
    * Click **Configure endpoints**.

    <figure><img src="../../.gitbook/assets/image (14).png" alt=""><figcaption></figcaption></figure>
2.  **Set up outbound endpoint:**

    * Choose **Outbound only**.

    <figure><img src="../../.gitbook/assets/image (15).png" alt=""><figcaption></figcaption></figure>
3.  **Create a security group:**

    * Open a new browser tab and go to the **VPC** service page.

    <figure><img src="../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

    * Select **Security Groups** and click **Create security group**.
    * Provide a **Security group name** and **description**. Choose the appropriate **VPC**.
    * Create two rules:
      * Rule 1: Allow DNS (TCP) traffic.
      * Rule 2: Allow DNS (UDP) traffic.
    * Set the **CIDR of the VPC** as the custom source for both rules.
    * Click **Create security group**.

    <figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>
4.  **Configure endpoint settings:**

    * Return to the **Route 53 Resolver** tab.
    * Enter an **Endpoint name**.
    * Select the appropriate **VPC** and **Security group** (click the arrow to refresh if needed).
    * Set **Endpoint Type** to **IPv4** and **Protocols** to **Do53**.

    <figure><img src="../../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

    * Choose the **Availability Zone** and **Subnet**. Opt for **Use an IPv4 address that is selected automatically**.
    * Click **Next**.

    <figure><img src="../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>
5.  **Create forwarding rule:**

    * Click **Create rule**.
    * Enter a **Name** for the rule.
    * Set **Rule type** to **forward**.
    * Input the **Domain name** of the Active Directory.
    * Select the **VPC** and specify the **Target IP addresses** of both domain controllers.
    * Click **Next**.

    <figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>
6. **Review and submit:**
   * Review the entries.
   * Click **Submit** to finalize the configuration.

**Related information** (AWS documentation)

[Resolving DNS queries between VPCs and your network in AWS](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-overview-DSN-queries-to-vpc.html)

## 3. Deploy WEKA cluster using Terraform

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

<figure><img src="../../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>

## 4. Deploy Windows client on EC2

By setting up a Windows client in your AWS environment, you can manage and interact with your domain services directly within the cloud, streamlining administration and enhancing your infrastructure's flexibility.

**Procedure**

1.  **Launch the Windows instance:**

    * Navigate to the **EC2** service page in the **AWS Management Console**.
    * Click **Launch Instances**.
    * Configure the following:
      * **Name**: Enter a descriptive name for the instance.
      * **AMI**: Select **Microsoft Windows Server 2019 Base**.
      * **Instance Type**: Choose **c5n.9xlarge**.
      * **Key pair**: Select an existing key pair or create a new one.
    * **Network settings**:
      * Click **Edit**.
      * Select the appropriate **VPC**, **Subnet**, and **Security Group**. Ensure the instance is accessible through RDP.
      * Choose the same **Availability Zone** used for the WEKA cluster.
    * Expand **Advanced Details** and select the **Placement Group** that matches the WEKA cluster.
    * Click **Launch Instance**.

    <figure><img src="../../.gitbook/assets/image (17).png" alt=""><figcaption></figcaption></figure>

    <figure><img src="../../.gitbook/assets/image (18).png" alt=""><figcaption></figcaption></figure>
2.  **Connect to the Windows instance:**

    * On the **Instances** page, click on the link for your newly created instance.

    <figure><img src="../../.gitbook/assets/image (19).png" alt="" width="375"><figcaption></figcaption></figure>

    * Select the checkbox next to the instance and click **Connect**.

    <figure><img src="../../.gitbook/assets/image (20).png" alt=""><figcaption></figcaption></figure>

    * Navigate to the **RDP** tab and click **Get Password**.

    <figure><img src="../../.gitbook/assets/image (22).png" alt=""><figcaption></figcaption></figure>

    * Upload or paste your private key into the provided text box, then click **Decrypt Password**. The instance password will be displayed.

    <figure><img src="../../.gitbook/assets/image (21).png" alt=""><figcaption></figcaption></figure>
3. **Log in to the Windows client:**
   * Use the RDP credentials to log in to the Windows instance.
4. **Install required features:**
   *   Open **Windows PowerShell** and execute the following commands to install necessary features:

       ```powershell
       Install-WindowsFeature RSAT-ADDS
       Install-WindowsFeature RSAT-DNS-Server
       ```
5.  **Join the domain:**

    * Go to the **Start** menu and open **Control Panel**.
    * Navigate to **System and Security** > **System** > **See the name of this computer**.

    <figure><img src="../../.gitbook/assets/image (23).png" alt=""><figcaption></figcaption></figure>

    * Click **Change Settings**.

    <figure><img src="../../.gitbook/assets/image (24).png" alt=""><figcaption></figcaption></figure>

    * In the **Computer Name** tab, click **Change…**.

    <figure><img src="../../.gitbook/assets/image (25).png" alt="" width="375"><figcaption></figcaption></figure>

    * Under **Member of**, select **Domain** and enter `weka.local`.

    <figure><img src="../../.gitbook/assets/image (26).png" alt="" width="320"><figcaption></figcaption></figure>

    *   Click **OK** and enter the domain credentials:

        * **Username**: `Admin`
        * **Password**: The password used during the creation of the AWS Managed AD.

        <figure><img src="../../.gitbook/assets/image (27).png" alt="" width="375"><figcaption></figcaption></figure>
    * Click **OK** to join the domain.

    <figure><img src="../../.gitbook/assets/image (28).png" alt="" width="375"><figcaption></figcaption></figure>
6. **Restart the instance:**
   * Go to the **Start** menu and select **Restart** to apply the changes.

## 5. Configure SMB

Configure a WEKA SMB cluster to enable file sharing between WEKA and Windows clients, ensuring proper integration and secure access.

You can configure the SMB cluster using one of the following approaches according to your preferences:

* [#configure-smb-using-rfc2307](install-smb-on-aws.md#configure-smb-using-rfc2307 "mention"): Use this approach when you need consistent UID/GID mappings across UNIX/Linux and Windows systems, managed through Active Directory.
* [#configure-smb-using-rid-mapping](install-smb-on-aws.md#configure-smb-using-rid-mapping "mention"): Use this approach for automatic UID/GID generation in simpler environments with minimal UNIX/Linux integration.

### &#x20;Configure SMB using RFC2307

#### **1. Retrieve the WEKA Password**

* Log in to the WEKA GUI.
* Retrieve the WEKA password from Secrets Manager using the AWS CLI command listed in the Terraform output, or access it via the AWS Console.

#### **2. Create DNS records**

1. **Log in to the Windows client**:
   * Use RDP to connect, logging in with `admin@weka.local` and the corresponding password.
2. **Open DNS management**:
   * Go to **Start → Windows Administrative Tools → DNS**.
3. **Connect to the Domain Controller**:
   * Select **The following computer**, enter the IP address of the domain controller, and click **OK**.
4. **Configure DNS**:
   * In the **weka.local Forward Lookup Zone**, click **View → Advanced**.
   * Select **Action → New Host (A or AAAA)**.
   * Enter the name (matching the WEKA SMB Cluster name), IP address, and set TTL to 0. Click **Add Host**. Ensure the hostname is 15 characters or fewer.
5. **Add DNS records**:
   * Repeat the process for all three SMB protocol gateways.
6. **Validate DNS configuration**:
   * Ping `smbtest.weka.local` to confirm connectivity.
   * If ping fails, verify the security group configuration:
     * Ensure the Windows client and WEKA backend are in the same security group or have appropriate inbound rules for ping and SMB protocols.
     * Simplify by adding an **All Traffic** rule from the security group containing the Windows client to the WEKA backend security group.

#### **3. Join the WEKA SMB cluster to Active Directory**

* In the WEKA GUI, click **Join**.
* Enter the **Username** as `Admin` and the **Password** as the AD password, then click **Join**.

#### **4. Create an SMB share in WEKA**

* In the WEKA GUI, go to the **Shares** tab, then click **Create**.
* Set **Name** to `test`, **Filesystem** to `default`, **Path** to `/`, and enable **ACLs**. Click **Save**.

#### **5. Set UID and GID for the Admin user**

* In the Windows Client RDP session:
  1. Navigate to **Start → Windows Administrative Tools → Active Directory Users and Computers**.
  2. Click **View → Advanced Features**.
  3. Go to the **Users** folder under the `weka` OU. Right-click the **Admin** user and select **Properties**.
  4. On the **Attribute Editor** tab, set `uidNumber` and `gidNumber` to `0`, then click **OK**.

#### **6. Connect and configure the SMB share**

1. **Connect to the SMB share**:
   * Use File Explorer to connect to `smb://weka.local/`.
2. **Configure share permissions**:
   * Right-click the `Test` share, select **Properties**, then go to the **Security** tab.
   * Click **Edit** to modify permissions. In this example, give **Everyone** full control by checking **Allow** for **Full Control**. Click **OK**, then **Yes** on the confirmation prompt.
3. **Test the share**:
   * Access the share and create a new folder or copy a file to verify functionality.

### Configure SMB using RID mapping

**1. Configure WEKA SMB Cluster**

1. Log in via SSH to a protocol gateway.
2. Run `weka user login`.
3. Identify the container IDs of the protocol gateway frontend containers using `weka cluster container -F container=frontend0`.
4.  Execute the following command, replacing placeholders with your environment specifics:

    ```bash
    weka smb cluster create wekasmb weka.local .config_fs --encryption enabled --container-ids 12,13,14 --idmap-backend rid
    ```
5. Wait until the status indicators turn green.

**2. Create DNS Records**

1. Log in to the Windows Client via RDP using `admin@weka.local` and the corresponding password.
2. Go to **Start → Windows Administrative Tools → DNS**.
3. Select **The following computer**, enter the IP address of a domain controller, and click **OK**.
4. In **weka.local Forward Lookup Zone**, click **View → Advanced**.
5. Select **Action → New Host (A or AAAA)**.
6. Enter the name (matching the WEKA SMB cluster name), IP address, and set TTL to 0. Click **Add Host** (hostname must be 15 characters or fewer).
7. Repeat for all three SMB protocol gateways.
8. Validate by pinging `smbtest.weka.local`. If ping fails, check the security group configuration to allow ping and SMB protocols.

**3. Join WEKA SMB Cluster to Active Directory**

1. In the WEKA GUI, click **Join**.
2. Enter `Admin` as the username and the AD password, then click **Join**.

**4. Create an SMB Share in the WEKA Cluster**

1. In the WEKA GUI, go to the **Shares** tab and click **Create**.
2. Set **Name** to `test`, **Filesystem** to `default`, **Path** to `/`, and enable **ACLs**. Click **Save**.

**5. Set Initial SMB Share Permissions**

1. SSH to one of the protocol gateways.
2.  Mount the default filesystem:

    ```bash
    sudo mkdir -p /mnt/weka
    sudo mount -t wekafs default /mnt/weka
    sudo chmod 777 /mnt/weka
    ```

**6. Connect and Configure SMB Share**

1. Use File Explorer to connect to `smb://weka.local/`.
2. Right-click the `Test` share, select **Properties**, and go to the **Security** tab.
3. Click **Edit** to modify permissions, granting **Everyone** full control. Click **OK**, then confirm with **Yes**.
4. Access the share and create a new folder or copy a file to verify the configuration.

## 6. Clean up

Clean up resources after deploying a WEKA cluster in AWS. Properly removing these resources ensures that no unnecessary costs or configurations remain in your environment.

**Procedure**

1. Delete Managed AD in Directory Services.
2. Run `terraform destroy` to remove the WEKA cluster.
3. Terminate the Windows client instance.
4. Delete the Route 53 Resolver Rule and Endpoint.
