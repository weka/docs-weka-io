# WEKA cluster auto-scaling in AWS

## Scale-out the WEKA cluster backend servers

Scale-out is the process of increasing the number of EC2 instances in the system to handle higher workloads or enhance redundancy.

Scale-out is essential to ensure a system can meet growing demands, maintain performance, and distribute workloads effectively. This proactive approach helps prevent overloads, reduce response times, and maintain high availability.

**Action**

* Increase the desired size of the Auto-Scaling Group (ASG) associated with your WEKA cluster using the AWS Console or AWS CLI.

**Result**

* AWS automatically launches the new EC2 instance.&#x20;
* AWS triggers the Lambda Function to create a `join` script that runs once as part of the instance user data and, subsequently, integrates the new EC2 instance into the existing WEKA cluster.

You can monitor the process in the AWS Step Function GUI.

## Scale-in the WEKA cluster backend servers

Scale-in is the process of reducing the number of EC2 instances of a system to align with decreased workloads or to optimize resource utilization.

Scale-in is essential for efficient resource management, cost reduction, and ensuring the appropriate allocation of resources. It helps prevent over-provisioning, lowers operational expenses, and safeguards against unintentional removal of EC2 instances from the existing WEKA cluster in AWS.

The cluster is configured with scale-in protection and instance termination protection to enhance the safety of this process.

**Action**

* Decrease the desired size of the Auto-Scaling Group (ASG) associated with your WEKA cluster. You can do this through the AWS Console, AWS CLI, or other compatible methods.

**Result**

* After modifying the desired size, it doesn't immediately impact the Auto Scaling Group (ASG). Instead, a Step Function continuously monitors the configuration.
* This Step Function runs every minute and identifies that the desired size is less than the current WEKA system's size.
* When this condition is met, it initiates a scale-in process, but only if certain conditions are met, such as having enough capacity on the filesystem.
* If the scale-down is successful, the Step Function subsequently removes the protection from the scaled-in instance, thereby allowing the Auto Scaling Group to proceed with removing it.
