#!/bin/bash
dir=$(dirname "$0")
file="/minimized.txt"
order=$(xprop -root | awk '/NET_CLIENT_LIST_STACKING\(WINDOW\)/ {gsub(",",""); for(i=5;i<=NF;i++){printf "%s\n", strtonum( $i )}}')
focus=""
visible=""
minimized=""
notifyme=false
showdesktop=false
if [[ $1 ]]
then
    notifyme=$1
fi
if [[ $2 ]]
then
    showdesktop=$2
fi

for w in $order
do
    if [[ $notifyme = true && $(xdotool getwindowclassname $w) == "plasmashell" && $(xdotool getwindowname $w) == "Plasma" ]]
    then
        skip=true
    else
        skip=false
    fi
    if [[ $skip = false && $w != "" ]]
    then
        win=$(xwininfo -all -id $w 2>/dev/null)
        if [[ ! $( echo $win | awk '/Below/') ]]
        then
            if [[ $(echo "$win" | awk '/Focused/') ]] #is focused
            then
                focus=$w
            elif [[ $(echo "$win" | awk '/IsViewable/') ]] #is visible
            then
                if [[ $visible == "" ]]
                then
                    visible=$w
                else
                    visible=$visible$'\n'$w
                fi
            else
                if [[ $minimized == "" ]]
                then
                    minimized=$w
                else
                    minimized=$minimized$'\n'$w
                fi
            fi
            if [[ $neword == "" ]]
            then
                neword=$w
            else
                neword=$neword$'\n'$w
            fi
        fi
    fi
done

if [[ ! $visible && ! $focus ]]
then
    visible=$(awk '{print $0}' $dir$file)
fi
rm $dir$file

if [[ ! $focus ]]
then
    for f in $visible
    do
        xdotool windowactivate $f
    done
    xdotool windowactivate $(echo "$neword" | tail -1)
    if [[ $notifyme = true ]]
    then
        notify-send -t 1000 -i window -a "Keyboard" "Reopennig minimized windows"
    fi
else
    #minimize all
    if [[ $notifyme = true ]]
    then
        notify-send -t 1000 -i window -a "Keyboard" "Swiching to Desktop"
    fi
    for f in $visible
    do
        xdotool windowminimize $f
    done
    xdotool windowminimize $focus
    echo "$visible"$'\n'"$focus" > $dir$file
fi

