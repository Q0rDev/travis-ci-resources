#!/usr/bin/env bash

# Check if commit is not a pull request, if git repo is MChat, and if branch is master. If checks pass, create and upload Doxygen files.
if [[ $TRAVIS_PULL_REQUEST = "false" ]] && [[ $TRAVIS_REPO_SLUG = "Q0rDev/MChat" ]] && [[ $TRAVIS_BRANCH = "master" ]]; then
  # Doxygen: Get / Extract / Set Executable.
  wget -q -P target http://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.6.linux.bin.tar.gz & wait
  tar -xf target/doxygen-*.tar.gz -C target
  chmod +x target/doxygen-*/bin/doxygen
  
  # Run Doxygen.
  ./target/doxygen-*/bin/doxygen ${TRAVIS_BUILD_DIR}/target/travis/Doxyfile & wait
  
  # Change to target directory.
  cd ${TRAVIS_BUILD_DIR}/target/doxy/
  
  # Set Git config values.
  git config --global user.email "MiracleM4n@gmail.com"
  git config --global user.name "MiracleM4n"
  git config --global push.default simple
 
  # Push to Github. 
  git add --all
  git commit -m "$(curl -sS -X POST -F "commit=${TRAVIS_COMMIT:0:7}" http://q0r.ca/ci/commit.php)"
  git push https://Q0r-JD:${GH_PASSWORD}@github.com/Q0rDev/q0rdev-javadocs --quiet > /dev/null
  
fi
