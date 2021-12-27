#
# Drupal build
#
FROM drupal:9.2-php7.4-fpm-buster AS drupal_build

# upgrade system + install required packages
RUN apt-get update -yq && \
    apt-get upgrade -yq && \
    apt-get install -yq \
      unzip \
      git \
      rsync \
      postgresql-client \
      python3 \
      python3-pip \
      procps && \
    pip3 install \
      jinja2-cli

# setup env vars
ENV APP_DIR=/opt/drupal
ENV SCRIPT_DIR=${APP_DIR}/scripts
ENV TEMPLATE_DIR=${APP_DIR}/templates
ENV I18N_DIR=${APP_DIR}/i18n
ENV WEB_DIR=${APP_DIR}/web
ENV SITE_DIR=${WEB_DIR}/sites
ENV MOD_DIR=${WEB_DIR}/modules
ENV THEME_DIR=${WEB_DIR}/themes
ENV CORE_DIR=${WEB_DIR}/core
ENV BASE_DIR=/opt/base

# copy app files
COPY drupal/i18n ${I18N_DIR}
COPY drupal/scripts ${SCRIPT_DIR}
COPY drupal/site_config ${APP_DIR}/site_config
COPY drupal/templates ${TEMPLATE_DIR}
COPY drupal/composer.json ${APP_DIR}/composer.json
COPY drupal/composer.lock ${APP_DIR}/composer.lock
RUN chmod +x ${SCRIPT_DIR}/*.sh && \
    mkdir -p ${SITE_DIR}/default/sync && \
    chown -R www-data:www-data ${SITE_DIR}/default/sync && \
    mkdir -p ${SITE_DIR}/default/files && \
    chown -R www-data:www-data ${SITE_DIR}/default/files

# install composer project
RUN composer install --no-cache

#
# Development image (For local development)
#
FROM drupal_build as drupal_development

ENV DEV_MODE=true

ENTRYPOINT ["/opt/drupal/scripts/entrypoint.sh"]

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

# setup env vars:
ENV APP_DIR=/opt/drupal
ENV WEB_DIR=${APP_DIR}/web
ENV MOD_DIR=${WEB_DIR}/modules

# copy custom modules
RUN mkdir -p ${MOD_DIR}
COPY modules/avoindata-header               ${MOD_DIR}/avoindata-header/
COPY modules/avoindata-servicemessage       ${MOD_DIR}/avoindata-servicemessage/
COPY modules/avoindata-hero                 ${MOD_DIR}/avoindata-hero/
COPY modules/avoindata-categories           ${MOD_DIR}/avoindata-categories/
COPY modules/avoindata-infobox              ${MOD_DIR}/avoindata-infobox/
COPY modules/avoindata-datasetlist          ${MOD_DIR}/avoindata-datasetlist/
COPY modules/avoindata-newsfeed             ${MOD_DIR}/avoindata-newsfeed/
COPY modules/avoindata-appfeed              ${MOD_DIR}/avoindata-appfeed/
COPY modules/avoindata-footer               ${MOD_DIR}/avoindata-footer/
COPY modules/avoindata-articles             ${MOD_DIR}/avoindata-articles/
COPY modules/avoindata-events               ${MOD_DIR}/avoindata-events/
COPY modules/avoindata-guide                ${MOD_DIR}/avoindata-guide/
COPY modules/avoindata-user                 ${MOD_DIR}/avoindata-user/
COPY modules/avoindata-ckeditor-plugins     ${MOD_DIR}/avoindata-ckeditor-plugins/
COPY modules/avoindata-theme                ${MOD_DIR}/avoindata-theme/

# copy frontend
COPY modules/ytp-assets-common              ${MOD_DIR}/ytp-assets-common/
COPY drupal/gulpfile.js                     ${APP_DIR}/gulpfile.js
COPY drupal/build_frontend.sh               ${APP_DIR}/build_frontend.sh
COPY drupal/package.default.json            ${APP_DIR}/package.default.json

# build frontend
WORKDIR ${APP_DIR}
RUN cp -f ${MOD_DIR}/ytp-assets-common/package.json ${APP_DIR} && \
    cp -f ${MOD_DIR}/ytp-assets-common/.stylelintrc ${APP_DIR} && \
    cp -f ${MOD_DIR}/ytp-assets-common/.stylelintignore ${APP_DIR} && \
    chmod +x ./build_frontend.sh
RUN --mount=type=secret,id=npmrc ./build_frontend.sh

#
# Production image
#
FROM drupal_build

# copy modules and themes
COPY --from=modules_build ${MOD_DIR} ${MOD_DIR}
RUN mv ${MOD_DIR}/avoindata-theme ${THEME_DIR}/avoindata/

# setup base directory that is used for initializing shared file systems
RUN mkdir -p ${BASE_DIR} && \
    mv ${SITE_DIR} ${BASE_DIR}/sites && \
    mv ${THEME_DIR} ${BASE_DIR}/themes && \
    mv ${CORE_DIR} ${BASE_DIR}/core && \
    mkdir -p ${SITE_DIR} && \
    mkdir -p ${THEME_DIR} && \
    mkdir -p ${CORE_DIR}

ENTRYPOINT ["/opt/drupal/scripts/entrypoint.sh"]
