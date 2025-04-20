#!/bin/bash

# This script performs git operations to commit and push quote updates
# Parameters:
# $1 - File path to add
# $2 - Commit message

FILE_PATH=$1
COMMIT_MESSAGE=$2

if [ -z "$FILE_PATH" ] || [ -z "$COMMIT_MESSAGE" ]; then
  echo "Error: Missing parameters. Usage: $0 <file_path> <commit_message>"
  exit 1
fi

# Add the file
git add "$FILE_PATH"

# Commit with the given message
git commit -m "$COMMIT_MESSAGE"

# Push to the remote repository
git push

exit $? 