#!/bin/bash

# Check for directory argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/folder/"
    exit 1
fi

DIRECTORY="$1"

# Check if the provided path is a directory
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: $DIRECTORY is not a directory."
    exit 1
fi

for file in "$DIRECTORY"/*; do
    # Only process regular files
    [ -f "$file" ] || continue

    # Read line 5
    line5=$(sed -n '5p' "$file")

    # Check if line 5 starts with a "
    if [[ "$line5" == \"* ]]; then
        # Extract quote and reference
        quote="${line5%%--*}"
        reference="${line5#*--}"

        # Clean up whitespace
        quote=$(echo "$quote" | sed 's/[[:space:]]*$//')
        reference=$(echo "$reference" | sed 's/^[[:space:]]*//')

        # Prepare formatted lines
        formatted="> $quote
> 
> $reference"

        # Replace line 5 in the file
        awk -v newtext="$formatted" 'NR==5{print newtext; next} 1' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

        echo "Processed: $file"
    else
        echo "Skipped (no quote at line 5): $file"
    fi
done

