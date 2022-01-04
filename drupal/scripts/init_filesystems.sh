#!/bin/bash
set -e

if [[ "${DEV_MODE}" == "true" ]]; then
  # init mounted filesystems
  echo "init_filesystems - DEV_MODE = 'true', initializing '${WWW_DIR}/resources' ..."
  rsync -au --delete ${MOD_DIR}/opendata-assets/resources/ ${WWW_DIR}/resources
else
  # migrate data if migration fs is mounted to known path
  # NOTE: this is a bad idea, because EFS->EFS rsync perf is so bad!
  #       it's left here as an example, can be deleted later...
  if [[ -d "/mnt/ytp_files/drupal" ]]; then
    echo "init_filesystems - migrating data from '/mnt/ytp_files/drupal' to '${SITE_DIR}/default/files' ..."
    mkdir -p ${SITE_DIR}/default/files && chown -R www-data:www-data ${SITE_DIR}/default
    rsync -au --chown=www-data:www-data /mnt/ytp_files/drupal/ ${SITE_DIR}/default/files
    echo "printing migration source contents:"
    ls -lah /mnt/ytp_files/drupal
    echo "printing migration destination contents:"
    ls -lah ${SITE_DIR}/default/files
  fi

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
