#!/bin/bash

# Usage: ./script.sh /path/to/folder

FOLDER="$1"

if [[ ! -d "$FOLDER" ]]; then
    echo "Usage: $0 /path/to/folder"
    exit 1
fi

for file in "$FOLDER"/*; do
    # Skip if not a regular file
    [[ -f "$file" ]] || continue

    # Read first two lines
    line1=$(sed -n '1p' "$file")
    line2=$(sed -n '2p' "$file")

    # Check if both lines are blank (empty or only whitespace)
    if [[ "$line1" =~ ^[[:space:]]*$ && "$line2" =~ ^[[:space:]]*$ ]]; then
        # Remove first two lines and add "# " to the new first line
        {
            sed '1,2d' "$file" | sed '1s/^/# /'
        } > "$file.tmp" && mv "$file.tmp" "$file"
        echo "Processed: $file"
    fi
done

