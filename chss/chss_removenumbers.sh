#!/bin/bash

# Usage: ./script.sh /path/to/folder

FOLDER="$1"

if [[ -z "$FOLDER" || ! -d "$FOLDER" ]]; then
    echo "Usage: $0 /path/to/folder"
    exit 1
fi

for file in "$FOLDER"/*; do
    # Skip if not a regular file
    [[ -f "$file" ]] || continue

    # Run vim in Ex mode to apply the substitutions and save the file
    vi -es -u NONE -c '%s/^\s*[IVXLCDM]\+\.\s*//' -c '%s/^\s*\d\+\.\s*//' -c 'wq' "$file"
    
    echo "Processed: $file"
done


