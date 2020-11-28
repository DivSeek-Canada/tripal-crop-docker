---
layout: tutorials
title: "How do I import my data?"
nav_order: 2
has_children: false
permalink: /tutorials/import
---
{% assign url_prefix = site.baseurl | append: "/tutorials" %}

All data, with the exception of genotypic data, can be imported into your site using friendly web-based forms!

1. To import data, go to "Tripal" on the top administration toolbar. The click on "Data Loaders".

  ![Step1]({{url_prefix}}/import/data-import-1.png)

2. Then choose your data type from the list of Data Loaders. For example, for germplasm accession passport data you would choose "Germplasm Accession Importer".

  ![Step2]({{url_prefix}}/import/data-import-2.png)

3. Each data importer provides detailed instructions on the format of file needed to import that data type. Where there are clear standards (e.g VCF or MSTmap) they are used but in many cases there are not yet good standards (e.g. quantitative trait loci). Here is the germplasm importer instructions.

  ![Step3]({{url_prefix}}/import/data-import-3.png)

4. Once you have your data prepared in the described format, you can use the Browse button to select your file and then the upload button to upload it to your site. Then you just fill out any additional metadata and click "Import file" to submit the job!

  ![Step4]({{url_prefix}}/import/data-import-4.png)

5. Since biological data files can be large, all data is imported from the command line. When you submitted the job above, you should have seen a green message giving you the command to run on the command-line!

  ![Step5]({{url_prefix}}/import/data-import-5.png)

To do this, you first need to SSH into your server. For the [ComputeCanada OpenStack cloud, you can find instructions on step 10]({{url_prefix}}/create-site/compute-canada.html). Then execute the command inside your site docker container as follows:

```
sudo docker exec -it --workdir=/var/www/html tcrop vendor/bin/drush trp-run-jobs --username=divseek_admin --root=/var/www/html
```
