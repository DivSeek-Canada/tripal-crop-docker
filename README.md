
# Tripal Crop Docker

This docker container contains all the Drupal, Tripal and DivSeek Canada extension modules you need to create your own Tripal Crop site. Furthermore, it contains a number of command-line drush commands to make maitenance and administration of your Tripal crop site more streamlined.

**The Tripal Crop Docker does NOT include any data, configuration or installation in current releases. Manual installation and configuration of the Tripal Crop site is required. Check the future work to see plans for upcoming releases.**

## Current Usage
```
docker pull docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.0

docker run --publish=9010:80 --name=tcrop -tid \
  -e DBPASS='some secure password!' \
  -e ADMINPASS='some secure password' \
  --env-file=.env \
  tripal-crop-docker:1.1

docker exec -it tcrop /app/init_scripts/startup_container.sh
```

## Future Work
- create a tripal extension module with drush commands
   - install and configure defaults for all Modules
   - add permissions and roles which make sense
- create command-line bash commands for easy site management
   - Initial setup: creates database, installs site, and runs drush commands
   - Certbot: create/renew certificate
   - Upgrade? upgrades drupal and all extension modules

## Funding

The first iteration of the platform is funded under a [Genome Canada Project](https://www.genomecanada.ca/en/divseek-canada-harnessing-genomics-accelerate-crop-improvement-canada) with co-funding from other partners.

## Citation

Lacey-Anne Sanderson, Kirstin E. Bett, Loren H. Rieseberg (2020) Tripal Crop Docker: A fully provisioned Tripal site aimed at supporting crop-focused and breeding research. DEVELOPMENT VERSION. DivSeek Canada Pilot Project: Harnessing Genomics to Accelerate Crop Improvement in Canada.
