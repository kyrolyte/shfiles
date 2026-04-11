#!/bin/bash

# This script will return the count of distinct case-insensitive alphabetic characters and numeric digits that occur more than once in the input string.

input="$1"
input=$(echo "$input" | tr '[:upper:]' '[:lower:]') # Convert to lowercase
count=0
declare -A seen

for ((i = 0; i < ${#input}; i++)); do
  char="${input:$i:1}"
  if [[ $char =~ [a-z0-9] ]]; then
    if [[ -n ${seen["$char"]} ]]; then
      if [[ ${seen["$char"]} -eq 1 ]]; then
        count=$((count + 1))
      fi
      seen["$char"]=$((seen["$char"] + 1))
    else
      seen["$char"]=1
    fi
  fi
done

echo $count
