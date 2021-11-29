#!/bin/bash
set -e

echo "init_filesystems() ..."

# TODO: check if migration fs is mounted, migrate data if it is

# init mounted filesystems (ECS Fargate EFS limitation forces this approach)
echo "initializing ${SITE_DIR}, ${THEME_DIR}, ${CORE_DIR} & ${WWW_DIR}/resources ..."
rsync -au ${BASE_DIR}/sites/ ${SITE_DIR} &
rsync -au ${BASE_DIR}/themes/ ${THEME_DIR} &
rsync -au ${BASE_DIR}/core/ ${CORE_DIR} &
rsync -au --delete ${BASE_DIR}/resources/ ${WWW_DIR}/resources &
wait
