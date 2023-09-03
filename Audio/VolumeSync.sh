#!/bin/bash
setchange=0
setmultiply=10
clampvol=100
plasmachange=5 #Set this to what plasma changes the volume by to get a correct audio overlay
if [[ $1 == "lower" ]]
then
    setchange=-1
fi
if [[ $1 == "raise" ]]
then
    setchange=1
fi
setchange=$((setchange*setmultiply))

all=$(pactl list short | awk '!/\.monitor/ && (/bluez_output/ || /alsa_output/ || $2 ~ /media/ || $2 ~ /them/) {print $1}')

#qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "decrease_volume"
nvo=0
for i in $all
do
    vol=$(pactl get-sink-volume $i | awk '{print substr($5,1,length($5)-1)}')
    if [[ $vol -gt $nvo ]]
    then
        nvo=$vol
    fi
done

nvo=$((nvo+setchange))
if [[ $nvo -gt $clampvol ]]
then
    nvo=$clampvol
elif [[ $nvo -lt 0 ]]
then
    nvo=0
fi

send=0
if [[ $setchange -gt 0 && $nvo -lt $((clampvol-plasmachange+1)) ]] # volume no bigger then chlapvolume - plasmachange
then
    send=1
    num=$((nvo-plasmachange))
    for i in $all
    do
        pactl set-sink-volume $i $num%
    done
elif [[ $setchange -lt 0 && $nvo -gt $((0+plasmachange-1)) ]]
then
    send=-1
    num=$((nvo+plasmachange))
    for i in $all
    do
        pactl set-sink-volume $i $num%
    done
elif [[ $nvo -gt 50 ]]
then
    send=1
    num=$((nvo-plasmachange))
    for i in $all
    do
        pactl set-sink-volume $i $num%
    done
else
    send=-1
    num=$((nvo+plasmachange))
    for i in $all
    do
        pactl set-sink-volume $i $num%
    done
fi

if [[ $send == 1 ]]
then
    qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "increase_volume"
elif [[ $send == -1 ]]
then
    qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "decrease_volume"
fi

for i in $all
do
    pactl set-sink-volume $i $nvo%
    #echo set-sink-volume of $i to $nvo
done
