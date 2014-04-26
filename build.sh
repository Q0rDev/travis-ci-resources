#!/usr/bin/env bash

# Check if commit is not a pull request, if git repo is official, and if branch is master. If checks pass, deploy artifacts to Maven repository.
if [[ $TRAVIS_PULL_REQUEST = "false" ]] && [[ $TRAVIS_REPO_SLUG = "Q0rDev/"* ]] && [[ $TRAVIS_BRANCH = "master" ]]; then
  mvn deploy -Dmaven.test.skip=true -Dcommit=${TRAVIS_COMMIT:0:7} --settings target/travis/settings.xml > build.txt
  grep -v "Download" build.txt
  
  grep -q "BUILD SUCCESS" build.txt
  exit $?;
# If above check fails, just package.
else
  mvn package -Dmaven.test.skip=true -Dcommit=${TRAVIS_COMMIT:0:7} > build.txt
  grep -v "Download" build.txt
  
  grep -q "BUILD SUCCESS" build.txt
  exit $?;
fi
