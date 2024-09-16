---
description: >-
  Learn how to manage authentication across multiple clusters in the WEKA CLI
  using connection profiles, enabling seamless switching between clusters
  without re-authentication.
---

# Manage authentication across multiple clusters with connection profiles

## Overview

Managing authentication across multiple clusters in the WEKA CLI is streamlined with connection profiles. By default, when you run the `weka user login` command, it creates a profile stored as `.weka/auth-token.json`. This is sufficient for single-cluster environments. However, in a multi-cluster environment, use the `--profile` parameter to create and manage separate profiles for each cluster. This allows you to switch between clusters without needing to re-authenticate each time, enhancing efficiency and usability.

**Profile naming conventions**

When creating a connection profile, follow these guidelines:

* **Maximum length:** 50 characters
* **Allowed characters:**
  * Alphanumeric (A-Z, a-z, 0-9)
  * Underscores (\_)
  * Hyphens (-)

Profile names dictate where authentication details are stored in the `.weka` directory:

* **Default profile:** `.weka/auth-token.json`
* **Named profiles:** `.weka/auth-token-<profile-name>.json`

## **Log in with profiles**

The `weka user login` command supports profiles, enabling you to specify which profile to use or create a new one.

**Command syntax:**

```bash
weka user login --profile <profile-name>
```

* **Default profile:** If no profile is specified, the system uses the default profile.
* **Profile-specific file:** Authentication information is saved in a file named after the profile.
*   **Success message:** After a successful login, the following message appears:

    ```bash
    Login completed successfully.
    <Default/profileN> profile updated.
    ```
* **Failure message:** If the profile is not found or the login fails, an error message displays the profile name and file path.

## **Log out of profiles**

The `weka user logout` command supports profiles, enabling you to remove the authentication details for a specific profile.

**Command syntax:**

```bash
weka user logout --profile <profile-name>
```

* The specified profile’s authentication file is deleted.
* If no profile is specified, the default profile is logged out.

## **Using profiles with WEKA CLI commands**

You can specify a profile when executing most WEKA CLI commands using the `--profile` option. If no profile is provided, the default profile is used.

**Command syntax:**

```bash
weka <command> --profile <profile-name>
```

{% hint style="info" %}
The `--profile` option is not supported with `weka diag` commands. The default profile is used for diagnostics.
{% endhint %}

**Related topic**

[mount-filesystems-from-multiple-clusters-on-a-single-client.md](mount-filesystems-from-multiple-clusters-on-a-single-client.md "mention")
