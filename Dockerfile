# The most recent version of Drupal 7 with PHP 7.4 and Apache2
FROM drupal:7-apache-buster

MAINTAINER Lacey-Anne Sanderson <laceyannesanderson@gmail.com>

USER root

COPY . /app

RUN chmod -R +x /app && apt-get update 1> ~/aptget.update.log \
  && apt-get install git unzip zip wget gnupg2 supervisor --yes -qq 1> ~/aptget.extras.log

########## PostgreSQL ###########################

# This seems to be needed though I'm not sure why.
# See https://stackoverflow.com/questions/51033689/how-to-fix-error-on-postgres-install-ubuntu
RUN mkdir -p /usr/share/man/man1 && mkdir -p /usr/share/man/man7

# Add PostgreSQL's repository.
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
#  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install PostgreSQL 11
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install postgresql-11 postgresql-client-11 postgresql-contrib-11 --yes -qq 1> ~/aptget.postgresql.log

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-11`` package when it was ``apt-get installed``
USER postgres

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN cp /app/default_files/postgresql/pg_hba.conf /etc/postgresql/11/main/pg_hba.conf

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
RUN    /etc/init.d/postgresql start \
    && psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" \
    && createdb -O docker docker \
    && export PGPASSWORD='docker'

# Expose the PostgreSQL port
EXPOSE 5432

USER root

########## Drupal Additions #####################
WORKDIR /var/www/html
RUN chmod a+x /app/init_scripts/composer-init.sh \
  && /app/init_scripts/composer-init.sh \
  && vendor/bin/drush --version

########## Tripal ###############################
WORKDIR /var/www/html/sites/all/modules
RUN org='tripal' && repo='tripal' \
  && url="https://api.github.com/repos/$org/$repo/releases/latest" \
  && latest=`curl -s $url |  grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/'` \
  && echo "github/$org/$repo version $latest" \
  && git config --global advice.detachedHead false \
  && git clone --quiet https://github.com/$org/$repo.git --branch=$latest tripal

########## Crop Modules #########################
ARG DL_MODULES="advanced_help ctools date dragndrop_upload ds entity field_formatter_class field_formatter_settings field_group field_group_table jquery_update libraries link maillog memcache panels queue_ui redirect services ultimate_cron views webform"
RUN /var/www/html/vendor/bin/drush --quiet dl $DL_MODULES \
  && chmod a+x /app/init_scripts/clone_github_modules.sh \
  && /app/init_scripts/clone_github_modules.sh   \
  && git clone --quiet https://gitlab.com/mainlabwsu/tripal_map.git tripal_map \
  && cp -R /app/libraries/* /var/www/html/sites/all/libraries/ \
  && cp -R /app/themes/* /var/www/html/sites/all/themes/

RUN  chmod a+r -R /var/www/html/sites/all \
  && chown -R www-data:www-data /var/www/html/sites/all \
  && chmod +x /app/init_scripts/startup_container.sh
