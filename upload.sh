#!/usr/bin/env bash

# Check if commit is not a pull request, if git repo is official, and if branch is master. If checks pass, upload artifacts to Bukkit.
if [[ $TRAVIS_PULL_REQUEST = "false" ]] && [[ $TRAVIS_REPO_SLUG = "Q0rDev/"* ]] && [[ $TRAVIS_BRANCH = "master" ]]; then
    # Find file to upload.
    file=$(find -L . -name "*.jar");

    # Check to make sure File isn't a Snapshot.
    if echo "$file" | grep -v -q "SNAPSHOT"; then
        # Set Type to Beta or Release.
        if echo "$file" | grep -v -q "BETA"; then
            type="r"
        else
            type="b"
        fi
    
        # Upload to Bukkit.
        curl -X POST -F "api_key=$BUKKIT_API_KEY" -F "commit=${TRAVIS_COMMIT:0:7}" -F "file=@$file" -F "file_type=$type" -F "slug=$TRAVIS_REPO_SLUG" http://q0r.ca/ci/upload.php;
    fi
    
    # Test TRAVIS_TEST_RESULT Variable
    echo $TRAVIS_TEST_RESULT;
fi
