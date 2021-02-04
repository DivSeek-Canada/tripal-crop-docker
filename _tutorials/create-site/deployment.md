---
layout: tutorials
title: "3. Deploying the Tripal Crop Docker"
permalink: /tutorials/create-site/deployment
nav_order: 3
parent: "How can I create my own site?"
---
{% assign url_prefix = site.baseurl | append: "/tutorials/create-site" %}

**1) Pull the most recent image from Docker Hub.**

```
docker pull divseekcanada/tripal-crop-docker:latest
```

**2) Pull down a copy of the default .env file.**

```
wget https://raw.githubusercontent.com/DivSeek-Canada/tripal-crop-docker/master/.env
```

*To customize the installed site, change the variables available in the .env file without removing any.*

**3) Create a running container exposing the website at localhost:9010**

**Make sure to change DBPASS and ADMINPASS for security reasons.**

```
docker run --publish=9010:80 --name=tcrop -tid \
  -e DBPASS='somesecurepassword' \
  -e ADMINPASS='anothersecurepassword' \
  --env-file=.env \
  divseekcanada/tripal-crop-docker:latest
```

**4) Provision the container including installation of the software stack and default configuration.**

```
docker exec -it tcrop /app/init_scripts/startup_container.sh
```

**5) Add your species information to the resource using our configuration helper.**

```
docker exec -it --workdir=/var/www/html tcrop vendor/bin/drush tcrop-species Genus species CommonName "Abbreviation"
```

Make sure to change the `Genus`,`species`,`CommonName`,`Abbreviation` with the information for your crop. Run this command once per species you would like to add to the resource.

> **NOTE:**
> Your site will now be available at http://localhost:9010. The administrative username is in your .env file and the password was supplied on the command-line. You can now follow the [tutorial provided by Tripal](https://tripal.readthedocs.io/en/latest/user_guide/drupal_overview.html) to become familiar with the system.
{: .note }
