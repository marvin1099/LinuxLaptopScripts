#!/bin/bash
nr=1
wd=$(pwd)
first=""
rm -r "/tmp/pdf-a4-merge-now"
mkdir "/tmp/pdf-a4-merge-now"
notify-send -t 30000 -i application-pdf -a "PDF" "Merging Pages"
for var in "$@"
do
    fullpath=$var
    fullname=$(basename "$fullpath")
    path="$(dirname "$fullpath")/"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    if [[ $first == "" ]]
    then
        first="${path}${filename} merge.pdf"
    fi
    echo "\"$fullpath\" \"${path}${filename}-xx.png\""
    rm -r "/tmp/pdf-a4-merge-pas"
    mkdir "/tmp/pdf-a4-merge-pas"
    convert "$fullpath" "/tmp/pdf-a4-merge-pas/p.png"
    cd "/tmp/pdf-a4-merge-pas"
    pnr=1
    for f in $(ls --color=never -1)
    do
        orient=$(identify -format '%w %h' "${f}" | awk '{printf int($1/$2+0.99999)}')
        if [[ $orient -gt 1 ]]
        then
            pdfjam --paper a4paper --landscape --outfile "${f}.pdf" "${f}"
        else
            pdfjam --paper a4paper --outfile "${f}.pdf" "${f}"
        fi
        if [[ $pnr == 1 ]]
        then
            pnr=2
            cp "$f.pdf" "pdf.pdf"
        else
            pdfunite "pdf.pdf" "$f.pdf" "pdft.pdf"
            cp "pdft.pdf" "pdf.pdf"
        fi
    done
    cp "pdf.pdf" "/tmp/pdf-a4-merge-now/${filename}-temp.pdf"
    sleep 4
    rm -r "/tmp/pdf-a4-merge-pas"
    cd $wd
    if [[ $nr == 1 ]]
    then
        nr=2
        cp "/tmp/pdf-a4-merge-now/${filename}-temp.pdf" "/tmp/pdf-a4-merge-now/pdf.pdf"
    else
        pdfunite "/tmp/pdf-a4-merge-now/pdf.pdf" "/tmp/pdf-a4-merge-now/${filename}-temp.pdf" "/tmp/pdf-a4-merge-now/pdft.pdf"
        cp "/tmp/pdf-a4-merge-now/pdft.pdf" "/tmp/pdf-a4-merge-now/pdf.pdf"
    fi
done
cp "/tmp/pdf-a4-merge-now/pdf.pdf" "${first}"
notify-send -t 30000 -i application-pdf -a "PDF" "Done Merging Pages"
rm -r "/tmp/pdf-a4-merge-now"
