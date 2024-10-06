# WEKA Cloud Deployment Manager Local (CDM Local) User Guide

## Overview

The WEKA Cloud Deployment Manager Local (CDM Local) offers a locally installed solution for deploying WEKA clusters in AWS, Azure, and GCP public cloud environments. Like CDM Web, it leverages WEKA’s validated Terraform deployment modules and provides a user-friendly interface to guide users through the configuration process. However, CDM Local adds new features tailored for users who prefer a local installation, including public cloud environment configuration polling and validation, which is not available in CDM Web.

Key features of CDM Local:

* **Locally installed solution**: CDM Local is packaged as a Go binary for download and can be run on a cloud instance in the customer’s public cloud environment.
* **Cross-platform compatibility**: CDM Local provides individually downloadable binaries for different platforms, including Darwin (Intel and Apple Silicon), Linux (Intel and ARM), and Windows (Intel).
* **Configuration polling and validation**: CDM Local includes a unique feature that automatically polls the public cloud environment to populate key variables like VPC and Subnet details. Additionally, it validates the cluster configuration to detect conflicts before deployment.
* **Manual Terraform deployment**: Like CDM Web, CDM Local generates a Terraform configuration file (`main.tf`) for manual application through Terraform on the user’s local machine or CDM Local system.

## CDM Local prerequisites

Before deploying CDM Local, ensure the following components are installed on the system:

