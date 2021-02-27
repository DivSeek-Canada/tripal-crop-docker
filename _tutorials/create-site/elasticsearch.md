---
layout: tutorials
title: "6. Setting up Site-wide Search"
permalink: /tutorials/create-site/elasticsearch
nav_order: 6
parent: "How can I create my own site?"
---
{% assign url_prefix = site.baseurl | append: "/tutorials/create-site" %}

The site-wide search for Tripal Crop Docker is powered by [Elasticsearch](https://www.elastic.co/elasticsearch/) which is an extremely fast, open source, enterprise level search engine. The following instructions will help you set it up with minimal fuss and start indexing your website for site-wide search!

> **NOTE:**
> You may want to install elastic search on a separate "machine" then your webserver. If this is the case, you can still follow these instructions but you will also need to first install Docker.
{: .note }

**1) Install Docker Compose.**

We use Docker Compose to manage a cluster of 3 Elasticsearch images. This provides better performance for your website. To [install Docker Compose, follow the instructions here](https://docs.docker.com/compose/install/) which match the operating system of your host machine (i.e. the machine you are running Docker on).

**2) Setup the Elasticsearch Engine using Docker Compose.**

```
mkdir elasticsearch
cd elasticsearch
wget https://gist.githubusercontent.com/laceysanderson/af87889e458cfe593b63b8ecbbf1f41f/raw/ad7f1a1617b91dfc5b9b3bc154c42fabfd6bc03c/docker-compose.yml
```

The above commands will download a YAML file which tells Docker Compose how to start up three elasticsearch containers in a small cluster. The following command then executes those instructions and starts the 3 containers in the background.

```
sudo docker-compose up -d
```

This will make your cluster publicly accessingly on port 9200. You can check your cluster by going to http://localhost:9200.

**3) Configure Tripal Elasticsearch**

Now we need to configure [Tripal Elasticsearch](https://github.com/tripal/tripal_elasticsearch/) which is included in Tripal Crop Docker. As such the module is already downloaded and installed so you just need to configure it!

Navigate to http://localhost/admin/tripal/extension/tripal_elasticsearch/connection to connect your Elasticsearch cluster to your website. Simply enter the URL of your cluster in the "Elasticsearch Server URL". Assuming you installed the cluster on the same machine as your site, this will be the same URL as your site but with port 9200 indicated as shown in the following screenshot. Then click the button below it and if everything worked properly, you will see the status of your cluster highlighted at the bottom.

![screenshot with http://localhost:9200 filled in]({{url_prefix}}/elasticsearch/step3.png)

**4) Setup Indicies for your site.**

Next, you will want to setup search indices for your site. This is done through the Tripal Elasticsearch configuration forms. Navigate to http://localhost/admin/tripal/extension/tripal_elasticsearch/indices/create and "entities". You can leave all settings at the default and click "Create New Index" at the bottom. This will index all of your biological data for search through the site-wide search!

**5) Ensure you have cron running to index content.**

Finally, you want to setup cron to run the jobs submitted above. To do this, first open a terminal session into your tripal crop docker container using the following command.

```
sudo docker exec -it tcrop bash
```

Then within the prompt opened in the container, you will want to start the cron daemon and then edit the root crontab as follows.

```
service cron start
crontab -e
```

This will open an editor where you should paste in the following lines at the bottom.

```
# Drupal Website Cron in general
*/4 * * * * drush cron-run --root=/var/www/html
# Elastic Search Queues
* * * * * drush cron-run queue_elasticsearch_dispatcher --root=/var/www/html
* * * * * drush cron-run queue_elasticsearch_queue_1 --root=/var/www/html
* * * * * drush cron-run queue_elasticsearch_queue_2 --root=/var/www/html
* * * * * drush cron-run queue_elasticsearch_queue_3 --root=/var/www/html
* * * * * drush cron-run queue_elasticsearch_queue_4 --root=/var/www/html
* * * * * drush cron-run queue_elasticsearch_queue_5 --root=/var/www/html
```

Then save your changes and cron will take care of running all your indexing jobs!

And that's it! It will take some time to populate your index but once it is complete, you will be able to search for your biological data through the site-wide search!

![screenshot of website showing search results]({{url_prefix}}/elasticsearch/final.png)
