#!/bin/bash

# You are given an array(list) strarr of strings and an integer k. 
# This function is to return the first longest string consisting of k consecutive strings (strings that follow one after another without an interruption) taken in the array.
# n being the length of the string array, if n = 0 or k > n or k <= 0 return "" 

strarr=($1)
k=$2
n=${#strarr[@]}

# Check for edge cases
if (( n == 0 || k > n || k <= 0 )); then
    echo ""
    exit
fi

longest=""
longest_length=0

for (( i=0; i<=n-k; i++ )); do
    current=""
    for (( j=i; j<i+k; j++ )); do
        current="${current}${strarr[j]}"
    done

    current_length=${#current}

    if (( current_length > longest_length )); then
        longest=$current
        longest_length=$current_length
    fi
done

echo "$longest"

