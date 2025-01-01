#!/bin/bash

SPACE_ID=$(echo "$NAME" | sed 's/space\.//')
WINDOWS=$(yabai -m query --windows --space "$SPACE_ID" | jq -r 'map(.app) | join(":")')

if [ -z "$WINDOWS" ] || [ "$WINDOWS" = "null" ]; then
    sketchybar --set "$NAME" \
        icon="$SPACE_ID" \
        label="empty" \
        background.drawing="$SELECTED"
else
    sketchybar --set "$NAME" \
        icon="$SPACE_ID" \
        label="$WINDOWS" \
        background.drawing="$SELECTED"
fi
