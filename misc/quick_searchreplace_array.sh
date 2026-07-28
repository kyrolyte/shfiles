#!/bin/bash

# Define the arrays of phrases
# Add your pairs here. The index in OLD must match the index in NEW.
declare -a OLD_PHRASES=("OldPhrase1" "OldPhrase2" "OldPhrase3")
declare -a NEW_PHRASES=("NewPhrase1" "NewPhrase2" "NewPhrase3")

# Validate that both arrays have the same number of elements
if [ ${#OLD_PHRASES[@]} -ne ${#NEW_PHRASES[@]} ]; then
    echo "Error: The number of old phrases (${#OLD_PHRASES[@]}) does not match the number of new phrases (${#NEW_PHRASES[@]})."
    echo "Please ensure each index in OLD_PHRASES has a corresponding replacement in NEW_PHRASES."
    exit 1
fi

echo "Starting replacement process for ${#OLD_PHRASES[@]} phrase pairs..."

for (( i=0; i<${#OLD_PHRASES[@]}; i++ )); do
    SEARCH_PHRASE="${OLD_PHRASES[$i]}"
    REPLACEMENT_PHRASE="${NEW_PHRASES[$i]}"

    echo "Processing pair: '$SEARCH_PHRASE' -> '$REPLACEMENT_PHRASE'"

    for file in *; do
        # Check if the item is a regular file
        if [ -f "$file" ]; then
            # Check if the file contains the search phrase
            if grep -q "$SEARCH_PHRASE" "$file"; then
                # Perform the replacement in-place
                # Note: Using 'g' flag replaces all occurrences in the line
                sed -i "s/$SEARCH_PHRASE/$REPLACEMENT_PHRASE/g" "$file"
                echo "  Updated file: $file"
            fi
        fi
    done
done

echo "Replacement process complete."

