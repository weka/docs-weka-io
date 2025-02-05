---
description: >-
  Learn how to configure and manage token expiration settings to maintain a
  secure authentication environment aligned with best practices.
---

# Manage token expiration

Token expiration ensures authentication credentials remain valid for a limited time, reducing risks like unauthorized access and token misuse. Use `weka security token-expiry` commands to configure token lifetimes and maintain a secure, policy-aligned authentication environment.

## View existing token expiration settings

**Command:** `weka security token-expiry show`

This command displays the default and maximum expiration times for access and refresh tokens.

## Set token expiration

**Command:** `weka security token-expiry set`

This command allows you to define the default and maximum expiration times for both access and refresh tokens.

{% code overflow="wrap" %}
```
weka security token-expiry set [--access-token access-token] [--refresh-token refresh-token] [--access-token-max access-token-max] [--refresh-token-max refresh-token-max]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="249">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>access-token</code></td><td><p>Default lifetime of an access token.</p><p>Possible values: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited</p></td></tr><tr><td><code>refresh-token</code></td><td><p>Default lifetime of a refresh token.</p><p>Possible values: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited</p></td></tr><tr><td><code>access-token-max</code></td><td><p>Maximum allowable lifetime for an access token.</p><p>Possible values: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited</p></td></tr><tr><td><code>refresh-token-max</code></td><td><p>Maximum allowable lifetime for a refresh token.</p><p>Possible values: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited</p></td></tr></tbody></table>

**Examples:**

*   To set the default access token lifetime to 5 minutes and refresh token lifetime to 2 weeks:

    ```bash
    weka security token-expiry set --access-token 5m --refresh-token 2w
    ```
*   To enforce stricter maximum values for token lifetimes:

    ```bash
    weka security token-expiry set --access-token-max 5m --refresh-token-max 2w
    ```

### Recommendations for token expiration

#### Access tokens

* **Default lifetime**: Set to 5 minutes.
* **Maximum lifetime**: Enforce a maximum of 5 minutes.
* **Reason**: Shorter lifetimes reduce exposure to risks from stale tokens and ensure permissions are frequently reevaluated.

#### Refresh tokens

* **Default Lifetime**: Set to 2 weeks.
* **Maximum Lifetime**: Enforce a maximum of 2 weeks.
* **Reason**: This balance minimizes reauthentication burdens while ensuring periodic user validation.
