#!/bin/bash

# Loop through volume numbers 1 to 63
for n in {1..63}; do
    VOL_DIR="/path/to/volume-${n}"
    echo ">>> Processing volume-${n}..."

    # Check if the directory exists
    if [[ ! -d "$VOL_DIR" ]]; then
        echo "    ⚠ Directory $VOL_DIR not found. Skipping."
        continue
    fi

    # Change into the volume directory
    if ! cd "$VOL_DIR"; then
        echo "    ❌ Failed to enter $VOL_DIR. Skipping."
        continue
    fi

    # Stage all changes
    if ! git add .; then
        echo "    ❌ Failed to run 'git add .' in $VOL_DIR. Skipping commit."
        continue
    fi

    # Commit with the specified message
    if ! git commit -m "chore: update for volume ${n}"; then
        echo "    ⚠ Commit failed for $VOL_DIR (likely no changes or missing git user config). Skipping."
        continue
    fi

    echo "    ✅ Successfully committed volume-${n}."
done

echo ""
echo "🏁 All volumes processed."

