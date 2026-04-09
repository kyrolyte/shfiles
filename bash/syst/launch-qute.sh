#!/bin/bash
# 1. Start qutebrowser in the background
qutebrowser &

# 2. Wait a moment for the window to actually exist
sleep 2

# 4. Find the qutebrowser window and force it to (0,0) and full size
WID=$(xdotool search --onlyvisible --class qutebrowser | head -n 1)
xdotool windowmove $WID 0 0
xdotool windowsize $WID 100% 100%

# 5. Keep the script alive so X doesn't close immediately
wait $(pgrep qutebrowser)
