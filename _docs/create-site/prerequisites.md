---
layout: docs
title: "Install pre-requisistes"
permalink: /docs/create-site/prerequisites.html
nav-parent: ../create-site.html
nav-next: ../index.html
nav-prev: hosting.html
---

***Currently the only pre-requisite is Docker!***

## Installation of Docker

To run Docker, you'll obviously need to [install Docker first](https://docs.docker.com/engine/installation/) in your target Linux operating environment (bare metal server or virtual machine running Linux).

For our installations, we typically use Ubuntu Linux, for which there is an [Ubuntu-specific docker installation](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository) using the repository.

Note that you should have 'curl' installed first before installing Docker:

```
sudo apt install curl
```

For other installations, please find instructions specific to your choice of Linux variant, on the Docker site.

### Testing Docker

In order to ensure that Docker is working correctly, run the following command:

```
sudo docker run hello-world
```

This should result in something akin to the following output:

```
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
ca4f61b1923c: Pull complete
Digest: sha256:be0cd392e45be79ffeffa6b05338b98ebb16c87b255f48e297ec7f98e123905c
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:

  docker run -it ubuntu bash

  Share images, automate workflows, and more with a free Docker ID:
    https://cloud.docker.com/

  For more examples and ideas, visit:
    https://docs.docker.com/engine/userguide/
```
