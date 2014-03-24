#!/usr/bin/env bash

file=$(find -L . -name "*.jar");

if echo "$file" | grep -v -q "SNAPSHOT"; then
    curl -X POST -F "commit=$1" -F "type=$2" -F "key=$BUKKIT_API_KEY" -F "file=@$file" http://pc-serv.ca/ci_upload.php;
fi
