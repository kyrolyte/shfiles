#!/bin/bash

# Configuration
START=3440
END=3463

echo "Starting sermon cleanup loop from $START to $END..."

# Loop through the numbers
for n in $(seq $START $END); do
    FILE_PATH="filename_${n}.md"
    
    # Check if the file exists before attempting to add it
    if [ -f "$FILE_PATH" ]; then
        echo "Processing iteration $n: Adding '$FILE_PATH'..."
        git add "$FILE_PATH"
        
        # Commit the changes with the specific message format
        # We use the -q flag to suppress output from 'git add' if you want silent operation
        git commit -m "chore: cleanup top quote on file $n"
        
        echo "Commit successful for sermon $n"
    else
        echo "Skipping iteration $n: File '$FILE_PATH' not found."
    fi
done

echo "Loop completed."

