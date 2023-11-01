# Required services and supported regions

The region must support the services used in WEKA on GCP. The following sections list these services and the regions that support them.

## Required services used in WEKA on GCP

* Cloud Build API
* Cloud Deployment Manager V2 API
* Cloud DNS API
* Cloud Functions API
* Cloud Logging API
* Cloud Resource Manager API
* Cloud Scheduler API
* Compute Engine API
* Secret Manager API
* Serverless VPC Access API
* Service Usage API
* Workflow Executions API
* Workflows API

Other services used or enabled:

* App Engine
* IAM
* Google Cloud Storage

## Supported regions

To ensure support for a specific region, it must meet the requirements listed [above](required-services-and-supported-regions.md#required-services-used-in-weka-on-gcp).

{% hint style="info" %}
If the region you're interested in is not on the supported list, verify the availability of these services in that region. If they are available and your region is not listed, contact the WEKA [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) for validation.
{% endhint %}

### Americas

| Region Name             | Region Description            |
| ----------------------- | ----------------------------- |
| northamerica-northeast1 | Montréal, Canada              |
| southamerica-east1      | São Paulo, Brazil             |
| southamerica-west1      | Santiago, Chile               |
| us-central1             | Iowa, United States           |
| us-east1                | South Carolina, United States |
| us-east4                | Virginia, United States       |
| us-east5                | Columbus, United States       |
| us-west1                | Oregon, United States         |
| us-west2                | Los Angeles, United States    |
| us-west4                | Las Vegas, United States      |

### Asia Pacific

| Region name          | Region Description       |
| -------------------- | ------------------------ |
| asia-east1           | Changhua County, Taiwan  |
| asia-east2           | Hong Kong                |
| asia-northeast1      | Tokyo, Japan             |
| asia-northeast2      | Osaka, Japan             |
| asia-northeast3      | Seoul, South Korea       |
| asia-south1          | Mumbai, India            |
| asia-south2          | Delhi, India             |
| asia-southeast1      | Jurong West, Singapore   |
| australia-southeast1 | Sydney, Australia        |

### Europe

| Region Name   | Region Description     |
| ------------- | ---------------------- |
| europe-north1 | Hamina, Finland        |
| europe-west1  | St. Ghislain, Belgium  |
| europe-west2  | London, England        |
| europe-west3  | Frankfurt, Germany     |
| europe-west4  | Eemshaven, Netherlands |
| europe-west6  | Zurich, Switzerland    |

**Related information**

[Regions and zones](https://cloud.google.com/compute/docs/regions-zones)

[Cloud locations](https://cloud.google.com/about/locations)
