#!/bin/bash
set -e

if [[ "${DEV_MODE}" == "true" ]]; then
    # don't do anything because folders are mounted from host
    echo "init_filesystems() ... skipping because DEV_MODE == ${DEV_MODE} ..."
else
    # init mounted filesystems (ECS Fargate EFS limitation forces this approach)
    echo "init_filesystems() initializing ${SITE_DIR}, ${THEME_DIR}, ${CORE_DIR} & ${WWW_DIR}/resources ..."
    rsync -au ${BASE_DIR}/sites/ ${SITE_DIR} &
    rsync -au ${BASE_DIR}/themes/ ${THEME_DIR} &
    rsync -au ${BASE_DIR}/core/ ${CORE_DIR} &
    rsync -au --delete ${BASE_DIR}/resources/ ${WWW_DIR}/resources &
    wait
fi