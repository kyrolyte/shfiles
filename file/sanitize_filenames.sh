#!/bin/bash

# Set directory to the folder you want to convert filenames for
read -p "Enter the directory: " directory

# Use a for loop to iterate through all filenames in the directory
for filename in "$directory"/*; do
  # Get the file's base name and extension
  base=$(basename "$filename")
  ext="${base##*.}"
  base="${base%.*}"
  base_without_ext="${base%.*}"

# Convert the base name to lowercase and replace spaces with '_'
  base=$(echo "$base" | tr ' ' '_' | tr -s '_' | tr '[:upper:]' '[:lower:]')

  # Remove characters other than letters, numbers, and underscores
  base=$(echo "$base" | tr -cd '[:alnum:]_')

  # Check if the length of the base name is greater than 20 characters
  if [ ${#base} -gt 30 ]; then
    base=${base:0:30}  # Truncate to the first 20 characters
  fi

  # Add extension only if the original filename had an extension
  if [[ -n "$ext" && "$base_without_ext" != "$ext" ]]; then  
	new_filename="$base.$ext"
  else
    new_filename="$base"
  fi

  # Rename the file with the new base name
  if [ "$filename" != "$directory/$new_filename" ]; then
    mv "$filename" "$directory/$new_filename"
  fi
done

