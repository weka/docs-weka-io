# Manage Cross-Origin Resource Sharing

Cross-Origin Resource Sharing (CORS) is a security mechanism implemented by web browsers that restricts how a web page from one domain can request resources from a different domain. This essentially defines the rules for communication between a web application and the server that hosts the resources it needs.

**Why do we need CORS?**

Imagine a scenario where a website (yourbank.com) relies on functionalities from another website (images.com) to display product images. If browsers didn't have CORS, images.com could potentially steal your login credentials from yourbank.com through a malicious script.

CORS prevents such unauthorized access by enforcing a set of rules. The server hosting the resources (images.com) can specify which websites (origins) can access them through special HTTP headers. This ensures that your sensitive data on yourbank.com remains secure.

In summary, CORS helps maintain web security by:

* **Preventing unauthorized access:** It restricts malicious websites from accessing resources on other domains.
* **Enforcing communication protocols:** It defines a clear communication channel between browsers and servers for cross-origin requests.

TBD: command syntax and parameter descriptions.&#x20;

{% code overflow="wrap" %}
```bash
[root@jamesjoseph1-0 ~] 2024-06-19 17:05:12 $ weka security cors-trusted-sites
Usage:
    weka security cors-trusted-sites [--color color] [--help]

Description:
    Commands for handling Cross Origin Resource Sharing weka apis

Subcommands:
   list         Lists the set of trusted sites where CORS in configured
   add          Add a trusted site to list, provide url with http or https prefix and port number if not a standard
                port.
   remove       Remove the specified site from the trusted list.
   remove-all   Removes all trusted sites for Cross Origin Resource Sharing

Options:
   --color      Specify whether to use color in output (format: 'auto', 'disabled' or 'enabled')
   -h, --help   Show help message


Examples:

[root@jamesjoseph1-0 ~] 2024-06-19 17:05:17 $ weka security cors-trusted-sites list
[root@jamesjoseph1-0 ~] 2024-06-19 17:05:21 $ weka security cors-trusted-sites add http://x.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:05:36 $ weka security cors-trusted-sites add http://y.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:05:40 $ weka security cors-trusted-sites add http://z.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:05:43 $ weka security cors-trusted-sites list
http://x.com
http://y.com
http://z.com

[root@jamesjoseph1-0 ~] 2024-06-19 17:05:47 $ weka security cors-trusted-sites remove http://y.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:06:05 $
[root@jamesjoseph1-0 ~] 2024-06-19 17:06:08 $ weka security cors-trusted-sites list
http://x.com
http://z.com

[root@jamesjoseph1-0 ~] 2024-06-19 17:06:10 $ weka security cors-trusted-sites add http://1.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:06:21 $ weka security cors-trusted-sites add http://2.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:06:24 $ weka security cors-trusted-sites add http://3.com
[root@jamesjoseph1-0 ~] 2024-06-19 17:06:27 $ weka security cors-trusted-sites list
http://x.com
http://z.com
http://1.com
http://2.com
http://3.com
```
{% endcode %}

