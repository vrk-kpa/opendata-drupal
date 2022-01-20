#!/bin/bash
set -e

if [[ "${DEV_MODE}" == "true" ]]; then
  # init mounted filesystems
  echo "init_filesystems - DEV_MODE = 'true', initializing '${WWW_DIR}/resources' and installing fonts ..."
  rsync -au --delete ${MOD_DIR}/opendata-assets/resources/ ${WWW_DIR}/resources
  cp -rf ${WWW_DIR}/resources/vendor/@fortawesome/fontawesome/webfonts/.  ${THEME_DIR}/avoindata/fonts && \
  cp -rf ${WWW_DIR}/resources/vendor/bootstrap/dist/fonts/.               ${THEME_DIR}/avoindata/fonts
else
  # init mounted filesystems if not done or version updated (ECS Fargate EFS limitation forces this approach)
  if [[ "$(cat ${SITE_DIR}/.fs-done)" != "$DRUPAL_IMAGE_TAG" ]]; then
    echo "init_filesystems - initializing '${SITE_DIR}', '${THEME_DIR}', '${CORE_DIR}' & '${WWW_DIR}/resources' ..."
    rsync -au ${BASE_DIR}/sites/ ${SITE_DIR} &
    rsync -au ${BASE_DIR}/themes/ ${THEME_DIR} &
    rsync -au ${BASE_DIR}/core/ ${CORE_DIR} &
    rsync -au --delete ${BASE_DIR}/resources/ ${WWW_DIR}/resources &
    wait
    # set init flag to done
    echo "$DRUPAL_IMAGE_TAG" > ${SITE_DIR}/.fs-done
  fi
fi
