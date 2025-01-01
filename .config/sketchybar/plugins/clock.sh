#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set "$NAME" label="$(date '+%d/%m %H:%M')"

# sketchybar --add item clock right \
#            --set clock update_freq=1 \
#            --set clock script="date '+%H:%M'"
