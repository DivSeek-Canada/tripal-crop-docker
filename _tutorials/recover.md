---
layout: tutorials
title: "How do I recover my site from a backup?"
nav_order: 6
has_children: false
permalink: /tutorials/restore
---
{% assign url_prefix = site.baseurl | append: "/tutorials" %}

**This guide assumes you backed up the docker image as described in ["How do I backup my site?"]({{ url_prefix}}/backup).**

To restore your site from a compressed archive, you first need to load the image. To do so, SSH into your server. For the [ComputeCanada OpenStack cloud, you can find instructions on step 10]({{url_prefix}}/create-site/compute-canada.html). Then execute the following command from the directory containing your archive:

```
sudo docker load --input tcrop-2020nov28.tar.gz
```

Now you should have an image name tcrop-2020nov28 which you can restart your container from. To start the containing, run the following command:

```
sudo docker run --name=tcrop tcrop-2020nov28
```

And that's it! You should have a working site matching the state of your site when you made the backup.
