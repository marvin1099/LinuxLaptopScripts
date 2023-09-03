#!/bin/bash
for var in "$@"
do
    fullpath=$var
    fullname=$(basename "$fullpath")
    path="$(dirname "$fullpath")/"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo "\"$fullpath\"  \"${path}${filename} Send.pdf\""
    cp "$fullpath" "${path}${filename} Send.${extension}"
    libreoffice --convert-to pdf "${path}${filename} Send.${extension}"
    rm "${path}${filename} Send.${extension}"
done
