#!/bin/bash
if [[ $(pactl get-sink-mute $(pactl list short | awk '/alsa_output/ && !/.monitor/ {print $1}' | tail -1) | awk '/yes/') ]]
then
    notify-send -t 5000 -i audio -a "Keyboard" "The Speaker was Unmuted"
else
    notify-send -t 5000 -i notification-audio-volume-off -a "Keyboard" "The Speaker was Muted"
fi
pactl set-sink-mute $(pactl list short | awk '/alsa_output/ && !/.monitor/ {print $1}' | tail -1) toggle
