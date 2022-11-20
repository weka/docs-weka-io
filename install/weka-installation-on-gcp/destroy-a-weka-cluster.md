# Destroy a Weka cluster

If the Weka cluster is no longer required on GCP, you need to prepare the Weka cluster for termination first and only then use the `terraform destroy` action.

The preparation for the Weka cluster for termination can also be used if you need to retain the GCP resources (to save time) and deploy a new Weka cluster. &#x20;

{% hint style="info" %}
If you need to preserve your data, create a snapshot using [snap-to-object](../../fs/snap-to-obj/).
{% endhint %}

To prepare the Weka cluster for termination, run the following command line (replace `Cluster_Name` with the actual cluster name):

```
curl -m 70 -X POST ${google_cloudfunctions_function.terminate_cluster_function.https_trigger_url} \
-H "Authorization:bearer $(gcloud auth print-identity-token)" \
-H "Content-Type:application/json" \
-d '{"name":"Cluster_Name"}'
```

Once the Weka cluster is prepared for termination, you can use the `terraform destroy` action or deploy a new Weka cluster.
