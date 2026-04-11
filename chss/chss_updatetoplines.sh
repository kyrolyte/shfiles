#!/bin/bash

FOLDER="$1"

if [[ -z "$FOLDER" || ! -d "$FOLDER" ]]; then
    echo "Usage: $0 <folder>"
    exit 1
fi

for file in "$FOLDER"/*; do
    # Extract lines 3 to 11
    block=$(sed -n '3,11p' "$file")
    # Use awk to extract the relevant fields
    sermon_no=$(echo "$block" | awk '/\(No\./{gsub(/[()]/,""); print $2}')
    delivered_on=$(echo "$block" | awk '/Delivered on/{for(i=3;i<=NF-2;++i) printf $i" "; print $(NF-1)}' | sed 's/,$//')
    at_location=$(echo "$block" | awk '/^At /{for(i=2;i<=NF-1;++i) printf $i" "; print $NF}' | sed 's/\.$//')

    # Check if all fields were found
    if [[ -n "$sermon_no" && -n "$delivered_on" && -n "$at_location" ]]; then
        new_line="Sermon No. $sermon_no - Delivered on $delivered_on the REV. C.H. SPURGEON at $at_location"
        new_line+="."
        # Replace lines 3-11 with the new_line
        cp "$file" "$file.bak"
        awk -v new_line="$new_line" 'NR==3{print new_line; skip=1} NR>3&&NR<=11&&skip{next} {print}' "$file.bak" > "$file"
        sed -i '4{/A Sermon/d}' "$file"
        echo "Updated: $file"
    fi
done