* [Terraform](https://developer.hashicorp.com/terraform/install)
* [Go](https://go.dev/doc/install)
* The appropriate Cloud CLI or SDK for the target cloud environment:
  * [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  * [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

{% hint style="info" %}
Ensure that the Cloud CLI is configured and logged in using the same user account that is used to deploy the WEKA cluster. This ensures the necessary permissions are applied to the logged-in user.
{% endhint %}

## Download CDM Local

1. Go to [**get.weka.io**](http://get.weka.io) and select the **CDM** tab.

<figure><img src="../.gitbook/assets/1_cdm_local_get-weka-io.png" alt=""><figcaption></figcaption></figure>

2. CDM Local is available as a platform-specific binary. Choose the binary that matches your target host platform for installation:
   * **darwin** (for Mac):
     * Intel-based: cdm-darwin-amd64
     * Apple Silicon-based: cdm-darwin-arm64
   * **linux**:
     * Intel-based: cdm-linux-amd64
     * ARM-based: cdm-linux-arm64
   * **windows**:
     * Intel-based: cdm-windows-amd64

<figure><img src="../.gitbook/assets/2_cdm_local_get-weka-io.png" alt=""><figcaption></figcaption></figure>

## Launch CDM Local

CDM Local uses Terraform to finalize the deployment of WEKA cluster resources and execute post-installation scripts, similar to CDM Web. However, CDM Local is run locally through a binary and launched through a browser-based UI.

**Before you begin**

* Ensure you are authenticated to the relevant Cloud CLI (AWS, Azure, GCP) to grant the necessary permissions for the deployment.
* A valid [get.weka.io](http://get.weka.io) token is required to complete the deployment. Ensure you have this token available before proceeding.

**Procedure**

1. **Navigate to the CDM Local binary:** Open a terminal and navigate to the directory where the downloaded CDM Local binary is located.
2.  **Make the binary executable:** Change the file permissions to allow execution. Example on an Apple Silicon system:

    ```bash
    chmod +x cdm-darwin-arm64-v1.1.0
    ```
3.  **Run the CDM Local binary:** Launch CDM Local by executing the binary. Example on an Apple Silicon system:

    ```bash
    ./cdm-darwin-arm64-v1.1.0
    ```
4. **Access the CDM Local UI:** After running the binary, a browser window with the CDM Local interface opens automatically.

<figure><img src="../.gitbook/assets/3_cdm_local_login.png" alt=""><figcaption><p>CDM Local welcome</p></figcaption></figure>

4. **Select the public cloud for deployment:** Choose the cloud environment (AWS, Azure, GCP) for deploying your WEKA cluster. The CDM Local dashboard appears.

## CDM Local dashboard overview

The CDM Local dashboard provides a streamlined way to configure WEKA clusters, leveraging the power of Terraform modules with a graphical UI.

The CDM dashboard consists of three main sections:

* The workflow navigation panel (outlined in green)
* The configuration input panel (outlined in orange)
* The dynamic content sidebar (outlined in teal)

<figure><img src="../.gitbook/assets/5_cdm_local_interface.png" alt=""><figcaption><p>CDM Local dashboard overview</p></figcaption></figure>

### **Workflow navigation panel**

The workflow navigation panel provides convenient access to various WEKA cluster configuration variables. You can switch between different aspects of cluster configuration and adjust settings according to their deployment needs.

The tabs within the panel correspond to primary configurable aspects for a WEKA cluster:

* Basic Configuration
* Networking Configuration
* Security Configuration
* OBS: Optional object storage configuration
* NFS Protocol Gateways: Optional deployment of NFS protocol servers.
* SMB Protocol Gateways: Optional deployment of SMB protocol servers.
* Clients: Optional deployment of WEKA clients
* Advanced Configuration: Optional, granular cluster-level adjustments

To ensure completeness from a basic requirements perspective, specific fields within the configuration input panel are marked as mandatory based on the selected configuration options.

The workflow navigation panel visually indicates the completeness of the configuration. A green check or a red **x** appears next to each tab, helping users identify areas that require additional attention. For example, if both Basic Configuration and Security Configuration have fields that need attention, the panel reflects this.

You can navigate between different workflow pages and view associated configuration input panels by clicking the **Next** button or selecting the desired tab from the workflow navigation panel.

<figure><img src="../.gitbook/assets/7_workflow_navigation (1).png" alt="" width="563"><figcaption><p>Workflow navigation panel</p></figcaption></figure>

### **Configuration input panel**

The configuration input panel enables customizing input fields related to the WEKA cluster deployment. These fields correspond to variables in WEKA Terraform modules, which traditionally require manual formatting and entry into a `main.tf` file. With CDM, these variables are presented visually, streamlining the configuration process.

* You can tailor the input fields to match their needs and deployment objectives.
* Required fields are marked with a red asterisk.

The following example illustrates the Basic Configuration tab, where some required fields are populated, while others remain empty. Fields lacking input are highlighted in bright red, and the red outline disappears once the user provides the necessary information.

<figure><img src="../.gitbook/assets/8_configuration_input_panel.png" alt="" width="563"><figcaption><p>Configuration input panel: Basic Configuration tab showing required fields</p></figcaption></figure>

Certain fields within the configuration input panel require manual user input. Other fields, such as Instance Type, WEKA Version, and Region, are provided as selectable dropdown menus.

{% tabs %}
{% tab title="Instance Type" %}
<figure><img src="../.gitbook/assets/image (259).png" alt="" width="290"><figcaption><p>Instance Type</p></figcaption></figure>
{% endtab %}

{% tab title="Region" %}
<figure><img src="../.gitbook/assets/image (260).png" alt="" width="290"><figcaption><p>Region</p></figcaption></figure>
{% endtab %}

{% tab title="WEKA Version" %}
The WEKA software release dropdown menu is designed to auto-populate with the most recent Long-Term Support (LTS) version by default. You can select the previous software release by opening the dropdown menu and choosing from the list. The top two entries in the dropdown are always LTS releases, while the bottom two are innovation releases.

To enter a WEKA software release that is not listed in the dropdown, click directly in the WEKA Version input field and type the desired release. This feature is particularly useful when deploying a WEKA cluster with a customer-specific software release.

<figure><img src="../.gitbook/assets/image (261).png" alt="" width="290"><figcaption><p>WEKA Version</p></figcaption></figure>
{% endtab %}
{% endtabs %}

### **Dynamic content sidebar**

The dynamic content sidebar enhances user experience by displaying contextually relevant information during various activities within CDM. Its primary functions include:

#### Real-time configuration guidance

* **Purpose:** Assists users in understanding the role of specific variables or input fields in the configuration input panel.
* **Functionality:** Automatically displays pertinent information when an input field, such as the Terraform Module Release Version, is selected. This feature covers every input field for AWS, Azure, and GCP configurations.

<figure><img src="../.gitbook/assets/CDM_tf_version.png" alt=""><figcaption><p>Terraform Module Release Version</p></figcaption></figure>

#### Real-time file representation

* **Purpose:** Provides a preview of the file that will be generated for download once all configuration inputs are completed.
* **Functionality:** Next to the configuration guidance tab, a new tab labeled “tf file preview” showcases the file in real-time.

#### JSON and HCL format options for main.tf

* **Purpose:** Allows flexibility in file format based on deployment requirements.
* **Functionality:** Includes a toggle switch to change the main.tf file format between JSON and HCL.

#### Validation of the finalized terraform configuration file

* **Purpose:** The validation process ensures that the completed Terraform configuration is accurate and ready for local deployment. This step helps identify and resolve any issues before proceeding with the deployment.
* **Functionality:** Before copying or downloading the generated `main.tf` file, it is highly recommended to validate the configuration using the **VALIDATE WEKA CLUSTER** button. The CDM Local performs the following checks during validation:
  * **Permissions:** Ensures that the user has the necessary permissions to deploy and run the WEKA cluster.
  * **Subnet IP addresses:** Confirms that the specified subnet has enough available IP addresses to accommodate the WEKA resources to be deployed.
  * **Compute resource quota:** Verifies that the chosen machine type for WEKA components meets the required compute resource quotas for the deployment.

If any errors occur during the validation, a popup window appears with details about the encountered issues. Users can then correct these errors and revalidate the configuration before continuing. Once validation is successful, the file can be copied or downloaded for use in the deployment process.

<figure><img src="../.gitbook/assets/13_Validate_TF.png" alt=""><figcaption><p>Validation of the finalized terraform configuration file</p></figcaption></figure>

#### Download and copy the finalized terraform configuration file

* **Purpose:** Enables users to download or copy the completed configuration file for local use.
* **Functionality:** The **Download** and **Copy** buttons allow you to save the file locally or copy it, to manually execute the relevant Terraform `plan`, and `apply` commands for WEKA cluster deployment.

<figure><img src="../.gitbook/assets/14_Download_TF.png" alt=""><figcaption><p>Download and copy the finalized terraform configuration file</p></figcaption></figure>

{% hint style="success" %}
All tabs in the workflow navigation panel display green status bubbles with check marks, indicating the configuration is complete and ready for a minimally viable WEKA deployment based on the user's selected parameters. Once all status bubbles are green, the dynamic content sidebar only shows the **TF File Preview** tab, **File Format** toggle, and **Download** button.
{% endhint %}

### Finalize the WEKA deployment

Once you download the CDM-generated Terraform file, manually execute the relevant Terraform commands to deploy their generated WEKA cluster configuration into the cloud of choice.

This means that Terraform, all its dependencies, relevant public cloud CLIs, and SDKs must exist, and the login uses an adequately privileged account before applying the Terraform file.

**Related topics**

[deployment-on-aws-using-terraform.md](aws/weka-installation-on-aws-using-terraform/deployment-on-aws-using-terraform.md "mention")

[deployment-on-azure-using-terraform.md](weka-installation-on-azure/deployment-on-azure-using-terraform.md "mention")

[deployment-on-gcp-using-terraform.md](weka-installation-on-gcp/deployment-on-gcp-using-terraform.md "mention")
