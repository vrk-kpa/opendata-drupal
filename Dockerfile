#
# Drupal build
#
FROM drupal:9.2-fpm-buster AS drupal_build

# install required packages
RUN apt-get update -yq && \
    apt-get install -yq unzip \
                    git \
                    postgresql-client \
                    rsync \
                    python3 \
                    python3-pip \
                    procps && \
    pip3 install jinja2-cli

# setup env vars
ENV WEB_DIR=/opt/drupal/web
ENV SITE_DIR=${WEB_DIR}/sites
ENV MOD_DIR=${WEB_DIR}/modules
ENV THEME_DIR=${WEB_DIR}/themes
ENV CORE_DIR=${WEB_DIR}/core
ENV BASE_DIR=/opt/drupal_base
ENV WWW_DIR=/var/www

# make sure config sync/files directories exist
RUN mkdir -p ${SITE_DIR}/default/sync && \
    chown -R www-data:www-data ${SITE_DIR}/default/sync && \
    mkdir -p ${SITE_DIR}/default/files && \
    chown -R www-data:www-data ${SITE_DIR}/default/files

# copy translations
COPY i18n /opt/i18n

# copy scripts
COPY scripts/ /opt/drupal/
RUN chmod +x /opt/drupal/*.sh

# copy site config
COPY site_config /opt/drupal/site_config

# copy templates
COPY templates /opt/templates

# install composer project
COPY composer.json /opt/drupal/composer.json
COPY composer.lock /opt/drupal/composer.lock
RUN composer install --no-cache

#
# Development image (For local development)
#
FROM drupal_build as drupal_development

ENV DEV_MODE=true

ENTRYPOINT ["/opt/drupal/entrypoint.sh"]

#
# Modules build (for production)
#
FROM ubuntu:focal AS modules_build

# build args
ARG SECRET_NPMRC

# install required packages
RUN apt-get update -yq && apt-get install -yq curl

# install nodejs via nodesource & frontend requirements
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -yq nodejs libjpeg-turbo8
RUN node --version && npm --version && npm install -g gulp

# copy custom modules
COPY modules/avoindata-header            /opt/drupal_modules/avoindata-header/
COPY modules/avoindata-servicemessage    /opt/drupal_modules/avoindata-servicemessage/
COPY modules/avoindata-hero              /opt/drupal_modules/avoindata-hero/
COPY modules/avoindata-categories        /opt/drupal_modules/avoindata-categories/
COPY modules/avoindata-infobox           /opt/drupal_modules/avoindata-infobox/
COPY modules/avoindata-datasetlist       /opt/drupal_modules/avoindata-datasetlist/
COPY modules/avoindata-newsfeed          /opt/drupal_modules/avoindata-newsfeed/
COPY modules/avoindata-appfeed           /opt/drupal_modules/avoindata-appfeed/
COPY modules/avoindata-footer            /opt/drupal_modules/avoindata-footer/
COPY modules/avoindata-articles          /opt/drupal_modules/avoindata-articles/
COPY modules/avoindata-events            /opt/drupal_modules/avoindata-events/
COPY modules/avoindata-guide             /opt/drupal_modules/avoindata-guide/
COPY modules/avoindata-user              /opt/drupal_modules/avoindata-user/
COPY modules/avoindata-ckeditor-plugins  /opt/drupal_modules/avoindata-ckeditor-plugins/
COPY modules/avoindata-theme             /opt/drupal_modules/avoindata-theme/

# copy frontend
COPY modules/ytp-assets-common                  /opt/drupal_modules/ytp-assets-common/
COPY package.default.json                       /opt/drupal_modules/ytp-assets-common/package.default.json
COPY build_frontend.sh                          /opt/drupal_modules/ytp-assets-common/build_frontend.sh

# build frontend
WORKDIR /opt/drupal_modules/ytp-assets-common
RUN chmod +x ./build_frontend.sh
RUN --mount=type=secret,id=npmrc ./build_frontend.sh

#
# Production image
#
FROM drupal_build

# copy modules and themes
COPY --from=modules_build /opt/drupal_modules ${MOD_DIR}/
RUN mv ${MOD_DIR}/avoindata-theme ${THEME_DIR}/avoindata/

# install frontend
RUN mkdir -p ${WWW_DIR} && mv ${MOD_DIR}/ytp-assets-common/resources ${WWW_DIR}/

# install fonts
RUN cp -rf ${WWW_DIR}/resources/vendor/@fortawesome/fontawesome/webfonts/.  ${THEME_DIR}/avoindata/fonts && \
    cp -rf ${WWW_DIR}/resources/vendor/bootstrap/dist/fonts/.               ${THEME_DIR}/avoindata/fonts

# setup base directory that is used for initializing shared file systems
RUN mkdir -p ${BASE_DIR} && \
    mv ${SITE_DIR} ${BASE_DIR}/sites && \
    mv ${THEME_DIR} ${BASE_DIR}/themes && \
    mv ${CORE_DIR} ${BASE_DIR}/core && \
    mv ${WWW_DIR}/resources ${BASE_DIR}/resources && \
    mkdir -p ${SITE_DIR} && \
    mkdir -p ${THEME_DIR} && \
    mkdir -p ${CORE_DIR} && \
    mkdir -p ${WWW_DIR}/resources

ENTRYPOINT ["/opt/drupal/entrypoint.sh"]
