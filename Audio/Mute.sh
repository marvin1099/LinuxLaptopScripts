#!/bin/bash
if [[ $(pactl get-source-mute $(pactl list short | awk '/alsa_input/ {print $1}' | tail -1) | awk '/yes/') ]]
then
    notify-send -t 5000 -i audio -a "Keyboard" "The Mic was Unmuted"
else
    notify-send -t 5000 -i notification-audio-volume-off -a "Keyboard" "The Mic was Muted"
fi
pactl set-source-mute $(pactl list short | awk '/alsa_input/ {print $1}' | tail -1) toggle
