#!/bin/bash

# This script is meant to be used with the prompt_process script
# Sometimes the source files will contain mismatched quotations which will cause a disruption when executing the docker exec command (the entire command is in a string)
# By replaceing the double quotes with single, this problem is more easily avoided

folder_path="source"

# Loop through all files in the folder
for file in "$folder_path"/*; do
  # Use sed to replace double quotes with single quotes in-place
  sed -i "s/\"/'/g" "$file"
done

echo "All double quotes have been replaced with single quotes in the 'source' folder."
