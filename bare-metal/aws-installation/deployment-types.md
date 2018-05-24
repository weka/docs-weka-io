# Deployment Types

Deploying a WekaIO cluster in AWS requires at least 6 EC2 instances with SSD/NVMe drives \(a.k.a instance store\), and potentially additional instances that may connect as clients.

There may be two deployment types according to the instance types being used and how they’re configured:

### Client-Backend Deployment {#client-backend-deployment}

In a client-backend deployment, two different types of instances are being launched:

* **Backend instances**: these instances contribute their drives and all possible CPU and network resources.
* **Client instances**: these instances connect to the cluster created by the backend instances and run an application using one or more shared filesystems.

In this type of deployment, you can add or remove clients according to how many resources the application requires at any given moment.

Backend instances can be added to increase the cluster capacity or performance and can be removed as long as they’re deactivated to safely allow for data to be migrated out of them.

### Hyper-Converged Deployment {#hyper-converged-deployment}

A hyper-converged deployment is a more generic deployment in which every instance is configured to contribute resources of some kind to the cluster — whether it’s drives, CPUs and/or network interfaces.

You’d usually choose to deploy a hyper-converged cluster in cases such as:

* Very small applications that need a high-performance filesystem but don’t require many resources themselves, therefore they can use resources in the same instances storing the data.
* Cloud bursting an application to AWS, in which case you’d want to utilize as many resources as possible for your application but also provide as many resources as possible to the WekaIO cluster so to achieve maximum performance.

