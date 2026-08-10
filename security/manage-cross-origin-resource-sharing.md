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

**Command:** `weka security cors-trusted-sites list`

Use the following command line to display the list of trusted sites with configured CORS settings:

`weka security cors-trusted-sites list`

Example:

```
$ weka security cors-trusted-sites list
http://site_1.com
http://Site_2.com
```

### Add a CORS trusted site

**Command:** `weka security cors-trusted-sites add`

Use the following command line to add a trusted site to the CORS list.

`weka security cors-trusted-sites add <site>`

**Parameters**

<table><thead><tr><th width="179">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>site</code>*</td><td>Trusted site to add. Include the URL with the <code>http</code> or <code>https</code> prefix, and specify the port number if it’s not the default.</td></tr></tbody></table>

Example:

```
$ weka security cors-trusted-sites add http://site_3.com
```

### Remove a CORS trusted site

**Command:** `weka security cors-trusted-sites remove`

Use the following command line to remove a specified trusted site from the CORS list.

`weka security cors-trusted-sites remove`

<table><thead><tr><th width="179">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>site</code>*</td><td>Trusted site to remove from the CORS list.</td></tr></tbody></table>

### Remove all trusted sites from the CORS list

**Command:** `weka security cors-trusted-sites remove-all`

Use the following command line to remove all trusted sites from the CORS list.

`weka security cors-trusted-sites remove`
