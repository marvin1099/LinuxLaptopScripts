#!/bin/bash
for var in "$@"
do
    fullpath=$var
    fullname=$(basename "$fullpath")
    path="$(dirname "$fullpath")/"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo "\"$fullpath\" -p \"${path}${filename} Send.pdf\""
    xournalpp "$fullpath" -p "${path}${filename} Send.pdf"
    ret=$?
    if [[ $ret != 0 ]]
    then
        xournalpp "$fullpath"
        xournalpp "$fullpath" -p "${path}${filename} Send.pdf"
    fi
done
