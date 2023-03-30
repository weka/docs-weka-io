# Auto scale instances in GCP

Once the Terraform files are applied, two workflows are running every minute. One for scale-up and the other for scale-down.

WEKA provides a cloud function for scale-up or scale-down of the number of compute engine instances (cluster size). Terraform automatically creates the cluster according to the specified target value in a few minutes.

To change the cluster size (up or down), specify the link to the resize cloud function on GCP and the resize target value for the number of compute engine instances in the following command and run it:

```
curl -m 70 -X POST  https://<resize_cloud_funcltion_name> \
-H "Authorization:bearer $(gcloud auth print-identity-token)" \
-H "Content-Type:application/json" \
-d '{"value":<Resize_target_value>}'
```

Example:

```
curl -m 70 -X POST  https://europe-west1-wekaio-qa.cloudfunctions.net/weka-test \
-H "Authorization:bearer $(gcloud auth print-identity-token)" \
-H "Content-Type:application/json" \
-d '{"value":7}'
```

****

**Related topics**

[#resize-cloud-function-operation](weka-project-description.md#resize-cloud-function-operation "mention")
