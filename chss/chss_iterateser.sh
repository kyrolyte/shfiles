#!/bin/bash

# Check if a directory argument was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/directory/"
    exit 1
fi

DIRECTORY="$1"

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory '$DIRECTORY' does not exist."
    exit 2
fi

# Array of bash script names
BASH_SCRIPTS=(
    "removetoplines.sh"
    "updatetoplines.sh"
    "removenumbers.sh"
    "updatetopquote.sh"
    "emptyblockquotes.sh"
    "spaceblockquotes.sh"
)

# Execute each bash script in order
for SCRIPT in "${BASH_SCRIPTS[@]}"; do
    if [ ! -x "$SCRIPT" ]; then
        echo "Error: Script '$SCRIPT' not found or not executable."
        exit 3
    fi
    echo "Running $SCRIPT $DIRECTORY"
    sh "$SCRIPT" "$DIRECTORY"
    if [ $? -ne 0 ]; then
        echo "Error: Script '$SCRIPT' failed."
        exit 4
    fi
done

echo "All bash scripts executed successfully."

# Array of python script names, add new scripts here
PYTHON_SCRIPTS=(
    "script.py"
)

# Execute each python script in order
for SCRIPT in "${PYTHON_SCRIPTS[@]}"; do
    if [ ! -x "$SCRIPT" ]; then
        echo "Error: Python script '$SCRIPT' not found or not executable."
        exit 5
    fi
    echo "Running $SCRIPT $DIRECTORY"
    python "$SCRIPT" "$DIRECTORY"
    if [ $? -ne 0 ]; then
        echo "Error: Python script '$SCRIPT' failed."
        exit 6
    fi
done

echo "All scripts executed successfully."

