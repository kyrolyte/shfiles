#!/bin/bash

# This script is meant to split large text files into smaller files within a specified directory
# In this example a large '----' string acts as a seperateor but any string can be used

# Check arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_directory>"
    exit 1
fi

input_file="$1"
output_dir="$2"
separator="__________________________________________________________________"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

file_count=1
output_file="$output_dir/otpt_$(printf "%03d" $file_count)"

# Empty the first output file (in case it exists)
> "$output_file"

while IFS= read -r line; do
    if [[ "$line" == "$separator" ]]; then
        ((file_count++))
        output_file="$output_dir/otpt_$(printf "%03d" $file_count)"
        > "$output_file"
    else
        echo "$line" >> "$output_file"
    fi
done < "$input_file"
