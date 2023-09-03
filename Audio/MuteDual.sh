#!/bin/bash

if [[ $(pactl get-sink-mute media | awk '/yes/') ]]
then
    pactl set-sink-mute media 0
    pactl set-sink-mute them 0
    notify-send -t 5000 -i audio -a "Keyboard" "Unmuted System"
else
    pactl set-sink-mute media 1
    pactl set-sink-mute them 1
    notify-send -t 5000 -i notification-audio-volume-off -a "Keyboard" "Muted System"
fi
