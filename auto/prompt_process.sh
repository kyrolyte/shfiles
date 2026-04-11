#!/bin/bash

# This is a script that will iterate through a source folder and execute an ollama prompt for each file
# For example if you have a collectino of files that you would like to write documentation for you can adjust main_prmopt to be 'Write documentation for this content: '
# Then in each file, documentation will be written and exported to the output/main folder

main_prompt="Enter your generic prompt here, you can include additional text content: "

remove_ansi_codes() {
    perl -CSD -pe 's/\e\[?.*?[\@-~]//g'
}

for file in source/*; do
    text_content=$(<"$file")
    filename=$(basename "$file")
    # model name and parameters can be inserted here, i.e. gemma3:4b
    commandbase="docker exec -it ollamagpu ollama run <model_name:Nb> \"$main_prompt $text_content\" > output/main/$filename"

    echo "Executing docker command for main output on: $file"
    eval "$commandbase"
done

find output/ -type f | while read -r file; do
    echo "Processing: $file"
    file_content=$(remove_ansi_codes < "$file")

    letter_index=-1
    for ((i=0; i<${#file_content}; i++)); do
        char="${file_content:$i:1}"
        if [[ "$char" =~ [A-Za-z] ]]; then
            letter_index=$i
            break
        fi
    done

    if [[ $letter_index -ge 0 ]]; then
        text_part="${file_content:$letter_index}"
        echo "$text_part" > "$file"
    else
        echo "$file_content" > "$file"
    fi
done

echo "Build complete!"
