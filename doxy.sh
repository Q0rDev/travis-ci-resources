#!/usr/bin/env bash

# Only to be used with MChat
if [[ $TRAVIS_REPO_SLUG = "Q0rDev/MChat" ]]; then
  sudo apt-get install -qq doxygen > /dev/null & wait
  doxygen ${TRAVIS_BUILD_DIR}/target/travis/DoxyFile & wait
  
  COMMIT_MESSAGE=$(curl -X POST -F "commit=$TRAVIS_COMMIT" http://q0r.ca/ci/commit.php) & wait
  
  cd ${TRAVIS_BUILD_DIR}/target/doxy/
  git add --all
  git commit -m "${COMMIT_MESSAGE}"
  git push https://Q0r-JD:${GH_PASSWORD}@github.com/Q0rDev/q0rdev-javadocs
fi
