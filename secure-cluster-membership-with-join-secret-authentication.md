# Secure cluster membership with join secret authentication

To enhance security in multi-cluster environments, WEKA supports join secret authentication in on-premises deployments, which ensures that only authorized backends with the correct secret can join a cluster. This mechanism prevents accidental cross-cluster joins and unauthorized access, maintaining a secure and isolated cluster environment.

{% hint style="info" %}
Join secret authentication is not supported on cloud deployments.
{% endhint %}

## Enable join secret authentication

Join secret authentication is enabled during cluster creation by specifying a secret:

```
weka cluster add --join-secret <join-secret>
```

The `<join-secret>` acts as a shared credential required for all backend containers that need to join the cluster.

## Set join secret for existing clusters

If the cluster was initially created without a join secret, you can assign it post-deployment to each container using:

```
weka cluster container join-secret <container-id> <secret>
```

Replace `<container-id>` with the container’s identifier and with the desired join secret value.

## Add resources to a cluster with join secret

When expanding a cluster with join secret authentication enabled, the following commands must include the correct secret:

* Set up a new container:

```
weka local setup container --join-secret <join-secret>
```

* Join using local resources:

```
weka local resources join-secret <secret>
```

**Related topic**

[expansion-of-specific-resources.md](operation-guide/expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md "mention")
