# Detailed deployment tutorial: WEKA on Azure using Terraform

## Introduction

**Document Purpose**

To guide WEKA field, CS, and support technical resources through the process of deploying the WEKA data fabric in Microsoft Azure.

**Document Premise**

Deploying WEKA in Azure requires knowledge of several technologies, specifically Microsoft Azure Cloud, Terraform (infrastructure-as-code provisioning manager), basic Linux operations, and WEKA software. Understanding that not everyone tasked with deploying WEKA in Azure will have experience in each required domain, this document seeks to provide an end-to-end instruction set that allows its reader to successfully deploy a working WEKA cluster in Azure with minimal knowledge prerequisites.

**Document Scope**

This document focuses on deploying WEKA in an Azure environment which has an existing networking configuration. For instance, deploying WEKA for a POC or production purposes necessitates using an Azure customer’s existing VNet, subnet, and Network Security Group.

The reader will be guided through setting up and configuring general Azure requirements, the Azure networking requirements needed to support WEKA, installing Terraform on their local system, using Terraform to deploy WEKA, and verifying a successful deployment.

{% hint style="info" %}
A similar document is being created which will use the same format to guide a reader through deploying WEKA when Terraform is allowed to create all networking prerequisites and permits direct internet access to the WEKA cluster for logistical ease. This deployment methodology is better suited to quick demos and familiarizing oneself with Weka in Azure. It will likely never be used in a production or POC scenario.
{% endhint %}

**Attention**

One section of this document falls under the category of a **“one-time setup.”** The entirety of _Section 3: Terraform Preparation and Installation_ only needs to be completed once on a given workstation used for Terraform deployment. If, at any time, a new workstation without Terraform installed is to be used, the steps must be repeated on the new workstation.

{% hint style="info" %}
The images embedded in this document can appear small when viewed in-line with the document. Double-clicking on the image will enlarge it to its original size for easier viewing.
{% endhint %}

## Administrative Prerequisites

When deploying WEKA in Microsoft Azure, it is necessary to ensure that the target environment is well-suited for the deployment of WEKA software. There are several key components that must be configured prior to deploying WEKA using Terraform to achieve a successful outcome. The subsections below outline in a step-by-step manner how to configure each component in accordance with WEKA requirements.

### Azure Subscription

