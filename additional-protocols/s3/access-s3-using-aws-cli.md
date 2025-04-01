---
description: Learn how to configure and use the AWS CLI with WEKA's S3 storage.
---

# Access S3 using AWS CLI

To use the AWS CLI to access S3-compatible storage on WEKA, configure the CLI with the appropriate endpoint and credentials.

{% hint style="info" %}
* If you are using a self-signed SSL certificate or a WEKA backend IP address as your S3 endpoint, append `--no-verify-ssl` to any AWS CLI commands listed below.
* These examples assume you have a properly configured WEKA S3 protocol servers. For guidance on configuring the S3 protocol on your WEKA cluster, see [.](./ "mention").
{% endhint %}

## **Install and configure the AWS CLI**

1. **Verify AWS CLI is installed:**
   1. Verify that the AWS CLI is installed on your system. If required, see [**Install the AWS CLI**](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)**.**
2. **Configure AWS CLI with WEKA credentials:**
   1.  Use the following command to start configuration:

       ```bash
       aws configure
       ```
   2. Enter the following information when prompted:
      * **AWS Access Key ID**: Your WEKA S3 user access key.
      * **AWS Secret Access Key**: Your WEKA S3 user secret key.
      * **Default region name**: You can leave this blank.
      * **Default output format**: You can leave this blank.
3. **Enable AWS Signature Version 4 for WEKA server:**
   1.  WEKA requires AWS Signature Version 4 for authentication. Set it using:

       ```bash
       aws configure set default.s3.signature_version s3v4
       ```

## **AWS CLI usage**

When using AWS CLI commands with WEKA, specify the custom endpoint URL. The following are some common operations:

### **List buckets**

```bash
aws --endpoint-url https://your-weka-server:9000 s3 ls
```

Replace `https://your-weka-server:9000` with your WEKA server's actual address.

### **Create a bucket**

```bash
aws --endpoint-url https://your-weka-server:9000 s3 mb s3://mybucket
```

This command creates a new bucket named `mybucket`.

### **Upload a file**

```bash
aws --endpoint-url https://your-weka-server:9000 s3 cp local-file.txt s3://mybucket/
```

This command uploads `local-file.txt` to the `mybucket` bucket.

### **List bucket contents**

```bash
aws --endpoint-url https://your-weka-server:9000 s3 ls s3://mybucket
```

This command lists the contents of the `mybucket` bucket.

### **Download a file**

```bash
aws --endpoint-url https://your-weka-server:9000 s3 cp s3://mybucket/remote-file.txt ./
```

This command downloads `remote-file.txt` from the `mybucket` bucket to the current directory.

### **Delete a file**

```bash
aws --endpoint-url https://your-weka-server:9000 s3 rm s3://mybucket/file-to-delete.txt
```

This command deletes `file-to-delete.txt` from the `mybucket` bucket.

### **Remove a bucket**

If you attempt to remove a bucket that is not empty, you receive an error. You must either empty all object versions from the bucket or add `--force` to the remove bucket command. `--force` deletes the bucket and all object versions within it.

```bash
aws --endpoint-url https://your-weka-server:9000 s3 rb s3://mybucket
```

This command removes the `mybucket` bucket.
