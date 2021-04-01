# Auto Scaling Group

Auto-scaling is useful to easily scale the number of EC2 instances up or down at need.

After deploying the Weka cluster via CloudFormation, it is possible to create an auto-scaling group to ease the Weka cluster size management.

You can create an auto-scaling group for your cluster by running the [wekactl utility](https://github.com/weka/wekactl).

You can control the number of instances by either changing the desired capacity of instances from the AWS auto-scaling group console or defining your custom metrics and scaling policy in AWS. Once the desired capacity has changed, Weka will take care of safely scaling the instances.

{% hint style="info" %}
**Note:** When scaling the number of instance increase/decrease and along with that the cluster resources. Currently, the existing filesystems SSD size does not change.

 When downscaling, you should make sure the filesystems can fit into the lower capacity cluster or tiered to S3.

When upscaling, you have more SSD capacity for new filesystems, or, if required, you can manually increase the existing filesystems capacity.
{% endhint %}

For more information and documentation on the utility, refer to the [wekactl GitHub repository](https://github.com/weka/wekactl).