Azure environments are contained within a [Subscription](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/fundamental-concepts#azure-subscription-purposes). The Subscription is the overarching construct that contains resource groups, vnets, subnets, security groups, virtual machine instances, and so on. The first step to deploying WEKA in Azure is identifying the subscription into which the WEKA resources will be deployed.

Follow the steps below to find the correct Azure Subscription.

#### Identifying The Subscription

Navigate to the Microsoft Azure Portal. In the search bar, search for “subscriptions.” Select the “Subscriptions” service.

<figure><img src="../../.gitbook/assets/image (29).png" alt=""><figcaption></figcaption></figure>

On the Subscriptions service page, identify the subscription you wish to use for deploying WEKA.

{% hint style="info" %}
Please understand the AWS subscription structure for your environment before deploying.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (1) (1).png" alt=""><figcaption></figcaption></figure>

### User Account Privileges

To perform the operations necessary for a successful WEKA in Microsoft Azure deployment, you must confirm that the account being used is a Subscription Contributer. If the user chosen for a WEKA deployment in Azure is not a Subscription Contributer, all of the following steps in this guide will not be successful.

If an existing user cannot be used, it is recommended to create a new user that can have the necessary rights within a Subscription.

Follow the steps below to verify user privileges assignment.

#### Confirming Azure User Status

Navigate to the Azure Portal. Login using the account which will be used for the entirety of the WEKA deployment. Once in the Portal, search for “users” in the search bar and then select “Users” from the search bar drop down.

<figure><img src="../../.gitbook/assets/image (2) (1).png" alt=""><figcaption></figcaption></figure>

Search for the intended user by typing part of the username into the search box. Once the desired user appears, select the username.

<figure><img src="../../.gitbook/assets/image (3) (1).png" alt=""><figcaption></figcaption></figure>

Once on the user page, select “Azure Role Assignments.”

<figure><img src="../../.gitbook/assets/image (4) (1).png" alt=""><figcaption></figcaption></figure>

Next, view the Role Assignments to ensure the user has the proper permissions / roles. Confirm that the user is an “Owner” or “Contributor” for the Subscription you wish to use for deployment of WEKA in Azure.

<figure><img src="../../.gitbook/assets/image (5) (1).png" alt=""><figcaption></figcaption></figure>

Now that you’ve confirmed the proper user permissions, it’s time to confirm sufficient resource quotas.

### Azure Quotas

When deploying resources in Microsoft Azure, sufficient quotas must be set for the deployment of specific resources. For example, when deploying Lsv3 virtual instances for the WEKA backend cluster it is necessary to configure an adequate vCPU quota for the `Lsv3` instance type. Microsoft Azure specifies quota on a per-instance or per-instance-family basis.

If you or your customer have never used a specific instance type before, you must set a sufficient quota prior to attempting deployment otherwise failure will be experienced when running your `terraform plan` or `terraform apply` command. The minimum quota required is equal to the total number of vCPUs of a specific instance (example, `Lsv3` for WEKA backends) that will be deployed in support of the WEKA deployment. `terraform plan` and `terraform apply` will be covered in a later section.

Follow the steps below to ensure sufficient quotas are set.

#### Setting Resource Quotas

In the Azure Portal, search for “quotas” in the search bar, and select “Quotas” from the drop down menu.

<figure><img src="../../.gitbook/assets/image (6) (1).png" alt=""><figcaption></figcaption></figure>

Once on the quotas page, select “Compute.”

<figure><img src="../../.gitbook/assets/image (7) (1).png" alt=""><figcaption></figcaption></figure>

In the search bar, search for the instance family or specific instance for which you’d like to set or check quota. In this example, the instance type `Dsv5` has been used.

<figure><img src="../../.gitbook/assets/image (8) (1).png" alt=""><figcaption></figcaption></figure>

Check the box next to the desired instance type, then select the dropdown menu labeled “Request quota increase.” Then, select “Enter a new limit.”

<figure><img src="../../.gitbook/assets/image (9) (1).png" alt=""><figcaption></figcaption></figure>

In the “Request quota increase” blade, enter the desired number of vCPUs to allocate to the instance type or family in question. In this example, we’ll be asking for a new vCPU quota of 150 for the Standard `Dsv5` family of instances. Click “submit.”

<figure><img src="../../.gitbook/assets/image (10) (1).png" alt=""><figcaption></figcaption></figure>

Most quota increase requests are approved in real-time, and there is no interaction with Azure support required. If the requested quota increase is for a particularly expensive or specialized instance, or a large number of vCPUs have been requested, it’s possible the request will be denied and Azure support will need to be contacted. The example below shows a successful request for vCPU increase.

<figure><img src="../../.gitbook/assets/image (11) (1).png" alt=""><figcaption></figcaption></figure>

Be sure to set quota for any and all instances that will be used as part of the deployment or POC. As documented in the [docs.weka.io supported virtual machine types](https://docs.weka.io/install/weka-installation-on-azure/supported-virtual-machine-types) page, WEKA backends are deployed on `Lsv3` series instances. Reference the link above for a complete listing of the `Lsv3` instance sizes available for use. Quota will need to be set for the `Lsv3` instance family along with whichever instance family will be used for WEKA clients.

## Azure Resource Prerequisites

Running WEKA in Azure requires Azure cloud resources for compute, storage, networking, and security. When deploying WEKA for internal testing, a customer POC, or production deployment, a minimum resource configuration is required for successful deployment and function.

Many customers will have pre-existing Azure environments they’d like to use for WEKA. These environments will likely already have the necessary resources deployed, though confirmation will be necessary. To provide a full contextual understanding of deploying WEKA in Azure, the steps outlined below assume that WEKA is being deployed into a “blank slate” Azure environment. The instructions can also be used to navigate a customer’s existing environment to ensure prerequisites for WEKA are met.

{% hint style="info" %}
The Terraform deployment scripts used later in this guide provide an option to automatically create all necessary resources for WEKA deployment, Resource Groups being the only exception. To have Terraform create the network resources, use the \`no\_existing\_network\` example. A Resource Group must be manually configured (as depicted below) and supplied as a variable to use this option.

In most POC or production deployments, the customer will already have their networking resources configured. In this case, the \`existing\_network\` example should be used.
{% endhint %}

### Resource Groups

A Microsoft Azure Resource Group is a fundamental organizational structure within the Azure platform. It acts as a logical container for resources deployed within an Azure Subscription. Resource groups can contain any number of Azure cloud resources such as virtual machine instances, vnets, security groups, storage accounts, and other Azure cloud native services. A Resource Group needs to be available for deployment of WEKA and other Azure dependencies.

{% hint style="info" %}
There are instances where corporate IT or departmental policy requires the separation of WEKA compute instances and / or client instances from the network resources used by WEKA. There are provisions in the Terraform deployment scripts to accommodate this requirement, and these will be covered in a later section.
{% endhint %}

Follow the steps below to create a resource group.

#### Creating a Resource Group

In the Azure Portal, search for “resource group” in the search box. Select “Resource groups.”

<figure><img src="../../.gitbook/assets/image (12) (1).png" alt=""><figcaption></figcaption></figure>

On the Resource groups page, select “Create.”

<figure><img src="../../.gitbook/assets/image (13) (1).png" alt=""><figcaption></figcaption></figure>

On the Create resource group page, enter the relevant details. Be sure to select the correct subscription and region into which you wish to deploy the WEKA resources. When finished, click “Review + create.”

{% hint style="info" %}
Once a resource group has been named, it cannot be renamed at a later point in time. Keep this in mind when selecting a naming convention.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (14) (1).png" alt=""><figcaption></figcaption></figure>

Confirm creation by clicking “Create.”

<figure><img src="../../.gitbook/assets/image (15) (1).png" alt=""><figcaption></figcaption></figure>

Review the newly created resource group.

<figure><img src="../../.gitbook/assets/image (16) (1).png" alt=""><figcaption></figcaption></figure>

### VNets

A VNet, or Virtual Network, in Microsoft Azure is a core component in Azure networking. It allows Azure resources, like virtual machines (VMs), to communicate with each other, the internet, and on-premises networks securely. A VNet is a logical representation of a physical network, and it is a logical isolation of the Azure cloud dedicated to a subscription. WEKA will use VNets for both management and DPDK traffic. DPDK is the preferred method of WEKA deployment to ensure best possible performance. The VNets also contain subnets, providing address space from which virtual machine instances will obtain their IP addresses.

{% hint style="info" %}
At this time, WEKA cluster backends and POSIX clients accessing the WEKA storage should be located in the same VNet and on the same subnet. For additional details, contact the Cloud PM team.
{% endhint %}

Follow the instructions below to create an Azure VNet and subnet.

#### Creating a VNet and Associated Subnet

In the Azure Portal, search for “virtual networks” in the search bar. Select “Virtual networks.”

<figure><img src="../../.gitbook/assets/image (17) (1).png" alt=""><figcaption></figcaption></figure>

On the Virtual networks page, select “Create.”

<figure><img src="../../.gitbook/assets/image (18) (1).png" alt=""><figcaption></figcaption></figure>

On the “Create virtual network” page, enter the desired configuration details for the VNet. Select the proper subscription along with the resource group created in the prior step. Specify a VNet name and region, then select “Next: IP Addresses.”

<figure><img src="../../.gitbook/assets/image (19) (1).png" alt=""><figcaption></figcaption></figure>

In the “IP Addresses” section, specify the relevant IP address space information. The wizard pre-populates IP address space, and also pre-populates a “default” subnet configuration. The pre-populated information can be changed to suit organizational preferences or requirements. When finished, select “Review + create.”

<figure><img src="../../.gitbook/assets/image (20) (1).png" alt=""><figcaption></figcaption></figure>

Confirm creation by selecting “Create” on the next screen.

<figure><img src="../../.gitbook/assets/image (21) (1).png" alt=""><figcaption></figcaption></figure>

When creation is complete, a confirmation page will be presented. Review the newly created VNet.

<figure><img src="../../.gitbook/assets/image (22) (1).png" alt=""><figcaption></figcaption></figure>

### Network Security Groups

An Azure Network Security Group (NSG) is a networking construct provided by Azure to allow or deny network traffic to Azure resources based on a set of security rules. Essentially, it acts as a simple firewall to control ingress (incoming) and egress (outgoing) traffic to network interfaces (NICs), virtual machines (VMs), and subnets.

{% hint style="info" %}
Every NSG starts with default rules that ensure basic connectivity. For example, there's a default rule that allows outbound communication from all Azure resources and another default rule that denies all inbound traffic from the internet. These rules have high priority numbers so custom rules can easily override them.
{% endhint %}

Follow the instructions below to create a Network Security Group.

#### Creating a Network Security Group

In the Azure Portal, type “network security group” in the search bar. Select “Network security groups.”

<figure><img src="../../.gitbook/assets/image (23) (1).png" alt=""><figcaption></figcaption></figure>

On the “Network security groups” page, select “Create.”

<figure><img src="../../.gitbook/assets/image (24) (1).png" alt=""><figcaption></figcaption></figure>

On the “Create network security group” page, enter the relevant environmental information. Be sure to select the correct subscription, and use the resource group previously created. Keep the region consistent with the other resources that have been created. Select “Review + create” when finished.

<figure><img src="../../.gitbook/assets/image (25) (1).png" alt=""><figcaption></figcaption></figure>

Confirm creation by clicking “Create” on the next screen.

<figure><img src="../../.gitbook/assets/image (26) (1).png" alt=""><figcaption></figcaption></figure>

When creation is complete, a confirmation page will be presented. Review the newly created Network Security Group.

<figure><img src="../../.gitbook/assets/image (27) (1).png" alt=""><figcaption></figcaption></figure>

#### Associating a Security Group with a Subnet

Azure Network Security Groups must be associated with one of two entities to be active and effective. NSGs can be associated with either a **subnet** or **NIC**. In the context of this deployment, the NSG will be associated with the subnet created earlier in this guide. When deploying in a customer environment, it’s possible the user will encounter

Follow the instructions below to associate the NSG with a subnet.

Navigate to the “Virtual networks” page by searching for “virtual networks” from the portal search bar.

<figure><img src="../../.gitbook/assets/image (28) (1).png" alt=""><figcaption></figcaption></figure>

Select the relevant virtual network from the list presented.

<figure><img src="../../.gitbook/assets/image (29) (1).png" alt=""><figcaption></figcaption></figure>

From the selected virtual network configuration screen, select “Subnets” in the left-hand column.

<figure><img src="../../.gitbook/assets/image (30).png" alt=""><figcaption></figcaption></figure>

Select the relevant subnet - in this example, the default subnet will be selected.

<figure><img src="../../.gitbook/assets/image (31).png" alt=""><figcaption></figcaption></figure>

From the subnet configuration screen, locate the “Network security group” drop down. Select the previously created network security group.

<figure><img src="../../.gitbook/assets/image (32).png" alt=""><figcaption></figcaption></figure>

Confirm the proper NSG selection, then select “Save.”

<figure><img src="../../.gitbook/assets/image (33).png" alt=""><figcaption></figcaption></figure>

### NAT Gateways

Azure NAT (Network Address Translation) Gateway is a managed networking service provided by Azure to simplify outbound-only Internet connectivity for virtual networks. When VMs or other resources in a virtual network require outbound connectivity to the internet, the NAT Gateway provides source network address translation for their private IP addresses to a public IP address, allowing these resources to connect to external services without exposing them to inbound internet traffic.

{% hint style="info" %}
Deploying WEKA generally requires internet access from the subnet where WEKA is being deployed. Internet access is used to access apt repos and obtain the WEKA binaries for install. Rather than assigning public endpoints (public IP addresses) directly to the WEKA backend instances, a NAT Gateway is configured and associated with the WEKA cluster subnet to allow outbound internet access. This provides a greater level of security while still meeting deployment requirements.
{% endhint %}

{% hint style="info" %}
In some cases, customers do not allow any access to the internet from the subnet into which WEKA is being deployed. A solution for this scenario is covered later in this document.
{% endhint %}

#### Creating and Associating a NAT Gateway

NAT Gateways must be created and then associated with the subnet that will receive outbound internet access. The NAT Gateway creation wizard allows for both steps to be completed as part of the same process.

Follow the instructions below to create and associate a NAT Gateway.

In the Azure Portal, search for “nat” in the search bar. Select “NAT gateways.”

<figure><img src="../../.gitbook/assets/image (34).png" alt=""><figcaption></figcaption></figure>

On the “NAT gateways” page, select “Create.”

<figure><img src="../../.gitbook/assets/image (35).png" alt=""><figcaption></figcaption></figure>

On the “Create network address translation (NAT) gateway” page, enter the relevant environmental variables. Use the correct subscription and select the resource group created earlier in this document. Specify a name and region, and select “Next: Outbound IP.”

<figure><img src="../../.gitbook/assets/image (36).png" alt=""><figcaption></figcaption></figure>

In the “Outbound IP” section, select “Create a new public IP address.” In the resulting “Add a public IP” entry box, enter a name for the public IP address and select “OK.”

<figure><img src="../../.gitbook/assets/image (37).png" alt=""><figcaption></figcaption></figure>

Confirm the “Public IP address” dropdown reflects the name just provided. Select “Next: Subnet.”

<figure><img src="../../.gitbook/assets/image (38).png" alt=""><figcaption></figcaption></figure>

In the “Subnet” section, select the VNet and subnet previously created in this guide. Select “Review + create.”

<figure><img src="../../.gitbook/assets/image (39).png" alt=""><figcaption></figcaption></figure>

Confirm creation by clicking “Create.”

<figure><img src="../../.gitbook/assets/image (40).png" alt=""><figcaption></figcaption></figure>

When creation is complete, a confirmation page will be presented. Review the newly created NAT Gateway.

<figure><img src="../../.gitbook/assets/image (42).png" alt=""><figcaption></figcaption></figure>

## Terraform Preparation and Installation

HashiCorp Terraform is a tool that allows you to define, provision, and manage infrastructure as code. Instead of manually setting up servers, databases, networks, and other infrastructure components, you describe what you want in a configuration file using a declarative language. Once your desired infrastructure is described in this file, Terraform can automatically create, modify, or delete resources to match your specifications, ensuring your infrastructure is consistently and predictably deployed.

WEKA data platform deployment in Azure is automated using Terraform. Our choice of Terraform was influenced by its widespread adoption by customers, and ubiquity in the Infrastructure as Code (IaC) space. It is commonly embraced by organizations globally, large and small, to deploy stateful infrastructure both on-premises, and in public clouds such as AWS, Azure, or Google Cloud.

To deploy WEKA using Terraform, a number of prerequisites must be installed depending on the platform you wish to use for running Terraform.

HashiCorp’s website provides clear, succinct documentation on how to install Terraform on a number of platforms including Windows, Mac, and Linux. [HashiCorp: How to Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

In this guide, installing Terraform for Mac and Linux will be covered in detail.

### Configuring Terraform Prerequisites on Mac

Installing Terraform on Mac for deployment of WEKA requires several dependencies, including the [Homebrew](http://brew.sh) package manager, golang, (also known as Go), and AzureCLI. Follow the instructions in the sections below to install the prerequisites. **The prerequisites only need to be installed once** on the system from which you will be using Terraform to deploy WEKA.

#### Installing Homebrew

In a web browser, visit [https://brew.sh](http://www.brew.sh) and copy the bash script featured prominently on the homepage. For convenience, the bash script is pasted here:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

<figure><img src="../../.gitbook/assets/image (43).png" alt=""><figcaption></figcaption></figure>

Open a terminal window, and paste the the Homebrew installation bash script at the terminal prompt.

<figure><img src="../../.gitbook/assets/image (44).png" alt=""><figcaption></figcaption></figure>

The bash script downloads the Homebrew packages and requests permission to install. Press “return” to install.

<figure><img src="../../.gitbook/assets/image (45).png" alt=""><figcaption></figcaption></figure>

The installation completes. Take note of the information pertaining to adding Homebrew to your PATH. Without Homebrew in your PATH, it won’t be possible to run Homebrew in directories outside of Homebrew’s install directory.

<figure><img src="../../.gitbook/assets/image (46).png" alt=""><figcaption></figcaption></figure>

Copy the command supplied under “Next steps” and run it. The screenshot below shows two outcomes when running `brew --version`. The red box shows the outcome when running `brew` commands outside the Homebrew install directory when Homebrew has not been added to your PATH. The purple box shows the outcome when running `brew` commands outside the install directory after adding Homebrew to your PATH using the provided command. Only after adding Homebrew to the PATH did `brew --version` execute correctly.

<figure><img src="../../.gitbook/assets/image (47).png" alt=""><figcaption></figcaption></figure>

Homebrew has now been successfully installed.

#### Installing Go

Terraform leverages Go during its operation. The minimum required version of Go for WEKA deployment via Terraform is 1.19, though it is recommended to download and install the latest version. The following examples use version 1.21, which is the current version at the time of this writing.

Navigate to [https://go.dev/dl](https://go.dev/dl) and select the correct Mac download package for your machine. If your machine is Intel-based, select “x86-64.” If your machine is Apple Silicon based (M1, M2), select “ARM64.”

<figure><img src="../../.gitbook/assets/image (48).png" alt=""><figcaption></figcaption></figure>

The installation package downloads as a standard Mac `.pkg` file. Execute the file once downloaded, and proceed through the install wizard.

<figure><img src="../../.gitbook/assets/image (49).png" alt=""><figcaption></figcaption></figure>

Confirm the successful install of Go by opening a terminal window and executing `go version` at the prompt. If Go has been installed correctly, the version of Go installed should be returned.

<figure><img src="../../.gitbook/assets/image (50).png" alt=""><figcaption></figcaption></figure>

The package installs the Go distribution to /usr/local/go. The package should put the /usr/local/go/bin directory in your PATH environment variable and therefore, unlike Homebrew, you should not have to add it to your PATH manually. You may need to restart any open Terminal sessions for the change to take effect.

#### Installing AzureCLI

Terraform passes commands to Azure by leveraging the AzureCLI. It is recommended to install the most recent version of AzureCLI. The following examples use version 2.50, which is the current version at the time of this writing.

Open a terminal window, and use Homebrew to install AzureCLI by typing `brew update && brew install azure-cli` at the prompt.

<figure><img src="../../.gitbook/assets/image (51).png" alt=""><figcaption></figcaption></figure>

AzureCLI will now install.

<figure><img src="../../.gitbook/assets/image (52).png" alt=""><figcaption></figcaption></figure>

Successful installation can be confirmed by running `az version` at the prompt. A value similar to below should be returned.

<figure><img src="../../.gitbook/assets/image (53).png" alt=""><figcaption></figcaption></figure>

### Installing Terraform on Mac

At a minimum, version 1.3.7 needs to be used when using Terraform to deploy WEKA in Microsoft Azure. However, it is recommended to use the latest version of Terraform whenever possible. The following examples use version 1.5.5, which is the current version at the time of this writing. Installing Terraform using Homebrew is straightforward, and the steps to do so are outlined below.

Begin by opening a terminal window and executing `brew tap hashicorp/tap` at the prompt. This adds the HashiCorp repository to Homebrew.

<figure><img src="../../.gitbook/assets/image (54).png" alt=""><figcaption></figcaption></figure>

Install Terraform via Homebrew by executing `brew install hashicorp/tap/terraform` at the prompt.

<figure><img src="../../.gitbook/assets/image (55).png" alt=""><figcaption></figcaption></figure>

Confirm successful installation of Terraform by running `terraform --version`. If the installation has completed successfully, it should look similar to the output below. If your Mac is Intel-based, it will reflect darwin\_amd64.

<figure><img src="../../.gitbook/assets/image (56).png" alt=""><figcaption></figcaption></figure>

## Running Terraform and Deploying WEKA in Azure

With Terraform and all of its prerequisites installed, WEKA can now be deployed into Azure in an automated way. In this section, we will cover deploying WEKA in Azure in two different ways: the `existing_network` terraform example, and the `no_existing_network` terraform example.

In most real world situations, the `existing_network` example will be used since the organization will likely have a Azure resource group, VNet, subnet, and network security group preconfigured. In this case, the organization will want to use their existing resources. In this step-by-step deployment tutorial for `existing_network` , real world practices have been adhered to as closely as possible. For instance, the WEKA backends **have not** been assigned public endpoints, and therefore are not accessible from the internet. Jump box servers in both the Linux and Windows flavors have been used to facilitate access to the WEKA backends for the purposes of checking deployment status, and accessing the WEKA GUI.

For demos in a sanboxed environment and familiarizing yourself with WEKA in Azure, the `no_existing_network` example reduces overall friction and minimizes deployment time, especially when the WEKA backends are configured **with** public endpoints to allow for ease of connectivity without the need for jump box servers.

To proceed with deploying WEKA in Azure with [Terraform Essentials](https://github.com/weka/terraform-azure-weka-essential), please follow the instructions in this section.

### Logging In to AzureCLI

As mentioned earlier in this document, Terraform leverages AzureCLI to perform operations within an Azure subscription. Prior to using Terraform, the Azure user identified earlier in section 1.2 must be authenticated to Azure from the AzureCLI.

Perform the following steps to authenticate the user.

Open a terminal session and issue the command `az login`.

<figure><img src="../../.gitbook/assets/image (57).png" alt=""><figcaption></figcaption></figure>

A web browser will automatically be opened, and the user will be instructed to select an account for authentication. Select the user or enter the user’s credentials.

<figure><img src="../../.gitbook/assets/image (58).png" alt=""><figcaption></figcaption></figure>

Upon successful authentication, the user will be informed that the login was successful. The user can now return to the terminal session.

<figure><img src="../../.gitbook/assets/image (59).png" alt=""><figcaption></figcaption></figure>

Upon returning to the terminal, the user will see an output reflecting the authentication status of AzureCLI.

<figure><img src="../../.gitbook/assets/image (60).png" alt=""><figcaption></figcaption></figure>

### Locate the User’s get.weka.io Token

The [get.weka.io](http://get.weka.io) token provides access to the WEKA binaries, and is used to query get.weka.io during the installation process.

To find the user’s get.weka.io token, follow the instructions below.

In a web browser, navigate to get.weka.io and select the user’s name in the upper righthand corner of the page.

<figure><img src="../../.gitbook/assets/image (61).png" alt=""><figcaption></figcaption></figure>

From the column on the lefthand side of the page, select “API Tokens.” The user’s API token is presented on the screen. The API token will be used later in the install process.

<figure><img src="../../.gitbook/assets/image (62).png" alt=""><figcaption></figcaption></figure>

### Obtaining the Terraform Essentials Package

Terraform resources for deploying WEKA in Azure are stored, updated, and managed on GitHub. Updates are committed on a regular basis, and Terraform GA code releases are tagged as a release. The `terraform-azure-weka-essential` [GitHub page](https://github.com/weka/terraform-azure-weka-essential) is a wealth of information, and hosts the README file that explains the Terraform modules and input variables that can be used as part of a WEKA in Azure deployment using Terraform. The key variables necessary to facilitate a deployment will be covered in the next several sections, while others are more elective in nature and are used to fit certain environmental or customer requirements.

Follow the instructions below to obtain the `terraform-azure-weka-essential` terraform package.

Navigate to the `terraform-azure-weka-essential` GitHub repo, which can be found at [https://github.com/weka/terraform-azure-weka-essential](https://github.com/weka/terraform-azure-weka-essential). On the righthand side of the page, the latest GA code release is shown. Click the current release (v1.0.3 as of this writing) to review download options.

<figure><img src="../../.gitbook/assets/image (63).png" alt=""><figcaption></figcaption></figure>

The tagged release page shows the release version, the features / changes added since the previous release, and the assets the release contains. The terraform package can be downloaded in either zip or tar format. Select zip to download the code.

{% hint style="info" %}
In the upper lefthand corner of the page, there’s a link to “releases.” Clicking on “releases” will load the full tagged release history for viewing and download, though it is recommended to always use the most recent release.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (64).png" alt=""><figcaption></figcaption></figure>

Once downloaded, extract the terraform code into your preferred working directory.

<figure><img src="../../.gitbook/assets/image (66).png" alt=""><figcaption></figcaption></figure>

### Deploying WEKA in Azure with Terraform - existing\_network example

In the context of a Terraform module or package, the **`examples`** directory is a common convention used by terraform module developers to provide consumers of the module with the following:

1. **Usage Examples**: Demonstrations of how the module can be used. This helps consumers understand the module's functionality, inputs, and outputs in practical scenarios.
2. **Test Scenarios**: Some module developers use the **`examples`** directory to define specific scenarios that they then test with automated testing tools. By providing executable examples, developers can ensure that changes to their module don't inadvertently break its functionality.
3. **Variations**: If a module can be used in multiple ways or has several typical configurations, the **`examples`** directory might contain various subdirectories, each demonstrating a different way of using the module.

When you're checking out a new Terraform module (e.g., from the Terraform Registry or GitHub), it's a good practice to look in the **`examples`** directory (if one exists) to get a sense of how the module is intended to be used. Not all modules will have this directory, but when they do, it's often a valuable resource for understanding and properly implementing the module in your infrastructure.

In the context of a WEKA deployment, the `examples` directory contains two subdirectories - `existing_network` and `no_existing_network` . The “network” being referred to is the Azure environment vnet and associated subnet. As discussed earlier, each section up to this point has been constructed with the intent of deploying WEKA via the `existing_network` method. Each subdirectory contains a `main.tf` file which is intended to be customized with input variables that set the primary WEKA cluster configuration and shape the final deployment.

Follow the instructions below to deploy WEKA.

#### Preparing the main.tf File

In the newly unzipped parent `terraform-azure-weka-essential` directory, navigate to `examples`.

<figure><img src="../../.gitbook/assets/image (67).png" alt=""><figcaption></figcaption></figure>

Navigate to `existing_network`.

<figure><img src="../../.gitbook/assets/image (68).png" alt=""><figcaption></figcaption></figure>

Locate the `main.tf` file.

<figure><img src="../../.gitbook/assets/image (69).png" alt=""><figcaption></figcaption></figure>

Open the `[main.tf](http://main.tf)` using your choice of code editor. Some code editors, such as PyCharm or Microsoft VS Code, have terraform plugins that highlight the syntax in a helpful manner which is useful when editing. Review the input variables contained in `main.tf` by default.

The default input variables are broken down below.

```json
  source            = "../.."  #terraform module location (local)
  prefix            = "essential" #desired cluster naming convention prefix (specified by user, to be used by Terraform when creating resources.)
  rg_name           = "example" #azure resource group name (to be pre-created in Azure by the user, Terraform will use it for placement of created resources.)
  cluster_name      = "test" #cluster naming convention suffix (specified by user, to be used by Terraform when creating resources.)
  instance_type     = "Standard_L8s_v3" #azure vm instance type, size
  cluster_size      = 6 #number of WEKA backends in the cluster
  get_weka_io_token = ".." #get.weka.io token
  vnet_name         = "essential-vnet" #azure vnet name (to be pre-created in Azure by the user, Terraform will use it for placement of resources.)
  subnet            = "essential-subnet" #azure subnet name (to be pre-created in Azure by the user, Terraform will use it for placement of networking resources.)
```

<figure><img src="../../.gitbook/assets/image (70).png" alt=""><figcaption></figcaption></figure>

Populate the `main.tf` in accordance with the objectives of the deployment. In the `main.tf` shown below, the default input variable values have been changed to reflect the Azure resources (resource group, vnet, subnet) created earlier in this document. Additionally, three optional input variables have been added to customize this deployment to maintain the objective of simulating a customer POC deployment. The light purple bracket shows the added variables. The dark purple bracket shows the variables that should be customized prior to deployment. Save the file after modifying.

The added input variables are summarized below.

```json
  assign_public_ip  = false #do not assign public IPs to backends
  clients_number    = 2 #automatically create and mount 2 clients
  client_instance_type = "Standard_D8_v5" #client instance type, size
```

{% hint style="info" %}
Remember, the complete list of input variables and usage instructions can be found on GitHub in the README section.\
[https://github.com/weka/terraform-azure-weka-essential](https://github.com/weka/terraform-azure-weka-essential)
{% endhint %}

{% hint style="info" %}
The \`subscription\_id\` is tied to the same subscription identified in the section.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (71).png" alt=""><figcaption></figcaption></figure>

#### Terraform Init, Plan, and Apply

In this phase of the deployment, terraform will begin deploying resources. Three primary commands will be used to initiate resource deployment:

* `init`: Initializes a Terraform working directory by downloading necessary providers and setting up backend storage.
* `plan`: Shows a preview of the changes that Terraform will make based on the current configuration.
* `apply`: Applies the proposed changes to reach the desired state defined in the configuration.

In a terminal window, navigate to the same `existing_network` directory containing the `main.tf` file modified in the steps above.

<figure><img src="../../.gitbook/assets/image (72).png" alt=""><figcaption></figcaption></figure>

Verify the changes made to the `main.tf` file in the previous step were saved correctly, but running `cat main.tf`. Review the contents of the printed file for any errors.

<figure><img src="../../.gitbook/assets/image (73).png" alt=""><figcaption></figcaption></figure>

Initialize terraform by running `terraform init`. The required providers will be downloaded and configured.

<figure><img src="../../.gitbook/assets/image (74).png" alt=""><figcaption></figcaption></figure>

Run `terraform plan` to perform a quick “dry run” of the deployment. `plan` usually catches most configuration issues before running the final `apply` command, and is generally a good idea to run. If there are no errors presented by `terraform plan`, the user can have a high level of confidence that `terraform apply` will run successfully. A successful `plan` run is indicated by a lack of red error outputs and the presence of green “+” symbols next to the resources being created. Look for an output similar to below for confirmation of a successful `plan`.

<figure><img src="../../.gitbook/assets/image (75).png" alt=""><figcaption></figcaption></figure>

Finally, initiate the deployment of Weka in Azure by running `terraform apply`. `apply` executes the creation of Azure resources necessary to run WEKA. Confirm deployment of resources by typing `yes` at the prompt.

{% hint style="info" %}
Take note of the local directory where Terraform will store the SSH private key associated with the created resources. It will be required for accessing the deployed resources via SSH. Also take note of the SSH username.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (76).png" alt=""><figcaption></figcaption></figure>

The terraform deployment process begins. Text similar to the output shown below will begin to scroll up the terminal window.

<figure><img src="../../.gitbook/assets/image (77).png" alt=""><figcaption></figcaption></figure>

When the terraform Azure resource deployment process successfully completes, an output similar to below will be shown. Take note of the deployed WEKA backend IPs as well as the deployed client IPs, if clients were configured as part of the initial terraform `main.tf` file. As a reminder, again take note of the SSH private key path and the SSH user name.

<figure><img src="../../.gitbook/assets/image (78).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
It is important to note that once Terraform has finished deploying Azure resources, WEKA has not finished deploying. Terraform deploys the Azure infrastructure resources necessary to run WEKA, but that is not the final step in a WEKA in Azure deployment. Once Terraform completes resource deployment, \`cloud init\` scripts kick off the installation of WEKA software and finalize clusterization.
{% endhint %}

{% hint style="info" %}
In the next section, we’ll cover how to monitor the WEKA software installation and clusterization process to ensure a successfully deployed, working WEKA cluster.
{% endhint %}

#### Locate and SCP the WEKA Cluster SSH Key to Azure Jump Box

The WEKA cluster SSH key created during terraform deployment is required to access the WEKA cluster backend members, as well as any WEKA clients that were deployed via terraform.

Follow the instructions below to locate the SSH private key and SCP it to the Azure jump box.

Navigate to the `/tmp/` directory.

<figure><img src="../../.gitbook/assets/image (79).png" alt=""><figcaption></figcaption></figure>

Locate both the public (.pub) and private (.pem) key files.

Use SCP to transfer the private key (.pem) file from the local machine’s `/tmp/` directory to the Azure linux jump box. Text highlighted in purple should be copied and used directly for your specific SCP command. Text in green should be customized to your unique values.

`azureuser` is the default user account created when creating a new virtual machine instance in Azure. It is recommended to keep this default. The first path highlighted in green is the path to the private key for your Azure jump box. The second path is for the private key for the newly created WEKA cluster you’d like to transfer to the Azure jump box. The IP address should be changed to the Azure public IP of your jump box. The WEKA cluster private key should be transferred to the `.ssh` directory in the default azureuser’s home directory on the jump box.

<figure><img src="../../.gitbook/assets/image (80).png" alt=""><figcaption></figcaption></figure>

If the command has been configured correctly, an output similar to below should be printed to the terminal upon completion of private key transfer.

#### Monitoring Deployment Status

When deploying into a customer’s Azure environment, it’s likely they’ll already have some means of connectivity to the vnet and subnet into which WEKA has been deployed. This could be by way of a VPN, [bastion host](https://azure.microsoft.com/en-us/products/azure-bastion), or preconfigured jump box. If the customer doesn’t have any means of accessing the WEKA cluster on the isolated subnet, they’ll need to configure one of the methods mentioned above. In this example, a preconfigured Ubuntu linux jump box with a publicly assigned IP will be used. The jump box is in the same vnet, network security group, and subnet as the WEKA cluster, though inbound access rules have been applied to the network security group to facilitate access from the outside on SSH port 22.

Some form of access to the WEKA cluster will be crucial for monitoring the deployment progress and ensuring everything completes successfully.

Follow the steps below to monitor deployment progress.

Navigate to Virtual Machines in the Azure portal. Locate the virtual machine instance with the suffix `clusterizing` . The `clusterizing` suffix is only visible in the Azure portal to denote the WEKA backend cluster member that runs post resource deployment clusterization scripts. You’ll note that the virtual machine’s actual name is `demo-bgc-backend-5`.

Identify the local network IP address of the `clusterizing` instance’s management interface. Take note of the IP address, as it will be used in the next step.

<figure><img src="../../.gitbook/assets/image (81).png" alt=""><figcaption></figcaption></figure>

SSH to the Azure linux jump box using the applicable private key and public IP address. This private key is **not** the WEKA cluster SSH private key saved to the `/tmp/` directory by terraform. The jump box private key would’ve been specified or created and downloaded at the time the jump box was manually created in the Azure portal.

Once connected to the jump box, use the local IP address of the `clusterizing` instance identified in the previous step to SSH into the `clusterizing` instance, also known as `demo-bgc-backend-5`.

{% hint style="info" %}
The \`clusterizing\` instance will always be the last node of the cluster. For instance, if a 6 node cluster is deployed, the instances will have suffixes \`0-5\`. Instance \`5\` will be the \`clusterizing\` instance. If an 18 node cluster is deployed, the instances will have suffixes \`0-17\`. Instance \`17\` will be the \`clusterizing\` instance.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (82).png" alt=""><figcaption></figcaption></figure>

Once connected to the `clusterizing` instance, navigate to the `/var/log` directory. Locate the `cloud-init-output.log` file highlighted in purple. Run the command `tail -f cloud-init-output.log` to tail the logfile to check the status of the deployment. In the example below, the `tail` command was run while WEKA binaries were being downloaded from `get.weka.io`.

<figure><img src="../../.gitbook/assets/image (83).png" alt=""><figcaption></figcaption></figure>

The WEKA containers are being configured as the WEKA installation continues.

<figure><img src="../../.gitbook/assets/image (84).png" alt=""><figcaption></figcaption></figure>

The install script will start-io. At this point, i-nodes and WEKA buckets will begin coming online.

<figure><img src="../../.gitbook/assets/image (85).png" alt=""><figcaption></figcaption></figure>

Finally, the file system group `default` and file system `default` will be created. The date and time of cluster creation completion will be printed in UTC. The number of seconds required to perform clusterization is printed. This signifies that the WEKA installation and clusterization processes are complete.

<figure><img src="../../.gitbook/assets/image (86).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Stay logged into \`backend-5\` for the next section.
{% endhint %}

#### Weka Status and Client Status

To confirm that the WEKA cluster is up and running, issue a `weka status` command on the `backend-5` cluster member. If the cluster is indeed up and running, an output identical to the below should be outputted.

{% hint style="info" %}
Note the \`status\`, \`protection\`, and \`io status\`.
{% endhint %}

When the terraform `main.tf` file was configured for this deployment, two clients were specified for deployment in addition to the WEKA cluster backend members. Note that when `weka status` is initially run immediately following `cloud-init` script completion, those clients aren’t acknowledged. Note the entry for `clients: 0 connected`. **This is expected behavior**, as the clients are the last components to initialize. Depending on the number of clients deployed, 15 minutes can elapse before all clients are registered.

<figure><img src="../../.gitbook/assets/image (87).png" alt=""><figcaption></figcaption></figure>

Below, it can be seen that the two clients are successfully connected to the cluster three minutes after cluster io starts.

<figure><img src="../../.gitbook/assets/image (88).png" alt=""><figcaption></figcaption></figure>

#### WEKA GUI Login and Review

Using a jump box with a GUI deployed into the same vnet and subnet as the WEKA cluster, the WEKA GUI can be accessed via a web browser.

In the examples below, a Windows 10 instance with a public IP address was deployed in the same vnet, subnet, and security group as the WEKA cluster. Network security group rules were added to allow RDP explicit access to the Windows 10 system.

Open a browser in the Windows 10 jump box and visit `https://<cluster-backend-ip>:14000`. The WEKA GUI login screen should appear. After changing the default password, login.

<figure><img src="../../.gitbook/assets/image (89).png" alt=""><figcaption></figcaption></figure>

View the cluster GUI home screen.

<figure><img src="../../.gitbook/assets/image (90).png" alt=""><figcaption></figcaption></figure>

Review the cluster backends.

<figure><img src="../../.gitbook/assets/image (91).png" alt=""><figcaption></figcaption></figure>

Review the clients attached to the cluster as part of the terraform deployment process.

<figure><img src="../../.gitbook/assets/image (92).png" alt=""><figcaption></figcaption></figure>

Review the file system `default` created as part of the terraform deployment process.

<figure><img src="../../.gitbook/assets/image (95).png" alt=""><figcaption></figcaption></figure>

In the Azure portal Virtual Machines page, view the WEKA cluster instance resources.

<figure><img src="../../.gitbook/assets/image (94).png" alt=""><figcaption></figcaption></figure>

## Running Terraform and Deploying WEKA in Azure using Terraform Advanced

Like Azure Terraform Essentials, Azure Terraform Advanced has a number of prerequisites that need fulfillment prior to running Terraform. The prerequisites are dependent upon the desired type of deployment - for instance, whether an existing network with existing Azure resources will be used, or if the WEKA Terraform package will be permitted to auto-create the required environmental resources.

It is important to note that, due to the increased functionality provided by Terraform Advanced, more Azure resource dependencies will be required for a successful WEKA deployment than with Terraform Essentials.

In the section below, the required Azure dependencies for Terraform Advanced will be listed, described, and explained in the context of WEKA and WEKA deployment.

### Terraform Advanced Dependencies and Constructs

When invoked, the Terraform Advanced package will deploy (or will require their creation in advance, depending on deployment method used) the following Azure environmental resources:

* **VMSS (Virtual Machine Scale Set):** A Microsoft Azure Virtual Machine Scale Set (VMSS) is a service in Azure, which allows for the deployment and management of a set of identical virtual machine instances intended to scale depending on user, application, or infrastructure needs. VMSS is designed for applications that need to quickly scale in or out, based on demand. In the context of WEKA, the VMSS logically contains all of the WEKA backend instances and additionally makes use of Placement Groups.
* **Placement Groups:** Placement groups are used to control the distribution and placement of the VM instances within a scale set. They are designed to optimize network traffic among VM instances and to provide fault tolerance. In the context of WEKA, currently only single-placement groups are supported which allows for WEKA backend clusters consisting of up to 100 VM instances.
* **Resource Groups:** A Microsoft Azure Resource Group is a fundamental organizational structure within the Azure platform. It acts as a logical container for resources deployed within an Azure Subscription. Resource groups can contain any number of Azure cloud resources such as virtual machine instances, vnets, security groups, storage accounts, and other Azure cloud native services. A Resource Group needs to be available for deployment of WEKA and other Azure dependencies.
* **Vnet:** A VNet, or Virtual Network, in Microsoft Azure is a core component in Azure networking. It allows Azure resources, like virtual machines (VMs), to communicate with each other, the internet, and on-premises networks securely. A VNet is a logical representation of a physical network, and it is a logical isolation of the Azure cloud dedicated to a subscription. WEKA will use VNets for both management and DPDK traffic. DPDK is the preferred method of WEKA deployment to ensure best possible performance. The VNets also contain subnets, providing address space from which virtual machine instances will obtain their IP addresses.
* **Subnet:** An Azure subnet is a range of IP addresses in your virtual network (VNet) in the Microsoft Azure cloud. It allows you to segment the network within your VNet, providing a way to organize and secure resources in a structured manner.
* **Delegated subnets / subnet delegations:** Azure subnet delegations, often referred to as delegated subnets, is a feature in Azure Networking that allows you to designate a specific subnet (within a Vnet) for a particular Azure service. This delegation grants permissions to the service to create service-specific resources within that subnet. In the context of WEKA, delegated subnets are used for our function apps and logic apps which support features like user driven cluster scaling and cluster auto healing.
* **Network Security Group (NSG):** An Azure Network Security Group (NSG) is a networking filter (or firewall) used in Microsoft Azure that contains a list of security rules. These rules are used to filter network traffic to and from Azure resources within a Virtual Network (VNet). Each rule in an NSG defines whether to allow or deny traffic based on several parameters, such as source/destination IP addresses, ports, and protocols. In most instances, it is ideal to have a self-referencing rule in place - a self-referencing rule in an NSG is a security rule that references the NSG itself as the source or destination of the traffic.
* **Private DNS Zone:** A Private DNS zone in Azure is a type of DNS zone that is used to host DNS records for a domain within a private network. Unlike public DNS zones, which resolve domain names on the public internet, private DNS zones are used within Azure Virtual Networks (VNets) to resolve domain names in a private network environment. In the context of WEKA, the private DNS zones are used within Azure VNets. They provide name resolution for VMs, application services, WEKA components and other resources that are connected to these VNets.

### Deploying Terraform Advanced from the Terraform Registry

#### Deployment Prerequisites

Prior to deploying WEKA via Terraform Advanced, it is important to pre-create some of the dependencies if it has been decided that Terraform will not be creating all prerequisites. For instance - if using an existing Vnet, it is necessary to pre-create that Vnet. In a customer’s environment, it is likely that all pre-existing resources will already be created.

The need to create resources as part of this guide is purely educational. The instructions provided earlier in this document for creating Azure pre-requisites are not exclusively applicable to Terraform Essentials - they are general guidelines for creating Azure resources and can also be used for Terraform Advanced. Therefore, the instructions in sections [1. Administrative Prerequisites](https://www.notion.so/1cf5acb8c7f2470b850b20741d3f508d?pvs=21) and [2. Azure Resource Prerequisites](https://www.notion.so/1cf5acb8c7f2470b850b20741d3f508d?pvs=21) still apply for general Azure cloud resource creation.

Additionally, the instructions for installing Terraform and its prerequisites from section [3. Terraform Preparation and Installation](https://www.notion.so/1cf5acb8c7f2470b850b20741d3f508d?pvs=21) also apply to this Terraform Advanced section.

#### Navigating the Terraform Registry and Obtaining the Files

Deploying WEKA using the Terraform Registry makes it easy to stay up to date with the most recent Terraform releases, cleanly manage versioning, and requires only one `main.tf` file to be downloaded for variable configuration. Access to WEKA’s Terraform Registry Namespace can be found below:

[Terraform Registry WEKA Namespace](https://registry.terraform.io/namespaces/weka)

After arriving at the WEKA Namespace page on the Terraform Registry, select the “weka / weka” module.

<figure><img src="../../.gitbook/assets/image (96).png" alt=""><figcaption></figcaption></figure>

The “weka / weka” module page contains a wealth of resources and information, some of which will be covered in this guide. There are several sections to the module page, as shown below.

The `README` tab replaces the traditional README file typically found on GitHub and explains in detail how the module works.

The `Inputs` tab outlines all the possible variables supported by the module, such as selecting a Vnet, specifying resource groups, indicating desired instance types, and so on. The inputs are how a user configures the features, functions, and capabilities of the WEKA environment that is ultimately deployed by Terraform.

The `Outputs` tab describes the available pieces of information that can be outputted by the Terraform module after the `terraform apply` is complete. These outputs will assist the user in tracking cluster deployment status, retrieving the auto-created WEKA password from the KeyVault, downloading SSH keys, along with other functions that will be discussed later.

The `Dependencies` tab outlines the provider dependencies that will be installed automatically upon running `terraform init` .

The `Resources` tab outlines all of the Azure resources that the module may or may not create, depending upon user input variable selection.

<figure><img src="../../.gitbook/assets/image (97).png" alt=""><figcaption></figcaption></figure>

To download the `main.tf` file and get started, click the “Examples” drop down and select the deployment type relevant to the situation. For this guide, the `public_network` example will be used as a starting point, though we’ll modify it to demonstrate deployment of WEKA into an existing public network rather than having Terraform Advanced create the vnet and subnet.

On the following page, select the GitHub source code link.

<figure><img src="../../.gitbook/assets/image (98).png" alt=""><figcaption></figcaption></figure>

On the GitHub page, click the `main.tf` link to open the `public_network` example.

{% hint style="info" %}
Keep in mind that an example is just that - an example. It provides a starting place to begin assembling the variables specific to your deployment and environment. Examples should not be used “as is” with the expectation that it will have the expected outcome.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (99).png" alt=""><figcaption></figcaption></figure>

Click the “download” button to download the `main.tf` example file.

Once downloaded, open the `main.tf` file in your preferred code editor. In the following section, the file will be tailored to fit the Azure environment into which WEKA is being deployed, along with specifying the desired WEKA configuration.

#### Selecting Variables and Editing the main.tf Deployment File

Open the downloaded `main.tf` file in your preferred code editor and review the default variables supplied as part of the example.

```jsx
//Under provider "azurerm"
subscription_id = var.subscription_id //replace with the Azure subscription id of the deployment environment
partner_id = "f13589d1-f10d-4c3b-ae42-3b1a8337eaf1" //attributes azure resource spend with WEKA as a partner.  Do not alter.

//Under module "weka_deployment"
source = "../.." //specifies the module source location
prefix = "weka" //cluster prefix for resources created in Azure
rg_name = "weka-rg" //specifies the name of the precreated Azure resource group
get_weka_io_token = var.get_weka_io_token //replace with your unique get.weka.io software download token
subscription_id = var.subscription_id //replace with the Azure subscription id of the deployment environment
cluster_name = "poc" //the custom cluster name, appended to the prefix variable noted above
tiering_enable_obs_integration = true //specifies whether object tiering should be enabled
cluster_size = 6 //specifies the number of WEKA backend members to create for the WEKA cluster
allow_ssh_cidrs = ["0.0.0.0/0"] //since this is a public network example, allow ssh access to cluster members from a defined WAN address range
allow_weka_api_cidrs = ["0.0.0.0/0"] //since this is a public network example, allow access to WEKA API from a defined WAN address range
```

Several of the default example variables will be altered and others will be added to customize the deployment for the purposes of this guide. The deployment will be to an existing public network.

{% hint style="info" %}
Important to note: Many of the Terraform Advanced variables listed and described on the \[Terraform Registry page for the Azure Weka / Weka module]\(https://registry.terraform.io/modules/weka/weka/azure/latest) under \[Inputs]\(https://registry.terraform.io/modules/weka/weka/azure/latest?tab=inputs) have been assigned “default variable values.” This means that unless a variable is explicitly included in the \`main.tf\` deployment file, a default value which has been specified in the \`variables.tf\` file will be used and applied. Therefore, it is good practice to review the input variables on the Terraform Registry Azure Weka / Weka module page to determine whether the defaults are acceptable or if the variable should be included and customized in the \`main.tf\` deployment file.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (100).png" alt=""><figcaption></figcaption></figure>

Shown below is the customized `main.tf` deployment file that will be used to deploy a WEKA cluster as part of this guide. Below the screenshot, all changes have been described in detail.

<figure><img src="../../.gitbook/assets/image (101).png" alt=""><figcaption></figcaption></figure>

```jsx
//Under provider "azurerm"
subscription_id = //Has been filled out with the Azure subscription associated with the environment into which WEKA will be deployed.

//Under module "weka_deployment"
source = "weka/weka/azure" //This value points Terraform to the Terraform Registry - specifically, the Weka Namespace and Weka Module for Azure.
version = "4.0.5" //Specifies the Weka Terraform module release version for Azure Terraform Advanced.
prefix = "weka" //Prefixes created Azure resources with "weka" - this value can be customized per customer requirements.
rg_name = "bgcadv" //References the existing Azure resource group for deployment of WEKA resources.
vnet_name = "bgcadv" //References the existing Azure vnet where deployment of WEKA resources should occur.
subnet_name = "default" //References the existing Azure subnet within the existing vnet where deployment of Weka resources should occur.
get_weka_io_token = "your_token_here" //get.weka.io token to be used for downloading WEKA binaries.
subscription_id = "azure_subscription_id_here" //Has been filled out with the Azure subscription associated with the environment into which WEKA will be deployed.
cluster_name = "bgcadv0" //Name of deployed cluster resources.  Will be appended to the prefix specified earlier.
tiering_enable_obs_integration = false //For the purposes of this guide, object integration will not be configured.
instance_type = "Standard_L8s_v3" //Specify the desired (supported) Azure instance type here for WEKA cluster backends.
cluster_size = 6 //Specify the number of WEKA backends to be deployed for the WEKA cluster.
allow_ssh_cidrs = ["0.0.0.0/0"] //Since this is a public network deployment, where the WEKA cluster will be accessible from the internet, specify the WAN address range that can access the WEKA cluster via SSH. 
allow_weka_api_cidrs = ["0.0.0.0/0"] //Since this is a public network deployment, where the WEKA cluster will be accessible from the internet, specify the WAN address range that can access the WEKA cluster API.
clients_number = 2 //Number of WEKA clients to be deployed and mounted to the cluster automatically.
client_instance_type = "Standard_D4_v4" //Specifies the instance type to be used for WEKA clients being deployed automatically.

//The final entry instructs Terraform to output useful information about the WEKA cluster which will help with connecting to and verifying proper function of the WEKA cluster.

output "get-cluster-helpers-commands" {
	value = module.weka_deployment
}
```

Review the variables available for use on the [**Terraform Registry page for the Azure Weka / Weka module**](https://registry.terraform.io/modules/weka/weka/azure/latest) to determine the variables required for your specific deployment needs. Once the `main.tf` file is configured for the deployment, proceed to initializing and running Terraform to deploy WEKA resourcesRunning Terraform init, plan, and apply to Deploy WEKA Cluster Resources

Open a terminal window on your local machine (or on whichever machine Terraform will be run from) and navigate to the directory containing the newly edited `main.tf` file. Once in the directory, execute the `terraform init` command. As shown below, the WEKA Azure Terraform Advanced modules will download followed by the necessary provider plugins.

<figure><img src="../../.gitbook/assets/image (102).png" alt=""><figcaption></figcaption></figure>

Once Terraform is successfully initialized, proceed to running `terraform plan` . As with Terraform Essentials, covered earlier in this guide, `terraform plan` performs a dry run of the deployment to detect any configuration issues. That said, it cannot account for certain circumstances which can only be validated during an `apply` , such as whether or not there is sufficient quota for the instance type selected, or if there’s a naming conflict with the Azure KeyVault. If no errors appear after `terraform plan` successfully runs as shown below, it can be reasonably assumed that a `terraform apply` will succeed.

<figure><img src="../../.gitbook/assets/image (103).png" alt=""><figcaption></figcaption></figure>

After a successful `terraform plan` , proceed to executing a `terraform apply` as shown below. If the `apply` completes successfully, an output similar to below will be shown. Also note the `get-cluster-helpers-commands` output.

<figure><img src="../../.gitbook/assets/image (104).png" alt=""><figcaption></figcaption></figure>

#### Using the Outputted Cluster Helper Commands

Using the outputted helper commands is straightforward and is done using the terminal and a web browser. The function app, created as part of the deployment, facilitates processing the commands, obtaining the information, and returning it to the user.

To begin, clusterization status will be retrieved. Under the “Get Clusterization Status” heading, copy the first line of code, enter it at the terminal prompt and execute as shown below. No output will result after command execution - this is expected behavior and not an error.

<figure><img src="../../.gitbook/assets/image (105).png" alt=""><figcaption></figcaption></figure>

Paste the command at the terminal prompt. Note the command executed and no output was returned.

<figure><img src="../../.gitbook/assets/image (106).png" alt=""><figcaption></figcaption></figure>

Next, copy the line of code immediately following the first line of code under the “Get Clusterization Status” header, paste it at the terminal prompt, and execute.

<figure><img src="../../.gitbook/assets/image (107).png" alt=""><figcaption></figcaption></figure>

Paste at the terminal prompt and execute. This time, an error will be returned followed by a URL. This is expected behavior - the curl command is intended to fail and return only the URL to be used for checking clusterization status by copying and pasting into a web browser.

<figure><img src="../../.gitbook/assets/image (108).png" alt=""><figcaption></figcaption></figure>

Copy the outputted URL and paste it into the address bar of a web browser. The URL will return the clusterization status of the newly deployed WEKA cluster as shown below. Review the returned data to determine if the cluster has been deployed correctly as anticipated.

<figure><img src="../../.gitbook/assets/image (109).png" alt=""><figcaption></figcaption></figure>

Checking cluster status follows the same process, and will return the same information as “Get Clusterization Status” once the clusterization has completed.

Next, the WEKA cluster password will be fetched. Prior to running the helper command, jq must be installed on the machine running the commands. jq is a lightweight and flexible command-line JSON processor. It is widely used in programming and system administration for parsing and manipulating JSON. To install jq on a Mac, Brew can be used. Simply run `brew install jq` to install jq.

<figure><img src="../../.gitbook/assets/image (110).png" alt=""><figcaption></figcaption></figure>

The process of installing jq will begin. Installation will be complete once a command prompt is returned.

<figure><img src="../../.gitbook/assets/image (111).png" alt=""><figcaption></figcaption></figure>

With jq installed, the WEKA cluster password can now be successfully fetched. Under the helper heading “Fetch Weka Cluster Password” copy the function command, paste it at the terminal prompt, and execute.

<figure><img src="../../.gitbook/assets/image (112).png" alt=""><figcaption></figcaption></figure>

Paste at the terminal prompt and execute. The WEKA cluster password will be returned.

<figure><img src="../../.gitbook/assets/image (113).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Before accessing the WEKA web interface, the WEKA backend IP addresses must be retrieved. Since the deployment used in this guide was deployed as a \`public\_network\` deployment, and public endpoints were assigned to each WEKA backend instance, the IP addresses retrieved will be WAN IP addresses. Had the cluster been deployed as a \`private\_network\` , LAN IP addresses would be returned.
{% endhint %}

To obtain the WEKA cluster backend IP addresses, the helper command to list the IP addresses of the VMSS (virtual machine scale set) containing the WEKA backend instances will be used. Copy the command and paste it at the terminal prompt as shown below.

<figure><img src="../../.gitbook/assets/image (114).png" alt=""><figcaption></figcaption></figure>

Paste the command at the prompt and execute to return the public IP addresses.

<figure><img src="../../.gitbook/assets/image (115).png" alt=""><figcaption></figcaption></figure>

Once the IP addresses have been retrieved, they can be used to access the WEKA web interface using a web browser. Select one of the returned WEKA cluster backend IP addresses, paste it into the address bar of a web browser, append port 14000, and execute. The WEKA web interface will appear.

<figure><img src="../../.gitbook/assets/image (116).png" alt=""><figcaption></figcaption></figure>

Login using the default user `admin` and the password retrieved using the function app command in an earlier step.
