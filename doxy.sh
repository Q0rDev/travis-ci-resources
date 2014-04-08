#!/usr/bin/env bash

# Only to be used with MChat
if [[ $TRAVIS_REPO_SLUG = "Q0rDev/MChat" ]]; then
  doxygen ${TRAVIS_BUILD_DIR}/target/travis/DoxyFile & wait

  cd ${TRAVIS_BUILD_DIR}/target/doxy/
  git add --all
  git commit -m ${TRAVIS_COMMIT_MESSAGE}
  git push https://Q0r-JD:${GH_PASSWORD}@github.com/Q0rDev/q0rdev-javadocs
fi
