#!/usr/bin/env bash
# ------------------------------------------------------------------
#  brightness.sh – Set laptop screen brightness from the TTY
#
#  Usage:
#      brightness.sh <percent>   # 0‑100
#      brightness.sh inc         # +10%
#      brightness.sh dec         # –10%
#      brightness.sh max         # 100%
#      brightness.sh min         # 0%
#
#  Requires: root privileges (or write access to the backlight file).
#  ------------------------------------------------------------------

# ----------------- configuration ------------------------------------
# If you want to force a specific back‑light driver, override this.
# BL_DIR=${BL_DIR:-"/sys/class/backlight/intel_backlight"}   # example
# --------------------------------------------------------------------

# 1. Find a back‑light device (the first one in /sys/class/backlight)
BL_DIR=$(ls -d /sys/class/backlight/* 2>/dev/null | head -n1)

if [[ -z "$BL_DIR" ]]; then
    echo "❌  No back‑light device found in /sys/class/backlight."
    exit 1
fi

# 2. Read the maximum brightness value
MAX=$(cat "$BL_DIR/max_brightness")
if [[ -z "$MAX" ]]; then
    echo "❌  Could not read max_brightness from $BL_DIR."
    exit 1
fi

# 3. Resolve the target brightness
target_brightness() {
    local percent=$1
    # Clamp percent to 0‑100
    if (( percent < 0 )); then percent=0; fi
    if (( percent > 100 )); then percent=100; fi
    # Convert percent → raw value
    echo $(( percent * MAX / 100 ))
}

# 4. Handle command line arguments
case "$1" in
    inc)
        # Increase by ~10%
        CURRENT=$(cat "$BL_DIR/brightness")
        PCT=$(( CURRENT * 100 / MAX ))
        PCT=$(( PCT + 10 ))
        ;;
    dec)
        # Decrease by ~10%
        CURRENT=$(cat "$BL_DIR/brightness")
        PCT=$(( CURRENT * 100 / MAX ))
        PCT=$(( PCT - 10 ))
        ;;
    max)
        PCT=100
        ;;
    min)
        PCT=0
        ;;
    *)
        # Assume the user supplied a numeric percentage
        if [[ "$1" =~ ^[0-9]+$ ]]; then
            PCT=$1
        else
            echo "Usage: $0 <percent|inc|dec|max|min>"
            exit 1
        fi
        ;;
esac

# 5. Write the new brightness value
NEW=$(target_brightness "$PCT")

# 6. Apply it.  Use sudo if we don't have direct write access.
if [[ -w "$BL_DIR/brightness" ]]; then
    echo "$NEW" > "$BL_DIR/brightness"
else
    echo "$NEW" | sudo tee "$BL_DIR/brightness" > /dev/null
fi

echo "✔  Set brightness to ${PCT}% (raw $NEW / max $MAX)."

# h
