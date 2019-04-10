#!/bin/bash

# Set these environment variables
#DOCKER_TAG // build id
#ORG // optional

set -e

ORG=${ORG:-dolmit}
DOCKER_IMAGE=pelias-data-container-builder
#DOCKER_TAG=${DOCKER_TAG:-$TRAVIS_BUILD_ID}
DOCKER_TAGGED_IMAGE=$ORG/$DOCKER_IMAGE #:$DOCKER_TAG

# Build image
docker build -t="$DOCKER_TAGGED_IMAGE" -f Dockerfile.builder .

#if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
    docker login -u $DOCKER_USER -p $DOCKER_AUTH $ORG
    docker push $ORG/$DOCKER_IMAGE #:$DOCKER_TAG
   # docker tag $ORG/$DOCKER_IMAGE:$DOCKER_TAG $ORG/$DOCKER_IMAGE:latest
    docker tag $ORG/$DOCKER_IMAGE $ORG/$DOCKER_IMAGE:latest
    docker push $ORG/$DOCKER_IMAGE:latest
#fi

echo "$DOCKER_IMAGE built and deployed"
