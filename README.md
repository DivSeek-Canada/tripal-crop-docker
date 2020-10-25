
# Tripal Crop Docker

This docker container contains all the Drupal, Tripal and DivSeek Canada extension modules you need to create your own Tripal Crop site. Furthermore, it contains a number of command-line drush commands to make maitenance and administration of your Tripal crop site more streamlined.

## Current Usage
```
docker pull docker.pkg.github.com/divseek-canada/tripal-crop-docker/tripal-crop-docker:1.0
docker run --publish=80:80 --name=tcrop -tid tripal-crop-docker:1.0
docker exec -it tcrop service postgresql start
```

Create the database within the container using docker exec to hop inside.
```
docker exec -it tcrop su postgres && /bin/bash
psql
postgres=# CREATE ROLE tripalcropadmin WITH PASSWORD 'your secure password here!';
postgres=# ALTER ROLE tripalcropadmin WITH LOGIN;
postgres=# CREATE DATABASE tripalcropdb WITH OWNER tripalcropadmin;
```

Then use the web interface to install Drupal and enable the modules.

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
