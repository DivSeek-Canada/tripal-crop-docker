#!/bin/bash

## This script is run when the docker container is created.
##
## Expected ENVIRONMENTAL VARIABLES
## - $DBPASS: The password for the tripal/chado database administrative user.
## - $ADMINPASS: The password for the drupal admin user.
##
## All Other variables are defined in a .env file.

service postgresql start
SQL="CREATE ROLE $DBADMIN WITH PASSWORD '$DBPASS'"
echo $SQL
PGPASSWORD=docker psql --user docker --command "$SQL"
SQL="ALTER ROLE $DBADMIN WITH LOGIN"
echo $SQL
PGPASSWORD=docker psql --user docker --command "$SQL"
SQL="CREATE DATABASE $DBNAME WITH OWNER $DBADMIN"
echo $SQL
PGPASSWORD=docker psql --user docker --command "$SQL"

service apache2 start
sleep 30
cd /var/www/html/
vendor/drush/drush/drush site-install standard --yes \
  --db-url=pgsql://$DBADMIN:$DBPASS@localhost/$DBNAME \
  --account-mail="$DRUPALEMAIL" \
  --account-name=$DRUPALADMIN \
  --account-pass=$ADMINPASS \
  --site-mail="$DRUPALEMAIL" \
  --site-name="$SITENAME"

vendor/drush/drush/drush pm-enable --yes advanced_help ctools date \
	dragndrop_upload ds entity field_formatter_class field_formatter_settings \
	field_group field_group_table jquery_update libraries link maillog memcache \
	panels queue_ui redirect services ultimate_cron views webform
vendor/drush/drush/drush pm-enable --yes chado_custom_search trpfancy_fields \
	tripald3 trpdownload_api
vendor/drush/drush/drush pm-enable --yes analyzedphenotypes divseek-search  \
	nd_genotypes tripal_elasticsearch tripal_galaxy tripal_germplasm_importer \
	tripal_jbrowse tripal_qtl vcf_filter
vendor/drush/drush/drush pm-enable --yes tripal_map

vendor/drush/drush/drush pm-enable --yes bootstrap divseek_theme
vendor/drush/drush/drush vset theme_default divseek_theme

/bin/bash
