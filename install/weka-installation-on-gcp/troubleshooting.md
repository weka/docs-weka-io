# Troubleshooting

The GCP Console has a [Logs Explorer](https://cloud.google.com/logging/docs/view/logs-explorer-interface) interface in which you can view the cloud function logs related to the Weka cluster activities, such as when scaling instances up or down. In addition, the cluster state file retained in the cloud storage provides you with the status of the operations in the weka project.

**Typical troubleshooting flow if the resize cloud function does not resize the cluster**

1. Open the cluster state file and check that a trigger to resize the cluster was received. The cluster state file is in the cloud storage, and its name comprises the `prefix` and `cluster_name` provided in the [terraform variables file](weka-project-description.md#tf.tfvars-example-public-vpc).
2. Check the workload for scale-up or scale-down if the trigger does not show in the cluster state file. Check which function didn't work and its related logs in the Logs Explorer of the GCP Console.
