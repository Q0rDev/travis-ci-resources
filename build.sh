#!/usr/bin/env bash

# Check if commit is not a pull request, if git repo is official, and if branch is master. If checks pass, deploy artifacts to Maven repository.
if [[ $TRAVIS_PULL_REQUEST = "false" ]] && [[ $TRAVIS_REPO_SLUG = "Q0rDev/"* ]] && [[ $TRAVIS_BRANCH = "master" ]]; then
  mvn deploy -DbuildNumber=b${TRAVIS_BUILD_NUMBER}trvs --settings target/travis/settings.xml
# If above check fails, just package.
else
  mvn package -DbuildNumber=b${TRAVIS_BUILD_NUMBER}trvs
fi
