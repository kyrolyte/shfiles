#!/bin/bash

# Check if enough arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <branch-name> <merge|rebase>"
    exit 1
fi

BRANCH_NAME=$1
STRATEGY=$2

# Fetch changes from the private repository
git fetch private

# Merge or rebase based on the specified strategy
if [ "$STRATEGY" == "merge" ]; then
    git merge private/"$BRANCH_NAME"
    if [ $? -ne 0 ]; then
        echo "Merge failed. Please resolve conflicts and try again."
        exit 1
    fi
elif [ "$STRATEGY" == "rebase" ]; then
    git rebase private/"$BRANCH_NAME"
    if [ $? -ne 0 ]; then
        echo "Rebase failed. Please resolve conflicts and try again."
        exit 1
    fi
else
    echo "Invalid strategy: $STRATEGY. Use 'merge' or 'rebase'."
    exit 1
fi

# Push to the public repository
git push origin "$BRANCH_NAME"

# Check if the push to the public was successful
if [ $? -eq 0 ]; then
    # Push to the private repository
    git push private "$BRANCH_NAME"
else
    echo "Failed to push to public repository"
fi

