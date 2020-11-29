---
layout: tutorials
title: "How do I backup my site?"
nav_order: 5
has_children: false
permalink: /tutorials/backup
---
{% assign url_prefix = site.baseurl | append: "/tutorials" %}

To backup our site we are going to take advantage of the Docker system. Specifically we're going to commit all the changes you've made to your site into it's own docker image so that you can re-create it again perfectly later.

To do this, you first need to SSH into your server. For the [ComputeCanada OpenStack cloud, you can find instructions on step 10]({{url_prefix}}/create-site/compute-canada.html). Then execute the command inside your cloud instance as follows changing the date for the current date of your backup:

```
sudo docker commit --pause tcrop tcrop-2020Nov28
```

Now you have an image stored in your cloud instance. Next, you should transfer your backup to a different machine for extra safety. To do this we need to package up the docker image into a compressed archive. While still within your server, execute the following command:

```
sudo docker save tcrop-2020nov28 | gzip > tcrop-2020nov28.tar.gz
```

You can then copy the compressed archive from the server. [Compute Canada has provided documentation](https://docs.computecanada.ca/wiki/Transferring_data/en) specific to that setup should you need more information.
