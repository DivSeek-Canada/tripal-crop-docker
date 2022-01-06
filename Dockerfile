# PHP 8.0 and Apache2 on Debian 11 bullseye (Released Aug2021; supported until Aug2026)
# Cannot use drupal image (https://hub.docker.com/_/drupal) as no Drupal7 + php 8 version
FROM php:8.0-apache-bullseye

MAINTAINER Lacey-Anne Sanderson <laceyannesanderson@gmail.com>

USER root

COPY . /app

RUN chmod -R +x /app && apt-get update 1> ~/aptget.update.log \
  && apt-get install git unzip zip wget gnupg2 supervisor --yes -qq 1> ~/aptget.extras.log

########## Drupal 7 #############################
# Inspired by the Drupal 7 + php 7.4 and the Drupal 9 + php 8 Dockerfiles
# https://github.com/docker-library/drupal/blob/master/7/php7.4/apache-bullseye/Dockerfile
# https://github.com/docker-library/drupal/blob/master/9.2/php8.0/apache-bullseye/Dockerfile

# install the PHP extensions we need
RUN set -eux; \
	\
	if command -v a2enmod; then \
		a2enmod rewrite; \
	fi; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libfreetype6-dev \
		libjpeg-dev \
		libpng-dev \
		libpq-dev \
		libzip-dev \
	; \
	\
	docker-php-ext-configure gd \
		--with-freetype \
		--with-jpeg=/usr \
	; \
	\
	docker-php-ext-install -j "$(nproc)" \
		gd \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		zip \
	; \
	\
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 7.84
ENV DRUPAL_MD5 1d270b00fbbb87a81776202eec1f848e

WORKDIR /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/

RUN set -eux; \
	curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz; \
	echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c -; \
	tar -xz --strip-components=1 -f drupal.tar.gz; \
	rm drupal.tar.gz; \
	chown -R www-data:www-data sites modules themes

########## PostgreSQL ###########################

# This seems to be needed though I'm not sure why.
# See https://stackoverflow.com/questions/51033689/how-to-fix-error-on-postgres-install-ubuntu
RUN mkdir -p /usr/share/man/man1 && mkdir -p /usr/share/man/man7

# Add PostgreSQL's repository.
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
#  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install PostgreSQL 13
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install postgresql-13 postgresql-client-13 postgresql-contrib-13 --yes -qq 1> ~/aptget.postgresql.log

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-13`` package when it was ``apt-get installed``
USER postgres

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN cp /app/default_files/postgresql/pg_hba.conf /etc/postgresql/13/main/pg_hba.conf

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
RUN    /etc/init.d/postgresql start \
    && psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" \
    && createdb -O docker docker \
    && export PGPASSWORD='docker'

# Expose the PostgreSQL port
EXPOSE 5432

USER root

########## CERTBOT ##############################
RUN apt-get update  --yes -qq 1> ~/aptget.update.2.log \
  && apt-get install certbot --yes -qq 1> ~/aptget.certbot.log

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
