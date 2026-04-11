#!/bin/bash

# Prompt the user to enter a file name
read -p "Enter the file name you want to search for: " filename

# Define the directory to search in (you can change this to the desired directory)
# By default the current directory is used
search_dir="./" 

# Use 'find' and 'grep' to search for the file
results=$(find "$search_dir" -type f -name "$filename" 2>/dev/null)

# Check if any results were found
if [ -n "$results" ]; then
    echo "Results for '$filename':"
    echo "$results"
else
    echo "No results found for '$filename' in $search_dir or its subdirectories."
fi

