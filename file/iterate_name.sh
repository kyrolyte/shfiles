#!/bin/bash

# Usage: ./iterate_name.sh /path/to/directory

# If a directory contains a large list of files that need to be renamed, but their content is of a similar layout, then a string from that content can be used for renaming
# In this example, each file contains a string of `(Reference String No. <value>)` where <value> is number
# The script will capture <value> within that string and use it to rename the file according to that specific number
# The advantage of this script is that it can iterate through a large list of files and ignore other files within the same directory that don't need to be updated

search_dir="${1:-.}"

find "$search_dir" -type f | while read -r file; do
    # Extract the value within (Reference String No. <value>)
    value=$(grep -oP '\(Reference String No\. \K[^)]+' "$file" | head -n1)
    if [[ -n "$value" ]]; then
        dir=$(dirname "$file")
        newname="fileout_${value}"
        newpath="${dir}/${newname}"
        if [[ "$file" != "$newpath" && ! -e "$newpath" ]]; then
            mv "$file" "$newpath"
            echo "Renamed: $file -> $newpath"
        fi
    fi
done
