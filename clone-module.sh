#!/bin/sh
#######################################################
#  CLONE MODULE                                       #
#  Clones a drupal module.                            #
#  -------------------------------------------------  #
#                                                     #
#  Usage:                                             #
#     $ clone-module module new-module                #
#                                                     #
#  Public Domain Software -- Free to Use as You Like  #
#######################################################

if [ ! -d "$1" ]; then
  echo "The first argument is not a valid directory"
  exit 1
fi

if [ -d "$2" ]; then
  echo "A module already exists with the name specified."
  exit 1
fi

cp -r "$1" "$2"
cd "$2"

# remove files that do not begin with the module name.
find . -type f -not -name "$1*" | xargs rm
# remove directories
find . -type d -depth 1 | xargs rm -r
# rename files and replace module name
for f in *; do
  sed -E -e "s/$1/$2/g" -i .bak "$f"
  echo "$f" | awk -F . '{ print $2; }' | xargs -I {} mv "$f" "$2".{}
done
rm *.bak

cd -
