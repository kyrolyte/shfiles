#!/bin/bash

# This script is for exporting the profile information from gnome terminal
# Instead of typing the full command the user only needs to provide a file name

# Prompt the user for a filename
read -p "Enter a filename (without extension): " filename

# Check if the filename is empty
if [ -z "$filename" ]; then
  echo "Filename cannot be empty. Exiting."
  exit 1
fi

# Append the .dconf extension to the filename
filename="$filename.dconf"

# Run the dconf command with the provided filename
dconf dump /org/gnome/terminal/legacy/profiles:/ > "$filename"

# Check if the command was successful
if [ $? -eq 0 ]; then
  echo "dconf settings dumped to $filename"
else
  echo "An error occurred while running the dconf command."
fi

