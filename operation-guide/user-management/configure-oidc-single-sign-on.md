---
description: >-
  Let tenant users sign in to the CLI and the GUI with their Microsoft Entra ID
  account through OpenID Connect (OIDC).
---

# Configure OIDC single sign-on

Each tenant can connect the cluster to its Microsoft Entra ID directory. Users of that tenant then sign in to the CLI and the GUI with their Entra ID account.

* Microsoft Entra ID is the supported identity provider.
* With MFA required, the default, the cluster accepts only sign-ins that Entra ID reports as multi-factor.
* An enabled connector takes over management sign-in for LDAP users of the tenant.
  * LDAP management sign-in stops for the tenant.
  * The LDAP configuration stays in place and keeps serving S3 users.
  * Local users sign in with their password as before.

This topic covers management sign-in. For S3 access with OIDC, see [Configure S3 OIDC authentication](../../additional-protocols/s3/s3-users-and-authentication/configure-s3-oidc-authentication.md).

## Before you begin

* Run the commands as a Cluster Admin or Tenant Admin of the tenant.
* In Entra ID, register an application for the cluster and note:
  * The **issuer URL**, for example `https://login.microsoftonline.com/<directory-id>/v2.0`.
  * The **client ID**, which is the application ID.
  * A **client secret**, only if you register the application as a confidential client.
* Choose how users receive their WEKA role. Use one method per connector:
  * **App roles:** In the application, create app roles whose values are WEKA role names, and assign users or groups to them. The values are `ClusterAdmin`, `TenantAdmin`, `ReadOnly`, `Regular`, or `QuotaManager`. Matching ignores case.
  * **Group mapping:** Configure the application to include group claims in the token, then map each group to a WEKA role on the cluster. See [Map groups to roles](#map-groups-to-roles).
* With either method, if a user has several roles, the highest one applies.
* In a tenant other than the root tenant, `ClusterAdmin` is not granted. Use `TenantAdmin` instead.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Navin Adarsh Gunamani):** Which redirect URIs must be registered in the Entra ID application, for the GUI and for the CLI browser sign-in? The CLI listens on `127.0.0.1`, and it is unclear whether Entra ID accepts that or requires `localhost`. Also confirm whether **Allow public client flows** must be enabled for `--use-device-code`.
{% endhint %}

## Configure the OIDC connector

**Command:** `weka user oidc set`

Creates or updates the tenant's OIDC connector. When you enable the connector, the cluster contacts the issuer to validate the configuration.

{% code overflow="wrap" %}
```
weka user oidc set [--issuer <url>] [--client-id <id>] [--vendor entra] [--role-claim <claim>] [--groups-claim <claim>] [--cluster-admin-group <group>] [--tenant-admin-group <group>] [--readonly-group <group>] [--regular-group <group>] [--quota-manager-group <group>] [--client-secret <secret> | --clear-client-secret] [--redirect-uris <origin>[,<origin>...] | --clear-redirect-uris] [--require-mfa[=false]] [--enabled[=false]]
```
{% endcode %}

**Parameters**

| Parameter | Description |
| --- | --- |
| `issuer` | Issuer URL of the Entra ID directory. Required to enable the connector. |
| `client-id` | Application (client) ID. Required to enable the connector. |
| `vendor` | Identity provider. Possible value: `entra`. |
| `role-claim` | Token claim that carries the WEKA role names. For Entra ID app roles, the claim is `roles`. To clear it, pass an empty value: `--role-claim ""`. |
| `groups-claim` | Token claim that carries the user's groups, for group mapping. Default: `groups`. To return to the default, pass an empty value. |
| `cluster-admin-group`<br>`tenant-admin-group`<br>`readonly-group`<br>`regular-group`<br>`quota-manager-group` | Group that receives the `ClusterAdmin`, `TenantAdmin`, `ReadOnly`, `Regular`, or `QuotaManager` role. Specify the group object ID or name, as the token carries it. To clear a mapping, pass an empty value. |
| `client-secret` | Client secret, for a confidential client. Omit it for a public client. To be prompted, pass an empty value. The secret is never displayed again. |
| `clear-client-secret` | Removes a stored client secret, making the cluster a public client. |
| `redirect-uris` | Origins that the browser sign-in can start from, in the format `https://<host>[:<port>]`. Up to 8 origins, comma-separated. Replaces the current list. |
| `clear-redirect-uris` | Removes every origin from the list, so the browser sign-in accepts any HTTPS origin. |
| `require-mfa` | Accepts only sign-ins that Entra ID reports as multi-factor. Default when the connector is created: `true`. |
| `enabled` | Enables the connector for the tenant. Default when the connector is created: `false`. To disable it, pass `--enabled=false`. |

