#!/bin/bash
# 1. Start qutebrowser in the background
 qutebrowser &

 # 2. Wait a moment for the window to actually exist
 sleep 2

 # 3. Get the screen resolution (e.g., 1920x1080)
 WIDTH=$(xrandr | grep '*' | awk '{print $1}' | cut -d'x' -f1)
 HEIGHT=$(xrandr | grep '*' | awk '{print $1}' | cut -d'x' -f2)

 # 4. Find the qutebrowser window and force it to (0,0) and full size
 WID=$(xdotool search --onlyvisible --class qutebrowser | head -n 1)
 xdotool windowmove $WID 0 0
 xdotool windowsize $WID $WIDTH $HEIGHT

 # 5. Keep the script alive so X doesn't close immediately
 wait
