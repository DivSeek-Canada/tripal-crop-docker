---
layout: docs
title: "Overall data network"
nav_order: 2
has_children: false
permalink: /docs/data-network
---
{% assign url_prefix = site.baseurl | append: "/assets/videos" %}

## Data Types

The following data types are fully supported in Tripal Crop Docker.

   - Germplasm passport & pedigree
   - Phenotypic traits
   - Phenotypic experiments & measurements
   - Genotypic experiments & calls
   - Sequence variants & genetic markers
   - Genetic maps & loci
   - Quantitative trait loci (QTL)
   - Genome assemblies & gene sets

Specifically, the full data lifecycle from import, visualization, integration and download is managed. Furthermore, all data is made FAIR through searches, web services, extensive metadata support, summaries, relationships between data points + types, display of integrated data on record pages and multi-format downloads.

## Data Integration

Germplasm form the core of any Tripal Crop Docker site just as it forms the core of any breeding program. All data types are directly or indirectly connected to germplasm. This ensures that it is easy for researchers to ensure that the data they are performing association studies on are truely from the same germplasm. Furthermore, this integration empowers breeders to select germplasm based on a variety of data types!
