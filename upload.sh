#!/usr/bin/env bash

file=$(find -L . -name "*.jar");

if echo "$file" | grep -v -q "SNAPSHOT"; then
    if echo "$file" | grep -v -q "BETA"; then
        type="r"
    else
        type="b"
    fi
    
    curl -X POST -F "api_key=$BUKKIT_API_KEY" -F "commit=$TRAVIS_COMMIT" -F "file=@$file" -F "file_type=$type" -F "slug=$TRAVIS_REPO_SLUG" http://q0r.ca/ci/upload.php;
fi
