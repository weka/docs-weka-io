---
description: This page describes the various ways to manage Weka system.
---

# Managing the Weka System

The Weka system is now installed. Now let's learn how to view, manage and operate it using either the [CLI](managing-wekaio-system.md#cli) or the [GUI](managing-wekaio-system.md#gui), and [perform the first IO](performing-the-first-io.md) to a WekaFS filesystem.

## CLI

The Weka CLI is installed on each Weka host and is available through the `weka` command. It's possible to`ssh` one of the hosts and run the `weka` command. This displays a list of all available top-level commands. You can go ahead and explore them.

```
$ weka
Usage:
    weka [--help] [--build] [--version] [--legal]

Description:
    The base command for all weka related CLIs

Subcommands:
   agent      Command s that control the weka agent (outside the weka containers)
   alerts     List alerts in the Weka cluster
   cloud      Cloud commands. List the cluster's cloud status, if no subcommand supplied.
   cluster    Commands that manage the cluster
   debug      Commands used to debug a weka cluster
   diags      Diagnostics commands to help understand the status of the cluster and its environment
   events     List all events that conform to the filter criteria
   fs         List filesystems defined in this Weka cluster
   local      Commands that control weka and its containers on the local machine
   mount      Mounts a wekafs filesystem. This is the helper utility installed at /sbin/mount.wekafs.
   nfs        Commands that manage client-groups, permissions and interface-groups
   org        List organizations defined in the Weka cluster
   security   Security commands.
   smb        Commands that manage Weka's SMB container
   stats      List all statistics that conform to the filter criteria
   status     Get an overall status of the Weka cluster
   umount     Unmounts wekafs filesystems. This is the helper utility installed at /sbin/umount.wekafs.
   user       List users defined in the Weka cluster
   version    When run without arguments, lists the versions available on this machine. Subcommands allow for
              downloading of versions, setting the current version and other actions to manage versions.

Options:
   --agent         Start the agent service
   -h, --help      Show help message
   --build         Prints the CLI build number and exits
   -v, --version   Prints the CLI version and exits
   --legal         Prints software license information and exits
```

For more information about the CLI, refer to [Getting Started with Weka CLI](cli-overview.md).

## GUI

The Weka GUI is accessible at port 14000. It can be accessed from any host or by using the cluster name. For example: `https://weka01:14000` or `https://WekaProd:14000`.

{% hint style="info" %}
**Note:** If it's not possible to access the GUI, make sure that it has been opened in your firewall, as described on the [Prerequisites](../support/prerequisites-and-compatibility.md) page.
{% endhint %}

![Weka Login Page](../.gitbook/assets/wekaio-login-page.png)

The initial default username/password is _admin/admin,_ as described in [User Management.](../usage/security/user-management.md) It is enforced to change the admin password upon the first login.

For more information about the GUI, refer to [Getting Started with Weka GUI](gui.md).

{% hint style="info" %}
**Note:** It is possible to set up external monitoring via Grafana. For more information, refer to [External Monitoring](../appendix/external-monitoring.md).
{% endhint %}

## REST API

The Weka system supports a RESTful API. This is useful when automating the interaction with the Weka system and when integrating it into your workflows or monitoring systems.

The API is accessible at port 14000, via the `/api/v2` URL, you can explore it via `/api/v2/docs` when accessing from the cluster (e.g. `https://weka01:14000/api/v2/docs`).

&#x20;Our static API documentation can be accessed from [api.docs.weka.io](https://api.docs.weka.io) (the version of the `.json` file can be changed to reflect the desired version, e.g., _**3.11.**json_). This file can also be used to create your client code, using an OpenAPI client generator.

### Obtaining an Access Token

You must provide an access token to use the Weka REST API.&#x20;

To obtain access/refresh tokens via the CLI, refer to [Obtaining an Authentication Token](../usage/security/#obtaining-an-authentication-token) section (there you can also generate an access token with a longer expiry time). To obtain access/refresh tokens via the API, you can call the `login` API, providing it a `username` and `password`.&#x20;

If you already obtained a refresh token, you can use the `login/refresh` API to refresh the access token.

{% tabs %}
{% tab title="Login" %}
{% code title="Python example calling the login API" %}
```python
import requests

url = "https://weka01:14000/api/v2/login"

payload="{\n    \"username\": \"admin\",\n    \"password\": \"admin\"\n}"
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)

```
{% endcode %}
{% endtab %}

{% tab title="Refresh" %}
{% code title="Python example calling the login refresh API" %}
```python
import requests

url = "https://weka01:14000/api/v2/login/refresh"

payload="{\n    \"refresh_token\": \"REPLACE-WITH-REFRESH-TOKEN\"\n}"
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)

```
{% endcode %}
{% endtab %}
{% endtabs %}

In response, you will get an access token (valid for 5 minutes), that can be used in the other APIs that require token authentication, along with the refresh token (valid for 1 year), for getting additional access tokens without using the username/password.

{% code title="Login/Refresh Response" %}
```python
{
  "data": [
    {
      "access_token": "ACCESS-TOKEN",
      "token_type": "Bearer",
      "expires_in": 300,
      "refresh_token": "REFRESH-TOKEN"
    }
  ]
}
```
{% endcode %}

### Calling the REST API

Now, that you have obtained an access token, you can call Weka REST API commands with it. For example, you can query the cluster status:

{% code title="Python example calling cluster status API" %}
```python
import requests

url = "https://weka01:14000/api/v2/cluster"

payload={}
headers = {
  'Authorization': 'Bearer REPLACE-WITH-ACCESS-TOKEN'
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

```
{% endcode %}

