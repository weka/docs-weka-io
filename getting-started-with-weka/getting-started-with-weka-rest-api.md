# Getting started with WEKA REST API

The WEKA system provides a RESTful API that allows you to automate operations and integrate them into your workflows or monitoring systems. A solid understanding of the relevant WEKA CLI commands and parameters is important when working with the REST API. For example, when creating a filesystem using the `POST /fileSystems` service, refer to the corresponding CLI documentation for guidance.

## Access the REST API

You can access the REST API using one of the following methods:

* **Direct access:** Use port 14000 and the URL `/api/v2`.
* **Through the cluster:** Browse to `https://<cluster name or IP>:14000/api/v2/docs`.
*   **Through the WEKA GUI:** Select the three dots on the upper right menu and select **REST API**.

    <figure><img src="../.gitbook/assets/wmng_access_rest_api.png" alt=""><figcaption><p>Access the REST API through the WEKA GUI</p></figcaption></figure>
* **WEKA static API:** Browse to [api.docs.weka.io](https://api.docs.weka.io/) and select the required REST API version from the definition selector. You can also generate client code by using the OpenAPI client generator with the corresponding .json definition file.

<figure><img src="../.gitbook/assets/4_4_static_api_docs.png" alt=""><figcaption><p>api.docs.weka.io</p></figcaption></figure>

## Explore the REST API through the GUI

<figure><img src="../.gitbook/assets/Get_started_with_REST_API.gif" alt=""><figcaption><p>Explore the REST API through the GUI</p></figcaption></figure>

## Obtain an access token

To use the WEKA REST API, provide an access or refresh token.

You can generate an access or refresh for the REST API usage through the CLI or the GUI.\
See [obtain-authentication-tokens.md](../security/obtain-authentication-tokens.md "mention").

You can also call the login API to obtain access or refresh tokens through the API, providing it with a `username` and `password`.&#x20;

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

The response includes the access token (valid for 5 minutes) to use in the other APIs requiring token authentication, along with the refresh token (valid for 1 year), for getting additional access tokens without using the username/password.

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

## Call the REST API

Once you obtain an access token, you can call WEKA REST API commands with it. For example, you can query the cluster status:

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
