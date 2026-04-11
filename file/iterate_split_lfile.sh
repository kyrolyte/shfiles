#!/bin/bash

# This script is meant to be used with split script for large files
# The purpose is so that all large files can be iterated; if there isn't a dedicated folder, the script will create one

# Iterate 50 times, can be adjusted to a different number
for i in $(seq -w 1 50); do
    file="outputvol$i"
    dir="volume$i/"
    
    # Check if the file exists
    if [[ -f "$file" ]]; then
        # Check if the directory exists, if not, create it
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
        fi
        # Execute the command
        echo "Running script on $file for $dir...."
        sh lsplit.sh "$file" "$dir"
    else
        echo "File $file does not exist. Skipping."
    fi
done
