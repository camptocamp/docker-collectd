#!/bin/bash -e
# Setup login
openssl aes-256-cbc -K $encrypted__key -iv $encrypted__iv -in .dockercfg.enc -out ~/.dockercfg -d
if [ "$TRAVIS_BRANCH" == "master" ]; then
  echo "Deploying image to docker hub for master (latest)"
  docker push "camptocamp/:latest"
elif [ ! -z "$TRAVIS_TAG" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Deploying image to docker hub for tag ${TRAVIS_TAG}"
  docker push "camptocamp/:${TRAVIS_TAG}"
elif [ ! -z "$TRAVIS_BRANCH" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo "Deploying image to docker hub for branch ${TRAVIS_BRANCH}"
  docker push "camptocamp/:${TRAVIS_BRANCH}"
else
  echo "Not deploying image"
fi
