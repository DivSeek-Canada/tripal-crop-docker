---
layout: home
title: Home
nav_order: 1
description: "A fully provisioned Tripal site aimed at supporting crop-focused and breeding research."
permalink: /
---


![Logo]({{site.baseurl}}/assets/images/DivseekCan_Green_CapYes.png)
{: .frontpage-center }

## We used [Docker](https://www.docker.com/why-docker) so you can have <br /> your OWN breeder-focused portal!
{: .frontpage-h2 }


### We like to think of docker as packaging our website framework and tools into a [present](https://www.docker.com/resources/what-container) just for you!
{: .frontpage-h3 }

_Either use your own hosting solution or the Compute Canada OpenStack cloud and Follow our super simple, unwrapping instructions to auto-magically create your own customized portal!_
{: .frontpage-center }

---

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

## Funding

The first iteration of the platform is funded under a [Genome Canada Project](https://www.genomecanada.ca/en/divseek-canada-harnessing-genomics-accelerate-crop-improvement-canada) with co-funding from other partners.

## Citation

Lacey-Anne Sanderson, Kirstin E. Bett, Loren H. Rieseberg (2020) Tripal Crop Docker: A fully provisioned Tripal site aimed at supporting crop-focused and breeding research. DEVELOPMENT VERSION. DivSeek Canada Pilot Project: Harnessing Genomics to Accelerate Crop Improvement in Canada.
