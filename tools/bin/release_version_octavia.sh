#!/usr/bin/env bash

set -e

. tools/lib/lib.sh

# if [[ -z "${DOCKER_PASSWORD}" ]]; then
#   echo 'DOCKER_PASSWORD for airbytebot not set.';
#   exit 1;
# fi

#docker login -u airbytebot -p "${DOCKER_PASSWORD}"

source ./tools/bin/bump_version.sh

echo "Building and publishing OCTAVIA version ${NEW_VERSION} for git revision ${GIT_REVISION}..."
VERSION=$NEW_VERSION SUB_BUILD=OCTAVIA_CLI ./gradlew clean build
./octavia-cli/publish.sh ${NEW_VERSION} ${GIT_REVISION}
echo "Completed building and publishing OCTAVIA..."
