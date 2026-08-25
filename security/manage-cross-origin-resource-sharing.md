---
description: Manage trusted sites for Cross-Origin Resource Sharing using CLI commands.
---

# Manage Cross-Origin Resource Sharing

Cross-Origin Resource Sharing (CORS) is a security mechanism implemented by web browsers that restricts how a web page from one domain can request resources from a different domain. This essentially defines the rules for communication between a web application and the server that hosts the resources it needs.

**Why do we need CORS?**

Imagine a scenario where a website (yourbank.com) relies on functionalities from another website (images.com) to display product images. If browsers didn't have CORS, images.com could potentially steal your login credentials from yourbank.com through a malicious script.

CORS prevents such unauthorized access by enforcing a set of rules. The server hosting the resources (images.com) can specify which websites (origins) can access them through special HTTP headers. This ensures that your sensitive data on yourbank.com remains secure.

In summary, CORS helps maintain web security by:

* **Preventing unauthorized access:** It restricts malicious websites from accessing resources on other domains.
* **Enforcing communication protocols:** It defines a clear communication channel between browsers and servers for cross-origin requests.

## **CORS CLI commands**


### List the CORS trusted sites

Lists the origins allowed to make cross-origin requests to the cluster's API.

**Command:** `weka security cors-trusted-sites list`

```sh
weka security cors-trusted-sites list
```

### Add a CORS trusted site

Adds an origin to the CORS trusted list.

**Command:** `weka security cors-trusted-sites add`

```sh
weka security cors-trusted-sites add <site>
```

**Parameters**

| Parameter | Description                                      |
| --- | --- |
| `site`\* | Site to trust for cross origin resource sharing. |

Example:

```
$ weka security cors-trusted-sites add http://site_3.com
```

### Remove a CORS trusted site

Removes a single origin from the CORS trusted list.

**Command:** `weka security cors-trusted-sites remove`

```sh
weka security cors-trusted-sites remove <site>
```

**Parameters**

| Parameter | Description                           |
| --- | --- |
| `site`\* | Site to remove from the trusted list. |

### Remove all trusted sites from the CORS list

Clears the CORS trusted list, disallowing all cross-origin requests.

**Command:** `weka security cors-trusted-sites reset`

```sh
weka security cors-trusted-sites reset
```
