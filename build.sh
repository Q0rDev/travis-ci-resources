#!/usr/bin/env bash

# Check if commit is not a pull request, if git repo is official, and if branch is master. If checks pass, deploy artifacts to Maven repository.
if [[ $TRAVIS_PULL_REQUEST = "false" ]] && [[ $TRAVIS_REPO_SLUG = "Q0rDev/"* ]] && [[ $TRAVIS_BRANCH = "master" ]]; then
  mvn deploy -Dcommit=${TRAVIS_COMMIT:0:7}git --settings target/travis/settings.xml
# If above check fails, just package.
else
  mvn package -Dcommit=${TRAVIS_COMMIT:0:7}git
fi
