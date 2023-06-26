# Add SELinux support

Security-Enhanced Linux (SELinux) is a Linux kernel security module that provides a mechanism for supporting access control security policies, including mandatory access controls (MAC).

To add SELinux support, perform the following procedures:

1. [Install a custom SELinux policy](add-selinux-support.md#install-a-custom-selink-p).
2. [Install and configure the WEKA CSI Plugin](add-selinux-support.md#install-config-csi-plugin).
3. [Test the WEKA CSI Plugin operation](add-selinux-support.md#test-csi-plugin).

### Install a custom SELinux policy <a href="#install-a-custom-selink-p" id="install-a-custom-selink-p"></a>

1. Distribute the SELinux policy package to all Kubernetes nodes using one of the following options:
   *   Clone WEKA CSI Plugin Github repository:

       ```
       git clone https://github.com/weka/csi-wekafs.git
       ```
   * Copy the content of the `selinux` directory directly to Kubernetes nodes
2.  Apply the policy package directly:

    ```
    $ semodule -i csi-wekafs.pp
    ```

    Verify that the policy is applied correctly:

    ```
    $ getsebool -a | grep wekafs
    container_use_wekafs --> off
    ```

    If the output matches mentioned above, skip to step 4. Otherwise, proceed to step 3 to build the policy from the sources.
3.  In certain circumstances, the pre-compiled policy installation could fail. For example, in a different Kernel version or Linux distribution. In this case, build the policy and install it from the source using the following steps:

    ```
    $ checkmodule -M -m -o csi-wekafs.mod csi-wekafs.te
    $ semodule_package -o csi-wekafs.pp -m csi-wekafs.mod
    $ make -f /usr/share/selinux/devel/Makefile csi-wekafs.pp
    $ semodule -i csi-wekafs.pp
    ```

    For this purpose, the `policycoreutils-devel` package (or its alternative in case of Linux distribution different from the RedHat family) is required.

    Verify that the policy is applied correctly:

    ```
    $ getsebool -a | grep wekafs
    container_use_wekafs --> off
    ```
4.  The policy provides a boolean setting that allows on-demand enablement of relevant permissions. To enable WekaFS CSI volumes access from pods, run the command:

    ```
    $ setsebool container_use_wekafs=on
    ```

    To disable access, perform the command:

    ```
    $ setsebool container_use_wekafs=off
    ```

    The configuration changes are applied immediately.

### Install and configure the WEKA CSI Plugin <a href="#install-config-csi-plugin" id="install-config-csi-plugin"></a>

1. To label volumes correctly, install the WEKA CSI Plugin in an SELinux-compatible mode. To do that, set the `selinuxSupport` value to `"enforced"` or `"mixed”` by editing the file `values.yaml` or passing the parameter directly in the `helm` installation command.

Example:

```
$ helm install --upgrade csi-wekafsplugin csi-wekafs/csi-wekafsplugin --namespace csi-wekafsplugin --create-namespace --set selinuxSupport=enforced
```

Follow these considerations:

* WEKA CSI Plugin supports both the `enforced` and `mixed` modes of `selinuxSupport`. The installation depends on the following mode settings:
  * When `selinuxSupport` is set to `enforced`, only SELinux-enabled CSI plugin node components are installed.
  * When `selinuxSupport` is set to `mixed`, both non-SELinux and SELinux-enabled components are installed.
  * When `selinuxSupport` is set to `off`, only non-SELinux CSI plugin node components are installed.
*   The SELinux status cannot be known from within the CSI plugin pod. Therefore, a way of distinguishing between SELinux-enabled and non-SELinux nodes is required. WEKA CSI Plugin relies on the node affinity mechanism by matching the value of a certain node label, in a mutually exclusive way. That is, only when the label exists and is set to `"true"`, an SELinux-enabled node component will start on that node, otherwise non-SELinux node component will start.

    To ensure that the plugin starts in compatibility mode, set the following label on each SELinux-enabled Kubernetes node:&#x20;
* If a node label is modified after installing the WEKA CSI Plugin node component on that node, terminate the csi-wekafs-node-XXXX component on the affected node. As a result, a replacement pod is automatically scheduled on the node but with the correct SELinux configuration.

```
csi.weka.io/selinux_enabled="true"
```

*   If another label stating SELinux support is already maintained on nodes, you can modify the expected label name in the `selinuxNodeLabel` parameter by editing the file `values.yaml` or by setting it directly during the WEKA CSI Plugin installation.

    Example:

```
$ helm install --upgrade csi-wekafsplugin csi-wekafs/csi-wekafsplugin --namespace csi-wekafsplugin --create-namespace --set selinuxSupport=mixed --set selinuxNodeLabel="selinux_enabled"
```

* If a node lab

### Test the WEKA CSI plugin operation <a href="#test-csi-plugin" id="test-csi-plugin"></a>

1. Make sure you have configured a valid CSI API [`secret`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api/csi-wekafs-api-secret.yaml). Create a valid WEKA CSI Plugin [`storageClass`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api).
2. Provision a [`PersistentVolumeClaim`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api/pvc-wekafs-dir-api.yaml).
3. Provision a [`DaemonSet`](https://github.com/weka/csi-wekafs/blob/master/examples/dynamic\_api/csi-daemonset.app-on-dir-api.yaml), to enable access of all pods on all nodes.
4.  Monitor the pod logs using the following command (expect no printing in the log files):

    ```
    $ kubectl logs -f -lapp=csi-daemonset-app-on-dir-api
    ```

    If the command returns a repeating message like the following one, it is most likely that the node on which the relevant pod is running is misconfigured:

    ```
    /bin/sh: can't create /data/csi-wekafs-test-api-gldmk.txt: Permission denied
    ```
5.  Obtain the node name from the pod:

    ```
    $ kubectl get pod csi-wekafs-test-api-gldmk -o wide
    NAME                        READY   STATUS    RESTARTS   AGE   IP            NODE         NOMINATED NODE   READINESS GATES
    csi-wekafs-test-api-gldmk   1/1     Running   0          98m   10.244.15.2   don-kube-8   <none>           <none>
    ```
6.  Connect to the relevant node and check if the WEKA CSI SELinux policy is installed and enabled:

    ```
    $ getsebool -a | grep wekafs
    container_use_wekafs --> on
    ```

    * If the result matches the example, proceed to the next step.
    * If no result, the policy is not installed. Perform the [Install a custom SELinux policy](add-selinux-support.md#install-a-custom-selinux-policy) procedure.
    *   If the policy is off, enable it and check the pod output again by running:

        ```
        $ setsebool container_use_wekafs=on
        ```
7.  Check if the node is labeled with plugin is operating in SELinux-compatible mode by running the following command:

    ```
    $ kubectl describe node don-kube-8 | grep csi.weka.io/selinux_enabled
                 csi.weka.io/selinux_enabled=true
    ```

    *   If the output is empty, [Install and configure the Weka CSI Plugin](add-selinux-support.md#install-and-configure-the-weka-csi-plugin).



        If the label was missing and added by you during troubleshooting, the CSI node server component must be restarted on the node.\
        Perform the following command to terminate the relevant pod, and another instance will start automatically:

{% code fullWidth="false" %}
```
$ POD=$(kubectl get pod -n csi-wekafs -lcomponent=csi-wekafs-node -o wide | grep -w don-kube-8 | cut -d" " -f1)
$ kubectl delete pod -n csi-wekafs $POD
```
{% endcode %}

8. Collect CSI node server logs from the matching Kubernetes nodes and contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

```
$ POD=$(kubectl get pod -n csi-wekafs -lcomponent=csi-wekafs-node -o wide | grep -w don-kube-8 | cut -d" " -f1)
$ kubectl logs -n csi-wekafs -c wekafs $POD > log.txt  
```