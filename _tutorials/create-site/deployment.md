---
layout: tutorials
title: "3. Deploying the Tripal Crop Docker"
permalink: /tutorials/create-site/deployment
nav_order: 3
parent: "How can I create my own site?"
---
{% assign url_prefix = site.baseurl | append: "/tutorials/create-site" %}

**1) Login to the Github Package Repository**

GitHub currently requires authentication to access public docker images. As such you will need to first [create a person GitHub access token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) and then authenticate using the following command where you have replaced USERNAME with your GitHub username and TOKEN.txt contains your personal access token.

```
cat ~/TOKEN.txt | docker login https://docker.pkg.github.com -u USERNAME --password-stdin
```

**2) Pull the most recent image from the Github Package Repository.**

```
docker pull docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.3
```

**3) Create a running container exposing the website at localhost:9010**

*To customize the installed site, change the variables available in the .env file without removing any.* **Make sure to change DBPASS and ADMINPASS for security reasons.**

```
docker run --publish=9010:80 --name=tcrop -tid \
  -e DBPASS='somesecurepassword' \
  -e ADMINPASS='anothersecurepassword' \
  --env-file=.env \
  docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.3
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
