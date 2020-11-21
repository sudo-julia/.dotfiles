#!/usr/bin/env bash

# kill any running instances
killall -q polybar

# set polybar on both monitors
if type "xrandr" > /dev/null; then
    for m in $( polybar -m | cut -d':' -f1 ); do
	MONITOR=$m polybar --reload jambar >> /tmp/polybar1.log 2>&1 &
    done
else
    polybar --reload jambar >> /tmp/polybar1.log 2>&1 &
fi
