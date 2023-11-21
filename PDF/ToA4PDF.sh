#!/bin/bash
for var in "$@"
do
    wd=$(pwd)
    fullpath=$var
    fullname=$(basename "$fullpath")
    path="$(dirname "$fullpath")/"
    extension="${fullname##*.}"
    filename="${fullname%.*}"
    echo "\"$fullpath\"  \"${path}${filename}.pdf\""
    #cp "$fullpath" "${path}${filename}${extension}"
    #libreoffice --convert-to pdf "${path}${filename} Send.${extension}"
    #rm "${path}${filename} Send.${extension}"
    if [[ $extension == "png" || $extension == "pdf" && $(pdfinfo "$fullpath" | awk '/Pages:/ {print $2}') == 1 ]]
    then
        orient=$(identify -format '%w %h' "$fullpath" | awk '{printf int($1/$2+0.99999)}')
        if [[ $orient -gt 1 ]]
        then
            pdfjam --paper a4paper --landscape --outfile "${path}${filename}.pdf" "$fullpath"
        else
            pdfjam --paper a4paper --outfile "${path}${filename}.pdf" "$fullpath"
        fi
    elif [[ $extension == "pdf" ]]
    then
        notify-send -t 30000 -i application-pdf -a "PDF" "Converting pages"
        rm -r "/tmp/${filename}-pdftemp"
        mkdir "/tmp/${filename}-pdftemp"
        #pdftoppm "-png" "-r" "300" "$fullpath" "/tmp/${filename}-pdftemp/p" #To slow
        convert -density 300 "$fullpath" -quality 100 "/tmp/${filename}-pdftemp/p.png"
        cd "/tmp/${filename}-pdftemp/"
        nr=1
        l=""
        for f in $(ls --color=never -1)
        do
            echo "file is $f"
            orient=$(identify -format '%w %h' "$f" | awk '{printf int($1/$2+0.99999)}')
            if [[ $orient -gt 1 ]]
            then
                pdfjam --paper a4paper --landscape --outfile "$f.pdf" "$f"
            else
                pdfjam --paper a4paper --outfile "$f.pdf" "$f"
            fi
            if [[ $nr == 1 ]]
            then
                nr=2
                cp "$f.pdf" "pdf.pdf"
            else
                pdfunite "pdf.pdf" "$f.pdf" "pdft.pdf"
                cp "pdft.pdf" "pdf.pdf"
            fi
        done
        cd $wd
        cp "/tmp/${filename}-pdftemp/pdf.pdf" "${path}${filename}.pdf"
        notify-send -t 30000 -i application-pdf -a "PDF" "Done converting pages to A4"
        rm -r "/tmp/${filename}-pdftemp"
    fi
done
