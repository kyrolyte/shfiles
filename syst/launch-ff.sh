#!/usr/bin/env bash
# -------------  launch-firefox.sh  -------------
# Launch Firefox, put the window in the top‑left corner and maximise it,
# then keep the script alive so that X stays up.

# 1.  Fire up Firefox in the background
firefox &

# 2.  Give X a moment to actually create a window
sleep 2

# 3.  Grab the first visible Firefox window
#    (Firefox’s window class is usually “Firefox” – the capital F is important)
WID=$(xdotool search --onlyvisible --class Firefox | head -n1)

# 4.  If we got a window, move it to the top‑left corner and maximise
if [[ -n "$WID" ]]; then
    xdotool windowmove "$WID" 0 0
    xdotool windowsize "$WID" 100% 100%
else
    echo "ERROR: Could not find a Firefox window (class Firefox)!" >&2
fi

# 5.  Keep the script alive until the Firefox process ends
#    (pgrep will return the PID(s) of all running firefox processes)
wait $(pgrep firefox)

