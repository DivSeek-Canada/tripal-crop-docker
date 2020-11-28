---
layout: tutorials
title: "How can I create my own site?"
nav_order: 1
has_children: true
has_toc: false
permalink: /tutorials/create-site
---
{% assign url_prefix = site.baseurl | append: "/tutorials/create-site" %}

This guide will walk you through how to create a copy of the DivSeek Portal. The DivSeek portal has been designed to encapsulate the functionality in a collection of Docker containers so that you can easily create your own portal with the same functionality to house your data.

## Steps:

1. [Finding a place to host your site]({{url_prefix}}/hosting.html)
2. [Install pre-requisistes]({{url_prefix}}/prerequisites.html)
3. [Deploying the Tripal Crop Docker]({{url_prefix}}/deployment.html)
4. [HTTPS/SSL configuration]({{url_prefix}}/https-config.html)
5. [Changing the look & feel of your site]({{url_prefix}}/customize-look.html)
