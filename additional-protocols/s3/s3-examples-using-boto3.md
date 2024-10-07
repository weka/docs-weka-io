---
description: This page provides some examples of using the S3 API.
---

# S3 examples using boto3

## Boto3

[Boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html), the official AWS SDK for Python, is used to create, configure, and manage AWS services.

The following are examples of defining a resource/client in boto3 for the WEKA S3 service, managing credentials and pre-signed URLs, generating secure temporary tokens, and using those to run S3 API calls.

### Installation

`pip install boto3`

## Credentials

There are many ways to set credentials in boto3, as described on the [boto3 credentials](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/credentials.html) page. Specifically, look into the [Assume Role Provider](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/credentials.html#assume-role-provider) method, which uses the access/secret keys to automatically generate and use the temporary security token.

## Resource

Resources represent an object-oriented interface to Amazon Web Services (AWS). They provide a higher-level abstraction than service clients' raw, low-level calls. To use resources, invoke the [resource()](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/core/session.html#boto3.session.Session.resource) method of a [Session](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/core/session.html#boto3.session.Session) and pass in a service name.

```python
s3 = boto3.resource('s3',
                    endpoint_url='https://weka:9000',
                    aws_access_key_id='s3_key',
                    aws_secret_access_key='s3_secret')

```

## Client

[Clients](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/clients.html) provide a low-level interface to AWS, whose methods map close to 1:1 with service APIs. All service operations are supported by clients (in our case, `s3` and `sts`).

```python
s3_client = boto3.client('sts',
                         endpoint_url='https://weka:9000',
                         aws_access_key_id='s3_key',
                         aws_secret_access_key='s3_secret',
                         region_name='us-east-1'))
```

## Assume role example

Example code of using an access/secret key to obtain a temporary security token for the S3 service:

```python
#!/usr/bin/env/python
import boto3
import logging
from botocore.exceptions import ClientError
from botocore.client import Config

config = Config(
   signature_version = 's3v4'
)

s3_client = boto3.client('sts',
        endpoint_url='https://weka:9000',
        aws_access_key_id='s3_key',
        aws_secret_access_key='s3_secret',
        config=config,
        region_name='us-east-1')

try:

  response = s3_client.assume_role(
      RoleArn='arn:x:ignored:by:weka-s3:',
      RoleSessionName='ignored-by-weka-s3',
      DurationSeconds=900
  )

except ClientError as e:
    logging.error(e)

print 'AccessKeyId:' + response['Credentials']['AccessKeyId']
print 'SecretAccessKey:' + response['Credentials']['SecretAccessKey']
print 'SessionToken:' + response['Credentials']['SessionToken']
```

## Pre-signed URL example

Example of signing on a GET request for `myobject`  within `mybucket` for anonymous access:

```python
#!/usr/bin/env/python
import boto3
import logging
from botocore.exceptions import ClientError
from botocore.client import Config

config = Config(
   signature_version = 's3v4'
)

s3_client = boto3.client('s3',
                         endpoint_url='https://weka:9000',
                         aws_access_key_id='s3_key',
                         aws_secret_access_key='s3_secret',
                         config=config,
                         region_name='us-east-1')

try:
    response = s3_client.generate_presigned_url('get_object',
                                                Params={'Bucket': 'mybucket',
                                                        'Key': 'myobject'},
                                                ExpiresIn=3600)
except ClientError as e:
    logging.error(e)

# The response contains the pre-signed URL
print response
```

Use the response to access the object without providing any credentials:

```python
$ curl "http://weka:9000/mybucket/myobject?AWSAccessKeyId=s3_key&Expires=1624801707&Signature=4QBcfEUsUdR7Jaffg6gLRVpNTY0%3D"
myobject content
```

## Pre-signed URL with assume role example

Combine the above two examples by providing a pre-signed URL from a temporary security token:

```python
#!/usr/bin/env/python
import boto3
import logging
from botocore.exceptions import ClientError
from botocore.client import Config

config = Config(
   signature_version = 's3v4'
)

s3_client = boto3.client('s3',
                         endpoint_url='https://weka:9000',
                         aws_access_key_id='access_key',
                         aws_secret_access_key='secret_key',
	                       aws_session_token='session_token',
	                       config=config,
                         region_name='us-east-1')
try:
    response = s3_client.generate_presigned_url('get_object',
                                                Params={'Bucket': 'mybucket',
                                                        'Key': 'myobject'},
                                                ExpiresIn=3600)
except ClientError as e:
    logging.error(e)

# The response contains the pre-signed URL
print response

```

## Upload/Download example

An example of using the boto3 resource to upload and download an object:

```python
#!/usr/bin/env/python
import boto3
import logging
from botocore.exceptions import ClientError
from botocore.client import Config

config = Config(
   signature_version = 's3v4'
)

s3 = boto3.resource('s3',
                    endpoint_url='https://weka:9000',
                    aws_access_key_id='s3_key',
                    aws_secret_access_key='s3_secret',
                    config=config)

try:
  # upload a file from local file system 'myfile' to bucket 'mybucket' with 'my_uploaded_object' as the object name.
  s3.Bucket('mybucket').upload_file('myfile','my_uploaded_object')

  # download the object 'myfile' from the bucket 'mybucket' and save it to local FS as /tmp/classical.mp3
  s3.Bucket('mybucket').download_file('my_uploaded_object', 'my_downloaded_object')

except ClientError as e:
        logging.error(e)

print ("Downloaded 'my_downloaded_object' as 'my_uploaded_object'. a")

```

## Create bucket example

An example of creating a bucket `newbucket` with a boto3 client:

```python
#!/usr/bin/env/python
import boto3
import logging
from botocore.exceptions import ClientError
from botocore.client import Config

config = Config(
   signature_version = 's3v4'
)

s3_client = boto3.client('s3',
                         endpoint_url='https://weka:9000',
                         aws_access_key_id='s3_key',
                         aws_secret_access_key='s3_secret',
                         config=config)


try:
  s3_client.create_bucket(Bucket='newbucket')
except ClientError as e:
        logging.error(e)

```
