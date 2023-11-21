#!/usr/bin/env bash

#echo "Find and replace in current directory!"

#echo "File pattern to look for? (eg '*.txt')"
#read filepattern
filepattern="$1"

#echo "Existing string?"
#read existing
existing="$2"
escapedExisting=$(echo "$existing" | sed 's/\//\\\//g')

#echo "Replacement string?"
#read replacement
replacement="$3"
escapedReplacement=$(echo "$replacement" | sed 's/\//\\\//g')

echo "Replacing all occurences of $existing with $replacement in files matching $filepattern"

for f in $(find . -type f -name "$filepattern"); do sed -i.bak -e "s/$escapedExisting/$escapedReplacement/g" "$f"; rm "$f.bak"; done