**Example**

{% code overflow="wrap" %}
```
weka user oidc set --vendor entra --issuer https://login.microsoftonline.com/<directory-id>/v2.0 --client-id <application-id> --role-claim roles --enabled
```
{% endcode %}

### Map groups to roles

Group mapping assigns WEKA roles by the user's group membership in Entra ID, instead of by app roles.

* Each role takes one group. A user in several mapped groups receives the highest role.
* Each group flag updates only its own role. The other mappings stay in place.
* A connector uses either the role claim or group mapping. To switch to group mapping, clear the role claim and set the group mappings in the same command. To switch back, clear every group mapping and set the role claim in the same command.
* Entra ID limits the number of groups it puts in a token. For users who belong to many groups, configure group filtering for the application in Entra ID.

**Example**

{% code overflow="wrap" %}
```
weka user oidc set --role-claim "" --tenant-admin-group <admins-group-id> --readonly-group <viewers-group-id>
```
{% endcode %}

### Restrict sign-in origins

By default, the browser sign-in accepts any HTTPS origin, and the `OIDCRedirectOriginsUnrestricted` alert stays active while the connector is enabled. To accept only the addresses users open the GUI from, list them with `--redirect-uris`. The cluster appends `/auth/callback` to each origin.

* The CLI sign-in uses a loopback address, which is always accepted. List only the GUI addresses.
* To view the list, run `weka user oidc show`.

**Example**

{% code overflow="wrap" %}
```
weka user oidc set --redirect-uris https://cluster.example.com:14000
```
{% endcode %}

### View, reset, or rotate the connector

* To view the connector: `weka user oidc show`
* To remove the connector: `weka user oidc reset`
* To rotate the key that protects single sign-on sessions: `weka user oidc rotate-seal-key`. Single sign-on users of the tenant sign in again at their next session refresh.

## Sign in with OIDC

### Sign in to the CLI

**Command:** `weka user login`

Run the command without a username, in an interactive terminal. The CLI opens a browser to the Entra ID sign-in page. After you sign in, the CLI saves the credentials to your profile.

* To sign in from another device, add `--use-device-code`. The CLI shows a URL and a code to enter on any device.
* To print the sign-in URL instead of opening a browser, add `--no-open`.
* In a remote session, the CLI prints an `ssh` command to run on your local computer, so the sign-in completes in your local browser.
* Single sign-on uses the cluster's default token lifetimes. `--access-token-timeout` and `--refresh-token-timeout` apply only to username and password sign-in.

To sign in as a local user, pass the username: `weka user login <username>`.

### Sign in to the GUI

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (GUI team):** Add the GUI sign-in steps and screen captures for single sign-on.
{% endhint %}

## Control how long an OIDC session stays valid

The cluster rechecks an OIDC user with Entra ID when the session's access token is refreshed. Changes in Entra ID, such as a disabled account or a removed role, take effect at the next refresh.

The access token of an OIDC or LDAP user lasts at most the revalidation interval. Default: 5 minutes. To change it, see [Manage token expiration](../../security/manage-token-expiration.md).

## Monitor OIDC

**Events**

| Event | Raised when |
| --- | --- |
| `OIDCConfigUpdated` | The connector configuration changes. |
| `OIDCAuthEnabled`, `OIDCAuthDisabled` | The connector is enabled, disabled, or reset. |
| `OIDCSealKeyRotated` | The session key is rotated. |
| `OIDCSessionRefreshRefused` | A session refresh is refused, for example because the account is disabled, the role is removed, or MFA is no longer reported. |
| `UserLoggedIn`, `UserLoginFailed` | A user signs in through OIDC, or the sign-in fails. |
| `OIDCProviderUnreachable`, `OIDCProviderRecovered` | The cluster can't reach Entra ID, or reaches it again. |

**Alert**

`OIDCRedirectOriginsUnrestricted`: the connector accepts browser sign-in from any HTTPS origin. To clear it, see [Restrict sign-in origins](#restrict-sign-in-origins).

## Considerations

* Microsoft Entra ID is the only supported identity provider.
* The cluster checks Entra ID reachability when users sign in or refresh a session. The provider events appear only then.
