#!/usr/bin/env bash

# Given a number N , calculate its primorial. 
# In primorial, not all the natural numbers get multiplied, only prime numbers are multiplied to calculate the primorial of a number. It's denoted with P# and it is the product of the first n prime numbers.

# Function to check if a number is prime
is_prime() {
    local num=$1
    if [ $num -le 1 ]; then
        return 1
    elif [ $num -le 3 ]; then
        return 0
    elif [ $((num % 2)) -eq 0 ] || [ $((num % 3)) -eq 0 ]; then
        return 1
    fi

    local i=5
    while [ $((i * i)) -le $num ]; do
        if [ $((num % i)) -eq 0 ] || [ $((num % (i + 2))) -eq 0 ]; then
            return 1
        fi
        i=$((i + 6))
    done

    return 0
}

# Function to calculate the primorial
numPrimorial() {
    local numPrimes=$1
    local primorial=1
    local count=0
    local num=2
    
    while [ $count -lt $numPrimes ]; do
        if is_prime $num; then
            primorial=$((primorial * num))
            count=$((count + 1))
        fi
        num=$((num + 1))
    done
    
    echo $primorial
}

# Call the function with the argument
numPrimorial $1

