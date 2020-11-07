---
layout: docs
title: "Deploying the Tripal Crop Docker"
permalink: /docs/create-site/deployment.html
nav-parent: ../create-site.html
nav-next: https-config.html
nav-prev: prerequisites.html
---

**1) Pull the most recent image from the Github Package Repository.**

```
docker pull docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.3
```

**2) Create a running container exposing the website at localhost:9010**

*To customize the installed site, change the variables available in the .env file without removing any.* **Make sure to change DBPASS and ADMINPASS for security reasons.**

```
docker run --publish=9010:80 --name=tcrop -tid \
  -e DBPASS='somesecurepassword' \
  -e ADMINPASS='anothersecurepassword' \
  --env-file=.env \
  docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.3
```

**3) Provision the container including installation of the software stack and default configuration.**

```
docker exec -it tcrop /app/init_scripts/startup_container.sh
```

**4) Add your species information to the resource using our configuration helper.**

```
docker exec -it --workdir=/var/www/html tcrop vendor/bin/drush tcrop-species Genus species CommonName "Abbreviation"
```

Make sure to change the `Genus`,`species`,`CommonName`,`"Abbreviation` with the information for your crop. Run this command once per species you would like to add to the resource.
