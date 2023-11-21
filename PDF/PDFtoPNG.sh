#!/bin/bash
for var in "$@"
do
    fullpath=$var
    fullname=$(basename "$fullpath")
    path="$(dirname "$fullpath")/"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo "-png -r 300 \"$fullpath\" \"${path}${filename}-xx.png\""
    #pdftoppm "-png" "-r" "300" "$fullpath" "${path}${filename}"
    convert -density 300 "$fullpath" -quality 100 "${path}${filename}.png"
done

