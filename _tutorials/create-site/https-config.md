---
layout: tutorials
title: "4. HTTPS/SSL Configuration"
permalink: /tutorials/create-site/https-config
nav_order: 4
parent: "How can I create my own site?"
---
{% assign url_prefix = site.baseurl | append: "/tutorials/create-site" %}

Let’s Encrypt is a Certificate Authority (CA) that provides an easy way to obtain and install free TLS/SSL certificates. Such a certificate is needed to enable encrypted HTTPS on all websites. Let's Encrypt further simplifies this process by providing a software client, Certbotto automate this process. Tripal Crop Docker already has certbot for apache installed.

As such, to obtain your certificate for HTTPS encryption, simply run the following command and answer the prompts.

**Make sure to replace your_domain with a domain name you have purchased and pointed to your host IP address.**

```
docker exec -it tcrop certbot --apache -d your_domain -d www.your_domain
```

 And that's it!
