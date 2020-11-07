---
layout: default
title: Home
---

<div style="text-align:center;">

<img style="margin: 5px auto" src="{{ site.baseurl }}/public/DivseekCan_Green_CapYes.png" />

<h2>We used <a href="https://www.docker.com/why-docker">Docker</a> so you can have <br /> your OWN breeder-focused portal!</h2>

<h4>We like to think of docker as packaging our website framework and tools <br /> into a <a href="https://www.docker.com/resources/what-container">present</a> just for you!</h4>

<p>Either use your own hosting solution or the Compute Canada OpenStack cloud <br /> and Follow our super simple, unwrapping instructions to auto-magically create your own customized portal!</p>

</div>
<hr>

This docker container contains all the Drupal, Tripal and DivSeek Canada extension modules you need to create your own Tripal Crop site. Furthermore, it contains a number of command-line drush commands to make maintenance and administration of your Tripal crop site more streamlined.

## Data Types

*The following data types are fully supported in Tripal Crop Docker. Specifically, the full data lifecycle from import, visualization, integration and download is managed. Furthermore, all data is made FAIR through searches, web services, extensive metadata support, summaries, relationships between data points + types, display of integrated data on record pages and multi-format downloads.*

- Germplasm passport & pedigree
- Phenotypic traits
- Phenotypic experiments & measurements
- Genotypic experiments & calls
- Sequence variants & genetic markers
- Genetic maps & loci
- Quantitative trait loci (QTL)
- Genome assemblies & gene sets

## Software Stack

*The following software exists within the current tripal-crop-docker image. NOTE: PostgreSQL is inside the same image as Drupal for security reasons as it allows us to close incoming ports.*

- Tripal 3.4
- Drupal 7.73
- Composer 2.0.2
- Drush 8.4.5
- PHP 7.4.11
- PostgreSQL 11.9
- Apache 2.4.38
- Debian 10 (buster)

In addition, the tripal-crop-docker contains a large number of Tripal extension modules to support crop research and breeding activities.

## Usage

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

**3) Provision the container including installation of the software stack.**

```
docker exec -it tcrop /app/init_scripts/startup_container.sh
```

## Funding

The first iteration of the platform is funded under a [Genome Canada Project](https://www.genomecanada.ca/en/divseek-canada-harnessing-genomics-accelerate-crop-improvement-canada) with co-funding from other partners.

## Citation

Lacey-Anne Sanderson, Kirstin E. Bett, Loren H. Rieseberg (2020) Tripal Crop Docker: A fully provisioned Tripal site aimed at supporting crop-focused and breeding research. DEVELOPMENT VERSION. DivSeek Canada Pilot Project: Harnessing Genomics to Accelerate Crop Improvement in Canada.
