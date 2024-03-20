# Launch an application using WEKA as the POD's storage

Once a storage class and a PVC are in place, you can configure the Kubernetes pods to provision volumes via the Weka system.

We'll take an example application that echos the current timestamp every 10 seconds and provide it with the previously created `pvc-wekafs-dir` PVC.

Note that multiple pods can share a volume produced by the same PVC as long as the `accessModes` parameter is set to `ReadWriteMany`.

{% code title="csi-wekafs/examples/dynamic/csi-app-on-dir.yaml" %}
```yaml
kind: Pod
apiVersion: v1
metadata:
  name: my-csi-app
spec:
  containers:
    - name: my-frontend
      image: busybox
      volumeMounts:
      - mountPath: "/data"
        name: my-csi-volume
      command: ["/bin/sh"]
      args: ["-c", "while true; do echo `date` >> /data/temp.txt; sleep 10;done"]
  volumes:
    - name: my-csi-volume
      persistentVolumeClaim:
        claimName: pvc-wekafs-dir # defined in pvc-wekafs-dir.yaml
```
{% endcode %}

Create the pod by applying manifest:

```yaml
$ kubectl apply -f csi-app-on-dir.yaml
pod/my-csi-app created
```

Kubernetes allocates a persistent volume and attach it to the pod, it uses a directory within the WEKA filesystem as defined in the storage class mentioned in the persistent volume claim. The pod is in `Running` status, and the `temp.txt` file is updated with occasional `date` information.

```
$ kubectl get pod my-csi-app
NAME                      READY   STATUS              RESTARTS   AGE
my-csi-app                1/1     Running             0          85s

# if we go to a wekafs mount of this filesystem we can see a directory has been created
$ ls -l /mnt/weka/podsFilesystem/csi-volumes
drwxr-x--- 1 root root 0 Jul 19 12:18 pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380-a1659c8a7ded3c3c05d6facffd69cbf79b95604c

# inside that directory, the temp.txt file from the running pod can be found
 $ cat /mnt/weka/podsFilesystem/csi-volumes/pvc-d00ba0fe-04a0-4916-8fea-ddbbc8f43380-a1659c8a7ded3c3c05d6facffd69cbf79b95604c/temp.txt
Sun Jul 19 12:50:25 IDT 2020
Sun Jul 19 12:50:35 IDT 2020
Sun Jul 19 12:50:45 IDT 2020
```
