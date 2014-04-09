#!/usr/bin/env bash

# Only to be used with MChat
if [[ $TRAVIS_REPO_SLUG = "Q0rDev/MChat" ]]; then
  wget -q -P target http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.6.linux.bin.tar.gz & wait
  tar -xf target/doxygen-*.tar.gz -C target
  chmod +x target/doxygen-*/bin/doxygen
  
  ./target/doxygen-*/bin/doxygen ${TRAVIS_BUILD_DIR}/target/travis/Doxyfile & wait
  
  cd ${TRAVIS_BUILD_DIR}/target/doxy/
  
  git config --global user.email "MiracleM4n@gmail.com"
  git config --global user.name "MiracleM4n"
  git config --global push.default simple
  
  git add --all
  git commit -m "$(curl -sS -X POST -F "commit=${TRAVIS_COMMIT:0:7}" http://q0r.ca/ci/commit.php)"
  git push https://Q0r-JD:${GH_PASSWORD}@github.com/Q0rDev/q0rdev-javadocs
fi
