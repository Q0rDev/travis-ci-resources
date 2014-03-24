#!/usr/bin/env bash

file=$(find -L . -name "*.jar");

if echo "$file" | grep -v -q "SNAPSHOT"; then
    if echo "$file" | grep -v -q "BETA"; then
        type="r"
    else
        type="b"
    fi
    
    curl -X POST -F "branch=$TRAVIS_BRANCH" -F "commit=$TRAVIS_COMMIT" -F "file=@$file" -F "file_type=$type" -F "job=$TRAVIS_BUILD_NUMBER" -F "key=$BUKKIT_API_KEY" http://pc-serv.ca/ci/upload.php;
fi
