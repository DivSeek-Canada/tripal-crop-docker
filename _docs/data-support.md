---
layout: docs
title: "Functionality Overview"
nav_order: 3
has_children: false
permalink: /docs/data-support
---
{% assign url_prefix = site.baseurl | append: "/assets/videos" %}

Tripal Crop Docker provides a flexible suite of tools to breeders and researchers. While you can use these tools in many ways to answer your research and variety development questions, we're going to highlight a few here for demonstration purposes. There will be a full question-focused user guide soon!

## Examples
{: .no_toc .text-delta }

 - TOC
{:toc}

## Find all early emerging Lentil accessions with upright growth habit for easy harvest.

<video width="800" height="450" controls>
 <source src="{{url_prefix}}/germplasm-search.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

1. Go the the [Lentil Germplasm Search](https://staging.divseekcanada.ca/search/germplasm?genus=Lens)
2. Enter "Days till Plants Emerge" as the trait and less than or equal to 12 days. You choose "Mean per Trait" to match the values shown in the heatmap.
3. Click "Add a Trait" then enter "Lodging" as the trait and less than or equal to 1 scale 1 (upright) to 5 (lodged). Again, choose "Mean per Trait".
4. Click search to find there is only one!

## How much resistance to Pasmo already exists in Flax?

<video width="800" height="450" controls>
 <source src="{{url_prefix}}/trait-summary.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

1. Go to the [Trait Distribution Plot](https://staging.divseekcanada.ca/phenotypes/trait-distribution)
2. Choose the Experiment "Genome-wise association studies for Pasmo resistance in Flax", then the Trait "Pasmo Resistance" then the method and unit.
3. The method is shown in the figure lengend of the plot and indicates a scalar value of 1-2 is resistant. The plot shows that not many varieties fall within 1-2 on the scale.

## Is PI 664232 susceptible to Downy Mildew?

<video width="800" height="450" controls>
 <source src="{{url_prefix}}/germplasm-trait.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>

1. Go to the [Sunflower Germplasm search](https://staging.divseekcanada.ca/search/germplasm?genus=Helianthus) and enter the name "PI 664232"
2. Click on the name to go to the germplasm page for "PI 664232" and scroll to the bottom to see the Phenotypic data summary distribution plot.
3. The current germplasm is indicated with a green line and in this case, the green line is above the average indicator in the box plot. As such, PI 664232 has greater then average spore density and is likely susceptible to Downy Mildew.
