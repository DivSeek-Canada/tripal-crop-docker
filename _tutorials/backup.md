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

> **NOTE:**
> If possible it is advised to stop the PostgreSQL database running your site before executing the above docker commit command. To do this, run the following command on your server.
> ```
> sudo docker exec tcrop service postgresql stop
> ```
>
> But don't forget to re-start PostgreSQL after the commit is complete!
> ```
> sudo docker exec tcrop service postgresql restart
> ```
> **WARNING: Your site will be unavailable to users while PostgreSQL is stopped so make sure to do this during non-peak times or with scheduled warning to your users.**
{: .note }

Now you have an image stored in your cloud instance. Next, you should transfer your backup to a different machine for extra safety. To do this we need to package up the docker image into a compressed archive. While still within your server, execute the following command:

```
sudo docker save tcrop-2020nov28 | gzip > tcrop-2020nov28.tar.gz
```

You can then copy the compressed archive from the server. [Compute Canada has provided documentation](https://docs.computecanada.ca/wiki/Transferring_data/en) specific to that setup should you need more information.

> **NOTE:**
> Alternatively, you can use [Docker Hub](https://hub.docker.com/) or any other docker image hosting platform to store the image in the cloud. I suggest using a _PRIVATE_ repository for this approach as anyone can make a completely functioning clone of your site by running this image. Here is the [documentation for pushing an image to Docker Hub](https://docs.docker.com/docker-hub/repos/).
{: .note }

> **WARNING:**
> Docker run has a `--volume` parameter which allows you to mount part of your local file system within the docker container. This is invaluable when developing new modules; however, it **SHOULD NOT BE USED IN PRODUCTION**. If you use `--volume` to mount directories when you use the backup steps above the mounted files will missing from the backup and cause the recover process to not be successful. If you must mount in production then make sure to backup the mounted files separately keeping them timestamped the same as the container as you will need them when recovering the site.
{: .warning }
