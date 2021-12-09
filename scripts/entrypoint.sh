#!/bin/bash
set -e

echo "entrypoint() ..."

# init drupal if not done or version updated, otherwise run re-init
flock -x ${SITE_DIR}/.init-lock -c 'echo "waiting for .init-lock to be released ..."'
if [[ "$(cat ${SITE_DIR}/.init-done)" != "$DRUPAL_IMAGE_TAG" ]]; then
  flock -x ${SITE_DIR}/.init-lock -c './init_drupal.sh'
else
  flock -x ${SITE_DIR}/.init-lock -c './reinit_drupal.sh'
fi

# run php-fpm
docker-php-entrypoint php-fpm
