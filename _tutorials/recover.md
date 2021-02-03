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

> **NOTE:** Alternatively, if you chose to store the image privately in [Docker Hub](https://hub.docker.com/) then you can use [`docker pull`](https://docs.docker.com/engine/reference/commandline/pull/) to pull that image from the cloud to your server. The following command will work with either method.
{: .note}

Now you should have an image name tcrop-2020nov28 which you can restart your container from. You will need to stop the container currently running your site. When you do this your site will become unavailable through the internet but the container will remain on your server as copy in case you need to roll back this process.

```
sudo docker stop tcrop
sudo docker rename tcrop tcrop-original
```

Then to start a new container from the backup, run the following command:

```
sudo docker run --name=tcrop --publish=80:80 -tid tcrop-2020nov28
sudo docker exec tcrop service postgresql restart
```

And that's it! You should have a working site matching the state of your site when you made the backup.

> **NOTE:** It is highly recommend you check your site after this process to make sure everything is as you expect. Once you have verified you are happy with the process, you can save the original version of the site using the same process as when you backed up your site.
{: .note }

If you have space concerns, you may decide to delete past containers/images. Once you delete either from your server they are permanently removed and are only recoverable if you backed them up via file or cloud. You can delete old containers using [`docker rm`](https://docs.docker.com/engine/reference/commandline/rm/) and old images using [`docker rmi`](https://docs.docker.com/engine/reference/commandline/rmi/).

## TROUBLESHOOTING:

### Rolling Back a Recovery Attempt

If something goes wrong and you need to rollback to the original version of your site then use the following commands to return your site to the original version before this backup process began.

1. Stop the failed backup container and rename it to keep it separate.
```
sudo docker stop tcrop
sudo docker rename tcrop tcrop-failedbackup
```

2. Next restart your original container after renaming it back.
```
sudo docker rename tcrop-original tcrop
sudo docker restart tcrop
sudo docker exec tcrop service postgresql restart
```
After this point you should have a working site for your users to interact with while you figure out what went wrong.

3. Start the failed backup on your local computer to investigate what went wrong. To do this follow the  instructions for restoring a backup but on your local computer.

4. Check your local site to see if the recovery worked. If it works locally, then the problem is with the server and may be related to docker software versions, permissions or access to hardware resources. If it doesn't work locally then use `docker exec -it tcrop bash` to open a terminal session inside the docker container. This will allow you to check that
	- the files are all there. Specifically, check the sites/all directories
	- the /var/www/html/sites/default/settings.php file has the correct database settings in it
	- if you mounted any directories using --volume when running the original container they may need to be replaced in the backup.
	- use `drush status` to check that the site is bootstrapped correctly.
	- use `drush cc all` to clear the cache of your website in case incorrect settings are cached.
