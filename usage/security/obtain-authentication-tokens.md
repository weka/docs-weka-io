# Obtain authentication tokens

The authentication tokens include two types: an access token and a refresh token.

* **Access token:** The access token is a short-lived token (five minutes) used for accessing the WEKA system API and to allow the mounting of secure filesystems.
* **Refresh token:** The refresh token is a long-lived token for obtaining an additional access token.

**Procedure**

Do one of the following:

*   To obtain the refresh token and access token through the **CLI**, log in to the system using the command: `weka user login`.

    The system creates an authentication token file and saves it in `~/.weka/auth-token.json`. The token file contains both the access token and the refresh token.

![Auth-token file content example](../../.gitbook/assets/wmng\_auth\_token\_example.png)

* To obtain the refresh token and access token through the **REST API,** use the `POST /login`. The API returns the token in the response body.

![REST API login response example](../../.gitbook/assets/wmng\_auth\_token\_api\_example.png)

## Manage long-lived tokens for REST API usage

When working with the REST API, local users may use a long-lived token (a token that doesn't require a refresh every 5 minutes).

As a local user, you can generate a long-lived token using the GUI or the CLI.

### Generate a long-live access token using the GUI

**Procedure**

1. From the signed-in user menu, select **API Token**.
2. In the Manage API Token dialog, select Generate token and set the expiration time. Then, select **Generate**.

<figure><img src="../../.gitbook/assets/wmng_manage_api_token.png" alt=""><figcaption><p>Manage API Token</p></figcaption></figure>

{% hint style="info" %}
If you want to revoke all existing login tokens of the local user and refresh them, select **Revoke Tokens**.
{% endhint %}

3\. Copy the generated token and paste it to the REST API authorization dialog.

<figure><img src="../../.gitbook/assets/wmng_manage_api_token_generated.png" alt=""><figcaption><p>Generated token</p></figcaption></figure>

The following demonstrates how to generate the API token and authorize it in the REST API.

<figure><img src="../../.gitbook/assets/wmng_generate_token_example_animated.gif" alt=""><figcaption><p>Generate a long-lived token using the GUI example</p></figcaption></figure>

### Generate a long-lived access token using the CLI

**Command:** `weka user generate-token [--access-token-timeout timeout]`

The default timeout is 30 days.

To revoke the access and refresh tokens, use the CLI command: `weka user revoke-tokens`.

