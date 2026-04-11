#!/bin/bash

# Prompt user for directory
read -p "Enter the directory path (or press Enter to use current directory): " directory

# Assign current directory if blank, otherwise check to verify if directory exists
if [ -z "$directory" ]; then
    directory="."
fi

if [ ! -d "$directory" ]; then
  echo "Directory not found."
  exit 1
fi

# This is the list of extensions that can be removed, subject to change
extensions=("bak" "cab" "cfg" "cpl" "cur" "dll" "dmp" "drv" "icns" "ico" "ini" "lnk" "msi" "sys" "tmp" "rtf" "tex" "txt" "wpd")

for filename in "$directory"/*; do
  base=$(basename "$filename")
  ext="${base##*.}"

  if [[ -n "$ext" && " ${extensions[@]} " =~ " $ext " ]]; then
    new_filename="${base%.*}"  # Remove extension
    mv "$filename" "$directory/$new_filename"
  fi
done

