# Troubleshooting

The GCP Console has a [Logs Explorer](https://cloud.google.com/logging/docs/view/logs-explorer-interface) interface in which you can view the cloud function logs related to the WEKA cluster activities, such as when scaling instances up or down. In addition, the cluster state file retained in the cloud storage provides you with the status of the operations in the WEKA project.

**Typical troubleshooting flow if the resize cloud function does not resize the cluster**

1. Open the cluster state file and check that the `desired_size` is as expected and the `clusterized` value is `true`. The cluster state file is in the cloud storage, and its name comprises the `prefix` and `cluster_name` provided in the [terraform variables file](weka-project-description.md#tf.tfvars-example-public-vpc).
2. Check the scale-up workflow (or scale-down workflow). Check the function that didn't work and its related logs in the Logs Explorer of the GCP Console.
