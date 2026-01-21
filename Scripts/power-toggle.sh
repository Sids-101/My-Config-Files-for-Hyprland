#!/bin/bash

# File to store the timestamp when wlogout was opened
STATE_FILE="/tmp/wlogout_open_timestamp"

if pgrep -x wlogout > /dev/null; then
    # wlogout is running → kill it and lock
    pkill -x wlogout
    hyprlock
else
    # Launch wlogout and record the time it was opened
    wlogout &
    echo "$(date +%s)" > "$STATE_FILE"
fi
