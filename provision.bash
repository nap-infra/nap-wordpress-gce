#!/bin/bash

VERSION=v0.0.8
REPO_NAME=acd-onix-gce

if [ $# -ne "1" ]; then
    echo "Arguments <dev|prod> are required!!!"
    exit 1
fi

ENVIRONMENT_ALIAS=$1
BRANCH=develop
ENVIRONMENT=development

if [ "${ENVIRONMENT_ALIAS}" == "dev" ]; then
    BRANCH=develop
    ENVIRONMENT=development
elif [ "${ENVIRONMENT_ALIAS}" == "prod" ]; then
    BRANCH=main
    ENVIRONMENT=production
fi

sudo docker run \
-v $(pwd)/${REPO_NAME}-${ENVIRONMENT}:/wip/output \
-v ${HOME}/.ssh/:/root/.ssh/ \
-e IASC_VCS_MODE=git \
-e IASC_VCS_URL="https://github.com/its-software-services-customers/${REPO_NAME}.git" \
-e IASC_VCS_REF=${BRANCH} \
-e ENVIRONMENT_ALIAS=${ENVIRONMENT_ALIAS} \
-e ENVIRONMENT=${ENVIRONMENT} \
-it gcr.io/its-artifact-commons/iasc:${VERSION} \
init

sudo chown -R $(whoami):$(whoami) ${REPO_NAME}-${ENVIRONMENT}
