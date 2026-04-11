#!/bin/bash

# Prompt the user for the directory or use the current directory as default
read -p "Enter the directory (press Enter to use current directory): " user_directory
directory=${user_directory:-.}

# Prompt the user for the prefix
read -p "Enter the prefix: " prefix

# Go through all documents in the directory, remove any spaces or dashes and then add prefix
for filename in "$directory"/*; do
  if [ -f "$filename" ]; then  # Check if it's a regular file
    base=$(basename "$filename")
    ext="${base##*.}"
    base="${base%.*}"
	base_without_ext="${base%.*}"
    base=$(echo "$base" | tr ' ' '_' | tr -d '()' | tr '-' '_')
    new_base="$prefix$base"

	if [[ -n "$ext" && "$base_without_ext" != "$ext" ]]; then
	  new_filename="$new_base.$ext"
	else
	  new_filename="$new_base"
	fi

    mv "$filename" "$directory/$new_filename"
  fi
done

