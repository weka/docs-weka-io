# Getting started with WEKA REST API



The WEKA system supports a RESTful API. This is useful when automating the interaction with the WEKA system and integrating it into your workflows or monitoring systems.

The API is accessible at port 14000, via the `/api/v2` URL, you can explore it via `/api/v2/docs` when accessing from the cluster (e.g. `https://weka01:14000/api/v2/docs`).

THE WEKA static API documentation can be accessed from [api.docs.weka.io](https://api.docs.weka.io) (the version can be selected from the drop-down list). The `.json` file can also create client code using an OpenAPI client generator.

### Obtain an access token

You must provide an access token to use the WEKA REST API.&#x20;

To obtain access/refresh tokens via the CLI, refer to [Obtaining an Authentication Token](../usage/security/#obtaining-an-authentication-token) section (you can also generate an access token with a longer expiry time).

You can call the login API to obtain access/refresh tokens via the API, providing it with a `username` and `password`.&#x20;

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

### Call the REST API

Now, that you have obtained an access token, you can call WEKA REST API commands with it. For example, you can query the cluster status:

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

**Related topics**

[REST API Reference Guide](https://api.docs.weka.io/)
