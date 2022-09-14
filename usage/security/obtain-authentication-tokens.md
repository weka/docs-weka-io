# Obtain authentication tokens

The authentication tokens include two types: an access token and a refresh token.

* **Access token:** The access token is a short-live token (five minutes) used for accessing the Weka system API and to allow the mounting of secure filesystems.
* **Refresh token:** The refresh token is a long-live token (one year) used for obtaining an additional access token.

**Procedure**

Do one of the following:

*   To obtain the refresh token and access token, **through the CLI**, log in to the system using the command: `weka user login`.

    The system creates an authentication token file and saves it in: `~/.weka/auth-token.json`. The token file contains both the access token and refresh token.

![Auth-token file content example](../../.gitbook/assets/wmng\_auth\_token\_example.png)

* To obtain the refresh token and access token, **through the REST API,** use the `POST /login`. The API returns the token in the response body.

![REST API login response example](../../.gitbook/assets/wmng\_auth\_token\_api\_example.png)

### Generate an access token for API usage (for internal users only)

When working with the REST API, internal Weka users may require using a longer-lived access token (a token that doesn't require a refresh every 5 minutes).

You can generate a longer-lived access token using the CLI command:

`weka user generate-token [--access-token-timeout timeout]`

The default timeout is 30 days.

To revoke the access and refresh tokens, use the CLI command: `weka user revoke-tokens`.&#x20;
