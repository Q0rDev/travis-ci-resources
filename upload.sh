#!/usr/bin/env bash

# Check if commit is not a pull request, if git repo is official, and if branch is master. If checks pass, upload artifacts to Bukkit.
if [[ $TRAVIS_PULL_REQUEST = "false" ]] && [[ $TRAVIS_REPO_SLUG = "Q0rDev/"* ]] && [[ $TRAVIS_BRANCH = "master" ]]; then
    # Find file to upload.
    file=$(find -L . -name "*.jar");

    # Check to make sure File is found and isn't a Snapshot.
    if [ -n "$file" ] && echo "$file" | grep -v -q "SNAPSHOT"; then
        # Set Type to Beta or Release.
        if echo "$file" | grep -v -q "BETA"; then
            type="r"
        else
            type="b"
        fi
    
        # Upload to Bukkit.
        curl -X POST -F "api_key=$BUKKIT_API_KEY" -F "commit=${TRAVIS_COMMIT:0:7}" -F "file=@$file" -F "file_type=$type" -F "slug=$TRAVIS_REPO_SLUG" http://q0r.ca/ci/upload/;
    fi
    
    # Adds blank file if Build fails.
    if [[ -z "$file" ]]; then
        file="/tmp/$RANDOM.$RANDOM"
        echo -n "" > $file
    fi
    
    # Upload to AWS.
    curl -X POST -F "commit=${TRAVIS_BUILD_NUMBER}-${TRAVIS_COMMIT:0:7}" -F "slug=$TRAVIS_REPO_SLUG" -F "secret=$AWS_SECRET" -F "file=@$file" http://q0r.ca/ci/aws/;
   
fi
