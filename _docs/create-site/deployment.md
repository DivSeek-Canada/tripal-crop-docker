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
docker pull docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.2
```

**2) Create a running container exposing the website at localhost:9010**

*To customize the installed site, change the variables available in the .env file without removing any.* **Make sure to change DBPASS and ADMINPASS for security reasons.**

```
docker run --publish=9010:80 --name=tcrop -tid \
  -e DBPASS='some secure password!' \
  -e ADMINPASS='another secure password!' \
  --env-file=.env \
  docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.2
```

**3) Provision the container including installation of the software stack.**

```
docker exec -it tcrop /app/init_scripts/startup_container.sh
```
